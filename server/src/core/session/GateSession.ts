import ILocalDB from "@ungate/plugininf/lib/db/local/ILocalDB";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import IObjectParam from "@ungate/plugininf/lib/IObjectParam";
import ISession from "@ungate/plugininf/lib/ISession";
import Logger from "@ungate/plugininf/lib/Logger";
import * as crypto from "crypto";
import { v4 as uuidv4 } from "uuid";
import Constants from "../Constants";
import Property from "../property/Property";
import { IContextParams } from "@ungate/plugininf/lib/IContextPlugin";
import { NeDbSessionStore } from "./store/NeDbSessionStore";
import IContext from "@ungate/plugininf/lib/IContext";
import { IRufusLogger } from "rufus";
import NotificationController from "../../http/controllers/NotificationController";
import {
    IAuthController,
    ICreateSessionParam,
} from "@ungate/plugininf/lib/IAuthController";
import { ISessionStore } from "@ungate/plugininf/lib/IAuthController";
import { ISessionData } from "@ungate/plugininf/lib/ISession";
import { initParams } from "@ungate/plugininf/lib/util/Util";
import NullContext from "@ungate/plugininf/lib/NullContext";

export class GateSession implements IAuthController {
    private dbUsers: ILocalDB;
    private store: ISessionStore;
    private dbCache: ILocalDB;
    private logger: IRufusLogger;
    public updateUserInfo: () => void;
    private params: IContextParams;

    constructor(
        private name: string,
        params: IContextParams,
        private secret: string,
    ) {
        this.params = initParams(NullContext.getParamsInfo(), params);
        this.logger = Logger.getLogger(`GateSession_${name}`);
        this.updateUserInfo = NotificationController.updateUserInfo.bind(
            NotificationController,
        );
    }

    public async init() {
        this.logger.debug(
            "Start Init AuthController %s params %j",
            this.name,
            this.params,
        );
        this.dbUsers = await Property.getUsers(this.name);
        this.store =
            this.params.paramSession.typeStore === "nedb"
                ? new NeDbSessionStore({
                      nameContext: this.name,
                      ttl: this.params.paramSession.cookie.maxAge,
                  })
                : new NeDbSessionStore({
                      nameContext: this.name,
                      ttl: this.params.paramSession.cookie.maxAge,
                  });
        await this.store.init();
        this.dbCache = await Property.getCache(this.name);
        this.logger.info("Inited AuthController %s", this.name);
    }

    public sha1(buf): string {
        const shasum = crypto.createHash("sha1");
        shasum.update(buf);
        return shasum.digest("hex");
    }

    public static sha1(buf): string {
        const shasum = crypto.createHash("sha1");
        shasum.update(buf);
        return shasum.digest("hex");
    }

    public sha256(buf): string {
        const shasum = crypto.createHash("sha256");
        shasum.update(buf);
        return shasum.digest("hex");
    }

    public static sha256(buf): string {
        const shasum = crypto.createHash("sha256");
        shasum.update(buf);
        return shasum.digest("hex");
    }

    /**
     * Создание сессии
     * @param idUser индификатор пользователя
     * @param nameProvider наименование провайдера
     * @param data данные пользователя
     * @param sessionDuration время жизни сессии в минутах
     */
    public createSession({
        context,
        idUser,
        nameProvider,
        userData,
        sessionDuration = 60,
        sessionData,
    }: ICreateSessionParam): Promise<IObjectParam> {
        if (!idUser) {
            idUser = uuidv4();
            idUser = idUser.replace(/-/g, "");
        }
        const signed =
            "s:" + this.sign(context.request.session.id, this.secret);

        context.request.session.gsession = {
            nameProvider,
            idUser,
            userData: userData as any,
            session: signed,
            ...sessionData,
        };
        context.request.session.cookie.originalMaxAge = sessionDuration * 60000;
        context.request.session.cookie.maxAge = sessionDuration * 60000;
        context.request.session.cookie.expires = new Date(
            Date.now() + sessionDuration * 6000,
        );
        return new Promise((resolve, reject) => {
            context.request.session.save((err) => {
                if (err) {
                    return reject(err);
                }
                resolve({
                    ...userData,
                    session: signed,
                });
            });
        });
    }

