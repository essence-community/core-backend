--liquibase formatted sql
--changeset patcher-core:Page_BCF372022D324CF691035DBBB893289C dbms:postgresql runOnChange:true splitStatements:false stripComments:false
select pkg_patcher.p_remove_page('BCF372022D324CF691035DBBB893289C');

INSERT INTO s_mt.t_page (ck_id, ck_parent, cr_type, cv_name, cn_order, cl_static, cv_url, ck_icon, ck_user, ct_change, cl_menu)VALUES('BCF372022D324CF691035DBBB893289C', '914836A8F7734C5DA29CC3E03677685F', 2, '96dd677448db478a8c4ef0790b8c52da', 10, 1, 'core-classes-button', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-18T09:55:18.444+0000', 0) on conflict (ck_id) do update set ck_parent = excluded.ck_parent, cr_type = excluded.cr_type, cv_name = excluded.cv_name, cn_order = excluded.cn_order, cl_static = excluded.cl_static, cv_url = excluded.cv_url, ck_icon = excluded.ck_icon, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_menu = excluded.cl_menu;
select pkg_patcher.p_merge_page_action('6BF06E55DD8A417DA40063C7B9716798', 'BCF372022D324CF691035DBBB893289C', 'edit', 99999, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-16T08:58:13.908+0000');
select pkg_patcher.p_merge_page_action('56439095519B4417BA3E7F8C77BBF65B', 'BCF372022D324CF691035DBBB893289C', 'view', 99999, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-16T08:58:13.908+0000');
select pkg_patcher.p_merge_object('DB6A8869C7D84232B87503EFCF5ABB84', '137', null, 'SYS Demo Button', 50, null, 'SYS Demo Button', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-16T08:59:57.922+0000');
select pkg_patcher.p_merge_object('4F575593B40E4BCF96040A8709C98457', '19', 'DB6A8869C7D84232B87503EFCF5ABB84', 'Button New', 10, null, 'Button New', '6d12c16cd7fa46579477a107a53f0790', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-16T09:00:26.829+0000');
select pkg_patcher.p_merge_object_attr('626299AB08C54CEFA53E5F5A06A9F0CF', '4F575593B40E4BCF96040A8709C98457', '992', 'plus', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-18T09:56:24.478+0000', 'iconfont');
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('88EA99B3B0454E7BB139F4CB5B0D229D', 'BCF372022D324CF691035DBBB893289C', 'DB6A8869C7D84232B87503EFCF5ABB84', 10, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-16T09:00:54.278+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('D598EE5B3BE844A692EF8D3541B6B59F', 'BCF372022D324CF691035DBBB893289C', '4F575593B40E4BCF96040A8709C98457', 10, '88EA99B3B0454E7BB139F4CB5B0D229D', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-16T09:00:54.278+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)
select t.ck_id, t.ck_d_lang, t.cr_namespace, t.cv_value, t.ck_user, t.ct_change::timestamp from (
    select '6d12c16cd7fa46579477a107a53f0790' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Создать' as cv_value, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-04T00:00:00.000+0000' as ct_change
    union all
    select '96dd677448db478a8c4ef0790b8c52da' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Button' as cv_value, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-06-16T08:58:13.908+0000' as ct_change
) as t 
 join s_mt.t_d_lang dl
 on t.ck_d_lang = dl.ck_id
on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
