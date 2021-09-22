import Logger from "@ungate/plugininf/lib/Logger";
import { sendProcess } from "@ungate/plugininf/lib/util/ProcessSender";
import PluginManager from "../core/pluginmanager";
import Property from "../core/property";
const logger = Logger.getLogger("SchedulersNode");
class SchedulersNode {
    public async start(): Promise<any> {
        const dbScheduler = await Property.getSchedulers();
        await PluginManager.resetSchedulersClass();
        const confSchedulers = await dbScheduler.find();
        return Promise.all(
            confSchedulers.map(async (conf) => {
                const pluginClass = PluginManager.getGateSchedulerClass(
                    conf.ck_d_plugin.toLowerCase(),
                );
                if (pluginClass) {
                    const plugin = pluginClass.default
                        ? new pluginClass.default(
                              conf.ck_id,
                              conf.cct_params,
                              conf.cv_cron,
                              !!conf.cl_enable,
                          )
                        : new pluginClass(
                              conf.ck_id,
                              conf.cct_params,
                              conf.cv_cron,
                              !!conf.cl_enable,
                          );
                    return plugin.init().then(
                        () => {
                            PluginManager.setGateScheduler(conf.ck_id, plugin);
                            return Promise.resolve();
                        },
                        (err) => {
                            logger.error(
                                `Not init scheduler plugin ${conf.ck_id}\n${err.message}`,
                                err,
                            );
                            return Promise.resolve();
                        },
                    );
                }
                return Promise.resolve();
            }),
        );
    }
}
const schedulersNode = new SchedulersNode();
schedulersNode.start().then(
    () => {
        sendProcess({
            command: "startedSchedulerNode",
            data: {},
            target: "master",
        });
        logger.info("Scheduler node started!");
    },
    (err) => logger.error(`Scheduler node fail start\n${err.message}`, err),
);
export default schedulersNode;
