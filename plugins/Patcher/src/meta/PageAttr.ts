import { format } from "util";
import { IRowPatch } from "../IRowPatch";

var formatPageAttrSqlPostgres = "INSERT INTO s_mt.t_page_attr" +
		"(ck_id, ck_page, ck_attr, cv_value, ck_user, ct_change)" +
		" VALUES (%s, %s, %s, %s, %s, %s) " +
		" on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;"


export class PageAttr extends IRowPatch {
    public toRow(): string {
        return format(
            formatPageAttrSqlPostgres,
            this.toStringOrNull("ck_id"),
            this.toStringOrNull("ck_page"),
            this.toStringOrNull("ck_attr"),
            this.toStringOrNull("cv_value"),
            this.toStringOrNull("ck_user"),
            this.toTimestamp("ct_change"),
        );
    }
}
