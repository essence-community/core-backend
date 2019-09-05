import Connection from "@ungate/plugininf/lib/db/Connection";
import PostgresDB from "@ungate/plugininf/lib/db/postgres";
import ICCTParams from "@ungate/plugininf/lib/ICCTParams";
import IContext from "@ungate/plugininf/lib/IContext";
import { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import IQuery from "@ungate/plugininf/lib/IQuery";
import { IResultProvider } from "@ungate/plugininf/lib/IResult";

export default abstract class IPostgreSQLController {
    public name: string;
    public params: ICCTParams;
    public dataSource: PostgresDB;
    constructor(name: string, params: ICCTParams, dataSource: PostgresDB) {
        this.name = name;
        this.params = params;
        this.dataSource = dataSource;
    }
    public abstract init(): Promise<void>;
    public abstract getConnection(context: IContext): Promise<Connection>;
    public abstract processSql(
        context: IContext,
        query: IGateQuery,
    ): Promise<IResultProvider>;
    public abstract processDml(
        context: IContext,
        query: IGateQuery,
    ): Promise<IResultProvider>;
    public abstract initContext(
        context: IContext,
        query: IQuery,
    ): Promise<IQuery>;
}
