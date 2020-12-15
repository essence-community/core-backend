--liquibase formatted sql
--changeset patcher-core:Page_FF7C023ADAD940A397E46F3BBD4A5AD6 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_page (ck_id, ck_parent, cr_type, cv_name, cn_order, cl_static, cv_url, ck_icon, ck_view, ck_user, ct_change, cl_menu)VALUES('FF7C023ADAD940A397E46F3BBD4A5AD6', null, 3, 'b749ad285f72426bbdfda8d89d181444', 1, 1, 'pages', '101', 'system', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-12-11T11:51:12.282+0000', 0) on conflict (ck_id) do update set ck_parent = excluded.ck_parent, ck_view=excluded.ck_view, cr_type = excluded.cr_type, cv_name = excluded.cv_name, cn_order = excluded.cn_order, cl_static = excluded.cl_static, cv_url = excluded.cv_url, ck_icon = excluded.ck_icon, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_menu = excluded.cl_menu;
INSERT INTO s_mt.t_page_attr(ck_id, ck_page, ck_attr, cv_value, ck_user, ct_change) VALUES ('670416B02C714270B164C2854D3F9264', 'FF7C023ADAD940A397E46F3BBD4A5AD6', 'defaultvalue', 'home', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-12-15T07:45:09.642+0000')  on conflict (ck_id) do update set ck_id = excluded.ck_id, ck_page, ck_attr, cv_value, ck_user, ct_change;
INSERT INTO s_mt.t_page_attr(ck_id, ck_page, ck_attr, cv_value, ck_user, ct_change) VALUES ('68DB14ECD6644384ABC1BB4E0CE61486', 'FF7C023ADAD940A397E46F3BBD4A5AD6', 'activerules', 'g_sess_session != ""', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-12-15T07:46:19.846+0000')  on conflict (ck_id) do update set ck_id = excluded.ck_id, ck_page, ck_attr, cv_value, ck_user, ct_change;
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)
select t.ck_id, t.ck_d_lang, t.cr_namespace, t.cv_value, t.ck_user, t.ct_change::timestamp from (
    select 'b749ad285f72426bbdfda8d89d181444' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Приложения Essence Core' as cv_value, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-12-11T08:51:12.282+0000' as ct_change
) as t 
 join s_mt.t_d_lang dl
 on t.ck_d_lang = dl.ck_id
on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
