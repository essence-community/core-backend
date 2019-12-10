--liquibase formatted sql
--changeset patcher-core:Page_12127721 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
with recursive page as (
select
    ck_id
from
    s_mt.t_page
where
    ck_id = '12127721'
union all
select
    p.ck_id
from
    s_mt.t_page p
join page rp on
    p.ck_parent = rp.ck_id )
delete
from
    s_mt.t_page_action ap
where ap.ck_page in (select ck_id from page);
with recursive page as (
select
    ck_id
from
    s_mt.t_page
where
    ck_id = '12127721'
union all
select
    p.ck_id
from
    s_mt.t_page p
join page rp on
    p.ck_parent = rp.ck_id )
delete
from
    s_mt.t_page_variable ap
where ap.ck_page in (select ck_id from page);
with recursive page_object as (
select
    ck_id
from
    s_mt.t_page_object
where
    ck_page in ( with recursive page as (
    select
        ck_id
    from
        s_mt.t_page
    where
        ck_id = '12127721'
union all
    select
        p.ck_id
    from
        s_mt.t_page p
    join page rp on
        p.ck_parent = rp.ck_id )
    select
        ck_id
    from
        page )
union all
select
    po.ck_id
from
    s_mt.t_page_object po
join page_object rp on
    po.ck_parent = rp.ck_id )
delete
from
    s_mt.t_page_object_attr attr
where attr.ck_page_object in (select ck_id from page_object);
with recursive page_object as (
select
    ck_id
from
    s_mt.t_page_object
where
    ck_page in ( with recursive page as (
    select
        ck_id
    from
        s_mt.t_page
    where
        ck_id = '12127721'
union all
    select
        p.ck_id
    from
        s_mt.t_page p
    join page rp on
        p.ck_parent = rp.ck_id )
    select
        ck_id
    from
        page )
union all
select
    po.ck_id
from
    s_mt.t_page_object po
join page_object rp on
    po.ck_parent = rp.ck_id )
delete
from
    s_mt.t_page_object ob
where ob.ck_id in (select ck_id from page_object);
with recursive page as (
select
    ck_id
from
    s_mt.t_page
where
    ck_id = '12127721'
union all
select
    p.ck_id
from
    s_mt.t_page p
join page rp on
    p.ck_parent = rp.ck_id )
delete
from
    s_mt.t_page p
where p.ck_id in (select ck_id from page);

