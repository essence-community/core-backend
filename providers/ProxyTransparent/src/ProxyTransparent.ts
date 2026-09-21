import BreakException from "@ungate/plugininf/lib/errors/BreakException";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import {IParamsInfo} from "@ungate/plugininf/lib/ICCTParams";
import IContext, {IFormData} from "@ungate/plugininf/lib/IContext";
import {IGateQuery} from "@ungate/plugininf/lib/IQuery";
import {IResultProvider} from "@ungate/plugininf/lib/IResult";
import NullProvider from "@ungate/plugininf/lib/NullProvider";
import ResultStream from "@ungate/plugininf/lib/stream/ResultStream";
import {
    ReadStreamToArray,
    safeResponsePipe,
} from "@ungate/plugininf/lib/stream/Util";
import {hiddenSecret, isEmpty} from "@ungate/plugininf/lib/util/Util";
import * as fs from "fs";
import * as JSONStream from "JSONStream";
import {isArray, isBoolean} from "lodash";
import * as QueryString from "qs";
import * as axios from "axios";
import FormData from "form-data";
import * as url from "url";

const keysJson = ["total", "data", "metaData", "success"];

export default class ProxyTransparent extends NullProvider {
    public static getParamsInfo(): IParamsInfo {
        return {
            gateUrl: {
                name: "Ссылка на проксируемый шлюз",
                required: true,
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
        const headers = gateContext.request.headers;
        const contentType = headers["content-type"]?.toLowerCase() || "";
        delete headers["content-encoding"];
        delete headers["content-length"];
        delete headers["transfer-encoding"];
        /* tslint:disable:object-literal-sort-keys */
        const paramsQuery = {
            action: gateContext.actionName,
            session: gateContext.sessionId,
            provider: gateContext.providerName,
            query: gateContext.queryName,
            plugin: gateContext.pluginName.join(","),
            ...gateContext.params,
        };
        /* tslint:enable:object-literal-sort-keys */
        const urlGate = url.parse(this.params.gateUrl) as any;
        urlGate.query = QueryString.parse(
            (gateContext.request as any)._parsedUrl.query,
        );
        const params: axios.AxiosRequestConfig = {
            decompress: !!this.params.useGzip,
            headers,
            method: gateContext.request.method?.toUpperCase() as axios.Method || "GET",
            timeout: this.params.timeout
                ? parseInt(this.params.timeout, 10) * 1000
                : 660000,
            url: url.format(urlGate),
            responseType: "stream",
            validateStatus: () => true,
        };
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
            const proxyauth = proxy.auth ? proxy.auth.split(":") : [];
            params.proxy = this.params.proxy.startsWith("{")
                ? proxy
                : {
                    host: proxy.host,
                    port: parseInt(proxy.port, 10),
                    auth: proxy.auth
                        ? {username: proxyauth[0], password: proxyauth[1]}
                        : undefined,
                    protocol: proxy.protocol,
                };
        }
        if (params.method === "GET") {
            delete params.data;
        }
        if (gateContext.isDebugEnabled()) {
            gateContext.debug(
                `proxy request params: ${JSON.stringify(
                    hiddenSecret(params),
                ).substr(0, 4000)}`,
            );
        }
        return new Promise(async (resolve, reject) => {
            const stream = JSONStream.parse("data.*");
            stream.on("header", (data: any) => {
                if (isArray(data)) {
                    stream.emit(
                        "error",
                        new BreakException("success", ResultStream(data)),
                    );
                    return;
                }
                if (isBoolean(data.success) && data.success && data.metaData) {
                    gateContext.metaData = data.metaData;
                    return;
                }
                if (isBoolean(data.success) && !data.success && data.err_code) {
                    gateContext.warn(`Response: ${JSON.stringify(data)}`);
                    if (isEmpty(data.err_code)) {
                        stream.emit(
                            "error",
                            new ErrorException(
                                -1,
                                "Ошибка вызова внешнего сервиса",
                            ),
                        );
                        return;
                    }
                    stream.emit(
                        "error",
                        new ErrorException(data.err_code, data.err_text),
                    );
                    return;
                }
                const keys = Object.keys(data).filter(
                    (key) => !keysJson.includes(key),
                );
                if (keys.length) {
                    stream.emit(
                        "error",
                        new BreakException("success", ResultStream([data])),
                    );
                }
            });
            stream.on("footer", (data: any) => {
                if (data.metaData) {
                    gateContext.metaData = data.metaData;
                }
            });
            let res: axios.AxiosResponse;
            try {
                res = await axios.default.request(params);
            } catch (err) {
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
                return undefined;
            }
            const ctHeader = `${res.headers["content-type"] || "application/json"
                }`;
            const rheaders = {
                ...res.headers,
            };
            if (gateContext.isDebugEnabled()) {
                gateContext.debug(
                    `Response proxy headers: ${JSON.stringify(res.headers)}`,
                );
            }
            if (ctHeader.startsWith("application/json")) {
                res.data.on("error", (err: any) => {
                    if (err) {
                        gateContext.error(
                            `Error query ${gateContext.queryName}`,
                            err,
                        );
                        stream.emit(
                            "error",
                            new ErrorException(
                                -1,
                                "Ошибка вызова внешнего сервиса",
                            ),
                        );
                    }
                    return undefined;
                });
                res.data.pipe(stream);
                return ReadStreamToArray(stream as any).then((arr) =>
                    resolve({
                        stream: ResultStream(arr),
                    }),
                );
            }
            delete rheaders.date;
            delete rheaders.host;
            gateContext.response.writeHead(res.status, rheaders as any);
            res.data.on("end", () => reject(new BreakException("break")));
            res.data.on("error", (err: any) => {
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
            safeResponsePipe(res.data as any, gateContext.response);
            return undefined;
        });
    }
}
