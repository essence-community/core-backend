--liquibase formatted sql
--changeset patcher-core:Page_6DEAA83AAB72473CA2271A7CEC29C19D dbms:postgresql runOnChange:true splitStatements:false stripComments:false
select pkg_patcher.p_remove_page('6DEAA83AAB72473CA2271A7CEC29C19D');

INSERT INTO s_mt.t_page (ck_id, ck_parent, cr_type, cv_name, cn_order, cl_static, cv_url, ck_icon, ck_user, ct_change, cl_menu)VALUES('6DEAA83AAB72473CA2271A7CEC29C19D', 'C0EF204A8D77489FB097AC43A481818D', 2, '4a125d08ddd14845baf3a6983b28a555', 20, 0, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-17T06:14:46.710+0000', 1) on conflict (ck_id) do update set ck_parent = excluded.ck_parent, cr_type = excluded.cr_type, cv_name = excluded.cv_name, cn_order = excluded.cn_order, cl_static = excluded.cl_static, cv_url = excluded.cv_url, ck_icon = excluded.ck_icon, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_menu = excluded.cl_menu;
INSERT INTO s_mt.t_page_action (ck_id, ck_page, cr_type, cn_action, ck_user, ct_change)VALUES('862091079D45471A9BF70E8B1D1C7E50', '6DEAA83AAB72473CA2271A7CEC29C19D', 'edit', 99999, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-17T06:14:46.710+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cr_type = excluded.cr_type, cn_action = excluded.cn_action, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_action (ck_id, ck_page, cr_type, cn_action, ck_user, ct_change)VALUES('1E98F00BF3474DDE9D7FD6C69A8DC48C', '6DEAA83AAB72473CA2271A7CEC29C19D', 'view', 99999, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-17T06:14:46.710+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cr_type = excluded.cr_type, cn_action = excluded.cn_action, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
select pkg_patcher.p_merge_object('FC2F9A8B93CE4B21B5DDFDF8BBAB16BD', '1', null, 'SYS Documentation Static Box', 20, null, 'SYS Documentation Static Box', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-15T13:32:05.427+0000');
select pkg_patcher.p_merge_object('00992032FD31411CA17F2961B5F5BBE7', '5F229304828F4AADBF9B0BE6463B1248', 'FC2F9A8B93CE4B21B5DDFDF8BBAB16BD', 'Documentation Text', 10, null, 'Documentation Text', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-15T13:33:21.083+0000');
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('A7BC2F1A358A4A2398A09042A443B1F8', '6DEAA83AAB72473CA2271A7CEC29C19D', 'FC2F9A8B93CE4B21B5DDFDF8BBAB16BD', 10, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-17T06:15:17.686+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('2894A2AE1E6645DC8E38E82F46033571', '6DEAA83AAB72473CA2271A7CEC29C19D', '00992032FD31411CA17F2961B5F5BBE7', 10, 'A7BC2F1A358A4A2398A09042A443B1F8', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-17T06:15:17.686+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
select pkg_patcher.p_merge_page_object_attr('E623E9FA6B0B4CFD8F5096FF6171F6D4', '2894A2AE1E6645DC8E38E82F46033571', '77CCD76E7CD444FFAF54D6000CEF4E05', '# Принцип ведение документации

Примеры показаны на классе `App Bar Panel`

## Статическая документация

Для создание необходимо создать страницу в разделе `CORE/Конструктор документации`.

Можно создавать свои разделы. Для общих документаций нужно использовать раздел `Базовая документация`

После добавления страница документации появится в приложении документации

### Пример создания статической страницы

1. Создаем страницу в разделе  `CORE/Конструктор документации/Базовая документация`.
1. указываем права доступа `99999` для просмотра и редактирования т.к. документация общедоступная (можно ограничить доступность по надобности)
1. Добавляем объект `SYS Documentation Static Box` в страницу
1. В объектах выбираем `SYS Documentation Static Box/Documentation Text`
1. В атрибутах переходим в редактирование тарибута `text`. В момент открытия на редактирование откроется модальное окно с возможностью ввода markdown текст.
1. Сохраняем и проверяем созданную страницу в разделах документации

## Документация в классах

В разделе управления [классами](redirect/pages/3) добавлена вкладка документации (пример App Bar Panel)

После заполнения данная документация будет отображена в разделе пользовательской документации класса

## Автодокументация

Создается на основе коде, для активации необходимо в папке с классом создать файл `config.json`, пример:

```
{
    "name": "App Bar Panel",
    "docs": [
        ["container", "AppBar.tsx"],
        ["container", "AppBar.styles.ts"]
    ]
}

```

где:

1. name - название класса (необходимо брать такое же, как и в classes), в дальнейшем будет добавлено  `ck_id` класса для более строгой идентификации
1. docs - массив с массива строк пути - служит для поиска файлов из которых необходимо собрать автодокументацию

### Описание документации

Ведние документации происходит в исходном коде по принципу [jsdoc](https://jsdoc.app/). Пример можно посмотреть в файле [packages/@essence/essence-constructor-classes/src/AppBar/container/AppBar.tsx](https://github.com/essence-community/core-frontend/blob/dev/packages/%40essence/essence-constructor-classes/src/AppBar/container/AppBar.tsx)

### Генерация документации

Генерация документации происходит посредством запуска nodejs скрипта во frontend репозитории, для этого необходимо

1. `cd packages/\@essence/essence-constructor-classes/` перейти в классы
1. `node GATE_URL=http://localhost:3000/api node scripts/generateAutoDoc.js` запуска создания автодокументации. GATE_URL указывает куда апи по которому будет синхронизироваться база
1. в `backend/dbms` запускаем патчинг классов `../patcher/patcher -c class`
1. делаем коммит для распространения документации

## Создание примеров к классу

Для создания примеров необходимо на [страницах](redirect/pages/2) создать страницу для отображения класса.

### Порядок создания

1. Заходим в `CORE/Конструктор документации/Демо классов` и создаем страницу с таким же наименованием как сам класс. **Обязательно** указываем статическую страницу и копирует url страницы как в классе документации, пример `core-classes-app-bar-panel`
1. Создаем объект с наименованием `DEMO {имя класса}`. Порядок можно проставит 50
1. Создаем структуру для теста (можно рисовать вложенные структуры с несколькими примерами и группами)
1. Добавляем объект в созданную страницу', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-17T07:13:51.619+0000', 'text');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)
select t.ck_id, t.ck_d_lang, t.cr_namespace, t.cv_value, t.ck_user, t.ct_change::timestamp from (
    select '4a125d08ddd14845baf3a6983b28a555' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Ведение документации' as cv_value, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-06-17T06:14:46.710+0000' as ct_change
) as t 
 join s_mt.t_d_lang dl
 on t.ck_d_lang = dl.ck_id
on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
