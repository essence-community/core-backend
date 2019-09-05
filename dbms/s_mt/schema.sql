--liquibase formatted sql
--changeset artemov_i:s_mt dbms:postgresql splitStatements:false stripComments:false
CREATE SCHEMA s_mt;

CREATE TABLE s_mt.t_action (
	ck_id varchar(32) NOT NULL,
	ck_step varchar(32),
	cn_order bigint NOT NULL,
	cv_key varchar(4000),
	cv_value varchar(4000),
	cv_description varchar(2000),
	cn_user bigint NOT NULL,
	ct_change timestamp with time zone NOT NULL,
	ck_d_action varchar(20) NOT NULL,
	cl_expected smallint NOT NULL DEFAULT null,
	CONSTRAINT cin_p_action PRIMARY KEY (ck_id),
    CONSTRAINT cin_c_action_1 UNIQUE (ck_step,cn_order)
);
COMMENT ON TABLE s_mt.t_action IS 'Действие';
COMMENT ON COLUMN s_mt.t_action.ck_id IS 'ИД действия';
COMMENT ON COLUMN s_mt.t_action.ck_step IS 'ИД Шага сценария';
COMMENT ON COLUMN s_mt.t_action.cn_order IS 'Номер действия в рамках шага';
COMMENT ON COLUMN s_mt.t_action.cv_key IS 'Ключ (как правило, ck_page_object или ck_page)';
COMMENT ON COLUMN s_mt.t_action.cv_value IS 'Значение (например, действие)';
COMMENT ON COLUMN s_mt.t_action.cv_description IS 'Описание';
COMMENT ON COLUMN s_mt.t_action.cn_user IS 'ИД пользователя';
COMMENT ON COLUMN s_mt.t_action.ct_change IS 'Дата последнего изменения';
COMMENT ON COLUMN s_mt.t_action.ck_d_action IS 'ИД типа действия';
COMMENT ON COLUMN s_mt.t_action.cl_expected IS 'Ожидаемый результат (true/false)';
CREATE UNIQUE INDEX cin_u_action_1 ON s_mt.t_action (ck_step, cn_order);

CREATE TABLE s_mt.t_attr (
	ck_id varchar(255) NOT NULL,
	cv_description varchar(2000) NOT NULL,
	ck_attr_type varchar(20) NOT NULL DEFAULT 'null',
	cn_user bigint NOT NULL,
	ct_change timestamp with time zone NOT NULL,
	CONSTRAINT cin_p_attr PRIMARY KEY (ck_id)
) ;
COMMENT ON TABLE s_mt.t_attr IS 'Справочник атрибутов';
COMMENT ON COLUMN s_mt.t_attr.ck_attr_type IS 'ИД типа атрибута';
COMMENT ON COLUMN s_mt.t_attr.cv_description IS 'Описание';
COMMENT ON COLUMN s_mt.t_attr.cn_user IS 'ИД пользователя';
COMMENT ON COLUMN s_mt.t_attr.ck_id IS 'ИД атрибута (имя)';
COMMENT ON COLUMN s_mt.t_attr.ct_change IS 'Дата последнего изменения';
CREATE INDEX cin_i_attr_1 ON s_mt.t_attr (ck_attr_type);

CREATE TABLE s_mt.t_attr_type (
	ck_id varchar(20) NOT NULL,
	cv_description varchar(100),
	cn_user bigint NOT NULL,
	ct_change timestamp with time zone NOT NULL,
	CONSTRAINT cin_p_attr_type PRIMARY KEY (ck_id)
);
COMMENT ON TABLE s_mt.t_attr_type IS 'Системные настройки';
COMMENT ON COLUMN s_mt.t_attr_type.ck_id IS 'ИД типа атрибута';
COMMENT ON COLUMN s_mt.t_attr_type.cv_description IS 'Описание';
COMMENT ON COLUMN s_mt.t_attr_type.cn_user IS 'ИД пользователя';
COMMENT ON COLUMN s_mt.t_attr_type.ct_change IS 'Дата последнего изменения';

CREATE TABLE s_mt.t_class (
	ck_id varchar(32) NOT NULL,
	cv_name varchar(100) NOT NULL,
	cv_description varchar(2000),
	cl_final smallint NOT NULL,
	cl_dataset smallint NOT NULL,
	cn_user bigint NOT NULL,
	ct_change timestamp with time zone NOT NULL,
	CONSTRAINT cin_p_class PRIMARY KEY (ck_id)
) ;
COMMENT ON TABLE s_mt.t_class IS 'С_Класс';
COMMENT ON COLUMN s_mt.t_class.ck_id IS 'ИД класса';
COMMENT ON COLUMN s_mt.t_class.cv_name IS 'Наименование класса';
COMMENT ON COLUMN s_mt.t_class.cv_description IS 'Описание класса';
COMMENT ON COLUMN s_mt.t_class.cl_final IS 'Признак возможности самостоятельного отображения в GUI (т.е. объект такого класса может быть напрямую связан со страницей)';
COMMENT ON COLUMN s_mt.t_class.cl_dataset IS 'Признак выводимого набора данных';
COMMENT ON COLUMN s_mt.t_class.cn_user IS 'ИД пользователя';
COMMENT ON COLUMN s_mt.t_class.ct_change IS 'Дата последнего изменения';

