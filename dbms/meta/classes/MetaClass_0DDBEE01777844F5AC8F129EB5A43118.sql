--liquibase formatted sql
--changeset patcher-core:MetaClass_0DDBEE01777844F5AC8F129EB5A43118 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class(ck_id, cv_name, cv_description, cv_manual_documentation, cv_auto_documentation, cl_final, cl_dataset, ck_view, ck_user, ct_change) VALUES ('0DDBEE01777844F5AC8F129EB5A43118', 'Promo Page', 'Promo страница', null, null, 1, 0, 'system', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-05T14:44:06.338+0000')  on conflict (ck_id) do update set cv_name = excluded.cv_name, cv_description = excluded.cv_description, cv_manual_documentation = excluded.cv_manual_documentation, cv_auto_documentation = excluded.cv_auto_documentation, cl_final = excluded.cl_final, cl_dataset = excluded.cl_dataset, ck_view = excluded.ck_view, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_class_attr(ck_id, ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) VALUES ('E5AFFA28EEBB41B4A90F9D2A085BD773', '0DDBEE01777844F5AC8F129EB5A43118', 'type', null, 'PROMO', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-05T14:43:32.998+0000', 0, 0)  on conflict on constraint cin_c_class_attr_1 do update set ck_class = excluded.ck_class, ck_attr = excluded.ck_attr, cv_data_type_extra = excluded.cv_data_type_extra, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_required = excluded.cl_required, cl_empty = excluded.cl_empty;
select pkg_patcher.p_clear_attr('0DDBEE01777844F5AC8F129EB5A43118'::varchar, '["type"]'::jsonb);
