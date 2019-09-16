--liquibase formatted sql
--changeset artemov_i:MTClass.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTClass', '/*MTClass*/
select c.ck_id,
       c.cv_name,
       c.cv_description,
       c.cl_final,
       c.cl_dataset,
       /* Поля аудита */
       c.ck_user,
       c.ct_change at time zone :sess_cv_timezone as ct_change
  from s_mt.t_class c
  left join s_mt.t_module_class mc
    on c.ck_id = mc.ck_class
  left join s_mt.t_module m
    on mc.ck_module = m.ck_id
 where coalesce(m.cl_available, 1) = 1
   and ( &FILTER )
 /*##filter.ck_id*/and c.ck_id = (cast(:json as jsonb)->''filter''->>''ck_id'')::varchar/*filter.ck_id##*/
 order by &SORT, c.cv_name asc
  ', 'meta', '20783', '2019-05-24 14:28:20.009812+03', 'select', 'po_session', NULL, 'Необходимо актуализировать')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

