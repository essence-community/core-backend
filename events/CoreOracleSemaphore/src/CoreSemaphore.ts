import OracleDB from "@ungate/plugininf/lib/db/oracle";
import { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import ICCTParams from "@ungate/plugininf/lib/ICCTParams";
import Logger from "@ungate/plugininf/lib/Logger";
import NullEvent from "@ungate/plugininf/lib/NullEvent";
import { ReadStreamToArray } from "@ungate/plugininf/lib/stream/Util";
import { sendProcess } from "@ungate/plugininf/lib/util/ProcessSender";
import { initParams } from "@ungate/plugininf/lib/util/Util";
import { delay, noop } from "lodash";
const logger = Logger.getLogger("CoreNotification");
const CHECK_TIMEOUT = 15000;

export default class CoreSemaphore extends NullEvent {
    public static getParamsInfo(): IParamsInfo {
        return {
            connectString: {
                name: "Строка подключения к БД",
                required: true,
                type: "string",
            },
            password: {
                name: "Пароль учетной записи БД",
                required: true,
                type: "string",
            },
            user: {
                name: "Наименвание учетной записи БД",
                required: true,
                type: "string",
            },
        };
    }
    private dataSource: OracleDB;
    private eventConnect: any;
    private checktimer: any;
    constructor(name: string, params: ICCTParams) {
        super(name, params);
        this.params = initParams(CoreSemaphore.getParamsInfo(), params);
        this.dataSource = new OracleDB(`${this.name}_semaphore`, {
            connectString: this.params.connectString,
            password: this.params.password,
            poolMax: 10,
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
            await conn
                .unsubscribe(`core_semaphore_${this.name}`)
                .then(
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
            logger.error(
                `Ошибка отслеживания семафора ${this.name} ${err.message}`,
                err,
            );
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
    /**
     * Подключение слежене
     */
    public initEvents() {
        logger.info(`Init event ${this.name}`);
        this.eventMask();
        return this.eventConnect.subscribe(`core_semaphore_${this.name}`, {
            callback: (event) => {
                logger.debug(`Init event ${this.name} event ${event}`);
                this.eventMask();
            },
            qos: this.dataSource.oracledb.SUBSCR_QOS_ROWIDS,
            sql: "select * from t_semaphore",
        });
    }
    /**
     * Установка/снятие маски
     */
    public eventMask() {
        try {
            this.dataSource
                .executeStmt(
                    "select t.cn_value from t_semaphore t where t.ck_id = 'GUI_blocked'",
                )
                .then(
                    (data) =>
                        new Promise((resolve, reject) => {
                            const rows = [];
                            data.stream.on("data", (chunk) => rows.push(chunk));
                            data.stream.on("error", (error) => reject(error));
                            data.stream.on("end", () => {
                                if (rows.length) {
                                    const mask = rows[0].cn_value !== 0;
                                    logger.debug(`Event mask ${mask}`);
                                    sendProcess({
                                        command: "setMask",
                                        data: {
                                            mask,
                                        },
                                        target: "cluster",
                                    });
                                    return resolve();
                                }
                                return reject(
                                    new Error("Not found GUI_blocked"),
                                );
                            });
                        }),
                )
                .catch((err) => {
                    this.eventMask();
                    logger.error(err);
                });
        } catch (e) {
            logger.error(e);
        }
    }
    /**
     * Перезагрузка оповещение в случае сбоя
     */
    private reload() {
        this.init().then(noop, (err) => {
            logger.error(
                `Ошибка отслеживания семафора ${this.name} ${err.message}`,
                err,
            );
            delay(this.reload, 15000);
        });
    }
    private checkEventConnect() {
        this.dataSource
            .executeStmt(
                "select count(*) cnt\n" +
                    "  from user_change_notification_regs ucqn\n" +
                    " where ucqn.table_name like upper('%t_semaphore')",
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
}
