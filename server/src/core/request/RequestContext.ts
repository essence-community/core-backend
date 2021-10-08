import Connection from "@ungate/plugininf/lib/db/Connection";
import IContext, {
    IFormData,
    IHeader,
    IParam,
    IRequest,
    TAction,
} from "@ungate/plugininf/lib/IContext";
import IContextPlugin from "@ungate/plugininf/lib/IContextPlugin";
import IProvider from "@ungate/plugininf/lib/IProvider";
import { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import { IMetaData } from "@ungate/plugininf/lib/IResult";
import ISession from "@ungate/plugininf/lib/ISession";
import Logger from "@ungate/plugininf/lib/Logger";
import * as crypto from "crypto";
import * as http from "http";
import { noop } from "lodash";
import Constants from "../Constants";
import * as fs from "fs";
const log = Logger.getLogger("RequestContext");
function prePareMsg(context: RequestContext, str: string): string {
    return str && str.length > context.gateContextPlugin.maxLogParamLen
        ? `${str.substr(0, context.gateContextPlugin.maxLogParamLen)}...`
        : str;
}
// tslint:disable: variable-name
export default class RequestContext implements IContext {
    private _endResponse?: any;
    public get isResponded() {
        return this._isResponded;
    }
    public set isResponded(res: boolean) {
        return;
    }
    public get query(): IGateQuery {
        return this._query;
    }
    public set query(value: IGateQuery) {
        return;
    }
    public get provider(): IProvider {
        return this._provider;
    }
    public set provider(value: IProvider) {
        return;
    }
    public get gateVersion(): string {
        return this._gateVersion;
    }
    public set gateVersion(value: string) {
        return;
    }
    public get startTime(): number {
        return this._startTime;
    }
    public set startTime(value: number) {
        return;
    }
    public get hash(): string {
        return this._hash;
    }
    public set hash(value: string) {
        return;
    }
    public get session(): ISession {
        return this._session;
    }
    public set session(value: ISession) {
        return;
    }
    public get sessionId(): string {
        return this._sessionId;
    }
    public set sessionId(value: string) {
        return;
    }
    public get extraHeaders(): IHeader {
        return this._extraHeaders;
    }
    public set extraHeaders(value: IHeader) {
        this._extraHeaders = {
            ...this._extraHeaders,
            ...value,
        };
    }
    public get gateContextPlugin(): IContextPlugin {
        return this._gateContextPlugin;
    }
    public set gateContextPlugin(value: IContextPlugin) {
        return;
    }
    public get request(): IRequest {
        return this._request;
    }
    public set request(value: IRequest) {
        return;
    }
    public get response(): http.ServerResponse {
        return this._response;
    }
    public set response(value: http.ServerResponse) {
        return;
    }
    public get params(): IParam {
        return this._params;
    }
    public set params(value: IParam) {
        this._params = {
            ...this._params,
            ...value,
        };
    }
    public get actionName(): TAction {
        return this._actionName;
    }
    public set actionName(value: TAction) {
        return;
    }
    public get providerName(): string {
        return this._providerName;
    }
    public set providerName(value: string) {
        return;
    }
    public get queryName(): string {
        return this._queryName;
    }
    public set queryName(value: string) {
        return;
    }
    public get pluginName(): string[] {
        return this._pluginName;
    }
    public set pluginName(value: string[]) {
        return;
    }
    public get metaData(): IMetaData {
        return this._metaData;
    }
    public set metaData(value: IMetaData) {
        this._metaData = {
            ...this._metaData,
            ...value,
        };
    }
    public get connection() {
        return this._connection;
    }
    public set connection(conn: Connection) {
        if (conn) {
            this._endResponse = this._endResponse || this._response.end;
            this._response.end = async (...arg) => {
                try {
                    await conn.commit();
                    await conn.release();
                } catch (e) {
                    conn.rollbackAndRelease().then(noop, noop);
                    this.error(e);
                } finally {
                    this._endResponse.apply(this._response, arg);
                    this._response.end = this._endResponse;
                    this._endResponse = undefined;
                }
            };
        }
        if (this._connection && !conn) {
            this._response.end = this._endResponse;
            this._endResponse = undefined;
        }
        this._connection = conn;
    }
    private _connection?: Connection;
    private _isResponded: boolean = false;
    private _gateVersion: string;
    private _startTime: number;
    private _hash: string;
    private _session?: ISession;
    private _sessionId?: string;
    private _extraHeaders: IHeader = {};
    private _gateContextPlugin: IContextPlugin;
    private _request: IRequest;
    private _response: http.ServerResponse;
    private _params: IParam;
    private _actionName: TAction;
    private _providerName: string;
    private _queryName: string;
    private _pluginName: string[];
    private _metaData: IMetaData = {};
    private _query: IGateQuery;
    private _provider: IProvider;
    constructor(
        request: IRequest,
        response: http.ServerResponse,
        context: IContextPlugin,
    ) {
        const buf = Buffer.alloc(6);
        crypto.randomFillSync(buf);
        this._hash = buf.toString("hex");
        this._gateContextPlugin = context;
        this._startTime = new Date().getTime();
        this._gateVersion = Constants.GATE_VERSION;
        this._request = request;
        this._response = response;
        const writeHead = response.writeHead;
        let isWriteHead = false;
        response.writeHead = (...args) => {
            if (!isWriteHead) {
                writeHead.apply(response, args);
                isWriteHead = true;
            }
        };
        response.once("finish", () => {
            this.info(
                `${this.request.method}(${this.actionName},${this.queryName}` +
                    `,${
                        this.providerName
                    }) time execute ${(new Date().getTime() - this.startTime) /
                        1000}`,
            );
            if (
                typeof this.request.body === "object" &&
                (this.request.body as IFormData).files
            ) {
                Object.entries((this.request.body as IFormData).files).forEach(
                    ([key, files]) => {
                        files.forEach((file) => {
                            if (fs.existsSync(file.path)) {
                                fs.unlink(file.path, (err) => {
                                    if (err) {
                                        this.error(err.message, err);
                                    }
                                });
                            }
                        });
                    },
                );
            }
        });
        this._params = {
            ...request.params,
            ...request.preParams,
        };
        this._actionName = (
            this.params[Constants.ACTION_PARAM] || ""
        ).toLocaleLowerCase();
        delete this.params[Constants.ACTION_PARAM];
        this._queryName = (
            this.params[Constants.QUERYNAME_PARAM] || ""
        ).toLocaleLowerCase();
        delete this.params[Constants.QUERYNAME_PARAM];
        this._sessionId = decodeURIComponent(
            this.params[Constants.SESSION_PARAM],
        );
        delete this.params[Constants.SESSION_PARAM];
        this._providerName = (
            this.params[Constants.PROVIDER_PARAM] || ""
        ).toLocaleLowerCase();
        delete this.params[Constants.PROVIDER_PARAM];
        this._pluginName = (this.params[Constants.PLUGIN_PARAM] || "")
            .toLocaleLowerCase()
            .split(",");
        delete this.params[Constants.PLUGIN_PARAM];
        this.response.once("finish", () => {
            this.setIsResponded(true);
        });
    }
    public setIsResponded(res: boolean) {
        this._isResponded = res;
    }
    public setProvider(value: IProvider) {
        this._provider = value;
    }
    public setQuery(value: IGateQuery) {
        this._query = value;
    }
    public setSession(value: ISession) {
        this._session = value;
    }
    public setActionName(value: TAction) {
        this._actionName = value;
    }
    public setProviderName(value: string) {
        this._providerName = value;
    }
    public setQueryName(value: string) {
        this._queryName = value;
    }
    public setPluginName(value: string[]) {
        this._pluginName = value;
    }

    public info(str: string, ...args: any[]): void {
        log.info(`${this.hash} - ${prePareMsg(this, str)}`, ...args);
    }
    public warn(str: string, ...args: any[]): void {
        log.warn(`${this.hash} - ${prePareMsg(this, str)}`, ...args);
    }
    public error(str: string, ...args: any[]): void {
        log.error(`${this.hash} - ${prePareMsg(this, str)}`, ...args);
    }
    public debug(str: string, ...args: any[]): void {
        log.debug(`${this.hash} - ${prePareMsg(this, str)}`, ...args);
    }
    public trace(str: string, ...args: any[]): void {
        log.trace(`${this.hash} - ${prePareMsg(this, str)}`, ...args);
    }
    public isDebugEnabled = () => log.isDebugEnabled();
    public isTraceEnabled = () => log.isTraceEnabled();
    public isWarnEnabled = () => log.isWarnEnabled();
    public isInfoEnabled = () => log.isInfoEnabled();
}
