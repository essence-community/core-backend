import Connection from "@ungate/plugininf/lib/db/Connection";
import PostgresDB from "@ungate/plugininf/lib/db/postgres";
import { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import ICCTParams from "@ungate/plugininf/lib/ICCTParams";
import Logger from "@ungate/plugininf/lib/Logger";
import NullEvent from "@ungate/plugininf/lib/NullEvent";
import { sendProcess } from "@ungate/plugininf/lib/util/ProcessSender";
import { initParams } from "@ungate/plugininf/lib/util/Util";
import { delay, noop } from "lodash";
const logger = Logger.getLogger("CorePgNotification");

export default class CoreSemaphore extends NullEvent {
    public static getParamsInfo(): IParamsInfo {
        return {
            connectString: {
                name: "Строка подключения к БД",
                required: true,
                type: "string",
            },
            ...PostgresDB.getParamsInfo(),
        };
    }
    private dataSource: PostgresDB;
    private eventConnect: Connection;
    constructor(name: string, params: ICCTParams) {
        super(name, params);
        this.params = initParams(CoreSemaphore.getParamsInfo(), params);
        this.dataSource = new PostgresDB(`${this.name}_semaphore`, {
            connectString: this.params.connectString,
            connectionTimeoutMillis: this.params.connectionTimeoutMillis,
            idleTimeoutMillis: this.params.idleTimeoutMillis,
            partRows: this.params.partRows,
            poolMax: this.params.poolMax || 5,
            poolMin: this.params.poolMin || 1,
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
            logger.error(
                `Ошибка отслеживания семафора ${this.name} ${err.message}`,
                err,
            );
            this.reload();
        });
        return this.initEvents();
    }
    /**
     * Подключение слежене
     */
    public initEvents() {
        logger.info(`Init event ${this.name}`);
        this.eventMask();
        const conn = this.eventConnect.getCurrentConnection();
        conn.on("notification", (msg) => {
            logger.debug("Notification %j", msg);
            const payload = JSON.parse(msg.payload);
            if (
                payload.table &&
                payload.table.toLowerCase().endsWith("t_semaphore")
            ) {
                const mask = payload.data.cn_value !== 0;
                logger.debug(`Event mask ${mask}`);
                sendProcess({
                    command: "setMask",
                    data: {
                        mask,
                    },
                    target: "cluster",
                });
            }
        });
        return conn.query("LISTEN events");
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
                                logger.debug(`Event rows %j`, rows);
                                if (rows.length) {
                                    // tslint:disable-next-line: triple-equals
                                    const mask = rows[0].cn_value != 0;
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
}
