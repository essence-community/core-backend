import { SessionData, Store } from "express-session";
import { ISessionData } from "@ungate/plugininf/lib/ISession";

export interface IStoreTypes {
    nameContext: string;
    ttl: number;
}

export interface ISessionStore extends Store {
    init(): Promise<void>;
    allSession(
        sessionId?: string | string[],
        isExpired?: boolean,
    ): Promise<{ [sid: string]: ISessionData } | null>;
}
