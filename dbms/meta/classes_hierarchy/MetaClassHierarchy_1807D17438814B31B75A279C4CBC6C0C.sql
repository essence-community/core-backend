--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_1807D17438814B31B75A279C4CBC6C0C dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '29CE713D6887494EB4DB90AE8FA294C4' as ck_id, '1807D17438814B31B75A279C4CBC6C0C' as ck_class_parent, '1457' as ck_class_child, '225864898ED0411FA0E5434CD3A85346' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-04T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '914AA4CD5A0149F69C4805B917825A21' as ck_id, '1807D17438814B31B75A279C4CBC6C0C' as ck_class_parent, '16CD1F9A0789445AA23AC20DA565BFCC' as ck_class_child, '225864898ED0411FA0E5434CD3A85346' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-04T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '452795343D34403C90C59899FE295BBE' as ck_id, '1807D17438814B31B75A279C4CBC6C0C' as ck_class_parent, '19' as ck_class_child, '225864898ED0411FA0E5434CD3A85346' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-04T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '59CFC1DF83B94A2F8FE3467EFD0A32E4' as ck_id, '1807D17438814B31B75A279C4CBC6C0C' as ck_class_parent, '4457' as ck_class_child, '225864898ED0411FA0E5434CD3A85346' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-07T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'A30ABA0CE0614CDFB50844C2B78A619C' as ck_id, '1807D17438814B31B75A279C4CBC6C0C' as ck_class_parent, '8C96F9B255F5407FBCB8DE9189B15F39' as ck_class_child, '225864898ED0411FA0E5434CD3A85346' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-11-18T12:15:34.260+0000'::timestamp with time zone as ct_change
    union all
    select 'E115392A23ED446D890E923FF2809270' as ck_id, '1807D17438814B31B75A279C4CBC6C0C' as ck_class_parent, 'DB557A6113634FD2BC40D2A58EE1EB3F' as ck_class_child, '225864898ED0411FA0E5434CD3A85346' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-04T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'C745F4C5E8DE458AAF0A0B603A9A6E46' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '1807D17438814B31B75A279C4CBC6C0C' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-15T00:00:00.000+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
