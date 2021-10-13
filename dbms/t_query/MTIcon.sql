--liquibase formatted sql
--changeset artemov_i:MTIcon.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTIcon', '/*MTIcon*/
select /*Pagination*/
       count(1) over() as jn_total_cnt,
       /*ICON*/
       t.*
  from (
  select i.ck_id,
       i.cv_name,
       i.cv_font,
       /* Поля аудита */
       i.ck_user,
       i.ct_change at time zone :sess_cv_timezone as ct_change
  from s_mt.t_icon i
  ) as t
 where &FILTER
 order by &SORT
offset &OFFSET rows
 fetch first &FETCH rows only
   ', 'meta', '20783', '2019-05-30 14:43:15.211439+03', 'select', 'po_session', NULL, 'Список доступных иконок')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;

