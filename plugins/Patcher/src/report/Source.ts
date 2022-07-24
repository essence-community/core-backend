import { format } from "util";
import { IRowPatch } from "../IRowPatch";

const formatSqlPostgres =
"INSERT INTO s_ut.t_source\n" + 
"(ck_id, cct_parameter, cv_plugin, ck_d_source, ck_user, ct_change, cl_enable)\n" + 
"VALUES(%s, %s, %s, %s, %s, %s, %d)\n" + 
"on conflict (ck_id) do NOTHING;\n";

export class Source extends IRowPatch {
    public toRow(): string {
        return format(
            formatSqlPostgres,
            this.toStringOrNull("ck_id"),
            this.toStringOrNull("cct_parameter"),
            this.toStringOrNull("cv_plugin"),
            this.toStringOrNull("ck_d_source"),
            this.toStringOrNull("ck_user"),
            this.toTimestamp("ct_change"),
            this.row.cl_enable || 0,
        );
    }
}
