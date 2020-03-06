--liquibase formatted sql
--changeset artemov_i:GetModuleClassList dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('GetModuleClassList', '--GetModuleClassList
select
  c.ck_id,
  c.cv_name,
  c.ck_user,
  c.ct_change at time zone :sess_cv_timezone as ct_change,
  string_agg(opb.cv_name, '', '' ORDER BY opb.cv_name ASC) as cv_class_objects
from s_mt.t_module m
join s_mt.t_module_class mc
on m.ck_id = mc.ck_module
join s_mt.t_class c
on c.ck_id = mc.ck_class
left join s_mt.t_object ob
on ob.ck_class = mc.ck_class
left join s_mt.t_object opb
on ob.ck_parent = opb.ck_id
where &FILTER 
/*##master.ck_id*/ and m.ck_id = (cast(:json as jsonb)->''master''->>''ck_id'')/*master.ck_id##*/
/*##filter.ck_id*/ and m.ck_id = (cast(:json as jsonb)->''filter''->>''ck_id'')/*filter.ck_id##*/
group by c.ck_id,
  c.cv_name,
  c.ck_user,
  c.ct_change
order by &SORT
  ', 'meta', '-11', '2019-05-21 16:55:33.287994+03', 'select', 'po_session', NULL, 'Необходимо актуализировать')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

