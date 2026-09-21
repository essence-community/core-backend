import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import IContext, {TAction} from "@ungate/plugininf/lib/IContext";
import IQuery from "@ungate/plugininf/lib/IQuery";
import ISession from "@ungate/plugininf/lib/ISession";
import NullSessProvider from "@ungate/plugininf/lib/NullSessProvider";
import ResultStream from "@ungate/plugininf/lib/stream/ResultStream";
import {hiddenSecret, isEmpty} from "@ungate/plugininf/lib/util/Util";
import {noop} from "lodash";
import Constants from "../../core/Constants";
import PluginManager from "../../core/pluginmanager/PluginManager";
import Property from "../../core/property/Property";
import RequestContext from "../../core/request/RequestContext";
import WSQuery from "../../core/WSQuery";
import Mask from "../Mask";
import ActionController from "./ActionController";
import PluginController, {IPlugins} from "./PluginController";
import ResultController from "./ResultController";
import {In, IsNull, Repository} from "typeorm";
import {ProviderModel} from "../../core/property/entities/ProviderModel";
import {PluginModel} from "../../core/property/entities/PluginModel";
import {QueryModel} from "../../core/property/entities/QueryModel";
import Connection from "@ungate/plugininf/lib/db/Connection";
import {IMetaData} from "@ungate/plugininf/lib/IResult";
import ICCTParams from "@ungate/plugininf/lib/ICCTParams";
/**
 * Created by artemov_i on 04.12.2018.
 */

