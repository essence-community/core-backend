import Logger from "@ungate/plugininf/lib/Logger";
import {sendProcess} from "@ungate/plugininf/lib/util/ProcessSender";
import * as fs from "fs";
import * as https from "https";
import MSG from "msgpack-lite";
import * as websocket from "websocket";
import Constants from "../../core/Constants";
import Property, {getLocalDb} from "../../core/property/Property";
import {ServerModel} from "../../core/property/entities/ServerModel";
import {noop} from "lodash";
import {CreateJsonStream} from "@ungate/plugininf/lib/stream/ResultStream";
import {In, Not, ObjectLiteral, Repository} from "typeorm";
const logger = Logger.getLogger("AdminEventController");
const TIMEOUT_CONNECT = 15000;

interface IServerConnect {
    init: boolean;
    send?: websocket.connection;
    received?: websocket.connection;
}

function sendAllDate(
    conn: websocket.connection,
    db: Repository<ObjectLiteral>,
): Promise<void> {
    return db.find().then(async (docs) => {
        conn.sendBytes(
            MSG.encode({
                data: {
                    action: "save",
                    args: [docs],
                    name: db.metadata.tableName,
                },
                event: "callDb",
            }),
        );
    });
}

class AdminEventController {
    private key!: string | Buffer;
    private cert!: string | Buffer;
    private ca!: string | Buffer;
    private wsServer!: websocket.server;
    protected server!: https.Server;

