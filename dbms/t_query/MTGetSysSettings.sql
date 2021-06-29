--liquibase formatted sql
--changeset artemov_i:MTGetSysSettings.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTGetSysSettings', '--MTGetSysSettings

select s.ck_id,

       s.cv_value,

       s.cv_description

  from s_mt.t_sys_setting s

 where &FILTER

 /*##filter.ck_id*/and s.ck_id = (cast(:json as jsonb)->''filter''->>''ck_id'')::varchar/*filter.ck_id##*/

 order by &SORT, s.ck_id

  ', 'meta', '10020788', '2019-05-21 16:55:53.449266+03', 'select', 'free', NULL, 'Необходимо актуализировать')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;

