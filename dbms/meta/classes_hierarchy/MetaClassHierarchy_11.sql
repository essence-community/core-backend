--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_11 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '4029AE0FD2FA49EA96E435523D2FDF3D' as ck_id, '11' as ck_class_parent, '10457' as ck_class_child, '43' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '059ADDF8D150411AAC644611FDCF9E60' as ck_id, '11' as ck_class_parent, '15593D209A1D46FC873706F69EE71E7A' as ck_class_child, '43' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '9351AB24D45B4940A60E8B38E752125B' as ck_id, '11' as ck_class_parent, '197' as ck_class_child, '43' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'DE8BB6665D854438B8915BBE766BB7D9' as ck_id, '11' as ck_class_parent, '26' as ck_class_child, '43' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '35EDCA2776E74BCC815B93AC6399D087' as ck_id, '11' as ck_class_parent, '27' as ck_class_child, '43' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'DE21A7DB4DC54BDA9BCE2897ED238CD3' as ck_id, '11' as ck_class_parent, '28' as ck_class_child, '43' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '56' as ck_id, '11' as ck_class_parent, '29' as ck_class_child, '43' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '55' as ck_id, '11' as ck_class_parent, '30' as ck_class_child, '43' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '54' as ck_id, '11' as ck_class_parent, '31' as ck_class_child, '43' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '629' as ck_id, '11' as ck_class_parent, '33' as ck_class_child, '43' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '759310417E0649E2AB59D25BCE0AD662' as ck_id, '11' as ck_class_parent, '357' as ck_class_child, '43' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'C44DEE537D6C4B75893F3A808D8F7FB6' as ck_id, '11' as ck_class_parent, '37' as ck_class_child, '43' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '592B206BF34A498DBD6F381B86F30509' as ck_id, '11' as ck_class_parent, '38' as ck_class_child, '43' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'C086DDC1FC30401D8241C8885F334130' as ck_id, '11' as ck_class_parent, '417' as ck_class_child, '43' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '25FC2A2CAE3D4728A75A6E910491DF1D' as ck_id, '11' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '43' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '70B793C8A45C4469A935A31AAF824F72' as ck_id, '11' as ck_class_parent, '508B0DE5C67B464CB3A5CED4DF778084' as ck_class_child, '43' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '3AF2614A2162434F9AEB61FFC99933E2' as ck_id, '11' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '43' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '9390F68A830B41FAA6673137DC822224' as ck_id, '11' as ck_class_parent, '6B1F10465BA848B4BF8E75924A6268A2' as ck_class_child, '43' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '573812C2B2624EE48AE5030DFF5FCE19' as ck_id, '11' as ck_class_parent, '7457' as ck_class_child, '43' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '3929E7C2CF7F47AE9DF38251D2D306F9' as ck_id, '11' as ck_class_parent, '8457' as ck_class_child, '43' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '724962CD79BE48FAAFE1F65F6C9F8D56' as ck_id, '11' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '43' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '5C12F0ADEBD7434788350907CDF407AB' as ck_id, '11' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '43' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:37:38.715+0000'::timestamp with time zone as ct_change
    union all
    select '3FD90C812CE644B782F0254C3106C837' as ck_id, '11' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '43' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'B95758AC5A834ED69FAAD06C3B43CF09' as ck_id, '11' as ck_class_parent, '8E6AC2B44FCB8D3BE053809BA8C0E74D' as ck_class_child, '43' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'D411F951E0FD4115972D4A7E37303575' as ck_id, '11' as ck_class_parent, '97' as ck_class_child, '43' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '28D67792A97A4BD5A32CAD0F94C65DF7' as ck_id, '11' as ck_class_parent, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_child, '43' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'A64EEDBC6D0F404DA588881042EB94C6' as ck_id, '11' as ck_class_parent, 'DA77FDDE896F48909B19EBB516326D33' as ck_class_child, '43' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '925' as ck_id, '18' as ck_class_parent, '11' as ck_class_child, '27' as ck_class_attr, '10020786' as ck_user, '2018-04-19T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '131' as ck_id, '37' as ck_class_parent, '11' as ck_class_child, '270' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '90' as ck_id, '38' as ck_class_parent, '11' as ck_class_child, '306' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '3' as ck_id, '8' as ck_class_parent, '11' as ck_class_child, '8' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