CREATE TABLE s_mt.t_class_attr (
	ck_id varchar(32) NOT NULL,
	ck_class varchar(32) NOT NULL,
	ck_attr varchar(255),
	cv_value varchar(2000),
	cn_user bigint NOT NULL,
	ct_change timestamp with time zone NOT NULL,
	cl_required smallint NOT NULL DEFAULT 0,
	CONSTRAINT cin_p_class_attr PRIMARY KEY (ck_id),
    CONSTRAINT cin_c_class_attr_1 UNIQUE (ck_class,ck_attr)
) ;
COMMENT ON TABLE s_mt.t_class_attr IS 'С_Атрибут класса';
COMMENT ON COLUMN s_mt.t_class_attr.ck_id IS 'ИД атрибута класса';
COMMENT ON COLUMN s_mt.t_class_attr.ck_class IS 'ИД класса';
COMMENT ON COLUMN s_mt.t_class_attr.ck_attr IS 'ИД атрибута (имя)';
COMMENT ON COLUMN s_mt.t_class_attr.cv_value IS 'Значение атрибута';
COMMENT ON COLUMN s_mt.t_class_attr.cn_user IS 'ИД пользователя';
COMMENT ON COLUMN s_mt.t_class_attr.ct_change IS 'Дата последнего изменения';
COMMENT ON COLUMN s_mt.t_class_attr.cl_required IS 'Обязательность';
CREATE UNIQUE INDEX cin_u_class_attr_1 ON s_mt.t_class_attr (ck_class, ck_attr);

CREATE TABLE s_mt.t_class_hierarchy (
	ck_id varchar(32) NOT NULL,
	ck_class_parent varchar(32) NOT NULL,
	ck_class_child varchar(32) NOT NULL,
	ck_class_attr varchar(32) NOT NULL,
	cn_user bigint NOT NULL,
	ct_change timestamp with time zone NOT NULL,
	CONSTRAINT cin_p_class_hierarchy PRIMARY KEY (ck_id),
    CONSTRAINT cin_c_class_hierarchy_1 UNIQUE (ck_class_parent,ck_class_child,ck_class_attr)
) ;
COMMENT ON TABLE s_mt.t_class_hierarchy IS 'С_Иерархия классов';
COMMENT ON COLUMN s_mt.t_class_hierarchy.ct_change IS 'Дата последнего изменения';
COMMENT ON COLUMN s_mt.t_class_hierarchy.cn_user IS 'ИД пользователя';
COMMENT ON COLUMN s_mt.t_class_hierarchy.ck_id IS 'ИД Иерархии классов';
COMMENT ON COLUMN s_mt.t_class_hierarchy.ck_class_attr IS 'ИД атрибута ';
COMMENT ON COLUMN s_mt.t_class_hierarchy.ck_class_parent IS 'ИД родительского класса';
COMMENT ON COLUMN s_mt.t_class_hierarchy.ck_class_child IS 'ИД дочернего класса';
CREATE INDEX cin_r_class_hierarchy_1 ON s_mt.t_class_hierarchy (ck_class_parent);
CREATE INDEX cin_r_class_hierarchy_2 ON s_mt.t_class_hierarchy (ck_class_child);
CREATE INDEX cin_r_class_hierarchy_3 ON s_mt.t_class_hierarchy (ck_class_attr);
CREATE UNIQUE INDEX cin_u_class_hierarchy_1 ON s_mt.t_class_hierarchy (ck_class_parent, ck_class_child, ck_class_attr);

CREATE TABLE s_mt.t_d_action (
	ck_id varchar(20) NOT NULL,
	cv_description varchar(255),
	CONSTRAINT cin_p_d_action PRIMARY KEY (ck_id)
);

COMMENT ON TABLE s_mt.t_d_action IS 'С_Тип действия';
COMMENT ON COLUMN s_mt.t_d_action.ck_id IS 'ИД типа действия';
COMMENT ON COLUMN s_mt.t_d_action.cv_description IS 'Описание';

CREATE TABLE s_mt.t_icon (
	ck_id varchar(32) NOT NULL,
	cv_name varchar(100),
	cv_font varchar(100),
	cn_user bigint NOT NULL,
	ct_change timestamp with time zone NOT NULL,
	CONSTRAINT cin_p_icon PRIMARY KEY (ck_id)
) ;

