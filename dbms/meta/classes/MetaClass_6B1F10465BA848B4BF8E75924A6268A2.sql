--liquibase formatted sql
--changeset patcher-core:MetaClass_6B1F10465BA848B4BF8E75924A6268A2 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class(ck_id, cv_name, cv_description, cv_manual_documentation, cv_auto_documentation, cl_final, cl_dataset, ck_view, ck_user, ct_change) VALUES ('6B1F10465BA848B4BF8E75924A6268A2', 'Field Regexp Repl', 'Поле "Создание регулярного выражения"', null, null, 0, 0, 'system', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-24T13:11:51.869+0000')  on conflict (ck_id) do update set cv_name = excluded.cv_name, cv_description = excluded.cv_description, cv_manual_documentation = excluded.cv_manual_documentation, cv_auto_documentation = excluded.cv_auto_documentation, cl_final = excluded.cl_final, cl_dataset = excluded.cl_dataset, ck_view = excluded.ck_view, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('341D95BB5ABC42239DF41A28EF13854F', '6B1F10465BA848B4BF8E75924A6268A2', 'column', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-24T13:12:00.275+0000', 0, 0)  on conflict (ck_id) do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('CB5CDE38C0014FD2BC9DF386616A0EA6', '6B1F10465BA848B4BF8E75924A6268A2', 'datatype', null, 'regexprepl', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-24T13:12:25.018+0000', 1, 0)  on conflict (ck_id) do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('94E421DA73674EF8A54260E859593B4F', '6B1F10465BA848B4BF8E75924A6268A2', 'defaultvaluerule', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-02-11T16:03:44.964+0000', 0, 0)  on conflict (ck_id) do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('65610061494D419C995DA0A9B3F5F30D', '6B1F10465BA848B4BF8E75924A6268A2', 'disabled', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-24T13:12:39.507+0000', 0, 0)  on conflict (ck_id) do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('9354A00F11484F4EB1E2FC4A394DE6C9', '6B1F10465BA848B4BF8E75924A6268A2', 'disabledrules', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-24T13:12:43.559+0000', 0, 0)  on conflict (ck_id) do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('4FFF374EDEEA410E8CE45ABB5AD8FB9A', '6B1F10465BA848B4BF8E75924A6268A2', 'hidden', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-24T13:12:35.139+0000', 0, 0)  on conflict (ck_id) do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('800ECCABE0184238A67D0322A66CB6DB', '6B1F10465BA848B4BF8E75924A6268A2', 'hiddenrules', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-24T13:12:30.611+0000', 0, 0)  on conflict (ck_id) do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('5122A2C7B120408DB8B7526B7928C37C', '6B1F10465BA848B4BF8E75924A6268A2', 'type', null, 'IFIELD', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-24T13:12:13.751+0000', 1, 0)  on conflict (ck_id) do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
select pkg_patcher.p_clear_attr('6B1F10465BA848B4BF8E75924A6268A2'::varchar, '["column","datatype","defaultvaluerule","disabled","disabledrules","hidden","hiddenrules","type"]'::jsonb);
