--liquibase formatted sql
--changeset artemov_i:MTAddPageObject dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTAddPageObject', '/*MTAddPageObject*/
select pkg_json_meta.f_modify_page_all(pv_user => :sess_ck_id,
                                                 pv_session => :sess_session,
                                                 pc_json => :json) as result
 ', 'meta', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-06-03 11:18:09.874041+03', 'dml', 'po_session', NULL, 'Наполнение страницы')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;
