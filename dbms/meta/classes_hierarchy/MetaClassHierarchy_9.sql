--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_9 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '10' as ck_id, '18' as ck_class_parent, '9' as ck_class_child, '27' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '92' as ck_id, '37' as ck_class_parent, '9' as ck_class_child, '270' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '665' as ck_id, '38' as ck_class_parent, '9' as ck_class_child, '306' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '1' as ck_id, '8' as ck_class_parent, '9' as ck_class_child, '8' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '11996' as ck_id, '9' as ck_class_parent, '10457' as ck_class_child, '39' as ck_class_attr, '30021381' as ck_user, '2019-01-24T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '82A17DB9CAD9485597895E2DCF8FFF10' as ck_id, '9' as ck_class_parent, '15593D209A1D46FC873706F69EE71E7A' as ck_class_child, '39' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '289' as ck_id, '9' as ck_class_parent, '197' as ck_class_child, '39' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '42' as ck_id, '9' as ck_class_parent, '26' as ck_class_child, '39' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '43' as ck_id, '9' as ck_class_parent, '27' as ck_class_child, '39' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '44' as ck_id, '9' as ck_class_parent, '28' as ck_class_child, '39' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '45' as ck_id, '9' as ck_class_parent, '29' as ck_class_child, '39' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '46' as ck_id, '9' as ck_class_parent, '30' as ck_class_child, '39' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'AF6A9C94605F412CB88E616DB947D23C' as ck_id, '9' as ck_class_parent, '3061ADE6780F432B93F17C1DCCC33D93' as ck_class_child, '39' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:35.711+0000'::timestamp with time zone as ct_change
    union all
    select '47' as ck_id, '9' as ck_class_parent, '31' as ck_class_child, '39' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '846' as ck_id, '9' as ck_class_parent, '317' as ck_class_child, '39' as ck_class_attr, '10020785' as ck_user, '2018-02-28T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '627' as ck_id, '9' as ck_class_parent, '33' as ck_class_child, '39' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '648' as ck_id, '9' as ck_class_parent, '357' as ck_class_child, '39' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '126' as ck_id, '9' as ck_class_parent, '37' as ck_class_child, '39' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '125' as ck_id, '9' as ck_class_parent, '38' as ck_class_child, '39' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '274F2B5D40E14D909D5EBD1E35847406' as ck_id, '9' as ck_class_parent, '417' as ck_class_child, '39' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '529089CA2C4B4263BC92171EF10627CE' as ck_id, '9' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '39' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-09T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'BCFA3C29137540B3BF244745310608AE' as ck_id, '9' as ck_class_parent, '508B0DE5C67B464CB3A5CED4DF778084' as ck_class_child, '39' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:14.957+0000'::timestamp with time zone as ct_change
    union all
    select '4B206C6512A2446E9B56DE648A3DB400' as ck_id, '9' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '39' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '04540E15612B4C9BACB6827C68CE4810' as ck_id, '9' as ck_class_parent, '6B1F10465BA848B4BF8E75924A6268A2' as ck_class_child, '39' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '20880F2B6EBA4AC7AF66782073ECBB69' as ck_id, '9' as ck_class_parent, '7457' as ck_class_child, '39' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '8987' as ck_id, '9' as ck_class_parent, '8457' as ck_class_child, '39' as ck_class_attr, '20786' as ck_user, '2018-12-24T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '591BA75BE45A4E8786C6073ACFF78701' as ck_id, '9' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '39' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'ECE80C37AF9446D78431FF625CD29C23' as ck_id, '9' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '39' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:37:38.715+0000'::timestamp with time zone as ct_change
    union all
    select '5AC5D95DA3C64FFDB3DDECC9C2D7CCA4' as ck_id, '9' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '39' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '1F00D353C0B44962A553F01506276C08' as ck_id, '9' as ck_class_parent, '8E6AC2B44FCB8D3BE053809BA8C0E74D' as ck_class_child, '39' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '791EBFF0BFCA4CC6B9800B53227CAB23' as ck_id, '9' as ck_class_parent, '97' as ck_class_child, '39' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'FB59BE8F541B4218BC932502B614335E' as ck_id, '9' as ck_class_parent, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_child, '39' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '9D0879C0F086450FABF015D6F256459F' as ck_id, '9' as ck_class_parent, 'DA77FDDE896F48909B19EBB516326D33' as ck_class_child, '39' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-06-03T13:49:26.799+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
