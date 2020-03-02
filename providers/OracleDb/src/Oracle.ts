import Connection from "@ungate/plugininf/lib/db/Connection";
import OracleDB from "@ungate/plugininf/lib/db/oracle";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import IContext from "@ungate/plugininf/lib/IContext";
import IQuery, { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import { IResultProvider } from "@ungate/plugininf/lib/IResult";
import IOracleController from "./IOracleController";
import { IParamOracle } from "./OracleDb.types";

export default class Oracle implements IOracleController {
    public dataSource: OracleDB;
    public params: IParamOracle;
    public name: string;
    constructor(name: string, params: IParamOracle, dataSource: OracleDB) {
        this.name = name;
        this.params = params;
        this.dataSource = dataSource;
    }
    public async init(): Promise<void> {
        return;
    }
    public async getConnection(context: IContext): Promise<Connection> {
        const conn = await this.dataSource.getConnection();
        return conn;
    }
    public processSql(
        context: IContext,
        query: IGateQuery,
    ): Promise<IResultProvider> {
        return context.connection
            .executeStmt(query.queryStr, query.inParams, query.outParams, {
                resultSet: true,
            })
            .catch((err) => {
                if (err && (err.message || "").indexOf("ORA-04061") > -1) {
                    return context.connection
                        .rollbackAndClose()
                        .then(async () => {
                            context.connection = await this.getConnection(
                                context,
                            );
                            return;
                        })
                        .then(() => this.processSql(context, query));
                }
                return Promise.reject(err);
            });
    }
    public processDml(
        context: IContext,
        query: IGateQuery,
    ): Promise<IResultProvider> {
        return context.connection
            .executeStmt(query.queryStr, query.inParams, query.outParams)
            .catch((err) => {
                if (err && (err.message || "").indexOf("ORA-04061") > -1) {
                    return context.connection
                        .rollbackAndClose()
                        .then(async () => {
                            context.connection = await this.getConnection(
                                context,
                            );
                            return;
                        })
                        .then(() => this.processDml(context, query));
                }
                return Promise.reject(err);
            });
    }
    public async initContext(
        context: IContext,
        connection: Connection,
        query: IQuery,
    ): Promise<any> {
        if (!query.queryStr && query.modifyMethod !== "_") {
            throw new ErrorException(ErrorGate.NOTFOUND_QUERY);
        }
        return query;
    }
}
