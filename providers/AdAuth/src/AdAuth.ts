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
import { IAuthProviderParam } from "@ungate/plugininf/lib/NullAuthProvider";

const BASIC_PATTERN = "Basic";
const PASSWORD_PATTERN_NGINX_GSS = "bogus_auth_gss_passwd";

interface IAdAuthParam extends IAuthProviderParam {
    adBaseDN?: string;
    adLogin: string;
    adPassword: string;
    adUrl: string;
    adMapGroups: {
        group: string;
        action: string;
    }[];
    adMapUserAttr: {
        inKey: string;
        outKey: string;
    }[];
}

export default class AdAuth extends NullAuthProvider {
    public static getParamsInfo(): IParamsInfo {
        return {
            adBaseDN: {
                name: "Начальный уровень поиска в ldap",
                type: "string",
            },
            adLogin: {
                name: "Логин УЗ доступа к ldap",
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
            adMapGroups: {
                name: "Мапинг групп и экшенов пользователя",
                required: true,
                type: "form_repeater",
                childs: {
                    group: {
                        type: "string",
                        name: "Group",
                        required: true,
                    },
                    action: {
                        type: "combo",
                        allownew: "new#",
                        query: "MTGetPageAction",
                        displayField: "cn_action",
                        valueField: [{ in: "cn_action" }],
                        querymode: "remote",
                        queryparam: "cn_action",
                        idproperty: "cn_action",
                        name: "Action",
                        required: true,
                    },
                },
            },
            adMapUserAttr: {
                defaultValue: [
                    {
                        inKey: "sAMAccountName",
                        outKey: "cv_login",
                    },
                    {
                        inKey: "cn",
                        outKey: "cv_name",
                    },
                    {
                        inKey: "sn",
                        outKey: "cv_surname",
                    },
                    {
                        inKey: "mail",
                        outKey: "cv_email",
                    },
                    {
                        inKey: "userCertificate",
                        outKey: "cv_cert",
                    },
                ],
                name: "Мапинг атрибутов пользователя",
                required: true,
                type: "form_repeater",
                childs: {
                    inKey: {
                        type: "string",
                        name: "Key ldap",
                        required: true,
                    },
                    outKey: {
                        type: "string",
                        name: "Session key",
                        required: true,
                    },
                },
            },
        };
    }
    public params: IAdAuthParam;
    private ad: ActiveDirectory;
    constructor(
        name: string,
        params: ICCTParams,
        authController: IAuthController,
    ) {
        super(name, params, authController);
        this.params = initParams(AdAuth.getParamsInfo(), this.params);
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
        this.params.adMapUserAttr.forEach(({ inKey }) => {
            if (!userAttr.includes(inKey)) {
                userAttr.push(inKey);
            }
        });
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
        this.params.adMapGroups.forEach(({ group }) => {
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
                            const data = this.params.adMapUserAttr.reduce(
                                (obj, { inKey, outKey }) => ({
                                    ...obj,
                                    [outKey]: user[inKey],
                                }),
                                {
                                    ca_actions: this.getActionUser(user),
                                    ck_id: user.objectSID,
                                },
                            );
                            addUsers.push(
                                this.authController.addUser(
                                    data.ck_id,
                                    this.name,
                                    data as any,
                                    user.sAMAccountName,
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
                                cv_login: username,
                            },
                        ],
                    },
                    true,
                )
                .then(async (userData) => {
                    const data = this.params.adMapUserAttr.reduce(
                        (obj, { inKey, outKey }) => ({
                            ...obj,
                            [outKey]: user[inKey],
                        }),
                        {
                            ...userData.data,
                            ca_actions: this.getActionUser(user, [
                                ...(userData.data || {}).ca_actions,
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
                            user.sAMAccountName,
                        );
                    }
                    if (isUserData) {
                        return resolve(data);
                    }
                    return this.createSession({
                        context,
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
    /**
     * Мапинг юзера с экшенами
     *
     * @param user
     * @param actions
     */
    private getActionUser(user: any, actions?: number[]) {
        return uniq(
            this.params.adMapGroups.reduce(
                (arr, { group, action }) =>
                    user.isMemberOf(group)
                        ? [
                              ...arr,
                              typeof action === "string"
                                  ? parseInt(action.replace("new#", ""), 10)
                                  : action,
                          ]
                        : arr,
                actions,
            ),
        );
        return actions;
    }
}
