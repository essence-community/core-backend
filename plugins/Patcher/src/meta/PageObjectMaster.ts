import { format } from "util";
import { IRowPatch } from "../IRowPatch";

const formatMPageObjectMasterSqlPostgres =
    "update s_mt.t_page_object set ck_master=%s where ck_id=%s;\n";

export class PageObjectMaster extends IRowPatch {
    public toRow(): string {
        return format(
            formatMPageObjectMasterSqlPostgres,
            this.toStringOrNull("ck_master"),
            this.toStringOrNull("ck_id"),
        );
    }
}
