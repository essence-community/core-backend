import Connection from "@ungate/plugininf/lib/db/Connection";
import * as fs from "fs";
import * as path from "path";
import { IJson } from "../Patcher.types";
import { sqlProvider, sqlInterface } from "./SqlPostgres";
import { Interface } from "./Interface";
import { Provider } from "./Provider";

function createWriteStream(dir: string, name: string) {
    const stream = fs.createWriteStream(path.join(dir, name + ".sql"));
    stream.write("--liquibase formatted sql\n");
    stream.write(
        `--changeset patcher-core:${name} dbms:postgresql runOnChange:true splitStatements:false stripComments:false\n`,
    );
    return stream;
}

export async function patchIntegr(dir: string, json: IJson, conn: Connection) {
    const include: string[] = [];
    const meta = path.join(dir, "integr");
    if (!fs.existsSync(meta)) {
        fs.mkdirSync(meta);
    }
    if (json.data.cct_interface) {
        const info = createWriteStream(meta, "Interface");
        include.push("Interface");
        await conn
            .executeStmt(
                sqlProvider,
                {
                    cct_interface: JSON.stringify(json.data.cct_interface),
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
                            info.write(new Provider(row).toRow());
                        });
                        res.stream.on("error", (err) => reject(err));
                        res.stream.on("end", () => resolve());
                    }),
            );
        await conn
            .executeStmt(
                sqlInterface,
                {
                    cct_interface: JSON.stringify(json.data.cct_interface),
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
                            info.write(new Interface(row).toRow());
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

    return new Promise((resolve, reject) => {
        fs.writeFile(
            path.join(meta, "integr.xml"),
            '<?xml version="1.0" encoding="UTF-8"?>\n' +
                "<databaseChangeLog\n" +
                '  xmlns="http://www.liquibase.org/xml/ns/dbchangelog"\n' +
                '  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"\n' +
                '  xsi:schemaLocation="http://www.liquibase.org/xml/ns/dbchangelog\n' +
                '         http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-3.1.xsd">\n' +
                include.reduce((res, str) => {
                    return `${res}        <include file="./integr/${str}.sql" />\n`;
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
