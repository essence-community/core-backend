import { format } from "util";
import { IRowPatch } from "../IRowPatch";

const formatQuerySqlPostgres =
    "INSERT INTO s_mt.t_query (ck_id, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description, cc_query)" +
    "\n VALUES(%s, %s, %s, %s, %s, %s, %s, %s,\n %s\n) " +
    "on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;\n";

export class Query extends IRowPatch {
    public toRow(): string {
        return format(
            formatQuerySqlPostgres,
            this.toStringOrNull("ck_id"),
            this.toStringOrNull("ck_provider"),
            this.toStringOrNull("ck_user"),
            this.toTimestamp("ct_change"),
            this.toStringOrNull("cr_type"),
            this.toStringOrNull("cr_access"),
            this.row.cn_action,
            this.toStringOrNull(
                "cv_description",
                "'Необходимо актуализировать'",
            ),
            this.toStringOrNull("cc_query"),
        );
    }
}
