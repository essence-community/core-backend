import ILocalDB from "@ungate/plugininf/lib/db/local/ILocalDB";
import * as fs from "fs";
import Constants from "../../core/Constants";
import IServerConfig from "../../core/property/IServerConfig";
import Property from "../../core/property/Property";
import axios from "axios";
import { Agent as HttpsAgent } from "https";
import { Pod, PodList } from "../types/kube/v1.21.0/core/v1";
import { noop } from "lodash";
import Logger from "@ungate/plugininf/lib/Logger";
import { clearInterval } from "timers";
import * as qs from "query-string";
import adminEventController from "./AdminEventController";
const logger = Logger.getLogger("KubeController");

export class KubeController {
    /*
    Max time (in millis) to wait for a connection to the Kubernetes server. 
    If exceeded, an exception will be thrown 
    */
    protected connectTimeout = parseInt(
        process.env.KUBERNETES_CONNECT_TIMEOUT || "5000",
        10,
    );

    /*
    Max time (in millis) to wait for a response from the Kubernetes server",   
    */
    protected readTimeout = parseInt(
        process.env.KUBERNETES_READ_TIMEOUT || "30000",
        10,
    );

    /*
    Max number of attempts to send discovery requests 
    */
    protected operationAttempts = parseInt(
        process.env.KUBERNETES_OPERATION_ATTEMPTS || "3",
        10,
    );

    /*
    Time (in millis) between operation attempts 
    */
    protected operationSleep = parseInt(
        process.env.KUBERNETES_OPERATION_SLEEP || "5000",
        10,
    );

    /*
    https (default) or http. Used to send the initial discovery request to the Kubernetes server",       
    */
    protected masterProtocol =
        process.env.KUBERNETES_MASTER_PROTOCOL || "https";

    /*
    The URL of the Kubernetes server process.env.KUBERNETES_SERVICE_HOST
    */
    protected masterHost = process.env.KUBERNETES_SERVICE_HOST;

    /*
    The port on which the Kubernetes server is listening 
    */
    protected masterPort = process.env.KUBERNETES_SERVICE_PORT;

    /*
    The version of the protocol to the Kubernetes server 
    */
    protected apiVersion = process.env.KUBERNETES_API_VERSION || "v1";

    /* namespace */
    protected namespace =
        process.env.KUBERNETES_NAMESPACE ||
        process.env.OPENSHIFT_KUBE_PING_NAMESPACE ||
        "default";

    /*
    The labels to use in the discovery request to the Kubernetes server
    */
    protected labels =
        process.env.KUBERNETES_LABELS || process.env.OPENSHIFT_KUBE_PING_LABELS;

    /*
    Certificate to access the Kubernetes server 
    */
    protected clientCertFile = process.env.KUBERNETES_CLIENT_CERTIFICATE_FILE;

    /*
    Client key file (store) 
    */
    protected clientKeyFile = process.env.KUBERNETES_CLIENT_KEY_FILE;

    /*
    The password to access the client key store 
    */
    protected clientKeyPassword = process.env.KUBERNETES_CLIENT_KEY_PASSWORD;

    /*
    The algorithm used by the client
    */
    protected clientKeyAlgo = process.env.KUBERNETES_CLIENT_KEY_ALGO || "RSA";

    /*
    Location of certificate bundle used to verify the serving certificate of the apiserver. 
    If the specified file is unavailable, a warning message is issued.
    */
    protected caCertFile =
        process.env.KUBERNETES_CA_CERTIFICATE_FILE ||
        "/var/run/secrets/kubernetes.io/serviceaccount/ca.crt";

    /*
    Token file
    */
    protected saTokenFile =
        process.env.SA_TOKEN_FILE ||
        "/var/run/secrets/kubernetes.io/serviceaccount/token";

    /*
    The standard behavior during Rolling Update is to put all Pods in the same cluster. In
            cases (application level incompatibility) this causes problems. One might decide to split clusters to
            'old' and 'new' during that process
    */
    protected splitClustersDuringRollingUpdate =
        process.env.KUBERNETES_SPLIT_CLUSTERS_DURING_ROLLING_UPDATE;

