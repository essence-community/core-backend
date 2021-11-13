import BreakException from "@ungate/plugininf/lib/errors/BreakException";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import IContext, { IFormData } from "@ungate/plugininf/lib/IContext";
import { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import { IResultProvider } from "@ungate/plugininf/lib/IResult";
import NullProvider from "@ungate/plugininf/lib/NullProvider";
import ResultStream from "@ungate/plugininf/lib/stream/ResultStream";
import {
    ReadStreamToArray,
    safeResponsePipe,
} from "@ungate/plugininf/lib/stream/Util";
import { isEmpty } from "@ungate/plugininf/lib/util/Util";
import * as fs from "fs";
import * as JSONStream from "JSONStream";
import { isArray, isBoolean } from "lodash";
import * as QueryString from "qs";
import * as request from "request";
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
        const contentType = headers["content-type"].toLowerCase();
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
        const params: request.Options = {
            gzip: !!this.params.useGzip,
            headers,
            method: gateContext.request.method.toUpperCase(),
            timeout: this.params.timeout
                ? parseInt(this.params.timeout, 10) * 1000
                : 660000,
            url: url.format(urlGate),
        };
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
        if (gateContext.isDebugEnabled()) {
            gateContext.debug(
                `proxy request params: ${JSON.stringify(params).substr(
                    0,
                    4000,
                )}`,
            );
        }
        return new Promise((resolve, reject) => {
            const resp = request(params);
            const stream = JSONStream.parse("data.*");
            stream.on("header", (data) => {
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
            stream.on("footer", (data) => {
                if (data.metaData) {
                    gateContext.metaData = data.metaData;
                }
            });
            resp.on("response", (res) => {
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
                if (ctHeader.startsWith("application/json")) {
                    resp.on("error", (err) => {
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
                    resp.pipe(stream);
                    return ReadStreamToArray(stream as any).then((arr) =>
                        resolve({
                            stream: ResultStream(arr),
                        }),
                    );
                }
                delete rheaders.date;
                delete rheaders.host;
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
