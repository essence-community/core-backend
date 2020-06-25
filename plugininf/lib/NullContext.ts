import ErrorGate from "./errors/ErrorGate";
import ICCTParams, { IParamsInfo } from "./ICCTParams";
import IContext from "./IContext";
import IContextPlugin, { IContextPluginResult } from "./IContextPlugin";
import { IGateQuery } from "./IQuery";
import IResult from "./IResult";
import ResultStream from "./stream/ResultStream";
import { initParams } from "./util/Util";
import { IRufusLogger } from "rufus";
import Logger from "./Logger";

export default abstract class NullContext implements IContextPlugin {
    public static getParamsInfo(): IParamsInfo {
        return {
            attachmentType: {
                defaultValue: "attachment",
                name: "Mimetype file download",
                type: "string",
            },
            maxFileSize: {
                defaultValue: 10485760,
                name: "Размер файла в байтах",
                type: "integer",
            },
            maxLogParamLen: {
                defaultValue: 2048,
                name: "Максимальная длина лога",
                type: "integer",
            },
            maxPostSize: {
                defaultValue: 10485760,
                name: "Размер POST в байтах",
                type: "integer",
            },
            lvl_logger: {
                displayField: "ck_id",
                name: "Level logger",
                records: [
                    {
                        ck_id: "NOTSET",
                    },
                    { ck_id: "VERBOSE" },
                    { ck_id: "DEBUG" },
                    { ck_id: "INFO" },
                    { ck_id: "WARNING" },
                    { ck_id: "ERROR" },
                    { ck_id: "CRITICAL" },
                    { ck_id: "WARN" },
                    { ck_id: "TRACE" },
                    { ck_id: "FATAL" },
                ],
                type: "combo",
                valueField: "ck_id",
            },
        };
    }
    public name: string;
    public params: ICCTParams;
    public logger: IRufusLogger;
    public get maxPostSize(): number {
        return this.params.maxPostSize || 10485760;
    }
    public get maxFileSize(): number {
        return this.params.maxFileSize || 10485760;
    }
    public get maxLogParamLen(): number {
        return this.params.maxLogParamLen || 2048;
    }
    public get attachmentType(): string {
        return this.params.attachmentType || "attachment";
    }
    constructor(name: string, params: ICCTParams) {
        this.name = name;
        this.params = initParams(NullContext.getParamsInfo(), params);
        this.logger = Logger.getLogger(`Context ${name}`);
        if (
            typeof this.params === "object" &&
            this.params.lvl_logger &&
            this.params.lvl_logger !== "NOTSET"
        ) {
            const rootLogger = Logger.getRootLogger();
            this.logger.setLevel(this.params.lvl_logger);
            for (let handler of rootLogger._handlers) {
                this.logger.addHandler(handler);
            }
        }
    }
    public abstract init(reload?: boolean): Promise<void>;
    public abstract initContext(
        gateContext: IContext,
    ): Promise<IContextPluginResult>;
    public async checkQueryAccess(
        gateContext: IContext,
        query: IGateQuery,
    ): Promise<boolean> {
        if (query.needSession && !gateContext.session) {
            return false;
        }
        return true;
    }
    public async handleResult(
        gateContext: IContext,
        result: IResult,
    ): Promise<IResult> {
        return result;
    }
    public async maskResult(): Promise<IResult> {
        const result = {
            data: ResultStream([ErrorGate.MAINTENANCE_WORK]),
            type: "error",
        };
        return result as IResult;
    }
    public abstract destroy(): Promise<void>;
}
