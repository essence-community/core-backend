import Logger from "@ungate/plugininf/lib/Logger";
import * as js2xmlparser from "js2xmlparser";
import { forEach } from "lodash";
import { isBoolean, isDate, isNumber } from "lodash";
import moment = require("moment");
import * as soap from "soap";
import ICCTParams, { IParamsInfo } from "../ICCTParams";
import IObjectParam from "../IObjectParam";
import { initParams, isEmpty } from "../util/Util";
const logger = Logger.getLogger("CrmWsCaller");

export default class CrmWsCaller {
    public static getParamsInfo(): IParamsInfo {
        return {
            proxy: {
                name: "Прокси сервер если необходим",
                type: "string",
            },
            timeout: {
                defaultValue: 660,
                name: "Максимальное время выполнения запроса в секундах",
                type: "integer",
            },
            urlWSDL: {
                name: "Путь до wsdl шины",
                required: true,
                type: "string",
            },
        };
    }
    private params: ICCTParams;
    private urlWSDL: string;
    private conn?: any;
    constructor(params: ICCTParams) {
        this.params = initParams(CrmWsCaller.getParamsInfo(), params);
        this.urlWSDL = params.urlWSDL;
    }

    /**
     * Инициализуем коннект
     * @returns {Promise}
     */
    public init() {
        return new Promise<void>((resolve, reject) => {
            if (this.conn) {
                resolve();
            } else {
                soap.createClientAsync(this.urlWSDL, {
                    attributesKey: "$attributes",
                    valueKey: "$value",
                    xmlKey: "$xml",
                }).then((conn) => {
                    this.conn = conn;
                    Object.values((conn.wsdl as any).services).forEach((services: any) => {
                        Object.values(services.ports).forEach((port: any) => {
                            port.binding.methods.getDataEx.style = "document";
                        });
                    });
                    resolve();
                }, reject);
            }
        });
    }

    /**
     * Получение данных из сервиса
     * @param nameQuery - имя сервиса
     * @param params - объект параметров
     * @param macrosArr - объект макросов
     * @param schema - схема
     */
    public async getData(
        nameQuery: string,
        params: IObjectParam,
        macros?: IObjectParam,
        schema?: string,
    ): Promise<IObjectParam[]> {
        try {
            const [result] = await this.conn.getDataExAsync(
                {
                    _xml: this.getXml(nameQuery, params, macros, schema),
                },
                {
                    proxy: this.params.proxy,
                    timeout: parseInt(this.params.timeout, 10) * 1000 || 660000,
                },
            );
            const res = [];
            if (
                result.getDataReturn &&
                result.getDataReturn.getDataReturn &&
                typeof result.getDataReturn.getDataReturn === "object"
            ) {
                (Array.isArray(result.getDataReturn.getDataReturn)
                    ? result.getDataReturn.getDataReturn
                    : [result.getDataReturn.getDataReturn]
                ).forEach((data) => {
                    const obj = {};
                    (Array.isArray(data.value.item)
                        ? data.value.item
                        : [data.value.item]
                    ).forEach((data2) => {
                        obj[data2.key.$value.toLowerCase()] = this.parseResult(
                            data2.value,
                        );
                    });
                    res.push(obj);
                });
            }
            return res;
        } catch (err) {
            logger.error(err);
            throw err;
        }
    }

