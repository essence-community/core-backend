import ILocalDB from "@ungate/plugininf/lib/db/local/ILocalDB";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import IContext from "@ungate/plugininf/lib/IContext";
import IQuery from "@ungate/plugininf/lib/IQuery";
import ISession from "@ungate/plugininf/lib/ISession";
import NullSessProvider from "@ungate/plugininf/lib/NullSessProvider";
import ResultStream from "@ungate/plugininf/lib/stream/ResultStream";
import { isEmpty } from "@ungate/plugininf/lib/util/Util";
import { noop } from "lodash";
import IProviderConfig from "../../core/property/IProviderConfig";
import Constants from "../../core/Constants";
import PluginManager from "../../core/pluginmanager/PluginManager";
import IQueryConfig from "../../core/property/IQueryConfig";
import Property from "../../core/property/Property";
import RequestContext from "../../core/request/RequestContext";
import WSQuery from "../../core/WSQuery";
import Mask from "../Mask";
import ActionController from "./ActionController";
import PluginController from "./PluginController";
import ResultController from "./ResultController";
import IPluginConfig from "../../core/property/IPluginConfig";
/**
 * Created by artemov_i on 04.12.2018.
 */

class MainController {
    public providerDb: ILocalDB<IProviderConfig>;
    public queryDb: ILocalDB<IQueryConfig>;
    public pluginDb: ILocalDB<IPluginConfig>;
    public async init() {
        this.providerDb = await Property.getProviders();
        this.pluginDb = await Property.getPlugins();
        this.queryDb = await Property.getQuery();
    }
    public async execute(requestContext: RequestContext) {
        let isLog = false;
        try {
            // 1: Проверка на установку маски
            if (Mask.masked) {
                this.logParams(requestContext);
                isLog = true;
                return ResultController.responseCheck(
                    requestContext,
                    await requestContext.gateContextPlugin.maskResult(),
                );
            }
            const sessProviders = PluginManager.getGateSessProviders(
                requestContext.gateContextPlugin.name,
            ) as NullSessProvider[];

            let session = await PluginController.applyBeforeSession(
                requestContext,
                sessProviders,
            );

            const sessCtrl =
                requestContext.gateContextPlugin.sessCtrl;
            // 2: Если передана сессия то инициализируем сессию
            if (isEmpty(session) && requestContext.sessionId) {
                session = await sessCtrl.loadSession(
                    requestContext,
                    requestContext.sessionId,
                );
            }
            session = await PluginController.applyAfterSession(
                requestContext,
                session as ISession,
                sessProviders,
            );
            if (session) {
                requestContext.setSession(session);
            }
            // 2.1: Добавляем аудит
            requestContext.gateContextPlugin.audit(requestContext);
            if (requestContext.queryName === Constants.QUERY_LOGOUT) {
                if (session) {
                    await sessCtrl.logoutSession(requestContext);
                }
                return ResultController.responseCheck(requestContext, {
                    data: ResultStream([]),
                    type: "success",
                });
            }
            // 3: Проверка на запрос получения данных о сессии если прошла то предаем сессию в ответе
            if (requestContext.queryName === Constants.QUERY_GETSESSIONDATA) {
                this.logParams(requestContext);
                isLog = true;
                return ResultController.responseCheck(requestContext, {
                    data: ResultStream(
                        session
                            ? [
                                  {
                                      session: session.session,
                                      ...session.userData,
                                  },
                              ]
                            : [],
                    ),
                    type: "success",
                });
            }
            let query;
            // 4. Инициализируем Контекст насройки
            const cResult = await requestContext.gateContextPlugin.initContext(
                requestContext,
            );
            if (!isEmpty(cResult.connection)) {
                requestContext.connection = cResult.connection;
            }
            if (!isEmpty(cResult.queryName)) {
                requestContext.setQueryName(cResult.queryName);
            }
            if (!isEmpty(cResult.pluginName)) {
                requestContext.setPluginName(cResult.pluginName);
            }
            if (!isEmpty(cResult.providerName)) {
                requestContext.setProviderName(cResult.providerName);
            }
            if (!isEmpty(cResult.query)) {
                query = cResult.query;
            }
            if (!isEmpty(cResult.metaData)) {
                requestContext.metaData = cResult.metaData;
            }
            if (!isEmpty(cResult.actionName)) {
                requestContext.setActionName(cResult.actionName);
            }
            if (
                !isEmpty(cResult.defaultActionName) &&
                (isEmpty(requestContext.actionName) ||
                    requestContext.actionName === "auth")
            ) {
                requestContext.setActionName(cResult.defaultActionName);
            }
            if (
                !isEmpty(cResult.defaultQueryName) &&
                isEmpty(requestContext.queryName)
            ) {
                requestContext.setQueryName(cResult.defaultQueryName);
            }
            if (
                !isEmpty(cResult.defaultProviderName) &&
                isEmpty(requestContext.providerName)
            ) {
                requestContext.setProviderName(cResult.defaultProviderName);
            }
            if (
                !isEmpty(cResult.defaultPluginName) &&
                isEmpty(requestContext.pluginName)
            ) {
                requestContext.setPluginName(cResult.defaultPluginName);
            }
            if (
                !isEmpty(cResult.loginQuery) &&
                requestContext.actionName === "auth"
            ) {
                requestContext.setQueryName(cResult.loginQuery);
            }
            this.logParams(requestContext);
            isLog = true;
            // 5: Загружаем провайдер данных
            const provider = await this.loadProvider(requestContext);
            requestContext.setProvider(provider);
            // 6: Загружаем все плагины данных
            const plugins = await this.loadPlugins(requestContext);
            try {
                // 7: Вызов плагинов инициализации запроса
                query = await PluginController.applyPluginInitQueryBefore(
                    requestContext,
                    plugins,
                    query,
                );
                // 8: Инициализируем провайдер
                query = await provider.initContext(requestContext, query);
                await this.loadQueryData(requestContext, query);
                // 9: Инициализируем query
                const wsQuery = new WSQuery(requestContext, query);
                requestContext.setQuery(wsQuery);
                wsQuery.prepareParams(provider);
                // 10: Проверка авторизации
                await PluginController.applyCheckQuery(
                    requestContext,
                    wsQuery,
                    sessProviders,
                );

                // 10.1: Проверка доступа
                if (
                    !(await requestContext.gateContextPlugin.checkQueryAccess(
                        requestContext,
                        wsQuery,
                    ))
                ) {
                    throw new ErrorException(ErrorGate.REQUIRED_AUTH);
                }
                // 11: Передаем query плагинам
                await PluginController.applyPluginInitQueryAfter(
                    requestContext,
                    plugins,
                    wsQuery,
                );
                // 12: Вызов плагинов перед получение результата
                let result =
                    await PluginController.applyPluginQueryExecuteBefore(
                        requestContext,
                        plugins,
                        wsQuery,
                    );
                if (!result) {
                    // 13: Обработка по экшенам
                    result = await ActionController.execute({
                        gateContext: requestContext,
                        plugins,
                        provider,
                        query: wsQuery,
                    });
                }
                if (!requestContext.isResponded) {
                    // 15: Вызов плагины постобработки
                    result =
                        await PluginController.applyPluginAfterQueryExecute(
                            requestContext,
                            plugins,
                            result,
                        );
                    await ResultController.responseCheck(
                        requestContext,
                        result,
                    );
                }
            } catch (err) {
                if (!isLog) {
                    this.logParams(requestContext);
                }
                await this.checkError(err, requestContext, plugins);
            }
        } catch (err) {
            if (!isLog) {
                this.logParams(requestContext);
            }
            await ResultController.responseCheck(requestContext, null, err);
        }
    }
    private async checkError(err, requestContext, plugins): Promise<void> {
        const conn = requestContext.connection;
        if (conn) {
            conn.rollbackAndRelease().then(noop, noop);
        }
        const result = await PluginController.applyPluginError(
            requestContext,
            plugins,
            err,
        );
        ResultController.responseCheck(requestContext, null, result).then(
            noop,
            noop,
        );
    }
    /**
     * Выводим лог
     * @param params
     * @returns {Promise.<void>}
     * @private
     */
    private async logParams(gateContext: IContext) {
        if (gateContext.gateContextPlugin.isExcludeAccessLog) {
            return;
        }
        const param = Object.assign({}, gateContext.params);
        if (param[Constants.PASSWORD_PARAM_PREFIX]) {
            param[Constants.PASSWORD_PARAM_PREFIX] = "***";
        }
        if (param.cv_password) {
            param.cv_password = "***";
        }

        if (gateContext.session) {
            gateContext.info(
                `${gateContext.request.method}(${gateContext.actionName},${gateContext.queryName}` +
                    `,${gateContext.providerName || ""},${
                        gateContext.isTraceEnabled()
                            ? JSON.stringify(param)
                            : ""
                    },${
                        gateContext.isTraceEnabled()
                            ? JSON.stringify(gateContext.session)
                            : gateContext.session.session.substr(0, 10)
                    })`,
            );
        } else {
            gateContext.info(
                `${gateContext.request.method}(${gateContext.actionName},${gateContext.queryName}` +
                    `,${gateContext.providerName},${
                        gateContext.isTraceEnabled()
                            ? JSON.stringify(param)
                            : ""
                    })`,
            );
        }
    }

