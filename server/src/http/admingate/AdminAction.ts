import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import ICCTParams, {
    IParamInfo,
    IParamsInfo,
} from "@ungate/plugininf/lib/ICCTParams";
import IContext from "@ungate/plugininf/lib/IContext";
import {
    filterFilesData,
    isEmpty,
    sortFilesData,
} from "@ungate/plugininf/lib/util/Util";
import {isObject} from "lodash";
import {v4 as uuidv4} from "uuid";
import PluginManager from "../../core/pluginmanager/PluginManager";
import Property from "../../core/property/Property";
import resetAction from "./ResetAction";
import RiakAction from "./RiakAction";
import NullProvider from "@ungate/plugininf/lib/NullProvider";
import NullContext from "@ungate/plugininf/lib/NullContext";
import NullPlugin from "@ungate/plugininf/lib/NullPlugin";
import NullScheduler from "@ungate/plugininf/lib/NullScheduler";
import NullEvent from "@ungate/plugininf/lib/NullEvent";
import NullSessProvider from "@ungate/plugininf/lib/NullSessProvider";
import {ContextModel} from "../../core/property/entities/ContextModel";
import {Repository} from "typeorm";
import {EventModel} from "../../core/property/entities/EventModel";
import {ProviderModel} from "../../core/property/entities/ProviderModel";
import {SchedulerModel} from "../../core/property/entities/SchedulerModel";
import {QueryModel} from "../../core/property/entities/QueryModel";
import {PluginModel} from "../../core/property/entities/PluginModel";
import {ServerModel} from "../../core/property/entities/ServerModel";
import {
    toContext,
    toEvent,
    toPlugin,
    toProvider,
    toQuery,
    toScheduler,
    toServer,
} from "../../core/property/map";

export default class AdminAction {
    public params: ICCTParams;
    public name: string;
    public riakAction: RiakAction;
    public contextStore!: Repository<ContextModel>;
    public eventStore!: Repository<EventModel>;
    public providerStore!: Repository<ProviderModel>;
    public schedulerStore!: Repository<SchedulerModel>;
    public pluginStore!: Repository<PluginModel>;
    public queryStore!: Repository<QueryModel>;
    public serverStore!: Repository<ServerModel>;
    constructor(name: string, params: ICCTParams) {
        this.name = name;
        this.params = params;
        this.riakAction = new RiakAction(params);
    }

