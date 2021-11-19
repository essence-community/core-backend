import Logger from "@ungate/plugininf/lib/Logger";
import * as crypto from "crypto";
import * as http from "http";
import * as https from "https";
import { delay, forEach } from "lodash";
import * as websocket from "websocket";
import Mask from "../Mask";
import PluginManager from "../../core/pluginmanager/PluginManager";
import IContextPlugin from "@ungate/plugininf/lib/IContextPlugin";
import { ParsedQs } from "qs";
import ISession from "@ungate/plugininf/lib/ISession";
import { GateSession } from "../../core/session/GateSession";
const logger = Logger.getLogger("NotificationController");
const TIMEOUT = 30000;

interface IWSConnect extends websocket.connection {
    sessionId: string;
    session: ISession;
    uniqhash: string;
    gateContext: IContextPlugin;
}
interface IClientWs {
    [key: string]: {
        [key: string]: IWSConnect;
    };
}

interface IConfigSession {
    [key: string]: {
        context: IContextPlugin;
        sessions: string[];
        conns: IWSConnect[];
    };
}

class NotificationController {
    public notificationClient: IClientWs = {};
    private wsServer: websocket.server;
    private contexts: IContextPlugin[];
    public async init(httpServer: http.Server | https.Server): Promise<void> {
        this.wsServer = new websocket.server({
            httpServer,
        });
        this.wsServer.on("request", this.onRequest.bind(this));
        delay(() => this.checkConnection(), TIMEOUT);
        this.contexts = PluginManager.getGateContexts();
        Mask.on("change", this.changeMask, this);
    }
    /**
     * Установка маски
     * @param isMask
     */
    public changeMask(isMask) {
        setTimeout(
            () => {
                this.sendNotificationAll(
                    JSON.stringify([
                        {
                            data: {
                                action: isMask ? "block" : "unblock",
                                msg: isMask
                                    ? "Проводятся технические работы. Пожалуйста, подождите"
                                    : "Технические работы завершены, можете продолжать работу",
                            },
                            event: "mask",
                        },
                    ]),
                );
            },
            isMask ? 10 : 500,
        );
    }

    public async onRequest(request: websocket.request) {
        if (
            !request.resourceURL.query ||
            !(request.resourceURL.query as ParsedQs).session
        ) {
            return;
        }
        const sessionId = decodeURIComponent(
            (Array.isArray((request.resourceURL.query as ParsedQs).session)
                ? (request.resourceURL.query as ParsedQs).session[0]
                : (request.resourceURL.query as ParsedQs).session) as string,
        );
        const connection = request.accept(
            "notification",
            request.origin,
        ) as IWSConnect;
        const configSession = (await this.contexts.slice(1).reduce(
            (res, context) => {
                if (res) {
                    return res;
                }
                return (context.authController as GateSession)
                    .loadSession(null, sessionId, true)
                    .then((session) =>
                        session ? { session, context } : session,
                    );
            },
            (this.contexts[0].authController as GateSession)
                .loadSession(null, sessionId, true)
                .then((session) =>
                    session ? { session, context: this.contexts[0] } : session,
                ),
        )) as {
            session: ISession;
            context: IContextPlugin;
        };
        if (configSession) {
            const { session, context } = configSession;
            logger.info(`WS Connect ${JSON.stringify(session)}`);
            connection.sessionId = session.session;
            connection.gateContext = context;
            connection.session = session;
            const buf = Buffer.alloc(6);
            crypto.randomFillSync(buf);
            connection.uniqhash = buf.toString("hex");
            connection.on("close", () => {
                const obj = this.notificationClient[
                    `${session.idUser}:${session.nameProvider}`
                ];
                delete obj[connection.uniqhash];
            });
            if (
                this.notificationClient[
                    `${session.idUser}:${session.nameProvider}`
                ]
            ) {
                this.notificationClient[
                    `${session.idUser}:${session.nameProvider}`
                ][connection.uniqhash] = connection;
            } else {
                this.notificationClient[
                    `${session.idUser}:${session.nameProvider}`
                ] = {
                    [connection.uniqhash]: connection,
                };
            }
            return;
        }
        logger.debug("Close %s", sessionId);
        connection.sendCloseFrame(
            4001,
            "Session not found, specified query requires authentication",
            true,
        );
    }

    /**
     * Получить все подключеные id пользователей
     * @param nameProvider
     */
    public getIdUsers(nameProvider?: string): string[] {
        const names = {};
        forEach(this.notificationClient || {}, (userObj) => {
            forEach(userObj || {}, (conn) => {
                if (
                    (nameProvider &&
                        conn.session.nameProvider === nameProvider) ||
                    !nameProvider
                ) {
                    names[(conn as any).session.idUser] = true;
                }
            });
        });
        return Object.keys(names);
    }

