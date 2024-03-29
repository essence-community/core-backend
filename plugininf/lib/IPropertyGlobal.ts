import ILocalDB from "./db/local/ILocalDB";
import { ICacheDb } from "./ISessCtrl";
import { IUserDbData } from "./ISession";

export interface IPropertyGlobal {
    getCache(name: string): Promise<ILocalDB<ICacheDb>>;
    getUsers(name: string): Promise<ILocalDB<IUserDbData>>;
}
