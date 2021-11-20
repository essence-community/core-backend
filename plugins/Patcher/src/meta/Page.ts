import { format } from "util";
import { IRowPatch } from "../IRowPatch";

const formatPageSqlPostgres =
    "INSERT INTO s_mt.t_page (ck_id, ck_parent, cr_type, cv_name, cn_order, cl_static, cv_url, ck_icon, ck_user, ct_change, cl_menu, ck_view)" +
    " VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s) " +
    "on conflict (ck_id) do update set ck_parent = excluded.ck_parent, cr_type = excluded.cr_type, cv_name = excluded.cv_name, cn_order = excluded.cn_order, cl_static = excluded.cl_static, cv_url = excluded.cv_url, ck_icon = excluded.ck_icon, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_menu = excluded.cl_menu, ck_view = excluded.ck_view;\n";

export class Page extends IRowPatch {
    public toRow(): string {
        return format(
            formatPageSqlPostgres,
            this.toStringOrNull("ck_id"),
            this.toStringOrNull("ck_parent"),
            this.row.cr_type,
            this.toStringOrNull("cv_name"),
            this.row.cn_order,
            this.row.cl_static,
            this.toStringOrNull("cv_url"),
            this.toStringOrNull("ck_icon"),
            this.toStringOrNull("ck_user"),
            this.toTimestamp("ct_change"),
            this.row.cl_menu,
            this.toStringOrNull("ck_view"),
        );
    }
}
