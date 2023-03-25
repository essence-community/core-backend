--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_19 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '197' as ck_id, '137' as ck_class_parent, '19' as ck_class_child, '619' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '1985' as ck_id, '1457' as ck_class_parent, '19' as ck_class_child, '5176' as ck_class_attr, '10020785' as ck_user, '2018-07-12T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '6985' as ck_id, '157' as ck_class_parent, '19' as ck_class_child, '36169' as ck_class_attr, '20785' as ck_user, '2018-12-11T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '13' as ck_id, '18' as ck_class_parent, '19' as ck_class_child, '31' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '452795343D34403C90C59899FE295BBE' as ck_id, '1807D17438814B31B75A279C4CBC6C0C' as ck_class_parent, '19' as ck_class_child, '225864898ED0411FA0E5434CD3A85346' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-04T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'D0DEC310D76345519B02CF77D2199005' as ck_id, '19' as ck_class_parent, '32' as ck_class_child, '2419E72C5EFB42D3965A503A9D00B7F2' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-12-08T10:32:14.282+0000'::timestamp with time zone as ct_change
    union all
    select '946' as ck_id, '217' as ck_class_parent, '19' as ck_class_child, '830' as ck_class_attr, '10020785' as ck_user, '2018-04-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '31' as ck_id, '32' as ck_class_parent, '19' as ck_class_child, '132' as ck_class_attr, '10020788' as ck_user, '2018-04-21T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '831B66C74FEB4164B6B1D46D9EEAC76D' as ck_id, '57' as ck_class_parent, '19' as ck_class_child, '5A71798ADE90475B941C914EDF5E1339' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-03-25T11:54:16.065+0000'::timestamp with time zone as ct_change
    union all
    select '11' as ck_id, '8' as ck_class_parent, '19' as ck_class_child, '30' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'B6BC04C53EFF43DF84C03785E23073D4' as ck_id, '9CC06E8D9D7E4791BA1C6232DAF60CDD' as ck_class_parent, '19' as ck_class_child, '1CEDCCF877584C01B3BD292C10D65DC9' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-18T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '6E663A2B4AB54136A2DB8AE84388FF49' as ck_id, 'BA125F895507411E8730C07D3AD26A3A' as ck_class_parent, '19' as ck_class_child, '0A71556DD08146C496C07ED8E2375751' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-03T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '293166F53C934427B2524859A2156539' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '19' as ck_class_child, '6E05E9179E274246A22A1583347ACA4D' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-03T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '4953B98C1D8941A4AA9DD567026FEE36' as ck_id, 'D966BA30FBA3469FB5FEA82127B1ED6D' as ck_class_parent, '19' as ck_class_child, 'D910BD59B2CE4895BE263B2FC12DA80D' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-09-27T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '25DCFA2674A74F2ABF817A6F453CB315' as ck_id, 'DB557A6113634FD2BC40D2A58EE1EB3F' as ck_class_parent, '19' as ck_class_child, '061FCBDA3AEB49F397D36170131F36C6' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-03T00:00:00.000+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
