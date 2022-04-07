--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_C3F1A4DE593B40FD81079A422C16070D dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '58D9E3DC7AB342CDB3578111FF1EC034' as ck_id, '1' as ck_class_parent, 'C3F1A4DE593B40FD81079A422C16070D' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-06-17T07:57:44.359+0000' as ct_change
    union all
    select '10AF78DDC6BC4057BC1383D5658ACAE1' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, 'C3F1A4DE593B40FD81079A422C16070D' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-14T00:00:00.000+0000' as ct_change
    union all
    select '74741F6AD2144260A9D88DB54A2DF3CA' as ck_id, 'C3F1A4DE593B40FD81079A422C16070D' as ck_class_parent, '1' as ck_class_child, 'C5CC30188D464E26A99E092BA1EB128B' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-06-11T11:52:10.054+0000' as ct_change
    union all
    select 'FED8D025F4184963AF096D4B1BFAB404' as ck_id, 'C3F1A4DE593B40FD81079A422C16070D' as ck_class_parent, 'FC278B804F4C4DE6A273C8C4D6F4037D' as ck_class_child, 'C5CC30188D464E26A99E092BA1EB128B' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-06-11T11:56:37.825+0000' as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
