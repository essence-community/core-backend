import { format } from "util";
import { IRowPatch } from "../IRowPatch";

const formatInfoSqlPostgres =
    "INSERT INTO s_at.t_d_info (ck_id, cv_description, cr_type, cl_required, ck_user, ct_change) " +
    " VALUES(%s, %s, %s, %s, %s, %s) " +
    "on conflict (ck_id) do update set ck_id = excluded.ck_id, cv_description = excluded.cv_description, cr_type = excluded.cr_type, cl_required = excluded.cl_required, ck_user = excluded.ck_user, ct_change = excluded.ct_change;\n";

export class Info extends IRowPatch {
    public toRow(): string {
        return format(
            formatInfoSqlPostgres,
            this.toStringOrNull("ck_id"),
            this.toStringOrNull("cv_description"),
            this.toStringOrNull("cr_type"),
            this.row.cl_required,
            this.toStringOrNull("ck_user"),
            this.toTimestamp("ct_change"),
        );
    }
}
