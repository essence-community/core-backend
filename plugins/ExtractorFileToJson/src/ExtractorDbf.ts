import { EventEmitter } from "events";
import { ParserDbf } from "./ParserDbf";

export class ExtractorDbf extends EventEmitter {
    private dbf: ParserDbf;
    private packRows: number;
    private pack: any[] = [];
    private isEventRead: boolean = false;
    private flag: number = 0;
    private bindParseRow: (row: any) => void;
    constructor(path: string, packRows: number, encoding: string = "utf-8") {
        super();
        this.packRows = packRows;
        this.dbf = new ParserDbf(path, encoding);
        this.dbf.on("end", () => {
            if (this.pack.length) {
                this.emit("pack", [...this.pack]);
            }
        });
    }
    public on(
        event: "pack" | "end" | "error",
        listener: (...args: any[]) => void,
    ) {
        super.on(event as string, listener);
        if (event === "pack") {
            if (!this.isEventRead) {
                this.bindParseRow = (row) => this.parseRow(this, row);
                this.dbf.on("record", this.bindParseRow);
                this.isEventRead = true;
                this.dbf.parse();
            }
            this.flag += 1;
        } else if ((event as string) !== "record") {
            this.dbf.on(event, listener);
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
                this.dbf.removeListener("record", this.bindParseRow);
                this.isEventRead = false;
            }
        }
        return this;
    }

    public pause() {
        this.dbf.pause();
    }

    public resume() {
        this.dbf.resume();
    }
    private parseRow(self, row) {
        self.pack.push(row);
        if (self.pack.length >= self.packRows) {
            self.emit("pack", [...self.pack]);
            self.pack = [];
        }
    }
}
