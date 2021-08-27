import Connection from "@ungate/plugininf/lib/db/Connection";
import ILocalDB from "@ungate/plugininf/lib/db/local/ILocalDB";
import OracleDB from "@ungate/plugininf/lib/db/oracle";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import ICCTParams, { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import IContext from "@ungate/plugininf/lib/IContext";
import IGlobalObject from "@ungate/plugininf/lib/IGlobalObject";
import { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import IQuery from "@ungate/plugininf/lib/IQuery";
import NullAuthProvider, {
    IAuthResult,
} from "@ungate/plugininf/lib/NullAuthProvider";
import { ReadStreamToArray } from "@ungate/plugininf/lib/stream/Util";
import { initParams, isEmpty } from "@ungate/plugininf/lib/util/Util";
import * as moment from "moment";
import { IAuthController } from "@ungate/plugininf/lib/IAuthController";
const Property = ((global as any) as IGlobalObject).property;

export default class ProjectTiiAuth extends NullAuthProvider {
    public static getParamsInfo(): IParamsInfo {
        return {
            ...OracleDB.getParamsInfo(),
        };
    }

    public dataSource: OracleDB;

    private dbUsers: ILocalDB;
    constructor(
        name: string,
        params: ICCTParams,
        authController: IAuthController,
    ) {
        super(name, params, authController);
        this.params = initParams(ProjectTiiAuth.getParamsInfo(), this.params);
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
    /**
     * Создание сессии
     * @param idUser id пользователя
     * @param data данные сессии
     * @param [sessionDuration] - время жизни
     * @returns session
     */
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
        if (isEmpty(arr)) {
            throw new ErrorException(ErrorGate.AUTH_DENIED);
        }
        return {
            idUser: arr[0].ck_id,
            dataUser: arr[0],
        };
    }
    public async init(reload?: boolean): Promise<void> {
        if (!this.dbUsers) {
            this.dbUsers = this.authController.getUserDb();
        }
        await this.dataSource.createPool();
        const users = {};
        return this.dataSource
            .executeStmt("select * from crd_user", null, null, null, {
                resultSet: true,
            })
            .then(
                (resUser) =>
                    new Promise((resolve, reject) => {
                        resUser.stream.on("error", (err) => reject(err));
                        resUser.stream.on("data", (chunk) => {
                            users[chunk.id_usr] = {
                                ca_actions: [],
                                ck_id: chunk.id_usr,
                                cv_email: chunk.nm_email,
                                cv_login: chunk.nm_login,
                                cv_name: chunk.nm_first,
                                cv_patronymic: chunk.nm_middle,
                                cv_surname: chunk.nm_last,
                            };
                        });
                        resUser.stream.on("end", () => {
                            this.dataSource
                                .executeStmt(
                                    "select distinct r.id_usr, a.kd_action from crd_role_to_usr r" +
                                        " join crd_action_to_role a on r.kd_role=a.kd_role",
                                    null,
                                    {},
                                    {},
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
                                                        if (users[val.id_usr]) {
                                                            users[
                                                                val.id_usr
                                                            ].ca_actions.push(
                                                                parseInt(
                                                                    val.kd_action,
                                                                    10,
                                                                ),
                                                            );
                                                        }
                                                    },
                                                );
                                                resAction.stream.on(
                                                    "end",
                                                    () => {
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
                        this.authController.addUser(
                            (user as any).ck_id,
                            this.name,
                            user as any,
                        ),
                    ),
                ),
            )
            .then(() => this.authController.updateHashAuth())
            .then(async () => {
                await this.authController.updateUserInfo(this.name);
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
