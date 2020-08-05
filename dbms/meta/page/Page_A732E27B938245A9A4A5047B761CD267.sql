--liquibase formatted sql
--changeset patcher-core:Page_A732E27B938245A9A4A5047B761CD267 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
select pkg_patcher.p_remove_page('A732E27B938245A9A4A5047B761CD267');

INSERT INTO s_mt.t_page (ck_id, ck_parent, cr_type, cv_name, cn_order, cl_static, cv_url, ck_icon, ck_user, ct_change, cl_menu)VALUES('A732E27B938245A9A4A5047B761CD267', 'C0EF204A8D77489FB097AC43A481818D', 2, 'b539896d6a1c48f5b962a8cfc0677973', 10, 0, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-15T15:05:21.499+0000', 1) on conflict (ck_id) do update set ck_parent = excluded.ck_parent, cr_type = excluded.cr_type, cv_name = excluded.cv_name, cn_order = excluded.cn_order, cl_static = excluded.cl_static, cv_url = excluded.cv_url, ck_icon = excluded.ck_icon, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_menu = excluded.cl_menu;
select pkg_patcher.p_merge_page_action('35C08821AF874B29A27E3DFE9D11CCE2', 'A732E27B938245A9A4A5047B761CD267', 'edit', 99999, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-15T13:40:37.450+0000');
select pkg_patcher.p_merge_page_action('191B1B6CD1514B1185A4971A4F22ECB8', 'A732E27B938245A9A4A5047B761CD267', 'view', 99999, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-15T13:40:37.450+0000');
select pkg_patcher.p_merge_object('FC2F9A8B93CE4B21B5DDFDF8BBAB16BD', '1', null, 'SYS Documentation Static Box', 20, null, 'SYS Documentation Static Box', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-15T13:32:05.427+0000');
select pkg_patcher.p_merge_object('00992032FD31411CA17F2961B5F5BBE7', '5F229304828F4AADBF9B0BE6463B1248', 'FC2F9A8B93CE4B21B5DDFDF8BBAB16BD', 'Documentation Text', 10, null, 'Documentation Text', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-15T13:33:21.083+0000');
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('C531D1B87EC64A9498CF0B35A2BBD3DD', 'A732E27B938245A9A4A5047B761CD267', 'FC2F9A8B93CE4B21B5DDFDF8BBAB16BD', 10, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-15T13:40:58.931+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('9232CE099B9D4123861EE78AE9A7103A', 'A732E27B938245A9A4A5047B761CD267', '00992032FD31411CA17F2961B5F5BBE7', 10, 'C531D1B87EC64A9498CF0B35A2BBD3DD', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-15T13:40:58.931+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
select pkg_patcher.p_merge_page_object_attr('6235DC93C1AA45C78ABC4EAB0FD362C5', '9232CE099B9D4123861EE78AE9A7103A', '77CCD76E7CD444FFAF54D6000CEF4E05', '# Принцип разработки

TODO: Страница в разработке

## Клиентский логер

Для логирования ошибок и сообщений используется npm пакет [debug](https://www.npmjs.com/package/debug)

Для включения необходимо (опиcание на браузере Google Chrome):

1. Открыть консоль разработчика
1. Перейти на вкладку "Application"
1. В группу "Storage" раскрыть "Local Storage" и выбрать соотвествующее доменное имя
1. В конец списка добавить запись с ключем `debug` и значением `essence:constructor:*`
1. Перезагрузить страницу

После добавления найтроек дебагера, в консоле будут появляться отладочные сообщения', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-17T15:01:33.758+0000', 'text');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)
select t.ck_id, t.ck_d_lang, t.cr_namespace, t.cv_value, t.ck_user, t.ct_change::timestamp from (
    select 'b539896d6a1c48f5b962a8cfc0677973' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Разработка' as cv_value, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-06-15T13:40:37.450+0000' as ct_change
) as t 
 join s_mt.t_d_lang dl
 on t.ck_d_lang = dl.ck_id
on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