    /**
     * Загружаем провайдер данных
     * @param gateContext
     * @returns
     */
    private async loadProvider(gateContext: RequestContext) {
        if (isEmpty(gateContext.providerName)) {
            throw new ErrorException(ErrorGate.REQUIRED_PARAM);
        }
        let provider = PluginManager.getGateProvider(
            gateContext.gateContextPlugin.name,
            gateContext.providerName,
        );
        if (provider) {
            return provider;
        }
        const config = await this.providerDb.findOne(
            {
                $and: [
                    {
                        ck_id: gateContext.providerName,
                    },
                    {
                        $or: [
                            { ck_context: { $exists: false } },
                            { ck_context: gateContext.gateContextPlugin.name },
                        ],
                    },
                ],
            },
            true,
        );
        if (!config) {
            throw new ErrorException(ErrorGate.PLUGIN_NOT_FOUND);
        }
        const pluginClass = PluginManager.getGateProviderClass(
            config.ck_d_plugin.toLowerCase(),
        );
        provider = pluginClass.default
            ? new pluginClass.default(
                  config.ck_id,
                  config.cct_params,
                  gateContext.gateContextPlugin.sessCtrl,
              )
            : new pluginClass(
                  config.ck_id,
                  config.cct_params,
                  gateContext.gateContextPlugin.sessCtrl,
              );
        await provider.init();
        PluginManager.setGateProvider(
            gateContext.gateContextPlugin.name,
            config.ck_id,
            provider,
        );
        return provider;
    }

