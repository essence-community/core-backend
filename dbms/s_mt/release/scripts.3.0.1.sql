--liquibase formatted sql
--changeset artemov_i:added_localization_attr dbms:postgresql splitStatements:false stripComments:false
INSERT INTO s_mt.t_localization
(ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)
VALUES('e42dc0232bf04b6d93283bf631671722', 'ru_RU', 'static', 'Запрещается использовать спец символы /.\!-#%?&^()[];:"''+*`~', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2023-03-22 11:25:18.761') on conflict on constraint cin_u_localization_1 DO NOTHING;