INSERT INTO s_mt.t_page (ck_id, ck_parent, cr_type, cv_name, cn_order, cl_static, cv_url, ck_icon, ck_user, ct_change, cl_menu)VALUES('12127721', '4', 1, '23cba69b926e448bad49f78c20e6c38f', 10, 0, null, null, '20780', '2019-03-16T00:00:00.000+0000', 0) on conflict (ck_id) do update set ck_parent = excluded.ck_parent, cr_type = excluded.cr_type, cv_name = excluded.cv_name, cn_order = excluded.cn_order, cl_static = excluded.cl_static, cv_url = excluded.cv_url, ck_icon = excluded.ck_icon, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_menu = excluded.cl_menu;
INSERT INTO s_mt.t_page (ck_id, ck_parent, cr_type, cv_name, cn_order, cl_static, cv_url, ck_icon, ck_user, ct_change, cl_menu)VALUES('12128581', '12127721', 2, '0b1f0f88eab64838a2b8171fde789a70', 1, 0, null, '745', '10020788', '2018-08-17T00:00:00.000+0000', 0) on conflict (ck_id) do update set ck_parent = excluded.ck_parent, cr_type = excluded.cr_type, cv_name = excluded.cv_name, cn_order = excluded.cn_order, cl_static = excluded.cl_static, cv_url = excluded.cv_url, ck_icon = excluded.ck_icon, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_menu = excluded.cl_menu;
INSERT INTO s_mt.t_page_action (ck_id, ck_page, cr_type, cn_action, ck_user, ct_change)VALUES('12227', '12128581', 'edit', 516, '10020788', '2018-08-17T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cr_type = excluded.cr_type, cn_action = excluded.cn_action, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_action (ck_id, ck_page, cr_type, cn_action, ck_user, ct_change)VALUES('12226', '12128581', 'view', 515, '10020788', '2018-08-17T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cr_type = excluded.cr_type, cn_action = excluded.cn_action, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_variable (ck_id, ck_page, cv_name, cv_description, ck_user, ct_change)VALUES('723', '12128581', 'gck_page', 'скрытый ИД страницы, над которой сейчас идет работа внутри шага, нужно для корректной работы окна редактирования действия', '20788', '2018-10-25T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cv_name = excluded.cv_name, cv_description = excluded.cv_description, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_variable (ck_id, ck_page, cv_name, cv_description, ck_user, ct_change)VALUES('282', '12128581', 'gck_scenario', 'ИД сценария, над которым ведется работа', '10020788', '2018-08-19T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cv_name = excluded.cv_name, cv_description = excluded.cv_description, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_variable (ck_id, ck_page, cv_name, cv_description, ck_user, ct_change)VALUES('682', '12128581', 'gck_step', 'ИД шага, над которым ведется работа', '20788', '2018-10-17T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cv_name = excluded.cv_name, cv_description = excluded.cv_description, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
select pkg_patcher.p_merge_object('4475E8B33D4A4CC4A7CEEDC831330858', '8', null, 'Scenario Grid', 771, 'ATShowScenario', 'Сценарии автотестов', '0b1f0f88eab64838a2b8171fde789a70', 'pkg_json_scenario.f_modify_scenario', 'meta', '10020788', '2018-08-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object('5EF9A8D63E6C425895E7B4DD64C29FC4', '19', '4475E8B33D4A4CC4A7CEEDC831330858', 'create button', 0, null, 'Кнопка Создать организацию', '3a5239ee97d9464c9c4143c18fda9815', null, null, '10020788', '2018-08-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object('B74E10C540854F2CA49307176D110ABA', '16', '4475E8B33D4A4CC4A7CEEDC831330858', 'edit column', 1, null, 'edit column', null, null, null, '10020788', '2018-08-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object('6863F6CAF331403DB5B356AB8282321A', '77', '4475E8B33D4A4CC4A7CEEDC831330858', 'cn_order', 2, null, 'cn_order', '512e78221fce4e57b92fba397cb4a6bc', null, null, '10020788', '2018-08-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object('010E3129785E4E99A6B93DB708D423B4', '9', '4475E8B33D4A4CC4A7CEEDC831330858', 'cv_name', 3, null, 'cv_name', '93037706cacc453abc6d8437cddcef6c', null, null, '10020788', '2018-08-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object('3325297AD1154B428F7D3F98CF01F6B9', '36', '4475E8B33D4A4CC4A7CEEDC831330858', 'cl_valid', 4, null, 'cl_valid', '0ee4db8bcb3c4a7c9c33ded37aeb1485', null, null, '10020788', '2018-08-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object('6F07766E002C46348CA66385A3B1F5A7', '9', '4475E8B33D4A4CC4A7CEEDC831330858', 'cv_description', 5, null, 'cv_description', '900d174d0a994374a01b0005756521bc', null, null, '10020788', '2018-08-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('55073', '4475E8B33D4A4CC4A7CEEDC831330858', '853', 'asc', '10020788', '2018-08-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('55080', '4475E8B33D4A4CC4A7CEEDC831330858', '407', 'inline', '10020788', '2018-08-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('55072', '4475E8B33D4A4CC4A7CEEDC831330858', '852', 'cn_order', '10020788', '2018-08-21T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('55081', '5EF9A8D63E6C425895E7B4DD64C29FC4', '155', '1', '10020788', '2018-08-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('202030942021', '5EF9A8D63E6C425895E7B4DD64C29FC4', '992', 'fa-plus', '20780', '2019-01-13T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('55076', '6863F6CAF331403DB5B356AB8282321A', '444', 'cn_order', '10020788', '2018-08-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('55077', '010E3129785E4E99A6B93DB708D423B4', '47', 'cv_name', '10020788', '2018-08-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('96118', '010E3129785E4E99A6B93DB708D423B4', '662', '50', '20848', '2018-10-21T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('55078', '3325297AD1154B428F7D3F98CF01F6B9', '250', 'cl_valid', '10020788', '2018-08-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('55079', '6F07766E002C46348CA66385A3B1F5A7', '47', 'cv_description', '10020788', '2018-08-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('96117', '6F07766E002C46348CA66385A3B1F5A7', '662', '250', '20848', '2018-10-21T00:00:00.000+0000');
select pkg_patcher.p_merge_object('75378F5F391D63EFE053809BA8C03200', '8', null, 'Scenario Step Grid', 772, 'ATShowStep', 'Scenario Step Grid', 'e9d2834ba62647579a4f17283e0342a4', 'pkg_json_scenario.f_modify_step', 'meta', '10020788', '2018-09-09T00:00:00.000+0000');
select pkg_patcher.p_merge_object('75378F5F394663EFE053809BA8C03200', '19', '75378F5F391D63EFE053809BA8C03200', 'create button', 0, null, 'Кнопка Создать организацию', '3a5239ee97d9464c9c4143c18fda9815', null, null, '10020788', '2018-09-09T00:00:00.000+0000');
select pkg_patcher.p_merge_object('7881233F56D6301EE053809BA8C0193B', '77', '75378F5F391D63EFE053809BA8C03200', 'ck_id', 2, null, 'ck_id', null, null, null, '20788', '2018-10-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object('75443CA0E6F16840E053809BA8C02951', '16', '75378F5F391D63EFE053809BA8C03200', 'edit column', 5, null, 'edit column', null, null, null, '10020788', '2018-09-09T00:00:00.000+0000');
select pkg_patcher.p_merge_object('75443CA0E6F06840E053809BA8C02951', '77', '75378F5F391D63EFE053809BA8C03200', 'cn_order', 10, null, 'cn_order', '6d5eed4bd3004038ba9c29bff68dda3d', null, null, '10020788', '2018-09-08T00:00:00.000+0000');
select pkg_patcher.p_merge_object('7546D922464C63E5E053809BA8C0A5FE', '9', '75378F5F391D63EFE053809BA8C03200', 'cv_name', 20, 'ATGetJSONScenario', 'cv_name', '1d28e01513a74f9b9073640903205a3e', null, null, '10020848', '2018-09-09T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('66074', '75378F5F391D63EFE053809BA8C03200', '852', 'cn_order', '10020788', '2018-09-08T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('66081', '75378F5F394663EFE053809BA8C03200', '155', '1', '10020788', '2018-09-09T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('202580334921', '75378F5F394663EFE053809BA8C03200', '992', 'fa-plus', '20780', '2019-01-13T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('94120', '7881233F56D6301EE053809BA8C0193B', '444', 'ck_id', '20788', '2018-10-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('94121', '7881233F56D6301EE053809BA8C0193B', '451', 'false', '20788', '2018-10-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('102119', '7881233F56D6301EE053809BA8C0193B', '446', 'disabled', '20788', '2018-10-31T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('102120', '7881233F56D6301EE053809BA8C0193B', '1083', 'false', '20785', '2018-10-31T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('66072', '75443CA0E6F06840E053809BA8C02951', '444', 'cn_order', '10020788', '2018-09-08T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('66073', '7546D922464C63E5E053809BA8C0A5FE', '47', 'cv_name', '10020788', '2018-09-08T00:00:00.000+0000');
select pkg_patcher.p_merge_object('A68E08849DD1469C94FCEFFE9BC2F8BE', '8', null, 'Scenario Action Grid', 773, 'ATShowAction', 'Scenario Action Grid', 'f18ffe5bb03342cc9b7aeff150c7b7f6', 'pkg_json_scenario.f_modify_action', 'meta', '10020788', '2018-09-08T00:00:00.000+0000');
select pkg_patcher.p_merge_object('9170452F83A44A5A860503A946841282', '16', 'A68E08849DD1469C94FCEFFE9BC2F8BE', 'edit column', 0, null, 'edit column', null, null, null, '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object('6CBB87EE05E44135BE698831F69D0089', '77', 'A68E08849DD1469C94FCEFFE9BC2F8BE', 'cn_order', 10, null, 'cn_order', '3fa683657e964882bd7fb04cdafe2b2b', null, null, '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object('547C77C56D5743F4BC714267A70D268E', '9', 'A68E08849DD1469C94FCEFFE9BC2F8BE', 'cv_key', 20, null, 'cv_key', '441ea4d033cb40bc8e24fde9e1f95642', null, null, '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object('7ADF03850F41695EE053809BA8C06BEA', '9', 'A68E08849DD1469C94FCEFFE9BC2F8BE', 'ck_d_action', 25, null, 'ck_d_action', '6f26c504edde4fd0adc3c9630712623f', null, null, '20788', '2018-11-16T00:00:00.000+0000');
select pkg_patcher.p_merge_object('A55D847FD6F84BEE9C9C8B3AC920FDA1', '9', 'A68E08849DD1469C94FCEFFE9BC2F8BE', 'cv_value', 30, null, 'cv_value', '21886e99e642475f97fd558533a109ed', null, null, '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object('7AC7484B97015042E053809BA8C08EA4', '36', 'A68E08849DD1469C94FCEFFE9BC2F8BE', 'cl_expected', 32, null, 'cl_expected', 'a1a2d12475d34c538f3d0618370e39fa', null, null, '20788', '2018-11-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object('76DA546E56FC5729E053809BA8C03F28', '9', 'A68E08849DD1469C94FCEFFE9BC2F8BE', 'cv_name', 35, null, 'cv_name', '503985fc00c94c5fb39a1688e3dbd096', null, null, '10020788', '2018-09-26T00:00:00.000+0000');
select pkg_patcher.p_merge_object('674333317F284B35AAF191EE237642C5', '9', 'A68E08849DD1469C94FCEFFE9BC2F8BE', 'cv_description', 40, null, 'cv_description', '900d174d0a994374a01b0005756521bc', null, null, '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object('7922AEB2467268CFE053809BA8C06346', '77', 'A68E08849DD1469C94FCEFFE9BC2F8BE', 'ck_page hidden', 45, null, 'ck_page hidden column for editing', null, null, null, '20788', '2018-10-25T00:00:00.000+0000');
select pkg_patcher.p_merge_object('6F874D3322584C38A8259394D70793D6', '19', 'A68E08849DD1469C94FCEFFE9BC2F8BE', 'Add Page - Button', 50, null, 'Add Page - Button', '1abcf035d0434a95affa2ba415f99e60', null, null, '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object('F496BDACF8E24E63843342BB5E38F476', '19', 'A68E08849DD1469C94FCEFFE9BC2F8BE', 'Add PageObject - Button', 60, null, 'Add PageObject - Button', '214bfc6907aa40bdabb93f44d99b7e68', null, null, '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object('5A12051DD97349FA9E1E0335D812E2D5', '32', 'A68E08849DD1469C94FCEFFE9BC2F8BE', 'Window - Page', 100, null, 'Окно добавления/настройки страницы', '62ba2dc2dbe7407a9f555776acfd1e5b', null, null, '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object('C3D2D33E2CC347979F732F9C880D94F0', '32', 'A68E08849DD1469C94FCEFFE9BC2F8BE', 'Window - PageObject - Add', 200, null, 'Окно добавления/настройки PageObject', '86ea605d84c0496c87a7e4798ee0fc6f', null, null, '20788', '2018-10-25T00:00:00.000+0000');
select pkg_patcher.p_merge_object('791E9C69D08A26AAE053809BA8C0EE36', '32', 'A68E08849DD1469C94FCEFFE9BC2F8BE', 'Window - PageObject - Edit', 300, null, 'Окно добавления/настройки PageObject', '89b94396b8e44d54bb4672e15ff65ff2', null, null, '20788', '2018-10-27T00:00:00.000+0000');
select pkg_patcher.p_merge_object('FF11BEE0974440049116EE429CB912EB', '27', '5A12051DD97349FA9E1E0335D812E2D5', 'cn_order', 10, null, 'cn_order', 'a1907e490eeb42ed932fa6d06cd29164', null, null, '10020788', '2018-09-26T00:00:00.000+0000');
select pkg_patcher.p_merge_object('791E9C69D08B26AAE053809BA8C0EE36', '27', '791E9C69D08A26AAE053809BA8C0EE36', 'cn_order', 10, null, 'cn_order', 'ac7d5ad9fc3c4d868ab4bf4bb2d28042', null, null, '20788', '2018-10-25T00:00:00.000+0000');
select pkg_patcher.p_merge_object('6CEEC8AD01EE45A182D20A8EDF7EDAB3', '27', 'C3D2D33E2CC347979F732F9C880D94F0', 'cn_order', 10, null, 'cn_order', '3c38c81e05514b62800c8c549202663f', null, null, '10020788', '2018-09-26T00:00:00.000+0000');
select pkg_patcher.p_merge_object('791E9C69D09026AAE053809BA8C0EE36', '31', '791E9C69D08A26AAE053809BA8C0EE36', 'page - combobox', 20, 'ATGetPageAtEditing', 'page - combobox', 'd655b74cb6df4f229941dd2e0e14cb9d', null, null, '20788', '2018-10-27T00:00:00.000+0000');
select pkg_patcher.p_merge_object('031B4FB1AFBC4D4FB24607D9AF72732C', '31', 'C3D2D33E2CC347979F732F9C880D94F0', 'page - combobox', 20, 'ATGetPage', 'page - combobox', '949518d7b7e247c7842dc0ed9f4cf4e4', null, null, '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object('B76819BB9BB1455384B15A1BE9053171', '37', '5A12051DD97349FA9E1E0335D812E2D5', 'Field Page', 100, 'MTPage', 'Выбор страницы', 'c03f376224be47ffa3caa33867b49667', null, null, '10020788', '2018-08-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object('BED11E02B1C94229A401A953339BF918', '37', 'C3D2D33E2CC347979F732F9C880D94F0', 'Field PageObject', 100, 'MTPageObject', 'Выбор объекта', '1fa4173f948d4a699e37ac1c42742ee3', null, null, '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object('791E9C69D08F26AAE053809BA8C0EE36', '37', '791E9C69D08A26AAE053809BA8C0EE36', 'Field PageObject', 100, 'MTPageObject', 'Выбор объекта', '4b65c5b63be44b8ea044d9c47e7e5aab', null, null, '20788', '2018-10-25T00:00:00.000+0000');
select pkg_patcher.p_merge_object('7AF477E70B12854CE053809BA8C0F58B', '31', 'C3D2D33E2CC347979F732F9C880D94F0', 'ck_d_action', 110, 'ATShowDAction', 'ck_d_action', '3ac6bd4504f64f25997276ef43d0ea4b', null, null, '20788', '2018-11-18T00:00:00.000+0000');
select pkg_patcher.p_merge_object('7AF4749A594B8546E053809BA8C0404C', '31', '791E9C69D08A26AAE053809BA8C0EE36', 'ck_d_action', 110, 'ATShowDAction', 'ck_d_action', '9a20285b2cba45e9a207f7c546bc8850', null, null, '20788', '2018-11-18T00:00:00.000+0000');
select pkg_patcher.p_merge_object('76D9FA19C3FF5685E053809BA8C06F04', '26', '5A12051DD97349FA9E1E0335D812E2D5', 'cv_description', 120, null, 'cv_description', '900d174d0a994374a01b0005756521bc', null, null, '10020788', '2018-09-26T00:00:00.000+0000');
select pkg_patcher.p_merge_object('791E9C69D09126AAE053809BA8C0EE36', '26', '791E9C69D08A26AAE053809BA8C0EE36', 'cv_value', 120, null, 'cv_value', '21fe3558a31c44ef8c93da0d7cd79d3b', null, null, '20788', '2018-10-25T00:00:00.000+0000');
select pkg_patcher.p_merge_object('F81F9ED51BB64B50B8D477B18584B753', '26', 'C3D2D33E2CC347979F732F9C880D94F0', 'cv_value', 120, null, 'cv_value', '7766a06d4eb548b5ab48d77763820a64', null, null, '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object('7AF477E70ADA854CE053809BA8C0F58B', '29', '791E9C69D08A26AAE053809BA8C0EE36', 'cl_expected', 125, null, 'cl_expected', 'c231e34e776947b99aadc512dffdcfa1', null, null, '20788', '2018-11-18T00:00:00.000+0000');
select pkg_patcher.p_merge_object('7AF477E70B13854CE053809BA8C0F58B', '29', 'C3D2D33E2CC347979F732F9C880D94F0', 'cl_expected', 125, null, 'cl_expected', '8cd4ba6597f44711a705725cfca6f41f', null, null, '20788', '2018-11-18T00:00:00.000+0000');
select pkg_patcher.p_merge_object('76D9FA19C4005685E053809BA8C06F04', '26', 'C3D2D33E2CC347979F732F9C880D94F0', 'cv_description', 130, null, 'cv_description', '900d174d0a994374a01b0005756521bc', null, null, '10020788', '2018-09-26T00:00:00.000+0000');
select pkg_patcher.p_merge_object('791E9C69D09226AAE053809BA8C0EE36', '26', '791E9C69D08A26AAE053809BA8C0EE36', 'cv_description', 130, null, 'cv_description', '900d174d0a994374a01b0005756521bc', null, null, '20788', '2018-10-25T00:00:00.000+0000');
select pkg_patcher.p_merge_object('A3830EF05D7F4939BD550E2B1E1BC807', '19', 'C3D2D33E2CC347979F732F9C880D94F0', 'Button Save', 250, null, 'Button Save', '65cf41472f334981b05c9946ddabfd92', null, null, '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object('0BF74ACC2DCA42BD9DBC75FAF17DEA0C', '19', '5A12051DD97349FA9E1E0335D812E2D5', 'Button Save', 250, null, 'Button Save', '1b9494d74b6446ac88da6aa65b9b362f', null, null, '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object('791E9C69D08E26AAE053809BA8C0EE36', '19', '791E9C69D08A26AAE053809BA8C0EE36', 'Button Save', 250, null, 'Button Save', '5f11e4c7232e4b3c9617b2f85302eeb3', null, null, '20788', '2018-10-25T00:00:00.000+0000');
select pkg_patcher.p_merge_object('3EA37F331C244CB1B21A70EBC7F82AB1', '19', '5A12051DD97349FA9E1E0335D812E2D5', 'Button Close Window', 300, null, 'Button Close Window', '64aacc431c4c4640b5f2c45def57cae9', null, null, '10020788', '2018-08-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object('791E9C69D08C26AAE053809BA8C0EE36', '19', '791E9C69D08A26AAE053809BA8C0EE36', 'Button Close Window', 300, null, 'Button Close Window', '64aacc431c4c4640b5f2c45def57cae9', null, null, '20788', '2018-10-25T00:00:00.000+0000');
select pkg_patcher.p_merge_object('D460E023593541FC86DCDEC55BD017E0', '19', 'C3D2D33E2CC347979F732F9C880D94F0', 'Button Close Window', 300, null, 'Button Close Window', '64aacc431c4c4640b5f2c45def57cae9', null, null, '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object('F0E5164DB5854ECE8FAED2F6618C3D6B', '17', 'B76819BB9BB1455384B15A1BE9053171', 'cv_name', 100, null, 'cv_name', '17ec819d20d24cac9b0e42bd81185ef9', null, null, '10020788', '2018-08-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object('791E9C69D09426AAE053809BA8C0EE36', '17', '791E9C69D08F26AAE053809BA8C0EE36', 'cv_name', 100, null, 'cv_name', 'f57b674688784465adf25e7f17025839', null, null, '20788', '2018-10-25T00:00:00.000+0000');
select pkg_patcher.p_merge_object('78C410DA7C81487A9002A0B352751434', '17', 'BED11E02B1C94229A401A953339BF918', 'cv_name', 100, null, 'cv_name', '981ea57059a94806a93f114da535e347', null, null, '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object('E3798BBFF9DD4D00ADB6FE5CC15F08D3', '77', 'B76819BB9BB1455384B15A1BE9053171', 'cn_order', 200, null, 'cn_order', '40ff9fd2c8c64a77bb027f048881a0d9', null, null, '10020788', '2018-08-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object('791E9C69D09326AAE053809BA8C0EE36', '77', '791E9C69D08F26AAE053809BA8C0EE36', 'cn_order', 200, null, 'cn_order', '077eb1ec92924960a8a315b011c769e4', null, null, '20788', '2018-10-25T00:00:00.000+0000');
select pkg_patcher.p_merge_object('48D46FB3D8BA4D56B916225D7E40D4E4', '77', 'BED11E02B1C94229A401A953339BF918', 'cn_order', 200, null, 'cn_order', 'eeff0fc849ae4010bcd942e29104a755', null, null, '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('55075', 'A68E08849DD1469C94FCEFFE9BC2F8BE', '853', 'asc', '10020788', '2018-08-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('55074', 'A68E08849DD1469C94FCEFFE9BC2F8BE', '852', 'cn_order', '10020788', '2018-08-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('64189', '9170452F83A44A5A860503A946841282', '1493', 'cv_row_type === "page" ? "addeditpage" : "editpageobject"', '20788', '2018-10-27T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('56094', '6CBB87EE05E44135BE698831F69D0089', '444', 'cn_order', '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('56095', '547C77C56D5743F4BC714267A70D268E', '47', 'cv_key', '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('109117', '7ADF03850F41695EE053809BA8C06BEA', '47', 'ck_d_action', '20788', '2018-11-16T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('56096', 'A55D847FD6F84BEE9C9C8B3AC920FDA1', '47', 'cv_value', '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('110117', '7AC7484B97015042E053809BA8C08EA4', '250', 'cl_expected', '20788', '2018-11-18T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('80126', '76DA546E56FC5729E053809BA8C03F28', '47', 'cv_name', '10020788', '2018-09-26T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('56097', '674333317F284B35AAF191EE237642C5', '47', 'cv_description', '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('97180', '7922AEB2467268CFE053809BA8C06346', '444', 'ck_page', '20788', '2018-10-25T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('97179', '7922AEB2467268CFE053809BA8C06346', '451', 'false', '20788', '2018-10-25T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('55086', '6F874D3322584C38A8259394D70793D6', '140', 'onCreateChildWindowMaster', '10020788', '2018-08-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('55084', '6F874D3322584C38A8259394D70793D6', '155', '1', '10020788', '2018-08-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('55085', '6F874D3322584C38A8259394D70793D6', '992', 'fa-file-powerpoint-o', '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('55083', '6F874D3322584C38A8259394D70793D6', '1033', 'addeditpage', '20788', '2018-10-25T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('56091', 'F496BDACF8E24E63843342BB5E38F476', '140', 'onCreateChildWindowMaster', '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('56088', 'F496BDACF8E24E63843342BB5E38F476', '1033', 'addpageobject', '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('56089', 'F496BDACF8E24E63843342BB5E38F476', '155', '1', '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('56090', 'F496BDACF8E24E63843342BB5E38F476', '992', 'fa-gavel', '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('55155', '5A12051DD97349FA9E1E0335D812E2D5', '1029', 'addeditpage', '20788', '2018-10-25T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('56080', 'C3D2D33E2CC347979F732F9C880D94F0', '1029', 'addpageobject', '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('97156', '791E9C69D08A26AAE053809BA8C0EE36', '1029', 'editpageobject', '20788', '2018-10-25T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('56099', 'FF11BEE0974440049116EE429CB912EB', '72', 'true', '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('56098', '6CEEC8AD01EE45A182D20A8EDF7EDAB3', '72', 'true', '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('56087', 'FF11BEE0974440049116EE429CB912EB', '85', 'cn_order', '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('56086', '6CEEC8AD01EE45A182D20A8EDF7EDAB3', '85', 'cn_order', '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('97148', '791E9C69D08B26AAE053809BA8C0EE36', '72', 'true', '20788', '2018-10-25T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('97147', '791E9C69D08B26AAE053809BA8C0EE36', '85', 'cn_order', '20788', '2018-10-25T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('56093', '031B4FB1AFBC4D4FB24607D9AF72732C', '126', 'ck_id', '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('56092', '031B4FB1AFBC4D4FB24607D9AF72732C', '125', 'cv_name', '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('56106', '031B4FB1AFBC4D4FB24607D9AF72732C', '1013', 'true', '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('80122', '031B4FB1AFBC4D4FB24607D9AF72732C', '123', 'true', '10020788', '2018-09-26T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('80118', '031B4FB1AFBC4D4FB24607D9AF72732C', '870', '##first##', '10020788', '2018-09-26T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('80119', '031B4FB1AFBC4D4FB24607D9AF72732C', '120', 'ck_page', '10020788', '2018-09-26T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('97164', '791E9C69D09026AAE053809BA8C0EE36', '126', 'ck_id', '20788', '2018-10-25T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('97166', '791E9C69D09026AAE053809BA8C0EE36', '1013', 'true', '20788', '2018-10-25T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('97171', '791E9C69D09026AAE053809BA8C0EE36', '123', 'true', '20788', '2018-10-25T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('97167', '791E9C69D09026AAE053809BA8C0EE36', '870', '##first##', '20788', '2018-10-27T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('97168', '791E9C69D09026AAE053809BA8C0EE36', '120', 'ck_page', '20788', '2018-10-27T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('97163', '791E9C69D09026AAE053809BA8C0EE36', '125', 'cv_name', '20788', '2018-10-27T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('55161', 'B76819BB9BB1455384B15A1BE9053171', '858', 'asc', '10020788', '2018-08-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('55157', 'B76819BB9BB1455384B15A1BE9053171', '994', null, '10020788', '2018-08-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('55154', 'B76819BB9BB1455384B15A1BE9053171', '361', 'cv_name', '10020788', '2018-08-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('55152', 'B76819BB9BB1455384B15A1BE9053171', '267', 'ck_id', '10020788', '2018-08-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('55150', 'B76819BB9BB1455384B15A1BE9053171', '859', 'cn_order', '10020788', '2018-08-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('55148', 'B76819BB9BB1455384B15A1BE9053171', '261', 'ck_page', '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('80121', 'B76819BB9BB1455384B15A1BE9053171', '264', 'true', '10020788', '2018-09-26T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('56077', 'BED11E02B1C94229A401A953339BF918', '859', 'cn_order', '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('56074', 'BED11E02B1C94229A401A953339BF918', '858', 'asc', '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('56076', 'BED11E02B1C94229A401A953339BF918', '261', 'ck_page_object', '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('56078', 'BED11E02B1C94229A401A953339BF918', '267', 'ck_id', '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('56079', 'BED11E02B1C94229A401A953339BF918', '361', 'cv_name_object', '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('56082', 'BED11E02B1C94229A401A953339BF918', '994', null, '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('80123', 'BED11E02B1C94229A401A953339BF918', '264', 'true', '10020788', '2018-09-26T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('97172', '791E9C69D08F26AAE053809BA8C0EE36', '264', 'true', '20788', '2018-10-25T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('97150', '791E9C69D08F26AAE053809BA8C0EE36', '858', 'asc', '20788', '2018-10-25T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('97158', '791E9C69D08F26AAE053809BA8C0EE36', '994', null, '20788', '2018-10-25T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('97154', '791E9C69D08F26AAE053809BA8C0EE36', '267', 'ck_id', '20788', '2018-10-25T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('97153', '791E9C69D08F26AAE053809BA8C0EE36', '859', 'cn_order', '20788', '2018-10-25T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('97155', '791E9C69D08F26AAE053809BA8C0EE36', '361', 'cv_name_object', '20788', '2018-10-27T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('97152', '791E9C69D08F26AAE053809BA8C0EE36', '261', 'ck_page_object', '20788', '2018-10-27T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('111163', '7AF477E70B12854CE053809BA8C0F58B', '123', 'true', '20788', '2018-11-18T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('110119', '7AF4749A594B8546E053809BA8C0404C', '125', 'ck_id', '20788', '2018-11-18T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('111162', '7AF4749A594B8546E053809BA8C0404C', '123', 'true', '20788', '2018-11-18T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('110120', '7AF4749A594B8546E053809BA8C0404C', '126', 'ck_id', '20788', '2018-11-18T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('110123', '7AF477E70B12854CE053809BA8C0F58B', '120', 'ck_d_action', '20788', '2018-11-18T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('110124', '7AF477E70B12854CE053809BA8C0F58B', '125', 'ck_id', '20788', '2018-11-18T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('110125', '7AF477E70B12854CE053809BA8C0F58B', '126', 'ck_id', '20788', '2018-11-18T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('110122', '7AF4749A594B8546E053809BA8C0404C', '120', 'ck_d_action', '20788', '2018-11-18T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('80124', '76D9FA19C3FF5685E053809BA8C06F04', '86', 'cv_description', '10020788', '2018-09-26T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('80127', 'F81F9ED51BB64B50B8D477B18584B753', '86', 'cv_value', '10020788', '2018-09-26T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('97170', '791E9C69D09126AAE053809BA8C0EE36', '86', 'cv_value', '20788', '2018-10-25T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('110118', '7AF477E70ADA854CE053809BA8C0F58B', '869', '1', '20788', '2018-11-18T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('110126', '7AF477E70B13854CE053809BA8C0F58B', '94', 'cl_expected', '20788', '2018-11-18T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('110127', '7AF477E70B13854CE053809BA8C0F58B', '869', '1', '20788', '2018-11-18T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('110121', '7AF477E70ADA854CE053809BA8C0F58B', '94', 'cl_expected', '20788', '2018-11-18T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('80125', '76D9FA19C4005685E053809BA8C06F04', '86', 'cv_description', '10020788', '2018-09-26T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('97169', '791E9C69D09226AAE053809BA8C0EE36', '86', 'cv_description', '20788', '2018-10-25T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('55165', '0BF74ACC2DCA42BD9DBC75FAF17DEA0C', '140', 'onSimpleSaveWindow', '10020788', '2018-08-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('56075', 'A3830EF05D7F4939BD550E2B1E1BC807', '140', 'onSimpleSaveWindow', '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('97151', '791E9C69D08E26AAE053809BA8C0EE36', '140', 'onSimpleSaveWindow', '20788', '2018-10-25T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('55159', '3EA37F331C244CB1B21A70EBC7F82AB1', '140', 'onCloseWindow', '10020788', '2018-08-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('55160', '3EA37F331C244CB1B21A70EBC7F82AB1', '147', '2', '10020788', '2018-08-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('56084', 'D460E023593541FC86DCDEC55BD017E0', '140', 'onCloseWindow', '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('56085', 'D460E023593541FC86DCDEC55BD017E0', '147', '2', '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('97160', '791E9C69D08C26AAE053809BA8C0EE36', '140', 'onCloseWindow', '20788', '2018-10-25T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('97161', '791E9C69D08C26AAE053809BA8C0EE36', '147', '2', '20788', '2018-10-25T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('55158', 'F0E5164DB5854ECE8FAED2F6618C3D6B', '52', 'cv_name', '10020788', '2018-08-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('56083', '78C410DA7C81487A9002A0B352751434', '52', 'cv_name_object', '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('97159', '791E9C69D09426AAE053809BA8C0EE36', '52', 'cv_name_object', '20788', '2018-10-25T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('55163', 'E3798BBFF9DD4D00ADB6FE5CC15F08D3', '444', 'cn_order', '10020788', '2018-08-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('56073', '48D46FB3D8BA4D56B916225D7E40D4E4', '444', 'cn_order', '10020788', '2018-08-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('97149', '791E9C69D09326AAE053809BA8C0EE36', '444', 'cn_order', '20788', '2018-10-25T00:00:00.000+0000');
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CE28540E053809BA8C07007', '12128581', '4475E8B33D4A4CC4A7CEEDC831330858', 10, null, null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CDC8540E053809BA8C07007', '12128581', '75378F5F391D63EFE053809BA8C03200', 20, null, null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CB08540E053809BA8C07007', '12128581', 'A68E08849DD1469C94FCEFFE9BC2F8BE', 30, null, null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CDE8540E053809BA8C07007', '12128581', '75378F5F394663EFE053809BA8C03200', 0, '7AF4B54D1CDC8540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CE88540E053809BA8C07007', '12128581', '5EF9A8D63E6C425895E7B4DD64C29FC4', 0, '7AF4B54D1CE28540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CB98540E053809BA8C07007', '12128581', '9170452F83A44A5A860503A946841282', 0, '7AF4B54D1CB08540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CE48540E053809BA8C07007', '12128581', 'B74E10C540854F2CA49307176D110ABA', 1, '7AF4B54D1CE28540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CDF8540E053809BA8C07007', '12128581', '7881233F56D6301EE053809BA8C0193B', 2, '7AF4B54D1CDC8540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CE58540E053809BA8C07007', '12128581', '6863F6CAF331403DB5B356AB8282321A', 2, '7AF4B54D1CE28540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CE68540E053809BA8C07007', '12128581', '010E3129785E4E99A6B93DB708D423B4', 3, '7AF4B54D1CE28540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CE38540E053809BA8C07007', '12128581', '3325297AD1154B428F7D3F98CF01F6B9', 4, '7AF4B54D1CE28540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CE78540E053809BA8C07007', '12128581', '6F07766E002C46348CA66385A3B1F5A7', 5, '7AF4B54D1CE28540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CE18540E053809BA8C07007', '12128581', '75443CA0E6F16840E053809BA8C02951', 5, '7AF4B54D1CDC8540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CB28540E053809BA8C07007', '12128581', '6CBB87EE05E44135BE698831F69D0089', 10, '7AF4B54D1CB08540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CE08540E053809BA8C07007', '12128581', '75443CA0E6F06840E053809BA8C02951', 10, '7AF4B54D1CDC8540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CBA8540E053809BA8C07007', '12128581', '547C77C56D5743F4BC714267A70D268E', 20, '7AF4B54D1CB08540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CDD8540E053809BA8C07007', '12128581', '7546D922464C63E5E053809BA8C0A5FE', 20, '7AF4B54D1CDC8540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CBE8540E053809BA8C07007', '12128581', '7ADF03850F41695EE053809BA8C06BEA', 25, '7AF4B54D1CB08540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CB38540E053809BA8C07007', '12128581', 'A55D847FD6F84BEE9C9C8B3AC920FDA1', 30, '7AF4B54D1CB08540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CBD8540E053809BA8C07007', '12128581', '7AC7484B97015042E053809BA8C08EA4', 32, '7AF4B54D1CB08540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CBC8540E053809BA8C07007', '12128581', '76DA546E56FC5729E053809BA8C03F28', 35, '7AF4B54D1CB08540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CB48540E053809BA8C07007', '12128581', '674333317F284B35AAF191EE237642C5', 40, '7AF4B54D1CB08540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CBB8540E053809BA8C07007', '12128581', '7922AEB2467268CFE053809BA8C06346', 45, '7AF4B54D1CB08540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CB58540E053809BA8C07007', '12128581', '6F874D3322584C38A8259394D70793D6', 50, '7AF4B54D1CB08540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CB88540E053809BA8C07007', '12128581', 'F496BDACF8E24E63843342BB5E38F476', 60, '7AF4B54D1CB08540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CB68540E053809BA8C07007', '12128581', '5A12051DD97349FA9E1E0335D812E2D5', 100, '7AF4B54D1CB08540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CB78540E053809BA8C07007', '12128581', 'C3D2D33E2CC347979F732F9C880D94F0', 200, '7AF4B54D1CB08540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CB18540E053809BA8C07007', '12128581', '791E9C69D08A26AAE053809BA8C0EE36', 300, '7AF4B54D1CB08540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CCA8540E053809BA8C07007', '12128581', 'FF11BEE0974440049116EE429CB912EB', 10, '7AF4B54D1CB68540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CCD8540E053809BA8C07007', '12128581', '6CEEC8AD01EE45A182D20A8EDF7EDAB3', 10, '7AF4B54D1CB78540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CC28540E053809BA8C07007', '12128581', '791E9C69D08B26AAE053809BA8C0EE36', 10, '7AF4B54D1CB18540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CC58540E053809BA8C07007', '12128581', '791E9C69D09026AAE053809BA8C0EE36', 20, '7AF4B54D1CB18540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CD18540E053809BA8C07007', '12128581', '031B4FB1AFBC4D4FB24607D9AF72732C', 20, '7AF4B54D1CB78540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CC98540E053809BA8C07007', '12128581', 'B76819BB9BB1455384B15A1BE9053171', 100, '7AF4B54D1CB68540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CD08540E053809BA8C07007', '12128581', 'BED11E02B1C94229A401A953339BF918', 100, '7AF4B54D1CB78540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CC18540E053809BA8C07007', '12128581', '791E9C69D08F26AAE053809BA8C0EE36', 100, '7AF4B54D1CB18540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CD48540E053809BA8C07007', '12128581', '7AF477E70B12854CE053809BA8C0F58B', 110, '7AF4B54D1CB78540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CC68540E053809BA8C07007', '12128581', '7AF4749A594B8546E053809BA8C0404C', 110, '7AF4B54D1CB18540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CCC8540E053809BA8C07007', '12128581', '76D9FA19C3FF5685E053809BA8C06F04', 120, '7AF4B54D1CB68540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CD28540E053809BA8C07007', '12128581', 'F81F9ED51BB64B50B8D477B18584B753', 120, '7AF4B54D1CB78540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CC48540E053809BA8C07007', '12128581', '791E9C69D09126AAE053809BA8C0EE36', 120, '7AF4B54D1CB18540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CC78540E053809BA8C07007', '12128581', '7AF477E70ADA854CE053809BA8C0F58B', 125, '7AF4B54D1CB18540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CD58540E053809BA8C07007', '12128581', '7AF477E70B13854CE053809BA8C0F58B', 125, '7AF4B54D1CB78540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CD38540E053809BA8C07007', '12128581', '76D9FA19C4005685E053809BA8C06F04', 130, '7AF4B54D1CB78540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CC38540E053809BA8C07007', '12128581', '791E9C69D09226AAE053809BA8C0EE36', 130, '7AF4B54D1CB18540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CCF8540E053809BA8C07007', '12128581', 'A3830EF05D7F4939BD550E2B1E1BC807', 250, '7AF4B54D1CB78540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CCB8540E053809BA8C07007', '12128581', '0BF74ACC2DCA42BD9DBC75FAF17DEA0C', 250, '7AF4B54D1CB68540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CC08540E053809BA8C07007', '12128581', '791E9C69D08E26AAE053809BA8C0EE36', 250, '7AF4B54D1CB18540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CC88540E053809BA8C07007', '12128581', '3EA37F331C244CB1B21A70EBC7F82AB1', 300, '7AF4B54D1CB68540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CBF8540E053809BA8C07007', '12128581', '791E9C69D08C26AAE053809BA8C0EE36', 300, '7AF4B54D1CB18540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CCE8540E053809BA8C07007', '12128581', 'D460E023593541FC86DCDEC55BD017E0', 300, '7AF4B54D1CB78540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CD88540E053809BA8C07007', '12128581', 'F0E5164DB5854ECE8FAED2F6618C3D6B', 100, '7AF4B54D1CC98540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CDB8540E053809BA8C07007', '12128581', '78C410DA7C81487A9002A0B352751434', 100, '7AF4B54D1CD08540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CD78540E053809BA8C07007', '12128581', '791E9C69D09426AAE053809BA8C0EE36', 100, '7AF4B54D1CC18540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CD68540E053809BA8C07007', '12128581', '791E9C69D09326AAE053809BA8C0EE36', 200, '7AF4B54D1CC18540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CDA8540E053809BA8C07007', '12128581', '48D46FB3D8BA4D56B916225D7E40D4E4', 200, '7AF4B54D1CD08540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7AF4B54D1CD98540E053809BA8C07007', '12128581', 'E3798BBFF9DD4D00ADB6FE5CC15F08D3', 200, '7AF4B54D1CC98540E053809BA8C07007', null, '20788', '2018-11-18T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('100490', '7AF4B54D1CE28540E053809BA8C07007', '1204', 'gck_scenario', '20788', '2018-11-18T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('100485', '7AF4B54D1CB08540E053809BA8C07007', '1204', 'ck_page=gck_page', '20788', '2018-11-18T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('100489', '7AF4B54D1CDC8540E053809BA8C07007', '1204', 'ck_id=gck_step', '20788', '2018-11-18T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('100488', '7AF4B54D1CDC8540E053809BA8C07007', '853', 'ASC', '20788', '2018-11-18T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('100486', '7AF4B54D1CC58540E053809BA8C07007', '1219', 'gck_page', '20788', '2018-11-18T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('100487', '7AF4B54D1CD18540E053809BA8C07007', '1219', 'gck_step', '20788', '2018-11-18T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
update s_mt.t_page_object set ck_master='7AF4B54D1CDC8540E053809BA8C07007' where ck_id='7AF4B54D1CB08540E053809BA8C07007';
update s_mt.t_page_object set ck_master='7AF4B54D1CB08540E053809BA8C07007' where ck_id='7AF4B54D1CC08540E053809BA8C07007';
update s_mt.t_page_object set ck_master='7AF4B54D1CC58540E053809BA8C07007' where ck_id='7AF4B54D1CC18540E053809BA8C07007';
update s_mt.t_page_object set ck_master='7AF4B54D1CB08540E053809BA8C07007' where ck_id='7AF4B54D1CCB8540E053809BA8C07007';
update s_mt.t_page_object set ck_master='7AF4B54D1CB08540E053809BA8C07007' where ck_id='7AF4B54D1CCF8540E053809BA8C07007';
update s_mt.t_page_object set ck_master='7AF4B54D1CD18540E053809BA8C07007' where ck_id='7AF4B54D1CD08540E053809BA8C07007';
update s_mt.t_page_object set ck_master='7AF4B54D1CCD8540E053809BA8C07007' where ck_id='7AF4B54D1CD18540E053809BA8C07007';
update s_mt.t_page_object set ck_master='7AF4B54D1CE28540E053809BA8C07007' where ck_id='7AF4B54D1CDC8540E053809BA8C07007';
