--liquibase formatted sql
--changeset patcher-core:MetaClass_1EE230968D8648419A9FEF0AAF7390E7 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class(ck_id, cv_name, cv_description, cv_manual_documentation, cv_auto_documentation, cl_final, cl_dataset, ck_view, ck_user, ct_change) VALUES ('1EE230968D8648419A9FEF0AAF7390E7', 'Application', 'Контейнер для приложения', 'Компонент для создания приложения

[Button](/redirect/docs/core-classes-button)', '

## ApplicationContainer

Включает commonDecorator

Type: React.FC&lt;IClassProps&lt;IBuilderClassConfig>>

### loadApplication

Загрузка начального состоянии приложения

## ApplicationModel

### Parameters

-   `history` **[History][1]** 
-   `url` **[string][2]** 

### handlers

#### onLogout

Выход из приложения

#### onWindowOpen

Открытие окна по ckwindow

[1]: https://developer.mozilla.org/docs/Web/Guide/API/DOM/Manipulating_the_browser_history

[2]: https://developer.mozilla.org/docs/Web/JavaScript/Reference/Global_Objects/String
', 1, 1, 'system', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-10-14T00:00:00.000+0000')  on conflict (ck_id) do update set cv_name = excluded.cv_name, cv_description = excluded.cv_description, cv_manual_documentation = excluded.cv_manual_documentation, cv_auto_documentation = excluded.cv_auto_documentation, cl_final = excluded.cl_final, cl_dataset = excluded.cl_dataset, ck_view = excluded.ck_view, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('720D49730212420EA2CE5933F0D244DE', '1EE230968D8648419A9FEF0AAF7390E7', 'actiongate', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2023-06-30T15:21:46.067+0000', 0, 1)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('B4952B6F8DA34BEFB04D244268B674F1', '1EE230968D8648419A9FEF0AAF7390E7', 'activerules', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-10-15T00:00:00.000+0000', 1, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('290CBFB50CFC4362B2F00C5C4D34AAB5', '1EE230968D8648419A9FEF0AAF7390E7', 'childs', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-10-14T00:00:00.000+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('8E3A9174CCB442F1B50A7E5F97806827', '1EE230968D8648419A9FEF0AAF7390E7', 'childwindow', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-10-17T00:00:00.000+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('939B5B0FDBB24DB08E935675A72676B7', '1EE230968D8648419A9FEF0AAF7390E7', 'defaultvalue', null, 'home', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-10-30T00:00:00.000+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('D73A9971AFD745AF830077F0E113512C', '1EE230968D8648419A9FEF0AAF7390E7', 'defaultvaluelocalization', null, 'home', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-10-28T12:24:03.549+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('62C35A46C42445ACAF5C6CA1E4A0639A', '1EE230968D8648419A9FEF0AAF7390E7', 'getmastervalue', null, '[{"in": "ck_id", "out": "ck_id"}]', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-01-13T00:00:00.000+0000', 1, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('185CC21AEB3F4A0BAA73F685A5F03BD4', '1EE230968D8648419A9FEF0AAF7390E7', 'idproperty', null, 'ck_id', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-01-14T00:00:00.000+0000', 1, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('7461034978DE4E86ACA2F26C0916B6FE', '1EE230968D8648419A9FEF0AAF7390E7', 'noblank', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2024-09-06T14:31:35.286+0000', 0, 1)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('A333461EE19C4FC1B4D6BB5848855834', '1EE230968D8648419A9FEF0AAF7390E7', 'redirecturl', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-04-07T00:00:00.000+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('64F7AA1D130847AFAB624B92D85B01BF', '1EE230968D8648419A9FEF0AAF7390E7', 'setrecordtoglobal', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-02-06T00:00:00.000+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('029735586E854F23A06CEF4CDCED4DAA', '1EE230968D8648419A9FEF0AAF7390E7', 'type', null, 'APPLICATION', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-10-14T00:00:00.000+0000', 1, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
select pkg_patcher.p_clear_attr('1EE230968D8648419A9FEF0AAF7390E7'::varchar, '["actiongate","activerules","childs","childwindow","defaultvalue","defaultvaluelocalization","getmastervalue","idproperty","noblank","redirecturl","setrecordtoglobal","type"]'::jsonb);
