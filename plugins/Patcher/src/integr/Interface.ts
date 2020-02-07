import { format } from "util";
import { IRowPatch } from "../IRowPatch";

const formatInterfaceSqlPostgres =
    "INSERT INTO s_it.t_interface (ck_id, ck_d_interface, ck_d_provider, cc_request, cc_response, cn_action, cv_url_request, cv_url_response, cv_description, ck_parent) " +
    " VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s) " +
    "on conflict (ck_id) do update set ck_id = excluded.ck_id, ck_d_interface = excluded.ck_d_interface, ck_d_provider = excluded.ck_d_provider, cc_request = excluded.cc_request, cc_response = excluded.cc_response, cn_action = excluded.cn_action, cv_url_request = excluded.cv_url_request, cv_url_response = excluded.cv_url_response, cv_description = excluded.cv_description, ck_parent = excluded.ck_parent;\n";

export class Interface extends IRowPatch {
    public toRow(): string {
        return format(
            formatInterfaceSqlPostgres,
            this.toStringOrNull("ck_id"),
            this.toStringOrNull("ck_d_interface"),
            this.toStringOrNull("ck_d_provider"),
            this.toStringOrNull("cc_request"),
            this.toStringOrNull("cc_response"),
            this.row.cn_action,
            this.toStringOrNull("cv_url_request"),
            this.toStringOrNull("cv_url_response"),
            this.toStringOrNull("cv_description"),
            this.toStringOrNull("ck_parent"),
        );
    }
}
