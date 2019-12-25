import { format } from "util";
import { IRowPatch } from "../IRowPatch";

const formatProviderSqlPostgres =
    "INSERT INTO s_it.t_d_provider (ck_id, cv_description)" +
    " VALUES(%s, %s) " +
    "on conflict (ck_id) do update set ck_id = excluded.ck_id, cv_description = excluded.cv_description;\n";

export class Provider extends IRowPatch {
    public toRow(): string {
        return format(
            formatProviderSqlPostgres,
            this.toStringOrNull("ck_id"),
            this.toStringOrNull("cv_description"),
        );
    }
}
