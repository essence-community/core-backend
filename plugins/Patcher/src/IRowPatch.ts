import { isEmpty } from "@ungate/plugininf/lib/util/Util";
import * as moment from "moment";
export abstract class IRowPatch {
    public row: Record<string, any>;
    constructor(row: Record<string, any>) {
        this.row = row;
    }
    public abstract toRow(): string;
    public toStringOrNull(key: string, defaultValue: string = "null") {
        let val = this.row[key];
        if (!isEmpty(val) && (typeof val === "object" || Array.isArray(val))) {
            val = JSON.stringify(val);
        }
        if (!isEmpty(val) && typeof val !== "string") {
            val = `${val}`;
        }
        return isEmpty(val) ? defaultValue : `'${val.replace(/'/g, "''")}'`;
    }
    public toTimestamp(key: string) {
        const val = this.row[key];
        return isEmpty(val)
            ? "null"
            : `'${moment(val).format("YYYY-MM-DDTHH:mm:ss.SSSZZ")}'`;
    }
    public toBinary(key: string) {
        const val = this.row[key];
        return isEmpty(val) || (val && val.length === 0)
            ? "null"
            : `DECODE('${(Buffer.from(val)).toString('base64')}', 'BASE64')`;
    }
}
