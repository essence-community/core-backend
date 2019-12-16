import ILocalDB from "@ungate/plugininf/lib/db/local/ILocalDB";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import ICCTParams from "@ungate/plugininf/lib/ICCTParams";
import IContext from "@ungate/plugininf/lib/IContext";
import IObjectParam from "@ungate/plugininf/lib/IObjectParam";
import { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import { isEmpty } from "@ungate/plugininf/lib/util/Util";
import { forEach, isArray } from "lodash";
import Property from "../../core/property/index";
import RiakAction from "./RiakAction";

const actions = ["i", "u", "d"];
export default class AdminModify {
    public params: ICCTParams;
    public name: string;
    public riakAction: RiakAction;
    public dbUsers: ILocalDB;
    public dbContexts: ILocalDB;
    public dbEvents: ILocalDB;
    public dbSessions: ILocalDB;
    public dbProviders: ILocalDB;
    public dbSchedulers: ILocalDB;
    public dbPlugins: ILocalDB;
    public dbQuerys: ILocalDB;
    public dbServers: ILocalDB;
    constructor(name: string, params: ICCTParams) {
        this.name = name;
        this.params = params;
        this.riakAction = new RiakAction(params);
    }

    public async init(): Promise<void> {
        this.dbUsers = await Property.getUsers();
        this.dbContexts = await Property.getContext();
        this.dbEvents = await Property.getEvents();
        this.dbSessions = await Property.getSessions();
        this.dbProviders = await Property.getProviders();
        this.dbSchedulers = await Property.getSchedulers();
        this.dbPlugins = await Property.getPlugins();
        this.dbQuerys = await Property.getQuery();
        this.dbServers = await Property.getServers();
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
            const localDb = this[query.queryStr];
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

    private callLocalDb(localDb: ILocalDB, json: IObjectParam) {
        if (json.data.cct_params) {
            const cctParams = json.data.cct_params;
            json.data.cct_params = {};
            (isArray(cctParams)
                ? cctParams
                : Object.values(cctParams || {})
            ).forEach((val: any) => {
                if (!isEmpty(val.value)) {
                    switch (val.datatype) {
                        case "text": {
                            json.data.cct_params[val.column] = val.value;
                            break;
                        }
                        case "integer": {
                            json.data.cct_params[val.column] = parseInt(
                                val.value,
                                10,
                            );
                            break;
                        }
                        case "checkbox": {
                            json.data.cct_params[val.column] = !!val.value;
                            break;
                        }
                        case "combo": {
                            if (val.value === "true" || val.value === "false") {
                                json.data.cct_params[val.column] =
                                    val.value === "true";
                            } else {
                                json.data.cct_params[val.column] = val.value;
                            }
                            break;
                        }
                        case "password": {
                            if (
                                val.value !==
                                "5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8"
                            ) {
                                json.data.cct_params[val.column] = val.value;
                            }
                            break;
                        }
                        default: {
                            json.data.cct_params[val.column] = val.value;
                            break;
                        }
                    }
                } else if (json.service.cv_action.toLowerCase() === "u") {
                    json.data.cct_params[val.column] = undefined;
                }
            });
        }
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
                    forEach(json.data.cct_params, (val, key) => {
                        json.data[`cct_params.${key}`] = val;
                    });
                    delete json.data.cct_params;
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
