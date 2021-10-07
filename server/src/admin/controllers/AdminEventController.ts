import ILocalDB from "@ungate/plugininf/lib/db/local/ILocalDB";
import Logger from "@ungate/plugininf/lib/Logger";
import { sendProcess } from "@ungate/plugininf/lib/util/ProcessSender";
import * as fs from "fs";
import * as https from "https";
import * as MSG from "msgpack-lite";
import * as websocket from "websocket";
import Constants from "../../core/Constants";
import Property, { getLocalDb } from "../../core/property/Property";
import IServerConfig from "../../core/property/IServerConfig";
import { noop } from "lodash";
const logger = Logger.getLogger("AdminEventController");
const TIMEOUT_CONNECT = 15000;

interface IServersConnect {
    [key: string]: websocket.connection;
}

function sendAllDate (
    conn: websocket.connection,
    db: ILocalDB<any>,
): Promise<void> {
    return db.find().then(async (docs) => {
        conn.sendBytes(
            MSG.encode({
                data: {
                    action: "insert",
                    args: [docs],
                    isTemp: db.isTemp,
                    name: db.dbname,
                },
                event: "callDb",
            }),
        );
    });
}

class AdminEventController {
    private key: string;
    private cert: string;
    private ca: string;
    private wsServer: websocket.server;
    protected server: https.Server;
    private serversSend: IServersConnect = {};
    private serversReceive: IServersConnect = {};
    private dbServers: ILocalDB<IServerConfig>;
    public async init (): Promise<void> {
        if (
            !(
                fs.existsSync(Constants.GATE_ADMIN_CLUSTER_KEY) &&
                fs.existsSync(Constants.GATE_ADMIN_CLUSTER_CERT) &&
                fs.existsSync(Constants.GATE_ADMIN_CLUSTER_CA)
            )
        ) {
            throw new Error(
                `Not found ${Constants.GATE_ADMIN_CLUSTER_KEY} ${Constants.GATE_ADMIN_CLUSTER_CERT} ${Constants.GATE_ADMIN_CLUSTER_CA}`,
            );
        }
        this.key = fs.readFileSync(Constants.GATE_ADMIN_CLUSTER_KEY, {
            encoding: "UTF-8",
            flag: "r",
        });
        this.cert = fs.readFileSync(Constants.GATE_ADMIN_CLUSTER_CERT, {
            encoding: "UTF-8",
            flag: "r",
        });
        this.ca = fs.readFileSync(Constants.GATE_ADMIN_CLUSTER_CA, {
            encoding: "UTF-8",
            flag: "r",
        });
        await new Promise<void>((resolve, reject) => {
            const server = https.createServer(
                {
                    ca: this.ca,
                    cert: this.cert,
                    key: this.key,
                    requestCert: true,
                },
                (req, res) => {
                    const error = JSON.stringify({
                        err_code: 404,
                        err_text: `\`${req.url}\` is not an implemented route`,
                        metaData: { responseTime: 0.0 },
                        success: false,
                    });
                    res.writeHead(404, {
                        "Content-Length": Buffer.byteLength(error),
                        "Content-Type": Constants.JSON_CONTENT_TYPE,
                    });
                    res.end(error);
                },
            );
            this.wsServer = new websocket.server({
                httpServer: server,
            });
            server.listen(Constants.GATE_ADMIN_CLUSTER_PORT, (err) => {
                if (err) {
                    return reject(err);
                }
                return resolve();
            });
            this.server = server;
        });

        this.wsServer.on("request", this.onRequest.bind(this));
        this.dbServers = await Property.getServers();
        await this.connectServers();
    }

    public async connectServers (name?: string, first = false) {
        const configs = await this.dbServers.find({
            ck_id: name
                ? name
                : {
                      $ne: Constants.GATE_NODE_NAME,
                  },
        });
        configs.forEach((conf) => {
            this.onConnectServer(conf.ck_id, conf.cv_ip, conf.cn_port, true);
        });
    }

