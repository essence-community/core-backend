--liquibase formatted sql
--changeset artemov_i:pkg_report dbms:postgresql runOnChange:true splitStatements:false stripComments:false
DROP SCHEMA IF EXISTS pkg_report cascade;

CREATE SCHEMA pkg_report
    AUTHORIZATION ${user.update};


ALTER SCHEMA pkg_report OWNER TO ${user.update};

CREATE OR REPLACE FUNCTION pkg_report.p_modify_dynamic_report(
	pv_action character varying,
	pot_dynamic_report s_mt.t_dynamic_report,
	INOUT pot_query s_mt.t_query)
    RETURNS s_mt.t_query
    LANGUAGE 'plpgsql'
    SECURITY DEFINER 
    SET search_path=public, pkg, pkg_report, s_mt
AS $BODY$
declare
  -- переменные пакета
  i sessvarstr;
  u sessvarstr;
  d sessvarstr;
  gv_error sessvarstr;

  -- переменные функции
  pcur_query record;
begin
  -- инициализация/получение переменных пакета
  i = sessvarstr_declare('pkg', 'i', 'I');
  u = sessvarstr_declare('pkg', 'u', 'U');
  d = sessvarstr_declare('pkg', 'd', 'D');
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');
  if pv_action = d::varchar then
    /*Удаление*/
    delete from s_mt.t_dynamic_report where ck_query = pot_query.ck_id;
    delete from s_mt.t_query where ck_id = pot_query.ck_id;
  else
    -- Если не указано имя
    if pot_query.ck_id is null then
      perform pkg.p_set_error(69);
    end if;
    -- Если не указано описание
    if pot_query.cv_description is null then
      perform pkg.p_set_error(70);
    end if;
    -- Если не указано действие
    if pot_query.cn_action is null then
      perform pkg.p_set_error(72);
    end if;
    -- Проверка на импорт
    if pv_action = i::varchar then
      --Проверяем на уникальность имени
      for pcur_query in (select 1
                        from s_mt.t_query q
                       where q.ck_id = pot_query.ck_id) loop
        perform pkg.p_set_error(73, pot_query.ck_id);
      end loop;
      -- Если нет тела запроса то ошибка
      if nullif(trim(pot_query.cc_query), '') is null then
      	perform pkg.p_set_error(71);
      end if;
    else
      -- Если нет тела запроса используем раннее заведенное
      if nullif(trim(pot_query.cc_query), '') is null then
      	select q.cc_query
      	  into strict pot_query.cc_query
          from s_mt.t_query q
          where q.ck_id = pot_query.ck_id;
      end if;
    end if;
    -- Если ранее была ошибка выходим
    if nullif(gv_error::varchar, '') is not null then
       return;
    end if;
   
    if pv_action = i::varchar then
      insert into s_mt.t_query values (pot_query.*);
      insert into s_mt.t_dynamic_report values (pot_dynamic_report.*);
    elsif pv_action = u::varchar then
     update s_mt.t_query set
        (cv_description, cc_query, ck_user, ct_change, cn_action, ck_provider) = 
        row(pot_query.cv_description, pot_query.cc_query, pot_query.ck_user, pot_query.ct_change, pot_query.cn_action, pot_query.ck_provider)
      where ck_id = pot_query.ck_id;
     if not found then
        perform pkg.p_set_error(504);
     end if;
     update s_mt.t_dynamic_report set
        (ck_query, ck_page, ck_user, ct_change) = row(pot_dynamic_report.*)
      where ck_query = pot_query.ck_id;
      if not found then
        perform pkg.p_set_error(504);
      end if;
    end if;
  end if;
end;
$BODY$;

ALTER FUNCTION pkg_report.p_modify_dynamic_report(character varying, s_mt.t_dynamic_report, s_mt.t_query)
    OWNER TO ${user.update};

COMMENT ON FUNCTION pkg_report.p_modify_dynamic_report(character varying, s_mt.t_dynamic_report, s_mt.t_query)
    IS 'Добавление/Редактирование/Удаление запросов для универсальной печати';