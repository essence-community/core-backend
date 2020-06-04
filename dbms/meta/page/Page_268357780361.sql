--liquibase formatted sql
--changeset patcher-core:Page_268357780361 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
select pkg_patcher.p_remove_page('268357780361');

INSERT INTO s_mt.t_page (ck_id, ck_parent, cr_type, cv_name, cn_order, cl_static, cv_url, ck_icon, ck_user, ct_change, cl_menu)VALUES('268357780361', '302', 2, '87e9b00d960d4b3e8cdab0ba7b9abb64', 20, 0, null, '306', '20780', '2018-12-16T00:00:00.000+0000', 1) on conflict (ck_id) do update set ck_parent = excluded.ck_parent, cr_type = excluded.cr_type, cv_name = excluded.cv_name, cn_order = excluded.cn_order, cl_static = excluded.cl_static, cv_url = excluded.cv_url, ck_icon = excluded.ck_icon, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_menu = excluded.cl_menu;
INSERT INTO s_mt.t_page_action (ck_id, ck_page, cr_type, cn_action, ck_user, ct_change)VALUES('342988767', '268357780361', 'edit', 705, '20780', '2018-12-16T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cr_type = excluded.cr_type, cn_action = excluded.cn_action, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_action (ck_id, ck_page, cr_type, cn_action, ck_user, ct_change)VALUES('342646497', '268357780361', 'view', 704, '20780', '2018-12-16T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cr_type = excluded.cr_type, cn_action = excluded.cn_action, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
select pkg_patcher.p_merge_object('7B511D868B5D954CE053809BA8C098D7', '8', null, 'SYS Settings', 1003010, 'MTGetSysSettings', 't_sys_setting', 'c3a995950b0847ab9707dfc8eea248c5', 'pkg_json_meta.f_modify_sys_setting', 'meta', '20788', '2018-11-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('7B6855FFD50E052EE053809BA8C0CCCE', '16', '7B511D868B5D954CE053809BA8C098D7', 'column edit', 5, null, 'column edit', null, null, null, '20788', '2018-11-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('7B516907E04995DBE053809BA8C0143F', '9', '7B511D868B5D954CE053809BA8C098D7', 'ck_id', 10, null, 'ck_id', '079a71832c164e49a909d1b3c385807c', null, null, '20788', '2018-12-07T00:00:00.000+0000');
select pkg_patcher.p_merge_object('7B67FE4A449B95A4E053809BA8C0EF74', '9', '7B511D868B5D954CE053809BA8C098D7', 'cv_value', 20, null, 'cv_value', '21fe3558a31c44ef8c93da0d7cd79d3b', null, null, '20788', '2018-12-07T00:00:00.000+0000');
select pkg_patcher.p_merge_object('7C81353E4D1B19FAE053809BA8C08693', '9', '7B511D868B5D954CE053809BA8C098D7', 'cv_description', 30, null, 'cv_description', 'd1dd81f5338c4d85a5ffb32a0d7aab69', null, null, '20788', '2018-12-07T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('33681260521', '7B511D868B5D954CE053809BA8C098D7', '1643', 'false', '20788', '2018-11-25T00:00:00.000+0000', 'btndelete');
select pkg_patcher.p_merge_object_attr('78563296821', '7B516907E04995DBE053809BA8C0143F', '179', '25%', '20788', '2018-12-07T00:00:00.000+0000', 'width');
select pkg_patcher.p_merge_object_attr('33692472621', '7B516907E04995DBE053809BA8C0143F', '433', 'hidden', '20788', '2018-11-25T00:00:00.000+0000', 'editmode');
select pkg_patcher.p_merge_object_attr('22435524221', '7B516907E04995DBE053809BA8C0143F', '47', 'ck_id', '20788', '2018-11-23T00:00:00.000+0000', 'column');
select pkg_patcher.p_merge_object_attr('22457948421', '7B511D868B5D954CE053809BA8C098D7', '852', 'ck_id', '20788', '2018-11-23T00:00:00.000+0000', 'orderproperty');
select pkg_patcher.p_merge_object_attr('78574508921', '7B67FE4A449B95A4E053809BA8C0EF74', '179', '25%', '20788', '2018-12-07T00:00:00.000+0000', 'width');
select pkg_patcher.p_merge_object_attr('22446736321', '7B67FE4A449B95A4E053809BA8C0EF74', '47', 'cv_value', '20788', '2018-11-23T00:00:00.000+0000', 'column');
select pkg_patcher.p_merge_object_attr('78585721021', '7C81353E4D1B19FAE053809BA8C08693', '179', '50%', '20788', '2018-12-07T00:00:00.000+0000', 'width');
select pkg_patcher.p_merge_object_attr('78552084721', '7C81353E4D1B19FAE053809BA8C08693', '47', 'cv_description', '20788', '2018-12-07T00:00:00.000+0000', 'column');
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7D305F9D62433AA5E053809BA8C09B24', '268357780361', '7B511D868B5D954CE053809BA8C098D7', 10, null, null, '20848', '2018-12-16T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7D305F9D62443AA5E053809BA8C09B24', '268357780361', '7B6855FFD50E052EE053809BA8C0CCCE', 5, '7D305F9D62433AA5E053809BA8C09B24', null, '20848', '2018-12-16T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7D305F9D62453AA5E053809BA8C09B24', '268357780361', '7B516907E04995DBE053809BA8C0143F', 10, '7D305F9D62433AA5E053809BA8C09B24', null, '20848', '2018-12-16T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7D305F9D62463AA5E053809BA8C09B24', '268357780361', '7B67FE4A449B95A4E053809BA8C0EF74', 20, '7D305F9D62433AA5E053809BA8C09B24', null, '20848', '2018-12-16T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7D305F9D62473AA5E053809BA8C09B24', '268357780361', '7C81353E4D1B19FAE053809BA8C08693', 30, '7D305F9D62433AA5E053809BA8C09B24', null, '20848', '2018-12-16T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)
select t.ck_id, t.ck_d_lang, t.cr_namespace, t.cv_value, t.ck_user, t.ct_change::timestamp from (
    select '079a71832c164e49a909d1b3c385807c' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Имя' as cv_value, '-11' as ck_user, '2019-12-10T00:00:00.000+0000' as ct_change
    union all
    select '21fe3558a31c44ef8c93da0d7cd79d3b' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Значение' as cv_value, '-11' as ck_user, '2019-12-10T00:00:00.000+0000' as ct_change
    union all
    select '87e9b00d960d4b3e8cdab0ba7b9abb64' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Системные настройки' as cv_value, '-11' as ck_user, '2019-12-10T00:00:00.000+0000' as ct_change
    union all
    select 'c3a995950b0847ab9707dfc8eea248c5' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Системные настройки экземпляра CORE' as cv_value, '-11' as ck_user, '2019-12-10T00:00:00.000+0000' as ct_change
    union all
    select 'd0ad23ef13f8493e996cfca8a98d0721' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Редактировать значение' as cv_value, '-11' as ck_user, '2019-12-10T00:00:00.000+0000' as ct_change
    union all
    select 'd1dd81f5338c4d85a5ffb32a0d7aab69' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Описание' as cv_value, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-26T00:00:00.000+0000' as ct_change
) as t 
 join s_mt.t_d_lang dl
 on t.ck_d_lang = dl.ck_id
on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
