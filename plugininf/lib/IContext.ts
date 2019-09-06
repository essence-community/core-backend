/**
 * Created by artemov_i on 04.12.2018.
 */
import * as http from "http";
import Connection from "./db/Connection";
import IContextPlugin from "./IContextPlugin";
import IProvider from "./IProvider";
import { IGateQuery } from "./IQuery";
import { IMetaData } from "./IResult";
import ISession from "./ISession";

export type TAction = "sql" | "dml" | "upload" | "file" | "getfile" | "auth";

export interface IParam {
    [key: string]: any;
}

export interface IHeader {
    [key: string]: string | number;
}
export interface IRequest extends http.IncomingMessage {
    body?: any;
    params?: IParam;
    preParams: IParam;
}
export default interface IContext {
    readonly hash: string;
    session?: ISession;
    readonly sessionId?: string;
    extraHeaders: IHeader;
    startTime: number;
    params: IParam;
    isResponded: boolean;
    readonly actionName: TAction;
    readonly providerName: string;
    readonly queryName: string;
    readonly pluginName: string[];
    readonly gateContextPlugin: IContextPlugin;
    readonly request: IRequest;
    readonly response: http.ServerResponse;
    readonly gateVersion: string;
    metaData: IMetaData;
    connection?: Connection;
    provider: IProvider;
    query: IGateQuery;
    info(str: string, ...args: any[]): void;
    warn(str: string, ...args: any[]): void;
    error(str: string, ...args: any[]): void;
    debug(str: string, ...args: any[]): void;
    trace(str: string, ...args: any[]): void;
    isDebugEnabled(): boolean;
    isTraceEnabled(): boolean;
    isWarnEnabled(): boolean;
    isInfoEnabled(): boolean;
}
