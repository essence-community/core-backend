import { format } from "util";
import { IRowPatch } from "../IRowPatch";

const formatRoleSqlPostgres =
    "INSERT INTO s_at.t_role (ck_id, cv_name, cv_description, ck_user, ct_change)" +
    " VALUES(%s, %s, %s, %s, %s) " +
    "on conflict (ck_id) do update set ck_id = excluded.ck_id, cv_name = excluded.cv_name, cv_description = excluded.cv_description, ck_user = excluded.ck_user, ct_change = excluded.ct_change;\n";

export class Role extends IRowPatch {
    public toRow(): string {
        return format(
            formatRoleSqlPostgres,
            this.toStringOrNull("ck_id"),
            this.toStringOrNull("cv_name"),
            this.toStringOrNull("cv_description"),
            this.toStringOrNull("ck_user"),
            this.toTimestamp("ct_change"),
        );
    }
}
