import Connection from "@ungate/plugininf/lib/db/Connection";
import PostgresDB from "@ungate/plugininf/lib/db/postgres";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import ICCTParams, { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import IContext from "@ungate/plugininf/lib/IContext";
import { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import IQuery from "@ungate/plugininf/lib/IQuery";
import { IResultProvider } from "@ungate/plugininf/lib/IResult";
import NullSessProvider, {
    IAuthResult,
    ISessProviderParam,
} from "@ungate/plugininf/lib/NullSessProvider";
import { ReadStreamToArray } from "@ungate/plugininf/lib/stream/Util";
import { initParams, isEmpty, debounce } from "@ungate/plugininf/lib/util/Util";
import { noop, isObject, pick } from "lodash";
import ISession from "@ungate/plugininf/lib/ISession";
import { ISessCtrl } from "@ungate/plugininf/lib/ISessCtrl";

const MAX_WAIT_RELOAD = 5000;

export interface IParamsProvider extends ISessProviderParam {
    guestAccount?: string;
}
export default class CoreAuthPg extends NullSessProvider {
    public static getParamsInfo(): IParamsInfo {
        /* tslint:disable:object-literal-sort-keys */
        return {
            ...PostgresDB.getParamsInfo(),
            guestAccount: {
                type: "combo",
                name: "static:c7871bbd0e855693a47185a29b2b79f1",
                query: "AuthShowAccount",
                pagesize: 10,
                displayField: "cv_login",
                valueField: [{ in: "ck_id" }],
                querymode: "remote",
                queryparam: "cv_login",
            },
        };
        /* tslint:enable:object-literal-sort-keys */
    }

    public dataSource: PostgresDB;
    public params: IParamsProvider;

    private eventConnect: Connection;
    private reloadTemp = debounce(() => {
        this.initTemp().then(noop, (err) => this.log.error(err));
    }, MAX_WAIT_RELOAD);
    constructor(
        name: string,
        params: ICCTParams,
        sessCtrl: ISessCtrl,
    ) {
        super(name, params, sessCtrl);
        this.params = initParams(CoreAuthPg.getParamsInfo(), this.params);
        this.dataSource = new PostgresDB(`${this.name}_provider`, pick(this.params, ...Object.keys(PostgresDB.getParamsInfo())) as any);
        if (!isEmpty(this.params.guestAccount)) {
            this.afterSession = async (
                context: IContext,
                sessionId?: string,
                session?: ISession,
            ): Promise<ISession> => {
                if (session) {
                    return session;
                }
                if (context.params.connect_guest === "true") {
                    const { session: sessGuest }: any =
                        await this.createSession({
                            context,
                            idUser: this.params.guestAccount,
                            userData: {} as any,
                        });
                    return this.sessCtrl.loadSession(sessGuest);
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
            this.log.warn("Invalid login and password");
            throw new ErrorException(ErrorGate.AUTH_DENIED);
        }
        return {
            idUser: arr[0].ck_id,
            dataUser: arr[0],
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
        if (this.eventConnect) {
            await this.eventConnect.rollbackAndClose();
            this.eventConnect = null;
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
        if (this.eventConnect) {
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
                await this.eventConnect.rollbackAndClose();
                this.eventConnect = null;
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
                this.initEvents();
            });
            return conn.query("LISTEN events");
        } catch (err) {
            this.log.error(err);
            return new Promise((resolve, reject) => {
                setTimeout(
                    () => this.initEvents().then(resolve, reject),
                    MAX_WAIT_RELOAD,
                );
            });
        }
    }
    /**
     * Обновление информации по пользователям
     */
    private initTemp() {
        const users = {};
        this.log.trace("Cache users...");
        return this.dataSource
            .executeStmt(
                "select jsonb_build_object('ck_id', u.ck_id,\n" + 
                "                   'cv_login', u.cv_login,\n" + 
                "                   'cv_name', u.cv_name,\n" + 
                "                   'cv_surname', u.cv_surname,\n" + 
                "                   'cv_patronymic', u.cv_patronymic,\n" + 
                "                   'cv_email', u.cv_email,\n" + 
                "                   'cv_timezone', u.cv_timezone) || coalesce(info.attr, '{}'::jsonb) as json\n" + 
                "  from s_at.t_account u\n" + 
                "  left join (select a.ck_id,\n" + 
                "                jsonb_object_agg(a.ck_d_info, pkg_json_account.f_decode_attr(ainf.cv_value, a.cr_type)) as attr\n" + 
                "          from (select ac.ck_id, inf.ck_id as ck_d_info, inf.cr_type\n" + 
                "                  from s_at.t_account ac, s_at.t_d_info inf) a\n" + 
                "          left join s_at.t_account_info ainf\n" + 
                "            on a.ck_d_info = ainf.ck_d_info and a.ck_id = ainf.ck_account\n" + 
                "          where ainf.cv_value is not null\n" + 
                "         group by a.ck_id) as info\n" + 
                "    on u.ck_id = info.ck_id\n",
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
                                                        this.log.trace(
                                                            `Users ${JSON.stringify(
                                                                users,
                                                            )}`,
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
            .then(() => this.sessCtrl.updateUserInfo(this.name));
    }
}
