import { format } from "util";
import { IRowPatch } from "../IRowPatch";

const formatAccountRoleSqlPostgres =
    "INSERT INTO s_at.t_account_role (ck_id, ck_role, ck_account, ck_user, ct_change) " +
    " VALUES(%s, %s, %s, %s, %s) " +
    "on conflict on constraint cin_u_account_role_1 do update set ck_id = excluded.ck_id, ck_account = excluded.ck_account, ck_role = excluded.ck_role, ck_user = excluded.ck_user, ct_change = excluded.ct_change;\n";

export class AccountRole extends IRowPatch {
    public toRow(): string {
        return format(
            formatAccountRoleSqlPostgres,
            this.toStringOrNull("ck_id"),
            this.toStringOrNull("ck_role"),
            this.toStringOrNull("ck_account"),
            this.toStringOrNull("ck_user"),
            this.toTimestamp("ct_change"),
        );
    }
}
