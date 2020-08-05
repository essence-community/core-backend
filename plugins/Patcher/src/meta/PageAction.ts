import { format } from "util";
import { IRowPatch } from "../IRowPatch";

const formatPageActionSqlPostgres =
    "select pkg_patcher.p_merge_page_action(%s, %s, %s, %s, %s, %s);\n";

export class PageAction extends IRowPatch {
    public toRow(): string {
        return format(
            formatPageActionSqlPostgres,
            this.toStringOrNull("ck_id"),
            this.toStringOrNull("ck_page"),
            this.toStringOrNull("cr_type"),
            this.row.cn_action,
            this.toStringOrNull("ck_user"),
            this.toTimestamp("ct_change"),
        );
    }
}
