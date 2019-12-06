--liquibase formatted sql
--changeset artemov_i:s_it dbms:postgresql splitStatements:false stripComments:false
CREATE SCHEMA s_it;

CREATE TABLE s_it.t_log
(
    ck_id varchar(32) NOT NULL,
    cv_session varchar(100),
    cc_json text,
    cv_table varchar(4000),
    cv_id varchar(4000),
    cv_action varchar(30),
    cv_error varchar(4000),
    ck_user varchar(150) NOT NULL,
    ct_change timestamp with time zone NOT NULL,
    CONSTRAINT cin_p_log PRIMARY KEY (ck_id)
);

COMMENT ON TABLE s_it.t_log IS 'Лог';
COMMENT ON COLUMN s_it.t_log.ck_id IS 'ИД записи лога';
COMMENT ON COLUMN s_it.t_log.cv_session IS 'ИД сессии';
COMMENT ON COLUMN s_it.t_log.cc_json IS 'JSON';
COMMENT ON COLUMN s_it.t_log.cv_table IS 'Имя таблицы';
COMMENT ON COLUMN s_it.t_log.cv_id IS 'ИД записи в таблице';
COMMENT ON COLUMN s_it.t_log.cv_action IS 'ИД действия';
COMMENT ON COLUMN s_it.t_log.cv_error IS 'Код ошибки';
COMMENT ON COLUMN s_it.t_log.ck_user IS 'ИД пользователя';
COMMENT ON COLUMN s_it.t_log.ct_change IS 'Дата последнего изменения';

CREATE TABLE s_it.t_d_interface 
  (	ck_id varchar(20) not null, 
    cv_description varchar(500), 
    CONSTRAINT cin_p_d_interface PRIMARY KEY (ck_id)
  );

COMMENT ON COLUMN s_it.t_d_interface.ck_id is 'ИД типа интегр. интерфейса';
COMMENT ON COLUMN s_it.t_d_interface.cv_description is 'Имя';
COMMENT ON TABLE s_it.t_d_interface is 'Тип интеграционного интерфейса';

CREATE TABLE s_it.t_d_provider 
   (	ck_id varchar(20) not null, 
	    cv_description varchar(500), 
	    CONSTRAINT cin_p_d_provider PRIMARY KEY (ck_id)
  );

COMMENT ON COLUMN s_it.t_d_provider.ck_id IS 'ИД источника данных';
COMMENT ON COLUMN s_it.t_d_provider.cv_description IS 'Имя';
COMMENT ON TABLE s_it.t_d_provider  IS 'Источник данных';

CREATE TABLE s_it.t_d_param 
   ( 
     ck_id VARCHAR(20) NOT NULL, 
	 cv_description VARCHAR(500), 
	 CONSTRAINT cin_p_d_param PRIMARY KEY (ck_id)
   );

COMMENT ON COLUMN s_it.t_d_param.ck_id IS 'ИД типа параметра';
COMMENT ON COLUMN s_it.t_d_param.cv_description IS 'Описание';
COMMENT ON TABLE s_it.t_d_param  IS 'Тип параметра интерфейса';

CREATE TABLE s_it.t_d_status 
   (	
     ck_id VARCHAR(20) NOT NULL, 
	 cv_description VARCHAR(500), 
	 CONSTRAINT cin_p_d_status PRIMARY KEY (ck_id)
   );

COMMENT ON COLUMN s_it.t_d_status.ck_id IS 'ИД статуса обработки';
COMMENT ON COLUMN s_it.t_d_status.cv_description IS 'Имя';
COMMENT ON TABLE s_it.t_d_status  IS 'Статус обработки';

