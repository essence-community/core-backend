import BreakException from "@ungate/plugininf/lib/errors/BreakException";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import IContext, { IFormData } from "@ungate/plugininf/lib/IContext";
import { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import { parse } from "@ungate/plugininf/lib/parser/parserAsync";
import IResult, { IResultProvider } from "@ungate/plugininf/lib/IResult";
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
import { initParams, isEmpty } from "@ungate/plugininf/lib/util/Util";
import * as fs from "fs";
import * as path from "path";
import * as QueryString from "qs";
import * as FormData from "form-data";
import { IFile } from "@ungate/plugininf/lib/IContext";
import { BreakResult } from "./BreakResult";
import ICCTParams from "@ungate/plugininf/lib/ICCTParams";
import { IAuthController } from "@ungate/plugininf/lib/IAuthController";

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

export interface IRestEssenceProxyConfig
    extends Partial<axios.AxiosRequestConfig> {
    header?: Record<string, string | string[]>;
    includeHeader?: string[];
    url?: string;
    json?: Record<string, any> | string | string[] | Record<string, any>[];
    form?: Record<string, any> | string;
    formData?: Record<string, any>;
    resultPath?: string;
    resultParse?: string;
    resultRowParse?: string;
    breakResult?: string;
    breakTypeResult?: IResult["type"];
    includeHeaderOut?: string[];
    excludeHeaderOut?: string[];
    typeResult?: IResult["type"];
    proxyResult?: boolean;
}

interface IPairValue {
    key: string;
    value: string;
}

export interface IRestEssenceProxyParams extends IParamsProvider {
    defaultGateUrl: string;
    proxy?: string;
    timeout: string;
    useGzip: boolean;
    httpsAgent?: string;
    extraParam?: IPairValue[];
    extraParamEncrypt?: IPairValue[];
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
            extraParam: {
                type: "form_repeater",
                name: "Дополнительные настройки",
                childs: {
                    key: {
                        type: "string",
                        name: "Ключ",
                        required: true,
                    },
                    value: {
                        type: "string",
                        name: "Значание",
                        required: true,
                    },
                },
            },
            extraParamEncrypt: {
                type: "form_repeater",
                name: "Дополнительные настройки шифрованые",
                childs: {
                    key: {
                        type: "string",
                        name: "Ключ",
                        required: true,
                    },
                    value: {
                        type: "password",
                        name: "Значание",
                        required: true,
                    },
                },
            },
        };
    }
    private extraParam: Record<string, string> = {};
    public params: IRestEssenceProxyParams;

    constructor(
        name: string,
        params: ICCTParams,
        authController: IAuthController,
    ) {
        super(name, params, authController);
        this.params = initParams(RestTransformProxy.getParamsInfo(), params);
        if (this.params.extraParam) {
            this.params.extraParam.forEach(({ key, value }) => {
                this.extraParam[key] = value;
            });
        }
        if (this.params.extraParamEncrypt) {
            this.params.extraParamEncrypt.forEach(({ key, value }) => {
                this.extraParam[key] = value;
            });
        }
    }

    public processSql(
        context: IContext,
        query: IGateQuery,
    ): Promise<IResultProvider> {
        return this.prepareCallRequest(context, query);
    }
    public processDml(
        context: IContext,
        query: IGateQuery,
    ): Promise<IResultProvider> {
        return this.prepareCallRequest(context, query);
    }
    public async init(reload?: boolean): Promise<void> {
        return;
    }
    public async prepareCallRequest(
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
            jt_extra_params: this.extraParam,
        };
        let result = [];
        let type;
        try {
            const config = await parser.runer<IRestEssenceProxyConfig>({
                get: (key: string, isKeyEmpty: boolean) => {
                    if (key === "callRequest") {
                        return (
                            configRest: IRestEssenceProxyConfig,
                            name?: string,
                        ) =>
                            this.callRequest(
                                gateContext,
                                configRest,
                                param,
                                name,
                            );
                    }
                    return param[key] || (isKeyEmpty ? "" : key);
                },
            });

            type = config.typeResult;
            result = await this.callRequest(gateContext, config, param);
        } catch (err) {
            if (err instanceof BreakResult) {
                result = err.result;
                type = err.type;
            } else {
                throw err;
            }
        }

        if (!Array.isArray(result)) {
            result = [result];
        }

        if (result.length && typeof result[0] !== "object") {
            result = result.map((res) => ({ raw: res }));
        }

        return {
            stream: ResultStream(result),
            type,
        };
    }
    public async callRequest(
        gateContext: IContext,
        config: IRestEssenceProxyConfig,
        param: Record<string, any>,
        name?: string,
    ): Promise<any[]> {
        if (name && Object.prototype.hasOwnProperty.call(param, name)) {
            return param[name];
        }
        const headers = {
            ...(config.header || {}),
        };
        if (config.includeHeader) {
            config.includeHeader.forEach((item: string) => {
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
            validateStatus: () => true,
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
            params.data =
                typeof config.json === "string"
                    ? JSON.parse(config.json)
                    : config.json;
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
            params.headers = headers as any;
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
                `Request: proxy params:\n${JSON.stringify(params).substr(
                    0,
                    4000,
                )}`,
            );
        }
        return new Promise(async (resolve, reject) => {
            try {
                const response = await axios.default.request(params);
                const ctHeader =
                    response.headers["content-type"] || "application/json";
                const rheaders = {
                    ...response.headers,
                };
                if (gateContext.isDebugEnabled()) {
                    gateContext.debug(
                        "Response: Status: %s,  proxy headers:\n%j",
                        response.status,
                        response.headers,
                    );
                }
                let arr: any = [];
                let jtBody;

                if (config.proxyResult) {
                    delete rheaders.date;
                    delete rheaders.host;
                    if (config.excludeHeaderOut) {
                        config.excludeHeaderOut.forEach((item) => {
                            delete rheaders[item];
                        });
                    }
                    gateContext.response.writeHead(response.status, rheaders);
                    response.data.on("end", () =>
                        reject(new BreakException("break")),
                    );
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
                    return safeResponsePipe(
                        response.data as any,
                        gateContext.response,
                    );
                } else if (
                    validHeader.find((key) => ctHeader.startsWith(key))
                ) {
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
                                    const parseData = ctHeader.startsWith(
                                        "application/json",
                                    )
                                        ? isEmpty(json)
                                            ? []
                                            : JSON.parse(json)
                                        : {
                                              response_data: json,
                                          };
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
                        const stream = JSONStream.parse(
                            config.resultPath || "*",
                        );

                        response.data.pipe(stream);

                        arr = await ReadStreamToArray(stream as any);
                    }
                } else {
                    jtBody = await new Promise((resolveChild, rejectChild) => {
                        const bufs = [];
                        response.data.on("error", (err) => {
                            if (err) {
                                gateContext.error(
                                    `Error query ${gateContext.queryName}`,
                                    err,
                                );
                                return rejectChild(
                                    new ErrorException(
                                        -1,
                                        "Ошибка вызова внешнего сервиса",
                                    ),
                                );
                            }
                        });
                        response.data.on("data", (d) => {
                            bufs.push(d);
                        });
                        response.data.on("end", () => {
                            resolveChild(Buffer.concat(bufs));
                        });
                    });
                    arr = {
                        jt_body: jtBody,
                    };
                }
                let result = arr;

                if (config.breakResult) {
                    const responseParam = {
                        ...param,
                        jt_response_header: response.headers,
                        jt_response_status: response.status,
                        jt_result: result,
                        jt_body: jtBody,
                    };
                    const parserResult = parse(config.breakResult);

                    const res = await parserResult.runer({
                        get: (key: string, isKeyEmpty: boolean) => {
                            if (key === "callRequest") {
                                return (
                                    configRestChild: IRestEssenceProxyConfig,
                                    nameChild?: string,
                                ) =>
                                    this.callRequest(
                                        gateContext,
                                        configRestChild,
                                        param,
                                        nameChild,
                                    );
                            }
                            return (
                                responseParam[key] || (isKeyEmpty ? "" : key)
                            );
                        },
                    });
                    if (res) {
                        throw new BreakResult(res, config.breakTypeResult);
                    }
                }
                if (config.resultParse) {
                    const responseParam = {
                        ...param,
                        jt_response_header: response.headers,
                        jt_response_status: response.status,
                        jt_result: result,
                        jt_body: jtBody,
                    };
                    const parserResult = parse(config.resultParse);

                    result = await parserResult.runer({
                        get: (key: string, isKeyEmpty: boolean) => {
                            if (key === "callRequest") {
                                return (
                                    configRestChild: IRestEssenceProxyConfig,
                                    nameChild?: string,
                                ) =>
                                    this.callRequest(
                                        gateContext,
                                        configRestChild,
                                        param,
                                        nameChild,
                                    );
                            }
                            return (
                                responseParam[key] || (isKeyEmpty ? "" : key)
                            );
                        },
                    });
                }
                if (config.resultRowParse && Array.isArray(result)) {
                    const parserRowResult = parse(config.resultRowParse);
                    const responseParam = {
                        ...param,
                        jt_response_header: response.headers,
                        jt_response_status: response.status,
                        jt_result: result,
                        jt_body: jtBody,
                    };
                    result = await Promise.all(
                        result.map((item, index) => {
                            const rowParam = {
                                ...responseParam,
                                jt_result_row: item,
                                jt_result_row_index: index,
                                jt_body: jtBody,
                            };
                            return parserRowResult.runer({
                                get: (key: string, isKeyEmpty: boolean) => {
                                    if (key === "callRequest") {
                                        return (
                                            configRestChild: IRestEssenceProxyConfig,
                                            nameChild?: string,
                                        ) =>
                                            this.callRequest(
                                                gateContext,
                                                configRestChild,
                                                param,
                                                nameChild,
                                            );
                                    }
                                    return (
                                        rowParam[key] || (isKeyEmpty ? "" : key)
                                    );
                                },
                            });
                        }),
                    );
                }
                if (config.includeHeaderOut) {
                    config.includeHeaderOut.forEach((item) => {
                        gateContext.extraHeaders[item] = rheaders[item] as any;
                    });
                }
                if (name) {
                    param[name] = result;
                }
                return resolve(result);
            } catch (err) {
                reject(err);
            }
        });
    }
}
