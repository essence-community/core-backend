/**
 * Created by artemov_i on 04.12.2018.
 */
import IContext from "./IContext";
import IObjectParam from "./IObjectParam";
import IQuery, { IGateQuery } from "./IQuery";
import { IResultProvider } from "./IResult";

export default interface IProvider {
    name: string;
    init(reload?: boolean): Promise<void>;
    initContext(context: IContext, query?: IQuery): Promise<IQuery>;
    processSql(context: IContext, query: IGateQuery): Promise<IResultProvider>;
    processDml(context: IContext, query: IGateQuery): Promise<IResultProvider>;
    fileInParams(file: Buffer): any;
    dateInParams(date: string): any;
    arrayInParams(val: any[]): any;
    destroy(): Promise<void>;
}
