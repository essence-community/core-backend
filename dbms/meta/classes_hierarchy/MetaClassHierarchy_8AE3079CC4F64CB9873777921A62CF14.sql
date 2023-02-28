--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_8AE3079CC4F64CB9873777921A62CF14 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '2656802CCE6D42B4838742D22459DC6E' as ck_id, '137' as ck_class_parent, '8AE3079CC4F64CB9873777921A62CF14' as ck_class_child, '619' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-28T14:52:09.168+0000'::timestamp with time zone as ct_change
    union all
    select 'AF0DEE3EE4424B0A8F9D22975255A06C' as ck_id, '157' as ck_class_parent, '8AE3079CC4F64CB9873777921A62CF14' as ck_class_child, '36169' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-28T14:52:18.409+0000'::timestamp with time zone as ct_change
    union all
    select '0AE5854D6F9A478EB2C4F516258DE94C' as ck_id, '18' as ck_class_parent, '8AE3079CC4F64CB9873777921A62CF14' as ck_class_child, '31' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-28T14:51:20.838+0000'::timestamp with time zone as ct_change
    union all
    select 'CB8795F10DCA4E82BBE424387F2F9A8F' as ck_id, '217' as ck_class_parent, '8AE3079CC4F64CB9873777921A62CF14' as ck_class_child, '830' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-28T14:52:28.823+0000'::timestamp with time zone as ct_change
    union all
    select 'EEDBD9DEA82E4AFA8B56AD2D1C203996' as ck_id, '8' as ck_class_parent, '8AE3079CC4F64CB9873777921A62CF14' as ck_class_child, '30' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-28T14:51:11.075+0000'::timestamp with time zone as ct_change
    union all
    select '272C5FC408344C2EA6819586244DEA57' as ck_id, 'BA125F895507411E8730C07D3AD26A3A' as ck_class_parent, '8AE3079CC4F64CB9873777921A62CF14' as ck_class_child, '0A71556DD08146C496C07ED8E2375751' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-28T14:52:47.048+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
