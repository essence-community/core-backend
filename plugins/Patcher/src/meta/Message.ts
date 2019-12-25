import { format } from "util";
import { IRowPatch } from "../IRowPatch";

const formatMMessageSqlPostgres =
    "INSERT INTO s_mt.t_message (ck_id, cr_type, cv_text, ck_user, ct_change)" +
    " VALUES(%s, %s, %s, %s, %s) " +
    "on conflict (ck_id) do update set ck_id = excluded.ck_id, cr_type = excluded.cr_type, cv_text = excluded.cv_text, ck_user = excluded.ck_user, ct_change = excluded.ct_change;\n";

export class Message extends IRowPatch {
    public toRow(): string {
        return format(
            formatMMessageSqlPostgres,
            this.toStringOrNull("ck_id"),
            this.toStringOrNull("cr_type"),
            this.toStringOrNull("cv_text"),
            this.toStringOrNull("ck_user"),
            this.toTimestamp("ct_change"),
        );
    }
}
