import OracleDB from "@ungate/plugininf/lib/db/oracle";
import ICCTParams, { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import IContext from "@ungate/plugininf/lib/IContext";
import IQuery, { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import { IResultProvider } from "@ungate/plugininf/lib/IResult";
import NullProvider from "@ungate/plugininf/lib/NullProvider";
import { initParams } from "@ungate/plugininf/lib/util/Util";
import { isEmpty } from "@ungate/plugininf/lib/util/Util";
import { noop } from "lodash";
import * as moment from "moment";
import CoreOracle from "./CoreOracle";
import IOracleController from "./IOracleController";
import OldOracle from "./OldOracle";
import Oracle from "./Oracle";
import { IParamOracle } from "./OracleDb.types";
import { IAuthController } from "@ungate/plugininf/lib/IAuthController";

export default class OracleDBPlugin extends NullProvider {
    /* tslint:disable:object-literal-sort-keys */
    public static getParamsInfo(): IParamsInfo {
        return {
            ...OracleDB.getParamsInfo(),
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
            defaultSchema: {
                description: "Схема по умолчаниюв режиме old",
                name: "Схема по умолчанию в режиме old",
                type: "string",
            },
            old: {
                defaultValue: false,
                name: "Работа по аналогии Java json",
                type: "boolean",
            },
        };
    }
    /* tslint:enable:object-literal-sort-keys */
    public params: IParamOracle;
    public dataSource: OracleDB;
    private controller: IOracleController;
    constructor(
        name: string,
        params: ICCTParams,
        authController: IAuthController,
    ) {
        super(name, params, authController);
        this.params = initParams(OracleDBPlugin.getParamsInfo(), this.params);
        this.dataSource = new OracleDB(`${this.name}_provider`, {
            connectString: this.params.connectString,
            maxRows: this.params.maxRows,
            partRows: this.params.partRows,
            password: this.params.password,
            poolMax: this.params.poolMax,
            poolMin: this.params.poolMin,
            prefetchRows: this.params.prefetchRows,
            queryTimeout: this.params.queryTimeout,
            queueTimeout: this.params.queueTimeout,
            user: this.params.user,
        });
        if (params.core) {
            this.controller = new CoreOracle(
                this.name,
                this.params,
                this.dataSource,
                this.authController,
            );
        } else if (params.old) {
            this.controller = new OldOracle(
                this.name,
                this.params,
                this.dataSource,
                this.authController,
            );
        } else {
            this.controller = new Oracle(
                this.name,
                this.params,
                this.dataSource,
                this.authController,
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
                await new Promise<void>((resolve, reject) => {
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
                await new Promise<void>((resolve, reject) => {
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
                                new Promise<void>((resolve, reject) => {
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
                                new Promise<void>((resolve, reject) => {
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
    /**
     * Переводим массив в правильный тип для провайдера
     * @param array
     * @returns {{dir: (BIND_IN|{value, enumerable}), val: *}}
     */
    public arrayInParams(array): any {
        return {
            dir: this.dataSource.oracledb.BIND_IN,
            val: array,
        };
    }
    /**
     * Переводим дату в правильный тип для провайдера
     * @param array
     * @returns {{dir: (BIND_IN|{value, enumerable}), val: *}}
     */
    public dateInParams(value): any {
        return isEmpty(value)
            ? ""
            : {
                  dir: this.dataSource.oracledb.BIND_IN,
                  type: this.dataSource.oracledb.DATE,
                  val: moment(value).toDate(),
              };
    }
    /**
     * Переводим файл/buffer в правильный тип для провайдера
     * @param array
     * @returns {{dir: (BIND_IN|{value, enumerable}), val: *}}
     */
    public fileInParams(value): any {
        return {
            dir: this.dataSource.oracledb.BIND_IN,
            type: this.dataSource.oracledb.BLOB,
            val: value,
        };
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
        await this.dataSource.createPool();
        return this.controller.init();
    }
    public async initContext(
        context: IContext,
        query: IQuery = {},
    ): Promise<IQuery> {
        const res = await super.initContext(context, query);
        context.connection = await this.controller.getConnection(context);
        if (!isEmpty(res.modifyMethod) && res.modifyMethod !== "_") {
            res.queryStr =
                "begin\n" +
                `:result := ${res.modifyMethod}(:sess_ck_id, :sess_session, :json);\n` +
                "end;";
            return res;
        } else if (res.modifyMethod === "_") {
            return res;
        }
        if (!isEmpty(query.queryStr)) {
            return res;
        }
        return this.controller.initContext(context, context.connection, res);
    }

    public destroy(): Promise<void> {
        return this.dataSource.resetPool();
    }
}
