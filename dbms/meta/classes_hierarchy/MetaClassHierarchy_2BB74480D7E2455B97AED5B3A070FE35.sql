--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_2BB74480D7E2455B97AED5B3A070FE35 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '9EECD8F6BE3D4B29B3D511DEDCAAC7E3' as ck_id, '137' as ck_class_parent, '2BB74480D7E2455B97AED5B3A070FE35' as ck_class_child, '621' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-24T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'EF4739E55DBA41559FF0B048330DFDCB' as ck_id, '32' as ck_class_parent, '2BB74480D7E2455B97AED5B3A070FE35' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-24T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'ED4566DC08DC43C69C61E2F8E2D2823D' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '2BB74480D7E2455B97AED5B3A070FE35' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-24T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '64D4D9D5C9E0445D8A6607CF1AF69A41' as ck_id, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_parent, '2BB74480D7E2455B97AED5B3A070FE35' as ck_class_child, 'E2D0A96506384965A7B2666E5D2D1970' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-24T00:00:00.000+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