    /**
     * Отправка сообщения пользователю
     * @param idUser индификатор пользователя
     * @param nameProviderAuth наименование провайдера
     * @param text текст сообщения
     */
    public sendNotification(
        idUser: string,
        nameProviderAuth: string,
        text: string,
    ) {
        forEach(
            this.notificationClient[`${idUser}:${nameProviderAuth}`] || {},
            (conn) => conn.sendUTF(text),
        );
    }

    /**
     * Отправка всем пользователям
     * @param text текст сообщения
     */
    public sendNotificationAll(text: string) {
        forEach(this.notificationClient || {}, (userObj) => {
            forEach(userObj || {}, (conn) => conn.sendUTF(text));
        });
    }
    /**
     * Обновление информации о пользователе
     * @param ckUser индификатор пользователя
     */
    public updateUserInfo(nameProvider?: string, ckUser?: string) {
        const allConn = Object.values(this.notificationClient || {}).reduce(
            (arr, value) => [...arr, ...Object.values(value)],
            [],
        ) as IWSConnect[];
        let filter: (IWSConnect) => boolean = () => true;
        if (ckUser && nameProvider) {
            filter = (conn) =>
                conn.session.idUser === ckUser &&
                conn.session.nameProvider === nameProvider;
        } else if (nameProvider) {
            filter = (conn) => conn.session.nameProvider === nameProvider;
        }

        const confSessions = allConn.filter(filter).reduce((res, conn) => {
            if (!res[conn.gateContext.name]) {
                res[conn.gateContext.name] = {
                    context: conn.gateContext,
                    sessions: [conn.sessionId],
                    conns: [conn],
                };
            } else {
                res[conn.gateContext.name].sessions.push(conn.sessionId);
                res[conn.gateContext.name].conns.push(conn);
            }
            return res;
        }, {}) as IConfigSession;
        if (confSessions) {
            Object.values(confSessions).forEach(({ context, sessions }) => {
                (context.authController as GateSession)
                    .findSessions(sessions, false)
                    .then((docs) => {
                        const ckUsers = Object.values(docs).map(
                            (doc) =>
                                `${doc.gsession.idUser}:${doc.gsession.nameProvider}`,
                        );
                        const data = Object.values(docs).reduce((res, doc) => {
                            res[
                                `${doc.gsession.idUser}:${doc.gsession.nameProvider}`
                            ] = doc.gsession.userData;
                            return res;
                        }, {});
                        return (context.authController as GateSession)
                            .getUserDb()
                            .find({ ck_id: { $in: ckUsers } })
                            .then((users) => {
                                users.forEach((user) => {
                                    Object.values(
                                        this.notificationClient[user.ck_id],
                                    ).forEach((conn) =>
                                        conn.sendUTF(
                                            JSON.stringify([
                                                {
                                                    data: {
                                                        ...data[user.ck_id],
                                                        ...user.data,
                                                        session: conn.sessionId,
                                                    },
                                                    event: "reloaduser",
                                                },
                                            ]),
                                        ),
                                    );
                                });
                            });
                    })
                    .catch((err) => logger.error(err));
            });
        }
    }

    /**
     * Проверка пользователей на актуальность сессий
     */
    public checkConnection() {
        const allConn = Object.values(this.notificationClient || {}).reduce(
            (arr, value) => [...arr, ...Object.values(value)],
            [],
        ) as IWSConnect[];
        const confSessions = allConn.reduce((res, conn) => {
            if (!res[conn.gateContext.name]) {
                res[conn.gateContext.name] = {
                    context: conn.gateContext,
                    sessions: [conn.sessionId],
                    conns: [conn],
                };
            } else {
                res[conn.gateContext.name].sessions.push(conn.sessionId);
                res[conn.gateContext.name].conns.push(conn);
            }
            return res;
        }, {}) as IConfigSession;
        if (allConn.length) {
            Object.values(confSessions).forEach(
                ({ context, sessions, conns }) => {
                    (context.authController as GateSession)
                        .findSessions(sessions, false)
                        .then((docs) => {
                            const getSession = Object.values(docs).map(
                                (doc) => doc.gsession?.session,
                            );
                            const disconectedSession = sessions.filter(
                                (sessionId) =>
                                    getSession.indexOf(sessionId) === -1,
                            );
                            disconectedSession.forEach((sessionId) => {
                                conns.forEach((conn) => {
                                    if (conn.sessionId === sessionId) {
                                        logger.debug(
                                            "Close expire %s",
                                            conn.sessionId,
                                        );
                                        conn.sendCloseFrame(
                                            4001,
                                            "Session not found, specified query requires authentication",
                                            true,
                                        );
                                        const obj = this.notificationClient[
                                            `${conn.session.idUser}:${conn.session.nameProvider}`
                                        ];
                                        delete obj[conn.uniqhash];
                                    }
                                });
                            });
                        })
                        .catch((err) => logger.error(err));
                },
            );
        }
        delay(() => this.checkConnection(), TIMEOUT);
    }
}

export default new NotificationController();
