import { IRequest } from "@ungate/plugininf/lib/IContext";
import * as KeyCloak from "keycloak-connect";
import { ISessProviderParam } from "@ungate/plugininf/lib/NullSessProvider";
import { Agent as HttpsAgent } from "https";
import { Agent as HttpAgent } from "http";

export interface IGrantMap {
    grant: string;
    action: string;
}

export interface IGrantRoleMap {
    grant: string;
    role: string;
}

export interface IUserInfoMap {
    in: string;
    out: string;
}

export interface IKeyCloakAuthParams extends ISessProviderParam {
    grantManagerConfig: IGrantManagerConfig;
    keyCloakParamName: string;
    redirectUrl: string;
    mapKeyCloakGrantRole?: IGrantRoleMap[];
    mapKeyCloakGrant?: IGrantMap[];
    mapKeyCloakUserInfo?: IUserInfoMap[];
    disableRecursiveAuth?: boolean;
    flagRedirect: string;
    adminPathParam: string;
    idKey: string;
    httpAgent?: string;
    httpsAgent?: string;
    isSaveToken?: boolean;
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
    certsUrl?: string;
    realmUrl: string;
    proxyUrl?: string;
    minTimeBetweenJwksRequests: number;
    httpsAgent?: HttpsAgent;
    httpAgent?: HttpAgent;
}

export interface IGrantManagerConfig extends IRotationConfig {
    userInfoUrl?: string;
    tokenVerifyUrl?: string;
    tokenUrl?: string;
    clientId: string;
    secret?: string;
    publicKey?: string;
    public?: boolean;
    bearerOnly?: boolean;
    verifyTokenAudience?: boolean;
    isIgnoreCheckSignature?: boolean;
    scope?: string;
    idpHint?: string;
    grantManagerConfigExtra?: any;
}

