--liquibase formatted sql
--changeset patcher-core:MetaClass_FC278B804F4C4DE6A273C8C4D6F4037D dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class(ck_id, cv_name, cv_description, cv_manual_documentation, cv_auto_documentation, cl_final, cl_dataset, ck_view, ck_user, ct_change) VALUES ('FC278B804F4C4DE6A273C8C4D6F4037D', 'Documentation', 'Контейнер для отображения документации', null, null, 0, 1, 'system', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-11T12:27:56.854+0000')  on conflict (ck_id) do update set cv_name = excluded.cv_name, cv_description = excluded.cv_description, cv_manual_documentation = excluded.cv_manual_documentation, cv_auto_documentation = excluded.cv_auto_documentation, cl_final = excluded.cl_final, cl_dataset = excluded.cl_dataset, ck_view = excluded.ck_view, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('7465CE4D99124DB1A0E4C30B157A2BCE', 'FC278B804F4C4DE6A273C8C4D6F4037D', 'autoload', null, 'false', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-11T12:32:09.400+0000', 0, 0)  on conflict (ck_id) do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('A413DCE94BCA41FB9D4C0D746343BDFB', 'FC278B804F4C4DE6A273C8C4D6F4037D', 'defaultvalue', null, '##first##', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-11T12:35:41.261+0000', 0, 0)  on conflict (ck_id) do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('F2CAF0FCF4454FB78FD2EB5B4986E8C8', 'FC278B804F4C4DE6A273C8C4D6F4037D', 'defaultvaluelocalization', null, '##first##', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-10-28T12:24:03.549+0000', 0, 0)  on conflict (ck_id) do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('FF48C7C8E55445CCBA04789096613542', 'FC278B804F4C4DE6A273C8C4D6F4037D', 'disabled', null, 'false', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-15T20:03:41.394+0000', 0, 0)  on conflict (ck_id) do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('D3DCC88692E040EF9E6E2D4209B10F6D', 'FC278B804F4C4DE6A273C8C4D6F4037D', 'disabledrules', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-15T20:03:46.391+0000', 0, 0)  on conflict (ck_id) do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('D17CA871C27A45529DD32C695397B4A0', 'FC278B804F4C4DE6A273C8C4D6F4037D', 'hidden', null, 'false', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-15T20:03:35.711+0000', 0, 0)  on conflict (ck_id) do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('617F091F61914925BD8AD34942DA6DFE', 'FC278B804F4C4DE6A273C8C4D6F4037D', 'hiddenrules', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-15T20:00:30.463+0000', 0, 0)  on conflict (ck_id) do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('3229B730C39042BDB05BE67AE105CC9D', 'FC278B804F4C4DE6A273C8C4D6F4037D', 'type', null, 'DOCUMENTATION', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-11T11:56:14.191+0000', 0, 0)  on conflict (ck_id) do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
select pkg_patcher.p_clear_attr('FC278B804F4C4DE6A273C8C4D6F4037D'::varchar, '["autoload","defaultvalue","defaultvaluelocalization","disabled","disabledrules","hidden","hiddenrules","type"]'::jsonb);
