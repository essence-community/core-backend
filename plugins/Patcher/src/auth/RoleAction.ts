import { format } from "util";
import { IRowPatch } from "../IRowPatch";

const formatRoleActionSqlPostgres =
    "         select %s as ck_id, %s as ck_action, %s as ck_role, %s as ck_user, %s as ct_change\n";

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
