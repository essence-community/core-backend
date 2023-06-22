import Logger from "@ungate/plugininf/lib/Logger";
import {
    initProcess,
    sendProcess,
} from "@ungate/plugininf/lib/util/ProcessSender";
import PluginManager from "../core/pluginmanager";
import Property from "../core/property";
import ProcessController from "./controllers/ProcessController";
const logger = Logger.getLogger("EventsNode");
class EventsNode {
    public async start(): Promise<any> {
        const dbEvents = await Property.getEvents();
        await ProcessController.init();
        initProcess(ProcessController, "eventNode");
        await PluginManager.resetEventsClass();
        const confEvents = await dbEvents.find();
        return Promise.all(
            confEvents.map(async (conf) => {
                const pluginClass = PluginManager.getGateEventsClass(
                    conf.ck_d_plugin.toLowerCase(),
                );
                if (pluginClass) {
                    const plugin = pluginClass.default
                        ? new pluginClass.default(conf.ck_id, conf.cct_params)
                        : new pluginClass(conf.ck_id, conf.cct_params);
                    return plugin.init().then(
                        () => {
                            PluginManager.setGateEvent(conf.ck_id, plugin);
                            return Promise.resolve();
                        },
                        (err) => {
                            logger.error(
                                `Not init event plugin ${conf.ck_id}\n${err.message}`,
                                err,
                            );
                            return Promise.resolve();
                        },
                    );
                }
                return;
            }),
        );
    }
}
process.on("unhandledRejection", (reason, promise) => {
    logger.error('Unhandled Rejection at: %s\nreason: %s', promise, reason);
});

process.on('uncaughtException', (err, origin) => {
    logger.error('Uncaught Exception at: %s\nreason: %s', err, origin);
    process.exit(1)
});
const eventNode = new EventsNode();
eventNode.start().then(
    () => {
        sendProcess({
            command: "startedEventNode",
            data: {},
            target: "master",
        });
        logger.info("Events node started!");
    },
    (err) => logger.error(`Events node fail start\n${err.message}`, err),
);
export default eventNode;
