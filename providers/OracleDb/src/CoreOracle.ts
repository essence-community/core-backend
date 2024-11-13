import Connection from "@ungate/plugininf/lib/db/Connection";
import ILocalDB from "@ungate/plugininf/lib/db/local/ILocalDB";
import OracleDB from "@ungate/plugininf/lib/db/oracle";
import BreakException from "@ungate/plugininf/lib/errors/BreakException";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import IContext from "@ungate/plugininf/lib/IContext";
import IQuery, { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import { IResultProvider } from "@ungate/plugininf/lib/IResult";
import { IUserData } from "@ungate/plugininf/lib/ISession";
import ResultStream from "@ungate/plugininf/lib/stream/ResultStream";
import { isObject } from "lodash";
import IOracleController from "./IOracleController";
import { IParamOracle } from "./OracleDb.types";
import {
    ISessCtrl,
    ICacheDb,
} from "@ungate/plugininf/lib/ISessCtrl";
import { IUserDbData } from "@ungate/plugininf/lib/ISession";
const wsQuerySQL =
    "select cc_query from t_query where upper(ck_id) = upper(:query)";

export default class CoreOracle implements IOracleController {
    public dataSource: OracleDB;
    public params: IParamOracle;
    public name: string;
    private dbUsers: ILocalDB<IUserDbData>;
    private dbCache: ILocalDB<ICacheDb>;
    constructor(
        name: string,
        params: IParamOracle,
        dataSource: OracleDB,
        private sessCtrl: ISessCtrl,
    ) {
        this.name = name;
        this.params = params;
        this.dataSource = dataSource;
    }
    public async init(): Promise<void> {
        if (!this.dbUsers) {
            this.dbUsers = this.sessCtrl.getUserDb();
        }
        if (!this.dbCache) {
            this.dbCache = this.sessCtrl.getCacheDb();
        }
    }
    public async getConnection(context: IContext): Promise<Connection> {
        const conn = await this.dataSource.getConnection();
        await this.initTempTableSession(context, conn.getCurrentConnection());
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
    ): Promise<IQuery> {
        if (!query.queryStr) {
            return this.dataSource
                .executeStmt(wsQuerySQL, connection.getCurrentConnection(), {
                    query: context.queryName,
                }, null, {
                    autoCommit: true,
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
                                queryStr: data[0].cc_query,
                            });
                        });
                    });
                });
        }
        return query;
    }
    /**
     * Инициализация темповых таблиц
     * @param  {[type]} gateContext [description]
     * @return {[type]}      [description]
     */
    public async initTempTableSession(gateContext: IContext, connection: any) {
        const res = await this.dataSource.executeStmt(
            "select pkg_json_user.f_get_context('hash_user') as hash_user, " +
                "pkg_json_user.f_get_context('hash_user_action') as hash_user_action, " +
                "pkg_json_user.f_get_context('hash_user_department') as hash_user_department from dual",
            connection,
            null,
            null,
            {
                autoCommit: true,
            }
        );
        return new Promise<void>((resolve, reject) => {
            const data = [];
            res.stream.on("error", (err) => reject(err));
            res.stream.on("data", (chunk) => data.push(chunk));
            res.stream.on("end", () =>
                this.updateSession(gateContext, connection, data).then(
                    () => resolve(),
                    (err) => reject(err),
                ),
            );
        });
    }

    private async updateSession(
        gateContext: IContext,
        connection: any,
        data: any,
    ) {
        if (!data.length) {
            throw new ErrorException(-1, "Нет данных о сессии");
        }
        if (gateContext.isDebugEnabled()) {
            gateContext.debug(`Hash session ${JSON.stringify(data)}`);
        }
        const users = [];
        const userActions = [];
        const userDepartments = [];
        const row = data[0];
        let updateUser = false;
        let updateUserAction = false;
        let updateUserDepartment = false;
        const hashObj = await this.dbCache.findOne(
            {
                ck_id: "hash_user",
            },
            true,
        );
        if (hashObj) {
            if (hashObj.hash_user !== row.hash_user) {
                updateUser = true;
                updateUserAction = true;
                updateUserDepartment = true;
            }
            if (hashObj.hash_user_action !== row.hash_user_action) {
                updateUserAction = true;
            }
            if (hashObj.hash_user_department !== row.hash_user_department) {
                updateUserDepartment = true;
            }
        }
        await Promise.all([
            updateUser || updateUserAction || updateUserDepartment
                ? this.dbUsers.find().then(async (usersRows) => {
                      let errRow;
                      const result = usersRows.every((userRow) => {
                          const item: Partial<IUserData> = userRow.data || {};
                          if (!isObject(item)) {
                              gateContext.error(`Bad tt_user data ${userRow}`);
                              errRow = new ErrorException(
                                  -1,
                                  "Bad tt_users data",
                              );
                              return false;
                          }
                          if (!Array.isArray(item.ca_actions)) {
                              if (
                                  typeof item.ca_actions === "string" &&
                                  (item.ca_actions as any).startsWith("[")
                              ) {
                                  item.ca_actions = JSON.parse(item.ca_actions);
                              } else {
                                  item.ca_actions = [];
                              }
                          }
                          (item.ca_actions || []).forEach((action) => {
                              userActions.push({
                                  ck_user: item.ck_id,
                                  cn_action: action,
                              });
                          });
                          if (!Array.isArray(item.ca_department)) {
                              if (
                                  typeof item.ca_department === "string" &&
                                  (item.ca_department as any).startsWith("[")
                              ) {
                                  item.ca_department = JSON.parse(
                                      item.ca_department,
                                  );
                              } else {
                                  item.ca_department = [];
                              }
                          }
                          (item.ca_department || []).forEach((dep) => {
                              userDepartments.push({
                                  ck_department: dep,
                                  ck_user: item.ck_id,
                              });
                          });
                          delete item.ca_actions;
                          delete item.ca_department;
                          delete item.ck_dept;
                          delete item.cv_timezone;
                          users.push(item);
                          return true;
                      });
                      if (!result) {
                          throw errRow;
                      }
                      return;
                  })
                : Promise.resolve(),
        ]);
        const actions = [];
        if (updateUser) {
            const jsonUser = JSON.stringify(users);
            actions.push(
                Promise.resolve({
                    hashObj: hashObj.hash_user,
                    json: jsonUser,
                    name: "f_modify_user",
                }),
            );
        }
        if (updateUserAction && userActions.length) {
            const jsonUserAction = JSON.stringify(userActions);
            actions.push(
                Promise.resolve({
                    hashObj: hashObj.hash_user_action,
                    json: jsonUserAction,
                    name: "f_modify_user_action",
                }),
            );
        }
        if (updateUserDepartment && userDepartments.length) {
            const jsonUserDepartment = JSON.stringify(userDepartments);
            actions.push(
                Promise.resolve({
                    hashObj: hashObj.hash_user_department,
                    json: jsonUserDepartment,
                    name: "f_modify_user_department",
                }),
            );
        }
        if (actions.length === 0) {
            return;
        }
        return actions
            .slice(1)
            .reduce((current, next) => {
                return current
                    .then((obj) =>
                        this.executePkgUser(
                            gateContext,
                            connection,
                            obj.name,
                            obj.json,
                            obj.hashObj,
                        ),
                    )
                    .then(() => next);
            }, actions[0])
            .then((obj) =>
                this.executePkgUser(
                    gateContext,
                    connection,
                    obj.name,
                    obj.json,
                    obj.hashObj,
                ),
            );
    }

    /**
     * Загрузка темповых таблиц авториизации
     * @param conn
     * @param nameFunction
     * @param obj
     * @returns {*|Promise.<TResult>}
     */
    private executePkgUser(
        gateContext: IContext,
        connection: any,
        nameFunction: string,
        obj: string,
        hash: string,
    ) {
        if (gateContext.isDebugEnabled()) {
            gateContext.debug(
                `New session init ${nameFunction} Hash: ${hash} Data: ${obj}`,
            );
        }
        return this.dataSource
            .executeStmt(
                "begin\n" +
                    `:result := pkg_json_user.${nameFunction}(pc_json => :json, pv_hash => :hash);\n` +
                    "end;",
                connection,
                {
                    hash,
                    json: obj,
                },
                {
                    result: null,
                },
                {
                    autoCommit: true,
                },
            )
            .then((res) => {
                const rows = [];
                res.stream.on("data", (chunk) => rows.push(chunk));
                return new Promise<void>((resolve, reject) => {
                    res.stream.on("error", (err) => reject(err));
                    res.stream.on("end", () => {
                        if (rows.length && rows[0].result) {
                            try {
                                const result = JSON.parse(rows[0].result);
                                if (result.cv_error) {
                                    gateContext.error(
                                        `Provider ${
                                            this.name
                                        } Error ${nameFunction}, ${JSON.stringify(
                                            result.cv_error,
                                        )}`,
                                    );
                                    return reject(
                                        new BreakException({
                                            data: ResultStream([result]),
                                            type: "success",
                                        }),
                                    );
                                }
                            } catch (e) {
                                gateContext.error(
                                    `Provider ${this.name} Error ${nameFunction}: ${rows[0]}: ${rows[0].result}`,
                                    e,
                                );
                                return Promise.reject(e);
                            }
                            return resolve();
                        }
                        return reject(
                            new ErrorException(
                                -1,
                                `Not return result ${nameFunction}`,
                            ),
                        );
                    });
                });
            })
            .catch((err) => {
                gateContext.error(
                    `Provider ${this.name} Error ${nameFunction}: ${err.message}\n
                    Hash: ${hash} Data: ${obj}`,
                    err,
                );
                return Promise.reject(err);
            });
    }
}
