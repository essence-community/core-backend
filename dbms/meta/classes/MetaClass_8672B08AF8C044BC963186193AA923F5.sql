--liquibase formatted sql
--changeset patcher-core:MetaClass_8672B08AF8C044BC963186193AA923F5 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class(ck_id, cv_name, cv_description, cv_manual_documentation, cv_auto_documentation, cl_final, cl_dataset, ck_view, ck_user, ct_change) VALUES ('8672B08AF8C044BC963186193AA923F5', 'Module Federation Component', 'Загрузка внешних компонентов', null, null, 1, 0, 'system', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-09-30T06:35:55.897+0000')  on conflict (ck_id) do update set cv_name = excluded.cv_name, cv_description = excluded.cv_description, cv_manual_documentation = excluded.cv_manual_documentation, cv_auto_documentation = excluded.cv_auto_documentation, cl_final = excluded.cl_final, cl_dataset = excluded.cl_dataset, ck_view = excluded.ck_view, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('020498F1380F44CF9C834F80C28DAD9E', '8672B08AF8C044BC963186193AA923F5', 'childwindow', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-10-10T11:08:59.337+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('51AA82B266414A19967CFF10BC9EEB23', '8672B08AF8C044BC963186193AA923F5', 'disabled', null, 'false', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-09-29T14:53:24.756+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('C330CDC9E2BF4E6CBC9475A31A0B4352', '8672B08AF8C044BC963186193AA923F5', 'disabledrules', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-09-29T14:54:15.566+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('824A748729ED44068ECB8C4F06A9F141', '8672B08AF8C044BC963186193AA923F5', 'height', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-09-29T14:52:45.104+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('6508B20EBF074B29AB13FBD6449B62BB', '8672B08AF8C044BC963186193AA923F5', 'hidden', null, 'false', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-09-29T14:53:30.714+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('FFEAC8168586462CA88D1B12DC418141', '8672B08AF8C044BC963186193AA923F5', 'hiddenrules', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-09-29T14:54:08.839+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('15FC6BECCF1D4BC0AE0A1357E2721132', '8672B08AF8C044BC963186193AA923F5', 'maxheight', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-09-29T14:52:59.858+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('9E9AF02675B34375867396A01B004807', '8672B08AF8C044BC963186193AA923F5', 'maxwidth', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-09-30T06:15:14.641+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('EDA6C489CCD44B6AAD1C8F32EA406489', '8672B08AF8C044BC963186193AA923F5', 'mfcomponentconfig', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-09-30T06:12:59.880+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('2C606494ADB64FC683001A0CF952AD88', '8672B08AF8C044BC963186193AA923F5', 'mfcomponentconfigrule', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-09-30T06:14:29.002+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('DD629043C6C84441B221B0D851373863', '8672B08AF8C044BC963186193AA923F5', 'mfconfig', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-09-30T06:12:51.456+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('6ED868D5A8C54980906EB2F5C7D7F8DC', '8672B08AF8C044BC963186193AA923F5', 'mfconfigfail', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2023-02-10T10:10:51.806+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('69B1CD991EB84325B1A73DB356903F5B', '8672B08AF8C044BC963186193AA923F5', 'mfconfigrule', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2023-02-10T10:52:10.234+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('D5C6D30931DC4D15AFE6D5F6DC9144DF', '8672B08AF8C044BC963186193AA923F5', 'mfeventconfig', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-10-10T10:18:58.129+0000', 0, 1)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('4BC440747C194C39A3E7E0992D1B13AD', '8672B08AF8C044BC963186193AA923F5', 'minheight', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-09-29T14:53:05.480+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('33195571E852487CB7F6BBEE99E55231', '8672B08AF8C044BC963186193AA923F5', 'minwidth', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-09-30T06:15:22.577+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('A1492D44BE074B4B919B9A86611D135A', '8672B08AF8C044BC963186193AA923F5', 'readonly', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-09-30T06:14:48.649+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('75BC7B166B6A485FAF8F218FF6936490', '8672B08AF8C044BC963186193AA923F5', 'readonlyrules', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-09-29T14:54:00.596+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('4107C89E04BC407F8316E3A471EFB755', '8672B08AF8C044BC963186193AA923F5', 'type', null, 'MODULE_FEDERATION', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-09-29T14:52:35.851+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('8D84601675CE4FEB9408117ED9A6EBFF', '8672B08AF8C044BC963186193AA923F5', 'width', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-09-29T14:52:53.245+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
select pkg_patcher.p_clear_attr('8672B08AF8C044BC963186193AA923F5'::varchar, '["childwindow","disabled","disabledrules","height","hidden","hiddenrules","maxheight","maxwidth","mfcomponentconfig","mfcomponentconfigrule","mfconfig","mfconfigfail","mfconfigrule","mfeventconfig","minheight","minwidth","readonly","readonlyrules","type","width"]'::jsonb);
