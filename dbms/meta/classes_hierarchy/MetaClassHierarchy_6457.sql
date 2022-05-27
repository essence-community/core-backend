--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_6457 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '10985' as ck_id, '38' as ck_class_parent, '6457' as ck_class_child, '40169' as ck_class_attr, '20785' as ck_user, '2019-01-21T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '11991' as ck_id, '6457' as ck_class_parent, '10457' as ck_class_child, '36173' as ck_class_attr, '30021381' as ck_user, '2019-01-24T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '6995' as ck_id, '6457' as ck_class_parent, '137' as ck_class_child, '36173' as ck_class_attr, '20785' as ck_user, '2018-12-12T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '6986' as ck_id, '6457' as ck_class_parent, '26' as ck_class_child, '36173' as ck_class_attr, '20785' as ck_user, '2018-12-11T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '6987' as ck_id, '6457' as ck_class_parent, '27' as ck_class_child, '36173' as ck_class_attr, '20785' as ck_user, '2018-12-11T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '6988' as ck_id, '6457' as ck_class_parent, '28' as ck_class_child, '36173' as ck_class_attr, '20785' as ck_user, '2018-12-11T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '6989' as ck_id, '6457' as ck_class_parent, '29' as ck_class_child, '36173' as ck_class_attr, '20785' as ck_user, '2018-12-11T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '6990' as ck_id, '6457' as ck_class_parent, '30' as ck_class_child, '36173' as ck_class_attr, '20785' as ck_user, '2018-12-11T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '6991' as ck_id, '6457' as ck_class_parent, '31' as ck_class_child, '36173' as ck_class_attr, '20785' as ck_user, '2018-12-11T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '12985' as ck_id, '6457' as ck_class_parent, '4457' as ck_class_child, '36173' as ck_class_attr, '10028610' as ck_user, '2019-02-05T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '75D16228383245ABA11795C44A3F9A1D' as ck_id, '6457' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-09T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '5C80529ED28D46489D94A7B23457BACB' as ck_id, '6457' as ck_class_parent, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T10:01:45.975+0000'::timestamp with time zone as ct_change
    union all
    select '178DF055B7364F4F860F1F10898D1FD8' as ck_id, '6457' as ck_class_parent, '5F229304828F4AADBF9B0BE6463B1248' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-05-27T11:15:53.605+0000'::timestamp with time zone as ct_change
    union all
    select '8D547C621A0A626CE053809BA8C0882B' as ck_id, '6457' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '36173' as ck_class_attr, '20785' as ck_user, '2019-07-13T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '6992' as ck_id, '6457' as ck_class_parent, '97' as ck_class_child, '36173' as ck_class_attr, '20785' as ck_user, '2018-12-11T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'A922E50420E54235BBFDDFC9B0B2A095' as ck_id, '6457' as ck_class_parent, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-03-30T13:27:02.090+0000'::timestamp with time zone as ct_change
    union all
    select '6994' as ck_id, '8' as ck_class_parent, '6457' as ck_class_child, '36174' as ck_class_attr, '20785' as ck_user, '2018-12-11T00:00:00.000+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
