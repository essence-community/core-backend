--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_18 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '221' as ck_id, '1' as ck_class_parent, '18' as ck_class_child, '623' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '204' as ck_id, '137' as ck_class_parent, '18' as ck_class_child, '621' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '9985' as ck_id, '18' as ck_class_parent, '10' as ck_class_child, '27' as ck_class_attr, '20788' as ck_user, '2019-01-16T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '925' as ck_id, '18' as ck_class_parent, '11' as ck_class_child, '27' as ck_class_attr, '10020786' as ck_user, '2018-04-19T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '2985' as ck_id, '18' as ck_class_parent, '1457' as ck_class_child, '31' as ck_class_attr, '10020785' as ck_user, '2018-07-15T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '6' as ck_id, '18' as ck_class_parent, '15' as ck_class_child, '27' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '7' as ck_id, '18' as ck_class_parent, '16' as ck_class_child, '27' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '9' as ck_id, '18' as ck_class_parent, '17' as ck_class_child, '27' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '13' as ck_id, '18' as ck_class_parent, '19' as ck_class_child, '31' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '447' as ck_id, '18' as ck_class_parent, '257' as ck_class_child, '977' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '35' as ck_id, '18' as ck_class_parent, '32' as ck_class_child, '55' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '86' as ck_id, '18' as ck_class_parent, '36' as ck_class_child, '27' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '909' as ck_id, '18' as ck_class_parent, '437' as ck_class_child, '27' as ck_class_attr, '-11' as ck_user, '2018-04-04T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '105' as ck_id, '18' as ck_class_parent, '57' as ck_class_child, '27' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '117' as ck_id, '18' as ck_class_parent, '58' as ck_class_child, '392' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '128' as ck_id, '18' as ck_class_parent, '77' as ck_class_child, '27' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '239C5C4FB98F409BBDB0F7A1CEBCFCEF' as ck_id, '18' as ck_class_parent, '7C133EA0021A44A0864B82F7BC40F183' as ck_class_child, 'AEAE3F4A3E864A648D66BB31A5F26BAF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-11-08T14:34:33.061+0000'::timestamp with time zone as ct_change
    union all
    select '0AE5854D6F9A478EB2C4F516258DE94C' as ck_id, '18' as ck_class_parent, '8AE3079CC4F64CB9873777921A62CF14' as ck_class_child, '31' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-28T14:51:20.838+0000'::timestamp with time zone as ct_change
    union all
    select '5BAE3378AF3744848ED597A74E54B902' as ck_id, '18' as ck_class_parent, '8C96F9B255F5407FBCB8DE9189B15F39' as ck_class_child, '31' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-11-18T12:15:34.260+0000'::timestamp with time zone as ct_change
    union all
    select '10' as ck_id, '18' as ck_class_parent, '9' as ck_class_child, '27' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '62246C7035354485A1F391306CC73E0C' as ck_id, '18' as ck_class_parent, '9CC06E8D9D7E4791BA1C6232DAF60CDD' as ck_class_child, '31' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:31:33.547+0000'::timestamp with time zone as ct_change
    union all
    select '94' as ck_id, '32' as ck_class_parent, '18' as ck_class_child, '138' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '63' as ck_id, '35' as ck_class_parent, '18' as ck_class_child, '172' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'FA8D5FABCDC44BFF816942C14E6C28F1' as ck_id, '92D23B81FAEA445DAB66C6651F1F0479' as ck_class_parent, '18' as ck_class_child, '5A77102C08BB468EA5E45DCF6036C048' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-10-24T11:39:31.885+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
