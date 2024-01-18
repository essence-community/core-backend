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
import { ISessCtrl } from "@ungate/plugininf/lib/ISessCtrl";
import * as KeyCloak from "keycloak-connect";
import { ITokenAuthParams } from "./TokenAuth.types";
import { GrantAttacher } from "./Midleware";
import BreakException from "@ungate/plugininf/lib/errors/BreakException";
import { uniq } from "lodash";
import * as fs from "fs";
import { Constant } from "@ungate/plugininf/lib/Constants";
import * as Token from "keycloak-connect/middleware/auth-utils/token";
import * as URL from "url";
import { GrantManager } from "./GrantManager";
import { Agent as HttpsAgent, AgentOptions } from "https";
import { Agent as HttpAgent } from "http";
import * as crypto from 'crypto';

const FLAG_REDIRECT = "jl_keycloak_auth_callback";
const USE_REDIRECT = "jl_keycloak_use_redirect";

export default class TokenAuth extends NullSessProvider {
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
                        type: "string",
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
            mapKeyCloakGrant: {
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
            idKey: {
                defaultValue: "sub",
                name: "Наименование ключа индетификации",
                type: "string",
            },
            httpsAgent: {
                name: "Настройки https agent",
                type: "long_string",
            },
        };
    }
    public params: ITokenAuthParams;
    private grantManager: GrantManager;
    constructor(
        name: string,
        params: ICCTParams,
        sessCtrl: ISessCtrl,
    ) {
        super(name, params, sessCtrl);
        this.params = initParams(TokenAuth.getParamsInfo(), this.params);
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
        const header = gateContext.request.headers.authorization;
        if (
            (session && session.nameProvider !== this.name) ||
            (header &&
                header.substr(0, 7).toLowerCase().indexOf("bearer ") === -1) ||
            (session)
        ) {
            return session;
        }
        this.log.debug("Grant check");
        return GrantAttacher(this.name, gateContext, this.grantManager)
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
                const dataUser = await this.generateUserData(
                    gateContext,
                    grant,
                    this.grantManager,
                );
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
            .catch(async (err) => {
                gateContext.debug("Token Auth Error", err);
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
    }
    private async generateUserData(
        context: IContext,
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
            ck_id: idUser,
        } as IUserData;

        this.params.mapKeyCloakUserInfo.forEach((obj) => {
            if (!isEmpty(userInfo[obj.in])) {
                dataUser[obj.out] = userInfo[obj.in];
            }
            if (
                token.content &&
                !isEmpty(token.content[obj.in])
            ) {
                dataUser[obj.out] = token.content[obj.in];
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
        this.params.mapKeyCloakGrant.forEach((obj) => {
            if (token.hasRole(obj.grant)) {
                dataUser.ca_actions.push(
                    typeof obj.action === "string"
                        ? parseInt(obj.action.replace("new#", "") as any, 10)
                        : obj.action,
                );
            }
        });
        dataUser.ca_actions = uniq(dataUser.ca_actions);
        return { userData: dataUser, idUser };
    }
    private async redirectAccess(context: IContext): Promise<any> {
        const redirectUrl = URL.parse(this.params.redirectUrl, true);
        redirectUrl.query[this.params.flagRedirect] = "1";
        if (context.params[USE_REDIRECT] === "1") {
            context.response.writeHead(302, {
                Location: URL.format(redirectUrl),
            });
            context.response.end();
            throw new BreakException("break");
        }
        throw new ErrorException(
            ErrorGate.REDIRECT_MESSAGE(URL.format(redirectUrl)),
        );
    }
    public async checkQuery(
        context: IContext,
        query: IGateQuery,
    ): Promise<void> {
        if (query.needSession && !context.session) {
            throw new ErrorException(ErrorGate.REQUIRED_AUTH);
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
            ).then( async (grant: KeyCloak.Grant) => {
                const dataUser = await this.generateUserData(
                    context,
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
