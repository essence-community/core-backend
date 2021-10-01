import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import ICCTParams from "@ungate/plugininf/lib/ICCTParams";
import IContext from "@ungate/plugininf/lib/IContext";
import { IPluginRequestContext } from "@ungate/plugininf/lib/IPlugin";
import IQuery, { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import IResult from "@ungate/plugininf/lib/IResult";
import NullPlugin from "@ungate/plugininf/lib/NullPlugin";
import ResultStream from "@ungate/plugininf/lib/stream/ResultStream";
import { initParams, isEmpty } from "@ungate/plugininf/lib/util/Util";
import { delay, forEach, isObject } from "lodash";
import * as moment from "moment";
import * as QueryString from "query-string";
import * as request from "request";
import * as url from "url";
import * as util from "util";

export default class USPOIntegration extends NullPlugin {
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
            queryNotification: {
                name: "Наименование запроса для оповещения",
                required: true,
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

    private runReport;
    private reportDelete;
    protected runDelayedPrint;
    private reportStatus;
    constructor(name: string, params: ICCTParams) {
        super(name, params);
        this.name = name;
        this.params = initParams(USPOIntegration.getParamsInfo(), this.params);
        this.params.queryNotification = this.params.queryNotification.toLowerCase();
        this.runReport = `${this.params.urlReceiver}/accept`;
        this.reportDelete = `${this.params.urlReceiver}/queue-delete`;
        this.runDelayedPrint = `${this.params.urlReceiver}/delayedPrint`;
        this.reportStatus = `${this.params.urlReceiver}/status`;
    }
    public async beforeInitQueryPerform(
        gateContext: IContext,
        PRequestContext: IPluginRequestContext,
        query?: IQuery,
    ): Promise<IQuery | void> {
        if (
            gateContext.actionName === "dml" &&
            gateContext.queryName === this.params.queryNotification
        ) {
            const json = JSON.parse(gateContext.params.json);
            const jsonData = JSON.parse(json.incomingData.params.json);
            if (isEmpty(gateContext.session)) {
                gateContext.session = jsonData.session;
                query.needSession = false;
            }
            if (isEmpty(query.extraInParams)) {
                query.extraInParams = [];
            }
            query.extraInParams.push({
                cl_replace: true,
                cv_name: "json",
                cv_value: JSON.stringify({
                    data: {
                        cd_st: moment().format("YYYY-MM-DDTHH:mm:ss"),
                        // tslint:disable-next-line:object-literal-sort-keys
                        cd_en: moment()
                            .add(1, "day")
                            .format("YYYY-MM-DDTHH:mm:ss"),
                        cl_sent: 0,
                        ck_user: jsonData.session.idUser,
                        cv_message: json.incomingData.params.export_excel
                            ? JSON.stringify(
                                  json.status === "success"
                                      ? {
                                            export_excel: `${
                                                this.params.prefixPath
                                            }${util.format(
                                                "/%s/%s",
                                                json.queueId,
                                                jsonData.session.session,
                                            )}`,
                                        }
                                      : {
                                            cv_error: {
                                                "50": ["Выгрузка в excel"],
                                            },
                                        },
                              )
                            : JSON.stringify({
                                  cv_error: {
                                      [json.status === "success" ? 47 : 50]: [
                                          json.reportName,
                                      ],
                                  },
                                  reloadpageobject: jsonData.reloadpageobject,
                              }),
                    },
                    service: {
                        cv_action: "I",
                    },
                }),
            });
            forEach(jsonData.session, (val, key) => {
                query.extraInParams.push({
                    cv_name: `sess_${key}`,
                    cv_value: val,
                });
            });
        }
        return;
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
        if (
            gateContext.actionName.toLowerCase() === "dml" &&
            gateContext.queryName !== this.params.queryNotification
        ) {
            const json = JSON.parse(query.inParams.json);
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
                const runReport = url.parse(this.runReport, true);
                const postData = JSON.stringify({
                    parameters: {
                        callback_gate_url: this.params.callBackUrl,
                        json: JSON.stringify(json),
                        page_object: query.inParams.page_object,
                        session: gateContext.sessionId,
                        ...(json.data.ck_d_format === "csv"
                            ? { REPORT_LOCALE: "en_EN" }
                            : {}),
                    },
                    reportFormat: json.data.ck_d_format,
                    reportId: json.data.ck_report,
                    reportName: json.data.cv_filename,
                    session: gateContext.sessionId,
                    user: gateContext.session.userData.ck_id,
                });
                return this.executePrintServer(
                    gateContext,
                    runReport,
                    "POST",
                    postData,
                ).then(async (res) => {
                    if (res.responseJson.resultCode) {
                        if (json.data.cl_online) {
                            return this.checkOnline(
                                gateContext,
                                res.responseJson.queueId,
                            ).then(
                                async (value) =>
                                    ({
                                        data: ResultStream([
                                            {
                                                ck_id: res.responseJson.queueId,
                                                cv_error:
                                                    value === "success"
                                                        ? null
                                                        : {
                                                              50: [
                                                                  isEmpty(
                                                                      json.data
                                                                          .cv_filename,
                                                                  )
                                                                      ? json
                                                                            .data
                                                                            .cv_filename
                                                                      : "",
                                                              ],
                                                          },
                                                cv_url:
                                                    value === "success"
                                                        ? `${
                                                              this.params
                                                                  .prefixPath
                                                          }${util.format(
                                                              "/%s/%s",
                                                              res.responseJson
                                                                  .queueId,
                                                              gateContext.sessionId,
                                                          )}`
                                                        : null,
                                            },
                                        ]),
                                        type: "success",
                                    } as IResult),
                            );
                        }
                        return {
                            data: ResultStream([
                                {
                                    ck_id: res.responseJson.queueId,
                                    cv_error: null,
                                    cv_url: `${
                                        this.params.prefixPath
                                    }${util.format(
                                        "/%s/%s",
                                        res.responseJson.queueId,
                                        gateContext.sessionId,
                                    )}`,
                                },
                            ]),
                            type: "success",
                        } as IResult;
                    }
                    gateContext.error(`UNKNOWN_MESSAGE ${res.buf.toString()}`);
                    throw new ErrorException(-1, "Error execute printServer");
                });
            } else if (json.service.cv_action.toLowerCase() === "d") {
                const reportDelete = url.parse(this.reportDelete, true);
                const postData = JSON.stringify({
                    queueId: json.data.ck_id,
                    session: gateContext.sessionId,
                    user: gateContext.session.userData.ck_id,
                });
                return this.executePrintServer(
                    gateContext,
                    reportDelete,
                    "POST",
                    postData,
                ).then(async (res) => {
                    if (res.responseJson.resultCode === "success") {
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
                    gateContext.error(`UNKNOWN_MESSAGE ${res.buf.toString()}`);
                    throw new ErrorException(-1, "Error execute printServer");
                });
            }
        }
        return;
    }

    /**
     * Проверка статуса если олайн
     * @param gateContext
     * @param cvResult
     */
    public checkOnline(gateContext, cvResult, timeout = 50) {
        const urlStatus = url.parse(this.reportStatus, true);
        urlStatus.query = {
            queueId: cvResult,
            session: gateContext.sessionId,
        };
        return this.executePrintServer(gateContext, urlStatus, "GET").then(
            (res) => {
                if (
                    res.responseJson.status === "new" ||
                    res.responseJson.status === "processing"
                ) {
                    return new Promise((resolve, reject) => {
                        delay(
                            (gateContextl, cvResultl, timeoutl) => {
                                this.checkOnline(
                                    gateContextl,
                                    cvResultl,
                                    timeoutl,
                                ).then(
                                    (value) => resolve(value),
                                    (err) => reject(err),
                                );
                            },
                            timeout,
                            gateContext,
                            cvResult,
                            timeout,
                        );
                    });
                }
                return Promise.resolve(res.responseJson.status);
            },
        );
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
        const callBackUrl = url.parse(this.params.callBackUrl, true);
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
            url: url.format(callBackUrl),
        };
        const postData = JSON.stringify({
            parameters: {
                export_excel: true,
                json: JSON.stringify(jsonRequest),
                jsonBC: gateContext.query.inParams.jsonbc,
            },
            reportFormat: "xlsx",
            reportId: this.params.exportUrl,
            reportName: json.excelname,
            session: gateContext.sessionId,
        });
        return this.executePrintServer(
            gateContext,
            url.parse(`${this.params.urlReceiver}/accept`, true),
            "POST",
            postData,
        ).then((res) => {
            if (res.responseJson.queueId) {
                return this.checkOnline(
                    gateContext,
                    res.responseJson.queueId,
                ).then((value) => {
                    const result = {
                        ck_id: res.responseJson.queueId,
                        cv_url_response: `${
                            this.params.prefixPath
                        }${util.format(
                            "/%s/%s",
                            res.responseJson.queueId,
                            gateContext.sessionId,
                        )}`,
                    };
                    return Promise.resolve({
                        data: ResultStream([
                            {
                                ...result,
                                cv_error:
                                    value === "success"
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
                });
            }
            gateContext.error(`UNKNOWN_MESSAGE ${res.buf.toString()}`);
            throw new Error("Error response print Server");
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
        urlPrint: url.UrlWithParsedQuery,
        method: string = "POST",
        postData?: string,
    ): Promise<any> {
        return new Promise((resolve, reject) => {
            const params: request.Options = {
                body: postData,
                headers: {
                    Accept: "application/json",
                    "Content-Type": "application/json",
                    ...(postData
                        ? {
                              "Content-Length": Buffer.byteLength(postData),
                          }
                        : {}),
                },
                method,
                timeout: this.params.timeout,
                url: url.format(urlPrint),
            };
            if (this.params.proxy) {
                params.proxy = this.params.proxy;
            }
            if (gateContext.isDebugEnabled()) {
                gateContext.debug(`Request params: ${JSON.stringify(params)}`);
            }
            request(params, (err, res, body) => {
                if (err) {
                    gateContext.error(err);
                    return reject(
                        new Error(
                            `Ошибка вызова ${urlPrint.hostname}\nError: ${err.message}`,
                        ),
                    );
                }
                if (gateContext.isDebugEnabled()) {
                    gateContext.debug(
                        `Response headers: ${JSON.stringify(
                            res.headers,
                        )}\nResponse Code: ${res.statusCode}\nbody:\n${body}`,
                    );
                }
                if (res.statusCode > 400) {
                    return reject(
                        new Error(
                            `Ошибка вызова ${urlPrint.hostname}\n` +
                                `Response Code: ${res.statusCode}\nBody: ${body}`,
                        ),
                    );
                }
                try {
                    const responseJson = JSON.parse(body);
                    if (isObject(responseJson)) {
                        return resolve({
                            body,
                            response: res,
                            responseJson,
                        });
                    }
                } catch (e) {
                    gateContext.error(`UNKNOWN_MESSAGE ${body}`);
                    return reject(new Error("Error response print Server"));
                }
            });
            return;
        });
    }
}
