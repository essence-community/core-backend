--liquibase formatted sql
--changeset artemov_i:ATShowAction.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('ATShowAction', '--ATShowAction

select

  a.ck_id,

  a.ck_step,

  a.cn_order,

  a.cv_key,

  o.cv_name,

  a.cv_value,

  a.cv_description,

  a.ck_d_action,

  a.cl_expected,

  /* для функционирования окон редактирования нужно отдать ck_page + ck_page_object */

  case cv_key

    when ''ck_page'' then a.cv_value

    else po.ck_page

  end as ck_page,

  case cv_key

    when ''ck_page'' then null

    else a.cv_key

  end as ck_page_object,

  /* для определения, какое окно редактирования вызывать */

  case cv_key

    when ''ck_page'' then ''page''

    else ''pageobject''

  end as cv_row_type,

  /* текущая страница - TODO - обсудить с Воробьевым */

  --lag(decode(a.cv_key,''ck_page'',a.cv_value) ignore nulls,1,decode(a.cv_key,''ck_page'',a.cv_value)) over(order by a.cn_order) as ck_page,

  /* Поля аудита */

  a.ck_user,

  a.ct_change at time zone :sess_cv_timezone as ct_change

from s_mt.t_action a

left join s_mt.t_page_object po on

  po.ck_id = a.cv_key

left join s_mt.t_object o on

  o.ck_id = po.ck_object

where a.ck_step = (cast(:json as jsonb)->''master''->>''ck_id'')::varchar and

 ( &FILTER )

 /*##filter.ck_id*/and a.ck_id = (cast(:json as jsonb)->''filter''->>''ck_id'')::varchar/*filter.ck_id##*/

order by &SORT, a.cn_order asc

  ', 'meta', '10020788', '2019-05-21 16:53:53.21082+03', 'select', 'po_session', NULL, 'Необходимо актуализировать')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

