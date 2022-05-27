--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_5F229304828F4AADBF9B0BE6463B1248 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '06A70E0E355D4B999B51CACCC67CC7B6' as ck_id, '1' as ck_class_parent, '5F229304828F4AADBF9B0BE6463B1248' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-06-15T13:31:05.701+0000'::timestamp with time zone as ct_change
    union all
    select '4FF9DB7B91B74F158F7EFE03CD60D2ED' as ck_id, '137' as ck_class_parent, '5F229304828F4AADBF9B0BE6463B1248' as ck_class_child, '621' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-05-27T11:15:44.772+0000'::timestamp with time zone as ct_change
    union all
    select 'A2B68F5C9B3948A4985B01B53CB9D62F' as ck_id, '1807D17438814B31B75A279C4CBC6C0C' as ck_class_parent, '5F229304828F4AADBF9B0BE6463B1248' as ck_class_child, '225864898ED0411FA0E5434CD3A85346' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-05-27T11:17:11.746+0000'::timestamp with time zone as ct_change
    union all
    select 'C6C01387B1FF4FF3BA64071B3803F73E' as ck_id, '32' as ck_class_parent, '5F229304828F4AADBF9B0BE6463B1248' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-05-27T11:16:07.443+0000'::timestamp with time zone as ct_change
    union all
    select '140AE258A3E5440DB0C442FEA3E5718B' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '5F229304828F4AADBF9B0BE6463B1248' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-05-27T11:16:26.529+0000'::timestamp with time zone as ct_change
    union all
    select '178DF055B7364F4F860F1F10898D1FD8' as ck_id, '6457' as ck_class_parent, '5F229304828F4AADBF9B0BE6463B1248' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-05-27T11:15:53.605+0000'::timestamp with time zone as ct_change
    union all
    select '9D00BAD27C7A4828B7C37ECAEAA57BA3' as ck_id, '7457' as ck_class_parent, '5F229304828F4AADBF9B0BE6463B1248' as ck_class_child, '37172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-05-27T11:16:47.642+0000'::timestamp with time zone as ct_change
    union all
    select '220939D14C82407E8A7B46C9AE91E315' as ck_id, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_parent, '5F229304828F4AADBF9B0BE6463B1248' as ck_class_child, 'E2D0A96506384965A7B2666E5D2D1970' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-05-27T11:16:16.200+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
