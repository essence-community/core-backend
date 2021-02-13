import ICCTParams, { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import IContext, { IFormData } from "@ungate/plugininf/lib/IContext";
import { IPluginRequestContext } from "@ungate/plugininf/lib/IPlugin";
import { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import IResult from "@ungate/plugininf/lib/IResult";
import NullPlugin from "@ungate/plugininf/lib/NullPlugin";
import { initParams, isEmpty } from "@ungate/plugininf/lib/util/Util";
import { IEncoderParams, IEncoder } from "./Encoder.types";
import { YAMLEncoder } from "./YAMLEncoder";
import { XMLEncoder } from "./XMLEncoder";
import { BASE64Encoder } from "./BASE64Encoder";
import { isString } from "lodash";
import { deepParam } from "@ungate/plugininf/lib/util/deepParam";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import { ReadStreamToArray } from "@ungate/plugininf/lib/stream/Util";
import { deepChange } from "@ungate/plugininf/lib/util/deepParam";
import ResultStream from "@ungate/plugininf/lib/stream/ResultStream";
import * as fs from "fs";

// tslint:disable: object-literal-sort-keys
export default class Encoder extends NullPlugin {
    public static getParamsInfo(): IParamsInfo {
        return {
            fvTypeEncode: {
                type: "combo",
                name: "Тип декодирования по умолчанию",
                required: true,
                valueField: [{ in: "fkId" }],
                displayField: "fvId",
                records: [
                    { fkId: "1", fvId: "JSON -> YAML" },
                    { fkId: "2", fvId: "YAML -> JSON" },
                    { fkId: "3", fvId: "JSON -> XML" },
                    { fkId: "4", fvId: "XML -> JSON" },
                    { fkId: "5", fvId: "XML -> YAML" },
                    { fkId: "6", fvId: "YAML -> XML" },
                    { fkId: "7", fvId: "Encode BASE64" },
                    { fkId: "8", fvId: "Decode BASE64" },
                ],
                defaultValue: "1",
            },
            fvPath: {
                type: "string",
                required: true,
                description:
                    "jt_inparam - искать во входных данных<br/>jt_result - искать во после обработки<br/>jt_query - Тело запроса<br/>Пример: jt_inparam.json.filter.input",
                name: "Путь до данных которые надо декодировать",
            },
            fvTypeEncodePath: {
                type: "string",
                name: "Путь до типа кодировани",
                description:
                    "jt_inparam - искать во входных данных<br/>jt_result - искать во после обработки<br/>jt_query - Тело запроса<br/>Пример: jt_inparam.json.filter.input",
            },
            flBefore: {
                type: "boolean",
                required: true,
                name: "Запускать до вызова провайдера",
                defaultValue: true,
            },
            flFinal: {
                type: "boolean",
                required: true,
                setGlobal: [{ out: "g_encode_final" }],
                name: "Выводить сразу в результат",
                defaultValue: false,
            },
            fvFinalPath: {
                type: "string",
                name: "Путь куда выложить конечный результат",
                hiddenRules: "!g_encode_final",
                hidden: true,
                required: true,
                defaultValue: "jt_return_form_data.output",
            },
        };
    }
    params: IEncoderParams;
    encoder: Record<"yaml" | "xml" | "base64", IEncoder>;

    constructor(name: string, params: ICCTParams) {
        super(name, params);
        this.params = initParams(Encoder.getParamsInfo(), params, true);
        this.logger.debug("params", this.params);
        this.encoder = {
            yaml: new YAMLEncoder(this.params),
            xml: new XMLEncoder(this.params),
            base64: new BASE64Encoder(this.params),
        };
        if (this.params.flBefore) {
            this.beforeQueryExecutePerform = async (
                gateContext: IContext,
                PRequestContext: IPluginRequestContext,
                query: IGateQuery,
            ): Promise<IResult | null> => {
                const inParam = {
                    jt_inparam:
                        typeof gateContext.request.body === "object" &&
                        (gateContext.request.body as IFormData).files
                            ? {
                                  ...gateContext.query.inParams,
                                  ...(gateContext.request.body as IFormData)
                                      .files,
                              }
                            : gateContext.query.inParams,
                    jt_query:
                        isString(gateContext.query.queryStr) &&
                        (gateContext.query.queryStr.trim().startsWith("{") ||
                            gateContext.query.queryStr.trim().startsWith("["))
                            ? JSON.parse(gateContext.query.queryStr)
                            : gateContext.query.queryStr,
                    jt_result: null,
                };
                const res = await this.executePlugin(
                    gateContext.actionName,
                    inParam,
                );
                if (res) {
                    if (this.params.flFinal) {
                        return {
                            type: "success",
                            data: ResultStream(res),
                        } as IResult;
                    }
                    this.params.fvPath
                        .split(",")
                        .filter((val) => val.indexOf("jt_inparam") > -1)
                        .slice(1)
                        .forEach((val) => {
                            deepChange(gateContext.query.inParams, val, res);
                        }, "");
                }
                return null;
            };
        } else {
            this.afterQueryExecutePerform = async (
                gateContext: IContext,
                PRequestContext: IPluginRequestContext,
                result: IResult,
            ): Promise<IResult | null> => {
                const resStream = await ReadStreamToArray(result.data);
                const inParam = {
                    jt_result: resStream,
                    jt_inparam:
                        typeof gateContext.request.body === "object" &&
                        (gateContext.request.body as IFormData).files
                            ? {
                                  ...gateContext.query.inParams,
                                  ...(gateContext.request.body as IFormData)
                                      .files,
                              }
                            : gateContext.query.inParams,
                    jt_query:
                        isString(gateContext.query.queryStr) &&
                        (gateContext.query.queryStr.trim().startsWith("{") ||
                            gateContext.query.queryStr.trim().startsWith("["))
                            ? JSON.parse(gateContext.query.queryStr)
                            : gateContext.query.queryStr,
                };

                const res = await this.executePlugin(
                    gateContext.actionName,
                    inParam,
                );
                if (res) {
                    return {
                        type: "success",
                        data: ResultStream(res),
                    } as IResult;
                }
                return result;
            };
        }
    }

    executePlugin = async (
        action: IContext["actionName"],
        inParam: Record<string, any>,
    ): Promise<Record<string, any>[] | null> => {
        const input = this.params.fvPath.split(",").reduce((res, val) => {
            const value = deepParam(val, inParam);
            return value ? value : res;
        }, "");
        const type =
            this.params.fvTypeEncodePath?.split(",").reduce((res, val) => {
                const value = deepParam(val, inParam);
                return value ? value : res;
            }, "") || this.params.fvTypeEncode;
        const notFoundParam = [];
        if (isEmpty(input)) {
            notFoundParam.push("input");
        }
        if (isEmpty(type)) {
            notFoundParam.push("typeEncode");
        }
        if (notFoundParam.length) {
            throw new ErrorException(
                ErrorGate.compileErrorResult(
                    -1,
                    `Not found require params ${notFoundParam.join(",")}`,
                ),
            );
        }
        let result = null;
        switch (type) {
            case "1":
                result = await this.encoder.yaml.encode(
                    typeof input === "string" ? JSON.parse(input) : input,
                );
                break;
            case "2":
                result = await this.encoder.yaml.decode(input);
                break;
            case "3":
                result = await this.encoder.xml.encode(
                    typeof input === "string" ? JSON.parse(input) : input,
                );
                break;
            case "4":
                result = await this.encoder.xml.decode(input);
                break;
            case "5":
                result = await this.encoder.xml.decode(input);
                result = await this.encoder.yaml.encode(result);
                break;
            case "6":
                result = await this.encoder.yaml.decode(input);
                result = await this.encoder.xml.encode(result);
                break;
            case "7":
                result = await this.encoder.base64.encodeStr(input);
                break;
            case "8":
                result = await this.encoder.base64.decodeStr(input);
                break;
            default:
                throw new ErrorException(
                    ErrorGate.compileErrorResult(
                        -1,
                        `Type Encode error ${type}`,
                    ),
                );
        }
        if (this.params.flFinal) {
            let data = isString(result) ? result : "";
            if (Array.isArray(result) && result.length && result[0].path) {
                data = fs.readFileSync(result[0].path).toString();
            } else if (typeof result === "object" || Array.isArray(result)) {
                data = JSON.stringify(result);
            }
            if (action === "file") {
                return [
                    {
                        filedata: data,
                        ...this.fileData(type),
                    },
                ];
            }
            const arr = inParam.jt_result || [{}];
            deepChange(arr[0], this.params.fvFinalPath, data);
            return arr;
        }
        return inParam.jt_result;
    };

    fileData(type: string) {
        const name = "output";
        switch (type) {
            case "1":
                return {
                    filetype: "application/x-yaml",
                    filename: `${name}.yaml`,
                };
            case "2":
                return {
                    filetype: "application/json",
                    filename: `${name}.json`,
                };
            case "3":
                return {
                    filetype: "text/xml",
                    filename: `${name}.xml`,
                };
            case "4":
                return {
                    filetype: "application/json",
                    filename: `${name}.json`,
                };
            case "5":
                return {
                    filetype: "application/x-yaml",
                    filename: `${name}.yaml`,
                };
            case "6":
                return {
                    filetype: "text/xml",
                    filename: `${name}.xml`,
                };
            case "7":
                return {
                    filetype: "text/plain",
                    filename: `${name}.txt`,
                };
            case "8":
                return {
                    filetype: "text/plain",
                    filename: `${name}.txt`,
                };
            default:
                throw new ErrorException(
                    ErrorGate.compileErrorResult(
                        -1,
                        `Type Encode error ${type}`,
                    ),
                );
        }
    }
}
