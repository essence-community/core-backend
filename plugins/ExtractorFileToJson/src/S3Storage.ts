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
import { Readable } from "stream";
import { v4 as uuidv4 } from "uuid";
import { IPluginParams } from "./ExtractorFileToJson.types";

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

export class S3Storage {
    private s3?: S3Client;
    private minio?: Client;
    private params: IPluginParams;
    private logger: IRufusLogger;
    private UPLOAD_DIR: string = process.env.GATE_UPLOAD_DIR || os.tmpdir();
    constructor(params: IPluginParams, logger: IRufusLogger) {
        this.params = params;
        this.logger = logger;
        if (this.params.cvTypeStorage === "riak") {
            this.minio = minioFromUrl(
                this.params.cvPath,
                this.params.cvS3KeyId,
                this.params.cvS3SecretKey,
            );
        } else {
            this.s3 = new S3Client({
                region: "us-east-1",
                credentials: {
                    accessKeyId: this.params.cvS3KeyId,
                    secretAccessKey: this.params.cvS3SecretKey,
                },
                endpoint: this.params.cvPath,
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
        buffer: Buffer | Readable,
        content: string,
        Metadata: Record<string, string> = {},
        size: number = (buffer as Readable).pipe
            ? undefined
            : Buffer.byteLength(buffer as Buffer),
    ): Promise<void> {
        if (this.minio) {
            await this.minio.putObject(
                this.params.cvS3Bucket,
                key,
                buffer,
                size,
                {
                    ...(this.params.clS3ReadPublic
                        ? { "x-amz-acl": "public-read" }
                        : {}),
                    "Content-Type": content,
                    ...Metadata,
                    originalFilename:
                        Metadata &&
                        encodeURIComponent(Metadata.originalFilename),
                },
            );
            return;
        }
        await this.s3!.send(
            new PutObjectCommand({
                ...(this.params.clS3ReadPublic ? { ACL: "public-read" } : {}),
                Body: buffer,
                Bucket: this.params.cvS3Bucket,
                ContentLength: size,
                ContentType: content,
                Key: key,
                Metadata: {
                    ...Metadata,
                    originalFilename:
                        Metadata &&
                        encodeURIComponent(Metadata.originalFilename),
                },
            }),
        );
    }
    public async deletePath(key: string): Promise<void> {
        try {
            if (this.minio) {
                await this.minio.statObject(this.params.cvS3Bucket, key);
            } else {
                await this.s3!.send(
                    new HeadObjectCommand({
                        Bucket: this.params.cvS3Bucket,
                        Key: key,
                    }),
                );
            }
        } catch (er) {
            this.logger.debug(er);
            return;
        }
        if (this.minio) {
            await this.minio.removeObject(this.params.cvS3Bucket, key);
            return;
        }
        await this.s3!.send(
            new DeleteObjectCommand({
                Bucket: this.params.cvS3Bucket,
                Key: key,
            }),
        );
    }

    public async getFile(key: string): Promise<IFile> {
        const filePath = path.join(this.UPLOAD_DIR, uuidv4());
        if (this.minio) {
            const stat = await this.minio.statObject(
                this.params.cvS3Bucket,
                key,
            );
            await fs.promises.writeFile(
                filePath,
                await streamToBuffer(
                    await this.minio.getObject(this.params.cvS3Bucket, key),
                ),
            );
            return {
                fieldName: "upload",
                headers: {
                    "content-type": stat.metaData["content-type"],
                },
                originalFilename: decodeURI(
                    stat.metaData.originalFilename || "",
                ),
                path: filePath,
                size: stat.size,
            };
        }
        const response = await this.s3!.send(
            new GetObjectCommand({
                Bucket: this.params.cvS3Bucket,
                Key: key,
            }),
        );
        await fs.promises.writeFile(
            filePath,
            Buffer.from(await response.Body!.transformToByteArray()),
        );
        return {
            fieldName: "upload",
            headers: {
                "content-type": response.ContentType,
            },
            originalFilename:
                response.Metadata &&
                decodeURI(response.Metadata.originalFilename),
            path: filePath,
            size: response.ContentLength,
        };
    }
}
