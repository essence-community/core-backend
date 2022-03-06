/**
 * Created by artemov_i on 05.12.2018.
 */

import BigNumberBase from "bignumber.js";
import * as fs from "fs";
import { forEach, isArray, isString, toNumber, toString } from "lodash";
import * as moment from "moment";
import * as path from "path";
import * as crypto from "crypto";
import ErrorException from "../errors/ErrorException";
import ErrorGate from "../errors/ErrorGate";
import { IParamInfo, IParamsInfo } from "../ICCTParams";
import ICCTParams from "../ICCTParams";
import IContext from "../IContext";
import Constant from "../Constants";
import * as cu from "./cryptoUtil";

export function isEmpty(value: any, allowEmptyString: boolean = false) {
    return (
        value == null ||
        (allowEmptyString ? false : value === "") ||
        (isArray(value) && value.length === 0)
    );
}

export function dateBetween(date: Date, fromDate: Date, toDate: Date) {
    return date >= fromDate && date <= toDate;
}

function decryptAes(
    type: crypto.CipherCCMTypes | crypto.CipherGCMTypes,
    data: string,
): string {
    const key = cu.getKeyFromPassword(
        type,
        Constant.PW_KEY_SECRET,
        Constant.PW_SALT_SECRET,
    );
    return cu.decrypt(type, data, key);
}

function decryptUseKey(data: string): string {
    return crypto
        .privateDecrypt(
            {
                key: Constant.PW_RSA_SECRET,
                passphrase: Constant.PW_RSA_SECRET_PASSPHRASE,
            },
            Buffer.from(data, "hex"),
        )
        .toString();
}

export function encryptAes(
    type: crypto.CipherCCMTypes | crypto.CipherGCMTypes,
    data: string,
): string {
    if (!Constant.PW_KEY_SECRET) {
        throw new Error(
            "Not found key, need init environment ESSENCE_PW_KEY_SECRET",
        );
    }
    const key = cu.getKeyFromPassword(
        type,
        Constant.PW_KEY_SECRET,
        Constant.PW_SALT_SECRET,
    );

    return cu.encrypt(type, data, key);
}

export function encryptUseKey(data: string): string {
    if (!Constant.PW_RSA_SECRET) {
        throw new Error(
            "Not found private key, need init environment ESSENCE_PW_RSA",
        );
    }
    return crypto
        .publicEncrypt(
            {
                key: Constant.PW_RSA_SECRET,
                passphrase: Constant.PW_RSA_SECRET_PASSPHRASE,
            } as any,
            Buffer.from(data),
        )
        .toString("hex");
}
/**
 * Encrypt password
 * @param data
 * @param type
 * @returns
 */
export function encryptPassword(
    data: string,
    type = Constant.DEFAULT_ALG,
): string {
    if (!Constant.isUseEncrypt) {
        return data;
    }
    switch (type) {
        case "privatekey": {
            if (!Constant.PW_RSA_SECRET) {
                return data;
            }
            return `{privatekey}${encryptUseKey(data)}`;
        }
        case "aes-128-gcm":
        case "aes-192-gcm":
        case "aes-256-gcm":
        case "aes-128-ccm":
        case "aes-192-ccm":
        case "aes-256-ccm": {
            if (!Constant.PW_KEY_SECRET) {
                return data;
            }
            return `{${type}}${encryptAes(type as any, data)}`;
        }
        default:
            return data;
    }
}

export function decryptPassword(value: string) {
    if (
        typeof value !== "string" ||
        isEmpty(value) ||
        value.indexOf("{") !== 0 ||
        !Constant.isUseEncrypt
    ) {
        return value;
    }
    const endIndex = value.indexOf("}");
    const type = value.substring(1, endIndex);
    const hash = value.substring(endIndex + 1);
    switch (type) {
        case "aes-128-gcm":
        case "aes-192-gcm":
        case "aes-256-gcm":
        case "aes-128-ccm":
        case "aes-192-ccm":
        case "aes-256-ccm":
            return decryptAes(type as any, hash);
        case "privatekey":
            return decryptUseKey(hash);
        default:
            return value;
    }
}

