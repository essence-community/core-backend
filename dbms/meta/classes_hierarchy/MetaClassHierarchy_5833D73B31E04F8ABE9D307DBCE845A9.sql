--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_5833D73B31E04F8ABE9D307DBCE845A9 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '1219ADF584634D82A7A83D7DB9662516' as ck_id, '1' as ck_class_parent, '5833D73B31E04F8ABE9D307DBCE845A9' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-03-18T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'F392C364B5BE471EA18E24FCFD9EB253' as ck_id, '137' as ck_class_parent, '5833D73B31E04F8ABE9D307DBCE845A9' as ck_class_child, '621' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-03-17T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'D6FF702A485243118EE6AC689910FCB6' as ck_id, '32' as ck_class_parent, '5833D73B31E04F8ABE9D307DBCE845A9' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-03-18T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '30F71583AF674BBBA6E4055B2E4E465E' as ck_id, '58' as ck_class_parent, '5833D73B31E04F8ABE9D307DBCE845A9' as ck_class_child, '382' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-03-18T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '0B9A8F74F28A43CDBACF5C45F66DA591' as ck_id, '5833D73B31E04F8ABE9D307DBCE845A9' as ck_class_parent, '7C133EA0021A44A0864B82F7BC40F183' as ck_class_child, '4AEC70A0D12E482CAD770D943783B1FD' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-11-08T14:36:49.100+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
