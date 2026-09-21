import IObjectParam from "@ungate/plugininf/lib/IObjectParam";
import Logger from "@ungate/plugininf/lib/Logger";
import {noop} from "lodash";
import PluginManager from "../../core/pluginmanager/PluginManager";
import Mask from "../Mask";
import NotificationController from "./NotificationController";
import {fromCache, fromSession, fromUser} from "@ungate/plugininf/lib/entries/map";
const log = Logger.getLogger("ProcessController");

class ProcessController {
    public async init() {
        return;
    }
    public handlers: Record<string, (data?: Record<string, any>) => Promise<any>> = {
        getWsUsers: this.getWsUsers,
        reloadProvider: this.reloadProvider,
        reloadAllProvider: this.reloadAllProvider,
        reloadContext: this.reloadContext,
        resetContextClass: this.resetContextClass,
        resetProviderClass: this.resetProviderClass,
        resetPluginClass: this.resetPluginClass,
        reloadAllContext: this.reloadAllContext,
        destroyProvider: this.destroyProvider,
        destroyAllProvider: this.destroyAllProvider,
        sendNotification: this.sendNotification,
        sendNotificationAll: this.sendNotificationAll,
        updateUserInfo: this.updateUserInfo,
        setMask: this.setMask,
        saveSessCtl: this.saveSessCtl,
    };

    private async saveSessCtl(data?: Record<string, any>): Promise<any> {
        if (process.env.UNGATE_HTTP_ID !== "1") {
            return;
        }
        const context = PluginManager.getGateContext(data?.context);
        if (context) {
            const sessionCtl = context.sessCtrl;
            switch (data?.table) {
                case "t_user": {
                    const user = sessionCtl.getUserStore();
                    const doc = fromUser(data?.entity);
                    if (doc.id) {
                        user.update(doc.id, doc);
                    } else {
                        user.save(doc, {listeners: false});
                    }
                    break;
                }
                case "t_cache": {
                    const cache = sessionCtl.getCacheStore();
                    const doc = fromCache(data?.entity);
                    if (doc.id) {
                        cache.update(doc.id, doc);
                    } else {
                        cache.save(doc, {listeners: false});
                    }
                    break;
                }
                case "t_session": {
                    const session = sessionCtl.getSessionStore();
                    const doc = fromSession(data?.entity);
                    if (doc.id) {
                        session.update(doc.id, doc);
                    } else {
                        session.save(doc, {listeners: false});
                    }
                    break;
                }
                default:
                    break;
            }
        }
    }

    private async getWsUsers(data?: Record<string, any>): Promise<any> {
        return {
            users: NotificationController.getIdUsers(data?.nameProvider),
        };
    }
    /**
     * Сброс провайдера
     * @param  {[type]} data [description]
     * @return {[type]}      [description]
     */
    private async reloadProvider(data?: Record<string, any>): Promise<any> {
        const providers = PluginManager.findGateProvider(
            data?.nameContext,
            data?.name,
        );
        if (providers.length) {
            log.info(
                `Start init provider ${data?.name} process: ${process.env.UNGATE_HTTP_ID}`,
            );
            Promise.all(
                providers.map((provider) =>
                    PluginManager.removeGateProvider(
                        data?.nameContext,
                        provider.name,
                    ),
                ),
            )
                .then(() => true)
                .catch(() => true);
        }
    }

    /**
     * Сброс провайдера
     * @param  {[type]} data [description]
     * @return {[type]}      [description]
     */
    private async reloadAllProvider(data?: Record<string, any>): Promise<any> {
        const rows = [];
        log.info(
            `Start init provider all process: ${process.env.UNGATE_HTTP_ID}`,
        );
        PluginManager.removeAllGateProvider(data?.nameContext)
            .then(noop)
            .catch(noop);
    }

    /**
     * Сброс провайдера
     * @param  {[type]} data [description]
     * @return {[type]}      [description]
     */
    private async reloadContext(data?: Record<string, any>): Promise<any> {
        const config = PluginManager.getGateContext(data?.name);
        if (config) {
            log.info(
                `Start init config ${data?.name} process: ${process.env.UNGATE_HTTP_ID}`,
            );
            Mask.mask(data?.session)
                .then(() =>
                    config.init(true).then(
                        () => {
                            log.info(
                                `End init config ${data?.name} process: ${process.env.UNGATE_HTTP_ID}`,
                            );
                            return Mask.unmask(data?.session);
                        },
                        (err) => {
                            log.error(err);
                            return Mask.unmask(data?.session);
                        },
                    ),
                )
                .then(noop)
                .catch(() => Mask.unmask(data?.session));
        }
    }

