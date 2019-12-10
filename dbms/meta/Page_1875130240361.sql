--liquibase formatted sql
--changeset patcher-core:Page_1875130240361 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
with recursive page as (
select
    ck_id
from
    s_mt.t_page
where
    ck_id = '1875130240361'
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
    ck_id = '1875130240361'
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
        ck_id = '1875130240361'
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
        ck_id = '1875130240361'
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
    ck_id = '1875130240361'
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

INSERT INTO s_mt.t_page (ck_id, ck_parent, cr_type, cv_name, cn_order, cl_static, cv_url, ck_icon, ck_user, ct_change, cl_menu)VALUES('1875130240361', null, 0, '63f4d73447ea4da880234a577c7301b6', 10, 0, null, null, '20780', '2019-03-27T00:00:00.000+0000', 0) on conflict (ck_id) do update set ck_parent = excluded.ck_parent, cr_type = excluded.cr_type, cv_name = excluded.cv_name, cn_order = excluded.cn_order, cl_static = excluded.cl_static, cv_url = excluded.cv_url, ck_icon = excluded.ck_icon, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_menu = excluded.cl_menu;
INSERT INTO s_mt.t_page (ck_id, ck_parent, cr_type, cv_name, cn_order, cl_static, cv_url, ck_icon, ck_user, ct_change, cl_menu)VALUES('1875398035771', '1875130240361', 2, 'e571d8599bc8466aac42ade8b1891e44', 1, 0, null, '5', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-08-22T00:00:00.000+0000', 0) on conflict (ck_id) do update set ck_parent = excluded.ck_parent, cr_type = excluded.cr_type, cv_name = excluded.cv_name, cn_order = excluded.cn_order, cl_static = excluded.cl_static, cv_url = excluded.cv_url, ck_icon = excluded.ck_icon, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_menu = excluded.cl_menu;
INSERT INTO s_mt.t_page_action (ck_id, ck_page, cr_type, cn_action, ck_user, ct_change)VALUES('2739563307', '1875398035771', 'edit', 504, '20780', '2019-01-20T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cr_type = excluded.cr_type, cn_action = excluded.cn_action, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_action (ck_id, ck_page, cr_type, cn_action, ck_user, ct_change)VALUES('2739221037', '1875398035771', 'view', 503, '20780', '2019-01-20T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cr_type = excluded.cr_type, cn_action = excluded.cn_action, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_variable (ck_id, ck_page, cv_name, cv_description, ck_user, ct_change)VALUES('867CA355C1024D308A75AAA5FD6C7390', '1875398035771', 'gSessCvLogin', 'логин', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-08-22T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cv_name = excluded.cv_name, cv_description = excluded.cv_description, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_variable (ck_id, ck_page, cv_name, cv_description, ck_user, ct_change)VALUES('AFBB8C4D0677410C85D99022B0CFCFE5', '1875398035771', 'gSessCvName', 'имя', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-08-22T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cv_name = excluded.cv_name, cv_description = excluded.cv_description, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_variable (ck_id, ck_page, cv_name, cv_description, ck_user, ct_change)VALUES('85A357E10E8A4CDCBE3AA3ADEB883108', '1875398035771', 'gSessCvSurname', 'Фамилия', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-08-22T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cv_name = excluded.cv_name, cv_description = excluded.cv_description, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_variable (ck_id, ck_page, cv_name, cv_description, ck_user, ct_change)VALUES('2032473', '1875398035771', 'g_cd_period', 'Период', '20786', '2018-12-24T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cv_name = excluded.cv_name, cv_description = excluded.cv_description, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
select pkg_patcher.p_merge_object('7DD501DC87595167E053809BA8C05540', '137', null, 'SYS Menu Profile', 1000950, null, 'Профиль', null, null, null, '20786', '2018-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object('7DD501DC875A5167E053809BA8C05540', '26', '7DD501DC87595167E053809BA8C05540', 'Field Login', 10, null, 'Логин', '27153827faa648bb920aec6b06c0f45a', null, null, '20786', '2018-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object('7DD51E27188751DDE053809BA8C01BB0', '26', '7DD501DC87595167E053809BA8C05540', 'Field FIO', 20, null, 'ФИО', '1740026cff1e45a9a13eeb3302428dc0', null, null, '20786', '2018-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object('7DD51E27188851DDE053809BA8C01BB0', '26', '7DD501DC87595167E053809BA8C05540', 'Field', 30, null, 'E-MAIL', 'cd78af76de0a40c7a56052936666e3e8', null, null, '20786', '2018-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('147652257021', '7DD501DC87595167E053809BA8C05540', '609', 'vbox', '20786', '2018-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('147921347421', '7DD501DC875A5167E053809BA8C05540', '899', 'true', '20786', '2018-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('147663469121', '7DD501DC875A5167E053809BA8C05540', '86', 'cv_login', '20786', '2018-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('147674681221', '7DD51E27188751DDE053809BA8C01BB0', '86', 'cv_full_name', '20786', '2018-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('147910135321', '7DD51E27188751DDE053809BA8C01BB0', '899', 'true', '20786', '2018-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('147685893321', '7DD51E27188851DDE053809BA8C01BB0', '86', 'cv_email', '20786', '2018-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('147932559521', '7DD51E27188851DDE053809BA8C01BB0', '899', 'true', '20786', '2018-12-24T00:00:00.000+0000');
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7DD74166ADDA5F9FE053809BA8C0134E', '1875398035771', '7DD501DC87595167E053809BA8C05540', 10, null, null, '20786', '2018-12-24T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7DD74166ADE15F9FE053809BA8C0134E', '1875398035771', '7DD501DC875A5167E053809BA8C05540', 10, '7DD74166ADDA5F9FE053809BA8C0134E', null, '20786', '2018-12-24T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7DD74166ADDB5F9FE053809BA8C0134E', '1875398035771', '7DD51E27188751DDE053809BA8C01BB0', 20, '7DD74166ADDA5F9FE053809BA8C0134E', null, '20786', '2018-12-24T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7DD74166ADDC5F9FE053809BA8C0134E', '1875398035771', '7DD51E27188851DDE053809BA8C01BB0', 30, '7DD74166ADDA5F9FE053809BA8C0134E', null, '20786', '2018-12-24T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('6A445F6E82854035846AD981904C93BD', '7DD74166ADE15F9FE053809BA8C0134E', '1160', 'gSessCvLogin', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-08-22T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('4FCAFAEF62F64B678AFC37221D08BA52', '7DD74166ADDB5F9FE053809BA8C0134E', '1160', 'gSessCvSurname||'' ''||gSessCvName', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-08-22T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
