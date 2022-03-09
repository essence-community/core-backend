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
import { sqlActionRole, sqlInfoAccount } from "./SqlPostgres";
import {
    sqlAccount,
    sqlAccountInfo,
    sqlAccountRole,
    sqlAction,
    sqlInfo,
    sqlRole,
    sqlRoleAccount,
    sqlRoleAction,
} from "./SqlPostgres";

export async function patchUser(dir: string, json: IJson, conn: Connection) {
    const include: string[] = [];
    const meta = path.join(dir, "user");
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
                    new Promise<void>((resolve, reject) => {
                        res.stream.on("data", (row) => {
                            info.write(new Info(row).toRow());
                        });
                        res.stream.on("error", (err) => reject(err));
                        res.stream.on("end", () => resolve());
                    }),
            );
        await conn
            .executeStmt(
                sqlInfoAccount,
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
                    new Promise<void>((resolve, reject) => {
                        let isNotFirst = false;

                        res.stream.on("data", (row) => {
                            if (isNotFirst) {
                                info.write("        union all\n");
                            } else {
                                info.write(
                                    "INSERT INTO s_at.t_account_info (ck_id, ck_account, ck_d_info, cv_value, ck_user, ct_change)\n" +
                                        "    select t.ck_id, t.ck_account, t.ck_d_info, t.cv_value, t.ck_user, t.ct_change::timestamp from (\n",
                                );
                                isNotFirst = true;
                            }
                            info.write(new AccountInfo(row).toRow());
                        });
                        res.stream.on("error", (err) => reject(err));
                        res.stream.on("end", () => {
                            if (isNotFirst) {
                                info.write(
                                    ") as t \n" +
                                        " join s_at.t_account ac\n" +
                                        " on t.ck_account = ac.ck_id\n" +
                                        "on conflict on constraint cin_u_account_info_1 do update set ck_id = excluded.ck_id, ck_account = excluded.ck_account, ck_d_info = excluded.ck_d_info, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;\n",
                                );
                            }
                            resolve();
                        });
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
                    new Promise<void>((resolve, reject) => {
                        res.stream.on("data", (row) => {
                            action.write(new Action(row).toRow());
                        });
                        res.stream.on("error", (err) => reject(err));
                        res.stream.on("end", () => resolve());
                    }),
            );
        await conn
            .executeStmt(
                sqlActionRole,
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
                    new Promise<void>((resolve, reject) => {
                        let isNotFirst = false;

                        res.stream.on("data", (row) => {
                            if (isNotFirst) {
                                action.write("        union all\n");
                            } else {
                                action.write(
                                    "INSERT INTO s_at.t_role_action (ck_id, ck_action, ck_role, ck_user, ct_change)\n" +
                                        "    select t.ck_id, t.ck_action, t.ck_role, t.ck_user, t.ct_change::timestamp from (",
                                );
                                isNotFirst = true;
                            }
                            action.write(new RoleAction(row).toRow());
                        });
                        res.stream.on("error", (err) => reject(err));
                        res.stream.on("end", () => {
                            if (isNotFirst) {
                                action.write(
                                    ") as t \n" +
                                        " join s_at.t_role r\n" +
                                        " on t.ck_role = r.ck_id\n" +
                                        "on conflict on constraint cin_u_role_action_1 do update set ck_id = excluded.ck_id, ck_action = excluded.ck_action, ck_role = excluded.ck_role, ck_user = excluded.ck_user, ct_change = excluded.ct_change;\n",
                                );
                            }
                            resolve();
                        });
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
                    new Promise<void>((resolve, reject) => {
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
                },
                {},
                {
                    autoCommit: true,
                    resultSet: true,
                },
            )
            .then(
                (res) =>
                    new Promise<void>((resolve, reject) => {
                        let isNotFirst = false;

                        res.stream.on("data", (row) => {
                            if (isNotFirst) {
                                role.write("        union all\n");
                            } else {
                                role.write(
                                    "INSERT INTO s_at.t_role_action (ck_id, ck_action, ck_role, ck_user, ct_change)\n" +
                                        "    select t.ck_id, t.ck_action, t.ck_role, t.ck_user, t.ct_change::timestamp from (",
                                );
                                isNotFirst = true;
                            }
                            role.write(new RoleAction(row).toRow());
                        });
                        res.stream.on("error", (err) => reject(err));
                        res.stream.on("end", () => {
                            if (isNotFirst) {
                                role.write(
                                    ") as t \n" +
                                        " join s_at.t_action ac\n" +
                                        " on t.ck_action = ac.ck_id\n" +
                                        "on conflict on constraint cin_u_role_action_1 do update set ck_id = excluded.ck_id, ck_action = excluded.ck_action, ck_role = excluded.ck_role, ck_user = excluded.ck_user, ct_change = excluded.ct_change;\n",
                                );
                            }
                            resolve();
                        });
                    }),
            );
        await conn
            .executeStmt(
                sqlRoleAccount,
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
                    new Promise<void>((resolve, reject) => {
                        let isNotFirst = false;

                        res.stream.on("data", (row) => {
                            if (isNotFirst) {
                                role.write("        union all\n");
                            } else {
                                role.write(
                                    "INSERT INTO s_at.t_account_role (ck_id, ck_role, ck_account, ck_user, ct_change)\n" +
                                        "    select t.ck_id, t.ck_role, t.ck_account, t.ck_user, t.ct_change::timestamp from (\n",
                                );
                                isNotFirst = true;
                            }
                            role.write(new AccountRole(row).toRow());
                        });
                        res.stream.on("error", (err) => reject(err));
                        res.stream.on("end", () => {
                            if (isNotFirst) {
                                role.write(
                                    ") as t \n" +
                                        " join s_at.t_account ac\n" +
                                        " on t.ck_account = ac.ck_id\n" +
                                        "on conflict on constraint cin_u_account_role_1 do update set ck_id = excluded.ck_id, ck_account = excluded.ck_account, ck_role = excluded.ck_role, ck_user = excluded.ck_user, ct_change = excluded.ct_change;\n",
                                );
                            }
                            resolve();
                        });
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
                    new Promise<void>((resolve, reject) => {
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
                },
                {},
                {
                    autoCommit: true,
                    resultSet: true,
                },
            )
            .then(
                (res) =>
                    new Promise<void>((resolve, reject) => {
                        let isNotFirst = false;

                        res.stream.on("data", (row) => {
                            if (isNotFirst) {
                                account.write("        union all\n");
                            } else {
                                account.write(
                                    "INSERT INTO s_at.t_account_role (ck_id, ck_role, ck_account, ck_user, ct_change)\n" +
                                        "    select t.ck_id, t.ck_role, t.ck_account, t.ck_user, t.ct_change::timestamp from (\n",
                                );
                                isNotFirst = true;
                            }
                            account.write(new AccountRole(row).toRow());
                        });
                        res.stream.on("error", (err) => reject(err));
                        res.stream.on("end", () => {
                            if (isNotFirst) {
                                account.write(
                                    ") as t \n" +
                                        " join s_at.t_role r\n" +
                                        " on t.ck_role = r.ck_id\n" +
                                        "on conflict on constraint cin_u_account_role_1 do update set ck_id = excluded.ck_id, ck_account = excluded.ck_account, ck_role = excluded.ck_role, ck_user = excluded.ck_user, ct_change = excluded.ct_change;\n",
                                );
                            }
                            resolve();
                        });
                    }),
            );
        await conn
            .executeStmt(
                sqlAccountInfo,
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
                    new Promise<void>((resolve, reject) => {
                        let isNotFirst = false;

                        res.stream.on("data", (row) => {
                            if (isNotFirst) {
                                account.write("        union all\n");
                            } else {
                                account.write(
                                    "INSERT INTO s_at.t_account_info (ck_id, ck_account, ck_d_info, cv_value, ck_user, ct_change)\n" +
                                        "    select t.ck_id, t.ck_account, t.ck_d_info, t.cv_value, t.ck_user, t.ct_change::timestamp from (\n",
                                );
                                isNotFirst = true;
                            }
                            account.write(new AccountInfo(row).toRow());
                        });
                        res.stream.on("error", (err) => reject(err));
                        res.stream.on("end", () => {
                            if (isNotFirst) {
                                account.write(
                                    ") as t \n" +
                                        " join s_at.t_d_info inf\n" +
                                        " on t.ck_d_info = inf.ck_id\n" +
                                        "on conflict on constraint cin_u_account_info_1 do update set ck_id = excluded.ck_id, ck_account = excluded.ck_account, ck_d_info = excluded.ck_d_info, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;\n",
                                );
                            }
                            resolve();
                        });
                    }),
            );
        await closeFsWriteStream(account);
    }
    return createChangeXml(
        path.join(meta, "user.xml"),
        include.map(
            (str) =>
                `        <include file="${str}.sql" relativeToChangelogFile="true" />\n`,
        ),
    );
}
