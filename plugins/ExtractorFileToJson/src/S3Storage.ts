import * as AWS from "aws-sdk";
import { IRufusLogger } from "rufus";
import { IPluginParams } from "./ExtractorFileToJson.types";
export class S3Storage {
    private clients: AWS.S3;
    private params: IPluginParams;
    private logger: IRufusLogger;
    constructor(params: IPluginParams, logger: IRufusLogger) {
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

    /**
     * Сохраняем в S3 хранилище
     * @param gateContext
     * @param json
     * @param val
     * @param query
     * @returns file
     */
    public saveFile(
        path: string,
        buffer: any,
        content: string,
        size: number = Buffer.byteLength(buffer),
    ): Promise<void> {
        return new Promise((resolve, reject) => {
            this.clients.putObject(
                {
                    ...(this.params.clS3ReadPublic
                        ? { ACL: "public-read" }
                        : {}),
                    Body: buffer,
                    Bucket: this.params.cvS3Bucket,
                    ContentLength: size,
                    ContentType: content,
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
    public deletePath(path: string): Promise<void> {
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
}
