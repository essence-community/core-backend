import Connection from "@ungate/plugininf/lib/db/Connection";
import IContext from "@ungate/plugininf/lib/IContext";
import IQuery, { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import { IResultProvider } from "@ungate/plugininf/lib/IResult";

export default interface IOracleController {
    init(): Promise<void>;
    getConnection(context: IContext): Promise<Connection>;
    processSql(context: IContext, query: IGateQuery): Promise<IResultProvider>;
    processDml(context: IContext, query: IGateQuery): Promise<IResultProvider>;
    initContext(
        context: IContext,
        connection: Connection,
        query: IQuery,
    ): Promise<IQuery>;
}
