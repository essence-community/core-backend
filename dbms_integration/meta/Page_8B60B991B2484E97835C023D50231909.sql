--liquibase formatted sql
--changeset patcher-core:Page_8B60B991B2484E97835C023D50231909 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
select pkg_patcher.p_remove_page('8B60B991B2484E97835C023D50231909');

INSERT INTO s_mt.t_page (ck_id, ck_parent, cr_type, cv_name, cn_order, cl_static, cv_url, ck_icon, ck_user, ct_change, cl_menu)VALUES('8B60B991B2484E97835C023D50231909', 'FA489CA01DB649ED914DC3E7C5E061F2', 2, '980446eade8a46bb9a55471686587bbd', 20, 0, null, '43', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-19T00:00:00.000+0000', 1) on conflict (ck_id) do update set ck_parent = excluded.ck_parent, cr_type = excluded.cr_type, cv_name = excluded.cv_name, cn_order = excluded.cn_order, cl_static = excluded.cl_static, cv_url = excluded.cv_url, ck_icon = excluded.ck_icon, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_menu = excluded.cl_menu;
INSERT INTO s_mt.t_page_action (ck_id, ck_page, cr_type, cn_action, ck_user, ct_change)VALUES('B2DC5F7C4DD9429A9CBBB29317A86EE6', '8B60B991B2484E97835C023D50231909', 'edit', 516, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-19T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cr_type = excluded.cr_type, cn_action = excluded.cn_action, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_action (ck_id, ck_page, cr_type, cn_action, ck_user, ct_change)VALUES('D7EC1D44D9174B14ADB3EAA59758C59A', '8B60B991B2484E97835C023D50231909', 'view', 515, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-19T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cr_type = excluded.cr_type, cn_action = excluded.cn_action, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
select pkg_patcher.p_merge_object('D647270354794881BC735F7038016488', '8', null, 'Patch Integr Grid', 10, 'ITGetPatchInterface', 'Patch Integr Grid', 'e352f04a992a45abbbc8d7aa4f9fc256', 'pkg_json_patcher.f_modify_patch', 's_ic_adm', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object('CA876D87B2CB44C09F74112B6ADA7050', '35', null, 'Patch Intrgr Tab', 20, null, 'Patch Intrgr Tab', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object('5849FD08F92B47369F952378CE556EED', '57', 'D647270354794881BC735F7038016488', 'Download Button', 5, null, 'Скачивание', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object('09C2277143FC46639D1567883971C22C', '19', 'D647270354794881BC735F7038016488', 'Create Button', 10, null, 'Create Button', 'eb3f37c72da848b4a73500bc35ed8c08', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object('B05807A8476E4917BC9BDA10115C85C0', '9', 'D647270354794881BC735F7038016488', 'Наименование', 20, null, 'Наименование', 'e0cd88534f90436da2b3b5eeae0ae340', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object('99258F2CDF034FA692E6F5B667B012BE', '8', 'CA876D87B2CB44C09F74112B6ADA7050', 'Integr Grid', 30, 'ITGetPatchInterface', 'Интеграционные сервисы', 'd6698d28cb3444138523a21141c16570', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object('2C575CD35407466D9FE133C6D01EDC51', '11', 'D647270354794881BC735F7038016488', 'Дата сборки', 30, null, 'Дата сборки', '9b82c8e576784bd5b52d48d1bc96aa32', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object('DB7F1402D9B74E089F8B728E423D490B', '10', 'D647270354794881BC735F7038016488', 'Размер сборки, МБ', 40, null, 'Размер сборки, МБ', '7425a5c6e803436f8e06399c89dc7fd6', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object('206F888DCB3E467DAB34307AF651E724', '32', 'D647270354794881BC735F7038016488', 'Create Window', 50, null, 'Состав  сборки', 'd9df123fbc844da39be9b002d49e7bc4', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object('6C9790DDC103421D8DC846334F99B2B7', '19', 'D647270354794881BC735F7038016488', 'FAQ Button', 1000050, null, 'Как установить', '751e3a8b87b44beba52b0d4dbc27ae81', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object('6AA0E89BB9D04ECD8DCCF304C0F1A811', '9', '99258F2CDF034FA692E6F5B667B012BE', 'ck_id', 10, null, 'Идентификатор', '356026998685486b99fc07969bd2af68', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object('C7E4EB8C25E44C9AA7612AEB929FE8BB', '38', '206F888DCB3E467DAB34307AF651E724', 'inetegr Query Grid', 10, 'ITGetInterface', 'Сервисы', 'd6698d28cb3444138523a21141c16570', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object('38C71C1D9D2D49FEA68390853D453223', '9', '99258F2CDF034FA692E6F5B667B012BE', 'ck_interface', 20, null, 'Тип интеграционного интерфейса', '45747a3e5f8e4f519d63e8a6e1c3243c', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object('70315858CFC54A01897481A72C22D2EF', '9', '99258F2CDF034FA692E6F5B667B012BE', 'ck_provider', 30, null, 'Провайдер', 'c8d602c66c7247a0b3bc5b26caaa39c8', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object('6E2CBA528EE94F53B928D1B175E5D1CB', '9', '99258F2CDF034FA692E6F5B667B012BE', 'ck_parent', 40, null, 'ИД связанного сервиса', '6727af8d818542fba835d152ebef3430', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object('AF5875E3124C43E6BC1E1F49E1460F1E', '9', '99258F2CDF034FA692E6F5B667B012BE', 'cv_description', 50, null, 'Описание', 'a4b1d1f3995f499a8f2bac5b57a3cbdc', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object('DFE0F44B35A64DA4A51B26F3DA191EDE', '19', '206F888DCB3E467DAB34307AF651E724', 'Save Button', 100, null, 'Save Button', '98773577d9614dea95c7d010a72e2b81', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object('C745B0F603E649DE92F6855ADA8D516A', '19', '206F888DCB3E467DAB34307AF651E724', 'Canсel Button', 200, null, 'Отмена', '8fd23a27ba224ee48cdef41f72947665', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object('E00F56FE3DB248DE8223A57F1D3C01A1', '437', 'C7E4EB8C25E44C9AA7612AEB929FE8BB', 'COPY of COPY of Checkbox', 10, null, 'Checkbox', '0e804404b039411e83292c0b1658c0ee', null, null, '-1', '2019-12-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object('5B3FBD7BBCB14F0CB37B003858EA38CD', '9', 'C7E4EB8C25E44C9AA7612AEB929FE8BB', 'COPY of COPY of ck_id', 20, null, 'Идентификатор', '356026998685486b99fc07969bd2af68', null, null, '-1', '2019-12-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object('41774C33E02E403CA07B64976ACEC930', '9', 'C7E4EB8C25E44C9AA7612AEB929FE8BB', 'COPY of COPY of ck_interface', 25, null, 'Тип интеграционного интерфейса', '45747a3e5f8e4f519d63e8a6e1c3243c', null, null, '-1', '2019-12-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object('B6C638A902894C88913A5C50EEE635CC', '9', 'C7E4EB8C25E44C9AA7612AEB929FE8BB', 'COPY of COPY of ck_provider', 30, null, 'Провайдер', 'c8d602c66c7247a0b3bc5b26caaa39c8', null, null, '-1', '2019-12-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object('625700777D754791BF7EC81628FD85FF', '9', 'C7E4EB8C25E44C9AA7612AEB929FE8BB', 'COPY of COPY of ck_parent', 40, null, 'ИД связанного сервиса', '6727af8d818542fba835d152ebef3430', null, null, '-1', '2019-12-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object('0B72EF4D6E9144919AB332522A69AFFF', '9', 'C7E4EB8C25E44C9AA7612AEB929FE8BB', 'COPY of COPY of cv_description', 50, null, 'Описание', 'a4b1d1f3995f499a8f2bac5b57a3cbdc', null, null, '-1', '2019-12-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('A360C9ABC51143BFA9A9D2CFF1D29A9C', '5849FD08F92B47369F952378CE556EED', '1930', 'create_patch', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('DFB50C6CEDEA4118A046F028D020054B', '5849FD08F92B47369F952378CE556EED', '22171', 'integration', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('AA025EE569204210A48A69FF72048CF8', '5849FD08F92B47369F952378CE556EED', '353', 'file-o', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('1087BD834B004CB0B148B38540E8439C', '5849FD08F92B47369F952378CE556EED', '560', 'onUpdate', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('6022235E8D2242F0BC677029265D8D10', '5849FD08F92B47369F952378CE556EED', '591', '7', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('6CA2D1C79ADA49958A8BBCF5AA5EF1AF', '5849FD08F92B47369F952378CE556EED', '592', 'Modify', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('3A365E90F907481696AC0773CC2E7421', '09C2277143FC46639D1567883971C22C', '1033', 'ck_create', '-1', '2019-12-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('C19A076FEDA14719A9EED1FCCC9AEE65', 'C7E4EB8C25E44C9AA7612AEB929FE8BB', '297', 'cct_interface', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('F3570E03A6274CCCA9390FC120E72529', 'D647270354794881BC735F7038016488', '401', '10', '-1', '2019-12-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('CBD25BD3E2774C8AACD1A9312ADBBF3A', 'D647270354794881BC735F7038016488', '407', 'modalwindow', '-1', '2019-12-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('80E9366019564723A93E9F6F09F2C566', '6AA0E89BB9D04ECD8DCCF304C0F1A811', '47', 'ck_id', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('18C602AB333C4FF7B41DF27D34C3FAE0', 'C7E4EB8C25E44C9AA7612AEB929FE8BB', '5169', 'array', '-1', '2019-12-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('948EEDF457C54F94BA280608FCA66CE5', 'D647270354794881BC735F7038016488', '852', 'ck_id', '-1', '2019-12-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('C396C90791A34C39B0296FF676337CA4', 'D647270354794881BC735F7038016488', '8D547C621A1D626CE053809BA8C0882B', 'false', '-1', '2019-12-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('48FDFD538AF348618B277684F5123084', '5B3FBD7BBCB14F0CB37B003858EA38CD', '47', 'ck_id', '-1', '2019-12-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('0ABF6907F2604453A55B841277839E72', '38C71C1D9D2D49FEA68390853D453223', '47', 'ck_d_interface', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('8541034345924C5FAE0BB05CDC863B25', 'B05807A8476E4917BC9BDA10115C85C0', '47', 'cv_value', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('E334BDD6131243D1AC253E58F8783D7D', '41774C33E02E403CA07B64976ACEC930', '47', 'ck_d_provider', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('769AE84CE72D45F9BD76B0A6E671B77A', '99258F2CDF034FA692E6F5B667B012BE', '1440', 'false', '-1', '2019-12-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('466267D3E7214A3F84B9AB5758C09411', '99258F2CDF034FA692E6F5B667B012BE', '1643', 'false', '-1', '2019-12-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('04165EB3BF704881B0BF0823910BD662', '2C575CD35407466D9FE133C6D01EDC51', '191', '6', '-1', '2019-12-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('7D1472FFB943437EBC68B5FF4DAA0BF2', '99258F2CDF034FA692E6F5B667B012BE', '401', '10', '-1', '2019-12-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('46521A7C5F7047D28BFBEDCA1D5C4660', 'B6C638A902894C88913A5C50EEE635CC', '47', 'ck_d_provider', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('1C1A75851A714567AA66EAD36404DF8C', '70315858CFC54A01897481A72C22D2EF', '47', 'ck_d_provider', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('67E22AD9ACF145F9A4B1F9EB7FC7CAAA', '2C575CD35407466D9FE133C6D01EDC51', '49', 'cd_create', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('43CCDFFB95CF4A7AB1F711DE0B5E271C', '99258F2CDF034FA692E6F5B667B012BE', '852', 'ck_id', '-1', '2019-12-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('FBD348CA21ED403CB66E01DB39F49C3A', '99258F2CDF034FA692E6F5B667B012BE', '8D547C621A1D626CE053809BA8C0882B', 'false', '-1', '2019-12-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('F8E5E43569A54D1CB2C760E41134F381', '625700777D754791BF7EC81628FD85FF', '47', 'ck_parent', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('C8C1EFC4D66642EC90D12CCD2B64F24C', '6E2CBA528EE94F53B928D1B175E5D1CB', '47', 'ck_parent', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('F8B73431C10846B3866F053982FA5D42', 'DB7F1402D9B74E089F8B728E423D490B', '48', 'cn_size_view', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('99873B1AE71149658D99A83F9CD76766', '206F888DCB3E467DAB34307AF651E724', '1029', 'ck_create', '-1', '2019-12-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('ED4E502FF553414893AA87CF3FC98D4D', 'AF5875E3124C43E6BC1E1F49E1460F1E', '47', 'cv_description', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('DCFF59AFB4944BDC977E639F44803A10', 'DFE0F44B35A64DA4A51B26F3DA191EDE', '140', 'onSimpleSaveWindow', '-1', '2019-12-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('F45B202BE45A46A4B4F3329D83891810', 'DFE0F44B35A64DA4A51B26F3DA191EDE', '155', '7', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('CD7ED5DAA53D4AD2A7C887F5FFA96D92', 'DFE0F44B35A64DA4A51B26F3DA191EDE', '1928', 'create_patch', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('D3E1AEB13B0945668A525F5820E61770', 'DFE0F44B35A64DA4A51B26F3DA191EDE', '22170', 'integration', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-24T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('F11AB6EEF5774EA48D7C83E8ACBA6153', 'C745B0F603E649DE92F6855ADA8D516A', '140', 'onCloseWindow', '-1', '2019-12-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2F186CA0F13649DFBD0316DFF25508ED', 'C745B0F603E649DE92F6855ADA8D516A', '147', '2', '-1', '2019-12-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('C8C173DC59D4457C891AC72296504D59', '6C9790DDC103421D8DC846334F99B2B7', '140', 'onCloseWindowSilent', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-01-09T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('790B79229A7345B789EEEC83CD4E9C0C', '6C9790DDC103421D8DC846334F99B2B7', '1682', 'ce7646e1e30b4f4da7ace0344500d87d', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-20T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('F369FE05797D4742BE7685AEC50E150D', '6C9790DDC103421D8DC846334F99B2B7', '1695', 'true', '-1', '2019-12-19T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('8636E6387433476AA78EB6FDE877BE46', '6C9790DDC103421D8DC846334F99B2B7', '992', 'fa-question-circle-o', '-1', '2019-12-19T00:00:00.000+0000');
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('3122411C6D6F4356A161B0B9799F0840', '8B60B991B2484E97835C023D50231909', 'D647270354794881BC735F7038016488', 10, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-19T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('D223B097867744E093DA61B36AE3DBE3', '8B60B991B2484E97835C023D50231909', 'CA876D87B2CB44C09F74112B6ADA7050', 20, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-24T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('D8803F4BB07841479AAE5B738E30EC56', '8B60B991B2484E97835C023D50231909', '5849FD08F92B47369F952378CE556EED', 5, '3122411C6D6F4356A161B0B9799F0840', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-19T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('B3856661533C448C97BE139B36915610', '8B60B991B2484E97835C023D50231909', '09C2277143FC46639D1567883971C22C', 10, '3122411C6D6F4356A161B0B9799F0840', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-19T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('ABA687A2A6D54017A8800FA10ECA7D17', '8B60B991B2484E97835C023D50231909', 'B05807A8476E4917BC9BDA10115C85C0', 20, '3122411C6D6F4356A161B0B9799F0840', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-19T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('66B8842C4A1A4AE49D2B309A22F4DC1B', '8B60B991B2484E97835C023D50231909', '2C575CD35407466D9FE133C6D01EDC51', 30, '3122411C6D6F4356A161B0B9799F0840', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-19T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('1CDF9B5617D34FB09583EFE2006110BB', '8B60B991B2484E97835C023D50231909', '99258F2CDF034FA692E6F5B667B012BE', 30, 'D223B097867744E093DA61B36AE3DBE3', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-24T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('0A787148953A448AB7471CFEF9C21CCC', '8B60B991B2484E97835C023D50231909', 'DB7F1402D9B74E089F8B728E423D490B', 40, '3122411C6D6F4356A161B0B9799F0840', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-19T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('639D3527E06A4D90B048B2D01D160B8A', '8B60B991B2484E97835C023D50231909', '206F888DCB3E467DAB34307AF651E724', 50, '3122411C6D6F4356A161B0B9799F0840', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-19T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('0BBC6D8B83D24D3097E99059E6F172B1', '8B60B991B2484E97835C023D50231909', '6C9790DDC103421D8DC846334F99B2B7', 1000050, '3122411C6D6F4356A161B0B9799F0840', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-19T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('CB918BD104C6427F84742930FEED55E5', '8B60B991B2484E97835C023D50231909', 'C7E4EB8C25E44C9AA7612AEB929FE8BB', 10, '639D3527E06A4D90B048B2D01D160B8A', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-19T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('B8A7F6BA00014F8AB40EFE2D65BCAAC1', '8B60B991B2484E97835C023D50231909', '6AA0E89BB9D04ECD8DCCF304C0F1A811', 10, '1CDF9B5617D34FB09583EFE2006110BB', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-24T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('458357DC375846049CDA33BC268D10A4', '8B60B991B2484E97835C023D50231909', '38C71C1D9D2D49FEA68390853D453223', 20, '1CDF9B5617D34FB09583EFE2006110BB', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-24T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('0839A4951F72426D9CA75BAC5029F13A', '8B60B991B2484E97835C023D50231909', '70315858CFC54A01897481A72C22D2EF', 30, '1CDF9B5617D34FB09583EFE2006110BB', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-24T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('E24B0E2F6CE741959D9090139708191C', '8B60B991B2484E97835C023D50231909', '6E2CBA528EE94F53B928D1B175E5D1CB', 40, '1CDF9B5617D34FB09583EFE2006110BB', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-24T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('5CEF1FFDD3254F5D8F0D6A344BFFA537', '8B60B991B2484E97835C023D50231909', 'AF5875E3124C43E6BC1E1F49E1460F1E', 50, '1CDF9B5617D34FB09583EFE2006110BB', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-24T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('FB9453B953074375AEF29E2CF7C225C0', '8B60B991B2484E97835C023D50231909', 'DFE0F44B35A64DA4A51B26F3DA191EDE', 100, '639D3527E06A4D90B048B2D01D160B8A', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-19T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('3716257DC0B24A97827FE72296634493', '8B60B991B2484E97835C023D50231909', 'C745B0F603E649DE92F6855ADA8D516A', 200, '639D3527E06A4D90B048B2D01D160B8A', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-19T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7662E714D21F48DD852B1E54C2EB88D3', '8B60B991B2484E97835C023D50231909', 'E00F56FE3DB248DE8223A57F1D3C01A1', 10, 'CB918BD104C6427F84742930FEED55E5', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-19T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('D37E05410CA94DDFAF6D6ACABA83F613', '8B60B991B2484E97835C023D50231909', '5B3FBD7BBCB14F0CB37B003858EA38CD', 20, 'CB918BD104C6427F84742930FEED55E5', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-19T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('53D4ED37CEED402EA1DE17AC8B67F344', '8B60B991B2484E97835C023D50231909', '41774C33E02E403CA07B64976ACEC930', 25, 'CB918BD104C6427F84742930FEED55E5', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-19T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('279D415E215648A4A187B5A6486E98CB', '8B60B991B2484E97835C023D50231909', 'B6C638A902894C88913A5C50EEE635CC', 30, 'CB918BD104C6427F84742930FEED55E5', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-19T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('B81ED95786DE4C56AFC4836FE6E53CBE', '8B60B991B2484E97835C023D50231909', '625700777D754791BF7EC81628FD85FF', 40, 'CB918BD104C6427F84742930FEED55E5', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-19T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('BF2AAE7F7C2045F392F078E2F2DE3C83', '8B60B991B2484E97835C023D50231909', '0B72EF4D6E9144919AB332522A69AFFF', 50, 'CB918BD104C6427F84742930FEED55E5', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-19T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
update s_mt.t_page_object set ck_master='3122411C6D6F4356A161B0B9799F0840' where ck_id='D223B097867744E093DA61B36AE3DBE3';
update s_mt.t_page_object set ck_master='3122411C6D6F4356A161B0B9799F0840' where ck_id='1CDF9B5617D34FB09583EFE2006110BB';
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)
select t.ck_id, t.ck_d_lang, t.cr_namespace, t.cv_value, t.ck_user, t.ct_change::timestamp from (
    select '356026998685486b99fc07969bd2af68' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Идентификатор' as cv_value, '-11' as ck_user, '2019-12-09T00:00:00.000+0000' as ct_change
    union all
    select 'c8d602c66c7247a0b3bc5b26caaa39c8' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Провайдер' as cv_value, '-11' as ck_user, '2019-12-09T00:00:00.000+0000' as ct_change
    union all
    select '0e804404b039411e83292c0b1658c0ee' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Checkbox' as cv_value, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-17T00:00:00.000+0000' as ct_change
    union all
    select '45747a3e5f8e4f519d63e8a6e1c3243c' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Тип интеграционного интерфейса' as cv_value, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-17T00:00:00.000+0000' as ct_change
    union all
    select '6727af8d818542fba835d152ebef3430' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'ИД связанного сервиса' as cv_value, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-17T00:00:00.000+0000' as ct_change
    union all
    select '7425a5c6e803436f8e06399c89dc7fd6' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Размер сборки, МБ' as cv_value, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-17T00:00:00.000+0000' as ct_change
    union all
    select '9b82c8e576784bd5b52d48d1bc96aa32' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Дата сборки' as cv_value, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-17T00:00:00.000+0000' as ct_change
    union all
    select 'd6698d28cb3444138523a21141c16570' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Интеграционные сервисы' as cv_value, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-17T00:00:00.000+0000' as ct_change
    union all
    select 'd9df123fbc844da39be9b002d49e7bc4' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Состав  сборки' as cv_value, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-17T00:00:00.000+0000' as ct_change
    union all
    select 'e352f04a992a45abbbc8d7aa4f9fc256' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Патч' as cv_value, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-17T00:00:00.000+0000' as ct_change
    union all
    select 'eb3f37c72da848b4a73500bc35ed8c08' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Собрать' as cv_value, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-17T00:00:00.000+0000' as ct_change
    union all
    select '751e3a8b87b44beba52b0d4dbc27ae81' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Как установить' as cv_value, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-18T00:00:00.000+0000' as ct_change
    union all
    select '980446eade8a46bb9a55471686587bbd' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Интеграция' as cv_value, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-18T00:00:00.000+0000' as ct_change
    union all
    select 'ce7646e1e30b4f4da7ace0344500d87d' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, '1. снять дамп обновляемой БД<br/>2. распаковать архив<br/>3. в файле liquibase.integr.properties указать корректные данные обновляемой БД<br/>4. запустить update' as cv_value, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-19T00:00:00.000+0000' as ct_change
    union all
    select '8fd23a27ba224ee48cdef41f72947665' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Отмена' as cv_value, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-26T00:00:00.000+0000' as ct_change
    union all
    select '98773577d9614dea95c7d010a72e2b81' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Сохранить' as cv_value, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-26T00:00:00.000+0000' as ct_change
    union all
    select 'a4b1d1f3995f499a8f2bac5b57a3cbdc' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Описание' as cv_value, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-26T00:00:00.000+0000' as ct_change
    union all
    select 'e0cd88534f90436da2b3b5eeae0ae340' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Наименование' as cv_value, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-26T00:00:00.000+0000' as ct_change
) as t 
 join s_mt.t_d_lang dl
 on t.ck_d_lang = dl.ck_id
on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
