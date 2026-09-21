import IContextConfig from "./IContextConfig";
import IEventConfig from "./IEventConfig";
import IPluginConfig from "./IPluginConfig";
import IProviderConfig from "./IProviderConfig";
import IQueryConfig from "./IQueryConfig";
import IServerConfig from "./IServerConfig";
import IShedulerConfig from "./IShedulerConfig";
import {ContextModel} from "./entities/ContextModel";
import {EventModel} from "./entities/EventModel";
import {PluginModel} from "./entities/PluginModel";
import {ProviderModel} from "./entities/ProviderModel";
import {QueryModel} from "./entities/QueryModel";
import {SchedulerModel} from "./entities/SchedulerModel";
import {ServerModel} from "./entities/ServerModel";

export function toContext(m: ContextModel): IContextConfig {
    return {
        ck_id: m.id,
        cv_path: m.path,
        ck_d_plugin: m.plugin,
        cv_description: m.description,
        cct_params: m.params,
    };
}

export function fromContext(d: IContextConfig): ContextModel {
    const m = new ContextModel();
    m.id = d.ck_id;
    m.path = d.cv_path;
    m.plugin = d.ck_d_plugin;
    m.description = d.cv_description;
    m.params = d.cct_params;
    return m;
}

export function toProvider(m: ProviderModel): IProviderConfig {
    return {
        ck_id: m.id,
        cv_description: m.description,
        cl_autoload: m.autoload,
        ck_d_plugin: m.plugin,
        ck_context: m.context,
        cct_params: m.params,
    };
}

export function fromProvider(d: IProviderConfig): ProviderModel {
    const m = new ProviderModel();
    m.id = d.ck_id;
    m.description = d.cv_description;
    m.autoload = Boolean(d.cl_autoload);
    m.plugin = d.ck_d_plugin;
    m.context = d.ck_context;
    m.params = d.cct_params;
    return m;
}

export function toPlugin(m: PluginModel): IPluginConfig {
    return {
        ck_id: m.id,
        cv_name: m.name,
        ck_context: m.context,
        ck_d_provider: m.provider,
        cv_description: m.description,
        ck_d_plugin: m.plugin,
        cl_required: m.isRequired ? 1 : 0,
        cl_default: m.isDefault ? 1 : 0,
        cn_order: m.order,
        cct_params: m.params,
    };
}

export function fromPlugin(d: IPluginConfig): PluginModel {
    const m = new PluginModel();
    m.id = d.ck_id;
    m.name = d.cv_name;
    m.context = d.ck_context;
    m.provider = d.ck_d_provider ?? "all";
    m.description = d.cv_description;
    m.plugin = d.ck_d_plugin;
    m.isRequired = Boolean(d.cl_required);
    m.isDefault = Boolean(d.cl_default);
    m.order = d.cn_order;
    m.params = d.cct_params;
    return m;
}

export function toQuery(m: QueryModel): IQueryConfig {
    return {
        ck_id: m.id,
        cv_name: m.name,
        ck_d_context: m.context,
        ck_d_provider: m.provider,
        cv_text: m.text,
        cv_description: m.description,
        cct_inParams: m.inParams,
        cct_outParams: m.outParams,
    };
}

export function fromQuery(d: IQueryConfig): QueryModel {
    const m = new QueryModel();
    m.id = d.ck_id;
    m.name = d.cv_name;
    m.context = d.ck_d_context;
    m.provider = d.ck_d_provider;
    m.text = d.cv_text;
    m.description = d.cv_description;
    m.inParams = d.cct_inParams;
    m.outParams = d.cct_outParams;
    return m;
}

export function toEvent(m: EventModel): IEventConfig {
    return {
        ck_id: m.id,
        cv_description: m.description,
        ck_d_plugin: m.plugin,
        cct_params: m.params,
    };
}

export function fromEvent(d: IEventConfig): EventModel {
    const m = new EventModel();
    m.id = d.ck_id;
    m.description = d.cv_description;
    m.plugin = d.ck_d_plugin;
    m.params = d.cct_params;
    return m;
}

export function toScheduler(m: SchedulerModel): IShedulerConfig {
    return {
        ck_id: m.id,
        cv_description: m.description,
        cl_enable: m.isEnabled ? 1 : 0,
        ck_d_plugin: m.plugin,
        cv_cron: m.cron,
        cct_params: m.params,
    };
}

export function fromScheduler(d: IShedulerConfig): SchedulerModel {
    const m = new SchedulerModel();
    m.id = d.ck_id;
    m.description = d.cv_description;
    m.isEnabled = Boolean(d.cl_enable);
    m.plugin = d.ck_d_plugin;
    m.cron = d.cv_cron;
    m.params = d.cct_params;
    return m;
}

export function toServer(m: ServerModel): IServerConfig {
    return {
        ck_id: m.id,
        cv_description: m.description,
        cv_ip: m.ip,
        cn_port: m.port,
    };
}

export function fromServer(d: IServerConfig): ServerModel {
    const m = new ServerModel();
    m.id = d.ck_id;
    m.description = d.cv_description;
    m.ip = d.cv_ip;
    m.port = d.cn_port;
    return m;
}