COMMENT ON TABLE s_mt.t_icon IS 'Иконки';
COMMENT ON COLUMN s_mt.t_icon.ct_change IS 'Дата последнего изменения';
COMMENT ON COLUMN s_mt.t_icon.ck_id IS 'ИД иконки';
COMMENT ON COLUMN s_mt.t_icon.cv_name IS 'Наименование иконки / код символа';
COMMENT ON COLUMN s_mt.t_icon.cn_user IS 'ИД пользователя';
COMMENT ON COLUMN s_mt.t_icon.cv_font IS 'Наименование шрифта';

CREATE TABLE s_mt.t_log (
	ck_id varchar(32) NOT NULL,
	cv_session varchar(100),
	cc_json text,
	cv_table varchar(4000),
	cv_id varchar(4000),
	cv_action varchar(30),
	cv_error varchar(4000),
	cn_user bigint NOT NULL,
	ct_change timestamp with time zone NOT NULL,
	CONSTRAINT cin_p_log PRIMARY KEY (ck_id)
) ;
COMMENT ON TABLE s_mt.t_log IS 'Лог';
COMMENT ON COLUMN s_mt.t_log.cc_json IS 'JSON';
COMMENT ON COLUMN s_mt.t_log.ct_change IS 'Дата последнего изменения';
COMMENT ON COLUMN s_mt.t_log.ck_id IS 'ИД записи лога';
COMMENT ON COLUMN s_mt.t_log.cv_table IS 'Имя таблицы';
COMMENT ON COLUMN s_mt.t_log.cv_id IS 'ИД записи в таблице';
COMMENT ON COLUMN s_mt.t_log.cv_session IS 'ИД сессии';
COMMENT ON COLUMN s_mt.t_log.cv_action IS 'ИД действия';
COMMENT ON COLUMN s_mt.t_log.cn_user IS 'ИД пользователя';
COMMENT ON COLUMN s_mt.t_log.cv_error IS 'Код ошибки';

CREATE TABLE s_mt.t_message (
	ck_id bigint NOT NULL,
	cr_type varchar(10) NOT NULL,
	cv_text varchar(500) NOT NULL,
	cn_user bigint NOT NULL,
	ct_change timestamp with time zone NOT NULL,
	CONSTRAINT cin_p_message PRIMARY KEY (ck_id)
) ;
COMMENT ON TABLE s_mt.t_message IS 'С_Системные сообщения';
COMMENT ON COLUMN s_mt.t_message.cv_text IS 'Текст сообщения';
COMMENT ON COLUMN s_mt.t_message.cr_type IS 'Тип сообщения (info=информационное; error=ошибка; warning=предупреждение, требующее подтверждения;)';
COMMENT ON COLUMN s_mt.t_message.ct_change IS 'Дата последнего изменения';
COMMENT ON COLUMN s_mt.t_message.ck_id IS 'ИД системного сообщения';
COMMENT ON COLUMN s_mt.t_message.cn_user IS 'ИД пользователя';
ALTER TABLE s_mt.t_message ADD CONSTRAINT cin_c_message_1 CHECK (cr_type='info' OR cr_type='error' OR cr_type='warning');

CREATE TABLE s_mt.t_module (
	ck_id varchar(32) NOT NULL,
	ck_class varchar(32),
	cv_name varchar(1000) NOT NULL,
	cn_user bigint NOT NULL,
	ct_change timestamp with time zone NOT NULL,
	cv_version varchar(1000) NOT NULL,
	cl_available smallint NOT NULL,
	cc_manifest text,
	CONSTRAINT cin_p_module PRIMARY KEY (ck_id)
);
COMMENT ON TABLE s_mt.t_module IS 'Список модулей';
COMMENT ON COLUMN s_mt.t_module.cv_version IS 'версия модуля';
COMMENT ON COLUMN s_mt.t_module.cn_user IS 'ид пользователя';
COMMENT ON COLUMN s_mt.t_module.cv_name IS 'наименование модуля';
COMMENT ON COLUMN s_mt.t_module.cl_available IS 'признак активности модуля (0 - не активен, 1 - активен)';
COMMENT ON COLUMN s_mt.t_module.ck_class IS 'ид класса';
COMMENT ON COLUMN s_mt.t_module.cc_manifest IS 'Манифест';
COMMENT ON COLUMN s_mt.t_module.ct_change IS 'дата последнего изменения';
COMMENT ON COLUMN s_mt.t_module.ck_id IS 'ИД модуля';
CREATE INDEX cin_r_module_1 ON s_mt.t_module (ck_class);

