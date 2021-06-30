--liquibase formatted sql
--changeset artemov_i:MTGetPageAction dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTGetPageAction', '--MTGetPageAction
select
    distinct cn_action
from
    t_page_action
where 1=1
 /*##filter.cn_action*/ and cn_action >= (:json::json#>>''{filter,cn_action}'')::bigint || ''%'' /*filter.cn_action##*/
order by
    cn_action
  ', 'meta', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-06-30 12:56:04.052926+03', 'select', 'session', NULL, 'Список уникальных экшенов')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

