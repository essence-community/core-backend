import * as JSONStream from "JSONStream";
import { isBoolean } from "lodash";
import * as QueryString from "querystring";
import * as request from "request";
import * as url from "url";
import { isObject, isString } from "util";
import ErrorException from "../errors/ErrorException";
import ICCTParams, { IParamsInfo } from "../ICCTParams";
import IContext from "../IContext";
import IObjectParam from "../IObjectParam";
import { IResultProvider } from "../IResult";
import { isEmpty } from "../util/Util";

export default class JsonGateCaller {
    public static getParamsInfo(): IParamsInfo {
        return {
            jsonGateUrl: {
                name: "Путь до jsongate шины",
                required: true,
                type: "string",
            },
            proxy: {
                name: "Прокси сервер",
                type: "string",
            },
            timeout: {
                defaultValue: 660,
                name: "Максимальное время выполнения запроса в секундах",
                type: "integer",
            },
            useGzip: {
                defaultValue: false,
                name: "Использовать компрессию",
                type: "boolean",
            },
        };
    }
    private params: ICCTParams;
    private jsonGateUrl: string;
    constructor(params: ICCTParams) {
        this.params = params;
        this.jsonGateUrl = params.jsonGateUrl;
    }
    public async callGet(
        context: IContext,
        action: "auth" | "sql" | "dml" | "plug" | "file" | "upload",
        queryName: string,
        inParams: IObjectParam = {},
        outParams: IObjectParam = {},
    ): Promise<IResultProvider> {
        const qs = {
            action,
            query: queryName,
            ...QueryString.parse(
                QueryString.stringify({
                    ...inParams,
                    ...Object.entries(outParams).reduce((obj, arr) => {
                        obj[`out_${arr[0]}`] = "";
                        return obj;
                    }, {}),
                }),
            ),
        };
        return this.request(context, "GET", qs);
    }
    public async callPost(
        context: IContext,
        action: "auth" | "sql" | "dml" | "plug" | "file" | "upload",
        queryName: string,
        inParams: IObjectParam = {},
        outParams: IObjectParam = {},
    ): Promise<IResultProvider> {
        const qs = {
            action,
            query: queryName,
        };
        const body = QueryString.stringify({
            ...inParams,
            ...Object.entries(outParams).reduce((obj, arr) => {
                obj[`out_${arr[0]}`] = "";
                return obj;
            }, {}),
        });
        return this.request(context, "POST", qs, null, body);
    }
    private request(
        context: IContext,
        method: "GET" | "POST",
        qs: QueryString.ParsedUrlQuery,
        headers: IObjectParam = {
            "content-type": "application/x-www-form-urlencoded",
        },
        body?: any,
    ): Promise<IResultProvider> {
        const urlGate = url.parse(this.jsonGateUrl, true) as url.Url;
        urlGate.query = qs;
        const params = {
            gzip: !!this.params.useGzip,
            headers,
            method,
            timeout: this.params.timeout ? this.params.timeout * 1000 : 660000,
            url: url.format(urlGate),
        } as request.Options;
        if (isString(body) && !isEmpty(body)) {
            params.body = body;
        }
        if (isObject(body)) {
            params.formData = body;
        }
        if (this.params.proxy) {
            params.proxy = this.params.proxy;
        }
        if (context.isDebugEnabled()) {
            context.debug(`Params caller: ${JSON.stringify(params)}`);
        }

        return new Promise((resolve) => {
            const result = {
                metaData: {},
                stream: JSONStream.parse("data.*"),
            };
            const resp = request(params);
            resp.on("error", (err) => {
                if (err) {
                    context.error(`Error query ${context.queryName}`, err);
                    result.stream.emit(
                        "error",
                        new ErrorException(
                            -1,
                            "Ошибка вызова внешнего сервиса",
                        ),
                    );
                }
                return undefined;
            });

            result.stream.on("header", (data) => {
                if (isBoolean(data.success) && data.success && data.metaData) {
                    result.metaData = data.metaData;
                    return;
                }
                if (isBoolean(data.success) && !data.success && data.err_code) {
                    context.warn(`Response: ${JSON.stringify(data)}`);
                    if (isEmpty(data.err_code)) {
                        result.stream.emit(
                            "error",
                            new ErrorException(
                                -1,
                                "Ошибка вызова внешнего сервиса",
                            ),
                        );
                        return;
                    }
                    result.stream.emit(
                        "error",
                        new ErrorException(data.err_code, data.err_text),
                    );
                    return;
                }
            });
            result.stream.on("footer", (data) => {
                if (data.metaData) {
                    result.metaData = data.metaData;
                }
            });

            resp.on("response", (res) => {
                const ctHeader =
                    res.headers["content-type"] || "application/json";
                if (context.isDebugEnabled()) {
                    context.debug(
                        `Response proxy headers: ${JSON.stringify(
                            res.headers,
                        )}`,
                    );
                }
                if (!ctHeader.startsWith("application/json")) {
                    result.stream.emit(
                        "error",
                        new ErrorException(
                            -1,
                            "Ошибка вызова внешнего сервиса",
                        ),
                    );
                }
            }).pipe(result.stream);
            return resolve(result as any);
        });
    }
}
