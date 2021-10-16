/* tslint:disable:variable-name */
import { SessionOptions, Store } from "express-session";
import ILocalDB from "@ungate/plugininf/lib/db/local/ILocalDB";
import Property from "../../property/Property";
import { IStoreTypes, IGateSession } from "./Store.types";
import Logger from "@ungate/plugininf/lib/Logger";
import { ISessionData } from "@ungate/plugininf/lib/ISession";
import { IRufusLogger } from "rufus";
import { ISessionStore } from "@ungate/plugininf/lib/IAuthController";

export interface IDBSessionData {
    ck_id: string;
    isDelete?: boolean;
    expiredAt: any;
    data: IGateSession;
}

export class NeDbSessionStore extends Store implements ISessionStore {
    db: ILocalDB<IDBSessionData>;
    name: string;
    ttl: number;
    private logger: IRufusLogger;

    constructor(options: Partial<SessionOptions & IStoreTypes> = {}) {
        // @ts-ignore
        super(options as any);
        this.logger = Logger.getLogger(
            `${options.nameContext}:NeDbSessionStore`,
        );
        this.name = options.nameContext;
        this.ttl = options.ttl;
        this.emit("disconnect");
    }

    init() {
        return Property.getSession(this.name).then((db) => {
            this.db = db;
            this.emit("connect");
            return;
        });
    }

    get(ck_id, cb: any = (err) => (err ? this.logger.error(err) : null)) {
        this.logger.trace("GET %s", ck_id);
        const now = new Date();
        this.db
            .findOne(
                {
                    ck_id,
                    isDelete: {
                        $exists: false,
                    },
                    expiredAt: {
                        $gte: now,
                    },
                },
                true,
            )
            .then(
                (val) => {
                    if (!val) {
                        return cb(null, null);
                    }
                    val.data.expires = val.expiredAt;
                    return cb(null, val.data);
                },
                (err) => cb(err),
            );
    }
    set(
        ck_id,
        data: IGateSession,
        cb: any = (err) => (err ? this.logger.error(err) : null),
    ) {
        this.logger.trace("SET %s data %j", ck_id, data);
        data.expires =
            data.cookie.expires ||
            new Date(
                Date.now() +
                    (data.sessionDuration
                        ? data.sessionDuration * 60000
                        : this.ttl * 1000),
            );
        this.db
            .update(
                { ck_id },
                {
                    ck_id,
                    data,
                    expiredAt: data.expires,
                },
                { multi: false, upsert: true },
            )
            .then(
                () => cb(),
                (err) => cb(err),
            );
    }
    destroy(ck_id, cb: any = (err) => (err ? this.logger.error(err) : null)) {
        this.logger.trace("DESTROY %s", ck_id);
        this.db
            .update(
                { ck_id },
                { ck_id, isDelete: true },
                { multi: false, upsert: false },
            )
            .then(
                () => cb(),
                (err) => cb(err),
            );
    }

    touch(
        ck_id,
        sess: IGateSession,
        cb: any = (err) => (err ? this.logger.error(err) : null),
    ) {
        this.logger.trace("TOUCH %s data %j", ck_id, sess);
        if (!sess.gsession) {
            return cb();
        }
        const oldDate = sess.expires;
        if (
            oldDate &&
            oldDate.getTime() <
                new Date(
                    Date.now() -
                        (sess.sessionDuration
                            ? sess.sessionDuration * 60000
                            : this.ttl * 1000) *
                            0.1,
                ).getTime()
        ) {
            return cb();
        } else {
            sess.cookie.maxAge = sess.sessionDuration
                ? sess.sessionDuration * 60000
                : this.ttl * 1000;
            sess.cookie.originalMaxAge = sess.sessionDuration
                ? sess.sessionDuration * 60000
                : this.ttl * 1000;
            sess.cookie.expires = new Date(
                Date.now() +
                    (sess.sessionDuration
                        ? sess.sessionDuration * 60000
                        : this.ttl * 1000),
            );
            sess.expires = sess.cookie.expires;
        }
        this.db
            .update(
                {
                    $and: [
                        {
                            ck_id,
                        },
                        {
                            isDelete: {
                                $exists: false,
                            },
                        },
                        {
                            expiredAt: {
                                $lt: new Date(
                                    Date.now() -
                                        (sess.sessionDuration
                                            ? sess.sessionDuration * 60000
                                            : this.ttl * 1000) *
                                            0.1,
                                ),
                            },
                        },
                    ],
                },
                {
                    ck_id,
                    expiredAt:
                        sess.cookie.expires ||
                        new Date(
                            Date.now() +
                                (sess.sessionDuration
                                    ? sess.sessionDuration * 60000
                                    : this.ttl * 1000),
                        ),
                    data: sess,
                },
                { multi: false, upsert: false },
            )
            .then(
                () => cb(),
                (err) => cb(err),
            );
    }

    all(cb: any = (err) => (err ? this.logger.error(err) : null)) {
        this.logger.trace("ALL");
        this.db
            .find({
                isDelete: {
                    $exists: false,
                },
            })
            .then(
                (val: Record<string, any>) => {
                    cb(
                        null,
                        val.map((value) => ({
                            [value.ck_id]: value.data as ISessionData,
                        })),
                    );
                },
                (err) => cb(err),
            );
    }

    allSession(
        sessionId?: string | string[],
        isExpired?: boolean,
    ): Promise<{ [sid: string]: ISessionData } | null> {
        const now = new Date();
        return this.db
            .find({
                $and: [
                    {
                        isDelete: {
                            $exists: false,
                        },
                    },
                    ...(sessionId
                        ? [
                              {
                                  ck_id: Array.isArray(sessionId)
                                      ? {
                                            $in: sessionId,
                                        }
                                      : sessionId,
                              },
                          ]
                        : []),
                    {
                        expiredAt: {
                            [isExpired ? "$lt" : "$gte"]: now,
                        },
                    },
                ],
            })
            .then((val: Record<string, any>) =>
                val
                    .filter((value) => value.data.gsession)
                    .reduce((res, value) => {
                        res[value.ck_id] = value.data;
                        return res;
                    }, {} as { [sid: string]: ISessionData }),
            );
    }

    length(cb: any = (err) => (err ? this.logger.error(err) : null)) {
        this.logger.trace("LENGTH");
        this.db
            .count({
                isDelete: {
                    $exists: false,
                },
            })
            .then(
                (cnt) => cb(null, cnt),
                (err) => cb(err),
            );
    }

    clear(cb: any = (err) => (err ? this.logger.error(err) : null)) {
        this.logger.trace("CLEAR");
        this.db
            .update(
                {
                    isDelete: {
                        $exists: false,
                    },
                },
                {
                    isDelete: true,
                },
                { multi: true },
            )
            .then(
                (cnt) => cb(null, cnt),
                (err) => cb(err),
            );
    }
}
