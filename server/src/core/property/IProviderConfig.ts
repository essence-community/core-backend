import ICCTParams from "@ungate/plugininf/lib/ICCTParams";

export default interface IProviderConfig {
    ck_id: string;
    cv_description?: string;
    cl_autoload: number;
    ck_d_plugin: string;
    ck_context?: string;
    cct_params?: ICCTParams;
}
