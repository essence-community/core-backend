import Connection from "@ungate/plugininf/lib/db/Connection";
import * as fs from "fs";
import * as path from "path";
import { IJson } from "../Patcher.types";
import {
    sqlInfo,
    sqlAction,
    sqlRole,
    sqlRoleAction,
    sqlAccount,
    sqlAccountRole,
    sqlAccountInfo,
} from "./SqlPostgres";
import { Info } from "./Info";
import { Action } from "./Action";
import { Role } from "./Role";
import { RoleAction } from "./RoleAction";
import { Account } from "./Account";
import { AccountRole } from "./AccountRole";
import { AccountInfo } from "./AccountInfo";

function createWriteStream(dir: string, name: string) {
    const stream = fs.createWriteStream(path.join(dir, name + ".sql"));
    stream.write("--liquibase formatted sql\n");
    stream.write(
        `--changeset patcher-core:${name} dbms:postgresql runOnChange:true splitStatements:false stripComments:false\n`,
    );
    return stream;
}

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
        await new Promise((resolve, reject) => {
            info.end((err) => {
                if (err) {
                    return reject(err);
                }
                info.close();
                resolve();
            });
        });
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
        await new Promise((resolve, reject) => {
            action.end((err) => {
                if (err) {
                    return reject(err);
                }
                action.close();
                resolve();
            });
        });
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
                    cct_role: JSON.stringify(json.data.cct_role),
                    cct_action: JSON.stringify(json.data.cct_action || "[]"),
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
        await new Promise((resolve, reject) => {
            role.end((err) => {
                if (err) {
                    return reject(err);
                }
                role.close();
                resolve();
            });
        });
    }
    if (json.data.cct_role) {
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
                    cct_role: JSON.stringify(json.data.cct_role || "[]"),
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
                    cct_info: JSON.stringify(json.data.cct_info || "[]"),
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
                            account.write(new AccountInfo(row).toRow());
                        });
                        res.stream.on("error", (err) => reject(err));
                        res.stream.on("end", () => resolve());
                    }),
            );
        await new Promise((resolve, reject) => {
            account.end((err) => {
                if (err) {
                    return reject(err);
                }
                account.close();
                resolve();
            });
        });
    }
    return new Promise((resolve, reject) => {
        fs.writeFile(
            path.join(meta, "auth.xml"),
            '<?xml version="1.0" encoding="UTF-8"?>\n' +
                "<databaseChangeLog\n" +
                '  xmlns="http://www.liquibase.org/xml/ns/dbchangelog"\n' +
                '  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"\n' +
                '  xsi:schemaLocation="http://www.liquibase.org/xml/ns/dbchangelog\n' +
                '         http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-3.1.xsd">\n' +
                include.reduce((res, str) => {
                    return `${res}        <include file="./auth/${str}.sql" />\n`;
                }, "") +
                "</databaseChangeLog>",
            (err) => {
                if (err) {
                    return reject(err);
                }
                resolve();
            },
        );
    });
}