    public async init(): Promise<void> {
        this.contextStore = await Property.getContext();
        this.eventStore = await Property.getEvents();
        this.providerStore = await Property.getProviders();
        this.schedulerStore = await Property.getSchedulers();
        this.pluginStore = await Property.getPlugins();
        this.queryStore = await Property.getQuery();
        this.serverStore = await Property.getServers();
    }
    /* tslint:disable:object-literal-sort-keys */
    public get handlers() {
        return {
            gtresetdefaultconfig: (gateContext: IContext) =>
                gateContext.gateContextPlugin.init(true).then(() =>
                    Promise.resolve([
                        {
                            ck_id: undefined,
                            cv_error: null,
                        },
                    ]),
                ),
            gtrestartgate: (gateContext: IContext) =>
                resetAction(
                    gateContext,
                    "ck_id",
                    "restartCluster",
                    "master",
                    "ck_id",
                ),
            gtrestartfullgate: (gateContext: IContext) =>
                resetAction(
                    gateContext,
                    "ck_id",
                    "restartAll",
                    "master",
                    "ck_id",
                ),
            gtgetusers: (gateContext: IContext) =>
                gateContext.gateContextPlugin.sessCtrl
                    .getUserStore()
                    .find()
                    .then((docs) =>
                        Promise.resolve(
                            docs
                                .map((val) => ({
                                    ck_id: val.id,
                                    ck_d_provider: val.provider,
                                    cv_login: val.login,
                                    ...Object.entries(val.data || {}).reduce(
                                        (obj, arr) => ({
                                            ...obj,
                                            [`data_${arr[0]}`]: arr[1],
                                        }),
                                        {},
                                    ),
                                    cv_actions:
                                        val.data && val.data.ca_actions
                                            ? val.data.ca_actions.join(", ")
                                            : "",
                                    cv_departments:
                                        val.data && val.data.ca_department
                                            ? val.data.ca_department.join(", ")
                                            : "",
                                }))
                                .sort(sortFilesData(gateContext))
                                .filter(filterFilesData(gateContext)),
                        ),
                    ),
            gtgetsessions: (gateContext: IContext) =>
                this.contextStore.find().then((docs) =>
                    docs.map((val) => PluginManager.getGateContext(val.id))
                )
                    .then((context) => Promise.all(context.map((val) => val.sessCtrl.getSessionStore().find({
                        take: 100,
                        skip: 0,
                        order: {
                            create: "DESC",
                        },
                    }))))
                    .then((sessions) => sessions.flat().map((val) => ({
                        id: val.id,
                        ...val.data?.gsession?.userData || {},
                    }))
                        .sort(sortFilesData(gateContext))
                        .filter(filterFilesData(gateContext))
                        .slice(0, 20),
                    ),
            gtgetservers: (gateContext: IContext) =>
                this.serverStore
                    .find()
                    .then((docs) =>
                        Promise.resolve(
                            docs
                                .map(toServer)
                                .sort(sortFilesData(gateContext))
                                .filter(filterFilesData(gateContext)),
                        ),
                    ),
            gtgetconfproviders: (gateContext: IContext) => {
                const json = JSON.parse(
                    gateContext.query.inParams.json,
                    (key, value) => {
                        if (value === null) {
                            return undefined;
                        }
                        return value;
                    },
                );
                return this.providerStore.find().then((rows) =>
                    (
                        [
                            ...(json?.filter?.g_providers_add_all === "all"
                                ? [
                                    {
                                        ck_id: "all",
                                    },
                                ]
                                : []),
                            ...rows.map(toProvider),
                        ] as any
                    )
                        .map((val: any) =>
                            json?.filter?.g_providers_add_all === "all"
                                ? {ck_id: val.ck_id}
                                : {
                                    ...val,
                                    cv_params: this.ParamsToString(
                                        PluginManager.getGateProviderClass,
                                        val.ck_d_plugin,
                                        val.cct_params,
                                    ),
                                    cct_params: undefined,
                                    ck_d_plugin:
                                        val.ck_d_plugin.toLowerCase(),
                                },
                        )
                        .sort(sortFilesData(gateContext))
                        .filter(filterFilesData(gateContext)),
                );
            },
            gtgetinitedproviders: (gateContext: IContext) =>
                this.providerStore.find().then((docs) =>
                    Promise.resolve(
                        [{ck_id: "all"}, ...docs.map(toProvider)]
                            .map((val) => ({
                                ck_id: val.ck_id,
                            }))
                            .sort(sortFilesData(gateContext))
                            .filter(filterFilesData(gateContext)),
                    ),
                ),
            gtgetevent: (gateContext: IContext) =>
                this.eventStore.find().then((docs) =>
                    Promise.resolve(
                        docs
                            .map(toEvent)
                            .map((val) => ({
                                ...val,
                                cv_params: this.ParamsToString(
                                    PluginManager.getGateEventsClass,
                                    val.ck_d_plugin,
                                    val.cct_params,
                                ),
                                cct_params: undefined,
                                ck_d_plugin: val.ck_d_plugin.toLowerCase(),
                            }))
                            .sort(sortFilesData(gateContext))
                            .filter(filterFilesData(gateContext)),
                    ),
                ),
            gtgetconfigs: (gateContext: IContext) =>
                this.contextStore.find().then((docs) =>
                    Promise.resolve(
                        docs
                            .map(toContext)
                            .map((val) => ({
                                ...val,
                                cv_params: this.ParamsToString(
                                    PluginManager.getGateContextClass,
                                    val.ck_d_plugin,
                                    val.cct_params,
                                ),
                                cct_params: undefined,
                                ck_d_plugin: val.ck_d_plugin.toLowerCase(),
                            }))
                            .sort(sortFilesData(gateContext))
                            .filter(filterFilesData(gateContext)),
                    ),
                ),
            gtgetconfplugins: (gateContext: IContext) =>
                this.pluginStore.find().then((docs) =>
                    Promise.resolve(
                        docs
                            .map(toPlugin)
                            .map((val) => ({
                                ...val,
                                cv_params: this.ParamsToString(
                                    PluginManager.getGatePluginsClass,
                                    val.ck_d_plugin,
                                    val.cct_params,
                                ),
                                cct_params: undefined,
                                ck_d_plugin: val.ck_d_plugin.toLowerCase(),
                            }))
                            .sort(sortFilesData(gateContext))
                            .filter(filterFilesData(gateContext)),
                    ),
                ),
            gtgetconfquery: (gateContext: IContext) =>
                this.queryStore.find().then((docs) =>
                    Promise.resolve(
                        docs
                            .map(toQuery)
                            .map((val) => ({
                                ...val,
                            }))
                            .sort(sortFilesData(gateContext))
                            .filter(filterFilesData(gateContext)),
                    ),
                ),
            gtgetschedulers: (gateContext: IContext) =>
                this.schedulerStore.find().then((docs) =>
                    Promise.resolve(
                        docs
                            .map(toScheduler)
                            .map((val) => ({
                                ...val,
                                cv_params: this.ParamsToString(
                                    PluginManager.getGateSchedulerClass,
                                    val.ck_d_plugin,
                                    val.cct_params,
                                ),
                                cct_params: undefined,
                                ck_d_plugin: val.ck_d_plugin.toLowerCase(),
                            }))
                            .sort(sortFilesData(gateContext))
                            .filter(filterFilesData(gateContext)),
                    ),
                ),
            gtgetpluginsclass: (gateContext: IContext) =>
                Promise.resolve(
                    PluginManager.getGateAllPluginsClass()
                        .map((val) => ({ck_id: val}))
                        .sort(sortFilesData(gateContext))
                        .filter(filterFilesData(gateContext)),
                ),
            gtgetprovidersclass: (gateContext: IContext) =>
                Promise.resolve(
                    PluginManager.getGateAllProvidersClass()
                        .map((val) => ({ck_id: val}))
                        .sort(sortFilesData(gateContext))
                        .filter(filterFilesData(gateContext)),
                ),
            gtgetconfigclass: (gateContext: IContext) =>
                Promise.resolve(
                    PluginManager.getGateAllContextClass()
                        .map((val) => ({ck_id: val}))
                        .sort(sortFilesData(gateContext))
                        .filter(filterFilesData(gateContext)),
                ),
            gtgetschedulerclass: (gateContext: IContext) =>
                Promise.resolve(
                    PluginManager.getGateAllSchedulersClass()
                        .map((val) => ({ck_id: val}))
                        .sort(sortFilesData(gateContext))
                        .filter(filterFilesData(gateContext)),
                ),
            gtgeteventclass: (gateContext: IContext) =>
                Promise.resolve(
                    PluginManager.getGateAllEventsClass()
                        .map((val) => ({ck_id: val}))
                        .sort(sortFilesData(gateContext))
                        .filter(filterFilesData(gateContext)),
                ),
            gtreloadpluginsclass: (gateContext: IContext) =>
                resetAction(
                    gateContext,
                    "ck_id",
                    "resetPluginClass",
                    "cluster",
                ),
            gtreloadprovidersclass: (gateContext: IContext) =>
                resetAction(
                    gateContext,
                    "ck_id",
                    "resetProviderClass",
                    "cluster",
                ),
            gtreloadconfigclass: (gateContext: IContext) =>
                resetAction(
                    gateContext,
                    "ck_id",
                    "resetContextClass",
                    "cluster",
                ),
            gtresetprovider: (gateContext: IContext) =>
                resetAction(gateContext, "ck_id", "reloadProvider", "cluster"),
            gtresetallprovider: (gateContext: IContext) =>
                resetAction(
                    gateContext,
                    "ck_id",
                    "reloadAllProvider",
                    "cluster",
                ),
            gtresetconfig: (gateContext: IContext) =>
                resetAction(gateContext, "ck_id", "reloadContext", "cluster"),
            gtresetallconfig: (gateContext: IContext) =>
                resetAction(
                    gateContext,
                    "ck_id",
                    "reloadAllContext",
                    "cluster",
                ),
            gtresetscheduler: (gateContext: IContext) =>
                resetAction(
                    gateContext,
                    "ck_id",
                    "reloadScheduler",
                    "schedulerNode",
                ),
            gtresetallscheduler: (gateContext: IContext) =>
                resetAction(
                    gateContext,
                    "ck_id",
                    "reloadAllScheduler",
                    "schedulerNode",
                ),
            gtgetriakbuckets: (...arg: any[]) =>
                this.riakAction.gtgetriakbuckets.apply(
                    this.riakAction,
                    arg as any,
                ),
            gtgetriakfiles: (gateContext: IContext) =>
                this.riakAction.loadRiakFiles(gateContext),
            gtgetriakfileinfo: (gateContext: IContext) =>
                this.riakAction.loadRiakFileInfo(gateContext),
            gtdownloadriakfile: (gateContext: IContext) =>
                this.riakAction.downloadRiakFile(gateContext),
            gtgetprovidersetting: (gateContext: IContext) =>
                this.loadSetting(
                    gateContext,
                    "ck_id",
                    PluginManager.getGateProviderClass,
                    this.providerStore,
                    (pkClass) =>
                        pkClass.isAuth
                            ? NullSessProvider.getParamsInfo
                            : NullProvider.getParamsInfo,
                ),
            gtgetcontextsetting: (gateContext: IContext) =>
                this.loadSetting(
                    gateContext,
                    "ck_id",
                    PluginManager.getGateContextClass,
                    this.contextStore,
                    () => NullContext.getParamsInfo,
                ),
            gtgetpluginsetting: (gateContext: IContext) =>
                this.loadSetting(
                    gateContext,
                    "ck_id",
                    PluginManager.getGatePluginsClass,
                    this.pluginStore,
                    () => NullPlugin.getParamsInfo,
                ),
            gtgetschedulersetting: (gateContext: IContext) =>
                this.loadSetting(
                    gateContext,
                    "ck_id",
                    PluginManager.getGateSchedulerClass,
                    this.schedulerStore,
                    () => NullScheduler.getParamsInfo,
                ),
            gtgeteventsetting: (gateContext: IContext) =>
                this.loadSetting(
                    gateContext,
                    "ck_id",
                    PluginManager.getGateEventsClass,
                    this.eventStore,
                    () => NullEvent.getParamsInfo,
                ),
            gtgetboolean: () =>
                Promise.resolve([
                    {
                        ck_id: true,
                    },
                    {
                        ck_id: false,
                    },
                ]),
        };
    }

