--liquibase formatted sql
--changeset patcher-core:Page_12987721 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
select pkg_patcher.p_remove_page('12987721');

INSERT INTO s_mt.t_page (ck_id, ck_parent, cr_type, cv_name, cn_order, cl_static, cv_url, ck_icon, ck_user, ct_change, cl_menu)VALUES('12987721', '5', 2, 'fa5c0a601c3845f0938602d0fa7f71dc', 5, 0, null, '526', '10020788', '2018-09-01T00:00:00.000+0000', 1) on conflict (ck_id) do update set ck_parent = excluded.ck_parent, cr_type = excluded.cr_type, cv_name = excluded.cv_name, cn_order = excluded.cn_order, cl_static = excluded.cl_static, cv_url = excluded.cv_url, ck_icon = excluded.ck_icon, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_menu = excluded.cl_menu;
INSERT INTO s_mt.t_page_action (ck_id, ck_page, cr_type, cn_action, ck_user, ct_change)VALUES('15227', '12987721', 'edit', 516, '10020788', '2018-09-01T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cr_type = excluded.cr_type, cn_action = excluded.cn_action, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_action (ck_id, ck_page, cr_type, cn_action, ck_user, ct_change)VALUES('15226', '12987721', 'view', 515, '10020788', '2018-09-01T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cr_type = excluded.cr_type, cn_action = excluded.cn_action, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
select pkg_patcher.p_merge_object('7255AC58F776470694BDE04EF5063179', '8', null, 'SYS Query Grid << DO NOT CHANGE', 1003000, 'MTQueryExtended', 'Сервисы t_query', null, null, null, '10020788', '2018-09-01T00:00:00.000+0000');
select pkg_patcher.p_merge_object('86E1138247FF58EAE053809BA8C096F6', '58', '7255AC58F776470694BDE04EF5063179', 'Query Filters panel', 1, null, 'Панель фильтров сервисов', 'b744eb99612247088221bfe583069d60', null, null, '20783', '2019-04-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object('585D9FB916024544B4AD52822CF6DFF6', '9', '7255AC58F776470694BDE04EF5063179', 'ck_id', 10, null, 'Имя сервиса', '002ec63ccef84e759841e7a7e25e27f1', null, null, '10020788', '2018-09-01T00:00:00.000+0000');
select pkg_patcher.p_merge_object('4B8AB86588DA424EBD4D6DF9A2E98085', '9', '7255AC58F776470694BDE04EF5063179', 'ck_provider', 30, null, 'Имя провайдера данных', 'aaf9025cde674df68d6f07e7fbfe6ee1', null, null, '10020788', '2018-09-01T00:00:00.000+0000');
select pkg_patcher.p_merge_object('7C8088D3D3B48928E053809BA8C0C76A', '9', '7255AC58F776470694BDE04EF5063179', 'cr_type', 33, null, 'cr_type', '4d8d29a47fe24d9381329c0510c05942', null, null, '20788', '2018-12-08T00:00:00.000+0000');
select pkg_patcher.p_merge_object('7C8088D3D3B58928E053809BA8C0C76A', '9', '7255AC58F776470694BDE04EF5063179', 'cr_access', 36, null, 'cr_access', 'f61b22bbb7144b1db8da8b64aa4847c8', null, null, '20788', '2018-12-08T00:00:00.000+0000');
select pkg_patcher.p_merge_object('1CCFF24F069A4D328611E3FB4A9249C8', '9', '7255AC58F776470694BDE04EF5063179', 'cv_used', 40, null, 'Где используется', '7444bf57e2044a2cb3fd266398ff7371', null, null, '10020788', '2018-09-01T00:00:00.000+0000');
select pkg_patcher.p_merge_object('86A49061739F2AFDE053809BA8C0EE3C', '26', '86E1138247FF58EAE053809BA8C096F6', 'Column ck_id', 10, null, 'Наименование сервиса', '29170697a3e946e182fabfc3f8f06d7e', null, null, '20783', '2019-04-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object('86B72CAAACA2437CE053809BA8C07CAA', '31', '86E1138247FF58EAE053809BA8C096F6', 'Column cv_used', 20, 'MTGetPage', 'Где используется', '7444bf57e2044a2cb3fd266398ff7371', null, null, '20783', '2019-04-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('86B72CAAAC9E437CE053809BA8C07CAA', '86A49061739F2AFDE053809BA8C0EE3C', '1054', '30%', '20783', '2019-04-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('8C5D922DDE8F4907E053809BA8C072F8', '7255AC58F776470694BDE04EF5063179', '1643', 'false', '20780', '2019-06-28T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('64197', '585D9FB916024544B4AD52822CF6DFF6', '179', '20%', '10020788', '2018-09-01T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('64192', '585D9FB916024544B4AD52822CF6DFF6', '47', 'ck_id', '10020788', '2018-09-01T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('64196', '7255AC58F776470694BDE04EF5063179', '852', 'ck_id', '10020788', '2018-09-01T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('86DF93672AAA58F0E053809BA8C0726A', '86A49061739F2AFDE053809BA8C0EE3C', '86', 'ck_id', '20783', '2019-04-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('86A4906173A62AFDE053809BA8C0EE3C', '86B72CAAACA2437CE053809BA8C07CAA', '1053', '60%', '20783', '2019-04-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('86B72CAAACA3437CE053809BA8C07CAA', '86B72CAAACA2437CE053809BA8C07CAA', '120', 'ck_page', '20783', '2019-04-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('86DF93672AAF58F0E053809BA8C0726A', '86B72CAAACA2437CE053809BA8C07CAA', '125', 'cv_name', '20783', '2019-04-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('86B72CAAACA4437CE053809BA8C07CAA', '86B72CAAACA2437CE053809BA8C07CAA', '126', 'ck_id', '20783', '2019-04-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('86E11382480C58EAE053809BA8C096F6', '86B72CAAACA2437CE053809BA8C07CAA', '127', 'remote', '20783', '2019-04-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('86E11382480D58EAE053809BA8C096F6', '86B72CAAACA2437CE053809BA8C07CAA', '863', 'cv_entered', '20783', '2019-04-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('64199', '4B8AB86588DA424EBD4D6DF9A2E98085', '179', '7%', '20788', '2018-12-08T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('64194', '4B8AB86588DA424EBD4D6DF9A2E98085', '47', 'ck_provider', '10020788', '2018-09-01T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('78518448421', '7C8088D3D3B48928E053809BA8C0C76A', '179', '10%', '20788', '2018-12-08T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('78496024221', '7C8088D3D3B48928E053809BA8C0C76A', '47', 'cr_type', '20788', '2018-12-08T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('78529660521', '7C8088D3D3B58928E053809BA8C0C76A', '179', '13%', '20788', '2018-12-08T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('78507236321', '7C8088D3D3B58928E053809BA8C0C76A', '47', 'cr_access', '20788', '2018-12-08T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('64200', '1CCFF24F069A4D328611E3FB4A9249C8', '179', '60%', '20788', '2018-12-08T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('64195', '1CCFF24F069A4D328611E3FB4A9249C8', '47', 'cv_used', '10020788', '2018-09-01T00:00:00.000+0000');
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('86E11382480E58EAE053809BA8C096F6', '12987721', '7255AC58F776470694BDE04EF5063179', 10, null, null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('86E11382481458EAE053809BA8C096F6', '12987721', '86E1138247FF58EAE053809BA8C096F6', 1, '86E11382480E58EAE053809BA8C096F6', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('86E11382480F58EAE053809BA8C096F6', '12987721', '585D9FB916024544B4AD52822CF6DFF6', 10, '86E11382480E58EAE053809BA8C096F6', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('86E11382481058EAE053809BA8C096F6', '12987721', '4B8AB86588DA424EBD4D6DF9A2E98085', 30, '86E11382480E58EAE053809BA8C096F6', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('86E11382481258EAE053809BA8C096F6', '12987721', '7C8088D3D3B48928E053809BA8C0C76A', 33, '86E11382480E58EAE053809BA8C096F6', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('86E11382481358EAE053809BA8C096F6', '12987721', '7C8088D3D3B58928E053809BA8C0C76A', 36, '86E11382480E58EAE053809BA8C096F6', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('86E11382481158EAE053809BA8C096F6', '12987721', '1CCFF24F069A4D328611E3FB4A9249C8', 40, '86E11382480E58EAE053809BA8C096F6', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('86E11382481658EAE053809BA8C096F6', '12987721', '86A49061739F2AFDE053809BA8C0EE3C', 10, '86E11382481458EAE053809BA8C096F6', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('86E11382481558EAE053809BA8C096F6', '12987721', '86B72CAAACA2437CE053809BA8C07CAA', 20, '86E11382481458EAE053809BA8C096F6', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;