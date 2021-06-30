import Connection from "@ungate/plugininf/lib/db/Connection";
import PostgresDB from "@ungate/plugininf/lib/db/postgres";
import { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import ICCTParams from "@ungate/plugininf/lib/ICCTParams";
import Logger from "@ungate/plugininf/lib/Logger";
import NullEvent from "@ungate/plugininf/lib/NullEvent";
import { sendProcess } from "@ungate/plugininf/lib/util/ProcessSender";
import { initParams } from "@ungate/plugininf/lib/util/Util";
import { delay, noop } from "lodash";
const logger = Logger.getLogger("CorePgLocalization");

export default class CorePgLocalization extends NullEvent {
    public static getParamsInfo(): IParamsInfo {
        return {
            ...PostgresDB.getParamsInfo(),
        };
    }
    private dataSource: PostgresDB;
    private eventConnect: Connection;
    constructor(name: string, params: ICCTParams) {
        super(name, params);
        this.params = initParams(
            CorePgLocalization.getParamsInfo(),
            this.params,
        );
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
            logger.error(
                `Ошибка отслеживания локализации ${this.name} ${err.message}`,
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
        const conn = this.eventConnect.getCurrentConnection();
        conn.on("notification", (msg) => {
            logger.debug("Notification %j", msg);
            const payload = JSON.parse(msg.payload);
            if (
                payload.table &&
                payload.table.toLowerCase().endsWith("t_localization")
            ) {
                logger.debug(
                    `Event localization ${payload.data.ck_id} - ${payload.data.cv_value}`,
                );
                const text = JSON.stringify([
                    {
                        data: payload.data,
                        event: "localization",
                    },
                ]);
                sendProcess({
                    command: "sendNotificationAll",
                    data: {
                        text,
                    },
                    target: "cluster",
                });
            }
        });
        return conn.query("LISTEN events");
    }
    /**
     * Перезагрузка оповещение в случае сбоя
     */
    private reload() {
        this.init().then(noop, (err) => {
            logger.error(
                `Ошибка отслеживания локализации ${this.name} ${err.message}`,
                err,
            );
            delay(this.reload, 15000);
        });
    }
}
