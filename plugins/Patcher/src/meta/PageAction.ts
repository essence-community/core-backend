import { format } from "util";
import { IRowPatch } from "../IRowPatch";

const formatPageActionSqlPostgres =
    "INSERT INTO s_mt.t_page_action (ck_id, ck_page, cr_type, cn_action, ck_user, ct_change)" +
    "VALUES(%s, %s, %s, %s, %s, %s) " +
    "on conflict (ck_id) do update set ck_page = excluded.ck_page, cr_type = excluded.cr_type, cn_action = excluded.cn_action, ck_user = excluded.ck_user, ct_change = excluded.ct_change;\n";

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
