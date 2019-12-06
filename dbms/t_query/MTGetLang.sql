--liquibase formatted sql
--changeset artemov_i:MTGetLang dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTGetLang', '--MTGetLang
select
  l.ck_id,
  l.cv_name,
  l.cl_default,
  l.ck_user,
  l.ct_change at time zone :sess_cv_timezone as ct_change
from t_d_lang l
where &FILTER
/*##filter.ck_id*/and t.ck_id = :json::json#>>''{filter,ck_id}''/*filter.ck_id##*/
/*##filter.g_lang_exclude*/and l.ck_id not in (select ck_d_lang from t_localization where ck_id = :json::json#>>''{filter,g_lang_exclude}'')/*filter.g_lang_exclude##*/
order by &SORT
  ', 'meta', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-05 12:56:04.052926+03', 'select', 'po_session', NULL, 'Список языков')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

