--liquibase formatted sql
--changeset artemov_i:AuthShowAction.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id,cc_query,ck_provider,ck_user,ct_change,cr_type,cr_access,cv_description)
VALUES ('AuthShowAction','/*AuthShowAction*/
select /*Pagination*/
       row_number() over(order by &SORT)as jn_rownum,
       count(1) over() as jn_total_cnt,
       /*Action*/
       t.*
  from (
select 
    ck_id,
	cv_name,
	cv_description,
	ck_user,
	ct_change
from t_action
 where true
       /*##filter.ck_id*/
   and ck_id = (:json::json#>>''{filter,ck_id}'')::bigint/*filter.ck_id##*/
      /*##filter.cn_action*/
   and ck_id =
       trim(:json::json#>>''{filter,cn_action}'')::bigint /*filter.cn_action##*/
      /*##filter.cv_name*/
   and upper(cv_name) like
       upper(trim(:json::json#>>''{filter,cv_name}'')) || ''%'' /*filter.cv_name##*/
  ) t
 where &FILTER
 order by &SORT
offset &OFFSET rows
 fetch first &FETCH rows only','authcore','-11','2019-08-15 09:30:00.000','select','po_session','Список действий')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;
