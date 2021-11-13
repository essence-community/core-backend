import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import ICCTParams from "@ungate/plugininf/lib/ICCTParams";
import IContext from "@ungate/plugininf/lib/IContext";
import { IPluginRequestContext } from "@ungate/plugininf/lib/IPlugin";
import { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import IResult from "@ungate/plugininf/lib/IResult";
import NullPlugin from "@ungate/plugininf/lib/NullPlugin";
import ResultStream from "@ungate/plugininf/lib/stream/ResultStream";
import { initParams, isEmpty } from "@ungate/plugininf/lib/util/Util";
import * as QueryString from "qs";
import * as URL from "url";
import * as util from "util";
import * as http from "http";
import { Execute, ResultFault, ResultSuccess } from "./typings";
import { safeResponsePipe } from "@ungate/plugininf/lib/stream/Util";

export default class EssenceReportIntegration extends NullPlugin {
    public static getParamsInfo(): IParamsInfo {
        return {
            callBackUrl: {
                name: "Урл шлюза",
                type: "string",
            },
            exportUrl: {
                name: "UUID на отчет excel",
                type: "string",
            },
            maxExcelRows: {
                defaultValue: 50000,
                name: "Максимальное количество строк",
                type: "integer",
            },
            prefixPath: {
                name: "Префикс пути",
                required: true,
                type: "string",
            },
            proxy: {
                name: "Прокси сервер",
                type: "string",
            },
            timeout: {
                defaultValue: 7200,
                name: "Время ожидания",
                type: "integer",
            },
            urlReceiver: {
                name: "URL JS",
                required: true,
                type: "string",
            },
        };
    }

    private executeReport;
    private storeReport;
    protected runDelayedPrint;
    protected reportStatus;
    constructor(name: string, params: ICCTParams) {
        super(name, params);
        this.name = name;
        this.params = initParams(
            EssenceReportIntegration.getParamsInfo(),
            params,
        );
        this.executeReport = `${this.params.urlReceiver}/execute`;
        this.storeReport = `${this.params.urlReceiver}/store`;
    }

    /**
     * Перед вызовом запроса
     * @param gateContext
     */
    public async beforeQueryExecutePerform(
        gateContext: IContext,
        PRequestContext: IPluginRequestContext,
        query: IGateQuery,
    ): Promise<IResult | void> {
        if (isEmpty(query.inParams.json)) {
            return;
        }
        if (gateContext.query.inParams.exportexcel) {
            return this.exportExcel(gateContext);
        }
        const json = JSON.parse(query.inParams.json);
        if (gateContext.actionName === "dml") {
            if (json.service.cv_action.toLowerCase() === "i") {
                if (isEmpty(json.data.ck_d_format)) {
                    return {
                        data: ResultStream([
                            {
                                ck_id: null,
                                cv_error: {
                                    900: [],
                                },
                            },
                        ]),
                        type: "success",
                    } as IResult;
                }
                if (
                    isEmpty(json.data.ck_report) ||
                    isEmpty(json.data.cl_online)
                ) {
                    throw new ErrorException(
                        101,
                        "Not found required parameters ck_report,cl_online",
                    );
                }
                json.session = {
                    ...gateContext.session.userData,
                    session: gateContext.sessionId,
                };
                const runReport = URL.parse(this.executeReport, true);
                const postData = JSON.stringify({
                    cct_parameter: {
                        callback_gate_url: this.params.callBackUrl,
                        json: JSON.stringify(json),
                        page_object: query.inParams.page_object,
                        session: gateContext.sessionId,
                    },
                    ck_format: json.data.ck_d_format,
                    ck_report: json.data.ck_report,
                    cl_online: json.data.cl_online,
                    cv_name: json.data.cv_filename,
                    session: gateContext.sessionId,
                } as Execute);
                return this.executePrintServer(
                    gateContext,
                    runReport,
                    "POST",
                    postData,
                ).then(async (res) => {
                    if (res.success) {
                        return {
                            data: ResultStream([
                                {
                                    ck_id: res.ck_id,
                                    cv_error:
                                        json.data.cl_online &&
                                        res.cv_status !== "success"
                                            ? {
                                                  50: [
                                                      isEmpty(
                                                          json.data.cv_filename,
                                                      )
                                                          ? json.data
                                                                .cv_filename
                                                          : "",
                                                  ],
                                              }
                                            : null,
                                    cv_url: `${
                                        this.params.prefixPath
                                    }${util.format(
                                        "/%s/%s",
                                        res.ck_id,
                                        gateContext.sessionId,
                                    )}`,
                                },
                            ]),
                            type: "success",
                        } as IResult;
                    }
                    throw new ErrorException(
                        -1,
                        (res as ResultFault).cv_message,
                    );
                });
            } else if (json.service.cv_action.toLowerCase() === "d") {
                const reportDelete = URL.parse(this.executeReport, true);
                reportDelete.query.session = gateContext.sessionId;
                reportDelete.query.ck_queue = json.data.ck_id;
                return this.executePrintServer(
                    gateContext,
                    reportDelete,
                    "DELETE",
                ).then(async (res) => {
                    if (res.success) {
                        return {
                            data: ResultStream([
                                {
                                    ck_id: json.data.ck_id,
                                    cv_error: null,
                                },
                            ]),
                            type: "success",
                        } as IResult;
                    }
                    throw new ErrorException(
                        -1,
                        (res as ResultFault).cv_message,
                    );
                });
            }
        } else if (gateContext.actionName === "file") {
            return this.getFile(gateContext, json);
        }
        return;
    }

    private getFile(gateContext: IContext, json): Promise<IResult> {
        const url = URL.parse(this.storeReport, true);
        url.query.session = gateContext.sessionId;
        url.query.ck_queue =
            json.data.ck_queue ||
            json.data.ck_id ||
            json.filter.ck_queue ||
            json.filter.ck_id;
        return new Promise((resolve) => {
            http.get(URL.format(url), (res) => {
                safeResponsePipe(res, gateContext.response);
                return resolve({
                    data: ResultStream([]),
                    type: "break",
                } as IResult);
            });
        });
    }

    /**
     * Экспорт в Excel
     * @param gateContext
     * @param data
     * @returns {Promise}
     */
    public exportExcel(gateContext: IContext): Promise<IResult> {
        const json = JSON.parse(gateContext.query.inParams.jsonbc);
        const params = this.params;
        const plugin = gateContext.pluginName
            .filter(
                (name) =>
                    name.toLocaleUpperCase() !== this.name.toLocaleUpperCase(),
            )
            .join(",");
        const body = {
            json: gateContext.query.inParams.json,
            page_object: gateContext.params.page_object,
            plugin,
        };
        const callBackUrl = URL.parse(this.params.callBackUrl, true);
        callBackUrl.query = {
            query: gateContext.queryName,
            session: gateContext.sessionId,
        };
        const jsonRequest = {
            body: QueryString.stringify(body),
            limit: params.maxExcelRows,
            method: "POST",
            session: {
                ...gateContext.session.userData,
                session: gateContext.sessionId,
            },
            stream: false,
            url: URL.format(callBackUrl),
        };
        const runReport = URL.parse(this.executeReport, true);
        const postData = JSON.stringify({
            cct_parameter: {
                export_excel: true,
                json: JSON.stringify(jsonRequest),
                jsonBC: gateContext.query.inParams.jsonbc,
            },
            cl_online: true,
            ck_format: "xlsx",
            ck_report: this.params.exportUrl,
            cv_name: json.excelname,
            session: gateContext.sessionId,
        } as Execute);
        return this.executePrintServer(
            gateContext,
            runReport,
            "POST",
            postData,
        ).then((res) => {
            if (res.success) {
                const result = {
                    ck_id: res.ck_id,
                    cv_url_response: `${this.params.prefixPath}${util.format(
                        "/%s/%s",
                        res.ck_id,
                        gateContext.sessionId,
                    )}`,
                };
                return Promise.resolve({
                    data: ResultStream([
                        {
                            ...result,
                            cv_error:
                                res.cv_status === "success"
                                    ? null
                                    : {
                                          50: [
                                              isEmpty(json.excelname)
                                                  ? json.excelname
                                                  : "",
                                          ],
                                      },
                        },
                    ]),
                    type: "success",
                } as IResult);
            }
            throw new ErrorException(-1, (res as ResultFault).cv_message);
        });
    }

    /**
     * Вызов сервиса
     * @param urlPrint (URL) ссылка
     * @param method (String) POST|GET|DELETE|UPDATE default POST
     * @param postData (String) Body
     * @returns {Promise}
     */
    public executePrintServer(
        gateContext: IContext,
        url: URL.UrlWithParsedQuery,
        method: "POST" | "GET" | "DELETE" = "POST",
        postData?: string,
    ): Promise<ResultSuccess | ResultFault> {
        return new Promise((resolve, reject) => {
            this.logger.debug("GET url %j", url);
            const req = http.request(
                URL.format(url),
                {
                    method,
                    timeout: this.params.timeout,
                    ...(postData
                        ? {
                              headers: {
                                  "Content-Type": "application/json",
                                  "Content-Length": Buffer.byteLength(postData),
                              },
                          }
                        : {}),
                },
                async (res) => {
                    const { statusCode } = res;
                    const contentType = res.headers["content-type"];
                    if (
                        statusCode !== 200 ||
                        !/^application\/json/.test(contentType)
                    ) {
                        this.logger.error(
                            "GET response url %j code %s content-type %s",
                            url,
                            statusCode,
                            contentType,
                        );
                        res.resume();
                        return reject();
                    }
                    res.setEncoding("utf8");
                    let rawData = "";
                    res.on("data", (chunk) => {
                        rawData += chunk;
                    });
                    res.on("end", () => {
                        try {
                            const parsedData = JSON.parse(rawData) as
                                | ResultSuccess
                                | ResultFault;
                            return resolve(parsedData);
                        } catch (e) {
                            this.logger.error(
                                "GET response url %j code %s content-type %s data %j",
                                url,
                                statusCode,
                                contentType,
                                rawData,
                            );
                        }
                        return reject();
                    });
                },
            );
            req.on("error", (e) => {
                reject(e);
            });

            // Write data to request body
            if (postData) {
                req.write(postData);
            }
            req.end();
        });
    }
}
