--liquibase formatted sql
--changeset patcher-core:MetaClass_4A7B7B56D5D544A7B81EB8D50EA8C8EC dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class(ck_id, cv_name, cv_description, cv_manual_documentation, cv_auto_documentation, cl_final, cl_dataset, ck_view, ck_user, ct_change) VALUES ('4A7B7B56D5D544A7B81EB8D50EA8C8EC', 'Panel Nested', 'Панель для подгрузки данных из другого источника в основную форму', null, null, 0, 1, 'system', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-10-16T13:40:27.641+0000')  on conflict (ck_id) do update set cv_name = excluded.cv_name, cv_description = excluded.cv_description, cv_manual_documentation = excluded.cv_manual_documentation, cv_auto_documentation = excluded.cv_auto_documentation, cl_final = excluded.cl_final, cl_dataset = excluded.cl_dataset, ck_view = excluded.ck_view, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('68841F8719504F359A29E18BD4942EA4', '4A7B7B56D5D544A7B81EB8D50EA8C8EC', 'align', null, 'left', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-08-27T09:45:07.631+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('055D11A2B5964C5B9E4F4FD728E85C72', '4A7B7B56D5D544A7B81EB8D50EA8C8EC', 'autoload', null, 'true', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-08-27T10:46:44.452+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('1FDEF8480E9141D995CDD42B7E209E2F', '4A7B7B56D5D544A7B81EB8D50EA8C8EC', 'autoloadrule', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-11-12T15:56:49.423+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('030C24F8A7DF46BD87C420B866989703', '4A7B7B56D5D544A7B81EB8D50EA8C8EC', 'childs', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-08-27T09:44:41.012+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('ED78C0EF93CF4118A3B99AB020F378B7', '4A7B7B56D5D544A7B81EB8D50EA8C8EC', 'column', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-08-27T09:45:51.142+0000', 1, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('1D0F8ECC8CB5458590B0CEED1B961895', '4A7B7B56D5D544A7B81EB8D50EA8C8EC', 'contentview', null, 'hbox', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-08-27T09:45:26.144+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('FB681F9925A14C8EBEA8B4FA13444849', '4A7B7B56D5D544A7B81EB8D50EA8C8EC', 'defaultvalue', null, '##first##', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-08-27T09:46:47.050+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('D3809167EAC64C51A3BCB2569F8FD578', '4A7B7B56D5D544A7B81EB8D50EA8C8EC', 'defaultvaluelocalization', null, '##first##', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-10-28T12:24:03.549+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('805395B555BD4B539B4829DFCBA3FEB2', '4A7B7B56D5D544A7B81EB8D50EA8C8EC', 'disabled', null, 'false', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-08-27T09:46:58.064+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('FE07219D9A7A42159350D03DBE6CCAF0', '4A7B7B56D5D544A7B81EB8D50EA8C8EC', 'disabledrules', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-08-27T09:47:17.149+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('F56519D3BE484F399916FF4335126ED3', '4A7B7B56D5D544A7B81EB8D50EA8C8EC', 'getglobal', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-08-27T09:51:36.563+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('12C25EF59E374AF985C2A0C5599552E9', '4A7B7B56D5D544A7B81EB8D50EA8C8EC', 'getglobaltostore', null, '[]', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-08-27T10:04:39.928+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('2E556EFB63F149B5B1A986DA1AD713C6', '4A7B7B56D5D544A7B81EB8D50EA8C8EC', 'getmastervalue', null, '[{"in": "ck_id", "out": "ck_id"}]', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-08-27T09:48:01.771+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('6B8202C074004333B89FBA01A16270A5', '4A7B7B56D5D544A7B81EB8D50EA8C8EC', 'hidden', null, 'false', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-08-27T09:47:24.610+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('6CC06B3C1F604FCE96B9B74479A30F10', '4A7B7B56D5D544A7B81EB8D50EA8C8EC', 'hiddenrules', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-08-27T09:47:31.349+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('54F8EA9D78484B688F991DA656D8CEE5', '4A7B7B56D5D544A7B81EB8D50EA8C8EC', 'idproperty', null, 'ck_id', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-08-27T09:47:43.022+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('0BA955FE0DD245448E0FDABF5FEBD752', '4A7B7B56D5D544A7B81EB8D50EA8C8EC', 'records', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-11-08T14:37:13.815+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('22369FF3AE5C43278CC011F4A8C5227E', '4A7B7B56D5D544A7B81EB8D50EA8C8EC', 'recordsrule', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-11-12T15:56:44.253+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('8ECDE4D43CD8417E91C6701FF328465C', '4A7B7B56D5D544A7B81EB8D50EA8C8EC', 'reqsel', null, 'false', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-08-27T09:48:51.492+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('93033F02916C4917A8A7531394E8EDF4', '4A7B7B56D5D544A7B81EB8D50EA8C8EC', 'setglobal', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-08-27T09:51:17.984+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('A4DCE2C6A19744BBA6C9534683C94B1F', '4A7B7B56D5D544A7B81EB8D50EA8C8EC', 'setrecordtoglobal', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-08-27T09:54:35.202+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('5132E680662C49F8BDD3606D4961CEC2', '4A7B7B56D5D544A7B81EB8D50EA8C8EC', 'timeout', null, '30', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-08-27T09:49:22.216+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('09F85D73915C4C07AD17B9A5889C3F7E', '4A7B7B56D5D544A7B81EB8D50EA8C8EC', 'type', null, 'FORM_NESTED', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-08-27T10:04:22.438+0000', 1, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
select pkg_patcher.p_clear_attr('4A7B7B56D5D544A7B81EB8D50EA8C8EC'::varchar, '["align","autoload","autoloadrule","childs","column","contentview","defaultvalue","defaultvaluelocalization","disabled","disabledrules","getglobal","getglobaltostore","getmastervalue","hidden","hiddenrules","idproperty","records","recordsrule","reqsel","setglobal","setrecordtoglobal","timeout","type"]'::jsonb);
