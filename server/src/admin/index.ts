import Logger from "@ungate/plugininf/lib/Logger";
import { initProcess } from "@ungate/plugininf/lib/util/ProcessSender";
import AdminEventController from "./controllers/AdminEventController";
import KubeController from "./controllers/KubeController";
const logger = Logger.getLogger("Admin");

process.on("unhandledRejection", (reason, promise) => {
    logger.error('Unhandled Rejection at: %s\nreason: %s', promise, reason);
});

process.on('uncaughtException', (err, origin) => {
    logger.error('Uncaught Exception at: %s\nreason: %s', err, origin);
    process.exit(1)
});
initProcess(AdminEventController.command, "clusterAdmin");
Promise.all([AdminEventController.init(), KubeController.init()]).then(
    () => logger.info("Init Admin Notification Server"),
    (err) =>
        logger.warn(`Error init Admin Notification Server ${err.message}`, err),
);
