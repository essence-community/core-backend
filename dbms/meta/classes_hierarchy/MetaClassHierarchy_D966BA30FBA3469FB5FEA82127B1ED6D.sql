--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_D966BA30FBA3469FB5FEA82127B1ED6D dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '8E5C6E77F6FC4B3E9EEE1DE5A3AD4CF1' as ck_id, '1' as ck_class_parent, 'D966BA30FBA3469FB5FEA82127B1ED6D' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-09-27T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'ADFF5975DA774D6188218990543EB997' as ck_id, '137' as ck_class_parent, 'D966BA30FBA3469FB5FEA82127B1ED6D' as ck_class_child, '621' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-09-27T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '19F9F82644044A77B605A78625930B7B' as ck_id, '32' as ck_class_parent, 'D966BA30FBA3469FB5FEA82127B1ED6D' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-09-30T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'E754E5180C5D4BCEAF3EA89125E6ADD1' as ck_id, '35' as ck_class_parent, 'D966BA30FBA3469FB5FEA82127B1ED6D' as ck_class_child, '172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-09-27T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'B8CBEABDDF03452798A20FD6C706BDBA' as ck_id, 'D966BA30FBA3469FB5FEA82127B1ED6D' as ck_class_parent, '137' as ck_class_child, '4E50E23DE3C2473A8B41011A689EEC1F' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-09-20T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '4953B98C1D8941A4AA9DD567026FEE36' as ck_id, 'D966BA30FBA3469FB5FEA82127B1ED6D' as ck_class_parent, '19' as ck_class_child, 'D910BD59B2CE4895BE263B2FC12DA80D' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-09-27T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'E56D6225F29447A1B29EBB05186C603E' as ck_id, 'D966BA30FBA3469FB5FEA82127B1ED6D' as ck_class_parent, '8C96F9B255F5407FBCB8DE9189B15F39' as ck_class_child, 'D910BD59B2CE4895BE263B2FC12DA80D' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-11-18T12:15:34.260+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
