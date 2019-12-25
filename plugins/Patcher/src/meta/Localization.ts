import { format } from "util";
import { IRowPatch } from "../IRowPatch";

const formatLocalizationSqlPostgres =
    "INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)" +
    " VALUES(%s, %s, %s, %s, %s, %s) " +
    "on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;\n";

export class Localization extends IRowPatch {
    public toRow(): string {
        return format(
            formatLocalizationSqlPostgres,
            this.toStringOrNull("ck_id"),
            this.toStringOrNull("ck_d_lang"),
            this.toStringOrNull("cr_namespace"),
            this.toStringOrNull("cv_value"),
            this.toStringOrNull("ck_user"),
            this.toTimestamp("ct_change"),
        );
    }
}
