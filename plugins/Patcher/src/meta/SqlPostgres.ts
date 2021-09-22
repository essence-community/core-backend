export const sqlProvider =
    "select\n" +
    "    ck_id,\n" +
    "    cv_name,\n" +
    "    ck_user,\n" +
    "    ct_change\n" +
    "from\n" +
    "    s_mt.t_provider\n" +
    "where\n" +
    "    ck_id in (\n" +
    "            select\n" +
    "                ck_provider\n" +
    "            from\n" +
    "                s_mt.t_query\n" +
    "            where\n" +
    "                ck_id in (\n" +
    "                    select\n" +
    "                        value\n" +
    "                    from\n" +
    "                        json_array_elements_text(:cct_query::json)\n" +
    "                )\n" +
    "        )\n" +
    "order by\n" +
    "    ck_id asc\n";
export const sqlQuery =
    "select\n" +
    "    ck_id,\n" +
    "    cc_query,\n" +
    "    ck_provider,\n" +
    "    ck_user,\n" +
    "    ct_change,\n" +
    "    cr_type,\n" +
    "    cr_access,\n" +
    "    cn_action,\n" +
    "    cv_description\n" +
    "from\n" +
    "    s_mt.t_query\n" +
    "where\n" +
    "     ck_id in (\n" +
    "            select\n" +
    "                value\n" +
    "            from\n" +
    "                json_array_elements_text(:cct_query::json)\n" +
    "        )\n" +
    "order by\n" +
    "    ck_id asc\n";
export const sqlObject =
    "with recursive obj as (\n" +
    "select\n" +
    "    o.ck_id,\n" +
    "    o.ck_class,\n" +
    "    o.ck_parent,\n" +
    "    o.cv_name,\n" +
    "    o.cn_order,\n" +
    "    o.ck_query,\n" +
    "    o.cv_description,\n" +
    "    o.cv_displayed,\n" +
    "    o.cv_modify,\n" +
    "    o.ck_provider,\n" +
    "    o.ck_user,\n" +
    "    o.ct_change,\n" +
    "    po.ck_id as ck_page_object,\n" +
    "    po.ck_page,\n" +
    "    1 as lvl\n" +
    "from s_mt.t_page_object po\n" +
    "join s_mt.t_object o\n" +
    "   on po.ck_object = o.ck_id\n" +
    "where\n" +
    "    po.ck_page in (select ck_id from s_mt.t_page where ck_id in (select value from json_array_elements_text(:cct_page::json)) and cr_type = 2) and po.ck_parent is null\n" +
    "union all\n" +
    "select\n" +
    "    o.ck_id,\n" +
    "    o.ck_class,\n" +
    "    o.ck_parent,\n" +
    "    o.cv_name,\n" +
    "    o.cn_order,\n" +
    "    o.ck_query,\n" +
    "    o.cv_description,\n" +
    "    o.cv_displayed,\n" +
    "    o.cv_modify,\n" +
    "    o.ck_provider,\n" +
    "    o.ck_user,\n" +
    "    o.ct_change,\n" +
    "    po.ck_id as ck_page_object,\n" +
    "    po.ck_page,\n" +
    "    c.lvl+1 as lvl\n" +
    "from obj c\n" +
    "join s_mt.t_page_object po \n" +
    "   on po.ck_parent = c.ck_page_object\n" +
    "join s_mt.t_object o\n" +
    "  on o.ck_id = po.ck_object )\n" +
    "select\n" +
    "    ck_id,\n" +
    "    ck_class,\n" +
    "    ck_parent,\n" +
    "    cv_name,\n" +
    "    cn_order,\n" +
    "    ck_query,\n" +
    "    cv_description,\n" +
    "    cv_displayed,\n" +
    "    cv_modify,\n" +
    "    ck_provider,\n" +
    "    ck_user,\n" +
    "    ct_change,\n" +
    "    ck_page\n" +
    "from\n" +
    "    obj\n" +
    "order by lvl asc, cn_order asc\n";
