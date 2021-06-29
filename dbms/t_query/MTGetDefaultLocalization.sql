--liquibase formatted sql
--changeset artemov_i:MTGetDefaultLocalization dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTGetDefaultLocalization', '--MTGetDefaultLocalization
select /*Pagination*/
       count(1) over() as jn_total_cnt,
       /*Localization*/
       t.*
  from (
    select
        l.ck_id,
        l.ck_d_lang,
        l.cr_namespace,
        l.cv_value,
        /* Поля аудита */
        l.ck_user,
        l.ct_change at time zone :sess_cv_timezone as ct_change
    from t_localization l
    where l.ck_d_lang in (select ck_id from t_d_lang where cl_default = 1)
     /*##filter.ck_id*/and l.ck_id = :json::json#>>''{filter,ck_id}''/*filter.ck_id##*/
    ) t
 where &FILTER
 order by &SORT
offset &OFFSET rows
 fetch first &FETCH rows only
  ', 'meta', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-05 12:56:04.052926+03', 'select', 'po_session', NULL, 'Список переводов')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;

