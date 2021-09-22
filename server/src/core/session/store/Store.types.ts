import { SessionData, Store } from "express-session";
import { ISessionData } from "@ungate/plugininf/lib/ISession";

export interface IStoreTypes {
    nameContext: string;
    ttl: number;
}
