--liquibase formatted sql
--changeset artemov_i:GetUserInfo.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('GetUserInfo', '/*GetUserInfo*/

with t as

(select u.ck_id as ck_user,

        u.cv_login as cv_username

   from tt_user u

  where u.ck_id = (:json::json#>>''{filter,cn_user}''))

--

select t.ck_user,

       coalesce(t.cv_username, ''Администратор ('' || (:json::json#>>''{filter,cn_user}'') || '')'') as cv_username

  from t

 right join dual on 1 = 1

 ', 'meta', '20783', '2019-05-28 14:12:03.226474+03', 'select', 'po_session', NULL, 'Необходимо актуализировать')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;

