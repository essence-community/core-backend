/**
 * Created by artemov_i on 04.12.2018.
 */
import BreakException from "./errors/BreakException";
import ErrorException from "./errors/ErrorException";
import IContext from "./IContext";
import IObjectParam from "./IObjectParam";
import IQuery, { IGateQuery } from "./IQuery";
import IResult from "./IResult";
import { IAuthResult } from "./NullSessProvider";
export interface IPluginRequestContext {
    [key: string]: any;
}
export default interface IPlugin {
    name: string;
    init(reload?: boolean): Promise<void>;
    beforeInitQueryPerform(
        gateContext: IContext,
        PRequestContext: IPluginRequestContext,
        query?: IQuery,
    ): Promise<IQuery | void>;
    afterInitQueryPerform(
        gateContext: IContext,
        PRequestContext: IPluginRequestContext,
        query: IGateQuery,
    ): Promise<void>;
    beforeQueryExecutePerform(
        gateContext: IContext,
        PRequestContext: IPluginRequestContext,
        query: IGateQuery,
    ): Promise<IResult | void>;
    afterQueryExecutePerform(
        gateContext: IContext,
        PRequestContext: IPluginRequestContext,
        result: IResult,
    ): Promise<IResult | void>;
    beforeSession(
        gateContext: IContext,
        PRequestContext: IPluginRequestContext,
    ): Promise<IAuthResult | void>;
    beforeSaveSession(
        gateContext: IContext,
        PRequestContext: IPluginRequestContext,
        data: IObjectParam,
    ): Promise<boolean>;
    handleError(
        gateContext: IContext,
        PRequestContext: IPluginRequestContext,
        err: BreakException | ErrorException | Error,
    ): Promise<BreakException | ErrorException | Error | void>;
    destroy(): Promise<void>;
}
