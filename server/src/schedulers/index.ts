import Logger from "@ungate/plugininf/lib/Logger";
import {sendProcess} from "@ungate/plugininf/lib/util/ProcessSender";
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
                    conf.plugin.toLowerCase(),
                );
                if (pluginClass) {
                    const plugin = pluginClass.default
                        ? new pluginClass.default(
                            conf.id,
                            conf.params,
                            conf.cron,
                            !!conf.isEnabled,
                        )
                        : new pluginClass(
                            conf.id,
                            conf.params,
                            conf.cron,
                            !!conf.isEnabled,
                        );
                    return plugin.init().then(
                        () => {
                            PluginManager.setGateScheduler(conf.id, plugin);
                            return Promise.resolve();
                        },
                        (err: any) => {
                            logger.error(
                                `Not init scheduler plugin ${conf.id}\n${err.message}`,
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
process.on("unhandledRejection", (reason, promise) => {
    logger.error("Unhandled Rejection at: %s\nreason: %s", promise, reason);
});

process.on("uncaughtException", (err, origin) => {
    logger.error("Uncaught Exception at: %s\nreason: %s", err, origin);
    process.exit(1);
});
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
