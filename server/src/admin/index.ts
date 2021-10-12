import Logger from "@ungate/plugininf/lib/Logger";
import { initProcess } from "@ungate/plugininf/lib/util/ProcessSender";
import AdminEventController from "./controllers/AdminEventController";
import KubeController from "./controllers/KubeController";
const logger = Logger.getLogger("Admin");

initProcess(AdminEventController.command, "clusterAdmin");
Promise.all([AdminEventController.init(), KubeController.init()]).then(
    () => logger.info("Init Admin Notification Server"),
    (err) =>
        logger.warn(`Error init Admin Notification Server ${err.message}`, err),
);
