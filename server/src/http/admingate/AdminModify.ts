import BreakException from "@ungate/plugininf/lib/errors/BreakException";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import ICCTParams, {IParamsInfo} from "@ungate/plugininf/lib/ICCTParams";
import IContext from "@ungate/plugininf/lib/IContext";
import IObjectParam from "@ungate/plugininf/lib/IObjectParam";
import {IGateQuery} from "@ungate/plugininf/lib/IQuery";
import ResultStream from "@ungate/plugininf/lib/stream/ResultStream";
import {encryptPassword, isEmpty} from "@ungate/plugininf/lib/util/Util";
import {forEach, isObject} from "lodash";
import Property from "../../core/property/index";
import RiakAction from "./RiakAction";
import PluginManager from "../../core/pluginmanager/index";
import IContextConfig from "../../core/property/IContextConfig";
import IEventConfig from "../../core/property/IEventConfig";
import IProviderConfig from "../../core/property/IProviderConfig";
import IShedulerConfig from "../../core/property/IShedulerConfig";
import IPluginConfig from "../../core/property/IPluginConfig";
import {ObjectLiteral, Repository} from "typeorm";
import {
    fromContext,
    fromEvent,
    fromPlugin,
    fromProvider,
    fromQuery,
    fromScheduler,
    fromServer,
    toContext,
    toEvent,
    toPlugin,
    toProvider,
    toQuery,
    toScheduler,
    toServer,
} from "../../core/property/map";

const actions = ["i", "u", "d"];
const PASSWORD_PLACEHOLDER =
    "5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8";

interface IModifyDb {
    db: Repository<ObjectLiteral>;
    getParamsInfo?: (data: any) => IParamsInfo;
    toDoc: (m: any) => any;
    fromDoc: (d: any) => any;
}
export default class AdminModify {
    public params: ICCTParams;
    public name: string;
    public riakAction: RiakAction;
    modify: Record<string, IModifyDb> = {};
    constructor(name: string, params: ICCTParams) {
        this.name = name;
        this.params = params;
        this.riakAction = new RiakAction(params);
    }

    public async init(): Promise<void> {
        this.modify.dbContexts = {
            db: await Property.getContext(),
            getParamsInfo: (data: IContextConfig) => {
                return PluginManager.getGateContextClass(
                    data.ck_d_plugin,
                ).getParamsInfo();
            },
            toDoc: toContext,
            fromDoc: fromContext,
        };
        this.modify.dbEvents = {
            db: await Property.getEvents(),
            getParamsInfo: (data: IEventConfig) => {
                return PluginManager.getGateEventsClass(
                    data.ck_d_plugin,
                ).getParamsInfo();
            },
            toDoc: toEvent,
            fromDoc: fromEvent,
        };
        this.modify.dbProviders = {
            db: await Property.getProviders(),
            getParamsInfo: (data: IProviderConfig) => {
                return PluginManager.getGateProviderClass(
                    data.ck_d_plugin,
                ).getParamsInfo();
            },
            toDoc: toProvider,
            fromDoc: fromProvider,
        };
        this.modify.dbSchedulers = {
            db: await Property.getSchedulers(),
            getParamsInfo: (data: IShedulerConfig) => {
                return PluginManager.getGateSchedulerClass(
                    data.ck_d_plugin,
                ).getParamsInfo();
            },
            toDoc: toScheduler,
            fromDoc: fromScheduler,
        };
        this.modify.dbPlugins = {
            db: await Property.getPlugins(),
            getParamsInfo: (data: IPluginConfig) => {
                return PluginManager.getGatePluginsClass(
                    data.ck_d_plugin,
                ).getParamsInfo();
            },
            toDoc: toPlugin,
            fromDoc: fromPlugin,
        };
        this.modify.dbQuerys = {
            db: await Property.getQuery(),
            toDoc: toQuery,
            fromDoc: fromQuery,
        };
        this.modify.dbServers = {
            db: await Property.getServers(),
            toDoc: toServer,
            fromDoc: fromServer,
        };
    }

