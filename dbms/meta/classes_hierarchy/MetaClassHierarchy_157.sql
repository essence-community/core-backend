--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_157 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '258' as ck_id, '1' as ck_class_parent, '157' as ck_class_child, '623' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '256' as ck_id, '137' as ck_class_parent, '157' as ck_class_child, '621' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '11992' as ck_id, '157' as ck_class_parent, '10457' as ck_class_child, '735' as ck_class_attr, '30021381' as ck_user, '2019-01-24T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '6985' as ck_id, '157' as ck_class_parent, '19' as ck_class_child, '36169' as ck_class_attr, '20785' as ck_user, '2018-12-11T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '255' as ck_id, '157' as ck_class_parent, '26' as ck_class_child, '735' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '249' as ck_id, '157' as ck_class_parent, '27' as ck_class_child, '735' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '253' as ck_id, '157' as ck_class_parent, '28' as ck_class_child, '735' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '245' as ck_id, '157' as ck_class_parent, '29' as ck_class_child, '735' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '247' as ck_id, '157' as ck_class_parent, '30' as ck_class_child, '735' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'DEF3A8B968F841F083ECCCA28A938838' as ck_id, '157' as ck_class_parent, '3061ADE6780F432B93F17C1DCCC33D93' as ck_class_child, '735' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:35.711+0000'::timestamp with time zone as ct_change
    union all
    select '246' as ck_id, '157' as ck_class_parent, '31' as ck_class_child, '735' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '13985' as ck_id, '157' as ck_class_parent, '33' as ck_class_child, '735' as ck_class_attr, '10028610' as ck_user, '2019-02-06T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '646' as ck_id, '157' as ck_class_parent, '357' as ck_class_child, '735' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '252' as ck_id, '157' as ck_class_parent, '37' as ck_class_child, '735' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '248' as ck_id, '157' as ck_class_parent, '38' as ck_class_child, '735' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '41337D5533D84388851E3EE6E41CCD92' as ck_id, '157' as ck_class_parent, '508B0DE5C67B464CB3A5CED4DF778084' as ck_class_child, '735' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:14.957+0000'::timestamp with time zone as ct_change
    union all
    select '914E9DE59B504109901B3D9A429DF04F' as ck_id, '157' as ck_class_parent, '7457' as ck_class_child, '735' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-22T13:03:35.560+0000'::timestamp with time zone as ct_change
    union all
    select '8989' as ck_id, '157' as ck_class_parent, '8457' as ck_class_child, '735' as ck_class_attr, '20786' as ck_user, '2018-12-24T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'AF0DEE3EE4424B0A8F9D22975255A06C' as ck_id, '157' as ck_class_parent, '8AE3079CC4F64CB9873777921A62CF14' as ck_class_child, '36169' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-28T14:52:18.409+0000'::timestamp with time zone as ct_change
    union all
    select '8BA063D683FA4B2987C158B9590F7FEC' as ck_id, '157' as ck_class_parent, '8C96F9B255F5407FBCB8DE9189B15F39' as ck_class_child, '36169' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-11-18T12:15:34.260+0000'::timestamp with time zone as ct_change
    union all
    select '8D4FD9E32888628AE053809BA8C080EB' as ck_id, '157' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '735' as ck_class_attr, '20785' as ck_user, '2019-07-13T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '254' as ck_id, '157' as ck_class_parent, '97' as ck_class_child, '735' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '259' as ck_id, '35' as ck_class_parent, '157' as ck_class_child, '172' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
