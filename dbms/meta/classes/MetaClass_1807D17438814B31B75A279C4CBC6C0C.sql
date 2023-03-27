--liquibase formatted sql
--changeset patcher-core:MetaClass_1807D17438814B31B75A279C4CBC6C0C dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class(ck_id, cv_name, cv_description, cv_manual_documentation, cv_auto_documentation, cl_final, cl_dataset, ck_view, ck_user, ct_change) VALUES ('1807D17438814B31B75A279C4CBC6C0C', 'App Bar Panel', 'Навигационая панель страницы', '## Описание

1. Отрисовка панели вверху
1. Может содержат [кнопки](core-classes-button)
1. Пример на [pages](redirect/pages/2)', '

## StylesEssenceAppBar

name: **EssenceAppBar**

## root

Общий root для MaterialAppBar

## AppBar

-   **See: [AppBar][1]
    **

Отображения навигационной панели

Type: React.FC&lt;IClassProps&lt;IBuilderClassConfig>>

### Parameters

-   `props`  

**Meta**

-   **since**: 2.5

[1]: https://material-ui.com/components/app-bar/#app-bar
', 1, 0, 'system', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-10-04T00:00:00.000+0000')  on conflict (ck_id) do update set cv_name = excluded.cv_name, cv_description = excluded.cv_description, cv_manual_documentation = excluded.cv_manual_documentation, cv_auto_documentation = excluded.cv_auto_documentation, cl_final = excluded.cl_final, cl_dataset = excluded.cl_dataset, ck_view = excluded.ck_view, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('3976BAC6CA2843F3B623A63AD9E8A3B7', '1807D17438814B31B75A279C4CBC6C0C', 'align', '["left", "right", "center", "stretch", "left-stretch", "right-stretch", "center-center"]', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2023-03-27T13:22:43.951+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('225864898ED0411FA0E5434CD3A85346', '1807D17438814B31B75A279C4CBC6C0C', 'childs', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-10-04T00:00:00.000+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('391E6C0F46674C26AB8CCE82F583C74E', '1807D17438814B31B75A279C4CBC6C0C', 'contentview', null, 'hbox', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-10-04T00:00:00.000+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('84C6F98E09C0434AA2CE5D1BEFC4D605', '1807D17438814B31B75A279C4CBC6C0C', 'disabled', null, 'false', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2023-02-01T09:19:06.554+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('860A7205D67542ACA0813FC54632E026', '1807D17438814B31B75A279C4CBC6C0C', 'disabledrules', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2023-02-01T09:19:14.654+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('5F01393A5D014FF3A017C1D3F840D8E2', '1807D17438814B31B75A279C4CBC6C0C', 'height', null, '34px', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-10-04T00:00:00.000+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('80DD8665006D47B2AE0DB9653B7CAA5E', '1807D17438814B31B75A279C4CBC6C0C', 'hidden', null, 'false', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2023-02-01T09:18:40.959+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('7ABF87ED79FF449BAED7FFDB121373D2', '1807D17438814B31B75A279C4CBC6C0C', 'hiddenrules', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2023-02-01T09:18:47.676+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('A38301B34FF04C4490C0EE4BFA4282AB', '1807D17438814B31B75A279C4CBC6C0C', 'position', null, 'relative', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-05T11:27:25.560+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('C433A5C849894E19915648A5EBECA2BA', '1807D17438814B31B75A279C4CBC6C0C', 'readonly', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2023-02-01T09:18:54.473+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('8D7504DF79304BD38B595119D135D3D0', '1807D17438814B31B75A279C4CBC6C0C', 'readonlyrules', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2023-02-01T09:19:00.293+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('32F672EE188A4BF7A2D8F3971C695D0B', '1807D17438814B31B75A279C4CBC6C0C', 'type', null, 'APP_BAR', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-10-04T00:00:00.000+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('B108CBBF73F3418893488BE4C2C05182', '1807D17438814B31B75A279C4CBC6C0C', 'uitype', null, '1', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-05T11:26:11.696+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('FEC7A3E95CAC46319A542B00BE42ED79', '1807D17438814B31B75A279C4CBC6C0C', 'width', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-10-04T00:00:00.000+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
select pkg_patcher.p_clear_attr('1807D17438814B31B75A279C4CBC6C0C'::varchar, '["align","childs","contentview","disabled","disabledrules","height","hidden","hiddenrules","position","readonly","readonlyrules","type","uitype","width"]'::jsonb);
