import ILocalDB from "@ungate/plugininf/lib/db/local/ILocalDB";
import IObjectParam from "@ungate/plugininf/lib/IObjectParam";
import Logger from "@ungate/plugininf/lib/Logger";
import * as crypto from "crypto";
import * as http from "http";
import * as https from "https";
import { delay, forEach } from "lodash";
import * as websocket from "websocket";
import Property from "../../core/property/Property";
import GateSession from "../../core/session/GateSession";
import Mask from "../Mask";
const logger = Logger.getLogger("NotificationController");
const TIMEOUT = 30000;

class NotificationController {
    public notificationClient: IObjectParam = {};
    private wsServer: websocket.server;
    private dbUsers: ILocalDB;
    public async init(httpServer: http.Server | https.Server): Promise<void> {
        this.wsServer = new websocket.server({
            httpServer,
        });
        this.wsServer.on("request", this.onRequest.bind(this));
        delay(() => this.checkConnection(), TIMEOUT);
        this.dbUsers = await Property.getUsers();
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

    public onRequest(request) {
        if (!request.resourceURL.query || !request.resourceURL.query.session) {
            return;
        }
        const connection = request.accept("notification", request.origin);
        GateSession.loadSession(request.resourceURL.query.session)
            .then((session) => {
                if (session) {
                    logger.info(`WS Connect ${JSON.stringify(session)}`);
                    connection.sessionId = session.session;
                    connection.session = session;
                    const buf = Buffer.alloc(6);
                    crypto.randomFillSync(buf);
                    connection.uniqhash = buf.toString("hex");
                    connection.on("close", () => {
                        const obj = this.notificationClient[
                            `${session.ck_id}:${session.ck_d_provider}`
                        ];
                        delete obj[connection.uniqhash];
                    });
                    if (
                        this.notificationClient[
                            `${session.ck_id}:${session.ck_d_provider}`
                        ]
                    ) {
                        this.notificationClient[
                            `${session.ck_id}:${session.ck_d_provider}`
                        ][connection.uniqhash] = connection;
                    } else {
                        this.notificationClient[
                            `${session.ck_id}:${session.ck_d_provider}`
                        ] = {
                            [connection.uniqhash]: connection,
                        };
                    }
                    return;
                }
                connection.close(
                    4001,
                    "Session not found, specified query requires authentication",
                );
            })
            .catch((err) => logger.error(err));
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
                        conn.session.ck_d_provider === nameProvider) ||
                    !nameProvider
                ) {
                    names[(conn as any).session.ck_id] = true;
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
        );
        let sessions;
        if (ckUser && nameProvider) {
            sessions = allConn
                .filter(
                    (conn) =>
                        conn.session.ck_user === ckUser &&
                        conn.session.ck_d_provider === nameProvider,
                )
                .map((conn) => conn.sessionId);
        } else if (nameProvider) {
            sessions = allConn
                .filter((conn) => conn.session.ck_d_provider === nameProvider)
                .map((conn) => conn.sessionId);
        } else {
            sessions = allConn.map((conn) => conn.sessionId);
        }
        if (allConn.length) {
            GateSession.findSessions(sessions, false)
                .then((docs) => {
                    const ckUsers = docs.map(
                        (doc) => `${doc.ck_id}:${doc.ck_d_provider}`,
                    );
                    return this.dbUsers
                        .find({ ck_id: { $in: ckUsers } })
                        .then((users) => {
                            users.forEach((user) => {
                                Object.values(
                                    this.notificationClient[user.ck_id],
                                ).forEach((conn) =>
                                    (conn as any).sendUTF(
                                        JSON.stringify([
                                            {
                                                data: {
                                                    ...user.data,
                                                    session: (conn as any)
                                                        .sessionId,
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
        }
    }

    /**
     * Проверка пользователей на актуальность сессий
     */
    public checkConnection() {
        const allConn = Object.values(this.notificationClient || {}).reduce(
            (arr, value) => [...arr, ...Object.values(value)],
            [],
        );
        const sessions = allConn.map((conn) => conn.sessionId);
        if (allConn.length) {
            GateSession.findSessions(sessions, false)
                .then((docs) => {
                    const getSession = docs.map((doc) => doc.ck_id);
                    const disconectedSession = sessions.filter(
                        (session) => getSession.indexOf(session) === -1,
                    );
                    disconectedSession.forEach((session) => {
                        allConn.forEach((conn) => {
                            if (conn.sessionId === session) {
                                conn.close(
                                    4001,
                                    "Session not found, specified query requires authentication",
                                );
                                const obj = this.notificationClient[
                                    `${conn.session.ck_id}:${conn.session.ck_d_provider}`
                                ];
                                delete obj[conn.uniqhash];
                            }
                        });
                    });
                })
                .catch((err) => logger.error(err));
        }
        delay(() => this.checkConnection(), TIMEOUT);
    }
}

export default new NotificationController();
