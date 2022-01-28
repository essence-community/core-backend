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

const FLAG_REDIRECT = "jl_keycloak_auth_callback";
const USE_REDIRECT = "jl_keycloak_use_redirect";

export default class TokenAuth extends NullAuthProvider {
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
                        defaultValue: true,
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
                        type: "boolean",
                        defaultValue: true,
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
        };
    }
    public params: ITokenAuthParams;
    private grantManager: GrantManager;
    constructor(
        name: string,
        params: ICCTParams,
        authController: IAuthController,
    ) {
        super(name, params, authController);
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
            (!header &&
                !gateContext.request.session[`token_bearer_${this.name}`])
        ) {
            return session;
        }
        this.log.debug("Grant check");
        return GrantAttacher(this.name, gateContext, this.grantManager)
            .then(async (grant) => {
                if (!grant) {
                    throw new Error("Not Auth");
                }
                if (
                    session &&
                    session.sessionData.access_token ===
                        (grant.access_token as any).token
                ) {
                    return session;
                }
                const dataUser = await this.generateUserData(
                    gateContext,
                    grant,
                );
                if (!session) {
                    await this.authController.addUser(
                        dataUser.idUser,
                        this.name,
                        dataUser.userData,
                    );
                    await this.authController.updateHashAuth();
                    const sess = await this.createSession({
                        context: gateContext,
                        idUser: dataUser.idUser,
                        userData: dataUser.userData,
                        isAccessErrorNotFound: false,
                        sessionData: {
                            access_token: (grant.access_token as any)?.token,
                        },
                    });

                    return this.authController.loadSession(
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
                session.sessionData.access_token = (
                    grant.access_token as any
                )?.token;
                gateContext.request.session.gsession.sessionData.access_token =
                    (grant.access_token as any)?.token;
                await this.authController.addUser(
                    dataUser.idUser,
                    this.name,
                    dataUser.userData,
                );
                return session;
            })
            .catch(async (err) => {
                gateContext.debug("Token Auth Error", err);
                if (session && session.nameProvider === this.name) {
                    await this.authController.logoutSession(gateContext);
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
    ): Promise<{ userData: IUserData; idUser: string }> {
        const token: Token = grant.access_token;
        const userInfo =
            this.grantManager.realmUrl && this.grantManager.userInfoUrl
                ? await this.grantManager.userInfo(token)
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
            if (token.content && !isEmpty(token.content[obj.in])) {
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
