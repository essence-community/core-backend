--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_508B0DE5C67B464CB3A5CED4DF778084 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '463012588CB0436982875EE4D5191B4D' as ck_id, '1' as ck_class_parent, '508B0DE5C67B464CB3A5CED4DF778084' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:14.957+0000'::timestamp with time zone as ct_change
    union all
    select 'D2FF671999E34F35939C15D46DC8AA7D' as ck_id, '10' as ck_class_parent, '508B0DE5C67B464CB3A5CED4DF778084' as ck_class_child, '40' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:14.957+0000'::timestamp with time zone as ct_change
    union all
    select '7B60DF352E8A477CB23CDADA985F6F9D' as ck_id, '137' as ck_class_parent, '508B0DE5C67B464CB3A5CED4DF778084' as ck_class_child, '621' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:14.957+0000'::timestamp with time zone as ct_change
    union all
    select '41337D5533D84388851E3EE6E41CCD92' as ck_id, '157' as ck_class_parent, '508B0DE5C67B464CB3A5CED4DF778084' as ck_class_child, '735' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:14.957+0000'::timestamp with time zone as ct_change
    union all
    select '2925232568584687B4BDE309DB9802CB' as ck_id, '17' as ck_class_parent, '508B0DE5C67B464CB3A5CED4DF778084' as ck_class_child, '524' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:14.957+0000'::timestamp with time zone as ct_change
    union all
    select 'A407A7ADDCE34228BE3736561B3F4792' as ck_id, '3061ADE6780F432B93F17C1DCCC33D93' as ck_class_parent, '508B0DE5C67B464CB3A5CED4DF778084' as ck_class_child, '182E640A949449AB9BCA61FD92017AD6' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:40:04.109+0000'::timestamp with time zone as ct_change
    union all
    select 'CB10D869610A461C952356441FF4A7A3' as ck_id, '32' as ck_class_parent, '508B0DE5C67B464CB3A5CED4DF778084' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:14.957+0000'::timestamp with time zone as ct_change
    union all
    select 'A4EEF048DA424C3285675F2B1D0D464D' as ck_id, '417' as ck_class_parent, '508B0DE5C67B464CB3A5CED4DF778084' as ck_class_child, '1850' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:14.957+0000'::timestamp with time zone as ct_change
    union all
    select 'B182F746E0C64599831748B20048E9C0' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '508B0DE5C67B464CB3A5CED4DF778084' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:14.957+0000'::timestamp with time zone as ct_change
    union all
    select '9FE26248AE4443DAB03CABC2AE9DE438' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '508B0DE5C67B464CB3A5CED4DF778084' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:14.957+0000'::timestamp with time zone as ct_change
    union all
    select '59D6DF6F54414752A08DC6E2D8A572F2' as ck_id, '58' as ck_class_parent, '508B0DE5C67B464CB3A5CED4DF778084' as ck_class_child, '382' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:14.957+0000'::timestamp with time zone as ct_change
    union all
    select '6B64D0858FA04090AE789C444ABB833D' as ck_id, '6457' as ck_class_parent, '508B0DE5C67B464CB3A5CED4DF778084' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:14.957+0000'::timestamp with time zone as ct_change
    union all
    select 'F76FF0B780484608AC525507EABF6C2B' as ck_id, '7457' as ck_class_parent, '508B0DE5C67B464CB3A5CED4DF778084' as ck_class_child, '37172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:14.957+0000'::timestamp with time zone as ct_change
    union all
    select '0CE4E1428AA04B159DFD8B6FF71FE934' as ck_id, '77' as ck_class_parent, '508B0DE5C67B464CB3A5CED4DF778084' as ck_class_child, '450' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:14.957+0000'::timestamp with time zone as ct_change
    union all
    select 'E08F77B21B7B47ADBC571FEE550C0978' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '508B0DE5C67B464CB3A5CED4DF778084' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:14.957+0000'::timestamp with time zone as ct_change
    union all
    select 'BCFA3C29137540B3BF244745310608AE' as ck_id, '9' as ck_class_parent, '508B0DE5C67B464CB3A5CED4DF778084' as ck_class_child, '39' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:14.957+0000'::timestamp with time zone as ct_change
    union all
    select '935CA0028A3A4291B706C0D4E9CAD623' as ck_id, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_parent, '508B0DE5C67B464CB3A5CED4DF778084' as ck_class_child, '4F0C103E377040179EF412F13E09D265' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:14.957+0000'::timestamp with time zone as ct_change
    union all
    select '3B314519FFFD47CEAF49EDC6344484B7' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '508B0DE5C67B464CB3A5CED4DF778084' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:14.957+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
