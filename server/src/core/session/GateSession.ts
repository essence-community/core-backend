import ILocalDB from "@ungate/plugininf/lib/db/local/ILocalDB";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import ISession, {
    IUserData,
    IUserDbData,
} from "@ungate/plugininf/lib/ISession";
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
    ICacheDb,
    ICreateSessionParam,
} from "@ungate/plugininf/lib/IAuthController";
import { ISessionStore } from "@ungate/plugininf/lib/IAuthController";
import { ISessionData } from "@ungate/plugininf/lib/ISession";
import { initParams, isEmpty } from "@ungate/plugininf/lib/util/Util";
import NullContext from "@ungate/plugininf/lib/NullContext";
import RequestContext from "../request/RequestContext";
import { debounce } from "@ungate/plugininf/lib/util/Util";
import { noop } from "lodash";
import * as moment from "moment-timezone";
import { ConnectionManager } from "typeorm";
import * as path from "path";
import { TypeOrmSessionStore } from "./store/TypeOrmSessionStore";
import { TypeOrmLogger } from "@ungate/plugininf/lib/db/TypeOrmLogger";
import { UserStore } from "./store/typeorm/UserStore";
import { CacheStore } from "./store/typeorm/CacheStore";
import { getSessionMaxAgeMs } from "../util";

const REPLICA_TIMEOUT = parseInt(
    process.env.KUBERNETES_REPLICA_TIMEOUT || "0",
    10,
);

export class GateSession implements IAuthController {
    private dbUsers: ILocalDB<IUserDbData>;
    private store: ISessionStore;
    private dbCache: ILocalDB<ICacheDb>;
    private logger: IRufusLogger;
    public updateUserInfo: typeof NotificationController.updateUserInfo;
    private params: IContextParams;
    private timezone: string;

    constructor(
        private name: string,
        params: IContextParams,
        private secret: string,
    ) {
        this.timezone = moment()
            .tz(Constants.DEFAULT_TIMEZONE_DATE)
            .format("Z");
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
        if (this.params.paramSession.typeStore === "nedb") {
            this.store = new NeDbSessionStore({
                nameContext: this.name,
                ttl: this.params.paramSession.cookie.maxAge,
            });
            this.dbUsers = await Property.getUsers(this.name);
            this.dbCache = await Property.getCache(this.name);
            if (
                process.env.KUBERNETES_SERVICE_HOST &&
                process.env.KUBERNETES_SERVICE_PORT
            ) {
                this.saveSession = (context: IContext) => {
                    return new Promise<void>((resolve, reject) => {
                        context.request.session.save((errChild) => {
                            if (errChild) {
                                return reject(errChild);
                            }
                            setTimeout(resolve, REPLICA_TIMEOUT);
                        });
                    });
                };
            }
        } else if (this.params.paramSession.typeStore === "typeorm") {
            const connectionManager = new ConnectionManager();
            const connection = connectionManager.create({
                ...this.params.paramSession.typeorm,
                extra: this.params.paramSession.typeorm.extra
                    ? JSON.parse(this.params.paramSession.typeorm.extra)
                    : undefined,
                synchronize: true,
                ...(this.params.paramSession.typeorm.typeOrmExtra
                    ? JSON.parse(this.params.paramSession.typeorm.typeOrmExtra)
                    : {}),
                name: `session_store_${this.name}`,
                logging: true,
                logger: new TypeOrmLogger(`${this.name}:session_store`),
                entities: [
                    path.join(
                        __dirname,
                        "store",
                        "typeorm",
                        "entries",
                        "*{.ts,.js}",
                    ),
                ],
            });
            this.store = new TypeOrmSessionStore({
                connection,
                nameContext: this.name,
                ttl: this.params.paramSession.cookie.maxAge,
            });
            this.dbUsers = new UserStore(this.name, connection);
            this.dbCache = new CacheStore(this.name, connection);
        }
        await this.store.init();

        this.logger.info("Inited AuthController %s", this.name);
    }

