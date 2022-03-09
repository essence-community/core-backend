import { format } from "util";
import { IRowPatch } from "../IRowPatch";

const formatAccountSqlPostgres =
    "INSERT INTO s_at.t_account (ck_id, cv_surname, cv_name, cv_login, cv_hash_password, cv_timezone, cv_salt, cv_email, cv_patronymic, ck_user, ct_change) " +
    " VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s) " +
    "on conflict (ck_id) do update set ck_id = excluded.ck_id, cv_name = excluded.cv_name, cv_surname = excluded.cv_surname, cv_login = excluded.cv_login, cv_hash_password = excluded.cv_hash_password, cv_timezone = excluded.cv_timezone, cv_salt = excluded.cv_salt, cv_email = excluded.cv_email, cv_patronymic = excluded.cv_patronymic, ck_user = excluded.ck_user, ct_change = excluded.ct_change;\n";

export class Account extends IRowPatch {
    public toRow(): string {
        return format(
            formatAccountSqlPostgres,
            this.toStringOrNull("ck_id"),
            this.toStringOrNull("cv_surname"),
            this.toStringOrNull("cv_name"),
            this.toStringOrNull("cv_login"),
            this.toStringOrNull("cv_hash_password"),
            this.toStringOrNull("cv_timezone"),
            this.toStringOrNull("cv_salt"),
            this.toStringOrNull("cv_email"),
            this.toStringOrNull("cv_patronymic"),
            this.toStringOrNull("ck_user"),
            this.toTimestamp("ct_change"),
        );
    }
}
