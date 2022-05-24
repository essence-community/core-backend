--liquibase formatted sql
--changeset patcher-core:MetaClass_DB557A6113634FD2BC40D2A58EE1EB3F dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class(ck_id, cv_name, cv_description, cv_manual_documentation, cv_auto_documentation, cl_final, cl_dataset, ck_view, ck_user, ct_change) VALUES ('DB557A6113634FD2BC40D2A58EE1EB3F', 'Button Group', 'Контейнер кнопок', null, null, 1, 0, 'system', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-10-03T00:00:00.000+0000')  on conflict (ck_id) do update set cv_name = excluded.cv_name, cv_description = excluded.cv_description, cv_manual_documentation = excluded.cv_manual_documentation, cv_auto_documentation = excluded.cv_auto_documentation, cl_final = excluded.cl_final, cl_dataset = excluded.cl_dataset, ck_view = excluded.ck_view, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('061FCBDA3AEB49F397D36170131F36C6', 'DB557A6113634FD2BC40D2A58EE1EB3F', 'childs', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-10-03T00:00:00.000+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('0FB8DA8E42584B569EEB2C1A53D4F0C3', 'DB557A6113634FD2BC40D2A58EE1EB3F', 'contentview', null, 'hbox', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-10-04T00:00:00.000+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('CDF54BCD782344EFACB87D673A3E0747', 'DB557A6113634FD2BC40D2A58EE1EB3F', 'height', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-10-03T00:00:00.000+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('6AC299E9D222440A83B2E721571B9A77', 'DB557A6113634FD2BC40D2A58EE1EB3F', 'onlyicon', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-10-03T00:00:00.000+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('67C264C962FE49F1B38549FD07C15F1F', 'DB557A6113634FD2BC40D2A58EE1EB3F', 'type', null, 'BTN_GROUP', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-10-03T00:00:00.000+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('BD719FF0AD6B4E55871FADA4C2422E70', 'DB557A6113634FD2BC40D2A58EE1EB3F', 'width', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-10-03T00:00:00.000+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
select pkg_patcher.p_clear_attr('DB557A6113634FD2BC40D2A58EE1EB3F'::varchar, '["childs","contentview","height","onlyicon","type","width"]'::jsonb);