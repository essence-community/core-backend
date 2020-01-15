import Connection from "@ungate/plugininf/lib/db/Connection";
import * as fs from "fs";
import * as path from "path";
import { IJson } from "../Patcher.types";
import {
    closeFsWriteStream,
    createChangeXml,
    createWriteStream,
} from "../Utils";
import { Account } from "./Account";
import { AccountInfo } from "./AccountInfo";
import { AccountRole } from "./AccountRole";
import { Action } from "./Action";
import { Info } from "./Info";
import { Role } from "./Role";
import { RoleAction } from "./RoleAction";
import {
    sqlAccount,
    sqlAccountInfo,
    sqlAccountRole,
    sqlAction,
    sqlInfo,
    sqlRole,
    sqlRoleAction,
} from "./SqlPostgres";

export async function patchAuth(dir: string, json: IJson, conn: Connection) {
    const include: string[] = [];
    const meta = path.join(dir, "auth");
    if (!fs.existsSync(meta)) {
        fs.mkdirSync(meta);
    }
    if (json.data.cct_info) {
        const info = createWriteStream(meta, "Info");
        include.push("Info");
        await conn
            .executeStmt(
                sqlInfo,
                {
                    cct_info: JSON.stringify(json.data.cct_info),
                },
                {},
                {
                    autoCommit: true,
                    resultSet: true,
                },
            )
            .then(
                (res) =>
                    new Promise((resolve, reject) => {
                        res.stream.on("data", (row) => {
                            info.write(new Info(row).toRow());
                        });
                        res.stream.on("error", (err) => reject(err));
                        res.stream.on("end", () => resolve());
                    }),
            );
        await closeFsWriteStream(info);
    }
    if (json.data.cct_action) {
        const action = createWriteStream(meta, "Action");
        include.push("Action");
        await conn
            .executeStmt(
                sqlAction,
                {
                    cct_action: JSON.stringify(json.data.cct_action),
                },
                {},
                {
                    autoCommit: true,
                    resultSet: true,
                },
            )
            .then(
                (res) =>
                    new Promise((resolve, reject) => {
                        res.stream.on("data", (row) => {
                            action.write(new Action(row).toRow());
                        });
                        res.stream.on("error", (err) => reject(err));
                        res.stream.on("end", () => resolve());
                    }),
            );
        await closeFsWriteStream(action);
    }
    if (json.data.cct_role) {
        const role = createWriteStream(meta, "Role");
        include.push("Role");
        await conn
            .executeStmt(
                sqlRole,
                {
                    cct_role: JSON.stringify(json.data.cct_role),
                },
                {},
                {
                    autoCommit: true,
                    resultSet: true,
                },
            )
            .then(
                (res) =>
                    new Promise((resolve, reject) => {
                        res.stream.on("data", (row) => {
                            role.write(new Role(row).toRow());
                        });
                        res.stream.on("error", (err) => reject(err));
                        res.stream.on("end", () => resolve());
                    }),
            );
        await conn
            .executeStmt(
                sqlRoleAction,
                {
                    cct_action: JSON.stringify(json.data.cct_action || "[]"),
                    cct_role: JSON.stringify(json.data.cct_role),
                },
                {},
                {
                    autoCommit: true,
                    resultSet: true,
                },
            )
            .then(
                (res) =>
                    new Promise((resolve, reject) => {
                        res.stream.on("data", (row) => {
                            role.write(new RoleAction(row).toRow());
                        });
                        res.stream.on("error", (err) => reject(err));
                        res.stream.on("end", () => resolve());
                    }),
            );
        await closeFsWriteStream(role);
    }
    if (json.data.cct_account) {
        const account = createWriteStream(meta, "Account");
        include.push("Account");
        await conn
            .executeStmt(
                sqlAccount,
                {
                    cct_account: JSON.stringify(json.data.cct_account),
                },
                {},
                {
                    autoCommit: true,
                    resultSet: true,
                },
            )
            .then(
                (res) =>
                    new Promise((resolve, reject) => {
                        res.stream.on("data", (row) => {
                            account.write(new Account(row).toRow());
                        });
                        res.stream.on("error", (err) => reject(err));
                        res.stream.on("end", () => resolve());
                    }),
            );
        await conn
            .executeStmt(
                sqlAccountRole,
                {
                    cct_account: JSON.stringify(json.data.cct_account),
                    cct_role: JSON.stringify(json.data.cct_role || "[]"),
                },
                {},
                {
                    autoCommit: true,
                    resultSet: true,
                },
            )
            .then(
                (res) =>
                    new Promise((resolve, reject) => {
                        res.stream.on("data", (row) => {
                            account.write(new AccountRole(row).toRow());
                        });
                        res.stream.on("error", (err) => reject(err));
                        res.stream.on("end", () => resolve());
                    }),
            );
        await conn
            .executeStmt(
                sqlAccountInfo,
                {
                    cct_account: JSON.stringify(json.data.cct_account),
                    cct_info: JSON.stringify(json.data.cct_info || "[]"),
                },
                {},
                {
                    autoCommit: true,
                    resultSet: true,
                },
            )
            .then(
                (res) =>
                    new Promise((resolve, reject) => {
                        res.stream.on("data", (row) => {
                            account.write(new AccountInfo(row).toRow());
                        });
                        res.stream.on("error", (err) => reject(err));
                        res.stream.on("end", () => resolve());
                    }),
            );
        await closeFsWriteStream(account);
    }
    return createChangeXml(
        path.join(meta, "auth.xml"),
        include.map((str) => `        <include file="./auth/${str}.sql" />\n`),
    );
}
