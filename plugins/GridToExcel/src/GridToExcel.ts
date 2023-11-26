import NullPlugin from "@ungate/plugininf/lib/NullPlugin";
import IResult from "@ungate/plugininf/lib/IResult";
import IContext from "@ungate/plugininf/lib/IContext";
import { IPluginRequestContext } from "@ungate/plugininf/lib/IPlugin";
import * as XLSX from "xlsx-js-style";
import ICCTParams, { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import { getColumnName } from "./Util";
import ResultStream from "@ungate/plugininf/lib/stream/ResultStream";
import { ReadStreamToArray } from "@ungate/plugininf/lib/stream/Util";
import { isEmpty, transformToBoolean } from "@ungate/plugininf/lib/util/Util";
import * as moment from "moment";

interface IColumn {
    cv_description?: string;
    cv_displayed?: string;
    column: string;
    currencysign: string;
    datatype: string;
    decimalprecision: number;
    decimalseparator: string;
    format: string;
    thousandseparator: string;
}

interface IJsonBc {
    cv_description?: string;
    cv_displayed?: string;
    excelname?: string;
    columns: IColumn[];
}

const DATE_FORMAT = {
    "1": "yyyy",
    "2": "MMM yyyy",
    "3": "dd.MM.yyyy",
    "4": "dd.MM.yyyy HH:00",
    "5": "dd.MM.yyyy HH:mm",
    "6": "dd.MM.yyyy HH:mm:ss",
};

export default class GridToExcel extends NullPlugin {
    public static getParamsInfo(): IParamsInfo {
        // tslint:disable:object-literal-sort-keys
        return {};
    }
    constructor(name: string, params: ICCTParams) {
        super(name, params);
    }

    public async afterQueryExecutePerform(
        gateContext: IContext,
        PRequestContext: IPluginRequestContext,
        result: IResult,
    ): Promise<IResult | void> {
        if (isEmpty(gateContext.params.jsonbc)) {
            return;
        }
        const jsonbc: IJsonBc = JSON.parse(gateContext.params.jsonbc);
        if (isEmpty(jsonbc.columns)) {
            return;
        }
        const excelName =
            gateContext.params.excelname || jsonbc.excelname || "export_excel";
        const rows = await ReadStreamToArray(result.data);
        const wb = XLSX.utils.book_new();
        const ws = XLSX.utils.aoa_to_sheet([
            jsonbc.columns.map((col) => ({
                t: isEmpty(col.cv_displayed) ? "z" : "s",
                v: col.cv_displayed || "",
                z: "@",
                s: {
                    border: {
                        top: {
                            style: "thin",
                            color: {
                                rgb: "000000"
                            }
                        },
                        bottom: {
                            style: "thin",
                            color: {
                                rgb: "000000"
                            }
                        },
                        right: {
                            style: "thin",
                            color: {
                                rgb: "000000"
                            }
                        },
                        left: {
                            style: "thin",
                            color: {
                                rgb: "000000"
                            }
                        }
                    },
                    numFmt: "@",
                }
            })),
            ...rows.map((row) => jsonbc.columns.map((col) => this.formatValue(col, row[col.column]))),
        ], {
            cellStyles: true,
        });
        ws["!autofilter"] = { ref: `A1:${getColumnName(jsonbc.columns.length)}1` };
        ws["!cols"] = jsonbc.columns.map(() => ({ width: 30 }));
        XLSX.utils.book_append_sheet(wb, ws, jsonbc.cv_displayed || "Export");
        const userData = gateContext.session?.userData;
        const filedata = XLSX.writeXLSX(wb, {
            type: "buffer",
            cellStyles: true,
            Props: {
                Title: jsonbc.cv_displayed || "Export xlsx",
                CreatedDate: new Date(),
                Author: userData ? `${gateContext.session?.userData.cv_surname || ""} ${gateContext.session?.userData.cv_name || ""} ${gateContext.session?.userData.cv_patronymic || ""}${gateContext.session?.userData.cv_email ? ` (${gateContext.session?.userData.cv_email})` : ""}` : "essence",
            }
        });

        return {
            type: "attachment",
            data: ResultStream({
                filename: `${excelName}.xlsx`,
                filetype:
                    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
                filedata,
            }),
        };
    }

    formatValue = (col: IColumn, value: any) => {
        const result = {
            t: "s",
            v: value,
            z: "@",
            s: {
                border: {
                    top: {
                        style: "thin",
                        color: {
                            rgb: "000000"
                        }
                    },
                    bottom: {
                        style: "thin",
                        color: {
                            rgb: "000000"
                        }
                    },
                    right: {
                        style: "thin",
                        color: {
                            rgb: "000000"
                        }
                    },
                    left: {
                        style: "thin",
                        color: {
                            rgb: "000000"
                        }
                    }
                },
                numFmt: "@",
            } as XLSX.CellStyle
        } as XLSX.CellObject;
        if (isEmpty(value)) {
            result.t = "z";
            result.v = "";
            return result;
        }
        if (col.datatype === "boolean" || col.datatype === "checkbox") {
            result.t = "b";
            result.v = transformToBoolean(result.v);
        }
        if (col.datatype === "date") {
            result.t = typeof result.v === "string" || typeof result.v === "object" ? "d" : "z";
            result.v = typeof result.v === "string" || typeof result.v === "object" ? moment(result.v as string).toDate() : "";
            result.z = DATE_FORMAT[col.format] || DATE_FORMAT[3];
            result.s.numFmt = DATE_FORMAT[3];
        }
        if (col.datatype === "integer") {
            result.t = "n";
            result.s.numFmt = "0";
            result.z = "0";
            if (col.currencysign) {
                result.s.numFmt += col.currencysign;
                result.z += col.currencysign;
            }
        }
        if (col.datatype === "numeric") {
            result.t = "n";
            result.s.numFmt = "0";
            result.z = "0";
            if (col.decimalprecision > 0) {
                result.s.numFmt = "0.0";
                result.z = "0.0";
                for (let i = 1; i < col.decimalprecision; i += 1) {
                    result.s.numFmt += "#";
                    result.z += "#";
                }
            }
            if (col.currencysign) {
                result.s.numFmt += col.currencysign;
                result.z += col.currencysign;
            }
        }
        return result;
    }
}
