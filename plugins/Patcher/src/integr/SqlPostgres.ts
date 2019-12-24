export const sqlProvider =
    "select\n" +
    "    ck_id,\n" +
    "    cv_description\n" +
    "from\n" +
    "    s_it.t_d_provider\n" +
    "where\n" +
    "    ck_id in (\n" +
    "        select\n" +
    "            ck_d_provider\n" +
    "        from\n" +
    "            s_it.t_interface\n" +
    "        where\n" +
    "            ck_id in (\n" +
    "                select\n" +
    "                    value\n" +
    "                from\n" +
    "                    json_array_elements_text(:cct_interface::json)\n" +
    "            )\n" +
    "    )\n" +
    "order by\n" +
    "    ck_id asc\n";
export const sqlInterface =
    "select\n" +
    "    ck_id,\n" +
    "    ck_d_interface,\n" +
    "    ck_d_provider,\n" +
    "    cc_request,\n" +
    "    cc_response,\n" +
    "    cn_action,\n" +
    "    cv_url_request,\n" +
    "    cv_url_response,\n" +
    "    cv_description,\n" +
    "    ck_parent\n" +
    "from\n" +
    "    s_it.t_interface\n" +
    "where\n" +
    "    ck_id in (\n" +
    "        select\n" +
    "            value\n" +
    "        from\n" +
    "            json_array_elements_text(:cct_interface::json)\n" +
    "    )\n" +
    "order by\n" +
    "    ck_parent asc,\n" +
    "    ck_id asc\n";
