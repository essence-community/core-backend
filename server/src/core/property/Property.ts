import * as path from "path";
import * as fs from "fs";
import YAML from "js-yaml";
import TOML from "@iarna/toml";
import Constants from "../Constants";
import IContextConfig from "./IContextConfig";
import IEventConfig from "./IEventConfig";
import IShedulerConfig from "./IShedulerConfig";
import IServerConfig from "./IServerConfig";
import IQueryConfig from "./IQueryConfig";
import IPluginConfig from "./IPluginConfig";
import IProviderConfig from "./IProviderConfig";
import {DataSource, ObjectLiteral, Repository} from "typeorm";
import {ContextModel} from "./entities/ContextModel";
import {ProviderModel} from "./entities/ProviderModel";
import {PluginModel} from "./entities/PluginModel";
import {QueryModel} from "./entities/QueryModel";
import {ServerModel} from "./entities/ServerModel";
import {EventModel} from "./entities/EventModel";
import {SchedulerModel} from "./entities/SchedulerModel";
import {TypeOrmLogger} from "@ungate/plugininf/lib/db/TypeOrmLogger";
import {fromContext, fromEvent, fromPlugin, fromProvider, fromQuery, fromScheduler, fromServer, toContext, toEvent, toPlugin, toProvider, toQuery, toScheduler, toServer} from "./map";
import {propertyLoaded, PropertySubscriber} from "./PropertySubscriber";
import {debounce} from "@ungate/plugininf/lib/util/Util";
const LocalProperty: Map<string, Repository<any>> = new Map();

let localDataStore: DataSource | undefined;

export async function getLocalDb<T extends ObjectLiteral>(
    name: string,
): Promise<Repository<T>> {
    if (!LocalProperty.has(name)) {
        return loadProperty(name);
    }
    return LocalProperty.get(name)!;
}

