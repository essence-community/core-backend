import IObjectParam from "./IObjectParam";
import IProvider from "./IProvider";

/**
 * Created by artemov_i on 04.12.2018.
 */

export interface IInParamArray {
    cl_replace?: true | false;
    cl_require?: true | false;
    cv_name: string;
    cv_value?: any;
}

export interface IOutParamArray {
    cl_replace?: true | false;
    cv_name: string;
    outType?: string;
}

export interface IGateQuery {
    readonly queryData: IObjectParam;
    readonly needSession: true | false;
    readonly useMacros: true | false;
    readonly type: number;
    readonly extraInParams: IInParamArray[];
    readonly extraOutParams: IOutParamArray[];
    readonly inParams: IObjectParam;
    readonly outParams: IObjectParam;
    readonly macros: IObjectParam;
    readonly queryStr: string;
    prepareParams(provider: IProvider);
    applyMacro(regexp: string, data: string);
}

export default interface IQuery {
    queryData?: IObjectParam;
    needSession?: true | false;
    useMacros?: true | false;
    type?: number;
    extraInParams?: IInParamArray[];
    extraOutParams?: IOutParamArray[];
    queryStr?: string;
    modifyMethod?: string;
}
