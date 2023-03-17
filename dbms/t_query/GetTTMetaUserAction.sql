--liquibase formatted sql
--changeset artemov_i:GetTTMetaUserAction.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('GetTTMetaUserAction', '/*GetTTMetaUserAction*/
select 
  /*Pagination*/
  count(1) over() as jn_total_cnt,
  /*Data*/
  t.*
from tt_user_action t
 where &FILTER
 order by &SORT
offset &OFFSET rows
 fetch first &FETCH rows only
 ', 'meta', '20783', '2023-02-28 13:55:27.712586+03', 'select', 'po_session', NULL, 'Список закешированых экшены')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;

