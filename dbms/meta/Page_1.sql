--liquibase formatted sql
--changeset patcher-core:Page_1 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
with recursive page as (
select
    ck_id
from
    s_mt.t_page
where
    ck_id = '1'
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
    ck_id = '1'
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
        ck_id = '1'
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
        ck_id = '1'
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
    ck_id = '1'
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

INSERT INTO s_mt.t_page (ck_id, ck_parent, cr_type, cv_name, cn_order, cl_static, cv_url, ck_icon, ck_user, ct_change, cl_menu)VALUES('1', '5', 2, 'Объекты', 2, 0, null, '302', '-11', '2018-02-23T00:00:00.000+0000', 1) on conflict (ck_id) do update set ck_parent = excluded.ck_parent, cr_type = excluded.cr_type, cv_name = excluded.cv_name, cn_order = excluded.cn_order, cl_static = excluded.cl_static, cv_url = excluded.cv_url, ck_icon = excluded.ck_icon, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_menu = excluded.cl_menu;
INSERT INTO s_mt.t_page_action (ck_id, ck_page, cr_type, cn_action, ck_user, ct_change)VALUES('10', '1', 'edit', 500, '-11', '2018-02-23T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cr_type = excluded.cr_type, cn_action = excluded.cn_action, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_action (ck_id, ck_page, cr_type, cn_action, ck_user, ct_change)VALUES('9', '1', 'view', 499, '-11', '2018-02-23T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cr_type = excluded.cr_type, cn_action = excluded.cn_action, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_variable (ck_id, ck_page, cv_name, cv_description, ck_user, ct_change)VALUES('89', '1', 'g_cv_modify', 'требуется актуализировать', '10020788', '2018-07-22T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cv_name = excluded.cv_name, cv_description = excluded.cv_description, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_variable (ck_id, ck_page, cv_name, cv_description, ck_user, ct_change)VALUES('102', '1', 'gck_object', 'требуется актуализировать', '10020788', '2018-07-22T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cv_name = excluded.cv_name, cv_description = excluded.cv_description, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
select pkg_patcher.p_merge_object('A27411E018F34D16B5ABE97BCB6DBDF0', '18', null, 'SYS Grid Object << DO NOT CHANGE', 1000400, 'MTObject', 'Объекты метамодели', null, 'pkg_json_meta.f_modify_object', 'meta', '10020780', '2018-04-05T00:00:00.000+0000');
select pkg_patcher.p_merge_object('20E904F618D14931B946EFA7E8201725', '19', 'A27411E018F34D16B5ABE97BCB6DBDF0', 'Button Create Object', 100, null, 'Кнопка создания нового объекта', 'Создать новый объект', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('847FF29EEEBB450480BC720A2E849B1C', '58', 'A27411E018F34D16B5ABE97BCB6DBDF0', 'Filter', 115, null, 'Filter', null, null, null, '10020780', '2018-04-05T00:00:00.000+0000');
select pkg_patcher.p_merge_object('02E1029A8DCF4C41BDAF134464984704', '16', 'A27411E018F34D16B5ABE97BCB6DBDF0', 'Button Edit', 150, null, 'Кнопка "Редактировать" в гриде', 'Редактировать', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('085D40FB3F574204916A44658A636158', '32', 'A27411E018F34D16B5ABE97BCB6DBDF0', 'Add/Edit Object Window', 180, null, 'Объекта', null, null, null, '10020780', '2018-03-12T00:00:00.000+0000');
select pkg_patcher.p_merge_object('61A30167AC624DD98559417D42BCF027', '32', 'A27411E018F34D16B5ABE97BCB6DBDF0', 'Clone Object Window', 250, null, 'Окно клонирования объекта', 'Клонирование объекта', null, null, '10020785', '2018-03-05T00:00:00.000+0000');
select pkg_patcher.p_merge_object('38BC13060F1646B588299CBAA2F7C370', '57', 'A27411E018F34D16B5ABE97BCB6DBDF0', 'Column Copy Object', 300, null, 'Колонка копирования объекта', 'Клонировать объект', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-20T00:00:00.000+0000');
select pkg_patcher.p_merge_object('0202F94F3F624C13865A2B0AA9E8FDE5', '17', 'A27411E018F34D16B5ABE97BCB6DBDF0', 'Column Name (Tree)', 400, null, 'Колонка "Наименование" в виде дерева', 'Наименование', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('D853B3E280224C6C8C173CE8E7D2F484', '9', 'A27411E018F34D16B5ABE97BCB6DBDF0', 'Column Description', 500, null, 'Колонка "Описание"', 'Описание', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('84FFDBDA747849B1E053809BA8C0D55B', '9', 'A27411E018F34D16B5ABE97BCB6DBDF0', 'cv_displayed', 550, null, 'Отображаемое имя', 'Отображаемое имя', null, null, '20780', '2019-03-26T00:00:00.000+0000');
select pkg_patcher.p_merge_object('52354F089D7D42958DE7EF095B3E55C1', '9', 'A27411E018F34D16B5ABE97BCB6DBDF0', 'Column Data Service', 600, null, 'Имя сервиса откуда получаем данные', 'Имя сервиса', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('16E65663C5714E269C8289281C18DCA8', '9', 'A27411E018F34D16B5ABE97BCB6DBDF0', 'Column Class', 700, null, 'Класс объекта', 'Класс', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('A3875FB63D7042A6B61B371720EA55BF', '9', 'A27411E018F34D16B5ABE97BCB6DBDF0', 'Column Pages', 800, null, 'Страницы где подключен объект', 'Используется на страницах', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('66E12B205EC54282896B6B2498DE65A2', '9', 'A27411E018F34D16B5ABE97BCB6DBDF0', 'Column Modify Fn', 900, null, 'Колонка отображения привязки функции изменения', 'Метод модификации', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('04ACBA57BDB541699A459C20B4906BFD', '77', 'A27411E018F34D16B5ABE97BCB6DBDF0', 'Column cn_order', 1000, null, 'Column cn_order', 'Порядок сортировки', null, null, '10020786', '2018-04-05T00:00:00.000+0000');
select pkg_patcher.p_merge_object('919257042BA64D498D596BA60FC05385', '26', '847FF29EEEBB450480BC720A2E849B1C', 'cv_name', 10, null, 'cv_name', 'Наименование объекта', null, null, '10020780', '2018-04-05T00:00:00.000+0000');
select pkg_patcher.p_merge_object('5EC79376D75B43FD81D098D60CF69613', '31', '847FF29EEEBB450480BC720A2E849B1C', 'cv_pages', 20, 'MTGetPage', 'Используется на страницах', 'Используется на страницах', null, null, '10020780', '2018-04-20T00:00:00.000+0000');
select pkg_patcher.p_merge_object('EA7CFCD39A2948C2876FB8D0CF5BDC88', '31', '085D40FB3F574204916A44658A636158', 'Combo Class Field', 100, 'MTGetClassByParentObject', 'Класс', 'Класс', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('58E95625857C4D1B971A6FEE15321AE0', '37', '61A30167AC624DD98559417D42BCF027', 'Field Parent Object', 100, 'MTObject', 'Родительский объект', 'Родительский объект', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('9CB84B9533954CFFADFD349290E48881', '19', '61A30167AC624DD98559417D42BCF027', 'Button Clone Object', 200, 'MTCopyObject', 'Клонировать объект', 'Клонировать', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('98B367129551441BBC75BD5D42783962', '31', '085D40FB3F574204916A44658A636158', 'Combo Service Field', 200, 'MTQuery', 'Сервис', 'Сервис', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('9FD9EF21FA5C47BAA05E3C89C1211C58', '19', '61A30167AC624DD98559417D42BCF027', 'Button Close Window', 300, null, 'Button Close Window', 'Отмена', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('A250C26B41F84282BEBAE459FA63CE26', '26', '085D40FB3F574204916A44658A636158', 'Text Field Object', 300, null, 'Имя объекта', 'Имя объекта', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('21E9F838378546E69359B0FF5313B9CA', '26', '085D40FB3F574204916A44658A636158', 'Text Field Desc', 400, null, 'Описание объекта', 'Описание объекта', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('614202FC3A134191A5AB44D37F05BB40', '27', '085D40FB3F574204916A44658A636158', 'Field edit cn_order', 600, null, 'Порядок сортировки', 'Порядок сортировки', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('89E891F24EC34E3288980C890A0CED6D', '26', '085D40FB3F574204916A44658A636158', 'Field edit cv_displayed', 700, null, 'Отображаемое имя объекта', 'Отображаемое имя', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('06EBBAD0F5654999961313AD74F35758', '26', '085D40FB3F574204916A44658A636158', 'Field edit cv_modify', 800, null, 'Метод модификации', 'Метод модификации', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('71BEBE8212AE43CCAB228CD54AF6A348', '31', '085D40FB3F574204916A44658A636158', 'combo provider modify', 900, 'MTGetProvider', 'Провайдер данных при модификации', 'Провайдер данных при модификации', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('96D701D6167142548E0CC663F4B05B06', '19', '085D40FB3F574204916A44658A636158', 'BTN SAVE', 1200, null, 'Сохранить', 'Сохранить', null, null, '20788', '2018-12-18T00:00:00.000+0000');
select pkg_patcher.p_merge_object('820F0FE7A24A4B9F9DE25211D70A6A76', '19', '085D40FB3F574204916A44658A636158', 'BTN CLOSE', 1300, null, 'Отмена', 'Отмена', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('499F2085815F48CCAE347C7DFEC8385A', '17', '58E95625857C4D1B971A6FEE15321AE0', 'Column Name', 100, null, 'Колонка Имени', 'Наименование', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('08D6997839684C678BDE60466CF6684D', '9', '58E95625857C4D1B971A6FEE15321AE0', 'Column Description', 200, null, 'Описание объекта', 'Описание объекта', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('32', 'A27411E018F34D16B5ABE97BCB6DBDF0', '167', 'true', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('8320', 'A27411E018F34D16B5ABE97BCB6DBDF0', '1607', '440', '10020788', '2018-03-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('1559', 'A27411E018F34D16B5ABE97BCB6DBDF0', '854', 'cn_order', '10020785', '2018-05-10T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('6555', '20E904F618D14931B946EFA7E8201725', '1033', 'addwindow', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('27', '20E904F618D14931B946EFA7E8201725', '155', '1', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('9', '20E904F618D14931B946EFA7E8201725', '140', 'onCreateChildWindowMaster', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('201829124221', '20E904F618D14931B946EFA7E8201725', '992', 'fa-plus', '20780', '2019-01-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('6552', '02E1029A8DCF4C41BDAF134464984704', '1493', 'addwindow', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('10', '02E1029A8DCF4C41BDAF134464984704', '25', 'onRowCreateChildWindowMaster', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('6554', '085D40FB3F574204916A44658A636158', '1029', 'addwindow', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2907', '61A30167AC624DD98559417D42BCF027', '1029', 'copywindow', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2908', '38BC13060F1646B588299CBAA2F7C370', '1030', 'copywindow', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2768', '38BC13060F1646B588299CBAA2F7C370', '560', 'onRowCreateChildWindowMaster', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('692', '38BC13060F1646B588299CBAA2F7C370', '592', 'MTCopyObject', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('156991936321', '38BC13060F1646B588299CBAA2F7C370', '591', '6', '10020788', '2019-01-04T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('156980724221', '38BC13060F1646B588299CBAA2F7C370', '353', 'fa-clone', '10020788', '2019-01-04T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('3', '0202F94F3F624C13865A2B0AA9E8FDE5', '52', 'cv_name', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('4', 'D853B3E280224C6C8C173CE8E7D2F484', '47', 'cv_description', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('84FFDBDA747949B1E053809BA8C0D55B', '84FFDBDA747849B1E053809BA8C0D55B', '47', 'cv_displayed', '20780', '2019-03-26T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('1016', '52354F089D7D42958DE7EF095B3E55C1', '47', 'ck_query', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('1015', '16E65663C5714E269C8289281C18DCA8', '47', 'cv_class_name', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('1014', 'A3875FB63D7042A6B61B371720EA55BF', '47', 'cv_pages', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('779', '66E12B205EC54282896B6B2498DE65A2', '47', 'cv_modify', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('9489', '04ACBA57BDB541699A459C20B4906BFD', '444', 'cn_order', '10020786', '2018-04-05T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('9479', '919257042BA64D498D596BA60FC05385', '86', 'cv_name', '10020780', '2018-04-05T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('210675471121', '919257042BA64D498D596BA60FC05385', '1054', '25%', '10020788', '2019-01-18T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('9482', '5EC79376D75B43FD81D098D60CF69613', '126', 'ck_id', '10020780', '2018-04-05T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('9480', '5EC79376D75B43FD81D098D60CF69613', '125', 'cv_name', '10020780', '2018-04-05T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('10456', '5EC79376D75B43FD81D098D60CF69613', '127', 'remote', '10020780', '2018-04-20T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('10452', '5EC79376D75B43FD81D098D60CF69613', '863', 'cv_entered', '10020780', '2018-04-20T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('9478', '5EC79376D75B43FD81D098D60CF69613', '120', 'ck_page', '10020788', '2018-04-20T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('10460', '5EC79376D75B43FD81D098D60CF69613', '1949', '0', '10020788', '2018-04-20T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('210025169321', '5EC79376D75B43FD81D098D60CF69613', '1053', '25%', '10020788', '2019-01-18T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('15', 'EA7CFCD39A2948C2876FB8D0CF5BDC88', '120', 'ck_class', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('698', 'EA7CFCD39A2948C2876FB8D0CF5BDC88', '570', 'true', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('14', 'EA7CFCD39A2948C2876FB8D0CF5BDC88', '126', 'ck_id', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('13', 'EA7CFCD39A2948C2876FB8D0CF5BDC88', '125', 'cv_displayed', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('11', 'EA7CFCD39A2948C2876FB8D0CF5BDC88', '123', 'true', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2767', '58E95625857C4D1B971A6FEE15321AE0', '261', 'ck_parent', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2780', '58E95625857C4D1B971A6FEE15321AE0', '361', 'cv_name', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2788', '58E95625857C4D1B971A6FEE15321AE0', '994', null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2775', '58E95625857C4D1B971A6FEE15321AE0', '267', 'ck_id', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2773', '58E95625857C4D1B971A6FEE15321AE0', '859', 'cv_name_lowered', '20780', '2018-11-26T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2776', '9CB84B9533954CFFADFD349290E48881', '150', 'MTCopyObject', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2774', '9CB84B9533954CFFADFD349290E48881', '140', 'onSimpleSaveWindow', '10020786', '2018-07-03T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('17', '98B367129551441BBC75BD5D42783962', '126', 'ck_id', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('16', '98B367129551441BBC75BD5D42783962', '125', 'ck_id', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('18', '98B367129551441BBC75BD5D42783962', '120', 'ck_query', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2787', '9FD9EF21FA5C47BAA05E3C89C1211C58', '147', '2', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2786', '9FD9EF21FA5C47BAA05E3C89C1211C58', '140', 'onCloseWindow', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('19', 'A250C26B41F84282BEBAE459FA63CE26', '86', 'cv_name', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('12', 'A250C26B41F84282BEBAE459FA63CE26', '73', 'true', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('34', '21E9F838378546E69359B0FF5313B9CA', '73', 'true', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('20', '21E9F838378546E69359B0FF5313B9CA', '86', 'cv_description', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('31', '614202FC3A134191A5AB44D37F05BB40', '72', 'true', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('29', '614202FC3A134191A5AB44D37F05BB40', '85', 'cn_order', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('30', '89E891F24EC34E3288980C890A0CED6D', '86', 'cv_displayed', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('892', '06EBBAD0F5654999961313AD74F35758', '86', 'cv_modify', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('6553', '71BEBE8212AE43CCAB228CD54AF6A348', '120', 'ck_provider', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('6556', '71BEBE8212AE43CCAB228CD54AF6A348', '126', 'key', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('6557', '71BEBE8212AE43CCAB228CD54AF6A348', '125', 'value', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('6559', '71BEBE8212AE43CCAB228CD54AF6A348', '123', 'true', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('25', '96D701D6167142548E0CC663F4B05B06', '140', 'onSimpleSaveWindow', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('21', '820F0FE7A24A4B9F9DE25211D70A6A76', '147', '2', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('23', '820F0FE7A24A4B9F9DE25211D70A6A76', '140', 'onCloseWindow', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2782', '499F2085815F48CCAE347C7DFEC8385A', '52', 'cv_name', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('12187664821', '499F2085815F48CCAE347C7DFEC8385A', '13181', 'cv_name_lowered', '20788', '2018-11-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2772', '08D6997839684C678BDE60466CF6684D', '47', 'cv_description', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('5438D5F75E6D4CCB92CFCED7AFDA951C', '8', null, 'SYS Grid Object Attribute << DO NOT CHANGE', 1000401, 'MTObjectAttribute', 'Грид "Атрибуты объекта"', 'Атрибуты объекта', 'pkg_json_meta.f_modify_object_attr', 'meta', '20788', '2018-11-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object('482CF93188074352A883B2C22D0945F8', '16', '5438D5F75E6D4CCB92CFCED7AFDA951C', 'Button Edit', 100, null, 'Кнопка "Редактировать" в гриде', 'Редактировать', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('AC0C3A9C3BB7491D9F300E75EB893683', '9', '5438D5F75E6D4CCB92CFCED7AFDA951C', 'Column Name', 300, null, 'Колонка "Наименование"', 'Наименование', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('5540018FA2FC4C619E0A90969D8E7B6B', '9', '5438D5F75E6D4CCB92CFCED7AFDA951C', 'Column default value', 400, null, 'Колонка "Значение по умолчанию"', 'Значение по умолчанию', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('948B958349E94465AD6DDE0D1D81123E', '9', '5438D5F75E6D4CCB92CFCED7AFDA951C', 'Column value', 500, null, 'Колонка "Значение (переопределенное)"', 'Значение (переопределенное)', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('B25593736D6549B498335251E1FB280C', '9', '5438D5F75E6D4CCB92CFCED7AFDA951C', 'Object Attr Desc', 600, null, 'Описание атрибута', 'Описание', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('87DD0319961C49E182C7D5ACA7FCECE7', '31', '948B958349E94465AD6DDE0D1D81123E', 'Object Attr Value Field', 100, 'MTGetValuesByAttr', 'Поле редактирование значения атрибута', null, null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('1560', '5438D5F75E6D4CCB92CFCED7AFDA951C', '852', 'ck_attr', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('8322', '5438D5F75E6D4CCB92CFCED7AFDA951C', '1600', '440', '10020788', '2018-03-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('93132', '5438D5F75E6D4CCB92CFCED7AFDA951C', '28169', 'true', '10020785', '2018-10-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('5', 'AC0C3A9C3BB7491D9F300E75EB893683', '47', 'ck_attr', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('493', 'AC0C3A9C3BB7491D9F300E75EB893683', '433', 'disabled', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('6', '5540018FA2FC4C619E0A90969D8E7B6B', '47', 'cv_value_attr', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('494', '5540018FA2FC4C619E0A90969D8E7B6B', '433', 'disabled', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('7', '948B958349E94465AD6DDE0D1D81123E', '47', 'cv_value', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('496', 'B25593736D6549B498335251E1FB280C', '433', 'disabled', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('495', 'B25593736D6549B498335251E1FB280C', '47', 'cv_description', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2014', '87DD0319961C49E182C7D5ACA7FCECE7', '125', 'cv_value', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('7281163341FD43C4A2407DA62BFB8123', '87DD0319961C49E182C7D5ACA7FCECE7', '752', 'new:', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('1592', '87DD0319961C49E182C7D5ACA7FCECE7', '861', 'ck_attr', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('1591', '87DD0319961C49E182C7D5ACA7FCECE7', '863', 'cv_entered', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2015', '87DD0319961C49E182C7D5ACA7FCECE7', '120', 'cv_value', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2380', '87DD0319961C49E182C7D5ACA7FCECE7', '570', 'false', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('1590', '87DD0319961C49E182C7D5ACA7FCECE7', '127', 'remote', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2013', '87DD0319961C49E182C7D5ACA7FCECE7', '126', 'cv_value', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('10713', '87DD0319961C49E182C7D5ACA7FCECE7', '121', '4000', '10020786', '2018-05-08T00:00:00.000+0000');
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('84FFFEEFA8F149B5E053809BA8C08E0F', '1', 'A27411E018F34D16B5ABE97BCB6DBDF0', 1, null, null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('84FFFEEFA8EA49B5E053809BA8C08E0F', '1', '5438D5F75E6D4CCB92CFCED7AFDA951C', 2, null, null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('84FFFEEFA8F649B5E053809BA8C08E0F', '1', '20E904F618D14931B946EFA7E8201725', 100, '84FFFEEFA8F149B5E053809BA8C08E0F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('84FFFEEFA8EC49B5E053809BA8C08E0F', '1', '482CF93188074352A883B2C22D0945F8', 100, '84FFFEEFA8EA49B5E053809BA8C08E0F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('84FFFEEFA8FD49B5E053809BA8C08E0F', '1', '847FF29EEEBB450480BC720A2E849B1C', 115, '84FFFEEFA8F149B5E053809BA8C08E0F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('84FFFEEFA8F349B5E053809BA8C08E0F', '1', '02E1029A8DCF4C41BDAF134464984704', 150, '84FFFEEFA8F149B5E053809BA8C08E0F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('84FFFEEFA8F249B5E053809BA8C08E0F', '1', '085D40FB3F574204916A44658A636158', 180, '84FFFEEFA8F149B5E053809BA8C08E0F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('84FFFEEFA8FA49B5E053809BA8C08E0F', '1', '61A30167AC624DD98559417D42BCF027', 250, '84FFFEEFA8F149B5E053809BA8C08E0F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('84FFFEEFA8F749B5E053809BA8C08E0F', '1', '38BC13060F1646B588299CBAA2F7C370', 300, '84FFFEEFA8F149B5E053809BA8C08E0F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('84FFFEEFA8ED49B5E053809BA8C08E0F', '1', 'AC0C3A9C3BB7491D9F300E75EB893683', 300, '84FFFEEFA8EA49B5E053809BA8C08E0F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('84FFFEEFA8F449B5E053809BA8C08E0F', '1', '0202F94F3F624C13865A2B0AA9E8FDE5', 400, '84FFFEEFA8F149B5E053809BA8C08E0F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('84FFFEEFA8EE49B5E053809BA8C08E0F', '1', '5540018FA2FC4C619E0A90969D8E7B6B', 400, '84FFFEEFA8EA49B5E053809BA8C08E0F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('84FFFEEFA8F549B5E053809BA8C08E0F', '1', 'D853B3E280224C6C8C173CE8E7D2F484', 500, '84FFFEEFA8F149B5E053809BA8C08E0F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('84FFFEEFA8EF49B5E053809BA8C08E0F', '1', '948B958349E94465AD6DDE0D1D81123E', 500, '84FFFEEFA8EA49B5E053809BA8C08E0F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('84FFFEEFA8FF49B5E053809BA8C08E0F', '1', '84FFDBDA747849B1E053809BA8C0D55B', 550, '84FFFEEFA8F149B5E053809BA8C08E0F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('84FFFEEFA8F949B5E053809BA8C08E0F', '1', '52354F089D7D42958DE7EF095B3E55C1', 600, '84FFFEEFA8F149B5E053809BA8C08E0F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('84FFFEEFA8EB49B5E053809BA8C08E0F', '1', 'B25593736D6549B498335251E1FB280C', 600, '84FFFEEFA8EA49B5E053809BA8C08E0F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('84FFFEEFA8FC49B5E053809BA8C08E0F', '1', '16E65663C5714E269C8289281C18DCA8', 700, '84FFFEEFA8F149B5E053809BA8C08E0F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('84FFFEEFA8FB49B5E053809BA8C08E0F', '1', 'A3875FB63D7042A6B61B371720EA55BF', 800, '84FFFEEFA8F149B5E053809BA8C08E0F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('84FFFEEFA8F849B5E053809BA8C08E0F', '1', '66E12B205EC54282896B6B2498DE65A2', 900, '84FFFEEFA8F149B5E053809BA8C08E0F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('84FFFEEFA8FE49B5E053809BA8C08E0F', '1', '04ACBA57BDB541699A459C20B4906BFD', 1000, '84FFFEEFA8F149B5E053809BA8C08E0F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('84FFFEEFA90D49B5E053809BA8C08E0F', '1', '919257042BA64D498D596BA60FC05385', 10, '84FFFEEFA8FD49B5E053809BA8C08E0F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('84FFFEEFA90E49B5E053809BA8C08E0F', '1', '5EC79376D75B43FD81D098D60CF69613', 20, '84FFFEEFA8FD49B5E053809BA8C08E0F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('84FFFEEFA90049B5E053809BA8C08E0F', '1', 'EA7CFCD39A2948C2876FB8D0CF5BDC88', 100, '84FFFEEFA8F249B5E053809BA8C08E0F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('84FFFEEFA90A49B5E053809BA8C08E0F', '1', '58E95625857C4D1B971A6FEE15321AE0', 100, '84FFFEEFA8FA49B5E053809BA8C08E0F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('84FFFEEFA8F049B5E053809BA8C08E0F', '1', '87DD0319961C49E182C7D5ACA7FCECE7', 100, '84FFFEEFA8EF49B5E053809BA8C08E0F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('84FFFEEFA90B49B5E053809BA8C08E0F', '1', '9CB84B9533954CFFADFD349290E48881', 200, '84FFFEEFA8FA49B5E053809BA8C08E0F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('84FFFEEFA90149B5E053809BA8C08E0F', '1', '98B367129551441BBC75BD5D42783962', 200, '84FFFEEFA8F249B5E053809BA8C08E0F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('84FFFEEFA90C49B5E053809BA8C08E0F', '1', '9FD9EF21FA5C47BAA05E3C89C1211C58', 300, '84FFFEEFA8FA49B5E053809BA8C08E0F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('84FFFEEFA90249B5E053809BA8C08E0F', '1', 'A250C26B41F84282BEBAE459FA63CE26', 300, '84FFFEEFA8F249B5E053809BA8C08E0F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('84FFFEEFA90349B5E053809BA8C08E0F', '1', '21E9F838378546E69359B0FF5313B9CA', 400, '84FFFEEFA8F249B5E053809BA8C08E0F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('84FFFEEFA90649B5E053809BA8C08E0F', '1', '614202FC3A134191A5AB44D37F05BB40', 600, '84FFFEEFA8F249B5E053809BA8C08E0F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('84FFFEEFA90749B5E053809BA8C08E0F', '1', '89E891F24EC34E3288980C890A0CED6D', 700, '84FFFEEFA8F249B5E053809BA8C08E0F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('84FFFEEFA90849B5E053809BA8C08E0F', '1', '06EBBAD0F5654999961313AD74F35758', 800, '84FFFEEFA8F249B5E053809BA8C08E0F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('84FFFEEFA90949B5E053809BA8C08E0F', '1', '71BEBE8212AE43CCAB228CD54AF6A348', 900, '84FFFEEFA8F249B5E053809BA8C08E0F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('84FFFEEFA90449B5E053809BA8C08E0F', '1', '96D701D6167142548E0CC663F4B05B06', 1200, '84FFFEEFA8F249B5E053809BA8C08E0F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('84FFFEEFA90549B5E053809BA8C08E0F', '1', '820F0FE7A24A4B9F9DE25211D70A6A76', 1300, '84FFFEEFA8F249B5E053809BA8C08E0F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('84FFFEEFA91049B5E053809BA8C08E0F', '1', '499F2085815F48CCAE347C7DFEC8385A', 100, '84FFFEEFA90A49B5E053809BA8C08E0F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('84FFFEEFA90F49B5E053809BA8C08E0F', '1', '08D6997839684C678BDE60466CF6684D', 200, '84FFFEEFA90A49B5E053809BA8C08E0F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('84FFFEEFA91249B5E053809BA8C08E0F', '84FFFEEFA8F149B5E053809BA8C08E0F', '1181', 'gck_object', '20780', '2019-03-21T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('84FFFEEFA91449B5E053809BA8C08E0F', '84FFFEEFA90849B5E053809BA8C08E0F', '1190', 'g_cv_modify', '20788', '2018-11-23T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('84FFFEEFA91549B5E053809BA8C08E0F', '84FFFEEFA90949B5E053809BA8C08E0F', '125', null, '20788', '2018-11-23T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('84FFFEEFA91649B5E053809BA8C08E0F', '84FFFEEFA90949B5E053809BA8C08E0F', '1255', '!g_cv_modify', '20788', '2018-11-23T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('84FFFEEFA91349B5E053809BA8C08E0F', '84FFFEEFA90449B5E053809BA8C08E0F', '151', null, '20788', '2018-11-23T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('84FFFEEFA91149B5E053809BA8C08E0F', '84FFFEEFA8F049B5E053809BA8C08E0F', '1949', '0', '20788', '2018-11-23T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
update s_mt.t_page_object set ck_master='84FFFEEFA8F149B5E053809BA8C08E0F' where ck_id='84FFFEEFA8EA49B5E053809BA8C08E0F';
update s_mt.t_page_object set ck_master='84FFFEEFA8EA49B5E053809BA8C08E0F' where ck_id='84FFFEEFA8F049B5E053809BA8C08E0F';
update s_mt.t_page_object set ck_master='84FFFEEFA8F149B5E053809BA8C08E0F' where ck_id='84FFFEEFA8F349B5E053809BA8C08E0F';
update s_mt.t_page_object set ck_master='84FFFEEFA8F149B5E053809BA8C08E0F' where ck_id='84FFFEEFA8F649B5E053809BA8C08E0F';
update s_mt.t_page_object set ck_master='84FFFEEFA8FA49B5E053809BA8C08E0F' where ck_id='84FFFEEFA8F749B5E053809BA8C08E0F';
update s_mt.t_page_object set ck_master='84FFFEEFA8F149B5E053809BA8C08E0F' where ck_id='84FFFEEFA8FA49B5E053809BA8C08E0F';
update s_mt.t_page_object set ck_master='84FFFEEFA8F149B5E053809BA8C08E0F' where ck_id='84FFFEEFA90049B5E053809BA8C08E0F';
update s_mt.t_page_object set ck_master='84FFFEEFA8F149B5E053809BA8C08E0F' where ck_id='84FFFEEFA90449B5E053809BA8C08E0F';
update s_mt.t_page_object set ck_master='84FFFEEFA8F149B5E053809BA8C08E0F' where ck_id='84FFFEEFA90B49B5E053809BA8C08E0F';
