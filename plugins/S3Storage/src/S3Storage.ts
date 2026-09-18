import BreakException from "@ungate/plugininf/lib/errors/BreakException";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import ICCTParams from "@ungate/plugininf/lib/ICCTParams";
import IParamsInfo from "@ungate/plugininf/lib/ICCTParams";
import IContext, { IFormData } from "@ungate/plugininf/lib/IContext";
import { IPluginRequestContext } from "@ungate/plugininf/lib/IPlugin";
import { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import IResult from "@ungate/plugininf/lib/IResult";
import NullPlugin from "@ungate/plugininf/lib/NullPlugin";
import ResultStream from "@ungate/plugininf/lib/stream/ResultStream";
import { ReadStreamToArray } from "@ungate/plugininf/lib/stream/Util";
import { initParams, isEmpty } from "@ungate/plugininf/lib/util/Util";
import { forEach, isObject } from "lodash";
import { Client } from "minio";
import { v4 as uuidv4 } from "uuid";

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

export default class S3Storage extends NullPlugin {
    public static getParamsInfo(): IParamsInfo {
        return {
            clReadPublic: {
                defaultValue: false,
                name: "Выставить права на чтение для всех",
                type: "boolean",
            },
            cvBucket: {
                name: "Наименование корзины",
                required: true,
                type: "string",
            },
            cvDir: {
                name: "Папка S3 Storage",
                type: "string",
            },
            cvDirColumn: {
                defaultValue: "cv_dir",
                name: "Наименование колонки где находится наименование папки",
                type: "string",
            },
            cvKeyId: {
                name: "Id key S3 Storage",
                required: true,
                type: "string",
            },
            cvS3Url: {
                name: "Адресс S3 Storage",
                required: true,
                type: "string",
            },
            cvSecretKey: {
                name: "Secret key S3 Storage",
                required: true,
                type: "password",
            },
        };
    }
    private clients: Client;
    constructor(name: string, params: ICCTParams) {
        super(name, params);
        this.params = initParams(S3Storage.getParamsInfo(), this.params);
        this.clients = minioFromUrl(
            this.params.cvS3Url,
            this.params.cvKeyId,
            this.params.cvSecretKey,
        );
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
        const json = JSON.parse(query.inParams.json || "{}");
        if (gateContext.actionName === "upload") {
            if (isEmpty(query.inParams.json)) {
                throw new ErrorException(
                    ErrorGate.compileErrorResult(
                        -1,
                        `Not found require params json`,
                    ),
                );
            }
            if (
                !isObject(gateContext.request.body) ||
                !(gateContext.request.body as IFormData).files
            ) {
                throw new ErrorException(
                    ErrorGate.compileErrorResult(
                        -1,
                        `Not found require file body`,
                    ),
                );
            }
            const rows = [];
            forEach((gateContext.request.body as IFormData).files, (val) => {
                if (val && val.length) {
                    val.forEach((value) => {
                        rows.push(
                            this.saveFile(gateContext, json, value, query),
                        );
                    });
                }
            });
            return Promise.all(rows).then(
                async (values) =>
                    ({
                        data: ResultStream(
                            values.reduce((obj, arr) => [...obj, ...arr], []),
                        ),
                        type: "success",
                    }) as IResult,
            );
        } else if (gateContext.actionName === "dml") {
            if (isEmpty(query.inParams.json)) {
                throw new ErrorException(
                    ErrorGate.compileErrorResult(
                        -1,
                        `Not found require params json`,
                    ),
                );
            }
            if (json.service?.cv_action?.toUpperCase() === "D") {
                const Bucket = isEmpty(
                    json.data[this.params.cvDirColumn] ||
                        (json.master
                            ? json.master[this.params.cvDirColumn]
                            : "") ||
                        this.params.cvDir,
                )
                    ? this.params.cvBucket
                    : `${this.params.cvBucket}/${
                          json.data[this.params.cvDirColumn] ||
                          (json.master
                              ? json.master[this.params.cvDirColumn]
                              : "") ||
                          this.params.cvDir
                      }`;
                await this.clients.removeObject(Bucket, json.data.cv_file_guid);
                return;
            }
        } else if (
            !isEmpty(query.inParams.json) &&
            (gateContext.actionName === "file" ||
                gateContext.actionName === "getfile")
        ) {
            if (!json.data || isEmpty(json.data.cv_file_guid)) {
                throw new ErrorException(ErrorGate.REQUIRED_PARAM);
            }
            const Bucket = isEmpty(
                json.data[this.params.cvDirColumn] ||
                    (json.master ? json.master[this.params.cvDirColumn] : "") ||
                    this.params.cvDir,
            )
                ? this.params.cvBucket
                : `${this.params.cvBucket}/${
                      json.data[this.params.cvDirColumn] ||
                      (json.master
                          ? json.master[this.params.cvDirColumn]
                          : "") ||
                      this.params.cvDir
                  }`;
            try {
                const stat = await this.clients.statObject(
                    Bucket,
                    json.data.cv_file_guid,
                );
                const filedata = await streamToBuffer(
                    await this.clients.getObject(
                        Bucket,
                        json.data.cv_file_guid,
                    ),
                );
                return {
                    data: ResultStream([
                        {
                            filedata,
                            filename:
                                stat.metaData &&
                                decodeURI(
                                    stat.metaData.originalfilename ||
                                        stat.metaData.originalFilename ||
                                        "",
                                ),
                            filetype: stat.metaData["content-type"],
                            size: stat.size,
                        },
                    ]),
                    type: "attachment",
                };
            } catch (err) {
                this.logger.error(err);
                return {
                    data: ResultStream([
                        {
                            ck_id: "",
                            jt_message: {
                                error: [
                                    [`${this.name}: ${(err as Error).message}`],
                                ],
                            },
                        },
                    ]),
                    type: "success",
                };
            }
        }
        return;
    }
    /**
     * Сохраняем в S3 хранилище
     * @param gateContext
     * @param json
     * @param val
     * @param query
     * @returns file
     */
    private async saveFile(
        gateContext: IContext,
        json: any,
        val: any,
        query: IGateQuery,
    ): Promise<any> {
        const cvFileUuid = json.data.cv_file_guid || uuidv4();
        const Bucket = isEmpty(
            json.data[this.params.cvDirColumn] ||
                (json.master ? json.master[this.params.cvDirColumn] : "") ||
                this.params.cvDir,
        )
            ? this.params.cvBucket
            : `${this.params.cvBucket}/${
                  json.data[this.params.cvDirColumn] ||
                  (json.master ? json.master[this.params.cvDirColumn] : "") ||
                  this.params.cvDir
              }`;
        await this.clients.fPutObject(Bucket, cvFileUuid, val.path, {
            ...(this.params.clReadPublic ? { "x-amz-acl": "public-read" } : {}),
            "Content-Type": val.headers["content-type"],
            originalFilename:
                val.originalFilename &&
                encodeURIComponent(val.originalFilename),
        });
        json.data.upload_file = {
            key: cvFileUuid,
            size: val.size,
            mimeType: val.headers["content-type"],
            nameFile: val.originalFilename,
            pathFile:
                json.data[this.params.cvDirColumn] ||
                (json.master ? json.master[this.params.cvDirColumn] : "") ||
                this.params.cvDir,
        };
        query.inParams.json = JSON.stringify(json);
        if (isEmpty(query.queryStr)) {
            return [
                {
                    ck_id: cvFileUuid,
                    cv_error: null,
                },
            ];
        }
        try {
            const res = await gateContext.provider.processDml(
                gateContext,
                query,
            );
            const arr = await ReadStreamToArray(res.stream);
            const [row] = arr;
            if (row && row.result) {
                try {
                    const result = isObject(row.result)
                        ? row.result
                        : JSON.parse(row.result);
                    if (!isEmpty(result.cv_error) || result.jt_message?.error) {
                        await this.clients.removeObject(Bucket, cvFileUuid);
                        return arr;
                    }
                } catch (e) {
                    gateContext.error(
                        `Parse error: ${row.result}\n${(e as Error).message}`,
                        e,
                    );
                }
            }
            return arr;
        } catch (errProvider) {
            try {
                await this.clients.removeObject(Bucket, cvFileUuid);
            } catch (errDelete) {
                this.logger.error(errDelete);
            }
            throw errProvider;
        }
    }
}
