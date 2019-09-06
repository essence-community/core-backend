export interface IParamLocal {
    [key: string]: any;
}
/**
 * Created by artemov_i on 04.12.2018.
 */
export default interface ILocalDB {
    dbname: string;
    isTemp: boolean;
    find(obj?: IParamLocal): Promise<IParamLocal[]>;
    findOne(
        obj: IParamLocal,
        noErrorNotFound?: boolean,
    ): Promise<IParamLocal | null>;
    insert(obj: IParamLocal | IParamLocal[]): Promise<void>;
    update(
        obj: IParamLocal,
        obj2: IParamLocal,
        options?: IParamLocal,
    ): Promise<void>;
    remove(obj: IParamLocal, options?: IParamLocal): Promise<void>;
    count(obj?: IParamLocal): Promise<number>;
}
