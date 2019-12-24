import { format } from "util";
import { IRowPatch } from "../IRowPatch";

const formatPageObjectSqlPostgres =
    "INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change)" +
    " VALUES (%s, %s, %s, %s, %s, %s, %s, %s) " +
    " on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;\n";

export class PageObject extends IRowPatch {
    public toRow(): string {
        return format(
            formatPageObjectSqlPostgres,
            this.toStringOrNull("ck_id"),
            this.toStringOrNull("cv_page"),
            this.toStringOrNull("ck_object"),
            this.row.cn_order,
            this.toStringOrNull("ck_parent"),
            "null",
            this.toStringOrNull("ck_user"),
            this.toTimestamp("ct_change"),
        );
    }
}