    public saveSession(context: IContext): Promise<void> {
        return new Promise<void>((resolve, reject) => {
            context.request.session.save((errChild) => {
                if (errChild) {
                    return reject(errChild);
                }
                return resolve();
            });
        });
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
    }: ICreateSessionParam): Promise<IUserData> {
        if (!idUser) {
            idUser = uuidv4();
            idUser = idUser.replace(/-/g, "");
        }
        if (isEmpty(userData.cv_timezone)) {
            userData.cv_timezone = this.timezone;
        }
        if (isEmpty(userData.ca_actions)) {
            userData.ca_actions = [];
        }
        if (isEmpty(userData.ca_department)) {
            userData.ca_department = [];
        }
        if (
            typeof userData.ca_actions === "string" &&
            (userData.ca_actions as string).startsWith("[") &&
            (userData.ca_actions as string).endsWith("]")
        ) {
            userData.ca_actions = JSON.parse(userData.ca_actions);
        }
        if (
            typeof userData.ca_department === "string" &&
            (userData.ca_department as string).startsWith("[") &&
            (userData.ca_department as string).endsWith("]")
        ) {
            userData.ca_department = JSON.parse(userData.ca_department);
        }
        if (!Array.isArray(userData.ca_department)) {
            userData.ca_department = [];
        }
        if (!Array.isArray(userData.ca_actions)) {
            userData.ca_actions = [];
        }
        const signed =
            "s:" + this.sign(context.request.session.id, this.secret);

        context.request.session.gsession = {
            nameProvider,
            idUser,
            userData: userData as any,
            session: signed,
            sessionData,
        };
        const maxAge = getSessionMaxAgeMs(sessionDuration);
        context.request.session.cookie.originalMaxAge = maxAge;
        context.request.session.cookie.maxAge = maxAge;
        context.request.session.cookie.expires = new Date(
            Date.now() + maxAge,
        );
        context.request.session.sessionDuration = sessionDuration;
        context.request.session.expires = context.request.session.cookie.expires;
        context.request.session.create = new Date();
        return this.saveSession(context).then(() => ({
            ...userData,
            session: signed,
        }));
    }

    public async loadSession(
        context?: IContext,
        sessionId?: string,
        isNotification = false,
    ): Promise<ISession | null> {
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
            (context.request.session.gsession.sessionData.typeCheckAuth ===
                "cookie" ||
                context.request.session.gsession.sessionData.typeCheckAuth ===
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
                            (data.gsession.sessionData.typeCheckAuth ===
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
                            this.saveSession(context).then(
                                () => resolve(context.request.session.gsession),
                                reject,
                            );
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
    public logoutSession(context: RequestContext) {
        return new Promise<void>((resolve, reject) => {
            if (context.request.session.gsession) {
                context.request.session.cookie.expires = new Date();
                this.store.destroy(context.request.session.id, (err) => {
                    context.request.sessionID = null;
                    context.setSession(null);
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

    private updateHashDebounce = debounce(() => {
        this.updateHashAuth().then(noop, (err) => this.logger.error(err));
    }, 5000);

    /**
     * Добавляем пользователей в кэш
     * @param idUser индификатор пользователя
     * @param nameProvider наименование провайдера
     * @param data Данные пользователя
     */
    public addUser(
        idUser: string,
        nameProvider: string,
        data: IUserData,
        login = data?.cv_login,
    ): Promise<void> {
        if (isEmpty(data.cv_timezone)) {
            data.cv_timezone = this.timezone;
        }
        if (isEmpty(data.ca_actions)) {
            data.ca_actions = [];
        }
        if (isEmpty(data.ca_department)) {
            data.ca_department = [];
        }
        if (
            typeof data.ca_actions === "string" &&
            (data.ca_actions as string).startsWith("[") &&
            (data.ca_actions as string).endsWith("]")
        ) {
            data.ca_actions = JSON.parse(data.ca_actions);
        }
        if (
            typeof data.ca_department === "string" &&
            (data.ca_department as string).startsWith("[") &&
            (data.ca_department as string).endsWith("]")
        ) {
            data.ca_department = JSON.parse(data.ca_department);
        }
        if (!Array.isArray(data.ca_department)) {
            data.ca_department = [];
        }
        if (!Array.isArray(data.ca_actions)) {
            data.ca_actions = [];
        }
        return this.dbUsers
            .insert({
                ck_d_provider: nameProvider,
                ck_id: `${idUser}:${nameProvider}`,
                cv_login: login,
                data,
            })
            .then(() => {
                this.updateUserInfo();
                this.updateHashDebounce();
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
    ): Promise<IUserData | null> {
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

    public getUserDb(): ILocalDB<IUserDbData> {
        return this.dbUsers;
    }

    public getSessionStore(): ISessionStore {
        return this.store;
    }

    public getCacheDb(): ILocalDB<ICacheDb> {
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
                const item: Partial<IUserData> = row.data || {};
                if (!Array.isArray(item.ca_actions)) {
                    if (
                        typeof item.ca_actions === "string" &&
                        (item.ca_actions as any).startsWith("[")
                    ) {
                        item.ca_actions = JSON.parse(item.ca_actions);
                    } else {
                        item.ca_actions = [];
                    }
                }
                (item.ca_actions || []).forEach((action) => {
                    userActions.push({
                        ck_user: item.ck_id,
                        cn_action: action,
                    });
                });
                if (!Array.isArray(item.ca_department)) {
                    if (
                        typeof item.ca_department === "string" &&
                        (item.ca_department as any).startsWith("[")
                    ) {
                        item.ca_department = JSON.parse(item.ca_department);
                    } else {
                        item.ca_department = [];
                    }
                }
                (item.ca_department || []).forEach((dep) => {
                    userDepartments.push({
                        ck_department: dep,
                        ck_user: item.ck_id,
                    });
                });
                delete item.ca_actions;
                delete item.ca_department;
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
    public getHashSalt(): string {
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
}
