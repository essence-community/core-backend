--liquibase formatted sql
--changeset artemov_i:ITGetInterface dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('ITGetInterface', '--ITGetInterface
select
    ck_id, 
	ck_d_interface, 
	ck_d_provider, 
	cn_action,
	cv_description, 
	ck_parent
from t_interface
where true
/*##filter.ck_id*/and ck_id = :json::json#>>''{filter,ck_id}''/*filter.ck_id##*/
  ', 's_ic_adm', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-05 12:56:04.052926+03', 'select', 'po_session', NULL, 'Список интерфейсов')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

