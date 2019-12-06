import PostgresDB from "@ungate/plugininf/lib/db/postgres";
import IContext from "@ungate/plugininf/lib/IContext";
import { IContextPluginResult } from "@ungate/plugininf/lib/IContextPlugin";
import IResult from "@ungate/plugininf/lib/IResult";
import { ICoreParams } from "./CoreContext";

export default interface ICoreController {
    name: string;
    dataSource: PostgresDB;
    params: ICoreParams;
    init(reload?: boolean): Promise<void>;
    getSetting(gateContext: IContext): Promise<any>;
    findModify(gateContext: IContext): Promise<IContextPluginResult>;
    findPages(
        gateContext: IContext,
        ckPage: string,
        caActions: any[],
        version: "1" | "2" | "3",
    ): Promise<any>;
    findQuery(
        gateContext: IContext,
        name: string,
    ): Promise<IContextPluginResult>;
    handleResult(gateContext: IContext, result: IResult): Promise<IResult>;
    destroy(): Promise<void>;
}
