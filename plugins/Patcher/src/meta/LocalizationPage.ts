import { format } from "util";
import { IRowPatch } from "../IRowPatch";

const formatLocalizationSqlPostgres =
    "    select %s as ck_id, %s as ck_d_lang, %s as cr_namespace, %s as cv_value, %s as ck_user, %s as ct_change\n";

export class LocalizationPage extends IRowPatch {
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
