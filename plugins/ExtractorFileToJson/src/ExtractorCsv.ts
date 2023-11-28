import { EventEmitter } from "events";
import * as Сsv from "fast-csv";
import * as fs from "fs";
import { isString } from "lodash";
import { getColumnName } from "./Utils";

export interface ICsvOptions {
    // Ensure that data events have an object emitted rather than the stringified version set to false to have a stringified buffer.
    objectMode: boolean;
    // If your data uses an alternate delimiter such as ; or \t.
    delimiter?: string;
    // NOTE When specifying an alternate delimiter you may only pass in a single character delimiter
    // The character to use to quote fields that contain a delimiter. If you set to null then all quoting will be ignored.
    quote?: string;
    // The character to used tp escape quotes inside of a quoted field.
    escape?: string;
    // If you wish to ignore empty rows.
    ignoreEmpty?: boolean;
    // If your CSV contains comments you can use this option to ignore lines that begin with the specified character (e.g. #).
    comment?: string;
    // If you want to discard columns that do not map to a header.
    discardUnmappedColumns?: boolean;
    strictColumnHandling?: boolean;
    trim?: boolean;
    rtrim?: boolean;
    ltrim?: boolean;
    encoding: string;
}

export class ExtractorCsv extends EventEmitter {
    private csv: any;
    protected packRows: number;
    private pack: any[] = [];
    private isEventRead: boolean = false;
    private flag: number = 0;
    private bindParseRow: (row: any) => void;
    constructor(
        path: string,
        packRows: number,
        options: ICsvOptions = {
            encoding: "utf-8",
            objectMode: true,
        },
    ) {
        super();
        this.packRows = packRows;
        const fileStream = isString(path)
            ? fs.createReadStream(path as string)
            : path;
        this.csv = Сsv.parse(options);
        this.csv.on("end", () => {
            if (this.pack.length) {
                this.emit("pack", [...this.pack]);
            }
        });
        fileStream.pipe(this.csv);
    }
    public on(
        event: "pack" | "end" | "error",
        listener: (...args: any[]) => void,
    ) {
        super.on(event as string, listener);
        if (event === "pack") {
            if (!this.isEventRead) {
                this.bindParseRow = (row) => this.parseRow(this, row);
                this.csv.on("data", this.bindParseRow);
                this.isEventRead = true;
            }
            this.flag += 1;
        } else if ((event as string) !== "data") {
            this.csv.on(event, listener);
        }
        return this;
    }
    public removeListener(
        event: string | symbol,
        listener: (...args: any[]) => void,
    ) {
        super.removeListener(event, listener);
        if (event === "pack") {
            this.flag -= 1;
            if (this.flag === 0) {
                this.csv.removeListener("data", this.bindParseRow);
                this.isEventRead = false;
            }
        }
        return this;
    }

    public pause() {
        this.csv.pause();
    }

    public resume() {
        this.csv.resume();
    }
    private parseRow(self, row) {
        const rowData = {};
        (row || []).forEach((item, index) => {
            rowData[getColumnName(index + 1)] = item;
        });
        self.pack.push(rowData);
        if (self.pack.length >= self.packRows) {
            self.emit("pack", [...self.pack]);
            self.pack = [];
        }
    }
}
