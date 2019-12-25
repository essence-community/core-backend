import { format } from "util";
import { IRowPatch } from "../IRowPatch";

const formatRoleActionSqlPostgres =
    "INSERT INTO s_at.t_role_action (ck_id, ck_action, ck_role, ck_user, ct_change)" +
    " VALUES(%s, %s, %s, %s, %s) " +
    "on conflict on constraint cin_u_role_action_1 do update set ck_id = excluded.ck_id, ck_action = excluded.ck_action, ck_role = excluded.ck_role, ck_user = excluded.ck_user, ct_change = excluded.ct_change;\n";

export class RoleAction extends IRowPatch {
    public toRow(): string {
        return format(
            formatRoleActionSqlPostgres,
            this.toStringOrNull("ck_id"),
            this.row.ck_action,
            this.toStringOrNull("ck_role"),
            this.toStringOrNull("ck_user"),
            this.toTimestamp("ct_change"),
        );
    }
}
