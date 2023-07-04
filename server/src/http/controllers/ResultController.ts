import BreakException from "@ungate/plugininf/lib/errors/BreakException";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import { IHeader } from "@ungate/plugininf/lib/IContext";
import IResult from "@ungate/plugininf/lib/IResult";
import ResultStream from "@ungate/plugininf/lib/stream/ResultStream";
import { safePipe, safeResponsePipe } from "@ungate/plugininf/lib/stream/Util";
import { isEmpty } from "@ungate/plugininf/lib/util/Util";
import * as accepts from "accepts";
import * as js2xmlparser from "js2xmlparser";
import * as JSONStream from "JSONStream";
import { isArray, isBoolean, isDate, isNumber, isObject } from "lodash";
import * as moment from "moment";
import * as through from "through";
import Constants from "../../core/Constants";
import RequestContext from "../../core/request/RequestContext";

class ResultController {
    /**
     * Ответ в виде json
     */
    public responseJson(gateContext: RequestContext, result: IResult) {
        const metaData = {
            ...result.metaData,
            ...gateContext.metaData,
        };
        const responseTime =
            (new Date().getTime() - gateContext.startTime) / 1000;
        let first = true;
        let total = 0;
        const ResultTransform = through(
            function(data) {
                let resultData = data;
                if (first) {
                    resultData = `{"success":${
                        result.type === "false" ? "false" : "true"
                    },"data":${data}`;
                    first = false;
                }
                total += 1;
                this.queue(resultData);
            },
            function() {
                this.queue(
                    `,"metaData": ${JSON.stringify({
                        ...metaData,
                        responseTime,
                        total: total - 1,
                    })}}`,
                );
                this.queue(null);
            },
        );
        this.setHeader(gateContext, 200);
        safeResponsePipe(
            safePipe(result.data, [
                JSONStream.stringify("[", ",", "]"),
                ResultTransform,
            ]),
            gateContext.response,
        );
    }

    /**
     * Ответ в виде xml
     */
    public responseXml(gateContext: RequestContext, result: IResult) {
        const pepareXml = js2xmlparser.parse(
            "response",
            {
                "@": {
                    xmlns: "ungate.xml.api",
                    "xmlns:xs": "http://www.w3.org/2001/XMLSchema",
                    "xmlns:xsi": "http://www.w3.org/2001/XMLSchema-instance",
                },
                success: true,
                // tslint:disable-next-line:object-literal-sort-keys
                data: {},
                metaData: {},
            },
            {
                declaration: {
                    encoding: "UTF-8",
                    include: true,
                    standalone: "yes",
                    version: "1.0",
                },
                format: {
                    pretty: false,
                },
            },
        );
        const [startXml, before] = pepareXml.split("<data/>");
        let total = 0;
        let first = true;
        const self = this;
        const ResultTransform = through(
            function(data) {
                let xml = js2xmlparser.parse(
                    "data",
                    Object.entries(data).reduce(
                        (obj, arr) => {
                            const val = self.xsiType(arr[1]);
                            if (val.type === "object") {
                                obj.param.push({
                                    "#": val.value,
                                    "@": {
                                        key: arr[0],
                                        "xsi:type": val.type,
                                    },
                                });
                            } else {
                                obj.param.push({
                                    "#": val.value,
                                    "@": {
                                        key: arr[0],
                                        "xsi:type": val.type,
                                    },
                                });
                            }
                            return obj;
                        },
                        { param: [] },
                    ),
                    {
                        declaration: {
                            include: false,
                        },
                        format: {
                            pretty: false,
                        },
                    },
                );
                total += 1;
                if (first) {
                    xml = `${startXml}${xml}`;
                    first = false;
                }
                this.queue(xml);
            },
            function() {
                const metaData = js2xmlparser.parse(
                    "metaData",
                    {
                        total,
                    },
                    {
                        declaration: {
                            include: false,
                        },
                        format: {
                            pretty: false,
                        },
                    },
                );
                this.queue(before.replace("<metaData/>", metaData));
                this.queue(null);
            },
        );
        this.setHeader(gateContext, 200, {
            "Content-Type": Constants.XML_CONTENT_TYPE,
        });
        safeResponsePipe(
            safePipe(result.data, ResultTransform),
            gateContext.response,
        );
    }

