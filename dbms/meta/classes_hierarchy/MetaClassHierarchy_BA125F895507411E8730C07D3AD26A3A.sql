--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_BA125F895507411E8730C07D3AD26A3A dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select 'BCB20A4360E04E7DA169553A5E5BF93E' as ck_id, '1' as ck_class_parent, 'BA125F895507411E8730C07D3AD26A3A' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-03T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '93D7D7F199CF4DAC862BC0D2C526F3A2' as ck_id, '137' as ck_class_parent, 'BA125F895507411E8730C07D3AD26A3A' as ck_class_child, '621' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-03T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '45BF9FC5FBF44372B0D32F16B9B94207' as ck_id, 'BA125F895507411E8730C07D3AD26A3A' as ck_class_parent, '1457' as ck_class_child, '0A71556DD08146C496C07ED8E2375751' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-03T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '1E6AF1F3CAA54A2F972A8E8AA68F013D' as ck_id, 'BA125F895507411E8730C07D3AD26A3A' as ck_class_parent, '16CD1F9A0789445AA23AC20DA565BFCC' as ck_class_child, '0A71556DD08146C496C07ED8E2375751' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-03T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '6E663A2B4AB54136A2DB8AE84388FF49' as ck_id, 'BA125F895507411E8730C07D3AD26A3A' as ck_class_parent, '19' as ck_class_child, '0A71556DD08146C496C07ED8E2375751' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-03T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '45C92A9A24A94DA580CDE5C96CDEECC6' as ck_id, 'BA125F895507411E8730C07D3AD26A3A' as ck_class_parent, '4457' as ck_class_child, '0A71556DD08146C496C07ED8E2375751' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-07-25T09:59:28.821+0000'::timestamp with time zone as ct_change
    union all
    select '272C5FC408344C2EA6819586244DEA57' as ck_id, 'BA125F895507411E8730C07D3AD26A3A' as ck_class_parent, '8AE3079CC4F64CB9873777921A62CF14' as ck_class_child, '0A71556DD08146C496C07ED8E2375751' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-28T14:52:47.048+0000'::timestamp with time zone as ct_change
    union all
    select 'F1FB884607CB418F894DE4999EA14EE0' as ck_id, 'BA125F895507411E8730C07D3AD26A3A' as ck_class_parent, '8C96F9B255F5407FBCB8DE9189B15F39' as ck_class_child, '0A71556DD08146C496C07ED8E2375751' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-11-18T12:15:34.260+0000'::timestamp with time zone as ct_change
    union all
    select '445A7E7372BA417CA0572651D03AE4CF' as ck_id, 'BA125F895507411E8730C07D3AD26A3A' as ck_class_parent, '9CC06E8D9D7E4791BA1C6232DAF60CDD' as ck_class_child, '0A71556DD08146C496C07ED8E2375751' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-18T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'F13D731FF4E44702BAA598BD6D37730D' as ck_id, 'BA125F895507411E8730C07D3AD26A3A' as ck_class_parent, 'DB557A6113634FD2BC40D2A58EE1EB3F' as ck_class_child, '0A71556DD08146C496C07ED8E2375751' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-03T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'F74CEACE01724EBAA357CF3A8984FBED' as ck_id, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_parent, 'BA125F895507411E8730C07D3AD26A3A' as ck_class_child, 'E2D0A96506384965A7B2666E5D2D1970' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-13T00:00:00.000+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
