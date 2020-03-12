--liquibase formatted sql
--changeset artemov_i:MTQueryExtended.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTQueryExtended', '/*MTQueryExtended*/
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
/*##filter.ck_id*/and lower(t.ck_id) like ''%'' || lower(:json::json#>>''{filter,ck_id}'') || ''%''/*filter.ck_id##*/
and ( &FILTER )
order by &SORT, t.ck_id asc
 ', 'meta', '20783', '2019-05-29 12:52:37.25561+03', 'select', 'po_session', NULL, 'Список сервисов с расшириным поиском')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;
