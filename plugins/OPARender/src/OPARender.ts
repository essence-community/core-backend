import ICCTParams, { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import IContext, { IFile, IFormData } from "@ungate/plugininf/lib/IContext";
import { IPluginRequestContext } from "@ungate/plugininf/lib/IPlugin";
import { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import IResult from "@ungate/plugininf/lib/IResult";
import NullPlugin from "@ungate/plugininf/lib/NullPlugin";
import { initParams, isEmpty } from "@ungate/plugininf/lib/util/Util";
import { IOPARenderParams, IOPAEval } from "./OPARender.types";
import { LocalOPARender } from "./LocalOPARender";
import { HTTPOPARender } from "./HTTPOPARender";
import ResultStream from "@ungate/plugininf/lib/stream/ResultStream";
import { ReadStreamToArray } from "@ungate/plugininf/lib/stream/Util";
import { deepParam } from "./Util";
import { isString } from "lodash";

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
                    "jt_inparam - искать во входных данных<br/>jt_result - искать во после обработки<br/>jt_query - Тело запроса<br/>Пример: jt_inparam.json.filter.politics",
                name: "Путь до Politics",
                required: true,
            },
            fvInputPath: {
                type: "string",
                description:
                    "jt_inparam - искать во входных данных<br/>jt_result - искать во после обработки<br/>jt_query - Тело запроса<br/>Пример: jt_inparam.json.filter.input",
                name: "Путь до Input",
                required: true,
            },
            fvDataPath: {
                type: "string",
                description:
                    "jt_inparam - искать во входных данных<br/>jt_result - искать во после обработки<br/>jt_query - Тело запроса<br/>Пример: jt_inparam.json.filter.data",
                name: "Путь до Data",
            },
            fvQueryPath: {
                type: "string",
                description:
                    "jt_inparam - искать во входных данных<br/>jt_result - искать во после обработки<br/>jt_query - Тело запроса<br/>Пример: jt_inparam.json.filter.data",
                name: "Путь до Query",
            },
            fvResultKeyPath: {
                type: "string",
                name: "Путь до Result до пути поиска",
            },
            fvResultPath: {
                type: "string",
                name: "Путь до Result для распаковки вывода",
                required: true,
                defaultValue: "result.*.bindings",
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
                    "jt_inparam - искать во входных данных<br/>jt_result - искать во после обработки<br/>jt_query - Тело запроса<br/>Пример: jt_inparam.json.filter.keyId",
                name: "Идентификатор вызова",
            },
            flFinal: {
                type: "boolean",
                name: "Результат обработки, использовать в ответе",
                defaultValue: true,
            },
            fvDataDefault: {
                type: "long_string",
                name: "Метаинформация по умолчанию",
            },
            fvQueryDefault: {
                type: "long_string",
                name: "Запрос по умолчанию",
                defaultValue: `result := { msg |
                    msg := data[_][_]
                    is_object(msg)
                    }
                    `,
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
        this.logger.debug("params", this.params);
        const controller: IOPAEval =
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
                    jt_query:
                        isString(query.queryStr) &&
                        (query.queryStr.trim().startsWith("{") ||
                            query.queryStr.trim().startsWith("["))
                            ? JSON.parse(query.queryStr)
                            : query.queryStr,
                };
                const policies = this.params.fvPoliticPath
                    .split(",")
                    .reduce((res, val) => {
                        const value = deepParam(val, inParam);
                        return value ? value : res;
                    }, "");
                const input = this.params.fvInputPath
                    .split(",")
                    .reduce((res, val) => {
                        const value = deepParam(val, inParam);
                        return value ? value : res;
                    }, "");
                const data =
                    this.params.fvDataPath?.split(",").reduce((res, val) => {
                        const value = deepParam(val, inParam);
                        return value ? value : res;
                    }, "") || this.params.fvDataDefault;
                const queryString =
                    this.params.fvQueryPath?.split(",").reduce((res, val) => {
                        const value = deepParam(val, inParam);
                        return value ? value : res;
                    }, "") || this.params.fvQueryDefault;
                const queryId = this.params.flIdPoliticsKey
                    ?.split(",")
                    .reduce((res, val) => {
                        const value = deepParam(val, inParam);
                        return value ? value : res;
                    }, "");
                const resultPath =
                    this.params.fvResultKeyPath
                        ?.split(",")
                        .reduce((res, val) => {
                            const value = deepParam(val, inParam);
                            return value ? value : res;
                        }, "") || this.params.fvResultPath;
                let result = [];
                this.logger.debug(
                    "politics path: %s",
                    this.params.fvPoliticPath,
                    policies,
                );
                this.logger.debug(
                    "data path: %s",
                    this.params.fvDataPath || "",
                    data,
                );
                this.logger.debug(
                    "input path: %s",
                    this.params.fvInputPath,
                    input,
                );
                this.logger.debug(
                    "queryString path: %s",
                    this.params.fvQueryPath || "",
                    queryString,
                );
                this.logger.debug(
                    "resultPath path: %s",
                    this.params.fvResultKeyPath || "",
                    resultPath,
                );
                this.logger.debug(
                    `${Array.isArray(input)} && ${input.length} && ${
                        input[0].path
                    }`,
                );
                if (Array.isArray(input) && input.length && input[0].path) {
                    result = await Promise.all(
                        (input as IFile[]).map(async (file) => {
                            let res = await controller.eval(
                                this.fixParam(policies),
                                this.fixParam(data),
                                file,
                                queryString,
                                resultPath,
                                queryId ? queryId : undefined,
                            );
                            res = Array.isArray(res) ? res : [res];
                            return res.map((obj) => ({
                                ...obj,
                                fv_file_name: file.originalFilename,
                            }));
                        }),
                    ).then((values) =>
                        values.reduce(
                            (resInput, valInput) => [...resInput, ...valInput],
                            [],
                        ),
                    );
                } else {
                    result = await controller.eval(
                        this.fixParam(policies),
                        this.fixParam(data),
                        input,
                        queryString,
                        resultPath,
                        queryId ? queryId : undefined,
                    );
                }

                if (this.params.flFinal) {
                    return {
                        type: "success",
                        data: ResultStream(result),
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
                    jt_query:
                        isString(gateContext.query.queryStr) &&
                        (gateContext.query.queryStr.trim().startsWith("{") ||
                            gateContext.query.queryStr.trim().startsWith("["))
                            ? JSON.parse(gateContext.query.queryStr)
                            : gateContext.query.queryStr,
                };
                const policies =
                    this.params.fvPoliticPath.split(",").reduce((res, val) => {
                        const value = deepParam(val, inParam);
                        return value ? value : res;
                    }, "") || this.params.fvPoliticDefault;
                const input =
                    this.params.fvInputPath.split(",").reduce((res, val) => {
                        const value = deepParam(val, inParam);
                        return value ? value : res;
                    }, "") || this.params.fvInputDefault;
                const data =
                    this.params.fvDataPath.split(",").reduce((res, val) => {
                        const value = deepParam(val, inParam);
                        return value ? value : res;
                    }, "") || this.params.fvDataDefault;
                const queryString =
                    this.params.fvQueryPath.split(",").reduce((res, val) => {
                        const value = deepParam(val, inParam);
                        return value ? value : res;
                    }, "") || this.params.fvQueryDefault;
                const queryId = this.params.flIdPoliticsKey
                    ?.split(",")
                    .reduce((res, val) => {
                        const value = deepParam(val, inParam);
                        return value ? value : res;
                    }, "");
                const resultPath =
                    this.params.fvResultKeyPath
                        ?.split(",")
                        .reduce((res, val) => {
                            const value = deepParam(val, inParam);
                            return value ? value : res;
                        }, "") || this.params.fvResultPath;
                this.logger.debug("politics", policies);
                this.logger.debug("data", data);
                this.logger.debug("input", input);
                this.logger.debug("queryString", queryString);
                this.logger.debug("resultPath", resultPath);
                let resultOpa = [];
                if (Array.isArray(input) && input.length && input[0].path) {
                    resultOpa = await Promise.all(
                        (input as IFile[]).map(async (file) => {
                            let res = await controller.eval(
                                this.fixParam(policies),
                                this.fixParam(data),
                                file,
                                queryString,
                                resultPath,
                                queryId ? queryId : undefined,
                            );
                            res = Array.isArray(res) ? res : [res];
                            return res.map((obj) => ({
                                ...obj,
                                fv_file_name: file.originalFilename,
                            }));
                        }),
                    ).then((values) =>
                        values.reduce(
                            (resInput, valInput) => [...resInput, ...valInput],
                            [],
                        ),
                    );
                } else {
                    resultOpa = await controller.eval(
                        this.fixParam(policies),
                        this.fixParam(data),
                        input,
                        queryString,
                        resultPath,
                        queryId ? queryId : undefined,
                    );
                }
                return {
                    type: "success",
                    data: ResultStream(resultOpa),
                } as IResult;
            };
        }
    }
}
