import * as KeyClock from "keycloak-connect";
import * as Token from "keycloak-connect/middleware/auth-utils/token";
import * as Signature from "keycloak-connect/middleware/auth-utils/signature";
import IContext from "@ungate/plugininf/lib/IContext";
import { IRequestExtra, IKeyClockAuthParam } from "./KeyCloakAuth.types";

export async function PostAuth(
    gateContext: IContext,
    keycloak: KeyClock.Keycloak,
    data: IKeyClockAuthParam,
) {
    const request = gateContext.request as IRequestExtra;

    //  During the check SSO process the Keycloak server answered the user is not logged in
    if (data.query.error === "login_required") {
        return;
    }

    if (data.query.error) {
        return;
    }

    return keycloak
        .getGrantFromCode(
            data.query.code,
            request as any,
            gateContext.response as any,
        )
        .then((grant) => {
            request.kauth.grant = grant;
            try {
                keycloak.authenticated(request as any);
            } catch (err) {
                throw err;
            }
        });
}

export async function GrantAttacher(
    gateContext: IContext,
    keycloak: KeyClock.Keycloak,
) {
    return keycloak
        .getGrant(gateContext.request as any, gateContext.response as any)
        .then((grant) => {
            (gateContext.request as any).kauth.grant = grant;
        });
}

async function adminLogout(context: IContext, keycloak: KeyClock.Keycloak) {
    context.debug(
        "KeyClock Admin Logout %s",
        context.params.text || context.params.json || context.params.raw,
    );
    const preToken = new Token(
        context.params.text || context.params.json || context.params.raw,
    );
    try {
        const signature = new Signature((keycloak as any).config);
        return signature
            .verify(preToken)
            .then((token) => {
                if (token.content.action === "LOGOUT") {
                    const sessionIDs = token.content.adapterSessionIds;
                    if (!sessionIDs) {
                        (keycloak.grantManager as any).notBefore =
                            token.content.notBefore;
                        context.response.writeHead(200);
                        context.response.end("ok");
                        return;
                    }
                    context.debug("KeyClock logout %j", sessionIDs);
                    if (sessionIDs && sessionIDs.length > 0) {
                        let seen = 0;
                        sessionIDs.forEach((id) => {
                            context.gateContextPlugin.authController
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

async function adminNotBefore(context: IContext, keycloak: KeyClock.Keycloak) {
    context.debug(
        "KeyClock Admin Not Before %s",
        context.params.text || context.params.json || context.params.raw,
    );
    const preToken = new Token(
        context.params.text || context.params.json || context.params.raw,
    );
    try {
        const signature = new Signature((keycloak as any).config);
        return signature
            .verify(preToken)
            .then((token) => {
                if (token.content.action === "PUSH_NOT_BEFORE") {
                    (keycloak.grantManager as any).notBefore =
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
    keycloak: KeyClock.Keycloak,
    path: string,
) {
    context.debug("KeyClock Admin path %s", path);
    switch (path) {
        case "k_logout":
            return adminLogout(context, keycloak);
        case "k_push_not_before":
            return adminNotBefore(context, keycloak);
        default:
            return;
    }
}
