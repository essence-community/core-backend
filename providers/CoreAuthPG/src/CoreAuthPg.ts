import Connection from "@ungate/plugininf/lib/db/Connection";
import ILocalDB from "@ungate/plugininf/lib/db/local/ILocalDB";
import PostgresDB from "@ungate/plugininf/lib/db/postgres";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import ICCTParams, { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import IContext from "@ungate/plugininf/lib/IContext";
import IGlobalObject from "@ungate/plugininf/lib/IGlobalObject";
import { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import IQuery from "@ungate/plugininf/lib/IQuery";
import { IResultProvider } from "@ungate/plugininf/lib/IResult";
import NullAuthProvider, {
    IAuthResult,
    IAuthProviderParam,
} from "@ungate/plugininf/lib/NullAuthProvider";
import { ReadStreamToArray } from "@ungate/plugininf/lib/stream/Util";
import { initParams, isEmpty } from "@ungate/plugininf/lib/util/Util";
import { debounce, noop } from "lodash";
import { isObject } from "util";
import ISession from "@ungate/plugininf/lib/ISession";
const Property = (global as IGlobalObject).property;

const MAX_WAIT_RELOAD = 5000;

export interface IParamsProvider extends IAuthProviderParam {
    guestAccount?: string;
}
export default class CoreAuthPg extends NullAuthProvider {
    public static getParamsInfo(): IParamsInfo {
        /* tslint:disable:object-literal-sort-keys */
        return {
            ...NullAuthProvider.getParamsInfo(),
            ...PostgresDB.getParamsInfo(),
            guestAccount: {
                type: "combo",
                name: "static:c7871bbd0e855693a47185a29b2b79f1",
                query: "AuthShowAccount",
                pagesize: "10",
                displayField: "cv_login",
                valueField: "ck_id",
                querymode: "remote",
                queryparam: "cv_login",
            },
        };
        /* tslint:enable:object-literal-sort-keys */
    }

    public dataSource: PostgresDB;
    public params: IParamsProvider;

    private dbUsers: ILocalDB;
    private eventConnect: Connection;
    private reloadTemp = debounce(() => {
        this.initTemp().then(noop, (err) => this.log.error(err));
    }, MAX_WAIT_RELOAD);
    constructor(name: string, params: ICCTParams) {
        super(name, params);
        this.params = {
            ...this.params,
            ...initParams(CoreAuthPg.getParamsInfo(), params),
        };
        this.dataSource = new PostgresDB(`${this.name}_provider`, {
            connectString: this.params.connectString,
            connectionTimeoutMillis: this.params.connectionTimeoutMillis,
            idleTimeoutMillis: this.params.idleTimeoutMillis,
            partRows: this.params.partRows,
            poolMax: this.params.poolMax,
            queryTimeout: this.params.queryTimeout,
        });
        if (!isEmpty(this.params.guestAccount)) {
            this.afterSession = async (
                context: IContext,
                sessionId?: string,
                session?: ISession,
            ): Promise<ISession> => {
                if (context.params.connect_guest === "true") {
                    const {
                        session: sessGuest,
                        ...sessDataGuest
                    }: any = await this.createSession(
                        this.params.guestAccount,
                        {},
                        this.params.sessionDuration,
                    );
                    return {
                        ck_id: this.params.guestAccount,
                        ck_d_provider: this.name,
                        data: sessDataGuest,
                        session: sessGuest,
                    };
                }
                return session;
            };
        }
    }
    public getConnection(): Promise<Connection> {
        return this.dataSource.getConnection();
    }
    public async processAuth(
        context: IContext,
        query: IGateQuery,
    ): Promise<IAuthResult> {
        const res = await context.connection.executeStmt(
            query.queryStr,
            query.inParams,
            query.outParams,
        );
        const arr = await ReadStreamToArray(res.stream);
        if (isEmpty(arr) || isEmpty(arr[0].ck_id)) {
            throw new ErrorException(ErrorGate.AUTH_DENIED);
        }
        return {
            ck_user: arr[0].ck_id,
            data: arr[0],
        };
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
    public async init(reload?: boolean): Promise<void> {
        if (!this.dbUsers) {
            this.dbUsers = await Property.getUsers();
        }
        if (this.dataSource.pool) {
            await this.dataSource.resetPool();
        }
        await this.dataSource.createPool();
        if (process.env.UNGATE_HTTP_ID === "1") {
            await this.initEvents();
        }
        return this.initTemp();
    }
    public async destroy() {
        if (process.env.UNGATE_HTTP_ID === "1") {
            this.reloadTemp.cancel();
            await this.eventConnect.rollbackAndClose();
        }
        return this.dataSource.resetPool();
    }
    public async initContext(
        context: IContext,
        query: IQuery = {},
    ): Promise<IQuery> {
        const res = await super.initContext(context, query);
        context.connection = await this.getConnection();
        if (!isEmpty(res.modifyMethod) && res.modifyMethod !== "_") {
            res.queryStr = `select ${res.modifyMethod}(:sess_ck_id, :sess_session, :json) as result`;
            return res;
        } else if (res.modifyMethod === "_") {
            return res;
        }
        if (isEmpty(query.queryStr)) {
            if (context.actionName !== "auth") {
                throw new ErrorException(ErrorGate.NOTFOUND_QUERY);
            } else {
                query.queryStr =
                    "/*Login*/ select pkg_json_account.f_get_user(:cv_login::varchar, :cv_password::varchar, :cv_token::varchar, 1::smallint) as ck_id";
            }
        }
        return res;
    }
    private async initEvents() {
        try {
            this.log.info(`Init event ${this.name}`);
            if (this.eventConnect) {
                this.reloadTemp.cancel();
                await this.eventConnect.rollbackAndClose();
            }
            this.eventConnect = await this.dataSource.getConnection();
            const conn = this.eventConnect.getCurrentConnection();
            conn.on("notification", (msg) => {
                this.log.trace("Notification %j", msg);
                const payload = JSON.parse(msg.payload);
                const table = payload.table?.toLowerCase();
                if (
                    table &&
                    (table.endsWith("t_account") ||
                        table.endsWith("t_account_role") ||
                        table.endsWith("t_account_info") ||
                        table.endsWith("t_role_action"))
                ) {
                    this.reloadTemp();
                }
            });
            conn.on("error", () => {
                return this.initEvents();
            });
            return conn.query("LISTEN events");
        } catch (err) {
            setTimeout(() => this.initEvents(), MAX_WAIT_RELOAD);
        }
    }
    private async initTemp() {
        const users = {};
        return this.dataSource
            .executeStmt(
                "select json_object(array['ck_id',\n" +
                    "                   'cv_login',\n" +
                    "                   'cv_name',\n" +
                    "                   'cv_surname',\n" +
                    "                   'cv_patronymic',\n" +
                    "                   'cv_email',\n" +
                    "                   'cv_timezone']::varchar[] || coalesce(info.key::varchar[], array[]::varchar[]),\n" +
                    "                   array[u.ck_id,\n" +
                    "                   u.cv_login,\n" +
                    "                   u.cv_name,\n" +
                    "                   u.cv_surname,\n" +
                    "                   u.cv_patronymic,\n" +
                    "                   u.cv_email,\n" +
                    "                   u.cv_timezone]::varchar[] || coalesce(info.value::varchar[], array[]::varchar[])) as json\n" +
                    "  from s_at.t_account u\n" +
                    "  left join (select a.ck_id,\n" +
                    "               array_agg(a.ck_d_info) as key,\n" +
                    "               array_agg(ainf.cv_value) as value\n" +
                    "          from (select ac.ck_id, inf.ck_id as ck_d_info, inf.cr_type\n" +
                    "                  from s_at.t_account ac, s_at.t_d_info inf) a\n" +
                    "          left join s_at.t_account_info ainf\n" +
                    "            on a.ck_d_info = ainf.ck_d_info and a.ck_id = ainf.ck_account\n" +
                    "         group by a.ck_id) as info\n" +
                    "    on u.ck_id = info.ck_id",
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
                            const row = isObject(chunk.json)
                                ? chunk.json
                                : JSON.stringify(chunk.json);
                            users[row.ck_id] = {
                                cv_timezone: "+03:00",
                                ...row,
                                ca_actions: [],
                            };
                        });
                        resUser.stream.on("end", () => {
                            this.dataSource
                                .executeStmt(
                                    "select distinct ur.ck_account, dra.ck_action\n" +
                                        "  from t_account_role ur\n" +
                                        "  join t_role_action dra on ur.ck_role = dra.ck_role",
                                    null,
                                    null,
                                    null,
                                    {
                                        resultSet: true,
                                    },
                                )
                                .then(
                                    (resAction) =>
                                        new Promise(
                                            (resolveAction, rejectAction) => {
                                                resAction.stream.on(
                                                    "error",
                                                    (err) => rejectAction(err),
                                                );
                                                resAction.stream.on(
                                                    "data",
                                                    (val) => {
                                                        if (
                                                            users[
                                                                val.ck_account
                                                            ]
                                                        ) {
                                                            users[
                                                                val.ck_account
                                                            ].ca_actions.push(
                                                                parseInt(
                                                                    val.ck_action,
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
                            user,
                        ),
                    ),
                ),
            )
            .then(() => this.authController.updateHashAuth())
            .then(async () => {
                await this.authController.updateUserInfo(this.name);
            });
    }
}
