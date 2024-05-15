--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_47AC6CC616C3493E923FAD5E79B28166 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select 'DC201ABB803C4196A350BE8CFD427FFB' as ck_id, '1' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-09T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'A8C580328EAB489CB1DB135F4D5341DE' as ck_id, '10' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '40' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '25FC2A2CAE3D4728A75A6E910491DF1D' as ck_id, '11' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '43' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '379CF928DF5B4C8E94F84AA00328A5FD' as ck_id, '137' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '621' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-09T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'A65ACC8977324FE0896965CECA16B5F0' as ck_id, '17' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '524' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '3AB46278CC674FA49B66468E0438CC8F' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '2D744CBAA37748CC935FCE2CD1DFEDE1' as ck_id, '217' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'A36690E5AB7143519E2EE658036F1491' as ck_id, '32' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-09T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '5840A8CC01CE486DBA898CFBDD905392' as ck_id, '36' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '254' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '260A64B29DED4A7C83F922C7D915EAC2' as ck_id, '417' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '1850' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '3F38CDCA01EB414CB546ABC9B8531E5C' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:57:36.841+0000'::timestamp with time zone as ct_change
    union all
    select '81B2C29F4A84418AB4F7735EA8C4FE84' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '59228798E25A4622AC306F3B104DC502' as ck_id, '58' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '382' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '75D16228383245ABA11795C44A3F9A1D' as ck_id, '6457' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-09T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '6524DFEE3037413481D9FC632DDA2CD5' as ck_id, '7457' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '37172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '22BBF7529E2B4D98854061E09737A917' as ck_id, '77' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '450' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'E2938D9CA21642F18E04EAA7A75B2312' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-09T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '529089CA2C4B4263BC92171EF10627CE' as ck_id, '9' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '39' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-09T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'BA566F71D3934999A7FD2C1677D1F314' as ck_id, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '4F0C103E377040179EF412F13E09D265' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'DAAD7FA546714E689229394D29214251' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '3E291DBF59BC4A048ED2EE25E95A25A0' as ck_id, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, 'E2D0A96506384965A7B2666E5D2D1970' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '6786BBF4283C4AD99F65A29E9651A62B' as ck_id, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, 'EEBFE7B1ABBA407EAA22DE1DB8960C9C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:34:13.019+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
