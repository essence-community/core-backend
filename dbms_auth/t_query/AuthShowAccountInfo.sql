--liquibase formatted sql
--changeset artemov_i:AuthShowAccountInfo.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id,cc_query,ck_provider,ck_user,ct_change,cr_type,cr_access,cv_description)
VALUES ('AuthShowAccountInfo','/*AuthShowAccountInfo*/
select 
	ainf.ck_id,
	inf.ck_id as ck_d_info,
	inf.cv_description,
	inf.cr_type,
	ainf.cv_value,
	ainf.ck_user,
	ainf.ct_change 
from t_d_info inf 
left join t_account_info ainf
  on inf.ck_id=ainf.ck_d_info and ainf.ck_account = trim(:json::json#>>''{master,ck_id}'')::uuid
where &FILTER
   /*##filter.ck_id*/
   and ainf.ck_id = (:json::json#>>''{filter,ck_id}'')::uuid/*filter.ck_id##*/
order by &SORT','authcore','-11','2019-08-13 18:30:00.000','select','po_session','Список дополнительных атрибутов пользователя')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;