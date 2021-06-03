--liquibase formatted sql
--changeset artemov_i:ATGetJSONScenario.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('ATGetJSONScenario', '--ATGetJSONScenario

select

  jsonb_build_object(

    ''ck_page_object'', a.cv_key,

    ''ck_d_action'', a.ck_d_action,

    ''cv_value'', a.cv_value,

    ''cl_expected'', a.cl_expected

  ) as json

from s_mt.t_action a

join s_mt.t_step st on st.ck_id = a.ck_step

join s_mt.t_scenario sc on sc.ck_id = st.ck_scenario

where sc.cn_order = (cast(:json as jsonb)->>''cn_order_scenario'')::bigint

order by st.cn_order, a.cn_order

  ', 'meta', '10020788', '2019-05-21 16:56:35.930509+03', 'select', 'session', NULL, 'Необходимо актуализировать')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;

