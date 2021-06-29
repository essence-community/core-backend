--liquibase formatted sql
--changeset artemov_i:GetMetamodelPage.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('GetMetamodelPage', '--GetMetamodelPage

select

  pkg_json.f_get_object(po.ck_id) as json

from s_mt.t_page_object po,

  s_mt.t_page_action pa,

  s_mt.tt_user_action ua

where po.ck_page = (cast(:json as jsonb)->''filter''->>''ck_page'')::varchar

and po.ck_parent is null

and pa.ck_page = po.ck_page

and pa.cr_type = ''view''

and ua.cn_action = pa.cn_action

and ua.ck_user = :sess_ck_id

order by po.cn_order

  ', 'meta', '10020788', '2019-05-22 16:37:50.515969+03', 'select', 'po_session', NULL, 'Необходимо актуализировать')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;