    private servers: Record<string, IServerConnect> = {};
    private dbServers!: Repository<ServerModel>;
    public async init(): Promise<void> {
        if (!(
            fs.existsSync(Constants.GATE_ADMIN_CLUSTER_KEY) &&
            fs.existsSync(Constants.GATE_ADMIN_CLUSTER_CERT) &&
            fs.existsSync(Constants.GATE_ADMIN_CLUSTER_CA)
        )) {
            throw new Error(
                `Not found ${Constants.GATE_ADMIN_CLUSTER_KEY} ${Constants.GATE_ADMIN_CLUSTER_CERT} ${Constants.GATE_ADMIN_CLUSTER_CA}`,
            );
        }
        this.key = fs.readFileSync(Constants.GATE_ADMIN_CLUSTER_KEY, {
            flag: "r",
        });
        this.cert = fs.readFileSync(Constants.GATE_ADMIN_CLUSTER_CERT, {
            flag: "r",
        });
        this.ca = fs.readFileSync(Constants.GATE_ADMIN_CLUSTER_CA, {
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
                    const stream = CreateJsonStream({
                        err_code: 404,
                        err_text: "is not an implemented route",
                        metaData: {responseTime: 0.0},
                        success: false,
                    });
                    res.writeHead(404, {
                        "Content-Type": Constants.JSON_CONTENT_TYPE,
                    });
                    stream.pipe(res);
                },
            );
            this.wsServer = new websocket.server({
                httpServer: server,
            });
            server.listen(Constants.GATE_ADMIN_CLUSTER_PORT, () => {
                return resolve();
            });
            this.server = server;
        });

        this.wsServer.on("request", this.onRequest.bind(this));
        this.dbServers = await Property.getServers();
        await this.connectServers();
    }

    public command: Record<string, (conn: websocket.connection, data?: Record<string, any>) => Promise<any>> = {
        callDb: this.callDb,
        callProcess: this.callProcess,
    };
    public async callDb(conn: websocket.connection, data?: Record<string, any>): Promise<any> {
        let db: Repository<ObjectLiteral>;
        try {
            db = await getLocalDb(data?.name);
        } catch (err) {
            logger.error(
                "Error: callDb: db: %s, action: %s, message: %s",
                data?.name,
                data?.action,
                (err as Error).message,
                err,
            );
            return;
        }
        logger.trace("callDb: db: %s, action: %s", data?.name, data?.action);
        const fn = (db as any)[data?.action];
        if (typeof fn === "function") {
            return fn.apply(db, data?.args).then(noop, (err: any) => {
                logger.error(
                    "Error: callDb: db: %s, action: %s, message: %s",
                    data?.name,
                    data?.action,
                    err.message,
                    err,
                );
            });
        }
    }

    private async callProcess(conn: websocket.connection, data?: Record<string, any>): Promise<any> {
        logger.trace(
            "callProcess: command: %s, target: %s",
            data?.command,
            data?.target,
        );
        sendProcess({
            command: data?.command,
            data: data?.data,
            target: data?.target,
        });
    }

    public handlers: Record<string, (data?: Record<string, any>) => Promise<any>> = {
        sendServerCallDb: async (data?: Record<string, any>): Promise<any> => {
            const conn = this.servers[data?.server].send;
            if (!conn) {
                return;
            }
            logger.trace(
                "sendServerCallDb: Server: %s, db: %s, action: %s",
                data?.server,
                data?.name,
                data?.action,
            );
            conn.sendBytes(
                MSG.encode({
                    data: {
                        action: data?.action,
                        args: data?.args,
                        isTemp: data?.isTemp,
                        name: data?.name,
                    },
                    event: "callDb",
                }),
            );
        },

        sendAllServerCallDb: async (data?: Record<string, any>): Promise<any> => {
            const conns = Object.values(this.servers)
                .filter((val) => val.send)
                .map((val) => val.send);
            logger.trace(
                "sendAllServerCallDb: Conns: %s, db: %s, action: %s",
                conns.length,
                data?.name,
                data?.action,
            );
            if (conns.length === 0) {
                return;
            }
            conns.forEach((conn) => {
                conn?.sendBytes(
                    MSG.encode({
                        data: {
                            action: data?.action,
                            args: data?.args,
                            isTemp: data?.isTemp,
                            name: data?.name,
                        },
                        event: "callDb",
                    }),
                );
            });
        },
        sendServerAdminCmdAll: async (data?: Record<string, any>): Promise<any> => {
            Object.entries(this.servers).forEach(([name, server]) => {
                const conn = server.send;
                if (!conn) {
                    return;
                }
                logger.trace(
                    "sendServerAdminCmdAll: Server: %s, command: %s, target: %s",
                    name,
                    data?.command,
                    data?.target,
                );
                conn.sendBytes(
                    MSG.encode({
                        data: {
                            command: data?.command,
                            data: data?.data,
                            target: data?.target,
                        },
                        event: "callProcess",
                    }),
                );
            });
        },
        sendServerAdminCmd: async (data?: Record<string, any>): Promise<any> => {
            const conn = this.servers[data?.server].send;
            if (!conn) {
                return;
            }
            logger.trace(
                "sendServerAdminCmd: Server: %s, command: %s, target: %s",
                data?.server,
                data?.command,
                data?.target,
            );
            conn.sendBytes(
                MSG.encode({
                    data: {
                        command: data?.command,
                        data: data?.data,
                        target: data?.target,
                    },
                    event: "callProcess",
                }),
            );
        },
    };

    public async connectServers(name?: string, first = false) {
        const exclude = [
            Constants.GATE_NODE_NAME,
            ...Object.entries(this.servers)
                .filter(([key, val]) => val.init || val.send)
                .map(([key]) => key),
        ];
        const configs = name
            ? await this.dbServers.find({where: {id: name}})
            : await this.dbServers.find({
                where: {id: Not(In(exclude))},
            });
        configs.forEach((conf) => {
            this.onConnectServer(conf.id, conf.ip, conf.port, true);
        });
    }

    public loadProperty(conn: websocket.connection) {
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

    private onRequest(request: any) {
        const name = request.resourceURL.query.server;
        const connection: websocket.connection = request.accept(
            "adminevents",
            request.origin,
        );
        if (!this.servers[name]) {
            this.servers[name] = {init: false};
        }
        this.servers[name].received = connection;
        connection.on("error", (error) => {
            logger.warn(error.message, error);
            this.servers[name].received = undefined;
        });
        connection.on("close", () => {
            this.servers[name].received = undefined;
        });
        connection.on("message", async (message) => {
            if (message.type === "binary") {
                try {
                    const command = MSG.decode(message.binaryData);
                    await this.command[command.event as keyof typeof this.command](connection, command.data as any);
                } catch (err: any) {
                    logger.warn(
                        `Cluster message: ${message.binaryData}\nError: ${err.message}`,
                        err,
                    );
                }
            }
        });
    }

    private onConnectServer(
        name: string,
        ip: string,
        port: number = Constants.GATE_ADMIN_CLUSTER_PORT,
        first: boolean = true,
    ) {
        if (!this.servers[name]) {
            this.servers[name] = {init: false};
        }
        if (
            this.servers[name] &&
            (this.servers[name].init || this.servers[name].send)
        ) {
            return;
        }
        logger.info(`Connect to ${name} ${ip} ${port}`);
        this.servers[name].init = true;
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
            this.servers[name].send = undefined;
            this.servers[name].init = false;
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
            this.servers[name].send = connection;
            this.servers[name].init = false;
            connection.on("error", (error) => {
                logger.warn(error.message, error);
                this.servers[name].send = undefined;
                this.servers[name].init = false;
                setTimeout(
                    () =>
                        this.connectServers(name, false).then(noop, (err) =>
                            logger.error(err),
                        ),
                    TIMEOUT_CONNECT,
                );
            });
            connection.on("close", (code) => {
                this.servers[name].send = undefined;
                this.servers[name].init = false;
                setTimeout(
                    () =>
                        this.connectServers(name, false).then(noop, (err) =>
                            logger.error(err),
                        ),
                    TIMEOUT_CONNECT,
                );
            });
            if (first) {
                this.loadProperty(connection);
            }
        });

        client.connect(
            `wss://${ip}:${port}/?server=${Constants.GATE_NODE_NAME}`,
            "adminevents",
        );
    }
}

export default new AdminEventController();
