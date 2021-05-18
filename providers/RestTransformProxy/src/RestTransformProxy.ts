import BreakException from "@ungate/plugininf/lib/errors/BreakException";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import IContext, { IFormData } from "@ungate/plugininf/lib/IContext";
import { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import { parse } from "@ungate/plugininf/lib/parser/parser";
import { IResultProvider } from "@ungate/plugininf/lib/IResult";
import NullProvider from "@ungate/plugininf/lib/NullProvider";
import ResultStream from "@ungate/plugininf/lib/stream/ResultStream";
import {
    ReadStreamToArray,
    safeResponsePipe,
} from "@ungate/plugininf/lib/stream/Util";
import * as JSONStream from "JSONStream";
import * as request from "request";
import * as url from "url";
import { isEmpty } from "@ungate/plugininf/lib/util/Util";

const optionsRequest = [
    "url",
    "baseUrl",
    "jar",
    "formData",
    "form",
    "auth",
    "oauth",
    "aws",
    "hawk",
    "qs",
    "qsStringifyOptions",
    "qsParseOptions",
    "json",
    "multipart",
    "agent",
    "agentOptions",
    "method",
    "body",
    "family",
    "followRedirect",
    "followAllRedirects",
    "followOriginalHttpMethod",
    "maxRedirects",
    "removeRefererHeader",
    "encoding",
    "timeout",
    "localAddress",
    "proxy",
    "tunnel",
    "strictSSL",
    "rejectUnauthorized",
    "time",
    "gzip",
    "preambleCRLF",
    "postambleCRLF",
    "withCredentials",
    "key",
    "cert",
    "passphrase",
    "ca",
    "har",
    "useQuerystring",
];

const validHeader = ["application/json", "application/xml", "text/"];

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
            ...NullProvider.getParamsInfo(),
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
        const params: request.OptionsWithUrl = {
            gzip: !!this.params.useGzip,
            method: gateContext.request.method.toUpperCase(),
            timeout: this.params.timeout
                ? parseInt(this.params.timeout, 10) * 1000
                : 660000,
            url: url.format(urlGate),
        };
        optionsRequest.forEach((key) => {
            if (Object.prototype.hasOwnProperty.call(config, key)) {
                params[key] = config[key];
            }
        });

        if (urlGate) {
            params.url = url.format(urlGate);
        }

        if (Object.keys(headers).length) {
            params.headers = headers;
        }

        if (this.params.proxy) {
            params.proxy = this.params.proxy;
        }
        if (this.log.isDebugEnabled()) {
            this.log.debug(
                `proxy request params: ${JSON.stringify(params).substr(
                    0,
                    4000,
                )}`,
            );
        }
        return new Promise((resolve, reject) => {
            const resp = request(params);

            resp.on("response", async (res) => {
                const ctHeader =
                    res.headers["content-type"] || "application/json";
                const rheaders = {
                    ...res.headers,
                };
                if (gateContext.isDebugEnabled()) {
                    gateContext.debug(
                        `Response proxy headers: ${JSON.stringify(
                            res.headers,
                        )}`,
                    );
                }
                if (validHeader.find((key) => ctHeader.startsWith(key))) {
                    let arr = [];
                    resp.on("error", (err) => {
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
                            res.on("data", (data) => {
                                json += data;
                            });
                            res.on("end", () => {
                                try {
                                    let parseData = ctHeader.startsWith(
                                        "application/json",
                                    )
                                        ? JSON.parse(json)
                                        : {
                                            response_data: json,
                                        };
                                    if (!Array.isArray(parseData)) {
                                        parseData = [parseData];
                                    }
                                    resolveArr(parseData);
                                } catch (e) {
                                    this.log.error(`Parse json error: \n ${json}`, e)
                                    reject(e);
                                }
                            });
                        });
                    } else if (ctHeader.startsWith("application/json")) {
                        const stream = JSONStream.parse(
                            config.resultPath || "*",
                        );

                        resp.pipe(stream);

                        arr = await ReadStreamToArray(stream as any);
                    }

                    let result = arr;

                    if (config.resultParse) {
                        const responseParam = {
                            ...param,
                            jt_response_header: res.headers,
                            jt_result: arr,
                        };
                        const parserResult = parse(config.resultParse);

                        result = parserResult.runer({
                            get: (key: string, isKeyEmpty: boolean) => {
                                return (
                                    responseParam[key] ||
                                    (isKeyEmpty ? "" : key)
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
                            jt_response_header: res.headers,
                            jt_result: result,
                        };
                        result = result.map((item) => {
                            const rowParam = {
                                ...responseParam,
                                jt_result_row: item,
                            };
                            return parserRowResult.runer({
                                get: (key: string, isKeyEmpty: boolean) => {
                                    return (
                                        rowParam[key] || (isKeyEmpty ? "" : key)
                                    );
                                },
                            });
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
                gateContext.response.writeHead(res.statusCode, rheaders);
                resp.on("end", () => reject(new BreakException("break")));
                resp.on("error", (err) => {
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
                safeResponsePipe(resp as any, gateContext.response);
            });
        });
    }
}
