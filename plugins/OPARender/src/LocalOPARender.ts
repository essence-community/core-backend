import { IOPAEval, IOPARenderParams } from "./OPARender.types";
import { IRufusLogger } from "rufus";
import path = require("path");
import { spawn } from "child_process";
import * as fs from "fs";
import { IFile } from "@ungate/plugininf/lib/IContext";
import { deleteFolderRecursive } from "@ungate/plugininf/lib/util/Util";
import { isObject } from "lodash";

export class LocalOPARender implements IOPAEval {
    params: IOPARenderParams;
    log: IRufusLogger;
    constructor(params: IOPARenderParams, log: IRufusLogger) {
        this.params = params;
        this.log = log;
    }

    async eval(
        query: string[] | IFile[],
        dataFile: string[] | IFile[],
        input: Record<string, any> | Record<string, any>[],
    ) {
        return new Promise(async (resolve, reject) => {
            const temp = fs.mkdtempSync("opa_temp");
            const param = [];
            await Promise.all(
                (query as any).map(async (val: string | IFile, ind: number) => {
                    const namePath = path.join(temp, `query_${ind}.rego`);
                    await new Promise((resolveFile, rejectFile) => {
                        if (typeof val === "object") {
                            const inFile = fs.createReadStream(
                                (val as IFile).path,
                            );
                            inFile.pipe(fs.createWriteStream(namePath));
                            inFile.on("error", (err) => rejectFile(err));
                            inFile.on("end", () => resolveFile(true));
                        } else {
                            fs.writeFile(namePath, val, (err) => {
                                if (err) {
                                    return rejectFile(err);
                                }
                                resolveFile(true);
                            });
                        }
                    });
                    param.push("-d");
                    param.push(namePath);
                }),
            );
            await Promise.all(
                (dataFile as any).map(async (val, ind) => {
                    const namePath = path.join(temp, `data_${ind}.json`);
                    await new Promise((resolveFile, rejectFile) => {
                        if (typeof val === "object") {
                            const inFile = fs.createReadStream(
                                (val as IFile).path,
                            );
                            inFile.pipe(fs.createWriteStream(namePath));
                            inFile.on("error", (err) => rejectFile(err));
                            inFile.on("end", () => resolveFile(true));
                        } else {
                            fs.writeFile(namePath, val, (err) => {
                                if (err) {
                                    return rejectFile(err);
                                }
                                resolveFile(true);
                            });
                        }
                    });
                    param.push("-d");
                    param.push(namePath);
                }),
            );
            fs.writeFileSync(
                path.join(temp, "input.json"),
                JSON.stringify(input),
            );
            const opa = spawn(path.resolve(this.params.fvPath), [
                "eval",
                "-i",
                path.join(temp, "input.json"),
                ...param,
                `data[_]`,
            ]);
            let rawData = "";
            opa.stdout.on("data", (chunk) => {
                rawData += chunk;
            });
            opa.stderr.on("data", (data) => {
                this.log.error(data);
            });
            opa.on("exit", () => {
                try {
                    deleteFolderRecursive(temp);
                    const res = JSON.parse(rawData);
                    resolve(
                        res.result.reduce((result, value) => {
                            return [
                                ...result,
                                ...value.expressions
                                    .filter(
                                        (valExp) =>
                                            (isObject(valExp.value) && !Array.isArray(valExp.value) && Object.keys(valExp.value).length) ||
                                            (Array.isArray(valExp.value) &&
                                                isObject(valExp.value[0])),
                                    )
                                    .reduce(
                                        (resExp, valExp) => [
                                            ...resExp,
                                            ...(Array.isArray(valExp.value)
                                                ? valExp.value
                                                : [valExp.value]),
                                        ],
                                        [],
                                    ),
                            ];
                        }, []),
                    );
                } catch (e) {
                    reject(e);
                }
            });
        });
    }
}
