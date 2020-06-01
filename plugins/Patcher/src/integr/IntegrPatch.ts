import Connection from "@ungate/plugininf/lib/db/Connection";
import * as fs from "fs";
import * as path from "path";
import { IJson } from "../Patcher.types";
import {
    closeFsWriteStream,
    createChangeXml,
    createWriteStream,
} from "../Utils";
import { Interface } from "./Interface";
import { Provider } from "./Provider";
import { sqlInterface, sqlProvider } from "./SqlPostgres";

export async function patchIntegr(dir: string, json: IJson, conn: Connection) {
    const include: string[] = [];
    const meta = path.join(dir, "integr");
    if (!fs.existsSync(meta)) {
        fs.mkdirSync(meta);
    }
    if (json.data.cct_interface) {
        const integr = createWriteStream(meta, "Interface");
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
                            integr.write(new Provider(row).toRow());
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
                            integr.write(new Interface(row).toRow());
                        });
                        res.stream.on("error", (err) => reject(err));
                        res.stream.on("end", () => resolve());
                    }),
            );
        await closeFsWriteStream(integr);
    }
    return createChangeXml(
        path.join(meta, "integr.xml"),
        include.map(
            (str) =>
                `        <include file="${str}.sql" relativeToChangelogFile="true" />\n`,
        ),
    );
}
