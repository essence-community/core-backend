--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_7C133EA0021A44A0864B82F7BC40F183 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '938F503C08444EE980AB87838F5D197B' as ck_id, '31' as ck_class_parent, '7C133EA0021A44A0864B82F7BC40F183' as ck_class_child, '05EC92721264431DBE89B8C3B7A53C85' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-13T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'DAC90BBE9CCA405CBFCB9B8B739DD270' as ck_id, '8D547C621A02626CE053809BA8C0882B' as ck_class_parent, '7C133EA0021A44A0864B82F7BC40F183' as ck_class_child, '433F410317974A2EA8BAEA2AE491B216' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-03-30T00:00:00.000+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
