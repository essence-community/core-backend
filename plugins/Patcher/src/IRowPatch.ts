import { isEmpty } from "@ungate/plugininf/lib/util/Util";
import * as moment from "moment";
export abstract class IRowPatch {
    public row: Record<string, any>;
    constructor(row: Record<string, any>) {
        this.row = row;
    }
    public abstract toRow(): string;
    public toStringOrNull(key: string, defaultValue: string = "null") {
        const val = this.row[key];
        return isEmpty(val) ? defaultValue : `'${val.replace("'", "''")}'`;
    }
    public toTimestamp(key: string) {
        const val = this.row[key];
        return isEmpty(val)
            ? "null"
            : `'${moment(val).format("YYYY-MM-DDTHH:mm:ss.SSSZZ")}'`;
    }
}
