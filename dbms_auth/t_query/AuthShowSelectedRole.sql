--liquibase formatted sql
--changeset artemov_i:AuthShowSelectedRole.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id,cc_query,ck_provider,ck_user,ct_change,cr_type,cr_access,cv_description)
VALUES ('AuthShowSelectedRole','/*AuthShowSelectedRole*/
select /*Pagination*/
       row_number() over(order by &SORT)as jn_rownum,
       count(1) over() as jn_total_cnt,
       /*Roles*/
       t.*
  from (
select
  ra.ck_id,
  a.ck_id as ck_role,
	a.cv_name,
	a.cv_description,
  ragg.cv_action,
	ra.ck_user,
	ra.ct_change at time zone :sess_cv_timezone as ct_change
from t_role a
left join t_account_role ra
 on a.ck_id = ra.ck_role and ra.ck_account =
       trim(:json::json#>>''{master,ck_id}'')::uuid
left join (select
    tra.ck_role,
    string_agg(tra.ck_action::varchar, '', '') as cv_action
  from
    s_at.t_role_action as tra
  group by
    tra.ck_role) as ragg
on ragg.ck_role = ra.ck_role
 where ra.ck_account is not null
 ) t
  where &FILTER
 order by &SORT
offset &OFFSET rows
 fetch first &FETCH rows only','authcore','-11','2019-08-13 18:30:00.000','select','po_session','Список выбраных ролей')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cv_description = excluded.cv_description;
