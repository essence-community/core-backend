--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_10 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '11995' as ck_id, '10' as ck_class_parent, '10457' as ck_class_child, '40' as ck_class_attr, '30021381' as ck_user, '2019-01-24T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '48' as ck_id, '10' as ck_class_parent, '26' as ck_class_child, '40' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '49' as ck_id, '10' as ck_class_parent, '27' as ck_class_child, '40' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '50' as ck_id, '10' as ck_class_parent, '28' as ck_class_child, '40' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '51' as ck_id, '10' as ck_class_parent, '29' as ck_class_child, '40' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '53' as ck_id, '10' as ck_class_parent, '31' as ck_class_child, '40' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '626' as ck_id, '10' as ck_class_parent, '33' as ck_class_child, '40' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '36A9FA9CAFE744AE907F6252D9A8EC46' as ck_id, '10' as ck_class_parent, '37' as ck_class_child, '40' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '806' as ck_id, '10' as ck_class_parent, '38' as ck_class_child, '40' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'A8C580328EAB489CB1DB135F4D5341DE' as ck_id, '10' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '40' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'D2FF671999E34F35939C15D46DC8AA7D' as ck_id, '10' as ck_class_parent, '508B0DE5C67B464CB3A5CED4DF778084' as ck_class_child, '40' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:14.957+0000'::timestamp with time zone as ct_change
    union all
    select 'FF4F00189C8C48A4B4748A283A07EFAE' as ck_id, '10' as ck_class_parent, '8457' as ck_class_child, '40' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'A72010936FC24CB3BD2C91CFC6E12799' as ck_id, '10' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '40' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '1A162AADC1874FE0B546217B7D676605' as ck_id, '10' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '40' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:37:38.715+0000'::timestamp with time zone as ct_change
    union all
    select 'BD4157E7C46D444FA3BCC203ED09E571' as ck_id, '10' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '40' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '9985' as ck_id, '18' as ck_class_parent, '10' as ck_class_child, '27' as ck_class_attr, '20788' as ck_user, '2019-01-16T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '93' as ck_id, '37' as ck_class_parent, '10' as ck_class_child, '270' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '89' as ck_id, '38' as ck_class_parent, '10' as ck_class_child, '306' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '2' as ck_id, '8' as ck_class_parent, '10' as ck_class_child, '8' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
