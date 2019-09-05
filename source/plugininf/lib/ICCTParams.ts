export default interface ICCTParams {
    [key: string]: any;
}

export interface IParamInfo {
    required?: boolean;
    type: "string" | "boolean" | "integer" | "numeric" | "date" | "password";
    defaultValue?: any;
    name: string;
    description?: string;
}

export interface IParamsInfo {
    [key: string]: IParamInfo;
}