    public loadProperty (conn: websocket.connection) {
        const rows = [];
        rows.push(Property.getProviders().then((db) => sendAllDate(conn, db)));
        rows.push(Property.getContext().then((db) => sendAllDate(conn, db)));
        rows.push(Property.getPlugins().then((db) => sendAllDate(conn, db)));
        rows.push(Property.getServers().then((db) => sendAllDate(conn, db)));
        rows.push(Property.getSchedulers().then((db) => sendAllDate(conn, db)));
        rows.push(Property.getEvents().then((db) => sendAllDate(conn, db)));
        rows.push(Property.getQuery().then((db) => sendAllDate(conn, db)));
        return Promise.all(rows);
    }

    public async callDb (conn: websocket.connection, data) {
        const db = await getLocalDb(data.name, data.isTemp);
        if (db) {
            return db[data.action](...data.args);
        }
    }

    public async sendServerCallDb (data) {
        const conn = this.serversSend[data.server];
        if (!conn) {
            return;
        }
        conn.sendBytes(
            MSG.encode({
                data: {
                    action: data.action,
                    args: data.args,
                    isTemp: data.isTemp,
                    name: data.name,
                },
                event: "callDb",
            }),
        );
    }

    public async sendAllServerCallDb (data) {
        const conns = Object.values(this.serversSend);
        if (conns.length === 0) {
            return;
        }
        conns.forEach((conn) => {
            conn.sendBytes(
                MSG.encode({
                    data: {
                        action: data.action,
                        args: data.args,
                        isTemp: data.isTemp,
                        name: data.name,
                    },
                    event: "callDb",
                }),
            );
        });
    }

    public async sendServerAdminCmd (data) {
        const conn = this.serversSend[data.server];
        if (!conn) {
            return;
        }
        conn.sendBytes(
            MSG.encode({
                data: {
                    command: data.command,
                    data: data.data,
                    target: data.target,
                },
                event: "callProcess",
            }),
        );
    }

    public async callProcess (conn: websocket.connection, data) {
        sendProcess({
            command: data.command,
            data: data.data,
            target: data.target,
        });
    }

    private onRequest (request) {
        const name = request.resourceURL.query.server;
        const connection: websocket.connection = request.accept(
            "adminevents",
            request.origin,
        );
        this.serversReceive[name] = connection;
        connection.on("error", (error) => {
            logger.warn(error.message, error);
            delete this.serversReceive[name];
        });
        connection.on("close", () => {
            delete this.serversReceive[name];
        });
        connection.on("message", async (message) => {
            if (message.type === "binary") {
                try {
                    const command = MSG.decode(message.binaryData);
                    await this[command.event](connection, command.data);
                } catch (err) {
                    logger.warn(
                        `Cluster message: ${message.utf8Data}\nError: ${err.message}`,
                        err,
                    );
                }
            }
        });
    }

    private onConnectServer (
        name: string,
        ip: string,
        port: number = Constants.GATE_ADMIN_CLUSTER_PORT,
        first: boolean = true,
    ) {
        logger.info(`Connect to ${name} ${ip} ${port}`);
        if (this.serversSend[name]) {
            return;
        }
        const client = new websocket.client({
            tlsOptions: {
                ca: this.ca,
                cert: this.cert,
                checkServerIdentity: () => null,
                key: this.key,
            },
        } as any);
        client.on("connectFailed", (error) => {
            logger.warn(error.message, error);
            setTimeout(
                () =>
                    this.connectServers(name).then(noop, (err) =>
                        logger.error(err),
                    ),
                TIMEOUT_CONNECT,
            );
        });

        client.on("connect", (connection: websocket.connection) => {
            logger.info(`Connected to ${name} ${ip} ${port}`);
            this.serversSend[name] = connection;
            connection.on("error", (error) => {
                logger.warn(error.message, error);
                delete this.serversSend[name];
                setTimeout(
                    () =>
                        this.connectServers(name, false).then(noop, (err) =>
                            logger.error(err),
                        ),
                    TIMEOUT_CONNECT,
                );
            });
            connection.on("close", (code) => {
                delete this.serversSend[name];
                setTimeout(
                    () =>
                        this.connectServers(name, false).then(noop, (err) =>
                            logger.error(err),
                        ),
                    TIMEOUT_CONNECT,
                );
            });
            if (first) {
                connection.sendBytes(
                    MSG.encode({
                        data: {},
                        event: "loadProperty",
                    }),
                );
            }
        });

        client.connect(
            `wss://${ip}:${port}/?server=${Constants.GATE_NODE_NAME}`,
            "adminevents",
        );
    }
}

export default new AdminEventController();
