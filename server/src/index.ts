import ProcessController from "./master/ProcessController";
import Logger from "@ungate/plugininf/lib/Logger";

const logger = Logger.getLogger("master");

ProcessController.init().then(() => {
    logger.info("Master initialized");
});
