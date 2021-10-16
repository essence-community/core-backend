import ICCTParams, { IParamsInfo } from "./ICCTParams";
import IEvents from "./IEvents";
import Logger from "./Logger";
import { IRufusLogger } from "rufus";

export default abstract class NullEvent implements IEvents {
    public name: string;
    public params: ICCTParams;
    public logger: IRufusLogger;
    public static getParamsInfo(): IParamsInfo {
        return {};
    }
    constructor(name: string, params: ICCTParams) {
        this.name = name;
        this.params = params;
        this.logger = Logger.getLogger(`Event:${name}`);
    }
    public abstract init(reload?: boolean): Promise<void>;
    public async destroy(): Promise<void> {
        return;
    }
}
