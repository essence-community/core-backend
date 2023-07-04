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
import * as AWS from "aws-sdk";
import * as fs from "fs";
import { forEach, isObject } from "lodash";
import { v4 as uuidv4 } from "uuid";

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
    private clients: AWS.S3;
    constructor(name: string, params: ICCTParams) {
        super(name, params);
        this.params = initParams(S3Storage.getParamsInfo(), this.params);
        const endpoint = new AWS.Endpoint("http://s3.amazonaws.com");
        const credentials = new AWS.Credentials({
            accessKeyId: this.params.cvKeyId,
            secretAccessKey: this.params.cvSecretKey,
        });
        const config = {
            apiVersion: "2006-03-01",
            credentials,
            endpoint,
            httpOptions: {
                proxy: this.params.cvS3Url,
            },
            region: "us-east-1",
            s3DisableBodySigning: true,
            s3ForcePathStyle: true,
            signatureVersion: "v2",
            sslEnabled: false,
        };
        this.clients = new AWS.S3(new AWS.Config(config));
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
                    } as IResult),
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
                return new Promise((resolve, reject) => {
                    this.clients.deleteObject(
                        {
                            Bucket: isEmpty(
                                      json.data[this.params.cvDirColumn] || this.params.cvDir,
                                    )
                                    ? this.params.cvBucket
                                    : `${this.params.cvBucket}/${
                                      json.data[this.params.cvDirColumn] ||
                                      this.params.cvDir}`,
                            Key: json.data.cv_file_guid,
                        },
                        (err) => {
                            if (err) {
                                return reject(err);
                            }
                            return resolve();
                        },
                    );
                });
            }
        } else if (
            !isEmpty(query.inParams.json) &&
            (gateContext.actionName === "file" ||
                gateContext.actionName === "getfile")
        ) {
            if (!json.data || isEmpty(json.data.cv_file_guid)) {
                throw new ErrorException(ErrorGate.REQUIRED_PARAM);
            }
            return new Promise((resolve, reject) => {
                     this.clients.getObject(
                       {
                          Bucket: isEmpty(
                                    json.data[this.params.cvDirColumn] || this.params.cvDir,
                                  )
                                  ? this.params.cvBucket
                                  : `${this.params.cvBucket}/${
                                    json.data[this.params.cvDirColumn] ||
                                    this.params.cvDir}`,
                          Key: json.data.cv_file_guid,
                      },
                      (err, response) => {
                           if (err) {
                                this.logger.error(err);
                                return resolve({
                                  data: ResultStream([
                                        {
                                          ck_id: "",
                                          jt_message: {
                                            error: [[`${this.name}: ${err.message}`]],
                                          },
                                        },
                                  ]),
                                  type: "success",
                                });
                            }
                            return resolve({
                              data: ResultStream([
                                    {
                                     filedata: response.Body,
                                     filename: response.Metadata &&
                                                 decodeURI(response.Metadata.originalfilename),
                                     filetype: response.ContentType,
                                     size: response.ContentLength,
                                    },
                              ]),
                              type: "attachment",
                            });
                      },
                    );
                });
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
    private saveFile(
        gateContext: IContext,
        json: any,
        val: any,
        query: IGateQuery,
    ): Promise<any> {
        return new Promise((resolve, reject) => {
            const cvFileUuid = json.data.cv_file_guid || uuidv4();
            this.clients.putObject(
                {
                    ...(this.params.clReadPublic ? { ACL: "public-read" } : {}),
                    Body: fs.createReadStream(val.path),
                    Bucket: isEmpty(
                              json.data[this.params.cvDirColumn] || 
                              (json.master ? json.master[this.params.cvDirColumn] : "") || 
                              this.params.cvDir,
                            )
                            ? this.params.cvBucket
                            : `${this.params.cvBucket}/${
                              json.data[this.params.cvDirColumn] ||
                              (json.master ? json.master[this.params.cvDirColumn] : "") ||  
                              this.params.cvDir}`,
                    ContentLength: val.size,
                    ContentType: val.headers["content-type"],
                    Key: cvFileUuid,
                    Metadata: {
                        originalFilename:
                            val.originalFilename &&
                            encodeURIComponent(val.originalFilename)
                    },
                },
                (err) => {
                    if (err) {
                        return reject(err);
                    }
                    json.data.upload_file = {
                      key : cvFileUuid,
                      size : val.size,
                      mimeType : val.headers["content-type"],
                      nameFile : val.originalFilename,
                      pathFile : json.data[this.params.cvDirColumn] ||
                                 (json.master ? json.master[this.params.cvDirColumn] : "") ||  
                                 this.params.cvDir,
                    };
                    query.inParams.json = JSON.stringify(json);
                    if (isEmpty(query.queryStr)) {
                        return resolve([
                            {
                                ck_id: cvFileUuid,
                                cv_error: null,
                            },
                        ]);
                    }
                    return gateContext.provider
                        .processDml(gateContext, query)
                        .then((res) => ReadStreamToArray(res.stream))
                        .then((arr) => {
                            const [row] = arr;
                            if (row && row.result) {
                                try {
                                    const result = isObject(row.result)
                                        ? row.result
                                        : JSON.parse(row.result);
                                    if (!isEmpty(result.cv_error)) {
                                        this.clients.deleteObject(
                                            {
                                                Bucket: isEmpty(
                                                          json.data[this.params.cvDirColumn] || this.params.cvDir,
                                                        )
                                                        ? this.params.cvBucket
                                                        : `${this.params.cvBucket}/${
                                                          json.data[this.params.cvDirColumn] ||
                                                          this.params.cvDir}`,
                                                Key: cvFileUuid,
                                            },
                                            (errDelete) => {
                                                if (errDelete) {
                                                    return reject(errDelete);
                                                }
                                                return resolve(arr);
                                            },
                                        );
                                        return;
                                    }
                                } catch (e) {
                                    gateContext.error(
                                        `Parse error: ${row.result}\n${e.message}`,
                                        e,
                                    );
                                }
                            }
                            resolve(arr);
                        })
                        .catch((errProvider) => reject(errProvider));
                },
            );
        });
    }
}
