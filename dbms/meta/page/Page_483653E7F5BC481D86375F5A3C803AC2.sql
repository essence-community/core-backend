--liquibase formatted sql
--changeset patcher-core:Page_483653E7F5BC481D86375F5A3C803AC2 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
select pkg_patcher.p_remove_page('483653E7F5BC481D86375F5A3C803AC2');

INSERT INTO s_mt.t_page (ck_id, ck_parent, cr_type, cv_name, cn_order, cl_static, cv_url, ck_icon, ck_user, ct_change, cl_menu)VALUES('483653E7F5BC481D86375F5A3C803AC2', '1626AD0E15B446D4B478CCC5AC2B6E60', 2, 'a1af5304b34a44caaf8ee651a2330d36', 1, 1, 'home', '358', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-13T00:00:00.000+0000', 0) on conflict (ck_id) do update set ck_parent = excluded.ck_parent, cr_type = excluded.cr_type, cv_name = excluded.cv_name, cn_order = excluded.cn_order, cl_static = excluded.cl_static, cv_url = excluded.cv_url, ck_icon = excluded.ck_icon, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_menu = excluded.cl_menu;
select pkg_patcher.p_merge_page_action('2EC6E7461CBD4C208768AF55C35CE99C', '483653E7F5BC481D86375F5A3C803AC2', 'edit', 504, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-13T00:00:00.000+0000');
select pkg_patcher.p_merge_page_action('89DADF7246C14095BDBD26E04F5C783B', '483653E7F5BC481D86375F5A3C803AC2', 'view', 503, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-13T00:00:00.000+0000');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)
select t.ck_id, t.ck_d_lang, t.cr_namespace, t.cv_value, t.ck_user, t.ct_change::timestamp from (
    select 'a1af5304b34a44caaf8ee651a2330d36' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Домашняя страница' as cv_value, '-11' as ck_user, '2019-12-10T00:00:00.000+0000' as ct_change
) as t 
 join s_mt.t_d_lang dl
 on t.ck_d_lang = dl.ck_id
on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
