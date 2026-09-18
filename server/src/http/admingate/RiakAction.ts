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
import { forEach } from "lodash";
import { Client } from "minio";

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

interface IS3Clients {
    [key: string]: Client;
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
                this.clients[key] = minioFromUrl(
                    this.params.cvRiakUrl,
                    val.accessKeyId,
                    val.secretAccessKey,
                );
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
        const contents = await new Promise<any[]>((resolve, reject) => {
            const items = [];
            const stream = s3.listObjects(json.filter.cv_bucket, "", true);
            stream.on("data", (obj) => {
                const name = obj.name || obj.key;
                items.push({
                    ...obj,
                    Key: name,
                    ck_id: name,
                    cv_bucket: json.filter.cv_bucket,
                });
            });
            stream.on("error", reject);
            stream.on("end", () => resolve(items));
        });
        return contents
            .sort(sortFilesData(gateContext))
            .filter(filterFilesData(gateContext));
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
        const data = await s3.statObject(
            json.filter.cv_bucket,
            json.master.ck_id,
        );
        return data
            ? Object.entries(data.metaData)
                  .map((value) => ({
                      ck_id: value[0],
                      cv_value:
                          value[0] === "filename"
                              ? decodeURI(value[1] as string)
                              : value[1],
                  }))
                  .sort(sortFilesData(gateContext))
                  .filter(filterFilesData(gateContext))
            : [];
    }

    /**
     * Удаление файла из хранилища
     * @param json
     * @returns {Promise}
     */
    public async deleteRiakFile(gateContext: IContext, json): Promise<any> {
        const s3 = this.clients[json.data.cv_bucket];
        await s3.removeObject(json.data.cv_bucket, json.data.ck_id);
        return [
            {
                ck_id: null,
                cv_error: null,
            },
        ];
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
        const stat = await s3.statObject(json.data.cv_bucket, json.data.ck_id);
        const filedata = await streamToBuffer(
            await s3.getObject(json.data.cv_bucket, json.data.ck_id),
        );
        const filenameMeta =
            stat.metaData.filename || stat.metaData.originalfilename;
        return [
            {
                filedata,
                filename: filenameMeta
                    ? decodeURI(filenameMeta)
                    : json.data.ck_id,
                filetype: stat.metaData["content-type"],
            },
        ];
    }
}
