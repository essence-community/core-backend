import { EventEmitter } from "events";
export type Document<T> = T & {
    ck_id?: string;
    _id?: string;
    createdAt?: Date;
    updatedAt?: Date;
};

export type WithTimestamps<T> = T & { createdAt: Date; updatedAt: Date };

type Deep<T> = { [K: string]: any };
type DeepKey<T> = keyof Deep<T>;
type DeArray<A> = A extends (infer T)[] ? T : never;

/*
type Optional<T extends Record<string, any>, OptionalKeys extends string> =
    {[K in OptionalKeys]?: T[K]} &
    {[K in Exclude<keyof T, OptionalKeys>]: T[K]};
*/

type Optional<T extends Record<string, any>, OptionalK extends string> = Omit<
    T,
    OptionalK
> &
    { [K in OptionalK]?: T[K] };

export type UpdateDoc<Doc> = Partial<Omit<Doc, "_id">>;
export type InsertDoc<Doc> = Optional<Doc, "_id" | "createdAt" | "updatedAt">;

export type QueryOperators<T> = Partial<{
    $in: T[];
    $nin: T[];
    $ne: T;
    $gt:
        | (T extends string ? string : never)
        | (T extends number ? number : never);
    $lt:
        | (T extends string ? string : never)
        | (T extends number ? number : never);
    $gte:
        | (T extends string ? string : never)
        | (T extends number ? number : never);
    $lte:
        | (T extends string ? string : never)
        | (T extends number ? number : never);
    $exists: boolean;
    $regex: T extends string ? RegExp : never;
    $size: T extends any[] ? number : never;
    $elemMatch: Partial<T> | QueryOperators<DeArray<T>>;
}>;

export type LogicalOperators<T> = {
    $not: Partial<T> | QueryOperators<T> | Record<string, any>;
    $or: (Partial<T> | QueryOperators<T> | Record<string, any>)[];
    $and: (Partial<T> | QueryOperators<T> | Record<string, any>)[];
};

export type FilterQuery<Doc> = Partial<LogicalOperators<Doc>> &
    Partial<{ [K in keyof Doc]: Doc[K] | QueryOperators<Doc[K]> }> &
    Partial<
        { [K in keyof Deep<Doc>]: Deep<Doc>[K] | QueryOperators<Deep<Doc>[K]> }
    >;

export type SortQuery<Doc> = Partial<Record<keyof Doc, -1 | 1>> &
    Partial<Record<DeepKey<Doc>, 1 | -1>>;

export type Projection<Doc> =
    | ({ _id?: 1 | 0 } & Record<keyof Doc, 0> & Record<DeepKey<Doc>, 0>)
    | ({ _id?: 1 | 0 } & Record<keyof Doc, 1> & Record<DeepKey<Doc>, 1>);

export type UpdateOperators<Doc> = {
    $set: { [K in keyof Omit<Doc, "_id">]?: Doc[K] } &
        Record<DeepKey<Doc>, any>;

    $unset: Record<Exclude<keyof Doc, "_id">, boolean> &
        Record<DeepKey<Doc>, boolean>;

    $push: {
        [K in keyof Doc]: Doc[K] extends any[]
            ?
                  | DeArray<Doc[K]>
                  | {
                        $each: Doc[K];
                        $slice?: number;
                    }
            : never;
    } &
        Record<DeepKey<Doc>, any>;

    $addToSet: {
        [K in keyof Doc]: Doc[K] extends any[]
            ?
                  | DeArray<Doc[K]>
                  | {
                        $each: Doc[K];
                        $slice?: number;
                    }
            : never;
    } &
        Record<DeepKey<Doc>, { $each: any; $slice?: number } | any>;

    $pull: {
        [K in keyof Doc]: Doc[K] extends any[]
            ?
                  | Partial<DeArray<Doc[K]>>
                  | FilterQuery<Doc[K]>
                  | {
                        $each: Partial<DeArray<Doc[K]>>;
                        $slice?: number;
                    }
            : never;
    } &
        Record<
            DeepKey<Doc>,
            | FilterQuery<any>
            | {
                  $each: any | FilterQuery<any>;
                  $slice?: number;
              }
            | any
        >;

    $slice: { [K in keyof Doc]: Doc[K] extends any[] ? number : never } &
        Record<DeepKey<Doc>, number>;

    $pop: { [K in keyof Doc]: Doc[K] extends any[] ? number : never } &
        Record<DeepKey<Doc>, number>;

    $inc: { [K in keyof Doc]?: Doc[K] extends number ? number : never } &
        Record<DeepKey<Doc>, number>;

    $dec: { [K in keyof Doc]?: Doc[K] extends number ? number : never } &
        Record<DeepKey<Doc>, number>;

    $min: { [K in keyof Doc]?: Doc[K] extends number ? number : never } &
        Record<DeepKey<Doc>, number>;

    $max: { [K in keyof Doc]?: Doc[K] extends number ? number : never } &
        Record<DeepKey<Doc>, number>;
};

export type UpdateQuery<Doc> = UpdateDoc<Doc> | Partial<UpdateOperators<Doc>>;

export type RemoveOptions = {
    multi?: boolean;
};

/**
 * Created by artemov_i on 04.12.2018.
 */
export default interface ILocalDB<T> extends EventEmitter {
    dbname: string;
    isTemp: boolean;
    find(filter?: FilterQuery<Document<T>>): Promise<Document<T>[]>;
    findOne(
        filter: FilterQuery<Document<T>>,
        noErrorNotFound?: boolean,
    ): Promise<Document<T> | null>;
    insert(
        newDoc: InsertDoc<Document<T>> | InsertDoc<Document<T>>[],
    ): Promise<void>;
    on(
        event: "insert" | "inserted",
        listener: (
            newDoc: InsertDoc<Document<T>> | InsertDoc<Document<T>>[],
        ) => void,
    ): this;
    once(
        event: "insert" | "inserted",
        listener: (
            newDoc: InsertDoc<Document<T>> | InsertDoc<Document<T>>[],
        ) => void,
    ): this;
    update(
        filter: FilterQuery<Document<T>>,
        update: UpdateQuery<Document<T>>,
        options?: {
            multi?: boolean;
            returnUpdatedDocs?: boolean;
            upsert?: boolean;
        },
    ): Promise<void>;
    on(
        event: "update" | "updated",
        listener: (
            filter: FilterQuery<Document<T>>,
            update: UpdateQuery<Document<T>>,
            options?: {
                multi?: boolean;
                returnUpdatedDocs?: boolean;
                upsert?: boolean;
            },
        ) => void,
    ): this;
    once(
        event: "update" | "updated",
        listener: (
            filter: FilterQuery<Document<T>>,
            update: UpdateQuery<Document<T>>,
            options?: {
                multi?: boolean;
                returnUpdatedDocs?: boolean;
                upsert?: boolean;
            },
        ) => void,
    ): this;
    remove(
        filter?: FilterQuery<Document<T>>,
        options?: RemoveOptions,
    ): Promise<void>;
    on(
        event: "remove" | "removed",
        listener: (
            filter?: FilterQuery<Document<T>>,
            options?: RemoveOptions,
        ) => void,
    ): this;
    once(
        event: "remove" | "removed",
        listener: (
            filter?: FilterQuery<Document<T>>,
            options?: RemoveOptions,
        ) => void,
    ): this;
    count(filter?: FilterQuery<Document<T>>): Promise<number>;
}
