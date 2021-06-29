import CrmWsCaller from "@ungate/plugininf/lib/caller/CrmWsCaller";
import JsonGateCaller from "@ungate/plugininf/lib/caller/JsonGateCaller";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import ICCTParams, { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import IContext from "@ungate/plugininf/lib/IContext";
import IQuery, { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import { IResultProvider } from "@ungate/plugininf/lib/IResult";
import NullAuthProvider, {
    IAuthResult,
} from "@ungate/plugininf/lib/NullAuthProvider";
import ResultStream from "@ungate/plugininf/lib/stream/ResultStream";
import { ReadStreamToArray } from "@ungate/plugininf/lib/stream/Util";
import { initParams, isEmpty } from "@ungate/plugininf/lib/util/Util";
import { IAuthController } from "@ungate/plugininf/lib/IAuthController";

export default class AuthCrmWs extends NullAuthProvider {
    public static getParamsInfo(): IParamsInfo {
        return {
            ...CrmWsCaller.getParamsInfo(),
            clAudit: {
                defaultValue: true,
                name: "Признак аудита",
                type: "boolean",
            },
            cnSystem: {
                name: "Ид системы",
                required: true,
                type: "integer",
            },
            nsiGateUrl: {
                name: "Ссылка на гейт NSI",
                type: "string",
            },
            queryAuth: {
                name: "Наименовани запроса проверки авторизации",
                required: true,
                type: "string",
            },
            queryGetCrmUrl: {
                name: "Имя запроса получения ссылки на сувк",
                required: true,
                type: "string",
            },
            queryMetaUsers: {
                name: "Наименование запроса получения мета информации",
                required: true,
                type: "string",
            },
            queryToken: {
                name: "Наименование запроса получения token",
                required: true,
                type: "string",
            },
            queryUsersActions: {
                name: "Наименование запроса получения всех экшенов",
                required: true,
                type: "string",
            },
            queryUsersDepartments: {
                name: "Наименование запроса получения департаментов по юзеру",
                required: true,
                type: "string",
            },
            sessionDuration: {
                defaultValue: 60,
                name: "Время жизни сессии в минутах по умолчанию 60 минут",
                type: "integer",
            },
            urlCrmTemplate: {
                name: "Шаблон ссылки",
                type: "string",
            },
        };
    }
    private crmWSCaller: CrmWsCaller;
    private nsiJsonGateCaller: JsonGateCaller;
    constructor(
        name: string,
        params: ICCTParams,
        authController: IAuthController,
    ) {
        super(name, params, authController);
        this.params = {
            ...this.params,
            ...initParams(AuthCrmWs.getParamsInfo(), params),
        };
        this.crmWSCaller = new CrmWsCaller(this.params);
        this.nsiJsonGateCaller = new JsonGateCaller({
            jsonGateUrl: this.params.nsiGateUrl,
        });
    }
    public async processAuth(
        context: IContext,
        query: IGateQuery,
    ): Promise<IAuthResult> {
        try {
            const params = {
                ...query.inParams,
                cl_audit: +this.params.clAudit,
                cn_system: this.params.cnSystem,
            };
            const result = await this.crmWSCaller.getData(
                this.params.queryAuth,
                params,
            );
            this.log.trace(
                `Ответ ${this.params.queryAuth} ${
                    result ? JSON.stringify(result) : result
                }`,
            );
            if (!result || !result.length) {
                throw new ErrorException(ErrorGate.AUTH_DENIED);
            }
            return {
                idUser: result[0].cn_user,
            };
        } catch (e) {
            this.log.error(
                `Ошибка вызова внешнего сервиса авторизации ${e.message}`,
                e,
            );
            throw new ErrorException(ErrorGate.AUTH_CALL_REMOTE);
        }
    }
    public processSql(
        context: IContext,
        query: IGateQuery,
    ): Promise<IResultProvider> {
        return this.handlers[query.queryStr](context, query);
    }
    public processDml(
        context: IContext,
        query: IGateQuery,
    ): Promise<IResultProvider> {
        return this.handlers[query.queryStr](context, query);
    }

    public handlers = {
        /**
         * Получаем ссылку на Сувк
         * @param gateContext
         * @returns {*|Promise.<TResult>}
         */
        getCrmUrl: async (gateContext: IContext): Promise<IResultProvider> => {
            const params = {
                cn_user: gateContext.session.idUser,
            };
            const res = await this.crmWSCaller.getData(
                this.params.queryToken,
                params,
            );
            if (!res.length) {
                return {
                    stream: ResultStream([
                        {
                            ck_id: null,
                            cv_error: {
                                513: [],
                            },
                        },
                    ]),
                };
            }
            const [obj] = res;
            return {
                stream: ResultStream([
                    {
                        ck_id: null,
                        cv_error: null,
                        cv_url: (this.params.urlCrmTemplate || "").replace(
                            /{([^}]+)}/g,
                            (req, value) => obj[value],
                        ),
                    },
                ]),
            };
        },
        getUrlForNsi: async (
            gateContext: IContext,
        ): Promise<IResultProvider> => {
            return this.handlers.getNsiUrl(gateContext, false);
        },
        getUrlForNsiByTable: async (
            gateContext: IContext,
        ): Promise<IResultProvider> => {
            return this.handlers.getNsiUrl(gateContext, true);
        },
        /**
         * Получаем ссылку на НСИ
         * @param gateContext
         * @returns {*|Promise.<TResult>}
         */
        getNsiUrl: async (
            gateContext: IContext,
            isTable = false,
        ): Promise<IResultProvider> => {
            if (isEmpty(this.params.nsiGateUrl)) {
                throw new ErrorException(
                    -1,
                    "Require params(nsiGateUrl) not found",
                );
            }
            const json = JSON.parse(gateContext.params.json || "{}");
            const params = {
                cn_user: gateContext.session.idUser,
            };
            const jsonCaller = await this.nsiJsonGateCaller.callGet(
                gateContext,
                "sql",
                isTable ? "GetUrlDocReqCreate" : "GetUrlDocReqList",
                isTable
                    ? {
                          nm_table: json.filter.cv_table,
                      }
                    : undefined,
            );
            const respData = await ReadStreamToArray(jsonCaller.stream);
            if (respData.length) {
                const [urlObj] = respData;
                const resJson = await this.crmWSCaller.getData(
                    this.params.queryToken,
                    params,
                );
                if (resJson.length) {
                    const [obj] = resJson;
                    return {
                        stream: ResultStream([
                            {
                                ck_id: null,
                                cv_error: null,
                                cv_url: urlObj.nm_url.replace(
                                    /\[token\]/g,
                                    obj.cv_token,
                                ),
                            },
                        ]),
                    };
                }
            }
            return {
                stream: ResultStream([
                    {
                        ck_id: null,
                        cv_error: {
                            513: [],
                        },
                    },
                ]),
            };
        },
    };

    public async initContext(
        context: IContext,
        query: IQuery = {},
    ): Promise<IQuery> {
        const res = await super.initContext(context, query);
        if (context.actionName === "auth") {
            return {
                ...res,
                queryStr: "authCrm",
            };
        }
        switch (context.queryName) {
            case this.params.queryGetCrmUrl.toLowerCase(): {
                return {
                    ...res,
                    queryStr: "getCrmUrl",
                };
            }
            case "geturlfornsi": {
                return {
                    ...res,
                    queryStr: "getUrlForNsi",
                };
            }
            case "geturlfornsibytable": {
                return {
                    ...res,
                    queryStr: "getUrlForNsiByTable",
                };
            }
            default:
                throw new ErrorException(ErrorGate.NOTFOUND_QUERY);
        }
    }
    public async init(reload?: boolean): Promise<any> {
        await this.crmWSCaller.init();
        const params = {
            cn_system: this.params.cnSystem,
        };
        const users = {};
        this.log.trace(
            `Вызов сервиса ${
                this.params.queryMetaUsers
            }, параметры ${JSON.stringify(params)}`,
        );
        const usersArr = await this.crmWSCaller.getData(
            this.params.queryMetaUsers,
            params,
        );
        const rows = [];
        this.log.trace(
            `Ответ ${this.params.queryMetaUsers} ${
                usersArr ? JSON.stringify(usersArr) : usersArr
            }`,
        );
        if (!usersArr || !usersArr.length) {
            throw new ErrorException(
                -1,
                `Нет данных о пользователях, провайдер: ${this.name}`,
            );
        }
        usersArr.forEach((item) => {
            users[item.ck_id] = {
                ...item,
                ca_actions: [],
                ca_department: [],
            };
        });

        // загружаем экшены пользователей
        this.log.trace(
            `Вызов сервиса ${
                this.params.queryUsersActions
            }, параметры ${JSON.stringify(params)}`,
        );
        rows.push(
            this.crmWSCaller
                .getData(this.params.queryUsersActions, params)
                .then((res) => {
                    this.log.trace(
                        `Ответ ${this.params.queryUsersActions} ${
                            res ? JSON.stringify(res) : res
                        }`,
                    );
                    if (res && res.length) {
                        res.forEach((item) => {
                            item.cv_actions.split(",").forEach((cnAction) => {
                                if (users[item.ck_user]) {
                                    users[item.ck_user].ca_actions.push(
                                        parseInt(cnAction, 10),
                                    );
                                }
                            });
                        });
                        return Promise.resolve();
                    }
                    throw new ErrorException(
                        -1,
                        `Нет данных о доступах, провайдер: ${this.name}`,
                    );
                }),
        );
        // загружаем департаменты пользователей
        this.log.trace(
            `Вызов сервиса ${
                this.params.queryUsersDepartments
            }, параметры ${JSON.stringify(params)}`,
        );
        rows.push(
            this.crmWSCaller
                .getData(this.params.queryUsersDepartments, params)
                .then((res) => {
                    this.log.trace(
                        `Ответ ${this.params.queryUsersDepartments} ${
                            res ? JSON.stringify(res) : res
                        }`,
                    );
                    if (res && res.length) {
                        res.forEach((item) => {
                            item.cv_departments
                                .split(",")
                                .forEach((ckDepartment) => {
                                    if (users[item.ck_user]) {
                                        users[item.ck_user].ca_department.push(
                                            parseInt(ckDepartment, 10),
                                        );
                                    }
                                });
                        });
                    }
                    return Promise.resolve();
                }),
        );
        return Promise.all(rows)
            .then(() =>
                Promise.all(
                    Object.values(users).map((user) =>
                        this.authController.addUser(
                            (user as any).ck_id,
                            this.name,
                            user,
                        ),
                    ),
                ),
            )
            .then(() => this.authController.updateHashAuth())
            .then(() => {
                this.authController.updateUserInfo(this.name);
                return Promise.resolve();
            });
    }
}
