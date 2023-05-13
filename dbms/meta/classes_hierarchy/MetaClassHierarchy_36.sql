--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_36 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '86' as ck_id, '18' as ck_class_parent, '36' as ck_class_child, '27' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '25E6FE83588E4C519A2EF3CE8D53FD01' as ck_id, '36' as ck_class_parent, '10457' as ck_class_child, '254' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '7F2DD1B15B894270BCCD9716E5F024B5' as ck_id, '36' as ck_class_parent, '15593D209A1D46FC873706F69EE71E7A' as ck_class_child, '254' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'A4F09EC618604F09B97C0522502952A9' as ck_id, '36' as ck_class_parent, '197' as ck_class_child, '254' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '44CDDFAB5E6043E7950737CB1A30B996' as ck_id, '36' as ck_class_parent, '26' as ck_class_child, '254' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '53B1833932114D9EA0686792E7983DCF' as ck_id, '36' as ck_class_parent, '27' as ck_class_child, '254' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '164AAB656A214CB3881113B6F2D36C59' as ck_id, '36' as ck_class_parent, '28' as ck_class_child, '254' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '87' as ck_id, '36' as ck_class_parent, '29' as ck_class_child, '254' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'DB83A96A69FC4E29A4F431AA3A6B7673' as ck_id, '36' as ck_class_parent, '30' as ck_class_child, '254' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'E3CCB5A907344895907E6BDF676894CB' as ck_id, '36' as ck_class_parent, '31' as ck_class_child, '254' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '53902C7FF33647C5803E706CC4C1DA8B' as ck_id, '36' as ck_class_parent, '33' as ck_class_child, '254' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '8913A9224C9B4744B75BE69665CD9B47' as ck_id, '36' as ck_class_parent, '357' as ck_class_child, '254' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'E70AF74669D34D55927E666016770775' as ck_id, '36' as ck_class_parent, '37' as ck_class_child, '254' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '869F7391F57B426BBEA74B6DE14D1BB3' as ck_id, '36' as ck_class_parent, '38' as ck_class_child, '254' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '79F9CB80746F4DB3B6F003DB497BFAD5' as ck_id, '36' as ck_class_parent, '417' as ck_class_child, '254' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '5840A8CC01CE486DBA898CFBDD905392' as ck_id, '36' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '254' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '30DE42E45DEB4B65BF84D9F662B5BD9C' as ck_id, '36' as ck_class_parent, '508B0DE5C67B464CB3A5CED4DF778084' as ck_class_child, '254' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '9BEF47504CEA4865A277F5DCF52BB9C1' as ck_id, '36' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '254' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'C2B67C35EC5847A6AC2A26654E7BF96E' as ck_id, '36' as ck_class_parent, '6B1F10465BA848B4BF8E75924A6268A2' as ck_class_child, '254' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '9C144C2C85DC43458EF32FEF89526C90' as ck_id, '36' as ck_class_parent, '7457' as ck_class_child, '254' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '0D9C9D5B0E5C42028C69C5E8E8AC5DEC' as ck_id, '36' as ck_class_parent, '8457' as ck_class_child, '254' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'A35FDF73B3D349E199F22A30FE227C79' as ck_id, '36' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '254' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'B17512AF0B9C415C9A75AA53E54F1B53' as ck_id, '36' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '254' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:37:38.715+0000'::timestamp with time zone as ct_change
    union all
    select '259D5AB70F9F41D886DBBCF1FF44B1B4' as ck_id, '36' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '254' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'A9241C74254D40B1882E6E2B213CF14C' as ck_id, '36' as ck_class_parent, '8E6AC2B44FCB8D3BE053809BA8C0E74D' as ck_class_child, '254' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '38B467A1449F4C229BA0D12A4907811F' as ck_id, '36' as ck_class_parent, '97' as ck_class_child, '254' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '9B7DCB19325A4BD89807F417BD7DB178' as ck_id, '36' as ck_class_parent, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_child, '254' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '5A7827D5F6BF4872B33ADB28F7B4CE26' as ck_id, '36' as ck_class_parent, 'DA77FDDE896F48909B19EBB516326D33' as ck_class_child, '254' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '133' as ck_id, '37' as ck_class_parent, '36' as ck_class_child, '270' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '132' as ck_id, '38' as ck_class_parent, '36' as ck_class_child, '306' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '85' as ck_id, '8' as ck_class_parent, '36' as ck_class_child, '8' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
