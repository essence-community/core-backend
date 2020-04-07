--liquibase formatted sql
--changeset artemov_i:init_data dbms:postgresql splitStatements:false stripComments:false

INSERT INTO ${user.table}.T_D_INTERFACE (CK_ID,CV_DESCRIPTION,CK_USER,CT_CHANGE)
	VALUES ('auth','Авторизация','4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-04-01 10:35:32.765');
INSERT INTO ${user.table}.T_D_INTERFACE (CK_ID,CV_DESCRIPTION,CK_USER,CT_CHANGE)
	VALUES ('select','Выборка данных','4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-04-01 10:35:32.765');
INSERT INTO ${user.table}.T_D_INTERFACE (CK_ID,CV_DESCRIPTION,CK_USER,CT_CHANGE)
	VALUES ('dml','Модификация данных','4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-04-01 10:35:32.765');
INSERT INTO ${user.table}.T_D_INTERFACE (CK_ID,CV_DESCRIPTION,CK_USER,CT_CHANGE)
	VALUES ('upload','Загрузка данных','4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-04-01 10:35:32.765');
INSERT INTO ${user.table}.T_D_INTERFACE (CK_ID,CV_DESCRIPTION,CK_USER,CT_CHANGE)
	VALUES ('file','Вложение','4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-04-01 10:35:32.765');

INSERT INTO ${user.table}.T_D_PROVIDER (CK_ID,CV_DESCRIPTION,CK_USER,CT_CHANGE)
	VALUES ('bpmn_integration','Основная схема интеграции','4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-04-01 10:35:32.765');
INSERT INTO ${user.table}.T_D_PROVIDER (CK_ID,CV_DESCRIPTION,CK_USER,CT_CHANGE)
	VALUES ('authcore','Авторизация','4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-04-01 10:35:32.765');
