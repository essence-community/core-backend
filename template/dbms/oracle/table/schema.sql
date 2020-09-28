--liquibase formatted sql
--changeset artemov_i:init_schema_default dbms:oracle splitStatements:true stripComments:false
CREATE TABLE ${user.table}."T_LOG" 
   (
    "CK_ID" NUMBER NOT NULL ENABLE, 
	"CV_SESSION" VARCHAR2(100 CHAR), 
	"CC_JSON" CLOB, 
	"CV_TABLE" VARCHAR2(4000 CHAR), 
	"CV_ID" VARCHAR2(4000 CHAR), 
	"CV_ACTION" VARCHAR2(30 CHAR), 
	"CV_ERROR" VARCHAR2(4000 CHAR), 
	"CK_USER" VARCHAR2(150 CHAR) NOT NULL ENABLE, 
	"CT_CHANGE" TIMESTAMP (6) WITH TIME ZONE NOT NULL ENABLE, 
	 CONSTRAINT "CIN_P_LOG" PRIMARY KEY ("CK_ID")
  USING INDEX  ENABLE
   ) rowdependencies;

COMMENT ON COLUMN ${user.table}."T_LOG"."CK_ID" IS 'ИД записи лога';
COMMENT ON COLUMN ${user.table}."T_LOG"."CV_SESSION" IS 'ИД сессии';
COMMENT ON COLUMN ${user.table}."T_LOG"."CC_JSON" IS 'JSON';
COMMENT ON COLUMN ${user.table}."T_LOG"."CV_TABLE" IS 'Имя таблицы';
COMMENT ON COLUMN ${user.table}."T_LOG"."CV_ID" IS 'ИД записи в таблице';
COMMENT ON COLUMN ${user.table}."T_LOG"."CV_ACTION" IS 'ИД действия';
COMMENT ON COLUMN ${user.table}."T_LOG"."CV_ERROR" IS 'Код ошибки';
COMMENT ON COLUMN ${user.table}."T_LOG"."CK_USER" IS 'ИД пользователя';
COMMENT ON COLUMN ${user.table}."T_LOG"."CT_CHANGE" IS 'Дата последнего изменения';
COMMENT ON TABLE ${user.table}."T_LOG"  IS 'Лог';

CREATE GLOBAL TEMPORARY TABLE ${user.table}."TT_USER" 
   (	
    "CK_ID" VARCHAR2(150 CHAR) NOT NULL ENABLE,
    "CCT_DATA" CLOB,  
	"CV_LOGIN" VARCHAR2(30 CHAR) NOT NULL ENABLE,
	"CV_SURNAME" VARCHAR2(30 CHAR), 
	"CV_NAME" VARCHAR2(30 CHAR), 
	"CV_PATRONYMIC" VARCHAR2(30 CHAR), 
	"CV_EMAIL" VARCHAR2(150 CHAR),
	 CONSTRAINT "CIN_P_USER" PRIMARY KEY ("CK_ID") ENABLE
   ) ON COMMIT PRESERVE ROWS ;

COMMENT ON COLUMN ${user.table}."TT_USER"."CK_ID" IS 'ИД пользователя, acc_user.acc_id_usr';
COMMENT ON COLUMN ${user.table}."TT_USER"."CCT_DATA" IS 'Вся информация о пользователе';
COMMENT ON COLUMN ${user.table}."TT_USER"."CV_LOGIN" IS 'Логин из acc_user.nm_usr';
COMMENT ON COLUMN ${user.table}."TT_USER"."CV_SURNAME" IS 'Фамилия из acc_user.nm_last';
COMMENT ON COLUMN ${user.table}."TT_USER"."CV_NAME" IS 'Имя из acc_user.nm_first';
COMMENT ON COLUMN ${user.table}."TT_USER"."CV_PATRONYMIC" IS 'Отчество из acc_user.nm_middle';
COMMENT ON COLUMN ${user.table}."TT_USER"."CV_EMAIL" IS 'Email из acc_user.nm_email';
COMMENT ON TABLE ${user.table}."TT_USER"  IS 'Пользователь, данные берутся из СУВК';

CREATE GLOBAL TEMPORARY TABLE ${user.table}."TT_USER_ACTION" 
   (
    "CK_USER" VARCHAR2(150 CHAR) NOT NULL ENABLE, 
	"CN_ACTION" NUMBER NOT NULL ENABLE, 
	 CONSTRAINT "CIN_U_USER_ACTION_1" UNIQUE ("CK_USER", "CN_ACTION") ENABLE
   ) ON COMMIT PRESERVE ROWS ;

COMMENT ON COLUMN ${user.table}."TT_USER_ACTION"."CK_USER" IS 'ИД пользователя, acc_user.acc_id_usr';
COMMENT ON COLUMN ${user.table}."TT_USER_ACTION"."CN_ACTION" IS 'Код действия из СУВК';
COMMENT ON TABLE ${user.table}."TT_USER_ACTION"  IS 'Действия, доступные пользователю';
CREATE INDEX ${user.table}."CIN_R_USER_ACTION_1" ON ${user.table}."TT_USER_ACTION" ("CK_USER");

CREATE GLOBAL TEMPORARY TABLE ${user.table}."TT_USER_DEPARTMENT" 
   (
    "CK_USER" VARCHAR2(150 CHAR) NOT NULL ENABLE, 
	"CK_DEPARTMENT" NUMBER NOT NULL ENABLE, 
	 CONSTRAINT "CIN_U_USER_DEPARTMENT_1" UNIQUE ("CK_USER", "CK_DEPARTMENT") ENABLE
   ) ON COMMIT PRESERVE ROWS ;

COMMENT ON COLUMN ${user.table}."TT_USER_DEPARTMENT"."CK_USER" IS 'ИД пользователя, acc_user.acc_id_usr';
COMMENT ON COLUMN ${user.table}."TT_USER_DEPARTMENT"."CK_DEPARTMENT" IS 'ИД поразделения';
COMMENT ON TABLE ${user.table}."TT_USER_DEPARTMENT"  IS 'Подразделения пользователя';
CREATE INDEX ${user.table}."CIN_R_USER_DEPARTMENT_1" ON ${user.table}."TT_USER_DEPARTMENT" ("CK_DEPARTMENT") ;
CREATE INDEX ${user.table}."CIN_R_USER_DEPARTMENT_2" ON ${user.table}."TT_USER_DEPARTMENT" ("CK_USER") ;

