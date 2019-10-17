import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import ICCTParams, { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import IContext from "@ungate/plugininf/lib/IContext";
import { IPluginRequestContext } from "@ungate/plugininf/lib/IPlugin";
import { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import IResult from "@ungate/plugininf/lib/IResult";
import NullPlugin from "@ungate/plugininf/lib/NullPlugin";
import { initParams, isEmpty } from "@ungate/plugininf/lib/util/Util";
import * as zip from "adm-zip";
import * as AWS from "aws-sdk";
import * as fs from "fs";
import { forEach, isObject } from "lodash";
import { getType } from "mime";
import * as Path from "path";

interface File {
    /**
     * same as name - the field name for this file
     */
    fieldName: string;
    /**
     * the filename that the user reports for the file
     */
    originalFilename: string;
    /**
     * the absolute path of the uploaded file on disk
     */
    path: string;
    /**
     * the HTTP headers that were sent along with this file
     */
    headers: any;
    /**
     * size of the file in bytes
     */
    size: number;
}

interface Files {
    [key: string]: File[];
}
interface PluginParams extends ICCTParams {
    cvTypeStorage: "riak" | "aws" | "dir";
    cvPath: string;
    cvS3Bucket?: string;
    cvS3KeyId?: string;
    cvS3SecretKey?: string;
}
// tslint:disable: object-literal-sort-keys
export default class ModuleStorage extends NullPlugin {
    public static getParamsInfo(): IParamsInfo {
        return {
            cvTypeStorage: {
                defaultValue: "riak",
                name: "Тип хранилища: dir|aws|riak",
                type: "string",
                required: true,
            },
            cvPath: {
                name: "Адрес Riak|Dir|Aws",
                type: "string",
                required: true,
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
                name: "Id key S3 Storage",
                type: "password",
            },
        };
    }
    private clients?: AWS.S3;
    constructor(name: string, params: ICCTParams) {
        super(name, params);
        this.params = initParams(
            ModuleStorage.getParamsInfo(),
            params,
        ) as PluginParams;
        if (this.params.cvTypeStorage === "dir") {
            this.saveFile = this.saveFileDir.bind(this);
            this.deletePath = this.deletePathDir.bind(this);
            return;
        }
        const credentials = new AWS.Credentials({
            accessKeyId: this.params.cvS3KeyId,
            secretAccessKey: this.params.cvS3SecretKey,
        });
        if (this.params.cvTypeStorage === "riak") {
            const endpoint = new AWS.Endpoint("http://s3.amazonaws.com");
            const config = {
                apiVersion: "2006-03-01",
                credentials,
                endpoint,
                httpOptions: {
                    proxy: this.params.cvPath,
                },
                region: "us-east-1",
                s3DisableBodySigning: true,
                s3ForcePathStyle: true,
                signatureVersion: "v2",
                sslEnabled: false,
            };
            this.clients = new AWS.S3(new AWS.Config(config));
        } else {
            const endpoint = new AWS.Endpoint(this.params.cvPath);
            const config = {
                credentials,
                endpoint,
            };
            this.clients = new AWS.S3(new AWS.Config(config));
        }
    }

    public async beforeQueryExecutePerform(
        gateContext: IContext,
        PRequestContext: IPluginRequestContext,
        query: IGateQuery,
    ): Promise<IResult | void> {
        if (gateContext.actionName === "upload") {
            if (isEmpty(query.inParams.json)) {
                throw new ErrorException(
                    ErrorGate.compileErrorResult(
                        -1,
                        `Not found require params json`,
                    ),
                );
            }
            if (!isObject(gateContext.request.body)) {
                throw new ErrorException(
                    ErrorGate.compileErrorResult(
                        -1,
                        `Not found require file body`,
                    ),
                );
            }
            const rows = [];
            const json = JSON.parse(query.inParams.json);
            forEach(gateContext.request.body as Files, (val) => {
                if (val && val.length) {
                    val.forEach((value) => {
                        rows.push(
                            this.extractZip(gateContext, json, value, query),
                        );
                    });
                }
            });
            return Promise.all(rows).then(() => undefined);
        } else if (gateContext.actionName === "dml") {
            if (isEmpty(query.inParams.json)) {
                throw new ErrorException(
                    ErrorGate.compileErrorResult(
                        -1,
                        `Not found require params json`,
                    ),
                );
            }
            const json = JSON.parse(query.inParams.json);
            if (json.service.cv_action.toUpperCase() === "D") {
                return this.deletePath(
                    `/${json.data.cv_name}/${json.data.cv_version}`,
                );
            }
        }
        return;
    }
    /**
     * Распаковываем zip и сохраняем в хранилище
     * @param gateContext
     * @param json
     * @param file
     * @param query
     */
    public async extractZip(
        gateContext: IContext,
        json: any,
        file: File,
        query: IGateQuery,
    ) {
        const fileZip = new zip(file.path);
        const configStr = fileZip.readAsText("config.json");
        if (isEmpty(configStr)) {
            throw new ErrorException(1000, "Not found config.json");
        }
        const config = JSON.parse(configStr);
        const rows = [];
        await this.deletePath(`/${config.name}/${config.version}`).catch(
            (err) => {
                this.logger.error(err);
                return Promise.resolve();
            },
        );
        config.files.forEach((item: string) => {
            rows.push(
                this.saveFile(
                    `/${config.name}/${config.version}${item}`,
                    fileZip.readFile(item.substr(1)),
                    getType(item.replace(/^.*\./, "")),
                ),
            );
        });
        rows.push(
            this.saveFile(
                `/${config.name}/${config.version}/module.zip`,
                fs.createReadStream(file.path),
                file.headers["content-type"],
                file.size,
            ),
        );
        json.data.cv_name = config.name;
        json.data.cv_version = config.version;
        json.data.cv_version_api = config.versionapi;
        json.data.cc_manifest = fileZip.readAsText(config.manifest.substr(1));
        json.data.cc_config = configStr;
        query.inParams.json = JSON.stringify(json);
        return Promise.all(rows);
    }
    /**
     * Сохраняем в S3 хранилище
     * @param gateContext
     * @param json
     * @param val
     * @param query
     * @returns file
     */
    private saveFile(
        path: string,
        buffer: any,
        content: string,
        size: number = Buffer.byteLength(buffer),
    ): Promise<void> {
        return new Promise((resolve, reject) => {
            this.clients.putObject(
                {
                    Body: buffer,
                    Bucket: this.params.cvS3Bucket,
                    ContentLength: size,
                    ContentType: content,
                    ACL: "public-read",
                    Key: path,
                },
                (err) => {
                    if (err) {
                        return reject(err);
                    }
                    resolve();
                },
            );
        });
    }
    /**
     * Сохраняем в папку
     * @param gateContext
     * @param json
     * @param val
     * @param query
     * @returns
     */
    private saveFileDir(
        path: string,
        buffer: any,
        content: string,
        size: number = Buffer.byteLength(buffer),
    ): Promise<void> {
        return new Promise((resolve, reject) => {
            const param = this.params as PluginParams;
            const dir = Path.dirname(`${param.cvPath}${path}`);
            if (!fs.existsSync(dir)) {
                fs.mkdirSync(dir, {
                    recursive: true,
                });
            }
            if (buffer.pipe) {
                const ws = fs.createWriteStream(`${param.cvPath}${path}`);
                ws.on("error", (err) => reject(err));
                buffer.on("error", (err) => reject(err));
                buffer.on("end", () => resolve());
                buffer.pipe(ws);
                return;
            }
            fs.writeFile(`${param.cvPath}${path}`, buffer, (err) => {
                if (err) {
                    reject(err);
                }
                resolve();
            });
        });
    }
    private deletePath(path: string): Promise<void> {
        return new Promise((resolve, reject) => {
            this.clients.headObject(
                {
                    Bucket: this.params.cvS3Bucket,
                    Key: path,
                },
                (er) => {
                    if (er) {
                        this.logger.debug(er);
                        return resolve();
                    }
                    this.clients.deleteObject(
                        {
                            Bucket: this.params.cvS3Bucket,
                            Key: path,
                        },
                        (err) => {
                            if (err) {
                                return reject(err);
                            }
                            return resolve();
                        },
                    );
                },
            );
        });
    }
    private deletePathDir(path: string): Promise<void> {
        return new Promise((resolve, reject) => {
            const param = this.params as PluginParams;
            const file = `${param.cvPath}${path}`;
            if (!fs.existsSync(file)) {
                return resolve();
            }
            fs.unlink(file, (err) => {
                if (err) {
                    return reject(err);
                }
                resolve();
            });
        });
    }
}
