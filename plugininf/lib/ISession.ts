import { SessionData } from "express-session-fork";

/**
 * Created by artemov_i on 04.12.2018.
 */

export default interface ISession {
    session: string;
    idUser: string;
    nameProvider: string;
    userData: IUserData;
    sessionData: {
        [key: string]: any;
        typeCheckAuth?:
            | "cookie"
            | "session"
            | "cookieandsession"
            | "cookieorsession";
    };
}

export interface IUserData {
    ca_actions: any[];
    // @deprecated
    ca_department?: any[];
    ck_id: any;
    cv_login?: string;
    ck_dept?: any;
    cv_timezone?: string;
    [key: string]: any;
}

export interface IUserDbData {
    ck_d_provider: string;
    ck_id: string;
    cv_login?: string;
    data: IUserData;
}

export interface ISessionData extends SessionData {
    gsession?: ISession;
}
