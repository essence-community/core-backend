--liquibase formatted sql
--changeset artemov_i:MTAttr.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTAttr', '/*MTAttr*/

select a.ck_id,

       a.ck_attr_type,

       a.cv_description,

       /* Поля аудита */

       a.ck_user,

       a.ct_change at time zone :sess_cv_timezone as ct_change

 from s_mt.t_attr a

where ( &FILTER )

 /*##filter.ck_id*/and a.ck_id = (cast(:json as jsonb)->''filter''->>''ck_id'')::varchar/*filter.ck_id##*/

order by &SORT, a.ck_id asc

  ', 'meta', '20783', '2019-05-24 12:00:00.314025+03', 'select', 'po_session', NULL, 'Необходимо актуализировать')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

