--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_664B30CA82FC453BAADF14EE7C102312 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select 'F20C870B32BD47AC8C2FACF032B2B7EF' as ck_id, '1' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-02-10T16:46:17.657+0000'::timestamp with time zone as ct_change
    union all
    select '2FE37BBA27C6413EA81CF9A6372AFF3A' as ck_id, '137' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '621' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-02-10T16:45:37.910+0000'::timestamp with time zone as ct_change
    union all
    select 'B6BEB9AF08B743E885DAB51F2B56BF8C' as ck_id, '17' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '524' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'FF376F4455FF4D15960F052A4071D3EC' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'DC8D9E8679D741A78770879CA9EE166E' as ck_id, '217' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '65EBDA0371204C6A94E8EC28446176BE' as ck_id, '32' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-02-10T16:46:05.499+0000'::timestamp with time zone as ct_change
    union all
    select '9BEF47504CEA4865A277F5DCF52BB9C1' as ck_id, '36' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '254' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '0DB977E7AA394AAFA6C29C82CE1F2C33' as ck_id, '417' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '1850' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '5CAB9DA7438D41E4B89F88F38C402EEE' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-02-10T16:45:47.209+0000'::timestamp with time zone as ct_change
    union all
    select '7F06198C718C4EEDB4038B18BD9BC363' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-02-10T16:45:12.558+0000'::timestamp with time zone as ct_change
    union all
    select '8F709C09D77F46DD851FD978894D5EBE' as ck_id, '58' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '382' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-02-10T16:45:22.782+0000'::timestamp with time zone as ct_change
    union all
    select '1BF8298D0AE340EC928820A3CB14E331' as ck_id, '6457' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'DB36C35152BC467EAB66AD6C2F1BED99' as ck_id, '7457' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '37172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '48FF0C90DAFC4AC88BD20F112189952A' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-02-10T16:44:58.494+0000'::timestamp with time zone as ct_change
    union all
    select '4B206C6512A2446E9B56DE648A3DB400' as ck_id, '9' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '39' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '718D66A4B0B149068507DE05DD7B6CF3' as ck_id, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '4F0C103E377040179EF412F13E09D265' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'D731B655A83E49C3AA68CBF7F3888ADD' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '97E800A9E33744FAA77FB1F4BDAEB1FC' as ck_id, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, 'E2D0A96506384965A7B2666E5D2D1970' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
