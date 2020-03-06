--liquibase formatted sql
--changeset artemov_i:AuthDefaultTokenExpire dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id,cc_query,ck_provider,ck_user,ct_change,cr_type,cr_access,cv_description)
VALUES ('AuthDefaultTokenExpire','/*AuthDefaultTokenExpire*/
select to_char((CURRENT_TIMESTAMP + interval ''2 minute''), ''IYYY-MM-DD"T"HH24:MI:SS'') as ct_date
','authcore','4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-03-06 09:30:00.000','select','po_session','Время истечения токена по умолчанию')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cv_description = excluded.cv_description;
