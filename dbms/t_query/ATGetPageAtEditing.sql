--liquibase formatted sql
--changeset artemov_i:ATGetPageAtEditing.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('ATGetPageAtEditing', '--ATGetPageAtEditing

/*forked from ATGetPage*/

select

  t.ck_id,

  t.cv_name,

  t.rn

from(

  with recursive

    q as (

      select

        p.ck_id,

        p.cv_name,

        array[p.cn_order] as sort

      from s_mt.t_page p

      where p.cr_type = 2 and /* Страницы */

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

where lower(t.cv_name) like (lower(cast(:json as jsonb)->''filter''->>''cv_entered'')::varchar || ''%'')

order by

  case

    when t.ck_id = (cast(:json as jsonb)->''filter''->>''gck_page'')::varchar then 1

    else 0

  end desc,

  t.rn

  ', 'meta', '10020788', '2019-05-21 16:54:33.872319+03', 'select', 'po_session', NULL, 'Необходимо актуализировать')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;

