--liquibase formatted sql
--changeset patcher-core:MetaClass_8C96F9B255F5407FBCB8DE9189B15F39 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class(ck_id, cv_name, cv_description, cv_manual_documentation, cv_auto_documentation, cl_final, cl_dataset, ck_view, ck_user, ct_change) VALUES ('8C96F9B255F5407FBCB8DE9189B15F39', 'Button Dynamic', 'Динамическая кнопка', null, null, 0, 1, 'system', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T11:43:58.597+0000')  on conflict (ck_id) do update set cv_name = excluded.cv_name, cv_description = excluded.cv_description, cv_manual_documentation = excluded.cv_manual_documentation, cv_auto_documentation = excluded.cv_auto_documentation, cl_final = excluded.cl_final, cl_dataset = excluded.cl_dataset, ck_view = excluded.ck_view, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('E8068A0263684F33AF9EE1B60EE36AC8', '8C96F9B255F5407FBCB8DE9189B15F39', 'actiongate', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2023-06-30T15:21:46.067+0000', 0, 1)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('A9EAAAEBAD504ACBB9BC14D3B564ED8F', '8C96F9B255F5407FBCB8DE9189B15F39', 'activerules', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2023-11-03T07:23:41.899+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('8ACC0066FCB24A8BAF8466FA317166FF', '8C96F9B255F5407FBCB8DE9189B15F39', 'align', '["left", "right", "center", "stretch", "left-stretch", "right-stretch", "center-center","menu"]', 'left', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T11:56:32.294+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('732B595BF030403B84A54742CDE7C12B', '8C96F9B255F5407FBCB8DE9189B15F39', 'autoload', null, 'true', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T12:50:30.100+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('ACA6F9F579F544F992BC275D8E0C0148', '8C96F9B255F5407FBCB8DE9189B15F39', 'autoloadrule', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-11-12T15:58:32.005+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('AE17A3166D6F436E9F15FA0277E5683D', '8C96F9B255F5407FBCB8DE9189B15F39', 'autoreloadrule', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2024-06-11T14:26:04.745+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('29297B17BFFF47CFA43BD466283F11E7', '8C96F9B255F5407FBCB8DE9189B15F39', 'childs', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2023-11-23T12:46:47.090+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('A2568EEB60A442A8B8F4DF90DF547BC7', '8C96F9B255F5407FBCB8DE9189B15F39', 'childwindow', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-12-08T10:31:38.916+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('766F06F805C6424293BCB6C08036A1E8', '8C96F9B255F5407FBCB8DE9189B15F39', 'ckwindow', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T11:56:06.472+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('0F3D161769864123BF7FFC7EC4EA178E', '8C96F9B255F5407FBCB8DE9189B15F39', 'closereload', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2024-06-06T10:15:34.757+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('45E3B1687F4340A782610E3DF9BEFAE7', '8C96F9B255F5407FBCB8DE9189B15F39', 'columnsfilter', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T11:56:06.472+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('CDC822F107CF4914855829A72B1A4058', '8C96F9B255F5407FBCB8DE9189B15F39', 'confirmquestion', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T11:56:06.472+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('39E2A7046592452CBBCBD2537AFB6F27', '8C96F9B255F5407FBCB8DE9189B15F39', 'contentview', '["hbox", "hbox-wrap", "vbox", "vbox-wrap", "menu"]', 'hbox', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T11:57:45.400+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('BD3C9E122DBF40D68563B64CE8C32FD8', '8C96F9B255F5407FBCB8DE9189B15F39', 'disabled', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T11:56:06.472+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('A5E33CFF0144469AA839079C6C98FC44', '8C96F9B255F5407FBCB8DE9189B15F39', 'disabledemptymaster', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T11:56:06.472+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('7D0C99EFFD1F4B25ACBE2E6EAA52EF8D', '8C96F9B255F5407FBCB8DE9189B15F39', 'disabledrules', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T11:56:06.472+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('187183C09CA44931B97B08EF68CDF674', '8C96F9B255F5407FBCB8DE9189B15F39', 'extraplugingate', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T11:56:06.472+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('9B7359CB1ED242BF84F7162DE5F3356E', '8C96F9B255F5407FBCB8DE9189B15F39', 'filemode', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T11:56:06.472+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('893E1D8B8AB44EDA945176027156D0D2', '8C96F9B255F5407FBCB8DE9189B15F39', 'filetypes', null, 'doc,docx,pdf,zip,txt,ods,odt,xls,xlsx', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T11:56:06.472+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('4C8990CEDB7C4CC6829FA2A1A5CD6211', '8C96F9B255F5407FBCB8DE9189B15F39', 'getglobaltostore', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T11:56:06.472+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('B36DB1988AF9457A932DB48F13FC6A14', '8C96F9B255F5407FBCB8DE9189B15F39', 'getmastervalue', null, '[{"in": "ck_id", "out": "ck_id"}]', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T11:56:06.472+0000', 1, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('A5264B1757064CB48236C8285B13DD13', '8C96F9B255F5407FBCB8DE9189B15F39', 'handler', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T11:56:06.472+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('12D5818D31EB4ACB823CB23F7EDA9715', '8C96F9B255F5407FBCB8DE9189B15F39', 'height', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T11:58:43.522+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('C863F2EDE39B4191BC045AFE571C721C', '8C96F9B255F5407FBCB8DE9189B15F39', 'hidden', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T11:56:06.472+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('AE5DCB42F5E049C6A21BF30E139A39C5', '8C96F9B255F5407FBCB8DE9189B15F39', 'hiddenrules', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T11:56:06.472+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('565968E278E346729FEBF5CE471F01AF', '8C96F9B255F5407FBCB8DE9189B15F39', 'iconfont', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T11:56:06.472+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('8A7329766AF0481EAC2E7E23D4DFDEFF', '8C96F9B255F5407FBCB8DE9189B15F39', 'iconfontname', null, 'fa', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T11:56:06.472+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('F9CC9D0BBB844593B2C3A2F3A0F3FAAB', '8C96F9B255F5407FBCB8DE9189B15F39', 'idproperty', null, 'ck_id', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T12:53:37.342+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('CAE546C84FC84AD1B128A4DDB4BE31E0', '8C96F9B255F5407FBCB8DE9189B15F39', 'maxfile', null, '5242880', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T11:56:06.472+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('E30530E8690641408E024CAC162C89DF', '8C96F9B255F5407FBCB8DE9189B15F39', 'maxsize', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T11:58:25.293+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('74279EEDD6A9484EBE63DBB05E45D580', '8C96F9B255F5407FBCB8DE9189B15F39', 'mode', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T11:56:06.472+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('E0FEB225E00B4537AD1787504906D144', '8C96F9B255F5407FBCB8DE9189B15F39', 'modeaction', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T11:56:06.472+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('945C06242519411EB7355580972FCEEA', '8C96F9B255F5407FBCB8DE9189B15F39', 'onlyicon', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T11:56:06.472+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('1C91A27BE72F49E2BE6F2E1E656809A9', '8C96F9B255F5407FBCB8DE9189B15F39', 'position', '["theme", "window", "right", "left"]', 'theme', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2023-08-17T11:08:47.856+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('7DE30A8B6FBE49658C1F9D72526584F1', '8C96F9B255F5407FBCB8DE9189B15F39', 'readonly', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-30T16:37:08.547+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('71A72239C9D54964A98D712DEB246DF4', '8C96F9B255F5407FBCB8DE9189B15F39', 'readonlyrules', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-30T16:37:23.903+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('2D96892FFDCF4D0F9BC2B4A85DCB27DC', '8C96F9B255F5407FBCB8DE9189B15F39', 'records', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-11-08T14:36:09.454+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('5D907E043C594227AEB798202E6A7C82', '8C96F9B255F5407FBCB8DE9189B15F39', 'recordsrule', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-11-12T15:58:26.308+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('D87F1AFF448E45489470EEE35C703B46', '8C96F9B255F5407FBCB8DE9189B15F39', 'redirecturl', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T11:56:06.472+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('05071B8135B642469471FAA514CB1442', '8C96F9B255F5407FBCB8DE9189B15F39', 'redirectusequery', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T11:56:06.472+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('86C2FF1DFF3648E5820F6EA463797243', '8C96F9B255F5407FBCB8DE9189B15F39', 'reloadmaster', null, 'false', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-04-07T13:19:50.476+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('82B0B9B421254E8C89CCB26AAC2A992C', '8C96F9B255F5407FBCB8DE9189B15F39', 'reqsel', null, 'false', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T11:56:06.472+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('59A776D086F4489EBEFF4C2C2F03F3D5', '8C96F9B255F5407FBCB8DE9189B15F39', 'saverecordstoglobal', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2023-03-26T09:18:18.415+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('6D0D9BE61D4444F28FD59DF701180D99', '8C96F9B255F5407FBCB8DE9189B15F39', 'setglobal', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T14:39:32.140+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('C453CBA4DF1247AC998C0DC0FEE8C315', '8C96F9B255F5407FBCB8DE9189B15F39', 'skipvalidation', null, 'false', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T11:56:06.472+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('902C5ED8E4FD4EE38D255EA5AB28226C', '8C96F9B255F5407FBCB8DE9189B15F39', 'timeout', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T11:56:06.472+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('83C91DF7829C44868981CB2585CF2986', '8C96F9B255F5407FBCB8DE9189B15F39', 'tipmsg', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T11:56:06.472+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('7BFE9BC688074907931E93D981649AB6', '8C96F9B255F5407FBCB8DE9189B15F39', 'type', null, 'BTN_DYNAMIC', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T11:58:11.878+0000', 1, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('30F3AC6ACB0D46C0A61AF247EDE43180', '8C96F9B255F5407FBCB8DE9189B15F39', 'uitype', null, '1', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T14:30:13.288+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('33B9554FB4A743D781CD4E46703515B2', '8C96F9B255F5407FBCB8DE9189B15F39', 'updatequery', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T11:56:06.472+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('4D1F961779D4471D816CD1A8F5874DEE', '8C96F9B255F5407FBCB8DE9189B15F39', 'valuefield', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T12:17:29.734+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('2E14D70D4CC84528ABBE38718DA788E8', '8C96F9B255F5407FBCB8DE9189B15F39', 'width', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T11:58:48.656+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
select pkg_patcher.p_clear_attr('8C96F9B255F5407FBCB8DE9189B15F39'::varchar, '["actiongate","activerules","align","autoload","autoloadrule","autoreloadrule","childs","childwindow","ckwindow","closereload","columnsfilter","confirmquestion","contentview","disabled","disabledemptymaster","disabledrules","extraplugingate","filemode","filetypes","getglobaltostore","getmastervalue","handler","height","hidden","hiddenrules","iconfont","iconfontname","idproperty","maxfile","maxsize","mode","modeaction","onlyicon","position","readonly","readonlyrules","records","recordsrule","redirecturl","redirectusequery","reloadmaster","reqsel","saverecordstoglobal","setglobal","skipvalidation","timeout","tipmsg","type","uitype","updatequery","valuefield","width"]'::jsonb);
