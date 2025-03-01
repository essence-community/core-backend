import {CronJob} from "cron";
import * as rufus from "rufus";
import ICCTParams, { IParamsInfo } from "./ICCTParams";
import IScheduler from "./IScheduler";
import Logger from "./Logger";
import { isEmpty } from "./util/Util";
/**
 * Каркас класса плагина планировщик
 */
export default abstract class NullScheduler implements IScheduler {
    public isEnable: boolean;
    public name: string;
    public cronStr: string;
    public params: ICCTParams;
    public log: rufus.IRufusLogger;
    private job: CronJob;
    public static getParamsInfo(): IParamsInfo {
        return {};
    }
    constructor(
        name: string,
        params: ICCTParams,
        cronStr: string,
        isEnable: boolean = false,
    ) {
        this.log = Logger.getLogger(`Scheduler.${name}`);
        this.name = name;
        this.params = params;
        this.cronStr = cronStr;
        this.isEnable = isEnable;
        if (this.isEnable) {
            this.enable();
        }
    }
    public abstract init(reload?: boolean): Promise<void>;
    public enable(): void {
        if (!this.job && !isEmpty(this.cronStr)) {
            this.job = CronJob.from({
                cronTime: this.cronStr,
                onTick: () => {
                    try {
                        this.execute();
                    } catch (err) {
                        this.log.error(err.message, err);
                    }
                },
                start: true,
                timeZone: "Europe/Moscow",
            });
            this.isEnable = true;
        } else if (this.job) {
            this.job.start();
            this.isEnable = true;
        } else {
            this.log.warn(`Cron is empty ${this.cronStr}`);
        }
    }
    public disable(): void {
        if (this.job) {
            this.job.stop();
        }
        this.isEnable = false;
    }
    public abstract execute(): void;
    public abstract destroy(): Promise<void>;
}
