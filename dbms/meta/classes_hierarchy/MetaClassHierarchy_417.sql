--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_417 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '8F7C9522838F4E5DAB22B2F25C96B26D' as ck_id, '1' as ck_class_parent, '417' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-05-09T10:29:42.141+0000'::timestamp with time zone as ct_change
    union all
    select '37B9E4446AE648A78E9D6628410B15E4' as ck_id, '137' as ck_class_parent, '417' as ck_class_child, '621' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '158FE8DE605E46868B3CD3CF3E52ECAB' as ck_id, '17' as ck_class_parent, '417' as ck_class_child, '524' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'F11BFC7FFB44475EA6DE431B901F29C1' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '417' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '846F19CBBE0B41CC9D200C66C14B3FB1' as ck_id, '217' as ck_class_parent, '417' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '44DB8433C10845FAAD218CE69310AB49' as ck_id, '32' as ck_class_parent, '417' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-05-09T10:29:57.047+0000'::timestamp with time zone as ct_change
    union all
    select '11809BABBC3E4AA08E2C0A5ACE5C5F18' as ck_id, '417' as ck_class_parent, '1' as ck_class_child, '1850' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:32:54.499+0000'::timestamp with time zone as ct_change
    union all
    select '11987' as ck_id, '417' as ck_class_parent, '10457' as ck_class_child, '1850' as ck_class_attr, '30021381' as ck_user, '2019-01-24T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '6CC42020B35C40D9B3B76AE637CA1F9F' as ck_id, '417' as ck_class_parent, '15593D209A1D46FC873706F69EE71E7A' as ck_class_child, '1850' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '888' as ck_id, '417' as ck_class_parent, '197' as ck_class_child, '1850' as ck_class_attr, '10020786' as ck_user, '2018-03-05T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '898' as ck_id, '417' as ck_class_parent, '26' as ck_class_child, '1850' as ck_class_attr, '10020786' as ck_user, '2018-03-05T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '894' as ck_id, '417' as ck_class_parent, '27' as ck_class_child, '1850' as ck_class_attr, '10020786' as ck_user, '2018-03-05T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '896' as ck_id, '417' as ck_class_parent, '28' as ck_class_child, '1850' as ck_class_attr, '10020786' as ck_user, '2018-03-05T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '886' as ck_id, '417' as ck_class_parent, '29' as ck_class_child, '1850' as ck_class_attr, '10020786' as ck_user, '2018-03-05T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '890' as ck_id, '417' as ck_class_parent, '30' as ck_class_child, '1850' as ck_class_attr, '10020786' as ck_user, '2018-03-05T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'C7F83B3E646049CABFC64D17E7F5DBD0' as ck_id, '417' as ck_class_parent, '3061ADE6780F432B93F17C1DCCC33D93' as ck_class_child, '1850' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:35.711+0000'::timestamp with time zone as ct_change
    union all
    select '887' as ck_id, '417' as ck_class_parent, '31' as ck_class_child, '1850' as ck_class_attr, '10020786' as ck_user, '2018-03-05T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'F661587F1D7E415B9387C908D8B74D89' as ck_id, '417' as ck_class_parent, '317' as ck_class_child, '1850' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '893' as ck_id, '417' as ck_class_parent, '33' as ck_class_child, '1850' as ck_class_attr, '10020786' as ck_user, '2018-03-05T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '889' as ck_id, '417' as ck_class_parent, '357' as ck_class_child, '1850' as ck_class_attr, '10020786' as ck_user, '2018-03-05T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '899' as ck_id, '417' as ck_class_parent, '37' as ck_class_child, '1850' as ck_class_attr, '10020786' as ck_user, '2018-03-05T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '892' as ck_id, '417' as ck_class_parent, '38' as ck_class_child, '1850' as ck_class_attr, '10020786' as ck_user, '2018-03-05T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '897' as ck_id, '417' as ck_class_parent, '417' as ck_class_child, '1850' as ck_class_attr, '10020786' as ck_user, '2018-03-05T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '5986' as ck_id, '417' as ck_class_parent, '4457' as ck_class_child, '1850' as ck_class_attr, '10020785' as ck_user, '2018-10-07T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '260A64B29DED4A7C83F922C7D915EAC2' as ck_id, '417' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '1850' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '0567A396904E4C72B072F3DC2F2EEA19' as ck_id, '417' as ck_class_parent, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_child, '1850' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T10:01:15.179+0000'::timestamp with time zone as ct_change
    union all
    select 'A4EEF048DA424C3285675F2B1D0D464D' as ck_id, '417' as ck_class_parent, '508B0DE5C67B464CB3A5CED4DF778084' as ck_class_child, '1850' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:14.957+0000'::timestamp with time zone as ct_change
    union all
    select '01F71E2674CD4904BCC717E0033E6CF2' as ck_id, '417' as ck_class_parent, '5833D73B31E04F8ABE9D307DBCE845A9' as ck_class_child, '1850' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'E9797D3DAA794ACBB8AB854931E1CFBF' as ck_id, '417' as ck_class_parent, '5F229304828F4AADBF9B0BE6463B1248' as ck_class_child, '1850' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:23:06.119+0000'::timestamp with time zone as ct_change
    union all
    select '0DB977E7AA394AAFA6C29C82CE1F2C33' as ck_id, '417' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '1850' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '5AB11493B97A403B913B3881B5243B11' as ck_id, '417' as ck_class_parent, '6B1F10465BA848B4BF8E75924A6268A2' as ck_class_child, '1850' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '02F41B760C5C40DB8AC1BD3F67F02817' as ck_id, '417' as ck_class_parent, '7457' as ck_class_child, '1850' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '76476193BD46463DA1310A65E6D89E99' as ck_id, '417' as ck_class_parent, '8457' as ck_class_child, '1850' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'E34A2CDA2EE9477D8C1DD72E237E9D61' as ck_id, '417' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '1850' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-11T07:57:28.489+0000'::timestamp with time zone as ct_change
    union all
    select 'D5F09EA7F9724EF194F2DD09CFF266F0' as ck_id, '417' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '1850' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:38:16.403+0000'::timestamp with time zone as ct_change
    union all
    select '8D2BA0EF3703627EE053809BA8C0076B' as ck_id, '417' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '1850' as ck_class_attr, '20785' as ck_user, '2019-07-13T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'EE7832C77FC0440BAFEBEE0754CE4168' as ck_id, '417' as ck_class_parent, '8E6AC2B44FCB8D3BE053809BA8C0E74D' as ck_class_child, '1850' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'CE4E5A1B7A6D426AB0458D03E046B133' as ck_id, '417' as ck_class_parent, '97' as ck_class_child, '1850' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'BE86BDC12DC34735870722B9EAD98323' as ck_id, '417' as ck_class_parent, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_child, '1850' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '0058B13FB7B64FF8B7C9353121D08DC8' as ck_id, '417' as ck_class_parent, 'DA77FDDE896F48909B19EBB516326D33' as ck_class_child, '1850' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'CAEDBBF6EF3D494CB5EC8922BEB64B4B' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '417' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:58:56.697+0000'::timestamp with time zone as ct_change
    union all
    select 'C89714BBCF864710BA528C759EAFB6D6' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '417' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'A0915444A38B403780EECCC9209CA8CE' as ck_id, '58' as ck_class_parent, '417' as ck_class_child, '382' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '3A74D67E004E47589A588117E56F94D6' as ck_id, '6457' as ck_class_parent, '417' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'F07203F5DB844932AC3E58B511C75041' as ck_id, '7457' as ck_class_parent, '417' as ck_class_child, '37172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '87A9EF4DBB2F5226E053809BA8C0E1C2' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '417' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '20785' as ck_user, '2019-05-16T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '274F2B5D40E14D909D5EBD1E35847406' as ck_id, '9' as ck_class_parent, '417' as ck_class_child, '39' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'BC77BE97AE904C199C8250B91940064F' as ck_id, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_parent, '417' as ck_class_child, '4F0C103E377040179EF412F13E09D265' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-17T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '94C7FC37C7E44FD9912B6BA5E14EC864' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '417' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'AB921101C95B47438D311EA315E65F91' as ck_id, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_parent, '417' as ck_class_child, 'E2D0A96506384965A7B2666E5D2D1970' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
