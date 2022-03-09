import BreakException from "@ungate/plugininf/lib/errors/BreakException";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import IContext from "@ungate/plugininf/lib/IContext";
import IObjectParam from "@ungate/plugininf/lib/IObjectParam";
import IPlugin, { IPluginRequestContext } from "@ungate/plugininf/lib/IPlugin";
import IQuery, { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import IResult from "@ungate/plugininf/lib/IResult";
import ISession from "@ungate/plugininf/lib/ISession";
import NullSessProvider, {
    IAuthResult,
} from "@ungate/plugininf/lib/NullSessProvider";
import { isEmpty } from "@ungate/plugininf/lib/util/Util";

export interface IPlugins {
    plugin: IPlugin;
    context: IPluginRequestContext;
}

class PluginController {
    /** Вызов плагинов перед инициализацией запроса */
    public applyPluginInitQueryBefore(
        gateContext: IContext,
        plugins: IPlugins[],
        query?: IQuery,
    ): Promise<IQuery> {
        if (plugins.length) {
            let res = query;
            return plugins
                .slice(1)
                .reduce(
                    (prom, plugin) =>
                        prom.then((result) => {
                            if (!isEmpty(result)) {
                                res = result as IQuery;
                            }
                            gateContext.trace(
                                `plugin ${plugin.plugin.name} execute beforeInitQueryPerform`,
                            );
                            return plugin.plugin.beforeInitQueryPerform(
                                gateContext,
                                plugins[0].context,
                                query,
                            );
                        }),
                    plugins[0].plugin.beforeInitQueryPerform(
                        gateContext,
                        plugins[0].context,
                        query,
                    ),
                )
                .then((result) =>
                    Promise.resolve(isEmpty(result) ? res : (result as IQuery)),
                );
        }
        return Promise.resolve(query);
    }

    /** Вызов плагинов после инициализацией запроса */
    public applyPluginInitQueryAfter(
        gateContext: IContext,
        plugins: IPlugins[],
        query: IGateQuery,
    ): Promise<void> {
        if (plugins.length) {
            return plugins
                .slice(1)
                .reduce(
                    (prom, plugin) =>
                        prom.then(() => {
                            gateContext.trace(
                                `plugin ${plugin.plugin.name} execute afterInitQueryPerform`,
                            );
                            return plugin.plugin.afterInitQueryPerform(
                                gateContext,
                                plugins[0].context,
                                query,
                            );
                        }),
                    plugins[0].plugin.afterInitQueryPerform(
                        gateContext,
                        plugins[0].context,
                        query,
                    ),
                )
                .then(() => Promise.resolve());
        }
        return Promise.resolve();
    }

    /** Вызов плагинов перед вызовом запроса */
    public applyPluginQueryExecuteBefore(
        gateContext: IContext,
        plugins: IPlugins[],
        query: IGateQuery,
    ): Promise<IResult | null> {
        if (plugins.length) {
            let res = null;
            return plugins
                .slice(1)
                .reduce(
                    (prom, plugin) =>
                        prom.then((result) => {
                            if (!isEmpty(result)) {
                                res = result;
                            }
                            gateContext.trace(
                                `plugin ${plugin.plugin.name} execute beforeQueryExecutePerform`,
                            );
                            return res
                                ? Promise.resolve(res)
                                : plugin.plugin.beforeQueryExecutePerform(
                                      gateContext,
                                      plugins[0].context,
                                      query,
                                  );
                        }),
                    plugins[0].plugin.beforeQueryExecutePerform(
                        gateContext,
                        plugins[0].context,
                        query,
                    ),
                )
                .then((result) =>
                    Promise.resolve(isEmpty(result) ? res : result),
                );
        }
        return Promise.resolve(null);
    }

    /** Вызов плагинов для проверки перед сохранением сессии */
    public applyPluginBeforeSession(
        gateContext: IContext,
        plugins: IPlugins[],
    ): Promise<(IAuthResult & { namePlugin: string }) | null> {
        if (plugins.length) {
            return plugins
                .slice(1)
                .reduce(
                    (prom, plugin) =>
                        prom.then((result) => {
                            if (!isEmpty(result)) {
                                return result;
                            }
                            gateContext.trace(
                                `plugin ${plugin.plugin.name} execute beforeSession`,
                            );
                            return plugin.plugin
                                .beforeSession(gateContext, plugins[0].context)
                                .then((res) =>
                                    isEmpty(res)
                                        ? null
                                        : ({
                                              ...res,
                                              namePlugin:
                                                  plugins[0].plugin.name,
                                          } as IAuthResult & {
                                              namePlugin: string;
                                          }),
                                );
                        }),
                    plugins[0].plugin
                        .beforeSession(gateContext, plugins[0].context)
                        .then((res) =>
                            isEmpty(res)
                                ? null
                                : ({
                                      ...res,
                                      namePlugin: plugins[0].plugin.name,
                                  } as IAuthResult & { namePlugin: string }),
                        ),
                )
                .then((result) => (isEmpty(result) ? null : result));
        }
        return Promise.resolve(null);
    }

    /** Вызов плагинов для проверки перед сохранением сессии */
    public applyPluginBeforeSaveSession(
        gateContext: IContext,
        plugins: IPlugins[],
        data: IObjectParam,
    ): Promise<boolean> {
        if (plugins.length) {
            let res = true;
            return plugins
                .slice(1)
                .reduce(
                    (prom, plugin) =>
                        prom.then((result) => {
                            if (res !== result) {
                                res = result;
                            }
                            gateContext.trace(
                                `plugin ${plugin.plugin.name} execute beforeSaveSession`,
                            );
                            return res
                                ? plugin.plugin.beforeSaveSession(
                                      gateContext,
                                      plugins[0].context,
                                      data,
                                  )
                                : Promise.resolve(res);
                        }),
                    plugins[0].plugin.beforeSaveSession(
                        gateContext,
                        plugins[0].context,
                        data,
                    ),
                )
                .then((result) =>
                    Promise.resolve(isEmpty(result) ? res : result),
                );
        }
        return Promise.resolve(true);
    }

    /** Вызов плагинов после обработки запроса */
    public applyPluginAfterQueryExecute(
        gateContext: IContext,
        plugins: IPlugins[],
        resOrigin: IResult,
    ): Promise<IResult> {
        if (plugins.length) {
            let res: IResult = resOrigin;
            return plugins
                .slice(1)
                .reduce(
                    (prom, plugin) =>
                        prom.then((result) => {
                            if (!isEmpty(result)) {
                                if (res.data && (result as IResult).data) {
                                    res.data.on("error", (err) =>
                                        (result as IResult).data.emit(
                                            "error",
                                            err,
                                        ),
                                    );
                                } else if (res.data) {
                                    res.data.on("error", (err) =>
                                        gateContext.warn(`${err.message}`, err),
                                    );
                                }
                                res = result as IResult;
                            }
                            gateContext.trace(
                                `plugin ${plugin.plugin.name} execute afterQueryExecutePerform`,
                            );
                            return plugin.plugin.afterQueryExecutePerform(
                                gateContext,
                                plugins[0].context,
                                res,
                            );
                        }),
                    plugins[0].plugin.afterQueryExecutePerform(
                        gateContext,
                        plugins[0].context,
                        res,
                    ),
                )
                .then((result) =>
                    Promise.resolve(
                        isEmpty(result) ? res : (result as IResult),
                    ),
                );
        }
        return Promise.resolve(resOrigin);
    }

    /** Вызов плагинов для обработки ошибки */
    public applyPluginError(
        gateContext: IContext,
        plugins: IPlugins[],
        err: BreakException | ErrorException | Error,
    ): Promise<BreakException | ErrorException | Error> {
        let res = err;
        if (plugins.length) {
            gateContext.trace(`Real error ${err.message}`, err);
            return plugins
                .slice(1)
                .reduce(
                    (prom, plugin) =>
                        prom.then((result) => {
                            if (!isEmpty(result)) {
                                res = result as any;
                            }
                            gateContext.trace(
                                `plugin ${plugin.plugin.name} execute handleError`,
                            );
                            return plugin.plugin.handleError(
                                gateContext,
                                plugins[0].context,
                                res,
                            );
                        }),
                    plugins[0].plugin.handleError(
                        gateContext,
                        plugins[0].context,
                        res,
                    ),
                )
                .then(async (result: any) => (isEmpty(result) ? res : result))
                .catch((breakErr) => Promise.resolve(breakErr));
        }
        return Promise.resolve(res);
    }

    public applyBeforeSession(
        gateContext: IContext,
        providers: NullSessProvider[] = [],
    ): Promise<ISession | void> {
        if (providers.length) {
            return providers.slice(1).reduce(
                (prom, provider) =>
                    prom.then((result) => {
                        if (!isEmpty(result)) {
                            return Promise.resolve(result);
                        }
                        gateContext.trace(
                            `providerAuth ${provider.name} execute beforeSession`,
                        );
                        return provider.beforeSession(
                            gateContext,
                            gateContext.sessionId,
                        );
                    }),
                providers[0].beforeSession(gateContext, gateContext.sessionId),
            );
        }
        return Promise.resolve();
    }

    public applyAfterSession(
        gateContext: IContext,
        session?: ISession,
        providers: NullSessProvider[] = [],
    ): Promise<ISession> {
        if (providers.length) {
            return providers.slice(1).reduce(
                (prom, provider) =>
                    prom.then((result) => {
                        gateContext.trace(
                            `providerAuth ${provider.name} execute afterSession`,
                        );
                        return provider.afterSession(
                            gateContext,
                            gateContext.sessionId,
                            result,
                        );
                    }),
                providers[0].afterSession(
                    gateContext,
                    gateContext.sessionId,
                    session,
                ),
            );
        }
        return Promise.resolve(session);
    }

    public applyCheckQuery(
        gateContext: IContext,
        query: IGateQuery,
        providers: NullSessProvider[] = [],
    ): Promise<void> {
        if (providers.length) {
            return providers.slice(1).reduce(
                (prom, provider) =>
                    prom.then(() => {
                        gateContext.trace(
                            `providerAuth ${provider.name} execute checkQuery`,
                        );
                        return provider.checkQuery(gateContext, query);
                    }),
                providers[0].checkQuery(gateContext, query),
            );
        }
        return Promise.resolve();
    }
}

export default new PluginController();