    public async loadSession(
        context?: IContext,
        sessionId?: string,
        isNotification = false,
    ): Promise<ISession | null> {
        const now = new Date();

        if (
            context &&
            sessionId &&
            context.request.session &&
            context.request.session.gsession &&
            context.request.session.gsession.session === sessionId
        ) {
            return context.request.session.gsession;
        }

        if (
            context &&
            context.request.session &&
            context.request.session.gsession &&
            (context.request.session.gsession.typeCheckAuth === "cookie" ||
                context.request.session.gsession.typeCheckAuth ===
                    "cookieorsession")
        ) {
            return context.request.session.gsession;
        }

        if (sessionId && sessionId.substr(0, 2) === "s:") {
            const val = this.unsign(sessionId.slice(2), this.secret);

            if (val) {
                return new Promise((resolve, reject) => {
                    this.store.get(val, (err, data: ISessionData) => {
                        if (err) {
                            return reject(err);
                        }
                        if (
                            !data ||
                            !data.gsession ||
                            (data.gsession.typeCheckAuth ===
                                "cookieandsession" &&
                                !isNotification)
                        ) {
                            return resolve(null);
                        }
                        if (context) {
                            Object.entries(data)
                                .filter(([key]) => key !== "cookie")
                                .forEach(([key, value]) => {
                                    context.request.session[key] = value;
                                });
                            context.request.session.save((errChild) => {
                                if (errChild) {
                                    return reject(errChild);
                                }
                                return resolve(
                                    context.request.session.gsession,
                                );
                            });
                            return;
                        }
                        return resolve((data as any).gsession);
                    });
                });
            }
        }

        return null;
    }

    /**
     * Устаревание сессии
     * @param context {IContext}
     */
    public logoutSession(context: IContext) {
        return new Promise<void>((resolve, reject) => {
            if (context.request.session.gsession) {
                context.request.session.cookie.expires = new Date();
                context.request.session?.destroy((err) => {
                    if (err) {
                        return reject(err);
                    }
                    return resolve();
                });
            }
        });
    }

    /**
     * Поиск сессий
     * @param sessionId {Array | string} Строка или массив сессий
     * @param isExpired {boolean} Только истекшии
     * @returns {Promise}
     */
    public findSessions(
        sessionId: string | string[],
        isExpired: boolean = false,
    ): Promise<{ [sid: string]: ISessionData }> {
        const sessions = Array.isArray(sessionId) ? sessionId : [sessionId];

        return this.store.allSession(
            sessions
                .map((session) =>
                    session.substr(0, 2) === "s:"
                        ? this.unsign(session.slice(2), this.secret)
                        : session,
                )
                .filter((session) => typeof session === "string") as string[],
            isExpired,
        );
    }
    /**
     * Добавляем пользователей в кэш
     * @param idUser индификатор пользователя
     * @param nameProvider наименование провайдера
     * @param data Данные пользователя
     */
    public addUser(
        idUser: string,
        nameProvider: string,
        data: IObjectParam,
    ): Promise<void> {
        return this.dbUsers.insert({
            ck_d_provider: nameProvider,
            ck_id: `${idUser}:${nameProvider}`,
            data,
        });
    }
    /**
     * Получаем данные о пользователе
     * @param idUser индификатор пользователя
     * @param nameProvider наименование провайдера
     */
    public async getDataUser(
        idUser: string,
        nameProvider: string,
        isAccessErrorNotFound: boolean = false,
    ): Promise<IObjectParam | null> {
        const data = await this.dbUsers.findOne(
            {
                ck_id: `${idUser}:${nameProvider}`,
            },
            true,
        );
        if (data) {
            return data.data;
        }
        if (isAccessErrorNotFound) {
            throw new ErrorException(ErrorGate.AUTH_DENIED);
        }
        return null;
    }

    public getUserDb(): ILocalDB {
        return this.dbUsers;
    }

    public getSessionStore(): ISessionStore {
        return this.store;
    }

    public getCacheDb(): ILocalDB {
        return this.dbCache;
    }

