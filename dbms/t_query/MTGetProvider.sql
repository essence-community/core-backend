--liquibase formatted sql
--changeset artemov_i:MTGetProvider.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTGetProvider', '/*MTGetProvider*/

select p.ck_id as key,

       p.cv_name as value,

       /* Поля аудита */

       p.ck_user,

       p.ct_change at time zone :sess_cv_timezone as ct_change

  from s_mt.t_provider p

 where p.ck_id not in (''auth'')

 order by p.cv_name asc

  ', 'meta', '20783', '2019-05-30 14:00:17.366935+03', 'select', 'po_session', NULL, 'Необходимо актуализировать')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;

