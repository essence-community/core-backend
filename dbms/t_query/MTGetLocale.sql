--liquibase formatted sql
--changeset artemov_i:MTGetLocale dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('GetMsgList', '--MTGetLocale
select
  l.ck_id,
  l.сr_namespace,
  l.cv_value
from t_localization l
where l.ck_d_lang = :json::json#>>''{filter,cv_lang}''
order by l.ck_id asc
  ', 'meta', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-05 12:56:04.052926+03', 'select', 'free', NULL, 'Необходимо актуализировать')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

