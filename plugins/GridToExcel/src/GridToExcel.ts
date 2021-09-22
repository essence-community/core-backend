import NullPlugin from "@ungate/plugininf/lib/NullPlugin";
import IResult from "@ungate/plugininf/lib/IResult";
import IContext from "@ungate/plugininf/lib/IContext";
import { IPluginRequestContext } from "@ungate/plugininf/lib/IPlugin";
import * as JsReport from "jsreport-core";
import * as JsReportXlsx from "jsreport-xlsx";
// @ts-ignore
import * as JsReportHandlerBars from "jsreport-handlebars";
import * as fs from "fs";
import * as path from "path";
import ICCTParams, { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import { getColumnName } from "./Util";
import ResultStream from "@ungate/plugininf/lib/stream/ResultStream";
import { ReadStreamToArray } from "@ungate/plugininf/lib/stream/Util";
import { isEmpty } from "@ungate/plugininf/lib/util/Util";

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
export default class GridToExcel extends NullPlugin {
    public static getParamsInfo(): IParamsInfo {
        // tslint:disable:object-literal-sort-keys
        return {};
    }
    private jsReport: JsReport.Reporter;
    private isPreInit = true;
    constructor(name: string, params: ICCTParams) {
        super(name, params);
        // @ts-ignore
        this.jsReport = JsReport({
            tasks: {
                allowedModules: "*",
            },
        } as any);
        // @ts-ignore
        this.jsReport.use(JsReportXlsx());
        // @ts-ignore
        this.jsReport.use(JsReportHandlerBars());
        this.init();
    }

    public async afterQueryExecutePerform(
        gateContext: IContext,
        PRequestContext: IPluginRequestContext,
        result: IResult,
    ): Promise<IResult | void> {
        if (this.isPreInit) {
            await this.jsReport.init();
            this.isPreInit = false;
        }
        if (isEmpty(gateContext.params.jsonbc)) {
            return;
        }
        const jsonbc: IJsonBc = JSON.parse(gateContext.params.jsonbc);
        if (isEmpty(jsonbc.columns)) {
            return;
        }
        const excelName = gateContext.params.excelname || jsonbc.excelname || "export_excel";
        const rows = await ReadStreamToArray(result.data);
        const configRender = {
            template: {
                recipe: "xlsx",
                engine: "handlebars",
                helpers: `function inc(value)
                {
                    return parseInt(value) + 2;
                }`,
                content:
                    '{{#xlsxAdd "xl/worksheets/sheet1.xml" "worksheet.cols"}}' +
                    "     <cols>" +
                    jsonbc.columns.reduce(
                        (all, col, colIndex) =>
                            `${all}\n<col customWidth="0" bestFit="1" width="20" max="${
                                colIndex + 1
                            }" min="${colIndex + 1}"/>`,
                        "",
                    ) +
                    "     </cols>" +
                    "{{/xlsxAdd}}" +
                    '{{#xlsxAdd "xl/worksheets/sheet1.xml" "worksheet.sheetData[0].row"}}' +
                    '     <row r="1" customHeight="0" bestFit="1">' +
                    jsonbc.columns.reduce(
                        (all, col, colIndex) =>
                            `${all}\n<c r="${getColumnName(
                                colIndex + 1,
                            )}1" t="inlineStr"><is><t>${
                                col.cv_displayed
                            }</t></is></c>`,
                        "",
                    ) +
                    "     </row>" +
                    "{{/xlsxAdd}}" +
                    "{{#each rows}}" +
                    '  {{#xlsxAdd "xl/worksheets/sheet1.xml" "worksheet.sheetData[0].row"}}' +
                    `     <row r="{{inc @index}}" customHeight="0" bestFit="1">` +
                    jsonbc.columns.reduce(
                        (all, col, colIndex) =>
                            `${all}\n<c r="${getColumnName(
                                colIndex + 1,
                            )}{{inc @index}}" t="inlineStr"><is><t>{{${
                                col.column
                            }}}</t></is></c>`,
                        "",
                    ) +
                    "     </row>" +
                    "  {{/xlsxAdd}}" +
                    "{{/each}}" +
                    (jsonbc.cv_displayed
                        ? '{{#xlsxMerge "xl/workbook.xml" "workbook.sheets[0].sheet[0]"}}' +
                          `     <sheet name="${jsonbc.cv_displayed}"/>` +
                          "{{/xlsxMerge}}"
                        : "") +
                    '{{#xlsxAdd "xl/worksheets/sheet1.xml" "worksheet.autoFilter"}}' +
                    `     <autoFilter ref="A1:${getColumnName(
                        jsonbc.columns.length,
                    )}1"/>` +
                    "{{/xlsxAdd}}" +
                    "{{{xlsxPrint}}}",
                xlsx: {
                    templateAsset: {
                        content: fs
                            .readFileSync(
                                path.join(__dirname, "assets", "book.xlsx"),
                            )
                            .toString("base64"),
                        encoding: "base64",
                    },
                },
            },
            data: {
                rows,
            },
        } as any;

        return this.jsReport.render(configRender).then(async (res) => {
            const filedata = await new Promise((resolve, reject) => {
                const bufs = [];
                res.stream.on("data", (data) => bufs.push(data));
                res.stream.on("error", (err) => reject(err));
                res.stream.on("end", () => {
                    resolve(Buffer.concat(bufs));
                });
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
        });
    }
}