    public async checkModify(
        gateContext: IContext,
        query: IGateQuery,
    ): Promise<IObjectParam[]> {
        if (isEmpty(query.inParams.json) || isEmpty(query.queryStr)) {
            gateContext.warn(
                `Require params isEmpty:\njson: ${query.inParams.json}\nqueryStr: ${query.queryStr}`,
            );
            throw new ErrorException(ErrorGate.JSON_PARSE);
        }
        const json = JSON.parse(query.inParams.json, (key, value) => {
            if (value === null) {
                return undefined;
            }
            return value;
        });
        if (this.riakAction[query.queryStr as keyof RiakAction]) {
            return this.riakAction[query.queryStr as keyof RiakAction](gateContext, json);
        }
        if (actions.includes(json.service.cv_action.toLowerCase())) {
            const localDb = this.modify[query.queryStr];
            if (isEmpty(localDb)) {
                gateContext.warn(`LocalDb not found: ${query.queryStr}`);
                throw new ErrorException(ErrorGate.JSON_PARSE);
            }
            if (
                query.queryStr === "dbPlugins" &&
                json.service.cv_action.toLowerCase() === "i"
            ) {
                json.data.ck_id = `${json.data.cv_name}:${json.data.ck_d_provider}`;
            }
            return this.callLocalDb(localDb, json) as any;
        }

        return [];
    }

    deepPassword(data: any, conf?: IParamsInfo) {
        forEach(data, (val, key) => {
            const confChild = Array.isArray(data) ? conf : conf?.[key];
            if (isObject(val) || Array.isArray(val)) {
                this.deepPassword(val, (conf?.[key] as any)?.childs);
            } else if (confChild && confChild.type === "password") {
                if (val !== PASSWORD_PLACEHOLDER) {
                    data[key] = encryptPassword(val);
                }
            }
        });
    }

    private async callLocalDb(
        {db, getParamsInfo, toDoc, fromDoc}: IModifyDb,
        json: IObjectParam,
    ) {
        delete json.data.cv_params;
        switch (json.service.cv_action.toLowerCase()) {
            case "i": {
                if (getParamsInfo || json.data.cct_params) {
                    this.deepPassword(
                        json.data.cct_params,
                        getParamsInfo?.(json.data),
                    );
                }
                await db.save(fromDoc(json.data));
                return [
                    {
                        ck_id: json.data.ck_id,
                        cv_error: null,
                    },
                ];
            }
            case "u": {
                const ckId = json.service.value_key || json.data.ck_id;
                const rec = await db.findOne({
                    where: {id: ckId},
                });
                if (!rec) {
                    throw new BreakException({
                        data: ResultStream([
                            {
                                ck_id: "",
                                cv_error: {
                                    519: [],
                                },
                            },
                        ]),
                        type: "success",
                    });
                }
                const doc = toDoc(rec);
                const {cct_params: incomingParams, ...rest} = json.data;
                const merged = {...doc, ...rest, ck_id: ckId};
                if (incomingParams) {
                    merged.cct_params = {...(doc.cct_params || {})};
                    if (getParamsInfo) {
                        this.mergeParams(
                            merged.cct_params,
                            incomingParams,
                            getParamsInfo(merged),
                        );
                    } else {
                        Object.assign(merged.cct_params, incomingParams);
                    }
                }
                await db.update(ckId, fromDoc(merged));
                return [
                    {
                        ck_id: ckId,
                        cv_error: null,
                    },
                ];
            }
            case "d": {
                await db.delete({id: json.data.ck_id});
                return [
                    {
                        ck_id: json.data.ck_id,
                        cv_error: null,
                    },
                ];
            }
            default:
                return Promise.reject(
                    new ErrorException(-1, "Нет такого обработчика"),
                );
        }
    }

    private mergeParams(target: any, source: any, conf: IParamsInfo) {
        forEach(source, (val, key) => {
            const confChild = Array.isArray(source) ? conf : conf?.[key];
            if (isObject(val) || Array.isArray(val)) {
                if (target[key] == null) {
                    target[key] = Array.isArray(val) ? [] : {};
                }
                this.mergeParams(
                    target[key],
                    val,
                    (confChild as any)?.childs ?? confChild,
                );
            } else if (val === PASSWORD_PLACEHOLDER) {
                return;
            } else if (confChild && (confChild as any).type === "password") {
                target[key] = encryptPassword(val);
            } else {
                target[key] = val;
            }
        });
    }
}
