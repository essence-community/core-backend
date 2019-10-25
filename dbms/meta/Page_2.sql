--liquibase formatted sql
--changeset patcher-core:Page_2 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
with recursive page as (
select
    ck_id
from
    s_mt.t_page
where
    ck_id = '2'
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
    ck_id = '2'
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
        ck_id = '2'
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
        ck_id = '2'
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
    ck_id = '2'
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

INSERT INTO s_mt.t_page (ck_id, ck_parent, cr_type, cv_name, cn_order, cl_static, cv_url, ck_icon, ck_user, ct_change, cl_menu)VALUES('2', '5', 2, 'Страницы', 1, 0, null, '266', '10028610', '2019-02-16T00:00:00.000+0000', 1) on conflict (ck_id) do update set ck_parent = excluded.ck_parent, cr_type = excluded.cr_type, cv_name = excluded.cv_name, cn_order = excluded.cn_order, cl_static = excluded.cl_static, cv_url = excluded.cv_url, ck_icon = excluded.ck_icon, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_menu = excluded.cl_menu;
INSERT INTO s_mt.t_page_action (ck_id, ck_page, cr_type, cn_action, ck_user, ct_change)VALUES('22', '2', 'edit', 512, '-11', '2018-02-23T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cr_type = excluded.cr_type, cn_action = excluded.cn_action, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_action (ck_id, ck_page, cr_type, cn_action, ck_user, ct_change)VALUES('21', '2', 'view', 511, '-11', '2018-02-23T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cr_type = excluded.cr_type, cn_action = excluded.cn_action, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_variable (ck_id, ck_page, cv_name, cv_description, ck_user, ct_change)VALUES('138', '2', 'gck_object', 'требуется актуализировать', '10020788', '2018-07-22T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cv_name = excluded.cv_name, cv_description = excluded.cv_description, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_variable (ck_id, ck_page, cv_name, cv_description, ck_user, ct_change)VALUES('1020873', '2', 'gcl_static', 'Признак статической страницы', '20788', '2018-12-08T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cv_name = excluded.cv_name, cv_description = excluded.cv_description, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_variable (ck_id, ck_page, cv_name, cv_description, ck_user, ct_change)VALUES('1029303', '2', 'gcr_type', 'Тип создаваемой страницы', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-09-10T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cv_name = excluded.cv_name, cv_description = excluded.cv_description, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_variable (ck_id, ck_page, cv_name, cv_description, ck_user, ct_change)VALUES('55EC49B459794101B5F5C1C3975E2D4F', '2', 'gr_type_page', 'Тип выбранной страницы', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-09-10T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cv_name = excluded.cv_name, cv_description = excluded.cv_description, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
select pkg_patcher.p_merge_object('E56A94F186CA495BAEF39DF68B68681A', '18', null, 'SYS Grid Page << DO NOT CHANGE', 1000100, 'MTPage', 'Страницы', null, 'pkg_json_meta.f_modify_page', 'meta', '10020780', '2018-03-01T00:00:00.000+0000');
select pkg_patcher.p_merge_object('3DF8D382476C409FAFE16C90AF5E8339', '19', 'E56A94F186CA495BAEF39DF68B68681A', 'Top BTN Create Page', 100, null, 'Создание страницы', 'Создать страницу', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('E0799FB264604C54973DF0B6A49BD63E', '16', 'E56A94F186CA495BAEF39DF68B68681A', 'Edit Page', 150, null, 'Редактирование страниц', null, null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('D94343DAF0AC4B85A29C0DA667BEE539', '19', 'E56A94F186CA495BAEF39DF68B68681A', 'Reset Meta Cache', 200, null, 'Сбросить кэш на шлюзе', 'Сбросить кэш на шлюзе', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('3DD16DB9F9D64C6CA05252512E9BCDD3', '57', 'E56A94F186CA495BAEF39DF68B68681A', 'Refresh Page', 300, null, 'Обновление объектов страницы', null, null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('9637E6808A1B4196A2D6FD33BD85F326', '57', 'E56A94F186CA495BAEF39DF68B68681A', 'Column Icon Page', 400, null, 'Колонка выводящая иконку', 'Иконка', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('801B8290FF5F4C5399D150197D34833E', '17', 'E56A94F186CA495BAEF39DF68B68681A', 'Page Name', 500, null, 'Наименование страницы', 'Наименование страницы', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('E109C4675B564AD7AE5D4B1091E6C5CF', '77', 'E56A94F186CA495BAEF39DF68B68681A', 'cr_type_invisible', 550, null, 'cr_type_invisible', null, null, null, '20788', '2018-12-08T00:00:00.000+0000');
select pkg_patcher.p_merge_object('CBB07C568B094B1F82ED07BE368528F4', '77', 'E56A94F186CA495BAEF39DF68B68681A', 'cn_action_view', 600, null, 'cn_action_view', 'Код действия просмотра', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('B84591FA11C44C2581144504E7E2DFC7', '77', 'E56A94F186CA495BAEF39DF68B68681A', 'cn_action_edit', 700, null, 'cn_action_edit', 'Код действия модификации', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('5718878CB06C4E6DB5F6ABF555A33F4D', '9', 'E56A94F186CA495BAEF39DF68B68681A', 'Order Column', 800, null, 'Order Column', 'Порядок', null, null, '10020785', '2018-07-26T00:00:00.000+0000');
select pkg_patcher.p_merge_object('A2E08196F3CF4E8494FEA91DA200D361', '32', 'E56A94F186CA495BAEF39DF68B68681A', 'Add/Edit Page Window', 1000, null, 'Страницы', null, null, null, '10020780', '2018-03-01T00:00:00.000+0000');
select pkg_patcher.p_merge_object('1D150D1369E24783B7041818833097AB', '26', 'A2E08196F3CF4E8494FEA91DA200D361', 'Name Page', 100, null, 'Наименование страницы', 'Наименование', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('2246D7F3D7544A13A4B4E37DC232070D', '31', 'A2E08196F3CF4E8494FEA91DA200D361', 'cr_type', 400, 'MTGetTpPage', 'Выбор типа страницы', 'Тип', null, null, '20788', '2018-12-08T00:00:00.000+0000');
select pkg_patcher.p_merge_object('68E2ADA0B2CC4BD893CEB06D7D8D17D2', '27', 'A2E08196F3CF4E8494FEA91DA200D361', 'Order Page Field', 600, null, 'Порядок страниц', 'Порядок', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('27A16490A6234559BC556A47FA6E3C14', '38', 'A2E08196F3CF4E8494FEA91DA200D361', 'Field Icon Table', 700, 'MTIcon', 'Выбор иконки', 'Иконка', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('07810FE0DE1A49E0813EF0866D06D584', '27', 'A2E08196F3CF4E8494FEA91DA200D361', 'cn_action_view', 710, null, 'cn_action_view', 'Код действия просмотра', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('AF666D67CE794E3EA8237B971C5ACB65', '27', 'A2E08196F3CF4E8494FEA91DA200D361', 'cn_action_edit', 720, null, 'cn_action_edit', 'Код действия модификации', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('813AE10488CC4365E053809BA8C03542', '29', 'A2E08196F3CF4E8494FEA91DA200D361', 'cl_menu', 730, null, 'Отображать страницу в основном меню?', 'Отображать в меню', null, null, '10028610', '2019-02-07T00:00:00.000+0000');
select pkg_patcher.p_merge_object('1B89D8746D4F4AB9A505A8C3738138E0', '29', 'A2E08196F3CF4E8494FEA91DA200D361', 'cl_static', 750, null, 'Признак статичности страницы', 'Статическая страница', null, null, '20788', '2018-12-08T00:00:00.000+0000');
select pkg_patcher.p_merge_object('ED7E10DA3BBB45558F850F1E43BA967D', '26', 'A2E08196F3CF4E8494FEA91DA200D361', 'Url Page Field', 800, null, 'Ссылка', 'Ссылка', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('58DFD9E372DC4BBC891F8723E554E185', '19', 'A2E08196F3CF4E8494FEA91DA200D361', 'Botton Btn Save', 2000, null, 'Сохранение', 'Сохранить', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('DA7805DF671B46658EE88E36E280D3A2', '19', 'A2E08196F3CF4E8494FEA91DA200D361', 'Botton Btn Close', 3000, null, 'Отмена', 'Отмена', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('0634B02B58AB42A4867C36C9CDA4808E', '57', '27A16490A6234559BC556A47FA6E3C14', 'Column Icon', 100, null, 'Колонка с иконкой', 'Иконка', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('B4DF5B3F933744819E24CABB022C5944', '9', '27A16490A6234559BC556A47FA6E3C14', 'Column Name', 200, null, 'Наименование иконки', 'Наименование', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('210', 'E56A94F186CA495BAEF39DF68B68681A', '167', 'true', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('5473', 'E56A94F186CA495BAEF39DF68B68681A', '1607', '400', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('1557', 'E56A94F186CA495BAEF39DF68B68681A', '854', 'cn_order', '10020785', '2018-05-10T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('82', '3DF8D382476C409FAFE16C90AF5E8339', '155', '1', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('81', '3DF8D382476C409FAFE16C90AF5E8339', '140', 'onCreateChildWindowMaster', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('201873972621', '3DF8D382476C409FAFE16C90AF5E8339', '992', 'fa-plus', '20780', '2019-01-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('571828424221', '3DF8D382476C409FAFE16C90AF5E8339', '1033', 'window', '10028610', '2019-03-01T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('207', 'E0799FB264604C54973DF0B6A49BD63E', '25', 'onRowCreateChildWindowMaster', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('571839636321', 'E0799FB264604C54973DF0B6A49BD63E', '1493', 'window', '10028610', '2019-03-01T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('6525', 'D94343DAF0AC4B85A29C0DA667BEE539', '150', 'MetaResetCache', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('6523', 'D94343DAF0AC4B85A29C0DA667BEE539', '992', 'mdi-lock-reset', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('6522', 'D94343DAF0AC4B85A29C0DA667BEE539', '991', 'mdi', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('6524', 'D94343DAF0AC4B85A29C0DA667BEE539', '1695', 'true', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('6526', 'D94343DAF0AC4B85A29C0DA667BEE539', '155', '4', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('6533', 'D94343DAF0AC4B85A29C0DA667BEE539', '1997', 'Сбросить кэш на шлюзе?', '10020788', '2018-03-29T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('112883534921', 'D94343DAF0AC4B85A29C0DA667BEE539', '1682', 'Сбросить кэш на шлюзе. <br> Кешируется следующее: <br> 1) список ошибок t_message <br> 2) Метаинформация страниц (перечень pageobject) <br> 3) Правовые доступы для запросов <br> 4) Связь запросов с методами модификаций', '20848', '2018-12-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('778', '3DD16DB9F9D64C6CA05252512E9BCDD3', '592', 'MTRefreshPageObject', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('776', '3DD16DB9F9D64C6CA05252512E9BCDD3', '591', '4', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('775', '3DD16DB9F9D64C6CA05252512E9BCDD3', '589', 'Обновить привязку объектов', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('777', '3DD16DB9F9D64C6CA05252512E9BCDD3', '353', 'fa-refresh', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('774', '3DD16DB9F9D64C6CA05252512E9BCDD3', '1989', 'Обновить привязку объектов?', '10020788', '2018-03-29T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('355', '9637E6808A1B4196A2D6FD33BD85F326', '354', 'true', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('5765', '9637E6808A1B4196A2D6FD33BD85F326', '560', 'false', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('357', '9637E6808A1B4196A2D6FD33BD85F326', '353', 'cv_icon_name', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('356', '9637E6808A1B4196A2D6FD33BD85F326', '352', 'cv_icon_font', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('35', '801B8290FF5F4C5399D150197D34833E', '52', 'cv_name', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('7153', 'E109C4675B564AD7AE5D4B1091E6C5CF', '451', 'false', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('7152', 'E109C4675B564AD7AE5D4B1091E6C5CF', '444', 'cr_type', '20788', '2018-12-08T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('7137', 'CBB07C568B094B1F82ED07BE368528F4', '444', 'cn_action_view', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('7138', 'B84591FA11C44C2581144504E7E2DFC7', '444', 'cn_action_edit', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('36072', '5718878CB06C4E6DB5F6ABF555A33F4D', '47', 'cn_order', '10020785', '2018-07-26T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('571850848421', 'A2E08196F3CF4E8494FEA91DA200D361', '1029', 'window', '10028610', '2019-03-01T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('193', '1D150D1369E24783B7041818833097AB', '86', 'cv_name', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('10244', '1D150D1369E24783B7041818833097AB', '73', 'true', '10020848', '2018-04-16T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('198', '2246D7F3D7544A13A4B4E37DC232070D', '123', 'true', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('200', '2246D7F3D7544A13A4B4E37DC232070D', '126', 'cn_key', '20788', '2018-12-08T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('201', '2246D7F3D7544A13A4B4E37DC232070D', '125', 'cv_value', '20788', '2018-12-08T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('197', '2246D7F3D7544A13A4B4E37DC232070D', '120', 'cr_type', '20788', '2018-12-08T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('333', '68E2ADA0B2CC4BD893CEB06D7D8D17D2', '72', 'true', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('215', '68E2ADA0B2CC4BD893CEB06D7D8D17D2', '85', 'cn_order', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('368', '27A16490A6234559BC556A47FA6E3C14', '362', 'cv_name', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('367', '27A16490A6234559BC556A47FA6E3C14', '303', 'ck_id', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('369', '27A16490A6234559BC556A47FA6E3C14', '297', 'ck_icon', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('7139', '07810FE0DE1A49E0813EF0866D06D584', '85', 'cn_action_view', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('7142', '07810FE0DE1A49E0813EF0866D06D584', '1371', 'Код действия из СУВК, которое разрешает открывать страницу', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('7140', 'AF666D67CE794E3EA8237B971C5ACB65', '85', 'cn_action_edit', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('7141', 'AF666D67CE794E3EA8237B971C5ACB65', '1371', 'Код действия из СУВК, которое разрешает редактировать данные', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('325173436321', '813AE10488CC4365E053809BA8C03542', '94', 'cl_menu', '10028610', '2019-02-07T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('325184648421', '813AE10488CC4365E053809BA8C03542', '869', '1', '10028610', '2019-02-07T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('243', '1B89D8746D4F4AB9A505A8C3738138E0', '97', 'false', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('244', '1B89D8746D4F4AB9A505A8C3738138E0', '94', 'cl_static', '20788', '2018-12-08T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('6613', '1B89D8746D4F4AB9A505A8C3738138E0', '869', '0', '20788', '2018-12-08T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('245', 'ED7E10DA3BBB45558F850F1E43BA967D', '86', 'cv_url', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('578DBFF6833B4FBBB9D6F1C2A9EC7DAA', 'ED7E10DA3BBB45558F850F1E43BA967D', '73', 'true', '1', '2019-08-28T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('EB1B5B62260241BDB96AB4A3FD912B46', 'ED7E10DA3BBB45558F850F1E43BA967D', '61', '[-a-zA-Z0-9_]+', '1', '2019-08-28T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('903C80521E3F63DFE053809BA8C029CA', 'ED7E10DA3BBB45558F850F1E43BA967D', '1370', 'Доступные символы: [0-9],[a-z],[A-Z],[_],[-]. <br/>Запрещено использовать подряд идущие или одиночные символы "_", "-", а также их комбинации', '1', '2019-08-30T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('206', '58DFD9E372DC4BBC891F8723E554E185', '140', 'onSimpleSaveWindow', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('209', 'DA7805DF671B46658EE88E36E280D3A2', '147', '2', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('205', 'DA7805DF671B46658EE88E36E280D3A2', '140', 'onCloseWindow', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('372', '0634B02B58AB42A4867C36C9CDA4808E', '353', 'cv_name', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('370', '0634B02B58AB42A4867C36C9CDA4808E', '352', 'cv_font', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('8D3AF443FFA5625EE053809BA8C08428', '0634B02B58AB42A4867C36C9CDA4808E', '354', 'true', '20780', '2019-07-09T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('374', 'B4DF5B3F933744819E24CABB022C5944', '47', 'cv_name', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('7A5F95F042574D54915061C1090C9ADC', '18', null, 'SYS Grid Page Object << DO NOT CHANGE', 1000300, 'MTPageObject', 'Объекты на странице', null, 'pkg_json_meta.f_modify_page_object', 'meta', '10020780', '2018-03-02T00:00:00.000+0000');
select pkg_patcher.p_merge_object('5D7E99789C4C4AE38CF614A340343C62', '32', '7A5F95F042574D54915061C1090C9ADC', 'Add Object to Page Window', 100, null, 'Объекты на странице', 'Добавление объекта на страницу', null, null, '20780', '2019-05-29T00:00:00.000+0000');
select pkg_patcher.p_merge_object('16D8DF6E515F4274A69908D7FA34EB30', '19', '7A5F95F042574D54915061C1090C9ADC', 'Top Btn Add Object', 120, null, 'Добавление объекта в страницу', 'Добавить объект', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('41FC947229F54E8EB1A5A302A69EC23F', '16', '7A5F95F042574D54915061C1090C9ADC', 'Edit Object Page', 150, null, 'Редактирование объекта страницы', null, null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('95467F5511694BA6A9E982493356D3A1', '257', '7A5F95F042574D54915061C1090C9ADC', 'Переход на страницу', 300, null, 'Переход на страницу', 'Перейти в "Объекты"', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('32BC0ECB10F34E30AD727CBD97719E26', '17', '7A5F95F042574D54915061C1090C9ADC', 'Object Name', 350, null, 'Наименование объекта', 'Наименование объекта', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('E5A0DC93F74E475BA2F3E21328846FCA', '9', '7A5F95F042574D54915061C1090C9ADC', 'Name Class', 400, null, 'Наименование класса', 'Наименование класса', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('00BADB0DA18D4B2994866FC2FF7C411F', '9', '7A5F95F042574D54915061C1090C9ADC', 'Displaed Name', 450, null, 'Отображаемое имя', 'Отображаемое имя', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-10-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object('99F9D324EB484401A1F66491B2D64809', '9', '7A5F95F042574D54915061C1090C9ADC', 'Desc object', 500, null, 'Описание', 'Описание', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('D2DE62CD05FE4246AD8B39638CF96B8C', '9', '7A5F95F042574D54915061C1090C9ADC', 'Order Column', 600, null, 'Порядок', 'Порядок', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('E843C8A56FF744F18C0ACD61B816CE98', '9', '7A5F95F042574D54915061C1090C9ADC', 'Master Obj Name', 700, null, 'Имя мастер-объекта', 'Мастер', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('4E1B4314D2834E84BCEDC56A9EF5405F', '9', '7A5F95F042574D54915061C1090C9ADC', 'Master Column', 10000, null, 'Колонка Мастер', 'Мастер', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('A97413B7060046EF8D43C14B67B0F22D', '27', 'D2DE62CD05FE4246AD8B39638CF96B8C', 'Field Edit Order', 100, null, 'Редактирование порядка', null, null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('1D6170D4FF9E47E49268FD2A70CE3C53', '37', '4E1B4314D2834E84BCEDC56A9EF5405F', 'Field Master Edit', 100, 'MTPageObject', 'Поле выбора мастера', 'Мастер', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('4002FD9CB8904DC98C41A1D7D86A1B82', '31', '32BC0ECB10F34E30AD727CBD97719E26', 'Object Page Field', 100, 'MTGetObjectByParent', 'Выбор объекта из списка', 'Объект', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('80B07F19416149CA8FC56FEB8E9C6757', '31', '5D7E99789C4C4AE38CF614A340343C62', 'Object combo Field', 100, 'MTGetObjectByParent', 'Полу выбора объекта', 'Объект', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('6FE3C6BCC2C341F690856E77DB1CE30F', '27', '5D7E99789C4C4AE38CF614A340343C62', 'Order Object Field', 200, null, 'Поле выбора порядка', 'Порядок', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('281B061975594403AF492B839C2C1BB8', '37', '5D7E99789C4C4AE38CF614A340343C62', 'Field Master Object', 300, 'MTPageObject', 'Поле выбора матера', 'Выбор мастера', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('2CF0B4177AC944EF9D0F41728063F8ED', '19', '5D7E99789C4C4AE38CF614A340343C62', 'Btn Save Add Object', 1200, null, 'Сохраняем объект', 'Сохранить', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('CCFF180E309042B1BDE6D618737BEC05', '19', '5D7E99789C4C4AE38CF614A340343C62', 'Close Btn', 1300, null, 'Отмена', 'Отмена', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('67230B532F99404CBD12ACCFFE415947', '17', '281B061975594403AF492B839C2C1BB8', 'Column Name Object', 100, null, 'Колонка имени объекта', 'Наименование', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('9C910AD90E02438A8772211619BDD251', '17', '1D6170D4FF9E47E49268FD2A70CE3C53', 'Column Tree Name Object', 100, null, 'Наименование объекта', 'Наименование', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('5406', '7A5F95F042574D54915061C1090C9ADC', '1607', '390px', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('246', '7A5F95F042574D54915061C1090C9ADC', '167', 'true', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('1558', '7A5F95F042574D54915061C1090C9ADC', '854', 'cn_order', '10020785', '2018-05-10T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('571940545221', '5D7E99789C4C4AE38CF614A340343C62', '1029', 'window', '10028610', '2019-03-01T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('234', '16D8DF6E515F4274A69908D7FA34EB30', '155', '1', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('233', '16D8DF6E515F4274A69908D7FA34EB30', '140', null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('201885184721', '16D8DF6E515F4274A69908D7FA34EB30', '992', 'fa-plus', '20780', '2019-01-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('571918121021', '16D8DF6E515F4274A69908D7FA34EB30', '1033', 'window', '10028610', '2019-03-01T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2324', '95467F5511694BA6A9E982493356D3A1', '972', '1', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2325', '95467F5511694BA6A9E982493356D3A1', '970', 'ck_object', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('36', '32BC0ECB10F34E30AD727CBD97719E26', '52', 'cv_name_object', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('506', 'E5A0DC93F74E475BA2F3E21328846FCA', '433', 'disabled', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('52', 'E5A0DC93F74E475BA2F3E21328846FCA', '47', 'cv_name_class', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('6E8EE3A0A27F44539F7573C804BE962A', '00BADB0DA18D4B2994866FC2FF7C411F', '47', 'cv_displayed', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-10-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('507', '99F9D324EB484401A1F66491B2D64809', '433', 'disabled', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('53', '99F9D324EB484401A1F66491B2D64809', '47', 'cv_description', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('230', 'D2DE62CD05FE4246AD8B39638CF96B8C', '47', 'cn_order', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('8352', 'E843C8A56FF744F18C0ACD61B816CE98', '433', 'disabled', '10020780', '2018-03-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('6338', 'E843C8A56FF744F18C0ACD61B816CE98', '47', 'cv_master_path', '20788', '2018-11-04T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('525', '4E1B4314D2834E84BCEDC56A9EF5405F', '47', 'ck_master', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('6337', '4E1B4314D2834E84BCEDC56A9EF5405F', '434', 'false', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('237', 'A97413B7060046EF8D43C14B67B0F22D', '85', 'cn_order', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('235', 'A97413B7060046EF8D43C14B67B0F22D', '72', 'true', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('783', '1D6170D4FF9E47E49268FD2A70CE3C53', '267', 'ck_id', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('785', '1D6170D4FF9E47E49268FD2A70CE3C53', '261', 'ck_master', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('781', '1D6170D4FF9E47E49268FD2A70CE3C53', '361', 'cv_name_object', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('1108', '4002FD9CB8904DC98C41A1D7D86A1B82', '126', 'ck_id', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('1109', '4002FD9CB8904DC98C41A1D7D86A1B82', '120', 'ck_object', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('505', '4002FD9CB8904DC98C41A1D7D86A1B82', '40172', 'insert', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('1107', '4002FD9CB8904DC98C41A1D7D86A1B82', '125', 'cv_name', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('248', '80B07F19416149CA8FC56FEB8E9C6757', '126', 'ck_id', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('247', '80B07F19416149CA8FC56FEB8E9C6757', '125', 'cv_name', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('249', '80B07F19416149CA8FC56FEB8E9C6757', '120', 'ck_object', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('89E0AA6C16C26D37E053809BA8C0AE66', '80B07F19416149CA8FC56FEB8E9C6757', '123', 'true', '20780', '2019-05-29T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('330', '6FE3C6BCC2C341F690856E77DB1CE30F', '85', 'cn_order', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('331', '6FE3C6BCC2C341F690856E77DB1CE30F', '72', 'true', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('365', '281B061975594403AF492B839C2C1BB8', '361', 'cv_name_object', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('312', '281B061975594403AF492B839C2C1BB8', '267', 'ck_id', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('329', '281B061975594403AF492B839C2C1BB8', '261', 'ck_master', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('241', '2CF0B4177AC944EF9D0F41728063F8ED', '155', '1', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('242', '2CF0B4177AC944EF9D0F41728063F8ED', '140', 'onSimpleSaveWindow', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('240', 'CCFF180E309042B1BDE6D618737BEC05', '147', '2', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('239', 'CCFF180E309042B1BDE6D618737BEC05', '140', 'onCloseWindow', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('264', '67230B532F99404CBD12ACCFFE415947', '52', 'cv_name_object', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('784', '9C910AD90E02438A8772211619BDD251', '52', 'cv_name_object', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('0A03EF738B964B16B78F8E47C1A2A066', '35', null, 'SYS Tab Page << DO NOT CHANGE', 30, null, 'Таб-панель Страницы', null, null, null, '10020780', '2018-07-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object('A1707D6B3442425BAB77E04962EDC94D', '8', '0A03EF738B964B16B78F8E47C1A2A066', 'SYS Grid POA << DO NOT CHANGE', 10, 'MTPageObjectAttribute', 'Грид "Атрибуты объекта на странице"', 'Атрибуты объекта на странице', 'pkg_json_meta.f_modify_page_object_attr', 'meta', '10020780', '2018-07-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('6B214CDC907D43328F55C63F791B91C3', '8', '0A03EF738B964B16B78F8E47C1A2A066', 'SYS Grid Variable << DO NOT CHANGE', 20, 'MTPageVariable', 'Глобальные переменные на странице', 'Глобальные переменные на странице', 'pkg_json_meta.f_modify_page_variable', 'meta', '20788', '2018-12-08T00:00:00.000+0000');
select pkg_patcher.p_merge_object('84595AB4D5BD6B95E053809BA8C06D64', '32', 'A1707D6B3442425BAB77E04962EDC94D', 'Редактирование rules', 2, null, 'Редактирование rules', 'Редактирование поведенческих атрибутов', null, null, '1', '2019-08-29T00:00:00.000+0000');
select pkg_patcher.p_merge_object('F976D933C12248428804E879F51DC067', '19', '6B214CDC907D43328F55C63F791B91C3', 'Add Button', 10, null, 'Добавить', 'Добавить', null, null, '10020780', '2018-07-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('4B7F8B7BCCB549E3ACBF66B23A68227B', '16', '6B214CDC907D43328F55C63F791B91C3', 'Edit Button', 20, null, 'Редактирование', null, null, null, '10020780', '2018-07-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('348B927874AC465084BA622767F58E8E', '9', '6B214CDC907D43328F55C63F791B91C3', 'cv_name_global', 30, null, 'Наименование глобальной переменной', 'Наименование глобальной переменной', null, null, '10020780', '2018-07-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('D678025E869F496DAB0DC2F6E6EA04E1', '9', '6B214CDC907D43328F55C63F791B91C3', 'Set Object', 40, null, 'Объект, задающий глобальную переменную', 'Объект, задающий глобальную переменную', null, null, '10020780', '2018-07-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('6EAE71D55BD74B2AA767BCD0C5C7FBD3', '9', '6B214CDC907D43328F55C63F791B91C3', 'Get Object', 50, null, 'Объект, получающий глобальную переменную', 'Объект, получающий глобальную переменную', null, null, '10020780', '2018-07-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('A472952870C3428782C94EDB087C243D', '9', '6B214CDC907D43328F55C63F791B91C3', 'cv_description', 60, null, 'Описание', 'Описание', null, null, '10020780', '2018-07-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('50CA5A6528314911AF713C957850D441', '16', 'A1707D6B3442425BAB77E04962EDC94D', 'Button Edit', 100, null, 'Кнопка "Редактировать" в гриде', 'Редактировать', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('84BAC1BFD92A4E5EAF68057EBEC1234A', '9', 'A1707D6B3442425BAB77E04962EDC94D', 'Column Name', 300, null, 'Колонка "Наименование"', 'Наименование', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('3F19370F79234FF1AC7E8D37C88A1FED', '9', 'A1707D6B3442425BAB77E04962EDC94D', 'Column default value', 400, null, 'Колонка "Значение по умолчанию"', 'Значение по умолчанию', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('3CA37BF3A40E4B96A10C80D72390D88A', '9', 'A1707D6B3442425BAB77E04962EDC94D', 'Column value by Object', 500, null, 'Колонка "Значение, переопределенное на объекте"', 'Значение, переопределенное на объекте', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('C03108AB21C444F58C0F3C57E99B917E', '9', 'A1707D6B3442425BAB77E04962EDC94D', 'Column value POA', 550, null, 'Колонка "Значение, переопределенное на странице"', 'Значение, переопределенное на странице', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('4EE9F7610F094E73B54E8ECF42618A1C', '9', 'A1707D6B3442425BAB77E04962EDC94D', 'COPY of Object Attr Desc', 600, null, 'Описание атрибута', 'Описание', null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('846068E856FD60DAE053809BA8C0149C', '84599990888B6BCCE053809BA8C00CC8', '84595AB4D5BD6B95E053809BA8C06D64', 'Редактирование rules', 10, null, 'Редактирование rules', 'Редактирование rules', null, null, '20785', '2019-03-18T00:00:00.000+0000');
select pkg_patcher.p_merge_object('1D635F42855D49EBBFDB5C939D9CA38C', '31', 'C03108AB21C444F58C0F3C57E99B917E', 'POA Value Field', 100, 'MTGetValuesForPOA', 'Поле редактирование значения атрибута на странице', null, null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object('846068E856F960DAE053809BA8C0149C', '19', '84595AB4D5BD6B95E053809BA8C06D64', 'Сохранить', 500, null, 'Сохранить', 'Сохранить', null, null, '20785', '2019-03-18T00:00:00.000+0000');
select pkg_patcher.p_merge_object('84595AB4D5BE6B95E053809BA8C06D64', '19', '84595AB4D5BD6B95E053809BA8C06D64', 'Отмена', 501, null, 'Отмена', 'Отмена', null, null, '20785', '2019-03-18T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('3820', 'A1707D6B3442425BAB77E04962EDC94D', '852', 'ck_attr', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('8323', 'A1707D6B3442425BAB77E04962EDC94D', '1600', '500', '10020788', '2018-03-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('93135', 'A1707D6B3442425BAB77E04962EDC94D', '28169', 'true', '10020785', '2018-10-17T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('97183', '6B214CDC907D43328F55C63F791B91C3', '1600', '350', '20780', '2018-10-26T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('29082', '6B214CDC907D43328F55C63F791B91C3', '852', 'cv_name', '20780', '2018-10-26T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('97182', '6B214CDC907D43328F55C63F791B91C3', '853', 'ASC', '20780', '2018-10-26T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('846060F16DF160F2E053809BA8C0CA26', '84595AB4D5BD6B95E053809BA8C06D64', '1029', 'rules', '20785', '2019-03-18T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('29074', 'F976D933C12248428804E879F51DC067', '155', '1', '10020780', '2018-07-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('202501850221', 'F976D933C12248428804E879F51DC067', '992', 'fa-plus', '20780', '2019-01-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('31072', '348B927874AC465084BA622767F58E8E', '47', 'cv_name', '10020788', '2018-07-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('41072', 'D678025E869F496DAB0DC2F6E6EA04E1', '47', 'cv_path_set', '10020788', '2018-07-30T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('41074', 'D678025E869F496DAB0DC2F6E6EA04E1', '433', 'disabled', '10020788', '2018-07-30T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('41073', '6EAE71D55BD74B2AA767BCD0C5C7FBD3', '47', 'cv_path_get', '10020788', '2018-07-30T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('41075', '6EAE71D55BD74B2AA767BCD0C5C7FBD3', '433', 'disabled', '10020788', '2018-07-30T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('29075', 'A472952870C3428782C94EDB087C243D', '47', 'cv_description', '10020788', '2018-07-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('3807', '84BAC1BFD92A4E5EAF68057EBEC1234A', '47', 'ck_attr', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('3814', '84BAC1BFD92A4E5EAF68057EBEC1234A', '433', 'disabled', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('3808', '3F19370F79234FF1AC7E8D37C88A1FED', '47', 'cv_value_ca', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('3815', '3F19370F79234FF1AC7E8D37C88A1FED', '433', 'disabled', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('3837', '3CA37BF3A40E4B96A10C80D72390D88A', '433', 'disabled', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('3809', '3CA37BF3A40E4B96A10C80D72390D88A', '47', 'cv_value_oa', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('3826', 'C03108AB21C444F58C0F3C57E99B917E', '47', 'cv_value', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('3816', '4EE9F7610F094E73B54E8ECF42618A1C', '47', 'cv_description', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('3817', '4EE9F7610F094E73B54E8ECF42618A1C', '433', 'disabled', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('846060F16DF660F2E053809BA8C0CA26', '846068E856FD60DAE053809BA8C0149C', '846068E856FC60DAE053809BA8C0149C', 'cv_value', '20785', '2019-03-18T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('84599990888E6BCCE053809BA8C00CC8', '846068E856FD60DAE053809BA8C0149C', '846060F16DF460F2E053809BA8C0CA26', 'true', '20785', '2019-03-18T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('84599990888F6BCCE053809BA8C00CC8', '846068E856FD60DAE053809BA8C0149C', '84599990888D6BCCE053809BA8C00CC8', 'true', '20785', '2019-03-18T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('3828', '1D635F42855D49EBBFDB5C939D9CA38C', '863', 'cv_entered', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('3829', '1D635F42855D49EBBFDB5C939D9CA38C', '861', 'ck_attr', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('3830', '1D635F42855D49EBBFDB5C939D9CA38C', '752', 'true', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('3831', '1D635F42855D49EBBFDB5C939D9CA38C', '570', 'false', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('3827', '1D635F42855D49EBBFDB5C939D9CA38C', '127', 'remote', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('3833', '1D635F42855D49EBBFDB5C939D9CA38C', '126', 'cv_value', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('3834', '1D635F42855D49EBBFDB5C939D9CA38C', '125', 'cv_value', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('4852', '1D635F42855D49EBBFDB5C939D9CA38C', '121', '400', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('3835', '1D635F42855D49EBBFDB5C939D9CA38C', '120', 'cv_value', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('846060F16DF260F2E053809BA8C0CA26', '846068E856F960DAE053809BA8C0149C', '140', 'onSimpleSaveWindow', '20785', '2019-03-18T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('84595AB4D5BF6B95E053809BA8C06D64', '84595AB4D5BE6B95E053809BA8C06D64', '1997', 'Отменить?', '20785', '2019-03-18T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('846068E856FA60DAE053809BA8C0149C', '84595AB4D5BE6B95E053809BA8C06D64', '147', '2', '20785', '2019-03-18T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('846060F16DF360F2E053809BA8C0CA26', '84595AB4D5BE6B95E053809BA8C06D64', '140', 'onCloseWindow', '20785', '2019-03-18T00:00:00.000+0000');
select pkg_patcher.p_merge_object('999DA56D0ECF45A8BC98F2265A703988', '57', null, 'Menu Redirect Column Icon << Reusable', 101, null, 'Menu Redirect Column Icon << Reusable', null, null, null, '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('6385', '999DA56D0ECF45A8BC98F2265A703988', '560', 'showMenu', '-11', '2018-02-23T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('64226', '999DA56D0ECF45A8BC98F2265A703988', '353', 'fa-link', '10020785', '2018-09-05T00:00:00.000+0000');
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('3CCC179BD404490CB52CEEF665EFA694', '2', 'E56A94F186CA495BAEF39DF68B68681A', 1, null, null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('960FA1EFF74C45E38ECE1A50226C2E34', '2', '7A5F95F042574D54915061C1090C9ADC', 2, null, null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('62F55BD5AC404E9A87496F8B84DD3400', '2', '0A03EF738B964B16B78F8E47C1A2A066', 30, null, null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('8B8F934684C24A06BF7D42BEE303073F', '2', 'A1707D6B3442425BAB77E04962EDC94D', 10, '62F55BD5AC404E9A87496F8B84DD3400', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('220DEFA468F84CC1849F0D3F71852E3B', '2', '6B214CDC907D43328F55C63F791B91C3', 20, '62F55BD5AC404E9A87496F8B84DD3400', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('40161C651A2D426299BEEE128A9F8E82', '2', '5D7E99789C4C4AE38CF614A340343C62', 100, '960FA1EFF74C45E38ECE1A50226C2E34', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('79012D4B86374D8799A38BC4C0204F31', '2', '3DF8D382476C409FAFE16C90AF5E8339', 100, '3CCC179BD404490CB52CEEF665EFA694', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('73271B1CCCB8473BA987511F570E4D71', '2', '16D8DF6E515F4274A69908D7FA34EB30', 120, '960FA1EFF74C45E38ECE1A50226C2E34', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('3C6EAC942CA647DCBF569D63D27AE8F1', '2', '41FC947229F54E8EB1A5A302A69EC23F', 150, '960FA1EFF74C45E38ECE1A50226C2E34', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('DD3E4E871E3346FF85C1E7AC573D2B7A', '2', 'E0799FB264604C54973DF0B6A49BD63E', 150, '3CCC179BD404490CB52CEEF665EFA694', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7ED0CCEF314145D792550CF27E11EC96', '2', '999DA56D0ECF45A8BC98F2265A703988', 200, '960FA1EFF74C45E38ECE1A50226C2E34', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('2B0D4A2F5BF64CB8AE6755D2A0B8DC27', '2', 'D94343DAF0AC4B85A29C0DA667BEE539', 200, '3CCC179BD404490CB52CEEF665EFA694', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('8E494509B68E48C88230E5AA2A4F8D03', '2', '3DD16DB9F9D64C6CA05252512E9BCDD3', 300, '3CCC179BD404490CB52CEEF665EFA694', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('CFA806029637437C8F5A8F838FAFDF03', '2', '95467F5511694BA6A9E982493356D3A1', 300, '960FA1EFF74C45E38ECE1A50226C2E34', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('CEF5759CA14E49D5A55C9E0B74E2B1F2', '2', '32BC0ECB10F34E30AD727CBD97719E26', 350, '960FA1EFF74C45E38ECE1A50226C2E34', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('24D7B07A120D459891F97C5A080FE448', '2', '9637E6808A1B4196A2D6FD33BD85F326', 400, '3CCC179BD404490CB52CEEF665EFA694', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('413D85962F4044228970B2A3C2F3BA96', '2', 'E5A0DC93F74E475BA2F3E21328846FCA', 400, '960FA1EFF74C45E38ECE1A50226C2E34', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('C92F8C2CCF834A7F9AA14482E57F07B5', '2', '00BADB0DA18D4B2994866FC2FF7C411F', 450, '960FA1EFF74C45E38ECE1A50226C2E34', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('C6E781C2E35E472B834AB9DC4A5C9E42', '2', '99F9D324EB484401A1F66491B2D64809', 500, '960FA1EFF74C45E38ECE1A50226C2E34', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('CB5019618C0E4F2EA70F6B328BA61B6C', '2', '801B8290FF5F4C5399D150197D34833E', 500, '3CCC179BD404490CB52CEEF665EFA694', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('EA59FFA995624F9D80B8596E0C3ED5B7', '2', 'E109C4675B564AD7AE5D4B1091E6C5CF', 550, '3CCC179BD404490CB52CEEF665EFA694', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('15E2AEE5D61C47E9B7937BE3917E5EB8', '2', 'D2DE62CD05FE4246AD8B39638CF96B8C', 600, '960FA1EFF74C45E38ECE1A50226C2E34', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('D83DDF79CFD5455A856DE13673AC7617', '2', 'CBB07C568B094B1F82ED07BE368528F4', 600, '3CCC179BD404490CB52CEEF665EFA694', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('F0199AF6809C4F9491E8CF7D458525F3', '2', 'E843C8A56FF744F18C0ACD61B816CE98', 700, '960FA1EFF74C45E38ECE1A50226C2E34', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('E237E6BBA37241E69463F78BB7009084', '2', 'B84591FA11C44C2581144504E7E2DFC7', 700, '3CCC179BD404490CB52CEEF665EFA694', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('33428E45348945A0A0407C45F409D2DB', '2', '5718878CB06C4E6DB5F6ABF555A33F4D', 800, '3CCC179BD404490CB52CEEF665EFA694', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('698DA507F5234E20BCB5FF198897EB07', '2', 'A2E08196F3CF4E8494FEA91DA200D361', 1000, '3CCC179BD404490CB52CEEF665EFA694', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('30AFE8654CF046FDA64BD48C06FAC767', '2', '4E1B4314D2834E84BCEDC56A9EF5405F', 10000, '960FA1EFF74C45E38ECE1A50226C2E34', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('C1374F361B8E4895B695BC19A62C075A', '2', '84595AB4D5BD6B95E053809BA8C06D64', 2, '8B8F934684C24A06BF7D42BEE303073F', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('FF811FDEDC03455FAF83FC8E63E47E7E', '2', 'F976D933C12248428804E879F51DC067', 10, '220DEFA468F84CC1849F0D3F71852E3B', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('2B05A2D3B0BD416D85D51AEEEA4DFA8A', '2', '4B7F8B7BCCB549E3ACBF66B23A68227B', 20, '220DEFA468F84CC1849F0D3F71852E3B', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('ED8A7E26F5BD40C8867C0293A62B9B1C', '2', '348B927874AC465084BA622767F58E8E', 30, '220DEFA468F84CC1849F0D3F71852E3B', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('02F302F8BA924E78B2C2AE60D334468C', '2', 'D678025E869F496DAB0DC2F6E6EA04E1', 40, '220DEFA468F84CC1849F0D3F71852E3B', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('0C2352EF60D949EBB086410666491932', '2', '6EAE71D55BD74B2AA767BCD0C5C7FBD3', 50, '220DEFA468F84CC1849F0D3F71852E3B', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('CF113E6C1B464A20B9594E0384725F9A', '2', 'A472952870C3428782C94EDB087C243D', 60, '220DEFA468F84CC1849F0D3F71852E3B', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('E0E875816F10483ABCAA7AD749DA1CC3', '2', '50CA5A6528314911AF713C957850D441', 100, '8B8F934684C24A06BF7D42BEE303073F', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('4C2D01E44A674D149676F4CD382B79FA', '2', 'A97413B7060046EF8D43C14B67B0F22D', 100, '15E2AEE5D61C47E9B7937BE3917E5EB8', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('73B1B40F78EC40488B7C9BE501D63A37', '2', '1D6170D4FF9E47E49268FD2A70CE3C53', 100, '30AFE8654CF046FDA64BD48C06FAC767', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('C22045F968D948C2BBBA7C5357F6DDCB', '2', '1D150D1369E24783B7041818833097AB', 100, '698DA507F5234E20BCB5FF198897EB07', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('D9063F10B51C41AFA8486AC8068C6A4D', '2', '4002FD9CB8904DC98C41A1D7D86A1B82', 100, 'CEF5759CA14E49D5A55C9E0B74E2B1F2', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('263C286E2FAB4266A90E45A059ED1F32', '2', '80B07F19416149CA8FC56FEB8E9C6757', 100, '40161C651A2D426299BEEE128A9F8E82', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('8D4E42EF614C40A9B9E65F293F246E50', '2', '6FE3C6BCC2C341F690856E77DB1CE30F', 200, '40161C651A2D426299BEEE128A9F8E82', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('27229BA375D14DADBA45FD17914DC590', '2', '84BAC1BFD92A4E5EAF68057EBEC1234A', 300, '8B8F934684C24A06BF7D42BEE303073F', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('4A7A6A4D983D478FBBB55B7C21238FCD', '2', '281B061975594403AF492B839C2C1BB8', 300, '40161C651A2D426299BEEE128A9F8E82', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('6427F6756C98487F9FE6F92E0EFE13EF', '2', '3F19370F79234FF1AC7E8D37C88A1FED', 400, '8B8F934684C24A06BF7D42BEE303073F', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('855C5CA0B2574AD492C824054F97D1A9', '2', '2246D7F3D7544A13A4B4E37DC232070D', 400, '698DA507F5234E20BCB5FF198897EB07', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('DAB02EA5976B433AB40AB3057E98A3F6', '2', '3CA37BF3A40E4B96A10C80D72390D88A', 500, '8B8F934684C24A06BF7D42BEE303073F', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('226769D380154E7F977ECDFAC6B52739', '2', 'C03108AB21C444F58C0F3C57E99B917E', 550, '8B8F934684C24A06BF7D42BEE303073F', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('2F37F58F711F4CFBA3C7518CF18BBBA3', '2', '4EE9F7610F094E73B54E8ECF42618A1C', 600, '8B8F934684C24A06BF7D42BEE303073F', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('D4BBB6F3A5594611A57BBF38A3CE1FB7', '2', '68E2ADA0B2CC4BD893CEB06D7D8D17D2', 600, '698DA507F5234E20BCB5FF198897EB07', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('63401A62A3754048B50CE696452818F0', '2', '27A16490A6234559BC556A47FA6E3C14', 700, '698DA507F5234E20BCB5FF198897EB07', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('6E27F4F15AED4E79B0C75F5E13B0E104', '2', '07810FE0DE1A49E0813EF0866D06D584', 710, '698DA507F5234E20BCB5FF198897EB07', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7D737EB0C6F746C1A573EF8A9E584449', '2', 'AF666D67CE794E3EA8237B971C5ACB65', 720, '698DA507F5234E20BCB5FF198897EB07', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('86920F975E1B4E1B93FC667610A5717C', '2', '813AE10488CC4365E053809BA8C03542', 730, '698DA507F5234E20BCB5FF198897EB07', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('5BB1585DA1E94776803CE5E9687096AD', '2', '1B89D8746D4F4AB9A505A8C3738138E0', 750, '698DA507F5234E20BCB5FF198897EB07', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('70B17467544C43E380EF3E7CB0379A67', '2', 'ED7E10DA3BBB45558F850F1E43BA967D', 800, '698DA507F5234E20BCB5FF198897EB07', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('37D8142C4F0D469C9DCA14E09D7F7907', '2', '2CF0B4177AC944EF9D0F41728063F8ED', 1200, '40161C651A2D426299BEEE128A9F8E82', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('047D8522DC824B0C99CF71AD35D8F5E8', '2', 'CCFF180E309042B1BDE6D618737BEC05', 1300, '40161C651A2D426299BEEE128A9F8E82', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('88A5BF61081540B3ABE977885312B8DA', '2', '58DFD9E372DC4BBC891F8723E554E185', 2000, '698DA507F5234E20BCB5FF198897EB07', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('B0C30DE4F98346D2B9F3F89EA438177E', '2', 'DA7805DF671B46658EE88E36E280D3A2', 3000, '698DA507F5234E20BCB5FF198897EB07', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('B27AA768EA0749DD9386F46B94D87312', '2', '846068E856FD60DAE053809BA8C0149C', 10, 'C1374F361B8E4895B695BC19A62C075A', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('282698A094DC4CDDB7A0F5C8B075214B', '2', '0634B02B58AB42A4867C36C9CDA4808E', 100, '63401A62A3754048B50CE696452818F0', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('C7445040365A41EE83D745A28CE5D33D', '2', '67230B532F99404CBD12ACCFFE415947', 100, '4A7A6A4D983D478FBBB55B7C21238FCD', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('6CDBDDEF7FBF4C1C844D842D565BC4BB', '2', '9C910AD90E02438A8772211619BDD251', 100, '73B1B40F78EC40488B7C9BE501D63A37', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('BB0558FA32274064B787A25A6CFE6B6A', '2', '1D635F42855D49EBBFDB5C939D9CA38C', 100, '226769D380154E7F977ECDFAC6B52739', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('69B77D8BD1544954916263227ACC69D3', '2', 'B4DF5B3F933744819E24CABB022C5944', 200, '63401A62A3754048B50CE696452818F0', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('5CB8B949A12D4DCD9E21E1C967448BEB', '2', '846068E856F960DAE053809BA8C0149C', 500, 'C1374F361B8E4895B695BC19A62C075A', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('CF5F6D98EB6D4E238D62F34FAE5445C2', '2', '84595AB4D5BE6B95E053809BA8C06D64', 501, 'C1374F361B8E4895B695BC19A62C075A', null, '20848', '2018-12-17T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('984930EA8B2E4A9690E8897DEC04F4BE', '960FA1EFF74C45E38ECE1A50226C2E34', '1327', null, '20848', '2018-12-17T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('2333E115E60E4C0D8E08CD9D78C7E3CE', '3CCC179BD404490CB52CEEF665EFA694', '1607', '320', '20848', '2018-12-17T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('69C1C56564F6474999594FFB45C0BDEF', '960FA1EFF74C45E38ECE1A50226C2E34', '1607', '425', '20848', '2018-12-17T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('B707061161DB40C9A479A60F4D8707CC', '3CCC179BD404490CB52CEEF665EFA694', '1211', 'cr_type=gr_type_page', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-09-10T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('E7585442E93F47B3AEF74DB6A4CABBBB', 'CFA806029637437C8F5A8F838FAFDF03', '970', 'ck_object=gck_object', '20848', '2018-12-17T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('CD13E1914C9648FFB33FC66997FDE391', '73271B1CCCB8473BA987511F570E4D71', '1244', 'gr_type_page!=2', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-09-10T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('8C15D9AA05394A29BAFDB4095F9BBDBA', '5BB1585DA1E94776803CE5E9687096AD', '1193', 'gcl_static', '20848', '2018-12-17T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('6E6BDA9501E943CF9E7E178D0D4AACD9', '855C5CA0B2574AD492C824054F97D1A9', '1195', 'gcr_type', '20848', '2018-12-17T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('01BDEF99A7C64538AD8702234A292011', '70B17467544C43E380EF3E7CB0379A67', '1250', 'gcl_static==0', '20848', '2018-12-17T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('8BAC993510D1400AAE0A949944763398', 'C1374F361B8E4895B695BC19A62C075A', '1029', 'ruleswindow', '20785', '2019-07-19T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('9484EBE2BE5347CC8568D3784ADECC87', '7D737EB0C6F746C1A573EF8A9E584449', '1251', 'gcr_type!=2', '20785', '2019-07-26T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('CD08479AC46D4CF7847B825C26F48894', '6E27F4F15AED4E79B0C75F5E13B0E104', '1251', 'gcr_type!=2', '20785', '2019-07-26T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('E642B7EA087C4C76A5A5B4FEAB8CE91D', 'E0E875816F10483ABCAA7AD749DA1CC3', '1493', '{"hiddenrules": "ruleswindow", "disabledrules": "ruleswindow", "requiredrules": "ruleswindow", "readonlyrules": "ruleswindow", "reqcountrules": "ruleswindow"}[ckAttr]', '1', '2019-09-02T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
update s_mt.t_page_object set ck_master='3CCC179BD404490CB52CEEF665EFA694' where ck_id='220DEFA468F84CC1849F0D3F71852E3B';
update s_mt.t_page_object set ck_master='960FA1EFF74C45E38ECE1A50226C2E34' where ck_id='37D8142C4F0D469C9DCA14E09D7F7907';
update s_mt.t_page_object set ck_master='3CCC179BD404490CB52CEEF665EFA694' where ck_id='4A7A6A4D983D478FBBB55B7C21238FCD';
update s_mt.t_page_object set ck_master='960FA1EFF74C45E38ECE1A50226C2E34' where ck_id='73271B1CCCB8473BA987511F570E4D71';
update s_mt.t_page_object set ck_master='3CCC179BD404490CB52CEEF665EFA694' where ck_id='73B1B40F78EC40488B7C9BE501D63A37';
update s_mt.t_page_object set ck_master='3CCC179BD404490CB52CEEF665EFA694' where ck_id='79012D4B86374D8799A38BC4C0204F31';
update s_mt.t_page_object set ck_master='3CCC179BD404490CB52CEEF665EFA694' where ck_id='88A5BF61081540B3ABE977885312B8DA';
update s_mt.t_page_object set ck_master='960FA1EFF74C45E38ECE1A50226C2E34' where ck_id='8B8F934684C24A06BF7D42BEE303073F';
update s_mt.t_page_object set ck_master='3CCC179BD404490CB52CEEF665EFA694' where ck_id='960FA1EFF74C45E38ECE1A50226C2E34';
update s_mt.t_page_object set ck_master='8B8F934684C24A06BF7D42BEE303073F' where ck_id='BB0558FA32274064B787A25A6CFE6B6A';
update s_mt.t_page_object set ck_master='960FA1EFF74C45E38ECE1A50226C2E34' where ck_id='D9063F10B51C41AFA8486AC8068C6A4D';
