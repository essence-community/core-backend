import IObjectParam from "./IObjectParam";

/**
 * Created by artemov_i on 04.12.2018.
 */

export default interface ISession {
    session: string;
    ck_id: string;
    ck_d_provider: string;
    data: IUserData;
}

export interface IUserData {
    ca_actions?: any[];
    ca_department?: any[];
    ck_id: any;
    ck_dept?: any;
    cv_timezone: any;
    [key: string]: any;
}
