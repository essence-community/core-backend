--liquibase formatted sql
--changeset patcher-core:Page_1FE7D44E96374AEAB77604CF64038FF5 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_page (ck_id, ck_parent, cr_type, cv_name, cn_order, cl_static, cv_url, ck_icon, ck_view, ck_user, ct_change, cl_menu)VALUES('1FE7D44E96374AEAB77604CF64038FF5', null, 3, '72385771019346eda0878677425209e0', 1000, 1, 'auth', '728', 'auth', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-12-15T07:42:08.581+0000', 0) on conflict (ck_id) do update set ck_parent = excluded.ck_parent, ck_view=excluded.ck_view, cr_type = excluded.cr_type, cv_name = excluded.cv_name, cn_order = excluded.cn_order, cl_static = excluded.cl_static, cv_url = excluded.cv_url, ck_icon = excluded.ck_icon, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_menu = excluded.cl_menu;
INSERT INTO s_mt.t_page_attr(ck_id, ck_page, ck_attr, cv_value, ck_user, ct_change) VALUES ('2A2105806D134DCD9C75F99559FCA56C', '1FE7D44E96374AEAB77604CF64038FF5', 'defaultvalue', 'home', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-12-15T07:42:55.691+0000')  on conflict (ck_id) do update set ck_id = excluded.ck_id, ck_page, ck_attr, cv_value, ck_user, ct_change;
INSERT INTO s_mt.t_page_attr(ck_id, ck_page, ck_attr, cv_value, ck_user, ct_change) VALUES ('4AA498135C464D4581C02366F9AA37E9', '1FE7D44E96374AEAB77604CF64038FF5', 'redirecturl', 'pages', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-12-15T07:42:20.464+0000')  on conflict (ck_id) do update set ck_id = excluded.ck_id, ck_page, ck_attr, cv_value, ck_user, ct_change;
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)
select t.ck_id, t.ck_d_lang, t.cr_namespace, t.cv_value, t.ck_user, t.ct_change::timestamp from (
    select '72385771019346eda0878677425209e0' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Приложения Essence Core Auth' as cv_value, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-12-15T07:42:08.581+0000' as ct_change
) as t 
 join s_mt.t_d_lang dl
 on t.ck_d_lang = dl.ck_id
on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
