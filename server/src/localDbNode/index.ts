import * as nedb from "@ungate/nedb-multi";
import Logger from "@ungate/plugininf/lib/Logger";
import { sendProcess } from "@ungate/plugininf/lib/util/ProcessSender";
import * as axon from "axon";
import * as fs from "fs";
import * as URL from "url";
import Constants from "../core/Constants";
const logger = Logger.getLogger("LocalDbNode");

class BuilderLocalDbNode {
    public start() {
        const repSocket = axon.socket("rep");
        const messagesHandler = nedb.HandlerNeDb.create(new Map());
        this.deleteFolderRecursive(Constants.NEDB_TEMP_DB);
        if (Constants.NEDB_MULTI_HOST) {
            if (
                Constants.NEDB_MULTI_HOST.startsWith("unix:") ||
                Constants.NEDB_MULTI_HOST.startsWith("tcp:")
            ) {
                const url = URL.parse(Constants.NEDB_MULTI_HOST);
                if (url.protocol === "unix:" && fs.existsSync(url.path)) {
                    fs.unlinkSync(url.path);
                }
                repSocket.bind(Constants.NEDB_MULTI_HOST);
            } else {
                repSocket.bind(
                    Constants.NEDB_MULTI_PORT,
                    Constants.NEDB_MULTI_HOST,
                );
            }
        } else {
            repSocket.bind(Constants.NEDB_MULTI_PORT);
        }
        repSocket.on("message", messagesHandler);
        logger.info("LocalDbNode started");
        sendProcess({
            command: "startedLocalDbNode",
            data: {},
            target: "master",
        });
    }
    private deleteFolderRecursive(pathDir) {
        if (fs.existsSync(pathDir)) {
            fs.readdirSync(pathDir).forEach((file) => {
                const curPath = `${pathDir}/${file}`;
                if (fs.lstatSync(curPath).isDirectory()) {
                    this.deleteFolderRecursive(curPath);
                } else {
                    fs.unlinkSync(curPath);
                }
            });
            fs.rmdirSync(pathDir);
        }
    }
}
process.on("unhandledRejection", (reason, promise) => {
    logger.error('Unhandled Rejection at: %s\nreason: %s', promise, reason);
});

process.on('uncaughtException', (err, origin) => {
    logger.error('Uncaught Exception at: %s\nreason: %s', err, origin);
    process.exit(1)
});
const LocalDbNode = new BuilderLocalDbNode();
LocalDbNode.start();

export = LocalDbNode;
