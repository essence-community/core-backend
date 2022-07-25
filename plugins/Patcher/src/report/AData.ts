import { format } from "util";
import { IRowPatch } from "../IRowPatch";

const formatSqlPostgres =
"INSERT INTO s_ut.t_authorization\n" + 
"(ck_id, cv_name, cv_plugin, cct_parameter, ck_user, ct_change)\n" + 
"VALUES(%s, %s, %s, (%s)::jsonb, %s, %s)\n" + 
"on conflict (ck_id) do NOTHING;\n";

export class AData extends IRowPatch {
    public toRow(): string {
        return format(
            formatSqlPostgres,
            this.toStringOrNull("ck_id"),
            this.toStringOrNull("cv_name"),
            this.toStringOrNull("cv_plugin"),
            this.toStringOrNull("cct_parameter"),
            this.toStringOrNull("ck_user"),
            this.toTimestamp("ct_change"),
        );
    }
}
