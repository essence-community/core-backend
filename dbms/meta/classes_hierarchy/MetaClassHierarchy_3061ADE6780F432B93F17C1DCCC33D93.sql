--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_3061ADE6780F432B93F17C1DCCC33D93 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '8129A24CBDD5454DAA65769B5447157D' as ck_id, '1' as ck_class_parent, '3061ADE6780F432B93F17C1DCCC33D93' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:35.711+0000'::timestamp with time zone as ct_change
    union all
    select '41C33253A8DE4E548D378D4C73ADFE5F' as ck_id, '137' as ck_class_parent, '3061ADE6780F432B93F17C1DCCC33D93' as ck_class_child, '621' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:35.711+0000'::timestamp with time zone as ct_change
    union all
    select 'DEF3A8B968F841F083ECCCA28A938838' as ck_id, '157' as ck_class_parent, '3061ADE6780F432B93F17C1DCCC33D93' as ck_class_child, '735' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:35.711+0000'::timestamp with time zone as ct_change
    union all
    select '5644ADA6204B4019ACDBE016EDF5DFE9' as ck_id, '17' as ck_class_parent, '3061ADE6780F432B93F17C1DCCC33D93' as ck_class_child, '524' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:35.711+0000'::timestamp with time zone as ct_change
    union all
    select 'A407A7ADDCE34228BE3736561B3F4792' as ck_id, '3061ADE6780F432B93F17C1DCCC33D93' as ck_class_parent, '508B0DE5C67B464CB3A5CED4DF778084' as ck_class_child, '182E640A949449AB9BCA61FD92017AD6' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:40:04.109+0000'::timestamp with time zone as ct_change
    union all
    select 'FD90342E17724D6685037CE3A2C6506D' as ck_id, '32' as ck_class_parent, '3061ADE6780F432B93F17C1DCCC33D93' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:35.711+0000'::timestamp with time zone as ct_change
    union all
    select 'C7F83B3E646049CABFC64D17E7F5DBD0' as ck_id, '417' as ck_class_parent, '3061ADE6780F432B93F17C1DCCC33D93' as ck_class_child, '1850' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:35.711+0000'::timestamp with time zone as ct_change
    union all
    select 'F0A6438958F04385971FE7C1912D55E1' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '3061ADE6780F432B93F17C1DCCC33D93' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:35.711+0000'::timestamp with time zone as ct_change
    union all
    select '696D470C0CB04AE59B10EFE3D275C89A' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '3061ADE6780F432B93F17C1DCCC33D93' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:35.711+0000'::timestamp with time zone as ct_change
    union all
    select 'D998264F349741D28698A0B8938E07E6' as ck_id, '58' as ck_class_parent, '3061ADE6780F432B93F17C1DCCC33D93' as ck_class_child, '382' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:35.711+0000'::timestamp with time zone as ct_change
    union all
    select '42C9DBB806AF4AF48631D3C8F86BEFE7' as ck_id, '6457' as ck_class_parent, '3061ADE6780F432B93F17C1DCCC33D93' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:35.711+0000'::timestamp with time zone as ct_change
    union all
    select 'BF0719D8058C4CE2B93E89BCC49D5CF7' as ck_id, '7457' as ck_class_parent, '3061ADE6780F432B93F17C1DCCC33D93' as ck_class_child, '37172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:35.711+0000'::timestamp with time zone as ct_change
    union all
    select '948810B1F39F4B7D9062C74246BA8A6C' as ck_id, '77' as ck_class_parent, '3061ADE6780F432B93F17C1DCCC33D93' as ck_class_child, '450' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:35.711+0000'::timestamp with time zone as ct_change
    union all
    select '642075F047CC4ABDB7BCE9FA3BE8B0AE' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '3061ADE6780F432B93F17C1DCCC33D93' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:35.711+0000'::timestamp with time zone as ct_change
    union all
    select 'AF6A9C94605F412CB88E616DB947D23C' as ck_id, '9' as ck_class_parent, '3061ADE6780F432B93F17C1DCCC33D93' as ck_class_child, '39' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:35.711+0000'::timestamp with time zone as ct_change
    union all
    select '779CE4CE1F424DA28CB54726A824E643' as ck_id, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_parent, '3061ADE6780F432B93F17C1DCCC33D93' as ck_class_child, '4F0C103E377040179EF412F13E09D265' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:35.711+0000'::timestamp with time zone as ct_change
    union all
    select '40F63BC5FDBA4DBCB3B403E1DE60343E' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '3061ADE6780F432B93F17C1DCCC33D93' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:35.711+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
