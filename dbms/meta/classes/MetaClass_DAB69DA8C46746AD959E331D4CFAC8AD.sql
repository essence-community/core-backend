--liquibase formatted sql
--changeset patcher-core:MetaClass_DAB69DA8C46746AD959E331D4CFAC8AD dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class(ck_id, cv_name, cv_description, cv_manual_documentation, cv_auto_documentation, cl_final, cl_dataset, ck_view, ck_user, ct_change) VALUES ('DAB69DA8C46746AD959E331D4CFAC8AD', 'Lang Combo', 'Выбор языка', null, null, 1, 1, 'system', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-01-17T00:00:00.000+0000')  on conflict (ck_id) do update set cv_name = excluded.cv_name, cv_description = excluded.cv_description, cv_manual_documentation = excluded.cv_manual_documentation, cv_auto_documentation = excluded.cv_auto_documentation, cl_final = excluded.cl_final, cl_dataset = excluded.cl_dataset, ck_view = excluded.ck_view, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('60D797B44AD74083A775895BBA5F62B4', 'DAB69DA8C46746AD959E331D4CFAC8AD', 'column', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-01-17T00:00:00.000+0000', 0, 0)  on conflict (ck_id) do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('830DF67A4924499EB814EB74A65118DC', 'DAB69DA8C46746AD959E331D4CFAC8AD', 'getmastervalue', null, '[{"in": "ck_id", "out": "ck_id"}]', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-01-17T00:00:00.000+0000', 0, 0)  on conflict (ck_id) do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('9C6D50A139124F6687485AA77C5550C3', 'DAB69DA8C46746AD959E331D4CFAC8AD', 'idproperty', null, 'ck_id', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-01-17T00:00:00.000+0000', 0, 0)  on conflict (ck_id) do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('4F5907A6B6C740ED890F38344958B1EB', 'DAB69DA8C46746AD959E331D4CFAC8AD', 'setrecordtoglobal', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-02-06T00:00:00.000+0000', 0, 0)  on conflict (ck_id) do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('BD32B0A2B8734A3FBA1C32F48F9E4279', 'DAB69DA8C46746AD959E331D4CFAC8AD', 'type', null, 'LANG_COMBO', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-01-17T00:00:00.000+0000', 1, 0)  on conflict (ck_id) do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
select pkg_patcher.p_clear_attr('DAB69DA8C46746AD959E331D4CFAC8AD'::varchar, '["column","getmastervalue","idproperty","setrecordtoglobal","type"]'::jsonb);
