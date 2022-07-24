import { format } from "util";
import { IRowPatch } from "../IRowPatch";

const formatSqlPostgres =
"INSERT INTO s_ut.t_d_source_type\n" + 
"(ck_id, cv_name, ck_user, ct_change)\n" + 
"VALUES(%s, %s, %s, %s)\n" + 
"on conflict (ck_id) do NOTHING;\n";

export class DSource extends IRowPatch {
    public toRow(): string {
        return format(
            formatSqlPostgres,
            this.toStringOrNull("ck_id"),
            this.toStringOrNull("cv_name"),
            this.toStringOrNull("ck_user"),
            this.toTimestamp("ct_change"),
        );
    }
}
