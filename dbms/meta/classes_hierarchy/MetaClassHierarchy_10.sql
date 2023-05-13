--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_10 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '11995' as ck_id, '10' as ck_class_parent, '10457' as ck_class_child, '40' as ck_class_attr, '30021381' as ck_user, '2019-01-24T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '7CB2B2B6555C49A086E667BC445CCBF4' as ck_id, '10' as ck_class_parent, '15593D209A1D46FC873706F69EE71E7A' as ck_class_child, '40' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '805' as ck_id, '10' as ck_class_parent, '17' as ck_class_child, '40' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'DA7BD3702880425D8B6332D0B4774412' as ck_id, '10' as ck_class_parent, '197' as ck_class_child, '40' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '48' as ck_id, '10' as ck_class_parent, '26' as ck_class_child, '40' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '49' as ck_id, '10' as ck_class_parent, '27' as ck_class_child, '40' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '50' as ck_id, '10' as ck_class_parent, '28' as ck_class_child, '40' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '51' as ck_id, '10' as ck_class_parent, '29' as ck_class_child, '40' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '52' as ck_id, '10' as ck_class_parent, '30' as ck_class_child, '40' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '53' as ck_id, '10' as ck_class_parent, '31' as ck_class_child, '40' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '626' as ck_id, '10' as ck_class_parent, '33' as ck_class_child, '40' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '378634ECC459479EABCC45377038F176' as ck_id, '10' as ck_class_parent, '357' as ck_class_child, '40' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '36A9FA9CAFE744AE907F6252D9A8EC46' as ck_id, '10' as ck_class_parent, '37' as ck_class_child, '40' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '806' as ck_id, '10' as ck_class_parent, '38' as ck_class_child, '40' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '0881EF47749A4AB48FA3636CFC8A21E1' as ck_id, '10' as ck_class_parent, '417' as ck_class_child, '40' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'A8C580328EAB489CB1DB135F4D5341DE' as ck_id, '10' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '40' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'D2FF671999E34F35939C15D46DC8AA7D' as ck_id, '10' as ck_class_parent, '508B0DE5C67B464CB3A5CED4DF778084' as ck_class_child, '40' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:14.957+0000'::timestamp with time zone as ct_change
    union all
    select '52BE99BDF2FB4117A76F1D473210E025' as ck_id, '10' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '40' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'CED0AF105A4A48FD80866026093021DC' as ck_id, '10' as ck_class_parent, '6B1F10465BA848B4BF8E75924A6268A2' as ck_class_child, '40' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '71DEAD1FAA0D43F98214EAF68C324E64' as ck_id, '10' as ck_class_parent, '7457' as ck_class_child, '40' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'FF4F00189C8C48A4B4748A283A07EFAE' as ck_id, '10' as ck_class_parent, '8457' as ck_class_child, '40' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'A72010936FC24CB3BD2C91CFC6E12799' as ck_id, '10' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '40' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '1A162AADC1874FE0B546217B7D676605' as ck_id, '10' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '40' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:37:38.715+0000'::timestamp with time zone as ct_change
    union all
    select 'BD4157E7C46D444FA3BCC203ED09E571' as ck_id, '10' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '40' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '06D02D9E5FD24A208F0198792C1B9F07' as ck_id, '10' as ck_class_parent, '8E6AC2B44FCB8D3BE053809BA8C0E74D' as ck_class_child, '40' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '97761246D04245E9A98EC22204336C03' as ck_id, '10' as ck_class_parent, '97' as ck_class_child, '40' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'A69CF7F67B8649BAB24FA91F1550DDEF' as ck_id, '10' as ck_class_parent, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_child, '40' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '2367FEA4E6E4445D9A8145A97020670D' as ck_id, '10' as ck_class_parent, 'DA77FDDE896F48909B19EBB516326D33' as ck_class_child, '40' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '9985' as ck_id, '18' as ck_class_parent, '10' as ck_class_child, '27' as ck_class_attr, '20788' as ck_user, '2019-01-16T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '93' as ck_id, '37' as ck_class_parent, '10' as ck_class_child, '270' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '89' as ck_id, '38' as ck_class_parent, '10' as ck_class_child, '306' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '807' as ck_id, '77' as ck_class_parent, '10' as ck_class_child, '450' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '2' as ck_id, '8' as ck_class_parent, '10' as ck_class_child, '8' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
