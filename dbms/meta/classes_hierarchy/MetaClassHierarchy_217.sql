--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_217 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '745' as ck_id, '137' as ck_class_parent, '217' as ck_class_child, '621' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '305' as ck_id, '217' as ck_class_parent, '1' as ck_class_child, '829' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '6ECB01E1F7204763BFA9757B000DC382' as ck_id, '217' as ck_class_parent, '10457' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '306' as ck_id, '217' as ck_class_parent, '137' as ck_class_child, '829' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '2987' as ck_id, '217' as ck_class_parent, '1457' as ck_class_child, '830' as ck_class_attr, '10020785' as ck_user, '2018-07-15T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '70AFFAE8700047718C07D42E32582473' as ck_id, '217' as ck_class_parent, '15593D209A1D46FC873706F69EE71E7A' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '946' as ck_id, '217' as ck_class_parent, '19' as ck_class_child, '830' as ck_class_attr, '10020785' as ck_user, '2018-04-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '8569D4A0A15844B88C06CC199060F024' as ck_id, '217' as ck_class_parent, '197' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '4672AA83E0D742909BF62D286EA12CAA' as ck_id, '217' as ck_class_parent, '26' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '5B022A26D71E4D5FB27D81530D2223D4' as ck_id, '217' as ck_class_parent, '27' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'ACBF835A40FB4F61B4F3DC59D9B526E8' as ck_id, '217' as ck_class_parent, '28' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '5BD64543ED034386B342763E718E39A2' as ck_id, '217' as ck_class_parent, '29' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '33ED751DCA3947718B2657D549970712' as ck_id, '217' as ck_class_parent, '30' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'C8BBBF074B364F2DA659D161010FDF2F' as ck_id, '217' as ck_class_parent, '31' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'AAD1E30A47E6463CB0D9ACAEBC4417DD' as ck_id, '217' as ck_class_parent, '317' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'CD94973B33ED4C068436CB4A13533DDB' as ck_id, '217' as ck_class_parent, '33' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'A813770F1055425D926777D11F283C05' as ck_id, '217' as ck_class_parent, '357' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'BC014BF9468D4827A06106479CB83857' as ck_id, '217' as ck_class_parent, '37' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '251C033504A043E2876245CB730B7E51' as ck_id, '217' as ck_class_parent, '38' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '846F19CBBE0B41CC9D200C66C14B3FB1' as ck_id, '217' as ck_class_parent, '417' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'C8A8F375B5DE4814AEA9F257A54EF3DD' as ck_id, '217' as ck_class_parent, '4457' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '2D744CBAA37748CC935FCE2CD1DFEDE1' as ck_id, '217' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'A8F6E36B537C4AFF813110400662A35D' as ck_id, '217' as ck_class_parent, '508B0DE5C67B464CB3A5CED4DF778084' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '56D8DBF0B2D34923894654C8323FFEA6' as ck_id, '217' as ck_class_parent, '5833D73B31E04F8ABE9D307DBCE845A9' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '31270467483E449A8B6D0D129AA0CE40' as ck_id, '217' as ck_class_parent, '5F229304828F4AADBF9B0BE6463B1248' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:23:06.119+0000'::timestamp with time zone as ct_change
    union all
    select 'DC8D9E8679D741A78770879CA9EE166E' as ck_id, '217' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'BD4712C098DB407D81CDC45EC21DCB14' as ck_id, '217' as ck_class_parent, '6B1F10465BA848B4BF8E75924A6268A2' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '0EAF6B5379C14BE5B93EF96ECE18C775' as ck_id, '217' as ck_class_parent, '7457' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'D34644DED7504C57BC2BB31394FA0FD8' as ck_id, '217' as ck_class_parent, '7C133EA0021A44A0864B82F7BC40F183' as ck_class_child, '91BEE2DE87E64937A1F1EC6339BB79D9' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-11-08T14:37:06.732+0000'::timestamp with time zone as ct_change
    union all
    select 'EBC9A9227FB340A3A3A28522ECD05A02' as ck_id, '217' as ck_class_parent, '8457' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'D0F6B6CADA4F4A2BB32C40EF3F8D993C' as ck_id, '217' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '4C4BA563B08E449FA5A2EA2F364C2F94' as ck_id, '217' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-09-30T06:33:49.384+0000'::timestamp with time zone as ct_change
    union all
    select 'CB8795F10DCA4E82BBE424387F2F9A8F' as ck_id, '217' as ck_class_parent, '8AE3079CC4F64CB9873777921A62CF14' as ck_class_child, '830' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-28T14:52:28.823+0000'::timestamp with time zone as ct_change
    union all
    select 'C28A691EE5324BC18072BA6C4E1CB266' as ck_id, '217' as ck_class_parent, '8C96F9B255F5407FBCB8DE9189B15F39' as ck_class_child, '830' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-11-18T12:15:34.260+0000'::timestamp with time zone as ct_change
    union all
    select '9E19FEB1C88B4BEE80D463A530708E02' as ck_id, '217' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '0E3E2FB9209E4C71B6A047C37E858185' as ck_id, '217' as ck_class_parent, '8E6AC2B44FCB8D3BE053809BA8C0E74D' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'BD8C7CA775B147898C92B389FDB33C7D' as ck_id, '217' as ck_class_parent, '97' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'A1E50603144C4F8B8595F2167B067CE2' as ck_id, '217' as ck_class_parent, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'D05609828237434CB692D2C8550B4B27' as ck_id, '217' as ck_class_parent, '9CC06E8D9D7E4791BA1C6232DAF60CDD' as ck_class_child, '830' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:31:51.050+0000'::timestamp with time zone as ct_change
    union all
    select 'F598AC63012B48E086B56445E98213E2' as ck_id, '217' as ck_class_parent, 'DA77FDDE896F48909B19EBB516326D33' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '7330FFDECCF84C3687D06690515D3AF4' as ck_id, '217' as ck_class_parent, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:41:18.494+0000'::timestamp with time zone as ct_change
    union all
    select '308' as ck_id, '35' as ck_class_parent, '217' as ck_class_child, '172' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