    /**
     * Ответ в виде Attachment
     */
    public responseAttachment(gateContext: RequestContext, result: IResult) {
        const rows = [];
        result.data.on("data", (chunk) => {
            rows.push(chunk);
        });
        result.data.on("end", () => {
            if (rows.length === 0 || rows.length > 1) {
                return this.responseCheck(
                    gateContext,
                    null,
                    new ErrorException(ErrorGate.FILE_ROW_SIZE),
                );
            }
            const data = rows[0];
            if (data[Constants.FILE_DATA_COLUMN]) {
                if (
                    data[Constants.FILE_DATA_COLUMN].length > 2147483648 ||
                    data[Constants.FILE_DATA_COLUMN].length <= 0
                ) {
                    return this.responseCheck(
                        gateContext,
                        null,
                        new ErrorException(ErrorGate.FILE_SIZE),
                    );
                }
                let contentDisposition;
                if (gateContext.gateContextPlugin.attachmentType === "inline") {
                    contentDisposition = "inline";
                } else {
                    contentDisposition = `attachment; filename="${encodeURI(
                        data[Constants.FILE_NAME_COLUMN],
                    )}"`;
                }
                this.setHeader(gateContext, 200, {
                    "Content-Disposition": contentDisposition,
                    "Content-Length": data[Constants.FILE_DATA_COLUMN].length,
                    "Content-Type":
                        data[Constants.FILE_MIME_COLUMN] ||
                        Constants.FILE_CONTENT_TYPE,
                });
                gateContext.response.end(data[Constants.FILE_DATA_COLUMN]);
                if (gateContext.isDebugEnabled()) {
                    gateContext.debug(
                        `Ответ: FileName: ${
                            data[Constants.FILE_NAME_COLUMN]
                        }, FileMimeType: ${
                            data[Constants.FILE_MIME_COLUMN] ||
                            Constants.FILE_CONTENT_TYPE
                        }`,
                    );
                }
            } else {
                const error = `Ошибка загрузки файла (${moment().format(
                    "DD.MM.YYYY HH:mm:ss",
                )})`;
                this.setHeader(gateContext, 200, {
                    "Content-Disposition": `attachment; filename="${
                        data[Constants.ERROR_FILE_NAME]
                    }"`,
                    "Content-Length": Buffer.byteLength(error),
                    "Content-Type": Constants.ERROR_FILE_MIME,
                });
                gateContext.response.end(error);
            }
        });
    }

    /**
     * Ответ в виде Attachment
     */
    public responseFile(gateContext: RequestContext, result: IResult) {
        const rows = [];
        result.data.on("data", (chunk) => {
            rows.push(chunk);
        });
        result.data.on("end", () => {
            if (rows.length === 0 || rows.length > 1) {
                return this.responseCheck(
                    gateContext,
                    null,
                    new ErrorException(ErrorGate.FILE_ROW_SIZE),
                );
            }
            const data = rows[0];
            if (
                data[Constants.FILE_DATA_COLUMN] &&
                data[Constants.FILE_MIME_COLUMN] &&
                typeof data[Constants.FILE_MIME_COLUMN] === "string" &&
                data[Constants.FILE_NAME_COLUMN] &&
                typeof data[Constants.FILE_NAME_COLUMN] === "string"
            ) {
                if (
                    data[Constants.FILE_DATA_COLUMN].length > 2147483648 ||
                    data[Constants.FILE_DATA_COLUMN].length <= 0
                ) {
                    return this.responseCheck(
                        gateContext,
                        null,
                        new ErrorException(ErrorGate.FILE_SIZE),
                    );
                }

                this.setHeader(gateContext, 200, {
                    "Content-Length": data[Constants.FILE_DATA_COLUMN].length,
                    "Content-Type": data[Constants.FILE_MIME_COLUMN],
                });
                gateContext.response.end(data[Constants.FILE_DATA_COLUMN]);
                if (gateContext.isDebugEnabled()) {
                    gateContext.debug(
                        `Ответ: FileName: ${
                            data[Constants.FILE_NAME_COLUMN]
                        }, FileMimeType: ${data[Constants.FILE_MIME_COLUMN]}`,
                    );
                }
            } else {
                this.responseCheck(
                    gateContext,
                    null,
                    new ErrorException(ErrorGate.INVALID_FILE_RESULT),
                );
            }
        });
    }

