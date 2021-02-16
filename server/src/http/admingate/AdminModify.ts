import ILocalDB from "@ungate/plugininf/lib/db/local/ILocalDB";
import BreakException from "@ungate/plugininf/lib/errors/BreakException";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import ICCTParams from "@ungate/plugininf/lib/ICCTParams";
import IContext from "@ungate/plugininf/lib/IContext";
import IObjectParam from "@ungate/plugininf/lib/IObjectParam";
import { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import ResultStream from "@ungate/plugininf/lib/stream/ResultStream";
import { isEmpty } from "@ungate/plugininf/lib/util/Util";
import { forEach, isArray, isObject } from "lodash";
import Property from "../../core/property/index";
import RiakAction from "./RiakAction";

const actions = ["i", "u", "d"];
export default class AdminModify {
    public params: ICCTParams;
    public name: string;
    public riakAction: RiakAction;
    modify: Record<string, ILocalDB> = {};
    constructor(name: string, params: ICCTParams) {
        this.name = name;
        this.params = params;
        this.riakAction = new RiakAction(params);
    }

    public async init(): Promise<void> {
        this.modify.dbUsers = await Property.getUsers();
        this.modify.dbContexts = await Property.getContext();
        this.modify.dbEvents = await Property.getEvents();
        this.modify.dbSessions = await Property.getSessions();
        this.modify.dbProviders = await Property.getProviders();
        this.modify.dbSchedulers = await Property.getSchedulers();
        this.modify.dbPlugins = await Property.getPlugins();
        this.modify.dbQuerys = await Property.getQuery();
        this.modify.dbServers = await Property.getServers();
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
        if (this.riakAction[query.queryStr]) {
            return this.riakAction[query.queryStr](gateContext, json);
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

    deepChange(res, data, keyPrefix) {
        forEach(data, (val, key) => {
            if (isObject(val) || Array.isArray(val)) {
                this.deepChange(res, val, `${keyPrefix}.${key}`);
            } else if (
                val !=
                "5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8"
            ) {
                res[`${keyPrefix}.${key}`] = val;
            }
        });
    }

    private async callLocalDb(localDb: ILocalDB, json: IObjectParam) {
        delete json.data.cv_params;
        switch (json.service.cv_action.toLowerCase()) {
            case "i": {
                return localDb.insert(json.data).then(async () => {
                    await (localDb as any).compactDatafile();
                    return [
                        {
                            ck_id: json.data.ck_id,
                            cv_error: null,
                        },
                    ];
                });
            }
            case "u": {
                const ckId = json.data.ck_id;
                if (json.data.cct_params) {
                    this.deepChange(
                        json.data,
                        json.data.cct_params,
                        "cct_params",
                    );
                    delete json.data.cct_params;
                }
                const rec = await localDb.findOne(
                    {
                        ck_id: ckId,
                    },
                    true,
                );
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
                return localDb
                    .update(
                        {
                            ck_id: ckId,
                        },
                        {
                            $set: json.data,
                        },
                    )
                    .then(async () => {
                        await (localDb as any).compactDatafile();
                        return [
                            {
                                ck_id: ckId,
                                cv_error: null,
                            },
                        ];
                    });
            }
            case "d": {
                return localDb
                    .remove({
                        ck_id: json.data.ck_id,
                    })
                    .then(async () => {
                        await (localDb as any).compactDatafile();
                        return [
                            {
                                ck_id: json.data.ck_id,
                                cv_error: null,
                            },
                        ];
                    });
            }
            default:
                return Promise.reject(
                    new ErrorException(-1, "Нет такого обработчика"),
                );
        }
    }
}
