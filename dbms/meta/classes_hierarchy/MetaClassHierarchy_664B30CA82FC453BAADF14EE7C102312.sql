--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_664B30CA82FC453BAADF14EE7C102312 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select 'F20C870B32BD47AC8C2FACF032B2B7EF' as ck_id, '1' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-02-10T16:46:17.657+0000' as ct_change
    union all
    select '2FE37BBA27C6413EA81CF9A6372AFF3A' as ck_id, '137' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '621' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-02-10T16:45:37.910+0000' as ct_change
    union all
    select '65EBDA0371204C6A94E8EC28446176BE' as ck_id, '32' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-02-10T16:46:05.499+0000' as ct_change
    union all
    select '5CAB9DA7438D41E4B89F88F38C402EEE' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-02-10T16:45:47.209+0000' as ct_change
    union all
    select '7F06198C718C4EEDB4038B18BD9BC363' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-02-10T16:45:12.558+0000' as ct_change
    union all
    select '8F709C09D77F46DD851FD978894D5EBE' as ck_id, '58' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '382' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-02-10T16:45:22.782+0000' as ct_change
    union all
    select '48FF0C90DAFC4AC88BD20F112189952A' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-02-10T16:44:58.494+0000' as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
