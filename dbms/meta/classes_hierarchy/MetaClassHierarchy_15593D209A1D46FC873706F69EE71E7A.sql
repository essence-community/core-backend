--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_15593D209A1D46FC873706F69EE71E7A dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select 'F9D5AE7717724C36BF66D1025A1D1668' as ck_id, '137' as ck_class_parent, '15593D209A1D46FC873706F69EE71E7A' as ck_class_child, '621' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-05-20T10:08:53.888+0000' as ct_change
    union all
    select '49E6449F462946A18DB2D6922900384A' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '15593D209A1D46FC873706F69EE71E7A' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:55:36.098+0000' as ct_change
    union all
    select '61B280CACC954949A303CDA3437EBC76' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '15593D209A1D46FC873706F69EE71E7A' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-05-20T10:09:35.568+0000' as ct_change
    union all
    select '001BFAB7785749A6AA86EA5EF6280726' as ck_id, '58' as ck_class_parent, '15593D209A1D46FC873706F69EE71E7A' as ck_class_child, '382' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-05-20T10:09:23.578+0000' as ct_change
    union all
    select '11706B0DB96146298024A628F9E601C4' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '15593D209A1D46FC873706F69EE71E7A' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-05-20T10:09:12.593+0000' as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
