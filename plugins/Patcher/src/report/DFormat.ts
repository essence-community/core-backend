import { format } from "util";
import { IRowPatch } from "../IRowPatch";

const formatSqlPostgres =
"INSERT INTO s_ut.t_d_format\n" + 
"(ck_id, cv_name, cv_extension, cv_name_lib, cv_recipe, cct_parameter, cv_content_type, ck_user, ct_change)\n" + 
"VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s)\n" + 
"on conflict (ck_id) do NOTHING;\n";

export class DFormat extends IRowPatch {
    public toRow(): string {
        return format(
            formatSqlPostgres,
            this.toStringOrNull("ck_id"),
            this.toStringOrNull("cv_name"),
            this.toStringOrNull("cv_extension"),
            this.toStringOrNull("cv_name_lib"),
            this.toStringOrNull("cv_recipe"),
            this.toStringOrNull("cct_parameter"),
            this.toStringOrNull("cv_content_type"),
            this.toStringOrNull("ck_user"),
            this.toTimestamp("ct_change"),
        );
    }
}