CREATE TABLE s_it.t_interface 
   (	
    ck_id VARCHAR(50) NOT NULL, 
	ck_d_interface VARCHAR(20) NOT NULL, 
	ck_d_provider VARCHAR(20) NOT NULL, 
	cc_request TEXT, 
	cc_response TEXT, 
	cn_action BIGINT, 
	cv_url_request VARCHAR(500), 
	cv_url_response VARCHAR(500), 
	cv_description VARCHAR(4000), 
	ck_parent VARCHAR(50), 
	CONSTRAINT cin_p_interface PRIMARY KEY (ck_id), 
	CONSTRAINT cin_r_interface_1 FOREIGN KEY (ck_d_interface)
	  REFERENCES s_it.t_d_interface (ck_id), 
	CONSTRAINT cin_r_interface_3 FOREIGN KEY (ck_parent)
	  REFERENCES s_it.t_interface (ck_id), 
	CONSTRAINT cin_r_interface_2 FOREIGN KEY (ck_d_provider)
	  REFERENCES s_it.t_d_provider (ck_id)
   );

COMMENT ON COLUMN s_it.t_interface.ck_id IS 'ИД интеграционного интерфейса';
COMMENT ON COLUMN s_it.t_interface.ck_d_interface IS 'ИД типа интегр. интерфейса';
COMMENT ON COLUMN s_it.t_interface.ck_d_provider IS 'ИД источника данных';
COMMENT ON COLUMN s_it.t_interface.cc_request IS 'Текст запроса получения данных';
COMMENT ON COLUMN s_it.t_interface.cc_response IS 'Текст запроса для ответа';
COMMENT ON COLUMN s_it.t_interface.cn_action IS 'Код действия СУВК';
COMMENT ON COLUMN s_it.t_interface.cv_url_request IS 'Ссылка для получения данных';
COMMENT ON COLUMN s_it.t_interface.cv_url_response IS 'Ссылка для ответа';
COMMENT ON COLUMN s_it.t_interface.cv_description IS 'Описание интерфейса';
COMMENT ON COLUMN s_it.t_interface.ck_parent IS 'ИД связанного сервиса';
COMMENT ON TABLE s_it.t_interface  IS 'Интеграционный интерфейс';

CREATE TABLE s_it.t_json_tmp 
   (	
    fc_json TEXT, 
	ft_timestamp TIMESTAMP
   );


CREATE TABLE s_it.t_param 
   (
    ck_id bigint not null, 
	ck_interface varchar(20), 
	ck_d_param varchar(20), 
	cv_key varchar(500), 
	cv_value varchar(500), 
	cv_description varchar(500), 
	constraint cin_p_param primary key (ck_id), 
	constraint cin_r_param_1 foreign key (ck_d_param)
	  references s_it.t_d_param (ck_id), 
	constraint cin_r_param_2 foreign key (ck_interface)
	  references s_it.t_interface (ck_id)
   );

COMMENT ON COLUMN S_IT.T_PARAM.CK_ID IS 'ИД параметра';
COMMENT ON COLUMN S_IT.T_PARAM.CK_INTERFACE IS 'ИД интеграционного интерфейса';
COMMENT ON COLUMN S_IT.T_PARAM.CK_D_PARAM IS 'ИД типа параметра';
COMMENT ON COLUMN S_IT.T_PARAM.CV_KEY IS 'Ключ';
COMMENT ON COLUMN S_IT.T_PARAM.CV_VALUE IS 'Значение';
COMMENT ON COLUMN S_IT.T_PARAM.CV_DESCRIPTION IS 'Описание';
COMMENT ON TABLE S_IT.T_PARAM  IS 'Параметр интерфейса';

CREATE TABLE s_it.t_batch 
   (
    ck_id bigint not null, 
	ck_interface varchar(20), 
	ck_external varchar(500), 
	cd_external date, 
	cd_inserted date, 
	ck_d_status varchar(20) not null, 
	cb_data bytea, 
	cn_user bigint, 
	 constraint cin_p_batch primary key (ck_id),
	 constraint cin_r_batch_2 foreign key (ck_d_status)
	  references s_it.t_d_status (ck_id), 
	 constraint cin_r_batch_1 foreign key (ck_interface)
	  references s_it.t_interface (ck_id)
   );

