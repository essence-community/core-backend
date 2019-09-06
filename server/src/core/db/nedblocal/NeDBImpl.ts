import * as nedb from "@ungate/nedb-multi";
import ILocalDB, { IParamLocal } from "@ungate/plugininf/lib/db/local/ILocalDB";
import { sendProcess } from "@ungate/plugininf/lib/util/ProcessSender";
import { isEmpty } from "@ungate/plugininf/lib/util/Util";
import { isArray } from "lodash";

export class NeDBImpl implements ILocalDB {
    public dbname: string;
    public db: nedb.INeDb;
    public isTemp: boolean;

    constructor(dbname: string, db: nedb.INeDb, isTemp: boolean) {
        this.dbname = dbname;
        this.db = db;
        this.isTemp = isTemp;
    }

    public find(object: IParamLocal = {}): Promise<IParamLocal[]> {
        return new Promise((resolve, reject) => {
            this.db.find(object, (err, docs) => {
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
        object: IParamLocal,
        noErrorNotFound: boolean,
    ): Promise<IParamLocal | null> {
        return new Promise((resolve, reject) => {
            this.db.findOne(object, (err, doc) => {
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

    public insert(object: IParamLocal | IParamLocal[]): Promise<void> {
        return new Promise((resolve, reject) => {
            if (isArray(object)) {
                Promise.all(object.map((item) => this.insert(item)))
                    .then(() => resolve())
                    .catch((err) => reject(err));
                return;
            }
            if (!isEmpty((object as IParamLocal).ck_id)) {
                (object as IParamLocal)._id = (object as IParamLocal).ck_id;
            }
            if (!isEmpty((object as IParamLocal)._id)) {
                this.update(
                    {
                        _id: (object as IParamLocal)._id,
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
        object1: IParamLocal,
        object2,
        opts = { multi: false, upsert: false, returnUpdatedDocs: true },
    ): Promise<void> {
        sendProcess({
            command: "sendAllServerCallDb",
            data: {
                action: "update",
                args: [object1, object2, opts],
                isTemp: this.isTemp,
                name: this.dbname,
            },
            target: "clusterAdmin",
        });
        return new Promise((resolve, reject) => {
            this.db.update(object1, object2, opts, (err) => {
                if (err) {
                    err.message += ` db ${this.dbname}`;
                    return reject(err);
                }
                return resolve();
            });
        });
    }

    public remove(object1: IParamLocal, object2 = {}): Promise<void> {
        sendProcess({
            command: "sendAllServerCallDb",
            data: {
                action: "remove",
                args: [object1, object2],
                isTemp: this.isTemp,
                name: this.dbname,
            },
            target: "clusterAdmin",
        });
        return new Promise((resolve, reject) => {
            this.db.remove(object1, object2, (err) => {
                if (err) {
                    err.message += ` db ${this.dbname}`;
                    return reject(err);
                }
                return resolve();
            });
        });
    }

    public count(object: IParamLocal = {}): Promise<number> {
        return new Promise((resolve, reject) => {
            this.db.count(object, (err, count) => {
                if (err) {
                    err.message += ` db ${this.dbname}`;
                    return reject(err);
                }
                return resolve(count);
            });
        });
    }
}