export const sqlObjectAttr =
    "with recursive obj as (\n" +
    "select\n" +
    "    o.ck_id,\n" +
    "    o.ck_class,\n" +
    "    o.ck_parent,\n" +
    "    o.cv_name,\n" +
    "    o.cn_order,\n" +
    "    o.ck_query,\n" +
    "    o.cv_description,\n" +
    "    o.cv_displayed,\n" +
    "    o.cv_modify,\n" +
    "    o.ck_provider,\n" +
    "    o.ck_user,\n" +
    "    o.ct_change,\n" +
    "    po.ck_id as ck_page_object,\n" +
    "    po.ck_page,\n" +
    "    1 as lvl\n" +
    "from s_mt.t_page_object po\n" +
    "join s_mt.t_object o\n" +
    "   on po.ck_object = o.ck_id\n" +
    "where\n" +
    "    po.ck_page in (select ck_id from s_mt.t_page where ck_id in (select value from json_array_elements_text(:cct_page::json)) and cr_type = 2) and po.ck_parent is null\n" +
    "union all\n" +
    "select\n" +
    "    o.ck_id,\n" +
    "    o.ck_class,\n" +
    "    o.ck_parent,\n" +
    "    o.cv_name,\n" +
    "    o.cn_order,\n" +
    "    o.ck_query,\n" +
    "    o.cv_description,\n" +
    "    o.cv_displayed,\n" +
    "    o.cv_modify,\n" +
    "    o.ck_provider,\n" +
    "    o.ck_user,\n" +
    "    o.ct_change,\n" +
    "    po.ck_id as ck_page_object,\n" +
    "    po.ck_page,\n" +
    "    c.lvl+1 as lvl\n" +
    "from obj c\n" +
    "join s_mt.t_page_object po \n" +
    "   on po.ck_parent = c.ck_page_object\n" +
    "join s_mt.t_object o\n" +
    "  on o.ck_id = po.ck_object )\n" +
    "select\n" +
    "    attr.ck_id,\n" +
    "    attr.ck_object,\n" +
    "    attr.ck_class_attr,\n" +
    "    attr.cv_value,\n" +
    "    attr.ck_user,\n" +
    "    attr.ct_change,\n" +
    "    ca.ck_attr,\n" +
    "    ob.ck_page\n" +
    "from\n" +
    "    obj ob \n" +
    "join s_mt.t_object_attr attr\n" +
    "on ob.ck_id = attr.ck_object\n" +
    "join s_mt.t_class_attr ca\n" +
    "on ca.ck_id = attr.ck_class_attr\n" +
    "order by ob.lvl asc, ob.cn_order asc, attr.ck_class_attr asc\n";
export const sqlPage =
    "with recursive page as (\n" +
    "select\n" +
    "    ck_id,\n" +
    "    ck_parent,\n" +
    "    cr_type,\n" +
    "    cv_name,\n" +
    "    cn_order,\n" +
    "    cl_static,\n" +
    "    cv_url,\n" +
    "    ck_icon,\n" +
    "    ck_user,\n" +
    "    ct_change,\n" +
    "    cl_menu,\n" +
    "    1 as lvl\n" +
    "from\n" +
    "    s_mt.t_page\n" +
    "where ck_parent is null and\n" +
    "    ck_id in (select value from json_array_elements_text(:cct_page::json))\n" +
    "union all\n" +
    "select\n" +
    "    p.ck_id,\n" +
    "    p.ck_parent,\n" +
    "    p.cr_type,\n" +
    "    p.cv_name,\n" +
    "    p.cn_order,\n" +
    "    p.cl_static,\n" +
    "    p.cv_url,\n" +
    "    p.ck_icon,\n" +
    "    p.ck_user,\n" +
    "    p.ct_change,\n" +
    "    p.cl_menu,\n" +
    "    rp.lvl+1 as lvl\n" +
    "from\n" +
    "    s_mt.t_page p\n" +
    "join page rp on\n" +
    "    p.ck_parent = rp.ck_id \n" +
    "where p.ck_id in (select value from json_array_elements_text(:cct_page::json))\n" +
    ")\n" +
    "select\n" +
    "    ck_id,\n" +
    "    ck_parent,\n" +
    "    cr_type,\n" +
    "    cv_name,\n" +
    "    cn_order,\n" +
    "    cl_static,\n" +
    "    cv_url,\n" +
    "    ck_icon,\n" +
    "    ck_user,\n" +
    "    ct_change,\n" +
    "    cl_menu\n" +
    "from\n" +
    "    page\n" +
    "order by lvl asc, cn_order asc, cv_name asc\n";
