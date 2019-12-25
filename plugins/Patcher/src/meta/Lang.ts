import { format } from "util";
import { IRowPatch } from "../IRowPatch";

const formatDLangSqlPostgres =
    "INSERT INTO s_mt.t_d_lang (ck_id, cv_name, cl_default, ck_user, ct_change)" +
    " VALUES(%s, %s, %s, %s, %s) " +
    "on conflict (ck_id) do update set cv_name = excluded.cv_name, cl_default = excluded.cl_default, ck_user = excluded.ck_user, ct_change = excluded.ct_change;\n";

export class Lang extends IRowPatch {
    public toRow(): string {
        return format(
            formatDLangSqlPostgres,
            this.toStringOrNull("ck_id"),
            this.toStringOrNull("cv_name"),
            this.row.cl_default,
            this.toStringOrNull("ck_user"),
            this.toTimestamp("ct_change"),
        );
    }
}