    public ParamsToString(method: any, ckDPlugin: string, cctParams = {}) {
        const PClass = method(ckDPlugin.toLowerCase());
        let params = {} as Record<string, IParamInfo>;
        if (PClass && PClass.getParamsInfo) {
            params = PClass.getParamsInfo();
        }
        return Object.entries(cctParams).reduce((str, [key, value]) => {
            if (params[key] && (params[key] as IParamInfo).type === "password") {
                return `${str}${key}=***<br/>`;
            }
            return `${str}${key}=${isObject(value) ? JSON.stringify(value) : value}
                }<br/>`;
        }, "");
    }
    /**
     * Загрузка меню настроек
     * @param gateContext
     * @param method
     * @param db
     * @returns
     */
    public async loadSetting(
        gateContext: IContext,
        column: string,
        method: (ckDPlugin: string) => any,
        db: Repository<any>,
        getParamsInfo: (pklass: any) => () => IParamsInfo,
    ): Promise<Record<string, any>[]> {
        if (isEmpty(gateContext.query.inParams.json)) {
            throw new ErrorException(ErrorGate.JSON_PARSE);
        }
        const json = JSON.parse(
            gateContext.query.inParams.json,
            (key, value) => {
                if (value === null) {
                    return undefined;
                }
                return value;
            },
        );
        if (isEmpty(json.master.ck_id)) {
            return [];
        }
        const PClass = method(json.master.ck_id);
        if (PClass && PClass.getParamsInfo) {
            const params = PClass.getParamsInfo();
            const doc = await (json.filter.cv_name
                ? db.findOne({
                    where: {id: json.filter.cv_name},
                })
                : Promise.resolve(null));
            Object.entries(getParamsInfo(PClass)()).forEach(([key, value]) => {
                if (!Object.prototype.hasOwnProperty.call(params, key)) {
                    params[key] = value;
                }
            });
            const cctParams = doc?.params || {};
            const cctParam = Object.entries(params).reduce(
                (res, [key, obj]) => {
                    res[key] = this.checkData(
                        key,
                        obj as IParamInfo,
                        cctParams || (obj as IParamInfo).defaultValue,
                    );
                    return res;
                },
                {} as Record<string, any>,
            );
            return [
                {
                    childs: Object.entries(params)
                        .map(([key, obj]) =>
                            this.createFields(
                                gateContext,
                                key,
                                json.filter.ck_page,
                                (json.filter.ca_childs || [])[0],
                                obj as IParamInfo,
                                doc?.params,
                            ),
                        )
                        .filter((val) => !isEmpty(val)),
                    ck_page: json.filter.ck_page,
                    ck_page_object: uuidv4(),
                    initvalue: cctParam,
                    defaultvalue: cctParam,
                    column: "cct_params",
                    contentview: "vbox",
                    type: "FORM_NESTED",
                },
            ];
        }
        return Promise.resolve([]);
    }

