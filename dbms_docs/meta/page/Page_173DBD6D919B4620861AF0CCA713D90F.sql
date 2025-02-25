--liquibase formatted sql
--changeset patcher-core:Page_173DBD6D919B4620861AF0CCA713D90F dbms:postgresql runOnChange:true splitStatements:false stripComments:false
select pkg_patcher.p_remove_page('173DBD6D919B4620861AF0CCA713D90F');

INSERT INTO s_mt.t_page (ck_id, ck_parent, cr_type, cv_name, cn_order, cl_static, cv_url, ck_icon, ck_view, ck_user, ct_change, cl_menu)VALUES('173DBD6D919B4620861AF0CCA713D90F', 'C0EF204A8D77489FB097AC43A481818D', 2, 'ec24a8713fe34f84b8a796afc7c41199', 30, 1, 'modules', null, 'system', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-04-30T19:36:21.236+0000', 1) on conflict (ck_id) do update set ck_parent = excluded.ck_parent, ck_view=excluded.ck_view, cr_type = excluded.cr_type, cv_name = excluded.cv_name, cn_order = excluded.cn_order, cl_static = excluded.cl_static, cv_url = excluded.cv_url, ck_icon = excluded.ck_icon, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_menu = excluded.cl_menu;
select pkg_patcher.p_merge_page_action('D00027AE2AE74F4FAF325945C12CF879', '173DBD6D919B4620861AF0CCA713D90F', 'edit', 99999, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-04-30T19:36:21.236+0000');
select pkg_patcher.p_merge_page_action('8E044DA3DA2049528F46294AD040EE93', '173DBD6D919B4620861AF0CCA713D90F', 'view', 99999, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-04-30T19:36:21.236+0000');
select pkg_patcher.p_merge_object('FC2F9A8B93CE4B21B5DDFDF8BBAB16BD', '1', null, 'SYS Documentation Static Box', 20, null, 'SYS Documentation Static Box', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-15T13:32:05.427+0000');
select pkg_patcher.p_merge_object('00992032FD31411CA17F2961B5F5BBE7', '5F229304828F4AADBF9B0BE6463B1248', 'FC2F9A8B93CE4B21B5DDFDF8BBAB16BD', 'Documentation Text', 10, null, 'Documentation Text', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-15T13:33:21.083+0000');
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('64C94A3B8EB44E70998869DD8B5DE9DF', '173DBD6D919B4620861AF0CCA713D90F', 'FC2F9A8B93CE4B21B5DDFDF8BBAB16BD', 10, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-04-30T19:36:45.629+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('027C0D5EC4FD4F5E9317772A275312E7', '173DBD6D919B4620861AF0CCA713D90F', '00992032FD31411CA17F2961B5F5BBE7', 10, '64C94A3B8EB44E70998869DD8B5DE9DF', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-04-30T19:36:45.629+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
select pkg_patcher.p_merge_page_object_attr('824EFECBFE6E491DA2F5FD8F44AD5A97', '027C0D5EC4FD4F5E9317772A275312E7', '77CCD76E7CD444FFAF54D6000CEF4E05', '# Система модулей

## Зачем нужны модули

Модульная система предназначена для расширения существующего набора компонентов посредством добавления новых пакетов (модулей) через систему администрирования либо изменения существующих классов.

## Как добавить свой модуль

Для добавления модуля необходимо:

1. Реализовать модуль как отдельный пакет;
1. Использовать `setComponent` для установки компонента как модуля;
1. Создаем модуль командой `yarn create @essence-community/constructor-module card-new`, где `card-new` название модуля.;
1. Если нужно разработывать моуль на моках см. раздел "Разработка модуля на моках";
1. В созданном модуле в файле `index.ts` первым параметром в `setComponent` указываем тип нового модуля.

## Загрузка модуля (zip)

Для разворачивание модуля на стенде, необходимо:

1. собрать с помощью команды `yarn build`
1. создать архив для передачи `yarn zip`

После создания архив будем доступен в папке `dist`.

Имя `zip` файла создается по шаблону `${имя-модуля}-${версия-модуля}.zip`

Модуль содержит:

1. исходные файлы самого модуля, которые распологаются в `dist`
1. файл манифеста, который хранится по пути проекта `src/schema_manifest.json`


## Дополнительные возможности

Ядро конструктора использует react с динамическим обновлениям данных и возможностью изменения темы

1. React - служит для отображения данных и манипуляции с DOM элементами. Пакет должен отдавать react компонент в качестве модуля;
2. Mobx - утилита для управления состоянием приложения в реальном времени. С помощью этой утилиты можно реагировать на изменения окружающих модулей и распространять данных из своего модуля;
3. StoreBaseModel - базовая модель для создания хранилища по обмену данными между серверов и клиентом. Так же служить для реализация связей по средствам мастеров. Добавляет автоматическое обновление данных при изменении мастера.
4. Material-ui - утилита для визуализации простых компонентов и работы с css. На базе утилиты построена система изменения темы и цветовой палитры приложения.
5. PageModel (PageStore) - хранилище состояние страницы, на которой находится модуль. Предоставляет доступ к другим модулях через хранилища (store) других модулей. Дополнительно хранит в себе открытые окна и состоянием видимости страницы.
6. ApplicationModel (ApplicationStore) - общее хранилище приложения. Служит для работы с модулем авторизации и уведомлением. Хранит информацию о всех активных страницах в приложении. Позволяет осуществлять переход между страницами с предоставляем информации о предыдущей странице с помощью глобальных переменных.

## Что такое метамодель

Метамодель приложения разделена на 4 базовых типа:

1. Атрибуты - описывают типы данных в настройках одного класса. Каждый атрибут может быть опциональный. При работе с атрибутом в модуле необходимо проверить на наличие в нем данных, что бы не вызвать критическую ошибку.
1. Классы - описывают состояние модуля. Класс может включать в себя все атрибуты или часть из них. Обязательным атрибутом является только `type` по которому происходит определения к какому модулю относится данный класс.
1. Объекты - служат для объединения классов в один объект (например: таблица может включать в себя колонки для построения таблицы с нужными колонками для отображения). Вложенность одних объектов в других определяется на уровне создания класса. Для каждого класса разрешается переопределить его атрибуты.
1. Страница - служит для построения страницы (PageStore) из объектов. Для каждого класса разрешается переопределить его атрибуты при этом переопределение будет доступно только для выбранной страницы. Один и тот же объект может быть добавлен на несколько страниц сразу.

## Что такое глобальные переменные

Для общения между модулями реализовано общее хранилище переменных (globalValues в PageStore).

Хранилище позволяет:

1. Записывать данных из любого модуля (при использовании одного и того же ключа в разных модулях согласованность данных не гарантирована, вся ответственность ложится на создателя метамодели).
1. Читать данные - при этом нужно понимать, что тип данных может быть любой: `undefined, null, object, string, number, boolean, "array"`. При чтении данных нужно использовать `reaction` или `autorun` из `mobx` либо использовать `mobx-react` для подписывания `render` функции самого компонента на изменение данных.
1. Другие действия с данными - происходит посредством вызовов методов ObservableMap.

Глобальные переменные так же могут изменится при переходе между страницами посредством `applicationStore`

## Какие типы данных доступны

Для работы со статической типизации и утилитами предоставляется пакет `essence-constructor-share` который включает:

1. Типы данных для атрибутов `BuilderConfigType`. Данная структура синхронизируются с базой данных и позволяет поддерживать код в актуальном состоянии.
1. `ApplicationModelType` - тип данных для работы с приложением и авторизации. Доступно через `pageStore` модуля.
1. `PageModelType` - хранит состояние страницы.

## Параметры который приходят в модуль

1. `bc` - `BuilderConfigType` хранит состоянии класса переданного из метамодели;
1. `pageStore` - состояние страница, описано в типе `PageModelType`
1. `hidden` - (`boolean`) - состояние скрытия контента с помощью правил метамодели
1. `disabled` - (`boolean`) - состояние блокировки с помощью правил метамодели
1. `readOnly` - (`boolean`) - состояние "только для чтения" с помощью правил метамодели
1. `visible`  - (`boolean`) - состояние отображения контента на странице. Если страница полностью не показывается, то visible будет false. Иначе передается по цепочке.

Параметры `hidden`, `disabled`, `readOnly`, `visible` могут быть изменены в зависимости от состояний промежуточных компонентов.

## Как использовать другие модули в своих модулях

Для отображения дочерних компонентов использовать `mapComponents` при этом в каждый компонент необходимо обязательно передать `pageStore` и `bc` для правильной работы другого модуля. Так же нужно прокинуть по цепочке `disabled`, `hidden`, `readOnly`, `visible` при этом значения можно менять в зависимости от необходимости либо оставить какие пришли для совместимости.


## Документация для класса

Для создания документации необходимо в корне проекта поместить **DOC_MODULE.md** файл со следующим принципом наименования, где:

- `DOC_` - статический текст который говорит что это документация
- `MODULE` - динамическая часть, необходимо использовать `cv_type` класса, таким образом можно будет писать несколько документация для каждого класса, если модуль будет состоять из больше чем 1 класса
- `.md` - статический текст для расширения
', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-05-05T15:39:26.037+0000', 'text');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)
select t.ck_id, t.ck_d_lang, t.cr_namespace, t.cv_value, t.ck_user, t.ct_change::timestamp from (
    select 'ec24a8713fe34f84b8a796afc7c41199' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Модульная система' as cv_value, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-04-30T19:36:21.236+0000' as ct_change
) as t 
 join s_mt.t_d_lang dl
 on t.ck_d_lang = dl.ck_id
on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
