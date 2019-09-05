import Logger from "@ungate/plugininf/lib/Logger";
import { initProcess } from "@ungate/plugininf/lib/util/ProcessSender";
import AdminEventController from "./controllers/AdminEventController";
const logger = Logger.getLogger("Admin");

initProcess(AdminEventController, "clusterAdmin");
AdminEventController.init().then(
    () => logger.info("Init Admin Notification Server"),
    (err) =>
        logger.warn(`Error init Admin Notification Server ${err.message}`, err),
);
