--liquibase formatted sql
--changeset artemov_i:IBGetDProvider dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('IBGetDProvider', '--IBGetDProvider
select
  	p.ck_id, 
	  p.cv_description,
    p.ck_user,
    p.ct_change at time zone :sess_cv_timezone as ct_change
from t_d_provider p
where true
/*##filter.ck_id*/and p.ck_id = :json::json#>>''{filter,ck_id}''/*filter.ck_id##*/
  ', 's_ibc_adm', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-24 15:31:04.052526+03', 'select', 'po_session', NULL, 'Список провайдеров')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

