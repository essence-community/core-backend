--liquibase formatted sql
--changeset patcher-core:Page_181 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
with recursive page as (
select
    ck_id
from
    s_mt.t_page
where
    ck_id = '181'
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
    ck_id = '181'
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
        ck_id = '181'
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
        ck_id = '181'
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
    ck_id = '181'
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

INSERT INTO s_mt.t_page (ck_id, ck_parent, cr_type, cv_name, cn_order, cl_static, cv_url, ck_icon, ck_user, ct_change, cl_menu)VALUES('181', '5', 2, 'c9c069ee0fdf458494680488d7fa8057', 4, 0, null, '106', '-11', '2018-02-23T00:00:00.000+0000', 1) on conflict (ck_id) do update set ck_parent = excluded.ck_parent, cr_type = excluded.cr_type, cv_name = excluded.cv_name, cn_order = excluded.cn_order, cl_static = excluded.cl_static, cv_url = excluded.cv_url, ck_icon = excluded.ck_icon, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_menu = excluded.cl_menu;
INSERT INTO s_mt.t_page_action (ck_id, ck_page, cr_type, cn_action, ck_user, ct_change)VALUES('2', '181', 'edit', 492, '-11', '2018-02-23T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cr_type = excluded.cr_type, cn_action = excluded.cn_action, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_action (ck_id, ck_page, cr_type, cn_action, ck_user, ct_change)VALUES('1', '181', 'view', 491, '-11', '2018-02-23T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cr_type = excluded.cr_type, cn_action = excluded.cn_action, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
select pkg_patcher.p_merge_object('912DC90A71BB449181834548E5DDA4EA', '8', null, 'SYS Grid Attr << DO NOT CHANGE', 1001000, 'MTAttr', 'Список всех атрибутов', null, 'pkg_json_meta.f_modify_attr', 'meta', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('B71EF0C794214B3BA7A49E160B36D373', '19', '912DC90A71BB449181834548E5DDA4EA', 'Add New Attr Btn', 100, null, 'Добавление нового атрибута', '6d12c16cd7fa46579477a107a53f0790', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-04T00:00:00.000+0000');
select pkg_patcher.p_merge_object('7C45F172197C4BCDE053809BA8C030D5', '19', '912DC90A71BB449181834548E5DDA4EA', 'Override Save Button', 101, null, 'Override Save Button', null, null, null, '20785', '2018-12-05T00:00:00.000+0000');
select pkg_patcher.p_merge_object('553288E7156B4F71A7A681565326400A', '16', '912DC90A71BB449181834548E5DDA4EA', 'Edit Attr Btn Column', 150, null, 'Редактирование атрибута', null, null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('F3960DD69A33406B86F92BE05043120B', '9', '912DC90A71BB449181834548E5DDA4EA', 'Name Attr Column', 300, null, 'Наименование атрибута', '3a0b8d771a0d497e8aa1c44255fa6e83', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('60E439E451354D51855C0BFA53EC64D0', '9', '912DC90A71BB449181834548E5DDA4EA', 'Desc Attr Column', 400, null, 'Описание атрибута', '900d174d0a994374a01b0005756521bc', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('27C9B8FE4A084614A2D253815226A7EE', '9', '912DC90A71BB449181834548E5DDA4EA', 'Attr Type', 10000, null, 'Attr Type', 'acb73ce7e32841ec993dba6ecf442610', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('FD72C59E8C1B4EB6A57085743D832F4A', '31', '27C9B8FE4A084614A2D253815226A7EE', 'Attr Type Combo', 1, 'MTAttrType', 'Attr Type Combo', null, null, null, '10020788', '2018-03-08T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('1967', '912DC90A71BB449181834548E5DDA4EA', '852', 'ck_id', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('8292', '912DC90A71BB449181834548E5DDA4EA', '1600', '390', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-29T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('1070', 'B71EF0C794214B3BA7A49E160B36D373', '155', '1', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('201986093621', 'B71EF0C794214B3BA7A49E160B36D373', '992', 'fa-plus', '20780', '2019-01-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('67407257321', '7C45F172197C4BCDE053809BA8C030D5', '1997', '33a0e46ee9df4f3bb01bc95e07e28d3f', '20780', '2018-12-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('1068', 'F3960DD69A33406B86F92BE05043120B', '47', 'ck_id', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('4735', 'F3960DD69A33406B86F92BE05043120B', '433', 'insert', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('1069', '60E439E451354D51855C0BFA53EC64D0', '47', 'cv_description', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('3806', '27C9B8FE4A084614A2D253815226A7EE', '47', 'ck_attr_type', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('8093', 'FD72C59E8C1B4EB6A57085743D832F4A', '126', 'ck_id', '10020788', '2018-03-08T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('8094', 'FD72C59E8C1B4EB6A57085743D832F4A', '120', 'ck_attr_type', '10020788', '2018-03-08T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('8092', 'FD72C59E8C1B4EB6A57085743D832F4A', '125', 'ck_id', '10020788', '2018-03-08T00:00:00.000+0000');
select pkg_patcher.p_merge_object('57B5F4F962EB4AB48244C81888BB08E5', '8', null, 'SYS Grid Attr Class', 20, 'MTAttrClassList', 'В каких классах используется', '89ad8abd91d54514b23520186b551190', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-29T00:00:00.000+0000');
select pkg_patcher.p_merge_object('445E32FF063F4F8C8B2B4F839B1C97EB', '9', '57B5F4F962EB4AB48244C81888BB08E5', 'Cv_name', 10, null, 'Наименование класса', '3989aec5860044ec80f41db907599238', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-29T00:00:00.000+0000');
select pkg_patcher.p_merge_object('AF3194BF28654BDA969B582CB685D91E', '9', '57B5F4F962EB4AB48244C81888BB08E5', 'cv_description', 20, null, 'Описание класса', '80c7b0a9f8714587b77391263cffb324', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-29T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('34246560890047F889C2822EC8A91BCF', '57B5F4F962EB4AB48244C81888BB08E5', '1643', 'false', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-29T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('F014562C90D44950B40A52BBFA7529BE', '57B5F4F962EB4AB48244C81888BB08E5', '1600', '390', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-29T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('89BC05C43E9540A5B52A37B51ED7C797', '57B5F4F962EB4AB48244C81888BB08E5', '853', 'ASC', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-29T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2635DB4FC08F4112ABB01D94C7D01384', '57B5F4F962EB4AB48244C81888BB08E5', '852', 'cv_name', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-29T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('E9AFD9C3D8944B7B9433DCBE530C4D61', '445E32FF063F4F8C8B2B4F839B1C97EB', '47', 'cv_name', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-29T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('EE4EC9DE38704E88925E7A3F25B7D1C1', 'AF3194BF28654BDA969B582CB685D91E', '47', 'cv_description', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-29T00:00:00.000+0000');
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7C45F8C65E064F65E053809BA8C0A3B1', '181', '912DC90A71BB449181834548E5DDA4EA', 1, null, null, '20785', '2018-12-05T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('6A3D45BD19594A3AA1F03C65EBB83ACF', '181', '57B5F4F962EB4AB48244C81888BB08E5', 20, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-29T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('121E2CDA29EF4723BBDBA0C56468339E', '181', '445E32FF063F4F8C8B2B4F839B1C97EB', 10, '6A3D45BD19594A3AA1F03C65EBB83ACF', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-29T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('6ED87E90615148B786EFE33A8A66955C', '181', 'AF3194BF28654BDA969B582CB685D91E', 20, '6A3D45BD19594A3AA1F03C65EBB83ACF', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-29T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7C45F8C65E094F65E053809BA8C0A3B1', '181', 'B71EF0C794214B3BA7A49E160B36D373', 100, '7C45F8C65E064F65E053809BA8C0A3B1', null, '20785', '2018-12-05T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7C45F8C65E0C4F65E053809BA8C0A3B1', '181', '7C45F172197C4BCDE053809BA8C030D5', 101, '7C45F8C65E064F65E053809BA8C0A3B1', null, '20785', '2018-12-05T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7C45F8C65E084F65E053809BA8C0A3B1', '181', '553288E7156B4F71A7A681565326400A', 150, '7C45F8C65E064F65E053809BA8C0A3B1', null, '20785', '2018-12-05T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7C45F8C65E074F65E053809BA8C0A3B1', '181', 'F3960DD69A33406B86F92BE05043120B', 300, '7C45F8C65E064F65E053809BA8C0A3B1', null, '20785', '2018-12-05T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7C45F8C65E0A4F65E053809BA8C0A3B1', '181', '60E439E451354D51855C0BFA53EC64D0', 400, '7C45F8C65E064F65E053809BA8C0A3B1', null, '20785', '2018-12-05T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7C45F8C65E0B4F65E053809BA8C0A3B1', '181', '27C9B8FE4A084614A2D253815226A7EE', 10000, '7C45F8C65E064F65E053809BA8C0A3B1', null, '20785', '2018-12-05T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7C45F8C65E0D4F65E053809BA8C0A3B1', '181', 'FD72C59E8C1B4EB6A57085743D832F4A', 1, '7C45F8C65E0B4F65E053809BA8C0A3B1', null, '20785', '2018-12-05T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('3284128872', '7C45F8C65E074F65E053809BA8C0A3B1', '1237', null, '20785', '2018-12-05T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('3283123352', '7C45F8C65E074F65E053809BA8C0A3B1', '433', null, '20785', '2018-12-05T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
update s_mt.t_page_object set ck_master='7C45F8C65E064F65E053809BA8C0A3B1' where ck_id='6A3D45BD19594A3AA1F03C65EBB83ACF';
