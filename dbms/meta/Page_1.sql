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
select pkg_patcher.p_merge_object('9F921E25EF614B7087D8F200AFE60E30', '31', '085D40FB3F574204916A44658A636158', 'Field edit cv_displayed', 700, 'MTGetDefaultLocalization', 'Отображаемое имя объекта', '37023be03a484bd5928791eebcd47f51', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-25T00:00:00.000+0000');
select pkg_patcher.p_merge_object('06EBBAD0F5654999961313AD74F35758', '26', '085D40FB3F574204916A44658A636158', 'Field edit cv_modify', 800, null, 'Метод модификации', 'Метод модификации', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('71BEBE8212AE43CCAB228CD54AF6A348', '31', '085D40FB3F574204916A44658A636158', 'combo provider modify', 900, 'MTGetProvider', 'Провайдер данных при модификации', 'Провайдер данных при модификации', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('96D701D6167142548E0CC663F4B05B06', '19', '085D40FB3F574204916A44658A636158', 'BTN SAVE', 1200, null, 'Сохранить', 'Сохранить', null, null, '20788', '2018-12-18T00:00:00.000+0000');
select pkg_patcher.p_merge_object('820F0FE7A24A4B9F9DE25211D70A6A76', '19', '085D40FB3F574204916A44658A636158', 'BTN CLOSE', 1300, null, 'Отмена', 'Отмена', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('499F2085815F48CCAE347C7DFEC8385A', '17', '58E95625857C4D1B971A6FEE15321AE0', 'Column Name', 100, null, 'Колонка Имени', 'Наименование', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('08D6997839684C678BDE60466CF6684D', '9', '58E95625857C4D1B971A6FEE15321AE0', 'Column Description', 200, null, 'Описание объекта', 'Описание объекта', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('32', 'A27411E018F34D16B5ABE97BCB6DBDF0', '167', 'true', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('8320', 'A27411E018F34D16B5ABE97BCB6DBDF0', '1607', '440', '10020788', '2018-03-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('1559', 'A27411E018F34D16B5ABE97BCB6DBDF0', '854', 'cn_order', '10020785', '2018-05-10T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('27', '20E904F618D14931B946EFA7E8201725', '155', '1', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('6555', '20E904F618D14931B946EFA7E8201725', '1033', 'addwindow', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('9', '20E904F618D14931B946EFA7E8201725', '140', 'onCreateChildWindowMaster', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('201829124221', '20E904F618D14931B946EFA7E8201725', '992', 'fa-plus', '20780', '2019-01-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('6552', '02E1029A8DCF4C41BDAF134464984704', '1493', 'addwindow', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('10', '02E1029A8DCF4C41BDAF134464984704', '25', 'onRowCreateChildWindowMaster', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('6554', '085D40FB3F574204916A44658A636158', '1029', 'addwindow', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2907', '61A30167AC624DD98559417D42BCF027', '1029', 'copywindow', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('692', '38BC13060F1646B588299CBAA2F7C370', '592', 'MTCopyObject', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2908', '38BC13060F1646B588299CBAA2F7C370', '1030', 'copywindow', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2768', '38BC13060F1646B588299CBAA2F7C370', '560', 'onRowCreateChildWindowMaster', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('156980724221', '38BC13060F1646B588299CBAA2F7C370', '353', 'fa-clone', '10020788', '2019-01-04T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('156991936321', '38BC13060F1646B588299CBAA2F7C370', '591', '6', '10020788', '2019-01-04T00:00:00.000+0000');
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
select pkg_patcher.p_merge_object_attr('10452', '5EC79376D75B43FD81D098D60CF69613', '863', 'cv_entered', '10020780', '2018-04-20T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('10460', '5EC79376D75B43FD81D098D60CF69613', '1949', '0', '10020788', '2018-04-20T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('9478', '5EC79376D75B43FD81D098D60CF69613', '120', 'ck_page', '10020788', '2018-04-20T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('10456', '5EC79376D75B43FD81D098D60CF69613', '127', 'remote', '10020780', '2018-04-20T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('210025169321', '5EC79376D75B43FD81D098D60CF69613', '1053', '25%', '10020788', '2019-01-18T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('15', 'EA7CFCD39A2948C2876FB8D0CF5BDC88', '120', 'ck_class', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('13', 'EA7CFCD39A2948C2876FB8D0CF5BDC88', '125', 'cv_displayed', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('11', 'EA7CFCD39A2948C2876FB8D0CF5BDC88', '123', 'true', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('14', 'EA7CFCD39A2948C2876FB8D0CF5BDC88', '126', 'ck_id', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('698', 'EA7CFCD39A2948C2876FB8D0CF5BDC88', '570', 'true', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2767', '58E95625857C4D1B971A6FEE15321AE0', '261', 'ck_parent', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2775', '58E95625857C4D1B971A6FEE15321AE0', '267', 'ck_id', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2788', '58E95625857C4D1B971A6FEE15321AE0', '994', null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2780', '58E95625857C4D1B971A6FEE15321AE0', '361', 'cv_name', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2773', '58E95625857C4D1B971A6FEE15321AE0', '859', 'cv_name_lowered', '20780', '2018-11-26T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2776', '9CB84B9533954CFFADFD349290E48881', '150', 'MTCopyObject', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2774', '9CB84B9533954CFFADFD349290E48881', '140', 'onSimpleSaveWindow', '10020786', '2018-07-03T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('18', '98B367129551441BBC75BD5D42783962', '120', 'ck_query', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('17', '98B367129551441BBC75BD5D42783962', '126', 'ck_id', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('16', '98B367129551441BBC75BD5D42783962', '125', 'ck_id', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2787', '9FD9EF21FA5C47BAA05E3C89C1211C58', '147', '2', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2786', '9FD9EF21FA5C47BAA05E3C89C1211C58', '140', 'onCloseWindow', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('12', 'A250C26B41F84282BEBAE459FA63CE26', '73', 'true', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('19', 'A250C26B41F84282BEBAE459FA63CE26', '86', 'cv_name', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('20', '21E9F838378546E69359B0FF5313B9CA', '86', 'cv_description', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('34', '21E9F838378546E69359B0FF5313B9CA', '73', 'true', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('29', '614202FC3A134191A5AB44D37F05BB40', '85', 'cn_order', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('31', '614202FC3A134191A5AB44D37F05BB40', '72', 'true', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('FCC54FC30B7543DCA69DE479AC07A847', '9F921E25EF614B7087D8F200AFE60E30', '120', 'cv_displayed', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-22T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('1D5F4958510241DEBC744EDC2D46B820', '9F921E25EF614B7087D8F200AFE60E30', '125', 'cv_value', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-22T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('A5DE1F5B70ED4775BDF907795CB7347C', '9F921E25EF614B7087D8F200AFE60E30', '126', 'ck_id', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-22T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('6F7F0A77D419460793A60F330684C87E', '9F921E25EF614B7087D8F200AFE60E30', '752', 'new:', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-22T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('892', '06EBBAD0F5654999961313AD74F35758', '86', 'cv_modify', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('6556', '71BEBE8212AE43CCAB228CD54AF6A348', '126', 'key', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('6557', '71BEBE8212AE43CCAB228CD54AF6A348', '125', 'value', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('6559', '71BEBE8212AE43CCAB228CD54AF6A348', '123', 'true', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('6553', '71BEBE8212AE43CCAB228CD54AF6A348', '120', 'ck_provider', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('25', '96D701D6167142548E0CC663F4B05B06', '140', 'onSimpleSaveWindow', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('21', '820F0FE7A24A4B9F9DE25211D70A6A76', '147', '2', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('23', '820F0FE7A24A4B9F9DE25211D70A6A76', '140', 'onCloseWindow', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2782', '499F2085815F48CCAE347C7DFEC8385A', '52', 'cv_name', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('12187664821', '499F2085815F48CCAE347C7DFEC8385A', '13181', 'cv_name_lowered', '20788', '2018-11-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2772', '08D6997839684C678BDE60466CF6684D', '47', 'cv_description', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('5438D5F75E6D4CCB92CFCED7AFDA951C', '8', null, 'SYS Grid Object Attribute << DO NOT CHANGE', 1000401, 'MTObjectAttribute', 'Грид "Атрибуты объекта"', 'Атрибуты объекта', 'pkg_json_meta.f_modify_object_attr', 'meta', '20788', '2018-11-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object('AD92CE96A2054131B22B632935101B9E', '58', '5438D5F75E6D4CCB92CFCED7AFDA951C', 'Filter', 10, null, 'Filter', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-21T00:00:00.000+0000');
select pkg_patcher.p_merge_object('482CF93188074352A883B2C22D0945F8', '16', '5438D5F75E6D4CCB92CFCED7AFDA951C', 'Button Edit', 100, null, 'Кнопка "Редактировать" в гриде', 'Редактировать', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('AC0C3A9C3BB7491D9F300E75EB893683', '9', '5438D5F75E6D4CCB92CFCED7AFDA951C', 'Column Name', 300, null, 'Колонка "Наименование"', 'Наименование', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('5540018FA2FC4C619E0A90969D8E7B6B', '9', '5438D5F75E6D4CCB92CFCED7AFDA951C', 'Column default value', 400, null, 'Колонка "Значение по умолчанию"', 'Значение по умолчанию', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('948B958349E94465AD6DDE0D1D81123E', '9', '5438D5F75E6D4CCB92CFCED7AFDA951C', 'Column value', 500, null, 'Колонка "Значение (переопределенное)"', 'Значение (переопределенное)', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('B25593736D6549B498335251E1FB280C', '9', '5438D5F75E6D4CCB92CFCED7AFDA951C', 'Object Attr Desc', 600, null, 'Описание атрибута', 'Описание', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('18535FD223624FB5B6F57ACE83DF8592', '8D547C621A02626CE053809BA8C0882B', 'AD92CE96A2054131B22B632935101B9E', 'AttrType Radio', 10, 'MTObjectAttrType', 'Тип атрибута', 'Тип атрибута', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-21T00:00:00.000+0000');
select pkg_patcher.p_merge_object('87DD0319961C49E182C7D5ACA7FCECE7', '31', '948B958349E94465AD6DDE0D1D81123E', 'Object Attr Value Field', 100, 'MTGetValuesByAttr', 'Поле редактирование значения атрибута', null, null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('1560', '5438D5F75E6D4CCB92CFCED7AFDA951C', '852', 'ck_attr', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('8322', '5438D5F75E6D4CCB92CFCED7AFDA951C', '1600', '440', '10020788', '2018-03-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('93132', '5438D5F75E6D4CCB92CFCED7AFDA951C', '28169', 'true', '10020785', '2018-10-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('729DA2A4D55B40B19AACF8CA35668C50', 'AD92CE96A2054131B22B632935101B9E', '642', 'true', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-21T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('493', 'AC0C3A9C3BB7491D9F300E75EB893683', '433', 'disabled', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('5', 'AC0C3A9C3BB7491D9F300E75EB893683', '47', 'ck_attr', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('6', '5540018FA2FC4C619E0A90969D8E7B6B', '47', 'cv_value_attr', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('494', '5540018FA2FC4C619E0A90969D8E7B6B', '433', 'disabled', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('7', '948B958349E94465AD6DDE0D1D81123E', '47', 'cv_value', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('495', 'B25593736D6549B498335251E1FB280C', '47', 'cv_description', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('496', 'B25593736D6549B498335251E1FB280C', '433', 'disabled', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('1B2AEF70A286472EB979EF9FCD3F9FD0', '18535FD223624FB5B6F57ACE83DF8592', '8D2BA0EF36FE627EE053809BA8C0076B', 'hbox', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-21T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('751AEFE9F71246D8AA40E597893D10BC', '18535FD223624FB5B6F57ACE83DF8592', '8D3A50B6DE936276E053809BA8C0911C', '##first##', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-21T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('C63E91061E954CEA87F500CCA089AACF', '18535FD223624FB5B6F57ACE83DF8592', '8D3A50B6DE926276E053809BA8C0911C', 'ck_id', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-21T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('C9D9491433E24DBEBDACA31D498EE221', '18535FD223624FB5B6F57ACE83DF8592', '8D4FD9E32883628AE053809BA8C080EB', 'cv_name', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-21T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('3A705832D79D4482A2203647ECA070A9', '18535FD223624FB5B6F57ACE83DF8592', '8D3A50B6DE906276E053809BA8C0911C', 'ck_attr_type', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-21T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('4F29931758184B7E93AC3B7BB8C6DC1C', '18535FD223624FB5B6F57ACE83DF8592', '8FE6D5F194F92655E053809BA8C008C3', '17%', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-22T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2015', '87DD0319961C49E182C7D5ACA7FCECE7', '120', 'cv_value', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2380', '87DD0319961C49E182C7D5ACA7FCECE7', '570', 'false', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('1590', '87DD0319961C49E182C7D5ACA7FCECE7', '127', 'remote', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2013', '87DD0319961C49E182C7D5ACA7FCECE7', '126', 'cv_value', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('1593', '87DD0319961C49E182C7D5ACA7FCECE7', '752', 'new:', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('1592', '87DD0319961C49E182C7D5ACA7FCECE7', '861', 'ck_attr', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('1591', '87DD0319961C49E182C7D5ACA7FCECE7', '863', 'cv_entered', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2014', '87DD0319961C49E182C7D5ACA7FCECE7', '125', 'cv_value', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('10713', '87DD0319961C49E182C7D5ACA7FCECE7', '121', '4000', '10020786', '2018-05-08T00:00:00.000+0000');
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('306B3B3992A44685B1A09902050D3228', '1', 'A27411E018F34D16B5ABE97BCB6DBDF0', 1, null, null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('22AA246E373546899EC50493835F780F', '1', '5438D5F75E6D4CCB92CFCED7AFDA951C', 2, null, null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('F2AE8C38C64446AD95BE4D99A8E19D45', '1', 'AD92CE96A2054131B22B632935101B9E', 10, '22AA246E373546899EC50493835F780F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('5BC75EFB1F22498C92D617CCC4D9459A', '1', '20E904F618D14931B946EFA7E8201725', 100, '306B3B3992A44685B1A09902050D3228', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('F4EA1B949CEC4DCEBBEFF4285FD6A59F', '1', '482CF93188074352A883B2C22D0945F8', 100, '22AA246E373546899EC50493835F780F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('20448061DAF4462683DD1343F986ECAA', '1', '847FF29EEEBB450480BC720A2E849B1C', 115, '306B3B3992A44685B1A09902050D3228', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('9349191EC2654190BE2325F1F2EE4B93', '1', '02E1029A8DCF4C41BDAF134464984704', 150, '306B3B3992A44685B1A09902050D3228', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('65552273CDF148AC881048460B80A88C', '1', '085D40FB3F574204916A44658A636158', 180, '306B3B3992A44685B1A09902050D3228', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('08F2EBA952044F48ABED6865A93B75D3', '1', '61A30167AC624DD98559417D42BCF027', 250, '306B3B3992A44685B1A09902050D3228', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('5506C24A5C094288A22F57D13203B055', '1', '38BC13060F1646B588299CBAA2F7C370', 300, '306B3B3992A44685B1A09902050D3228', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('EC56BD51F6DA46F2ABAF0D5E1EC419C2', '1', 'AC0C3A9C3BB7491D9F300E75EB893683', 300, '22AA246E373546899EC50493835F780F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('5ADC0815FA284A35A51CD2847340D0B9', '1', '0202F94F3F624C13865A2B0AA9E8FDE5', 400, '306B3B3992A44685B1A09902050D3228', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('27494478C2DD44FF9D18B7D871CE32E4', '1', '5540018FA2FC4C619E0A90969D8E7B6B', 400, '22AA246E373546899EC50493835F780F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('2031C83D842E4F829B7EAC43A66418F9', '1', 'D853B3E280224C6C8C173CE8E7D2F484', 500, '306B3B3992A44685B1A09902050D3228', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('79163CFACEBB4E2B91F42CE00892EBEB', '1', '948B958349E94465AD6DDE0D1D81123E', 500, '22AA246E373546899EC50493835F780F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('828FE3C30650453C8A5CC6E6D55D1416', '1', '84FFDBDA747849B1E053809BA8C0D55B', 550, '306B3B3992A44685B1A09902050D3228', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('A0E66A88D08D4679A9234C7596E8987B', '1', '52354F089D7D42958DE7EF095B3E55C1', 600, '306B3B3992A44685B1A09902050D3228', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('538120EBECDD4780943A668C5D47629E', '1', 'B25593736D6549B498335251E1FB280C', 600, '22AA246E373546899EC50493835F780F', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('DEA794B68B59463EB95F4B3BAF739C59', '1', '16E65663C5714E269C8289281C18DCA8', 700, '306B3B3992A44685B1A09902050D3228', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('2B2B31875CE34EC6A7F72DC740CA897E', '1', 'A3875FB63D7042A6B61B371720EA55BF', 800, '306B3B3992A44685B1A09902050D3228', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('CC9DA397BCBD49958498967C2B35909E', '1', '66E12B205EC54282896B6B2498DE65A2', 900, '306B3B3992A44685B1A09902050D3228', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('661AB94C8954493BB1343989C376D78A', '1', '04ACBA57BDB541699A459C20B4906BFD', 1000, '306B3B3992A44685B1A09902050D3228', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('AD72A32F6EE74555A4A524DCDFEE773D', '1', '18535FD223624FB5B6F57ACE83DF8592', 10, 'F2AE8C38C64446AD95BE4D99A8E19D45', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('DDF08ED596C3425F99181DF963A9FF1D', '1', '919257042BA64D498D596BA60FC05385', 10, '20448061DAF4462683DD1343F986ECAA', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('57F0FF893E00435F899FCEF5F2BEBD41', '1', '5EC79376D75B43FD81D098D60CF69613', 20, '20448061DAF4462683DD1343F986ECAA', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('D854DB6CE599402782B9D7393BDA9AE7', '1', 'EA7CFCD39A2948C2876FB8D0CF5BDC88', 100, '65552273CDF148AC881048460B80A88C', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('FF087C613B3E42989CB56C8549032429', '1', '58E95625857C4D1B971A6FEE15321AE0', 100, '08F2EBA952044F48ABED6865A93B75D3', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('C8726248EB16494F89351E40C29E8A5C', '1', '87DD0319961C49E182C7D5ACA7FCECE7', 100, '79163CFACEBB4E2B91F42CE00892EBEB', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('9644F1A37F144E7B8EC43F577F06151B', '1', '9CB84B9533954CFFADFD349290E48881', 200, '08F2EBA952044F48ABED6865A93B75D3', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('9D949E1C20E34B788F14517B4D5BB5E2', '1', '98B367129551441BBC75BD5D42783962', 200, '65552273CDF148AC881048460B80A88C', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('C7E87A993F35499F819839956B108597', '1', '9FD9EF21FA5C47BAA05E3C89C1211C58', 300, '08F2EBA952044F48ABED6865A93B75D3', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('5F90BD4EEBFB44E2AF4376697440F7BB', '1', 'A250C26B41F84282BEBAE459FA63CE26', 300, '65552273CDF148AC881048460B80A88C', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('E1BDFAF851D442A1A593E3E9C39E5FAA', '1', '21E9F838378546E69359B0FF5313B9CA', 400, '65552273CDF148AC881048460B80A88C', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('C91555220C17472E863749B3B678EDEC', '1', '614202FC3A134191A5AB44D37F05BB40', 600, '65552273CDF148AC881048460B80A88C', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('ADA51C14EDA94537B08AD5E1E6251FF7', '1', '9F921E25EF614B7087D8F200AFE60E30', 700, '65552273CDF148AC881048460B80A88C', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('D5654BA1A09243FD89101090D949653C', '1', '06EBBAD0F5654999961313AD74F35758', 800, '65552273CDF148AC881048460B80A88C', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('8C0F3163D61B4DC293002CF8C4D7EAC3', '1', '71BEBE8212AE43CCAB228CD54AF6A348', 900, '65552273CDF148AC881048460B80A88C', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('9F4CC86103234915B8DD9BD31FA34621', '1', '96D701D6167142548E0CC663F4B05B06', 1200, '65552273CDF148AC881048460B80A88C', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('62FE6CB16B0843B897CFA0F3B0048705', '1', '820F0FE7A24A4B9F9DE25211D70A6A76', 1300, '65552273CDF148AC881048460B80A88C', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('FA11C42337874A4E8F68B1F8F5E2C8A8', '1', '499F2085815F48CCAE347C7DFEC8385A', 100, 'FF087C613B3E42989CB56C8549032429', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7B1F8DBA4B544441BB5F262CCE50EF1D', '1', '08D6997839684C678BDE60466CF6684D', 200, 'FF087C613B3E42989CB56C8549032429', null, '20788', '2018-11-23T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('667E102B50234F9D93D664DBD48A9E86', '306B3B3992A44685B1A09902050D3228', '1181', 'gck_object', '20780', '2019-03-21T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('5FF84C70B432462689B0A3635F45C827', 'D5654BA1A09243FD89101090D949653C', '1190', 'g_cv_modify', '20788', '2018-11-23T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('7E1CDC5F58934DD48B2495EC51BE97E8', '8C0F3163D61B4DC293002CF8C4D7EAC3', '125', null, '20788', '2018-11-23T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('64D773F9ED14401F8DE2C813E2DF3EAF', '8C0F3163D61B4DC293002CF8C4D7EAC3', '1255', '!g_cv_modify', '20788', '2018-11-23T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('DE12E92EAD7646A9AA66DA67760A0063', '9F4CC86103234915B8DD9BD31FA34621', '151', null, '20788', '2018-11-23T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('C1F1EA6FA7DF4B94952529685DC4CB81', 'C8726248EB16494F89351E40C29E8A5C', '1949', '0', '20788', '2018-11-23T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
update s_mt.t_page_object set ck_master='306B3B3992A44685B1A09902050D3228' where ck_id='08F2EBA952044F48ABED6865A93B75D3';
update s_mt.t_page_object set ck_master='306B3B3992A44685B1A09902050D3228' where ck_id='22AA246E373546899EC50493835F780F';
update s_mt.t_page_object set ck_master='08F2EBA952044F48ABED6865A93B75D3' where ck_id='5506C24A5C094288A22F57D13203B055';
update s_mt.t_page_object set ck_master='306B3B3992A44685B1A09902050D3228' where ck_id='5BC75EFB1F22498C92D617CCC4D9459A';
update s_mt.t_page_object set ck_master='306B3B3992A44685B1A09902050D3228' where ck_id='9349191EC2654190BE2325F1F2EE4B93';
update s_mt.t_page_object set ck_master='306B3B3992A44685B1A09902050D3228' where ck_id='9644F1A37F144E7B8EC43F577F06151B';
update s_mt.t_page_object set ck_master='306B3B3992A44685B1A09902050D3228' where ck_id='9F4CC86103234915B8DD9BD31FA34621';
update s_mt.t_page_object set ck_master='22AA246E373546899EC50493835F780F' where ck_id='C8726248EB16494F89351E40C29E8A5C';
update s_mt.t_page_object set ck_master='306B3B3992A44685B1A09902050D3228' where ck_id='D854DB6CE599402782B9D7393BDA9AE7';
