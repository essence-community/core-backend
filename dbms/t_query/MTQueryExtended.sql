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
		string_agg(x.cv_path, ''<br/>'') as cv_used,
		/* Поля аудита */
		q.ck_user,
		q.ct_change at time zone :sess_cv_timezone as ct_change
	from
		s_mt.t_query q
	left join /* get pathes where queries are used */
		( with o_updatequery as (
		select
			toa.ck_object as ck_id,
			toa.cv_value
		from
			s_mt.t_object_attr as toa
		where
			toa.ck_class_attr in (
			select
				att.ck_id
			from
				s_mt.t_class_attr as att
			where
				att.ck_attr = ''updatequery'') ),
		o_defaultvaluequery as (
		select
			toa.ck_object as ck_id,
			toa.cv_value
		from
			s_mt.t_object_attr as toa
		where
			toa.ck_class_attr in (
			select
				att.ck_id
			from
				s_mt.t_class_attr as att
			where
				att.ck_attr = ''defaultvaluequery'') ),
		po_updatequery as (
		select
			tpoa.ck_page_object as ck_id,
			tpoa.cv_value
		from
			s_mt.t_page_object_attr as tpoa
		where
			tpoa.ck_class_attr in (
			select
				att.ck_id
			from
				s_mt.t_class_attr as att
			where
				att.ck_attr = ''updatequery'') ),
		po_defaultvaluequery as (
		select
			tpoa.ck_page_object as ck_id,
			tpoa.cv_value
		from
			s_mt.t_page_object_attr as tpoa
		where
			tpoa.ck_class_attr in (
			select
				att.ck_id
			from
				s_mt.t_class_attr as att
			where
				att.ck_attr = ''defaultvaluequery'') )
		select
			sub.*
		from
			(with recursive q_object as (/* all PO + Objects + attr */
			select
				po.ck_id,
				po.ck_parent,
				po.ck_page,
				o.ck_query,
				coalesce(to_pu.cv_value, to_u.cv_value) as cv_updatequery,
				coalesce(to_pdu.cv_value, to_du.cv_value) as cv_defaultvaluequery,
				o.cv_name,
				1 as lvl,
				(o.cv_name || '')::varchar as cv_path
			from
				s_mt.t_page_object po
			join s_mt.t_object o on
				po.ck_object = o.ck_id
			left join (
				select
					*
				from
					o_updatequery) as to_u on
				po.ck_object = to_u.ck_id
			left join (
				select
					*
				from
					o_defaultvaluequery) as to_du on
				po.ck_object = to_du.ck_id
			left join (
				select
					*
				from
					po_updatequery) as to_pu on
				po.ck_id = to_pu.ck_id
			left join (
				select
					*
				from
					po_defaultvaluequery) as to_pdu on
				po.ck_id = to_pdu.ck_id
			where
				po.ck_parent is null
		union all
			select
				po.ck_id,
				po.ck_parent,
				po.ck_page,
				o.ck_query,
				coalesce(to_pu.cv_value, to_u.cv_value) as cv_updatequery,
				coalesce(to_pdu.cv_value, to_du.cv_value) as cv_defaultvaluequery,
				o.cv_name,
				all_ob.lvl + 1 as lvl,
				(all_ob.cv_path || '' / '' || o.cv_name) as cv_path
			from
				q_object as all_ob
			join s_mt.t_page_object po on
				po.ck_parent = all_ob.ck_id
			join s_mt.t_object o on
				po.ck_object = o.ck_id
			left join (
				select
					*
				from
					o_updatequery) as to_u on
				po.ck_object = to_u.ck_id
			left join (
				select
					*
				from
					o_defaultvaluequery) as to_du on
				po.ck_object = to_du.ck_id
			left join (
				select
					*
				from
					po_updatequery) as to_pu on
				po.ck_id = to_pu.ck_id
			left join (
				select
					*
				from
					po_defaultvaluequery) as to_pdu on
				po.ck_id = to_pdu.ck_id )
			select
				all_po.ck_page,
				all_po.ck_query,
				all_po.cv_updatequery,
				all_po.cv_defaultvaluequery,
				all_po.cv_path
			from
				q_object all_po
			where
				all_po.ck_query is not null
				or all_po.cv_updatequery is not null
				or all_po.cv_defaultvaluequery is not null) as sub ) as x on
		x.ck_query = q.ck_id
		or x.cv_updatequery = q.ck_id
		or x.cv_defaultvaluequery = q.ck_id
	where true
	/*##filter.ck_page*/and x.ck_page is not null and x.ck_page = :json::json#>>''{filter,ck_page}''/*filter.ck_page##*/
	group by
		q.ck_id
) t
where 1 = 1
/*##filter.ck_id*/and lower(t.ck_id) like ''%'' || lower(:json::json#>>''{filter,ck_id}'') || ''%''/*filter.ck_id##*/
and ( &FILTER )
order by &SORT, t.ck_id asc
 ', 'meta', '20783', '2019-05-29 12:52:37.25561+03', 'select', 'po_session', NULL, 'Необходимо актуализировать')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;
