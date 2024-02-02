import Logger from "@ungate/plugininf/lib/Logger";
import { ISenderOptions } from "@ungate/plugininf/lib/util/ProcessSender";
import * as cl from "cluster";
import Constants from "../core/Constants";
const logger = Logger.getLogger("Http");
const workers = {};
const cluster: cl.Cluster = cl as any;
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
process.on("unhandledRejection", (reason, promise) => {
    logger.error('HTTP Unhandled Rejection at: %s\nreason: %s', promise, reason);
});
process.on('uncaughtException', (err, origin) => {
    logger.error('HTTP id: %s, Uncaught Exception at: %s\nreason: %s', process.env.UNGATE_HTTP_ID, err, origin);
    process.exit(1)
});

if (cluster.isMaster || cluster.isPrimary) {
    process.on("message", (message) => {
        if ((message as ISenderOptions).target === "cluster") {
            Object.values(cluster.workers).forEach((node) => {
                if (node) {
                    node.send(message as any);
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
    const max = Constants.CLUSTER_NUM + 1;
    for (let i = 1; i < max; i += 1) {
        initNodeHttp(`${i}`);
    }
} else {
    import("./httpNode").catch((err) => logger.error(err));
}
