import BreakException from "@ungate/plugininf/lib/errors/BreakException";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import IContext, { IFormData } from "@ungate/plugininf/lib/IContext";
import { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import { parse } from "@ungate/plugininf/lib/parser/parser";
import { IResultProvider } from "@ungate/plugininf/lib/IResult";
import NullProvider, {
    IParamsProvider,
} from "@ungate/plugininf/lib/NullProvider";
import ResultStream from "@ungate/plugininf/lib/stream/ResultStream";
import {
    ReadStreamToArray,
    safeResponsePipe,
} from "@ungate/plugininf/lib/stream/Util";
import { Agent as HttpsAgent, AgentOptions } from "https";
import { Agent as HttpAgent } from "http";
import * as JSONStream from "JSONStream";
import * as axios from "axios";
import * as url from "url";
import { isEmpty } from "@ungate/plugininf/lib/util/Util";
import * as fs from "fs";
import * as path from "path";
import * as QueryString from "query-string";
import * as FormData from "form-data";
import { IFile } from "@ungate/plugininf/lib/IContext";

const optionsRequest = [
    "url",
    "method",
    "baseURL",
    "headers",
    "params",
    "data",
    "timeout",
    "timeoutErrorMessage",
    "withCredentials",
    "adapter",
    "auth",
    "xsrfCookieName",
    "xsrfHeaderName",
    "maxContentLength",
    "maxRedirects",
    "httpAgent",
    "httpsAgent",
    "proxy",
];

const validHeader = ["application/json", "application/xml", "text/"];
export interface IRestEssenceProxyParams extends IParamsProvider {
    defaultGateUrl: string;
    proxy?: string;
    timeout: string;
    useGzip: boolean;
    httpsAgent?: string;
}
export default class RestTransformProxy extends NullProvider {
    public static getParamsInfo(): IParamsInfo {
        return {
            defaultGateUrl: {
                name: "Ссылка на проксируемый шлюз",
                type: "string",
            },
            proxy: {
                name: "Прокси сервер",
                type: "string",
            },
            timeout: {
                defaultValue: 660,
                name: "Время ожидания внешнего сервиса в секундах",
                type: "integer",
            },
            useGzip: {
                defaultValue: false,
                name: "Использовать компрессию",
                type: "boolean",
            },
            httpsAgent: {
                name: "Настройки https agent",
                type: "long_string",
            },
        };
    }

    public processSql(
        context: IContext,
        query: IGateQuery,
    ): Promise<IResultProvider> {
        return this.callRequest(context, query);
    }
    public processDml(
        context: IContext,
        query: IGateQuery,
    ): Promise<IResultProvider> {
        return this.callRequest(context, query);
    }
    public async init(reload?: boolean): Promise<void> {
        return;
    }

    public async callRequest(
        gateContext: IContext,
        query: IGateQuery,
    ): Promise<IResultProvider> {
        if (isEmpty(query.queryStr) && isEmpty(query.modifyMethod)) {
            throw new ErrorException(101, "Empty query string");
        }
        const parser = parse(query.queryStr || query.modifyMethod);
        const param = {
            jt_in_param:
                typeof gateContext.request.body === "object" &&
                (gateContext.request.body as IFormData).files
                    ? {
                          ...query.inParams,
                          ...(gateContext.request.body as IFormData).files,
                      }
                    : query.inParams,
            jt_request_header: gateContext.request.headers,
            jt_request_method: gateContext.request.method,
            jt_provider_params: this.params,
        };

        const config = parser.runer({
            get: (key: string, isKeyEmpty: boolean) => {
                return param[key] || (isKeyEmpty ? "" : key);
            },
        }) as any;
        const headers = {
            ...(config.header || {}),
        };
        if (config.includeHeader) {
            config.includeHeader.forEach((item) => {
                headers[item] = gateContext.request.headers[item];
            });
        }
        if (isEmpty(config.url || this.params.defaultGateUrl)) {
            throw new ErrorException(101, "Not found required parameters url");
        }
        /* tslint:enable:object-literal-sort-keys */
        const urlGate = url.parse(
            config.url || this.params.defaultGateUrl,
            true,
        ) as any;
        const params: axios.AxiosRequestConfig = {
            method: gateContext.request.method.toUpperCase() as axios.Method,
            timeout: this.params.timeout
                ? parseInt(this.params.timeout, 10) * 1000
                : 660000,
            headers: {},
            responseType: "stream",
        };
        optionsRequest.forEach((key) => {
            if (Object.prototype.hasOwnProperty.call(config, key)) {
                params[key] = config[key];
            }
        });

        if (urlGate) {
            params.url = url.format(urlGate);
        }

        if (config.json) {
            params.data = JSON.stringify(config.json);
            params.headers["content-type"] = "application/json";
        }

        if (config.form) {
            params.data =
                typeof config.form === "string"
                    ? config.form
                    : QueryString.stringify(config.form);
            params.headers["content-type"] =
                "application/x-www-form-urlencoded";
        }

        if (config.formData) {
            const formData = new FormData();
            Object.entries(config.formData).forEach(([key, value]) => {
                if (
                    (Array.isArray(value) &&
                        typeof value[0] === "object" &&
                        (value[0] as IFile).path) ||
                    (typeof value === "object" && (value as IFile).path)
                ) {
                    (Array.isArray(value) ? value : [value]).forEach(
                        (val: IFile) => {
                            formData.append(
                                key,
                                fs.readFileSync(val.path, null),
                                {
                                    contentType: val.headers["content-type"],
                                    filename: val.originalFilename,
                                },
                            );
                        },
                    );
                    return;
                }
                if (typeof value === "string" && fs.existsSync(value)) {
                    formData.append(key, fs.readFileSync(value, null), {
                        contentType: "application/octet-stream",
                        filename: path.basename(value),
                    });
                    return;
                }
                formData.append(key, value);
            });
            params.data = formData;
            params.headers = {
                ...params.headers,
                ...formData.getHeaders(),
            };
        }

        if (Object.keys(headers).length) {
            params.headers = headers;
        }

        if (this.params.proxy) {
            const proxy = this.params.proxy.startsWith("{")
                ? JSON.parse(this.params.proxy)
                : url.parse(this.params.proxy, true);
            const proxyauth = proxy.auth.split(":");
            params.proxy = this.params.proxy.startsWith("{")
                ? proxy
                : {
                      host: proxy.host,
                      port: parseInt(proxy.port, 10),
                      auth: proxy.auth
                          ? { username: proxyauth[0], password: proxyauth[1] }
                          : undefined,
                      protocol: proxy.protocol,
                  };
        }

        if (typeof params.proxy === "string") {
            const proxy = (params.proxy as string).startsWith("{")
                ? JSON.parse(this.params.proxy)
                : url.parse(params.proxy, true);
            const proxyauth = proxy.auth.split(":");
            params.proxy = (params.proxy as string).startsWith("{")
                ? proxy
                : {
                      host: proxy.host,
                      port: parseInt(proxy.port, 10),
                      auth: proxy.auth
                          ? { username: proxyauth[0], password: proxyauth[1] }
                          : undefined,
                      protocol: proxy.protocol,
                  };
        }
        if (this.params.httpsAgent) {
            params.httpsAgent = JSON.parse(this.params.httpsAgent);
        }
        if (params.httpsAgent) {
            const httpsAgent: AgentOptions = (params.httpsAgent as string).startsWith(
                "{",
            )
                ? JSON.parse(params.httpsAgent as string)
                : params.httpsAgent;
            if (
                typeof httpsAgent.key === "string" &&
                httpsAgent.key.indexOf("/") > -1 &&
                fs.existsSync(httpsAgent.key)
            ) {
                httpsAgent.key = fs.readFileSync(httpsAgent.key);
            }
            if (
                typeof httpsAgent.ca === "string" &&
                httpsAgent.ca.indexOf("/") > -1 &&
                fs.existsSync(httpsAgent.ca)
            ) {
                httpsAgent.ca = fs.readFileSync(httpsAgent.ca);
            }
            if (
                typeof httpsAgent.cert === "string" &&
                httpsAgent.cert.indexOf("/") > -1 &&
                fs.existsSync(httpsAgent.cert)
            ) {
                httpsAgent.cert = fs.readFileSync(httpsAgent.cert);
            }
            if (
                typeof httpsAgent.crl === "string" &&
                httpsAgent.crl.indexOf("/") > -1 &&
                fs.existsSync(httpsAgent.crl)
            ) {
                httpsAgent.crl = fs.readFileSync(httpsAgent.crl);
            }
            if (
                typeof httpsAgent.dhparam === "string" &&
                httpsAgent.dhparam.indexOf("/") > -1 &&
                fs.existsSync(httpsAgent.dhparam)
            ) {
                httpsAgent.dhparam = fs.readFileSync(httpsAgent.dhparam);
            }
            if (
                typeof httpsAgent.pfx === "string" &&
                httpsAgent.pfx.indexOf("/") > -1 &&
                fs.existsSync(httpsAgent.pfx)
            ) {
                httpsAgent.pfx = fs.readFileSync(httpsAgent.pfx);
            }

            params.httpsAgent = new HttpsAgent(httpsAgent);
        }

        if (params.httpAgent) {
            const httpAgent = (params.httpAgent as string).startsWith("{")
                ? JSON.parse(params.httpAgent as string)
                : params.httpAgent;

            params.httpAgent = new HttpAgent(httpAgent);
        }
        if (this.log.isDebugEnabled()) {
            this.log.debug(
                `proxy request params: ${JSON.stringify(params).substr(
                    0,
                    4000,
                )}`,
            );
        }
        return new Promise(async (resolve, reject) => {
            const response = await axios.default.request(params);
            const ctHeader =
                response.headers["content-type"] || "application/json";
            const rheaders = {
                ...response.headers,
            };
            if (gateContext.isDebugEnabled()) {
                gateContext.debug(
                    `Response proxy headers: ${JSON.stringify(
                        response.headers,
                    )}`,
                );
            }
            if (validHeader.find((key) => ctHeader.startsWith(key))) {
                let arr = [];
                response.data.on("error", (err) => {
                    if (err) {
                        gateContext.error(
                            `Error query ${gateContext.queryName}`,
                            err,
                        );
                        reject(
                            new ErrorException(
                                -1,
                                "Ошибка вызова внешнего сервиса",
                            ),
                        );
                    }
                    return undefined;
                });
                if (
                    isEmpty(config.resultPath) ||
                    config.resultPath === "" ||
                    !ctHeader.startsWith("application/json")
                ) {
                    arr = await new Promise<any[]>((resolveArr) => {
                        let json = "";
                        response.data.on("data", (data) => {
                            json += data;
                        });
                        response.data.on("end", () => {
                            try {
                                let parseData = ctHeader.startsWith(
                                    "application/json",
                                )
                                    ? isEmpty(json)
                                        ? []
                                        : JSON.parse(json)
                                    : {
                                          response_data: json,
                                      };
                                if (!Array.isArray(parseData)) {
                                    parseData = [parseData];
                                }
                                resolveArr(parseData);
                            } catch (e) {
                                this.log.error(
                                    `Parse json error: \n ${json}`,
                                    e,
                                );
                                reject(e);
                            }
                        });
                    });
                } else if (ctHeader.startsWith("application/json")) {
                    const stream = JSONStream.parse(config.resultPath || "*");

                    response.data.pipe(stream);

                    arr = await ReadStreamToArray(stream as any);
                }

                let result = arr;

                if (config.resultParse) {
                    const responseParam = {
                        ...param,
                        jt_response_header: response.headers,
                        jt_result: arr,
                    };
                    const parserResult = parse(config.resultParse);

                    result = parserResult.runer({
                        get: (key: string, isKeyEmpty: boolean) => {
                            return (
                                responseParam[key] || (isKeyEmpty ? "" : key)
                            );
                        },
                    }) as any;
                    if (!Array.isArray(result)) {
                        result = [result];
                    }
                }
                if (config.resultRowParse && Array.isArray(result)) {
                    const parserRowResult = parse(config.resultRowParse);
                    const responseParam = {
                        ...param,
                        jt_response_header: response.headers,
                        jt_result: result,
                    };
                    result = result.map((item) => {
                        const rowParam = {
                            ...responseParam,
                            jt_result_row: item,
                        };
                        return parserRowResult.runer({
                            get: (key: string, isKeyEmpty: boolean) => {
                                return rowParam[key] || (isKeyEmpty ? "" : key);
                            },
                        });
                    });
                }
                if (config.includeHeaderOut) {
                    config.includeHeaderOut.split(",").forEach((item) => {
                        gateContext.extraHeaders[item] = rheaders[item] as any;
                    });
                }
                return resolve({
                    stream: ResultStream(result),
                });
            }
            delete rheaders.date;
            delete rheaders.host;
            if (config.excludeHeader) {
                config.excludeHeader.forEach((item) => {
                    delete rheaders[item];
                });
            }
            gateContext.response.writeHead(response.status, rheaders);
            response.data.on("end", () => reject(new BreakException("break")));
            response.data.on("error", (err) => {
                if (err) {
                    gateContext.error(
                        `Error query ${gateContext.queryName}`,
                        err,
                    );
                    return reject(
                        new ErrorException(
                            -1,
                            "Ошибка вызова внешнего сервиса",
                        ),
                    );
                }
            });
            safeResponsePipe(response.data as any, gateContext.response);
        });
    }
}
