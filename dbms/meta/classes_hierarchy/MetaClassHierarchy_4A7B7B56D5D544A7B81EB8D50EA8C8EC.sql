--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_4A7B7B56D5D544A7B81EB8D50EA8C8EC dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '2EF0A80070544148A5AE453CCE8B72BF' as ck_id, '1' as ck_class_parent, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T10:02:12.675+0000'::timestamp with time zone as ct_change
    union all
    select '8DF601942D194983AD3053F0C3894E6F' as ck_id, '137' as ck_class_parent, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_child, '621' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T10:01:28.259+0000'::timestamp with time zone as ct_change
    union all
    select '76F8B118ADCC4E5DAB0887A7CE925B5A' as ck_id, '32' as ck_class_parent, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:59:50.873+0000'::timestamp with time zone as ct_change
    union all
    select '0567A396904E4C72B072F3DC2F2EEA19' as ck_id, '417' as ck_class_parent, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_child, '1850' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T10:01:15.179+0000'::timestamp with time zone as ct_change
    union all
    select '2019FF6677AE484BA7731DC0AD34B0EA' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '1' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:55:17.249+0000'::timestamp with time zone as ct_change
    union all
    select 'BB4DDCEC177C4521BA63C95F2D2EA999' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '10457' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:59:13.321+0000'::timestamp with time zone as ct_change
    union all
    select 'F27D19C4848C433FAFABB8EF29E8E411' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '137' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:55:26.040+0000'::timestamp with time zone as ct_change
    union all
    select '49E6449F462946A18DB2D6922900384A' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '15593D209A1D46FC873706F69EE71E7A' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:55:36.098+0000'::timestamp with time zone as ct_change
    union all
    select '5A8B89D2AF2C4325974341B38768A2E8' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '197' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:56:05.304+0000'::timestamp with time zone as ct_change
    union all
    select 'BB23D73372A84DDBA958A99BB0A816E3' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '26' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:59:04.173+0000'::timestamp with time zone as ct_change
    union all
    select 'C659375971CB414AB753B26BA8636D12' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '27' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:57:16.823+0000'::timestamp with time zone as ct_change
    union all
    select '15E8DB5F43554421B24834D4E451BA09' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '28' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:57:50.747+0000'::timestamp with time zone as ct_change
    union all
    select 'D72DAE99E84B4C96986E8B6A45B85021' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '29' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:55:08.752+0000'::timestamp with time zone as ct_change
    union all
    select '95E3B7D972394AA596EF86925B537DB6' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '30' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:56:27.760+0000'::timestamp with time zone as ct_change
    union all
    select 'F0A6438958F04385971FE7C1912D55E1' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '3061ADE6780F432B93F17C1DCCC33D93' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:35.711+0000'::timestamp with time zone as ct_change
    union all
    select '6D973D7B9B904ECEA305B29DDA7B8487' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '31' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:55:45.672+0000'::timestamp with time zone as ct_change
    union all
    select 'E632B7DAF36445BCB72812591EEB37B1' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '317' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'FEF1215CB72F4301AB883307AAC036A2' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '33' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:57:00.179+0000'::timestamp with time zone as ct_change
    union all
    select 'D7F960DFB9254770B60D091FA571AB54' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '357' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:56:14.157+0000'::timestamp with time zone as ct_change
    union all
    select '7686CAC6706E47E7BAF6568FE1EE9462' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '37' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:56:46.468+0000'::timestamp with time zone as ct_change
    union all
    select '10DDE6E045A449D09326C4597E485213' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '38' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:56:37.417+0000'::timestamp with time zone as ct_change
    union all
    select 'CAEDBBF6EF3D494CB5EC8922BEB64B4B' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '417' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:58:56.697+0000'::timestamp with time zone as ct_change
    union all
    select '307CA79817A14F668B5464F0E8AFDBCC' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '4457' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:54:55.631+0000'::timestamp with time zone as ct_change
    union all
    select '3F38CDCA01EB414CB546ABC9B8531E5C' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:57:36.841+0000'::timestamp with time zone as ct_change
    union all
    select '06946D5B189247B68D854C5E7803DB37' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-11-02T18:23:10.761+0000'::timestamp with time zone as ct_change
    union all
    select 'B182F746E0C64599831748B20048E9C0' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '508B0DE5C67B464CB3A5CED4DF778084' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:14.957+0000'::timestamp with time zone as ct_change
    union all
    select 'DF359B4372BE4D6BB2637679CDB0B754' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '5833D73B31E04F8ABE9D307DBCE845A9' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '140AE258A3E5440DB0C442FEA3E5718B' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '5F229304828F4AADBF9B0BE6463B1248' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-05-27T11:16:26.529+0000'::timestamp with time zone as ct_change
    union all
    select '5CAB9DA7438D41E4B89F88F38C402EEE' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-02-10T16:45:47.209+0000'::timestamp with time zone as ct_change
    union all
    select '5C1B5C9957774207AB66F1F0DD86FAF8' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '6B1F10465BA848B4BF8E75924A6268A2' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:58:39.646+0000'::timestamp with time zone as ct_change
    union all
    select '00E87900616B48829BED4BB2E9DB7FB7' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '7457' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'E2FC7FF82007471F8C75EB890A58EC11' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '7C133EA0021A44A0864B82F7BC40F183' as ck_class_child, '0BA955FE0DD245448E0FDABF5FEBD752' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-11-08T14:37:20.761+0000'::timestamp with time zone as ct_change
    union all
    select 'E01CDBD1BD0C402C829A430FB494928A' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '8457' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:57:58.761+0000'::timestamp with time zone as ct_change
    union all
    select 'B48FA45DFC7E439C95D2934C111E18F3' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:55:57.282+0000'::timestamp with time zone as ct_change
    union all
    select 'E02D4B0403E147A7A4492EC76575FEE6' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-09-30T06:34:01.638+0000'::timestamp with time zone as ct_change
    union all
    select '644EDDB119524E7499E8522E8AE622C3' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:58:26.567+0000'::timestamp with time zone as ct_change
    union all
    select 'FD3E25B7CFBD4014855020F02585A4E2' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '8E6AC2B44FCB8D3BE053809BA8C0E74D' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:57:09.501+0000'::timestamp with time zone as ct_change
    union all
    select '93AEB109A9144D0AA8404FAF49DA7A67' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '97' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:58:10.436+0000'::timestamp with time zone as ct_change
    union all
    select '6B5AA870F345437FAC7321C00313075D' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:58:47.570+0000'::timestamp with time zone as ct_change
    union all
    select '38E793088A094F3BA99F1D5E68FF8281' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, 'DA77FDDE896F48909B19EBB516326D33' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '5C80529ED28D46489D94A7B23457BACB' as ck_id, '6457' as ck_class_parent, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T10:01:45.975+0000'::timestamp with time zone as ct_change
    union all
    select 'F6F38A01BFFC4DEDBEFACCA7A568CEA7' as ck_id, '7457' as ck_class_parent, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_child, '37172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T10:02:47.317+0000'::timestamp with time zone as ct_change
    union all
    select '8BA232ADDB3F40B192C7164197C97109' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T10:00:41.437+0000'::timestamp with time zone as ct_change
    union all
    select '65077E57DF9146B3A1143AEBAE53F378' as ck_id, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_parent, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_child, '4F0C103E377040179EF412F13E09D265' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-11-13T16:12:24.434+0000'::timestamp with time zone as ct_change
    union all
    select '183578067D4942A0BE74E1C94F52424D' as ck_id, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_parent, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_child, 'E2D0A96506384965A7B2666E5D2D1970' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T10:00:08.186+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