CREATE TABLE s_mt.t_notification (
	ck_id varchar(32) NOT NULL,
	cd_st timestamp NOT NULL,
	cd_en timestamp,
	ck_user varchar(32) NOT NULL,
	cl_sent smallint NOT NULL,
	cv_param varchar(4000),
	cv_message varchar(4000),
	CONSTRAINT cin_p_notification PRIMARY KEY (ck_id)
);
COMMENT ON TABLE s_mt.t_notification IS 'Т_Оповещение';
COMMENT ON COLUMN s_mt.t_notification.ck_id IS 'ИД оповещения';
COMMENT ON COLUMN s_mt.t_notification.cd_en IS 'Дата окончания';
COMMENT ON COLUMN s_mt.t_notification.cd_st IS 'Дата начала';
COMMENT ON COLUMN s_mt.t_notification.cv_param IS 'Параметры (например, для подстановки макроса для t_message)';
COMMENT ON COLUMN s_mt.t_notification.ck_user IS 'ИД пользователя из СУВК, acc_user.acc_id_usr';
COMMENT ON COLUMN s_mt.t_notification.cl_sent IS 'Признак отправки';

CREATE TABLE s_mt.t_object (
	ck_id varchar(32) NOT NULL,
	ck_class varchar(32) NOT NULL,
	ck_parent varchar(32),
	cv_name varchar(50) NOT NULL,
	cn_order bigint NOT NULL,
	ck_query varchar(255),
	cv_description varchar(2000) NOT NULL,
	cv_displayed varchar(255) DEFAULT ' ',
	cv_modify varchar(255),
	ck_provider varchar(10),
	cn_user bigint NOT NULL,
	ct_change timestamp with time zone NOT NULL,
	CONSTRAINT cin_p_object PRIMARY KEY (ck_id)
) ;
COMMENT ON TABLE s_mt.t_object IS 'Объект интерфейса';
COMMENT ON COLUMN s_mt.t_object.ck_parent IS 'ИД родительского объекта';
COMMENT ON COLUMN s_mt.t_object.cv_displayed IS 'Отображаемое в GUI имя';
COMMENT ON COLUMN s_mt.t_object.ck_provider IS 'ИД провайдера для модификации данных';
COMMENT ON COLUMN s_mt.t_object.cv_modify IS 'Имя запроса для модификации данных';
COMMENT ON COLUMN s_mt.t_object.ck_class IS 'Класс объекта';
COMMENT ON COLUMN s_mt.t_object.ck_query IS 'Имя запроса';
COMMENT ON COLUMN s_mt.t_object.ck_id IS 'ИД объекта';
COMMENT ON COLUMN s_mt.t_object.cn_order IS 'Порядок отображения объектов внутри родительского объекта';
COMMENT ON COLUMN s_mt.t_object.ct_change IS 'Дата последнего изменения';
COMMENT ON COLUMN s_mt.t_object.cv_description IS 'Описание';
COMMENT ON COLUMN s_mt.t_object.cv_name IS 'Наименование объекта';
COMMENT ON COLUMN s_mt.t_object.cn_user IS 'ИД пользователя';
CREATE INDEX cin_r_object_1 ON s_mt.t_object (ck_parent);
CREATE INDEX cin_r_object_2 ON s_mt.t_object (ck_query);
CREATE INDEX cin_r_object_3 ON s_mt.t_object (ck_class);
CREATE INDEX cin_r_object_4 ON s_mt.t_object (ck_provider);
CREATE UNIQUE INDEX cin_u_object_1 ON s_mt.t_object ((case when ck_parent is not null then ck_parent||cn_order::varchar else null end));
ALTER TABLE s_mt.t_object ADD CONSTRAINT cin_c_object_1 CHECK (cv_modify is null or ck_provider is not null);

CREATE TABLE s_mt.t_object_attr (
	ck_id varchar(32) NOT NULL,
	ck_object varchar(32) NOT NULL,
	ck_class_attr varchar(32) NOT NULL,
	cv_value varchar(2000),
	cn_user bigint NOT NULL,
	ct_change timestamp with time zone NOT NULL,
	CONSTRAINT cin_p_object_attr PRIMARY KEY (ck_id),
    CONSTRAINT cin_c_object_attr_1 UNIQUE (ck_object, ck_class_attr)
) ;
COMMENT ON TABLE s_mt.t_object_attr IS 'Атрибут объекта';
COMMENT ON COLUMN s_mt.t_object_attr.ck_id IS 'ИД атрибута объекта';
COMMENT ON COLUMN s_mt.t_object_attr.ck_object IS 'ИД объекта';
COMMENT ON COLUMN s_mt.t_object_attr.ck_class_attr IS 'Атрибут класса';
COMMENT ON COLUMN s_mt.t_object_attr.cv_value IS 'Значение';
COMMENT ON COLUMN s_mt.t_object_attr.cn_user IS 'ИД пользователя';
COMMENT ON COLUMN s_mt.t_object_attr.ct_change IS 'Дата последнего изменения';
CREATE UNIQUE INDEX cin_u_object_attr_1 ON s_mt.t_object_attr (ck_object, ck_class_attr);

