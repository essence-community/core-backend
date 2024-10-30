--liquibase formatted sql
--changeset artemov_i:UPDEV-7290 dbms:postgresql splitStatements:false stripComments:false
INSERT INTO s_mt.t_sys_setting
(ck_id, cv_value, ck_user, ct_change, cv_description)
VALUES('grid_to_excel_plugin', 'PrintJasperServer', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2024-10-30 13:05:06.971', 'Имя плагина используемое для печати таблиц в excel')
on conflict (ck_id) DO NOTHING;
