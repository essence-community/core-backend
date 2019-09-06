import Connection from "@ungate/plugininf/lib/db/Connection";
import OracleDB from "@ungate/plugininf/lib/db/oracle";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import ICCTParams from "@ungate/plugininf/lib/ICCTParams";
import IContext from "@ungate/plugininf/lib/IContext";
import IQuery, { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import { IResultProvider } from "@ungate/plugininf/lib/IResult";
import { noop } from "lodash";
import IOracleController from "./IOracleController";
const wsQuerySQL =
    "select vl_query, kd_type, pr_auth from report.wd_sqlstore where upper(nm_query) = upper(:nm_query)";

export default class OldOracle implements IOracleController {
    public dataSource: OracleDB;
    public params: ICCTParams;
    public name: string;
    constructor(name: string, params: ICCTParams, dataSource: OracleDB) {
        this.name = name;
        this.params = params;
        this.dataSource = dataSource;
    }
    public async init(): Promise<void> {
        return;
    }
    public getConnection(context: IContext): Promise<Connection> {
        return this.dataSource.getConnection();
    }
    public async processSql(
        context: IContext,
        query: IGateQuery,
    ): Promise<IResultProvider> {
        const newSchema =
            query.inParams.schema ||
            this.params.defaultSchema ||
            this.params.user;
        await this.alterSchemaConnection(
            context,
            query,
            newSchema,
            this.params.user,
        );
        return context.connection
            .executeStmt(query.queryStr, query.inParams, query.outParams, {
                resultSet: true,
            })
            .then(async (res) => {
                await this.alterSchemaConnection(
                    context,
                    query,
                    this.params.user,
                    newSchema,
                );
                return res;
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
    public async processDml(
        context: IContext,
        query: IGateQuery,
    ): Promise<IResultProvider> {
        const newSchema =
            query.inParams.schema ||
            this.params.defaultSchema ||
            this.params.user;
        await this.alterSchemaConnection(
            context,
            query,
            newSchema,
            this.params.user,
        );
        return context.connection
            .executeStmt(query.queryStr, query.inParams, query.outParams)
            .then(async (res) => {
                await this.alterSchemaConnection(
                    context,
                    query,
                    this.params.user,
                    newSchema,
                );
                return res;
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
                        .then(() => this.processDml(context, query));
                }
                return Promise.reject(err);
            });
    }
    public async initContext(
        context: IContext,
        connection: Connection,
        query: IQuery,
    ): Promise<IQuery> {
        if (!query.queryStr) {
            return this.dataSource
                .executeStmt(wsQuerySQL, connection.getCurrentConnection(), {
                    query: context.queryName,
                })
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
                                needSession: !!data[0].pr_auth,
                                queryStr: data[0].vl_query,
                                type: data[0].kd_type,
                            });
                        });
                    });
                });
        }
        return query;
    }

    /**
     * Переход в новую схему
     * @param gateContext
     * @param newSchema
     * @param oldSchema
     * @param force
     * @returns {Promise}
     */
    public async alterSchemaConnection(
        context: IContext,
        query: IGateQuery,
        newSchema: string,
        oldSchema: string,
        force: boolean = false,
    ) {
        if (this.params.useAlterSchema) {
            if (force || (query.type > 0 && newSchema !== oldSchema)) {
                const sql = `alter session set current_schema = ${newSchema}`;
                return context.connection
                    .executeStmt(sql)
                    .then((res) => {
                        return new Promise((resolve, reject) => {
                            res.stream.on("data", noop);
                            res.stream.on("err", (err) => reject(err));
                            res.stream.on("end", () => resolve());
                        });
                    })
                    .catch((err) => {
                        context.error(
                            `Schema alteration failed ${oldSchema} to ${newSchema}`,
                            err,
                        );
                        return context.connection
                            .rollback()
                            .then(
                                () => context.connection.close(),
                                () => context.connection.close(),
                            )
                            .then(() => {
                                context.connection = null;
                                return Promise.reject(
                                    new ErrorException(
                                        ErrorGate.FAILED_ALTER_SCHEMA,
                                    ),
                                );
                            })
                            .catch(() =>
                                Promise.reject(
                                    new ErrorException(
                                        ErrorGate.FAILED_ALTER_SCHEMA,
                                    ),
                                ),
                            );
                    });
            }
        }
        return;
    }
    /**
     * Проверка в какой схеме находимся
     * @param gateContext
     * @param schema
     * @returns {Promise}
     */
    public checkCurrentSchema(gateContext: IContext, schema: string) {
        return gateContext.connection
            .executeStmt(
                "SELECT SYS_CONTEXT('USERENV','CURRENT_SCHEMA') as schema FROM DUAL",
            )
            .then(
                (res) => {
                    return new Promise((resolve, reject) => {
                        const rows = [];
                        res.stream.on("data", (chunk) => rows.push(chunk));
                        res.stream.on("err", (err) => reject(err));
                        res.stream.on("end", () => {
                            if (rows.length) {
                                return resolve(
                                    rows[0].schema.toLowerCase() === schema,
                                );
                            }
                            return resolve(true);
                        });
                    });
                },
                (err) => {
                    gateContext.warn("Не удалось проверить схему", err);
                    return Promise.reject(err);
                },
            );
    }
}
