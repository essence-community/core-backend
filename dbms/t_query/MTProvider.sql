--liquibase formatted sql
--changeset artemov_i:MTProvider.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTProvider', '/*MTProvider*/

select t.ck_id,

       t.cv_name,

       t.ck_user,

       t.ct_change

  from s_mt.t_provider t

 where ( &FILTER )

 /*##filter.ck_id*/and t.ck_id = (cast(:json as jsonb)->''filter''->>''ck_id'')::varchar/*filter.ck_id##*/

 order by &SORT

  ', 'meta', '20783', '2019-05-23 11:53:26.817034+03', 'select', 'po_session', NULL, 'Необходимо актуализировать')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