export async function loadProperty<T extends ObjectLiteral>(
    name: string,
    force?: boolean,
): Promise<Repository<T>> {
    if (LocalProperty.has(name)) {
        return LocalProperty.get(name)!;
    }
    if (Constants.LOCAL_DB === "sqlite3") {
        if (!localDataStore) {
            if (!fs.existsSync(Constants.TEMP_DB)) {
                fs.mkdirSync(Constants.TEMP_DB, {recursive: true});
            }
            localDataStore = new DataSource({
                type: "better-sqlite3",
                enableWAL: true,
                database: path.join(Constants.TEMP_DB, `property_gate.sqlite`),
                logging: true,
                synchronize: true,
                logger: new TypeOrmLogger(`Property:config_store`),
                entities: [
                    ContextModel,
                    ProviderModel,
                    PluginModel,
                    QueryModel,
                    ServerModel,
                    EventModel,
                    SchedulerModel,
                ],
                subscribers: [
                    PropertySubscriber,
                ],
                prepareDatabase: (db) => {
                    db.pragma("journal_mode = WAL");
                    db.pragma("busy_timeout = 2000");
                },
            });
            await localDataStore.initialize();
        }
    } else {
        throw new Error(`Неизвестная тип таблицы ${Constants.LOCAL_DB}`);
    }
    let typeFile = "yaml";
    let filename = path.join(Constants.PROPERTY_DIR, `${name}.yaml`);
    if (
        fs.existsSync(
            path.join(Constants.PROPERTY_DIR, `${name}.toml`),
        ) &&
        !fs.existsSync(
            path.join(Constants.PROPERTY_DIR, `${name}.yaml`),
        )
    ) {
        typeFile = "toml";
        filename = path.join(
            Constants.PROPERTY_DIR,
            `${name}.toml`,
        );
    }

    switch (name) {
        case "t_context": {
            const db: Repository<any> = localDataStore.getRepository(ContextModel);
            if (force) {
                const data = typeFile === "yaml" ? await loadYaml<IContextConfig[]>(filename) : await loadToml<IContextConfig[]>(filename);
                await db.save(data.map(item => {
                    if (!item.ck_id) {
                        return null;
                    }
                    return fromContext(item);
                }).filter(Boolean));
            }
            propertyLoaded.context = true;
            LocalProperty.set(name, db);
            return db;
        }
        case "t_providers": {
            const db: Repository<any> = localDataStore.getRepository(ProviderModel);
            if (force) {
                const data = typeFile === "yaml" ? await loadYaml<IProviderConfig[]>(filename) : await loadToml<IProviderConfig[]>(filename);
                await db.save(data.map(item => {
                    if (!item.ck_id) {
                        return null;
                    }
                    return fromProvider(item);
                }).filter(Boolean));
            }
            propertyLoaded.providers = true;
            LocalProperty.set(name, db);
            return db;
        }
        case "t_plugins": {
            const db: Repository<any> = localDataStore.getRepository(PluginModel);
            if (force) {
                const data = typeFile === "yaml" ? await loadYaml<IPluginConfig[]>(filename) : await loadToml<IPluginConfig[]>(filename);
                await db.save(data.map(item => {
                    if (!item.ck_id) {
                        return null;
                    }
                    return fromPlugin(item);
                }).filter(Boolean));
            }
            propertyLoaded.plugins = true;
            LocalProperty.set(name, db);
            return db;
        }
        case "t_query": {
            const db: Repository<any> = localDataStore.getRepository(QueryModel);
            if (force) {
                const data = typeFile === "yaml" ? await loadYaml<IQueryConfig[]>(filename) : await loadToml<IQueryConfig[]>(filename);
                await db.save(data.map(item => {
                    if (!item.ck_id) {
                        return null;
                    }
                    return fromQuery(item);
                }).filter(Boolean));
            }
            propertyLoaded.query = true;
            LocalProperty.set(name, db);
            return db;
        }
        case "t_servers": {
            const db: Repository<any> = localDataStore.getRepository(ServerModel);
            if (force) {
                const data = typeFile === "yaml" ? await loadYaml<IServerConfig[]>(filename) : await loadToml<IServerConfig[]>(filename);
                await db.save(data.map(item => {
                    if (!item.ck_id) {
                        return null;
                    }
                    return fromServer(item);
                }).filter(Boolean));
            }
            propertyLoaded.server = true;
            LocalProperty.set(name, db);
            return db;
        }
        case "t_events": {
            const db: Repository<any> = localDataStore.getRepository(EventModel);
            if (force) {
                const data = typeFile === "yaml" ? await loadYaml<IEventConfig[]>(filename) : await loadToml<IEventConfig[]>(filename);
                await db.save(data.map(item => {
                    if (!item.ck_id) {
                        return null;
                    }
                    return fromEvent(item);
                }).filter(Boolean));
            }
            propertyLoaded.event = true;
            LocalProperty.set(name, db);
            return db;
        }
        case "t_schedulers": {
            const db: Repository<any> = localDataStore.getRepository(SchedulerModel);
            if (force) {
                const data = typeFile === "yaml" ? await loadYaml<IShedulerConfig[]>(filename) : await loadToml<IShedulerConfig[]>(filename);
                await db.save(data.map(item => {
                    if (!item.ck_id) {
                        return null;
                    }
                    return fromScheduler(item);
                }).filter(Boolean));
            }
            propertyLoaded.scheduler = true;
            LocalProperty.set(name, db);
            return db;
        }
        default:
            throw new Error(`Неизвестная таблица: ${name}`);
    }
}

function loadYaml<T>(file: string): Promise<T> {
    return new Promise((resolve, reject) => {
        fs.readFile(file, 'utf8', (err, data) => {
            if (err) {
                return reject(err);
            }
            try {
                resolve(YAML.load(data) as T);
            } catch (err) {
                reject(err);
            }
        });
    });
}

