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

export class UserStore implements ILocalDB<IUserDbData> {
    dbname: string;
    isTemp: boolean = false;
    connection: Connection;
    constructor(name: string, conn: Connection) {
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
        return this.connection.getRepository(UserModel).save(newDoc as any);
    }
    async update(
        filter: FilterQuery<Document<IUserDbData>>,
        update: UpdateQuery<Document<IUserDbData>>,
        options?: {
            multi?: boolean;
            returnUpdatedDocs?: boolean;
            upsert?: boolean;
        },
    ): Promise<void> {
        const qb = this.connection
            .getRepository(UserModel)
            .createQueryBuilder()
            .update();
        qb.set(update as any);
        Object.entries(filter).forEach(([key, value]) => {
            qb.andWhere(addFilter(value, key));
        });
        await qb.execute();
    }
    async remove(
        filter?: FilterQuery<Document<IUserDbData>>,
        options?: RemoveOptions,
    ): Promise<void> {
        const qb = this.connection
            .getRepository(UserModel)
            .createQueryBuilder()
            .delete();
        Object.entries(filter || {}).forEach(([key, value]) => {
            qb.andWhere(addFilter(value, key));
        });
        await qb.execute();
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
