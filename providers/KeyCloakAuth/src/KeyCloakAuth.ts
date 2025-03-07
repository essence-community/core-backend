import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import ICCTParams, { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import IContext from "@ungate/plugininf/lib/IContext";
import IQuery from "@ungate/plugininf/lib/IQuery";
import { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import ISession, { IUserData } from "@ungate/plugininf/lib/ISession";
import NullSessProvider, {
    IAuthResult,
} from "@ungate/plugininf/lib/NullSessProvider";
import { initParams, isEmpty } from "@ungate/plugininf/lib/util/Util";
import { ICacheDb, ISessCtrl } from "@ungate/plugininf/lib/ISessCtrl";
import * as KeyCloak from "keycloak-connect";
import { IKeyCloakAuthParams, IRequestExtra } from "./KeyCloakAuth.types";
import * as QueryString from "qs";
import * as URL from "url";
import { Admin, GrantAttacher, PostAuth } from "./Midleware";
import BreakException from "@ungate/plugininf/lib/errors/BreakException";
import ResultStream from "@ungate/plugininf/lib/stream/ResultStream";
import { uniq, forEach } from 'lodash';
import * as fs from "fs";
import { Constant } from "@ungate/plugininf/lib/Constants";
import * as Token from "keycloak-connect/middleware/auth-utils/token";
import { GrantManager } from "./util/GrantManager";
import * as crypto from 'crypto';
import { Agent as HttpsAgent, AgentOptions } from "https";
import { Agent as HttpAgent } from "http";
import ILocalDB from "@ungate/plugininf/lib/db/local/ILocalDB";

const FLAG_REDIRECT = "jl_keycloak_auth_callback";
const USE_REDIRECT = "jl_keycloak_use_redirect";
const PATH_CALLBACK = "jv_keycloak_path_callback";
const TOKEN_KEY = "keycloak-token";

export default class KeyCloakAuth extends NullSessProvider {
    public async init(reload?: boolean): Promise<void> {
        if (!this.dbCache) {
            this.dbCache = this.sessCtrl.getCacheDb();
        }
        return;
    }
    public static getParamsInfo(): IParamsInfo {
        return {
            redirectUrl: {
                name: "Redirect Url",
                type: "string",
                required: true,
            },
            keyCloakParamName: {
                name: "KeyCloak param key use front",
                type: "string",
                required: true,
                defaultValue: "jt_keycloak",
            },
            grantManagerConfig: {
                name: "manager",
                type: "form_nested",
                childs: {
                    clientId: {
                        name: "Client ID | Resource",
                        type: "string",
                        required: true,
                    },
                    realmUrl: {
                        name: "URL Realm",
                        type: "string",
                    },
                    proxyUrl: {
                        name: "Proxy URL Realm",
                        type: "string",
                    },
                    userInfoUrl: {
                        name: "URL User Info",
                        type: "string",
                    },
                    tokenUrl: {
                        name: "URL Token",
                        type: "string",
                    },
                    tokenVerifyUrl: {
                        name: "URL Token Verification",
                        type: "string",
                    },
                    secret: {
                        name: "Secret",
                        type: "password",
                    },
                    publicKey: {
                        name: "Realm public key",
                        type: "long_string",
                    },
                    public: {
                        name: "Public client",
                        type: "boolean",
                        defaultValue: false,
                    },
                    bearerOnly: {
                        name: "Bearer only",
                        type: "boolean",
                        defaultValue: true,
                    },
                    verifyTokenAudience: {
                        name: "Verify Token Audience",
                        type: "boolean",
                        defaultValue: true,
                    },
                    isIgnoreCheckSignature: {
                        name: "Ignore check sig",
                        type: "boolean"
                    },
                    scope: {
                        name: "Scope",
                        description: "Example: openid profile",
                        type: "string",
                    },
                    idpHint: {
                        name: "kc_idp_hint login url",
                        type: "string",
                    },
                },
            },
            mapKeyCloakGrantRole: {
                type: "form_repeater",
                name: "Grant Map Role",
                childs: {
                    grant: {
                        type: "string",
                        name: "Grant",
                        required: true,
                    },
                    role: {
                        type: "string",
                        name: "Role",
                        required: true,
                    },
                },
            },
            mapKeyCloakUserInfo: {
                type: "form_repeater",
                name: "UserInfo Map",
                childs: {
                    in: {
                        type: "string",
                        name: "Key KeyCloak",
                        required: true,
                    },
                    out: {
                        type: "string",
                        name: "Key Session",
                        required: true,
                    },
                },
                defaultValue: [
                    {
                        in: "sub",
                        out: "ck_id",
                    },
                    {
                        in: "given_name",
                        out: "cv_name",
                    },
                    {
                        in: "name",
                        out: "cv_full_name",
                    },
                    {
                        in: "preferred_username",
                        out: "cv_login",
                    },
                    {
                        in: "family_name",
                        out: "cv_surname",
                    },
                    {
                        in: "email",
                        out: "cv_email",
                    },
                ],
            },
            disableRecursiveAuth: {
                type: "boolean",
                defaultValue: true,
                name: "Disable recursive auth",
            },
            flagRedirect: {
                type: "string",
                defaultValue: FLAG_REDIRECT,
                name: "Flag Redirect Param",
            },
            adminPathParam: {
                type: "string",
                defaultValue: PATH_CALLBACK,
                name: "Admin path parameter",
            },
            idKey: {
                defaultValue: "sub",
                name: "Наименование ключа индетификации",
                type: "string",
            },
            httpsAgent: {
                name: "Настройки https agent",
                type: "long_string",
            },
            isSaveToken: {
                name: "Save token",
                type: "boolean",
                defaultValue: false,
            },
            mapKeyCloakGrant: {
                type: "form_repeater",
                name: "Grant Map Action",
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
        };
    }
    public params: IKeyCloakAuthParams;
    private grantManager: GrantManager;
    private dbCache: ILocalDB<ICacheDb>;
    
    constructor(
        name: string,
        params: ICCTParams,
        sessCtrl: ISessCtrl,
    ) {
        super(name, params, sessCtrl);
        this.params = initParams(KeyCloakAuth.getParamsInfo(), this.params);
        if (
            !isEmpty(this.params.grantManagerConfig.publicKey) &&
            fs.existsSync(this.params.grantManagerConfig.publicKey)
        ) {
            this.params.grantManagerConfig.publicKey = fs
                .readFileSync(this.params.grantManagerConfig.publicKey)
                .toString();
        }
        if (
            !isEmpty(this.params.grantManagerConfig.publicKey) &&
            !isEmpty(this.params.grantManagerConfig.publicKey.trim())
        ) {
            this.params.grantManagerConfig.publicKey =
                this.params.grantManagerConfig.publicKey
                    .replace("-----BEGIN PUBLIC KEY-----\n", "")
                    .replace("-----END PUBLIC KEY-----", "")
                    .trim();
        }
        Object.entries(this.params.grantManagerConfig).forEach(
            ([key, value]) => {
                if (isEmpty(value)) {
                    delete this.params.grantManagerConfig[key];
                }
            },
        );

        if (isEmpty(this.params.grantManagerConfig.isIgnoreCheckSignature) && isEmpty(this.params.grantManagerConfig.realmUrl)) {
            this.params.grantManagerConfig.isIgnoreCheckSignature = true;
        }

        if (this.params.httpsAgent) {
            const httpsAgent: AgentOptions = typeof this.params.httpsAgent =="string" && (
                this.params.httpsAgent as string
            ).startsWith("{")
                ? JSON.parse(this.params.httpsAgent as string)
                : this.params.httpsAgent;
            if (
                typeof httpsAgent.key === "string" &&
                httpsAgent.key.indexOf("/") > -1 &&
                fs.existsSync(httpsAgent.key)
            ) {
                httpsAgent.key = fs.readFileSync(httpsAgent.key);
            }
            if (
                typeof httpsAgent.ca === "string" &&
                httpsAgent.ca.indexOf("/") > -1 &&
                fs.existsSync(httpsAgent.ca)
            ) {
                httpsAgent.ca = fs.readFileSync(httpsAgent.ca);
            }
            if (
                typeof httpsAgent.cert === "string" &&
                httpsAgent.cert.indexOf("/") > -1 &&
                fs.existsSync(httpsAgent.cert)
            ) {
                httpsAgent.cert = fs.readFileSync(httpsAgent.cert);
            }
            if (
                typeof httpsAgent.crl === "string" &&
                httpsAgent.crl.indexOf("/") > -1 &&
                fs.existsSync(httpsAgent.crl)
            ) {
                httpsAgent.crl = fs.readFileSync(httpsAgent.crl);
            }
            if (
                typeof httpsAgent.dhparam === "string" &&
                httpsAgent.dhparam.indexOf("/") > -1 &&
                fs.existsSync(httpsAgent.dhparam)
            ) {
                httpsAgent.dhparam = fs.readFileSync(httpsAgent.dhparam);
            }
            if (
                typeof httpsAgent.pfx === "string" &&
                httpsAgent.pfx.indexOf("/") > -1 &&
                fs.existsSync(httpsAgent.pfx)
            ) {
                httpsAgent.pfx = fs.readFileSync(httpsAgent.pfx);
            }

            this.params.grantManagerConfig.httpsAgent = new HttpsAgent(httpsAgent);
        }

        if (this.params.httpAgent) {
            const httpAgent = typeof this.params.httpAgent == "string" && (this.params.httpAgent as string).startsWith("{")
                ? JSON.parse(this.params.httpAgent as string)
                : params.httpAgent;

            this.params.grantManagerConfig.httpAgent = new HttpAgent(httpAgent);
        }
        if (this.params.grantManagerConfig.grantManagerConfigExtra && typeof this.params.grantManagerConfig.grantManagerConfigExtra === "string") {
            this.params.grantManagerConfig = {
                ...JSON.parse(this.params.grantManagerConfigExtra),
                ...this.params.grantManagerConfig,
            };
            delete this.params.grantManagerConfig.grantManagerConfigExtra;
        }

        this.grantManager = new GrantManager(
            this.params.grantManagerConfig,
            this.log,
        );
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
            gateContext.params[this.params.keyCloakParamName] ||
            gateContext.params[this.params.flagRedirect] === "1"
        ) {
            gateContext.debug("KeyCloak login");
            let data;
            if (gateContext.params[this.params.keyCloakParamName]) {
                data = JSON.parse(
                    gateContext.params[this.params.keyCloakParamName],
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
            redirectUrl.query[this.params.flagRedirect] = "1";
            gateContext.request.session.auth_redirect_uri =
                URL.format(redirectUrl);
            const grant = await PostAuth(gateContext, this.grantManager, data);
            delete gateContext.request.session.auth_redirect_uri;
            if (!grant) {
                return this.redirectAccess(gateContext);
            }
            const access_token = (grant.access_token as any)?.token;
            const access_token_hash = crypto
                        .createHash("md5")
                        .update(access_token || "")
                    .digest("hex");
            const dataUser = await this.generateUserData(grant, this.grantManager);
            await this.sessCtrl.addUser(
                dataUser.idUser,
                this.name,
                dataUser.userData,
            );
            await this.sessCtrl.updateHashAuth();
            const sess = await this.createSession({
                context: gateContext,
                idUser: dataUser.idUser,
                userData: dataUser.userData,
                isAccessErrorNotFound: false,
                sessionData: {
                    access_token: this.params.isSaveToken ? access_token : undefined,
                    access_token_hash: access_token_hash,
                },
            });
            if (sess) {
                throw new BreakException({
                    type: "success",
                    data: ResultStream(sess),
                });
            } else {
                return this.redirectAccess(gateContext);
            }
        } else if (gateContext.params[this.params.adminPathParam]) {
            gateContext.debug("KeyCloak Admin");
            (gateContext.request as IRequestExtra).kauth = {};
            await Admin(
                gateContext,
                this.grantManager,
                gateContext.params[this.params.adminPathParam],
            );
            throw new BreakException("break");
        } else if (
            gateContext.request.headers.authorization
                ?.substring(0, 7)
                .toLowerCase()
                .indexOf("bearer ") > -1 ||
            gateContext.request.headers.authorization
                ?.substring(0, 6)
                .toLowerCase()
                .indexOf("basic ") > -1
        ) {
            gateContext.debug("KeyCloak Init grant");

            return GrantAttacher(gateContext, this.grantManager)
                .then(async (grant) => {
                    if (!grant) {
                        throw new Error("Not Auth");
                    }
                    const access_token = (grant.access_token as any)?.token;
                    const access_token_hash = crypto
                            .createHash("md5")
                            .update(access_token || "")
                        .digest("hex");
                    if (
                        session &&
                        session.sessionData.access_token_hash === access_token_hash
                    ) {
                        return session;
                    }
                    const dataUser = await this.generateUserData(grant, this.grantManager);
                    if (!session) {
                        await this.sessCtrl.addUser(
                            dataUser.idUser,
                            this.name,
                            dataUser.userData,
                        );
                        await this.sessCtrl.updateHashAuth();
                        const sess = await this.createSession({
                            context: gateContext,
                            idUser: dataUser.idUser,
                            userData: dataUser.userData,
                            isAccessErrorNotFound: false,
                            sessionData: {
                                access_token: this.params.isSaveToken ? access_token : undefined,
                                access_token_hash: access_token_hash,
                            },
                        });

                        return this.sessCtrl.loadSession(
                            gateContext,
                            sess.session,
                        );
                    }
                    gateContext.request.session.gsession.userData = {
                        ...gateContext.request.session.gsession.userData,
                        ...dataUser.userData,
                    };
                    session.userData = {
                        ...session.userData,
                        ...dataUser.userData,
                    };
                    session.sessionData.access_token_hash = access_token_hash;
                    gateContext.request.session.gsession.sessionData.access_token_hash = access_token_hash;
                    if (this.params.isSaveToken) {
                        session.sessionData.access_token = access_token;
                        gateContext.request.session.gsession.sessionData.access_token = access_token;
                    }
                    await this.sessCtrl.addUser(
                        dataUser.idUser,
                        this.name,
                        dataUser.userData,
                    );
                    return session;
                })
                .catch(async () => {
                    if (session && session.nameProvider === this.name) {
                        await this.sessCtrl.logoutSession(gateContext);
                    } else if (session && session.nameProvider !== this.name) {
                        return session;
                    }
                    if (
                        !this.params.disableRecursiveAuth &&
                        gateContext.queryName === Constant.QUERY_GETSESSIONDATA
                    ) {
                        return this.redirectAccess(gateContext);
                    }
                    return null;
                });
        } else if (
            !session &&
            !this.params.disableRecursiveAuth &&
            gateContext.queryName === Constant.QUERY_GETSESSIONDATA
        ) {
            return this.redirectAccess(gateContext);
        }
        return session;
    }
    private async generateUserData(
        grant: KeyCloak.Grant,
        grantManager: GrantManager,
    ): Promise<{ userData: IUserData; idUser: string }> {
        const token: Token = grant.access_token;
        const userInfo =
            grantManager.realmUrl && grantManager.userInfoUrl
                ? await grantManager.userInfo(token)
                : token.content;
        const idUser =
            token.content[this.params.idKey] ||
            userInfo[this.params.idKey] ||
            token.content.sub;
        const dataUser = {
            ca_actions: [],
            ca_role: [],
            ck_id: idUser,
            type_auth_provider: 'KEYCLOAKAUTH',
            realm: grantManager.realmUrl,
            client_id: grantManager.clientId,
        } as IUserData;

        this.params.mapKeyCloakUserInfo.forEach((obj) => {
            if (!isEmpty(userInfo[obj.in])) {
                dataUser[obj.out] = userInfo[obj.in];
            }
            if (
                 token.content &&
                !isEmpty( token.content[obj.in])
            ) {
                dataUser[obj.out] =  token.content[obj.in];
            }
        });
        if (typeof dataUser.ca_actions === "string") {
            dataUser.ca_actions =
                (dataUser.ca_actions as string).startsWith("[") &&
                (dataUser.ca_actions as string).endsWith("]")
                    ? JSON.parse(dataUser.ca_actions)
                    : dataUser.ca_actions;
        }
        if (typeof dataUser.ca_role === "string") {
            dataUser.ca_role =
                (dataUser.ca_role as string).startsWith("[") &&
                (dataUser.ca_role as string).endsWith("]")
                    ? JSON.parse(dataUser.ca_role)
                    : dataUser.ca_role;
        }
        if (!Array.isArray(dataUser.ca_actions)) {
            dataUser.ca_actions = [];
        }
        if (!Array.isArray(dataUser.ca_role)) {
            dataUser.ca_role = [];
        }
        this.params.mapKeyCloakGrant?.forEach((obj) => {
            if (grant.access_token.hasRole(obj.grant) || grant.access_token.hasRealmRole(obj.grant)) {
                dataUser.ca_actions.push(
                    typeof obj.action === "string"
                        ? parseInt(obj.action.replace("new#", "") as any, 10)
                        : obj.action,
                );
            }
        });
        if (this.params.mapKeyCloakGrantRole && this.params.mapKeyCloakGrantRole.length) {
            const hashObj = await this.dbCache.findOne(
                {
                    ck_id: "role_user",
                },
                true,
            ) || {};
            this.params.mapKeyCloakGrantRole.forEach((obj) => {
                if (grant.access_token.hasRole(obj.grant) || grant.access_token.hasRealmRole(obj.grant)) {
                    dataUser.ca_role.push(
                        obj.role,
                    );
                    const actions = hashObj[obj.role] as any[];
                    actions?.forEach((action) => {
                        dataUser.ca_actions.push(
                            typeof action === "string"
                                ? parseInt(action as any, 10)
                                : action,
                        );
                    });
                }
            });
        }
        dataUser.ca_role = uniq(dataUser.ca_role);
        dataUser.ca_actions = uniq(dataUser.ca_actions);
        return { userData: dataUser, idUser };
    }
    private async redirectAccess(context: IContext): Promise<any> {
        const redirectUrl = URL.parse(this.params.redirectUrl, true);
        redirectUrl.query[this.params.flagRedirect] = "1";
        const loginUrl = this.grantManager.loginUrl(
            context.request.session.id,
            URL.format(redirectUrl),
        );
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
        if (isEmpty(query.inParams.cv_login) || isEmpty(query.inParams.cv_password)) {
            return this.redirectAccess(context);
        }
        return this.grantManager.obtainDirectly(
                query.inParams.cv_login,
                query.inParams.cv_password
            ).then( async ([grant, headers]: [KeyCloak.Grant, Record<string, any>]) => {
                const dataUser = await this.generateUserData(
                    grant,
                    this.grantManager,
                );
                const access_token = (grant.access_token as any)?.token;
                const access_token_hash = crypto
                            .createHash("md5")
                            .update(access_token || "")
                        .digest("hex");
                await this.sessCtrl.addUser(
                                dataUser.idUser,
                                this.name,
                                dataUser.userData,
                            );
                await this.sessCtrl.updateHashAuth();
                if (headers) {
                    Object.entries(headers).forEach(([key, value]) => {
                        if (key.toLocaleLowerCase() === 'set-cookie') {
                            context.extraHeaders = { [key]: value };
                        }
                    });
                }
                return {
                    idUser: dataUser.idUser,
                    dataUser: dataUser.userData,
                    sessionData: {
                        access_token: this.params.isSaveToken ? access_token : undefined,
                        access_token_hash: access_token_hash,
                    },
                };
            }).catch((errFind) => {
                this.log.error(errFind);
                return this.redirectAccess(context);
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
        if (context.actionName !== "auth") {
            throw new ErrorException(ErrorGate.UNSUPPORTED_METHOD);
        }
        return res;
    }
}
