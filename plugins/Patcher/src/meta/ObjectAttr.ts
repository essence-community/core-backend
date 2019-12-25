import { format } from "util";
import { IRowPatch } from "../IRowPatch";

const formatMObjectAttrSqlPostgres =
    "select pkg_patcher.p_merge_object_attr(%s, %s, %s, %s, %s, %s);\n";

export class ObjectAttr extends IRowPatch {
    public toRow(): string {
        return format(
            formatMObjectAttrSqlPostgres,
            this.toStringOrNull("ck_id"),
            this.toStringOrNull("ck_object"),
            this.toStringOrNull("ck_class_attr"),
            this.toStringOrNull("cv_value"),
            this.toStringOrNull("ck_user"),
            this.toTimestamp("ct_change"),
        );
    }
}
