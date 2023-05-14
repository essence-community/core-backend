--liquibase formatted sql
--changeset artemov_i:MTGetClassByParentObject.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTGetClassByParentObject', '/*MTGetClassByParentObject*/
with tt_master as (
  select nullif(trim(:json::jsonb#>>''{master,ck_id}''),'''') as ck_id
)
select ck_id,
       cv_name,
       cv_description,
       cl_final,
       cl_dataset,
       cv_name || '' ('' || cv_description || '')'' as cv_displayed,
       /* Поля аудита */
       ck_user,
       ct_change at time zone :sess_cv_timezone as ct_change
  from (select distinct 
               c.*
          from s_mt.t_class c
         where 1 = 1
           /* только те классы, которые могут быть дочерними от класса родительского объекта */
           /*##master.ck_id*/
           and c.ck_id in (
                select ch.ck_class_child from s_mt.t_class_hierarchy ch
                join s_mt.t_object o
                on o.ck_class = ch.ck_class_parent
                where o.ck_id in (select ck_id from tt_master)
            )
           /*master.ck_id##*/
           and (c.ck_view = :json::json#>>''{filter,ck_view}'' or c.ck_view = ''system'')
           /* если родительский объект не передан, то показываем только final-классы */
           and (not exists(select 1 from tt_master where ck_id is null) or c.cl_final = 1)
  ) as q
 order by cv_displayed
  ', 'meta', '20783', '2019-05-27 14:23:16.322778+03', 'select', 'po_session', NULL, 'Список дочерних классов')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;

