import { format } from "util";
import { IRowPatch } from "../IRowPatch";

const formatMObjectSqlPostgres =
    "select pkg_patcher.p_merge_object(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s);\n";

export class MObject extends IRowPatch {
    public toRow(): string {
        return format(
            formatMObjectSqlPostgres,
            this.toStringOrNull("ck_id"),
            this.toStringOrNull("ck_class"),
            this.toStringOrNull("ck_parent"),
            this.toStringOrNull("cv_name"),
            this.row.cn_order,
            this.toStringOrNull("ck_query"),
            this.toStringOrNull("cv_description"),
            this.toStringOrNull("cv_displayed"),
            this.toStringOrNull("cv_modify"),
            this.toStringOrNull("ck_provider"),
            this.toStringOrNull("ck_user"),
            this.toTimestamp("ct_change"),
        );
    }
}
