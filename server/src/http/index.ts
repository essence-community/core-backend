import Logger from "@ungate/plugininf/lib/Logger";
import { ISenderOptions } from "@ungate/plugininf/lib/util/ProcessSender";
import * as cluster from "cluster";
import Constants from "../core/Constants";
const logger = Logger.getLogger("Http");
const workers = {};
function initNodeHttp(id: string) {
    const node = cluster.fork({
        ...process.env,
        UNGATE_HTTP_ID: id,
    });
    workers[node.process.pid] = id;
    node.on("message", (message) => {
        if ((message as ISenderOptions).target === "cluster") {
            Object.values(cluster.workers).forEach((nodeCluster) => {
                if (nodeCluster) {
                    nodeCluster.send(message);
                }
            });
        } else if ((message as ISenderOptions).target) {
            process.send(message);
        }
    });
}

if (cluster.isMaster) {
    process.on("message", (message) => {
        if ((message as ISenderOptions).target === "cluster") {
            Object.values(cluster.workers).forEach((node) => {
                if (node) {
                    node.send(message);
                }
            });
        }
    });
    cluster.on("exit", (worker, code, signal) => {
        logger.warn(
            "Worker die %s, code %s, signal %s",
            worker.process.pid,
            code,
            signal,
        );
        const id = workers[worker.process.pid];
        delete workers[worker.process.pid];
        initNodeHttp(id);
    });

    for (let i = 0; i < Constants.CLUSTER_NUM; i += 1) {
        initNodeHttp(`${i + 1}`);
    }
} else {
    import("./httpNode");
}
