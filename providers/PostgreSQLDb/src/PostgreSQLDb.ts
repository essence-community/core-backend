import PostgresDB from "@ungate/plugininf/lib/db/postgres/index";
import ICCTParams, { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import IContext from "@ungate/plugininf/lib/IContext";
import { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import IQuery from "@ungate/plugininf/lib/IQuery";
import { IResultProvider } from "@ungate/plugininf/lib/IResult";
import NullProvider from "@ungate/plugininf/lib/NullProvider";
import { initParams, isEmpty } from "@ungate/plugininf/lib/util/Util";
import { noop, omit } from "lodash";
import CorePG from "./CorePG";
import IPostgreSQLController from "./IPostgreSQLController";
import OldPG from "./OldPG";
import { IParamPg } from "./PostgreSQLDb.types";
import SimplePG from "./SimplePG";
import { ISessCtrl } from "@ungate/plugininf/lib/ISessCtrl";

export default class PostgreSQLDb extends NullProvider {
    /* tslint:disable:object-literal-sort-keys */
    public static getParamsInfo(): IParamsInfo {
        return {
            ...PostgresDB.getParamsInfo(),
            preExecuteSql: {
                name: "Запрос вызываемый перед",
                type: "long_string",
            },
            postExecuteSql: {
                name: "Запрос вызываемый после",
                type: "long_string",
            },
            core: {
                defaultValue: false,
                name: "Инициализация согласно проекту Core",
                type: "boolean",
            },
            old: {
                defaultValue: false,
                name: "Работа по аналогии Java json",
                type: "boolean",
            },
        };
    }
    /* tslint:enable:object-literal-sort-keys */
    public params: IParamPg;
    public dataSource: PostgresDB;
    private controller: IPostgreSQLController;
    constructor(
        name: string,
        params: ICCTParams,
        sessCtrl: ISessCtrl,
    ) {
        super(name, params, sessCtrl);
        this.params = initParams(PostgreSQLDb.getParamsInfo(), this.params);
        this.dataSource = new PostgresDB(`${this.name}_provider`, omit(this.params, Object.keys(PostgresDB.getParamsInfo())) as any);
        if (params.core) {
            this.controller = new CorePG(
                this.name,
                this.params,
                this.dataSource,
                this.sessCtrl,
            );
        } else if (params.old) {
            this.controller = new OldPG(
                this.name,
                this.params,
                this.dataSource,
                this.sessCtrl,
            );
        } else {
            this.controller = new SimplePG(
                this.name,
                this.params,
                this.dataSource,
                this.sessCtrl,
            );
        }
        if (!isEmpty(this.params.preExecuteSql)) {
            const processDmlPre = this.processDml;
            this.processDml = async (context: IContext, query: IGateQuery) => {
                const res = await context.connection.executeStmt(
                    this.params.preExecuteSql,
                    query.inParams,
                    query.outParams,
                );
                await new Promise((resolve, reject) => {
                    res.stream.on("error", (err) => reject(err));
                    res.stream.on("data", noop);
                    res.stream.on("end", () => resolve());
                });
                return processDmlPre.call(this, context, query);
            };
            const processSqlPre = this.processSql;
            this.processSql = async (context: IContext, query: IGateQuery) => {
                const res = await context.connection.executeStmt(
                    this.params.preExecuteSql,
                    query.inParams,
                    query.outParams,
                );
                await new Promise((resolve, reject) => {
                    res.stream.on("error", (err) => reject(err));
                    res.stream.on("data", noop);
                    res.stream.on("end", () => resolve());
                });
                return processSqlPre.call(this, context, query);
            };
        }
        if (!isEmpty(this.params.postExecuteSql)) {
            const processDmlPost = this.processDml;
            this.processDml = async (context: IContext, query: IGateQuery) => {
                const res = await processDmlPost.call(this, context, query);
                res.stream.once("end", () => {
                    context.connection
                        .executeStmt(
                            this.params.postExecuteSql,
                            query.inParams,
                            query.outParams,
                        )
                        .then(
                            (resPost) =>
                                new Promise((resolve, reject) => {
                                    resPost.stream.on("error", (err) =>
                                        reject(err),
                                    );
                                    resPost.stream.on("data", noop);
                                    resPost.stream.on("end", () => resolve());
                                }),
                        )
                        .then(noop)
                        .catch((err) =>
                            context.error(
                                `Error execute postExecuteSql:\n${err.message}`,
                                err,
                            ),
                        );
                });

                return res;
            };
            const processSqlPost = this.processSql;
            this.processSql = async (context: IContext, query: IGateQuery) => {
                const res = await processSqlPost.call(this, context, query);
                res.stream.once("end", () => {
                    context.connection
                        .executeStmt(
                            this.params.postExecuteSql,
                            query.inParams,
                            query.outParams,
                        )
                        .then(
                            (resPost) =>
                                new Promise((resolve, reject) => {
                                    resPost.stream.on("error", (err) =>
                                        reject(err),
                                    );
                                    resPost.stream.on("data", noop);
                                    resPost.stream.on("end", () => resolve());
                                }),
                        )
                        .then(noop)
                        .catch((err) =>
                            context.error(
                                `Error execute postExecuteSql:\n${err.message}`,
                                err,
                            ),
                        );
                });

                return res;
            };
        }
    }
    public processSql(
        context: IContext,
        query: IGateQuery,
    ): Promise<IResultProvider> {
        return this.controller.processSql(context, query);
    }
    public processDml(
        context: IContext,
        query: IGateQuery,
    ): Promise<IResultProvider> {
        return this.controller.processDml(context, query);
    }
    public async init(reload?: boolean): Promise<void> {
        if (this.dataSource.pool) {
            await this.dataSource.resetPool();
        }
        await this.dataSource.createPool();
        return this.controller.init();
    }
    public async initContext(
        context: IContext,
        query?: IQuery,
    ): Promise<IQuery> {
        const res = await super.initContext(context, query);
        context.connection = await this.controller.getConnection(context);
        if (!isEmpty(res.modifyMethod) && res.modifyMethod !== "_") {
            res.queryStr = `select ${res.modifyMethod}(:sess_ck_id, :sess_session, :json) as result`;
            return res;
        } else if (res.modifyMethod === "_") {
            return res;
        }
        if (!isEmpty(query.queryStr)) {
            return res;
        }
        return this.controller.initContext(context, res);
    }
}
