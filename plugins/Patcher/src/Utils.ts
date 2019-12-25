import * as fs from "fs";
import * as path from "path";

export function createWriteStream(dir: string, name: string) {
    const stream = fs.createWriteStream(path.join(dir, name + ".sql"));
    stream.write("--liquibase formatted sql\n");
    stream.write(
        `--changeset patcher-core:${name} dbms:postgresql runOnChange:true splitStatements:false stripComments:false\n`,
    );
    return stream;
}

export function closeFsWriteStream(stream: fs.WriteStream): Promise<void> {
    return new Promise((resolve, reject) => {
        stream.end((err) => {
            if (err) {
                return reject(err);
            }
            stream.close();
            resolve();
        });
    });
}

export function createChangeXml(pathFile: string, include: string[]) {
    return new Promise((resolve, reject) => {
        fs.writeFile(
            pathFile,
            '<?xml version="1.0" encoding="UTF-8"?>\n' +
                "<databaseChangeLog\n" +
                '  xmlns="http://www.liquibase.org/xml/ns/dbchangelog"\n' +
                '  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"\n' +
                '  xsi:schemaLocation="http://www.liquibase.org/xml/ns/dbchangelog\n' +
                '         http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-3.1.xsd">\n' +
                include.join("") +
                "\n</databaseChangeLog>",
            (err) => {
                if (err) {
                    return reject(err);
                }
                resolve();
            },
        );
    });
}
