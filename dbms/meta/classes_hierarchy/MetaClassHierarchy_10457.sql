--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_10457 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '11985' as ck_id, '1' as ck_class_parent, '10457' as ck_class_child, '623' as ck_class_attr, '30021381' as ck_user, '2019-01-24T00:00:00.000+0000' as ct_change
    union all
    select '11995' as ck_id, '10' as ck_class_parent, '10457' as ck_class_child, '40' as ck_class_attr, '30021381' as ck_user, '2019-01-24T00:00:00.000+0000' as ct_change
    union all
    select '11989' as ck_id, '137' as ck_class_parent, '10457' as ck_class_child, '621' as ck_class_attr, '30021381' as ck_user, '2019-01-24T00:00:00.000+0000' as ct_change
    union all
    select '11992' as ck_id, '157' as ck_class_parent, '10457' as ck_class_child, '735' as ck_class_attr, '30021381' as ck_user, '2019-01-24T00:00:00.000+0000' as ct_change
    union all
    select '11997' as ck_id, '17' as ck_class_parent, '10457' as ck_class_child, '524' as ck_class_attr, '30021381' as ck_user, '2019-01-24T00:00:00.000+0000' as ct_change
    union all
    select '11993' as ck_id, '32' as ck_class_parent, '10457' as ck_class_child, '138' as ck_class_attr, '30021381' as ck_user, '2019-01-24T00:00:00.000+0000' as ct_change
    union all
    select '11987' as ck_id, '417' as ck_class_parent, '10457' as ck_class_child, '1850' as ck_class_attr, '30021381' as ck_user, '2019-01-24T00:00:00.000+0000' as ct_change
    union all
    select 'BB4DDCEC177C4521BA63C95F2D2EA999' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '10457' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:59:13.321+0000' as ct_change
    union all
    select '11990' as ck_id, '58' as ck_class_parent, '10457' as ck_class_child, '382' as ck_class_attr, '30021381' as ck_user, '2019-01-24T00:00:00.000+0000' as ct_change
    union all
    select '11991' as ck_id, '6457' as ck_class_parent, '10457' as ck_class_child, '36173' as ck_class_attr, '30021381' as ck_user, '2019-01-24T00:00:00.000+0000' as ct_change
    union all
    select '11986' as ck_id, '7457' as ck_class_parent, '10457' as ck_class_child, '37172' as ck_class_attr, '30021381' as ck_user, '2019-01-24T00:00:00.000+0000' as ct_change
    union all
    select '11994' as ck_id, '77' as ck_class_parent, '10457' as ck_class_child, '450' as ck_class_attr, '30021381' as ck_user, '2019-01-24T00:00:00.000+0000' as ct_change
    union all
    select '87BF545279B513EDE053809BA8C0A884' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '10457' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '20785' as ck_user, '2019-05-16T00:00:00.000+0000' as ct_change
    union all
    select '11996' as ck_id, '9' as ck_class_parent, '10457' as ck_class_child, '39' as ck_class_attr, '30021381' as ck_user, '2019-01-24T00:00:00.000+0000' as ct_change
    union all
    select '2799E6E3EE4E41D0AD501833003E0370' as ck_id, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_parent, '10457' as ck_class_child, '4F0C103E377040179EF412F13E09D265' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-17T00:00:00.000+0000' as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
