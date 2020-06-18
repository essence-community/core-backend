export default interface ICCTParams {
    [key: string]: any;
}

export interface IParamInfo {
    required?: boolean;
    type:
        | "string"
        | "boolean"
        | "integer"
        | "numeric"
        | "date"
        | "password"
        | "long_string"
        | "combo";
    setGlobal?: string;
    getGlobal?: string;
    hiddenRules?: string;
    disabledRules?: string;
    defaultValue?: any;
    name: string;
    description?: string;
    valueField?: string;
    displayField?: string;
    query?: string;
    minValue?: string;
    maxValue?: string;
    allownew?: string;
    maxsize?: string;
    minchars?: string;
    pagesize?: string;
    querymode?: "remote" | "local";
    queryparam?: string;
    records?: Record<string, string | number>[];
}

export interface IParamsInfo {
    [key: string]: IParamInfo;
}
