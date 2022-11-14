--liquibase formatted sql
--changeset patcher-core:MetaClass_5833D73B31E04F8ABE9D307DBCE845A9 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class(ck_id, cv_name, cv_description, cv_manual_documentation, cv_auto_documentation, cl_final, cl_dataset, ck_view, ck_user, ct_change) VALUES ('5833D73B31E04F8ABE9D307DBCE845A9', 'Service Hidden', 'Компонент для скрытой загрузки сервисов', null, null, 1, 1, 'system', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-03-17T00:00:00.000+0000')  on conflict (ck_id) do update set cv_name = excluded.cv_name, cv_description = excluded.cv_description, cv_manual_documentation = excluded.cv_manual_documentation, cv_auto_documentation = excluded.cv_auto_documentation, cl_final = excluded.cl_final, cl_dataset = excluded.cl_dataset, ck_view = excluded.ck_view, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('4172E26A7C04438FB1A4FAE1E9EB5A58', '5833D73B31E04F8ABE9D307DBCE845A9', 'autoload', null, 'true', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-03-17T00:00:00.000+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('8DB8048329E3481BB7E28AC6CD39C13B', '5833D73B31E04F8ABE9D307DBCE845A9', 'autoloadrule', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-11-12T15:57:21.946+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('878651A7AC724A139CC7CAC04D0A62A9', '5833D73B31E04F8ABE9D307DBCE845A9', 'column', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T12:43:04.674+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('C51329078F364617A56C464D245C9D88', '5833D73B31E04F8ABE9D307DBCE845A9', 'defaultvalue', null, '##alwaysfirst##', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-04-17T13:47:42.564+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('33FC3B5A375546E9ABDAC117164FD086', '5833D73B31E04F8ABE9D307DBCE845A9', 'defaultvaluelocalization', null, '##alwaysfirst##', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-10-28T12:24:03.549+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('D7EF6E06EC3246F38D346524F7449356', '5833D73B31E04F8ABE9D307DBCE845A9', 'disabled', null, 'false', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T12:44:49.993+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('D5A5946AB99645B2AF2C677F4099FE3C', '5833D73B31E04F8ABE9D307DBCE845A9', 'disabledrules', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T12:44:58.459+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('1B6FEEA45C944E96BEB63B4F3A733BE1', '5833D73B31E04F8ABE9D307DBCE845A9', 'getglobaltostore', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-04-17T14:05:14.451+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('19E44B6F1A93432BA6FD76739E3D2F19', '5833D73B31E04F8ABE9D307DBCE845A9', 'getmastervalue', null, '[{"in": "ck_id", "out": "ck_id"}]', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-04-17T14:18:53.798+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('35DCCCAADBED40548A8404644FEECD3E', '5833D73B31E04F8ABE9D307DBCE845A9', 'hidden', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-04-17T13:48:12.596+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('95E786EFCC844CCB82562914D8191D25', '5833D73B31E04F8ABE9D307DBCE845A9', 'hiddenrules', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-04-17T13:48:29.673+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('BF984A63F86C435BA0105254CED9CB10', '5833D73B31E04F8ABE9D307DBCE845A9', 'idproperty', null, 'ck_id', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-04-17T13:50:28.202+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('7CCA642D9FC342688F74FCD5BA05B618', '5833D73B31E04F8ABE9D307DBCE845A9', 'noglobalmask', null, 'true', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-03-17T00:00:00.000+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('4AEC70A0D12E482CAD770D943783B1FD', '5833D73B31E04F8ABE9D307DBCE845A9', 'records', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-11-08T14:36:42.823+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('9B7043ED962543EAA2501CEFA0082C12', '5833D73B31E04F8ABE9D307DBCE845A9', 'recordsrule', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-11-12T15:57:16.506+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('372F665CB45B4D789D7D76A4E2571B5E', '5833D73B31E04F8ABE9D307DBCE845A9', 'reqsel', null, 'true', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-04-17T14:23:20.827+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('5AF22290B4B3473BBDE8A3888725FA50', '5833D73B31E04F8ABE9D307DBCE845A9', 'setglobal', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-03-17T00:00:00.000+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('6918753686C745F781F3942C51F9CFF8', '5833D73B31E04F8ABE9D307DBCE845A9', 'type', null, 'SERVICE_HIDDEN', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-03-17T00:00:00.000+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('3F6E60EBFEA34976A37D129A34DD8D8E', '5833D73B31E04F8ABE9D307DBCE845A9', 'valuefield', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-11-18T12:43:36.869+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
select pkg_patcher.p_clear_attr('5833D73B31E04F8ABE9D307DBCE845A9'::varchar, '["autoload","autoloadrule","column","defaultvalue","defaultvaluelocalization","disabled","disabledrules","getglobaltostore","getmastervalue","hidden","hiddenrules","idproperty","noglobalmask","records","recordsrule","reqsel","setglobal","type","valuefield"]'::jsonb);
