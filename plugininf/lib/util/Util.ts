/**
 * Created by artemov_i on 05.12.2018.
 */

import BigNumberBase from "bignumber.js";
import * as fs from "fs";
import { forEach, isArray, isString, toNumber, toString } from "lodash";
import * as moment from "moment";
import * as path from "path";
import ErrorException from "../errors/ErrorException";
import ErrorGate from "../errors/ErrorGate";
import { IParamInfo, IParamsInfo } from "../ICCTParams";
import ICCTParams from "../ICCTParams";
import IContext from "../IContext";

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

function parseParam(conf: IParamInfo, value: any) {
    switch (conf.type) {
        case "string":
        case "long_string":
        case "password":
            return toString(value);
        case "boolean": {
            if (isString(value)) {
                return value === "true";
            }
            return !!value;
        }
        case "integer":
        case "numeric":
            return toNumber(value);
        case "date":
            return moment(value).toDate();
        default:
            return toString(value);
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
        return (obj1: any, obj2: any): number =>
            jlSort.reduce((val: number, item) => {
                if (isEmpty(item.property) || isEmpty(item.direction)) {
                    return val;
                }
                const { datatype, format = "3", property } = item;
                const nmColumn = property || "";
                const direction = item.direction?.toUpperCase();
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
                    nmColumn.startsWith("ct_")
                ) {
                    return (
                        val +
                        moment(
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
                        )
                    );
                }
                if (typeof val1 === "number" && typeof val2 === "number") {
                    return (
                        val + (direction === "ASC" ? val1 - val2 : val2 - val1)
                    );
                }
                if (datatype === "integer" || datatype === "numeric") {
                    return (
                        val +
                        (direction === "ASC"
                            ? new BigNumber(val1 as any)
                                  .minus(new BigNumber(val2 as any))
                                  .toNumber()
                            : new BigNumber(val2 as any)
                                  .minus(new BigNumber(val1 as any))
                                  .toNumber())
                    );
                }
                if (typeof val1 === "string" && typeof val2 === "string") {
                    return (
                        val +
                        (
                            (direction === "ASC" ? val1 : val2) || ""
                        ).localeCompare(
                            (direction === "ASC" ? val2 : val1) || "",
                        )
                    );
                }
                // @ts-ignore
                // tslint:disable-line no-unused-expression
                return val + +(direction === "ASC" ? val1 > val2 : val2 > val1);
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
                            typeof valueRecord === "string" &&
                            typeof value === "string" &&
                            (datatype === "date" ||
                                nmColumn.startsWith("cd_") ||
                                nmColumn.startsWith("ct_"))
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
                            typeof valueRecord === "string" &&
                            typeof value === "string" &&
                            (datatype === "date" ||
                                nmColumn.startsWith("cd_") ||
                                nmColumn.startsWith("ct_"))
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
                            typeof valueRecord === "string" &&
                            typeof value === "string" &&
                            (datatype === "date" ||
                                nmColumn.startsWith("cd_") ||
                                nmColumn.startsWith("ct_"))
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
                            typeof valueRecord === "string" &&
                            typeof value === "string" &&
                            (datatype === "date" ||
                                nmColumn.startsWith("cd_") ||
                                nmColumn.startsWith("ct_"))
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
                            typeof valueRecord === "string" &&
                            typeof value === "string" &&
                            (datatype === "date" ||
                                nmColumn.startsWith("cd_") ||
                                nmColumn.startsWith("ct_"))
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