    /**
     * Загружаем информацию о запросе если есть
     * @param gateContext {RequestContext} Контекст запроса
     * @param query {IQuery} Настройки запроса
     * @returns
     */
    private async loadQueryData(gateContext: RequestContext, query: IQuery) {
        const queryDoc = await this.queryDb.findOne(
            {
                $and: [
                    {
                        cv_name: gateContext.queryName,
                    },
                    {
                        ck_d_provider: gateContext.providerName,
                    },
                    {
                        ck_d_context: gateContext.gateContextPlugin.name,
                    },
                ],
            },
            true,
        );
        if (queryDoc) {
            query.extraInParams = (queryDoc as IQueryConfig).cct_inParams;
            query.extraOutParams = (queryDoc as IQueryConfig).cct_outParams;
        }
        return;
    }

    /**
     * Загружаем провайдер данных
     * @param gateContext
     * @returns
     */
    private async loadPlugins(gateContext: RequestContext) {
        const configs = await this.pluginDb.find({
            $and: [
                {
                    $or: [
                        isEmpty(gateContext.pluginName)
                            ? { cl_default: 1 }
                            : { cv_name: { $in: gateContext.pluginName } },
                        { cl_required: 1 },
                    ],
                },
                { ck_d_provider: { $in: ["all", gateContext.providerName] } },
                {
                    $or: [
                        { ck_context: { $exists: false } },
                        { ck_context: gateContext.gateContextPlugin.name },
                    ],
                },
            ],
        });
        configs.sort((val1, val2) => val1.cn_order - val2.cn_order);
        const rows = [];
        const plugins = [];
        configs.forEach((conf) => {
            let plugin = PluginManager.getGatePlugin(
                gateContext.gateContextPlugin.name,
                conf.cv_name,
                gateContext.providerName,
            );
            if (plugin) {
                plugins.push({
                    context: {},
                    plugin,
                });
                return;
            }
            const pluginClass = PluginManager.getGatePluginsClass(
                conf.ck_d_plugin.toLowerCase(),
            );
            plugin = new pluginClass(conf.cv_name, conf.cct_params);
            plugins.push({
                context: {},
                plugin,
            });
            rows.push(
                plugin.init().then(() => {
                    PluginManager.setGatePlugins({
                        ...conf,
                        plugin,
                    } as any);
                    return Promise.resolve();
                }),
            );
        });
        await Promise.all(rows);
        return plugins;
    }
}

export default new MainController();
