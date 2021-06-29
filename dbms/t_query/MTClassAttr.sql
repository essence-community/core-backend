--liquibase formatted sql
--changeset dudin_m:MTClassAttr.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTClassAttr', '/*MTClassAttr*/
select ca.ck_id,
       ca.ck_class,
       ca.ck_attr,
       pkg_json.f_decode_attr(ca.cv_value, a.ck_d_data_type) as cv_value,
       ca.cl_required,
       ca.cl_empty,
       a.cv_description,
       a.ck_attr_type,
       a.ck_d_data_type,
       adt.cl_extra,   
      CASE WHEN a.ck_d_data_type = ''enum'' THEN
       jsonb_build_object(''cv_data_type_extra'', 
       (select jsonb_agg(jsonb_build_object(''cv_data_type_extra_value'', value)) from jsonb_array_elements_text(coalesce(ca.cv_data_type_extra, a.cv_data_type_extra)::JSONB))
        )
      ELSE
          jsonb_build_object(''cv_data_type_extra'', coalesce(ca.cv_data_type_extra, a.cv_data_type_extra))
      end as json,
      /* Поля аудита */
      ca.ck_user,
      ca.ct_change at time zone :sess_cv_timezone as ct_change
 from s_mt.t_class_attr ca
 join s_mt.t_attr a on a.ck_id = ca.ck_attr
 join s_mt.t_d_attr_data_type adt on a.ck_d_data_type = adt.ck_id
where ca.ck_class = (cast(:json as jsonb)->''master''->>''ck_id'')::varchar
  and ( &FILTER )
  /*##filter.ck_id*/and ca.ck_id = (cast(:json as jsonb)->''filter''->>''ck_id'')::varchar/*filter.ck_id##*/
  /*##filter.ck_attr_type*/and (lower(a.ck_attr_type) = lower((cast(:json as jsonb)->''filter''->>''ck_attr_type'')::varchar) or lower((cast(:json as jsonb)->''filter''->>''ck_attr_type'')::varchar) = ''all'')/*filter.ck_attr_type##*/
order by &SORT, ca.ck_attr asc', 'meta', '20783', '2019-05-24 15:17:55.661504+03', 'select', 'po_session', NULL, 'Необходимо актуализировать')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;

