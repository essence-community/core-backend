--liquibase formatted sql
--changeset kutsenko_o:MTClassDoc.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTClassDoc', '/*MTClassDoc*/
select t.ck_id,
       t.cv_name,
       t.cv_description,
       t.cl_final,
       t.cl_dataset,
       t.cv_manual_documentation,
       t.cv_auto_documentation,
       /*Поля аудита*/
       t.ck_user,
       t.ct_change
from   
( select c.ck_id,
       c.cv_name,
       c.cv_description,
       c.cl_final,
       c.cl_dataset,
       c.cv_manual_documentation,
       c.cv_auto_documentation,
       c.ck_user,
       c.ct_change at time zone :sess_cv_timezone as ct_change
  from s_mt.t_class c
  left join s_mt.t_module_class mc
    on c.ck_id = mc.ck_class
  left join s_mt.t_module m
    on mc.ck_module = m.ck_id
 where coalesce(m.cl_available, 1) = 1
 /*##filter.ck_id*/and c.ck_id = (cast(:json as jsonb)->''filter''->>''ck_id'')::varchar/*filter.ck_id##*/
) t
 where /*##master.ck_id*/t.ck_id = (cast(:json as jsonb)->''master''->>''ck_id'')::varchar and/*master.ck_id##*/ ( &FILTER )
 order by &SORT
', 'meta', '-11', '2020-06-11 09:18:27.503811+03', 'select', 'free', NULL, 'Список страниц документации')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;