export const sqlPageObject =
    "with recursive page_object as (\n" +
    "select\n" +
    "    po.ck_id,\n" +
    "    po.ck_page,\n" +
    "    po.ck_object,\n" +
    "    po.cn_order,\n" +
    "    po.ck_parent,\n" +
    "    po.ck_master,\n" +
    "    po.ck_user,\n" +
    "    po.ct_change,\n" +
    "    o.ck_parent as ck_parent_object,\n" +
    "    o.cv_name as cv_name_object,\n" +
    "    1 as lvl\n" +
    "from\n" +
    "    s_mt.t_page_object po\n" +
    "join s_mt.t_object o\n" +
    "    on o.ck_id = po.ck_object\n" +
    "where\n" +
    "    po.ck_parent is null and\n" +
    "    po.ck_page in (select ck_id from s_mt.t_page where ck_id in (select value from json_array_elements_text(:cct_page::json)) and cr_type = 2)\n" +
    "union all\n" +
    "select\n" +
    "    po.ck_id,\n" +
    "    po.ck_page,\n" +
    "    po.ck_object,\n" +
    "    po.cn_order,\n" +
    "    po.ck_parent,\n" +
    "    po.ck_master,\n" +
    "    po.ck_user,\n" +
    "    po.ct_change,\n" +
    "    o.ck_parent as ck_parent_object,\n" +
    "    o.cv_name as cv_name_object,\n" +
    "    rp.lvl+1 as lvl\n" +
    "from\n" +
    "    s_mt.t_page_object po\n" +
    "join page_object rp on\n" +
    "    po.ck_parent = rp.ck_id\n" +
    "join s_mt.t_object o\n" +
    "    on o.ck_id = po.ck_object\n" +
    ")\n" +
    "select\n" +
    "    ck_id,\n" +
    "    ck_page,\n" +
    "    ck_object,\n" +
    "    cn_order,\n" +
    "    ck_parent,\n" +
    "    ck_master,\n" +
    "    ck_user,\n" +
    "    ct_change,\n" +
    "    ck_parent_object\n" +
    "from\n" +
    "    page_object\n" +
    "order by lvl asc, ck_page asc, cn_order asc, cv_name_object asc \n";
export const sqlPageObjectMaster =
    "select\n" +
    "    po.ck_id,\n" +
    "    po.ck_master,\n" +
    "    po.ck_page\n" +
    "from\n" +
    "    s_mt.t_page_object po\n" +
    "where\n" +
    "    po.ck_master is not null and po.ck_page in (select ck_id from s_mt.t_page where ck_id in (select value from json_array_elements_text(:cct_page::json)) and cr_type = 2)\n" +
    "order by\n" +
    "    po.ck_id asc\n";
export const sqlPageObjectAttr =
    "with recursive page_object as (\n" +
    "select\n" +
    "    ck_id,\n" +
    "    ck_page,\n" +
    "    cn_order,\n" +
    "    1 as lvl\n" +
    "from\n" +
    "    s_mt.t_page_object\n" +
    "where\n" +
    "    ck_parent is null and\n" +
    "    ck_page in (select ck_id from s_mt.t_page where ck_id in (select value from json_array_elements_text(:cct_page::json)) and cr_type = 2)\n" +
    "union all\n" +
    "select\n" +
    "    po.ck_id,\n" +
    "    po.ck_page,\n" +
    "    po.cn_order,\n" +
    "    rp.lvl+1 as lvl\n" +
    "from\n" +
    "    s_mt.t_page_object po\n" +
    "join page_object rp on\n" +
    "    po.ck_parent = rp.ck_id )\n" +
    "select\n" +
    "    attr.ck_id,\n" +
    "    attr.ck_page_object,\n" +
    "    attr.ck_class_attr,\n" +
    "    attr.cv_value,\n" +
    "    attr.ck_user,\n" +
    "    attr.ct_change,\n" +
    "    ca.ck_attr," +
    "    po.ck_page\n" +
    "from\n" +
    "    s_mt.t_page_object_attr attr\n" +
    "join page_object po on\n" +
    "    ck_page_object = po.ck_id\n" +
    "join s_mt.t_class_attr ca\n" +
    "on ca.ck_id = attr.ck_class_attr\n" +
    "order by po.lvl asc, po.cn_order asc, attr.ck_class_attr asc \n";
