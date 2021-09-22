import ICCTParams from "@ungate/plugininf/lib/ICCTParams";

export default interface IPluginConfig {
    ck_id: string;
    cv_name: string;
    ck_context?: string;
    ck_d_provider: string;
    cv_description?: string;
    ck_d_plugin: string;
    cl_required: number;
    cl_default: number;
    cn_order: number;
    cct_params?: ICCTParams;
}
