import * as http from "http";
import * as URL from "url";
import * as crypto from "crypto";
import axios from "axios";
import * as qs from "qs";
import * as Grant from "keycloak-connect/middleware/auth-utils/grant";
import * as Token from "keycloak-connect/middleware/auth-utils/token";
import { Rotation } from "./Rotation";
import { IGrantManagerConfig, IToken } from "./TokenAuth.types";
import Logger from "@ungate/plugininf/lib/Logger";
import { isEmpty } from "@ungate/plugininf/lib/util/Util";
const logger = Logger.getLogger("GrantManager");

export class GrantManager {
    public notBefore: number;
    public rotation: Rotation;
    public realmUrl: string;
    public userInfoUrl: string;
    public tokenVerifyUrl: string;
    public tokenUrl: string;
    public clientId: string;
    public secret: string;
    public publicKey: string;
    public public: string;
    public bearerOnly: string;
    public verifyTokenAudience: boolean;
    public isIgnoreCheckSignature: boolean;
    public logger: any;
    constructor(config: IGrantManagerConfig, log: any) {
        this.realmUrl = config.realmUrl;
        this.userInfoUrl = config.userInfoUrl;
        this.tokenVerifyUrl = config.tokenVerifyUrl;
        this.tokenUrl = config.tokenUrl;
        this.clientId = config.clientId;
        this.secret = config.secret;
        this.publicKey = config.publicKey || "";
        this.public = config.public;
        this.bearerOnly = config.bearerOnly;
        this.isIgnoreCheckSignature = config.isIgnoreCheckSignature;
        this.notBefore = 0;
        this.rotation = new Rotation(config, log);
        this.verifyTokenAudience = config.verifyTokenAudience;
        this.logger = log;
    }
    obtainDirectly(username, password, callback, scopeParam) {
        const params = {
            client_id: this.clientId,
            username,
            password,
            grant_type: "password",
            scope: scopeParam || "openid",
        };
        const handler = createHandler(this);
        const options = postOptions(this);
        return nodeify(fetch(this, handler, options, params), callback);
    }
    obtainFromCode(request, code, sessionId, sessionHost, callback) {
        const params = {
            client_session_state: sessionId,
            client_session_host: sessionHost,
            code,
            grant_type: "authorization_code",
            client_id: this.clientId,
        };
        const handler = createHandler(this);
        const options = postOptions(this);

        return nodeify(
            fetch(
                this,
                handler,
                options,
                qs.stringify(params) +
                    `&redirect_uri=${
                        request.session && request.session.auth_redirect_uri
                            ? request.session.auth_redirect_uri
                            : getRedirectUrl(request)
                    }`,
            ),
            callback,
        );
    }
    checkPermissions(authzRequest, request, callback) {
        const params = {
            grant_type: "urn:ietf:params:oauth:grant-type:uma-ticket",
        } as Record<string, any>;

        if (authzRequest.audience) {
            params.audience = authzRequest.audience;
        } else {
            params.audience = this.clientId;
        }

        if (authzRequest.response_mode) {
            params.response_mode = authzRequest.response_mode;
        }

        if (authzRequest.claim_token) {
            params.claim_token = authzRequest.claim_token;
            params.claim_token_format = authzRequest.claim_token_format;
        }

        const options = postOptions(this);

        if (this.public) {
            if (
                request.kauth &&
                request.kauth.grant &&
                request.kauth.grant.access_token
            ) {
                options.headers.Authorization =
                    "Bearer " + request.kauth.grant.access_token.token;
            }
        } else {
            const header = request.headers.authorization;
            let bearerToken;

            if (
                header &&
                (header.indexOf("bearer ") === 0 ||
                    header.indexOf("Bearer ") === 0)
            ) {
                bearerToken = header.substring(7);
            }

            if (!bearerToken) {
                if (
                    request.kauth &&
                    request.kauth.grant &&
                    request.kauth.grant.access_token
                ) {
                    bearerToken = request.kauth.grant.access_token.token;
                } else {
                    return Promise.reject(new Error("No bearer in header"));
                }
            }

            params.subject_token = bearerToken;
        }

        let permissions = authzRequest.permissions;

        if (!permissions) {
            permissions = [];
        }

        for (const resource of permissions) {
            let permission = resource.id;

            if (resource.scopes && resource.scopes.length > 0) {
                permission += "#";

                for (const scope of resource.scopes) {
                    if (permission.indexOf("#") !== permission.length - 1) {
                        permission += ",";
                    }
                    permission += scope;
                }
            }

            if (!params.permission) {
                params.permission = [];
            }

            params.permission.push(permission);
        }

        const manager = this;

        const handler = (resolve, reject, json) => {
            try {
                if (
                    authzRequest.response_mode === "decision" ||
                    authzRequest.response_mode === "permissions"
                ) {
                    callback(JSON.parse(json));
                } else {
                    resolve(manager.createGrant(json));
                }
            } catch (err) {
                reject(err);
            }
        };

        return nodeify(fetch(this, handler, options, params));
    }
    obtainFromClientCredentials(callback, scopeParam) {
        const params = {
            grant_type: "client_credentials",
            scope: scopeParam || "openid",
            client_id: this.clientId,
        };
        const handler = createHandler(this);
        const options = postOptions(this);

        return nodeify(fetch(this, handler, options, params), callback);
    }
    ensureFreshness(grant, callback?: any) {
        if (!grant.isExpired()) {
            return nodeify(Promise.resolve(grant), callback);
        }

        if (!grant.refresh_token) {
            return nodeify(
                Promise.reject(
                    new Error("Unable to refresh without a refresh token"),
                ),
                callback,
            );
        }

        if (grant.refresh_token.isExpired()) {
            return nodeify(
                Promise.reject(
                    new Error("Unable to refresh with expired refresh token"),
                ),
                callback,
            );
        }

        const params = {
            grant_type: "refresh_token",
            refresh_token: grant.refresh_token.token,
            client_id: this.clientId,
        };
        const handler = refreshHandler(this);
        const options = postOptions(this);

        return nodeify(fetch(this, handler, options, params), callback);
    }
    validateAccessToken(token, callback?) {
        let t = token;
        if (typeof token === "object") {
            t = token.token;
        }
        const params = {
            token: t,
            client_secret: this.secret,
            client_id: this.clientId,
        };
        const options = postOptions(
            this,
            this.tokenVerifyUrl
                ? this.tokenVerifyUrl
                : this.realmUrl + "/protocol/openid-connect/token/introspect",
        );
        const handler = validationHandler(this, token);

        return nodeify(fetch(this, handler, options, params), callback);
    }
    userInfo(token: IToken | string, callback?) {
        const url = this.userInfoUrl
            ? this.userInfoUrl
            : this.realmUrl + "/protocol/openid-connect/userinfo";
        const options = URL.parse(url) as any;
        options.method = "GET";

        let t = token;
        if (typeof token === "object") {
            t = token.token;
        }

        options.headers = {
            Authorization: "Bearer " + t,
            Accept: "application/json",
            "X-Client": "keycloak-nodejs-connect",
        };

        const promise = axios
            .request<any>({
                url: URL.format(options),
                headers: options.headers,
                method: options.method,
                responseType: "json",
            })
            .then((res) => {
                if (res.data.error) {
                    throw res.data;
                }
                return res.data;
            })
            .catch((err) => {
                if (err.response) {
                    this.logger.error(err.response.data);
                    throw new Error("Error fetching account");
                }
                throw err;
            });

        return nodeify(promise, callback);
    }
    getAccount() {
        this.logger.error(
            "GrantManager#getAccount is deprecated. See GrantManager#userInfo",
        );
        return this.userInfo.apply(this, arguments);
    }
    isGrantRefreshable(grant) {
        return !this.bearerOnly && grant && grant.refresh_token;
    }
    createGrant(rawData) {
        let grantData = rawData;
        if (typeof rawData !== "object") grantData = JSON.parse(grantData);

        const grant = new Grant({
            access_token: grantData.access_token
                ? new Token(grantData.access_token, this.clientId)
                : undefined,
            refresh_token: grantData.refresh_token
                ? new Token(grantData.refresh_token)
                : undefined,
            id_token: grantData.id_token
                ? new Token(grantData.id_token)
                : undefined,
            expires_in: grantData.expires_in,
            token_type: grantData.token_type,
            __raw: rawData,
        });

        if (this.isGrantRefreshable(grant)) {
            return new Promise((resolve, reject) => {
                this.ensureFreshness(grant)
                    .then((g) => this.validateGrant(g))
                    .then((g) => resolve(g))
                    .catch((err) => reject(err));
            });
        } else {
            return this.validateGrant(grant);
        }
    }
    validateToken(token, expectedType) {
        return new Promise(async (resolve, reject) => {
            if (!token) {
                reject(new Error("invalid token (missing)"));
            } else if (token.isExpired()) {
                reject(new Error("invalid token (expired)"));
            } else if (!token.signed) {
                reject(new Error("invalid token (not signed)"));
            } else if (expectedType && token.content.typ !== expectedType) {
                reject(new Error("invalid token (wrong type)"));
            } else if (token.content.iat < this.notBefore) {
                reject(new Error("invalid token (stale token)"));
            } else if (this.realmUrl && token.content.iss !== this.realmUrl) {
                reject(new Error("invalid token (wrong ISS)"));
            } else {
                const audienceData = Array.isArray(token.content.aud)
                    ? token.content.aud
                    : [token.content.aud];
                if (expectedType === "ID") {
                    if (!audienceData.includes(this.clientId)) {
                        reject(new Error("invalid token (wrong audience)"));
                    }
                    if (
                        token.content.azp &&
                        token.content.azp !== this.clientId
                    ) {
                        reject(
                            new Error(
                                "invalid token (authorized party should match client id)",
                            ),
                        );
                    }
                } else if (this.verifyTokenAudience) {
                    if (!audienceData.includes(this.clientId)) {
                        reject(new Error("invalid token (wrong audience)"));
                    }
                }
                if (this.isIgnoreCheckSignature) {
                    return resolve(token);
                }
                const verify = crypto.createVerify("RSA-SHA256");
                // if public key has been supplied use it to validate token
                if (!isEmpty(this.publicKey)) {
                    try {
                        verify.update(token.signed);
                        if (
                            !verify.verify(
                                this.publicKey,
                                token.signature,
                                "base64",
                            )
                        ) {
                            reject(new Error("invalid token (signature)"));
                        } else {
                            resolve(token);
                        }
                    } catch (err) {
                        this.logger.error(err);
                        reject(
                            new Error(
                                "Misconfigured parameters while validating token. Check your keycloak.json file!",
                            ),
                        );
                    }
                } else {
                    // retrieve public KEY and use it to validate token
                    this.rotation
                        .getJWK(token.header.kid)
                        .then((key) => {
                            verify.update(token.signed);
                            if (!verify.verify(key, token.signature)) {
                                reject(
                                    new Error(
                                        "invalid token (public key signature)",
                                    ),
                                );
                            } else {
                                resolve(token);
                            }
                        })
                        .catch((err) => {
                            this.logger.error(err);
                            reject(
                                new Error(
                                    "failed to load public key to verify token. Reason: " +
                                        err.message,
                                ),
                            );
                        });
                }
            }
        });
    }
    validateGrant(grant) {
        const self = this;
        const validateGrantToken = (grantData, tokenName, expectedType) => {
            return new Promise<void>((resolve, reject) => {
                // check the access token
                this.validateToken(grantData[tokenName], expectedType)
                    .then((token) => {
                        grantData[tokenName] = token;
                        resolve();
                    })
                    .catch((err) => {
                        this.logger.error(err);
                        reject(
                            new Error(
                                "Grant validation failed. Reason: " +
                                    err.message,
                            ),
                        );
                    });
            });
        };
        return new Promise((resolve, reject) => {
            const promises = [];
            promises.push(validateGrantToken(grant, "access_token", "Bearer"));
            if (!self.bearerOnly) {
                if (grant.id_token) {
                    promises.push(validateGrantToken(grant, "id_token", "ID"));
                }
            }
            Promise.all(promises)
                .then(() => {
                    resolve(grant);
                })
                .catch((err) => {
                    this.logger.error(err);
                    reject(new Error(err.message));
                });
        });
    }
}

