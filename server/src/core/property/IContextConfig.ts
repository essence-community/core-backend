import ICCTParams from "@ungate/plugininf/lib/ICCTParams";

export default interface IContextConfig {
    ck_id: string;
    cv_path: string;
    ck_d_plugin: string;
    cv_description?: string;
    cct_params?: ICCTParams;
}
