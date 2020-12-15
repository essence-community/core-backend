--liquibase formatted sql
--changeset patcher-core:Page_E3B71F02EC584D619DCBA77ED1CF8F4E dbms:postgresql runOnChange:true splitStatements:false stripComments:false
select pkg_patcher.p_remove_page('E3B71F02EC584D619DCBA77ED1CF8F4E');

INSERT INTO s_mt.t_page (ck_id, ck_parent, cr_type, cv_name, cn_order, cl_static, cv_url, ck_icon, ck_view, ck_user, ct_change, cl_menu)VALUES('E3B71F02EC584D619DCBA77ED1CF8F4E', '1626AD0E15B446D4B478CCC5AC2B6E60', 2, 'd61bc561722546e6b4bb79b13412891a', 10, 1, 'home-docs', null, 'system', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-15T19:10:06.561+0000', 0) on conflict (ck_id) do update set ck_parent = excluded.ck_parent, ck_view=excluded.ck_view, cr_type = excluded.cr_type, cv_name = excluded.cv_name, cn_order = excluded.cn_order, cl_static = excluded.cl_static, cv_url = excluded.cv_url, ck_icon = excluded.ck_icon, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_menu = excluded.cl_menu;
select pkg_patcher.p_merge_page_action('0F089AAE29DC4E5F9A7479611631228B', 'E3B71F02EC584D619DCBA77ED1CF8F4E', 'edit', 99999, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-15T19:10:06.561+0000');
select pkg_patcher.p_merge_page_action('3BE5DBE1861A46FB9AEF4E75E8337856', 'E3B71F02EC584D619DCBA77ED1CF8F4E', 'view', 99999, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-15T19:10:06.561+0000');
select pkg_patcher.p_merge_object('FC2F9A8B93CE4B21B5DDFDF8BBAB16BD', '1', null, 'SYS Documentation Static Box', 20, null, 'SYS Documentation Static Box', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-15T13:32:05.427+0000');
select pkg_patcher.p_merge_object('00992032FD31411CA17F2961B5F5BBE7', '5F229304828F4AADBF9B0BE6463B1248', 'FC2F9A8B93CE4B21B5DDFDF8BBAB16BD', 'Documentation Text', 10, null, 'Documentation Text', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-15T13:33:21.083+0000');
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('1C1D8103131D4D17B6AF03181E3F1D50', 'E3B71F02EC584D619DCBA77ED1CF8F4E', 'FC2F9A8B93CE4B21B5DDFDF8BBAB16BD', 10, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-15T19:10:24.307+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('AEDD6A0B101E450F89C9C37195366614', 'E3B71F02EC584D619DCBA77ED1CF8F4E', '00992032FD31411CA17F2961B5F5BBE7', 10, '1C1D8103131D4D17B6AF03181E3F1D50', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-15T19:10:24.307+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
select pkg_patcher.p_merge_page_object_attr('2157A04F93EF45168F05111787E53304', 'AEDD6A0B101E450F89C9C37195366614', '77CCD76E7CD444FFAF54D6000CEF4E05', '# Добро пожаловать в докуменатцию

## Рады что выбрали нас ;)', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-15T19:11:20.298+0000', 'text');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)
select t.ck_id, t.ck_d_lang, t.cr_namespace, t.cv_value, t.ck_user, t.ct_change::timestamp from (
    select 'd61bc561722546e6b4bb79b13412891a' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Домашняя страница документации' as cv_value, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-06-15T19:10:06.561+0000' as ct_change
) as t 
 join s_mt.t_d_lang dl
 on t.ck_d_lang = dl.ck_id
on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
