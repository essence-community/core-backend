--liquibase formatted sql
--changeset patcher-core:MetaClass_92D23B81FAEA445DAB66C6651F1F0479 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class(ck_id, cv_name, cv_description, cv_manual_documentation, cv_auto_documentation, cl_final, cl_dataset, ck_view, ck_user, ct_change) VALUES ('92D23B81FAEA445DAB66C6651F1F0479', 'Layout Panel', 'Панель свободной сетки', null, null, 1, 0, 'system', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-10-24T11:34:08.274+0000')  on conflict (ck_id) do update set cv_name = excluded.cv_name, cv_description = excluded.cv_description, cv_manual_documentation = excluded.cv_manual_documentation, cv_auto_documentation = excluded.cv_auto_documentation, cl_final = excluded.cl_final, cl_dataset = excluded.cl_dataset, ck_view = excluded.ck_view, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('5A77102C08BB468EA5E45DCF6036C048', '92D23B81FAEA445DAB66C6651F1F0479', 'childs', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-10-24T11:36:42.546+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('15934E8DAF6B47FCBF716AE720E15DC1', '92D23B81FAEA445DAB66C6651F1F0479', 'disabled', null, 'false', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-10-24T11:35:21.620+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('E72122920D7142F1A2C1D76BB4E115D9', '92D23B81FAEA445DAB66C6651F1F0479', 'disabledrules', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-10-24T11:35:37.625+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('553BB1BE31614F7B86B92AEFE9886308', '92D23B81FAEA445DAB66C6651F1F0479', 'hidden', null, 'false', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-10-24T11:35:13.225+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('2B2ADD44B53A45A7864641E2D5957096', '92D23B81FAEA445DAB66C6651F1F0479', 'hiddenrules', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-10-24T11:35:30.626+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('9A10B1FBF4AB4B6CBF1AA30C21A73696', '92D23B81FAEA445DAB66C6651F1F0479', 'isstate', null, 'false', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-10-26T09:08:23.753+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('20F7760404434A8FBD97A32DD248BB5A', '92D23B81FAEA445DAB66C6651F1F0479', 'layoutpanelconfig', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-10-24T11:40:47.016+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('4726CD2173F44A408A0EBF378C5EA31B', '92D23B81FAEA445DAB66C6651F1F0479', 'maxheight', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-10-24T11:35:56.102+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('ED9672B1622046889EC4FA73329AD4DE', '92D23B81FAEA445DAB66C6651F1F0479', 'maxwidth', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-10-24T11:36:19.044+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('F1C5A8BAB5F246E1A0572C20B4E456AF', '92D23B81FAEA445DAB66C6651F1F0479', 'minheight', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-10-24T11:36:31.952+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('11C5DC3427F84CB08222C4AB08D4C0B5', '92D23B81FAEA445DAB66C6651F1F0479', 'minwidth', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-10-24T11:36:05.105+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('98E903204D42491EBA3629C3B029278E', '92D23B81FAEA445DAB66C6651F1F0479', 'reqsel', null, 'false', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-10-24T11:35:44.579+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('A88EEC4E879E4843849F268659A7B0F0', '92D23B81FAEA445DAB66C6651F1F0479', 'type', null, 'LAYOUT_GRID_PANEL', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-10-24T11:34:55.976+0000', 1, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('3AFED62979C04BAC9888484492324DCC', '92D23B81FAEA445DAB66C6651F1F0479', 'width', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-10-24T11:36:12.145+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
select pkg_patcher.p_clear_attr('92D23B81FAEA445DAB66C6651F1F0479'::varchar, '["childs","disabled","disabledrules","hidden","hiddenrules","isstate","layoutpanelconfig","maxheight","maxwidth","minheight","minwidth","reqsel","type","width"]'::jsonb);