--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_77 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '128' as ck_id, '18' as ck_class_parent, '77' as ck_class_child, '27' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '130' as ck_id, '37' as ck_class_parent, '77' as ck_class_child, '270' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '129' as ck_id, '38' as ck_class_parent, '77' as ck_class_child, '306' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '807' as ck_id, '77' as ck_class_parent, '10' as ck_class_child, '450' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '11994' as ck_id, '77' as ck_class_parent, '10457' as ck_class_child, '450' as ck_class_attr, '30021381' as ck_user, '2019-01-24T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'DBC99C1FAA744D3291EEE5458EC507BD' as ck_id, '77' as ck_class_parent, '15593D209A1D46FC873706F69EE71E7A' as ck_class_child, '450' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '4A1BC929798A4FE29D72A187B0009875' as ck_id, '77' as ck_class_parent, '197' as ck_class_child, '450' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '608' as ck_id, '77' as ck_class_parent, '26' as ck_class_child, '450' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '88882EDED62544E0840C550E23A72349' as ck_id, '77' as ck_class_parent, '27' as ck_class_child, '450' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'EAE9DD75951543F78DE28AD222CB7980' as ck_id, '77' as ck_class_parent, '28' as ck_class_child, '450' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '4477875572254354BB7F363EDB4E11A8' as ck_id, '77' as ck_class_parent, '29' as ck_class_child, '450' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'E30B1280591E43E0891FE520B10BC93B' as ck_id, '77' as ck_class_parent, '30' as ck_class_child, '450' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '948810B1F39F4B7D9062C74246BA8A6C' as ck_id, '77' as ck_class_parent, '3061ADE6780F432B93F17C1DCCC33D93' as ck_class_child, '450' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:35.711+0000'::timestamp with time zone as ct_change
    union all
    select '809' as ck_id, '77' as ck_class_parent, '31' as ck_class_child, '450' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '625' as ck_id, '77' as ck_class_parent, '33' as ck_class_child, '450' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'C0E721AC1B5241BDA6924EC4971AA4AE' as ck_id, '77' as ck_class_parent, '357' as ck_class_child, '450' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'C809404517C84BAF81A9EA654E3CA890' as ck_id, '77' as ck_class_parent, '37' as ck_class_child, '450' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '808' as ck_id, '77' as ck_class_parent, '38' as ck_class_child, '450' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '52917B55DD724931A39F06D0EAD9F221' as ck_id, '77' as ck_class_parent, '417' as ck_class_child, '450' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '22BBF7529E2B4D98854061E09737A917' as ck_id, '77' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '450' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '0CE4E1428AA04B159DFD8B6FF71FE934' as ck_id, '77' as ck_class_parent, '508B0DE5C67B464CB3A5CED4DF778084' as ck_class_child, '450' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:14.957+0000'::timestamp with time zone as ct_change
    union all
    select '8B99B16159574099B6197EA1B7BF9CAB' as ck_id, '77' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '450' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '0B2A6AD28D404B57ABC3EE7EF51C2717' as ck_id, '77' as ck_class_parent, '6B1F10465BA848B4BF8E75924A6268A2' as ck_class_child, '450' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '007FA822B8C64C18B54C099854AE5C9F' as ck_id, '77' as ck_class_parent, '7457' as ck_class_child, '450' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '607' as ck_id, '77' as ck_class_parent, '77' as ck_class_child, '450' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '70B8F15E5BAB4CA9B8BB2B9C4B5D8B63' as ck_id, '77' as ck_class_parent, '8457' as ck_class_child, '450' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '389014E5DC644A5FAA9F5D5613F01A90' as ck_id, '77' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '450' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '7BA31FC72371405C9B7800B7D24F5726' as ck_id, '77' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '450' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:37:38.715+0000'::timestamp with time zone as ct_change
    union all
    select 'DFA51AFA878441D29AB751023003FC57' as ck_id, '77' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '450' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'E633E245B5CA4F9C927B69D2834E8B1C' as ck_id, '77' as ck_class_parent, '8E6AC2B44FCB8D3BE053809BA8C0E74D' as ck_class_child, '450' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'D54DCCD7522148A09E1C60D59FEE2506' as ck_id, '77' as ck_class_parent, '97' as ck_class_child, '450' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '1EEB722EECC54EFDB22D435FE19187FD' as ck_id, '77' as ck_class_parent, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_child, '450' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '3351A4B2F26247C183B06DE53F2FAD36' as ck_id, '77' as ck_class_parent, 'DA77FDDE896F48909B19EBB516326D33' as ck_class_child, '450' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '127' as ck_id, '8' as ck_class_parent, '77' as ck_class_child, '8' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
