--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_26 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '230' as ck_id, '1' as ck_class_parent, '26' as ck_class_child, '623' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '48' as ck_id, '10' as ck_class_parent, '26' as ck_class_child, '40' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '214' as ck_id, '137' as ck_class_parent, '26' as ck_class_child, '621' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '255' as ck_id, '157' as ck_class_parent, '26' as ck_class_child, '735' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '149' as ck_id, '17' as ck_class_parent, '26' as ck_class_child, '524' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '36' as ck_id, '32' as ck_class_parent, '26' as ck_class_child, '138' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '898' as ck_id, '417' as ck_class_parent, '26' as ck_class_child, '1850' as ck_class_attr, '10020786' as ck_user, '2018-03-05T00:00:00.000+0000' as ct_change
    union all
    select 'BB23D73372A84DDBA958A99BB0A816E3' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '26' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:59:04.173+0000' as ct_change
    union all
    select '47D6A2EA6DBD412EA95163F1B3F2A093' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '26' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-09-20T00:00:00.000+0000' as ct_change
    union all
    select '115' as ck_id, '58' as ck_class_parent, '26' as ck_class_child, '382' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '6986' as ck_id, '6457' as ck_class_parent, '26' as ck_class_child, '36173' as ck_class_attr, '20785' as ck_user, '2018-12-11T00:00:00.000+0000' as ct_change
    union all
    select '7986' as ck_id, '7457' as ck_class_parent, '26' as ck_class_child, '37172' as ck_class_attr, '20785' as ck_user, '2018-12-19T00:00:00.000+0000' as ct_change
    union all
    select '608' as ck_id, '77' as ck_class_parent, '26' as ck_class_child, '450' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '87BF581B3930242FE053809BA8C0461B' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '26' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '20785' as ck_user, '2019-05-15T00:00:00.000+0000' as ct_change
    union all
    select '42' as ck_id, '9' as ck_class_parent, '26' as ck_class_child, '39' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '575ED01B57634A73A4BE86978000905C' as ck_id, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_parent, '26' as ck_class_child, '4F0C103E377040179EF412F13E09D265' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-16T00:00:00.000+0000' as ct_change
    union all
    select '9FB904AC48784500BF5145D00984FFA8' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '26' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-03T00:00:00.000+0000' as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
