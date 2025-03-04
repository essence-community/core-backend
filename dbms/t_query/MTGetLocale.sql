--liquibase formatted sql
--changeset artemov_i:MTGetLocale dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description, cr_cache, cv_cache_key_param) VALUES ('MTGetLocale', '--MTGetLocale
select
	json_object(array_agg(l.ck_id), array_agg(l.cv_value)) as json
from
	t_localization l
where l.ck_d_lang = :json::json#>>''{filter,ck_d_lang}'' and l.cr_namespace = :json::json#>>''{filter,cv_namespace}''
  ', 'meta', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-05 12:56:04.052926+03', 'select', 'free', NULL, 'Вытаскиваем все переводы', 'all', '["json.filter.ck_d_lang","json.filter.cv_namespace"]')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description, cr_cache = excluded.cr_cache, cv_cache_key_param = excluded.cv_cache_key_param;

