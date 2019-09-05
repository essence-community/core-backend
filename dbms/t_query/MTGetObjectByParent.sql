--liquibase formatted sql
--changeset artemov_i:MTGetObjectByParent.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTGetObjectByParent', '/*MTGetObjectByParent*/

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

 where o.ck_parent = (cast(:json as jsonb)->''master''->>''ck_id'')::varchar /* Если передали ИД родительского объекта - выберем его дочек */

    or o.ck_parent is null /* Верхнеуровневые объекты показываем всегда */

 order by lower(o.cv_name)

 ', 'meta', '20783', '2019-05-27 14:27:58.22659+03', 'select', 'po_session', NULL, 'Необходимо актуализировать')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

