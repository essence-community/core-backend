import Logger from "@ungate/plugininf/lib/Logger";
import { ISenderOptions } from "@ungate/plugininf/lib/util/ProcessSender";
import * as ChildProcess from "child_process";
import * as path from "path";
import Constants from "../core/Constants";
import * as fs from "fs";
import { deleteFolderRecursive } from "@ungate/plugininf/lib/util/Util";
const logger = Logger.getLogger("master");

const checkMessage =
    (nodes: INode, name: string, id) => (message: ISenderOptions) => {
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
        switch ((message as ISenderOptions).target) {
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
            case "localDbNode":
                if (nodes.localDbNode && id !== nodes.localDbNode.pid) {
                    nodes.localDbNode.send(message);
                }
                break;
            case "schedulerNode":
                if (nodes.schedulers && id !== nodes.schedulers.pid) {
                    nodes.schedulers.send(message);
                }
                break;
            case "master": {
                if (ProcessController[(message as ISenderOptions).command]) {
                    ProcessController[(message as ISenderOptions).command].call(
                        ProcessController,
                        (message as ISenderOptions).data,
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

function initNode(nodes: INode, name: string, paths: string) {
    const node = ChildProcess.fork(paths);
    node.on('uncaughtException', (err, origin) => {
        logger.error('Name node: %s, Unhandled Rejection at: %s reason: %s', name, err, origin, err);
    });
    node.on("unhandledRejection", (reason, promise) => {
        logger.error('Name node: %s, Unhandled Rejection at: %s reason: %s', name, promise, reason);
        node.kill(1);
    });
    node.on("message", checkMessage(nodes, name, node.pid));
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
    public init() {
        if (fs.existsSync(Constants.UPLOAD_DIR)) {
            deleteFolderRecursive(Constants.UPLOAD_DIR);
        }
        fs.mkdirSync(Constants.UPLOAD_DIR, {
            recursive: true,
        });
        if (Constants.LOCAL_DB === "nedb") {
            initNode(
                this.nodes,
                "localDbNode",
                path.join(Constants.HOME_DIR, "localDbNode", "index.js"),
            );
        } else {
            initNode(
                this.nodes,
                "http",
                path.join(Constants.HOME_DIR, "http", "index.js"),
            );
        }
    }
    public startedLocalDbNode() {
        initNode(
            this.nodes,
            "http",
            path.join(Constants.HOME_DIR, "http", "index.js"),
        );
    }
    public startedCluster() {
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
    }
    public startedEventNode() {
        return;
    }
    public startedSchedulerNode() {
        return;
    }
    public restartCluster() {
        this.isClusterStarted = false;
        const killNodes = [
            killNode(this.nodes, "events"),
            killNode(this.nodes, "schedulers"),
            killNode(this.nodes, "admin"),
            killNode(this.nodes, "http"),
        ];
        Promise.all(killNodes).then(() => {
            setTimeout(() => this.startedLocalDbNode(), 500);
        });
    }
    public restartAll() {
        this.isClusterStarted = false;
        const killNodes = [
            killNode(this.nodes, "localDbNode"),
            killNode(this.nodes, "events"),
            killNode(this.nodes, "schedulers"),
            killNode(this.nodes, "admin"),
            killNode(this.nodes, "http"),
        ];
        Promise.all(killNodes).then(() => {
            setTimeout(() => this.init(), 500);
        });
    }
}

const ProcessController = new BuilderProcessController();

export default ProcessController;
