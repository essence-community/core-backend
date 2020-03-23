--liquibase formatted sql
--changeset artemov_i:MTGetDistinctModuleList dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTGetDistinctModuleList', '--MTGetDistinctModuleList
select
    dm.*
from
    (
        select
            coalesce(am.ck_id, m.cv_name) as ck_id,
            m.cv_name,
            am.ck_user,
            am.ct_change at time zone :sess_cv_timezone as ct_change,
            am.cv_version,
            coalesce(am.cl_available, 0) as cl_available,
            am.cv_version_api,
            am.cc_manifest,
            am.cc_config
        from
            (
                select
                    distinct m.cv_name
                from
                    s_mt.t_module m
            ) as m
        left join s_mt.t_module am on
            m.cv_name = am.cv_name
            and am.cl_available = 1
    ) as dm
where &FILTER
/*##filter.ck_id*/ and dm.ck_id = :json::json#>>''{filter,ck_id}''/*filter.ck_id##*/
order by &SORT
  ', 'meta', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-03-03 16:55:33.287994+03', 'select', 'po_session', NULL, 'Список модулей')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

