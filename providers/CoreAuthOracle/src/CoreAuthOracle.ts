import Connection from "@ungate/plugininf/lib/db/Connection";
import OracleDB from "@ungate/plugininf/lib/db/oracle";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import ICCTParams, { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import IContext from "@ungate/plugininf/lib/IContext";
import { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import IQuery from "@ungate/plugininf/lib/IQuery";
import NullSessProvider, {
    IAuthResult,
} from "@ungate/plugininf/lib/NullSessProvider";
import { ReadStreamToArray } from "@ungate/plugininf/lib/stream/Util";
import { initParams, isEmpty } from "@ungate/plugininf/lib/util/Util";
import * as moment from "moment";
import { ISessCtrl } from "@ungate/plugininf/lib/ISessCtrl";
import { pick } from "lodash";

export default class CoreAuthOracle extends NullSessProvider {
    public static getParamsInfo(): IParamsInfo {
        return {
            ...OracleDB.getParamsInfo(),
        };
    }

    public dataSource: OracleDB;

    constructor(
        name: string,
        params: ICCTParams,
        sessCtrl: ISessCtrl,
    ) {
        super(name, params, sessCtrl);
        this.params = initParams(CoreAuthOracle.getParamsInfo(), this.params);
        this.dataSource = new OracleDB(`${this.name}_provider`, pick(this.params, ...Object.keys(OracleDB.getParamsInfo())) as any);
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
    public getConnection(): Promise<Connection> {
        return this.dataSource.getConnection();
    }
    public async processAuth(
        context: IContext,
        query: IGateQuery,
    ): Promise<IAuthResult> {
        const res = await context.connection
            .executeStmt(query.queryStr, query.inParams, query.outParams)
            .catch((err) => {
                if (err && (err.message || "").indexOf("ORA-04061") > -1) {
                    return context.connection
                        .rollbackAndClose()
                        .then(async () => {
                            context.connection = await this.getConnection();
                            return;
                        })
                        .then(() => this.processDml(context, query));
                }
                return Promise.reject(err);
            });
        const arr = await ReadStreamToArray(res.stream);
        if (isEmpty(arr) || isEmpty(arr[0].ck_id)) {
            this.log.warn("Invalid login and password");
            throw new ErrorException(ErrorGate.AUTH_UNAUTHORIZED);
        }
        return {
            idUser: arr[0].ck_id,
            dataUser: arr[0],
        };
    }
    public async init(reload?: boolean): Promise<void> {
        await this.dataSource.createPool();
        const users = {};
        this.log.trace("Cache users...");
        return this.dataSource
            .executeStmt(
                "select u.ck_id, u.cv_login, u.cv_name, u.cv_surname, u.cv_patronymic\n" +
                    "  from t_user u",
                null,
                null,
                null,
                {
                    resultSet: true,
                },
            )
            .then(
                (resUser) =>
                    new Promise((resolve, reject) => {
                        resUser.stream.on("error", (err) => reject(err));
                        resUser.stream.on("data", (chunk) => {
                            users[chunk.ck_id] = {
                                ...chunk,
                                ca_actions: [],
                                type_auth_provider: 'COREAUTHORACLE',
                            };
                        });
                        resUser.stream.on("end", () => {
                            this.dataSource
                                .executeStmt(
                                    "select ur.ck_user, dra.ck_d_action from t_user_role ur\n" +
                                        "  join t_d_role dr on dr.ck_id = ur.ck_d_role\n" +
                                        "  join t_d_role_action dra on dra.ck_d_role = dr.ck_id",
                                    null,
                                    null,
                                    null,
                                    {
                                        resultSet: true,
                                    },
                                )
                                .then(
                                    (resAction) =>
                                        new Promise<void>(
                                            (resolveAction, rejectAction) => {
                                                resAction.stream.on(
                                                    "error",
                                                    (err) => rejectAction(err),
                                                );
                                                resAction.stream.on(
                                                    "data",
                                                    (val) => {
                                                        if (
                                                            users[val.ck_user]
                                                        ) {
                                                            users[
                                                                val.ck_user
                                                            ].ca_actions.push(
                                                                parseInt(
                                                                    val.ck_d_action,
                                                                    10,
                                                                ),
                                                            );
                                                        }
                                                    },
                                                );
                                                resAction.stream.on(
                                                    "end",
                                                    () => {
                                                        this.log.trace(
                                                            `Find users ${
                                                                users
                                                                    ? JSON.stringify(
                                                                          users,
                                                                      )
                                                                    : users
                                                            }`,
                                                        );
                                                        resolveAction();
                                                    },
                                                );
                                            },
                                        ),
                                )
                                .then(
                                    () => resolve(users),
                                    (err) => reject(err),
                                );
                        });
                    }),
            )
            .then(() =>
                Promise.all(
                    Object.values(users).map((user) =>
                        this.sessCtrl.addUser(
                            (user as any).ck_id,
                            this.name,
                            user as any,
                        ),
                    ),
                ),
            )
            .then(() => this.sessCtrl.updateHashAuth())
            .then(async () => {
                await this.sessCtrl.updateUserInfo(this.name);
            });
    }
    public async initContext(
        context: IContext,
        query: IQuery = {},
    ): Promise<IQuery> {
        const res = await super.initContext(context, query);
        if (isEmpty(query.queryStr)) {
            throw new ErrorException(ErrorGate.NOTFOUND_QUERY);
        }
        if (context.actionName !== "auth") {
            throw new ErrorException(ErrorGate.UNSUPPORTED_METHOD);
        }
        context.connection = await this.getConnection();
        return res;
    }
}
