--liquibase formatted sql
--changeset artemov_i:MTObject.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTObject', '/*MTObject*/
with recursive
  temp_object_find as (
     select distinct t.* from (
        select
          false as filter,
          o.ck_id,
          o.ck_parent
        from s_mt.t_object o
        join s_mt.t_class c on c.ck_id = o.ck_class
        where (c.ck_view = :json::json#>>''{filter,ck_view}'' or c.ck_view = ''system'')
        and
        o.ck_parent is null
        /*##filter.cv_name*/ and false/*filter.cv_name##*/
        /*##filter.ck_page*/ and false/*filter.ck_page##*/
        /*##filter.jl_filter.0*/ and false/*filter.jl_filter.0##*/
        union all
        select
          true as filter,
          o.ck_id,
          o.ck_parent
        from s_mt.t_object o
        join s_mt.t_class c on c.ck_id = o.ck_class
        where (c.ck_view = :json::json#>>''{filter,ck_view}'' or c.ck_view = ''system'') and
        ( false
          /*##filter.cv_name*/ or true/*filter.cv_name##*/
          /*##filter.ck_page*/ or true/*filter.ck_page##*/
          /*##filter.jl_filter.0*/ or true/*filter.jl_filter.0##*/
        )
        /*##filter.cv_name*/ and UPPER(o.cv_name) like ''%'' || UPPER(:json::json#>>''{filter,cv_name}'') || ''%''/*filter.cv_name##*/
        /*##filter.ck_page*/ and exists(select 1
                                     from s_mt.t_page_object po
                                    where po.ck_object = o.ck_id
                                      and po.ck_page = (:json::json#>>''{filter,ck_page}'')::varchar)/*filter.ck_page##*/
        /*##filter.jl_filter.0*/
        and o.ck_id in (
          select t_o_a.ck_id from (
               select q.ck_id,
                    q.ck_class,
                    q.ck_parent,
                    q.cv_name,
                    l.cv_value as cv_displayed,
                    q.cn_order,
                    q.ck_query,
                    q.cv_description,
                    q.ck_provider,
                    q.cv_modify,
                    lower(q.cv_name) as cv_name_lowered,
                    c.cv_name as cv_class_name,
                    p_out.cv_pages,
                    /* Поля аудита */
                    q.ck_user,
                    q.ct_change
               from s_mt.t_object q
               left join s_mt.t_localization l
                    on q.cv_displayed = l.ck_id and l.ck_d_lang = :json::jsonb#>>''{filter,g_sys_lang}''
               -- получим классы объектов
               join s_mt.t_class c on c.ck_id = q.ck_class
               -- получим страницы, где используются объекты (если таковые имеются)
               left join (select po.ck_object,
                                   string_agg(''$t('' || p.cv_name || '')'', '', '' order by p.cv_name) as cv_pages
                              from s_mt.t_page_object po
                              join s_mt.t_page p
                              on p.ck_id = po.ck_page
                              group by po.ck_object) p_out on p_out.ck_object = q.ck_id
               where (c.ck_view = :json::json#>>''{filter,ck_view}'' or c.ck_view = ''system'')
          ) as t_o_a
          where &FILTER
        )
        /*filter.jl_filter.0##*/
     ) as t
  ),
  temp_object_down as (
    select o.*,
           NULL::boolean as expanded
    from s_mt.t_object o
    where o.ck_id in (select t_o.ck_id from temp_object_find t_o where t_o.ck_parent is null or t_o.ck_parent not in (select ck_id from temp_object_find))
    union all
    select o.*,
           NULL::boolean as expanded
    from s_mt.t_object o 
    join temp_object_down q on o.ck_parent = q.ck_id
  ),
  temp_object_up as (
      select
        o.*,
        true as expanded
      from s_mt.t_object o
      where o.ck_id in (select t_o.ck_parent from temp_object_find t_o where t_o.ck_parent is not null and t_o.ck_parent not in (select ck_id from temp_object_find))
      union all
      select
        o.*,
        true as expanded
      from s_mt.t_object o
      join temp_object_up q on
        o.ck_id = q.ck_parent
    ),
  temp_object as (
     select distinct o.* from temp_object_up o
     union all
     select o.* from temp_object_down o
  )
  select q.ck_id,
         q.ck_class,
         q.ck_parent,
         q.cv_name,
         q.cv_displayed,
         q.cn_order,
         q.ck_query,
         q.cv_description,
         q.ck_provider,
         q.cv_modify,
         lower(q.cv_name) as cv_name_lowered,
         c.cv_name as cv_class_name,
         p_out.cv_pages,
         case when not exists(SELECT 1 FROM temp_object m WHERE m.ck_parent = q.ck_id) then ''true''
                else ''false''
         end as leaf,
         /* Поля аудита */
         q.ck_user,
         q.ct_change at time zone :sess_cv_timezone as ct_change
    from temp_object q
    -- получим классы объектов
    join s_mt.t_class c on c.ck_id = q.ck_class
    -- получим страницы, где используются объекты (если таковые имеются)
    left join (select po.ck_object,
                      string_agg(''$t('' || p.cv_name || '')'', '', '' order by p.cv_name) as cv_pages
                 from s_mt.t_page_object po
                 join s_mt.t_page p
                   on p.ck_id = po.ck_page
                group by po.ck_object) p_out on p_out.ck_object = q.ck_id
   order by &SORT
   ', 'meta', '20783', '2019-05-30 15:22:49.352201+03', 'select', 'po_session', NULL, 'Список объектов')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;

