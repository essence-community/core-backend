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
import { initParams, isEmpty } from "@ungate/plugininf/lib/util/Util";
import * as ActiveDirectory from "activedirectory";
import { uniq } from "lodash";
import { IAuthController } from "@ungate/plugininf/lib/IAuthController";

const BASIC_PATTERN = "Basic";
const PASSWORD_PATTERN_NGINX_GSS = "bogus_auth_gss_passwd";

export default class AdAuth extends NullAuthProvider {
    public static getParamsInfo(): IParamsInfo {
        return {
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
                required: true,
                type: "string",
            },
            adMapGroups: {
                description:
                    "Мапинг групп AD c Core Экшенами, Пример: NameGroup=900,200;NameGroup=100,215",
                name: "Мапинг групп и экшенов пользователя",
                required: true,
                type: "string",
            },
            adMapUserAttr: {
                defaultValue:
                    "cv_login=sAMAccountName;cv_name=cn;cv_surname=sn;cv_email=mail;cv_cert=userCertificate",
                description:
                    "Пример: cv_login=sAMAccountName;cv_name=cn;cv_surname=sn;cv_email=email;cv_cert=userCertificate",
                name: "Мапинг атрибутов пользователя",
                required: true,
                type: "string",
            },
            adPassword: {
                name: "Пароль УЗ доступа к ldap",
                required: true,
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
        this.params = {
            ...this.params,
            ...initParams(AdAuth.getParamsInfo(), this.params),
        };
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
        ];
        this.params.adMapUserAttr.split(";").forEach((val) => {
            const [bdkey, adkey] = val.split("=");
            this.mapUserAttr[bdkey] = adkey;
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
    /**
     * Проверка на случай если авторизация вынесена на внешний прокси nginx
     *
     * @param gateContext
     * @param sessionId
     * @param session
     */
    public async afterSession(
        gateContext: IContext,
        sessionId: string,
        session: ISession,
    ): Promise<ISession> {
        if (
            isEmpty(session) &&
            gateContext.actionName !== "auth" &&
            gateContext.request.headers.authorization &&
            gateContext.request.headers.authorization.indexOf(BASIC_PATTERN) >
                -1
        ) {
            return new Promise((resolve, reject) => {
                const basic = Buffer.from(
                    gateContext.request.headers.authorization.split(" ")[1],
                    "base64",
                ).toString("ascii");
                const [username, password] = basic.split(":");
                this.log.trace(`Проверка авторизации Basic ${username}`);
                if (password === PASSWORD_PATTERN_NGINX_GSS) {
                    this.log.trace(
                        `Найдена прокси авторизация nginx_gss Basic ${username}`,
                    );
                    this.initSession(gateContext, resolve, reject, username);
                    return;
                }
                this.ad.authenticate(username, password, (err, isAuth) => {
                    if (err || !isAuth) {
                        this.log.warn(
                            err ? err.message : "Invalid password or login",
                        );
                        resolve(session);
                        return;
                    }
                    this.initSession(gateContext, resolve, reject, username);
                });
            });
        }
        return session;
    }
    /**
     * Процесс авторизации
     *
     * @param context
     * @param query
     */
    public async processAuth(
        context: IContext,
        query: IGateQuery,
    ): Promise<IAuthResult> {
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
                        context,
                        resolve,
                        reject,
                        query.inParams.cv_login,
                        true,
                    );
                },
            );
        }).then((user: IObjectParam) => ({
            idUser: user.ck_id,
            dataUser: user,
        }));
    }
    /**
     * Загрузка провайдера
     *
     * @param reload
     */
    public async init(reload?: boolean): Promise<void> {
        const rows = [];
        Object.keys(this.mapGroupActions).forEach((group) => {
            rows.push(
                new Promise((resolve, reject) => {
                    this.log.trace("Cache users...");
                    this.ad.getUsersForGroup(group, (err, users) => {
                        if (err) {
                            reject(err);
                            return;
                        }
                        this.log.trace(
                            `Find users ${
                                users ? JSON.stringify(users) : users
                            }`,
                        );
                        if (!users || users.length) {
                            return;
                        }
                        const addUsers = [];

                        users.forEach((user) => {
                            const data = Object.keys(this.mapUserAttr).reduce(
                                (obj, val) => ({
                                    ...obj,
                                    [val]: user[this.mapUserAttr[val]],
                                }),
                                {
                                    ca_actions: this.getActionUser(
                                        user,
                                        this.listDefaultActions,
                                    ),
                                    ck_id: user.objectSID,
                                    cv_timezone: "+03:00",
                                },
                            );
                            addUsers.push(
                                this.authController.addUser(
                                    data.ck_id,
                                    this.name,
                                    data,
                                ),
                            );
                        });
                        Promise.all(addUsers).then(
                            () => resolve(),
                            (errAdd) => reject(errAdd),
                        );
                    });
                }),
            );
        });
        return Promise.all(rows)
            .then(() => this.authController.updateHashAuth())
            .then(async () => {
                await this.authController.updateUserInfo(this.name);
            });
    }
    /**
     * Инициализация контекста
     *
     * @param context {IContext} Контекст вызова
     * @param query {IQuery} Запрос
     */
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
        return res;
    }
    private initSession(
        context: IContext,
        resolve: any,
        reject: any,
        username: string,
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
                .then(async (userData = {}) => {
                    const data = Object.keys(this.mapUserAttr).reduce(
                        (obj, val) => ({
                            ...obj,
                            [val]: user[this.mapUserAttr[val]],
                        }),
                        {
                            ...userData.data,
                            ca_actions: this.getActionUser(user, [
                                ...(userData.data || {}).ca_actions,
                                ...this.listDefaultActions,
                            ]),
                            ck_id:
                                (userData.data || {}).ck_id || user.objectSID,
                            cv_timezone:
                                (userData.data || {}).cv_timezone || "+03:00",
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
                        context,
                        userData.ck_id || user.objectSID,
                    );
                    if (session) {
                        return resolve(session);
                    }
                    return this.createSession(data.ck_id, data)
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
    /**
     * Мапинг юзера с экшенами
     *
     * @param user
     * @param actions
     */
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
