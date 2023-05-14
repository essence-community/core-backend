--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_17 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '11997' as ck_id, '17' as ck_class_parent, '10457' as ck_class_child, '524' as ck_class_attr, '30021381' as ck_user, '2019-01-24T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '5F722831E3BE4CA1B09E56A55CC665D6' as ck_id, '17' as ck_class_parent, '15593D209A1D46FC873706F69EE71E7A' as ck_class_child, '524' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '07054E951971452A861C3B3F30EBA616' as ck_id, '17' as ck_class_parent, '197' as ck_class_child, '524' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '149' as ck_id, '17' as ck_class_parent, '26' as ck_class_child, '524' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '5DD12ED2866842B09589728D1FE0D728' as ck_id, '17' as ck_class_parent, '27' as ck_class_child, '524' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '49B80C1788304A90AA4DDFAF960DA373' as ck_id, '17' as ck_class_parent, '28' as ck_class_child, '524' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '8EF06DA0FD3E44D7A9F93AC07AF2A875' as ck_id, '17' as ck_class_parent, '29' as ck_class_child, '524' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '30F7F4B3B2EE4723AC93A4AD34EFD6AF' as ck_id, '17' as ck_class_parent, '30' as ck_class_child, '524' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '5644ADA6204B4019ACDBE016EDF5DFE9' as ck_id, '17' as ck_class_parent, '3061ADE6780F432B93F17C1DCCC33D93' as ck_class_child, '524' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:35.711+0000'::timestamp with time zone as ct_change
    union all
    select '234' as ck_id, '17' as ck_class_parent, '31' as ck_class_child, '524' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '628' as ck_id, '17' as ck_class_parent, '33' as ck_class_child, '524' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '1C5FA50B678D4CB9877F15DBDBAEFF20' as ck_id, '17' as ck_class_parent, '357' as ck_class_child, '524' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '150' as ck_id, '17' as ck_class_parent, '37' as ck_class_child, '524' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '151' as ck_id, '17' as ck_class_parent, '38' as ck_class_child, '524' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '158FE8DE605E46868B3CD3CF3E52ECAB' as ck_id, '17' as ck_class_parent, '417' as ck_class_child, '524' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'A65ACC8977324FE0896965CECA16B5F0' as ck_id, '17' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '524' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '2925232568584687B4BDE309DB9802CB' as ck_id, '17' as ck_class_parent, '508B0DE5C67B464CB3A5CED4DF778084' as ck_class_child, '524' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:14.957+0000'::timestamp with time zone as ct_change
    union all
    select 'B6BEB9AF08B743E885DAB51F2B56BF8C' as ck_id, '17' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '524' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '3DFBA9E81DA24D3092829BF3CFAAD473' as ck_id, '17' as ck_class_parent, '6B1F10465BA848B4BF8E75924A6268A2' as ck_class_child, '524' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '83219990AC26470782E005135A2E65E5' as ck_id, '17' as ck_class_parent, '7457' as ck_class_child, '524' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'F0B7294D33944C4297F26A278098B049' as ck_id, '17' as ck_class_parent, '8457' as ck_class_child, '524' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'EE560C08F10C4D6987E68264F8289FBD' as ck_id, '17' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '524' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '954EAA8F538C418782DE942BEA4FC41E' as ck_id, '17' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '524' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:37:38.715+0000'::timestamp with time zone as ct_change
    union all
    select '9FBB5BC5E31D4113932794F3E4601004' as ck_id, '17' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '524' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '9F8DDAED2C464EE59A89709617D518FC' as ck_id, '17' as ck_class_parent, '8E6AC2B44FCB8D3BE053809BA8C0E74D' as ck_class_child, '524' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '3B9AB55B03E7484F892A9F5E63BE038D' as ck_id, '17' as ck_class_parent, '97' as ck_class_child, '524' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '4ED85ECF926A4E0EA777477CB383EF73' as ck_id, '17' as ck_class_parent, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_child, '524' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'FD6B54E24B7A455FBF22C77152C92425' as ck_id, '17' as ck_class_parent, 'DA77FDDE896F48909B19EBB516326D33' as ck_class_child, '524' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '9' as ck_id, '18' as ck_class_parent, '17' as ck_class_child, '27' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '91' as ck_id, '37' as ck_class_parent, '17' as ck_class_child, '270' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
