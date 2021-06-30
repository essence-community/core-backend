import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import ICCTParams, { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import IContext from "@ungate/plugininf/lib/IContext";
import IQuery from "@ungate/plugininf/lib/IQuery";
import { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import ISession, { IUserData } from "@ungate/plugininf/lib/ISession";
import NullAuthProvider, {
    IAuthResult,
} from "@ungate/plugininf/lib/NullAuthProvider";
import { initParams, isEmpty } from "@ungate/plugininf/lib/util/Util";
import { IAuthController } from "@ungate/plugininf/lib/IAuthController";
import * as KeyClock from "keycloak-connect";
import { IKeyClockAuthParams, IRequestExtra } from "./KeyClockAuth.types";
import * as QueryString from "query-string";
import * as URL from "url";
import { Admin, GrantAttacher, PostAuth } from "./Midleware";
import BreakException from "@ungate/plugininf/lib/errors/BreakException";
import ResultStream from "@ungate/plugininf/lib/stream/ResultStream";
import * as fs from "fs";

const FLAG_REDIRECT = "jl_keyclock_auth_callback";
const USE_REDIRECT = "jl_keyclock_use_redirect";
const PATH_CALLBACK = "jv_keyclock_path_callback";
const TOKEN_KEY = "keycloak-token";

export default class KeyClockAuth extends NullAuthProvider {
    public async init(reload?: boolean): Promise<void> {
        return;
    }
    public static getParamsInfo(): IParamsInfo {
        return {
            redirectUrl: {
                name: "Redirect Url",
                type: "string",
                required: true,
            },
            keyClockParamName: {
                name: "KeyClock param key use front",
                type: "string",
                required: true,
                defaultValue: "jt_keycloack",
            },
            keyClockConfig: {
                name: "KeyClockConfig",
                type: "form_nested",
                childs: {
                    "auth-server-url": {
                        name: "URL Keyckock Server",
                        type: "string",
                        required: true,
                    },
                    realm: {
                        name: "Realm",
                        type: "string",
                        required: true,
                    },
                    resource: {
                        name: "Client ID | Resource",
                        type: "string",
                        required: true,
                    },
                    "ssl-required": {
                        name: "SSL Require",
                        type: "string",
                        defaultValue: "external",
                    },
                    secret: {
                        name: "Secret",
                        type: "string",
                    },
                    "public-client": {
                        name: "Public client",
                        type: "boolean",
                        defaultValue: true,
                    },
                    "bearer-only": {
                        name: "Bearer only",
                        type: "boolean",
                        defaultValue: false,
                    },
                    "confidential-port": {
                        name: "Confidential port",
                        type: "string",
                        defaultValue: "0",
                    },
                    "min-time-between-jwks-requests": {
                        name: "Min time between jwks requests",
                        type: "integer",
                        defaultValue: 10,
                    },
                    "realm-public-key": {
                        name: "Realm public key",
                        type: "string",
                    },
                },
            },
            mapKeyClockGrant: {
                type: "form_repeater",
                name: "Grant Map",
                childs: {
                    grant: {
                        type: "string",
                        name: "Grant",
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
            mapKeyClockUserInfo: {
                type: "form_repeater",
                name: "UserInfo Map",
                childs: {
                    in: {
                        type: "string",
                        name: "Key KeyClock",
                        required: true,
                    },
                    out: {
                        type: "string",
                        name: "Key Session",
                        required: true,
                    },
                },
            },
        };
    }
    public params: IKeyClockAuthParams;
    private keyClock: KeyClock.Keycloak;
    constructor(
        name: string,
        params: ICCTParams,
        authController: IAuthController,
    ) {
        super(name, params, authController);
        this.params = initParams(KeyClockAuth.getParamsInfo(), this.params);
        if (
            this.params.keyClockConfig["realm-public-key"] &&
            fs.existsSync(this.params.keyClockConfig["realm-public-key"])
        ) {
            this.params.keyClockConfig["realm-public-key"] = fs
                .readFileSync(this.params.keyClockConfig["realm-public-key"])
                .toString();
        }
        if (this.params.keyClockConfig["realm-public-key"]) {
            this.params.keyClockConfig[
                "realm-public-key"
            ] = this.params.keyClockConfig["realm-public-key"]
                .replace("-----BEGIN PUBLIC KEY-----\n", "")
                .replace("-----END PUBLIC KEY-----", "")
                .trim();
        }
        Object.entries(this.params.keyClockConfig).forEach(([key, value]) => {
            if (isEmpty(value)) {
                delete this.params.keyClockConfig[key];
            }
        });
        this.keyClock = new KeyClock(
            {
                store: this.authController.getSessionStore(),
            },
            this.params.keyClockConfig,
        );
        this.keyClock.storeGrant = function (grant, request, response) {
            if (this.stores.length < 2 || this.stores[0].get(request)) {
                return;
            }
            if (!grant) {
                return;
            }

            this.stores[1].wrap(grant);
            (grant as any).store(request, response);
            return grant;
        };
        this.keyClock.storeGrant.bind(this.keyClock);
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
            gateContext.params[this.params.keyClockParamName] ||
            gateContext.params[FLAG_REDIRECT] === "1"
        ) {
            gateContext.debug("KeyClock login");
            let data;
            if (gateContext.params[this.params.keyClockParamName]) {
                data = JSON.parse(
                    gateContext.params[this.params.keyClockParamName],
                );
                data.query = QueryString.parse(data.query);
            } else {
                data = {
                    query: QueryString.parse(
                        (gateContext.request as any)._parsedUrl.query,
                    ),
                };
            }
            (gateContext.request as IRequestExtra).kauth = {};
            const redirectUrl = URL.parse(this.params.redirectUrl, true);
            redirectUrl.query[FLAG_REDIRECT] = "1";
            gateContext.request.session.auth_redirect_uri = URL.format(
                redirectUrl,
            );
            await PostAuth(gateContext, this.keyClock, data);
            delete gateContext.request.session.auth_redirect_uri;
            if (!(gateContext.request as IRequestExtra).kauth.grant) {
                return this.redirectAccess(gateContext);
            }

            const grant = (gateContext.request as IRequestExtra).kauth.grant;
            const dataUser = {
                ca_actions: [],
                ck_id: (grant.access_token as any).content.sub,
            } as IUserData;
            const userInfo = await this.keyClock.grantManager.userInfo(
                grant.access_token,
            );
            this.params.mapKeyClockUserInfo.forEach((obj) => {
                if (isEmpty(userInfo[obj.in])) {
                    dataUser[obj.out] = userInfo[obj.in];
                }
                if (
                    (grant.access_token as any).content &&
                    isEmpty((grant.access_token as any).content[obj.in])
                ) {
                    dataUser[obj.out] = (grant.access_token as any).content[
                        obj.in
                    ];
                }
            });
            if (typeof dataUser.ca_actions === "string") {
                dataUser.ca_actions = (dataUser.ca_actions as string).startsWith(
                    "[",
                )
                    ? JSON.parse(dataUser.ca_actions)
                    : dataUser.ca_actions;
            }
            if (!Array.isArray(dataUser.ca_actions)) {
                dataUser.ca_actions = [];
            }
            this.params.mapKeyClockGrant.forEach((obj) => {
                if (grant.access_token.hasRole(obj.grant)) {
                    dataUser.ca_actions.push(
                        typeof obj.action === "string"
                            ? parseInt(
                                  obj.action.replace("new#", "") as any,
                                  10,
                              )
                            : obj.action,
                    );
                }
            });
            await this.authController.addUser(
                dataUser.ck_id,
                this.name,
                dataUser,
            );
            await this.authController.updateHashAuth();
            const sess = await this.createSession(
                gateContext,
                dataUser.ck_id,
                dataUser,
                this.params.sessionDuration,
            );
            if (sess) {
                throw new BreakException({
                    type: "success",
                    data: ResultStream(sess),
                });
            } else {
                return this.redirectAccess(gateContext);
            }
        } else if (gateContext.params[PATH_CALLBACK]) {
            gateContext.debug("KeyClock Admin");
            (gateContext.request as IRequestExtra).kauth = {};
            await Admin(
                gateContext,
                this.keyClock,
                gateContext.params[PATH_CALLBACK],
            );
            throw new BreakException("break");
        } else if (gateContext.request.session[TOKEN_KEY]) {
            gateContext.debug("KeyClock Init grant");
            (gateContext.request as IRequestExtra).kauth = {};

            return GrantAttacher(gateContext, this.keyClock)
                .then(async () => {
                    if (
                        session &&
                        !(gateContext.request as IRequestExtra).kauth.grant
                    ) {
                        throw new Error("Not Auth");
                    }
                    const grant = (gateContext.request as IRequestExtra).kauth
                        .grant;
                    const dataUser = {
                        ca_actions: [],
                        ck_id: (grant.access_token as any).content.sub,
                    } as IUserData;

                    const userInfo = await this.keyClock.grantManager.userInfo(
                        grant.access_token,
                    );
                    this.params.mapKeyClockUserInfo.forEach((obj) => {
                        if (isEmpty(userInfo[obj.in])) {
                            dataUser[obj.out] = userInfo[obj.in];
                        }
                        if (
                            (grant.access_token as any).content &&
                            isEmpty((grant.access_token as any).content[obj.in])
                        ) {
                            dataUser[
                                obj.out
                            ] = (grant.access_token as any).content[obj.in];
                        }
                    });
                    if (typeof dataUser.ca_actions === "string") {
                        dataUser.ca_actions =
                            (dataUser.ca_actions as string).startsWith("[") &&
                            (dataUser.ca_actions as string).startsWith("]")
                                ? JSON.parse(dataUser.ca_actions)
                                : dataUser.ca_actions;
                    }
                    if (!Array.isArray(dataUser.ca_actions)) {
                        dataUser.ca_actions = [];
                    }
                    this.params.mapKeyClockGrant.forEach((obj) => {
                        if (grant.access_token.hasRole(obj.grant)) {
                            dataUser.ca_actions.push(
                                typeof obj.action === "string"
                                    ? parseInt(
                                          obj.action.replace("new#", "") as any,
                                          10,
                                      )
                                    : obj.action,
                            );
                        }
                    });
                    session.userData = {
                        ...session.userData,
                        dataUser,
                    };
                    await this.authController.addUser(
                        dataUser.ck_id,
                        this.name,
                        dataUser,
                    );
                    this.authController.updateUserInfo(
                        this.name,
                        dataUser.ck_id,
                    );
                    return session;
                })
                .catch(async () => {
                    await this.authController.logoutSession(gateContext);
                    return null;
                });
        }
        return session;
    }
    private async redirectAccess(context: IContext): Promise<any> {
        const redirectUrl = URL.parse(this.params.redirectUrl, true);
        redirectUrl.query[FLAG_REDIRECT] = "1";
        const loginUrl = this.keyClock.loginUrl(
            context.request.session.id,
            URL.format(redirectUrl),
        );
        if (context.params[USE_REDIRECT] === "1") {
            context.response.writeHead(302, {
                Location: loginUrl,
            });
            context.response.end();
            throw new BreakException("break");
        }
        throw new ErrorException(ErrorGate.REDIRECT_MESSAGE(loginUrl));
    }
    public async checkQuery(
        context: IContext,
        query: IGateQuery,
    ): Promise<void> {
        if (query.needSession && !context.session) {
            return this.redirectAccess(context);
        }
        return;
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
        return this.redirectAccess(context);
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
        if (context.actionName !== "auth") {
            throw new ErrorException(ErrorGate.UNSUPPORTED_METHOD);
        }
        return res;
    }
}