class MainController {
    public providerStore!: Repository<ProviderModel>;
    public queryStore!: Repository<QueryModel>;
    public pluginStore!: Repository<PluginModel>;
    public async init() {
        this.providerStore = await Property.getProviders();
        this.pluginStore = await Property.getPlugins();
        this.queryStore = await Property.getQuery();
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

            const sessCtrl = requestContext.gateContextPlugin.sessCtrl;
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
            const cResult =
                await requestContext.gateContextPlugin.initContext(
                    requestContext,
                );
            if (!isEmpty(cResult.connection)) {
                requestContext.connection = cResult.connection as Connection;
            }
            if (!isEmpty(cResult.queryName)) {
                requestContext.setQueryName(cResult.queryName as string);
            }
            if (!isEmpty(cResult.pluginName)) {
                requestContext.setPluginName(cResult.pluginName as string[]);
            }
            if (!isEmpty(cResult.providerName)) {
                requestContext.setProviderName(cResult.providerName as string);
            }
            if (!isEmpty(cResult.query)) {
                query = cResult.query;
            }
            if (!isEmpty(cResult.metaData)) {
                requestContext.metaData = cResult.metaData as IMetaData;
            }
            if (!isEmpty(cResult.actionName)) {
                requestContext.setActionName(cResult.actionName as TAction);
            }
            if (
                !isEmpty(cResult.defaultActionName) &&
                (isEmpty(requestContext.actionName) ||
                    requestContext.actionName === "auth")
            ) {
                requestContext.setActionName(cResult.defaultActionName as TAction);
            }
            if (
                !isEmpty(cResult.defaultQueryName) &&
                isEmpty(requestContext.queryName)
            ) {
                requestContext.setQueryName(cResult.defaultQueryName as string);
            }
            if (
                !isEmpty(cResult.defaultProviderName) &&
                isEmpty(requestContext.providerName)
            ) {
                requestContext.setProviderName(cResult.defaultProviderName as string);
            }
            if (
                !isEmpty(cResult.defaultPluginName) &&
                isEmpty(requestContext.pluginName)
            ) {
                requestContext.setPluginName(cResult.defaultPluginName as string[]);
            }
            if (
                !isEmpty(cResult.loginQuery) &&
                requestContext.actionName === "auth"
            ) {
                requestContext.setQueryName(cResult.loginQuery as string);
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
    private async checkError(err: any, requestContext: RequestContext, plugins: IPlugins[]): Promise<void> {
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
        const param = hiddenSecret(Object.assign({}, gateContext.params));

        if (gateContext.session) {
            gateContext.info(
                `${gateContext.request.method}(${gateContext.actionName},${gateContext.queryName}` +
                `,${gateContext.providerName || ""},${gateContext.isTraceEnabled()
                    ? JSON.stringify(param)
                    : ""
                },${gateContext.isTraceEnabled()
                    ? JSON.stringify(gateContext.session)
                    : gateContext.session.session.substr(0, 10)
                })`,
            );
        } else {
            gateContext.info(
                `${gateContext.request.method}(${gateContext.actionName},${gateContext.queryName}` +
                `,${gateContext.providerName},${gateContext.isTraceEnabled()
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
        const config = await this.providerStore.findOne(
            {
                where: [{
                    id: gateContext.providerName,
                    context: gateContext.gateContextPlugin.name,
                }, {
                    id: gateContext.providerName,
                    context: IsNull()
                }],
            },
        );
        if (!config) {
            throw new ErrorException(ErrorGate.PLUGIN_NOT_FOUND);
        }
        const pluginClass = PluginManager.getGateProviderClass(
            config.plugin.toLowerCase(),
        );
        provider = pluginClass.default
            ? new pluginClass.default(
                config.id,
                config.params as ICCTParams,
                gateContext.gateContextPlugin.sessCtrl,
            )
            : new pluginClass(
                config.id,
                config.params as ICCTParams,
                gateContext.gateContextPlugin.sessCtrl,
            );
        await provider.init();
        PluginManager.setGateProvider(
            gateContext.gateContextPlugin.name,
            config.id,
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
        const queryDoc = await this.queryStore.findOne(
            {
                where: [{
                    name: gateContext.queryName,
                    provider: gateContext.providerName,
                    context: gateContext.gateContextPlugin.name,
                }, {
                    name: gateContext.queryName,
                    provider: gateContext.providerName,
                    context: IsNull()
                }],
            },
        );
        if (queryDoc) {
            query.extraInParams = queryDoc.inParams;
            query.extraOutParams = queryDoc.outParams;
        }
        return;
    }

    /**
     * Загружаем провайдер данных
     * @param gateContext
     * @returns
     */
    private async loadPlugins(gateContext: RequestContext) {
        const configs = await this.pluginStore.find({
            where: gateContext.pluginName.length ? [{
                name: In(gateContext.pluginName),
                provider: In(["all", gateContext.providerName]),
                context: gateContext.gateContextPlugin.name,
            }, {
                name: In(gateContext.pluginName),
                provider: In(["all", gateContext.providerName]),
                context: IsNull()
            }, {
                isRequired: true,
                provider: In(["all", gateContext.providerName]),
                context: IsNull()
            }, {
                isRequired: true,
                provider: In(["all", gateContext.providerName]),
                context: gateContext.gateContextPlugin.name,
            }] : [{
                isRequired: true,
                provider: In(["all", gateContext.providerName]),
                context: IsNull()
            }, {
                isRequired: true,
                provider: In(["all", gateContext.providerName]),
                context: gateContext.gateContextPlugin.name,
            }, {
                isDefault: true,
                provider: In(["all", gateContext.providerName]),
                context: IsNull()
            }, {
                isDefault: true,
                provider: In(["all", gateContext.providerName]),
                context: gateContext.gateContextPlugin.name,
            }],
        });
        configs.sort((val1, val2) => val1.order - val2.order);
        const rows: Promise<void>[] = [];
        const plugins: IPlugins[] = [];
        configs.forEach((conf) => {
            let plugin = PluginManager.getGatePlugin(
                gateContext.gateContextPlugin.name,
                conf.name,
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
                conf.plugin.toLowerCase(),
            );
            plugin = new pluginClass(conf.name, conf.params as ICCTParams);
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
