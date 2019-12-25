import { format } from "util";
import { IRowPatch } from "../IRowPatch";

const formatAccountInfoSqlPostgres =
    "INSERT INTO s_at.t_account_info (ck_id, ck_account, ck_d_info, cv_value, ck_user, ct_change)" +
    " VALUES(%s, %s, %s, %s, %s, %s) " +
    "on conflict on constraint cin_i_account_info_1 do update set ck_id = excluded.ck_id, ck_account = excluded.ck_account, ck_d_info = excluded.ck_d_info, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;\n";

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
