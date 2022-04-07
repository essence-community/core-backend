--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_1EE230968D8648419A9FEF0AAF7390E7 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '5F09AEEB5557411A9085B80F5E5D77E0' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '0DDBEE01777844F5AC8F129EB5A43118' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-06-05T14:43:58.828+0000'::timestamp with time zone as ct_change
    union all
    select '49EF47513E074997AA1944FEF695C603' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '1' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-06-15T13:30:57.532+0000'::timestamp with time zone as ct_change
    union all
    select '682F9C44468D4BA48EA74FD9123107A1' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '137' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-02T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'C745F4C5E8DE458AAF0A0B603A9A6E46' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '1807D17438814B31B75A279C4CBC6C0C' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-15T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '5CC1B4AA488E47459FA15BD8E202C1D7' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '32' as ck_class_child, '8E3A9174CCB442F1B50A7E5F97806827' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-23T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '10AF78DDC6BC4057BC1383D5658ACAE1' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, 'C3F1A4DE593B40FD81079A422C16070D' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-14T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'C6095F6BA57F4E4898FBA270088CD6FB' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-03T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '24962C7D46404D2D8366D169AE6EC336' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_child, '8E3A9174CCB442F1B50A7E5F97806827' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-17T00:00:00.000+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
