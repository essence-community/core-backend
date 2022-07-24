import { format } from "util";
import { IRowPatch } from "../IRowPatch";

const formatSqlPostgres =
"INSERT INTO s_ut.t_report_query\n" + 
"(ck_id, cv_name, cv_body, ck_source, ck_report, cct_parameter, cct_source_parameter, ck_user, ct_change, ck_parent)\n" + 
"VALUES((%s)::uuid, %s, %s, %s, (%s)::uuid, %s, %s, %s, %s, (%s)::uuid)\n" + 
"on conflict (ck_id) do update set ck_id = excluded.ck_id, cv_name = excluded.cv_name, cv_body = excluded.cv_body, ck_source = excluded.ck_source, ck_report = excluded.ck_report, cct_parameter = excluded.cct_parameter, cct_source_parameter = excluded.cct_source_parameter, ck_user = excluded.ck_user, ct_change = excluded.ct_change, ck_parent = excluded.ck_parent;\n";

export class ReportQuery extends IRowPatch {
    public toRow(): string {
        return format(
            formatSqlPostgres,
            this.toStringOrNull("ck_id"),
            this.toStringOrNull("cv_name"),
            this.toStringOrNull("cv_body"),
            this.toStringOrNull("ck_source"),
            this.toStringOrNull("ck_report"),
            this.toStringOrNull("cct_parameter"),
            this.toStringOrNull("cct_source_parameter"),
            this.toStringOrNull("ck_user"),
            this.toTimestamp("ct_change"),
            this.toStringOrNull("ck_parent"),
        );
    }
}
