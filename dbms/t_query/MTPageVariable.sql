--liquibase formatted sql
--changeset artemov_i:MTPageVariable.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTPageVariable', '/*MTPageVariable*/

select

  t.ck_id,

  t.ck_page,

  t.cv_name,

  t.cv_description,

  t.cv_path_set,

  t.cv_path_get,

  /* Поля аудита */

  t.ck_user,

  t.ct_change at time zone :sess_cv_timezone as ct_change

from (select v.ck_id,

             v.ck_page,

             v.cv_name,

             v.cv_description,

            -- TO DO переделать cv_path_set + cv_path_get на одно использование

             (select string_agg(

             (with recursive

              q as (select o2.cv_name as cv_name,

                           1 as lvl,

                           po2.ck_parent

                      from s_mt.t_page_object po2

                      join s_mt.t_object o2

                        on o2.ck_id = po2.ck_object

                     where po2.ck_id = poa.ck_page_object



                     union all



                    select o2.cv_name as cv_name,

                           q.lvl + 1 as lvl,

                           po2.ck_parent

                     from s_mt.t_page_object po2

                     join s_mt.t_object o2

                       on o2.ck_id = po2.ck_object

                     join q

                       on po2.ck_id = q.ck_parent

              )



              select string_agg(q.cv_name, E''\\'' order by q.lvl desc)

                from q

             ),

          ''; '' || chr(13) || '' ''

          order by poa.ck_id

        )

      from s_mt.t_page_object_attr poa

      join s_mt.t_page_object po

        on po.ck_id = poa.ck_page_object

      join s_mt.t_class_attr ca

        on ca.ck_id = poa.ck_class_attr

      join s_mt.t_object o

        on o.ck_id = po.ck_object

      where po.ck_page = (cast(:json as jsonb)->''master''->>''ck_id'')::varchar

        and poa.cv_value like ''%'' || v.cv_name || ''%''

        and ca.ck_attr in (''setglobal'')) as cv_path_set,

    (

      select

        string_agg((

            with recursive

              q as (select o2.cv_name as cv_name,

                           1 as lvl,

                           po2.ck_parent

                      from s_mt.t_page_object po2

                      join s_mt.t_object o2

                        on o2.ck_id = po2.ck_object

                     where po2.ck_id = poa.ck_page_object



                     union all



                    select o2.cv_name as cv_name,

                           q.lvl + 1 as lvl,

                           po2.ck_parent

                     from s_mt.t_page_object po2

                     join s_mt.t_object o2

                       on o2.ck_id = po2.ck_object

                     join q

                       on po2.ck_id = q.ck_parent

              )



              select

                string_agg(q.cv_name, E''\\'' order by q.lvl desc)

              from q

          ),

          ''; '' || chr(13) || '' ''

          order by poa.ck_id

        )

      from s_mt.t_page_object_attr poa

      join s_mt.t_page_object po

        on po.ck_id = poa.ck_page_object

      join s_mt.t_class_attr ca

        on ca.ck_id = poa.ck_class_attr

      join s_mt.t_object o

        on o.ck_id = po.ck_object

      where po.ck_page = (cast(:json as jsonb)->''master''->>''ck_id'')::varchar

       and poa.cv_value like ''%'' || v.cv_name || ''%''

       and ca.ck_attr in (''getglobal'',

                          ''getglobaltostore'',

                          ''hiddenrules'',

                          ''disabledrules'',

                          ''columnsfilter'',

                          ''readonlyrules'',

                          ''requiredrules'')) as cv_path_get,

    v.ck_user,

    v.ct_change

  from s_mt.t_page_variable v

  where v.ck_page = (cast(:json as jsonb)->''master''->>''ck_id'')::varchar

) t

where ( &FILTER )

/*##filter.ck_id*/and t.ck_id = :json::json#>>''{filter,ck_id}''/*filter.ck_id##*/

order by &SORT

  ', 'meta', '20783', '2019-05-31 11:47:23.81503+03', 'select', 'po_session', NULL, 'Необходимо актуализировать')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

