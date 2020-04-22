--liquibase formatted sql
--changeset artemov_i:grants dbms:oracle runAlways:true runOnChange:true endDelimiter:/ splitStatements:true stripComments:false
--даем все права на чтение таблиц схеме клиента
declare
  pv_from varchar2(32) := '${user.table}';
  pv_to   varchar2(32) := '${user.connect}';
begin
  for pcur_data in (select table_name from all_tables where owner = pv_from) loop
    execute immediate 'GRANT SELECT ON ' || pv_from || '.' ||
                      pcur_data.table_name || ' TO ' || pv_to;
    begin
      execute immediate 'DROP SYNONYM ' || pv_to || '.' || pcur_data.table_name ||
                        ' FORCE';
    exception
      when others then
        null;
    end;
    begin
    execute immediate 'CREATE SYNONYM ' || pv_to || '.' || pcur_data.table_name ||
                      ' FOR ' || pv_from || '.' || pcur_data.table_name;
    exception
      when others then
        null;
    end;
  end loop;
end;
/

--даем права на вызов методов сохранения схеме клиента
declare
  pv_from varchar2(32) := '${user.update}';
  pv_to   varchar2(32) := '${user.connect}';
begin
  for pcur_data in (select a.object_name
                      from all_objects a
                     where a.object_type = 'PACKAGE'
                       and a.object_name like 'PKG_JSON%'
                       and a.owner = pv_from) loop
    execute immediate 'GRANT EXECUTE ON ' || pv_from || '.' ||
                      pcur_data.object_name || ' TO ' || pv_to;
  
    begin
      execute immediate 'DROP SYNONYM ' || pv_to || '.' ||
                        pcur_data.object_name || ' FORCE';
    exception
      when others then
        null;
    end;
  
    execute immediate 'CREATE SYNONYM ' || pv_to || '.' ||
                      pcur_data.object_name || ' FOR ' || pv_from || '.' ||
                      pcur_data.object_name;
  
  end loop;
end;
/

--даем все права на чтение таблиц схеме пакетов
declare
  pv_from varchar2(32) := '${user.table}';
  pv_to   varchar2(32) := '${user.update}';
begin
  for pcur_data in (select table_name from all_tables where owner = pv_from) loop
    execute immediate 'GRANT SELECT,INSERT,UPDATE,DELETE ON ' || pv_from || '.' ||
                      pcur_data.table_name || ' TO ' || pv_to;
    begin
      execute immediate 'DROP SYNONYM ' || pv_to || '.' || pcur_data.table_name ||
                        ' FORCE';
    exception
      when others then
        null;
    end;
    execute immediate 'CREATE SYNONYM ' || pv_to || '.' || pcur_data.table_name ||
                      ' FOR ' || pv_from || '.' || pcur_data.table_name;
  end loop;
end;
/