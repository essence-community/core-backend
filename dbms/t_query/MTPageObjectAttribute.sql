--liquibase formatted sql
--changeset dudin_m:MTPageObjectAttribute.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTPageObjectAttribute', '/*MTPageObjectAttribute*/

select 

  t.ck_id,

  t.ck_attr,

  t.ck_object,

  t.ck_class_attr,

  t.cv_description,

  t.ck_d_data_type,

  t.cv_data_type_extra,

  t.cv_value_ca,

  t.cv_value_oa,

  pkg_json.f_decode_attr(t.cv_value, t.ck_d_data_type) as cv_value,

  /* Поля аудита */

  t.ck_user,

  t.ct_change at time zone :sess_cv_timezone as ct_change

from (

  /* Обертка, чтобы работала сортировка/фильтрация по колонкам */

  select 

    poa.ck_id,

    ca.ck_attr,

    o.ck_id as ck_object,

    ca.ck_id as ck_class_attr,

    a.cv_description,

    a.ck_d_data_type,

    coalesce(ca.cv_data_type_extra, a.cv_data_type_extra) as cv_data_type_extra,

    ca.cv_value as cv_value_ca,

    oa.cv_value as cv_value_oa,

    poa.cv_value,

    poa.ck_user,

    poa.ct_change

  from s_mt.t_page_object po

  join s_mt.t_object o on o.ck_id = po.ck_object

  join s_mt.t_class c on c.ck_id = o.ck_class

  join s_mt.t_class_attr ca on ca.ck_class = c.ck_id

  join s_mt.t_attr a on a.ck_id = ca.ck_attr

  left join s_mt.t_object_attr oa on oa.ck_class_attr = ca.ck_id

    and oa.ck_object = o.ck_id

  left join s_mt.t_page_object_attr poa on poa.ck_page_object = po.ck_id

    and poa.ck_class_attr = ca.ck_id

  where po.ck_id = (cast(:json as jsonb)->''master''->>''ck_id'')::varchar

   /* Скроем атрибуты, которые не должны здесь переопределяться */

   and a.ck_attr_type not in (''system'',''placement'')
   
   /* Фильтр по типу атрибута */

   /*##filter.ck_attr_type*/and (lower(a.ck_attr_type) = lower((cast(:json as jsonb)->''filter''->>''ck_attr_type'')::varchar) or lower((cast(:json as jsonb)->''filter''->>''ck_attr_type'')::varchar) = ''all'')/*filter.ck_attr_type##*/

)t

 where 1=1

   and ( &FILTER )

 order by &SORT, t.ck_attr', 'meta', '20783', '2019-05-22 19:37:54.552257+03', 'select', 'po_session', NULL, 'Необходимо актуализировать')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;

