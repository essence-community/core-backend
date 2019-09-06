import { IInParamArray, IOutParamArray } from "@ungate/plugininf/lib/IQuery";

export interface IInParam {
    cl_replace: true | false;
    cl_require: true | false;
    cv_value: any;
}

export interface IOutParam {
    cl_replace: true | false;
    outType: string;
}

export default interface IQueryConfig {
    ck_id: string;
    cv_name: string;
    ck_d_context: string;
    ck_d_provider: string;
    cv_text?: string;
    cv_description?: string;
    cct_inParams?: IInParamArray[];
    cct_outParams?: IOutParamArray[];
}
