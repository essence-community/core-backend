import Connection from "@ungate/plugininf/lib/db/Connection";
import * as fs from "fs";
import * as path from "path";
import { IJson } from "../Patcher.types";
import {
    closeFsWriteStream,
    createChangeXml,
    createWriteStream,
} from "../Utils";
import { Lang } from "./Lang";
import { Localization } from "./Localization";
import { LocalizationPage } from "./LocalizationPage";
import { Message } from "./Message";
import { MObject } from "./MObject";
import { ObjectAttr } from "./ObjectAttr";
import { Page } from "./Page";
import { PageAction } from "./PageAction";
import { PageObject } from "./PageObject";
import { PageObjectAttr } from "./PageObjectAttr";
import { PageObjectMaster } from "./PageObjectMaster";
import { PageVariable } from "./PageVariable";
import { Provider } from "./Provider";
import { Query } from "./Query";
import {
    sqlDLang,
    sqlLocalization,
    sqlLocalizationMessage,
    sqlLocalizationPage,
    sqlMessage,
    sqlObject,
    sqlObjectAttr,
    sqlPage,
    sqlPageAction,
    sqlPageObject,
    sqlPageObjectAttr,
    sqlPageObjectMaster,
    sqlPageVariable,
    sqlProvider,
    sqlQuery,
    sqlQueryPage,
    sqlSysSetting,
} from "./SqlPostgres";
import { SysSetting } from "./SysSetting";

