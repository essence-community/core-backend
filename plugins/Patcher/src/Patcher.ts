import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import ICCTParams from "@ungate/plugininf/lib/ICCTParams";
import IParamsInfo from "@ungate/plugininf/lib/ICCTParams";
import IContext from "@ungate/plugininf/lib/IContext";
import { uuid } from "uuidv4";
import * as path from "path";
import * as fs from "fs";
import { IPluginRequestContext } from "@ungate/plugininf/lib/IPlugin";
import { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import IResult from "@ungate/plugininf/lib/IResult";
import NullPlugin from "@ungate/plugininf/lib/NullPlugin";
import ResultStream from "@ungate/plugininf/lib/stream/ResultStream";
import { isEmpty } from "@ungate/plugininf/lib/util/Util";
import { Readable } from "stream";
import { DirStorage } from "./DirStorage";
import { IFile, IPluginParams } from "./Patcher.types";
import { IJson } from "./Patcher.types";
import { S3Storage } from "./S3Storage";
import { patchIntegr } from "./integr/IntegrPatch";
import { patchAuth } from "./auth/AuthPatch";
import { patchMeta } from "./meta/MetaPatch";
import * as Zip from "adm-zip";
import * as moment from "moment";

const deleteFolderRecursive = (path) => {
    var files = [];
    if (fs.existsSync(path)) {
        files = fs.readdirSync(path);
        files.forEach((file) => {
            var curPath = path + "/" + file;
            if (fs.lstatSync(curPath).isDirectory()) {
                // recurse
                deleteFolderRecursive(curPath);
            } else {
                // delete file
                fs.unlinkSync(curPath);
            }
        });
        fs.rmdirSync(path);
    }
};
export class Patcher extends NullPlugin {
    public static getParamsInfo(): IParamsInfo {
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
                zip.addLocalFolder(path.join(temp, "integr"), "integr");
            } else if (json.service.cv_action === "auth") {
                await patchAuth(temp, json, gateContext.connection);
                include.push("auth/auth.xml");
                nameBd = "core_auth";
                zip.addLocalFolder(path.join(temp, "auth"), "auth");
            } else {
                await patchMeta(temp, json, gateContext.connection);
                include.push("meta/meta.xml");
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
                            res.stream.on("data", (res) => {
                                this.logger.debug(res);
                            });
                            res.stream.on("error", (err) => reject(err));
                            res.stream.on("end", () => resolve());
                        }),
                );
            deleteFolderRecursive(temp);
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
    private saveFile = (
        path: string,
        buffer: Buffer | Readable,
        content: string,
        metaData?: Record<string, string>,
        size?: number,
    ) => Promise.resolve();
    private deletePath = (path: string) => Promise.resolve();
    private getFile = (key: string): Promise<IFile> =>
        Promise.resolve({} as IFile);
}
