--liquibase formatted sql
--changeset patcher-core:MetaClass_BA125F895507411E8730C07D3AD26A3A dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class(ck_id, cv_name, cv_description, cv_manual_documentation, cv_auto_documentation, cl_final, cl_dataset, ck_view, ck_user, ct_change) VALUES ('BA125F895507411E8730C07D3AD26A3A', 'Tool Bar Panel', 'Контейнер меню', null, null, 1, 0, 'system', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-10-03T00:00:00.000+0000')  on conflict (ck_id) do update set cv_name = excluded.cv_name, cv_description = excluded.cv_description, cv_manual_documentation = excluded.cv_manual_documentation, cv_auto_documentation = excluded.cv_auto_documentation, cl_final = excluded.cl_final, cl_dataset = excluded.cl_dataset, ck_view = excluded.ck_view, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('5701E05269AD4814AA89830500C9FB41', 'BA125F895507411E8730C07D3AD26A3A', 'align', null, 'left', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-13T00:00:00.000+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('0A71556DD08146C496C07ED8E2375751', 'BA125F895507411E8730C07D3AD26A3A', 'childs', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-10-03T00:00:00.000+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('76C3C787FB4340B68606E3BD6DEC6E64', 'BA125F895507411E8730C07D3AD26A3A', 'contentview', null, 'hbox', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-10-03T00:00:00.000+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('F735AFB542F74B408F52A184AA470E3E', 'BA125F895507411E8730C07D3AD26A3A', 'height', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-10-03T00:00:00.000+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('E103BDD26D2E46EDAD4EE0FBD0949464', 'BA125F895507411E8730C07D3AD26A3A', 'type', null, 'TOOL_BAR', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-10-04T00:00:00.000+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('5DD8186E3533490F8D377FFE1BD264AB', 'BA125F895507411E8730C07D3AD26A3A', 'width', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-10-03T00:00:00.000+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
select pkg_patcher.p_clear_attr('BA125F895507411E8730C07D3AD26A3A'::varchar, '["align","childs","contentview","height","type","width"]'::jsonb);