import { isEmpty } from '@ungate/plugininf/lib/util/Util';
import * as fs from "fs";
import { getColumnName } from './ExtractorCsv';

export interface IField {
    name: string;
    type: string;
    displacement: number;
    length: number;
    decimalPlaces: number;
}
export default class HeaderDbf {
    public filename: string;
    public encoding: string = "utf-8";
    public type: string;
    public dateUpdated: Date;
    public numberOfRecords: number;
    public start: number;
    public recordLength: number;
    public fields: IField[];
    constructor(filename: string, encoding: string = "utf-8") {
        this.filename = filename;
        this.encoding = encoding;
    }

    public parse(callback) {
        fs.readFile(this.filename, (err, buffer) => {
            if (err) {
                return callback(err);
            }

            this.type = buffer.slice(0, 1).toString(this.encoding);
            this.dateUpdated = this.parseDate(buffer.slice(1, 4));
            this.numberOfRecords = this.convertBinaryToInteger(
                buffer.slice(4, 8),
            );
            this.start = this.convertBinaryToInteger(buffer.slice(8, 10));
            this.recordLength = this.convertBinaryToInteger(
                buffer.slice(10, 12),
            );

            const result = [];
            for (let i = 32, end = this.start - 32; i <= end; i += 32) {
                result.push(buffer.slice(i, i + 32));
            }

            this.fields = result.map((buf, index) => this.parseFieldSubRecord(buf, index));

            callback();
        });
    }

    private parseDate(buffer) {
        const year = 1900 + this.convertBinaryToInteger(buffer.slice(0, 1));
        const month = this.convertBinaryToInteger(buffer.slice(1, 2)) - 1;
        const day = this.convertBinaryToInteger(buffer.slice(2, 3));

        return new Date(year, month, day);
    }

    private parseFieldSubRecord(buffer, index) {
        const name = buffer
            .slice(0, 11)
            .toString(this.encoding)
            .replace(/[\u0000]+$/, "")
            .replace(/.*(\d*).*/gi, "$1");
        return {
            name: isEmpty(name) ? getColumnName(index+1) : getColumnName(name),
            type: buffer.slice(11, 12).toString(this.encoding),
            // tslint:disable-next-line: object-literal-sort-keys
            displacement: this.convertBinaryToInteger(buffer.slice(12, 16)),
            length: this.convertBinaryToInteger(buffer.slice(16, 17)),
            decimalPlaces: this.convertBinaryToInteger(buffer.slice(17, 18)),
        };
    }

    private convertBinaryToInteger(buffer) {
        return buffer.readIntLE(0, buffer.length);
    }
}
