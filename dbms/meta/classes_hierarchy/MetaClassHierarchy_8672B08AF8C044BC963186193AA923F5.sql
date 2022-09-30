--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_8672B08AF8C044BC963186193AA923F5 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '74824813DEC549BE9EBF5556DCC43300' as ck_id, '1' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-09-30T06:32:47.649+0000'::timestamp with time zone as ct_change
    union all
    select '5373425139E84A5E8F92CFC4CF7A8A0F' as ck_id, '137' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '621' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-09-30T06:33:25.467+0000'::timestamp with time zone as ct_change
    union all
    select '4C4BA563B08E449FA5A2EA2F364C2F94' as ck_id, '217' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-09-30T06:33:49.384+0000'::timestamp with time zone as ct_change
    union all
    select 'CB306CE3F7EC43C69CB81846E6F6CC88' as ck_id, '32' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-09-30T06:34:35.943+0000'::timestamp with time zone as ct_change
    union all
    select 'AFF9FE270DCC4DB5BBCB6F6269805398' as ck_id, '35' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-09-30T06:34:19.340+0000'::timestamp with time zone as ct_change
    union all
    select 'E02D4B0403E147A7A4492EC76575FEE6' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-09-30T06:34:01.638+0000'::timestamp with time zone as ct_change
    union all
    select '37DB8F31FF244EAD992C7F2B40315D0D' as ck_id, '6457' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-09-30T06:33:35.904+0000'::timestamp with time zone as ct_change
    union all
    select '034AA50916924D8F882CEFCAC2EBB2FB' as ck_id, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, 'E2D0A96506384965A7B2666E5D2D1970' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-09-30T06:34:50.078+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
