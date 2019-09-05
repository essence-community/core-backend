--liquibase formatted sql
--changeset artemov_i:MTRoute.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTRoute', '/*MTRoute*/

with recursive

  t1(ck_id,

     ck_parent,

     cr_type,

     cv_name,

     cn_order,

     cl_static,

     cv_url,

     ck_icon,

     cl_menu) as

(/* сначала выберем все страницы, к которым есть доступ у пользователя, и которые должны быть видны в меню */

    select p.ck_id,

           p.ck_parent,

           p.cr_type,

           p.cv_name,

           p.cn_order,

           p.cl_static,

           p.cv_url,

           p.ck_icon,

           p.cl_menu

    from s_mt.t_page p

    join s_mt.t_page_action pa on pa.ck_page = p.ck_id

    join tt_user_action ua on ua.cn_action = pa.cn_action

    where p.cr_type = 2

    and p.cl_menu = 1

    and pa.cr_type = ''view''

    and ua.ck_user = :sess_ck_id

    and (&FILTER)



    union all



    /* выберем их парентов в рекурсивном запросе */

    select s.ck_id,

           s.ck_parent,

           s.cr_type,

           s.cv_name,

           s.cn_order,

           s.cl_static,

           s.cv_url,

           s.ck_icon,

           s.cl_menu

      from t1

      join s_mt.t_page s on t1.ck_parent = s.ck_id),



  t2 as(select distinct ck_id,

                        ck_parent,

                        cr_type,

                        cv_name,

                        cn_order,

                        cl_static,

                        cv_url,

                        ck_icon,

                        cl_menu

                   from t1),



  t3 as (select jsonb_build_object(''ck_id'', t2.ck_id,

                                   ''ck_parent'', t2.ck_parent,

                                   ''cr_type'', t2.cr_type,

                                   ''cv_name'', t2.cv_name,

                                   ''cn_order'', t2.cn_order,

                                   ''cl_static'', t2.cl_static,

                                   ''cv_url'', t2.cv_url,

                                   ''ck_icon'', t2.ck_icon,

                                   ''cv_icon_name'', i.cv_icon_name,

                                   ''cv_icon_font'', i.cv_icon_font,

                                   ''leaf'', case when not exists(SELECT 1 FROM t2 m WHERE m.ck_parent = t2.ck_id) then ''true'' else ''false'' end,

                                   ''root'', t2.cv_name,

                                   ''cn_action_edit'', pa_edit.cn_action,

                                   ''cl_menu'', t2.cl_menu) as json,

    array[t2.cn_order] as sort

    from t2

    left join(select ck_id as ck_icon_id,

                     cv_name as cv_icon_name,

                     cv_font as cv_icon_font

                from s_mt.t_icon) i on i.ck_icon_id = t2.ck_icon

    left join s_mt.t_page_action pa_edit on t2.cr_type = 2 and pa_edit.ck_page = t2.ck_id and pa_edit.cr_type = ''edit''

    where t2.ck_parent is null



    union all



    select jsonb_build_object(''ck_id'', t2.ck_id,

                              ''ck_parent'', t2.ck_parent,

                              ''cr_type'', t2.cr_type,

                              ''cv_name'', t2.cv_name,

                              ''cn_order'', t2.cn_order,

                              ''cl_static'', t2.cl_static,

                              ''cv_url'', t2.cv_url,

                              ''ck_icon'', t2.ck_icon,

                              ''cv_icon_name'', i.cv_icon_name,

                              ''cv_icon_font'', i.cv_icon_font,

                              ''leaf'', case when not exists(SELECT 1 FROM t2 m WHERE m.ck_parent = t2.ck_id) then ''true'' else ''false'' end,

                              ''root'', (t3.json->>''root''),

                              ''cn_action_edit'', pa_edit.cn_action,

                              ''cl_menu'', t2.cl_menu) as json,

      (t3.sort || t2.cn_order) as sort

    from t2

    left join(select ck_id as ck_icon_id,

                     cv_name as cv_icon_name,

                     cv_font as cv_icon_font

                from s_mt.t_icon) i on i.ck_icon_id = t2.ck_icon

    left join s_mt.t_page_action pa_edit on t2.cr_type = 2 and pa_edit.ck_page = t2.ck_id and pa_edit.cr_type = ''edit''

    join t3 on

      t2.ck_parent = (t3.json->>''ck_id'')::varchar

  )



  select t3.json

    from t3

   order by t3.sort

  ', 'meta', '20783', '2019-05-30 09:18:27.503811+03', 'select', 'session', NULL, 'Необходимо актуализировать')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

