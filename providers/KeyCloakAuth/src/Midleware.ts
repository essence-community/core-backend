import * as KeyCloak from "keycloak-connect";
import * as Token from "keycloak-connect/middleware/auth-utils/token";
import * as Signature from "keycloak-connect/middleware/auth-utils/signature";
import IContext from "@ungate/plugininf/lib/IContext";
import { IRequestExtra, IKeyCloakAuthParam } from "./KeyCloakAuth.types";
import { GrantManager } from "./util/GrantManager";

export async function PostAuth(
    gateContext: IContext,
    grantManager: GrantManager,
    data: IKeyCloakAuthParam,
): Promise<KeyCloak.Grant | null> {
    const request = gateContext.request as IRequestExtra;

    //  During the check SSO process the Keycloak server answered the user is not logged in
    if (data.query.error === "login_required") {
        return null;
    }

    if (data.query.error) {
        return null;
    }

    return grantManager.obtainFromCode(request, data.query.code, request.session.id);
}

export async function GrantAttacher(
    gateContext: IContext,
    grantManager: GrantManager,
): Promise<KeyCloak.Grant | null> {
    const header = gateContext.request.headers.authorization;
    let accessToken;
    if (header && header.substring(0, 7).toLowerCase().indexOf("bearer ") === 0) {
        accessToken = JSON.stringify({
            access_token: header.substring(7),
        });
    } else if (header && header.substring(0, 6).toLowerCase().indexOf("basic ") === 0) {
        const basic = Buffer.from(
                    header.substring(6),
                    "base64",
            ).toString("ascii");
        const split = basic.indexOf(":");
        return grantManager.obtainDirectly(
            basic.substring(0, split),
            basic.substring(split+1)
        ).then(async ([grant, headers]: [KeyCloak.Grant, Record<string, any>]) => grant);
    }
    if (gateContext.isDebugEnabled()) {
        gateContext.debug("Access Token Found %s", accessToken);
    }
    return accessToken
        ? grantManager.createGrant(accessToken).then((grant: KeyCloak.Grant) => grant)
        : null;
}

async function adminLogout(context: IContext, grantManager: GrantManager) {
    context.debug(
        "KeyCloak Admin Logout %s",
        context.params.text || context.params.json || context.params.raw,
    );
    const preToken = new Token(
        context.params.text || context.params.json || context.params.raw,
    );
    try {
        const signature = new Signature(grantManager.config);
        return signature
            .verify(preToken)
            .then((token) => {
                if (token.content.action === "LOGOUT") {
                    const sessionIDs = token.content.adapterSessionIds;
                    if (!sessionIDs) {
                        grantManager.notBefore =
                            token.content.notBefore;
                        context.response.writeHead(200);
                        context.response.end("ok");
                        return;
                    }
                    context.debug("KeyCloak logout %j", sessionIDs);
                    if (sessionIDs && sessionIDs.length > 0) {
                        let seen = 0;
                        sessionIDs.forEach((id) => {
                            context.gateContextPlugin.sessCtrl
                                .getSessionStore()
                                .destroy(id);
                            ++seen;
                            if (seen === sessionIDs.length) {
                                context.response.writeHead(200);
                                context.response.end("ok");
                            }
                        });
                    } else {
                        context.response.writeHead(200);
                        context.response.end("ok");
                    }
                } else {
                    context.response.writeHead(400);
                    context.response.end();
                }
            })
            .catch((err) => {
                context.response.writeHead(401);
                context.response.end(err.message);
            });
    } catch (err) {
        context.response.writeHead(400);
        context.response.end(err.message);
    }
}

async function adminNotBefore(context: IContext, grantManager: GrantManager) {
    context.debug(
        "KeyCloak Admin Not Before %s",
        context.params.text || context.params.json || context.params.raw,
    );
    const preToken = new Token(
        context.params.text || context.params.json || context.params.raw,
    );
    try {
        const signature = new Signature(grantManager.config);
        return signature
            .verify(preToken)
            .then((token) => {
                if (token.content.action === "PUSH_NOT_BEFORE") {
                    grantManager.notBefore =
                        token.content.notBefore;
                    context.response.writeHead(200);
                    context.response.end("ok");
                }
            })
            .catch((err) => {
                context.response.writeHead(401);
                context.response.end(err.message);
            });
    } catch (err) {
        context.response.writeHead(400);
        context.response.end(err.message);
    }
}

export async function Admin(
    context: IContext,
    grantManager: GrantManager,
    path: string,
) {
    context.debug("KeyCloak Admin path %s", path);
    switch (path) {
        case "k_logout":
            return adminLogout(context, grantManager);
        case "k_push_not_before":
            return adminNotBefore(context, grantManager);
        default:
            return;
    }
}
