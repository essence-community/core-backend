--liquibase formatted sql
--changeset artemov_i:GetCurrentDate.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('GetCurrentDate', '/*GetCurrentDate*/

select jsonb_build_object(''ct_date'', to_char((CURRENT_TIMESTAMP) at time zone ''+3:00'', ''DD.MM.YYYY'')) as json 

  ', 'meta', '20783', '2019-05-22 14:36:08.83687+03', 'select', 'po_session', NULL, 'Необходимо актуализировать')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

