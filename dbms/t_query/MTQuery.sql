--liquibase formatted sql
--changeset artemov_i:MTQuery.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTQuery', '/*MTQuery*/

select

  q.ck_id,

  q.ck_provider,

  q.cr_type,

  q.cr_access,

  /* Поля аудита */

  q.ck_user,

  q.ct_change at time zone :sess_cv_timezone as ct_change

from s_mt.t_query q

order by q.ck_id asc

  ', 'meta', '20783', '2019-05-23 11:55:04.721523+03', 'select', 'po_session', NULL, 'Необходимо актуализировать')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

