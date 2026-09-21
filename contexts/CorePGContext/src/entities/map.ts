import {
    IActionData,
    IMessageData,
    IModifyData,
    IObjectData,
    IPageData,
    IQueryCacheData,
    IQueryData,
    ISysSettingData,
} from "../CoreContext.types";
import { ActionModel } from "./ActionModel";
import { MessageModel } from "./MessageModel";
import { ModifyActionModel } from "./ModifyActionModel";
import { ModifyModel } from "./ModifyModel";
import { ObjectModel } from "./ObjectModel";
import { PageModel } from "./PageModel";
import { QueryCacheModel } from "./QueryCacheModel";
import { QueryModel } from "./QueryModel";
import { SysSettingModel } from "./SysSettingModel";

export function toPage(m: PageModel): IPageData {
    return {
        ck_id: m.id,
        cn_action: m.action,
        cv_name: m.name,
        cv_url: m.url,
        children: m.children,
        global_value: m.globalValue,
        route: m.route,
    } as IPageData;
}

export function fromPage(d: IPageData): PageModel {
    const m = new PageModel();
    m.id = d.ck_id;
    m.action = d.cn_action;
    m.name = d.cv_name;
    m.url = d.cv_url;
    m.children = d.children;
    m.globalValue = d.global_value;
    m.route = d.route;
    return m;
}

export function toQuery(m: QueryModel): IQueryData {
    return {
        cc_query: m.query,
        ck_id: m.id,
        ck_provider: m.provider,
        cn_action: m.action,
        cr_access: m.access,
        cr_type: m.type,
        cr_cache: m.cache,
        cv_cache_key_param: m.cacheKeyParam,
    } as IQueryData;
}

export function fromQuery(d: IQueryData): QueryModel {
    const m = new QueryModel();
    m.id = d.ck_id;
    m.query = d.cc_query;
    m.provider = d.ck_provider;
    m.action = d.cn_action;
    m.access = d.cr_access;
    m.type = d.cr_type;
    m.cache = d.cr_cache;
    m.cacheKeyParam = d.cv_cache_key_param;
    return m;
}

export function fromQueryCache(d: IQueryCacheData): QueryCacheModel {
    const m = new QueryCacheModel();
    m.id = d.ck_id;
    m.data = d.cct_data;
    return m;
}

export function toAction(m: ActionModel | ModifyActionModel): IActionData {
    return {
        ck_id: m.id,
        ck_page_object: m.pageObject,
        cn_action: m.action,
    } as IActionData;
}

export function fromAction(d: IActionData): ActionModel {
    const m = new ActionModel();
    m.id = d.ck_id;
    m.pageObject = d.ck_page_object;
    m.action = d.cn_action;
    return m;
}

export function fromModifyAction(d: IActionData): ModifyActionModel {
    const m = new ModifyActionModel();
    m.id = d.ck_id;
    m.pageObject = d.ck_page_object;
    m.action = d.cn_action;
    return m;
}

export function toModify(m: ModifyModel): IModifyData {
    return {
        ck_id: m.id,
        ck_provider: m.provider,
        cv_modify: m.modify as any,
    };
}

export function fromModify(d: IModifyData): ModifyModel {
    const m = new ModifyModel();
    m.id = d.ck_id;
    m.provider = d.ck_provider;
    m.modify = String(d.cv_modify);
    return m;
}

export function fromMessage(d: IMessageData): MessageModel {
    const m = new MessageModel();
    m.id = String(d.ck_id);
    m.type = d.cr_type;
    m.text = d.cv_text;
    return m;
}

export function toSysSetting(m: SysSettingModel): ISysSettingData {
    return {
        ck_id: m.id,
        cv_value: m.value,
        cv_description: m.description,
    } as ISysSettingData;
}

export function fromSysSetting(d: ISysSettingData): SysSettingModel {
    const m = new SysSettingModel();
    m.id = d.ck_id;
    m.value = d.cv_value;
    m.description = d.cv_description;
    return m;
}

export function toObject(m: ObjectModel): IObjectData {
    return {
        ck_id: m.id,
        cn_action: m.action,
        json: m.json,
    } as IObjectData;
}

export function fromObject(d: IObjectData): ObjectModel {
    const m = new ObjectModel();
    m.id = d.ck_id;
    m.action = d.cn_action;
    m.json = d.json;
    return m;
}
