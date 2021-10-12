import Connection from "@ungate/plugininf/lib/db/Connection";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import IContext from "@ungate/plugininf/lib/IContext";
import IObjectParam from "@ungate/plugininf/lib/IObjectParam";
import IProvider from "@ungate/plugininf/lib/IProvider";
import IQuery, { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import { IInParamArray, IOutParamArray } from "@ungate/plugininf/lib/IQuery";
import { forEach } from "lodash";
import Constants from "./Constants";

export default class WSQuery implements IGateQuery {
    public connection: Connection;
    public useMacros: boolean = false;
    public queryData: IObjectParam = {};
    public needSession: boolean = true;
    public type: number = 0;
    public extraInParams: IInParamArray[] = [];
    public extraOutParams: IOutParamArray[] = [];
    public inParams: IObjectParam = {};
    public outParams: IObjectParam = {};
    public macros: IObjectParam = {};
    public queryStr: string = "";
    public modifyMethod?: string;
    private queryAllParams: IObjectParam;
    constructor(gateContext: IContext, queryOptions: IQuery) {
        forEach(queryOptions, (value, key) => {
            this[key] = value;
        });
        const inParam = {};
        if (gateContext.session) {
            inParam[`${Constants.SESSION_PARAM_PREFIX}session`] =
                gateContext.session.session;
            inParam[
                `${Constants.SESSION_PARAM_PREFIX}data_object`
            ] = JSON.stringify(gateContext.session.userData);
            Object.keys(gateContext.session.sessionData).forEach((key) => {
                inParam[`${Constants.SESSION_PARAM_PREFIX}${key}`] =
                    typeof gateContext.session.userData[key] === "object"
                        ? JSON.stringify(gateContext.session.userData[key])
                        : gateContext.session.userData[key];
            });
            Object.keys(gateContext.session.userData).forEach((key) => {
                inParam[`${Constants.SESSION_PARAM_PREFIX}${key}`] =
                    typeof gateContext.session.userData[key] === "object"
                        ? JSON.stringify(gateContext.session.userData[key])
                        : gateContext.session.userData[key];
            });
        }
        this.queryAllParams = { ...gateContext.params, ...inParam };
    }
    public prepareParams(provider: IProvider) {
        const paramsArr = Object.entries(this.queryAllParams);
        const inParams = paramsArr
            .filter(
                (val) =>
                    !val[0].startsWith(Constants.OUT_PARAM_PREFIX) &&
                    Constants.RESERVED_PARAMS.indexOf(val[0]) === -1 &&
                    val[0][0] !== "&",
            )
            .reduce((obj, val) => {
                if (
                    val[0].startsWith("cd_") ||
                    val[0].startsWith("ct_") ||
                    val[0].startsWith("dt_")
                ) {
                    obj[val[0]] = provider.dateInParams(val[1]);
                } else {
                    obj[val[0]] = val[1];
                }
                return obj;
            }, {});
        if (this.useMacros) {
            this.macros = paramsArr
                .filter((val) => val[0][0] === "&")
                .reduce((obj, arr) => {
                    obj[arr[0]] = arr[1];
                    return obj;
                }, {});
            paramsArr
                .filter((val) => val[0][0] === "&")
                .forEach((val) => this.applyMacro(val[0], val[1]));
        }
        const outParams = paramsArr
            .filter((val) => val[0].startsWith(Constants.OUT_PARAM_PREFIX))
            .reduce((obj, val) => {
                const name = val[0].substr(Constants.OUT_PARAM_PREFIX.length);
                obj[name] = name.indexOf("cur_") === 0 ? "CURSOR" : null;
                return obj;
            }, {});
        this.inParams = {
            ...this.inParams,
            ...inParams,
        };
        this.outParams = {
            ...this.outParams,
            ...outParams,
        };
        if (this.extraInParams.length) {
            const needParams = [];
            this.extraInParams.forEach((item) => {
                if (
                    !Object.prototype.hasOwnProperty.call(
                        this.inParams,
                        item.cv_name,
                    ) ||
                    item.cl_replace
                ) {
                    this.inParams[item.cv_name] = item.cv_value;
                }
                if (
                    !Object.prototype.hasOwnProperty.call(
                        this.inParams,
                        item.cv_name,
                    ) &&
                    item.cl_require
                ) {
                    needParams.push(item.cv_name);
                }
            });
            if (needParams.length) {
                throw new ErrorException(
                    -1,
                    `Не переданы обязательные параметры: ${needParams.join(
                        ",",
                    )}`,
                );
            }
        }
        if (this.extraOutParams.length) {
            this.extraOutParams.forEach((item) => {
                if (
                    !Object.prototype.hasOwnProperty.call(
                        this.outParams,
                        item.cv_name,
                    ) ||
                    item.cl_replace
                ) {
                    this.outParams[item.cv_name] = item.outType;
                } else if (!this.outParams[item.cv_name]) {
                    this.outParams[item.cv_name] = item.outType;
                }
            });
        }
        const json = this.inParams.json ? JSON.parse(this.inParams.json) : {};
        const jsonObject = json.data || json.filter || {};
        if (
            this.inParams[Constants.SCHEMA_PARAM] ||
            jsonObject[Constants.SCHEMA_PARAM]
        ) {
            this.inParams[Constants.SCHEMA_PARAM] =
                this.inParams[Constants.SCHEMA_PARAM] ||
                jsonObject[Constants.SCHEMA_PARAM];
            this.applyMacro(
                `&${Constants.SCHEMA_PARAM}`,
                this.inParams[Constants.SCHEMA_PARAM],
            );
        }
    }
    /**
     * Правим значения в запросе
     * @param regexp {string} RegExp строка
     * @param data {string} На что правим
     */
    public applyMacro(regexp: string, data: string) {
        this.queryStr = this.queryStr.replace(new RegExp(regexp, "g"), data);
    }
}
