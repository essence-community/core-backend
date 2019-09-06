import ICCTParams from "@ungate/plugininf/lib/ICCTParams";

export default interface IShedulerConfig {
    ck_id: string;
    cv_description?: string;
    cl_enable: number;
    ck_d_plugin: string;
    cv_cron: string;
    cct_params?: ICCTParams;
}
