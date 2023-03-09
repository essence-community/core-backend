--liquibase formatted sql
--changeset artemov_i:MTPageAttr dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description, cc_query)
 VALUES('MTPageAttr', 'meta', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-12-10T11:18:27.503+0000', 'select', 'po_session', null, 'Список атрибутов страницы',
 '/*MTPageAttr*/
select t.* from (
select 
    pattr.ck_id,
    pattr.ck_page,
    attr.ck_id as ck_attr,
    pattr.cv_value,
    attr.cv_description,
    attr.ck_d_data_type,
    attr.cv_data_type_extra,
    pattr.ck_user,
    pattr.ct_change at time zone :sess_cv_timezone as ct_change
from
    s_mt.t_attr attr
left join s_mt.t_page_attr pattr
    on attr.ck_id = pattr.ck_attr and pattr.ck_page = :json::jsonb#>>''{master,ck_id}''
where nullif(:json::jsonb#>>''{master,ck_id}'', '''') is not null
and attr.ck_id in (''defaultvalue'',''activerules'',''redirecturl'',''defaultvaluerule'',''titlerules'')
/*##filter.ck_id*/ and pattr.ck_id = (:json::jsonb#>>''{filter,ck_id}'')/*filter.ck_id##*/
 ) as t
where true
and &FILTER
order by &SORT
')
 on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;
