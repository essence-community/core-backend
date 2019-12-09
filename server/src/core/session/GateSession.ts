import ILocalDB from "@ungate/plugininf/lib/db/local/ILocalDB";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import IObjectParam from "@ungate/plugininf/lib/IObjectParam";
import ISession from "@ungate/plugininf/lib/ISession";
import Logger from "@ungate/plugininf/lib/Logger";
import { dateBetween } from "@ungate/plugininf/lib/util/Util";
import * as crypto from "crypto";
import { isArray } from "lodash";
import * as moment from "moment";
import { uuid as uuidv4 } from "uuidv4";
import Constants from "../Constants";
import Property from "../property/Property";

const logger = Logger.getLogger("GateSession");

class GateSession {
    private dbUsers: ILocalDB;
    private dbSession: ILocalDB;
    private dbCache: ILocalDB;

    public async init() {
        this.dbUsers = await Property.getUsers();
        this.dbSession = await Property.getSessions();
        this.dbCache = await Property.getCache();
    }

    public sha1(buf): Promise<string> {
        return new Promise((resolve) => {
            const shasum = crypto.createHash("sha1");
            shasum.update(buf);
            return resolve(shasum.digest("hex"));
        });
    }

    public sha256(buf): Promise<string> {
        return new Promise((resolve) => {
            const shasum = crypto.createHash("sha256");
            shasum.update(buf);
            return resolve(shasum.digest("hex"));
        });
    }

    /**
     * Создание сессии
     * @param idUser индификатор пользователя
     * @param nameProvider наименование провайдера
     * @param data данные пользователя
     * @param sessionDuration время жизни сессии в минутах
     */
    public createSession(
        idUser: string,
        nameProvider: string,
        data: IObjectParam,
        sessionDuration: number = 60,
    ): Promise<IObjectParam> {
        if (!idUser) {
            idUser = uuidv4();
            idUser = idUser.replace(/-/g, "");
        }
        return this.generateIdSession(idUser).then((sessionId) => {
            const param: IObjectParam = {};
            const now = new Date();
            param.ck_id = sessionId;
            param.ck_user = idUser;
            param.ck_d_provider = nameProvider;
            param.cd_create = now;
            param.cn_session_duration = sessionDuration;
            param.cd_expire = new Date(now.getTime() + sessionDuration * 60000);
            param.data = data;
            return this.dbSession.insert(param).then(async () => ({
                ...data,
                session: sessionId,
            }));
        });
    }

    public loadSession(
        sessionId: string,
        idUser?: string,
        nameProvider?: string,
    ): Promise<ISession | null> {
        const now = new Date();

        if (sessionId || (idUser && nameProvider)) {
            return this.dbSession
                .findOne(
                    {
                        $and: [
                            ...(sessionId
                                ? [{ ck_id: sessionId }]
                                : [
                                      { ck_user: idUser },
                                      { ck_d_provider: nameProvider },
                                  ]),
                            {
                                cd_expire: {
                                    $gte: now,
                                },
                            },
                        ],
                    },
                    true,
                )
                .then((doc) => {
                    if (doc) {
                        const cdExpire = moment(doc.cd_expire);
                        if (cdExpire.isBefore(now)) {
                            return Promise.reject(
                                new ErrorException(ErrorGate.REQUIRED_AUTH),
                            );
                        }
                        if (
                            dateBetween(
                                now,
                                new Date(
                                    cdExpire.toDate().getTime() -
                                        (doc.cn_session_duration || 60) *
                                            60000 *
                                            0.2,
                                ),
                                cdExpire.toDate(),
                            )
                        ) {
                            this.renewSession(
                                doc.ck_id,
                                doc.cn_session_duration,
                            );
                        }
                        return this.dbUsers
                            .findOne(
                                {
                                    ck_id: `${doc.ck_user}:${doc.ck_d_provider}`,
                                },
                                true,
                            )
                            .then(async (user) => ({
                                ck_d_provider: doc.ck_d_provider as string,
                                ck_id: doc.ck_user as string,
                                data: (user && user.data) || doc.data,
                                session: sessionId,
                            }));
                    }
                    return Promise.resolve(null);
                });
        }
        return Promise.resolve(null);
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
    ): Promise<IObjectParam> {
        const now = new Date();
        return this.dbSession.find({
            $and: [
                {
                    ck_id: isArray(sessionId)
                        ? {
                              $in: sessionId,
                          }
                        : sessionId,
                },
                {
                    cd_expire: {
                        [isExpired ? "$lt" : "$gte"]: now,
                    },
                },
            ],
        });
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

    /**
     * Обновление времени жизни сессиии
     * @param sessionId - сессия
     * @param id
     * @param sessionDuration - время жизни в минутах
     */
    public async renewSession(sessionId: string, sessionDuration: number = 60) {
        const now = new Date();
        try {
            await this.dbSession.update(
                { ck_id: sessionId },
                {
                    $set: {
                        cd_expire: new Date(
                            now.getTime() + sessionDuration * 60000,
                        ),
                    },
                },
            );
        } catch (e) {
            logger.error("Ошибка обновление сессии", e);
        }
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
                this.sha1(usersJson).then((sha) =>
                    Promise.resolve({
                        hash_user: sha,
                    }),
                ),
                userActions.length
                    ? this.sha1(userActionsJson).then((sha) =>
                          Promise.resolve({
                              hash_user_action: sha,
                          }),
                      )
                    : Promise.resolve({
                          hash_user_action: null,
                      }),
                userDepartments.length
                    ? this.sha1(userDepartmentsJson).then((sha) =>
                          Promise.resolve({
                              hash_user_department: sha,
                          }),
                      )
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
                    logger.trace(`generated session id: ${sessionId}`);
                    return resolve(sessionId);
                })
                .catch((err) => {
                    logger.error(err);
                    return reject(err);
                });
        });
    }
}

export default new GateSession();