CREATE TABLE s_mt.t_page (
	ck_id varchar(32) NOT NULL,
	ck_parent varchar(32),
	cr_type bigint,
	cv_name varchar(255),
	cn_order bigint NOT NULL,
	cl_static smallint NOT NULL,
	cv_url varchar(255),
	ck_icon varchar(32),
	cn_user bigint NOT NULL,
	ct_change timestamp with time zone NOT NULL,
	cl_menu smallint NOT NULL,
	CONSTRAINT cin_p_page PRIMARY KEY (ck_id)
) ;
COMMENT ON TABLE s_mt.t_page IS 'Страница интерфейса';
COMMENT ON COLUMN s_mt.t_page.ck_id IS 'ИД страницы';
COMMENT ON COLUMN s_mt.t_page.ct_change IS 'Дата последнего изменения';
COMMENT ON COLUMN s_mt.t_page.cn_order IS 'Порядок следования страниц интерфейса
Например, очередность в меню';
COMMENT ON COLUMN s_mt.t_page.cl_static IS 'Признак статической страницы';
COMMENT ON COLUMN s_mt.t_page.ck_parent IS 'Родительская страница';
COMMENT ON COLUMN s_mt.t_page.cn_user IS 'ИД пользователя';
COMMENT ON COLUMN s_mt.t_page.cv_name IS 'Наименование страницы';
COMMENT ON COLUMN s_mt.t_page.cv_url IS 'URL статичной страницы';
COMMENT ON COLUMN s_mt.t_page.ck_icon IS 'ИД иконки';
COMMENT ON COLUMN s_mt.t_page.cr_type IS '0 - модуль, 1 - каталог, 2 - страница';
COMMENT ON COLUMN s_mt.t_page.cl_menu IS 'Признак "Отображать в меню"';
CREATE INDEX cin_r_page_1 ON s_mt.t_page (ck_parent);
ALTER TABLE s_mt.t_page ADD CONSTRAINT cin_c_page_1 CHECK (cr_type in (0,1,2));

CREATE TABLE s_mt.t_page_action (
	ck_id varchar(32) NOT NULL,
	ck_page varchar(32),
	cr_type varchar(10),
	cn_action bigint,
	cn_user bigint NOT NULL,
	ct_change timestamp with time zone NOT NULL,
	CONSTRAINT cin_p_page_action PRIMARY KEY (ck_id)
) ;
COMMENT ON TABLE s_mt.t_page_action IS 'Действия со страницей';
COMMENT ON COLUMN s_mt.t_page_action.ck_id IS 'ИД атрибута объекта на странице';
COMMENT ON COLUMN s_mt.t_page_action.ck_page IS 'ИД связи страницы и объекта';
COMMENT ON COLUMN s_mt.t_page_action.cr_type IS 'Атрибут класса';
COMMENT ON COLUMN s_mt.t_page_action.cn_action IS 'ИД пользователя';
COMMENT ON COLUMN s_mt.t_page_action.cn_user IS 'ИД пользователя';
COMMENT ON COLUMN s_mt.t_page_action.ct_change IS 'Дата последнего изменения';
ALTER TABLE s_mt.t_page_action ADD CONSTRAINT cin_c_page_action_1 CHECK (cr_type='view' OR cr_type='edit');

CREATE TABLE s_mt.t_page_object (
	ck_page varchar(32) NOT NULL,
	ck_object varchar(32) NOT NULL,
	cn_order bigint NOT NULL,
	ck_parent varchar(32),
	ck_id varchar(32) NOT NULL,
	ck_master varchar(32),
	cn_user bigint NOT NULL,
	ct_change timestamp with time zone NOT NULL,
	CONSTRAINT cin_p_page_object PRIMARY KEY (ck_id),
    CONSTRAINT cin_c_page_object_1 UNIQUE (ck_page,ck_parent,cn_order)
) ;
COMMENT ON TABLE s_mt.t_page_object IS 'Связь страницы и объекта интерфейса';
COMMENT ON COLUMN s_mt.t_page_object.ck_id IS 'ИД связи страницы и объекта';
COMMENT ON COLUMN s_mt.t_page_object.ck_object IS 'ИД объекта';
COMMENT ON COLUMN s_mt.t_page_object.ck_page IS 'ИД страницы';
COMMENT ON COLUMN s_mt.t_page_object.cn_order IS 'Порядок отображения объектов на странице';
COMMENT ON COLUMN s_mt.t_page_object.ck_parent IS 'Родительский page_object';
COMMENT ON COLUMN s_mt.t_page_object.cn_user IS 'ИД пользователя';
COMMENT ON COLUMN s_mt.t_page_object.ck_master IS 'ИД пользователя';
COMMENT ON COLUMN s_mt.t_page_object.ct_change IS 'Дата последнего изменения';
CREATE UNIQUE INDEX cin_u_page_object_1 ON s_mt.t_page_object (ck_page, ck_parent, cn_order);

