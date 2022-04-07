--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_DA77FDDE896F48909B19EBB516326D33 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select 'C669B151F2F542B3921AAA215637421B' as ck_id, '32' as ck_class_parent, 'DA77FDDE896F48909B19EBB516326D33' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-06-25T11:47:18.474+0000' as ct_change
    union all
    select '9D0879C0F086450FABF015D6F256459F' as ck_id, '9' as ck_class_parent, 'DA77FDDE896F48909B19EBB516326D33' as ck_class_child, '39' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-06-03T13:49:26.799+0000' as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
