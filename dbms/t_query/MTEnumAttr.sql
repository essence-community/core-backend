--liquibase formatted sql
--changeset artemov_i:MTEnumAttr dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTEnumAttr', '/*MTEnumAttr*/
select t.*
from (
  select
    case
        when value ? ''cv_data_type_extra_value'' then value->>''cv_data_type_extra_value''
        else value::varchar end as ck_id
    from
        jsonb_array_elements((:json::jsonb#>>''{filter,cv_data_type_extra}'')::jsonb)
) as t
where ( &FILTER )
 /*##filter.ck_id*/and t.ck_id = :json::jsonb#>>''{filter,ck_id}''/*filter.ck_id##*/
order by &SORT
  ', 'meta', '20783', '2019-05-24 12:00:00.314025+03', 'select', 'po_session', NULL, 'Список enum значений')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