CREATE TABLE s_mt.t_page_object_attr (
	ck_id varchar(32) NOT NULL,
	ck_page_object varchar(32) NOT NULL,
	ck_class_attr varchar(32) NOT NULL,
	cv_value varchar(2000),
	cn_user bigint NOT NULL,
	ct_change timestamp with time zone NOT NULL,
	CONSTRAINT cin_p_page_object_attr PRIMARY KEY (ck_id),
    CONSTRAINT cin_c_page_object_attr_1 UNIQUE (ck_page_object,ck_class_attr)
) ;
COMMENT ON TABLE s_mt.t_page_object_attr IS 'Атрибут объекта на странице';
COMMENT ON COLUMN s_mt.t_page_object_attr.ck_id IS 'ИД атрибута объекта на странице';
COMMENT ON COLUMN s_mt.t_page_object_attr.ck_page_object IS 'ИД связи страницы и объекта';
COMMENT ON COLUMN s_mt.t_page_object_attr.ck_class_attr IS 'Атрибут класса';
COMMENT ON COLUMN s_mt.t_page_object_attr.cv_value IS 'Значение';
COMMENT ON COLUMN s_mt.t_page_object_attr.cn_user IS 'ИД пользователя';
COMMENT ON COLUMN s_mt.t_page_object_attr.ct_change IS 'Дата последнего изменения';
CREATE UNIQUE INDEX cin_u_page_object_attr_1 ON s_mt.t_page_object_attr (ck_page_object, ck_class_attr);

CREATE TABLE s_mt.t_page_variable (
	ck_id varchar(32) NOT NULL,
	ck_page varchar(32) NOT NULL,
	cv_name varchar(50) NOT NULL,
	cv_description varchar(255),
	cn_user bigint NOT NULL,
	ct_change timestamp with time zone NOT NULL,
	CONSTRAINT cin_p_page_variable PRIMARY KEY (ck_id),
    CONSTRAINT cin_c_page_variable_1 UNIQUE (ck_page,cv_name)
) ;
COMMENT ON TABLE s_mt.t_page_variable IS 'Страничная переменная';
COMMENT ON COLUMN s_mt.t_page_variable.ck_id IS 'ИД страничной переменной';
COMMENT ON COLUMN s_mt.t_page_variable.ck_page IS 'ИД страницы';
COMMENT ON COLUMN s_mt.t_page_variable.cv_name IS 'Имя';
COMMENT ON COLUMN s_mt.t_page_variable.cv_description IS 'Описание';
COMMENT ON COLUMN s_mt.t_page_variable.cn_user IS 'ИД пользователя';
COMMENT ON COLUMN s_mt.t_page_variable.ct_change IS 'Дата последнего изменения';
CREATE UNIQUE INDEX cin_u_page_variable_1 ON s_mt.t_page_variable (ck_page, cv_name);

CREATE TABLE s_mt.t_provider (
	ck_id varchar(10) NOT NULL,
	cv_name varchar(255) NOT NULL,
	cn_user bigint NOT NULL,
	ct_change timestamp with time zone NOT NULL,
	CONSTRAINT cin_p_provider PRIMARY KEY (ck_id)
) ;
COMMENT ON TABLE s_mt.t_provider IS 'Провайдер данных';
COMMENT ON COLUMN s_mt.t_provider.ct_change IS 'Дата последнего изменения';
COMMENT ON COLUMN s_mt.t_provider.cv_name IS 'Наименование провайдера';
COMMENT ON COLUMN s_mt.t_provider.ck_id IS 'ИД провайдера';
COMMENT ON COLUMN s_mt.t_provider.cn_user IS 'ИД пользователя';

CREATE TABLE s_mt.t_query (
	ck_id varchar(255) NOT NULL,
	cc_query text,
	ck_provider varchar(10) NOT NULL DEFAULT 'null',
	cn_user bigint NOT NULL,
	ct_change timestamp with time zone NOT NULL,
	cr_type varchar(20) NOT NULL,
	cr_access varchar(10) NOT NULL,
	CONSTRAINT cin_p_query PRIMARY KEY (ck_id)
);
COMMENT ON TABLE s_mt.t_query IS 'Запросы';
COMMENT ON COLUMN s_mt.t_query.cc_query IS 'Текст запроса';
COMMENT ON COLUMN s_mt.t_query.ck_provider IS 'ИД провайдера';
COMMENT ON COLUMN s_mt.t_query.cr_access IS 'Проверка доступа (что будет проверяться на шлюзе при выполнении запроса): po_session = page_object и сессию, session - только сессию, free - без проверки доступа (не использовать этот вариант без согласования)';
COMMENT ON COLUMN s_mt.t_query.cr_type IS 'Тип запроса:
select - запрос на выборку данных
dml - модификация данных
auth - авторизация
select_streaming - потоковая выборка
dml_streaming - потоковый метод
file_download - скачивание файла
file_upload - загрузка файла на сервер';
COMMENT ON COLUMN s_mt.t_query.ct_change IS 'Дата последнего изменения';
COMMENT ON COLUMN s_mt.t_query.cn_user IS 'ИД пользователя';
COMMENT ON COLUMN s_mt.t_query.ck_id IS 'Имя запроса';
CREATE INDEX cin_r_query_1 ON s_mt.t_query (ck_provider);
ALTER TABLE s_mt.t_query ADD CONSTRAINT cin_c_query_2 CHECK (cr_access in ('po_session','session','free'));
ALTER TABLE s_mt.t_query ADD CONSTRAINT cin_c_query_1 CHECK (cr_type in ('select','dml','auth','select_streaming','dml_streaming','file_download','file_upload'));

