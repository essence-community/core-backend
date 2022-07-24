import { format } from "util";
import { IRowPatch } from "../IRowPatch";

const formatSqlPostgres =
"INSERT INTO s_ut.t_report\n" + 
"(ck_id, cv_name, ck_d_default_queue, ck_authorization, cn_day_expire_storage, cct_parameter, cn_priority, ck_user, ct_change)\n" + 
"VALUES((%s)::uuid, %s, %s, (%s)::uuid, %d, %s, %d, %s, %s);\n" + 
"on conflict (ck_id) do update set ck_id = excluded.ck_id, cv_name = excluded.cv_name, ck_d_default_queue = excluded.ck_d_default_queue, ck_authorization = excluded.ck_authorization, cn_day_expire_storage = excluded.cn_day_expire_storage, cct_parameter = excluded.cct_parameter, cn_priority = excluded.cn_priority, ck_user = excluded.ck_user, ct_change = excluded.ct_change;\n";

export class Report extends IRowPatch {
    public toRow(): string {
        return format(
            formatSqlPostgres,
            this.toStringOrNull("ck_id"),
            this.toStringOrNull("cv_name"),
            this.toStringOrNull("ck_d_default_queue"),
            this.toStringOrNull("ck_authorization"),
            this.row.cn_day_expire_storage || 365,
            this.toStringOrNull("cct_parameter"),
            this.row.cn_priority || 100,
            this.toStringOrNull("ck_user"),
            this.toTimestamp("ct_change"),
        );
    }
}
