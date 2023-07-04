import { IRequest } from "@ungate/plugininf/lib/IContext";
import * as KeyCloak from "keycloak-connect";
import { ISessProviderParam } from "@ungate/plugininf/lib/NullSessProvider";

export interface IGrantMap {
    grant: string;
    action: string;
}

export interface IUserInfoMap {
    in: string;
    out: string;
}

export interface IKeyCloakAuthParams extends ISessProviderParam {
    keyCloakConfig: KeyCloak.KeycloakConfig & {
        secret?: string;
        "public-client"?: boolean;
        "min-time-between-jwks-requests"?: number;
        "realm-public-key"?: string;
    };
    keyCloakParamName: string;
    redirectUrl: string;
    mapKeyCloakGrant: IGrantMap[];
    mapKeyCloakUserInfo: IUserInfoMap[];
    disableRecursiveAuth: boolean;
    flagRedirect: string;
    adminPathParam: string;
    idKey: string;
}

export interface IRequestExtra extends IRequest {
    kauth: {
        grant?: KeyCloak.Grant;
    };
}

export interface IKeyCloakAuthParam {
    query: Record<string, any>;
    path: string;
}

export interface IToken extends KeyCloak.Token {
    token: string;
}

export interface IRotationConfig {
    certsUrl: string;
    realmUrl: string;
    minTimeBetweenJwksRequests: number;
}

export interface IGrantManagerConfig extends IRotationConfig {
    userInfoUrl: string;
    tokenVerifyUrl: string;
    tokenUrl: string;
    clientId: string;
    secret: string;
    publicKey: string;
    public: string;
    bearerOnly: string;
    verifyTokenAudience: boolean;
    isIgnoreCheckSignature?: boolean;
}

export interface IRotationConfig {
    certsUrl: string;
    minTimeBetweenJwksRequests: number;
}