CREATE TABLE s_mt.t_scenario (
	ck_id varchar(32) NOT NULL,
	cn_order bigint NOT NULL,
	cv_name varchar(50) NOT NULL,
	cl_valid smallint NOT NULL,
	cv_description varchar(2000),
	cn_user bigint NOT NULL,
	ct_change timestamp with time zone NOT NULL,
	CONSTRAINT cin_p_scenario PRIMARY KEY (ck_id),
    CONSTRAINT cin_c_scenario_1 UNIQUE (cn_order)
) ;
COMMENT ON TABLE s_mt.t_scenario IS 'Сценарий';
COMMENT ON COLUMN s_mt.t_scenario.ck_id IS 'ИД Сценария';
COMMENT ON COLUMN s_mt.t_scenario.cn_order IS 'Порядок';
COMMENT ON COLUMN s_mt.t_scenario.cv_name IS 'Имя';
COMMENT ON COLUMN s_mt.t_scenario.cl_valid IS 'Признак валидности';
COMMENT ON COLUMN s_mt.t_scenario.cv_description IS 'Описание';
COMMENT ON COLUMN s_mt.t_scenario.cn_user IS 'ИД пользователя';
COMMENT ON COLUMN s_mt.t_scenario.ct_change IS 'Дата последнего изменения';

CREATE TABLE s_mt.t_semaphore (
	ck_id varchar(255) NOT NULL,
	cn_value bigint NOT NULL,
	CONSTRAINT cin_p_semaphore PRIMARY KEY (ck_id)
) ;
COMMENT ON TABLE s_mt.t_semaphore IS 'Сценарий';
COMMENT ON COLUMN s_mt.t_semaphore.ck_id IS 'ИД семафора';
COMMENT ON COLUMN s_mt.t_semaphore.cn_value IS 'Значение';

CREATE TABLE s_mt.t_step (
	ck_id varchar(32) NOT NULL,
	ck_scenario varchar(32),
	cn_order bigint,
	cv_name varchar(255),
	cn_user bigint NOT NULL,
	ct_change timestamp with time zone NOT NULL,
	CONSTRAINT cin_p_step PRIMARY KEY (ck_id),
    CONSTRAINT cin_c_step_1 UNIQUE (ck_scenario, cn_order)
) ;
COMMENT ON TABLE s_mt.t_step IS 'Шаг сценария';
COMMENT ON COLUMN s_mt.t_step.cn_order IS 'Номер шага в рамках сценария';
COMMENT ON COLUMN s_mt.t_step.ct_change IS 'Дата последнего изменения';
COMMENT ON COLUMN s_mt.t_step.cv_name IS 'Имя шага';
COMMENT ON COLUMN s_mt.t_step.ck_id IS 'ИД Шага сценария';
COMMENT ON COLUMN s_mt.t_step.cn_user IS 'ИД пользователя';
COMMENT ON COLUMN s_mt.t_step.ck_scenario IS 'ИД Сценария';
CREATE INDEX cin_r_step_1 ON s_mt.t_step (ck_scenario);
CREATE UNIQUE INDEX cin_u_step_1 ON s_mt.t_step (ck_scenario, cn_order);

CREATE TABLE s_mt.t_sys_setting (
	ck_id varchar(255) NOT NULL,
	cv_value text,
	cn_user bigint NOT NULL,
	ct_change timestamp with time zone NOT NULL,
	cv_description varchar(2000),
	CONSTRAINT cin_p_sys_setting PRIMARY KEY (ck_id)
) ;
COMMENT ON TABLE s_mt.t_sys_setting IS 'Системные настройки';
COMMENT ON COLUMN s_mt.t_sys_setting.cv_description IS 'Описание';
COMMENT ON COLUMN s_mt.t_sys_setting.cn_user IS 'ИД пользователя';
COMMENT ON COLUMN s_mt.t_sys_setting.ck_id IS 'ИД настройки';
COMMENT ON COLUMN s_mt.t_sys_setting.ct_change IS 'Дата последнего изменения';
COMMENT ON COLUMN s_mt.t_sys_setting.cv_value IS 'Значение настройки';

