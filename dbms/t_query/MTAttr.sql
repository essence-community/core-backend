--liquibase formatted sql
--changeset artemov_i:MTAttr.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTAttr', '/*MTAttr*/
select t.* from (
  select a.ck_id,
        a.cv_description,
        a.ck_attr_type,
        a.ck_d_data_type,
        adt.cl_extra,
        CASE WHEN a.ck_d_data_type = ''enum'' THEN
          jsonb_build_object(''cv_data_type_extra'', 
          (select jsonb_agg(jsonb_build_object(''cv_data_type_extra_value'', value)) from jsonb_array_elements_text(a.cv_data_type_extra::JSONB))
            )
        ELSE
            jsonb_build_object(''cv_data_type_extra'', a.cv_data_type_extra)
        end as json,
        /* Поля аудита */
        a.ck_user,
        a.ct_change at time zone :sess_cv_timezone as ct_change
  from s_mt.t_attr a
  join s_mt.t_d_attr_data_type adt on a.ck_d_data_type = adt.ck_id
  where true
    /*##filter.ck_id*/and a.ck_id = :json::jsonb#>>''{filter,ck_id}''/*filter.ck_id##*/
 ) as t
where ( &FILTER )
order by &SORT, t.ck_id asc
  ', 'meta', '20783', '2019-05-24 12:00:00.314025+03', 'select', 'po_session', NULL, 'Список атрибутов')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