const nodeify = (promise, cb?: any) => {
    if (typeof cb !== "function") return promise;
    return promise.then((res) => cb(null, res)).catch((err) => cb(err));
};

const createHandler = (manager) => (resolve, reject, json) => {
    try {
        resolve(manager.createGrant(json));
    } catch (err) {
        reject(err);
    }
};

const refreshHandler = (manager: GrantManager) => (resolve, reject, json) => {
    manager
        .createGrant(json)
        .then((grant) => resolve(grant))
        .catch((err) => reject(err));
};

const validationHandler =
    (manager: GrantManager, token) => (resolve, reject, json) => {
        const data = JSON.parse(json);
        if (!data.active) resolve(false);
        else resolve(token);
    };

const postOptions = (manager: GrantManager, path?: string) => {
    const realPath =
        path || manager.tokenUrl || "/protocol/openid-connect/token";
    const opts = URL.parse(
        realPath.startsWith("http") ? realPath : manager.realmUrl + realPath,
    ) as any;
    opts.headers = {
        "Content-Type": "application/x-www-form-urlencoded",
        "X-Client": "keycloak-nodejs-connect",
    };
    if (!manager.public) {
        opts.headers.Authorization =
            "Basic " +
            Buffer.from(manager.clientId + ":" + manager.secret).toString(
                "base64",
            );
    }
    opts.method = "POST";
    return opts;
};

