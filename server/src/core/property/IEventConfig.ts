import ICCTParams from "@ungate/plugininf/lib/ICCTParams";

export default interface IEventConfig {
    ck_id: string;
    cv_description?: string;
    ck_d_plugin: string;
    cct_params?: ICCTParams;
}
