import { format } from "util";
import { IRowPatch } from "../IRowPatch";

const formatProviderSqlPostgres =
    "INSERT INTO s_mt.t_provider (ck_id, cv_name, ck_user, ct_change)" +
    " VALUES(%s, %s, %s, %s) " +
    "on conflict (ck_id) do update set ck_id = excluded.ck_id, cv_name = excluded.cv_name, ck_user = excluded.ck_user, ct_change = excluded.ct_change;\n";

export class Provider extends IRowPatch {
    public toRow(): string {
        return format(
            formatProviderSqlPostgres,
            this.toStringOrNull("ck_id"),
            this.toStringOrNull("cv_name"),
            this.toStringOrNull("ck_user"),
            this.toTimestamp("ct_change"),
        );
    }
}
