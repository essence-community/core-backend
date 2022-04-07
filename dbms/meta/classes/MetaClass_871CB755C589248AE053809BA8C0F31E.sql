--liquibase formatted sql
--changeset patcher-core:MetaClass_871CB755C589248AE053809BA8C0F31E dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class(ck_id, cv_name, cv_description, cv_manual_documentation, cv_auto_documentation, cl_final, cl_dataset, ck_view, ck_user, ct_change) VALUES ('871CB755C589248AE053809BA8C0F31E', 'Form Panel', 'Форма для работы с глобальными данными', null, null, 0, 0, 'system', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-01-17T00:00:00.000+0000')  on conflict (ck_id) do update set cv_name = excluded.cv_name, cv_description = excluded.cv_description, cv_manual_documentation = excluded.cv_manual_documentation, cv_auto_documentation = excluded.cv_auto_documentation, cl_final = excluded.cl_final, cl_dataset = excluded.cl_dataset, ck_view = excluded.ck_view, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('BAD0F50DA67C43B0BD0AF2064E5CB974', '871CB755C589248AE053809BA8C0F31E', 'align', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-10-28T00:00:00.000+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('876936326A5213F3E053809BA8C0487C', '871CB755C589248AE053809BA8C0F31E', 'childs', null, null, '20785', '2019-05-15T00:00:00.000+0000', 1, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('4054B98E02F342168872C8F83B86C7D4', '871CB755C589248AE053809BA8C0F31E', 'childwindow', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-12-08T10:32:37.989+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('68E51904C436427A9DC7A1A31352E5E8', '871CB755C589248AE053809BA8C0F31E', 'contentview', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-10-28T00:00:00.000+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('ADBCD7C88015483785EC78484A5AA12F', '871CB755C589248AE053809BA8C0F31E', 'editable', null, 'true', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-02-13T10:17:20.988+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('37B7C3DAAB5C46E8A6EAC66640084833', '871CB755C589248AE053809BA8C0F31E', 'editing', null, 'false', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-02-13T10:15:16.660+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('A6E3EE8335B94205AB413549E7A6226B', '871CB755C589248AE053809BA8C0F31E', 'editingrule', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-02-13T10:17:27.207+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('9BE3E1294D3A4F458D4D4CFEDB40E50E', '871CB755C589248AE053809BA8C0F31E', 'reloadmaster', null, 'false', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-04-07T13:17:32.779+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('871CB755C58A248AE053809BA8C0F31E', '871CB755C589248AE053809BA8C0F31E', 'setglobal', null, null, '20785', '2019-05-16T00:00:00.000+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('87BF581B392C242FE053809BA8C0461B', '871CB755C589248AE053809BA8C0F31E', 'type', null, 'FORMPANEL', '20785', '2019-05-15T00:00:00.000+0000', 1, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('876936326A5713F3E053809BA8C0487C', '871CB755C589248AE053809BA8C0F31E', 'updateglobal', null, null, '20785', '2019-05-16T00:00:00.000+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('902090BB29794B2CB869BEB12AA3E11C', '871CB755C589248AE053809BA8C0F31E', 'width', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-10-28T00:00:00.000+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
select pkg_patcher.p_clear_attr('871CB755C589248AE053809BA8C0F31E'::varchar, '["align","childs","childwindow","contentview","editable","editing","editingrule","reloadmaster","setglobal","type","updateglobal","width"]'::jsonb);
