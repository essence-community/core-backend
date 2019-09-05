--liquibase formatted sql
--changeset artemov_i:AuthShowSelectedRoleAction.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id,cc_query,ck_provider,ck_user,ct_change,cr_type,cr_access,cv_description)
VALUES ('AuthShowSelectedRoleAction','/*AuthShowSelectedRoleAction*/
select /*Pagination*/
       row_number() over(order by &SORT)as jn_rownum,
       count(1) over() as jn_total_cnt,
       /*Roles*/
       t.*
  from (
select
    a.ck_id,
	a.cv_name,
	a.cv_description,
	ra.ck_user,
	ra.ct_change
from t_role a
left join t_role_action ra
 on a.ck_id = ra.ck_role and ra.ck_action =
       nullif(trim(:json::json#>>''{master,ck_id}''), '''')::bigint
 where ra.ck_action is not null
 ) t
  where &FILTER
 order by &SORT
offset &OFFSET rows
 fetch first &FETCH rows only','authcore','-11','2019-08-13 18:30:00.000','select','po_session','Список выбраных ролей')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;