    /**
     * Ответ ошибки в виде json
     */
    public responseErrorJson(gateContext: RequestContext, result: IResult) {
        const endTime = new Date();
        const rows = [];
        result.data.on("data", (chunk) => {
            rows.push(chunk);
        });
        result.data.on("end", () => {
            const [error] = rows;
            error.err_id += ` ${moment(endTime).format("DD.MM.YYYY HH:mm:ss")}`;
            const metaData = {
                ...result.metaData,
                ...gateContext.metaData,
                total: 1,
            };
            error.metaData = {
                ...error.metaData,
                ...metaData,
                responseTime:
                    (new Date().getTime() - gateContext.startTime) / 1000,
            };

            const json = JSON.stringify(error);
            const headers = {
                "Content-Length": Buffer.byteLength(json),
            };
            this.setHeader(gateContext, 200, headers);
            gateContext.response.end(json);
            if (gateContext.isDebugEnabled()) {
                gateContext.debug(`Ответ: ${json}`);
            }
        });
    }
    /**
     * Ответ ошибки в виде xml
     */
    public responseErrorXml(gateContext: RequestContext, result: IResult) {
        const endTime = new Date();
        const rows = [];
        result.data.on("data", (chunk) => {
            rows.push(chunk);
        });
        result.data.on("end", () => {
            const [error] = rows;
            error.err_id += ` ${moment(endTime).format("DD.MM.YYYY HH:mm:ss")}`;
            const metaData = {
                ...result.metaData,
                ...gateContext.metaData,
                total: 1,
            };
            error.metaData = {
                ...error.metaData,
                ...metaData,
                responseTime:
                    (new Date().getTime() - gateContext.startTime) / 1000,
            };
            const xml = js2xmlparser.parse(
                "response",
                {
                    "@": {
                        xmlns: "ungate.xml.api",
                        "xmlns:xs": "http://www.w3.org/2001/XMLSchema",
                        "xmlns:xsi":
                            "http://www.w3.org/2001/XMLSchema-instance",
                    },
                    ...error,
                },
                {
                    declaration: {
                        encoding: "UTF-8",
                        include: true,
                        standalone: "yes",
                        version: "1.0",
                    },
                },
            );
            const headers = {
                "Content-Length": Buffer.byteLength(xml),
                "Content-Type": Constants.XML_CONTENT_TYPE,
            };
            this.setHeader(gateContext, 200, headers);
            gateContext.response.end(xml);
            if (gateContext.isDebugEnabled()) {
                gateContext.debug(`Ответ: ${xml}`);
            }
        });
    }
    /**
     * Формирование ответа
     * @param gateContext {RequestContext} контекст запроса
     * @param res {IResult} ответ
     * @param err {Error} Ошибка
     */
    public async responseCheck(
        gateContext: RequestContext,
        res: IResult,
        err?: Error | any,
    ) {
        let result = res;
        if (gateContext.isResponded) {
            return;
        }
        if (result && result.type === "break") {
            gateContext.info(
                `${gateContext.request.method}(${gateContext.actionName},${gateContext.queryName}` +
                    `,${gateContext.providerName}) time execute ${
                        (new Date().getTime() - gateContext.startTime) / 1000
                    }`,
            );
            return;
        }
        const accept = accepts(gateContext.request);
        if (err && (err as BreakException).break) {
            if ((err as BreakException).resultData) {
                result = (err as BreakException).resultData;
            }
        } else if (err) {
            if (!(err as ErrorException).result) {
                gateContext.error(`responseCheck: ${err.message}`, err);
            }
            result = {
                data: ResultStream(
                    err
                        ? [
                              (err as ErrorException).result ||
                                  ErrorGate.compileErrorResult(
                                      -1,
                                      err.message || "",
                                  ),
                          ]
                        : [ErrorGate.JSON_PARSE],
                ),
                type: "error",
            };
        }
        try {
            result = await gateContext.gateContextPlugin.handleResult(
                gateContext,
                result,
            );
        } catch (errContext) {
            if (errContext && (errContext as BreakException).break) {
                if ((errContext as BreakException).resultData) {
                    result = (errContext as BreakException).resultData;
                }
            } else if (errContext) {
                if (!(errContext as ErrorException).result) {
                    gateContext.error(`${errContext.message}`, errContext);
                }
                result = {
                    data: ResultStream(
                        err
                            ? [
                                  (errContext as ErrorException).result ||
                                      ErrorGate.compileErrorResult(
                                          -1,
                                          errContext.message || "",
                                      ),
                              ]
                            : [ErrorGate.JSON_PARSE],
                    ),
                    type: "error",
                };
            }
        }
        return new Promise<void>((resolve, reject) => {
            switch (
                result.type // Разбираем по типу ответа
            ) {
                case "success":
                case "false": {
                    switch (gateContext.actionName) {
                      case "getfile":
                      case "file": 
                          this.responseJson(gateContext, result);
                          break;
                      default: {
                          switch (accept.type(["json", "xml"])) {
                            case "json":
                                this.responseJson(gateContext, result);
                                break;
                            case "xml":
                                this.responseXml(gateContext, result);
                                break;
                            default:
                                this.responseJson(gateContext, result);
                                break;
                          }
                      }
                      break;
                    }
                    break;
                }
                case "break": // Отправка осуществлена раннее
                    break;
                case "attachment":
                    this.responseAttachment(gateContext, result);
                    break;
                case "file":
                    this.responseFile(gateContext, result);
                    break;
                case "error": {
                    switch (gateContext.actionName) {
                      case "getfile":
                      case "file":
                        this.responseErrorJson(gateContext, result);
                        break;
                      default: {
                          switch (accept.type(["json", "xml"])) {
                            case "json":
                                this.responseErrorJson(gateContext, result);
                                break;
                            case "xml":
                                this.responseErrorXml(gateContext, result);
                                break;
                            default:
                                this.responseErrorJson(gateContext, result);
                                break;
                          }
                        }
                        break;
                    }
                    break;
                }
                default:
                    gateContext.error(
                        `Не поддерживаемый вид ответа ${result.type}`,
                        err,
                    );
                    result = {
                        data: ResultStream([
                            ErrorGate.compileErrorResult(
                                -1,
                                "Unsupported response type",
                            ),
                        ]),
                        type: "error",
                    };
                    this.responseErrorJson(gateContext, result);
                    break;
            }
            if (result.data) {
                result.data.on("error", (errStream) => {
                    reject(errStream);
                });
                result.data.on("end", () => {
                    resolve();
                });
            } else {
                resolve();
            }
            return;
        });
    }

