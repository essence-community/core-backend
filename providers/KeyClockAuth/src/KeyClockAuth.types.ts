import { IRequest } from "@ungate/plugininf/lib/IContext";
import * as KeyClock from "keycloak-connect";
import { IAuthProviderParam } from "@ungate/plugininf/lib/NullAuthProvider";

export interface IGrantMap {
    grant: string;
    action: string;
}

export interface IUserInfoMap {
    in: string;
    out: string;
}

export interface IKeyClockAuthParams extends IAuthProviderParam {
    keyClockConfig: KeyClock.KeycloakConfig & {
        secret?: string;
        "public-client"?: boolean;
        "min-time-between-jwks-requests"?: number;
        "realm-public-key"?: string;
    };
    keyClockParamName: string;
    redirectUrl: string;
    mapKeyClockGrant: IGrantMap[];
    mapKeyClockUserInfo: IUserInfoMap[];
    disableRecursiveAuth: boolean;
}

export interface IRequestExtra extends IRequest {
    kauth: {
        grant?: KeyClock.Grant;
    };
}

export interface IKeyClockAuthParam {
    query: Record<string, any>;
    path: string;
}
