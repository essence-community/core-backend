--liquibase formatted sql
--changeset artemov_i:convert_column_cl_delete_to_integer dbms:postgresql splitStatements:false stripComments:false
--comment: Конвертируем столбец cl_delete из boolean в integer
ALTER TABLE ${user.table}.t_session ALTER COLUMN cl_delete TYPE integer USING cl_delete::integer;
--rollback ALTER TABLE ${user.table}.t_session ALTER COLUMN cl_delete TYPE boolean USING cl_delete::boolean;