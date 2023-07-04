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
import { IKeyCloakAuthParams, IRequestExtra } from "./KeyCloakAuth.types";
import * as QueryString from "qs";
import * as URL from "url";
import { Admin, GrantAttacher, PostAuth } from "./Midleware";
import BreakException from "@ungate/plugininf/lib/errors/BreakException";
import ResultStream from "@ungate/plugininf/lib/stream/ResultStream";
import { uniq } from "lodash";
import * as fs from "fs";
import { Constant } from "@ungate/plugininf/lib/Constants";
import * as Token from "keycloak-connect/middleware/auth-utils/token";
import { GrantManager } from "./util/GrantManager";

const FLAG_REDIRECT = "jl_keycloak_auth_callback";
const USE_REDIRECT = "jl_keycloak_use_redirect";
const PATH_CALLBACK = "jv_keycloak_path_callback";
const TOKEN_KEY = "keycloak-token";

export default class KeyCloakAuth extends NullSessProvider {
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
            keyCloakParamName: {
                name: "KeyCloak param key use front",
                type: "string",
                required: true,
                defaultValue: "jt_keycloak",
            },
            keyCloakConfig: {
                name: "KeyCloakConfig json",
                type: "long_string",
                defaultValue: "{}",
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
        };
    }
    public params: IKeyCloakAuthParams;
    private keyCloak: KeyCloak.Keycloak;
    constructor(
        name: string,
        params: ICCTParams,
        sessCtrl: ISessCtrl,
    ) {
        super(name, params, sessCtrl);
        this.params = initParams(KeyCloakAuth.getParamsInfo(), this.params);
        if (typeof this.params.keyCloakConfig === "string") {
            if ((this.params.keyCloakConfig as string).charAt(0) === "{") {
                this.params.keyCloakConfig = JSON.parse(this.params.keyCloakConfig);
            }
        }
        if (typeof this.params.keyCloakConfig !== "object") {
            this.params.keyCloakConfig = {} as any;
        }
        if (
            this.params.keyCloakConfig["realm-public-key"] &&
            fs.existsSync(this.params.keyCloakConfig["realm-public-key"])
        ) {
            this.params.keyCloakConfig["realm-public-key"] = fs
                .readFileSync(this.params.keyCloakConfig["realm-public-key"])
                .toString();
        }
        if (this.params.keyCloakConfig["realm-public-key"]) {
            this.params.keyCloakConfig["realm-public-key"] =
                this.params.keyCloakConfig["realm-public-key"]
                    .replace("-----BEGIN PUBLIC KEY-----\n", "")
                    .replace("-----END PUBLIC KEY-----", "")
                    .trim();
        }
        Object.entries(this.params.keyCloakConfig).forEach(([key, value]) => {
            if (isEmpty(value)) {
                delete this.params.keyCloakConfig[key];
            }
        });
        this.keyCloak = new KeyCloak(
            {
                store: this.sessCtrl.getSessionStore(),
            },
            this.params.keyCloakConfig,
        );
        (this.keyCloak as any).grantManager = new GrantManager({ ...this.params.keyCloakConfig,  ...(this.keyCloak as any).config}, this.log);
        this.keyCloak.storeGrant = function(grant, request, response) {
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
        this.keyCloak.storeGrant.bind(this.keyCloak);
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
            const grant = await PostAuth(gateContext, this.keyCloak, data);
            delete gateContext.request.session.auth_redirect_uri;
            if (!grant) {
                return this.redirectAccess(gateContext);
            }
            const dataUser = await this.generateUserData(grant);

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
                    [`access_token`]: (grant.access_token as any)?.token,
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
                this.keyCloak,
                gateContext.params[this.params.adminPathParam],
            );
            throw new BreakException("break");
        } else if (
            gateContext.request.session[TOKEN_KEY] ||
            gateContext.request.headers.authorization
                ?.substr(0, 7)
                .toLowerCase()
                .indexOf("bearer ") > -1
        ) {
            gateContext.debug("KeyCloak Init grant");
            (gateContext.request as IRequestExtra).kauth = {};

            return GrantAttacher(gateContext, this.keyCloak)
                .then(async (grant) => {
                    if (!grant) {
                        throw new Error("Not Auth");
                    }
                    const dataUser = await this.generateUserData(grant);
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
                                [`access_token`]: (grant.access_token as any)
                                    ?.token,
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
    ): Promise<{ userData: IUserData; idUser: string }> {
        const userInfo = await this.keyCloak.grantManager.userInfo(
            grant.access_token,
        );
        const idUser =
            (grant.access_token as Token).content[this.params.idKey] ||
            userInfo[this.params.idKey] ||
            (grant.access_token as Token).content.sub;
        const dataUser = {
            ca_actions: [],
            ck_id: idUser,
        } as IUserData;

        this.params.mapKeyCloakUserInfo.forEach((obj) => {
            if (!isEmpty(userInfo[obj.in])) {
                dataUser[obj.out] = userInfo[obj.in];
            }
            if (
                (grant.access_token as any).content &&
                !isEmpty((grant.access_token as any).content[obj.in])
            ) {
                dataUser[obj.out] = (grant.access_token as any).content[obj.in];
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
            if (grant.access_token.hasRole(obj.grant)) {
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
        const loginUrl = this.keyCloak.loginUrl(
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