export const sqlPageVariable =
    "select\n" +
    "    vp.ck_id,\n" +
    "    vp.ck_page,\n" +
    "    vp.cv_name,\n" +
    "    vp.cv_value,\n" +
    "    vp.cv_description,\n" +
    "    vp.ck_user,\n" +
    "    vp.ct_change\n" +
    "from\n" +
    "    s_mt.t_page_variable vp\n" +
    " where vp.ck_page in (select value from json_array_elements_text(:cct_page::json))\n" +
    "order by vp.cv_name asc, vp.ct_change asc\n";
export const sqlPageAction =
    "select\n" +
    "    ap.ck_id,\n" +
    "    ap.ck_page,\n" +
    "    ap.cr_type,\n" +
    "    ap.cn_action,\n" +
    "    ap.ck_user,\n" +
    "    ap.ct_change\n" +
    "from\n" +
    "    s_mt.t_page_action ap\n" +
    " where ap.ck_page in (select value from json_array_elements_text(:cct_page::json))\n" +
    "order by ap.cr_type\n";
export const sqlSysSetting =
    "select\n" +
    "    ck_id,\n" +
    "    cv_value,\n" +
    "    ck_user,\n" +
    "    ct_change,\n" +
    "    cv_description\n" +
    "from\n" +
    "    s_mt.t_sys_setting\n" +
    " where ck_id in (select value from json_array_elements_text(:cct_sys_setting::json))\n" +
    " order by ck_id asc\n";
export const sqlMessage =
    "select\n" +
    "    ck_id,\n" +
    "    cr_type,\n" +
    "    cv_text,\n" +
    "    ck_user,\n" +
    "    ct_change\n" +
    "from\n" +
    "    s_mt.t_message\n" +
    " where ck_id in (select value::bigint from json_array_elements_text(:cct_message::json))\n" +
    "  order by ck_id asc\n";
export const sqlDLang =
    "select\n" +
    "    ck_id,\n" +
    "    cv_name,\n" +
    "    cl_default,\n" +
    "    ck_user,\n" +
    "    ct_change\n" +
    "from\n" +
    "    s_mt.t_d_lang\n" +
    " where ck_id in (select value from json_array_elements_text(:cct_lang::json))\n" +
    "  order by ck_id asc\n";
export const sqlLocalization =
    "select\n" +
    "    ck_id,\n" +
    "    ck_d_lang,\n" +
    "    cr_namespace,\n" +
    "    cv_value,\n" +
    "    ck_user,\n" +
    "    ct_change\n" +
    "from\n" +
    "    s_mt.t_localization\n" +
    " where ck_d_lang in (select value from json_array_elements_text(:cct_lang::json))\n" +
    " order by ck_d_lang asc, ct_change asc, ck_id asc\n";
export const sqlLocalizationMessage =
    "select\n" +
    "    ck_id,\n" +
    "    ck_d_lang,\n" +
    "    cr_namespace,\n" +
    "    cv_value,\n" +
    "    ck_user,\n" +
    "    ct_change\n" +
    "from\n" +
    "    s_mt.t_localization\n" +
    " where cr_namespace = 'message'\n" +
    " order by ck_d_lang asc, ct_change asc, ck_id asc\n";
