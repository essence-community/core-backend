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
import * as path from "path";
import * as fs from "fs";
import Constant from "@ungate/plugininf/lib/Constants";
import { v4 as uuid } from 'uuid';

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
    "3": "dd\\.mm\\.yyyy",
    "4": "dd\\.mm\\.yyyy HH:00",
    "5": "dd\\.mm\\.yyyy HH:mm",
    "6": "dd\\.mm\\.yyyy HH:mm:ss",
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
        const temp = path.resolve(
            Constant.UPLOAD_DIR,
            `export_excel_${uuid()}.xlsx`,
        );
        if(!wb.Props) wb.Props = {};
        wb.Props.CreatedDate = new Date();
        wb.Props.Author = userData ?`${userData.cv_surname?userData.cv_surname:""}${userData.cv_name?" "+userData.cv_name:""}${userData.cv_patronymic?" "+userData.cv_patronymic:""}${userData.cv_email?" ("+userData.cv_email+")":""}` : "essence";
        XLSX.writeFile(wb, temp, {
            cellStyles: true,
            Props: {
                Title: jsonbc.cv_displayed || "Export xlsx",
                Comments: `Create xlsx-js-style version: ${XLSX.version}, style-version: ${(XLSX as any).style_version}`,
            }
        });
        const filedata = fs.readFileSync(temp);
        fs.unlinkSync(temp);

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
            result.s.numFmt = DATE_FORMAT[col.format] || DATE_FORMAT[3];
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
