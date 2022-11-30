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
    public static getParamsInfo (): IParamsInfo {
        return {
            authProvider: {
                name: "Наименвание провайдера авторизации",
                type: "string",
            },
            timeoutTimer: {
                name: "Время опроса сервера в сек",
                type: "integer",
                defaultValue: 5,
            },
            ...PostgresDB.getParamsInfo(),
        };
    }
    private dataSource: PostgresDB;
    private eventConnect: Connection;
    private timer?: NodeJS.Timeout;
    constructor (name: string, params: ICCTParams) {
        super(name, params);
        this.params = initParams(CoreNotification.getParamsInfo(), this.params);
        this.dataSource = new PostgresDB(`${this.name}_events`, {
            connectString: this.params.connectString,
            connectionTimeoutMillis: this.params.connectionTimeoutMillis,
            idleTimeoutMillis: this.params.idleTimeoutMillis,
            setConnectionParam: this.params.setConnectionParam,
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
    public async init (reload?: boolean): Promise<void> {
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
        if (this.timer) {
            clearTimeout(this.timer);
            this.timer = undefined;
        }
        return this.initEvents();
    }

    private readMessage = () => {
        if (this.timer) {
            clearTimeout(this.timer);
            this.timer = undefined;
        }
        sendProcess({
            callback: {
                command: "callEventPlugin",
                data: {
                    name: this.name,
                    command: "eventCorePgNotification",
                },
                target: "eventNode",
            },
            command: "getWsUsers",
            data: {
                nameProvider: this.params.authProvider,
            },
            target: "cluster",
        });
        this.timer = setTimeout(
            () => this.readMessage(),
            this.params.timeoutTimer * 1000,
        );
    };
    /**
     * Подключаем слежение к таблице
     */
    public initEvents (): Promise<void> {
        logger.info(`Init event provider ${this.name}`);
        this.readMessage();
        const conn = this.eventConnect.getCurrentConnection();
        conn.on("notification", (msg) => {
            logger.debug("Notification %j", msg);
            const payload = JSON.parse(msg.payload);
            if (
                payload.table &&
                payload.table.toLowerCase().endsWith("t_notification")
            ) {
                this.readMessage();
            }
        });
        return conn.query("LISTEN events");
    }

    /**
     * Поиск оповещений
     * @param processData объект с юзерами
     */
    public async eventCorePgNotification (data?: any): Promise<void> {
        logger.debug("LoadEventNotification: %j", data);
        const ckUsers = data?.users;
        if (isEmpty(ckUsers)) {
            return;
        }
        const json = ckUsers.map((value) => ({
            ck_id: value,
        }));
        const params = { json: JSON.stringify(json) };
        const sqlNotification =
            "select pkg_json_notification.f_get_notification(:json::jsonb) as cv_json";

        this.dataSource.open().then((conn) =>
            conn
                .executeStmt(sqlNotification, params)
                .then(
                    (data) =>
                        new Promise<void>((resolve, reject) => {
                            let preRows = [] as any[];
                            data.stream.on(
                                "data",
                                (chunk) =>
                                    (preRows = [
                                        ...preRows,
                                        ...JSON.parse(chunk.cv_json),
                                    ]),
                            );
                            data.stream.on("error", (err) => reject(err));
                            data.stream.on("end", () => {
                                const rows = preRows.filter(
                                    (val) => typeof val === "object",
                                );
                                if (rows.length) {
                                    return conn.commit().then(() =>
                                        Promise.all(
                                            rows.map((row) =>
                                                this.sendNotification(
                                                    row.ck_user,
                                                    row,
                                                ),
                                            ),
                                        )
                                            .then((values) =>
                                                this.updateNotification(
                                                    conn,
                                                    values.filter((value) =>
                                                        isObject(value),
                                                    ),
                                                ),
                                            )
                                            .then(() => resolve())
                                            .catch((err) => reject(err)),
                                    );
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
    private async updateNotification (conn: Connection, params = []) {
        if (params.length) {
            return Promise.all(
                params.map((param) =>
                    conn.executeStmt(
                        "select PKG_JSON_NOTIFICATION.f_modify_notification(pc_json => :json::jsonb) as result",
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
    private sendNotification = (user, row) => {
        let res = {
            json: JSON.stringify({
                data: {
                    ...row,
                    cl_sent: 2,
                },
                service: {
                    cv_action: "U",
                },
            }),
        };
        try {
            const msg =
                row.cv_message &&
                typeof row.cv_message === "string" &&
                row.cv_message.startsWith("{")
                    ? JSON.parse(row.cv_message)
                    : {};
            let text = JSON.stringify([
                {
                    data: {
                        ck_id: row.ck_id,
                        ...msg,
                    },
                    event: "notification",
                },
            ]);
            if (!isEmpty(msg.export_excel)) {
                text = JSON.stringify([
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
                        text,
                    },
                    target: "cluster",
                });
                sendProcess({
                    command: "sendServerAdminCmdAll",
                    data: {
                        command: "sendNotification",
                        data: {
                            ckUser: user,
                            nameProvider: this.params.authProvider,
                            text,
                        },
                        target: "cluster",
                    },
                    target: "clusterAdmin",
                });
                return res;
            }
            if (!isEmpty(msg.reloadpageobject)) {
                text = JSON.stringify([
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
                        text,
                    },
                    target: "cluster",
                });
                sendProcess({
                    command: "sendServerAdminCmdAll",
                    data: {
                        command: "sendNotification",
                        data: {
                            ckUser: user,
                            nameProvider: this.params.authProvider,
                            text,
                        },
                        target: "cluster",
                    },
                    target: "clusterAdmin",
                });
                return res;
            }
            if (
                !isEmpty(msg.cv_error) ||
                !isEmpty(msg.jt_message) ||
                !isEmpty(msg.jt_form_message) ||
                Object.keys(msg).length
            ) {
                sendProcess({
                    command: "sendNotification",
                    data: {
                        ckUser: user,
                        nameProvider: this.params.authProvider,
                        text,
                    },
                    target: "cluster",
                });
                sendProcess({
                    command: "sendServerAdminCmdAll",
                    data: {
                        command: "sendNotification",
                        data: {
                            ckUser: user,
                            nameProvider: this.params.authProvider,
                            text,
                        },
                        target: "cluster",
                    },
                    target: "clusterAdmin",
                });
                return res;
            }
            return res;
        } catch (e) {
            logger.error(`Message: ${JSON.stringify(row)}`, e);
            res = {
                json: JSON.stringify({
                    data: {
                        ...row,
                        cl_sent: 0,
                    },
                    service: {
                        cv_action: "U",
                    },
                }),
            };
            return res;
        }
    };
    /**
     * Перезагрузка оповещение в случае сбоя
     */
    private reload () {
        this.init().then(noop, (err) => {
            logger.error(`Ошибка оповещения ${this.name} ${err.message}`, err);
            delay(this.reload, 15000);
        });
    }
}
