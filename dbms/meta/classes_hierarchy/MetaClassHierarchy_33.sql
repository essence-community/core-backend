--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_33 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '226' as ck_id, '1' as ck_class_parent, '33' as ck_class_child, '623' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '626' as ck_id, '10' as ck_class_parent, '33' as ck_class_child, '40' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '629' as ck_id, '11' as ck_class_parent, '33' as ck_class_child, '43' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '210' as ck_id, '137' as ck_class_parent, '33' as ck_class_child, '621' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '13985' as ck_id, '157' as ck_class_parent, '33' as ck_class_child, '735' as ck_class_attr, '10028610' as ck_user, '2019-02-06T00:00:00.000+0000' as ct_change
    union all
    select '628' as ck_id, '17' as ck_class_parent, '33' as ck_class_child, '524' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '60' as ck_id, '32' as ck_class_parent, '33' as ck_class_child, '138' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '893' as ck_id, '417' as ck_class_parent, '33' as ck_class_child, '1850' as ck_class_attr, '10020786' as ck_user, '2018-03-05T00:00:00.000+0000' as ct_change
    union all
    select 'FEF1215CB72F4301AB883307AAC036A2' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '33' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:57:00.179+0000' as ct_change
    union all
    select '585' as ck_id, '58' as ck_class_parent, '33' as ck_class_child, '382' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '625' as ck_id, '77' as ck_class_parent, '33' as ck_class_child, '450' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '87A9EF4DBB2C5226E053809BA8C0E1C2' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '33' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '20785' as ck_user, '2019-05-16T00:00:00.000+0000' as ct_change
    union all
    select '627' as ck_id, '9' as ck_class_parent, '33' as ck_class_child, '39' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '9029E5800C1A4B0DB83A911341FB0446' as ck_id, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_parent, '33' as ck_class_child, '4F0C103E377040179EF412F13E09D265' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-17T00:00:00.000+0000' as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
