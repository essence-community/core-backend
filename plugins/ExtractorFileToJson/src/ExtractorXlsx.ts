import { EventEmitter } from "events";
import { Readable } from "stream";
import * as XLSX from "xlsx-js-style";
import { getColumnName } from "./Utils";
const TIMEOUT = 500;
interface IWSReadable extends Readable {
    id: string;
}
interface IWS {
    id: string;
    ws: XLSX.WorkSheet;
}
export class ExtractorXlsx extends EventEmitter {
    private xlsx: XLSX.WorkBook;
    protected packRows: number;
    private pack: any[] = [];
    private worksheets: IWS[] = [];
    private worksheet: IWSReadable;
    private bindParseRow = (row) => this.parseRow(this, row);
    constructor(path: string, packRows: number) {
        super();
        this.packRows = packRows;
        
        this.xlsx = XLSX.readFile(path);
        this.worksheets = Object.entries(this.xlsx.Sheets).map(([id, ws]) => {
            return {
                id,
                ws,
            };
        });
    }
    public on(
        event: "pack" | "end" | "error",
        listener: (...args: any[]) => void,
    ) {
        super.on(event as string, listener);
        return this;
    }
    public process() {
        if (this.worksheets.length === 0) {
            this.emit("end");
            return;
        }
        const ws = this.worksheets[0].ws;
        this.worksheet = new Readable({
            objectMode: true,
            read(size) { 
                const data = XLSX.utils.sheet_to_json(ws, { header: 1 });
                data.forEach((row) => {
                    this.push(row);
                });
                this.push(null);
            }
        }) as IWSReadable;
        this.worksheet.id = this.worksheets[0].id;
        if (this.worksheet) {
            this.worksheet.on("data", this.bindParseRow);
            this.worksheet.on("error", (err) => this.emit("error", err));
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
        } else {
            setTimeout(() => this.process(), TIMEOUT);
        }
    }
    public removeListener(
        event: string | symbol,
        listener: (...args: any[]) => void,
    ) {
        super.removeListener(event, listener);
        return this;
    }

    public pause() {
        if (this.worksheet) {
            this.worksheet.pause();
        }
    }

    public resume() {
        if (this.worksheet) {
            this.worksheet.resume();
        }
    }
    private parseRow(self, row) {
        try {
            const rowData = {};
            row.forEach((val, index) => {
                rowData[getColumnName(index+1)] = val;
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
