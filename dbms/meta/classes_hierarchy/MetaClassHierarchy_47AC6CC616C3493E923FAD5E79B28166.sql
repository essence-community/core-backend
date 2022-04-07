--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_47AC6CC616C3493E923FAD5E79B28166 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select 'DC201ABB803C4196A350BE8CFD427FFB' as ck_id, '1' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-09T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '379CF928DF5B4C8E94F84AA00328A5FD' as ck_id, '137' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '621' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-09T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'A36690E5AB7143519E2EE658036F1491' as ck_id, '32' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-09T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '3F38CDCA01EB414CB546ABC9B8531E5C' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:57:36.841+0000'::timestamp with time zone as ct_change
    union all
    select '75D16228383245ABA11795C44A3F9A1D' as ck_id, '6457' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-09T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'E2938D9CA21642F18E04EAA7A75B2312' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-09T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '529089CA2C4B4263BC92171EF10627CE' as ck_id, '9' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '39' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-09T00:00:00.000+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