COMMENT ON COLUMN S_IT.T_BATCH.CK_ID IS 'ИД набора данных';
COMMENT ON COLUMN S_IT.T_BATCH.CK_INTERFACE IS 'ИД интеграционного интерфейса';
COMMENT ON COLUMN S_IT.T_BATCH.CK_EXTERNAL IS 'Внешний ключ (значение)';
COMMENT ON COLUMN S_IT.T_BATCH.CD_EXTERNAL IS 'Дата из внешней системы';
COMMENT ON COLUMN S_IT.T_BATCH.CD_INSERTED IS 'Дата вставки';
COMMENT ON COLUMN S_IT.T_BATCH.CK_D_STATUS IS 'ИД статуса обработки';
COMMENT ON COLUMN S_IT.T_BATCH.CB_DATA IS 'Данные';
COMMENT ON TABLE S_IT.T_BATCH  IS 'Набор данных';

CREATE TABLE s_it.t_item 
   (
    ck_id bigint not null, 
	ck_batch bigint, 
	ck_interface varchar(20), 
	ck_external varchar(500), 
	cd_external date, 
	ck_d_status varchar(20) not null, 
	cv_action varchar(20), 
	ck_internal varchar(32), 
	cv_hash varchar(4000), 
	cv_data varchar(32657), 
	cv_key varchar(100), 
	ck_parent bigint, 
	 constraint cin_p_item primary key (ck_id), 
	 constraint cin_r_item_3 foreign key (ck_interface)
	  references s_it.t_interface (ck_id), 
	 constraint cin_r_item_1 foreign key (ck_batch)
	  references s_it.t_batch (ck_id), 
	 constraint cin_r_item_4 foreign key (ck_parent)
	  references s_it.t_item (ck_id), 
	 constraint cin_r_item_2 foreign key (ck_d_status)
	  references s_it.t_d_status (ck_id)
   );

COMMENT ON COLUMN S_IT.T_ITEM.CK_ID IS 'ИД элемента данных';
COMMENT ON COLUMN S_IT.T_ITEM.CK_BATCH IS 'ИД набора данных';
COMMENT ON COLUMN S_IT.T_ITEM.CK_INTERFACE IS 'ИД интеграционного интерфейса';
COMMENT ON COLUMN S_IT.T_ITEM.CK_EXTERNAL IS 'Внешний ключ (значение)';
COMMENT ON COLUMN S_IT.T_ITEM.CD_EXTERNAL IS 'Дата из внешней системы';
COMMENT ON COLUMN S_IT.T_ITEM.CK_D_STATUS IS 'ИД статуса обработки';
COMMENT ON COLUMN S_IT.T_ITEM.CV_ACTION IS 'Код действия (I/U/D/другое)';
COMMENT ON COLUMN S_IT.T_ITEM.CK_INTERNAL IS 'Внутренний ключ';
COMMENT ON COLUMN S_IT.T_ITEM.CV_HASH IS 'MD5 HASH значение данных';
COMMENT ON COLUMN S_IT.T_ITEM.CV_DATA IS 'Данные';
COMMENT ON TABLE S_IT.T_ITEM  IS 'Элемент данных';

CREATE TABLE s_it.t_item_result 
   (	
    ck_id bigint not null, 
	ck_batch bigint, 
	ck_item bigint, 
	cv_error varchar(500), 
	ct_change timestamp with time zone not null, 
	cl_type varchar(1), 
	 constraint cin_chk_item_result check (cl_type in ('m', 'e', 'w')), 
	 constraint cin_p_item_result primary key (ck_id), 
	 constraint cin_r_item_result_2 foreign key (ck_batch)
	  references s_it.t_batch (ck_id)
   );

COMMENT ON COLUMN S_IT.T_ITEM_RESULT.CK_ID IS 'ИД результата';
COMMENT ON COLUMN S_IT.T_ITEM_RESULT.CK_BATCH IS 'ИД набора данных';
COMMENT ON COLUMN S_IT.T_ITEM_RESULT.CK_ITEM IS 'ИД элемента данных';
COMMENT ON COLUMN S_IT.T_ITEM_RESULT.CV_ERROR IS 'Код ошибки';
COMMENT ON TABLE S_IT.T_ITEM_RESULT  IS 'Результат по элементу данных';
