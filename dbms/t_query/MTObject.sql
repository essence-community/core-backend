--liquibase formatted sql
--changeset artemov_i:MTObject.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTObject', '/*MTObject*/
with recursive
  q as (select array[o.cn_order] as sort,
               o.ck_id,
               o.ck_class,
               o.ck_parent,
               o.cv_name,
               o.cv_displayed,
               o.cn_order,
               o.ck_query,
               o.cv_description,
               o.ck_provider,
               o.cv_modify,
               o.cv_name_lowered,
               c.cv_class_name,
               p_out.cv_pages,
               case when not exists(SELECT 1 FROM s_mt.t_object m WHERE m.ck_parent = o.ck_id) then ''true''
                    else ''false''
               end as leaf,
               /* Поля аудита */
               o.ck_user,
               o.ct_change at time zone :sess_cv_timezone as ct_change
    from (select o_inn.*,
                 lower(o_inn.cv_name) as cv_name_lowered
            from s_mt.t_object o_inn) o
    -- получим классы объектов
    join (select ck_id as ck_class,
                 cv_name as cv_class_name,
                 ck_view
            from s_mt.t_class) c on c.ck_class = o.ck_class
    -- получим страницы, где используются объекты (если таковые имеются)
    left join (select po.ck_object,
                      string_agg(''$t('' || p.cv_name || '')'', '', '' order by p.cv_name) as cv_pages
                 from s_mt.t_page_object po
                 join s_mt.t_page p
                   on p.ck_id = po.ck_page
                group by po.ck_object) p_out on p_out.ck_object = o.ck_id
                where o.ck_parent is null
                and (c.ck_view = :json::json#>>''{filter,ck_view}'' or c.ck_view = ''system'')
    /* Поиск по наименованию работает только по объектам верхнего уровня */
    /*##filter.cv_name*/and lower(o.cv_name) like ''%'' || lower(:json::json#>>''{filter,cv_name}'') || ''%''/*filter.cv_name##*/
    /*##filter.ck_page*/and exists(select 1
                                     from s_mt.t_page_object po
                                    where po.ck_object = o.ck_id
                                      and po.ck_page = (:json::json#>>''{filter,ck_page}'')::varchar)/*filter.ck_page##*/

    union all
    select q.sort || o.cn_order as sort,
           o.ck_id,
           o.ck_class,
           o.ck_parent,
           o.cv_name,
           o.cv_displayed,
           o.cn_order,
           o.ck_query,
           o.cv_description,
           o.ck_provider,
           o.cv_modify,
           o.cv_name_lowered,
           c.cv_class_name,
           p_out.cv_pages,
           case when not exists(SELECT 1 FROM s_mt.t_object m WHERE m.ck_parent = o.ck_id) then ''true''
                else ''false''
           end as leaf,
           /* Поля аудита */
           o.ck_user,
           o.ct_change at time zone :sess_cv_timezone as ct_change
    from (select o_inn.*,
                 lower(o_inn.cv_name) as cv_name_lowered
            from s_mt.t_object o_inn) o
    -- получим классы объектов
    join (select ck_id as ck_class,
                 cv_name as cv_class_name
            from s_mt.t_class) c on c.ck_class = o.ck_class
    -- получим страницы, где используются объекты (если таковые имеются)
    left join (select po.ck_object,
                      string_agg(''$t('' || p.cv_name || '')'', '', '' order by p.cv_name) as cv_pages
                 from s_mt.t_page_object po
                 join s_mt.t_page p
                   on p.ck_id = po.ck_page
                group by po.ck_object) p_out on p_out.ck_object = o.ck_id
                 join q on o.ck_parent = q.ck_id
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
         q.cv_name_lowered,
         q.cv_class_name,
         q.cv_pages,
         q.leaf,
         /* Поля аудита */
         q.ck_user,
         q.ct_change
    from q
   order by &SORT, q.sort
   ', 'meta', '20783', '2019-05-30 15:22:49.352201+03', 'select', 'po_session', NULL, 'Список объектов')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;