    private xsiType(val: any): any {
        const result = { type: "", value: null };
        if (isDate(val)) {
            result.type = "xs:dateTime";
            result.value = moment(val).format();
        } else if (isNumber(val)) {
            result.type = "xs:decimal";
            result.value = `${val}`;
        } else if (isBoolean(val)) {
            result.type = "xs:boolean";
            result.value = `${val}`;
        } else if (isArray(val)) {
            result.type = "object";
            result.value = val.reduce(
                (obj, arr) => {
                    const types = this.xsiType(arr);
                    obj.param.push(types.value);
                    return obj;
                },
                { param: [] },
            );
        } else if (isObject(val)) {
            result.type = "object";
            result.value = Object.entries(val).reduce(
                (obj, arr) => {
                    const types = this.xsiType(val[1]);
                    if (types.type === "object") {
                        obj.param.push({
                            ...types.value,
                            "@": {
                                key: types[0],
                                "xsi:type": types.type,
                            },
                        });
                    } else {
                        obj.param.push({
                            "#": types.value,
                            "@": {
                                key: arr[0],
                                "xsi:type": types.type,
                            },
                        });
                    }
                    return obj;
                },
                { param: [] },
            );
        } else {
            result.type = "xs:string";
            result.value = isEmpty(val) ? "" : val;
        }
        return result;
    }
    private setHeader(
        gateContext: RequestContext,
        code: number,
        extraHeaders: IHeader = {},
    ) {
        gateContext.response.writeHead(code, {
            "Content-Type": Constants.JSON_CONTENT_TYPE,
            ...extraHeaders,
            ...gateContext.extraHeaders,
        });
    }
}

export default new ResultController();
