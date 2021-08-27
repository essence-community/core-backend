import Connection from "@ungate/plugininf/lib/db/Connection";
import PostgresDB from "@ungate/plugininf/lib/db/postgres";
import { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import ICCTParams from "@ungate/plugininf/lib/ICCTParams";
import Logger from "@ungate/plugininf/lib/Logger";
import NullEvent from "@ungate/plugininf/lib/NullEvent";
import { sendProcess } from "@ungate/plugininf/lib/util/ProcessSender";
import { initParams, isEmpty } from "@ungate/plugininf/lib/util/Util";
import { delay, isObject, noop } from "lodash";
const logger = Logger.getLogger("CoreNotification");

export default class CoreNotification extends NullEvent {
    public static getParamsInfo(): IParamsInfo {
        return {
            authProvider: {
                name: "Наименвание провайдера авторизации",
                type: "string",
            },
            ...PostgresDB.getParamsInfo(),
        };
    }
    private dataSource: PostgresDB;
    private eventConnect: Connection;
    constructor(name: string, params: ICCTParams) {
        super(name, params);
        this.params = initParams(CoreNotification.getParamsInfo(), this.params);
        this.dataSource = new PostgresDB(`${this.name}_events`, {
            connectString: this.params.connectString,
            connectionTimeoutMillis: this.params.connectionTimeoutMillis,
            idleTimeoutMillis: this.params.idleTimeoutMillis,
            partRows: this.params.partRows,
            poolMax: this.params.poolMax,
            poolMin: this.params.poolMin,
            user: this.params.user,
            password: this.params.password,
            queryTimeout: this.params.queryTimeout,
        });
    }
    /**
     * Инициализация
     */
    public async init(reload?: boolean): Promise<void> {
        if (this.eventConnect) {
            const conn = this.eventConnect;
            this.eventConnect = null;
            await conn.close();
        }
        if (this.dataSource.pool) {
            await this.dataSource.resetPool();
        }
        await this.dataSource.createPool();
        this.eventConnect = await this.dataSource.open();
        this.eventConnect.getCurrentConnection().on("error", (err) => {
            logger.error(`Ошибка оповещения ${this.name} ${err.message}`, err);
            this.reload();
        });
        return this.initEvents();
    }
    /**
     * Подключаем слежение к таблице
     */
    public initEvents(): Promise<void> {
        logger.info(`Init event provider ${this.name}`);
        sendProcess({
            callback: {
                command: "eventNotification",
                data: {
                    name: this.name,
                },
                target: "eventNode",
            },
            command: "getWsUsers",
            data: {
                nameProvider: this.params.authProvider,
            },
            target: "cluster",
        });
        const conn = this.eventConnect.getCurrentConnection();
        conn.on("notification", (msg) => {
            logger.debug("Notification %j", msg);
            const payload = JSON.parse(msg.payload);
            if (
                payload.table &&
                payload.table.toLowerCase().endsWith("t_notification")
            ) {
                sendProcess({
                    callback: {
                        command: "eventNotification",
                        data: {
                            name: this.name,
                        },
                        target: "eventNode",
                    },
                    command: "getWsUsers",
                    data: {
                        nameProvider: this.params.authProvider,
                    },
                    target: "cluster",
                });
            }
        });
        return conn.query("LISTEN events");
    }

    /**
     * Поиск оповещений
     * @param processData объект с юзерами
     */
    public async eventNotification(ckUsers?: string[]): Promise<void> {
        logger.debug(`LoadEventNotification: %j`, ckUsers);
        if (isEmpty(ckUsers)) {
            return;
        }
        const json = ckUsers.map((value) => ({
            ck_id: value,
        }));
        const params = { json: JSON.stringify(json) };
        const sqlNotification =
            "select t.*\n" +
            "  from t_notification t\n" +
            " where current_timestamp between t.cd_st and t.cd_en\n" +
            "   and t.cl_sent = 0\n" +
            "   and t.ck_user in\n" +
            "       (select ck_id from json_to_recordset(:json) as x(ck_id text))\n" +
            "   for update skip locked";

        this.dataSource.open().then((conn) =>
            conn
                .executeStmt(sqlNotification, params)
                .then(
                    (data) =>
                        new Promise<void>((resolve, reject) => {
                            const rows = [];
                            data.stream.on("data", (chunk) => rows.push(chunk));
                            data.stream.on("error", (err) => reject(err));
                            data.stream.on("end", () => {
                                if (rows.length) {
                                    const sendRows = rows.map((row) =>
                                        this.sendNotification(row.ck_user, row),
                                    );
                                    return Promise.all(sendRows)
                                        .then((values) =>
                                            this.updateNotification(
                                                conn,
                                                values.filter((value) =>
                                                    isObject(value),
                                                ),
                                            ),
                                        )
                                        .then(() => resolve())
                                        .catch((err) => reject(err));
                                }
                                return resolve();
                            });
                        }),
                    (err) => {
                        logger.error(
                            `sql: ${sqlNotification} json: ${params.json}`,
                        );
                        return Promise.reject(err);
                    },
                )
                .then(
                    () => conn.commit(),
                    (err) => {
                        logger.error(err);
                        return conn.rollback();
                    },
                )
                .then(
                    () => conn.release(),
                    () => conn.release(),
                )
                .then(noop)
                .catch((err) => logger.error(err)),
        );
    }
    /**
     * Массовое обновление статуса
     * @param params
     * @returns {*|Promise.<TResult>}
     */
    private async updateNotification(conn: Connection, params = []) {
        if (params.length) {
            return Promise.all(
                params.map((param) =>
                    conn.executeStmt(
                        "select PKG_JSON_NOTIFICATION.f_modify_notification(pc_json => :json) as result",
                        param,
                    ),
                ),
            );
        }
        return;
    }

    /**
     * Отправка сообщения
     * @param user {string} индификатор пользователя
     * @param row {Object} строка сообщения
     * @returns {Promise}
     */
    private sendNotification(user, row) {
        return new Promise<void | Record<string, any>>((resolve) => {
            try {
                const msg = JSON.parse(row.cv_message);
                const text = JSON.stringify([
                    {
                        data: {
                            ck_id: row.ck_id,
                            ...msg,
                        },
                        event: "notification",
                    },
                ]);
                if (!isEmpty(msg.export_excel)) {
                    const exportExcel = JSON.stringify([
                        {
                            data: {
                                url: msg.export_excel,
                            },
                            event: "export_excel",
                        },
                    ]);
                    sendProcess({
                        command: "sendNotification",
                        data: {
                            ckUser: user,
                            nameProvider: this.params.authProvider,
                            text: exportExcel,
                        },
                        target: "cluster",
                    });
                }
                if (!isEmpty(msg.reloadpageobject)) {
                    const reloadMsg = JSON.stringify([
                        {
                            data: msg.reloadpageobject,
                            event: "reloadpageobject",
                        },
                    ]);
                    sendProcess({
                        command: "sendNotification",
                        data: {
                            ckUser: user,
                            nameProvider: this.params.authProvider,
                            text: reloadMsg,
                        },
                        target: "cluster",
                    });
                }
                if (!isEmpty(msg.cv_error)) {
                    sendProcess({
                        command: "sendNotification",
                        data: {
                            ckUser: user,
                            nameProvider: this.params.authProvider,
                            text,
                        },
                        target: "cluster",
                    });
                }
                resolve({
                    json: JSON.stringify({
                        data: {
                            ...row,
                            cl_sent: 1,
                        },
                        service: {
                            cv_action: "U",
                        },
                    }),
                });
            } catch (e) {
                logger.error(`Message: ${JSON.stringify(row)}`, e);
                resolve();
            }
        });
    }
    /**
     * Перезагрузка оповещение в случае сбоя
     */
    private reload() {
        this.init().then(noop, (err) => {
            logger.error(`Ошибка оповещения ${this.name} ${err.message}`, err);
            delay(this.reload, 15000);
        });
    }
}
