import { format } from "util";
import { IRowPatch } from "../IRowPatch";

const formatSqlPostgres =
"INSERT INTO s_ut.t_asset\n" + 
"(ck_id, cv_name, cv_template, ck_engine, cct_parameter, cv_helpers, ck_user, ct_change, cl_archive, cb_asset)\n" + 
"VALUES((%s)::uuid, %s, %s, %s, (%s)::jsonb, %s, %s, %s, %d, %s)\n" + 
"on conflict (ck_id) do update set ck_id = excluded.ck_id, cv_name = excluded.cv_name, cv_template = excluded.cv_template, ck_engine = excluded.ck_engine, cb_asset = excluded.cb_asset, cct_parameter = excluded.cct_parameter, cv_helpers = excluded.cv_helpers, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_archive = excluded.cl_archive;\n";
export class Asset extends IRowPatch {
    public toRow(): string {
        return format(
            formatSqlPostgres,
            this.toStringOrNull("ck_id"),
            this.toStringOrNull("cv_name"),
            this.toStringOrNull("cv_template"),
            this.toStringOrNull("ck_engine"),
            this.toStringOrNull("cct_parameter"),
            this.toStringOrNull("cv_helpers"),
            this.toStringOrNull("ck_user"),
            this.toTimestamp("ct_change"),
            this.row.cl_archive || 0,
            this.toBinary("cb_asset")
        );
    }
}