    private checkData(name: string, conf: IParamInfo, params = {} as Record<string, any>) {
        switch (conf.type) {
            case "string":
            case "long_string": {
                return isObject(params[name])
                    ? JSON.stringify(params[name])
                    : isEmpty(params[name])
                        ? conf.defaultValue
                        : params[name];
            }
            case "form_nested": {
                return Object.entries(conf.childs).reduce((res, [key, obj]) => {
                    res[key] = this.checkData(
                        key,
                        obj as IParamInfo,
                        isEmpty(params[name])
                            ? conf.defaultValue
                            : params[name],
                    );
                    return res;
                }, {} as Record<string, any>);
            }
            case "form_repeater": {
                return (params[name] || conf.defaultValue || []).map((val: any) => {
                    return Object.entries(conf.childs).reduce(
                        (res, [key, obj]) => {
                            res[key] = this.checkData(
                                key,
                                obj as IParamInfo,
                                isEmpty(val) ? obj.defaultValue : val,
                            );
                            return res;
                        },
                        {} as Record<string, any>,
                    );
                });
            }
            case "password": {
                return isEmpty(params[name])
                    ? ""
                    : "5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8";
            }
            case "integer": {
                return isEmpty(params[name]) ? conf.defaultValue : params[name];
            }
            case "boolean": {
                const defaultValue = conf.defaultValue
                    ? +conf.defaultValue
                    : undefined;
                const value = isEmpty(params[name])
                    ? 0
                    : +(typeof params[name] === "string"
                        ? params[name] === "1" ||
                        params[name] === "true" ||
                        params[name] === "yes" ||
                        params[name] === "on"
                        : params[name]);
                if (isEmpty(conf.defaultValue)) {
                    return isEmpty(params[name]) ? defaultValue : value;
                }
                return +(isEmpty(params[name]) ? defaultValue || 0 : value);
            }
            case "combo": {
                return isEmpty(params[name]) ? conf.defaultValue : params[name];
            }
            default: {
                return isEmpty(params[name]) ? conf.defaultValue : params[name];
            }
        }
    }
    /**
     * Создаем поля ввода
     * @param gateContext
     * @param name
     * @param ckPage
     * @param [child]
     * @param conf
     * @param [params]
     * @returns
     */
    public createFields(
        gateContext: IContext,
        name: string,
        ckPage: number | string,
        child = {
            ck_page_object: uuidv4(),
        } as Record<string, any>,
        conf: IParamInfo,
        params = {} as Record<string, any>,
    ): Record<string, any> {
        /* tslint:disable:object-literal-sort-keys */
        const defaultAttr = {
            ck_page: ckPage,
            ck_page_object: uuidv4(),
            setglobal: conf.setGlobal,
            getglobal: conf.getGlobal,
            hiddenrules: conf.hiddenRules,
            disabledrules: conf.disabledRules,
            column: name,
            disabled: conf.disabled || false,
            hidden: conf.hidden || false,
            cv_displayed: conf.name,
            info: conf.description,
            required: conf.required || false,
        };
        switch (conf.type) {
            case "string": {
                return {
                    ...defaultAttr,
                    datatype: "text",
                    initvalue: isObject(params[name])
                        ? JSON.stringify(params[name])
                        : isEmpty(params[name])
                            ? conf.defaultValue
                            : params[name],
                    defaultvalue: isObject(params[name])
                        ? JSON.stringify(params[name])
                        : isEmpty(params[name])
                            ? conf.defaultValue
                            : params[name],
                    type: "IFIELD",
                };
            }
            case "form_nested": {
                return {
                    ...defaultAttr,
                    childs: Object.entries(conf.childs).map(([key, obj]) =>
                        this.createFields(
                            gateContext,
                            key,
                            ckPage,
                            child,
                            obj,
                            params[name] || {},
                        ),
                    ),
                    type: "FORM_NESTED",
                };
            }
            case "form_repeater": {
                return {
                    ...defaultAttr,
                    childs: Object.entries(conf.childs).map(([key, obj]) =>
                        this.createFields(
                            gateContext,
                            key,
                            ckPage,
                            child,
                            obj,
                            params[name] || {},
                        ),
                    ),
                    datatype: "repeater",
                    type: "IFIELD",
                };
            }
            case "long_string": {
                return {
                    ...defaultAttr,
                    datatype: "textarea",
                    initvalue: isObject(params[name])
                        ? JSON.stringify(params[name])
                        : isEmpty(params[name])
                            ? conf.defaultValue
                            : params[name],
                    defaultvalue: isObject(params[name])
                        ? JSON.stringify(params[name])
                        : isEmpty(params[name])
                            ? conf.defaultValue
                            : params[name],
                    type: "IFIELD",
                };
            }
            case "password": {
                return {
                    ...defaultAttr,
                    datatype: "password",
                    initvalue: isEmpty(params[name])
                        ? ""
                        : "5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8",
                    defaultvalue: isEmpty(params[name])
                        ? ""
                        : "5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8",
                    type: "IFIELD",
                };
            }
            case "integer": {
                return {
                    ...defaultAttr,
                    datatype: "integer",
                    maxvalue: conf.maxValue,
                    minvalue: conf.minValue,
                    initvalue: isEmpty(params[name])
                        ? conf.defaultValue
                        : params[name],
                    defaultvalue: isEmpty(params[name])
                        ? conf.defaultValue
                        : params[name],
                    type: "IFIELD",
                };
            }
            case "boolean": {
                const defaultValue = conf.defaultValue
                    ? +conf.defaultValue
                    : undefined;
                const value = isEmpty(params[name])
                    ? 0
                    : +(typeof params[name] === "string"
                        ? params[name] === "1" ||
                        params[name] === "true" ||
                        params[name] === "yes" ||
                        params[name] === "on"
                        : params[name]);
                if (isEmpty(conf.defaultValue)) {
                    return {
                        ...defaultAttr,
                        autoload: "true",
                        ck_page_object: child.ck_page_object,
                        cl_dataset: 1,
                        datatype: "combo",
                        initvalue: isEmpty(params[name]) ? defaultValue : value,
                        defaultvalue: isEmpty(params[name])
                            ? defaultValue
                            : value,
                        displayfield: "cv_name",
                        type: "IFIELD",
                        localization: "static",
                        records: [
                            {
                                ck_id: 1,
                                cv_name: "dacf7ab025c344cb81b700cfcc50e403",
                            },
                            {
                                ck_id: 0,
                                cv_name: "f0e9877df106481eb257c2c04f8eb039",
                            },
                        ],
                        valuefield: [{in: "ck_id"}],
                    };
                }
                return {
                    ...defaultAttr,
                    datatype: "checkbox",
                    initvalue: +(isEmpty(params[name])
                        ? defaultValue || 0
                        : value),
                    defaultvalue: +(isEmpty(params[name])
                        ? defaultValue || 0
                        : value),
                    type: "IFIELD",
                };
            }
            case "combo": {
                return {
                    ...defaultAttr,
                    autoload: "true",
                    ck_page_object: child.ck_page_object,
                    ck_query: conf.query,
                    getglobaltostore: conf.getGlobalToStore,
                    cl_dataset: 1,
                    datatype: "combo",
                    idproperty: conf.idproperty || "ck_id",
                    initvalue: isEmpty(params[name])
                        ? conf.defaultValue
                        : params[name],
                    defaultvalue: isEmpty(params[name])
                        ? conf.defaultValue
                        : params[name],
                    displayfield: conf.displayField,
                    type: "IFIELD",
                    valuefield: conf.valueField,
                    querymode: conf.querymode,
                    queryparam: conf.queryparam,
                    allownew: conf.allownew,
                    pagesize: conf.pagesize,
                    records: conf.records,
                };
            }
            default: {
                gateContext.warn(name, conf.type);
                return {} as Record<string, any>;
            }
        }
        /* tslint:enable:object-literal-sort-keys */
    }
}
