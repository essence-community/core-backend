--liquibase formatted sql
--changeset artemov_i:MTEnumAttr dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTEnumAttr', '/*MTEnumAttr*/
with temp_arr as (
  select '''' as ck_id from s_mt.t_attr where false
  /*##filter.cv_data_type_extra*/
  union all
  select
    case
      when value ? ''cv_data_type_extra_value'' then value->>''cv_data_type_extra_value''
      else value#>>''{}'' end as ck_id
    from
      jsonb_array_elements(:json::jsonb#>''{filter,cv_data_type_extra}'')
  /*filter.cv_data_type_extra##*/
  /*##filter.ck_attr*/
  union all
  select
    case
      when arr.value ? ''cv_data_type_extra_value'' then arr.value->>''cv_data_type_extra_value''
      else arr.value#>>''{}'' end as ck_id
  from s_mt.t_attr attr
  left join jsonb_array_elements(attr.cv_data_type_extra::jsonb) as arr
    on nullif(attr.cv_data_type_extra, '''') is not null
  where attr.ck_id = :json::jsonb#>>''{filter,ck_attr}''
  /*##filter.cv_data_type_extra*/and false/*filter.cv_data_type_extra##*/
  /*filter.ck_attr##*/
  /*##filter.ck_class_attr*/
  union all
  select
    case
      when arr.value ? ''cv_data_type_extra_value'' then arr.value->>''cv_data_type_extra_value''
      else arr.value#>>''{}'' end as ck_id
  from s_mt.t_class_attr ca
  join s_mt.t_attr attr
    on ca.ck_attr = attr.ck_id
  left join jsonb_array_elements((coalesce(nullif(ca.cv_data_type_extra, ''''), attr.cv_data_type_extra))::jsonb) as arr
    on nullif(ca.cv_data_type_extra, '''') is not null or nullif(attr.cv_data_type_extra, '''') is not null
  where ca.ck_id = :json::jsonb#>>''{filter,ck_class_attr}''
  /*##filter.cv_data_type_extra*/and false/*filter.cv_data_type_extra##*/
  /*filter.ck_class_attr##*/
)
select t.*
from temp_arr as t
where ( &FILTER )
 /*##filter.ck_id*/and t.ck_id = :json::jsonb#>>''{filter,ck_id}''/*filter.ck_id##*/
order by &SORT
  ', 'meta', '20783', '2019-05-24 12:00:00.314025+03', 'select', 'po_session', NULL, 'Список enum значений')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;