    /*
    Introduces similar behaviour to Kubernetes Services (using DNS) with publishNotReadyAddresses set to true.
            By default it's true
    */
    protected useNotReadyAddresses = process.env
        .KUBERNETES_USE_NOT_READY_ADDRESSES
        ? process.env.KUBERNETES_USE_NOT_READY_ADDRESSES === "true"
        : true;
    protected dbServer: ILocalDB<IServerConfig>;
    protected serverData: IServerConfig;
    protected readTimerKube: NodeJS.Timeout;
    protected masterUrlApi: string;
    protected token: string;
    protected httpsAgent: HttpsAgent;
    private getAllPodsUrl: string;
    public async init () {
        this.dbServer = await Property.getServers();
        this.serverData = (await this.dbServer.findOne(
            {
                ck_id: Constants.GATE_NODE_NAME,
            },
            true,
        )) || {
            ck_id: Constants.GATE_NODE_NAME,
            cn_port: Constants.GATE_ADMIN_CLUSTER_PORT,
            cv_ip: "127.0.0.1",
        };

        if (this.masterHost && this.masterPort) {
            this.masterUrlApi = `${this.masterProtocol}://${this.masterHost}:${this.masterPort}/api/${this.apiVersion}`;
            this.token = fs.readFileSync(this.saTokenFile).toString();
            logger.trace("Init Kube Watch url %s", this.masterUrlApi);
            if (
                fs.existsSync(this.clientCertFile) ||
                fs.existsSync(this.clientKeyFile)
            ) {
                this.httpsAgent = new HttpsAgent({
                    ca: fs.readFileSync(this.caCertFile),
                    cert: fs.readFileSync(this.clientCertFile),
                    key: fs.readFileSync(this.clientKeyFile),
                    passphrase: this.clientKeyPassword,
                    timeout: this.connectTimeout,
                });
            } else {
                this.httpsAgent = new HttpsAgent({
                    ca: fs.readFileSync(this.caCertFile),
                    timeout: this.connectTimeout,
                });
            }
            const getPodData = `${this.masterUrlApi}/namespaces/${this.namespace}/pods/${Constants.GATE_NODE_NAME}`;
            this.serverData = await axios
                .get<Pod>(getPodData, {
                    headers: {
                        authorization: `Bearer ${this.token}`,
                    },
                    httpsAgent: this.httpsAgent,
                    validateStatus: () => true,
                    timeout: this.readTimeout,
                    responseType: "json",
                })
                .then(
                    (result) => {
                        logger.trace(
                            "Get Info Pod %s url %s\nstatus: %s\ndata:\n%j",
                            Constants.GATE_NODE_NAME,
                            getPodData,
                            result.status,
                            result.data,
                        );
                        if (result.status >= 400 && result.status < 500) {
                            return this.serverData;
                        }
                        if (!this.labels && result.data.metadata.labels) {
                            this.labels = Object.entries(
                                result.data.metadata.labels,
                            )
                                .reduce((res, [key, value]) => {
                                    res.push(`${key}=${value}`);
                                    return res;
                                }, [] as string[])
                                .join(",");
                        }
                        logger.trace("Get Labels", this.labels);
                        if (this.labels) {
                            this.getAllPodsUrl = `${
                                this.masterUrlApi
                            }/namespaces/${this.namespace}/pods?${qs.stringify({
                                labelSelector: this.labels,
                            })}`;
                            this.initKube().then(noop, (err) =>
                                logger.error(err),
                            );
                            this.readTimerKube = setInterval(
                                () =>
                                    this.initKube().then(noop, (err) =>
                                        logger.error(err),
                                    ),
                                this.operationSleep,
                            );
                        }

                        return {
                            ck_id: Constants.GATE_NODE_NAME,
                            cv_ip: result.data.status.hostIP,
                            cn_port: Constants.GATE_ADMIN_CLUSTER_PORT,
                        };
                    },
                    (err) => {
                        logger.error(err);
                        setTimeout(this.init, this.operationSleep);
                        return this.serverData;
                    },
                );
            this.dbServer.insert(
                this.serverData,
            );
        } else {
            this.dbServer.insert(
                this.serverData,
            );
        }
    }
    protected async initKube () {
        const pods: IServerConfig[] = await axios
            .get<PodList>(this.getAllPodsUrl, {
                headers: {
                    authorization: `Bearer ${this.token}`,
                },
                httpsAgent: this.httpsAgent,
                validateStatus: () => true,
                timeout: this.readTimeout,
            })
            .then(
                (result) => {
                    logger.trace(
                        "Get info Pods url %s\nstatus:%s\ndata:\n%j",
                        this.getAllPodsUrl,
                        result.status,
                        result.data,
                    );
                    if (
                        (result.status >= 400 && result.status < 500) ||
                        !result.data ||
                        result.data.items.length === 0
                    ) {
                        if (result.status >= 400 && result.status < 500) {
                            clearInterval(this.readTimerKube);
                        }
                        return [];
                    }
                    return result.data.items.map((pod) => ({
                        ck_id: pod.metadata.name,
                        cv_ip: pod.status.hostIP,
                        cn_port: Constants.GATE_ADMIN_CLUSTER_PORT,
                    }));
                },
                (err) => {
                    logger.error(err);
                    return [];
                },
            );
        if (pods && pods.length) {
            this.dbServer
                .remove({
                    $nin: [pods.map((pod) => ({ ck_id: pod.ck_id }))],
                })
                .then(() => this.dbServer.insert(pods))
                .then(noop, (err) => logger.error(err));
        }

        await adminEventController.connectServers();
    }
}

export default new KubeController();
