--liquibase formatted sql
--changeset romanyuk_a:MTClass.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTClass', '/*MTClass*/
select t.ck_id,
       t.cv_name,
       t.cv_description,
       t.cl_final,
       t.cl_dataset,
       t.ck_view,
       /*Поля аудита*/
       t.ck_user,
       t.ct_change
from   
( select c.ck_id,
       c.cv_name,
       c.cv_description,
       c.cl_final,
       c.cl_dataset,
       c.ck_view,
       c.ck_user,
       c.ct_change at time zone :sess_cv_timezone as ct_change
  from s_mt.t_class c
  left join s_mt.t_module_class mc
    on c.ck_id = mc.ck_class
  left join s_mt.t_module m
    on mc.ck_module = m.ck_id
 where coalesce(m.cl_available, 1) = 1
 and c.ck_view = :json::json#>>''{filter,ck_view}''
 /*##filter.ck_id*/and c.ck_id = (:json::json#>>''{filter,ck_id}'')::varchar/*filter.ck_id##*/
) t
 where 1=1 and ( &FILTER )
 order by &SORT
  ', 'meta', '20783', '2019-11-22 15:28:20.009812+03', 'select', 'po_session', NULL, 'Список классов')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;

