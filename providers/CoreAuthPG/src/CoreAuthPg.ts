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
import { ICacheDb, ISessCtrl } from "@ungate/plugininf/lib/ISessCtrl";
import { v4 as uuid } from "uuid";
import { initProcess, sendProcess } from '@ungate/plugininf/lib/util/ProcessSender';
import ILocalDB from "@ungate/plugininf/lib/db/local/ILocalDB";

const MAX_WAIT_RELOAD = 5000;

export interface IParamsProvider extends ISessProviderParam {
    guestAccount?: string;
    addedExternal?: boolean;
}
const QUERY = 
    "/*Login*/\n" + 
    "select u.ck_id, jsonb_build_object('ck_id', u.ck_id,\n" + 
    "                   'cv_login', u.cv_login,\n" + 
    "                   'cv_name', u.cv_name,\n" + 
    "                   'cv_surname', u.cv_surname,\n" + 
    "                   'cv_patronymic', u.cv_patronymic,\n" + 
    "                   'cv_email', u.cv_email,\n" + 
    "                   'ca_actions', (\n" + 
    "                        select jsonb_agg(distinct dra.ck_action) \n" + 
    "                        from s_at.t_account_role ur\n" + 
    "                        join s_at.t_role_action dra on ur.ck_role = dra.ck_role\n" + 
    "                        where ur.ck_account = u.ck_id\n" + 
    "                   ),\n" + 
    "                   'cv_timezone', u.cv_timezone) || coalesce(info.attr, '{}'::jsonb) as json\n" + 
    "  from (\n" + 
    "        select pkg_json_account.f_get_user(:cv_login::varchar, :cv_password::varchar, :cv_token::varchar, 1::smallint) as ck_id\n" + 
    "  ) as t\n" + 
    "  join s_at.t_account u\n" + 
    "    on u.ck_id = t.ck_id::uuid\n" + 
    "  left join (select a.ck_id,\n" + 
    "                jsonb_object_agg(a.ck_d_info, pkg_json_account.f_decode_attr(ainf.cv_value, a.cr_type)) as attr\n" + 
    "          from (select ac.ck_id, inf.ck_id as ck_d_info, inf.cr_type\n" + 
    "                  from s_at.t_account ac, s_at.t_d_info inf) a\n" + 
    "          left join s_at.t_account_info ainf\n" + 
    "            on a.ck_d_info = ainf.ck_d_info and a.ck_id = ainf.ck_account\n" + 
    "          where ainf.cv_value is not null\n" + 
    "         group by a.ck_id) as info\n" + 
    "    on u.ck_id = info.ck_id\n";;

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
            addedExternal: {
                type: "boolean",
                defaultValue: false,
                name: "Added external user"
            },
        };
        /* tslint:enable:object-literal-sort-keys */
    }

    public dataSource: PostgresDB;
    public params: IParamsProvider;

    private dbCache: ILocalDB<ICacheDb>;
    private eventConnect: Connection;
    private syncFlag: Record<string, number> = {};
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
        if (this.params.addedExternal) {
            initProcess({
                addUser: (data) => {
                    if (data.nameProvider == this.name || (this.syncFlag[`${data.nameProvider}:${data.idUser}`] || 0) > 0) {
                        return;
                    }
                    setTimeout(
                        () => this.syncExternalAuthUserInfo(data.idUser, data.nameProvider, data.data), process.env.UNGATE_HTTP_ID != "1" ? (parseInt(process.env.UNGATE_HTTP_ID, 10) * 10 + 300) : 0,
                    );
                },
                [`maskAddUser${this.name}`]: (data) => this.syncFlag[data.id] = (this.syncFlag[data.id] || 0) + 1,
                [`unMaskAddUser${this.name}`]: (data) => this.syncFlag[data.id] = (this.syncFlag[data.id] || 0) - 1,
            }, "cluster", false);
        }

    }
    public async afterSession(
        context: IContext,
        sessionId?: string,
        session?: ISession,
    ): Promise<ISession> {
        if (session) {
            return session;
        }
        const header = context.request.headers.authorization || "";
        if (header.substring(0, 6).toLowerCase().startsWith("basic")) {
            const basic = Buffer.from(
                    header.substring(6),
                    "base64",
            ).toString("ascii");
            const split = basic.indexOf(":");
            return this.getSession(context, {
                cv_login: basic.substring(0, split),
                cv_password: basic.substring(split+1),
            });
        } else if (header.substring(0, 6).toLowerCase().startsWith("token")) {
            return this.getSession(context, {
                cv_token: header.substring(6)
            });
        }

        if (!isEmpty(this.params.guestAccount) && context.params.connect_guest === "true") {
            const { session: sessGuest }: any =
                await this.createSession({
                    context,
                    idUser: this.params.guestAccount,
                    userData: {} as any,
                });
            return this.sessCtrl.loadSession(sessGuest);
        }

        return session;
    }
    private async getSession(context: IContext, param: Record<string, string>) {
        const res = await this.dataSource.executeStmt(
            QUERY,
            null,
            param,
            null,
            {
                resultSet: true,
            },
        );
        const arr = await ReadStreamToArray(res.stream);
        if (isEmpty(arr) || isEmpty(arr[0].ck_id)) {
            this.log.warn("Invalid login and password");
            throw new ErrorException(ErrorGate.AUTH_UNAUTHORIZED);
        }
        let userData = arr[0];
        if (!isEmpty(userData.json)) {
            userData = {
                ...userData,
                ...(typeof userData.json === "object" ? userData.json : JSON.parse(userData.json)),
            };
        }

        const { session: sessGuest }: any =
                await this.createSession({
                    context,
                    idUser: userData.ck_id,
                    userData,
                });
        return this.sessCtrl.loadSession(sessGuest);
    }
    private async syncExternalAuthUserInfo(
        idUser: string,
        nameProvider: string,
        data: Record<string, any>
    ) {
        if ((this.syncFlag[`${nameProvider}:${idUser}`] || 0) > 0) {
            return;
        }
        this.log.debug("syncExternalAuthUserInfo process %s before:\nidUser:%s\nnameProvider:%s\ndata:%j", process.env.UNGATE_HTTP_ID, idUser, nameProvider, data);
        sendProcess({
            command: `maskAddUser${this.name}`,
            data: { id: `${nameProvider}:${idUser}` },
            target: "cluster",
        });
        await this.dataSource
            .executeStmt(
                "select\n" +
                "    pkg_json_account.f_modify_account(t.ck_account_ext, t.ck_account_ext, jsonb_build_object(\n" +
                "        'data',\n" +
                "        :data::jsonb || jsonb_build_object(\n" +
                "            'ck_id',\n" +
                "            case\n" +
                "                when tae.ck_id is null then public.uuid_generate_v4()::varchar\n" +
                "                else ta.ck_id::varchar\n" +
                "            end,\n" +
                "            'cv_hash_password',\n" +
                "            case\n" +
                "                when tae.ck_id is null then public.uuid_generate_v4()::varchar\n" +
                "                else ta.cv_hash_password::varchar\n" +
                "            end,\n" +
                "            'ck_account_ext',\n" +
                "            t.ck_account_ext,\n" +
                "            'ck_provider_ext',\n" +
                "            t.ck_provider_ext\n" +
                "        ),\n" +
                "        'service',\n" +
                "        jsonb_build_object(\n" +
                "            'cv_action',\n" +
                "            case\n" +
                "                when tae.ck_id is null then 'I'\n" +
                "                else 'U'\n" +
                "            end\n" +
                "        )\n" +
                "    )) as result\n" +
                "from\n" +
                "    (\n" +
                "        select\n" +
                "            :ck_account_ext::varchar as ck_account_ext,\n" +
                "            :ck_provider_ext::varchar as ck_provider_ext\n" +
                "    ) as t\n" +
                "left join s_at.t_account_ext tae \n" +
                "on\n" +
                "    tae.ck_account_ext = t.ck_account_ext\n" +
                "    and tae.ck_provider = t.ck_provider_ext\n" +
                "left join s_at.t_account ta \n" +
                "on tae.ck_account_int = ta.ck_id \n" +
                "where ta.ck_id is null or (ta.ck_id is not null and (ta.ct_change + interval '5' minute) < now())\n",
                null,
                {
                    data: JSON.stringify(data),
                    ck_account_ext: idUser,
                    ck_provider_ext: nameProvider,
                },
                {},
                { autoCommit: true, }
            )
            .then(async (res) => {
                const row = await ReadStreamToArray(res.stream);
                this.log.debug("syncExternalAuthUserInfo after:\nidUser:%s\nnameProvider:%s\nresult:%j", idUser, nameProvider, row);
            }, (err) => this.log.error(err))
            .finally(() => {
                setTimeout(() => {
                    sendProcess({
                        command: `unMaskAddUser${this.name}`,
                        data: { id: `${nameProvider}:${idUser}` },
                        target: "cluster",
                    });
                    this.syncFlag[`${nameProvider}:${idUser}`] = 0;
                }, 5000);

            });
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
            throw new ErrorException(ErrorGate.AUTH_UNAUTHORIZED);
        }
        let dataUser = arr[0];
        if (!isEmpty(dataUser.json)) {
            dataUser = {
                ...dataUser,
                ...(typeof dataUser.json === "object" ? dataUser.json : JSON.parse(dataUser.json)),
            };
        }
        return {
            idUser: dataUser.ck_id,
            dataUser: dataUser,
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
        if (!this.dbCache) {
            this.dbCache = this.sessCtrl.getCacheDb();
        }
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
                query.queryStr = QUERY
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
    private async initTemp() {
        const users = {};
        this.log.trace("Cache users...");
        await this.dataSource
            .executeStmt(
                "select\n" +
                "    tr.cv_name as role,\n" +
                "    jsonb_agg(tra.ck_action)::text as ca_action\n" +
                "from\n" +
                "    s_at.t_role tr\n" +
                "join s_at.t_role_action tra\n" +
                "on\n" +
                "    tr.ck_id = tra.ck_role\n" +
                "group by\n" +
                "    tr.cv_name\n",
                null,
                null,
                null,
                {
                    resultSet: true,
                },
            )
            .then(async (res) => {
                const rows = await ReadStreamToArray(res.stream);
                return this.dbCache.insert({
                    ck_id: "role_user",
                    ...(rows.reduce((res, value) => {
                        res[value.role] = typeof value.ca_action === "string" ? JSON.parse(value.ca_action) : value.ca_action;
                        return res;
                    }, {}))
                });
            });
        return this.dataSource
            .executeStmt(
                "select jsonb_build_object('ck_id', case when tae.ck_id is null then u.ck_id::varchar else tae.ck_account_ext end,\n" +
                "                   'cv_login', u.cv_login,\n" +
                "                   'cv_name', u.cv_name,\n" +
                "                   'cv_surname', u.cv_surname,\n" +
                "                   'cv_patronymic', u.cv_patronymic,\n" +
                "                   'cv_email', u.cv_email,\n" +
                "                   'ck_provider_ext', tae.ck_provider,\n" +
                "                   'cv_timezone', u.cv_timezone) || coalesce(info.attr, '{}'::jsonb) as json\n" +
                "  from s_at.t_account u\n" +
                "  left join s_at.t_account_ext tae\n" +
                "    on tae.ck_account_int = u.ck_id\n" +
                "  left join (select a.ck_id,\n" +
                "                jsonb_object_agg(a.ck_d_info, pkg_json_account.f_decode_attr(ainf.cv_value, a.cr_type)) as attr\n" +
                "          from (select ac.ck_id, inf.ck_id as ck_d_info, inf.cr_type\n" +
                "                  from s_at.t_account ac, s_at.t_d_info inf) a\n" +
                "          left join s_at.t_account_info ainf\n" +
                "            on a.ck_d_info = ainf.ck_d_info and a.ck_id = ainf.ck_account\n" +
                "          where ainf.cv_value is not null\n" +
                "         group by a.ck_id) as info\n" +
                "    on u.ck_id = info.ck_id\n" +
                "    where u.cl_deleted = 0\n",
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
                                : JSON.parse(chunk.json);
                            users[row.ck_id] = {
                                ...row,
                                ca_actions: [],
                                type_auth_provider: 'COREAUTHPG',
                            };
                        });
                        resUser.stream.on("end", () => {
                            this.dataSource
                                .executeStmt(
                                    "select distinct case when tae.ck_id is null then t.ck_account::varchar else tae.ck_account_ext end as ck_account, t.ck_action from (\n" +
                                    " select ur.ck_account, dra.ck_action\n" +
                                    "  from t_account_role ur\n" +
                                    "  join t_role_action dra on ur.ck_role = dra.ck_role\n" +
                                    " union all\n" +
                                    " select ta.ck_account, ta.ck_action from t_account_action ta \n" +
                                    ") as t" +
                                    "  join s_at.t_account ta\n" +
                                    "    on ta.ck_id = t.ck_account\n" +
                                    "  left join s_at.t_account_ext tae\n" +
                                    "    on tae.ck_account_int = t.ck_account\n" +
                                    "    where ta.cl_deleted = 0\n",
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
                    Object.values(users).map((user) => {
                        const ck_provider_ext = (user as any).ck_provider_ext;
                        delete (user as any).ck_provider_ext;
                        return this.sessCtrl.addUser(
                            (user as any).ck_id,
                            ck_provider_ext || this.name,
                            user as any,
                            (user as any).cv_login,
                            ck_provider_ext ? false : true,
                        )
                    }),
                ),
            )
            .then(() => this.sessCtrl.updateHashAuth());
    }
}
