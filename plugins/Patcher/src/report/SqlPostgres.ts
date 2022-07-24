export const sqlDFormat =
"select\n" + 
"    ck_id,\n" + 
"    cv_name,\n" + 
"    cv_extension,\n" + 
"    cv_name_lib,\n" + 
"    cv_recipe,\n" + 
"    cct_parameter,\n" + 
"    cv_content_type,\n" + 
"    ck_user,\n" + 
"    ct_change\n" + 
"from\n" + 
"    s_ut.t_d_format\n" + 
"where ck_id in (\n" + 
"    select\n" + 
"        ck_d_format\n" + 
"    from\n" + 
"        s_ut.t_report_format\n" + 
"    where\n" + 
"        ck_report in (\n" + 
"            select\n" + 
"                value::uuid\n" + 
"            from\n" + 
"                json_array_elements_text(:cct_report::json)\n" + 
"        )\n" + 
")\n";
export const sqlDSource =
"select\n" + 
"    ck_id,\n" + 
"    cv_name,\n" + 
"    ck_user,\n" + 
"    ct_change\n" + 
"from\n" + 
"    s_ut.t_d_source_type\n" + 
"where\n" + 
"    ck_id in (\n" + 
"        select\n" + 
"            ts.ck_d_source\n" + 
"        from\n" + 
"            s_ut.t_source ts\n" + 
"        join s_ut.t_report_query trq\n" + 
"            on\n" + 
"            trq.ck_source = ts.ck_id\n" + 
"        where\n" + 
"            trq.ck_report in (\n" + 
"                select\n" + 
"                    value::uuid\n" + 
"                from\n" + 
"                    json_array_elements_text(:cct_report::json)\n" + 
"            )\n" + 
"    )\n";
export const sqlSource =
"select\n" + 
"    ck_id,\n" + 
"    cct_parameter,\n" + 
"    cv_plugin,\n" + 
"    ck_d_source,\n" + 
"    ck_user,\n" + 
"    ct_change,\n" + 
"    cl_enable\n" + 
"from\n" + 
"    s_ut.t_source\n" + 
"where\n" + 
"    ck_id in (\n" + 
"        select\n" + 
"            trq.ck_source\n" + 
"        from\n" + 
"            s_ut.t_report_query trq\n" + 
"        where\n" + 
"            trq.ck_report in (\n" + 
"                select\n" + 
"                    value::uuid\n" + 
"                from\n" + 
"                    json_array_elements_text(:cct_report::json)\n" + 
"            )\n" + 
"    )\n";
export const sqlAsset =
"select\n" + 
"    distinct ck_id,\n" + 
"    cv_name,\n" + 
"    cv_template,\n" + 
"    ck_engine,\n" + 
"    cb_asset,\n" + 
"    cct_parameter,\n" + 
"    cv_helpers,\n" + 
"    ck_user,\n" + 
"    ct_change,\n" + 
"    cl_archive\n" + 
"from\n" + 
"    s_ut.t_asset\n" + 
"where\n" + 
"    ck_id in (\n" + 
"        select\n" + 
"            ck_asset\n" + 
"        from\n" + 
"            s_ut.t_report_format\n" + 
"        where\n" + 
"            ck_report in (\n" + 
"                select\n" + 
"                    value::uuid\n" + 
"                from\n" + 
"                    json_array_elements_text(:cct_report::json)\n" + 
"            )\n" + 
"    )\n" + 
"    or ck_id in (\n" + 
"        select\n" + 
"            ck_asset\n" + 
"        from\n" + 
"            s_ut.t_report_asset\n" + 
"        where\n" + 
"            ck_report in (\n" + 
"                select\n" + 
"                    value::uuid\n" + 
"                from\n" + 
"                    json_array_elements_text(:cct_report::json)\n" + 
"            )\n" + 
"                or\n" + 
"    )\n";
export const sqlAData =
"select\n" + 
"    ck_id,\n" + 
"    cv_name,\n" + 
"    cv_plugin,\n" + 
"    cct_parameter,\n" + 
"    ck_user,\n" + 
"    ct_change\n" + 
"from\n" + 
"    s_ut.t_authorization\n" + 
"where\n" + 
"    ck_id in (\n" + 
"        select\n" + 
"            ck_authorization\n" + 
"        from\n" + 
"            s_ut.t_report\n" + 
"        where\n" + 
"            ck_id in (\n" + 
"                select\n" + 
"                    value::uuid\n" + 
"                from\n" + 
"                    json_array_elements_text(:cct_report::json)\n" + 
"            )\n" + 
"    )\n";
export const sqlReport =
"select\n" + 
"    ck_id,\n" + 
"    cv_name,\n" + 
"    ck_d_default_queue,\n" + 
"    ck_authorization,\n" + 
"    cn_day_expire_storage,\n" + 
"    cct_parameter,\n" + 
"    cn_priority,\n" + 
"    ck_user,\n" + 
"    ct_change\n" + 
"from\n" + 
"    s_ut.t_report\n" + 
"where\n" + 
"    ck_id in (\n" + 
"        select\n" + 
"                    value::uuid\n" + 
"        from\n" + 
"                    json_array_elements_text(:cct_report::json)\n" + 
"    )\n";
export const sqlReportFormat =
"select\n" + 
"    ck_id,\n" + 
"    ck_report,\n" + 
"    ck_d_format,\n" + 
"    cct_parameter,\n" + 
"    ck_asset,\n" + 
"    ck_user,\n" + 
"    ct_change\n" + 
"from\n" + 
"    s_ut.t_report_format\n" + 
"where\n" + 
"    ck_report in (\n" + 
"        select\n" + 
"                    value::uuid\n" + 
"        from\n" + 
"                    json_array_elements_text(:cct_report::json)\n" + 
"    )\n";
export const sqlReportAsset =
"select\n" + 
"    ck_id,\n" + 
"    cv_name,\n" + 
"    ck_asset,\n" + 
"    ck_report,\n" + 
"    cct_parameter,\n" + 
"    ck_user,\n" + 
"    ct_change\n" + 
"from\n" + 
"    s_ut.t_report_asset\n" + 
"where\n" + 
"    ck_report in (\n" + 
"        select\n" + 
"                    value::uuid\n" + 
"        from\n" + 
"                    json_array_elements_text(:cct_report::json)\n" + 
"    )\n";
export const sqlReportQuery =
"select\n" + 
"    ck_id,\n" + 
"    cv_name,\n" + 
"    cv_body,\n" + 
"    ck_source,\n" + 
"    ck_report,\n" + 
"    cct_parameter,\n" + 
"    cct_source_parameter,\n" + 
"    ck_user,\n" + 
"    ct_change,\n" + 
"    ck_parent\n" + 
"from\n" + 
"    s_ut.t_report_query\n" + 
"where\n" + 
"    ck_report in (\n" + 
"        select\n" + 
"                    value::uuid\n" + 
"        from\n" + 
"                    json_array_elements_text(:cct_report::json)\n" + 
"    )\n";
