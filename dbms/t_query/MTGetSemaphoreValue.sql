--liquibase formatted sql
--changeset artemov_i:MTGetSemaphoreValue.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTGetSemaphoreValue', '/*MTGetSemaphoreValue*/

select s.cn_value

  from s_mt.t_semaphore s

 where s.ck_id = (cast(:json as jsonb)->''filter''->>''ck_id'')::varchar

  ', 'meta', '20783', '2019-05-30 14:00:17.372667+03', 'select', 'po_session', NULL, 'Необходимо актуализировать')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

