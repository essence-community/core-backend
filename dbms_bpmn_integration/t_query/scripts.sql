--liquibase formatted sql
--changeset artemov_i:init_provider_bpmn_integration dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_provider (ck_id, cv_name, ck_user, ct_change) VALUES('s_ibc_adm', 'Интеграция BPMN управление', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-04-01T09:08:46.214+0300') on conflict (ck_id) do update set ck_id = excluded.ck_id, cv_name = excluded.cv_name, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
