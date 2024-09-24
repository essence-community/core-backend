import IContext from "@ungate/plugininf/lib/IContext";
import { Grant } from "keycloak-connect";
import { GrantManager } from "./GrantManager";

export async function GrantAttacher(
    name: string,
    gateContext: IContext,
    grantManager: GrantManager,
): Promise<Grant> {
    const header = gateContext.request.headers.authorization || "";
    let accessToken;
    if (header && header.substr(0, 7).toLowerCase().indexOf("bearer ") === 0) {
        accessToken = JSON.stringify({
            access_token: header.substring(7),
        });
    } else if (header.substr(0, 6).toLowerCase().indexOf("basic ") === 0) {
        const basic = Buffer.from(
                    header.substring(6),
                    "base64",
            ).toString("ascii");
        const split = basic.indexOf(":");
        return grantManager.obtainDirectly(
            basic.substring(0, split),
            basic.substring(split+1)
        ).then(async ([grant, headers]: [Grant, Record<string, any>]) => {
            // tslint:disable:triple-equals
            if (
                gateContext.request.session[`token_bearer_${name}`] !=
                (grant as any).__raw
            ) {
                if (grantManager.tokenVerifyUrl) {
                    await grantManager.validateAccessToken(grant.access_token);
                }
                gateContext.request.session[`token_bearer_${name}`] = (
                    grant as any
                ).__raw;
            }
            return grant as Grant;
        });
    } else if (gateContext.request.session[`token_bearer_${name}`]) {
        accessToken = gateContext.request.session[`token_bearer_${name}`];
    }
    if (gateContext.isDebugEnabled()) {
        gateContext.debug("Access Token Found %s", accessToken);
    }
    return accessToken
        ? grantManager.createGrant(accessToken).then(async (grant: Grant) => {
            // tslint:disable:triple-equals
            if (
                gateContext.request.session[`token_bearer_${name}`] !=
                (grant as any).__raw
            ) {
                if (grantManager.tokenVerifyUrl) {
                    await grantManager.validateAccessToken(grant.access_token);
                }
                gateContext.request.session[`token_bearer_${name}`] = (
                    grant as any
                ).__raw;
            }
            return grant as Grant;
        })
        : null;
}
