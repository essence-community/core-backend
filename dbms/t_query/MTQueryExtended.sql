--liquibase formatted sql
--changeset artemov_i:MTQueryExtended.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description, cc_query)
 VALUES('MTQueryExtended', 'meta', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2024-04-26T15:01:00.716+0300', 'select', 'po_session', null, 'Список сервисов с расшириным поиском',
 '/*MTQueryExtended*/
select
  t.*
from (
	select
		/* Информация о сервисах */
		q.ck_id,
		q.cr_type,
		q.cr_access,
		q.ck_provider,
		/* Поля аудита */
		q.ck_user,
		q.ct_change at time zone :sess_cv_timezone as ct_change
	from
		s_mt.t_query q
	where true
	/*##filter.ck_page*/and q.ck_id in (
        with class_attr as (
                select ck_id from s_mt.t_class_attr ca where ca.ck_attr in (''defaultvaluequery'',''redirectusequery'',''updatequery'')
            )
        select tq.ck_id
            from
                s_mt.t_query tq
            left join s_mt.t_object_attr o_attr on
                o_attr.ck_class_attr in (select ck_id from class_attr) and o_attr.cv_value = tq.ck_id
            left join s_mt.t_class_attr ca on
                ca.ck_id in (select ck_id from class_attr) and ca.cv_value = tq.ck_id
            left join s_mt.t_page_object_attr po_attr on
                po_attr.ck_class_attr in (select ck_id from class_attr) and po_attr.cv_value = tq.ck_id
            left join s_mt.t_page_object po on
                po.ck_id = po_attr.ck_page_object
            join s_mt.t_object o on
                tq.ck_id = o.ck_query
                or o_attr.ck_object = o.ck_id
                or po.ck_object = o.ck_id
                or ca.ck_class = o.ck_id
            join s_mt.t_page_object po2
               on po2.ck_object = o.ck_id
			where po2.ck_page = :json::json#>>''{filter,ck_page}''
			)/*filter.ck_page##*/
) t
where true
/*##filter.ck_id*/
and (
    (jsonb_typeof(:json::jsonb#>''{filter,ck_id}'') = ''string'' and t.ck_id ilike ''%'' || lower(:json::json#>>''{filter,ck_id}'') || ''%'') 
    or 
    (jsonb_typeof(:json::jsonb#>''{filter,ck_id}'') = ''array'' and 
        exists (select 1 from jsonb_array_elements_text(:json::jsonb#>''{filter,ck_id}'') as tt where t.ck_id ilike ''%'' || tt.value || ''%'')
    )
)
/*filter.ck_id##*/
and ( &FILTER )
order by &SORT, t.ck_id asc
 '
) on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;
