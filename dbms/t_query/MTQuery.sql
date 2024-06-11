--liquibase formatted sql
--changeset artemov_i:MTQuery.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTQuery', '/*MTQuery*/
with temp_q as (
  select
    q.ck_id,
    q.ck_provider,
    q.cr_type,
    q.cr_access,
    q.cv_description,
    /* Поля аудита */
    q.ck_user,
    q.ct_change at time zone :sess_cv_timezone as ct_change
  from s_mt.t_query q
  union all
  select
    ''Modify'' as ck_id,
    ''all'' as ck_provider,
    ''dml'' as cr_type,
    ''po_session'' as cr_access,
    ''Метод модификации'' as cv_description,
    ''4fd05ca9-3a9e-4d66-82df-886dfa082113'' as ck_user,
    ''2024-06-11 11:55:04.721523+03''::timestamptz as ct_change
)
select /*Pagination*/
       count(1) over() as jn_total_cnt,
       /*Query*/
       t.*
  from (
    select q.*
    from temp_q q
    where &FILTER
    /*##filter.ck_id*/
    and q.ck_id = (:json::json#>>''{filter,ck_id}'')
    /*filter.ck_id##*/
    /*##filter.search*/
    and q.ck_id ilike ''%'' || (:json::json#>>''{filter,search}'')::text || ''%''
    /*filter.search##*/
    order by &SORT
  ) t
offset &OFFSET rows
 fetch first &FETCH rows only
  ', 'meta', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2024-06-11 11:55:04.721523+03', 'select', 'po_session', NULL, 'Список сервисов')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;

