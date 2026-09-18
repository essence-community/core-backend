import { IFile } from "@ungate/plugininf/lib/IContext";
import {
    DeleteObjectCommand,
    GetObjectCommand,
    HeadObjectCommand,
    PutObjectCommand,
    S3Client,
} from "@aws-sdk/client-s3";
import * as fs from "fs";
import * as os from "os";
import * as path from "path";
import { IRufusLogger } from "@ungate/plugininf/lib/Logger";
import { Client } from "minio";
import { v4 as uuidv4 } from "uuid";
import { IStorage, IPluginParams } from "./AssetsStorage.types";

function minioFromUrl(url: string, accessKey: string, secretKey: string) {
    const u = new URL(url.includes("://") ? url : `http://${url}`);
    return new Client({
        endPoint: u.hostname,
        port: u.port ? Number(u.port) : u.protocol === "https:" ? 443 : 80,
        useSSL: u.protocol === "https:",
        accessKey,
        secretKey,
        region: "us-east-1",
        pathStyle: true,
    });
}

async function streamToBuffer(stream: NodeJS.ReadableStream): Promise<Buffer> {
    const chunks: Buffer[] = [];
    for await (const chunk of stream) {
        chunks.push(Buffer.isBuffer(chunk) ? chunk : Buffer.from(chunk));
    }
    return Buffer.concat(chunks);
}

export class S3Storage implements IStorage {
    private s3?: S3Client;
    private minio?: Client;
    private params: IPluginParams;
    private logger: IRufusLogger;
    private UPLOAD_DIR: string = process.env.GATE_UPLOAD_DIR || os.tmpdir();
    constructor(params: IPluginParams, logger: IRufusLogger) {
        this.params = params;
        this.logger = logger;
        if (this.params.typeStorage === "riak") {
            this.minio = minioFromUrl(
                this.params.s3Url as string,
                this.params.s3KeyId as string,
                this.params.s3SecretKey as string,
            );
        } else {
            this.s3 = new S3Client({
                region: "us-east-1",
                credentials: {
                    accessKeyId: this.params.s3KeyId as string,
                    secretAccessKey: this.params.s3SecretKey as string,
                },
                endpoint: this.params.s3Url,
            });
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
    public async saveFile(
        key: string,
        file: IFile,
        metaData: Record<string, string> = {},
    ): Promise<void> {
        const bucket = this.params.s3Bucket as string;
        if (this.minio) {
            await this.minio.fPutObject(bucket, key, file.path, {
                ...(this.params.s3ReadPublic
                    ? { "x-amz-acl": "public-read" }
                    : {}),
                "Content-Type": file.headers["content-type"],
                ...metaData,
                originalFilename:
                    file.originalFilename &&
                    encodeURIComponent(file.originalFilename),
            });
            return;
        }
        await this.s3!.send(
            new PutObjectCommand({
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
            }),
        );
    }
    public async deletePath(key: string): Promise<void> {
        try {
            if (this.minio) {
                await this.minio.statObject(
                    this.params.s3Bucket as string,
                    key,
                );
            } else {
                await this.s3!.send(
                    new HeadObjectCommand({
                        Bucket: this.params.s3Bucket,
                        Key: key,
                    }),
                );
            }
        } catch (er) {
            this.logger.debug(er);
            return;
        }
        if (this.minio) {
            await this.minio.removeObject(this.params.s3Bucket as string, key);
            return;
        }
        await this.s3!.send(
            new DeleteObjectCommand({
                Bucket: this.params.s3Bucket,
                Key: key,
            }),
        );
    }

    public async getFile(key: string): Promise<IFile> {
        const filePath = path.join(this.UPLOAD_DIR, uuidv4());
        if (this.minio) {
            const stat = await this.minio.statObject(
                this.params.s3Bucket as string,
                key,
            );
            await fs.promises.writeFile(
                filePath,
                await streamToBuffer(
                    await this.minio.getObject(
                        this.params.s3Bucket as string,
                        key,
                    ),
                ),
            );
            return {
                fieldName: "upload_file",
                headers: {
                    "content-type": stat.metaData["content-type"],
                },
                originalFilename: decodeURI(
                    stat.metaData.originalFilename ||
                        stat.metaData.originalfilename ||
                        "",
                ),
                path: filePath,
                size: stat.size,
            };
        }
        const response = await this.s3!.send(
            new GetObjectCommand({
                Bucket: this.params.s3Bucket,
                Key: key,
            }),
        );
        await fs.promises.writeFile(
            filePath,
            Buffer.from(await response.Body!.transformToByteArray()),
        );
        return {
            fieldName: "upload_file",
            headers: {
                "content-type": response.ContentType,
            },
            originalFilename: decodeURI(
                response.Metadata?.originalFilename || "",
            ),
            path: filePath,
            size: response.ContentLength || 0,
        };
    }
}
