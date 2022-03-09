import Connection from "@ungate/plugininf/lib/db/Connection";
import PostgresDB from "@ungate/plugininf/lib/db/postgres";
import IContext from "@ungate/plugininf/lib/IContext";
import { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import IQuery from "@ungate/plugininf/lib/IQuery";
import { IResultProvider } from "@ungate/plugininf/lib/IResult";
import { IParamPg } from "./PostgreSQLDb.types";
import { ISessCtrl } from "@ungate/plugininf/lib/ISessCtrl";

export default abstract class IPostgreSQLController {
    constructor(
        public name: string,
        public params: IParamPg,
        public dataSource: PostgresDB,
        public sessCtrl: ISessCtrl,
    ) {}
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
