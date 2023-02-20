--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_4BA159E82B434939AAD293411854ED95 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '61B280CACC954949A303CDA3437EBC76' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '15593D209A1D46FC873706F69EE71E7A' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-05-20T10:09:35.568+0000'::timestamp with time zone as ct_change
    union all
    select 'BC578965E4164A83853EE19F4613392E' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '197' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-09-20T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '47D6A2EA6DBD412EA95163F1B3F2A093' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '26' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-09-20T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'B0438E49767B4D1FAFF43DC1344C924A' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '27' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-09-20T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'E97A0AF726A14D588992CA31DCFFC1C6' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '28' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-09-20T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'A6F31BFB6B1C499D8AA46F53986F5C85' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '29' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-09-20T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'B5EA629A334B4435877A1E9ADD675CEF' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '30' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-09-20T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '696D470C0CB04AE59B10EFE3D275C89A' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '3061ADE6780F432B93F17C1DCCC33D93' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:35.711+0000'::timestamp with time zone as ct_change
    union all
    select '972885F33B9E4414A66FF47185D60147' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '31' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-09-20T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'E599461243B443D79DAE9BE6BD901FBD' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '357' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-09-20T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'FCF34A313A5B43EBBCE75DB389AE9835' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '37' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-09-20T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '8B5EF501B37C4C6385C111C945CE9506' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '38' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-09-20T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '68405D6DA7A84DCC97A6F7941A95E104' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '4457' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-05-15T08:12:56.048+0000'::timestamp with time zone as ct_change
    union all
    select '9FE26248AE4443DAB03CABC2AE9DE438' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '508B0DE5C67B464CB3A5CED4DF778084' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:14.957+0000'::timestamp with time zone as ct_change
    union all
    select '7F06198C718C4EEDB4038B18BD9BC363' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-02-10T16:45:12.558+0000'::timestamp with time zone as ct_change
    union all
    select '631D579AFA48484C8EF21919FB22ECF3' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-09-20T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '6F9F548ADA3343C0B47E2256DF02CC86' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '97' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-09-20T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'A9D1A80CA3114F65B7058A82E5410221' as ck_id, '58' as ck_class_parent, '4BA159E82B434939AAD293411854ED95' as ck_class_child, '382' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-09-20T00:00:00.000+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
