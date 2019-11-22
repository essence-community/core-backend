--liquibase formatted sql
--changeset patcher-core:Page_3 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
with recursive page as (
select
    ck_id
from
    s_mt.t_page
where
    ck_id = '3'
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
    ck_id = '3'
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
        ck_id = '3'
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
        ck_id = '3'
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
    ck_id = '3'
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

INSERT INTO s_mt.t_page (ck_id, ck_parent, cr_type, cv_name, cn_order, cl_static, cv_url, ck_icon, ck_user, ct_change, cl_menu)VALUES('3', '5', 2, 'Классы', 3, 0, null, '194', '-11', '2018-02-23T00:00:00.000+0000', 1) on conflict (ck_id) do update set ck_parent = excluded.ck_parent, cr_type = excluded.cr_type, cv_name = excluded.cv_name, cn_order = excluded.cn_order, cl_static = excluded.cl_static, cv_url = excluded.cv_url, ck_icon = excluded.ck_icon, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_menu = excluded.cl_menu;
INSERT INTO s_mt.t_page_action (ck_id, ck_page, cr_type, cn_action, ck_user, ct_change)VALUES('8', '3', 'edit', 498, '-11', '2018-02-23T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cr_type = excluded.cr_type, cn_action = excluded.cn_action, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_action (ck_id, ck_page, cr_type, cn_action, ck_user, ct_change)VALUES('7', '3', 'view', 497, '-11', '2018-02-23T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cr_type = excluded.cr_type, cn_action = excluded.cn_action, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
select pkg_patcher.p_merge_object('9F4BA53BAAA740BBBBE4E17EBE3ACB42', '8', null, 'SYS Grid Class << DO NOT CHANGE', 1000800, 'MTClass', 'Таблица с классами', null, 'pkg_json_meta.f_modify_class', 'meta', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('AA3742B6B2D04C23AB751B501290B52B', '19', '9F4BA53BAAA740BBBBE4E17EBE3ACB42', 'Top Btn Add Class', 100, null, 'Создание нового класса', 'Создать новый класс', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('CC5F4F1AEF0941B39C528B7663AAC214', '16', '9F4BA53BAAA740BBBBE4E17EBE3ACB42', 'Edit Class', 200, null, 'Редактирование класса', null, null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('C0E589723932468982092A15976C8BB4', '9', '9F4BA53BAAA740BBBBE4E17EBE3ACB42', 'Name Class', 300, null, 'Наименование класса', 'Наименование', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('0ACDF60E6F944A6F9A44C59422A7E797', '9', '9F4BA53BAAA740BBBBE4E17EBE3ACB42', 'Description class', 400, null, 'Описание класса', 'Описание', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('AFCF040CC2044E53BBAF316B35E03EBF', '36', '9F4BA53BAAA740BBBBE4E17EBE3ACB42', 'Check cl_dataset', 500, null, 'Признак выводимого набора данных', 'Признак выводимого набора данных', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('F31962B0DD5344CAB0E7C5A1C6D48242', '36', '9F4BA53BAAA740BBBBE4E17EBE3ACB42', 'Check cl_final', 600, null, 'Признак самостоятельного заполнения', 'Признак самостоятельного заполнения', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('1548ECD6D7E1465EADCA37F0D94214BD', '29', 'AFCF040CC2044E53BBAF316B35E03EBF', 'CheckBox Field', 100, null, 'Поле выбора признака', null, null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('1D00659DFADA4992BAA2B7F07B8FC369', '29', 'F31962B0DD5344CAB0E7C5A1C6D48242', 'CheckBox Field cl_final', 100, null, 'Поле выбора', null, null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('C3A6E350960C46E289F771BB88355B1C', '26', '0ACDF60E6F944A6F9A44C59422A7E797', 'Edit Desc Class', 100, null, 'Поле редактирования описания класса', null, null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('78DD4CEE3E0F403586B9CB000F05A119', '26', 'C0E589723932468982092A15976C8BB4', 'Edit Name Class', 100, null, 'Поле редактирования имени класса', null, null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('1565', '9F4BA53BAAA740BBBBE4E17EBE3ACB42', '852', 'cv_name', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('40', '9F4BA53BAAA740BBBBE4E17EBE3ACB42', '1600', '390px', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('78', 'AA3742B6B2D04C23AB751B501290B52B', '140', 'onSimpleAddRow', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('4DDFFDC457914456AF353337D2FF6716', 'AA3742B6B2D04C23AB751B501290B52B', '992', 'plus', '1', '2019-09-03T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('41', 'C0E589723932468982092A15976C8BB4', '47', 'cv_name', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('42', '0ACDF60E6F944A6F9A44C59422A7E797', '47', 'cv_description', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('255', 'AFCF040CC2044E53BBAF316B35E03EBF', '250', 'cl_dataset', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('261', 'F31962B0DD5344CAB0E7C5A1C6D48242', '250', 'cl_final', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('258', '1548ECD6D7E1465EADCA37F0D94214BD', '97', 'false', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('257', '1548ECD6D7E1465EADCA37F0D94214BD', '94', 'cl_dataset', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('260', '1D00659DFADA4992BAA2B7F07B8FC369', '94', 'cl_final', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('213', 'C3A6E350960C46E289F771BB88355B1C', '73', 'false', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('212', '78DD4CEE3E0F403586B9CB000F05A119', '73', 'true', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('409', '78DD4CEE3E0F403586B9CB000F05A119', '408', '60', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('7F34DED949DF4E3D8A3C6BD52D726B1C', '35', null, 'SYS Tab Panel Class << DO NOT CHANGE', 1000900, null, 'Панель со вкладками', null, null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('D61761E4F2AA49279A15318CA3F8996F', '8', '7F34DED949DF4E3D8A3C6BD52D726B1C', 'SYS Grid Class Attr << DO NOT CHANGE', 100, 'MTClassAttr', 'Таблица атрибутов класса', 'Атрибуты', 'pkg_json_meta.f_modify_class_attr', 'meta', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('80B4041147E3470FA3C38E55004D160D', '8', '7F34DED949DF4E3D8A3C6BD52D726B1C', 'SYS Grid Child Class << DO NOT CHANGE', 200, 'MTClassChild', 'Таблица дочерних классов', 'Дочерние классы', 'pkg_json_meta.f_modify_class_hierarchy', 'meta', '10020788', '2018-03-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object('2872E6B328CA4397A8E81147EFDCBDA7', '8', '7F34DED949DF4E3D8A3C6BD52D726B1C', 'SYS Grid Parent Class << DO NOT CHANGE', 300, 'MTClassParent', 'Таблица родительских связей', 'Родительские классы', null, null, '10020788', '2018-03-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object('395C8390216045F2A51188B8E8C71568', '32', '80B4041147E3470FA3C38E55004D160D', 'Add/Edit Child Bind', 10, null, 'привязки дочернего класса', null, null, null, '10020788', '2018-03-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object('814EA6C85CEC4C3E93BB3AAB38AEE22E', '58', 'D61761E4F2AA49279A15318CA3F8996F', 'Filter', 10, null, 'Filter', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-21T00:00:00.000+0000');
select pkg_patcher.p_merge_object('D37EDE722CF34CDBB459521FB353D600', '9', '2872E6B328CA4397A8E81147EFDCBDA7', 'Name Attr', 100, null, 'Наименование атрибута', 'Наименование атрибута', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('B23DA17649564C9B9673AC3A1AA95A24', '19', 'D61761E4F2AA49279A15318CA3F8996F', 'Top Btn Add Attr', 100, null, 'Создание атрибута класса', 'Создать новый атрибут', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('8F21BF55FAE64AD681DD6D89D26E87BA', '19', '80B4041147E3470FA3C38E55004D160D', 'Top Btn Add Child Class', 100, null, 'Добавление дочерних классов', 'Привязать дочерний класс', null, null, '10020788', '2018-03-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object('F503DE08AA92406DB6299F241E20985E', '16', '80B4041147E3470FA3C38E55004D160D', 'Edit Childs Bind', 130, null, 'Редактирование связи с дочерней колонкой', null, null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('2ADDC9B8037F422B83266A1FF7E9E22D', '16', 'D61761E4F2AA49279A15318CA3F8996F', 'Edit Attr', 150, null, 'Редактирование Атрибута', null, null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('0F17EEABE4C34D6EA801023F37230114', '9', '2872E6B328CA4397A8E81147EFDCBDA7', 'Name Class', 200, null, 'Наименование класса', 'Наименование класса', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('B76C07B8A7C247EDA42C3A7E7265C6DE', '9', '2872E6B328CA4397A8E81147EFDCBDA7', 'Desc Class', 300, null, 'Описание класса', 'Описание класса', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('4E6AD4BE79284CE4B7BB14F107C835DB', '9', '80B4041147E3470FA3C38E55004D160D', 'Name Attr', 300, null, 'Наименование атрибута', 'Наименование атрибута', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('702A0926012D4AE78B9959485017020B', '9', 'D61761E4F2AA49279A15318CA3F8996F', 'Name Attr', 300, null, 'Наименование', 'Наименование', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('1E648C1FB7A243649A934C39DAEED002', '9', '80B4041147E3470FA3C38E55004D160D', 'Name Class', 400, null, 'Наименование класса', 'Наименование класса', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('C2F27EE271604FB4AABDB05C890F6FAC', '9', 'D61761E4F2AA49279A15318CA3F8996F', 'Value Attr', 400, null, 'Значение атрибута', 'Значение', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('14E3CF7E0F7C48179E7B318779E4D44D', '36', 'D61761E4F2AA49279A15318CA3F8996F', 'Check cl_required', 450, null, 'Признак обязательности', 'Признак обязательности', null, null, '10020788', '2018-03-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object('3486830584C742A5A870C3CC2941065D', '9', 'D61761E4F2AA49279A15318CA3F8996F', 'Desc Attr', 499, null, 'Описание атрибута', 'Описание', null, null, '10020788', '2018-03-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object('55CB11FA7ACB47AC9209700901BC0800', '9', '80B4041147E3470FA3C38E55004D160D', 'Desc Class', 500, null, 'Описание класса', 'Описание класса', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('BD3E264C18504B179BD47C0861737F0D', '9', 'D61761E4F2AA49279A15318CA3F8996F', 'Attr Type', 600, null, 'Attr Type', 'Тип атрибута', null, null, '10020788', '2018-03-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object('1A6488D52BDB4FCABFF8AAAE4CA23A29', '8D547C621A02626CE053809BA8C0882B', '814EA6C85CEC4C3E93BB3AAB38AEE22E', 'AttrType Radio', 10, 'MTClassAttrType', 'Тип атрибута', 'Тип атрибута', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-22T00:00:00.000+0000');
select pkg_patcher.p_merge_object('FCBE051AA2A14A63BA6B73379B5B62A0', '31', '395C8390216045F2A51188B8E8C71568', 'Attr Class Field', 100, 'MTClassAttrPlacementList', 'Поле выбора атрибута класса', 'Атрибут класса', null, null, '20783', '2019-04-29T00:00:00.000+0000');
select pkg_patcher.p_merge_object('F6609EBB0C06497E94545035201B3F77', '31', '702A0926012D4AE78B9959485017020B', 'Attr Field', 100, 'MTAttr', 'Поле выбора атрибута', null, null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('E6E64228A4DB4FF89E28CE77FD3B47CF', '29', '14E3CF7E0F7C48179E7B318779E4D44D', 'CheckBox Field', 100, null, 'Поле выбора признака', null, null, null, '10020788', '2018-03-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object('3CF84AC6FFA44F9EA1CFDC24F0CB0565', '26', 'C2F27EE271604FB4AABDB05C890F6FAC', 'Edit Value Attr', 100, null, 'Поле редактирования значения атрибута', null, null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('C2B772CF4C4740EBAC996AD47FA34AE9', '31', '395C8390216045F2A51188B8E8C71568', 'Class Combo Field', 200, 'MTClassList', 'Поле выбора класса', 'Класс', null, null, '10028610', '2019-02-06T00:00:00.000+0000');
select pkg_patcher.p_merge_object('5FD84B57C03B4C7CA5B426A621175F86', '19', '395C8390216045F2A51188B8E8C71568', 'BBtn Save Window', 1200, null, 'Сохраняем привязку к дочерним объектам', 'Сохранить', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('411E506D52AC49D683838C2CD9BFBA21', '19', '395C8390216045F2A51188B8E8C71568', 'BBtn Close Window', 1300, null, 'Отмена', 'Отмена', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('1562', 'D61761E4F2AA49279A15318CA3F8996F', '852', 'ck_attr', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('1563', '80B4041147E3470FA3C38E55004D160D', '852', 'ck_attr', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('314118305721', '80B4041147E3470FA3C38E55004D160D', '407', 'modalwindow', '10028610', '2019-02-06T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('1564', '2872E6B328CA4397A8E81147EFDCBDA7', '852', 'ck_attr', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('571873272621', '395C8390216045F2A51188B8E8C71568', '1029', 'window', '10028610', '2019-03-01T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('635A46714B8A4EF2892B2866A7E7EB71', '814EA6C85CEC4C3E93BB3AAB38AEE22E', '642', 'true', '-1', '2019-11-21T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('47', 'D37EDE722CF34CDBB459521FB353D600', '47', 'ck_attr', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('54', 'B23DA17649564C9B9673AC3A1AA95A24', '140', 'onSimpleAddRow', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('3ED7CC751366441C90FEE91CD128C979', 'B23DA17649564C9B9673AC3A1AA95A24', '992', 'plus', '1', '2019-09-03T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('223', '8F21BF55FAE64AD681DD6D89D26E87BA', '155', '1', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('221', '8F21BF55FAE64AD681DD6D89D26E87BA', '140', 'onCreateChildWindowMaster', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('201918821021', '8F21BF55FAE64AD681DD6D89D26E87BA', '992', 'fa-plus', '20780', '2019-01-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('571884484721', '8F21BF55FAE64AD681DD6D89D26E87BA', '1033', 'window', '10028610', '2019-03-01T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('222', 'F503DE08AA92406DB6299F241E20985E', '25', 'onRowCreateChildWindowMaster', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('48', '0F17EEABE4C34D6EA801023F37230114', '47', 'cv_name', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('51', 'B76C07B8A7C247EDA42C3A7E7265C6DE', '47', 'cv_description', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('528', '702A0926012D4AE78B9959485017020B', '453', 'true', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('46', '4E6AD4BE79284CE4B7BB14F107C835DB', '47', 'ck_attr', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('43', '702A0926012D4AE78B9959485017020B', '47', 'ck_attr', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('49', '1E648C1FB7A243649A934C39DAEED002', '47', 'cv_name', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('45', 'C2F27EE271604FB4AABDB05C890F6FAC', '47', 'cv_value', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('8312', '14E3CF7E0F7C48179E7B318779E4D44D', '250', 'cl_required', '10020788', '2018-03-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('44', '3486830584C742A5A870C3CC2941065D', '47', 'cv_description', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('1074', '3486830584C742A5A870C3CC2941065D', '433', 'disabled', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('50', '55CB11FA7ACB47AC9209700901BC0800', '47', 'cv_description', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('8297', 'BD3E264C18504B179BD47C0861737F0D', '433', 'disabled', '10020788', '2018-03-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('8293', 'BD3E264C18504B179BD47C0861737F0D', '47', 'ck_attr_type', '10020788', '2018-03-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('AD46E13D08984C578FAD10DFE48FA108', '1A6488D52BDB4FCABFF8AAAE4CA23A29', '8D3A50B6DE906276E053809BA8C0911C', 'ck_attr_type', '-1', '2019-11-21T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('E771277C875044289982AF9A606142F8', '1A6488D52BDB4FCABFF8AAAE4CA23A29', '8D2BA0EF36FE627EE053809BA8C0076B', 'hbox', '-1', '2019-11-21T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('E28A3BDBA5A84EA6B8781EF6ACD54003', '1A6488D52BDB4FCABFF8AAAE4CA23A29', '8D3A50B6DE926276E053809BA8C0911C', 'ck_id', '-1', '2019-11-21T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('F2EF902B69E844D5A93DA34A75EAC29B', '1A6488D52BDB4FCABFF8AAAE4CA23A29', '8D4FD9E32883628AE053809BA8C080EB', 'cv_name', '-1', '2019-11-21T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('16D0592FD0824078BA08E9D7C72611B5', '1A6488D52BDB4FCABFF8AAAE4CA23A29', '8D3A50B6DE936276E053809BA8C0911C', '##first##', '-1', '2019-11-21T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('224', 'FCBE051AA2A14A63BA6B73379B5B62A0', '125', 'ck_attr', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('225', 'FCBE051AA2A14A63BA6B73379B5B62A0', '126', 'ck_id', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('226', 'FCBE051AA2A14A63BA6B73379B5B62A0', '120', 'ck_class_attr', '10020788', '2018-03-29T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('1076', 'F6609EBB0C06497E94545035201B3F77', '125', 'ck_id', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('6537', 'F6609EBB0C06497E94545035201B3F77', '120', 'ck_attr', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('1077', 'F6609EBB0C06497E94545035201B3F77', '126', 'ck_id', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('8314', 'E6E64228A4DB4FF89E28CE77FD3B47CF', '97', 'false', '10020788', '2018-03-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('8313', 'E6E64228A4DB4FF89E28CE77FD3B47CF', '94', 'cl_required', '10020788', '2018-03-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('75', '3CF84AC6FFA44F9EA1CFDC24F0CB0565', '86', 'cv_value', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('228', 'C2B772CF4C4740EBAC996AD47FA34AE9', '126', 'ck_id', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('227', 'C2B772CF4C4740EBAC996AD47FA34AE9', '125', 'cv_name', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('229', 'C2B772CF4C4740EBAC996AD47FA34AE9', '120', 'ck_class', '10020788', '2018-03-29T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('218', '5FD84B57C03B4C7CA5B426A621175F86', '140', 'onSimpleSaveWindow', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('220', '411E506D52AC49D683838C2CD9BFBA21', '147', '2', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('219', '411E506D52AC49D683838C2CD9BFBA21', '140', 'onCloseWindow', '-11', '2018-02-23T00:00:00.000+0000');
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('22C6DC680F7E464CBDA21BF691D312FC', '3', '9F4BA53BAAA740BBBBE4E17EBE3ACB42', 1, null, null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('08C146701D8F4FFD863DB831F1CC178F', '3', '7F34DED949DF4E3D8A3C6BD52D726B1C', 2, null, null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('995AA5BFAFC5421593BFFBBD4B044548', '3', 'D61761E4F2AA49279A15318CA3F8996F', 100, '08C146701D8F4FFD863DB831F1CC178F', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('5B3FFA4D9935482980E9BA4C8A938082', '3', 'AA3742B6B2D04C23AB751B501290B52B', 100, '22C6DC680F7E464CBDA21BF691D312FC', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('BB7C41CFDA4A46D7B7A8C83E72CA137C', '3', 'CC5F4F1AEF0941B39C528B7663AAC214', 200, '22C6DC680F7E464CBDA21BF691D312FC', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('A1BBBB2478F049BBABD245F825088727', '3', '80B4041147E3470FA3C38E55004D160D', 200, '08C146701D8F4FFD863DB831F1CC178F', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('FE552586594246CB8682BA1B75D88162', '3', 'C0E589723932468982092A15976C8BB4', 300, '22C6DC680F7E464CBDA21BF691D312FC', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('A8995F918F36462C8C5D1AFB547AE477', '3', '2872E6B328CA4397A8E81147EFDCBDA7', 300, '08C146701D8F4FFD863DB831F1CC178F', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('0B10F752EE1B474BB173B4981B3CD2DC', '3', '0ACDF60E6F944A6F9A44C59422A7E797', 400, '22C6DC680F7E464CBDA21BF691D312FC', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('52D4A33ACE824A59BD8E1809D226D1BB', '3', 'AFCF040CC2044E53BBAF316B35E03EBF', 500, '22C6DC680F7E464CBDA21BF691D312FC', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('BA623C92F373419B8C9F1327812A3D1F', '3', 'F31962B0DD5344CAB0E7C5A1C6D48242', 600, '22C6DC680F7E464CBDA21BF691D312FC', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('64B6ECAFD9DA48EA8D907B0080CA1851', '3', '395C8390216045F2A51188B8E8C71568', 10, 'A1BBBB2478F049BBABD245F825088727', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('6251F87385304936BCD816E16F53346C', '3', '814EA6C85CEC4C3E93BB3AAB38AEE22E', 10, '995AA5BFAFC5421593BFFBBD4B044548', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('DC41CBEF4E4043B7917E14B2489DF17D', '3', '1548ECD6D7E1465EADCA37F0D94214BD', 100, '52D4A33ACE824A59BD8E1809D226D1BB', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('2226D88A38D14855B349244F41954047', '3', '1D00659DFADA4992BAA2B7F07B8FC369', 100, 'BA623C92F373419B8C9F1327812A3D1F', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('AE0ADBF5C8B04F36B5CEA60E0D547090', '3', 'C3A6E350960C46E289F771BB88355B1C', 100, '0B10F752EE1B474BB173B4981B3CD2DC', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('27367CBEFD7242BAA952862B4A28A430', '3', '78DD4CEE3E0F403586B9CB000F05A119', 100, 'FE552586594246CB8682BA1B75D88162', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('8BA0C316DD2B49658EBA4C12A031E7A2', '3', 'D37EDE722CF34CDBB459521FB353D600', 100, 'A8995F918F36462C8C5D1AFB547AE477', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('66C4A9320DE54BF99CEF90AF9DBDAE58', '3', 'B23DA17649564C9B9673AC3A1AA95A24', 100, '995AA5BFAFC5421593BFFBBD4B044548', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('4F1669DB8FFF44389507234C6B5A83EA', '3', '8F21BF55FAE64AD681DD6D89D26E87BA', 100, 'A1BBBB2478F049BBABD245F825088727', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('C4146088691E4159830D46FDB5763D7D', '3', 'F503DE08AA92406DB6299F241E20985E', 130, 'A1BBBB2478F049BBABD245F825088727', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('6591752C7687436C838C166841E7BDB1', '3', '2ADDC9B8037F422B83266A1FF7E9E22D', 150, '995AA5BFAFC5421593BFFBBD4B044548', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('624AC924087E4599B1007BE1F970FD6E', '3', '0F17EEABE4C34D6EA801023F37230114', 200, 'A8995F918F36462C8C5D1AFB547AE477', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('B966758BB9A944288E973831920587E0', '3', 'B76C07B8A7C247EDA42C3A7E7265C6DE', 300, 'A8995F918F36462C8C5D1AFB547AE477', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('1AB7410D084C407CBFDDABF02F22F4ED', '3', '4E6AD4BE79284CE4B7BB14F107C835DB', 300, 'A1BBBB2478F049BBABD245F825088727', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('6DB49E36E978412A811EDAA9E8A8ACC4', '3', '702A0926012D4AE78B9959485017020B', 300, '995AA5BFAFC5421593BFFBBD4B044548', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('D9338C20B1B44F51A013EAB6DDAF00F8', '3', '1E648C1FB7A243649A934C39DAEED002', 400, 'A1BBBB2478F049BBABD245F825088727', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('BF92C03CDB2B49488676F6649D4CA4C7', '3', 'C2F27EE271604FB4AABDB05C890F6FAC', 400, '995AA5BFAFC5421593BFFBBD4B044548', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('6773DB6A48C34ECEA9F4DF22E3C97AE9', '3', '14E3CF7E0F7C48179E7B318779E4D44D', 450, '995AA5BFAFC5421593BFFBBD4B044548', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('8456CFE86D684893A2384E674EB8C338', '3', '3486830584C742A5A870C3CC2941065D', 499, '995AA5BFAFC5421593BFFBBD4B044548', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('E0FDB73BD421495B9545C531135A742E', '3', '55CB11FA7ACB47AC9209700901BC0800', 500, 'A1BBBB2478F049BBABD245F825088727', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('35EAB1ACFDA44D9CA00F9110D8989760', '3', 'BD3E264C18504B179BD47C0861737F0D', 600, '995AA5BFAFC5421593BFFBBD4B044548', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('C9E3EDDA15F244C3BA44109BF74CF695', '3', '1A6488D52BDB4FCABFF8AAAE4CA23A29', 10, '6251F87385304936BCD816E16F53346C', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7F70DFD2586C44B6BC6D95C63C0893E9', '3', 'FCBE051AA2A14A63BA6B73379B5B62A0', 100, '64B6ECAFD9DA48EA8D907B0080CA1851', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7C1290164D0C46DFB05967E7948E0B71', '3', 'F6609EBB0C06497E94545035201B3F77', 100, '6DB49E36E978412A811EDAA9E8A8ACC4', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('4C398ADC07B14D74B7B0F6876D8180EE', '3', 'E6E64228A4DB4FF89E28CE77FD3B47CF', 100, '6773DB6A48C34ECEA9F4DF22E3C97AE9', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('8EA8B7E25B574861A840FCD65F201DD6', '3', '3CF84AC6FFA44F9EA1CFDC24F0CB0565', 100, 'BF92C03CDB2B49488676F6649D4CA4C7', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('D56A4AEF8A594C52818CB7506710ED95', '3', 'C2B772CF4C4740EBAC996AD47FA34AE9', 200, '64B6ECAFD9DA48EA8D907B0080CA1851', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('50D52681D12E48C59BB0BE05FA3FD826', '3', '5FD84B57C03B4C7CA5B426A621175F86', 1200, '64B6ECAFD9DA48EA8D907B0080CA1851', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('C9300F0B1B674F10ACAD8606B26A6038', '3', '411E506D52AC49D683838C2CD9BFBA21', 1300, '64B6ECAFD9DA48EA8D907B0080CA1851', null, '20788', '2018-12-08T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('504FE708E4B7455282591C67351E227A', '995AA5BFAFC5421593BFFBBD4B044548', '1600', '500', '20788', '2018-12-08T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('A6D23C81CF8F47228C880298A4A98A6A', 'AE0ADBF5C8B04F36B5CEA60E0D547090', '86', 'cv_description', '20788', '2018-12-08T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('C5A72FB952CD47E19D32A9277C93106A', '27367CBEFD7242BAA952862B4A28A430', '86', 'cv_name', '20788', '2018-12-08T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
update s_mt.t_page_object set ck_master='22C6DC680F7E464CBDA21BF691D312FC' where ck_id='08C146701D8F4FFD863DB831F1CC178F';
update s_mt.t_page_object set ck_master='A1BBBB2478F049BBABD245F825088727' where ck_id='4F1669DB8FFF44389507234C6B5A83EA';
update s_mt.t_page_object set ck_master='A1BBBB2478F049BBABD245F825088727' where ck_id='50D52681D12E48C59BB0BE05FA3FD826';
update s_mt.t_page_object set ck_master='22C6DC680F7E464CBDA21BF691D312FC' where ck_id='5B3FFA4D9935482980E9BA4C8A938082';
update s_mt.t_page_object set ck_master='995AA5BFAFC5421593BFFBBD4B044548' where ck_id='66C4A9320DE54BF99CEF90AF9DBDAE58';
update s_mt.t_page_object set ck_master='22C6DC680F7E464CBDA21BF691D312FC' where ck_id='7F70DFD2586C44B6BC6D95C63C0893E9';
update s_mt.t_page_object set ck_master='22C6DC680F7E464CBDA21BF691D312FC' where ck_id='995AA5BFAFC5421593BFFBBD4B044548';
update s_mt.t_page_object set ck_master='22C6DC680F7E464CBDA21BF691D312FC' where ck_id='A1BBBB2478F049BBABD245F825088727';
update s_mt.t_page_object set ck_master='22C6DC680F7E464CBDA21BF691D312FC' where ck_id='A8995F918F36462C8C5D1AFB547AE477';
