--liquibase formatted sql
--changeset artemov_i:MTQueryExtended.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTQueryExtended', '/*MTQueryExtended*/

select

  t.*

from (

select /* Информация о сервисах */

       q.ck_id,

       q.cr_type,

       q.cr_access,

       q.ck_provider,

       x.cv_used,

       /* Поля аудита */

       q.ck_user,

       q.ct_change at time zone :sess_cv_timezone as ct_change

  from s_mt.t_query q

  left join

  /* get pathes where queries are used */

  (with t_po as

    (with recursive q_core as

      (/* all PO + Objects */

        select po.ck_id,

               po.ck_parent,

               po.ck_page,

               o.ck_query,

               o.cv_name

          from s_mt.t_page_object po

          join s_mt.t_object o on po.ck_object = o.ck_id



          union all



          /* queries, that used as an attribute value at OA */

          select po.ck_id,

                 po.ck_parent,

                 po.ck_page,

                 oa.cv_value as ck_query,

                 o.cv_name

            from s_mt.t_query q

            join s_mt.t_object_attr oa on lower(trim(oa.cv_value)) = lower(trim(q.ck_id))

            join s_mt.t_object o on o.ck_id = oa.ck_object

            join s_mt.t_page_object po on po.ck_object = o.ck_id



          union all



          /* queries, that used as an attribute value at POA */

          select po.ck_id,

                 po.ck_parent,

                 po.ck_page,

                 poa.cv_value as ck_query,

                 o.cv_name

            from s_mt.t_query q

            join s_mt.t_page_object_attr poa on lower(trim(poa.cv_value)) = lower(trim(q.ck_id))

            join s_mt.t_page_object po on po.ck_id = poa.ck_page_object

            join s_mt.t_object o on o.ck_id = po.ck_object

          ),



          qq as(select q_core.ck_id,

                       q_core.ck_parent,

                       q_core.ck_page,

                       q_core.ck_query,

                       q_core.cv_name

                  from q_core

                 where q_core.ck_query is not null

            

                 union all

            

                select q_core.ck_id,

                       q_core.ck_parent,

                       q_core.ck_page,

                       q_core.ck_query,

                       q_core.cv_name

                  from q_core

                  join qq on qq.ck_parent = q_core.ck_id

        )

        

        select distinct qq.ck_id,

                        qq.ck_parent,

                        qq.ck_page,

                        qq.ck_query,

                        qq.cv_name 

          from qq

      ),



      rq as

      (with recursive sq as

        (select t_po.ck_query,

                p.cv_name,

                cast(t_po.cv_name as text) as connect_by_path,

                t_po.ck_parent,

                t_po.ck_page

           from t_po

           join s_mt.t_page p on p.ck_id = t_po.ck_page

          where t_po.ck_query is not null

            and t_po.ck_parent is null



          union all



         select t_po.ck_query,

                p.cv_name,

                sq.connect_by_path || E''\\'' || t_po.cv_name as connect_by_path,

                t_po.ck_id as ck_parent,

                t_po.ck_page

           from t_po

           join s_mt.t_page p on p.ck_id = t_po.ck_page

           join sq on t_po.ck_id = sq.ck_parent

          )



          select * from sq

      )



      select rq.ck_query,

             array_agg(rq.ck_page) as ck_pages,

             string_agg(rq.cv_name||'': ''|| substr(rq.connect_by_path, 1),

             ''<BR>'' || chr(13)) as cv_used

        from rq

       group by rq.ck_query



    ) x on x.ck_query = q.ck_id

/*##filter.ck_page*/where exists(select 1

                                   from

                                   (select unnest(array[x.ck_pages]) as ck_page

                                      from dual) t

                                  where t.ck_page = (cast(:json as jsonb)->''filter''->>''ck_page'')::varchar)/*filter.ck_page##*/

) t

where 1 = 1

/*##filter.ck_id*/and lower(t.ck_id) like ''%'' || lower((cast(:json as jsonb)->''filter''->>''ck_id'')::varchar) || ''%''/*filter.ck_id##*/

and ( &FILTER )

order by &SORT, t.ck_id asc

 ', 'meta', '20783', '2019-05-29 12:52:37.25561+03', 'select', 'po_session', NULL, 'Необходимо актуализировать')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

