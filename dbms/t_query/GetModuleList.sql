--liquibase formatted sql
--changeset artemov_i:GetModuleList.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('GetModuleList', '--GetModuleList
select
  m.ck_id,
  m.cv_name,
  m.ck_user,
  m.ct_change,
  m.cv_version,
  m.cl_available,
  m.cv_version_api,
  m.cc_manifest,
  m.cc_config
from s_mt.t_module m
where &FILTER
/*##master.cv_name*/ and m.cv_name = :json::json#>>''{master,cv_name}''/*master.cv_name##*/ 
/*##filter.ck_id*/ and m.ck_id = :json::json#>>''{filter,ck_id}''/*filter.ck_id##*/
/*##filter.cl_available*/ and m.cl_available = (:json::json#>>''{filter,cl_available}'')::smallint/*filter.cl_available##*/
/*##filter.cv_version_api*/ and REGEXP_REPLACE(m.cv_version_api, ''^(\d+\.\d+).*'',''\1'') = REGEXP_REPLACE((:json::json#>>''{filter,cv_version_api}''), ''^(\d+\.\d+).*'',''\1'') /*filter.cv_version_api##*/
order by &SORT
  ', 'meta', '-11', '2019-05-21 16:55:33.287994+03', 'select', 'free', NULL, 'Необходимо актуализировать')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

