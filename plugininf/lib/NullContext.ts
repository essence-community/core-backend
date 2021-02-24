/* tslint:disable:object-literal-sort-keys */
import { isString } from "lodash";
import { IRufusLogger } from "rufus";
import ErrorGate from "./errors/ErrorGate";
import ICCTParams, { IParamsInfo } from "./ICCTParams";
import IContext from "./IContext";
import IContextPlugin, { IContextPluginResult } from "./IContextPlugin";
import { IContextParams } from "./IContextPlugin";
import { IGateQuery } from "./IQuery";
import IResult from "./IResult";
import Logger from "./Logger";
import ResultStream from "./stream/ResultStream";
import { initParams } from "./util/Util";

const findRegEx = new RegExp("^/(?<reg>[\x5cs\x5cS]*)/(?<key>[gimy]*)$");

export default abstract class NullContext implements IContextPlugin {
    public static getParamsInfo(): IParamsInfo {
        return {
            attachmentType: {
                defaultValue: "attachment",
                name: "Mimetype file download",
                type: "string",
            },
            enableCors: {
                defaultValue: true,
                name: "Включаем защиту Cors",
                setGlobal: [{ out: "g_context_cors" }],
                type: "boolean",
            },
            cors: {
                childs: {
                    origin: {
                        name: "Access-Control-Allow-Origin",
                        description:
                            "Configures the Access-Control-Allow-Origin CORS header. Possible values:" +
                            "<br/>Boolean - set origin to true to reflect the request origin, as defined by req.header('Origin'), or set it to false to disable CORS." +
                            '<br/>String - set origin to a specific origin. For example if you set it to "http://example.com" only requests from "http://example.com" will be allowed.' +
                            '<br/>RegExp - set origin to a regular expression pattern which will be used to test the request origin. If it\'s a match, the request origin will be reflected. For example the pattern /example.com$/ will reflect any request that is coming from an origin ending with "example.com".' +
                            '<br/>Array - set origin to an array of valid origins. Each origin can be a String or a RegExp. For example ["http://example1.com", /.example2.com$/] will accept any request from "http://example1.com" or from a subdomain of "example2.com".',
                        type: "string",
                        defaultValue: "*",
                    },
                    methods: {
                        name: "Access-Control-Allow-Methods",
                        description:
                            "Configures the Access-Control-Allow-Methods CORS header. <br/>Expects a comma-delimited string (ex: 'GET,PUT,POST') or an array (ex: ['GET', 'PUT', 'POST']).",
                        type: "string",
                        defaultValue: "GET,PUT,POST,DELETE",
                    },
                    allowedHeaders: {
                        name: "Access-Control-Allow-Headers",
                        description:
                            "Configures the Access-Control-Allow-Headers CORS header. <br/>Expects a comma-delimited string (ex: 'Content-Type,Authorization') or an array (ex: ['Content-Type', 'Authorization']). <br/>If not specified, defaults to reflecting the headers specified in the request's Access-Control-Request-Headers header.",
                        type: "string",
                    },
                    exposedHeaders: {
                        name: "Access-Control-Expose-Headers",
                        description:
                            "Configures the Access-Control-Expose-Headers CORS header. <br/>Expects a comma-delimited string (ex: 'Content-Range,X-Content-Range') or an array (ex: ['Content-Range', 'X-Content-Range']). <br/>If not specified, no custom headers are exposed.",
                        type: "string",
                    },
                    credentials: {
                        name: "Access-Control-Allow-Credentials",
                        description:
                            "Configures the Access-Control-Allow-Credentials CORS header. <br/>Set to true to pass the header, otherwise it is omitted.",
                        type: "boolean",
                    },
                    maxAge: {
                        name: "Access-Control-Max-Age",
                        description:
                            "Configures the Access-Control-Max-Age CORS header. <br/>Set to an integer to pass the header, otherwise it is omitted.",
                        type: "integer",
                    },
                    preflightContinue: {
                        name:
                            "Pass the CORS preflight response to the next handler",
                        description:
                            "Pass the CORS preflight response to the next handler.",
                        type: "boolean",
                        defaultValue: false,
                    },
                    optionsSuccessStatus: {
                        defaultValue: 200,
                        name: "Success Status",
                        description:
                            "Provides a status code to use for successful OPTIONS requests, since some legacy browsers (IE11, various SmartTVs) choke on 204.",
                        type: "integer",
                    },
                },
                defaultValue: {
                    origin: "*",
                    methods: "GET,PUT,POST,DELETE",
                    preflightContinue: false,
                    optionsSuccessStatus: 200,
                },
                hidden: true,
                hiddenRules: "!g_context_cors",
                name: "cors params",
                type: "form_nested",
            },
            maxFileSize: {
                defaultValue: 10485760,
                name: "Размер файла в байтах",
                type: "integer",
            },
            maxLogParamLen: {
                defaultValue: 2048,
                name: "Максимальная длина лога",
                type: "integer",
            },
            maxPostSize: {
                defaultValue: 10485760,
                name: "Размер POST в байтах",
                type: "integer",
            },

            lvl_logger: {
                displayField: "ck_id",
                name: "Level logger",
                records: [
                    {
                        ck_id: "NOTSET",
                    },
                    { ck_id: "VERBOSE" },
                    { ck_id: "DEBUG" },
                    { ck_id: "INFO" },
                    { ck_id: "WARNING" },
                    { ck_id: "ERROR" },
                    { ck_id: "CRITICAL" },
                    { ck_id: "WARN" },
                    { ck_id: "TRACE" },
                    { ck_id: "FATAL" },
                ],
                type: "combo",
                valueField: [{ in: "ck_id" }],
            },
        };
    }
    public name: string;
    public params: IContextParams;
    public logger: IRufusLogger;
    public get maxPostSize(): number {
        return this.params.maxPostSize || 10485760;
    }
    public get maxFileSize(): number {
        return this.params.maxFileSize || 10485760;
    }
    public get maxLogParamLen(): number {
        return this.params.maxLogParamLen || 2048;
    }
    public get attachmentType(): string {
        return this.params.attachmentType || "attachment";
    }
    constructor(name: string, params: ICCTParams) {
        this.name = name;
        this.params = initParams(NullContext.getParamsInfo(), params);
        this.logger = Logger.getLogger(`Context ${name}`);
        if (this.params.enableCors) {
            if (this.params.cors) {
                if (isString(this.params.cors.origin)) {
                    const matcher = findRegEx.exec(
                        this.params.cors.origin as string,
                    );
                    if (matcher) {
                        const groups = matcher.groups;
                        this.params.cors.origin = new RegExp(
                            groups.reg,
                            groups.key,
                        );
                    } else if ((this.params.cors.origin as string).startsWith("[")) {
                        this.params.cors.origin = JSON.parse(
                            this.params.cors.origin as string,
                        );
                        this.params.cors.origin = (this.params.cors
                            .origin as string[]).map((val) => {
                            const matcher2 = findRegEx.exec(val);
                            if (matcher2) {
                                const groups = matcher2.groups;
                                return new RegExp(groups.reg, groups.key);
                            }
                            return val;
                        });
                    } else  if (this.params.cors.origin === "true") {
                        this.params.cors.origin = true;
                    }
                }
                if (this.params.cors.methods) {
                    if ((this.params.cors.methods as string).startsWith("[")) {
                        this.params.cors.methods = JSON.parse(
                            this.params.cors.methods as string,
                        );
                    }
                }
                if (this.params.cors.allowedHeaders) {
                    if (
                        (this.params.cors.allowedHeaders as string).startsWith(
                            "[",
                        )
                    ) {
                        this.params.cors.allowedHeaders = JSON.parse(
                            this.params.cors.allowedHeaders as string,
                        );
                    }
                }
                if (this.params.cors.exposedHeaders) {
                    if (
                        (this.params.cors.exposedHeaders as string).startsWith(
                            "[",
                        )
                    ) {
                        this.params.cors.exposedHeaders = JSON.parse(
                            this.params.cors.exposedHeaders as string,
                        );
                    }
                }
            }
        }
        if (
            typeof this.params === "object" &&
            this.params.lvl_logger &&
            this.params.lvl_logger !== "NOTSET"
        ) {
            const rootLogger = Logger.getRootLogger();
            this.logger.setLevel(this.params.lvl_logger);
            for (const handler of rootLogger._handlers) {
                this.logger.addHandler(handler);
            }
        }
    }
    public abstract init(reload?: boolean): Promise<void>;
    public abstract initContext(
        gateContext: IContext,
    ): Promise<IContextPluginResult>;
    public async checkQueryAccess(
        gateContext: IContext,
        query: IGateQuery,
    ): Promise<boolean> {
        if (query.needSession && !gateContext.session) {
            return false;
        }
        return true;
    }
    public async handleResult(
        gateContext: IContext,
        result: IResult,
    ): Promise<IResult> {
        return result;
    }
    public async maskResult(): Promise<IResult> {
        const result = {
            data: ResultStream([ErrorGate.MAINTENANCE_WORK]),
            type: "error",
        };
        return result as IResult;
    }
    public abstract destroy(): Promise<void>;
}
