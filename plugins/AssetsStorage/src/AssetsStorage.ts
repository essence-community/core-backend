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
import { forEach, isObject, isString } from "lodash";
import { v4 as uuidv4 } from "uuid";
import { IPluginParams, IStorage } from "./AssetsStorage.types";
import { deepParam } from "@ungate/plugininf/lib/util/deepParam";
import { DirStorage } from "./DirStorage";
import { S3Storage } from "./S3Storage";

export default class AssetsStorage extends NullPlugin {
    public static getParamsInfo(): IParamsInfo {
        return {
            typeStorage: {
                defaultValue: "dir",
                name: "Тип хранилища",
                type: "combo",
                setGlobal: [{ out: "g_store_module" }],
                displayField: "ck_id",
                valueField: [{ in: "ck_id" }],
                records: [
                    { ck_id: "dir" },
                    { ck_id: "aws" },
                    { ck_id: "riak" },
                ],
                required: true,
            },
            s3ReadPublic: {
                defaultValue: false,
                hidden: true,
                hiddenRules: "g_store_module=='dir'",
                name: "Выставить права на чтение для всех",
                type: "boolean",
            },
            s3Bucket: {
                name: "Наименование корзины",
                required: true,
                hidden: true,
                hiddenRules: "g_store_module=='dir'",
                type: "string",
            },
            dirPath: {
                name: "Корневая папка в режиме dir",
                required: true,
                hidden: true,
                hiddenRules: "g_store_module!='dir'",
                type: "string",
            },
            dirDefault: {
                defaultValue: "",
                name: "Наименование папки куда сохранять",
                type: "string",
            },
            dirColumn: {
                defaultValue: "jt_inparam.cv_dir",
                description:
                    "jt_inparam - искать во входных данных<br/>jt_result - искать во после обработки<br/>jt_query - Тело запроса<br/>Пример: jt_inparam.json.filter.data",
                name: "Наименование колонки где находится наименование папки",
                type: "string",
            },
            s3KeyId: {
                name: "Id Key S3 Storage",
                hidden: true,
                hiddenRules: "g_store_module=='dir'",
                required: true,
                type: "string",
            },
            s3Url: {
                name: "Адресс S3 Storage",
                hidden: true,
                hiddenRules: "g_store_module=='dir'",
                required: true,
                type: "string",
            },
            s3SecretKey: {
                name: "Id Secret S3 Storage",
                hidden: true,
                hiddenRules: "g_store_module=='dir'",
                required: true,
                type: "password",
            },
            finalOut: {
                defaultValue: false,
                setGlobal: [{ out: "g_final_out" }],
                name: "Выдавать ответ сразу",
                type: "boolean",
            },
            keyFilePath: {
                defaultValue: "jt_inparam.upload_file,jt_result.ck_file_uuid",
                description:
                    "jt_inparam - искать во входных данных<br/>jt_result - искать во после обработки<br/>jt_query - Тело запроса<br/>Пример: jt_inparam.json.filter.data",
                name: "Путь индификатора файла",
                type: "string",
            },
        };
    }
    protected clients: AWS.S3;
    public params: IPluginParams;
    private controler: IStorage;
    constructor(name: string, params: ICCTParams) {
        super(name, params);
        this.params = initParams(AssetsStorage.getParamsInfo(), params, true);
        if (this.params.typeStorage === "dir") {
            this.controler = new DirStorage(this.params, this.logger);
        } else {
            this.controler = new S3Storage(this.params, this.logger);
        }
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
        const inParam = {
            jt_inparam:
                typeof gateContext.request.body === "object" &&
                (gateContext.request.body as IFormData).files
                    ? {
                          ...query.inParams,
                          ...(gateContext.request.body as IFormData).files,
                      }
                    : query.inParams,
            jt_query:
                isString(query.queryStr) &&
                (query.queryStr.trim().startsWith("{") ||
                    query.queryStr.trim().startsWith("["))
                    ? JSON.parse(query.queryStr)
                    : query.queryStr,
        };
        const json = JSON.parse(query.inParams.json || "{}");
        const dir =
            this.params.dirColumn?.split(",").reduce((resDir, param) => {
                const foundDir = deepParam(param, inParam);
                return foundDir ? foundDir : resDir;
            }, "") || this.params.dirDefault;
        if (
            isObject(gateContext.request.body) &&
            (gateContext.request.body as IFormData).files
        ) {
            const rows = [];
            forEach(
                (gateContext.request.body as IFormData).files,
                (val, key) => {
                    if (val && val.length) {
                        val.forEach((value) => {
                            const fileKey = uuidv4();
                            rows.push(
                                this.controler
                                    .saveFile(
                                        isEmpty(dir)
                                            ? fileKey
                                            : `${dir}/${fileKey}`,
                                        value,
                                    )
                                    .then(() => ({
                                        key: fileKey,
                                        nameField: key,
                                        nameFile: value.originalFilename,
                                        mimeType: value.headers["content-type"],
                                    })),
                            );
                        });
                    }
                },
            );
            const res = await Promise.all(rows);
            if (this.params.finalOut) {
                return {
                    type: "success",
                    data: ResultStream(res.map((val) => ({ ck_id: val.key }))),
                };
            }
            const keys = new Set();
            res.forEach((val) => {
                const arr = json.data?.[val.nameField] || query.inParams[val.nameField];
                keys.add(val.nameField);
                if (arr && !Array.isArray(arr)) {
                    (json.data || query.inParams)[val.nameField] = [arr, val];
                } if (arr && Array.isArray(arr)) {
                    arr.push(val);
                }else {
                    (json.data || query.inParams)[val.nameField] = val;
                }
            });
            if (Object.keys(json).length) {
                query.inParams.json = JSON.stringify(json);
            } else {
                for(let nameField in keys.keys()) {
                    query.inParams[nameField] = JSON.stringify(query.inParams[nameField]);
                }
            }   
        }
        if (
            this.params.finalOut && (
            json.service?.cv_action?.toUpperCase() === "D" ||
            gateContext.request.method === "DELETE")
        ) {
            return new Promise(async (resolve) => {
                const fileKey = this.params.keyFilePath
                    ?.split(",")
                    .reduce((resDir, param) => {
                        const foundDir = deepParam(param, inParam);
                        return foundDir ? foundDir : resDir;
                    }, "");
                if (!isEmpty(fileKey)) {
                    await this.controler.deletePath(
                        isEmpty(dir) ? fileKey : `${dir}/${fileKey}`,
                    );
                }
                return resolve({
                    type: "success",
                    data: ResultStream([{ ck_id: fileKey }]),
                });
            });
        }
        return;
    }
    /**
     * Получаем файл из контенера
     * @param gateContext
     * @param PRequestContext
     * @param result
     */
    public async afterQueryExecutePerform(
        gateContext: IContext,
        PRequestContext: IPluginRequestContext,
        result: IResult,
    ): Promise<IResult | void> {
        const json = JSON.parse(gateContext.query.inParams.json || "{}");
        let inParam = {
            jt_inparam:
                typeof gateContext.request.body === "object" &&
                (gateContext.request.body as IFormData).files
                    ? {
                          ...gateContext.query.inParams,
                          ...(gateContext.request.body as IFormData).files,
                      }
                    : gateContext.query.inParams,
            jt_query:
                isString(gateContext.query.queryStr) &&
                (gateContext.query.queryStr.trim().startsWith("{") ||
                    gateContext.query.queryStr.trim().startsWith("["))
                    ? JSON.parse(gateContext.query.queryStr)
                    : gateContext.query.queryStr,
        } as any;
        const dir =
        this.params.dirColumn?.split(",").reduce((resDir, param) => {
            const foundDir = deepParam(param, inParam);
            return foundDir ? foundDir : resDir;
        }, "") || this.params.dirDefault;
        if (
            gateContext.actionName === "file" ||
            gateContext.actionName === "getfile"
        ) {
            const resStream = await ReadStreamToArray(result.data);
            inParam = {
                ...inParam,
                jt_result: resStream,
            }
            const dir =
                this.params.dirColumn?.split(",").reduce((resDir, param) => {
                    const foundDir = deepParam(param, inParam);
                    return foundDir ? foundDir : resDir;
                }, "") || this.params.dirDefault;
            const fileKey = this.params.keyFilePath
                ?.split(",")
                .reduce((resDir, param) => {
                    const foundDir = deepParam(param, inParam);
                    return foundDir ? foundDir : resDir;
                }, "");
            if (isEmpty(fileKey)) {
                throw new ErrorException(ErrorGate.INVALID_FILE_RESULT);
            }
            const file = await this.controler.getFile(
                isEmpty(dir) ? fileKey : `${dir}/${fileKey}`,
            );
            const filedata = fs.readFileSync(file.path);
            gateContext.response.once("finish", () => {
                fs.unlinkSync(file.path);
            });
            return {
                type: gateContext.actionName === "file" ? "attachment" : "file",
                data: ResultStream([
                    {
                        filedata,
                        filetype: file.headers["content-type"],
                        filename: file.originalFilename,
                    },
                ]),
            };
        }
        if (
            json.service?.cv_action?.toUpperCase() === "D" ||
            gateContext.request.method === "DELETE"
        ) {
            return new Promise(async (resolve) => {
                const fileKey = this.params.keyFilePath
                    ?.split(",")
                    .reduce((resDir, param) => {
                        const foundDir = deepParam(param, inParam);
                        return foundDir ? foundDir : resDir;
                    }, "");
                if (!isEmpty(fileKey)) {
                    await this.controler.deletePath(
                        isEmpty(dir) ? fileKey : `${dir}/${fileKey}`,
                    );
                }
                resolve();
            });
        }
        return;
    }
}
