import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import ICCTParams from "@ungate/plugininf/lib/ICCTParams";
import IContext from "@ungate/plugininf/lib/IContext";
import IObjectParam from "@ungate/plugininf/lib/IObjectParam";
import {
    filterFilesData,
    isEmpty,
    sortFilesData,
} from "@ungate/plugininf/lib/util/Util";
import * as AWS from "aws-sdk";
import { forEach } from "lodash";

interface IS3Clients {
    [key: string]: AWS.S3;
}

export default class RiakAction {
    private cctBuckets: IObjectParam;
    private params: ICCTParams;
    private clients: IS3Clients = {};
    constructor(params: ICCTParams) {
        this.params = params;
        if (!isEmpty(this.params.cctBuckets)) {
            this.cctBuckets = JSON.parse(this.params.cctBuckets);
            forEach(this.cctBuckets, (val, key) => {
                const ep = new AWS.Endpoint("http://s3.amazonaws.com");
                const credentials = new AWS.Credentials(val);
                const config = {
                    apiVersion: "2006-03-01",
                    credentials,
                    endpoint: ep,
                    httpOptions: {
                        proxy: this.params.cvRiakUrl,
                    },
                    region: "us-east-1",
                    s3DisableBodySigning: true,
                    s3ForcePathStyle: true,
                    signatureVersion: "v2",
                    sslEnabled: false,
                };
                this.clients[key] = new AWS.S3(new AWS.Config(config));
            });
        }
    }
    public gtgetriakbuckets = () =>
        Promise.resolve(
            Object.keys(this.cctBuckets || {}).map((val) => ({ ck_id: val })),
        );
    /**
     * Получаем список всех файлов
     * @param gateContext
     * @returns {*}
     */
    public async loadRiakFiles(gateContext: IContext): Promise<any> {
        if (isEmpty(gateContext.query.inParams.json)) {
            return Promise.reject(new ErrorException(ErrorGate.JSON_PARSE));
        }
        const json = JSON.parse(
            gateContext.query.inParams.json,
            (key, value) => {
                if (value === null) {
                    return undefined;
                }
                return value;
            },
        );
        const s3 = this.clients[json.filter.cv_bucket];
        const params = {
            Bucket: json.filter.cv_bucket,
        };
        return new Promise((resolve, reject) => {
            s3.listObjects(params, (err, data) => {
                if (err) {
                    return reject(err);
                }
                return resolve(
                    data
                        ? data.Contents.map((obj) => {
                              return {
                                  ...obj,
                                  ck_id: obj.Key,
                                  cv_bucket: json.filter.cv_bucket,
                              };
                          })
                              .sort(sortFilesData(gateContext))
                              .filter(filterFilesData(gateContext))
                        : [],
                );
            });
        });
    }

    /**
     * Получаем информацию по файлу
     * @param gateContext
     * @returns {*}
     */
    public async loadRiakFileInfo(gateContext: IContext): Promise<any> {
        if (isEmpty(gateContext.query.inParams.json)) {
            return Promise.reject(ErrorGate.JSON_PARSE);
        }
        const json = JSON.parse(
            gateContext.query.inParams.json,
            (key, value) => {
                if (value === null) {
                    return undefined;
                }
                return value;
            },
        );
        const s3 = this.clients[json.filter.cv_bucket];
        const params = {
            Bucket: json.filter.cv_bucket,
            Key: json.master.ck_id,
        };
        return new Promise((resolve, reject) => {
            s3.headObject(params, (err, data) => {
                if (err) {
                    return reject(err);
                }
                return resolve(
                    data
                        ? Object.entries(data.Metadata)
                              .map((value) => ({
                                  ck_id: value[0],
                                  cv_value:
                                      value[0] === "filename"
                                          ? decodeURI(value[1] as string)
                                          : value[1],
                              }))
                              .sort(sortFilesData(gateContext))
                              .filter(filterFilesData(gateContext))
                        : [],
                );
            });
        });
    }

    /**
     * Удаление файла из хранилища
     * @param json
     * @returns {Promise}
     */
    public async deleteRiakFile(gateContext: IContext, json): Promise<any> {
        const s3 = this.clients[json.data.cv_bucket];
        const params = {
            Bucket: json.data.cv_bucket,
            Key: json.data.ck_id,
        };
        return new Promise((resolve, reject) => {
            s3.deleteObject(params, (err) => {
                if (err) {
                    return reject(err);
                }
                return resolve([
                    {
                        ck_id: null,
                        cv_error: null,
                    },
                ]);
            });
        });
    }

    /**
     * Скачиваем файл из Riak
     * @param gateContext
     * @returns {*}
     */
    public async downloadRiakFile(gateContext: IContext): Promise<any> {
        if (isEmpty(gateContext.query.inParams.json)) {
            return Promise.reject(ErrorGate.JSON_PARSE);
        }
        const json = JSON.parse(
            gateContext.query.inParams.json,
            (key, value) => {
                if (value === null) {
                    return undefined;
                }
                return value;
            },
        );
        const s3 = this.clients[json.data.cv_bucket];
        const params = {
            Bucket: json.data.cv_bucket,
            Key: json.data.ck_id,
        };
        return new Promise((resolve, reject) => {
            s3.getObject(params, (err, data) => {
                if (err) {
                    return reject(err);
                }
                return resolve([
                    {
                        filedata: data.Body,
                        filename: data.Metadata.filename
                            ? decodeURI(data.Metadata.filename)
                            : json.data.ck_id,
                        filetype: data.ContentType,
                    },
                ]);
            });
        });
    }
}
