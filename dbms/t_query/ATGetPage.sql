--liquibase formatted sql
--changeset artemov_i:ATGetPage.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('ATGetPage', '--ATGetPage

/* find the current page,

   i.e. looking for the last page that was set before the current action */

with

  w_current_page as(

    select

      cv_value

    from s_mt.t_action a

    where a.ck_step = (cast(:json as jsonb)->''filter''->>''gck_step'')::varchar and

      a.cn_order < (cast(:json as jsonb)->''master''->>''ck_id'')::bigint and /* entered action''s number */

      a.cv_key = ''ck_page''

    order by a.cn_order desc

    fetch next 1 rows only

  )

  --

  select

    t.ck_id,

    t.cv_name,

    t.rn

  from (

    with recursive

      q as (

        select

          p.ck_id,

          p.cv_name,

          array[p.cn_order] as sort

        from s_mt.t_page p

        where p.cr_type = 2 /* Страницы */ and

          p.ck_parent is null



        union all



        select

          p.ck_id,

          p.cv_name,

          q.sort || p.cn_order as sort

        from s_mt.t_page p

        join q on

          p.ck_parent = q.ck_id

      )



    select

      q.ck_id,

      q.cv_name,

      row_number() over() as rn

    from q

    order by q.sort

  ) t

  left join w_current_page on

    1 = 1

  where lower(t.cv_name) like (lower(cast(:json as jsonb)->''filter''->>''cv_entered'')::varchar || ''%'')

  order by

    case

      when w_current_page.cv_value = t.ck_id then 1

      else 0

    end desc,

    t.rn

  ', 'meta', '10020788', '2019-05-23 15:39:14.16167+03', 'select', 'po_session', NULL, 'Необходимо актуализировать')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;

