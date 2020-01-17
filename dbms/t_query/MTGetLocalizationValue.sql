--liquibase formatted sql
--changeset artemov_i:MTGetLocalizationValue dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTGetLocalizationValue', '--MTGetLocalizationValue
select /*Pagination*/
       row_number() over(order by &SORT)as jn_rownum,
       count(1) over() as jn_total_cnt,
       /*Localization*/
       t.*
  from (
    select
        l.ck_id,
        l.cv_value
    from t_localization l
    where true
     /*##filter.g_sys_lang*/and l.ck_d_lang = :json::json#>>''{filter,g_sys_lang}''/*##filter.g_sys_lang*/
     /*##filter.ck_id*/and l.ck_id = :json::json#>>''{filter,ck_id}''/*filter.ck_id##*/
     /*##filter.cv_value*/and l.ck_id = :json::json#>>''{filter,ck_id}''/*filter.cv_value##*/
    ) t
 where &FILTER
 order by &SORT
offset &OFFSET rows
 fetch first &FETCH rows only
  ', 'meta', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-05 12:56:04.052926+03', 'select', 'po_session', NULL, 'Список переводов для комбо выбора')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

