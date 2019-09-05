--liquibase formatted sql
--changeset artemov_i:MTAttrType.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTAttrType', '/*MTAttrType*/

select 

  att.ck_id,

  att.cv_description,

  /* Поля аудита */

  att.ck_user,

  att.ct_change at time zone :sess_cv_timezone as ct_change

from s_mt.t_attr_type att

order by att.ck_id asc

  ', 'meta', '20783', '2019-05-24 12:06:22.563679+03', 'select', 'po_session', NULL, 'Необходимо актуализировать')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

