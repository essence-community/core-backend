--liquibase formatted sql
--changeset artemov_i:MTPage.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTPage', '/*MTPage*/
with recursive
    temp_page_search as (
      select distinct t.* from (
        select
          false as filter,
          p.ck_id,
          p.ck_parent
        from s_mt.t_page p
        where p.ck_parent is null
        /*##filter.cv_name*/ and false/*filter.cv_name##*/
        /*##filter.ck_view*/ and false/*filter.ck_view##*/
        /*##filter.jl_filter.0*/ and false/*filter.jl_filter.0##*/
        union all
        select
          true as filter,
          p.ck_id,
          p.ck_parent
        from s_mt.t_page p
        join s_mt.t_localization l
        on p.cv_name = l.ck_id and l.ck_d_lang = :json::jsonb#>>''{filter,g_sys_lang}''
        where 
        ( false
          /*##filter.cv_name*/ or true/*filter.cv_name##*/
          /*##filter.ck_view*/ or true/*filter.ck_view##*/
          /*##filter.jl_filter.0*/ or true/*filter.jl_filter.0##*/
        )
        /*##filter.cv_name*/and UPPER(l.cv_value) like ''%'' || UPPER(:json::jsonb#>>''{filter,cv_name}'') || ''%''/*filter.cv_name##*/
        /*##filter.ck_view*/and p.ck_view = :json::jsonb#>>''{filter,ck_view}''/*filter.ck_view##*/   
        /*##filter.jl_filter.0*/
          and p.ck_id in (
            select
                t_p.ck_id
              from (
                select
                  q.ck_id,
                  q.ck_parent,
                  q.cr_type,
                  l.cv_value as cv_name,
                  q.cn_order,
                  q.cl_menu,
                  q.cl_static,
                  q.cv_url,
                  q.ck_icon,
                  q.cv_redirect_url,
                  q.cl_multi,
                  q.ck_view,
                  q.ck_user,
                  q.ct_change,
                  i.cv_name as cv_icon_name,
                  i.cv_name as cv_icon_name,
                  i.cv_font as cv_icon_font,
                  case
                      when not exists(SELECT 1 FROM s_mt.t_page m WHERE m.ck_parent = q.ck_id) then ''true''
                      else ''false''
                  end as leaf,
                  pa_view.cn_action as cn_action_view,
                  pa_edit.cn_action as cn_action_edit,
                  tv.cv_description as cv_view_description
                from s_mt.t_page q
                join s_mt.t_localization l
                    on q.cv_name = l.ck_id and l.ck_d_lang = :json::jsonb#>>''{filter,g_sys_lang}''
                left join s_mt.t_icon i on i.ck_id = q.ck_icon
                left join s_mt.t_page_action pa_view on q.cr_type = 2 and pa_view.ck_page = q.ck_id and pa_view.cr_type = ''view''
                left join s_mt.t_page_action pa_edit on q.cr_type = 2 and pa_edit.ck_page = q.ck_id and pa_edit.cr_type = ''edit''
                join s_mt.t_view tv on
                tv.ck_id = q.ck_view
              ) t_p
              where &FILTER
          )
        /*filter.jl_filter.0##*/
      ) as t
    ),
    temp_page_down as (
      select
        p.ck_id,
        p.ck_parent
      from s_mt.t_page p
      where p.ck_id in (select t_p.ck_id from temp_page_search t_p where t_p.ck_parent is null or t_p.ck_parent not in (select ck_id from temp_page_search))
      union all
      select
        p.ck_id,
        p.ck_parent
      from s_mt.t_page p
      join temp_page_down q on
        p.ck_parent = q.ck_id
    ),
    temp_page_up as (
      select
        p.ck_id,
        p.ck_parent
      from s_mt.t_page p
      where p.ck_id in (select t_p.ck_parent from temp_page_search t_p where t_p.ck_parent is not null and t_p.ck_parent not in (select ck_id from temp_page_search))
      union all
      select
        p.ck_id,
        p.ck_parent
      from s_mt.t_page p
      join temp_page_up q on
        p.ck_id = q.ck_parent
    ),
    temp_page as (
      select distinct p.ck_id, p.ck_parent from temp_page_up p
      union all
      select distinct p.ck_id, p.ck_parent from temp_page_down p
    )
select
  t.ck_id,
  t.ck_parent,
  t.cr_type,
  t.cv_name,
  t.cn_order,
  t.cl_menu,
  t.cl_static,
  t.cv_url,
  t.ck_icon,
  t.cv_icon_name,
  t.cv_icon_font,
  t.cv_redirect_url,
  t.cl_multi,
  t.leaf,
  t.expanded,
  t.cn_action_view,
  t.cn_action_edit,
  t.ck_view,
  t.cv_view_description,
  /* Поля аудита */
  t.ck_user,
  t.ct_change at time zone :sess_cv_timezone as ct_change
from(
    select
      q.ck_id,
      q.ck_parent,
      q.cr_type,
      q.cv_name,
      q.cn_order,
      q.cl_menu,
      q.cl_static,
      q.cv_url,
      q.ck_icon,
      i.cv_name as cv_icon_name,
      i.cv_font as cv_icon_font,
      q.cv_redirect_url,
      q.cl_multi,
      case
          when not exists(SELECT 1 FROM temp_page m WHERE m.ck_parent = q.ck_id) then ''true''
          else ''false''
      end as leaf,
      case when exists(SELECT 1 FROM temp_page_up m WHERE m.ck_id = q.ck_id) then true
                else NULL::boolean
         end as expanded,
      pa_view.cn_action as cn_action_view,
      pa_edit.cn_action as cn_action_edit,
      q.ck_view,
      tv.cv_description as cv_view_description,
      q.ck_user,
      q.ct_change
    from s_mt.t_page q
    left join s_mt.t_icon i on i.ck_id = q.ck_icon
    left join s_mt.t_page_action pa_view on q.cr_type = 2 and pa_view.ck_page = q.ck_id and pa_view.cr_type = ''view''
    left join s_mt.t_page_action pa_edit on q.cr_type = 2 and pa_edit.ck_page = q.ck_id and pa_edit.cr_type = ''edit''
    join s_mt.t_view tv on
    tv.ck_id = q.ck_view
    where true
    and q.ck_id in (select tp.ck_id from temp_page tp)
    /*##filter.ck_id*/ and q.ck_id = (:json::jsonb#>>''{filter,ck_id}'')/*filter.ck_id##*/
    order by &SORT, q.cn_order asc
)t
  ', 'meta', '20783', '2019-05-22 15:37:52.224362+03', 'select', 'po_session', NULL, 'Список страниц/приложений')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;

