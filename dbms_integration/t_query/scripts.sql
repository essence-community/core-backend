--liquibase formatted sql
--changeset artemov_i:init_provider_integration dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_provider (ck_id, cv_name, ck_user, ct_change) VALUES('s_ic_adm', 'Интеграция управление', '-11', '2019-12-24T09:08:46.214+0300') on conflict (ck_id) do update set ck_id = excluded.ck_id, cv_name = excluded.cv_name, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
