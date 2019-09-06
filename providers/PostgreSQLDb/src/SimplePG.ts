import Connection from "@ungate/plugininf/lib/db/Connection";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import IContext from "@ungate/plugininf/lib/IContext";
import IQuery from "@ungate/plugininf/lib/IQuery";
import { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import { IResultProvider } from "@ungate/plugininf/lib/IResult";
import IPostgreSQLController from "./IPostgreSQLController";
const wsQuerySQL =
    "select cc_query from t_query where upper(ck_id) = upper(:query)";

export default class SimplePG extends IPostgreSQLController {
    public async init(): Promise<void> {
        return;
    }
    public getConnection(context: IContext): Promise<Connection> {
        return this.dataSource.getConnection();
    }
    public processSql(
        context: IContext,
        query: IGateQuery,
    ): Promise<IResultProvider> {
        return context.connection.executeStmt(
            query.queryStr,
            query.inParams,
            query.outParams,
            {
                resultSet: true,
            },
        );
    }
    public processDml(
        context: IContext,
        query: IGateQuery,
    ): Promise<IResultProvider> {
        return context.connection.executeStmt(
            query.queryStr,
            query.inParams,
            query.outParams,
        );
    }
    public async initContext(
        context: IContext,
        query: IQuery,
    ): Promise<IQuery> {
        if (!query.queryStr && query.modifyMethod !== "_") {
            return this.dataSource
                .executeStmt(
                    wsQuerySQL,
                    context.connection.getCurrentConnection(),
                    {
                        query: context.queryName,
                    },
                )
                .then((res) => {
                    return new Promise((resolve, reject) => {
                        const data = [];
                        res.stream.on("error", (err) => reject(err));
                        res.stream.on("data", (chunk) => data.push(chunk));
                        res.stream.on("end", () => {
                            if (!data.length) {
                                return reject(
                                    new ErrorException(
                                        ErrorGate.NOTFOUND_QUERY,
                                    ),
                                );
                            }
                            resolve({
                                ...query,
                                queryStr: data[0].cc_query,
                            });
                        });
                    });
                });
        }
        return query;
    }
}
