--liquibase formatted sql
--changeset patcher-core:Page_1875398035771 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
select pkg_patcher.p_remove_page('1875398035771');

INSERT INTO s_mt.t_page (ck_id, ck_parent, cr_type, cv_name, cn_order, cl_static, cv_url, ck_icon, ck_user, ct_change, cl_menu)VALUES('1875398035771', '1875130240361', 2, 'e571d8599bc8466aac42ade8b1891e44', 1, 0, null, '5', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-08-22T00:00:00.000+0000', 0) on conflict (ck_id) do update set ck_parent = excluded.ck_parent, cr_type = excluded.cr_type, cv_name = excluded.cv_name, cn_order = excluded.cn_order, cl_static = excluded.cl_static, cv_url = excluded.cv_url, ck_icon = excluded.ck_icon, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_menu = excluded.cl_menu;
INSERT INTO s_mt.t_page_action (ck_id, ck_page, cr_type, cn_action, ck_user, ct_change)VALUES('2739563307', '1875398035771', 'edit', 504, '20780', '2019-01-20T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cr_type = excluded.cr_type, cn_action = excluded.cn_action, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_action (ck_id, ck_page, cr_type, cn_action, ck_user, ct_change)VALUES('2739221037', '1875398035771', 'view', 503, '20780', '2019-01-20T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cr_type = excluded.cr_type, cn_action = excluded.cn_action, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_variable (ck_id, ck_page, cv_name, cv_description, ck_user, ct_change)VALUES('2032473', '1875398035771', 'g_cd_period', 'Период', '20786', '2018-12-24T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cv_name = excluded.cv_name, cv_description = excluded.cv_description, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
select pkg_patcher.p_merge_object('7DD501DC87595167E053809BA8C05540', '137', null, 'SYS Menu Profile', 1000950, null, 'Профиль', null, null, null, '20786', '2018-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object('7DD501DC875A5167E053809BA8C05540', '26', '7DD501DC87595167E053809BA8C05540', 'Field Login', 10, null, 'Логин', '060a6513dc574996853d045276217394', null, null, '20786', '2018-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object('7DD51E27188751DDE053809BA8C01BB0', '26', '7DD501DC87595167E053809BA8C05540', 'Field FIO', 20, null, 'ФИО', '1740026cff1e45a9a13eeb3302428dc0', null, null, '20786', '2018-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object('7DD51E27188851DDE053809BA8C01BB0', '26', '7DD501DC87595167E053809BA8C05540', 'Field Email', 30, null, 'E-MAIL', 'cd78af76de0a40c7a56052936666e3e8', null, null, '20786', '2018-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object('09C4F5C6F0DA4681B275936B46DDEE27', '2BB74480D7E2455B97AED5B3A070FE35', '7DD501DC87595167E053809BA8C05540', 'Theme', 35, null, 'Theme', 'eb5f0456bee64d60ba3560e6f7a9f332', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-01-30T00:00:00.000+0000');
select pkg_patcher.p_merge_object('64751E484B534DC497376A24716F826E', 'DAB69DA8C46746AD959E331D4CFAC8AD', '7DD501DC87595167E053809BA8C05540', 'язык', 40, null, 'Язык', '8ebf011fbbad4c45bd0e93d6f8f39b20', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-01-30T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('147652257021', '7DD501DC87595167E053809BA8C05540', '609', 'vbox', '20786', '2018-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('147663469121', '7DD501DC875A5167E053809BA8C05540', '86', 'cv_login', '20786', '2018-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('147921347421', '7DD501DC875A5167E053809BA8C05540', '899', 'true', '20786', '2018-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('147674681221', '7DD51E27188751DDE053809BA8C01BB0', '86', 'cv_full_name', '20786', '2018-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('147910135321', '7DD51E27188751DDE053809BA8C01BB0', '899', 'true', '20786', '2018-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('147685893321', '7DD51E27188851DDE053809BA8C01BB0', '86', 'cv_email', '20786', '2018-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('147932559521', '7DD51E27188851DDE053809BA8C01BB0', '899', 'true', '20786', '2018-12-24T00:00:00.000+0000');
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('5FC3A0D7742B469885B7D5B63E606909', '1875398035771', '7DD501DC87595167E053809BA8C05540', 10, null, null, '20786', '2018-12-24T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('534EC57B609D466F8862306682A8E28C', '1875398035771', '7DD501DC875A5167E053809BA8C05540', 10, '5FC3A0D7742B469885B7D5B63E606909', null, '20786', '2018-12-24T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('0169F067BCEC4BECA0547ECFA211C648', '1875398035771', '7DD51E27188751DDE053809BA8C01BB0', 20, '5FC3A0D7742B469885B7D5B63E606909', null, '20786', '2018-12-24T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('C376295C9E2B414DB22E4B9A5795C737', '1875398035771', '7DD51E27188851DDE053809BA8C01BB0', 30, '5FC3A0D7742B469885B7D5B63E606909', null, '20786', '2018-12-24T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('26FDE08B80AA430EA507C0D5AE4F16F6', '1875398035771', '09C4F5C6F0DA4681B275936B46DDEE27', 35, '5FC3A0D7742B469885B7D5B63E606909', null, '20786', '2018-12-24T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('6B0943EEB5164542A48D399F2D33B725', '1875398035771', '64751E484B534DC497376A24716F826E', 40, '5FC3A0D7742B469885B7D5B63E606909', null, '20786', '2018-12-24T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('F7E3A69B59004C609E65B512DB8C2221', '534EC57B609D466F8862306682A8E28C', '1160', 'g_sess_cv_login', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-01-23T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('6A609EDC6D25426BA00EAE7AD1D065CA', '0169F067BCEC4BECA0547ECFA211C648', '1160', 'g_sess_cv_surname||'' ''||g_sess_cv_name', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-01-23T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)
select t.ck_id, t.ck_d_lang, t.cr_namespace, t.cv_value, t.ck_user, t.ct_change::timestamp from (
    select '060a6513dc574996853d045276217394' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Логин' as cv_value, '-11' as ck_user, '2019-12-10T00:00:00.000+0000' as ct_change
    union all
    select '1740026cff1e45a9a13eeb3302428dc0' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'ФИО' as cv_value, '-11' as ck_user, '2019-12-10T00:00:00.000+0000' as ct_change
    union all
    select 'cd78af76de0a40c7a56052936666e3e8' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'e-mail' as cv_value, '-11' as ck_user, '2019-12-10T00:00:00.000+0000' as ct_change
    union all
    select 'e571d8599bc8466aac42ade8b1891e44' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Профиль' as cv_value, '-11' as ck_user, '2019-12-10T00:00:00.000+0000' as ct_change
    union all
    select '8ebf011fbbad4c45bd0e93d6f8f39b20' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Язык' as cv_value, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-26T00:00:00.000+0000' as ct_change
    union all
    select 'eb5f0456bee64d60ba3560e6f7a9f332' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Тема' as cv_value, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-01-30T00:00:00.000+0000' as ct_change
) as t 
 join s_mt.t_d_lang dl
 on t.ck_d_lang = dl.ck_id
on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;