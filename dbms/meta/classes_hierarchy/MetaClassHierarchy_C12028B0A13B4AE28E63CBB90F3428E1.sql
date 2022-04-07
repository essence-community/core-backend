--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_C12028B0A13B4AE28E63CBB90F3428E1 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select 'DBCAFDC4202048D590AEA6E6D20ACE43' as ck_id, 'C12028B0A13B4AE28E63CBB90F3428E1' as ck_class_parent, '137' as ck_class_child, '5CE6E945D0164CD49959C639DED4241F' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-21T00:00:00.000+0000' as ct_change
    union all
    select '8A49EDBA6A594AE39BA3B89B6FD289F5' as ck_id, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_parent, 'C12028B0A13B4AE28E63CBB90F3428E1' as ck_class_child, 'E2D0A96506384965A7B2666E5D2D1970' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-21T00:00:00.000+0000' as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