    /**
     * Сброс
     * @return {[type]}      [description]
     */
    private async resetContextClass(data?: Record<string, any>): Promise<any> {
        Mask.mask(data?.session)
            .then(() =>
                PluginManager.resetGateContextClass().then(() => {
                    return Mask.unmask(data?.session);
                }),
            )
            .then(noop)
            .catch(() => Mask.unmask(data?.session));
    }

    /**
     * Сброс
     * @return {[type]}      [description]
     */
    private async resetProviderClass(data?: Record<string, any>): Promise<any> {
        Mask.mask(data?.session)
            .then(() =>
                PluginManager.resetGateProviderClass().then(() => {
                    return Mask.unmask(data?.session);
                }),
            )
            .then(noop);
    }

    /**
     * Сброс
     * @return {[type]}      [description]
     */
    private async resetPluginClass(data?: Record<string, any>): Promise<any> {
        Mask.mask(data?.session)
            .then(() =>
                PluginManager.resetGatePluginsClass().then(() => {
                    return Mask.unmask(data?.session);
                }),
            )
            .then(noop)
            .catch(() => Mask.unmask(data?.session));
    }

    /**
     * Сброс настроек
     * @return {[type]}      [description]
     */
    private async reloadAllContext(data?: Record<string, any>): Promise<any> {
        const rows: Promise<any>[] = [];
        log.info(
            `Start init config all process: ${process.env.UNGATE_HTTP_ID}`,
        );
        Mask.mask(data?.session)
            .then(() => {
                PluginManager.getGateContexts().forEach((config) => {
                    rows.push(config.init(true));
                });
                return Promise.all(rows).then(
                    () => {
                        log.info(
                            `End init config all process: ${process.env.UNGATE_HTTP_ID}`,
                        );
                        return Mask.unmask(data?.session);
                    },
                    (err) => {
                        log.error(err);
                        return Mask.unmask(data?.session);
                    },
                );
            })
            .then(noop)
            .catch(() => Mask.unmask(data?.session));
    }

    /**
     * Сброс провайдера
     * @param  {[type]} data [description]
     * @return {[type]}      [description]
     */
    private async destroyProvider(data?: Record<string, any>): Promise<any> {
        Mask.mask(data?.session)
            .then(async () => {
                await PluginManager.removeGateProvider(
                    data?.nameContext,
                    data?.name,
                );
                return Mask.unmask(data?.session);
            })
            .then(noop);
    }

    /**
     * Сброс всех провайдеров
     * @param  {[type]} data [description]
     * @return {[type]}      [description]
     */
    private async destroyAllProvider(data?: Record<string, any>): Promise<any> {
        Mask.mask(data?.session)
            .then(async () => {
                await PluginManager.removeAllGateProvider();
                return Mask.unmask(data?.session);
            })
            .then(noop)
            .catch(() => Mask.unmask(data?.session));
    }

    /**
     * Отправка оповещения
     * @param data
     */
    private async sendNotification(data?: Record<string, any>): Promise<any> {
        NotificationController.sendNotification(
            data?.ckUser,
            data?.nameProvider,
            data?.text,
        );
    }

    /**
     * Отправка оповещения
     * @param data
     */
    private async sendNotificationAll(data?: Record<string, any>): Promise<any> {
        NotificationController.sendNotificationAll(data?.text);
    }

    /**
     * Обновление информации пользователя
     */
    private async updateUserInfo(data?: Record<string, any>): Promise<any> {
        NotificationController.updateUserInfo(data?.nameProvider, data?.ckUser);
    }

    /**
     * Смена маски
     * @param data
     */
    private async setMask(data?: Record<string, any>): Promise<any> {
        if (Mask.masked !== data?.mask) {
            Mask.setMask(data?.mask);
        }
    }
}

export default new ProcessController();
