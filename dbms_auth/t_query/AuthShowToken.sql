--liquibase formatted sql
--changeset artemov_i:AuthShowToken dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id,cc_query,ck_provider,ck_user,ct_change,cr_type,cr_access,cv_description)
VALUES ('AuthShowToken','/*AuthShowToken*/
select /*Pagination*/
       count(1) over() as jn_total_cnt,
       /*Token*/
       t.*
  from (
    select 
        at.ck_id,
        at.ct_start,
        at.ct_expire,
        at.ck_account,
        a.cv_login,
        at.cl_single,
        at.ck_user,
        at.ct_change at time zone :sess_cv_timezone as ct_change
    from t_auth_token at
    join t_account a
     on at.ck_account = a.ck_id
    where true and a.cl_deleted = 0::smallint
        /*##filter.ck_id*/
    and at.ck_id = :json::json#>>''{filter,ck_id}''/*filter.ck_id##*/
  ) t
 where &FILTER
 order by &SORT
offset &OFFSET rows
 fetch first &FETCH rows only','authcore','4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-03-06 09:30:00.000','select','po_session','Список токенов')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cv_description = excluded.cv_description;
