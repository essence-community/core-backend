import IObjectParam from "./IObjectParam";
import { SessionData } from "express-session";

/**
 * Created by artemov_i on 04.12.2018.
 */

export default interface ISession {
    session: string;
    idUser: string;
    nameProvider: string;
    userData: IUserData;
    typeCheckAuth?:
        | "cookie"
        | "session"
        | "cookieandsession"
        | "cookieorsession";
}

export interface IUserData {
    ca_actions: any[];
    ca_department?: any[];
    ck_id: any;
    ck_dept?: any;
    cv_timezone?: string;
    [key: string]: any;
}

export interface ISessionData extends SessionData {
    gsession?: ISession;
}