function parseParam(conf: IParamInfo, value: any) {
    switch (conf.type) {
        case "string":
        case "long_string":
            return conf.checkvalue
                ? conf.checkvalue(toString(value))
                : toString(value);
        case "password": {
            const decryptPass = decryptPassword(toString(value));
            return conf.checkvalue ? conf.checkvalue(decryptPass) : decryptPass;
        }
        case "boolean": {
            if (isString(value)) {
                return conf.checkvalue
                    ? conf.checkvalue(value === "true" || value === "1")
                    : value === "true" || value === "1";
            }
            return conf.checkvalue ? conf.checkvalue(!!value) : !!value;
        }
        case "integer":
        case "numeric":
            return conf.checkvalue
                ? conf.checkvalue(toNumber(value))
                : toNumber(value);
        case "date":
            return conf.checkvalue
                ? conf.checkvalue(moment(value).toDate())
                : moment(value).toDate();
        case "form_nested":
            let objValue = value;
            if (value && typeof value === "string" && value.charAt(0) === "{") {
                objValue = JSON.parse(value);
            }
            return Object.entries(conf.childs).reduce((res, [key, obj]) => {
                if (!isEmpty((objValue || {})[key])) {
                    res[key] = parseParam(obj, objValue[key]);
                } else if (
                    isEmpty((objValue || {})[key]) &&
                    !isEmpty(
                        (isEmpty(objValue) ? conf.defaultValue || {} : objValue)[key],
                    )
                ) {
                    res[key] = parseParam(
                        obj,
                        (isEmpty(objValue) ? conf.defaultValue || {} : objValue)[key],
                    );
                } else if (
                    isEmpty((objValue || {})[key]) &&
                    !isEmpty(obj.defaultValue)
                ) {
                    res[key] = obj.defaultValue;
                }
                return res;
            }, {});
        case "form_repeater":
            let arr = value;
            if (value && typeof value === "string" && value.charAt(0) === "[") {
                arr = JSON.parse(value);
            }
            return (arr || conf.defaultValue || []).map((val) =>
                Object.entries(conf.childs).reduce((res, [key, obj]) => {
                    if (!isEmpty(val[key])) {
                        res[key] = parseParam(obj, val[key]);
                    } else if (
                        isEmpty(val[key]) &&
                        !isEmpty(obj.defaultValue)
                    ) {
                        res[key] = obj.defaultValue;
                    }
                    return res;
                }, {}),
            );
        default: {
            const decryptPass = decryptPassword(value);
            return conf.checkvalue ? conf.checkvalue(decryptPass) : decryptPass;
        }
    }
}
/**
 * Функция для инициализации параметров в случаеесли нет обязательных параметров выкинет ErrorException
 * @param conf Настройки плагинов
 * @param param Параметры
 * @returns params Объект с параметрами
 */
export function initParams(
    conf: IParamsInfo,
    param: ICCTParams = {},
    isExcludeRequire: boolean = false,
): any {
    const notFound = [];
    const result = { ...param };
    forEach(conf, (value, key) => {
        if (!isEmpty(param[key])) {
            result[key] = parseParam(value, param[key]);
        } else if (
            isEmpty(param[key]) &&
            isEmpty(value.defaultValue) &&
            value.required
        ) {
            notFound.push(key);
        } else if (isEmpty(param[key]) && !isEmpty(value.defaultValue)) {
            result[key] = value.defaultValue;
        }
    });
    if (!isExcludeRequire && notFound.length) {
        throw new ErrorException(
            ErrorGate.compileErrorResult(
                -1,
                `Not found require params ${notFound.join(",")}`,
            ),
        );
    }
    return result;
}

const formatStr: Record<string, moment.unitOfTime.StartOf> = {
    1: "year",
    2: "month",
    3: "day",
    4: "hour",
    5: "minute",
    6: "second",
};

const BigNumber = BigNumberBase.clone({
    DECIMAL_PLACES: 20,
    FORMAT: {
        decimalSeparator: ",",
        fractionGroupSeparator: " ",
        fractionGroupSize: 0,
        groupSeparator: "",
        groupSize: 3,
        secondaryGroupSize: 0,
        suffix: "",
    },
    ROUNDING_MODE: 1,
});
const isNullAndUndefined = (val: any) =>
    typeof val === "undefined" || val == null;
export interface IRecordsOrder {
    direction: string;
    datatype?: string;
    format?: string;
    property: string;
}