async function loadToml<T>(file: string): Promise<T> {
    return new Promise((resolve, reject) => {
        fs.readFile(file, 'utf8', (err, data) => {
            if (err) {
                return reject(err);
            }
            try {
                const temp = TOML.parse(data);
                resolve(temp.data as T);
            } catch (err) {
                reject(err);
            }
        });
    });
}
class BuildProperty {
    public async reset(): Promise<void> {
        LocalProperty.clear();
        if (localDataStore) {
            await localDataStore.destroy();
        }
        localDataStore = undefined;
        return Promise.resolve();
    }
    public getContext(force: boolean = true): Promise<Repository<ContextModel>> {
        return loadProperty<ContextModel>("t_context", force);
    }
    public getProviders(force: boolean = true): Promise<Repository<ProviderModel>> {
        return loadProperty<ProviderModel>("t_providers", force);
    }
    public getPlugins(force: boolean = true): Promise<Repository<PluginModel>> {
        return loadProperty<PluginModel>("t_plugins", force);
    }
    public getQuery(force: boolean = true): Promise<Repository<QueryModel>> {
        return loadProperty<QueryModel>("t_query", force);
    }
    public getServers(force: boolean = true): Promise<Repository<ServerModel>> {
        return loadProperty<ServerModel>("t_servers", force);
    }
    public getEvents(force: boolean = true): Promise<Repository<EventModel>> {
        return loadProperty<EventModel>("t_events", force);
    }
    public getSchedulers(force: boolean = true): Promise<Repository<SchedulerModel>> {
        return loadProperty<SchedulerModel>("t_schedulers", force);
    }
    public handlers: Record<string, (data?: any) => void> = {
        saveContext: debounce(async () => {
            const context = await this.getContext();
            const contextData = await context.find();
            this.saveProperty("t_context", contextData.map((item) => toContext(item)));
        }, 2000),
        saveProviders: debounce(async () => {
            const providers = await this.getProviders();
            const providersData = await providers.find();
            this.saveProperty("t_providers", providersData.map((item) => toProvider(item)));
        }, 2000),
        savePlugins: debounce(async () => {
            const plugins = await this.getPlugins();
            const pluginsData = await plugins.find();
            this.saveProperty("t_plugins", pluginsData.map((item) => toPlugin(item)));
        }, 2000),
        saveQuery: debounce(async () => {
            const query = await this.getQuery();
            const queryData = await query.find();
            this.saveProperty("t_query", queryData.map((item) => toQuery(item)));
        }, 2000),
        saveServers: debounce(async () => {
            const servers = await this.getServers();
            const serversData = await servers.find();
            this.saveProperty("t_servers", serversData.map((item) => toServer(item)));
        }, 2000),
        saveEvents: debounce(async () => {
            const events = await this.getEvents();
            const eventsData = await events.find();
            this.saveProperty("t_events", eventsData.map((item) => toEvent(item)));
        }, 2000),
        saveSchedulers: debounce(async () => {
            const schedulers = await this.getSchedulers();
            const schedulersData = await schedulers.find();
            this.saveProperty("t_schedulers", schedulersData.map((item) => toScheduler(item)));
        }, 2000),

        savePropertyEntity: async (data: {entity: any, table: string}) => {
            switch (data.table) {
                case "t_context": {
                    const db = await this.getContext();
                    await db.save(fromContext(data.entity as IContextConfig));
                    break;
                }
                case "t_providers": {
                    const db = await this.getProviders();
                    await db.save(fromProvider(data.entity as IProviderConfig));
                    break;
                }
                case "t_plugins": {
                    const db = await this.getPlugins();
                    await db.save(fromPlugin(data.entity as IPluginConfig));
                    break;
                }
                case "t_query": {
                    const db = await this.getQuery();
                    await db.save(fromQuery(data.entity as IQueryConfig));
                    break;
                }
                case "t_servers": {
                    const db = await this.getServers()
                    await db.save(fromServer(data.entity as IServerConfig));
                    break;
                }
                case "t_events": {
                    const db = await this.getEvents()
                    await db.save(fromEvent(data.entity as IEventConfig));
                    break;
                }
                case "t_schedulers": {
                    const db = await this.getSchedulers()
                    await db.save(fromScheduler(data.entity as IShedulerConfig));
                    break;
                }
                default:
                    throw new Error(`Неизвестная таблица: ${data.table}`);
            }
        },
    };

    private saveProperty(name: string, data: any) {
        let typeFile = "yaml";
        let filename = path.join(Constants.PROPERTY_DIR, `${name}.yaml`);
        if (
            fs.existsSync(
                path.join(Constants.PROPERTY_DIR, `${name}.toml`),
            ) &&
            !fs.existsSync(
                path.join(Constants.PROPERTY_DIR, `${name}.yaml`),
            )
        ) {
            typeFile = "toml";
            filename = path.join(
                Constants.PROPERTY_DIR,
                `${name}.toml`,
            );
        }
        if (typeFile === "yaml") {
            return fs.writeFileSync(filename, YAML.dump(data), {
                encoding: "utf8",
            });
        } else {
            return fs.writeFileSync(filename, TOML.stringify({data: data}), {
                encoding: "utf8",
            });
        }
    }
}
const Property = new BuildProperty();
export default Property;
