import ILocalDB, {
    Document,
    FilterQuery,
    InsertDoc,
    RemoveOptions,
    UpdateQuery,
} from "@ungate/plugininf/lib/db/local/ILocalDB";
import { ICacheDb } from "@ungate/plugininf/lib/ISessCtrl";
import { Connection } from "typeorm";
import { CacheModel } from "./entries/CacheModel";
import { addFilter } from "./Utils";
import { EventEmitter } from "events";

interface ICache {
    ck_id: string;
}

export class CacheStore extends EventEmitter implements ILocalDB<ICacheDb> {
    dbname: string;
    isTemp: boolean = false;
    connection: Connection;
    constructor(name: string, conn: Connection) {
        super();
        this.dbname = name;
        this.connection = conn;
    }
    find(
        filter?: FilterQuery<Document<ICache>>,
    ): Promise<Document<ICacheDb>[]> {
        const qb = this.connection
            .getRepository(CacheModel)
            .createQueryBuilder();
        Object.entries(filter || {}).forEach(([key, value]) => {
            qb.andWhere(addFilter(value, key));
        });
        return qb.getMany().then((val) =>
            val.map(({ ck_id, data }) => ({
                ...data,
                ck_id,
            })),
        );
    }
    findOne(
        filter: FilterQuery<Document<ICache>>,
        noErrorNotFound?: boolean,
    ): Promise<Document<ICacheDb>> {
        const qb = this.connection
            .getRepository(CacheModel)
            .createQueryBuilder();
        Object.entries(filter).forEach(([key, value]) => {
            qb.andWhere(addFilter(value, key));
        });
        return noErrorNotFound
            ? qb.getOne().then(({ ck_id, data }) => ({
                  ...data,
                  ck_id,
              }))
            : qb.getOneOrFail().then(({ ck_id, data }) => ({
                  ...data,
                  ck_id,
              }));
    }
    insert(
        newDoc: InsertDoc<Document<ICacheDb>> | InsertDoc<Document<ICacheDb>>[],
    ): Promise<void> {
        this.emit("insert", newDoc);
        return this.connection
            .getRepository(CacheModel)
            .save(
                (Array.isArray(newDoc) ? newDoc : [newDoc]).map(
                    ({ ck_id, ...data }) => ({
                        ck_id,
                        data,
                    }),
                ) as any,
            )
            .then(() => {
                this.emit("inserted", newDoc);
            });
    }
    async update(
        filter: FilterQuery<Document<ICache>>,
        update: UpdateQuery<Document<ICacheDb>>,
        options: {
            multi?: boolean;
            returnUpdatedDocs?: boolean;
            upsert?: boolean;
        } = { multi: false, upsert: false, returnUpdatedDocs: true },
    ): Promise<void> {
        this.emit("update", filter, update, options);
        const qb = this.connection
            .getRepository(CacheModel)
            .createQueryBuilder()
            .update();
        qb.set({
            data: update as any,
        });
        Object.entries(filter).forEach(([key, value]) => {
            qb.andWhere(addFilter(value, key));
        });
        await qb.execute();
        this.emit("updated", filter, update, options);
        return;
    }
    async remove(
        filter?: FilterQuery<Document<ICache>>,
        options: RemoveOptions = { multi: true },
    ): Promise<void> {
        this.emit("remove", filter, options);
        const qb = this.connection
            .getRepository(CacheModel)
            .createQueryBuilder()
            .delete();
        Object.entries(filter || {}).forEach(([key, value]) => {
            qb.andWhere(addFilter(value, key));
        });
        await qb.execute();
        this.emit("removed", filter, options);
        return;
    }
    count(filter?: FilterQuery<Document<ICache>>): Promise<number> {
        const qb = this.connection
            .getRepository(CacheModel)
            .createQueryBuilder();
        Object.entries(filter || {}).forEach(([key, value]) => {
            qb.andWhere(addFilter(value, key));
        });
        return qb.getCount();
    }
}
