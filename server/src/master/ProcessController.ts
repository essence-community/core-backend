import Logger from "@ungate/plugininf/lib/Logger";
import {ISenderOptions} from "@ungate/plugininf/lib/util/ProcessSender";
import * as ChildProcess from "child_process";
import * as path from "path";
import Constants from "../core/Constants";
import * as fs from "fs";
import {deleteFolderRecursive} from "@ungate/plugininf/lib/util/Util";
import Property from "../core/property";
import MsgPack from "msgpack-lite";
const logger = Logger.getLogger("master");

const checkMessage =
    (nodes: INode, name: string, id: number) => (message: ISenderOptions) => {
        if (
            logger.isTraceEnabled() &&
            message.target &&
            message.command !== "sendAllServerCallDb"
        ) {
            logger.trace(
                `Process receive nameNode: ${name} pid: ${id} message ${JSON.stringify(
                    message,
                )}`,
            );
        }
        switch (message.target) {
            case "cluster":
                if (nodes.http && id !== nodes.http.pid) {
                    nodes.http.send(message);
                }
                break;
            case "clusterAdmin":
                if (nodes.admin && id !== nodes.admin.pid) {
                    nodes.admin.send(message);
                }
                break;
            case "eventNode":
                if (nodes.events && id !== nodes.events.pid) {
                    nodes.events.send(message);
                }
                break;
            case "schedulerNode":
                if (nodes.schedulers && id !== nodes.schedulers.pid) {
                    nodes.schedulers.send(message);
                }
                break;
            case "master": {
                if (
                    "object" === typeof message.data &&
                    message.data.type === "Buffer"
                ) {
                    message.data = MsgPack.decode(Buffer.from(message.data.data));
                }
                if (ProcessController.handler[message.command as keyof typeof ProcessController.handler]) {
                    ProcessController.handler[message.command as keyof typeof ProcessController.handler](
                        message.data,
                    );
                }
                break;
            }
            default:
                break;
        }
    };

function killNode(nodes: INode, name: string): Promise<void> {
    const node = nodes[name];
    delete nodes[name];
    if (!node) {
        return Promise.resolve();
    }
    return new Promise((resolve) => {
        node.removeAllListeners("close");
        node.on("close", () => resolve());
        node.on("exit", () => resolve());
        node.kill("SIGKILL");
    });
}

process.on("unhandledRejection", (reason, promise) => {
    logger.error("Unhandled Rejection at: %s\nreason: %s", promise, reason);
});

process.on("uncaughtException", (err, origin) => {
    logger.error("Uncaught Exception at: %s\nreason: %s", err, origin);
    process.exit(1);
});

function initNode(nodes: INode, name: string, paths: string) {
    const node = ChildProcess.fork(paths);
    node.on("uncaughtException", (err, origin) => {
        logger.error(
            "Name node: %s, Uncaught Exception at: %s\nreason: %s",
            name,
            err,
            origin,
            err,
        );
        node.kill(1);
    });
    node.on("message", checkMessage(nodes, name, node.pid as number));
    node.on("close", () => {
        delete nodes[name];
        initNode(nodes, name, paths);
    });
    nodes[name] = node;
}

interface INode {
    [key: string]: ChildProcess.ChildProcess;
}

class BuilderProcessController {
    private isClusterStarted = false;
    private nodes: INode = {};
    public handler: Record<string, (data?: any) => void> = {
        startedCluster: () => {
            if (!this.isClusterStarted) {
                this.isClusterStarted = true;
                initNode(
                    this.nodes,
                    "events",
                    path.join(Constants.HOME_DIR, "events", "index.js"),
                );
                initNode(
                    this.nodes,
                    "schedulers",
                    path.join(Constants.HOME_DIR, "schedulers", "index.js"),
                );
                initNode(
                    this.nodes,
                    "admin",
                    path.join(Constants.HOME_DIR, "admin", "index.js"),
                );
            }
        },
        startedEventNode: () => {
            return;
        },
        startedSchedulerNode: () => {
            return;
        },
        restartCluster: () => {
            this.isClusterStarted = false;
            const killNodes = [
                killNode(this.nodes, "events"),
                killNode(this.nodes, "schedulers"),
                killNode(this.nodes, "admin"),
                killNode(this.nodes, "http"),
            ];
            Promise.all(killNodes).then(() => {
                setTimeout(() => this.init(false), 500);
            });
        },
        restartAll: () => {
            this.isClusterStarted = false;
            const killNodes = [
                killNode(this.nodes, "events"),
                killNode(this.nodes, "schedulers"),
                killNode(this.nodes, "admin"),
                killNode(this.nodes, "http"),
            ];
            Promise.all(killNodes).then(() => {
                setTimeout(() => this.init(), 500);
            });
        },

        propertySave: (data: {command: string}) => {
            if (Property.handlers[data.command]) {
                Property.handlers[data.command].call(Property);
            }
        },

        savePropertyEntity: (data: {entity: any, table: string}) => {
            Property.handlers.savePropertyEntity(data);
        },
    };
    public async init(removeTempDb = true) {
        if (fs.existsSync(Constants.UPLOAD_DIR)) {
            deleteFolderRecursive(Constants.UPLOAD_DIR);
        }
        fs.mkdirSync(Constants.UPLOAD_DIR, {
            recursive: true,
        });
        let force = undefined;
        if (removeTempDb && fs.existsSync(Constants.TEMP_DB)) {
            deleteFolderRecursive(Constants.TEMP_DB);
            force = true;
        }
        fs.mkdirSync(Constants.TEMP_DB, {
            recursive: true,
        });
        await Property.reset();
        await Property.getContext(force);
        await Property.getProviders(force);
        await Property.getPlugins(force);
        await Property.getQuery(force);
        await Property.getServers(force);
        await Property.getEvents(force);
        await Property.getSchedulers(force);
        initNode(
            this.nodes,
            "http",
            path.join(Constants.HOME_DIR, "http", "index.js"),
        );
    }
}

const ProcessController = new BuilderProcessController();

export default ProcessController;
