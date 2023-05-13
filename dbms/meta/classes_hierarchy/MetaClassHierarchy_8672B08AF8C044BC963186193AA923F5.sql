--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_8672B08AF8C044BC963186193AA923F5 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '74824813DEC549BE9EBF5556DCC43300' as ck_id, '1' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-09-30T06:32:47.649+0000'::timestamp with time zone as ct_change
    union all
    select '1A162AADC1874FE0B546217B7D676605' as ck_id, '10' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '40' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:37:38.715+0000'::timestamp with time zone as ct_change
    union all
    select '5C12F0ADEBD7434788350907CDF407AB' as ck_id, '11' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '43' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:37:38.715+0000'::timestamp with time zone as ct_change
    union all
    select '5373425139E84A5E8F92CFC4CF7A8A0F' as ck_id, '137' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '621' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-09-30T06:33:25.467+0000'::timestamp with time zone as ct_change
    union all
    select '954EAA8F538C418782DE942BEA4FC41E' as ck_id, '17' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '524' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:37:38.715+0000'::timestamp with time zone as ct_change
    union all
    select 'BF85B01171364DE4B4366F1C5518ACD6' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:38:16.403+0000'::timestamp with time zone as ct_change
    union all
    select '4C4BA563B08E449FA5A2EA2F364C2F94' as ck_id, '217' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-09-30T06:33:49.384+0000'::timestamp with time zone as ct_change
    union all
    select 'CB306CE3F7EC43C69CB81846E6F6CC88' as ck_id, '32' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-09-30T06:34:35.943+0000'::timestamp with time zone as ct_change
    union all
    select 'AFF9FE270DCC4DB5BBCB6F6269805398' as ck_id, '35' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-09-30T06:34:19.340+0000'::timestamp with time zone as ct_change
    union all
    select 'B17512AF0B9C415C9A75AA53E54F1B53' as ck_id, '36' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '254' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:37:38.715+0000'::timestamp with time zone as ct_change
    union all
    select 'D5F09EA7F9724EF194F2DD09CFF266F0' as ck_id, '417' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '1850' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:38:16.403+0000'::timestamp with time zone as ct_change
    union all
    select 'E02D4B0403E147A7A4492EC76575FEE6' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-09-30T06:34:01.638+0000'::timestamp with time zone as ct_change
    union all
    select 'A7DA4ECF9B0C41168453AD28E4D845F3' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:38:16.403+0000'::timestamp with time zone as ct_change
    union all
    select '024903D72349465A8FFE151E8CCFB954' as ck_id, '58' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '382' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:38:16.403+0000'::timestamp with time zone as ct_change
    union all
    select '37DB8F31FF244EAD992C7F2B40315D0D' as ck_id, '6457' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-09-30T06:33:35.904+0000'::timestamp with time zone as ct_change
    union all
    select '842BDEDCFE4A4CF0996AA37C5B796669' as ck_id, '7457' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '37172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:38:16.403+0000'::timestamp with time zone as ct_change
    union all
    select '7BA31FC72371405C9B7800B7D24F5726' as ck_id, '77' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '450' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:37:38.715+0000'::timestamp with time zone as ct_change
    union all
    select 'BEE274C5DE2B4B508EF26B7A7D9A4763' as ck_id, '8672B08AF8C044BC963186193AA923F5' as ck_class_parent, '32' as ck_class_child, '020498F1380F44CF9C834F80C28DAD9E' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-10-10T11:09:13.447+0000'::timestamp with time zone as ct_change
    union all
    select 'F1C4BDF575B548C78617E24BB5E522E9' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:38:16.403+0000'::timestamp with time zone as ct_change
    union all
    select 'ECE80C37AF9446D78431FF625CD29C23' as ck_id, '9' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '39' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:37:38.715+0000'::timestamp with time zone as ct_change
    union all
    select '0394A204B8984DB2B8609AD2B61BE83C' as ck_id, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '4F0C103E377040179EF412F13E09D265' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:38:16.403+0000'::timestamp with time zone as ct_change
    union all
    select 'BCCD81F36C7742238C539091D610106D' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:38:16.403+0000'::timestamp with time zone as ct_change
    union all
    select '034AA50916924D8F882CEFCAC2EBB2FB' as ck_id, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, 'E2D0A96506384965A7B2666E5D2D1970' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-09-30T06:34:50.078+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
