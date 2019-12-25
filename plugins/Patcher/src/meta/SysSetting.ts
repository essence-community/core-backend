import { format } from "util";
import { IRowPatch } from "../IRowPatch";

const formatMSysSettingSqlPostgres =
    "INSERT INTO s_mt.t_sys_setting (ck_id, cv_value, ck_user, ct_change, cv_description)" +
    " VALUES(%s, %s, %s, %s, %s) " +
    "on conflict (ck_id) do update set ck_id = excluded.ck_id, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cv_description = excluded.cv_description;\n";

export class SysSetting extends IRowPatch {
    public toRow(): string {
        return format(
            formatMSysSettingSqlPostgres,
            this.toStringOrNull("ck_id"),
            this.toStringOrNull("cv_value"),
            this.toStringOrNull("ck_user"),
            this.toTimestamp("ct_change"),
            this.toStringOrNull("cv_description"),
        );
    }
}