const fetch = (manager: GrantManager, handler, options, params) => {
    return new Promise((resolve, reject) => {
        const data = typeof params === "string" ? params : qs.stringify(params);
        options.headers["Content-Length"] = data.length;
        axios
            .request({
                url: URL.format(options),
                headers: options.headers,
                method: options.method,
                data,
                responseType: "json",
            })
            .then((res) => {
                if (res.status < 200 || res.status > 299) {
                    logger.warning(res.data);
                    return reject(
                        new Error(
                            res.status + ":" + http.STATUS_CODES[res.status],
                        ),
                    );
                }
                handler(resolve, reject, res.data);
            })
            .catch((err) => {
                if (err.response) {
                    logger.error(err.response.data);
                    return reject(
                        new Error(
                            err.response.status +
                                ":" +
                                http.STATUS_CODES[err.response.status],
                        ),
                    );
                }
                return reject(err);
            });
    });
};

const getRedirectUrl = (request) => {
    const host = request.hostname;
    const [_headerHost, port = ""] = request.headers["x-forwarded-host"]
        ? request.headers["x-forwarded-host"].split(":")
        : request.headers.host.split(":");
    const xForwardedPath = request.headers["x-forwarded-path"] || "";
    const xForwardedAuth = request.headers["x-forwarded-auth"] || "";
    const protocol = request.headers["x-forwarded-proto"] || request.protocol;
    const hasQuery = (request.originalUrl || request.url).indexOf("?") > -1;

    const redirectUrl = xForwardedAuth
        ? xForwardedAuth +
          (request.originalUrl || request.url).split("?")[0] +
          (hasQuery ? "&" : "?") +
          "auth_callback=1"
        : protocol +
          "://" +
          host +
          (port === "" ? "" : ":" + port) +
          xForwardedPath +
          (request.originalUrl || request.url).split("?")[0] +
          "?" +
          "auth_callback=1";

    return redirectUrl;
};
