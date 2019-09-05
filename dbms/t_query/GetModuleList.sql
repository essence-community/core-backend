--liquibase formatted sql
--changeset artemov_i:GetModuleList.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('GetModuleList', '--GetModuleList

select

  m.ck_id,

  m.ck_class,

  m.cv_name,

  m.ck_user,

  m.ct_change,

  m.cv_version,

  m.cl_available

from s_mt.t_module m

/*##filter.cl_available*/

where m.cl_available = (cast(:json as jsonb)->''filter''->>''cl_available'')::bigint /*filter.cl_available##*/

order by m.cv_name

  ', 'meta', '-11', '2019-05-21 16:55:33.287994+03', 'select', 'free', NULL, 'Необходимо актуализировать')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

