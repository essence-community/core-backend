--liquibase formatted sql
--changeset artemov_i:GetTTMetaUser.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('GetTTMetaUser', '/*GetTTMetaUser*/
select 
  /*Pagination*/
  count(1) over() as jn_total_cnt,
  /*Data*/
  t.*
from tt_user t
 where &FILTER
 /*##filter.search*/and 
    (
      UPPER(t.cv_login) like ''%'' || UPPER(:json::json#>>''{filter,search}'') || ''%''
      or
      UPPER(t.cv_surname) like ''%'' || UPPER(:json::json#>>''{filter,search}'') || ''%''
      or
      UPPER(t.cv_name) like ''%'' || UPPER(:json::json#>>''{filter,search}'') || ''%''
      or
      UPPER(t.cv_patronymic) like ''%'' || UPPER(:json::json#>>''{filter,search}'') || ''%''
      or
      UPPER(t.cv_email) like ''%'' || UPPER(:json::json#>>''{filter,search}'') || ''%''
    )
 /*filter.search##*/
 order by &SORT
offset &OFFSET rows
 fetch first &FETCH rows only
 ', 'meta', '20783', '2023-02-28 09:21:02.345092+03', 'select', 'po_session', NULL, 'Список закешированых пользователей')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;

