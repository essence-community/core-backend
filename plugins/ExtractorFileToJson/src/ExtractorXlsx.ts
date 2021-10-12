import { EventEmitter } from "events";
import * as fs from "fs";
import { isString } from "lodash";
import { Readable } from "stream";
import * as XlsxStreamReader from "xlsx-stream-reader";
const TIMEOUT = 1000;
export class ExtractorXlsx extends EventEmitter {
    private xlsx: XlsxStreamReader;
    protected packRows: number;
    private pack: any[] = [];
    private isEnd: boolean = false;
    private flag: number = 0;
    private worksheets: any[] = [];
    private worksheet: any;
    private bindParseRow: (row: any) => void;
    constructor(path: string | Readable, packRows: number) {
        super();
        this.packRows = packRows;
        const fileStream = isString(path)
            ? fs.createReadStream(path as string)
            : path;
        this.xlsx = new XlsxStreamReader();
        this.xlsx.on("worksheet", (worksheet) => {
            this.worksheets.push(worksheet);
            this.worksheets.sort((a, b) => {
                return a.id - b.id;
            });
        });
        this.xlsx.on("end", () => {
            this.isEnd = true;
        });
        fileStream.pipe(this.xlsx);
    }
    public on(
        event: "pack" | "end" | "error",
        listener: (...args: any[]) => void,
    ) {
        super.on(event as string, listener);
        if (event === "pack") {
            this.bindParseRow = (row) => this.parseRow(this, row);
            if (
                this.flag === 0 &&
                this.worksheet &&
                !this.worksheet.isRowParse
            ) {
                this.worksheet.on("row", this.bindParseRow);
            }
            this.flag += 1;
        } else if ((event as string) !== "row" && (event as string) !== "end") {
            this.xlsx.on(event, listener);
        }
        return this;
    }
    public process() {
        this.worksheet = this.worksheets[0];
        if (this.worksheet) {
            this.worksheet.on("row", this.bindParseRow);
            this.worksheet.on("error", (err) => this.emit("error", err));
            this.worksheet.isRowParse = true;
            this.worksheet.on("end", () => {
                this.worksheets = this.worksheets.filter(
                    (w) => this.worksheet.id !== w.id,
                );
                if (this.pack.length) {
                    this.emit("pack", [...this.pack], this.worksheet.id);
                    this.pack = [];
                }
                this.process();
            });
            this.worksheet.process();
        } else if (this.isEnd && this.worksheets.length === 0) {
            this.emit("end");
        } else {
            setTimeout(() => this.process(), TIMEOUT);
        }
    }
    public removeListener(
        event: string | symbol,
        listener: (...args: any[]) => void,
    ) {
        super.removeListener(event, listener);
        if (event === "pack") {
            this.flag -= 1;
            if (this.flag === 0) {
                this.worksheet.removeListener("row", this.bindParseRow);
                this.worksheet.isRowParse = false;
            }
        }
        return this;
    }

    public pause() {
        if (this.worksheet) {
            this.worksheet.workSheetStream.pause();
        }
    }

    public resume() {
        if (this.worksheet) {
            this.worksheet.workSheetStream.resume();
        }
    }
    private parseRow(self, row) {
        try {
            const rowData = {};
            row.values.forEach((val, index) => {
                rowData[self.worksheet.getColumnName(index)] = val;
            });
            self.pack.push(rowData);
            if (self.pack.length >= self.packRows) {
                self.emit("pack", [...self.pack], self.worksheet.id);
                self.pack = [];
            }
        } catch (e) {
            self.emit("error", e);
        }
    }
}
