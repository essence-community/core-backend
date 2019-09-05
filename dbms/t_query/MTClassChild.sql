--liquibase formatted sql
--changeset artemov_i:MTClassChild.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTClassChild', '/*MTClassChild*/

select ca.ck_id as ck_class_attr,

       ca.ck_attr,

       ch.ck_id,

       c_child.ck_id as ck_class,

       c_child.cv_name,

       c_child.cv_description,

       c_child.cl_final,

       c_child.cl_dataset,

       /* Поля аудита */

       c_child.ck_user,

       c_child.ct_change at time zone :sess_cv_timezone as ct_change

  from s_mt.t_class_hierarchy ch

  join s_mt.t_class c_child on c_child.ck_id = ch.ck_class_child

  join s_mt.t_class_attr ca on ca.ck_id = ch.ck_class_attr

 where ch.ck_class_parent = (cast(:json as jsonb)->''master''->>''ck_id'')::varchar

   and ( &FILTER )

  /*##filter.ck_id*/and ch.ck_id = (cast(:json as jsonb)->''filter''->>''ck_id'')::varchar/*filter.ck_id##*/

 order by &SORT, ca.ck_attr asc, c_child.cv_name asc

  ', 'meta', '20783', '2019-05-24 15:33:14.958904+03', 'select', 'po_session', NULL, 'Необходимо актуализировать')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

