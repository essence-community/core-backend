import { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import ICCTParams from "@ungate/plugininf/lib/ICCTParams";
import IContext from "@ungate/plugininf/lib/IContext";
import { IPluginRequestContext } from "@ungate/plugininf/lib/IPlugin";
import IResult from "@ungate/plugininf/lib/IResult";
import NullPlugin from "@ungate/plugininf/lib/NullPlugin";
import { safePipe } from "@ungate/plugininf/lib/stream/Util";
import { initParams } from "@ungate/plugininf/lib/util/Util";
import { isArray, isObject, isString } from "lodash";
import { Transform } from "stream";

export default class JsonRowColumnExtractor extends NullPlugin {
    public static getParamsInfo(): IParamsInfo {
        return {
            columns: {
                name: "Наименоване колонок которые надо распаковать через запятую",
                type: "string",
            },
            extractSingleColumn: {
                defaultValue: false,
                name: "Признак что надо распоковать колонку если она одна",
                type: "boolean",
            },
        };
    }
    constructor(name: string, params: ICCTParams) {
        super(name, params);
        this.params = initParams(
            JsonRowColumnExtractor.getParamsInfo(),
            params,
        );
    }
    /**
     * Распаковываем json из строки
     * @param gateContext
     * @param PRequestContext
     * @param result
     */
    public async afterQueryExecutePerform(
        gateContext: IContext,
        PRequestContext: IPluginRequestContext,
        result: IResult,
    ): Promise<IResult | void> {
        if (
            result.type !== "success" &&
            result.type !== "error" &&
            result.type !== "false"
        ) {
            return;
        }
        const self = this;
        const columns = (this.params.columns || "").split(",");
        let columnExtract;
        const columnObjExtract =
            (name: string) => (stream: any, chunk: any, done: any) => {
                try {
                    const obj = isString(chunk[name])
                        ? JSON.parse(chunk[name])
                        : chunk[name];
                    delete chunk[name];
                    if (isArray(obj)) {
                        obj.forEach((val) =>
                            stream.push({
                                ...chunk,
                                ...val,
                            }),
                        );
                        done();
                        return;
                    }

                    done(null, {
                        ...chunk,
                        ...obj,
                    });
                } catch (e) {
                    gateContext.error(e.message, e);
                    done(null, chunk);
                }
            };
        const columnExist = (stream: any, chunk: any, done: any) => {
            done(null, chunk);
        };
        const extractor = new Transform({
            readableObjectMode: true,
            writableObjectMode: true,
            transform(chunk: any, encode: string, done) {
                if (columnExtract) {
                    columnExtract(this, chunk, done);
                    return;
                }
                if (!isObject(chunk)) {
                    columnExtract = columnExist;
                    columnExtract(this, chunk, done);
                    return;
                }
                if (columns.length) {
                    const res = columns.every((val) => {
                        if (Object.prototype.hasOwnProperty.call(chunk, val)) {
                            columnExtract = columnObjExtract(val);
                            columnExtract(this, chunk, done);
                            return false;
                        }
                        return true;
                    });
                    if (!res) {
                        return;
                    }
                }
                if (self.params.extractSingleColumn) {
                    const keys = Object.keys(chunk);
                    if (keys.length === 1) {
                        const val = chunk[keys[0]];
                        if (
                            (isString(val) &&
                                (val.trim()[0] === "{" ||
                                    val.trim()[0] === "[")) ||
                            isObject(val) ||
                            isArray(val)
                        ) {
                            columnExtract = columnObjExtract(keys[0]);
                            columnExtract(this, chunk, done);
                            return;
                        }
                    }
                }
                columnExtract = columnExist;
                columnExtract(this, chunk, done);
                return;
            },
        });
        result.data = safePipe(result.data, extractor);
        return;
    }
}
