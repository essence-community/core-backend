--liquibase formatted sql
--changeset patcher-core:MTApplicationRoute dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description, cc_query)
 VALUES('MTApplicationRoute', 'meta', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-05T14:59:49.000+0000', 'select', 'free', null, 'Список доступных приложений',
 '/*MTApplicationRoute*/
with recursive ot_page as (
    select
        tp.ck_id,
        tp.cn_order,
        1 as lvl
    from
        s_mt.t_page tp
    where
        tp.ck_id in (select cv_value from s_mt.t_sys_setting where ck_id = ''project_applications_page'')
union all
    select
        tp.ck_id,
        tp.cn_order,
        otp.lvl + 1 as lvl
    from
        s_mt.t_page tp
    join ot_page otp on
        tp.ck_parent = otp.ck_id
), ot_action as (
 select value::bigint from jsonb_array_elements_text(:sess_ca_actions)
 union all
 select cv_value::bigint as value from s_mt.t_sys_setting tss where tss.ck_id = ''g_sys_anonymous_action''
)
select
    jsonb_build_object(''children'', jsonb_agg(t.json), ''global_value'', (select  jsonb_object_agg(pv.cv_name, pv.cv_value) from ot_page p
join s_mt.t_page_variable pv on p.ck_id = pv.ck_page))::varchar as json
from
    (
        select
            jsonb_build_object(''ck_page_object'', po.ck_id, ''ck_object'', o.ck_id, ''cl_dataset'', c.cl_dataset, ''cv_name'', o.cv_name, ''cv_displayed'', o.cv_displayed, ''cv_description'', o.cv_description, ''ck_master'', po.ck_master, ''ck_page'', po.ck_page, ''ck_parent'', po.ck_parent, ''cn_order'', po.cn_order ) || coalesce((select ''{"cl_is_master": 1}''::jsonb where exists (select 1 from s_mt.t_page_object po_master where po_master.ck_master = po.ck_id)), ''{}''::jsonb) ||
            case
                when c.cl_dataset::int = 1 then jsonb_build_object(''ck_query'', o.ck_query, ''ck_modify'', ''modify'', ''cv_helper_color'', case when o.ck_query is null and o.cv_modify is null then ''red'' when o.ck_query is null or o.cv_modify is null then ''yellow'' else ''blue'' end )
                else ''{}''::jsonb
            end /*Добавление динамических атрибутов из класса и обьекта*/
            || coalesce((select
                jsonb_object_agg(t.ck_attr, pkg_json.f_decode_attr(t.cv_value, t.ck_d_data_type)) as attr_po
            from
                (
                    select
                        ca2.ck_attr,
                        a2.ck_d_data_type,
                        coalesce(poa.cv_value, oa.cv_value, ca2.cv_value) as cv_value
                    from
                        s_mt.t_class_attr ca2
                    join s_mt.t_attr a2 on
                        a2.ck_id = ca2.ck_attr
                    left join s_mt.t_object_attr oa on
                        o.ck_id = oa.ck_object
                        and ca2.ck_id = oa.ck_class_attr
                    left join s_mt.t_page_object_attr poa on
                        poa.ck_page_object = po.ck_id
                        and poa.ck_class_attr = ca2.ck_id
                    where
                        ca2.ck_class = c.ck_id
                        and ca2.ck_id not in (
                            select
                                ck_class_attr
                            from
                                s_mt.t_class_hierarchy ch
                            where
                                ch.ck_class_attr in (
                                    select
                                        ck_id
                                    from
                                        s_mt.t_class_attr
                                    where
                                        ck_class = c.ck_id
                                )
                        )
                ) as t
            where
                t.cv_value is not null), ''{}''::jsonb) as json
        from
            ot_page p
        join s_mt.t_page_action pa on
            p.ck_id = pa.ck_page
            and pa.cr_type = ''view''
        join s_mt.t_page_object po on
            p.ck_id = po.ck_page
        join s_mt.t_object o on
            o.ck_id = po.ck_object
        join s_mt.t_class c on
            o.ck_class = c.ck_id
        where po.ck_parent is null and pa.cn_action in (select value from ot_action)
        order by
            p.lvl asc, p.cn_order asc, po.cn_order asc
    ) as t')
 on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;
