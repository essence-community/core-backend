--liquibase formatted sql
--changeset patcher-core:MetaClass_15593D209A1D46FC873706F69EE71E7A dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class(ck_id, cv_name, cv_description, cv_manual_documentation, cv_auto_documentation, cl_final, cl_dataset, ck_view, ck_user, ct_change) VALUES ('15593D209A1D46FC873706F69EE71E7A', 'Field Color', 'Поле "Выбор цвета"', null, null, 0, 0, 'system', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-05-20T10:06:11.512+0000')  on conflict (ck_id) do update set cv_name = excluded.cv_name, cv_description = excluded.cv_description, cv_manual_documentation = excluded.cv_manual_documentation, cv_auto_documentation = excluded.cv_auto_documentation, cl_final = excluded.cl_final, cl_dataset = excluded.cl_dataset, ck_view = excluded.ck_view, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('B19D1605EB6F431DB7B7BEB6AF8033CF', '15593D209A1D46FC873706F69EE71E7A', 'column', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-05-20T10:06:49.770+0000', 0, 0)  on conflict (ck_id) do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('4D0D3A4AA56F4D2EBB52A45EDA1CE989', '15593D209A1D46FC873706F69EE71E7A', 'datatype', null, 'color', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-05-20T10:06:42.252+0000', 0, 0)  on conflict (ck_id) do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('FDD61DC9EDA648E0A4F9133D8B041350', '15593D209A1D46FC873706F69EE71E7A', 'defaultvalue', null, '#000000', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-05-20T10:18:10.282+0000', 0, 0)  on conflict (ck_id) do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('C264FBFC0CF14AAF965FD08F5B082CB2', '15593D209A1D46FC873706F69EE71E7A', 'defaultvaluelocalization', null, '#000000', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-10-28T12:24:03.549+0000', 0, 0)  on conflict (ck_id) do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('070DAB8D8726464E8D4D99BE03FA3F3E', '15593D209A1D46FC873706F69EE71E7A', 'defaultvaluerule', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-02-11T16:03:44.964+0000', 0, 0)  on conflict (ck_id) do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('C3640B48DAFD4F7894051683912D66D6', '15593D209A1D46FC873706F69EE71E7A', 'setglobal', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-05-20T10:07:29.046+0000', 0, 0)  on conflict (ck_id) do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('EC6790CF4A1444A9A9B29FF14EBAA88D', '15593D209A1D46FC873706F69EE71E7A', 'type', null, 'IFIELD', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-05-20T10:06:27.813+0000', 1, 0)  on conflict (ck_id) do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
select pkg_patcher.p_clear_attr('15593D209A1D46FC873706F69EE71E7A'::varchar, '["column","datatype","defaultvalue","defaultvaluelocalization","defaultvaluerule","setglobal","type"]'::jsonb);
