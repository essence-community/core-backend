import IContext from "@ungate/plugininf/lib/IContext";
import { Grant } from "keycloak-connect";
import { GrantManager } from "./GrantManager";

export async function GrantAttacher(
    name: string,
    gateContext: IContext,
    grantManager: GrantManager,
): Promise<Grant> {
    let header = gateContext.request.headers.authorization;
    if (header.toLowerCase().indexOf("bearer ") === 0) {
        let accessToken = header.substring(7);
        return grantManager
            .createGrant(
                JSON.stringify({
                    access_token: accessToken,
                }),
            )
            .then((grant) => {
                (gateContext.request as any).kauth.grant = grant;
                gateContext.request.session[
                    `token_bearer_${name}`
                ] = (grant as any).__raw;
                return grant as Grant;
            });
    } else if (gateContext.request.session[`token_bearer_${name}`]) {
        return grantManager
            .createGrant(gateContext.request.session[`token_bearer_${name}`])
            .then((grant) => {
                (gateContext.request as any).kauth.grant = grant;
                return grant as Grant;
            });
    }
    return null;
}
