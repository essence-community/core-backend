import IContext from "@ungate/plugininf/lib/IContext";
import { Grant } from "keycloak-connect";
import { GrantManager } from "./GrantManager";

export async function GrantAttacher(
    name: string,
    gateContext: IContext,
    grantManager: GrantManager,
): Promise<Grant> {
    const header = gateContext.request.headers.authorization;
    let accessToken;
    if (header && header.substr(0, 7).toLowerCase().indexOf("bearer ") === 0) {
        accessToken = JSON.stringify({
            access_token: header.substring(7),
        });
    } else if (gateContext.request.session[`token_bearer_${name}`]) {
        accessToken = gateContext.request.session[`token_bearer_${name}`];
    }
    return accessToken
        ? grantManager.createGrant(accessToken).then((grant) => {
              (gateContext.request as any).kauth.grant = grant;
              gateContext.request.session[
                  `token_bearer_${name}`
              ] = (grant as any).__raw;
              return grant as Grant;
          })
        : null;
}
