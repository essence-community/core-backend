--liquibase formatted sql
--changeset artemov_i:MTClassList.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTClassList', '/*MTClassList*/

select c.ck_id,

       c.cv_name

  from s_mt.t_class c

  left join s_mt.t_module m

    on c.ck_id = m.ck_class

 where coalesce(m.cl_available, 1) = 1

 order by c.cv_name asc

  ', 'meta', '20783', '2019-05-27 09:42:20.922637+03', 'select', 'po_session', NULL, 'Необходимо актуализировать')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

