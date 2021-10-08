import IContext from "@ungate/plugininf/lib/IContext";
import { Grant } from "keycloak-connect";
import { GrantManager } from "./GrantManager";

export async function GrantAttacher (
    gateContext: IContext,
    keycloak: GrantManager,
): Promise<Grant> {
    let header = gateContext.request.headers.authorization;
    if (header.toLowerCase().indexOf("bearer ") === 0) {
        let accessToken = header.substring(7);
        return keycloak
            .createGrant(
                JSON.stringify({
                    access_token: accessToken,
                }),
            )
            .then((grant) => {
                (gateContext.request as any).kauth.grant = grant;
                return grant as Grant;
            });
    }
    return null;
}
