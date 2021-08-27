--liquibase formatted sql
--changeset patcher-core:Page_5 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_page (ck_id, ck_parent, cr_type, cv_name, cn_order, cl_static, cv_url, ck_icon, ck_view, ck_user, ct_change, cl_menu)VALUES('5', '4', 1, '6213f1138a534cc088ff1440bb472505', 1, 0, null, '173', 'system', '-11', '2018-02-23T00:00:00.000+0000', 1) on conflict (ck_id) do update set ck_parent = excluded.ck_parent, ck_view=excluded.ck_view, cr_type = excluded.cr_type, cv_name = excluded.cv_name, cn_order = excluded.cn_order, cl_static = excluded.cl_static, cv_url = excluded.cv_url, ck_icon = excluded.ck_icon, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_menu = excluded.cl_menu;
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)
select t.ck_id, t.ck_d_lang, t.cr_namespace, t.cv_value, t.ck_user, t.ct_change::timestamp from (
    select '6213f1138a534cc088ff1440bb472505' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Конструктор GUI' as cv_value, '-11' as ck_user, '2019-12-10T00:00:00.000+0000' as ct_change
) as t 
 join s_mt.t_d_lang dl
 on t.ck_d_lang = dl.ck_id
on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
