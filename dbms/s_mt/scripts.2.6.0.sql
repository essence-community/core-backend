--liquibase formatted sql
--changeset artemov_i:CORE-1311 dbms:postgresql
INSERT INTO s_mt.t_sys_setting (ck_id,ck_user,ct_change,cv_description)
	VALUES ('skip_update_action_page','4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-08-05 11:10:31.709','Пропустить обновление доступов у страниц') on conflict (ck_id) DO NOTHING;

--changeset artemov_i:CORE-1316 dbms:postgresql
ALTER TABLE s_mt.t_class_attr ADD cl_empty int2 NOT NULL DEFAULT 0;
COMMENT ON COLUMN s_mt.t_class_attr.cl_empty IS 'Признак того что значение может быть пустой строкой';

DELETE FROM s_mt.t_object_attr o_attr
WHERE nullif(o_attr.cv_value, '') is null and o_attr.ck_class_attr in (select ck_id from s_mt.t_class_attr where cl_empty = 0);

DELETE FROM s_mt.t_page_object_attr po_attr
WHERE nullif(po_attr.cv_value, '') is null and po_attr.ck_class_attr in (select ck_id from s_mt.t_class_attr where cl_empty = 0);

INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('eea00f8cc53e471bbf7b8306e3927b5a','ru_RU','message','Необходимо указать значение','4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-08-07 14:14:44.489') on conflict on constraint cin_u_localization_1 DO NOTHING;

--changeset artemov_i:CORE-1326 dbms:postgresql
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)
    VALUES('6cef8d4302234753bc59aa193c7fe6bb', 'ru_RU', 'message', 'У класса не включен "Признак самостоятельного заполнения"', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-08-11 15:48:16.477') on conflict on constraint cin_u_localization_1 DO NOTHING;
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)
	VALUES ('7d4bdc39e17d423595affef73f4922d4','ru_RU','message','Изменение родителя у объекта может привести к потере работоспособности страниц, где этот объект используется','4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-08-12 12:17:13.193') on conflict on constraint cin_u_localization_1 DO NOTHING;
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('52b1e236fa264ac9ab19e1cd44d18376','ru_RU','message','Родительский объект успешно изменен, проверьте правильность настройки мастеров на данной странице','4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-08-12 12:35:43.592') on conflict on constraint cin_u_localization_1 DO NOTHING;
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,ck_user,ct_change)
	VALUES (82,'warning','37b938509c654b729dd22166ed22e927','4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-08-12 11:06:00.000') on conflict (ck_id) DO NOTHING;
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,ck_user,ct_change)
	VALUES (83,'info','37b938509c654b729dd22166ed22e927','4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-08-12 11:06:00.000') on conflict (ck_id) DO NOTHING;

--changeset artemov_i:CORE-1361 dbms:postgresql
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('588e2ab956f14295a82048271de5ad5a','ru_RU','message','Запрещено родителя добавлять в дочерний объект','4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-08-20 14:47:50.619') on conflict on constraint cin_u_localization_1 DO NOTHING;

--changeset artemov_i:CORE-1436 dbms:postgresql
INSERT INTO s_mt.t_class_attr
(ck_id, ck_class, ck_attr, cv_value, ck_user, ct_change, cl_required, cv_data_type_extra, cl_empty)
VALUES('4202666F5D3A4FCCBB3A28A3FEE3B60C', '7C133EA0021A44A0864B82F7BC40F183', 'defaultvalue', NULL, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-10-28 15:18:13.985', 0, NULL, 0) on conflict (ck_id) DO NOTHING;

update
    s_mt.t_object_attr
set
    cv_value = '[{"in": "defaultvalue", "out": null}]'
where
    ck_id in (
        select
            ck_id
        from
            s_mt.t_object_attr toa
        where
            toa.ck_object in (
                select
                    to2.ck_id
                from
                    s_mt.t_object to2
                where
                    to2.ck_id in (
                        select
                            ck_parent
                        from
                            s_mt.t_object
                        where
                            ck_class = '7C133EA0021A44A0864B82F7BC40F183'
                    )
            )
            and toa.ck_class_attr in (
                select
                    ck_id
                from
                    s_mt.t_class_attr
                where
                    ck_attr = 'valuefield'
            )
            and (
                (
                    toa.cv_value like '[%]'
                    and toa.cv_value::jsonb#>>'{0,in}' = 'valuefield'
                )
                or toa.cv_value = 'valuefield'
            )
    );

update
    s_mt.t_page_object_attr
set
    cv_value = '[{"in": "defaultvalue", "out": null}]'
where
    ck_id in (
        select
            tpoa.ck_id
        from
            s_mt.t_page_object_attr tpoa
        where
            tpoa.ck_page_object in (
                select
                    ck_id
                from
                    s_mt.t_page_object
                where
                    ck_object in (
                        select
                            to2.ck_id
                        from
                            s_mt.t_object to2
                        where
                            to2.ck_id in (
                                select
                                    ck_parent
                                from
                                    s_mt.t_object
                                where
                                    ck_class = '7C133EA0021A44A0864B82F7BC40F183'
                            )
                    )
            )
            and tpoa.ck_class_attr in (
                select
                    ck_id
                from
                    s_mt.t_class_attr
                where
                    ck_attr = 'valuefield'
            )
            and (
                (
                    tpoa.cv_value like '[%]'
                    and tpoa.cv_value::jsonb#>>'{0,in}' = 'valuefield'
                )
                or tpoa.cv_value = 'valuefield'
            )
    );

update
    s_mt.t_page_object_attr upoa
set
    (ck_class_attr, cv_value) = (select '4202666F5D3A4FCCBB3A28A3FEE3B60C' as ck_id, case when tpoa.cv_value like '[%]' then cv_value::jsonb#>>'{0,in}' else cv_value end as cv_value from s_mt.t_page_object_attr tpoa 
where tpoa.ck_class_attr = '349A87A48518414EA91B8618078351F6' and tpoa.ck_id = upoa.ck_id)
where upoa.ck_class_attr = '349A87A48518414EA91B8618078351F6';

update
    s_mt.t_object_attr uoa
set
    (ck_class_attr, cv_value) = (select '4202666F5D3A4FCCBB3A28A3FEE3B60C' as ck_id, case when cv_value like '[%]' then cv_value::jsonb#>>'{0,in}' else cv_value end as cv_value from s_mt.t_object_attr toa 
where toa.ck_class_attr = '349A87A48518414EA91B8618078351F6' and toa.ck_id = uoa.ck_id)
where uoa.ck_class_attr = '349A87A48518414EA91B8618078351F6';