export const sqlQueryPage =
    "with recursive page_object as (\n" +
    "    select\n" +
    "        q.ck_id as ck_query,\n" +
    "        po.ck_parent,\n" +
    "        po.ck_id\n" +
    "    from\n" +
    "        s_mt.t_page_object po\n" +
    "    join s_mt.t_object o on\n" +
    "        o.ck_id = po.ck_object\n" +
    "    left join s_mt.t_page_object_attr po_attr on\n" +
    "        po.ck_id = po_attr.ck_page_object\n" +
    "    left join s_mt.t_object_attr o_attr on\n" +
    "        o.ck_id = o_attr.ck_object\n" +
    "    left join s_mt.t_query q on\n" +
    "        o.ck_query = q.ck_id\n" +
    "        or po_attr.cv_value = q.ck_id\n" +
    "        or o_attr.cv_value = q.ck_id\n" +
    "    where\n" +
    "        po.ck_parent is null\n" +
    "        and po.ck_page in (select ck_id from s_mt.t_page where ck_id in (select value from json_array_elements_text(:cct_page::json)) and cr_type = 2)\n" +
    "union all\n" +
    "    select\n" +
    "        q.ck_id as ck_query,\n" +
    "        po.ck_parent,\n" +
    "        po.ck_id\n" +
    "    from\n" +
    "        s_mt.t_page_object po\n" +
    "    join page_object rp on\n" +
    "        po.ck_parent = rp.ck_id\n" +
    "    join s_mt.t_object o on\n" +
    "        o.ck_id = po.ck_object\n" +
    "    left join s_mt.t_page_object_attr po_attr on\n" +
    "        po.ck_id = po_attr.ck_page_object\n" +
    "    left join s_mt.t_object_attr o_attr on\n" +
    "        o.ck_id = o_attr.ck_object\n" +
    "    left join s_mt.t_query q on\n" +
    "        o.ck_query = q.ck_id\n" +
    "        or po_attr.cv_value = q.ck_id\n" +
    "        or o_attr.cv_value = q.ck_id\n" +
    ")\n" +
    "select\n" +
    "    distinct ck_query\n" +
    "from\n" +
    "    page_object\n" +
    "where\n" +
    "    ck_query is not null\n" +
    "order by\n" +
    "    ck_query asc\n";

export const sqlLocalizationPage =
    "with recursive page_object as (\n" +
    "    select\n" +
    "        po.ck_id,\n" +
    "        po.ck_page,\n" +
    "        po.ck_parent,\n" +
    "        po.ck_object,\n" +
    "        o.ck_class,\n" +
    "        o.cv_displayed,\n" +
    "        1 as lvl\n" +
    "    from\n" +
    "        s_mt.t_page_object po\n" +
    "    join s_mt.t_object o on\n" +
    "        po.ck_object = o.ck_id\n" +
    "    where\n" +
    "        po.ck_parent is null\n" +
    "        and po.ck_page in (select value from json_array_elements_text(:cct_page::json))\n" +
    "union all\n" +
    "    select\n" +
    "        po.ck_id,\n" +
    "        po.ck_page,\n" +
    "        po.ck_parent,\n" +
    "        po.ck_object,\n" +
    "        o.ck_class,\n" +
    "        o.cv_displayed,\n" +
    "        rp.lvl + 1 as lvl\n" +
    "    from\n" +
    "        s_mt.t_page_object po\n" +
    "    join s_mt.t_object o on\n" +
    "        po.ck_object = o.ck_id\n" +
    "    join page_object rp on\n" +
    "        po.ck_parent = rp.ck_id\n" +
    ")\n" +
    "select\n" +
    "    distinct p.ck_id as ck_page, l.*\n" +
    "from\n" +
    "    s_mt.t_page p\n" +
    "left join page_object po on\n" +
    "    p.ck_id = po.ck_page\n" +
    "left join s_mt.t_page_object_attr po_attr on\n" +
    "    po.ck_id = po_attr.ck_page_object\n" +
    "left join s_mt.t_object_attr o_attr on\n" +
    "    po.ck_object = o_attr.ck_object\n" +
    "left join s_mt.t_class_attr ca on\n" +
    "    po.ck_class = ca.ck_class\n" +
    "left join s_mt.t_localization l on\n" +
    "    l.ck_id = p.cv_name\n" +
    "    or l.ck_id = po.cv_displayed\n" +
    "    or l.ck_id = po_attr.cv_value\n" +
    "    or l.ck_id = o_attr.cv_value\n" +
    "    or l.ck_id = ca.cv_value\n" +
    "where\n" +
    "    l.ck_id is not null\n" +
    "    and p.ck_id in (select value from json_array_elements_text(:cct_page::json))\n" +
    "order by\n" +
    "    p.ck_id asc,\n" +
    "    l.ck_d_lang asc,\n" +
    "    l.ct_change asc,\n" +
    "    l.ck_id asc\n";
