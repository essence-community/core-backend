import { IOPAEval, IOPARenderParams } from "./OPARender.types";
import { IRufusLogger } from "rufus";
import path = require("path");
import { spawn } from "child_process";
import * as fs from "fs";
import { IFile } from "@ungate/plugininf/lib/IContext";
import { deleteFolderRecursive } from "@ungate/plugininf/lib/util/Util";
import { isObject, isString } from "lodash";
import { deepParam } from "./Util";

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
        input: string | Record<string, any> | Record<string, any>[] | IFile,
        queryString: string,
        resultPath: string,
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
            const inputName = path.join(temp, `input.json`);
            await new Promise((resolveFile, rejectFile) => {
                if (typeof input === "object" && (input as IFile).path) {
                    const inFile = fs.createReadStream((input as IFile).path);
                    inFile.pipe(fs.createWriteStream(inputName));
                    inFile.on("error", (err) => rejectFile(err));
                    inFile.on("end", () => resolveFile(true));
                } else {
                    fs.writeFile(
                        inputName,
                        isString(input) ? input : JSON.stringify(input),
                        (err) => {
                            if (err) {
                                return rejectFile(err);
                            }
                            resolveFile(true);
                        },
                    );
                }
            });
            const opa = spawn(path.resolve(this.params.fvPath), [
                "eval",
                "-i",
                inputName,
                ...param,
                `--stdin`,
            ]);
            opa.stdin.end(queryString);
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
                    resolve(deepParam(resultPath, res));
                } catch (e) {
                    reject(e);
                }
            });
        });
    }
}
