import * as URL from "url";
import * as jwkToPem from "jwk-to-pem";
import axios from "axios";
import { IRotationConfig } from "../KeyCloakAuth.types";
export class Rotation {
    public realmUrl: string;
    public certsUrl?: string;
    public proxyUrl?: string;
    public minTimeBetweenJwksRequests: number;
    public jwks: jwkToPem.JWK[];
    public lastTimeRequesTime: number;
    public logger: any;
    public config: IRotationConfig;
    constructor(config: IRotationConfig, logger: any) {
        this.realmUrl = config.realmUrl;
        this.minTimeBetweenJwksRequests = config.minTimeBetweenJwksRequests || 0;
        this.certsUrl = config.certsUrl;
        this.jwks = [];
        this.lastTimeRequesTime = 0;
        this.proxyUrl = config.proxyUrl;
        this.logger = logger;
        this.config = config;
    }

    retrieveJWKs(callback?: (err?: Error) => void) {
        const url = this.certsUrl
            ? this.certsUrl
            : (this.proxyUrl || this.realmUrl) + "/protocol/openid-connect/certs";
        const options = URL.parse(url);
        const promise = axios
            .get<{
                keys?: jwkToPem.JWK;
                error?: any;
            }>(URL.format(options), {
                validateStatus: () => true,
                responseType: "json",
                httpAgent: this.config.httpAgent,
                httpsAgent: this.config.httpsAgent,
            })
            .then((response) => {
                this.logger.debug("retrieveJWKs status: %s, header: %j, response %j", response.status, response.headers, response.data);
                if (response.status < 200 || response.status >= 300) {
                    throw new Error("Error fetching JWK Keys");
                }
                if (response.data.error) {
                    throw new Error(response.data.error);
                }
                return response.data;
            })
            .catch((err) => {
                this.logger.error("retrieveJWKs", err);
                return Promise.reject(err);
            });
        return nodeify(promise, callback);
    }
    async getJWK(kid, count = 0) {
        const key = this.jwks.find((keyChild) => {
            return (keyChild as any).kid === kid;
        });
        if (key) {
            return jwkToPem(key);
        }
        const self = this;

        if (count > 5) {
            throw new Error("Not found cert")
        }

        // check if we are allowed to send request
        const currentTime = new Date().getTime() / 1000;
        if (
            currentTime >
            this.lastTimeRequesTime + this.minTimeBetweenJwksRequests
        ) {
            return this.retrieveJWKs().then((publicKeys) => {
                self.lastTimeRequesTime = currentTime;
                self.jwks = publicKeys.keys;
                const convertedKey = jwkToPem(
                    self.jwks.find((keyChild) => {
                        return (keyChild as any).kid === kid;
                    }),
                );
                return convertedKey;
            });
        } else {
            this.logger.error(
                "Not enough time elapsed since the last request, blocking the request",
            );

            return new Promise((resolve, reject) => {
                setTimeout(() => this.getJWK(kid, count + 1).then(resolve, reject), 1000);
            });
        }
    }
    clearCache() {
        this.jwks.length = 0;
    }
}

const nodeify = (promise, cb) => {
    if (typeof cb !== "function") return promise;
    return promise.then((res) => cb(null, res)).catch((err) => cb(err));
};
