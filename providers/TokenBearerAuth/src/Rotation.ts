import * as URL from "url";
import * as jwkToPem from "jwk-to-pem";
import axios from "axios";
import { IRotationConfig } from "./TokenAuth.types";
export class Rotation {
    public realmUrl: string;
    public certsUrl: string;
    public minTimeBetweenJwksRequests: number;
    public jwks: jwkToPem.JWK[];
    public lastTimeRequesTime: number;
    public logger: any;
    constructor(config: IRotationConfig, logger: any) {
        this.realmUrl = config.realmUrl;
        this.minTimeBetweenJwksRequests = config.minTimeBetweenJwksRequests;
        this.certsUrl = config.certsUrl;
        this.jwks = [];
        this.lastTimeRequesTime = 0;
        this.logger = logger;
    }

    retrieveJWKs(callback?: (err?: Error) => void) {
        const url = this.certsUrl
            ? this.certsUrl
            : this.realmUrl + "/protocol/openid-connect/certs";
        const options = URL.parse(url);
        const promise = axios
            .get<{
                keys?: jwkToPem.JWK;
                error?: any;
            }>(URL.format(options), {
                validateStatus: () => true,
                responseType: "json",
            })
            .then((response) => {
                if (response.status < 200 || response.status >= 300) {
                    throw new Error("Error fetching JWK Keys");
                }
                if (response.data.error) {
                    throw response.data.error;
                }
                return response.data;
            });
        return nodeify(promise, callback);
    }
    getJWK(kid) {
        const key = this.jwks.find((keyChild) => {
            return (keyChild as any).kid === kid;
        });
        if (key) {
            return new Promise((resolve, reject) => {
                resolve(jwkToPem(key));
            });
        }
        const self = this;

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
