import ICCTParams, { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import IContext, { IFile, IFormData } from "@ungate/plugininf/lib/IContext";
import { IPluginRequestContext } from "@ungate/plugininf/lib/IPlugin";
import { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import IResult from "@ungate/plugininf/lib/IResult";
import NullPlugin from "@ungate/plugininf/lib/NullPlugin";
import { initParams, isEmpty } from "@ungate/plugininf/lib/util/Util";
import { IOPARenderParams } from "./OPARender.types";
import { LocalOPARender } from "./LocalOPARender";
import { HTTPOPARender } from "./HTTPOPARender";
import ResultStream from "@ungate/plugininf/lib/stream/ResultStream";
import { ReadStreamToArray } from "@ungate/plugininf/lib/stream/Util";

// tslint:disable: object-literal-sort-keys
export default class OPARender extends NullPlugin {
    public static getParamsInfo(): IParamsInfo {
        return {
            fkType: {
                type: "combo",
                required: true,
                name: "Тип запуска",
                setGlobal: [{ out: "g_opa_fk_type" }],
                valueField: [{ in: "fkId" }],
                displayField: "fvId",
                records: [
                    { fkId: "local", fvId: "Локально EVAL" },
                    // { fkId: "local_http", fvId: "Локально HTTP" },
                    // { fkId: "remote", fvId: "HTTP Pool" },
                ],
                defaultValue: "local",
            },
            fvPath: {
                type: "string",
                hidden: true,
                required: true,
                hiddenRules: "g_opa_fk_type=='remote'",
                name: "Путь до OPA",
            },
            fvUrl: {
                type: "string",
                required: true,
                hidden: true,
                hiddenRules: "g_opa_fk_type!='remote'",
                name: "Ссылка",
            },
            localPort: {
                type: "integer",
                required: true,
                hidden: true,
                hiddenRules: "g_opa_fk_type!='local_http'",
                name: "Порт OPA",
                defaultValue: 8181,
            },
            flBefore: {
                type: "boolean",
                name: "Вызвать до вызова провайдера",
                defaultValue: false,
            },
            fvPoliticPath: {
                type: "string",
                description:
                    "jt_inparam - искать во входных данных<br/>jt_result - искать во после обработки<br/>Пример: jt_inparam.json.filter.politics",
                name: "Путь до Politics",
                required: true,
            },
            fvInputPath: {
                type: "string",
                description:
                    "jt_inparam - искать во входных данных<br/>jt_result - искать во после обработки<br/>Пример: jt_inparam.json.filter.input",
                name: "Путь до Input",
                required: true,
            },
            fvDataPath: {
                type: "string",
                description:
                    "jt_inparam - искать во входных данных<br/>jt_result - искать во после обработки<br/>Пример: jt_inparam.json.filter.data",
                name: "Путь до Data",
                required: true,
            },
            flCachePolitics: {
                type: "boolean",
                hidden: true,
                hiddenRules: "g_opa_fk_type=='local'",
                name: "Кэшировать на сервере политики?",
                defaultValue: false,
            },
            flIdPoliticsKey: {
                type: "string",
                hidden: true,
                hiddenRules: "g_opa_fk_type=='local'",
                description:
                    "jt_inparam - искать во входных данных<br/>jt_result - искать во после обработки<br/>Пример: jt_inparam.json.filter.keyId",
                name: "Идентификатор вызова",
            },
            flFinal: {
                type: "boolean",
                name: "Результат обработки, использовать в ответе",
                defaultValue: true,
            },
        };
    }
    params: IOPARenderParams;

    fixParam(
        val: string | null | undefined | string[] | IFile[],
    ): string[] | IFile[] {
        if (isEmpty(val)) {
            return [];
        }
        return Array.isArray(val) ? val : [val];
    }
    constructor(name: string, params: ICCTParams) {
        super(name, params);
        this.params = initParams(OPARender.getParamsInfo(), params, true);
        const controller =
            this.params.fkType === "local"
                ? new LocalOPARender(this.params, this.logger)
                : new HTTPOPARender(this.params, this.logger);
        if (this.params.flBefore) {
            this.beforeQueryExecutePerform = async (
                gateContext: IContext,
                PRequestContext: IPluginRequestContext,
                query: IGateQuery,
            ): Promise<IResult> => {
                const inParam = {
                    jt_inparam:
                        typeof gateContext.request.body === "object" &&
                        (gateContext.request.body as IFormData).files
                            ? {
                                  ...query.inParams,
                                  ...(gateContext.request.body as IFormData)
                                      .files,
                              }
                            : query.inParams,
                };
                const policies = this.params.fvPoliticPath
                    .split(",")
                    .reduce((res, val) => {
                        const value = this.deepParam(val, inParam);
                        return value ? value : res;
                    }, "");
                const input = this.params.fvInputPath
                    .split(",")
                    .reduce((res, val) => {
                        const value = this.deepParam(val, inParam);
                        return value ? value : res;
                    }, "");
                const data = this.params.fvDataPath
                    .split(",")
                    .reduce((res, val) => {
                        const value = this.deepParam(val, inParam);
                        return value ? value : res;
                    }, "");
                const queryId = this.params.flIdPoliticsKey
                    ?.split(",")
                    .reduce((res, val) => {
                        const value = this.deepParam(val, inParam);
                        return value ? value : res;
                    }, "");
                const result = await controller.eval(
                    this.fixParam(policies),
                    this.fixParam(data),
                    input,
                    queryId ? queryId : undefined,
                )
                if (this.params.flFinal) {
                    return {
                        type: "success",
                        data: ResultStream(
                            await controller.eval(
                                this.fixParam(policies),
                                this.fixParam(data),
                                input,
                                queryId ? queryId : undefined,
                            ),
                        ),
                    } as IResult;
                }
                query.inParams.jt_rego_result = JSON.stringify(result);
            };
        } else {
            this.afterQueryExecutePerform = async (
                gateContext: IContext,
                PRequestContext: IPluginRequestContext,
                result: IResult,
            ): Promise<IResult> => {
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
                };
                const policies = this.params.fvPoliticPath
                    .split(",")
                    .reduce((res, val) => {
                        const value = this.deepParam(val, inParam);
                        return value ? value : res;
                    }, "");
                const input = this.params.fvInputPath
                    .split(",")
                    .reduce((res, val) => {
                        const value = this.deepParam(val, inParam);
                        return value ? value : res;
                    }, "");
                const data = this.params.fvDataPath
                    .split(",")
                    .reduce((res, val) => {
                        const value = this.deepParam(val, inParam);
                        return value ? value : res;
                    }, "");
                const queryId = this.params.flIdPoliticsKey
                    ?.split(",")
                    .reduce((res, val) => {
                        const value = this.deepParam(val, inParam);
                        return value ? value : res;
                    }, "");
                return {
                    type: "success",
                    data: ResultStream(
                        await controller.eval(
                            this.fixParam(policies),
                            this.fixParam(data),
                            input,
                            queryId ? queryId : undefined,
                        ),
                    ),
                } as IResult;
            };
        }
    }

    deepParam(path: string, params: Record<string, any>) {
        if (isEmpty(params) || isEmpty(path)) {
            return null;
        }
        const paths: any[] = path.split(".");
        let current: any = params;

        for (const val of paths) {
            if (
                typeof current === "string" &&
                (current.trim().charAt(0) === "[" ||
                    current.trim().charAt(0) === "{")
            ) {
                current = JSON.parse(current);
            }
            if (!Array.isArray(current) && typeof current !== "object") {
                return null;
            }
            if (current[val] === undefined || current[val] === null) {
                return current[val];
            }

            current = current[val];
        }

        return current;
    }
}
