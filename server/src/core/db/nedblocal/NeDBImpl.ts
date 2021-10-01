import * as nedb from "@ungate/nedb-multi";
import ILocalDB, {
    Document,
    FilterQuery,
    InsertDoc,
    RemoveOptions,
    UpdateQuery,
} from "@ungate/plugininf/lib/db/local/ILocalDB";
import { sendProcess } from "@ungate/plugininf/lib/util/ProcessSender";
import { isEmpty } from "@ungate/plugininf/lib/util/Util";
import { isArray } from "lodash";

export class NeDBImpl<T> implements ILocalDB<T> {
    public dbname: string;
    public db: nedb.INeDb;
    public isTemp: boolean;

    constructor(dbname: string, db: nedb.INeDb, isTemp: boolean) {
        this.dbname = dbname;
        this.db = db;
        this.isTemp = isTemp;
    }

    public find(filter?: FilterQuery<Document<T>>): Promise<Document<T>[]> {
        return new Promise((resolve, reject) => {
            this.db.find(filter, (err, docs) => {
                if (err) {
                    err.message += ` db ${this.dbname}`;
                    return reject(err);
                }
                return resolve(
                    docs.map((item) => ({
                        ...item,
                        _id: undefined,
                    })),
                );
            });
        });
    }

    public findOne(
        filter: FilterQuery<Document<T>>,
        noErrorNotFound: boolean,
    ): Promise<Document<T> | null> {
        return new Promise((resolve, reject) => {
            this.db.findOne(filter, (err, doc) => {
                let res = null;
                if (err) {
                    err.message += ` db ${this.dbname}`;
                    return reject(err);
                } else if (!doc && !noErrorNotFound) {
                    return reject(
                        new Error(`Not Found Data in db ${this.dbname}`),
                    );
                } else if (doc) {
                    res = {
                        ...doc,
                        _id: undefined,
                    };
                }
                return resolve(res);
            });
        });
    }

    public insert(
        object: InsertDoc<Document<T>> | InsertDoc<Document<T>>[],
    ): Promise<void> {
        return new Promise((resolve, reject) => {
            if (isArray(object)) {
                Promise.all(object.map((item) => this.insert(item)))
                    .then(() => resolve())
                    .catch((err) => reject(err));
                return;
            }
            if (!isEmpty(object.ck_id)) {
                // @ts-ignore
                object._id = object.ck_id;
            }
            if (!isEmpty(object._id)) {
                this.update(
                    // @ts-ignore
                    {
                        _id: object._id,
                    },
                    {
                        $set: object,
                    },
                    { multi: true, upsert: true, returnUpdatedDocs: false },
                )
                    .then(() => resolve())
                    .catch((err) => reject(err));
            } else {
                sendProcess({
                    command: "sendAllServerCallDb",
                    data: {
                        action: "insert",
                        args: [object],
                        isTemp: this.isTemp,
                        name: this.dbname,
                    },
                    target: "clusterAdmin",
                });
                this.db.insert(object, (err) => {
                    if (err) {
                        err.message += ` db ${this.dbname}`;
                        return reject(err);
                    }
                    return resolve();
                });
            }
        });
    }

    public update(
        filter: FilterQuery<Document<T>>,
        update: UpdateQuery<Document<T>>,
        opts = { multi: false, upsert: false, returnUpdatedDocs: true },
    ): Promise<void> {
        sendProcess({
            command: "sendAllServerCallDb",
            data: {
                action: "update",
                args: [filter, update, opts],
                isTemp: this.isTemp,
                name: this.dbname,
            },
            target: "clusterAdmin",
        });
        return new Promise((resolve, reject) => {
            this.db.update(filter, update, opts, (err) => {
                if (err) {
                    err.message += ` db ${this.dbname}`;
                    return reject(err);
                }
                return resolve();
            });
        });
    }

    public remove(
        filter: FilterQuery<Document<T>>,
        options?: RemoveOptions,
    ): Promise<void> {
        sendProcess({
            command: "sendAllServerCallDb",
            data: {
                action: "remove",
                args: [filter, options],
                isTemp: this.isTemp,
                name: this.dbname,
            },
            target: "clusterAdmin",
        });
        return new Promise((resolve, reject) => {
            this.db.remove(filter, options, (err) => {
                if (err) {
                    err.message += ` db ${this.dbname}`;
                    return reject(err);
                }
                return resolve();
            });
        });
    }

    public count(filter: FilterQuery<Document<T>>): Promise<number> {
        return new Promise((resolve, reject) => {
            this.db.count(filter, (err, count) => {
                if (err) {
                    err.message += ` db ${this.dbname}`;
                    return reject(err);
                }
                return resolve(count);
            });
        });
    }

    public compactDatafile() {
        return new Promise<void>((resolve) => {
            this.db.persistence.compactDatafile();
            return resolve();
        });
    }
}
