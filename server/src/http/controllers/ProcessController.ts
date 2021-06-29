import ILocalDB from "@ungate/plugininf/lib/db/local/ILocalDB";
import IObjectParam from "@ungate/plugininf/lib/IObjectParam";
import Logger from "@ungate/plugininf/lib/Logger";
import { noop } from "lodash";
import PluginManager from "../../core/pluginmanager/PluginManager";
import Property from "../../core/property";
import Mask from "../Mask";
import NotificationController from "./NotificationController";
const log = Logger.getLogger("ProcessController");

class ProcessController {
    private dbProvider: ILocalDB;
    public async init() {
        this.dbProvider = await Property.getProviders();
    }
    public async getWsUsers(data: IObjectParam): Promise<any> {
        return {
            users: NotificationController.getIdUsers(data.nameProvider),
        };
    }
    /**
     * Сброс провайдера
     * @param  {[type]} data [description]
     * @return {[type]}      [description]
     */
    public async reloadProvider(data) {
        const provider = PluginManager.getGateProvider(
            data.nameContext,
            data.name,
        );
        if (provider) {
            log.info(
                `Start init provider ${data.name} process: ${process.env.UNGATE_HTTP_ID}`,
            );
            Mask.mask(data.session)
                .then(() =>
                    provider.init(true).then(
                        () => {
                            log.info(
                                `End init provider ${data.name} process: ${process.env.UNGATE_HTTP_ID}`,
                            );
                            return Mask.unmask(data.session);
                        },
                        (err) => {
                            log.error(err);
                            return Mask.unmask(data.session);
                        },
                    ),
                )
                .then(noop)
                .catch(() => Mask.unmask(data.session));
        }
    }

    /**
     * Сброс провайдера
     * @param  {[type]} data [description]
     * @return {[type]}      [description]
     */
    public async reloadAllProvider(data) {
        const rows = [];
        log.info(
            `Start init provider all process: ${process.env.UNGATE_HTTP_ID}`,
        );
        Mask.mask(data.session)
            .then(() => {
                PluginManager.getGateProviders(data.nameContext).forEach(
                    (provider) => {
                        rows.push(provider.init(true));
                    },
                );
                return Promise.all(rows).then(
                    () => {
                        log.info(
                            `End init provider all process: ${process.env.UNGATE_HTTP_ID}`,
                        );
                        return Mask.unmask(data.session);
                    },
                    (err) => {
                        log.error(err);
                        return Mask.unmask(data.session);
                    },
                );
            })
            .then(noop)
            .catch(() => Mask.unmask(data.session));
    }

    /**
     * Сброс провайдера
     * @param  {[type]} data [description]
     * @return {[type]}      [description]
     */
    public async reloadContext(data) {
        const config = PluginManager.getGateContext(data.name);
        if (config) {
            log.info(
                `Start init config ${data.name} process: ${process.env.UNGATE_HTTP_ID}`,
            );
            Mask.mask(data.session)
                .then(() =>
                    config.init(true).then(
                        () => {
                            log.info(
                                `End init config ${data.name} process: ${process.env.UNGATE_HTTP_ID}`,
                            );
                            return Mask.unmask(data.session);
                        },
                        (err) => {
                            log.error(err);
                            return Mask.unmask(data.session);
                        },
                    ),
                )
                .then(noop)
                .catch(() => Mask.unmask(data.session));
        }
    }

    /**
     * Сброс
     * @return {[type]}      [description]
     */
    public async resetContextClass(data) {
        Mask.mask(data.session)
            .then(() =>
                PluginManager.resetGateContextClass().then(() => {
                    return Mask.unmask(data.session);
                }),
            )
            .then(noop)
            .catch(() => Mask.unmask(data.session));
    }

    /**
     * Сброс
     * @return {[type]}      [description]
     */
    public async resetProviderClass(data) {
        Mask.mask(data.session)
            .then(() =>
                PluginManager.resetGateProviderClass().then(() => {
                    return Mask.unmask(data.session);
                }),
            )
            .then(noop);
    }

    /**
     * Сброс
     * @return {[type]}      [description]
     */
    public async resetPluginClass(data) {
        Mask.mask(data.session)
            .then(() =>
                PluginManager.resetGatePluginsClass().then(() => {
                    return Mask.unmask(data.session);
                }),
            )
            .then(noop)
            .catch(() => Mask.unmask(data.session));
    }

    /**
     * Сброс настроек
     * @return {[type]}      [description]
     */
    public async reloadAllContext(data) {
        const rows = [];
        log.info(
            `Start init config all process: ${process.env.UNGATE_HTTP_ID}`,
        );
        Mask.mask(data.session)
            .then(() => {
                PluginManager.getGateContexts().forEach((config) => {
                    rows.push(config.init(true));
                });
                return Promise.all(rows).then(
                    () => {
                        log.info(
                            `End init config all process: ${process.env.UNGATE_HTTP_ID}`,
                        );
                        return Mask.unmask(data.session);
                    },
                    (err) => {
                        log.error(err);
                        return Mask.unmask(data.session);
                    },
                );
            })
            .then(noop)
            .catch(() => Mask.unmask(data.session));
    }

    /**
     * Сброс провайдера
     * @param  {[type]} data [description]
     * @return {[type]}      [description]
     */
    public async destroyProvider(data) {
        Mask.mask(data.session)
            .then(async () => {
                await PluginManager.removeGateProvider(
                    data.nameContext,
                    data.name,
                );
                return Mask.unmask(data.session);
            })
            .then(noop);
    }

    /**
     * Сброс всех провайдеров
     * @param  {[type]} data [description]
     * @return {[type]}      [description]
     */
    public async destroyAllProvider(data) {
        Mask.mask(data.session)
            .then(async () => {
                await PluginManager.removeAllGateProvider();
                return Mask.unmask(data.session);
            })
            .then(noop)
            .catch(() => Mask.unmask(data.session));
    }

    /**
     * Отправка оповещения
     * @param data
     */
    public async sendNotification(data) {
        NotificationController.sendNotification(
            data.ckUser,
            data.nameProvider,
            data.text,
        );
    }

    /**
     * Отправка оповещения
     * @param data
     */
    public async sendNotificationAll(data) {
        NotificationController.sendNotificationAll(data.text);
    }

    /**
     * Обновление информации пользователя
     */
    public async updateUserInfo(data) {
        NotificationController.updateUserInfo(data.ckUser, data.nameProvider);
    }

    /**
     * Смена маски
     * @param data
     */
    public async setMask(data) {
        if (Mask.masked !== data.mask) {
            Mask.setMask(data.mask);
        }
    }
}

export default new ProcessController();
