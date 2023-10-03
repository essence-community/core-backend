export interface ISysSettingData {
    ck_id: string;
    cv_value: string;
    cv_description: string;
}

export interface IMessageData {
    ck_id: number;
    cr_type: string;
    cv_text: string;
}

export interface IActionData {
    ck_id: string;
    ck_page_object: string;
    cn_action: number;
}

export interface IModifyData {
    ck_id: string;
    ck_provider: string;
    cv_modify: number;
}

export interface IQueryData {
    cc_query: string;
    ck_id: string;
    ck_provider: string;
    cn_action: number;
    cr_access: string;
    cr_type: string;
    cr_cache: string;
    cv_cache_key_param: string[];
}

export interface IQueryCacheData {
    ck_id: string;
    cct_data: Record<string, any>[];
}
export interface IPageData {
    ck_id: string;
    cn_action: number;
    cv_name: string;
    cv_url?: string;
    children: Record<string, any>[];
    global_value: Record<string, string>;
    route: Record<string, string>;
}

export interface IObjectData {
    ck_id: string;
    cn_action: number;
    json: Record<string, any>[];
}
