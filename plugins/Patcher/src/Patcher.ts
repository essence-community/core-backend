import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import ICCTParams from "@ungate/plugininf/lib/ICCTParams";
import IParamsInfo from "@ungate/plugininf/lib/ICCTParams";
import IContext from "@ungate/plugininf/lib/IContext";
import { IPluginRequestContext } from "@ungate/plugininf/lib/IPlugin";
import { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import IResult from "@ungate/plugininf/lib/IResult";
import NullPlugin from "@ungate/plugininf/lib/NullPlugin";
import ResultStream from "@ungate/plugininf/lib/stream/ResultStream";
import { sendProcess } from "@ungate/plugininf/lib/util/ProcessSender";
import {
    deleteFolderRecursive,
    isEmpty,
} from "@ungate/plugininf/lib/util/Util";
import * as Zip from "adm-zip";
import * as crypto from "crypto";
import * as fs from "fs";
import * as moment from "moment";
import * as path from "path";
import { Readable } from "stream";
import { uuid } from "uuidv4";
import { patchAuth } from "./auth/AuthPatch";
import { DirStorage } from "./DirStorage";
import { patchIntegr } from "./integr/IntegrPatch";
import { patchMeta } from "./meta/MetaPatch";
import { IFile, IPluginParams, IStorage } from "./Patcher.types";
import { IJson } from "./Patcher.types";
import { S3Storage } from "./S3Storage";

export class Patcher extends NullPlugin implements IStorage {
    public static getParamsInfo(): IParamsInfo {
        // tslint:disable:object-literal-sort-keys
        return {
            cvTypeStorage: {
                defaultValue: "riak",
                name: "Тип хранилища: dir|aws|riak",
                type: "string",
            },
            cvPath: {
                name: "Адрес Riak|Dir|Aws",
                type: "string",
            },
            cvS3Bucket: {
                name: "Наименование корзины s3",
                type: "string",
            },
            cvS3KeyId: {
                name: "Id key S3 Storage",
                type: "string",
            },
            cvS3SecretKey: {
                name: "Secret key S3 Storage",
                type: "password",
            },
        };
    }
    public params: IPluginParams;
    constructor(name: string, params: ICCTParams) {
        super(name, params);
        const storage =
            params.cvTypeStorage === "dir"
                ? new DirStorage(this.params, this.logger)
                : new S3Storage(this.params, this.logger);
        this.saveFile = storage.saveFile.bind(storage);
        this.deletePath = storage.deletePath.bind(storage);
        this.getFile = storage.getFile.bind(storage);
    }
    public saveFile(
        f: string,
        buffer: Buffer | Readable,
        content: string,
        metaData?: Record<string, string>,
        size?: number,
    ): Promise<void> {
        throw new Error("Method not implemented.");
    }
    public deletePath(f: string): Promise<void> {
        throw new Error("Method not implemented.");
    }
    public getFile(key: string): Promise<IFile> {
        throw new Error("Method not implemented.");
    }
    /**
     * Загрузка файла в хранилище в режиме upload
     * @param gateContext
     * @param PRequestContext
     * @param query
     */
    public async beforeQueryExecutePerform(
        gateContext: IContext,
        PRequestContext: IPluginRequestContext,
        query: IGateQuery,
    ): Promise<IResult | void> {
        if (isEmpty(query.inParams.json)) {
            throw new ErrorException(
                ErrorGate.compileErrorResult(
                    -1,
                    `Not found require params json`,
                ),
            );
        }
        const json: IJson = JSON.parse(query.inParams.json);
        if (gateContext.actionName === "dml") {
            if (json.service.cv_action.toUpperCase() === "D") {
                await this.deletePath(json.data.ck_id);
                return;
            }
        }
        if (
            gateContext.actionName === "file" ||
            gateContext.actionName === "getfile"
        ) {
            if (json.data.ck_id) {
                return this.getFile(json.data.ck_id).then((file) => ({
                    data: ResultStream([
                        {
                            filedata: fs.readFileSync(file.path),
                            filename: file.originalFilename,
                            filetype: file.headers["content-type"],
                        },
                    ]),
                    type: "attachment",
                }));
            }
            json.data.ck_id = uuid();
            const temp = fs.mkdtempSync("patch");
            const zip = new Zip();
            zip.addLocalFile(path.join(__dirname, "assets", "update"));
            zip.addLocalFile(path.join(__dirname, "assets", "update.bat"));
            zip.addLocalFolder(
                path.join(__dirname, "assets", "liquibase"),
                "liquibase",
            );
            const include: string[] = [];
            let nameBd: string = "core";
            if (json.service.cv_action === "integration") {
                await patchIntegr(temp, json, gateContext.connection);
                include.push("integr/integr.xml");
                nameBd = "core_integr";
                this.calcMd5(path.join(temp, "integr"));
                zip.addLocalFolder(path.join(temp, "integr"), "integr");
            } else if (json.service.cv_action === "auth") {
                await patchAuth(temp, json, gateContext.connection);
                include.push("auth/auth.xml");
                nameBd = "core_auth";
                this.calcMd5(path.join(temp, "auth"));
                zip.addLocalFolder(path.join(temp, "auth"), "auth");
            } else {
                await patchMeta(temp, json, gateContext.connection);
                include.push("meta/meta.xml");
                this.calcMd5(path.join(temp, "meta"));
                zip.addLocalFolder(path.join(temp, "meta"), "meta");
            }

            zip.addFile(
                "liquibase.properties",
                Buffer.from(
                    "driver: org.postgresql.Driver\n" +
                        `url: jdbc:postgresql://127.0.0.1:5432/${nameBd}\n` +
                        "username: s_su\n" +
                        "password: s_su\n",
                    "utf-8",
                ),
            );
            zip.addFile(
                "db.changelog.xml",
                Buffer.from(
                    '<?xml version="1.0" encoding="UTF-8"?>\n' +
                        "<databaseChangeLog\n" +
                        '  xmlns="http://www.liquibase.org/xml/ns/dbchangelog"\n' +
                        '  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"\n' +
                        '  xsi:schemaLocation="http://www.liquibase.org/xml/ns/dbchangelog\n' +
                        '         http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-3.1.xsd">\n' +
                        include.reduce((res, str) => {
                            return `${res}        <include file="./${str}" />\n`;
                        }, "") +
                        "</databaseChangeLog>",
                ),
            );
            zip.writeZip();
            const writeZip = zip.toBuffer();
            json.data.cv_file_name = `Patch_${moment().format(
                "YYYY-MM-DD_HH:mm:ss",
            )}.zip`;
            await this.saveFile(
                json.data.ck_id,
                writeZip,
                "application/zip",
                {
                    originalFilename: json.data.cv_file_name,
                },
                writeZip.length,
            );
            json.service.cv_action = "I";
            json.data.cn_size = writeZip.length;
            await gateContext.connection
                .executeStmt(
                    query.queryStr,
                    {
                        ...query.inParams,
                        json: JSON.stringify(json),
                    },
                    query.outParams,
                    {
                        autoCommit: true,
                    },
                )
                .then(
                    (res) =>
                        new Promise((resolve, reject) => {
                            res.stream.on("data", (row) => {
                                this.logger.debug(row);
                            });
                            res.stream.on("error", (err) => reject(err));
                            res.stream.on("end", () => resolve());
                        }),
                );
            deleteFolderRecursive(temp);
            gateContext.response.on("finish", () => {
                sendProcess({
                    command: "sendNotification",
                    data: {
                        ckUser: gateContext.session.ck_id,
                        nameProvider: gateContext.session.ck_d_provider,
                        text: JSON.stringify([
                            {
                                data: {
                                    ck_page: json.service.ck_page,
                                    ck_page_object: json.service.ck_page_object,
                                },
                                event: "reloadpageobject",
                            },
                        ]),
                    },
                    target: "cluster",
                });
            });
            return {
                data: ResultStream([
                    {
                        filedata: writeZip,
                        filename: json.data.cv_file_name,
                        filetype: "application/zip",
                    },
                ]),
                type: "attachment",
            };
        }
        return;
    }

    private calcMd5(dir: string) {
        fs.readdirSync(dir).forEach((file) => {
            const f = path.join(dir, file);
            if (fs.lstatSync(f).isFile()) {
                fs.writeFileSync(
                    path.join(dir, `${file}.md5`),
                    crypto
                        .createHash("md5")
                        .update(fs.readFileSync(f))
                        .digest("hex"),
                );
            }
            if (fs.lstatSync(f).isDirectory()) {
                this.calcMd5(f);
            }
        });
    }
}