export async function patchMeta(dir: string, json: IJson, conn: Connection) {
    const includePage: string[] = [];
    const includeQuery: string[] = [];
    const include: string[] = [];
    const meta = path.join(dir, "meta");
    if (!fs.existsSync(meta)) {
        fs.mkdirSync(meta);
    }
    if (json.data.cct_sys_setting) {
        const sysSetting = createWriteStream(meta, "SysSetting_meta");
        include.push("SysSetting_meta");
        await conn
            .executeStmt(
                sqlSysSetting,
                {
                    cct_sys_setting: JSON.stringify(json.data.cct_sys_setting),
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
                            sysSetting.write(new SysSetting(row).toRow());
                        });
                        res.stream.on("error", (err) => reject(err));
                        res.stream.on("end", () => resolve());
                    }),
            );
        await closeFsWriteStream(sysSetting);
    }
    if (json.data.cct_message) {
        const message = createWriteStream(meta, "Message");
        include.push("Message");
        await conn
            .executeStmt(
                sqlMessage,
                {
                    cct_message: JSON.stringify(json.data.cct_message),
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
                            message.write(new Message(row).toRow());
                        });
                        res.stream.on("error", (err) => reject(err));
                        res.stream.on("end", () => resolve());
                    }),
            );
        await conn
            .executeStmt(
                sqlLocalizationMessage,
                {},
                {},
                {
                    autoCommit: true,
                    resultSet: true,
                },
            )
            .then(
                (res) =>
                    new Promise((resolve, reject) => {
                        let isNotFirst = false;
                        res.stream.on("data", (row) => {
                            if (isNotFirst) {
                                message.write("    union all\n");
                            } else {
                                message.write(
                                    "INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)\n" +
                                        "select t.ck_id, t.ck_d_lang, t.cr_namespace, t.cv_value, t.ck_user, t.ct_change::timestamp from (\n",
                                );
                                isNotFirst = true;
                            }
                            message.write(new LocalizationPage(row).toRow());
                        });
                        res.stream.on("error", (err) => reject(err));
                        res.stream.on("end", () => {
                            if (isNotFirst) {
                                message.write(
                                    ") as t \n" +
                                        " join s_mt.t_d_lang dl\n" +
                                        " on t.ck_d_lang = dl.ck_id\n" +
                                        "on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;",
                                );
                            }
                            resolve();
                        });
                    }),
            );
        await closeFsWriteStream(message);
    }
    if (json.data.cct_lang) {
        const lang: { [key: string]: fs.WriteStream } = {};
        await conn
            .executeStmt(
                sqlDLang,
                {
                    cct_lang: JSON.stringify(json.data.cct_lang),
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
                            lang[row.ck_id] = createWriteStream(
                                meta,
                                `Localization_${row.ck_id}`,
                            );
                            lang[row.ck_id].write(new Lang(row).toRow());
                            include.push(`Localization_${row.ck_id}`);
                        });
                        res.stream.on("error", (err) => reject(err));
                        res.stream.on("end", () => resolve());
                    }),
            );
        await conn
            .executeStmt(
                sqlLocalization,
                {
                    cct_lang: JSON.stringify(json.data.cct_lang),
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
                            lang[row.ck_d_lang].write(
                                new Localization(row).toRow(),
                            );
                        });
                        res.stream.on("error", (err) => reject(err));
                        res.stream.on("end", () => resolve());
                    }),
            );
        await Promise.all(
            Object.values(lang).map((f) => closeFsWriteStream(f)),
        );
    }
    if (json.data.cct_page) {
        const page: { [key: string]: fs.WriteStream } = {};
        const resPage = await conn.executeStmt(
            sqlPage,
            {
                cct_page: JSON.stringify(json.data.cct_page),
            },
            {},
            {
                autoCommit: true,
                resultSet: true,
            },
        );
        await new Promise((resolve, reject) => {
            resPage.stream.on("data", (row) => {
                page[row.ck_id] = createWriteStream(
                    path.resolve(meta, "page"),
                    `Page_${row.ck_id}`,
                );
                if (parseInt(row.cr_type, 10) === 2) {
                    page[row.ck_id].write(
                        `select pkg_patcher.p_remove_page('${row.ck_id}');\n`,
                    );
                }
                page[row.ck_id].write(new Page(row).toRow());
                includePage.push(`Page_${row.ck_id}`);
            });
            resPage.stream.on("error", (err) => reject(err));
            resPage.stream.on("end", () => resolve());
        });
        await conn
            .executeStmt(
                sqlPageAction,
                {
                    cct_page: JSON.stringify(json.data.cct_page),
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
                            page[row.ck_page].write(
                                new PageAction(row).toRow(),
                            );
                        });
                        res.stream.on("error", (err) => reject(err));
                        res.stream.on("end", () => resolve());
                    }),
            );
        await conn
            .executeStmt(
                sqlPageVariable,
                {
                    cct_page: JSON.stringify(json.data.cct_page),
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
                            page[row.ck_page].write(
                                new PageVariable(row).toRow(),
                            );
                        });
                        res.stream.on("error", (err) => reject(err));
                        res.stream.on("end", () => resolve());
                    }),
            );
        await conn
            .executeStmt(
                sqlObject,
                {
                    cct_page: JSON.stringify(json.data.cct_page),
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
                            page[row.ck_page].write(new MObject(row).toRow());
                        });
                        res.stream.on("error", (err) => reject(err));
                        res.stream.on("end", () => resolve());
                    }),
            );
        await conn
            .executeStmt(
                sqlObjectAttr,
                {
                    cct_page: JSON.stringify(json.data.cct_page),
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
                            page[row.ck_page].write(
                                new ObjectAttr(row).toRow(),
                            );
                        });
                        res.stream.on("error", (err) => reject(err));
                        res.stream.on("end", () => resolve());
                    }),
            );
        await conn
            .executeStmt(
                sqlPageObject,
                {
                    cct_page: JSON.stringify(json.data.cct_page),
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
                            page[row.ck_page].write(
                                new PageObject(row).toRow(),
                            );
                        });
                        res.stream.on("error", (err) => reject(err));
                        res.stream.on("end", () => resolve());
                    }),
            );
        await conn
            .executeStmt(
                sqlPageObjectAttr,
                {
                    cct_page: JSON.stringify(json.data.cct_page),
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
                            page[row.ck_page].write(
                                new PageObjectAttr(row).toRow(),
                            );
                        });
                        res.stream.on("error", (err) => reject(err));
                        res.stream.on("end", () => resolve());
                    }),
            );
        await conn
            .executeStmt(
                sqlPageObjectMaster,
                {
                    cct_page: JSON.stringify(json.data.cct_page),
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
                            page[row.ck_page].write(
                                new PageObjectMaster(row).toRow(),
                            );
                        });
                        res.stream.on("error", (err) => reject(err));
                        res.stream.on("end", () => resolve());
                    }),
            );
        await conn
            .executeStmt(
                sqlLocalizationPage,
                {
                    cct_page: JSON.stringify(json.data.cct_page),
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
                        const ckPages: Record<string, boolean> = {};
                        res.stream.on("data", (row) => {
                            if (ckPages[row.ck_page]) {
                                page[row.ck_page].write("    union all\n");
                            } else {
                                page[row.ck_page].write(
                                    "INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)\n" +
                                        "select t.ck_id, t.ck_d_lang, t.cr_namespace, t.cv_value, t.ck_user, t.ct_change::timestamp from (\n",
                                );
                                ckPages[row.ck_page] = true;
                            }
                            page[row.ck_page].write(
                                new LocalizationPage(row).toRow(),
                            );
                        });
                        res.stream.on("error", (err) => reject(err));
                        res.stream.on("end", () => {
                            Object.keys(ckPages).forEach((key) => {
                                page[key].write(
                                    ") as t \n" +
                                        " join s_mt.t_d_lang dl\n" +
                                        " on t.ck_d_lang = dl.ck_id\n" +
                                        "on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;",
                                );
                            });
                            resolve();
                        });
                    }),
            );
        await conn
            .executeStmt(
                sqlQueryPage,
                {
                    cct_page: JSON.stringify(json.data.cct_page),
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
                        const query: string[] = [];
                        res.stream.on("data", (row) => {
                            query.push(row.ck_query);
                        });
                        res.stream.on("error", (err) => reject(err));
                        res.stream.on("end", () => {
                            json.data.cct_query = [
                                ...(json.data.cct_query || []),
                                ...query,
                            ];
                            resolve();
                        });
                    }),
            );
        await Promise.all(
            Object.values(page).map((f) => closeFsWriteStream(f)),
        );
    }
    if (json.data.cct_query) {
        const provider: { [key: string]: fs.WriteStream } = {};
        await conn
            .executeStmt(
                sqlProvider,
                {
                    cct_query: JSON.stringify(json.data.cct_query),
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
                            provider[row.ck_id] = createWriteStream(
                                path.resolve(meta, "query"),
                                `Provider_${row.ck_id}`,
                            );
                            provider[row.ck_id].write(
                                new Provider(row).toRow(),
                            );
                            includeQuery.push(`Provider_${row.ck_id}`);
                        });
                        res.stream.on("error", (err) => reject(err));
                        res.stream.on("end", () => resolve());
                    }),
            );
        await conn
            .executeStmt(
                sqlQuery,
                {
                    cct_query: JSON.stringify(json.data.cct_query),
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
                        const rows = [];
                        res.stream.on("data", (row) => {
                            const queryStream = createWriteStream(
                                path.resolve(meta, "query"),
                                `${row.ck_id}`,
                            );
                            queryStream.write(new Query(row).toRow());
                            includeQuery.push(`${row.ck_id}`);
                            rows.push(closeFsWriteStream(queryStream));
                        });
                        res.stream.on("error", (err) => reject(err));
                        res.stream.on("end", () =>
                            Promise.all(rows).then(
                                () => resolve(),
                                (err) => reject(err),
                            ),
                        );
                    }),
            );
        await Promise.all(
            Object.values(provider).map((f) => closeFsWriteStream(f)),
        );
    }

    if (includeQuery.length) {
        await createChangeXml(
            path.join(meta, "query", "query.xml"),
            includeQuery.map(
                (str) =>
                    `        <include file="${str}.sql" relativeToChangelogFile="true" />\n`,
            ),
        );
    }

    if (includePage.length) {
        await createChangeXml(
            path.join(meta, "page", "page.xml"),
            includePage.map(
                (str) =>
                    `        <include file="${str}.sql" relativeToChangelogFile="true" />\n`,
            ),
        );
    }

    return createChangeXml(path.join(meta, "meta.xml"), [
        ...include.map(
            (str) =>
                `        <include file="${str}.sql" relativeToChangelogFile="true" />\n`,
        ),
        includeQuery.length
            ? '        <include file="query/query.xml" relativeToChangelogFile="true" />\n'
            : "",
        includePage.length
            ? '        <include file="page/page.xml" relativeToChangelogFile="true" />\n'
            : "",
    ]);
}
