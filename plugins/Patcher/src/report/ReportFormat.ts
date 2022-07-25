import { format } from "util";
import { IRowPatch } from "../IRowPatch";

const formatSqlPostgres =
"INSERT INTO s_ut.t_report_format\n" + 
"(ck_id, ck_report, ck_d_format, cct_parameter, ck_asset, ck_user, ct_change)\n" + 
"VALUES((%s)::uuid, (%s)::uuid, %s, (%s)::jsonb, (%s)::uuid, %s, %s)\n" + 
"on conflict (ck_id) do update set ck_id = excluded.ck_id, ck_report = excluded.ck_report, ck_d_format = excluded.ck_d_format, cct_parameter = excluded.cct_parameter, ck_asset = excluded.ck_asset, ck_user = excluded.ck_user, ct_change = excluded.ct_change;\n";

export class ReportFormat extends IRowPatch {
    public toRow(): string {
        return format(
            formatSqlPostgres,
            this.toStringOrNull("ck_id"),
            this.toStringOrNull("ck_report"),
            this.toStringOrNull("ck_d_format"),
            this.toStringOrNull("cct_parameter"),
            this.toStringOrNull("ck_asset"),
            this.toStringOrNull("ck_user"),
            this.toTimestamp("ct_change"),
        );
    }
}
