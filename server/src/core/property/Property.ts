import * as nedb from "@ungate/nedb-multi";
import ILocalDB from "@ungate/plugininf/lib/db/local/ILocalDB";
import { ICacheDb } from "@ungate/plugininf/lib/ISessCtrl";
import IGlobalObject from "@ungate/plugininf/lib/IGlobalObject";
import { IUserDbData } from "@ungate/plugininf/lib/ISession";
import * as path from "path";
import * as fs from "fs";
import Constants from "../Constants";
import { NeDBImpl } from "../db/nedblocal/NeDBImpl";
import IContextConfig from "./IContextConfig";
import IEventConfig from "./IEventConfig";
import IShedulerConfig from "./IShedulerConfig";
import IServerConfig from "./IServerConfig";
import IQueryConfig from "./IQueryConfig";
import IPluginConfig from "./IPluginConfig";
import IProviderConfig from "./IProviderConfig";
import { IDBSessionData } from "../session/store/NeDbSessionStore";
let DataStore;
const LocalProperty: Map<string, ILocalDB<any>> = new Map();
const TempTable: Map<string, ILocalDB<any>> = new Map();

/*class ErrorLoadPropert extends Error {
    public isNotExist: boolean = false;
}*/

export async function getLocalDb<T>(
    name: string,
    isTemp?: boolean,
): Promise<ILocalDB<T>> {
    if (
        typeof isTemp === "undefined" &&
        LocalProperty.has(name) &&
        TempTable.has(name)
    ) {
        throw new Error(`A lot of db: ${name}`);
    }
    if (typeof isTemp !== "undefined") {
        return loadProperty(name, isTemp);
    }
    return TempTable.get(name) || LocalProperty.get(name);
}

export function loadProperty<T>(
    name,
    isTemp: boolean = false,
): Promise<ILocalDB<T>> {
    return new Promise(async (resolve, reject) => {
        if (LocalProperty.has(name) || TempTable.has(name)) {
            return resolve(
                isTemp ? TempTable.get(name) : LocalProperty.get(name),
            );
        }
        if (Constants.LOCAL_DB === "nedb") {
            if (!DataStore) {
                DataStore = nedb.NeDbProxy(
                    Constants.NEDB_MULTI_PORT,
                    Constants.NEDB_MULTI_HOST,
                );
            }
            let typeFile = "yaml-property";
            let filename = path.join(Constants.NEDB_TEMP_DB, `${name}.yaml`);
            if (!isTemp) {
                filename = path.join(Constants.PROPERTY_DIR, `${name}.yaml`);
                if (fs.existsSync(path.join(Constants.PROPERTY_DIR, `${name}.toml`))) {
                    typeFile = "toml";
                    filename = path.join(Constants.PROPERTY_DIR, `${name}.toml`)
                }
            }
            const db = new DataStore({
                filename,
                indexs: [{ fieldName: "ck_id", unique: true }],
                nameDb: name,
                typeFile,
            });
            db.loadDatabase((err) => {
                if (err) {
                    err.message = `Ошибка инициализации ${name}\n${err.message}`;
                    return reject(err);
                }
                // db.persistence.setAutocompactionInterval(5000);
                const localDb = new NeDBImpl<T>(name, db, isTemp);
                if (isTemp) {
                    TempTable.set(name, localDb);
                    return resolve(localDb);
                }
                LocalProperty.set(name, localDb);
                resolve(localDb);
            });
        }
        /*
        const pathConf = path.join(dirname, `${name}.toml`)
        if (fs.existsSync(pathConf)) {
            fs.readFile(pathConf, {
                encoding: "UTF-8",
                flag: "r"
            }, (err, strConf) => {
                if (err) {
                    err.message = `Ошибка инициализации ${name}.toml\n${err.message}`;
                    return reject(err);
                }
                const json = TOML.parse(strConf);
                return resolve((<ILocalDB> json));
            });
        }
        const err = new ErrorLoadPropert(`Ошибка инициализации ${name}.toml`);
        err.isNotExist = true;
        return reject(err);
        */
    });
}
class BuildProperty {
    public getConfig(): Promise<ILocalDB<Record<string, string>>> {
        return loadProperty<Record<string, string>>("t_config");
    }
    public getContext(): Promise<ILocalDB<IContextConfig>> {
        return loadProperty<IContextConfig>("t_context");
    }
    public getProviders(): Promise<ILocalDB<IProviderConfig>> {
        return loadProperty<IProviderConfig>("t_providers");
    }
    public getPlugins(): Promise<ILocalDB<IPluginConfig>> {
        return loadProperty<IPluginConfig>("t_plugins");
    }
    public getQuery(): Promise<ILocalDB<IQueryConfig>> {
        return loadProperty<IQueryConfig>("t_query");
    }
    public getServers(): Promise<ILocalDB<IServerConfig>> {
        return loadProperty<IServerConfig>("t_servers");
    }
    public getEvents(): Promise<ILocalDB<IEventConfig>> {
        return loadProperty<IEventConfig>("t_events");
    }
    public getSchedulers(): Promise<ILocalDB<IShedulerConfig>> {
        return loadProperty<IShedulerConfig>("t_schedulers");
    }
    public getCache(name: string): Promise<ILocalDB<ICacheDb>> {
        return loadProperty<ICacheDb>(`tt_cache_${name}`, true);
    }
    public getUsers(name: string): Promise<ILocalDB<IUserDbData>> {
        return loadProperty<IUserDbData>(`tt_users_${name}`, true);
    }
    public getSession(name: string): Promise<ILocalDB<IDBSessionData>> {
        return loadProperty<IDBSessionData>(`tt_sessions_${name}`, true);
    }
}
(global as any as IGlobalObject).createTempTable = (name) => {
    return loadProperty(name, true);
};
const Property = new BuildProperty();
(global as any as IGlobalObject).property = Property;
export default Property;
