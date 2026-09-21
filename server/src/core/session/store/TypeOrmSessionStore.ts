import {SessionOptions, Store} from "express-session-fork";
import {IStoreTypes, IGateSession} from "./Store.types";
import Logger, {IRufusLogger} from "@ungate/plugininf/lib/Logger";
import {ISessionData} from "@ungate/plugininf/lib/ISession";
import {Brackets, DataSource, IsNull, MoreThanOrEqual, Repository} from "typeorm";
import {SessionModel} from "@ungate/plugininf/lib/entries/SessionModel";

export interface IPTypeOrmSessionStore {
    connection: DataSource;
}
export class TypeOrmSessionStore extends Store {
    name: string;
    ttl: number;
    connection: DataSource;
    sessionStore: Repository<SessionModel>;
    private logger: IRufusLogger;

    constructor(
        options: Partial<
            IPTypeOrmSessionStore &
            SessionOptions &
            IStoreTypes & {nameContext: string; ttl: number}
        >,
    ) {
        super(options as any);
        this.connection = options.connection as DataSource;
        this.logger = Logger.getLogger(
            `TypeOrmSessionStore.${options.nameContext}`,
        );
        this.name = options.nameContext as string;
        this.ttl = options.ttl as number;
        this.sessionStore = this.connection.getRepository(SessionModel);
        this.emit("disconnect");
    }

    async init() {
        await this.connection.initialize();
        this.emit("connect");
        return;
    }

    get(id: string, cb: any = (err: Error) => (err ? this.logger.error(err) : null)) {
        this.logger.trace("GET %s", id);
        const now = new Date();
        this.sessionStore
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
        id: string,
        data: IGateSession,
        cb: any = (err: Error) => (err ? this.logger.error(err) : null),
    ) {
        this.logger.trace("SET %s data %j", id, data);
        data.expires =
            data.cookie.expires || new Date(Date.now() + (data.cookie.maxAge ?? 60 * 60 * 24));
        this.sessionStore
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
    destroy(id: string, cb: any = (err: Error) => (err ? this.logger.error(err) : null)) {
        this.logger.trace("DESTROY %s", id);
        this.sessionStore
            .update({
                id,
            }, {
                isDelete: true,
            });
    }

    touch(
        id: string,
        sess: IGateSession,
        cb: any = (err: Error) => (err ? this.logger.error(err) : null),
    ) {
        this.logger.trace("TOUCH %s data %j", id, sess);
        this.sessionStore
            .createQueryBuilder("session")
            .update(SessionModel)
            .set({
                expire:
                    sess.cookie.expires ||
                    new Date(Date.now() + (sess.cookie.maxAge ?? 60 * 60 * 24)),
                data: sess,
            })
            .where([
                {
                    id,
                    isDelete: IsNull(),
                },
                {
                    id,
                    isDelete: false,
                },
            ])
            .returning("*")
            .execute()
            .then(
                (cnt) => cb(null, cnt.affected),
                (err) => cb(err),
            );
    }

    all(cb: any = (err: Error) => (err ? this.logger.error(err) : null)) {
        this.logger.trace("ALL");
        this.sessionStore
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
    ): Promise<{[sid: string]: ISessionData} | null> {
        const now = new Date();
        const rep = this.sessionStore
            .createQueryBuilder("session")
            .where(
                new Brackets((qb) =>
                    qb.where([
                        {
                            isDelete: IsNull(),
                        },
                        {
                            isDelete: false,
                        },
                    ]),
                ),
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
                .reduce(
                    (res, value) => {
                        res[value.id] = value.data;
                        return res;
                    },
                    {} as {[sid: string]: any},
                ),
        );
    }

    length(cb: any = (err: Error) => (err ? this.logger.error(err) : null)) {
        this.logger.trace("LENGTH");
        this.sessionStore
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

    clear(cb: any = (err: Error) => (err ? this.logger.error(err) : null)) {
        this.logger.trace("CLEAR");
        this.sessionStore
            .createQueryBuilder("session")
            .update(SessionModel)
            .set({
                isDelete: true,
            })
            .where([
                {
                    isDelete: IsNull(),
                },
                {
                    isDelete: false,
                },
            ])
            .returning("*")
            .execute()
            .then(
                (cnt) => cb(null, cnt.affected),
                (err) => cb(err),
            );
    }
}
