import { format } from "util";
import { IRowPatch } from "../IRowPatch";

const formatMPageObjectAttrSqlPostgres =
    "INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change)" +
    " VALUES (%s, %s, %s, %s, %s, %s) " +
    " ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;\n";

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
        );
    }
}
