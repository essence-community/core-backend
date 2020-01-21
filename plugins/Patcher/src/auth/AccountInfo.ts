import { format } from "util";
import { IRowPatch } from "../IRowPatch";

const formatAccountInfoSqlPostgres =
    "        select %s as ck_id, (%s)::uuid as ck_account, %s as ck_d_info, %s as cv_value, %s as ck_user, %s as ct_change\n";

export class AccountInfo extends IRowPatch {
    public toRow(): string {
        return format(
            formatAccountInfoSqlPostgres,
            this.toStringOrNull("ck_id"),
            this.toStringOrNull("ck_account"),
            this.toStringOrNull("ck_d_info"),
            this.toStringOrNull("cv_value"),
            this.toStringOrNull("ck_user"),
            this.toTimestamp("ct_change"),
        );
    }
}
