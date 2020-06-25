--liquibase formatted sql
--changeset patcher-core:Page_F5CAF3CF206A4454A48FA1466932B969 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
select pkg_patcher.p_remove_page('F5CAF3CF206A4454A48FA1466932B969');

INSERT INTO s_mt.t_page (ck_id, ck_parent, cr_type, cv_name, cn_order, cl_static, cv_url, ck_icon, ck_user, ct_change, cl_menu)VALUES('F5CAF3CF206A4454A48FA1466932B969', 'BC4B5C748874439E9CED6E8F76933B84', 2, '7e9709869e4e48ab9344e347eeadcbf2', 20, 0, null, '280', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000', 1) on conflict (ck_id) do update set ck_parent = excluded.ck_parent, cr_type = excluded.cr_type, cv_name = excluded.cv_name, cn_order = excluded.cn_order, cl_static = excluded.cl_static, cv_url = excluded.cv_url, ck_icon = excluded.ck_icon, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_menu = excluded.cl_menu;
INSERT INTO s_mt.t_page_action (ck_id, ck_page, cr_type, cn_action, ck_user, ct_change)VALUES('9375D16F2BF1494A9E231C5734F1D005', 'F5CAF3CF206A4454A48FA1466932B969', 'edit', 516, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cr_type = excluded.cr_type, cn_action = excluded.cn_action, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_action (ck_id, ck_page, cr_type, cn_action, ck_user, ct_change)VALUES('B62D8310574C466C8E5D9C64BDC8ACF5', 'F5CAF3CF206A4454A48FA1466932B969', 'view', 515, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cr_type = excluded.cr_type, cn_action = excluded.cn_action, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_variable (ck_id, ck_page, cv_name, cv_description, cv_value, ck_user, ct_change)VALUES('CAEFC7FE1DA94907AE3CFF57FCD39FE5', 'F5CAF3CF206A4454A48FA1466932B969', 'g_lang_exclude', 'ID слова/фразы', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cv_name = excluded.cv_name, cv_description = excluded.cv_description, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
select pkg_patcher.p_merge_object('0F1117C047384041B24D44E81C50634D', '137', null, 'SYS Localization Panel', 1004001, null, 'Локализация', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000');
select pkg_patcher.p_merge_object('DBCA7FE4E17548A7AFBE21B3E1FF060C', '8', '0F1117C047384041B24D44E81C50634D', 'Dictionary Grid', 10, 'MTGetDefaultLocalization', 'Список слов/фраз', '6a6756ec59b64dcdac246cfdf6a9e28e', 'pkg_json_localization.f_modify_default_localization', 'meta', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000');
select pkg_patcher.p_merge_object('4FA67852465C4A08AF79D402DEA15054', '8', '0F1117C047384041B24D44E81C50634D', 'Translate Grid', 20, 'MTGetLocalization', 'Перевод', '16e495742eee4776af2456e0549b93f3', 'pkg_json_localization.f_modify_localization', 'meta', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000');
select pkg_patcher.p_merge_object('9176BFC191804165ABDA5AB9F967BA3B', '19', 'DBCA7FE4E17548A7AFBE21B3E1FF060C', 'Add Button', 10, null, 'Добавить', '122d20300ab34c02b78bd1d3945e5eeb', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000');
select pkg_patcher.p_merge_object('F0814387A1CC4C17BEAE4EB59DB3DEFF', '19', '4FA67852465C4A08AF79D402DEA15054', 'Add button', 10, null, 'Добавить', '122d20300ab34c02b78bd1d3945e5eeb', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000');
select pkg_patcher.p_merge_object('F35C4A7DC6584774B5761BC2BD4BBEFB', '16', '4FA67852465C4A08AF79D402DEA15054', 'Edit Button', 20, null, 'Редактировать', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000');
select pkg_patcher.p_merge_object('845C3929F9D74FE2829E1E38D7F57B33', '16', 'DBCA7FE4E17548A7AFBE21B3E1FF060C', 'Edit Button', 20, null, 'Редактирование', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000');
select pkg_patcher.p_merge_object('1ED129A364054C1A81788D0A1080F689', '9', 'DBCA7FE4E17548A7AFBE21B3E1FF060C', 'ck_id', 30, null, 'Идентификатор', '356026998685486b99fc07969bd2af68', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000');
select pkg_patcher.p_merge_object('B6512521E118405986D40EA94106B702', '9', '4FA67852465C4A08AF79D402DEA15054', 'cv_lang', 30, null, 'Язык', '8ebf011fbbad4c45bd0e93d6f8f39b20', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000');
select pkg_patcher.p_merge_object('2CD90B3C086047D39DC887E28C949F88', '9', '4FA67852465C4A08AF79D402DEA15054', 'cv_value', 40, null, 'Перевод', '16e495742eee4776af2456e0549b93f3', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000');
select pkg_patcher.p_merge_object('A4B0D06DCC904AD9BF3C7906DAB98744', '9', 'DBCA7FE4E17548A7AFBE21B3E1FF060C', 'cv_word', 40, null, 'Слово/Фраза', '44cb4487def44b74b32a748751d0263b', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000');
select pkg_patcher.p_merge_object('DDAEA661457B4AA185099E7122BC131B', '9', 'DBCA7FE4E17548A7AFBE21B3E1FF060C', 'cv_type', 50, null, 'Тип расположения', '4d1ff7c496954fd086b885c399da2831', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000');
select pkg_patcher.p_merge_object('A0949123DBA248CAA93F68905BFEE127', '9', 'DBCA7FE4E17548A7AFBE21B3E1FF060C', 'cv_path', 60, null, 'Расположение', '2544bf435d024d16920dfbd2f1b3b5e1', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000');
select pkg_patcher.p_merge_object('196843D6A4AA462F86AB603457CE2100', '31', 'B6512521E118405986D40EA94106B702', 'cv_lang', 10, 'MTGetLang', 'Язык', '8ebf011fbbad4c45bd0e93d6f8f39b20', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000');
select pkg_patcher.p_merge_object('F323F8193613406E85F6962024B2EC9C', '31', 'DDAEA661457B4AA185099E7122BC131B', 'cv_type', 10, 'MTGetLocalNameSpace', 'Тип расположения', '4d1ff7c496954fd086b885c399da2831', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('577F681A02964FAEA35A9A37758DB1CD', 'F323F8193613406E85F6962024B2EC9C', '120', 'cr_namespace', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000', 'column');
select pkg_patcher.p_merge_object_attr('C2FDD150508D421A88D9A5CA4F0E2793', '196843D6A4AA462F86AB603457CE2100', '120', 'ck_d_lang', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000', 'column');
select pkg_patcher.p_merge_object_attr('C325C789DB214B268A2D6235B6F09D79', '196843D6A4AA462F86AB603457CE2100', '125', 'cv_name', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000', 'displayfield');
select pkg_patcher.p_merge_object_attr('5993C11A04EF46ACA87EF0627C138A95', 'F323F8193613406E85F6962024B2EC9C', '125', 'ck_id', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000', 'displayfield');
select pkg_patcher.p_merge_object_attr('0A11248F02814AAC900AFD8BB4B024AF', '196843D6A4AA462F86AB603457CE2100', '126', '[{"in": "ck_id", "out": null}]', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000', 'valuefield');
select pkg_patcher.p_merge_object_attr('2437B4E2880D448CB7F8A460FB40916B', 'F323F8193613406E85F6962024B2EC9C', '126', '[{"in": "ck_id", "out": null}]', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000', 'valuefield');
select pkg_patcher.p_merge_object_attr('259E71D7C79447EC90C302D16FF2CFB8', 'F0814387A1CC4C17BEAE4EB59DB3DEFF', '155', '1', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000', 'mode');
select pkg_patcher.p_merge_object_attr('B3F482EB54D749EC997F625CB5313881', '9176BFC191804165ABDA5AB9F967BA3B', '155', '1', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000', 'mode');
select pkg_patcher.p_merge_object_attr('0DACE209FAD04395BF1105AB690A1E40', 'DBCA7FE4E17548A7AFBE21B3E1FF060C', '401', '25', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000', 'pagesize');
select pkg_patcher.p_merge_object_attr('6F4D56EB7C894A4E9F8D1DF7C906413D', 'DBCA7FE4E17548A7AFBE21B3E1FF060C', '852', 'cv_value', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000', 'orderproperty');
select pkg_patcher.p_merge_object_attr('A8D2EFD54A744A23BBE3F8C87D85047E', 'DBCA7FE4E17548A7AFBE21B3E1FF060C', '853', 'ASC', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000', 'orderdirection');
select pkg_patcher.p_merge_object_attr('77E597AD3EDE49A7A64C135BBD6F607B', 'F0814387A1CC4C17BEAE4EB59DB3DEFF', '992', 'plus', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-14T00:00:00.000+0000', 'iconfont');
select pkg_patcher.p_merge_object_attr('CB8A4A151B56470FA19677127C3260D5', '9176BFC191804165ABDA5AB9F967BA3B', '992', 'plus', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-14T00:00:00.000+0000', 'iconfont');
select pkg_patcher.p_merge_object_attr('C62398B5D473485897E3A31679D6C085', '4FA67852465C4A08AF79D402DEA15054', '572', 'false', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000', 'autoload');
select pkg_patcher.p_merge_object_attr('BD01533E71E64F7281028A75CEE86364', '4FA67852465C4A08AF79D402DEA15054', '852', 'ck_d_lang', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000', 'orderproperty');
select pkg_patcher.p_merge_object_attr('7FAE9FBC58254EA5BB03E92D10FD831D', '4FA67852465C4A08AF79D402DEA15054', '853', 'asc', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000', 'orderdirection');
select pkg_patcher.p_merge_object_attr('83BE1211DF044937B3DB35A24E14B5CD', '1ED129A364054C1A81788D0A1080F689', '433', 'hidden', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000', 'editmode');
select pkg_patcher.p_merge_object_attr('E0BD2DC35C3A46338F5276A222028B3A', 'B6512521E118405986D40EA94106B702', '433', 'insert', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000', 'editmode');
select pkg_patcher.p_merge_object_attr('3D4B2FBEAFBC473FAB7C5BDC0D73F65F', 'B6512521E118405986D40EA94106B702', '453', 'true', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-17T00:00:00.000+0000', 'required');
select pkg_patcher.p_merge_object_attr('11299E2870E04F3A9CAADA82A4757E95', '1ED129A364054C1A81788D0A1080F689', '47', 'ck_id', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000', 'column');
select pkg_patcher.p_merge_object_attr('2E5ACFF558E44D499313016E7A2F1162', 'B6512521E118405986D40EA94106B702', '47', 'cv_d_lang', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000', 'column');
select pkg_patcher.p_merge_object_attr('7F391E3E3CB440F59085077A02BB340B', 'A4B0D06DCC904AD9BF3C7906DAB98744', '453', 'true', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-17T00:00:00.000+0000', 'required');
select pkg_patcher.p_merge_object_attr('AC25760D1E9C45B5993B15D25FEB3CFB', '2CD90B3C086047D39DC887E28C949F88', '453', 'true', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-17T00:00:00.000+0000', 'required');
select pkg_patcher.p_merge_object_attr('B39243CCBFDE444583A8836E613E4BD0', 'A4B0D06DCC904AD9BF3C7906DAB98744', '47', 'cv_value', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000', 'column');
select pkg_patcher.p_merge_object_attr('7AC27088CF65401DBFD6AB887F40392C', '2CD90B3C086047D39DC887E28C949F88', '47', 'cv_value', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000', 'column');
select pkg_patcher.p_merge_object_attr('37CE0C0699EE47598646A350CAB12B40', 'DDAEA661457B4AA185099E7122BC131B', '453', 'true', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-17T00:00:00.000+0000', 'required');
select pkg_patcher.p_merge_object_attr('80DEDCFCCA964BFB9C33C2E3ACB2C245', 'DDAEA661457B4AA185099E7122BC131B', '47', 'cr_namespace', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000', 'column');
select pkg_patcher.p_merge_object_attr('C82AF6ECA5E5447A9B3962786AD9F215', 'A0949123DBA248CAA93F68905BFEE127', '433', 'hidden', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000', 'editmode');
select pkg_patcher.p_merge_object_attr('0D1C41CCB9374BFA8733EC7D6A2E415E', 'A0949123DBA248CAA93F68905BFEE127', '47', 'cv_path', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000', 'column');
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7255DF42D26C4AED9B479167A9FD242D', 'F5CAF3CF206A4454A48FA1466932B969', '0F1117C047384041B24D44E81C50634D', 10, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('C8E575B2C483413CAF2884477FB6E548', 'F5CAF3CF206A4454A48FA1466932B969', 'DBCA7FE4E17548A7AFBE21B3E1FF060C', 10, '7255DF42D26C4AED9B479167A9FD242D', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('DD14E144DFBA4DE892375B07E70EA17A', 'F5CAF3CF206A4454A48FA1466932B969', '4FA67852465C4A08AF79D402DEA15054', 20, '7255DF42D26C4AED9B479167A9FD242D', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('A78080CAE07D4A1388E108965DD08B11', 'F5CAF3CF206A4454A48FA1466932B969', '9176BFC191804165ABDA5AB9F967BA3B', 10, 'C8E575B2C483413CAF2884477FB6E548', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('90DDA76E04A5451AA8BD7D1C4EFF490D', 'F5CAF3CF206A4454A48FA1466932B969', 'F0814387A1CC4C17BEAE4EB59DB3DEFF', 10, 'DD14E144DFBA4DE892375B07E70EA17A', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('C9C3FD96155D4DD19F4247B9BC52FB8C', 'F5CAF3CF206A4454A48FA1466932B969', 'F35C4A7DC6584774B5761BC2BD4BBEFB', 20, 'DD14E144DFBA4DE892375B07E70EA17A', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('DA5B9A00E589436382F6E290450D5438', 'F5CAF3CF206A4454A48FA1466932B969', '845C3929F9D74FE2829E1E38D7F57B33', 20, 'C8E575B2C483413CAF2884477FB6E548', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('59D854A07011489887D06C5B45435C52', 'F5CAF3CF206A4454A48FA1466932B969', '1ED129A364054C1A81788D0A1080F689', 30, 'C8E575B2C483413CAF2884477FB6E548', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('B1BF3AE7AA30471483F25DFEFC306DC3', 'F5CAF3CF206A4454A48FA1466932B969', 'B6512521E118405986D40EA94106B702', 30, 'DD14E144DFBA4DE892375B07E70EA17A', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('F77E1E55405A4C4298A5DFFBC25CA701', 'F5CAF3CF206A4454A48FA1466932B969', '2CD90B3C086047D39DC887E28C949F88', 40, 'DD14E144DFBA4DE892375B07E70EA17A', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('B9D343B37491446DB8DF4BAAFC2B482A', 'F5CAF3CF206A4454A48FA1466932B969', 'A4B0D06DCC904AD9BF3C7906DAB98744', 40, 'C8E575B2C483413CAF2884477FB6E548', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('C8BDBD307BA24429AB47D34B8820C81D', 'F5CAF3CF206A4454A48FA1466932B969', 'DDAEA661457B4AA185099E7122BC131B', 50, 'C8E575B2C483413CAF2884477FB6E548', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('C9B828A2EBFE462C80C8E4C7ACE285D4', 'F5CAF3CF206A4454A48FA1466932B969', 'A0949123DBA248CAA93F68905BFEE127', 60, 'C8E575B2C483413CAF2884477FB6E548', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('8B1B032C07B641819232282953EE1BD4', 'F5CAF3CF206A4454A48FA1466932B969', '196843D6A4AA462F86AB603457CE2100', 10, 'B1BF3AE7AA30471483F25DFEFC306DC3', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('77111CDF68074B7F9524AF674FA99C68', 'F5CAF3CF206A4454A48FA1466932B969', 'F323F8193613406E85F6962024B2EC9C', 10, 'C8BDBD307BA24429AB47D34B8820C81D', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
select pkg_patcher.p_merge_page_object_attr('716EB8E9028B4FE5802950384FC891E3', 'C8E575B2C483413CAF2884477FB6E548', '1204', '[{"in": "ck_id", "out": "g_lang_exclude"}]', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000', 'setglobal');
select pkg_patcher.p_merge_page_object_attr('C6758F2F825245F5AA19218FFBCC4E1B', '8B1B032C07B641819232282953EE1BD4', '1219', '[{"in": "g_lang_exclude", "out": null}]', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000', 'getglobaltostore');
update s_mt.t_page_object set ck_master='C8E575B2C483413CAF2884477FB6E548' where ck_id='DD14E144DFBA4DE892375B07E70EA17A';
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)
select t.ck_id, t.ck_d_lang, t.cr_namespace, t.cv_value, t.ck_user, t.ct_change::timestamp from (
    select '356026998685486b99fc07969bd2af68' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Идентификатор' as cv_value, '-11' as ck_user, '2019-12-09T00:00:00.000+0000' as ct_change
    union all
    select '16e495742eee4776af2456e0549b93f3' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Перевод' as cv_value, '-11' as ck_user, '2019-12-10T00:00:00.000+0000' as ct_change
    union all
    select '2544bf435d024d16920dfbd2f1b3b5e1' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Расположение' as cv_value, '-11' as ck_user, '2019-12-10T00:00:00.000+0000' as ct_change
    union all
    select '44cb4487def44b74b32a748751d0263b' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Слово/Фраза' as cv_value, '-11' as ck_user, '2019-12-10T00:00:00.000+0000' as ct_change
    union all
    select '4d1ff7c496954fd086b885c399da2831' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Тип расположения' as cv_value, '-11' as ck_user, '2019-12-10T00:00:00.000+0000' as ct_change
    union all
    select '6a6756ec59b64dcdac246cfdf6a9e28e' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Список слов/фраз' as cv_value, '-11' as ck_user, '2019-12-10T00:00:00.000+0000' as ct_change
    union all
    select '7e9709869e4e48ab9344e347eeadcbf2' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Словарь' as cv_value, '-11' as ck_user, '2019-12-10T00:00:00.000+0000' as ct_change
    union all
    select 'd0ad23ef13f8493e996cfca8a98d0721' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Редактировать значение' as cv_value, '-11' as ck_user, '2019-12-10T00:00:00.000+0000' as ct_change
    union all
    select '122d20300ab34c02b78bd1d3945e5eeb' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Добавить' as cv_value, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-25T00:00:00.000+0000' as ct_change
    union all
    select '8ebf011fbbad4c45bd0e93d6f8f39b20' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Язык' as cv_value, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-26T00:00:00.000+0000' as ct_change
) as t 
 join s_mt.t_d_lang dl
 on t.ck_d_lang = dl.ck_id
on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
