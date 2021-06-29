--liquibase formatted sql
--changeset artemov_i:MTCopyObject.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTCopyObject', '/*MTCopyObject*/

select pkg_json_meta.f_copy_object(pv_user => :sess_ck_id,

                                         pv_session => :sess_session,

                                         pc_json => :json) as result

  ', 'meta', '20783', '2019-05-27 11:02:10.740711+03', 'dml', 'po_session', NULL, 'Необходимо актуализировать')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;

