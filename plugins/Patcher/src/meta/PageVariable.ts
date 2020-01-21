import { format } from "util";
import { IRowPatch } from "../IRowPatch";

const formatPageVariableSqlPostgres =
    "INSERT INTO s_mt.t_page_variable (ck_id, ck_page, cv_name, cv_description, cv_value, ck_user, ct_change)" +
    " VALUES(%s, %s, %s, %s, %s, %s, %s) " +
    "on conflict (ck_id) do update set ck_page = excluded.ck_page, cv_name = excluded.cv_name, cv_description = excluded.cv_description, ck_user = excluded.ck_user, ct_change = excluded.ct_change;\n";

export class PageVariable extends IRowPatch {
    public toRow(): string {
        return format(
            formatPageVariableSqlPostgres,
            this.toStringOrNull("ck_id"),
            this.toStringOrNull("ck_page"),
            this.toStringOrNull("cv_name"),
            this.toStringOrNull("cv_description"),
            this.toStringOrNull("cv_value"),
            this.toStringOrNull("ck_user"),
            this.toTimestamp("ct_change"),
        );
    }
}
