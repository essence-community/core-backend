--liquibase formatted sql
--changeset artemov_i:MTRoute dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description, cc_query)
 VALUES('MTRoute', 'meta', '20783', '2019-05-30T06:18:27.503+0000', 'select', 'free', null, 'Необходимо актуализировать',
 '/*MTRoute*/
with recursive t1(
    ck_id,
    ck_parent,
    cr_type,
    cv_name,
    cv_name_locale,
    cn_order,
    cl_static,
    cv_url,
    ck_icon,
    cl_menu,
    ck_view,
    cv_app_url,
    lvl,
    root,
    cn_action_view,
    cn_action_edit,
    ck_icon_id,
    cv_icon_name,
    cv_icon_font
) as (
    /* сначала выберем все объекты которые могут быть отображены */
    select
        p.ck_id,
        null::varchar as ck_parent,
        p.cr_type,
        p.cv_name,
        l.cv_value as cv_name_locale,
        p.cn_order,
        p.cl_static,
        p.cv_url,
        p.ck_icon,
        p.cl_menu,
        p.ck_view,
        par.cv_url as cv_app_url,
        1 as lvl,
        p.cv_name  as root,
        pav.cn_action as cn_action_view,
        pae.cn_action as cn_action_edit,
        i.ck_id as ck_icon_id,
        i.cv_name as cv_icon_name,
        i.cv_font as cv_icon_font
    from
        s_mt.t_page p
    join s_mt.t_page par on 
        p.ck_parent = par.ck_id
    left join s_mt.t_localization l on
        l.ck_id = p.cv_name and l.ck_d_lang in (select tdl.ck_id from s_mt.t_d_lang tdl where tdl.cl_default = 1)
    left join s_mt.t_page_action pav on
        pav.ck_page = p.ck_id and pav.cr_type = ''view''
    left join s_mt.t_page_action pae on
        pae.ck_page = p.ck_id and pae.cr_type = ''edit''
    left join s_mt.t_icon i on
        i.ck_id = p.ck_icon
    where
        (lower(:json::json#>>''{filter,appUrl}'') in (''pages'', ''frame'', ''reports'', ''safe'', ''redirect'', ''preference'')
        and p.ck_parent in (select ck_id from s_mt.t_page where ck_parent is null and cr_type = 3))
        or (p.ck_parent in (select ck_id from s_mt.t_page where lower(cv_url)=lower(:json::json#>>''{filter,appUrl}'') and cr_type = 3))
union all /* выберем их дочернии элементы в рекурсивном запросе */
    select
        p.ck_id,
        p.ck_parent,
        p.cr_type,
        p.cv_name,
        l.cv_value as cv_name_locale,
        p.cn_order,
        p.cl_static,
        p.cv_url,
        p.ck_icon,
        p.cl_menu,
        p.ck_view,
        op.cv_app_url,
        op.lvl+1 as lvl,
        op.cv_name as root,
        pav.cn_action as cn_action_view,
        pae.cn_action as cn_action_edit,
        i.ck_id as ck_icon_id,
        i.cv_name as cv_icon_name,
        i.cv_font as cv_icon_font
    from
        t1 op
    join s_mt.t_page p on
        op.ck_id = p.ck_parent
    left join s_mt.t_localization l on
        l.ck_id = p.cv_name and l.ck_d_lang in (select tdl.ck_id from s_mt.t_d_lang tdl where tdl.cl_default = 1)
    left join s_mt.t_page_action pav on
        pav.ck_page = p.ck_id and pav.cr_type = ''view''
    left join s_mt.t_page_action pae on
        pae.ck_page = p.ck_id and pae.cr_type = ''edit''
    left join s_mt.t_icon i on
        i.ck_id = p.ck_icon
),
ot_action as (
    select tss.cv_value::bigint as cn_action from s_mt.t_sys_setting tss where tss.ck_id = ''g_sys_anonymous_action''
    union all
    select value::bigint as cn_action from jsonb_array_elements_text(:sess_ca_actions::jsonb)
),
t2 as(
    select
        p.*
    from
        t1 p
    where
        p.cr_type = 2 and p.cn_action_view in (select cn_action from ot_action)
union all /* выберем их родителей в рекурсивном запросе */
    select
        p.*
    from
        t2
    join t1 p on
        t2.ck_parent = p.ck_id
),
t3 as(
    select
        distinct p.*
    from
        t2 p
)
select
    op.ck_id,
    op.ck_parent,
    op.cr_type,
    op.cv_name,
    op.cn_order,
    op.cl_menu,
    op.cl_static,
    op.cv_url,
    op.ck_icon,
    op.ck_id,
    op.ck_view,
    op.cv_app_url,
    op.cv_icon_name,
    op.cv_icon_font,
    case when not exists(select 1 from t3 m where m.ck_parent = op.ck_id) then ''true'' else ''false'' end as leaf,
    op.root,
    op.cn_action_edit
from
    t3 op
order by
    op.lvl asc, op.cn_order asc, op.cv_name_locale asc')
 on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;