export interface IRecordFilter {
    datatype?: string;
    format?: string;
    operator: string;
    property: string;
    value: any;
}
export function sortFilesData(
    gateContext: IContext,
): (a: any, b: any) => number {
    if (isEmpty(gateContext.params.json)) {
        return (obj1, obj2) => +(obj1 > obj2);
    }
    const json = JSON.parse(gateContext.params.json, (key, value) => {
        if (value === null) {
            return undefined;
        }
        return value;
    });
    const jlSort = json.filter.jl_sort as IRecordsOrder[];
    if (!isEmpty(jlSort)) {
        const sortArr = [...jlSort];
        return (obj1: any, obj2: any): number =>
            sortArr.reduce((val: number, item) => {
                if (val !== 0) {
                    return val;
                }
                if (isEmpty(item.property) || isEmpty(item.direction)) {
                    return val;
                }
                const { datatype, format = "3", property } = item;
                const nmColumn = property || "";
                const direction = item.direction?.toUpperCase() || "ASC";
                const val1 = obj1[nmColumn];
                const val2 = obj2[nmColumn];

                if (isNullAndUndefined(val1) && isNullAndUndefined(val2)) {
                    return val;
                }
                if (isNullAndUndefined(val1) && !isNullAndUndefined(val2)) {
                    return val;
                }
                if (!isNullAndUndefined(val1) && isNullAndUndefined(val2)) {
                    return val;
                }

                if (
                    datatype === "date" ||
                    nmColumn.startsWith("cd_") ||
                    nmColumn.startsWith("ct_") ||
                    nmColumn.startsWith("fd_") ||
                    nmColumn.startsWith("ft_")
                ) {
                    return moment(
                        direction === "ASC"
                            ? (val1 as string)
                            : (val2 as string),
                    ).diff(
                        moment(
                            direction === "ASC"
                                ? (val2 as string)
                                : (val1 as string),
                        ),
                        formatStr[format] as any,
                    );
                }
                if (typeof val1 === "number" && typeof val2 === "number") {
                    return direction === "ASC" ? val1 - val2 : val2 - val1;
                }
                if (datatype === "integer" || datatype === "numeric") {
                    return direction === "ASC"
                        ? new BigNumber(val1 as any)
                              .minus(new BigNumber(val2 as any))
                              .toNumber()
                        : new BigNumber(val2 as any)
                              .minus(new BigNumber(val1 as any))
                              .toNumber();
                }
                if (typeof val1 === "string" && typeof val2 === "string") {
                    return (
                        (direction === "ASC" ? val1 : val2) || ""
                    ).localeCompare((direction === "ASC" ? val2 : val1) || "");
                }
                // @ts-ignore
                // tslint:disable-line no-unused-expression
                return +(direction === "ASC" ? val1 > val2 : val2 > val1);
            }, 0);
    }

    return (obj1: any, obj2: any): number => +(obj1 > obj2);
}

