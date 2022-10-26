--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_92D23B81FAEA445DAB66C6651F1F0479 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '45D749C94E1041AAAE6D5FC1CDA8AA7B' as ck_id, '1' as ck_class_parent, '92D23B81FAEA445DAB66C6651F1F0479' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-10-24T11:41:48.602+0000'::timestamp with time zone as ct_change
    union all
    select '716CDCFD5186423DA5CD40FA6B236A17' as ck_id, '137' as ck_class_parent, '92D23B81FAEA445DAB66C6651F1F0479' as ck_class_child, '621' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-10-24T11:42:08.818+0000'::timestamp with time zone as ct_change
    union all
    select '9B0E3F3715EF469DABBC6ACDC068D963' as ck_id, '32' as ck_class_parent, '92D23B81FAEA445DAB66C6651F1F0479' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-10-24T11:42:29.988+0000'::timestamp with time zone as ct_change
    union all
    select 'DBCD75F2366C4CEC9014274EE8D7E170' as ck_id, '92D23B81FAEA445DAB66C6651F1F0479' as ck_class_parent, '1' as ck_class_child, '5A77102C08BB468EA5E45DCF6036C048' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-10-24T11:39:02.438+0000'::timestamp with time zone as ct_change
    union all
    select '1CCB7E8F790B445FB9C1E09A6A8AD7C2' as ck_id, '92D23B81FAEA445DAB66C6651F1F0479' as ck_class_parent, '137' as ck_class_child, '5A77102C08BB468EA5E45DCF6036C048' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-10-24T11:38:52.964+0000'::timestamp with time zone as ct_change
    union all
    select 'FA8D5FABCDC44BFF816942C14E6C28F1' as ck_id, '92D23B81FAEA445DAB66C6651F1F0479' as ck_class_parent, '18' as ck_class_child, '5A77102C08BB468EA5E45DCF6036C048' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-10-24T11:39:31.885+0000'::timestamp with time zone as ct_change
    union all
    select '96015FCB37494A2DA8F753421152E042' as ck_id, '92D23B81FAEA445DAB66C6651F1F0479' as ck_class_parent, '8' as ck_class_child, '5A77102C08BB468EA5E45DCF6036C048' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-10-24T11:39:14.832+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
