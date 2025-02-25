--liquibase formatted sql
--changeset patcher-core:Page_EDF1720E35FE4539AB933E87727185DC dbms:postgresql runOnChange:true splitStatements:false stripComments:false
select pkg_patcher.p_remove_page('EDF1720E35FE4539AB933E87727185DC');

INSERT INTO s_mt.t_page (ck_id, ck_parent, cr_type, cv_name, cn_order, cl_static, cv_url, ck_icon, ck_view, ck_user, ct_change, cl_menu)VALUES('EDF1720E35FE4539AB933E87727185DC', '067675EDBBCD49058E68401A427131B2', 2, 'f97dd86f406a460497f50376cdaff9b2', 20, 0, null, null, 'system', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-05-05T14:59:14.900+0000', 1) on conflict (ck_id) do update set ck_parent = excluded.ck_parent, ck_view=excluded.ck_view, cr_type = excluded.cr_type, cv_name = excluded.cv_name, cn_order = excluded.cn_order, cl_static = excluded.cl_static, cv_url = excluded.cv_url, ck_icon = excluded.ck_icon, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_menu = excluded.cl_menu;
select pkg_patcher.p_merge_page_action('C34F713C47D14086B65C7DF3B05288B4', 'EDF1720E35FE4539AB933E87727185DC', 'edit', 99999, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-05-05T14:59:14.900+0000');
select pkg_patcher.p_merge_page_action('376356C870F341AEBFD583C09043686C', 'EDF1720E35FE4539AB933E87727185DC', 'view', 99999, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-05-05T14:59:14.900+0000');
select pkg_patcher.p_merge_object('FC2F9A8B93CE4B21B5DDFDF8BBAB16BD', '1', null, 'SYS Documentation Static Box', 20, null, 'SYS Documentation Static Box', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-15T13:32:05.427+0000');
select pkg_patcher.p_merge_object('00992032FD31411CA17F2961B5F5BBE7', '5F229304828F4AADBF9B0BE6463B1248', 'FC2F9A8B93CE4B21B5DDFDF8BBAB16BD', 'Documentation Text', 10, null, 'Documentation Text', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-15T13:33:21.083+0000');
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('0E8F34546C394DFF9AEEDEEA01F662B6', 'EDF1720E35FE4539AB933E87727185DC', 'FC2F9A8B93CE4B21B5DDFDF8BBAB16BD', 10, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-05-05T14:59:49.196+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('C48A79AAD5774B2B9837EF321F49ACD0', 'EDF1720E35FE4539AB933E87727185DC', '00992032FD31411CA17F2961B5F5BBE7', 10, '0E8F34546C394DFF9AEEDEEA01F662B6', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-05-05T14:59:49.196+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
select pkg_patcher.p_merge_page_object_attr('485855234BC242978B75E89DDA98FB6D', 'C48A79AAD5774B2B9837EF321F49ACD0', '77CCD76E7CD444FFAF54D6000CEF4E05', '# Документация для "Patcher"

Приложение  применяется для создания файлов миграций из существующей инфраструктуры.

Команду на выполнения нужно выполнять из папки модуля, например: **dbms**.

Пакет состоит из модулей:

- class
- object
- page - создает миграцию содержимого страницы
- query
- syssetting
- messages
- modules
- lang
- auth

### Общие параметры

- **-p, --property <file>** - указывает файл коннекта к базе данных. Наименование файла должно быть в виде ***.properties**
- **-o,--object_ids <ids>** - указывает на идентификатор родительного объекта

## Описание "class"

## Описание "object"

## Описание "page"

Создание миграции для страницы.

Пример:

```sh
../patcher/patcher -c page -p liquibase.properties -o EDF1720E35FE4539AB933E87727185DC
```

где:

- **-o** - указывает на идентификатор выгружаемой странице


## Описание "query"

## Описание "syssetting"

## Описание "messages"

## Описание "modules"

## Описание "lang"

## Описание "auth"', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-05-05T15:29:57.953+0000', 'text');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)
select t.ck_id, t.ck_d_lang, t.cr_namespace, t.cv_value, t.ck_user, t.ct_change::timestamp from (
    select 'f97dd86f406a460497f50376cdaff9b2' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Patcher - создание миграций' as cv_value, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-05-05T14:59:14.900+0000' as ct_change
) as t 
 join s_mt.t_d_lang dl
 on t.ck_d_lang = dl.ck_id
on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