    /**
     * Обновляем hash авторизации
     * @returns {Promise.<*>}
     */
    public updateHashAuth() {
        return this.dbUsers.find().then((data) => {
            const users = [];
            const userActions = [];
            const userDepartments = [];
            data.forEach((row) => {
                const item = row.data || {};
                (item.ca_actions || []).forEach((action) => {
                    userActions.push({
                        ck_user: item.ck_id,
                        cn_action: action,
                    });
                });
                (item.ca_department || []).forEach((dep) => {
                    userDepartments.push({
                        ck_department: dep,
                        ck_user: item.ck_id,
                    });
                });
                delete item.ca_actions;
                delete item.ca_department;
                delete item.ck_dept;
                delete item.cv_timezone;
                users.push(item);
            });
            const usersJson = JSON.stringify(users);
            const userActionsJson = JSON.stringify(userActions);
            const userDepartmentsJson = JSON.stringify(userDepartments);
            return Promise.all([
                Promise.resolve({
                    hash_user: this.sha1(usersJson),
                }),
                userActions.length
                    ? Promise.resolve({
                          hash_user_action: this.sha1(userActionsJson),
                      })
                    : Promise.resolve({
                          hash_user_action: null,
                      }),
                userDepartments.length
                    ? Promise.resolve({
                          hash_user_department: this.sha1(userDepartmentsJson),
                      })
                    : Promise.resolve({
                          hash_user_department: null,
                      }),
            ]).then((values) =>
                this.dbCache.insert({
                    ck_id: "hash_user",
                    ...values[0],
                    ...values[1],
                    ...values[2],
                }),
            );
        });
    }
    /**
     * Получение соли
     * @returns hash salt
     */
    private getHashSalt(): string {
        let hashSalt = Constants.HASH_SALT;
        if (!hashSalt) {
            const hashLocalSalt = Constants.APP_START_TIME.toString(16);
            const buf = Buffer.alloc(8);
            crypto.randomFillSync(buf).toString("hex");
            hashSalt =
                hashLocalSalt + crypto.randomFillSync(buf).toString("hex");
            Constants.HASH_SALT = hashSalt;
        }
        return hashSalt;
    }

    public sign(val: string, secret: string): string {
        return (
            val +
            "." +
            crypto
                .createHmac("sha256", secret)
                .update(val)
                .digest("base64")
                .replace(/\=+$/, "")
        );
    }
    public unsign(val: string, secret: string): string | false {
        const str = val.slice(0, val.lastIndexOf("."));
        const mac = this.sign(str, secret);
        const macBuffer = Buffer.from(mac);
        const valBuffer = Buffer.alloc(macBuffer.length);

        valBuffer.write(val);
        return crypto.timingSafeEqual(macBuffer, valBuffer) ? str : false;
    }

    /**
     * Рандомное значение
     * @returns random
     */
    private generateRandom(): Promise<string> {
        return new Promise((resolve, reject) => {
            const buf = Buffer.alloc(10);
            crypto.randomFill(buf, (err, newBuf) => {
                if (err) {
                    return reject(err);
                }
                return resolve(newBuf.toString("hex"));
            });
        });
    }

    /**
     * Создание сессии
     * @param id - ид сессии
     * @returns сессия
     */
    private async generateIdSession(id: string | number): Promise<string> {
        return new Promise((resolve, reject) => {
            let buf = "";
            this.generateRandom()
                .then((rnd) => {
                    buf += rnd;
                    buf += this.getHashSalt();
                    return this.sha256(buf);
                })
                .then((str) => {
                    buf += str;
                    return this.generateRandom();
                })
                .then((rnd) => {
                    buf += rnd;
                    buf += id;
                    return this.generateRandom();
                })
                .then((rnd) => {
                    buf += rnd;
                    return this.generateRandom();
                })
                .then((rnd) => {
                    buf += rnd;
                    return this.generateRandom();
                })
                .then((rnd) => {
                    buf += rnd;
                    return this.sha256(buf);
                })
                .then((hash) => {
                    buf = hash;
                    const sessionId = buf.toUpperCase();
                    this.logger.trace(`generated session id: ${sessionId}`);
                    return resolve(sessionId);
                })
                .catch((err) => {
                    this.logger.error(err);
                    return reject(err);
                });
        });
    }
}
