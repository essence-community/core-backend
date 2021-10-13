--liquibase formatted sql
--changeset artemov_i:MTGetObjectByParent.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTGetObjectByParent', '/*MTGetObjectByParent*/
select /*Pagination*/
       count(1) over() as jn_total_cnt,
       /*Object*/
       t.*
  from (
select o.ck_id,
       o.ck_class,
       o.ck_parent,
       o.cv_name,
       op.cv_name as cv_name_parent,
       o.cv_displayed,
       o.cn_order,
       o.ck_query,
       o.cv_description,
       /* Поля аудита */
       o.ck_user,
       o.ct_change at time zone :sess_cv_timezone as ct_change
  from s_mt.t_object o
  join s_mt.t_class cl 
  on cl.ck_id = o.ck_class
  left join s_mt.t_object op
  on o.ck_parent = op.ck_id
 where (o.ck_parent = :json::json#>>''{master,ck_object}'' /* Если передали ИД родительского объекта - выберем его дочек */
    or o.ck_parent is null /* Верхнеуровневые объекты показываем всегда */)
    and cl.ck_view = :json::json#>>''{filter,gck_view}''
) as t
 where &FILTER
 order by &SORT
offset &OFFSET rows
 fetch first &FETCH rows only
 ', 'meta', '20783', '2019-05-27 14:27:58.22659+03', 'select', 'po_session', NULL, 'Список объектов по мастеру')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;

