--liquibase formatted sql
--changeset artemov_i:MTGetTopObject.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTGetTopObject', '/*MTGetTopObject*/

select o.ck_id,

       o.ck_class,

       o.ck_parent,

       o.cv_name,

       o.cv_displayed,

       o.cn_order,

       o.ck_query,

       o.cv_description,

       /* Поля аудита */

       o.ck_user,

       o.ct_change at time zone :sess_cv_timezone as ct_change

  from s_mt.t_object o

 where o.ck_parent is null

 order by o.cv_name asc

   ', 'meta', '20783', '2019-05-30 14:07:59.748302+03', 'select', 'po_session', NULL, 'Необходимо актуализировать')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

