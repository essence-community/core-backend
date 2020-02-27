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
        | "long_string";
    setGlobal?: string;
    getGlobal?: string;
    hiddenRules?: string;
    disabledRules?: string;
    defaultValue?: any;
    name: string;
    description?: string;
}

export interface IParamsInfo {
    [key: string]: IParamInfo;
}
