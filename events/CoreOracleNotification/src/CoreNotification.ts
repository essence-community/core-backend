import OracleDB from "@ungate/plugininf/lib/db/oracle";
import { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import ICCTParams from "@ungate/plugininf/lib/ICCTParams";
import Logger from "@ungate/plugininf/lib/Logger";
import NullEvent from "@ungate/plugininf/lib/NullEvent";
import { ReadStreamToArray } from "@ungate/plugininf/lib/stream/Util";
import { sendProcess } from "@ungate/plugininf/lib/util/ProcessSender";
import { initParams, isEmpty } from "@ungate/plugininf/lib/util/Util";
import { delay, isObject, noop } from "lodash";
const logger = Logger.getLogger("CoreNotification");
const CHECK_TIMEOUT = 15000;

export default class CoreNotification extends NullEvent {
    public static getParamsInfo(): IParamsInfo {
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
            ...OracleDB.getParamsInfo(),
        };
    }
    private dataSource: OracleDB;
    private eventConnect: any;
    private checktimer: any;
    private timer?: NodeJS.Timeout;
    constructor(name: string, params: ICCTParams) {
        super(name, params);
        this.params = initParams(CoreNotification.getParamsInfo(), this.params);
        this.dataSource = new OracleDB(`${this.name}_events`, {
            connectString: this.params.connectString,
            maxRows: this.params.maxRows,
            partRows: this.params.partRows,
            password: this.params.password,
            poolMax: this.params.poolMax,
            poolMin: this.params.poolMin,
            prefetchRows: this.params.prefetchRows,
            queryTimeout: this.params.queryTimeout,
            queueTimeout: this.params.queueTimeout,
            user: this.params.user,
        });
    }
    /**
     * Инициализация
     */
    public async init(reload?: boolean): Promise<void> {
        if (this.eventConnect) {
            const conn = this.eventConnect;
            this.eventConnect = null;
            await conn.unsubscribe(`core_notification_${this.name}`).then(
                () => this.dataSource.onClose(conn),
                () => this.dataSource.onClose(conn),
            );
        }
        if (this.dataSource.pool) {
            await this.dataSource.resetPool();
        }
        await this.dataSource.createPool();
        this.eventConnect = await this.dataSource.openEvents({
            connectString: this.params.connectString,
            password: this.params.password,
            user: this.params.user,
        });
        this.eventConnect.on("error", (err) => {
            logger.error(`Ошибка оповещения ${this.name} ${err.message}`, err);
            this.reload();
        });
        if (this.checktimer !== null) {
            clearTimeout(this.checktimer);
        }
        this.checktimer = setTimeout(
            () => this.checkEventConnect(),
            CHECK_TIMEOUT,
        );
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
                    command: "eventCoreOracleNotification",
                },
                target: "eventNode",
            },
            command: "getWsUsers",
            data: {
                nameProvider: this.params.authProvider,
            },
            target: "cluster",
        });
        this.timer = setTimeout(() => this.readMessage(), this.params.timeoutTimer * 1000);
    }
    /**
     * Подключаем слежение к таблице
     */
    public initEvents(): Promise<void> {
        logger.info(`Init event provider ${this.name}`);
        this.readMessage();
        return this.eventConnect.subscribe(`core_notification_${this.name}`, {
            callback: (event) => {
                logger.debug(`Event provider ${this.name}: ${event}`);
                this.readMessage();
            },
            qos: this.dataSource.oracledb.SUBSCR_QOS_BEST_EFFORT,
            sql: "select * from t_notification",
        });
    }

    /**
     * Поиск оповещений
     * @param processData объект с юзерами
     */
    public async eventCoreOracleNotification(data?: any): Promise<void> {
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
            "declare\n" +
            "  vct_users ct_number;\n" +
            "begin\n" +
            "  select distinct ck_id\n" +
            "    bulk collect\n" +
            "    into vct_users\n" +
            "    from json_table(:json, '$[*]' columns(ck_id number path '$.ck_id'));\n" +
            "\n" +
            "  open :cur for\n" +
            "    select t.*\n" +
            "      from t_notification t\n" +
            "     where sysdate between t.cd_st and t.cd_en\n" +
            "       and t.cl_sent = 0\n" +
            "       and t.ck_user in (select column_value from table(vct_users))\n" +
            "       for update;\n" +
            "end;";

        this.dataSource.open().then((conn) =>
            conn
                .executeStmt(sqlNotification, params, {
                    cur: "CURSOR",
                })
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
                                                conn.getCurrentConnection(),
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
    private checkEventConnect() {
        this.dataSource
            .executeStmt(
                "select count(*) cnt\n" +
                    "  from user_change_notification_regs ucqn\n" +
                    " where ucqn.table_name like upper('%t_notification')",
            )
            .then((res) => ReadStreamToArray(res.stream))
            .then(([row]) => {
                if (row.cnt < 1) {
                    return this.reload();
                }
                this.checktimer = setTimeout(
                    () => this.checkEventConnect(),
                    CHECK_TIMEOUT,
                );
            })
            .catch((err) => logger.error(err));
    }

    /**
     * Массовое обновление статуса
     * @param params
     * @returns {*|Promise.<TResult>}
     */
    private async updateNotification(conn, params = []) {
        if (params.length) {
            return conn.executeMany(
                "begin\n:result := PKG_JSON_NOTIFICATION.f_modify_notification(pc_json => :json);\nend;",
                params,
                {
                    autoCommit: true,
                    bindDefs: {
                        json: {
                            maxSize: 4000,
                            type: this.dataSource.oracledb.STRING,
                        },
                        result: {
                            dir: this.dataSource.oracledb.BIND_OUT,
                            maxSize: 4000,
                            type: this.dataSource.oracledb.STRING,
                        },
                    },
                },
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
                }
                if (
                    !isEmpty(msg.cv_error) ||
                    !isEmpty(msg.jt_message) ||
                    !isEmpty(msg.jt_form_message)
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
