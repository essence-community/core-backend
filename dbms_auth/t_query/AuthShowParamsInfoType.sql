--liquibase formatted sql
--changeset artemov_i:AuthShowParamsInfoType.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id,cc_query,ck_provider,ck_user,ct_change,cr_type,cr_access,cv_description)
VALUES ('AuthShowParamsInfoType','/*AuthShowParamsInfoType*/
select 
	t.ck_id 
from unnest(array[''text'',''date'',''integer'',''numeric'',''boolean'',''textarea'',''custom'']) as t(ck_id)
order by t.ck_id asc
','authcore','-11','2019-08-13 18:30:00.000','select','po_session','Список доступных типов полей')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;
