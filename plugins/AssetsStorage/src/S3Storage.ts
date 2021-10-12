import { IFile } from "@ungate/plugininf/lib/IContext";
import * as AWS from "aws-sdk";
import * as fs from "fs";
import * as os from "os";
import * as path from "path";
import { IRufusLogger } from "rufus";
import { v4 as uuidv4 } from "uuid";
import { IStorage, IPluginParams } from "./AssetsStorage.types";

export class S3Storage implements IStorage {
    private clients: AWS.S3;
    private params: IPluginParams;
    private logger: IRufusLogger;
    private UPLOAD_DIR: string = process.env.GATE_UPLOAD_DIR || os.tmpdir();
    constructor(params: IPluginParams, logger: IRufusLogger) {
        this.params = params;
        this.logger = logger;
        const credentials = new AWS.Credentials({
            accessKeyId: this.params.s3KeyId,
            secretAccessKey: this.params.s3SecretKey,
        });
        if (this.params.typeStorage === "riak") {
            const endpoint = new AWS.Endpoint("http://s3.amazonaws.com");
            const config = {
                apiVersion: "2006-03-01",
                credentials,
                endpoint,
                httpOptions: {
                    proxy: this.params.s3Url,
                },
                region: "us-east-1",
                s3DisableBodySigning: true,
                s3ForcePathStyle: true,
                signatureVersion: "v2",
                sslEnabled: false,
            };
            this.clients = new AWS.S3(new AWS.Config(config));
        } else {
            const endpoint = new AWS.Endpoint(this.params.s3Url);
            const config = {
                credentials,
                endpoint,
            };
            this.clients = new AWS.S3(new AWS.Config(config));
        }
    }

    /**
     * Сохраняем в S3 хранилище
     * @param gateContext
     * @param json
     * @param val
     * @param query
     * @returns file
     */
    public saveFile(
        key: string,
        file: IFile,
        metaData: Record<string, string> = {},
    ): Promise<void> {
        return new Promise((resolve, reject) => {
            this.clients.putObject(
                {
                    ...(this.params.s3ReadPublic ? { ACL: "public-read" } : {}),
                    Body: fs.createReadStream(file.path),
                    Bucket: this.params.s3Bucket,
                    ContentLength: file.size,
                    ContentType: file.headers["content-type"],
                    Key: key,
                    Metadata: {
                        ...metaData,
                        originalFilename:
                            file.originalFilename &&
                            encodeURIComponent(file.originalFilename),
                    },
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
    public deletePath(key: string): Promise<void> {
        return new Promise((resolve, reject) => {
            this.clients.headObject(
                {
                    Bucket: this.params.s3Bucket,
                    Key: key,
                },
                (er) => {
                    if (er) {
                        this.logger.debug(er);
                        return resolve();
                    }
                    this.clients.deleteObject(
                        {
                            Bucket: this.params.s3Bucket,
                            Key: key,
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

    public getFile(key: string): Promise<IFile> {
        return new Promise((resolve, reject) => {
            this.clients.getObject(
                {
                    Bucket: this.params.s3Bucket,
                    Key: key,
                },
                (err, response) => {
                    if (err) {
                        return reject(err);
                    }
                    const filePath = path.join(this.UPLOAD_DIR, uuidv4());
                    fs.writeFile(filePath, response.Body as Buffer, (er) => {
                        if (er) {
                            return reject(er);
                        }
                        resolve({
                            fieldName: "upload_file",
                            headers: {
                                "content-type": response.ContentType,
                            },
                            originalFilename:
                                response.Metadata &&
                                decodeURI(response.Metadata.originalFilename),
                            path: filePath,
                            size: response.ContentLength,
                        });
                    });
                },
            );
        });
    }
}
