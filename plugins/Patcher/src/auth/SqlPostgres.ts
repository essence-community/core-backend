export const sqlAccount =
    "select\n" +
    "    ck_id,\n" +
    "    cv_surname,\n" +
    "    cv_name,\n" +
    "    cv_login,\n" +
    "    cv_hash_password,\n" +
    "    cv_timezone,\n" +
    "    cv_salt,\n" +
    "    cv_email,\n" +
    "    cv_patronymic,\n" +
    "    ck_user,\n" +
    "    ct_change\n" +
    "from\n" +
    "    s_at.t_account\n" +
    "where\n" +
    "    ck_id in (\n" +
    "        select\n" +
    "            value::uuid\n" +
    "        from\n" +
    "            json_array_elements_text(:cct_account::json)\n" +
    "    )\n" +
    "order by\n" +
    "    cv_login asc\n";
export const sqlAccountInfo =
    "select\n" +
    "    ck_id,\n" +
    "    ck_account,\n" +
    "    ck_d_info,\n" +
    "    cv_value,\n" +
    "    ck_user,\n" +
    "    ct_change\n" +
    "from\n" +
    "    s_at.t_account_info\n" +
    "where\n" +
    "    ck_d_info in (\n" +
    "        select\n" +
    "            value\n" +
    "        from\n" +
    "            json_array_elements_text(:cct_info::json)\n" +
    "    )\n" +
    "    and ck_account in (\n" +
    "        select\n" +
    "            value::uuid\n" +
    "        from\n" +
    "            json_array_elements_text(:cct_account::json)\n" +
    "    )\n" +
    "order by\n" +
    "    ck_d_info asc\n";
export const sqlAccountRole =
    "select\n" +
    "    ck_id,\n" +
    "    ck_role,\n" +
    "    ck_account,\n" +
    "    ck_user,\n" +
    "    ct_change\n" +
    "from\n" +
    "    s_at.t_account_role\n" +
    "where\n" +
    "    ck_account in (\n" +
    "        select\n" +
    "            value::uuid\n" +
    "        from\n" +
    "            json_array_elements_text(:cct_account::json)\n" +
    "    )\n" +
    "    and ck_role in (\n" +
    "        select\n" +
    "            value::uuid\n" +
    "        from\n" +
    "            json_array_elements_text(:cct_role::json)\n" +
    "    )\n" +
    "order by\n" +
    "    ck_id asc\n";

export const sqlAction =
    "select\n" +
    "    ck_id,\n" +
    "    cv_name,\n" +
    "    cv_description,\n" +
    "    ck_user,\n" +
    "    ct_change\n" +
    "from\n" +
    "    s_at.t_action\n" +
    "where\n" +
    "    ck_id in (\n" +
    "        select\n" +
    "            value::bigint\n" +
    "        from\n" +
    "            json_array_elements_text(:cct_action::json)\n" +
    "    )\n" +
    "order by\n" +
    "    ck_id asc\n";
export const sqlInfo =
    "select\n" +
    "    ck_id,\n" +
    "    cv_description,\n" +
    "    cr_type,\n" +
    "    cl_required,\n" +
    "    ck_user,\n" +
    "    ct_change\n" +
    "from\n" +
    "    s_at.t_d_info\n" +
    "where\n" +
    "    ck_id in (\n" +
    "        select\n" +
    "            value\n" +
    "        from\n" +
    "            json_array_elements_text(:cct_info::json)\n" +
    "    )\n" +
    "order by\n" +
    "    ck_id asc\n";
export const sqlRole =
    "select\n" +
    "    ck_id,\n" +
    "    cv_name,\n" +
    "    cv_description,\n" +
    "    ck_user,\n" +
    "    ct_change\n" +
    "from\n" +
    "    s_at.t_role\n" +
    "where\n" +
    "    ck_id in (\n" +
    "        select\n" +
    "            value::uuid\n" +
    "        from\n" +
    "            json_array_elements_text(:cct_role::json)\n" +
    "    )\n" +
    "order by\n" +
    "    cv_name asc\n";
export const sqlRoleAction =
    "select\n" +
    "    ck_id,\n" +
    "    ck_action,\n" +
    "    ck_role,\n" +
    "    ck_user,\n" +
    "    ct_change\n" +
    "from\n" +
    "    s_at.t_role_action\n" +
    "where\n" +
    "    ck_role in (\n" +
    "        select\n" +
    "            value::uuid\n" +
    "        from\n" +
    "            json_array_elements_text(:cct_role::json)\n" +
    "    )\n" +
    "    and ck_action in (\n" +
    "        select\n" +
    "            value::bigint\n" +
    "        from\n" +
    "            json_array_elements_text(:cct_action::json)\n" +
    "    )\n" +
    "order by\n" +
    "    ck_id asc\n";
