import { SessionOptions, Store } from "express-session";
import { IStoreTypes, IGateSession } from "./Store.types";
import Logger from "@ungate/plugininf/lib/Logger";
import { ISessionData } from "@ungate/plugininf/lib/ISession";
import { IRufusLogger } from "rufus";
import { ISessionStore } from "@ungate/plugininf/lib/IAuthController";
import { Connection, IsNull, LessThan, MoreThanOrEqual } from "typeorm";
import { SessionModel } from "./typeorm/entries/SessionModel";
import { getSessionMaxAgeMs } from '../../util/index';

export interface IPTypeOrmSessionStore {
    connection: Connection;
}
export class TypeOrmSessionStore extends Store implements ISessionStore {
    name: string;
    ttl: number;
    connection: Connection;
    private logger: IRufusLogger;

    constructor(
        options: Partial<
            IPTypeOrmSessionStore & SessionOptions & IStoreTypes
        > = {},
    ) {
        // @ts-ignore
        super(options as any);
        this.connection = options.connection;
        this.logger = Logger.getLogger(
            `${options.nameContext}:TypeOrmSessionStore`,
        );
        this.name = options.nameContext;
        this.ttl = options.ttl;
        this.emit("disconnect");
    }

    async init() {
        await this.connection.connect();
        this.emit("connect");
        return;
    }

    get(id, cb: any = (err) => (err ? this.logger.error(err) : null)) {
        this.logger.trace("GET %s", id);
        const now = new Date();
        this.connection
            .getRepository(SessionModel)
            .findOne({
                where: [
                    {
                        id,
                        isDelete: IsNull(),
                        expire: MoreThanOrEqual(now),
                    },
                    {
                        id,
                        isDelete: false,
                        expire: MoreThanOrEqual(now),
                    },
                ],
            })
            .then((val) => {
                if (!val) {
                    return cb(null, null);
                }
                val.data.expires = val.expire;
                return cb(null, val.data);
            })
            .catch((err) => cb(err));
    }
    set(
        id,
        data: IGateSession,
        cb: any = (err) => (err ? this.logger.error(err) : null),
    ) {
        this.logger.trace("SET %s data %j", id, data);
        if (!data.cookie.maxAge) {
            const maxAge = data.sessionDuration ? getSessionMaxAgeMs(data.sessionDuration) : this.ttl * 1000;
            data.cookie.originalMaxAge = maxAge;
            data.cookie.maxAge = maxAge;
        }
        data.expires =
            data.cookie.expires ||
            new Date(
                Date.now() + data.cookie.maxAge,
            );
        this.connection
            .getRepository(SessionModel)
            .save({
                id,
                data,
                expire: data.expires,
            })
            .then(
                () => cb(),
                (err) => cb(err),
            );
    }
    destroy(id, cb: any = (err) => (err ? this.logger.error(err) : null)) {
        this.logger.trace("DESTROY %s", id);
        this.connection
            .getRepository(SessionModel)
            .save({
                id,
                isDelete: true,
            })
            .then(
                () => cb(),
                (err) => cb(err),
            );
    }

    touch(
        id,
        sess: IGateSession,
        cb: any = (err) => (err ? this.logger.error(err) : null),
    ) {
        this.logger.trace("TOUCH %s data %j", id, sess);
        if (!sess.gsession) {
            return cb();
        }
        const oldDate = sess.expires;
        if (
            oldDate &&
            oldDate.getTime() <
                new Date(
                    Date.now() -
                        sess.cookie.maxAge *
                            0.1,
                ).getTime()
        ) {
            return cb();
        } else {
            sess.cookie.expires = new Date(
                Date.now() + sess.cookie.maxAge,
            );
            sess.expires = sess.cookie.expires;
        }
        this.connection
            .getRepository(SessionModel)
            .createQueryBuilder("session")
            .update(SessionModel)
            .set({
                expire:
                    sess.cookie.expires ||
                    new Date(
                        Date.now() + sess.cookie.maxAge,
                    ),
                data: sess,
            })
            .where({
                id,
                expire: LessThan(
                    new Date(
                        Date.now() -
                            sess.cookie.maxAge *
                                0.1,
                    ),
                ),
            })
            .andWhere("(isDelete is null or isDelete = :isDelete)", {
                isDelete: false,
            })
            .returning("*")
            .execute()
            .then(
                (cnt) => cb(null, cnt.affected),
                (err) => cb(err),
            );
    }

    all(cb: any = (err) => (err ? this.logger.error(err) : null)) {
        this.logger.trace("ALL");
        this.connection
            .getRepository(SessionModel)
            .find({
                where: [
                    {
                        isDelete: IsNull(),
                    },
                    {
                        isDelete: false,
                    },
                ],
            })
            .then(
                (val) =>
                    cb(
                        null,
                        val.map((value) => ({
                            [value.id]: value.data as ISessionData,
                        })),
                    ),
                (err) => cb(err),
            );
    }

    allSession(
        sessionId?: string | string[],
        isExpired?: boolean,
    ): Promise<{ [sid: string]: ISessionData } | null> {
        const now = new Date();
        const rep = this.connection
            .getRepository(SessionModel)
            .createQueryBuilder("session")
            .where(
                "(session.isDelete is null or session.isDelete = :isDelete)",
                {
                    isDelete: false,
                },
            )
            .andWhere(
                isExpired
                    ? "session.expire < :expire"
                    : "session.expire >= :expire",
                {
                    expire: now,
                },
            );
        if (sessionId) {
            rep.andWhere("session.id IN (:...ids)", {
                ids: Array.isArray(sessionId) ? sessionId : [sessionId],
            });
        }
        return rep.getMany().then((val) =>
            val
                .filter((value) => value.data.gsession)
                .reduce((res, value) => {
                    res[value.id] = value.data;
                    return res;
                }, {} as { [sid: string]: any }),
        );
    }

    length(cb: any = (err) => (err ? this.logger.error(err) : null)) {
        this.logger.trace("LENGTH");
        this.connection
            .getRepository(SessionModel)
            .count({
                where: [
                    {
                        isDelete: IsNull(),
                    },
                    {
                        isDelete: false,
                    },
                ],
            })
            .then(
                (cnt) => cb(null, cnt),
                (err) => cb(err),
            );
    }

    clear(cb: any = (err) => (err ? this.logger.error(err) : null)) {
        this.logger.trace("CLEAR");
        this.connection
            .getRepository(SessionModel)
            .createQueryBuilder("session")
            .update(SessionModel)
            .set({
                isDelete: true,
            })
            .where({
                isDelete: IsNull(),
            })
            .returning("*")
            .execute()
            .then(
                (cnt) => cb(null, cnt.affected),
                (err) => cb(err),
            );
    }
}
