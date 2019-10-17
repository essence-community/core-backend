import { EventEmitter } from "events";
import * as fs from "fs";

import HeaderDbf from "./HeaderDbf";

export class ParserDbf extends EventEmitter {
    public filename: string;
    public encoding: string = "utf-8";
    public header: HeaderDbf;
    private paused: boolean;
    private readBuf: () => void;
    constructor(filename: string, encoding: string = "utf-8") {
        super();

        this.filename = filename;
        this.encoding = encoding;
    }

    public parse() {
        this.emit("start", this);

        this.header = new HeaderDbf(this.filename, this.encoding);
        this.header.parse((err) => {
            if (err) {
                this.emit("error", err);
                return;
            }
            this.emit("header", this.header);

            let sequenceNumber = 0;

            let loc = this.header.start;
            let bufLoc = this.header.start;
            let overflow = null;
            this.paused = false;

            const stream = fs.createReadStream(this.filename);

            this.readBuf = () => {
                let buffer;
                if (this.paused) {
                    this.emit("paused");
                    return;
                }

                // tslint:disable-next-line: no-conditional-assignment
                while ((buffer = stream.read())) {
                    if (bufLoc !== this.header.start) {
                        bufLoc = 0;
                    }
                    if (overflow !== null) {
                        buffer = overflow + buffer;
                    }

                    while (
                        loc <
                            this.header.start +
                                this.header.numberOfRecords *
                                    this.header.recordLength &&
                        bufLoc + this.header.recordLength <= buffer.length
                    ) {
                        this.emit(
                            "record",
                            this.parseRecord(
                                ++sequenceNumber,
                                buffer.slice(
                                    bufLoc,
                                    (bufLoc += this.header.recordLength),
                                ),
                            ),
                        );
                    }

                    loc += bufLoc;
                    if (bufLoc < buffer.length) {
                        overflow = buffer.slice(bufLoc, buffer.length);
                    } else {
                        overflow = null;
                    }

                    return this;
                }
            };
            stream.on("error", (e) => this.emit("error", e));
            stream.on("readable", this.readBuf);
            return stream.on("end", () => {
                return this.emit("end");
            });
        });

        return this;
    }

    public pause() {
        return (this.paused = true);
    }

    public resume() {
        this.paused = false;
        this.emit("resuming");
        return this.readBuf();
    }

    private parseRecord(sequenceNumber, buffer) {
        const record = {
            "@sequenceNumber": sequenceNumber,
            // tslint:disable-next-line: object-literal-sort-keys
            "@deleted": [42, "*"].includes(buffer.slice(0, 1)[0]),
        };

        let loc = 1;
        return this.header.fields.reduce((rec, field) => {
            rec[field.name] = this.parseField(
                field,
                buffer.slice(loc, (loc += field.length)),
            );
            return rec;
        }, record);
    }

    private parseField(field, buffer) {
        let value = buffer.toString(this.encoding).trim();

        if (field.type === "C") {
            // Character
            value = value;
        } else if (field.type === "F") {
            // Floating Point
            value = value;
        } else if (field.type === "L") {
            // Logical
            switch (value) {
                case ["Y", "y", "T", "t"].includes(value):
                    value = true;
                    break;
                case ["N", "n", "F", "f"].includes(value):
                    value = false;
                    break;
                default:
                    value = null;
            }
        } else if (field.type === "M") {
            // Memo
            value = value;
        } else if (field.type === "N") {
            // Numeric
            value = value;
        }

        return value;
    }
}
