import { format } from "util";
import { IRowPatch } from "../IRowPatch";

const formatAccountRoleSqlPostgres =
    "        select %s as ck_id, (%s)::uuid as ck_role, (%s)::uuid as ck_account, %s as ck_user, %s as ct_change\n";

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
