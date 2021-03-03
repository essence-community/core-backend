import { IOPAEval, IOPARenderParams } from "./OPARender.types";
import { IRufusLogger } from "rufus";
import path = require("path");
import { spawn } from "child_process";
import * as fs from "fs";
import { IFile } from "@ungate/plugininf/lib/IContext";
import { deleteFolderRecursive } from "@ungate/plugininf/lib/util/Util";
import { isString } from "lodash";
import { deepParam } from "@ungate/plugininf/lib/util/deepParam";
import { IEncoder } from "./Encoder.types";
import { YAMLEncoder } from "./YAMLEncoder";
import { XMLEncoder } from "./XMLEncoder";

export class LocalOPARender implements IOPAEval {
    params: IOPARenderParams;
    log: IRufusLogger;
    encoder: Record<"yaml" | "xml", IEncoder>;
    constructor(params: IOPARenderParams, log: IRufusLogger) {
        this.params = params;
        this.log = log;
        this.encoder = {
            yaml: new YAMLEncoder(this.params),
            xml: new XMLEncoder(this.params),
        };
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
            await new Promise(async (resolveFile, rejectFile) => {
                if (typeof input === "object" && (input as IFile).path) {
                    let fileTemp = (input as IFile).path;
                    const nameFile = (input as IFile).originalFilename;
                    if (
                        fileTemp.toLocaleLowerCase().endsWith("yaml") ||
                        fileTemp.toLocaleLowerCase().endsWith("yml") ||
                        nameFile.toLocaleLowerCase().endsWith("yaml") ||
                        nameFile.toLocaleLowerCase().endsWith("yml")
                    ) {
                        const arr = await this.encoder.yaml.decode([
                            input as IFile,
                        ]);
                        fileTemp = (arr[0] as IFile).path;
                    }
                    if (fileTemp.toLocaleLowerCase().endsWith("xml") ||
                        nameFile.toLocaleLowerCase().endsWith("xml")) {
                        const arr = await this.encoder.xml.decode([
                            input as IFile,
                        ]);
                        fileTemp = (arr[0] as IFile).path;
                    }
                    const inFile = fs.createReadStream((input as IFile).path);
                    inFile.pipe(fs.createWriteStream(inputName));
                    inFile.on("error", (err) => rejectFile(err));
                    inFile.on("end", () => resolveFile(true));
                } else {
                    let tempInput = isString(input)
                        ? input
                        : JSON.stringify(input);
                    if (temp.trimLeft().startsWith("<")) {
                        tempInput = JSON.stringify(
                            await this.encoder.yaml.decode(tempInput),
                        );
                    } else if (isString(input)) {
                        try {
                            JSON.parse(tempInput);
                        } catch (e) {
                            tempInput = JSON.stringify(
                                await this.encoder.xml.decode(tempInput),
                            );
                        }
                    }
                    fs.writeFile(inputName, tempInput, (err) => {
                        if (err) {
                            return rejectFile(err);
                        }
                        resolveFile(true);
                    });
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
