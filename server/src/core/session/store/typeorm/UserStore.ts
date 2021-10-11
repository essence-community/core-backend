import ILocalDB, {
    Document,
    FilterQuery,
    InsertDoc,
    RemoveOptions,
    UpdateQuery,
} from "@ungate/plugininf/lib/db/local/ILocalDB";
import { IUserDbData } from "@ungate/plugininf/lib/ISession";
import { Connection } from "typeorm";
import { UserModel } from "./entries/UserModel";
import { addFilter } from "./Utils";
import { EventEmitter } from "events";

export class UserStore extends EventEmitter implements ILocalDB<IUserDbData> {
    dbname: string;
    isTemp: boolean = false;
    connection: Connection;
    constructor(name: string, conn: Connection) {
        super();
        this.dbname = name;
        this.connection = conn;
    }
    find(
        filter?: FilterQuery<Document<IUserDbData>>,
    ): Promise<Document<IUserDbData>[]> {
        const qb = this.connection
            .getRepository(UserModel)
            .createQueryBuilder();
        Object.entries(filter || {}).forEach(([key, value]) => {
            qb.andWhere(addFilter(value, key));
        });
        return qb.getMany();
    }
    findOne(
        filter: FilterQuery<Document<IUserDbData>>,
        noErrorNotFound?: boolean,
    ): Promise<Document<IUserDbData>> {
        const qb = this.connection
            .getRepository(UserModel)
            .createQueryBuilder();
        Object.entries(filter).forEach(([key, value]) => {
            qb.andWhere(addFilter(value, key));
        });
        return noErrorNotFound ? qb.getOne() : qb.getOneOrFail();
    }
    insert(
        newDoc:
            | InsertDoc<Document<IUserDbData>>
            | InsertDoc<Document<IUserDbData>>[],
    ): Promise<void> {
        this.emit("insert", newDoc);
        return this.connection
            .getRepository(UserModel)
            .save(newDoc as any)
            .then(() => {
                this.emit("inserted", newDoc);
            });
    }
    async update(
        filter: FilterQuery<Document<IUserDbData>>,
        update: UpdateQuery<Document<IUserDbData>>,
        options: {
            multi?: boolean;
            returnUpdatedDocs?: boolean;
            upsert?: boolean;
        } = { multi: false, upsert: false, returnUpdatedDocs: true },
    ): Promise<void> {
        this.emit("update", filter, update, options);
        const qb = this.connection
            .getRepository(UserModel)
            .createQueryBuilder()
            .update();
        qb.set(update as any);
        Object.entries(filter).forEach(([key, value]) => {
            qb.andWhere(addFilter(value, key));
        });
        await qb.execute();
        this.emit("updated", filter, update, options);
        return;
    }
    async remove(
        filter?: FilterQuery<Document<IUserDbData>>,
        options: RemoveOptions = { multi: true },
    ): Promise<void> {
        this.emit("remove", filter, options);
        const qb = this.connection
            .getRepository(UserModel)
            .createQueryBuilder()
            .delete();
        Object.entries(filter || {}).forEach(([key, value]) => {
            qb.andWhere(addFilter(value, key));
        });
        await qb.execute();
        this.emit("removed", filter, options);
        return;
    }
    count(filter?: FilterQuery<Document<IUserDbData>>): Promise<number> {
        const qb = this.connection
            .getRepository(UserModel)
            .createQueryBuilder();
        Object.entries(filter || {}).forEach(([key, value]) => {
            qb.andWhere(addFilter(value, key));
        });
        return qb.getCount();
    }
}
