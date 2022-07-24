import { format } from "util";
import { IRowPatch } from "../IRowPatch";

const formatSqlPostgres =
"INSERT INTO s_ut.t_report_asset\n" + 
"(ck_id, cv_name, ck_asset, ck_report, cct_parameter, ck_user, ct_change)\n" + 
"VALUES((%s)::uuid, %s, (%s)::uuid, (%s)::uuid, %s, %s, %s)\n" + 
"on conflict (ck_id) do update set ck_id = excluded.ck_id, cv_name = excluded.cv_name, ck_asset = excluded.ck_asset, ck_report = excluded.ck_report, cct_parameter = excluded.cct_parameter, ck_user = excluded.ck_user, ct_change = excluded.ct_change;\n";

export class ReportAsset extends IRowPatch {
    public toRow(): string {
        return format(
            formatSqlPostgres,
            this.toStringOrNull("ck_id"),
            this.toStringOrNull("cv_name"),
            this.toStringOrNull("ck_asset"),
            this.toStringOrNull("ck_report"),
            this.toStringOrNull("cct_parameter"),
            this.toStringOrNull("ck_user"),
            this.toTimestamp("ct_change"),
        );
    }
}
