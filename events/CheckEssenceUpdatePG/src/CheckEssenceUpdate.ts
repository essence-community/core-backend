import Connection from "@ungate/plugininf/lib/db/Connection";
import PostgresDB from "@ungate/plugininf/lib/db/postgres";
import { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import ICCTParams from "@ungate/plugininf/lib/ICCTParams";
import Logger from "@ungate/plugininf/lib/Logger";
import NullEvent from "@ungate/plugininf/lib/NullEvent";
import { sendProcess } from "@ungate/plugininf/lib/util/ProcessSender";
import { initParams } from "@ungate/plugininf/lib/util/Util";
import { delay, noop, pick } from "lodash";
import { ReadStreamToArray } from "@ungate/plugininf/lib/stream/Util";
import * as moment from 'moment';
const logger = Logger.getLogger("CorePgNotification");

export default class CheckEssenceUpdate extends NullEvent {
    public static getParamsInfo (): IParamsInfo {
        return {
            enableListen: {
                name: "Включаем постояный слушатель",
                type: "boolean",
                defaultValue: false,
            },
            timeoutTimer: {
                name: "Период опроса",
                type: "integer",
                defaultValue: 5000,
            },
            ...PostgresDB.getParamsInfo(),
        };
    }
    private dataSource: PostgresDB;
    private eventConnect: Connection;
    private startDate = moment().toISOString();
    private timer?: NodeJS.Timeout;
    constructor (name: string, params: ICCTParams) {
        super(name, params);
        this.params = initParams(
            CheckEssenceUpdate.getParamsInfo(),
            this.params,
        );
        this.dataSource = new PostgresDB(`${this.name}_check_update`, {
            ...pick(this.params, ...Object.keys(PostgresDB.getParamsInfo())) as any,
            poolMax: this.params.poolMax || 5,
            poolMin: this.params.poolMin || 1,
        } as any);
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
        await this.initStartData();
        await this.execute();
        this.executeTimer();
        if (this.params.enableListen) {
            return this.initEvents();
        }
    }
    public initStartData () {
        return this.dataSource
            .executeStmt("select CURRENT_TIMESTAMP as ct_change")
            .then((res) => ReadStreamToArray(res.stream))
            .then((arr) => {
                if (arr.length) {
                    this.startDate = moment(arr[0].ct_change).toISOString();
                }
            });
    }
    /**
     * Подключение отслеживания
     */
    public async initEvents () {
        logger.info(`Init event ${this.name}`);
        this.eventConnect = await this.dataSource.open();
        this.eventConnect.getCurrentConnection().on("error", async (err) => {
            logger.error(
                `Ошибка отслеживания обновления t_page_update_history ${this.name} ${err.message}`,
                err,
            );
            try {
                await this.eventConnect.rollbackAndRelease();
            } catch(e) {
                logger.debug(
                    e,
                );
            }
            try {
                if (this.dataSource.pool) {
                    await this.dataSource.resetPool();
                }
            } catch(e) {
                logger.debug(
                    e,
                );
            }
            this.initEvents();
        });
        const conn = this.eventConnect.getCurrentConnection();
        conn.on("notification", (msg) => {
            logger.trace("Notification %j", msg);
            const payload = JSON.parse(msg.payload);
            if (
                payload.table &&
                payload.table.toLowerCase().endsWith("t_page_update_history")
            ) {
                this.execute().catch((err) => {
                    logger.error("Error execute", err);
                    return Promise.resolve();
                });
            }
        });
        return conn.query("LISTEN events");
    }

    private executeTimer () {
        this.timer = setTimeout(
            () =>
                this.execute()
                    .catch((err) => {
                        logger.error("Error execute", err);
                        return Promise.resolve();
                    })
                    .then(() => this.executeTimer()),
            this.params.timeoutTimer,
        );
    }
    /**
     * Проверка обновлений
     */
    private execute () {
        return this.dataSource
            .executeStmt(
                "select\n" + 
                "    t.*\n" + 
                "from\n" + 
                "    s_mt.t_page_update_history t\n" + 
                "where\n" + 
                "    date_trunc('second', t.ct_change) > date_trunc('second', :ct_change::timestamptz)\n" + 
                "order by\n" + 
                "    t.ct_change asc\n",
                undefined,
                {
                    ct_change: this.startDate,
                },
            )
            .then((res) => ReadStreamToArray(res.stream))
            .then((rows) => {
                if (rows.length) {
                    sendProcess({
                        command: "reloadPageCache",
                        data: {
                            startDate: this.startDate,
                        },
                        target: "cluster",
                    });
                    this.startDate = moment(rows.pop().ct_change).toISOString();
                }
            })
            .catch((err) => {
                logger.warn(err);
                if (this.dataSource.pool) {
                    return this.dataSource.resetPool();
                }
            });
    }
    /**
     * Перезагрузка оповещение в случае сбоя
     */
    private reload () {
        if (this.timer) {
            clearTimeout(this.timer);
            this.timer = undefined;
        }
        this.init().then(noop, (err) => {
            logger.error(
                `Ошибка отслеживания обновления t_page_update_history ${this.name} ${err.message}`,
                err,
            );
            delay(this.reload, 15000);
        });
    }
}
