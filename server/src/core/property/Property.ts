import * as nedb from "@ungate/nedb-multi";
import ILocalDB from "@ungate/plugininf/lib/db/local/ILocalDB";
import IGlobalObject from "@ungate/plugininf/lib/IGlobalObject";
import * as path from "path";
import Constants from "../Constants";
import { NeDBImpl } from "../db/nedblocal/NeDBImpl";
let DataStore;
const LocalProperty: Map<string, ILocalDB> = new Map();
const TempTable: Map<string, ILocalDB> = new Map();

/*class ErrorLoadPropert extends Error {
    public isNotExist: boolean = false;
}*/

export async function getLocalDb(
    name: string,
    isTemp?: boolean,
): Promise<ILocalDB> {
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

function loadProperty(name, isTemp: boolean = false): Promise<ILocalDB> {
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
            const db = new DataStore({
                filename: isTemp
                    ? path.join(Constants.NEDB_TEMP_DB, `${name}.yaml`)
                    : path.join(Constants.PROPERTY_DIR, `${name}.toml`),
                indexs: [{ fieldName: "ck_id", unique: true }],
                nameDb: name,
                tempDb: isTemp,
            });
            db.loadDatabase((err) => {
                if (err) {
                    err.message = `Ошибка инициализации ${name}\n${err.message}`;
                    return reject(err);
                }
                db.persistence.setAutocompactionInterval(5000);
                const localDb = new NeDBImpl(name, db, isTemp);
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
    public getConfig(): Promise<ILocalDB> {
        return loadProperty("t_config");
    }
    public getContext(): Promise<ILocalDB> {
        return loadProperty("t_context");
    }
    public getProviders(): Promise<ILocalDB> {
        return loadProperty("t_providers");
    }
    public getPlugins(): Promise<ILocalDB> {
        return loadProperty("t_plugins");
    }
    public getQuery(): Promise<ILocalDB> {
        return loadProperty("t_query");
    }
    public getServers(): Promise<ILocalDB> {
        return loadProperty("t_servers");
    }
    public getEvents(): Promise<ILocalDB> {
        return loadProperty("t_events");
    }
    public getSchedulers(): Promise<ILocalDB> {
        return loadProperty("t_schedulers");
    }
    public getCache(): Promise<ILocalDB> {
        return loadProperty("tt_cache", true);
    }
    public getUsers(): Promise<ILocalDB> {
        return loadProperty("tt_users", true);
    }
    public getSessions(): Promise<ILocalDB> {
        return loadProperty("tt_sessions", true);
    }
}
((global as any) as IGlobalObject).createTempTable = (name) => {
    return loadProperty(name, true);
};
const Property = new BuildProperty();
((global as any) as IGlobalObject).property = Property;
export default Property;
