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
        initProcess(ProcessController.handlers, "eventNode");
        await PluginManager.resetEventsClass();
        const confEvents = await dbEvents.find();
        return Promise.all(
            confEvents.map(async (conf) => {
                const pluginClass = PluginManager.getGateEventsClass(
                    conf.plugin.toLowerCase(),
                );
                if (pluginClass) {
                    const plugin = pluginClass.default
                        ? new pluginClass.default(conf.id, conf.params)
                        : new pluginClass(conf.id, conf.params);
                    return plugin.init().then(
                        () => {
                            PluginManager.setGateEvent(conf.id, plugin);
                            return Promise.resolve();
                        },
                        (err: any) => {
                            logger.error(
                                `Not init event plugin ${conf.id}\n${err.message}`,
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
    logger.error("Unhandled Rejection at: %s\nreason: %s", promise, reason);
});

process.on("uncaughtException", (err, origin) => {
    logger.error("Uncaught Exception at: %s\nreason: %s", err, origin);
    process.exit(1);
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
