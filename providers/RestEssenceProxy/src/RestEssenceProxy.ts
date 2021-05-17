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
import * as QueryString from "query-string";
import * as fs from 'fs';

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
        const headers = gateContext.request.headers;
        const contentType = headers["content-type"].toLowerCase();
        const paramsQuery = {
            action: gateContext.actionName,
            session: gateContext.sessionId,
            provider: gateContext.providerName,
            query: gateContext.queryName,
            plugin: gateContext.pluginName.join(","),
            ...gateContext.params,
        };
        const urlGate = url.parse(`${this.params.gateUrl}/${query.queryStr || query.modifyMethod}`.replace("//","/").replace(":/","://"), true) as any;
        urlGate.query = QueryString.parse(
            (gateContext.request as any)._parsedUrl.query,
        );

        const params: request.OptionsWithUrl = {
            gzip: !!this.params.useGzip,
            method: gateContext.request.method.toUpperCase(),
            timeout: this.params.timeout
                ? parseInt(this.params.timeout, 10) * 1000
                : 660000,
            url: url.format(urlGate),
        };
        if (urlGate) {
            params.url = url.format(urlGate);
        }
        if (this.params.includeHeaderIn) {
            this.params.includeHeaderIn.split(',').forEach((item) => {
                params.headers[item] = headers[item];
            });
        }
        if (!isEmpty(gateContext.request.body)) {
            if (
                typeof gateContext.request.body === "object" &&
                (gateContext.request.body as IFormData).files &&
                contentType.startsWith("multipart/form-data")
            ) {
                const formData = {};
                delete headers["content-type"];
                Object.keys(
                    (gateContext.request.body as IFormData).files,
                ).forEach((key) => {
                    if (
                        (gateContext.request.body as IFormData).files[key]
                            .length
                    ) {
                        formData[key] = [];
                        (gateContext.request.body as IFormData).files[
                            key
                        ].forEach((item) => {
                            formData[key].push({
                                options: {
                                    contentType: item.headers["content-type"],
                                    filename: item.originalFilename,
                                },
                                value: fs.readFileSync(item.path, null),
                            });
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
                        formData[key] = [];
                        (gateContext.request.body as IFormData).fields[
                            key
                        ].forEach((item) => {
                            formData[key].push(item);
                        });
                    }
                });
                params.formData = formData;
            } else if (
                contentType.startsWith("application/x-www-form-urlencoded")
            ) {
                params.body = QueryString.stringify(paramsQuery);
            } else {
                params.body = gateContext.request.body as IFormData;
            }
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
                    arr = await new Promise<any[]>((resolveArr) => {
                        let json = "";
                        res.on("data", (data) => {
                            json += data;
                        });
                        res.on("end", () => {
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
                        });
                    });

                    let result = arr;

                    return resolve({
                        stream: ResultStream(result),
                    });
                }
                delete rheaders.date;
                delete rheaders.host;
                if (this.params.excludeHeaderOut) {
                    this.params.excludeHeaderOut.split(',').forEach((item) => {
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
                return undefined;
            });
        });
    }
}
