--liquibase formatted sql
--changeset artemov_i:GetMsgList.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('GetMsgList', '--GetMsgList

select

  m.ck_id,

  m.cr_type,

  m.cv_text

from s_mt.t_message m

order by m.ck_id asc

  ', 'meta', '10020788', '2019-05-21 16:56:04.052926+03', 'select', 'free', NULL, 'Необходимо актуализировать')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

