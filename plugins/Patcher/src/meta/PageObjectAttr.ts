import { format } from "util";
import { IRowPatch } from "../IRowPatch";

const formatMPageObjectAttrSqlPostgres =
    "select pkg_patcher.p_merge_page_object_attr(%s, %s, %s, %s, %s, %s, %s);\n";

export class PageObjectAttr extends IRowPatch {
    public toRow(): string {
        return format(
            formatMPageObjectAttrSqlPostgres,
            this.toStringOrNull("ck_id"),
            this.toStringOrNull("ck_page_object"),
            this.toStringOrNull("ck_class_attr"),
            this.toStringOrNull("cv_value"),
            this.toStringOrNull("ck_user"),
            this.toTimestamp("ct_change"),
            this.toStringOrNull("ck_attr"),
        );
    }
}
