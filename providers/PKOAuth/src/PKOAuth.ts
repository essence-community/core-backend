import Connection from "@ungate/plugininf/lib/db/Connection";
import ILocalDB from "@ungate/plugininf/lib/db/local/ILocalDB";
import PostgresDB from "@ungate/plugininf/lib/db/postgres";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import ICCTParams, { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import IContext from "@ungate/plugininf/lib/IContext";
import IObjectParam from "@ungate/plugininf/lib/IObjectParam";
import IQuery from "@ungate/plugininf/lib/IQuery";
import { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import ISession from "@ungate/plugininf/lib/ISession";
import NullAuthProvider, {
    IAuthResult,
} from "@ungate/plugininf/lib/NullAuthProvider";
import { ReadStreamToArray } from "@ungate/plugininf/lib/stream/Util";
import { initParams, isEmpty } from "@ungate/plugininf/lib/util/Util";
import * as ActiveDirectory from "activedirectory";
import { X509 } from "jsrsasign";
import { isObject, uniq } from "lodash";
import { IAuthController } from "@ungate/plugininf/lib/IAuthController";
import { IUserDbData } from "@ungate/plugininf/lib/ISession";

const BASIC_PATTERN = "Basic";
const PASSWORD_PATTERN_NGINX_GSS = "bogus_auth_gss_passwd";

export default class PKOAuth extends NullAuthProvider {
    public static getParamsInfo(): IParamsInfo {
        return {
            ...PostgresDB.getParamsInfo(),
            adBaseDN: {
                name: "Начальный уровень поиска в ldap",
                type: "string",
            },
            adDefaultAction: {
                description:
                    "Список экшенов которые назначаются любому авторизованому пользователю",
                name: "Список экшенов по умолчанию",
                type: "string",
            },
            adLogin: {
                name: "Логин УЗ доступа к ldap",
                type: "string",
            },
            adMapGroups: {
                description:
                    "Мапинг групп AD c Core Экшенами, Пример: NameGroup=900,200;NameGroup=100,215",
                name: "Мапинг групп и экшенов пользователя",
                type: "string",
            },
            adMapUserAttr: {
                defaultValue:
                    "cv_login=sAMAccountName;cv_name=cn;cv_surname=sn;cv_email=mail;cv_cert=userCertificate",
                description:
                    "Пример: cv_login=sAMAccountName;cv_name=cn;cv_surname=sn;cv_email=email;cv_cert=userCertificate",
                name: "Мапинг атрибутов пользователя",
                type: "string",
            },
            adPassword: {
                name: "Пароль УЗ доступа к ldap",
                type: "password",
            },
            adUrl: {
                description: "Пример: ldap://dc.domain.com",
                name: "Урл к ldap",
                required: true,
                type: "string",
            },
        };
    }

    public dataSource: PostgresDB;
    private ad: ActiveDirectory;
    private mapUserAttr: IObjectParam = {};
    private mapGroupActions: IObjectParam = {};
    private listDefaultActions: number[] = [];
    constructor(
        name: string,
        params: ICCTParams,
        authController: IAuthController,
    ) {
        super(name, params, authController);
        this.params = initParams(PKOAuth.getParamsInfo(), this.params);
        this.dataSource = new PostgresDB(`${this.name}_provider`, {
            connectString: this.params.connectString,
            connectionTimeoutMillis: this.params.connectionTimeoutMillis,
            idleTimeoutMillis: this.params.idleTimeoutMillis,
            partRows: this.params.partRows,
            poolMax: this.params.poolMax,
            poolMin: this.params.poolMin,
            user: this.params.user,
            password: this.params.password,
            queryTimeout: this.params.queryTimeout,
        });
        const userAttr = [
            "dn",
            "sAMAccountName",
            "objectSID",
            "mail",
            "sn",
            "givenName",
            "initials",
            "cn",
            "displayName",
            "comment",
            "description",
            "userCertificate",
        ];
        this.params.adMapUserAttr.split(";").forEach((val) => {
            const [bdkey, adkey] = val.split("=");
            this.mapUserAttr[adkey] = bdkey;
            if (!userAttr.includes(adkey)) {
                userAttr.push(adkey);
            }
        });
        if (this.params.adMapGroups) {
            this.params.adMapGroups.split(";").forEach((val) => {
                const [bdkey, adkey] = val.split("=");
                this.mapGroupActions[bdkey] = adkey
                    .split(",")
                    .map((action) => parseInt(action, 10));
            });
        }
        if (this.params.adDefaultAction) {
            this.listDefaultActions = this.params.adDefaultAction
                .split(",")
                .map((val) => parseInt(val, 10));
        }
        this.ad = new ActiveDirectory({
            attributes: {
                user: userAttr,
            },
            baseDN: this.params.adBaseDN,
            password: this.params.adPassword,
            url: this.params.adUrl,
            username: this.params.adLogin,
        });
    }
    public async afterSession(
        gateContext: IContext,
        sessionId: string,
        session: ISession,
    ): Promise<ISession> {
        if (
            isEmpty(session) &&
            gateContext.actionName !== "auth" &&
            gateContext.request.headers.authorization &&
            gateContext.request.headers["forwarded-ssl-client-m-serial"] &&
            gateContext.request.headers.authorization.indexOf(BASIC_PATTERN) >
                -1
        ) {
            return new Promise((resolve, reject) => {
                const basic = Buffer.from(
                    gateContext.request.headers.authorization.split(" ")[1],
                    "base64",
                ).toString("ascii");
                const [username, password] = basic.split(":");
                if (password === PASSWORD_PATTERN_NGINX_GSS) {
                    this.initSession(resolve, reject, username, gateContext);
                    return;
                }
                this.ad.authenticate(username, password, (err, isAuth) => {
                    if (err || !isAuth) {
                        this.log.error(
                            err ? err.message : "Invalid password or login",
                        );
                        reject(new ErrorException(ErrorGate.AUTH_DENIED));
                        return;
                    }
                    this.initSession(resolve, reject, username, gateContext);
                });
            });
        }
        return session;
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
        if (isEmpty(arr)) {
            return new Promise((resolve, reject) => {
                this.ad.authenticate(
                    query.inParams.cv_login,
                    query.inParams.cv_password,
                    (err, isAuth) => {
                        if (err || !isAuth) {
                            this.log.error(
                                err ? err.message : "Invalid password or login",
                            );
                            reject(new ErrorException(ErrorGate.AUTH_DENIED));
                            return;
                        }
                        this.initSession(
                            resolve,
                            reject,
                            query.inParams.cv_login,
                            context,
                            true,
                        );
                    },
                );
            }).then((user: IObjectParam) => ({
                idUser: user.ck_id,
                dataUser: user,
            }));
        }
        return {
            idUser: arr[0].ck_id,
            dataUser: arr[0],
        };
    }
    public async init(reload?: boolean): Promise<void> {
        await this.dataSource.createPool();
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
    private initSession(
        resolve: any,
        reject: any,
        username: string,
        gateContext: IContext,
        isUserData: boolean = false,
    ): void {
        this.ad.findUser(username, (err, user) => {
            if (err || !user) {
                this.log.error(
                    err ? err.message : `Not found user ${username}`,
                    err,
                );
                reject(new ErrorException(ErrorGate.AUTH_DENIED));
                return;
            }
            if (isEmpty(user.userCertificate)) {
                this.log.error(
                    "User not valid certificate %j, userCertificate not pem",
                    user,
                );
                reject(new ErrorException(ErrorGate.AUTH_DENIED));
                return;
            }
            const x509 = new X509();
            try {
                x509.readCertPEM(user.userCertificate);
            } catch (e) {
                this.log.error("User not valid certificate %j", user, e);
                reject(new ErrorException(ErrorGate.AUTH_DENIED));
                return;
            }
            if (
                x509.getSerialNumberHex().toLocaleUpperCase() !==
                (gateContext.request.headers[
                    "forwarded-ssl-client-m-serial"
                ] as string).toLocaleUpperCase()
            ) {
                this.log.error(
                    `Not valid certificate Serial-In-AD: ${x509
                        .getSerialNumberHex()
                        .toLocaleUpperCase()}, Serial-Forwarded: ${(gateContext
                        .request.headers[
                        "forwarded-ssl-client-m-serial"
                    ] as string).toLocaleUpperCase()}`,
                );
                reject(new ErrorException(ErrorGate.AUTH_DENIED));
                return;
            }
            this.authController
                .getUserDb()
                .findOne(
                    {
                        $and: [
                            {
                                ck_d_provider: this.name,
                            },
                            {
                                "data.cv_login": username,
                            },
                        ],
                    },
                    true,
                )
                .then(async (userData) => {
                    const data = Object.keys(this.mapUserAttr).reduce(
                        (obj, val) => ({
                            ...obj,
                            [this.mapUserAttr[val]]: user[val],
                        }),
                        {
                            ...userData.data,
                            ca_actions: this.getActionUser(user, [
                                ...(userData.data || {}).ca_actions,
                                ...this.listDefaultActions,
                            ]),
                            ck_id:
                                (userData.data || {}).ck_id || user.objectSID,
                        },
                    );
                    if (!(userData.data || {}).ck_id) {
                        await this.authController.addUser(
                            data.ck_id,
                            this.name,
                            data,
                        );
                    }
                    if (isUserData) {
                        return resolve(data);
                    }
                    const session = await this.authController.loadSession(
                        gateContext,
                        userData.ck_id || user.objectSID,
                    );
                    if (session) {
                        return resolve(session);
                    }
                    return this.createSession({
                        context: gateContext,
                        idUser: data.ck_id,
                        userData: data,
                    })
                        .then((res) =>
                            this.authController.loadSession(res.session),
                        )
                        .then((sess) => resolve(sess));
                })
                .catch((errFind) => {
                    this.log.error(errFind.message, errFind);
                    reject(new ErrorException(ErrorGate.AUTH_DENIED));
                });
        });
    }
    private getActionUser(user: any, actions?: number[]) {
        const groups = Object.keys(this.mapGroupActions);
        if (groups.length) {
            return uniq(
                groups.reduce(
                    (arr, group) =>
                        user.isMemberOf(group)
                            ? [...arr, this.mapGroupActions[group]]
                            : arr,
                    actions,
                ),
            );
        }
        return actions;
    }
}
