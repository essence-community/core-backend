--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_137 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '218' as ck_id, '1' as ck_class_parent, '137' as ck_class_child, '623' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '202' as ck_id, '137' as ck_class_parent, '1' as ck_class_child, '621' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '11989' as ck_id, '137' as ck_class_parent, '10457' as ck_class_child, '621' as ck_class_attr, '30021381' as ck_user, '2019-01-24T00:00:00.000+0000' as ct_change
    union all
    select '216' as ck_id, '137' as ck_class_parent, '137' as ck_class_child, '621' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '2986' as ck_id, '137' as ck_class_parent, '1457' as ck_class_child, '619' as ck_class_attr, '10020785' as ck_user, '2018-07-15T00:00:00.000+0000' as ct_change
    union all
    select 'F9D5AE7717724C36BF66D1025A1D1668' as ck_id, '137' as ck_class_parent, '15593D209A1D46FC873706F69EE71E7A' as ck_class_child, '621' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-05-20T10:08:53.888+0000' as ct_change
    union all
    select '256' as ck_id, '137' as ck_class_parent, '157' as ck_class_child, '621' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '204' as ck_id, '137' as ck_class_parent, '18' as ck_class_child, '621' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '197' as ck_id, '137' as ck_class_parent, '19' as ck_class_child, '619' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '285' as ck_id, '137' as ck_class_parent, '197' as ck_class_child, '621' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '745' as ck_id, '137' as ck_class_parent, '217' as ck_class_child, '621' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '214' as ck_id, '137' as ck_class_parent, '26' as ck_class_child, '621' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '211' as ck_id, '137' as ck_class_parent, '27' as ck_class_child, '621' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '212' as ck_id, '137' as ck_class_parent, '28' as ck_class_child, '621' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '206' as ck_id, '137' as ck_class_parent, '29' as ck_class_child, '621' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '9EECD8F6BE3D4B29B3D511DEDCAAC7E3' as ck_id, '137' as ck_class_parent, '2BB74480D7E2455B97AED5B3A070FE35' as ck_class_child, '621' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-24T00:00:00.000+0000' as ct_change
    union all
    select '208' as ck_id, '137' as ck_class_parent, '30' as ck_class_child, '621' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '207' as ck_id, '137' as ck_class_parent, '31' as ck_class_child, '621' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '566' as ck_id, '137' as ck_class_parent, '317' as ck_class_child, '621' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '9D14E9ED27F64920971192825DE664E7' as ck_id, '137' as ck_class_parent, '32' as ck_class_child, 'E292FDA1A128432D90B468F23A6CA3BB' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-12-08T10:33:28.254+0000' as ct_change
    union all
    select '210' as ck_id, '137' as ck_class_parent, '33' as ck_class_child, '621' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '706' as ck_id, '137' as ck_class_parent, '337' as ck_class_child, '621' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '205' as ck_id, '137' as ck_class_parent, '35' as ck_class_child, '621' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '645' as ck_id, '137' as ck_class_parent, '357' as ck_class_child, '621' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '215' as ck_id, '137' as ck_class_parent, '37' as ck_class_child, '621' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '209' as ck_id, '137' as ck_class_parent, '38' as ck_class_child, '621' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select 'E6BDFBDCAE874D1FB86A769D4D23AAAE' as ck_id, '137' as ck_class_parent, '39AB8EAF9DCD456197944E6B6321989D' as ck_class_child, '621' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-23T00:00:00.000+0000' as ct_change
    union all
    select '5988' as ck_id, '137' as ck_class_parent, '4457' as ck_class_child, '621' as ck_class_attr, '10020785' as ck_user, '2018-10-07T00:00:00.000+0000' as ct_change
    union all
    select '379CF928DF5B4C8E94F84AA00328A5FD' as ck_id, '137' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '621' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-09T00:00:00.000+0000' as ct_change
    union all
    select '8DF601942D194983AD3053F0C3894E6F' as ck_id, '137' as ck_class_parent, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_child, '621' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T10:01:28.259+0000' as ct_change
    union all
    select '233' as ck_id, '137' as ck_class_parent, '58' as ck_class_child, '634' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select 'F392C364B5BE471EA18E24FCFD9EB253' as ck_id, '137' as ck_class_parent, '5833D73B31E04F8ABE9D307DBCE845A9' as ck_class_child, '621' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-03-17T00:00:00.000+0000' as ct_change
    union all
    select '2FE37BBA27C6413EA81CF9A6372AFF3A' as ck_id, '137' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '621' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-02-10T16:45:37.910+0000' as ct_change
    union all
    select '8F0CC686198C325DE053809BA8C053B6' as ck_id, '137' as ck_class_parent, '7457' as ck_class_child, '621' as ck_class_attr, '20780' as ck_user, '2019-08-06T00:00:00.000+0000' as ct_change
    union all
    select '203' as ck_id, '137' as ck_class_parent, '8' as ck_class_child, '621' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '8985' as ck_id, '137' as ck_class_parent, '8457' as ck_class_child, '621' as ck_class_attr, '20786' as ck_user, '2018-12-24T00:00:00.000+0000' as ct_change
    union all
    select 'C7C89FF4053C462688E2857C289C0F95' as ck_id, '137' as ck_class_parent, '858DBC49DF354ECCA2F57F36DAF4E37A' as ck_class_child, '621' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-06-11T08:43:01.750+0000' as ct_change
    union all
    select '871CB755C58C248AE053809BA8C0F31E' as ck_id, '137' as ck_class_parent, '871CB755C589248AE053809BA8C0F31E' as ck_class_child, '621' as ck_class_attr, '20785' as ck_user, '2019-05-15T00:00:00.000+0000' as ct_change
    union all
    select 'EAC52733D70A4C019F1C993A7C766518' as ck_id, '137' as ck_class_parent, '8C96F9B255F5407FBCB8DE9189B15F39' as ck_class_child, '619' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-11-18T12:15:34.260+0000' as ct_change
    union all
    select '8D3A50B6DE976276E053809BA8C0911C' as ck_id, '137' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '621' as ck_class_attr, '20785' as ck_user, '2019-07-13T00:00:00.000+0000' as ct_change
    union all
    select '8E595EA2AB618D8FE053809BA8C044A5' as ck_id, '137' as ck_class_parent, '8E6AC2B44FCB8D3BE053809BA8C0E74D' as ck_class_child, '621' as ck_class_attr, '20785' as ck_user, '2019-07-23T00:00:00.000+0000' as ct_change
    union all
    select '8FFF734D4DB9414BE053809BA8C08F58' as ck_id, '137' as ck_class_parent, '8FFC6C4564B84157E053809BA8C00266' as ck_class_child, '621' as ck_class_attr, '20785' as ck_user, '2019-08-13T00:00:00.000+0000' as ct_change
    union all
    select '213' as ck_id, '137' as ck_class_parent, '97' as ck_class_child, '621' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select 'D5D8134828D94D3699DF9D3B9C8E3C69' as ck_id, '137' as ck_class_parent, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_child, '621' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-16T00:00:00.000+0000' as ct_change
    union all
    select '93D7D7F199CF4DAC862BC0D2C526F3A2' as ck_id, '137' as ck_class_parent, 'BA125F895507411E8730C07D3AD26A3A' as ck_class_child, '621' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-03T00:00:00.000+0000' as ct_change
    union all
    select 'ADFF5975DA774D6188218990543EB997' as ck_id, '137' as ck_class_parent, 'D966BA30FBA3469FB5FEA82127B1ED6D' as ck_class_child, '621' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-09-27T00:00:00.000+0000' as ct_change
    union all
    select '381C84089356457CB798C598F66EE826' as ck_id, '137' as ck_class_parent, 'DAB69DA8C46746AD959E331D4CFAC8AD' as ck_class_child, '621' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-01-17T00:00:00.000+0000' as ct_change
    union all
    select 'C9E92C3CA2934C7CB37424445D09BFCB' as ck_id, '137' as ck_class_parent, 'system:check_list_container' as ck_class_child, '621' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-03-17T08:33:14.574+0000' as ct_change
    union all
    select '682F9C44468D4BA48EA74FD9123107A1' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '137' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-02T00:00:00.000+0000' as ct_change
    union all
    select '306' as ck_id, '217' as ck_class_parent, '137' as ck_class_child, '829' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '270' as ck_id, '32' as ck_class_parent, '137' as ck_class_child, '138' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '232' as ck_id, '35' as ck_class_parent, '137' as ck_class_child, '172' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select 'F27D19C4848C433FAFABB8EF29E8E411' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '137' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:55:26.040+0000' as ct_change
    union all
    select '6995' as ck_id, '6457' as ck_class_parent, '137' as ck_class_child, '36173' as ck_class_attr, '20785' as ck_user, '2018-12-12T00:00:00.000+0000' as ct_change
    union all
    select '59F26FA2D6ED456987D2E8C155B53969' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '137' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-28T00:00:00.000+0000' as ct_change
    union all
    select 'DBCAFDC4202048D590AEA6E6D20ACE43' as ck_id, 'C12028B0A13B4AE28E63CBB90F3428E1' as ck_class_parent, '137' as ck_class_child, '5CE6E945D0164CD49959C639DED4241F' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-21T00:00:00.000+0000' as ct_change
    union all
    select 'B8CBEABDDF03452798A20FD6C706BDBA' as ck_id, 'D966BA30FBA3469FB5FEA82127B1ED6D' as ck_class_parent, '137' as ck_class_child, '4E50E23DE3C2473A8B41011A689EEC1F' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-09-20T00:00:00.000+0000' as ct_change
    union all
    select '7E11698D105343A99B01889BBB993A90' as ck_id, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_parent, '137' as ck_class_child, 'E2D0A96506384965A7B2666E5D2D1970' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-24T00:00:00.000+0000' as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