export function filterFilesData(gateContext: IContext): (a: any) => boolean {
    if (isEmpty(gateContext.params.json)) {
        return () => true;
    }
    const json = JSON.parse(gateContext.params.json, (key, value) => {
        if (value === null) {
            return undefined;
        }
        return value;
    });
    const jlFilter = json.filter.jl_filter as IRecordFilter[];
    if (!isEmpty(jlFilter)) {
        return (obj: any): boolean =>
            jlFilter.filter((item) => {
                if (isEmpty(item.property)) {
                    return true;
                }
                if (isEmpty(item.operator)) {
                    return true;
                }
                const { datatype, format = "3", property } = item;
                const nmColumn = property;
                const operator = item.operator.toLowerCase();
                const value = item.value;
                const valueRecord = obj[nmColumn];

                if (isNullAndUndefined(valueRecord)) {
                    return false;
                }

                if (isNullAndUndefined(value)) {
                    return true;
                }

                switch (operator) {
                    case "gt":
                    case ">":
                        if (
                            (typeof valueRecord === "string" &&
                                typeof value === "string" &&
                                (datatype === "date" ||
                                    nmColumn.startsWith("cd_") ||
                                    nmColumn.startsWith("ct_"))) ||
                            nmColumn.startsWith("fd_") ||
                            nmColumn.startsWith("ft_")
                        ) {
                            return moment(valueRecord).isAfter(
                                value,
                                formatStr[format],
                            );
                        }

                        return new BigNumber(valueRecord as any).gt(
                            new BigNumber(value as any),
                        );
                    case "ge":
                    case ">=":
                        if (
                            (typeof valueRecord === "string" &&
                                typeof value === "string" &&
                                (datatype === "date" ||
                                    nmColumn.startsWith("cd_") ||
                                    nmColumn.startsWith("ct_"))) ||
                            nmColumn.startsWith("fd_") ||
                            nmColumn.startsWith("ft_")
                        ) {
                            return moment(valueRecord).isSameOrAfter(
                                value,
                                formatStr[format],
                            );
                        }

                        return new BigNumber(valueRecord as any).gte(
                            new BigNumber(value as any),
                        );
                    case "lt":
                    case "<":
                        if (
                            (typeof valueRecord === "string" &&
                                typeof value === "string" &&
                                (datatype === "date" ||
                                    nmColumn.startsWith("cd_") ||
                                    nmColumn.startsWith("ct_"))) ||
                            nmColumn.startsWith("fd_") ||
                            nmColumn.startsWith("ft_")
                        ) {
                            return moment(valueRecord).isBefore(
                                value,
                                formatStr[format],
                            );
                        }

                        return new BigNumber(valueRecord as any).lt(
                            new BigNumber(value as any),
                        );
                    case "le":
                    case "<=":
                        if (
                            (typeof valueRecord === "string" &&
                                typeof value === "string" &&
                                (datatype === "date" ||
                                    nmColumn.startsWith("cd_") ||
                                    nmColumn.startsWith("ct_"))) ||
                            nmColumn.startsWith("fd_") ||
                            nmColumn.startsWith("ft_")
                        ) {
                            return moment(valueRecord).isSameOrBefore(
                                value,
                                formatStr[format],
                            );
                        }

                        return new BigNumber(valueRecord as any).lte(
                            new BigNumber(value as any),
                        );
                    case "eq":
                    case "=":
                        if (
                            (typeof valueRecord === "string" &&
                                typeof value === "string" &&
                                (datatype === "date" ||
                                    nmColumn.startsWith("cd_") ||
                                    nmColumn.startsWith("ct_"))) ||
                            nmColumn.startsWith("fd_") ||
                            nmColumn.startsWith("ft_")
                        ) {
                            return moment(valueRecord).isSame(
                                value,
                                formatStr[format],
                            );
                        }

                        return `${valueRecord}` === `${value}`;
                    case "like": {
                        const reg = new RegExp(value as string, "gi");

                        return reg.test(`${valueRecord}`);
                    }
                    case "in":
                        return (value as any).indexOf(valueRecord) > -1;
                    case "not in":
                        return (value as any).indexOf(valueRecord) === -1;
                    default:
                        return true;
                }
            }).length === jlFilter.length;
    }

    return () => true;
}

export const deleteFolderRecursive = (pathDir: string) => {
    if (fs.existsSync(pathDir)) {
        if (fs.lstatSync(pathDir).isDirectory()) {
            fs.readdirSync(pathDir).forEach((file) => {
                const curPath = path.join(pathDir, file);
                if (fs.lstatSync(curPath).isDirectory()) {
                    // recurse
                    deleteFolderRecursive(curPath);
                } else {
                    // delete file
                    fs.unlinkSync(curPath);
                }
            });
            fs.rmdirSync(pathDir);
            return;
        }
        fs.unlinkSync(pathDir);
    }
};

type TDebounce = (...arg) => void;

/**
 * Функция вызывается не более одного раза в указанный период времени
 * (например, раз в 10 секунд). Другими словами ― троттлинг предотвращает запуск функции,
 * если она уже запускалась недавно.
 * @param f {Function} Функция которая должна вызваться
 * @param t {number} Время в милиссекундах
 */
export function throttle(f: TDebounce, t: number) {
    let lastCall;
    return (...args) => {
        const previousCall = lastCall;
        lastCall = Date.now();
        if (
            previousCall === undefined || // function is being called for the first time
            lastCall - previousCall > t
        ) {
            // throttle time has elapsed
            f(...args);
        }
    };
}

export interface IDebounce extends TDebounce {
    cancel: () => void;
}
/**
 * Все вызовы будут игнорироваться до тех пор,
 * пока они не прекратятся на определённый период времени.
 * Только после этого функция будет вызвана.
 * @param f {Function} Функция которая должна вызваться
 * @param t {number} Время в милиссекундах
 */
export function debounce(f: TDebounce, t: number): IDebounce {
    let lastCallTimer = null;
    let lastCall = null;
    const fn = (...args) => {
        const previousCall = lastCall;
        lastCall = Date.now();
        if (previousCall && lastCall - previousCall <= t) {
            clearTimeout(lastCallTimer);
        }
        lastCallTimer = setTimeout(() => {
            lastCallTimer = null;
            lastCall = null;
            f(...args);
        }, t);
    };
    fn.cancel = () => {
        clearTimeout(lastCallTimer);
    };
    return fn;
}
