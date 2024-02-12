--liquibase formatted sql
--changeset patcher-core:MTApplicationRoute dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description, cc_query)
 VALUES('MTApplicationRoute', 'meta', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-05T14:59:49.000+0000', 'select', 'free', null, 'Список доступных приложений',
 '/*MTApplicationRoute*/
 select
    p.ck_id,
    p.ck_parent,
    p.cr_type,
    p.cv_name,
    p.cn_order,
    p.cl_static,
    p.cv_url,
    p.ck_icon,
    p.cl_menu,
    p.ck_view,
    p.cv_redirect_url,
    p.cl_multi,
    (
        (coalesce(nullif(tv.cct_config#>>''{bc}'', ''''), ''{"type": "APPLICATION"}''))::jsonb
        || jsonb_build_object(''childs'', (coalesce(nullif(tv.cct_config#>>''{children}'', ''''), nullif(tv.cct_config#>>''{bc,childs}'', ''''), ''[]''))::jsonb || coalesce(nullif((
            select
                jsonb_agg(t.json ORDER BY t.cn_order) as children
            from
                (
                    select
                        po.cn_order,
                        pkg_json.f_get_object(po.ck_id)::jsonb as json
                    from t_page_object po
                    where po.ck_parent is null and po.ck_id is not null and po.ck_page = p.ck_id 
                ) as t
            )::text, ''[null]''), ''[]'')::jsonb)
        || coalesce((
            select
                jsonb_object_agg(tpa.ck_attr, tpa.cv_value)
            from
                s_mt.t_page_attr tpa
            where
                tpa.ck_page = p.ck_id
        ), ''{}'')::jsonb
    ) as json
from
    s_mt.t_page p
join s_mt.t_view tv on
    tv.ck_id = p.ck_view
where
    p.ck_parent is null
    and p.cr_type = 3
order by p.cn_order asc
')
 on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;