    /**
     * Собираем xml
     * @param nameQuery
     * @param params
     * @param macrosArr
     * @param schema
     * @returns {string}
     */
    private getXml(
        nameQuery: string,
        params: IObjectParam = {},
        macros: IObjectParam = {},
        schema: string = "",
    ) {
        return js2xmlparser.parse(
            "ws:getDataEx",
            {
                "@": {
                    "soap:encodingStyle":
                        "http://schemas.xmlsoap.org/soap/encoding/",
                    "xmlns:soapenc":
                        "http://schemas.xmlsoap.org/soap/encoding/",
                    "xmlns:ws": "http://ws.crm.tii.ru",
                    "xmlns:xsd": "http://www.w3.org/2001/XMLSchema",
                },
                queryID: {
                    "@": {
                        "xsi:type": "xsd:string",
                    },
                    // tslint:disable-next-line:object-literal-sort-keys
                    "#": nameQuery,
                },
                // tslint:disable-next-line:object-literal-sort-keys
                params: this.parseParams(params),
                macros: this.parseMacros(macros),
                conn: isEmpty(schema)
                    ? {
                          "@": {
                              "xsi:nil": "true",
                              "xsi:type": "xsd:string",
                          },
                      }
                    : {
                          "@": {
                              "xsi:type": "xsd:string",
                          },
                          // tslint:disable-next-line:object-literal-sort-keys
                          "#": schema,
                      },
            },
            {
                declaration: {
                    include: false,
                },
                format: {
                    doubleQuotes: true,
                },
            },
        );
    }
    /**
     * Разбираем ответ
     * @param data - объект soap
     * @returns {*}
     * @private
     */
    private parseResult(data) {
        let res;
        switch (data.$attributes["xsi:type"]) {
            case "xsd:decimal":
            case "xsd:int":
            case "xsd:integer":
                res =
                    data.$value &&
                    data.$value.length > 0 &&
                    data.$value.length <= 16
                        ? parseFloat(data.$value)
                        : data.$value;
                break;
            case "xsd:date":
            case "xsd:dateTime":
                res = moment(data.$value).toDate();
                break;
            default:
                res = data.$value;
                break;
        }
        if (res === "null") {
            res = null;
        }
        return res;
    }

    /**
     * Входные параметры преобразуем в xml
     * @param params
     * @returns {*}
     * @private
     */
    private parseParams(params: IObjectParam = {}) {
        const item = [];

        if (Object.keys(params).length) {
            forEach(params, (val, key) => {
                const data = this.xsiType(key, val);
                item.push({
                    "@": {
                        "xsi:type": "ws:itemMapObj",
                    },
                    key: {
                        "@": {
                            "xsi:type": "xsd:string",
                        },
                        // tslint:disable-next-line:object-literal-sort-keys
                        "#": data.key,
                    },
                    value: {
                        "@": {
                            "xsi:type": data.type,
                        },
                        // tslint:disable-next-line:object-literal-sort-keys
                        "#": data.val,
                    },
                });
            });
        }
        if (item.length) {
            return {
                item,
            };
        }
        return {
            "@": {
                "xsi:nil": "true",
                "xsi:type": "xsd:string",
            },
        };
    }

    /**
     * Преобразуем параметры xsd
     * @param key
     * @param val
     * @returns {{key: *, val: *}}
     * @private
     */
    private xsiType(key, val, isMacros = false) {
        const res = {
            key,
            type: "",
            val,
        };
        if (!isMacros && key[0] !== ":") {
            res.key = `:${key}`;
        } else if (isMacros) {
            res.key = `&amp;${key.replace(/&/g, "")}`;
        }
        if (isNumber(val)) {
            res.type = "xsd:decimal";
        } else if (isBoolean(val)) {
            res.type = "xsd:boolean";
        } else if (isDate(val)) {
            res.type = "xsd:dateTime";
            res.val = moment(val).format();
        } else {
            res.type = "xsd:string";
            res.val = val;
        }
        return res;
    }
    /**
     * Входные макросы преобразуем в xml
     * @param params
     * @returns {*}
     * @private
     */
    private parseMacros(macros: IObjectParam = {}) {
        const macrosArr = [];

        if (Object.keys(macros).length) {
            forEach(macros, (val, key) => {
                const data = this.xsiType(key, val, true);
                macrosArr.push({
                    "@": {
                        "xsi:type": "soapenc:Array",
                        // tslint:disable-next-line:object-literal-sort-keys
                        "soapenc:arrayType": "ws:mapItemString[]",
                    },
                    item: {
                        "@": {
                            "xsi:type": "ws:mapItemString",
                        },
                        key: {
                            "@": {
                                "xsi:type": "xsd:string",
                            },
                            // tslint:disable-next-line:object-literal-sort-keys
                            "#": data.key,
                        },
                        value: {
                            "@": {
                                "xsi:type": data.type,
                            },
                            // tslint:disable-next-line:object-literal-sort-keys
                            "#": data.val,
                        },
                    },
                });
            });
        }
        if (macrosArr.length) {
            return macrosArr;
        }
        return {
            "@": {
                "xsi:nil": "true",
                "xsi:type": "xsd:string",
            },
        };
    }
}
