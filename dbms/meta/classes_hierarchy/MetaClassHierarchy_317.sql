--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_317 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '703AC7D46C6946838D2D0EC2AC155D3B' as ck_id, '1' as ck_class_parent, '317' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '566' as ck_id, '137' as ck_class_parent, '317' as ck_class_child, '621' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '8DF8A5A90BDC4F91A40071F2581E32D9' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '317' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'AAD1E30A47E6463CB0D9ACAEBC4417DD' as ck_id, '217' as ck_class_parent, '317' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '565' as ck_id, '317' as ck_class_parent, '8' as ck_class_child, '1149' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '885' as ck_id, '32' as ck_class_parent, '317' as ck_class_child, '138' as ck_class_attr, '10020785' as ck_user, '2018-03-05T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'F661587F1D7E415B9387C908D8B74D89' as ck_id, '417' as ck_class_parent, '317' as ck_class_child, '1850' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'E632B7DAF36445BCB72812591EEB37B1' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '317' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '081B83167F844C8CA5C868CDC1EBC16B' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '317' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'AF5185B421174BA2B15515068CE50E85' as ck_id, '58' as ck_class_parent, '317' as ck_class_child, '382' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '37A375F940CA419885C2B2A5E3B17EC9' as ck_id, '6457' as ck_class_parent, '317' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '4FEE8CBB77CD4D1A899AF643057FAFE4' as ck_id, '7457' as ck_class_parent, '317' as ck_class_child, '37172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '87BF545279B313EDE053809BA8C0A884' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '317' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '20785' as ck_user, '2019-05-16T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '846' as ck_id, '9' as ck_class_parent, '317' as ck_class_child, '39' as ck_class_attr, '10020785' as ck_user, '2018-02-28T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '4405DAE3F4AE478CB0E0B9B8EF635A60' as ck_id, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_parent, '317' as ck_class_child, '4F0C103E377040179EF412F13E09D265' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-17T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'F0871185D0A048ADAC772580027DAFEF' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '317' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'DAE0E9F0430B4C8EA9AF317A399604DA' as ck_id, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_parent, '317' as ck_class_child, 'E2D0A96506384965A7B2666E5D2D1970' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
