--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_EC0610DA03D748E3B3086F49BEEE94ED dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select 'C2AC2D9A45764B6191999A511188722B' as ck_id, '1' as ck_class_parent, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:39:48.582+0000'::timestamp with time zone as ct_change
    union all
    select '06F6B6006D984B17A1BF17E431D23318' as ck_id, '10' as ck_class_parent, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_child, '40' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:43:57.245+0000'::timestamp with time zone as ct_change
    union all
    select '446207585E4049919441FD493DFCAD1B' as ck_id, '17' as ck_class_parent, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_child, '524' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:42:40.835+0000'::timestamp with time zone as ct_change
    union all
    select '7330FFDECCF84C3687D06690515D3AF4' as ck_id, '217' as ck_class_parent, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:41:18.494+0000'::timestamp with time zone as ct_change
    union all
    select '8E42D006A88143E486E6B4C4515B6983' as ck_id, '32' as ck_class_parent, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:42:01.109+0000'::timestamp with time zone as ct_change
    union all
    select 'E393076A80D545FC9411E56F3D5230BE' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:41:32.155+0000'::timestamp with time zone as ct_change
    union all
    select '018FAA2157124C38ABC2BCA5E71C4C0B' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:40:18.177+0000'::timestamp with time zone as ct_change
    union all
    select 'C11EFE5E82E545D0BA93954EE6C73BF4' as ck_id, '58' as ck_class_parent, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_child, '382' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:40:08.317+0000'::timestamp with time zone as ct_change
    union all
    select '8208F5E4426943DCB9E2F3A06122BDE5' as ck_id, '6457' as ck_class_parent, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:40:52.011+0000'::timestamp with time zone as ct_change
    union all
    select '22C5D59B778649E1915C6F3C8D18CFEF' as ck_id, '77' as ck_class_parent, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_child, '450' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:43:43.156+0000'::timestamp with time zone as ct_change
    union all
    select '48241F825C6542829A996B41F4B14A8A' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:40:29.676+0000'::timestamp with time zone as ct_change
    union all
    select '0EB077A0C13B459FA9B4AD30629159D6' as ck_id, '9' as ck_class_parent, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_child, '39' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:43:02.233+0000'::timestamp with time zone as ct_change
    union all
    select 'BD5A374F0F024B30937BB871BF5A4A86' as ck_id, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_parent, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_child, 'E2D0A96506384965A7B2666E5D2D1970' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:42:21.548+0000'::timestamp with time zone as ct_change
    union all
    select '6388CAB7F1034A058AE5CA1325F50D93' as ck_id, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_parent, '1' as ck_class_child, 'EEBFE7B1ABBA407EAA22DE1DB8960C9C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:30:33.498+0000'::timestamp with time zone as ct_change
    union all
    select '42BF17F9DFE54694BF7953140BBD6D4B' as ck_id, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_parent, '10457' as ck_class_child, 'EEBFE7B1ABBA407EAA22DE1DB8960C9C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:37:23.371+0000'::timestamp with time zone as ct_change
    union all
    select 'F0CB3548C4634030939BFAADA7F5DB46' as ck_id, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_parent, '137' as ck_class_child, 'EEBFE7B1ABBA407EAA22DE1DB8960C9C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:30:22.981+0000'::timestamp with time zone as ct_change
    union all
    select '3CFA93667B8F4A389C0BBAE457C2F8FB' as ck_id, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_parent, '15593D209A1D46FC873706F69EE71E7A' as ck_class_child, 'EEBFE7B1ABBA407EAA22DE1DB8960C9C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:31:20.092+0000'::timestamp with time zone as ct_change
    union all
    select '6F67D42EC4AA4BFAA32B1C28CCD266B6' as ck_id, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_parent, '26' as ck_class_child, 'EEBFE7B1ABBA407EAA22DE1DB8960C9C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:37:06.047+0000'::timestamp with time zone as ct_change
    union all
    select '4E4992E55402485F8796E26923031DA9' as ck_id, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_parent, '27' as ck_class_child, 'EEBFE7B1ABBA407EAA22DE1DB8960C9C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:34:56.838+0000'::timestamp with time zone as ct_change
    union all
    select 'DDFB7D20DED74E7788F106127C53516A' as ck_id, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_parent, '28' as ck_class_child, 'EEBFE7B1ABBA407EAA22DE1DB8960C9C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:35:20.628+0000'::timestamp with time zone as ct_change
    union all
    select '5D1469D17BBA48BCB7E295DB3FC656C4' as ck_id, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_parent, '29' as ck_class_child, 'EEBFE7B1ABBA407EAA22DE1DB8960C9C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:31:10.465+0000'::timestamp with time zone as ct_change
    union all
    select '4EABD401EE79470B8F591237118ECDED' as ck_id, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_parent, '30' as ck_class_child, 'EEBFE7B1ABBA407EAA22DE1DB8960C9C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:33:00.155+0000'::timestamp with time zone as ct_change
    union all
    select '86989FD6640244279032406EE4A9D38F' as ck_id, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_parent, '31' as ck_class_child, 'EEBFE7B1ABBA407EAA22DE1DB8960C9C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:31:30.267+0000'::timestamp with time zone as ct_change
    union all
    select 'F2EB6097544E4327AF6C2A59189DC4F7' as ck_id, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_parent, '33' as ck_class_child, 'EEBFE7B1ABBA407EAA22DE1DB8960C9C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:33:52.143+0000'::timestamp with time zone as ct_change
    union all
    select '8DE72EA3FEBE4990A6289121DD104299' as ck_id, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_parent, '37' as ck_class_child, 'EEBFE7B1ABBA407EAA22DE1DB8960C9C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:33:38.529+0000'::timestamp with time zone as ct_change
    union all
    select '5EEB2C84B1B6425CBF983F823BC69E21' as ck_id, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_parent, '38' as ck_class_child, 'EEBFE7B1ABBA407EAA22DE1DB8960C9C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:33:23.648+0000'::timestamp with time zone as ct_change
    union all
    select '0F0D8D41459746339FB868134FB4E8DD' as ck_id, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_parent, '417' as ck_class_child, 'EEBFE7B1ABBA407EAA22DE1DB8960C9C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:36:54.154+0000'::timestamp with time zone as ct_change
    union all
    select '6786BBF4283C4AD99F65A29E9651A62B' as ck_id, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, 'EEBFE7B1ABBA407EAA22DE1DB8960C9C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:34:13.019+0000'::timestamp with time zone as ct_change
    union all
    select '9FB565B06F30401D842E2DF8C0113B1B' as ck_id, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_parent, '508B0DE5C67B464CB3A5CED4DF778084' as ck_class_child, 'EEBFE7B1ABBA407EAA22DE1DB8960C9C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:35:31.326+0000'::timestamp with time zone as ct_change
    union all
    select '6C57356A404C4F2D8AEEEC5950FA72D1' as ck_id, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, 'EEBFE7B1ABBA407EAA22DE1DB8960C9C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:33:09.506+0000'::timestamp with time zone as ct_change
    union all
    select '3F9135BAD0B44A2396BF42638D16DA73' as ck_id, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_parent, '6B1F10465BA848B4BF8E75924A6268A2' as ck_class_child, 'EEBFE7B1ABBA407EAA22DE1DB8960C9C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:36:31.398+0000'::timestamp with time zone as ct_change
    union all
    select '839F015C54B148C6B02BA74CCD8A6BF3' as ck_id, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_parent, '7457' as ck_class_child, 'EEBFE7B1ABBA407EAA22DE1DB8960C9C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:34:02.345+0000'::timestamp with time zone as ct_change
    union all
    select 'F0607FD795DA45A18AB0FF1D82CFC356' as ck_id, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_parent, '7C133EA0021A44A0864B82F7BC40F183' as ck_class_child, '050ED34621EC42A48AE146B20B038DFE' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:30:51.773+0000'::timestamp with time zone as ct_change
    union all
    select '3B93A56C39E14C778D35DB1BAC462CEA' as ck_id, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_parent, '8457' as ck_class_child, 'EEBFE7B1ABBA407EAA22DE1DB8960C9C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:35:45.424+0000'::timestamp with time zone as ct_change
    union all
    select '12004615278A466183E771172C229F86' as ck_id, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, 'EEBFE7B1ABBA407EAA22DE1DB8960C9C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:32:17.094+0000'::timestamp with time zone as ct_change
    union all
    select 'DED9C3BE018F4F179C50C5D41AD08B39' as ck_id, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, 'EEBFE7B1ABBA407EAA22DE1DB8960C9C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:36:21.855+0000'::timestamp with time zone as ct_change
    union all
    select '4848FE529F2541ADA52077E861E4E113' as ck_id, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_parent, '8E6AC2B44FCB8D3BE053809BA8C0E74D' as ck_class_child, 'EEBFE7B1ABBA407EAA22DE1DB8960C9C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:34:48.851+0000'::timestamp with time zone as ct_change
    union all
    select '662AAFAAD43949F99E03D4702F97ABD3' as ck_id, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_parent, '97' as ck_class_child, 'EEBFE7B1ABBA407EAA22DE1DB8960C9C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:35:59.669+0000'::timestamp with time zone as ct_change
    union all
    select '6A14024D3CDB4E25AEC8ADE461FABAE5' as ck_id, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_parent, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_child, 'EEBFE7B1ABBA407EAA22DE1DB8960C9C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:36:43.449+0000'::timestamp with time zone as ct_change
    union all
    select '9A0854A4B7EB4B598414CB53B2F357EF' as ck_id, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_parent, 'DA77FDDE896F48909B19EBB516326D33' as ck_class_child, 'EEBFE7B1ABBA407EAA22DE1DB8960C9C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:31:01.649+0000'::timestamp with time zone as ct_change
    union all
    select 'A6195A8B1FFE47928DD122910FC39B0D' as ck_id, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_parent, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_child, 'EEBFE7B1ABBA407EAA22DE1DB8960C9C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:36:11.737+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
