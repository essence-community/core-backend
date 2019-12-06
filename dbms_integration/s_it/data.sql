--liquibase formatted sql
--changeset artemov_i:init_data dbms:postgresql splitStatements:false stripComments:false

INSERT INTO S_IT.T_D_INTERFACE (CK_ID,CV_DESCRIPTION)
	VALUES ('auth','Авторизация');
INSERT INTO S_IT.T_D_INTERFACE (CK_ID,CV_DESCRIPTION)
	VALUES ('select','Выборка данных');
INSERT INTO S_IT.T_D_INTERFACE (CK_ID,CV_DESCRIPTION)
	VALUES ('dml','Модификация данных');
INSERT INTO S_IT.T_D_INTERFACE (CK_ID,CV_DESCRIPTION)
	VALUES ('upload','Загрузка данных');
INSERT INTO S_IT.T_D_INTERFACE (CK_ID,CV_DESCRIPTION)
	VALUES ('file','Вложение');

INSERT INTO S_IT.T_D_PARAM (CK_ID)
	VALUES ('header');
INSERT INTO S_IT.T_D_PARAM (CK_ID)
	VALUES ('get');
INSERT INTO S_IT.T_D_PARAM (CK_ID)
	VALUES ('body');
INSERT INTO S_IT.T_D_PARAM (CK_ID)
	VALUES ('path');

INSERT INTO S_IT.T_D_PROVIDER (CK_ID,CV_DESCRIPTION)
	VALUES ('s_ic','Основная схема интеграции');
INSERT INTO S_IT.T_D_PROVIDER (CK_ID,CV_DESCRIPTION)
	VALUES ('auth','Авторизация');

INSERT INTO S_IT.T_D_STATUS (CK_ID,CV_DESCRIPTION)
	VALUES ('created','Создан/принят');
INSERT INTO S_IT.T_D_STATUS (CK_ID,CV_DESCRIPTION)
	VALUES ('processing','В работе в настоящий момент времени');
INSERT INTO S_IT.T_D_STATUS (CK_ID,CV_DESCRIPTION)
	VALUES ('failed','Произошла критическая ошибка');
INSERT INTO S_IT.T_D_STATUS (CK_ID,CV_DESCRIPTION)
	VALUES ('finished','Обработано');
INSERT INTO S_IT.T_D_STATUS (CK_ID,CV_DESCRIPTION)
	VALUES ('finished_with_error','Обработано с ошибками');
INSERT INTO S_IT.T_D_STATUS (CK_ID,CV_DESCRIPTION)
	VALUES ('responded','Ответ отправлен');