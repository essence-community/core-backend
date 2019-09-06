/**
 * Created by artemov_i on 04.12.2018.
 */
import Connection from "./db/Connection";
import IContext, { TAction } from "./IContext";
import IQuery, { IGateQuery } from "./IQuery";
import IResult from "./IResult";
import { IMetaData } from "./IResult";

export interface IContextPluginResult {
    actionName?: TAction;
    defaultActionName?: TAction;
    providerName?: string;
    defaultProviderName?: string;
    query?: IQuery;
    connection?: Connection;
    queryName?: string;
    defaultQueryName?: string;
    pluginName?: string[];
    defaultPluginName?: string[];
    loginQuery?: string;
    metaData?: IMetaData;
}

export default interface IContextPlugin {
    name: string;
    maxPostSize: number;
    maxFileSize: number;
    maxLogParamLen: number;
    attachmentType: string;
    init(reload?: boolean): Promise<void>;
    initContext(gateContext: IContext): Promise<IContextPluginResult>;
    checkQueryAccess(
        gateContext: IContext,
        query: IGateQuery,
    ): Promise<boolean>;
    handleResult(gateContext: IContext, result: IResult): Promise<IResult>;
    maskResult(): Promise<IResult>;
    destroy(): Promise<void>;
}
