--liquibase formatted sql
--changeset artemov_i:MTGetLocalizationValue dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTGetLocalizationValue', '--MTGetLocalizationValue
select /*Pagination*/
       count(1) over() as jn_total_cnt,
       /*Localization*/
       t.*
  from (
    select
        l.ck_id,
        l.cv_value
    from t_localization l
    where l.cr_namespace = ''meta''
     /*##filter.g_sys_lang*/and l.ck_d_lang = :json::json#>>''{filter,g_sys_lang}''/*##filter.g_sys_lang*/
     /*##filter.ck_id*/and l.ck_id = :json::json#>>''{filter,ck_id}''/*filter.ck_id##*/
     /*##filter.cv_value*/and (l.ck_id = :json::json#>>''{filter,cv_value}'' or upper(l.cv_value) like upper(:json::json#>>''{filter,cv_value}'' || ''%''))/*filter.cv_value##*/
     /*##filter.ck_id*/union all
     select
        l2.ck_id,
        l2.cv_value
    from t_localization l2
    where l2.cr_namespace = ''meta''
    and l2.ck_d_lang in (select ck_id from t_d_lang where cl_default = 1)
    and l2.ck_id = :json::json#>>''{filter,ck_id}''
    and not exists (select 1 from t_localization
      where ck_id = :json::json#>>''{filter,ck_id}''
      /*##filter.g_sys_lang*/and ck_d_lang = :json::json#>>''{filter,g_sys_lang}''/*##filter.g_sys_lang*/
    )
    /*filter.ck_id##*/
    /*##filter.cv_value*/union all
     select
        l3.ck_id,
        l3.cv_value
    from t_localization l3
    where l3.cr_namespace = ''meta''
    and l3.ck_d_lang in (select ck_id from t_d_lang where cl_default = 1)
    and l3.ck_id = :json::json#>>''{filter,cv_value}''
    /*##filter.ck_id*/and l.ck_id = :json::json#>>''{filter,ck_id}''/*filter.ck_id##*/
    and not exists (select 1 from t_localization
      where ck_id = :json::json#>>''{filter,cv_value}''
      /*##filter.ck_id*/and l.ck_id = :json::json#>>''{filter,ck_id}''/*filter.ck_id##*/
      /*##filter.g_sys_lang*/and ck_d_lang = :json::json#>>''{filter,g_sys_lang}''/*##filter.g_sys_lang*/
    )
    /*filter.cv_value##*/
    ) t
 where &FILTER
 order by &SORT
offset &OFFSET rows
 fetch first &FETCH rows only
  ', 'meta', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-05 12:56:04.052926+03', 'select', 'po_session', NULL, 'Список переводов для комбо выбора')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;
