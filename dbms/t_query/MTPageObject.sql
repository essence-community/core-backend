--liquibase formatted sql
--changeset artemov_i:MTPageObject.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTPageObject', '/*MTPageObject*/

select

  t.ck_page,

  t.ck_object,

  t.cn_order,

  t.ck_parent,

  t.ck_id,

  t.ck_master,

  t.cv_master_path,

  t.cv_name_object,

  t.cv_description,

  t.cv_displayed,

  t.cv_name_class,

  t.leaf,

  /* Поля аудита */

  t.ck_user,

  t.ct_change at time zone :sess_cv_timezone as ct_change

from (

  with recursive

    q as (

      select

        array[po.cn_order] as sort,

        po.ck_page,

        po.ck_object,

        po.cn_order,

        po.ck_parent,

        po.ck_id,

        po.ck_master,

        master.cv_master_path,

        o.cv_name_object,

        o.cv_description,

        o.cv_displayed,

        c.cv_name_class,

        case

          when not exists(SELECT 1 FROM s_mt.t_page_object m WHERE m.ck_parent = po.ck_id) then ''true''

          else ''false''

        end as leaf,

        /* Поля аудита */

        po.ck_user,

        po.ct_change

      from s_mt.t_page_object po

      /* объект */

      join (select ck_id,

                   cv_name as cv_name_object,

                   cv_description,

                   cv_displayed,

                   ck_class

              from s_mt.t_object) o on o.ck_id = po.ck_object

      /* класс */

      join (select ck_id,

                   cv_name as cv_name_class

              from s_mt.t_class) c on c.ck_id = o.ck_class

              /* получим данные по мастеру */

      left join (select t.ck_master,

            /* получим иерархию объектов для мастера */

          (with recursive

              q as (select o2.cv_name as cv_name,

                           1 as lvl,

                           po2.ck_parent

                      from s_mt.t_page_object po2

                      join s_mt.t_object o2

                        on o2.ck_id = po2.ck_object

                     where po2.ck_id = t.ck_master



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

          ) as cv_master_path

        /* выберем все записи из PO, у которых указан мастер (в рамках нужной страницы).

          Сделано так с подзапросом, т.к. lateral не получилось использовать */

        from (select distinct ck_master

                from s_mt.t_page_object

               where ck_page = (cast(:json as jsonb)->''master''->>''ck_id'')::varchar

                 and ck_master is not null

        ) t

      ) master on master.ck_master = po.ck_master

      where po.ck_parent is null



      union all



      select

        q.sort || po.cn_order as sort,

        po.ck_page,

        po.ck_object,

        po.cn_order,

        po.ck_parent,

        po.ck_id,

        po.ck_master,

        master.cv_master_path,

        o.cv_name_object,

        o.cv_description,

        o.cv_displayed,

        c.cv_name_class,

        case

          when not exists(SELECT 1 FROM s_mt.t_page_object m WHERE m.ck_parent = po.ck_id) then ''true''

          else ''false''

        end as leaf,

        /* Поля аудита */

        po.ck_user,

        po.ct_change

      from s_mt.t_page_object po

      /* объект */

      join (select ck_id,

                   cv_name as cv_name_object,

                   cv_description,

                   cv_displayed,

                   ck_class

              from s_mt.t_object) o on o.ck_id = po.ck_object

      /* класс */

      join (select ck_id,

                   cv_name as cv_name_class

              from s_mt.t_class) c on c.ck_id = o.ck_class

      /* получим данные по мастеру */

      left join (select t.ck_master,

                 /* получим иерархию объектов для мастера */

          (with recursive

              q as (select o2.cv_name as cv_name,

                           1 as lvl,

                           po2.ck_parent

                      from s_mt.t_page_object po2

                      join s_mt.t_object o2

                        on o2.ck_id = po2.ck_object

                     where po2.ck_id = t.ck_master



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

          ) as cv_master_path

        /* выберем все записи из PO, у которых указан мастер (в рамках нужной страницы).

          Сделано так с подзапросом, т.к. lateral не получилось использовать */

        from (select distinct ck_master

                from s_mt.t_page_object

               where ck_page = (cast(:json as jsonb)->''master''->>''ck_id'')::varchar

                 and ck_master is not null

        ) t

      ) master on master.ck_master = po.ck_master

      join q on po.ck_parent = q.ck_id

    )



    select *

    from q

    order by &SORT, q.sort

) t

where t.ck_page = (cast(:json as jsonb)->''master''->>''ck_id'')::varchar

  and (&FILTER)

  ', 'meta', '20783', '2019-05-23 10:19:40.793494+03', 'select', 'po_session', NULL, 'Необходимо актуализировать')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