ALTER TABLE s_mt.t_page_action ADD CONSTRAINT cin_r_page_action_1 FOREIGN KEY (ck_page) REFERENCES s_mt.t_page(ck_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE s_mt.t_page_object ADD CONSTRAINT cin_r_page_object_3 FOREIGN KEY (ck_parent) REFERENCES s_mt.t_page_object(ck_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE s_mt.t_page_object ADD CONSTRAINT cin_r_page_object_2 FOREIGN KEY (ck_object) REFERENCES s_mt.t_object(ck_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE s_mt.t_page_object ADD CONSTRAINT cin_r_page_object_4 FOREIGN KEY (ck_master) REFERENCES s_mt.t_page_object(ck_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE s_mt.t_page_object ADD CONSTRAINT cin_r_page_object_1 FOREIGN KEY (ck_page) REFERENCES s_mt.t_page(ck_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE s_mt.t_query ADD CONSTRAINT cin_r_query_1 FOREIGN KEY (ck_provider) REFERENCES s_mt.t_provider(ck_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE s_mt.t_class_hierarchy ADD CONSTRAINT cin_r_class_hierarchy_2 FOREIGN KEY (ck_class_child) REFERENCES s_mt.t_class(ck_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE s_mt.t_class_hierarchy ADD CONSTRAINT cin_r_class_hierarchy_3 FOREIGN KEY (ck_class_attr) REFERENCES s_mt.t_class_attr(ck_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE s_mt.t_class_hierarchy ADD CONSTRAINT cin_r_class_hierarchy_1 FOREIGN KEY (ck_class_parent) REFERENCES s_mt.t_class(ck_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE s_mt.t_page_variable ADD CONSTRAINT cin_r_page_variable_1 FOREIGN KEY (ck_page) REFERENCES s_mt.t_page(ck_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE s_mt.t_attr ADD CONSTRAINT cin_r_attr_1 FOREIGN KEY (ck_attr_type) REFERENCES s_mt.t_attr_type(ck_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE s_mt.t_module ADD CONSTRAINT cin_r_module_1 FOREIGN KEY (ck_class) REFERENCES s_mt.t_class(ck_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE s_mt.t_class_attr ADD CONSTRAINT cin_r_class_attr_1 FOREIGN KEY (ck_class) REFERENCES s_mt.t_class(ck_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE s_mt.t_class_attr ADD CONSTRAINT cin_r_class_attr_2 FOREIGN KEY (ck_attr) REFERENCES s_mt.t_attr(ck_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE s_mt.t_action ADD CONSTRAINT cin_r_action_1 FOREIGN KEY (ck_step) REFERENCES s_mt.t_step(ck_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE s_mt.t_action ADD CONSTRAINT cin_r_action_2 FOREIGN KEY (ck_d_action) REFERENCES s_mt.t_d_action(ck_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE s_mt.t_page ADD CONSTRAINT cin_r_page_1 FOREIGN KEY (ck_parent) REFERENCES s_mt.t_page(ck_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE s_mt.t_page ADD CONSTRAINT cin_r_page_2 FOREIGN KEY (ck_icon) REFERENCES s_mt.t_icon(ck_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE s_mt.t_step ADD CONSTRAINT cin_r_step_1 FOREIGN KEY (ck_scenario) REFERENCES s_mt.t_scenario(ck_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE s_mt.t_object_attr ADD CONSTRAINT cin_r_object_attr_2 FOREIGN KEY (ck_object) REFERENCES s_mt.t_object(ck_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE s_mt.t_object_attr ADD CONSTRAINT cin_r_object_attr_1 FOREIGN KEY (ck_class_attr) REFERENCES s_mt.t_class_attr(ck_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE s_mt.t_object ADD CONSTRAINT cin_r_object_2 FOREIGN KEY (ck_query) REFERENCES s_mt.t_query(ck_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE s_mt.t_object ADD CONSTRAINT cin_r_object_3 FOREIGN KEY (ck_class) REFERENCES s_mt.t_class(ck_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE s_mt.t_object ADD CONSTRAINT cin_r_object_1 FOREIGN KEY (ck_parent) REFERENCES s_mt.t_object(ck_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE s_mt.t_object ADD CONSTRAINT cin_r_object_4 FOREIGN KEY (ck_provider) REFERENCES s_mt.t_provider(ck_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE s_mt.t_page_object_attr ADD CONSTRAINT cin_r_page_object_attr_2 FOREIGN KEY (ck_class_attr) REFERENCES s_mt.t_class_attr(ck_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE s_mt.t_page_object_attr ADD CONSTRAINT cin_r_page_object_attr_1 FOREIGN KEY (ck_page_object) REFERENCES s_mt.t_page_object(ck_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;
