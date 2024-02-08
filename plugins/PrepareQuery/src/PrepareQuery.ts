import ICCTParams from "@ungate/plugininf/lib/ICCTParams";
import IContext from "@ungate/plugininf/lib/IContext";
import { IPluginRequestContext } from "@ungate/plugininf/lib/IPlugin";
import { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import NullPlugin from "@ungate/plugininf/lib/NullPlugin";
import { isEmpty } from "@ungate/plugininf/lib/util/Util";

const re = /^[A-z0-9_$]{2,30}$/;
const PATTERN_FILTER = /\/\x2a\s*##\s*([^\s|\x2a]+)/gi;
const FILTER_PREFIX = "cf_filter_";
const DIRECTIONS = ["DESC", "ASC"];

export default class PrepareQuery extends NullPlugin {
    constructor(name: string, params: ICCTParams) {
        super(name, params);
    }

    /**
     * Данный метод вызывается после инициализацией запроса
     * @param gateContext
     * @returns {Promise}
     */
    public afterInitQueryPerform(
        gateContext: IContext,
        PRequestContext: IPluginRequestContext,
        query: IGateQuery,
    ): Promise<void> {
        return new Promise((resolve) => {
            if (isEmpty(query.queryStr)) {
                return resolve();
            }
            const self = this;
            let matcher = PATTERN_FILTER.exec(query.queryStr);
            let removeBlock = [];
            let vlSort;
            let vlFilter;
            let vlFetch = "1000";
            let vlOffset = "0";

            if (matcher) {
                do {
                    removeBlock.push(matcher[1]);
                    matcher = PATTERN_FILTER.exec(query.queryStr);
                } while (matcher);
            }

            if (query.inParams.json) {
                const json = JSON.parse(query.inParams.json);

                removeBlock = removeBlock.filter(
                    (item) => !this.deepFindCheck(json, item),
                );

                const { filter = {} } = json;
                const jnFetch = filter.jn_fetch;
                const jnOffset = filter.jn_offset;
                const jlFilter = filter.jl_filter;
                const jlSort = filter.jl_sort;
                if (gateContext.isDebugEnabled()) {
                    gateContext.debug(
                        `jl_filter: ${jlFilter || ""}\njl_sort: ${
                            jlSort || ""
                        }`,
                    );
                }

                if (!isEmpty(jnFetch) && /^\d+$/.test(jnFetch)) {
                    vlFetch = jnFetch;
                }

                if (!isEmpty(jnOffset) && /^\d+$/.test(jnOffset)) {
                    vlOffset = jnOffset;
                }

                if (!isEmpty(jlFilter)) {
                    vlFilter = "1 = 1";
                    jlFilter.forEach((item) => {
                        const { datatype, format, property } = item;
                        let { operator, value } = item;
                        if (isEmpty(property) || !re.test(property)) {
                            return true;
                        }
                        if (isEmpty(operator)) {
                            return true;
                        }
                        operator = operator.toLowerCase();
                        let nmColumn = property.toUpperCase();
                        let key = `${FILTER_PREFIX}${property.toLowerCase()}`;
                        let param;
                        let ind = 0;
                        if (isEmpty(value)) {
                            return true;
                        }

                        while (
                            Object.prototype.hasOwnProperty.call(
                                query.inParams,
                                key,
                            )
                        ) {
                            key = `${FILTER_PREFIX}${property.toLowerCase()}_${ind}`;
                            ind += 1;
                        }

                        switch (operator) {
                            case "gt":
                            case ">":
                                if (
                                    datatype === "date" ||
                                    nmColumn.startsWith("CD") ||
                                    nmColumn.startsWith("CT")
                                ) {
                                    operator = ">=";
                                } else {
                                    operator = ">";
                                }
                                break;
                            case "ge":
                                operator = ">=";
                                break;
                            case "lt":
                            case "<":
                                if (
                                    datatype === "date" ||
                                    nmColumn.startsWith("CD") ||
                                    nmColumn.startsWith("CT")
                                ) {
                                    operator = "<=";
                                } else {
                                    operator = "<";
                                }
                                break;
                            case "le":
                                operator = "<=";
                                break;
                            case "eq":
                                operator = "=";
                                break;
                            case "ne":
                            case "<>":
                                operator = "!=";
                                break;
                            case "like":
                                if (
                                    !value ||
                                    value === "" ||
                                    typeof value !== "string"
                                ) {
                                    return true;
                                }
                                nmColumn = `UPPER(${nmColumn})`;
                                value = `%${value.toUpperCase()}%`;
                                break;
                            case "not like":
                                if (
                                    !value ||
                                    value === "" ||
                                    typeof value !== "string"
                                ) {
                                    return true;
                                }
                                nmColumn = `UPPER(${nmColumn})`;
                                value = `%${value.toUpperCase()}%`;
                                break;
                            case "in":
                            case "not in": {
                                if (!value || value.length === 0) {
                                    return true;
                                }
                                let vlValue = "";
                                for (let i = 0; i < value.length; i += 1) {
                                    vlValue = `${vlValue},:${key}_${i}`;
                                }
                                param = `(${vlValue.substr(1)})`;
                                break;
                            }
                            case "=":
                            case "<=":
                            case ">=":
                                break;
                            default: {
                                return true;
                            }
                        }
                        self.toSqlValue(
                            gateContext,
                            query.inParams,
                            value,
                            property.toLowerCase(),
                            key,
                        );
                        if (!param) {
                            param = `:${key}`;
                        }
                        if (datatype === "date" && gateContext.connection) {
                            if (gateContext.connection.name === "oracle") {
                                nmColumn = this.dateTruncOracle(
                                    nmColumn,
                                    format,
                                );
                                param = this.dateTruncOracle(param, format);
                            } else if (
                                gateContext.connection.name === "postgresql"
                            ) {
                                nmColumn = this.dateTruncPostgreSQL(
                                    nmColumn,
                                    format,
                                );
                                param = this.dateTruncPostgreSQL(param, format);
                            }
                        }
                        vlFilter = `${vlFilter} and ${nmColumn} ${operator} ${param}`;
                        return true;
                    });
                }
                if (!isEmpty(jlSort)) {
                    vlSort = "";
                    jlSort.forEach((item) => {
                        const { property, direction } = item;
                        if (isEmpty(property) || !re.test(property)) {
                            return true;
                        }
                        if (
                            isEmpty(direction) ||
                            !DIRECTIONS.includes(direction.toUpperCase())
                        ) {
                            return true;
                        }
                        vlSort = `${vlSort}, ${property.toUpperCase()} ${direction.toUpperCase()}`;
                        return true;
                    });
                    if (vlSort.length <= 2) {
                        vlSort = null;
                    } else {
                        vlSort = vlSort.substr(2);
                    }
                }
            }

            if (isEmpty(vlSort)) {
                vlSort = "1";
            }
            if (isEmpty(vlFilter)) {
                vlFilter = "1 = 1";
            }
            query.applyMacro("&SORT", vlSort);
            query.applyMacro("&FILTER", vlFilter);
            query.applyMacro("&OFFSET", vlOffset);
            query.applyMacro("&FETCH", vlFetch);
            removeBlock.forEach((item) => {
                query.applyMacro(
                    `/\x5c*\x5cs*##\x5cs*${item}\x5cs*\x5c*[\x5cs\x5cS]*?${item}\x5cs*##\x5cs*\x5c*/`,
                    "",
                );
            });
            if (gateContext.isDebugEnabled()) {
                gateContext.debug(
                    `jl_filter: ${vlFilter}\n` +
                        `inParam: ${JSON.stringify(
                            query.inParams,
                        )}\njl_sort: ${vlSort}\n${query.queryStr}`,
                );
            }
            return resolve();
        });
    }

    /**
     * Преобразуем параметры фильтра и добавляем в inParam
     * @param gateContext
     * @param inParam
     * @param value
     * @param column
     * @param param
     */
    private toSqlValue(gateContext, inParam, value, column, param) {
        if (typeof value === "string") {
            if (
                column.startsWith("cd") ||
                column.startsWith("ct") ||
                column.startsWith("dt")
            ) {
                inParam[param] = gateContext.provider.dateInParams(value);
            } else {
                inParam[param] = value;
            }
        } else if (gateContext.connection?.name === "oracle" && typeof value === "boolean") {
            inParam[param] = value ? 1 : 0;
        } else if (Array.isArray(value)) {
            value.forEach((val, index) => {
                inParam[`${param}_${index}`] = val;
            });
        } else {
            inParam[param] = value;
        }
    }

    /**
     * Ищем вложеные объекты наподопие XPATH
     * @param obj - Объект поиска
     * @param path - путь
     * @returns {*}
     */
    private deepFindCheck(obj, path) {
        const paths = path.split(".");
        let current = obj;

        for (const val of paths) {
            if (current[val] === undefined || current[val] === null) {
                return false;
            }
            current = current[val];
        }
        return true;
    }
    /**
     * Функция преобразования даты в оракле
     * @param name
     * @param format
     */
    private dateTruncOracle(name: string, format: string) {
        switch (format) {
            case "1":
                return `trunc(${name}, 'YEAR')`;
            case "2":
                return `trunc(${name}, 'MONTH')`;
            case "3":
                return `trunc(${name}, 'DDD')`;
            case "4":
                return `trunc(${name}, 'HH')`;
            case "5":
                return `trunc(${name}, 'MI')`;
            case "6":
                return `${name}`;
            default:
                return `trunc(${name}, 'DDD')`;
        }
    }
    /**
     * Функция преобразования даты в потгрес
     * @param name
     * @param format
     */
    private dateTruncPostgreSQL(name: string, format: string) {
        switch (format) {
            case "1":
                return `date_trunc('year', ${name}::timestamp)`;
            case "2":
                return `date_trunc('month', ${name}::timestamp)`;
            case "3":
                return `date_trunc('day', ${name}::timestamp)`;
            case "4":
                return `date_trunc('hour', ${name}::timestamp)`;
            case "5":
                return `date_trunc('minute', ${name}::timestamp)`;
            case "6":
                return `date_trunc('second', ${name}::timestamp)`;
            default:
                return `date_trunc('day', ${name}::timestamp)`;
        }
    }
}
