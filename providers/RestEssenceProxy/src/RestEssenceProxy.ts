import BreakException from "@ungate/plugininf/lib/errors/BreakException";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import IContext, { IFormData } from "@ungate/plugininf/lib/IContext";
import { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import { IResultProvider } from "@ungate/plugininf/lib/IResult";
import NullProvider, {
    IParamsProvider,
} from "@ungate/plugininf/lib/NullProvider";
import { Agent as HttpsAgent, AgentOptions } from "https";
import { Agent as HttpAgent } from "http";
import ResultStream from "@ungate/plugininf/lib/stream/ResultStream";
import { safeResponsePipe } from "@ungate/plugininf/lib/stream/Util";
import * as axios from "axios";
import * as url from "url";
import { isEmpty } from "@ungate/plugininf/lib/util/Util";
import * as QueryString from "qs";
import * as fs from "fs";
import * as FormData from "form-data";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";

const validHeader = ["application/json", "application/xml", "text/"];
const defaultHeader = ["content-type", "cookie"];
export interface IRestEssenceProxyParams extends IParamsProvider {
    defaultGateUrl: string;
    proxy?: string;
    timeout: string;
    useGzip: boolean;
    includeHeaderIn?: string;
    excludeHeaderOut?: string;
    includeHeaderOut?: string;
    httpsAgent?: string;
}

export default class RestEssenceProxy extends NullProvider {
    public static getParamsInfo(): IParamsInfo {
        return {
            defaultGateUrl: {
                name: "Ссылка на проксируемый шлюз",
                type: "string",
                required: true,
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
            includeHeaderIn: {
                name: "Пропускаемые header при запросе, через запятую",
                type: "string",
            },
            excludeHeaderOut: {
                name: "Исключаем header из ответа, через запятую",
                type: "string",
            },
            includeHeaderOut: {
                name: "Пропускаемые header при запросе, через запятую",
                type: "string",
            },
            httpsAgent: {
                name: "Настройки https agent",
                type: "long_string",
            },
        };
    }

    public params: IRestEssenceProxyParams;

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
        const headers = gateContext.request.headers;
        const contentType = headers["content-type"].toLowerCase();
        const paramsQuery = {
            action: gateContext.actionName,
            session: gateContext.sessionId,
            ...gateContext.params,
        };
        const urlGate = url.parse(
            `${this.params.defaultGateUrl}/${
                query.queryStr || query.modifyMethod
            }`
                .replace("//", "/")
                .replace(":/", "://"),
            true,
        ) as any;
        urlGate.query = (gateContext.request as any)._parsedUrl.query
            ? QueryString.parse((gateContext.request as any)._parsedUrl.query)
            : {};
        urlGate.query.session = gateContext.sessionId;

        const params: axios.AxiosRequestConfig = {
            method: gateContext.request.method.toUpperCase() as axios.Method,
            timeout: this.params.timeout
                ? parseInt(this.params.timeout, 10) * 1000
                : 660000,
            url: url.format(urlGate),
            headers: {},
            responseType: "stream",
            validateStatus: () => true,
        };

        defaultHeader.forEach((item) => {
            if (headers[item]) {
                params.headers[item] = headers[item];
            }
        });

        if (this.params.includeHeaderIn) {
            this.params.includeHeaderIn.split(",").forEach((item) => {
                if (headers[item]) {
                    params.headers[item] = headers[item];
                }
            });
        }
        if (!isEmpty(gateContext.request.body)) {
            if (
                typeof gateContext.request.body === "object" &&
                (gateContext.request.body as IFormData).files &&
                contentType.startsWith("multipart/form-data")
            ) {
                const formData = new FormData();
                delete headers["content-type"];
                Object.keys(
                    (gateContext.request.body as IFormData).files,
                ).forEach((key) => {
                    if (
                        (gateContext.request.body as IFormData).files[key]
                            .length
                    ) {
                        (gateContext.request.body as IFormData).files[
                            key
                        ].forEach((item) => {
                            formData.append(
                                key,
                                fs.readFileSync(item.path, null),
                                {
                                    contentType: item.headers["content-type"],
                                    filename: item.originalFilename,
                                },
                            );
                        });
                    }
                });
                Object.keys(
                    (gateContext.request.body as IFormData).fields,
                ).forEach((key) => {
                    if (
                        (gateContext.request.body as IFormData).fields[key]
                            .length
                    ) {
                        (gateContext.request.body as IFormData).fields[
                            key
                        ].forEach((item) => {
                            formData.append(key, item);
                        });
                    }
                });
                params.data = formData;
                params.headers = {
                    ...params.headers,
                    ...formData.getHeaders(),
                };
            } else if (
                contentType.startsWith("application/x-www-form-urlencoded")
            ) {
                params.data = QueryString.stringify(paramsQuery);
            } else {
                params.data = gateContext.request.body as IFormData;
            }
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
                `Request: proxy params: ${JSON.stringify(params).substr(
                    0,
                    4000,
                )}`,
            );
        }

        return new Promise(async (resolve, reject) => {
            let response: axios.AxiosResponse<any> = null;
            try {
                response = await axios.default.request(params);
            } catch (err) {
                if (err && err.isAxiosError) {
                    gateContext.error(
                        `Error query ${gateContext.queryName}`,
                        err,
                    );
                    if (err.response?.status === 403) {
                        return reject(
                            new ErrorException(ErrorGate.REQUIRED_AUTH),
                        );
                    } else {
                        return reject(
                            new ErrorException(
                                -1,
                                JSON.stringify(err.toJSON()),
                            ),
                        );
                    }
                } else if (err) {
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
            }
            if (gateContext.isDebugEnabled()) {
                gateContext.debug(
                    "Response: Status: %s,  proxy headers:\n%j",
                    response.status,
                    response.headers,
                );
            }
            if (response?.status === 403) {
                return reject(new ErrorException(ErrorGate.REQUIRED_AUTH));
            }
            const ctHeader =
                response.headers["content-type"] || "application/json";
            const rheaders = {
                ...response.headers,
            };

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
            if (validHeader.find((key) => ctHeader.startsWith(key))) {
                let arr = [];
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
                            this.log.error(`Parse json error: \n ${json}`, e);
                            reject(e);
                        }
                    });
                });

                if (arr.length === 1 && arr[0].statusCode && arr[0].error) {
                    return reject(
                        new ErrorException(
                            -1,
                            `StatusCode: ${arr[0].statusCode}\nError:\n${arr[0].message}`,
                        ),
                    );
                }

                if (this.params.includeHeaderOut) {
                    this.params.includeHeaderOut.split(",").forEach((item) => {
                        if (rheaders[item]) {
                            gateContext.extraHeaders[item] = rheaders[
                                item
                            ] as any;
                        }
                    });
                }
                return resolve({
                    stream: ResultStream(arr),
                });
            }
            delete rheaders.date;
            delete rheaders.host;
            if (this.params.excludeHeaderOut) {
                this.params.excludeHeaderOut.split(",").forEach((item) => {
                    delete rheaders[item];
                });
            }
            gateContext.response.writeHead(response.status, rheaders);
            response.data.on("end", () => reject(new BreakException("break")));
            safeResponsePipe(response.data as any, gateContext.response);
            return undefined;
        });
    }
}
