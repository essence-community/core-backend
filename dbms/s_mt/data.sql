--liquibase formatted sql
--changeset artemov_i:t_attr_type dbms:postgresql splitStatements:false stripComments:false
INSERT INTO s_mt.t_attr_type (ck_id, cv_description, cn_user, ct_change) VALUES ('basic', 'обычный атрибут', '-11', '2018-02-23 10:07:44.714+03');
INSERT INTO s_mt.t_attr_type (ck_id, cv_description, cn_user, ct_change) VALUES ('system', 'системный атрибут, не переопределяется для объекта/страницы', '-11', '2018-02-23 10:07:44.714+03');
INSERT INTO s_mt.t_attr_type (ck_id, cv_description, cn_user, ct_change) VALUES ('placement', 'место для размещения дочернего элемента', '-11', '2018-02-23 10:07:44.714+03');
INSERT INTO s_mt.t_attr_type (ck_id, cv_description, cn_user, ct_change) VALUES ('behavior', 'поведенческий атрибут для зависимости отображения от данных', '-11', '2018-02-23 10:07:44.714+03');

--changeset artemov_i:t_d_action dbms:postgresql splitStatements:false stripComments:false
INSERT INTO s_mt.t_d_action (ck_id, cv_description) VALUES ('click', NULL);
INSERT INTO s_mt.t_d_action (ck_id, cv_description) VALUES ('input', NULL);
INSERT INTO s_mt.t_d_action (ck_id, cv_description) VALUES ('read', NULL);
INSERT INTO s_mt.t_d_action (ck_id, cv_description) VALUES ('confirmation', NULL);
INSERT INTO s_mt.t_d_action (ck_id, cv_description) VALUES ('checkState', NULL);
INSERT INTO s_mt.t_d_action (ck_id, cv_description) VALUES ('open', NULL);

--changeset artemov_i:t_icon dbms:postgresql splitStatements:false stripComments:false
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('1', 'fa-500px', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('2', 'fa-address-book', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('3', 'fa-address-book-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('4', 'fa-address-card', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('5', 'fa-address-card-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('6', 'fa-adjust', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('7', 'fa-adn', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('8', 'fa-align-center', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('9', 'fa-align-justify', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('10', 'fa-align-left', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('11', 'fa-align-right', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('12', 'fa-amazon', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('13', 'fa-ambulance', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('14', 'fa-american-sign-language-interpreting', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('15', 'fa-anchor', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('16', 'fa-android', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('17', 'fa-angellist', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('18', 'fa-angle-double-down', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('19', 'fa-angle-double-left', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('20', 'fa-angle-double-right', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('21', 'fa-angle-double-up', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('22', 'fa-angle-down', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('23', 'fa-angle-left', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('24', 'fa-angle-right', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('25', 'fa-angle-up', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('26', 'fa-apple', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('27', 'fa-archive', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('28', 'fa-area-chart', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('29', 'fa-arrow-circle-down', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('30', 'fa-arrow-circle-left', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('31', 'fa-arrow-circle-o-down', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('32', 'fa-arrow-circle-o-left', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('33', 'fa-arrow-circle-o-right', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('34', 'fa-arrow-circle-o-up', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('35', 'fa-arrow-circle-right', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('36', 'fa-arrow-circle-up', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('37', 'fa-arrow-down', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('38', 'fa-arrow-left', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('39', 'fa-arrow-right', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('40', 'fa-arrow-up', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('41', 'fa-arrows', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('42', 'fa-arrows-alt', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('43', 'fa-arrows-h', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('44', 'fa-arrows-v', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('45', 'fa-asl-interpreting', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('46', 'fa-assistive-listening-systems', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('47', 'fa-asterisk', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('48', 'fa-at', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('49', 'fa-audio-description', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('50', 'fa-automobile', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('51', 'fa-backward', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('52', 'fa-balance-scale', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('53', 'fa-ban', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('54', 'fa-bandcamp', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('55', 'fa-bank', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('56', 'fa-bar-chart', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('57', 'fa-bar-chart-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('58', 'fa-barcode', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('59', 'fa-bars', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('60', 'fa-bath', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('61', 'fa-bathtub', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('62', 'fa-battery', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('63', 'fa-battery-0', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('64', 'fa-battery-1', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('65', 'fa-battery-2', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('66', 'fa-battery-3', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('67', 'fa-battery-4', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('68', 'fa-battery-empty', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('69', 'fa-battery-full', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('70', 'fa-battery-half', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('71', 'fa-battery-quarter', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('72', 'fa-battery-three-quarters', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('73', 'fa-bed', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('74', 'fa-beer', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('75', 'fa-behance', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('76', 'fa-behance-square', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('77', 'fa-bell', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('78', 'fa-bell-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('79', 'fa-bell-slash', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('80', 'fa-bell-slash-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('81', 'fa-bicycle', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('82', 'fa-binoculars', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('83', 'fa-birthday-cake', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('84', 'fa-bitbucket', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('85', 'fa-bitbucket-square', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('86', 'fa-bitcoin', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('87', 'fa-black-tie', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('88', 'fa-blind', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('89', 'fa-bluetooth', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('90', 'fa-bluetooth-b', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('91', 'fa-bold', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('92', 'fa-bolt', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('93', 'fa-bomb', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('94', 'fa-book', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('95', 'fa-bookmark', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('96', 'fa-bookmark-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('97', 'fa-braille', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('98', 'fa-briefcase', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('99', 'fa-btc', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('100', 'fa-bug', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('101', 'fa-building', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('102', 'fa-building-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('103', 'fa-bullhorn', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('104', 'fa-bullseye', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('105', 'fa-bus', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('106', 'fa-buysellads', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('107', 'fa-cab', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('108', 'fa-calculator', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('109', 'fa-calendar', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('110', 'fa-calendar-check-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('111', 'fa-calendar-minus-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('112', 'fa-calendar-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('113', 'fa-calendar-plus-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('114', 'fa-calendar-times-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('115', 'fa-camera', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('116', 'fa-camera-retro', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('117', 'fa-car', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('118', 'fa-caret-down', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('119', 'fa-caret-left', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('120', 'fa-caret-right', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('121', 'fa-caret-square-o-down', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('122', 'fa-caret-square-o-left', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('123', 'fa-caret-square-o-right', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('124', 'fa-caret-square-o-up', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('125', 'fa-caret-up', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('126', 'fa-cart-arrow-down', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('127', 'fa-cart-plus', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('128', 'fa-cc', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('129', 'fa-cc-amex', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('130', 'fa-cc-diners-club', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('131', 'fa-cc-discover', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('132', 'fa-cc-jcb', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('133', 'fa-cc-mastercard', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('134', 'fa-cc-paypal', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('135', 'fa-cc-stripe', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('136', 'fa-cc-visa', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('137', 'fa-certificate', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('138', 'fa-chain', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('139', 'fa-chain-broken', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('140', 'fa-check', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('141', 'fa-check-circle', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('142', 'fa-check-circle-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('143', 'fa-check-square', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('144', 'fa-check-square-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('145', 'fa-chevron-circle-down', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('146', 'fa-chevron-circle-left', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('147', 'fa-chevron-circle-right', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('148', 'fa-chevron-circle-up', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('149', 'fa-chevron-down', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('150', 'fa-chevron-left', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('151', 'fa-chevron-right', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('152', 'fa-chevron-up', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('153', 'fa-child', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('154', 'fa-chrome', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('155', 'fa-circle', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('156', 'fa-circle-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('157', 'fa-circle-o-notch', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('158', 'fa-circle-thin', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('159', 'fa-clipboard', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('160', 'fa-clock-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('161', 'fa-clone', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('162', 'fa-close', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('163', 'fa-cloud', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('164', 'fa-cloud-download', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('165', 'fa-cloud-upload', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('166', 'fa-cny', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('167', 'fa-code', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('168', 'fa-code-fork', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('169', 'fa-codepen', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('170', 'fa-codiepie', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('171', 'fa-coffee', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('172', 'fa-cog', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('173', 'fa-cogs', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('174', 'fa-columns', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('175', 'fa-comment', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('176', 'fa-comment-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('177', 'fa-commenting', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('178', 'fa-commenting-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('179', 'fa-comments', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('180', 'fa-comments-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('181', 'fa-compass', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('182', 'fa-compress', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('183', 'fa-connectdevelop', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('184', 'fa-contao', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('185', 'fa-copy', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('186', 'fa-copyright', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('187', 'fa-creative-commons', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('188', 'fa-credit-card', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('189', 'fa-credit-card-alt', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('190', 'fa-crop', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('191', 'fa-crosshairs', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('192', 'fa-css3', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('193', 'fa-cube', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('194', 'fa-cubes', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('195', 'fa-cut', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('196', 'fa-cutlery', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('197', 'fa-dashboard', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('198', 'fa-dashcube', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('199', 'fa-database', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('200', 'fa-deaf', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('201', 'fa-deafness', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('202', 'fa-dedent', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('203', 'fa-delicious', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('204', 'fa-desktop', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('205', 'fa-deviantart', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('206', 'fa-diamond', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('207', 'fa-digg', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('208', 'fa-dollar', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('209', 'fa-dot-circle-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('210', 'fa-download', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('211', 'fa-dribbble', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('212', 'fa-drivers-license', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('213', 'fa-drivers-license-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('214', 'fa-dropbox', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('215', 'fa-drupal', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('216', 'fa-edge', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('217', 'fa-edit', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('218', 'fa-eercast', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('219', 'fa-eject', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('220', 'fa-ellipsis-h', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('221', 'fa-ellipsis-v', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('222', 'fa-empire', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('223', 'fa-envelope', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('224', 'fa-envelope-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('225', 'fa-envelope-open', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('226', 'fa-envelope-open-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('227', 'fa-envelope-square', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('228', 'fa-envira', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('229', 'fa-eraser', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('230', 'fa-etsy', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('231', 'fa-eur', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('232', 'fa-euro', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('233', 'fa-exchange', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('234', 'fa-exclamation', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('235', 'fa-exclamation-circle', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('236', 'fa-exclamation-triangle', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('237', 'fa-expand', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('238', 'fa-expeditedssl', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('239', 'fa-external-link', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('240', 'fa-external-link-square', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('241', 'fa-eye', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('242', 'fa-eye-slash', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('243', 'fa-eyedropper', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('244', 'fa-fa', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('245', 'fa-facebook', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('246', 'fa-facebook-f', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('247', 'fa-facebook-official', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('248', 'fa-facebook-square', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('249', 'fa-fast-backward', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('250', 'fa-fast-forward', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('251', 'fa-fax', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('252', 'fa-feed', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('253', 'fa-female', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('254', 'fa-fighter-jet', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('255', 'fa-file', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('256', 'fa-file-archive-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('257', 'fa-file-audio-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('258', 'fa-file-code-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('259', 'fa-file-excel-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('260', 'fa-file-image-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('261', 'fa-file-movie-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('262', 'fa-file-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('263', 'fa-file-pdf-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('264', 'fa-file-photo-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('265', 'fa-file-picture-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('266', 'fa-file-powerpoint-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('267', 'fa-file-sound-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('268', 'fa-file-text', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('269', 'fa-file-text-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('270', 'fa-file-video-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('271', 'fa-file-word-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('272', 'fa-file-zip-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('273', 'fa-files-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('274', 'fa-film', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('275', 'fa-filter', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('276', 'fa-fire', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('277', 'fa-fire-extinguisher', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('278', 'fa-firefox', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('279', 'fa-first-order', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('280', 'fa-flag', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('281', 'fa-flag-checkered', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('282', 'fa-flag-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('283', 'fa-flash', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('284', 'fa-flask', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('285', 'fa-flickr', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('286', 'fa-floppy-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('287', 'fa-folder', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('288', 'fa-folder-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('289', 'fa-folder-open', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('290', 'fa-folder-open-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('291', 'fa-font', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('292', 'fa-font-awesome', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('293', 'fa-fonticons', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('294', 'fa-fort-awesome', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('295', 'fa-forumbee', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('296', 'fa-forward', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('297', 'fa-foursquare', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('298', 'fa-free-code-camp', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('299', 'fa-frown-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('300', 'fa-futbol-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('301', 'fa-gamepad', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('302', 'fa-gavel', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('303', 'fa-gbp', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('304', 'fa-ge', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('305', 'fa-gear', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('306', 'fa-gears', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('307', 'fa-genderless', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('308', 'fa-get-pocket', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('309', 'fa-gg', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('310', 'fa-gg-circle', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('311', 'fa-gift', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('312', 'fa-git', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('313', 'fa-git-square', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('314', 'fa-github', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('315', 'fa-github-alt', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('316', 'fa-github-square', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('317', 'fa-gitlab', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('318', 'fa-gittip', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('319', 'fa-glass', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('320', 'fa-glide', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('321', 'fa-glide-g', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('322', 'fa-globe', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('323', 'fa-google', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('324', 'fa-google-plus', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('325', 'fa-google-plus-circle', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('326', 'fa-google-plus-official', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('327', 'fa-google-plus-square', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('328', 'fa-google-wallet', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('329', 'fa-graduation-cap', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('330', 'fa-gratipay', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('331', 'fa-grav', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('332', 'fa-group', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('333', 'fa-h-square', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('334', 'fa-hacker-news', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('335', 'fa-hand-grab-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('336', 'fa-hand-lizard-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('337', 'fa-hand-o-down', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('338', 'fa-hand-o-left', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('339', 'fa-hand-o-right', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('340', 'fa-hand-o-up', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('341', 'fa-hand-paper-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('342', 'fa-hand-peace-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('343', 'fa-hand-pointer-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('344', 'fa-hand-rock-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('345', 'fa-hand-scissors-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('346', 'fa-hand-spock-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('347', 'fa-hand-stop-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('348', 'fa-handshake-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('349', 'fa-hard-of-hearing', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('350', 'fa-hashtag', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('351', 'fa-hdd-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('352', 'fa-header', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('353', 'fa-headphones', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('354', 'fa-heart', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('355', 'fa-heart-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('356', 'fa-heartbeat', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('357', 'fa-history', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('358', 'fa-home', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('359', 'fa-hospital-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('360', 'fa-hotel', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('361', 'fa-hourglass', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('362', 'fa-hourglass-1', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('363', 'fa-hourglass-2', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('364', 'fa-hourglass-3', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('365', 'fa-hourglass-end', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('366', 'fa-hourglass-half', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('367', 'fa-hourglass-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('368', 'fa-hourglass-start', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('369', 'fa-houzz', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('370', 'fa-html5', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('371', 'fa-i-cursor', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('372', 'fa-id-badge', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('373', 'fa-id-card', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('374', 'fa-id-card-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('375', 'fa-ils', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('376', 'fa-image', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('377', 'fa-imdb', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('378', 'fa-inbox', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('379', 'fa-indent', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('380', 'fa-industry', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('381', 'fa-info', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('382', 'fa-info-circle', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('383', 'fa-inr', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('384', 'fa-instagram', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('385', 'fa-institution', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('386', 'fa-internet-explorer', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('387', 'fa-intersex', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('388', 'fa-ioxhost', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('389', 'fa-italic', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('390', 'fa-joomla', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('391', 'fa-jpy', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('392', 'fa-jsfiddle', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('393', 'fa-key', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('394', 'fa-keyboard-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('395', 'fa-krw', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('396', 'fa-language', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('397', 'fa-laptop', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('398', 'fa-lastfm', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('399', 'fa-lastfm-square', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('400', 'fa-leaf', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('401', 'fa-leanpub', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('402', 'fa-legal', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('403', 'fa-lemon-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('404', 'fa-level-down', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('405', 'fa-level-up', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('406', 'fa-life-bouy', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('407', 'fa-life-buoy', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('408', 'fa-life-ring', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('409', 'fa-life-saver', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('410', 'fa-lightbulb-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('411', 'fa-line-chart', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('412', 'fa-link', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('413', 'fa-linkedin', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('414', 'fa-linkedin-square', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('415', 'fa-linode', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('416', 'fa-linux', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('417', 'fa-list', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('418', 'fa-list-alt', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('419', 'fa-list-ol', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('420', 'fa-list-ul', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('421', 'fa-location-arrow', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('422', 'fa-lock', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('423', 'fa-long-arrow-down', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('424', 'fa-long-arrow-left', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('425', 'fa-long-arrow-right', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('426', 'fa-long-arrow-up', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('427', 'fa-low-vision', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('428', 'fa-magic', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('429', 'fa-magnet', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('430', 'fa-mail-forward', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('431', 'fa-mail-reply', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('432', 'fa-mail-reply-all', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('433', 'fa-male', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('434', 'fa-map', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('435', 'fa-map-marker', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('436', 'fa-map-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('437', 'fa-map-pin', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('438', 'fa-map-signs', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('439', 'fa-mars', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('440', 'fa-mars-double', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('441', 'fa-mars-stroke', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('442', 'fa-mars-stroke-h', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('443', 'fa-mars-stroke-v', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('444', 'fa-maxcdn', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('445', 'fa-meanpath', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('446', 'fa-medium', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('447', 'fa-medkit', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('448', 'fa-meetup', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('449', 'fa-meh-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('450', 'fa-mercury', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('451', 'fa-microchip', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('452', 'fa-microphone', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('453', 'fa-microphone-slash', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('454', 'fa-minus', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('455', 'fa-minus-circle', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('456', 'fa-minus-square', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('457', 'fa-minus-square-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('458', 'fa-mixcloud', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('459', 'fa-mobile', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('460', 'fa-mobile-phone', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('461', 'fa-modx', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('462', 'fa-money', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('463', 'fa-moon-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('464', 'fa-mortar-board', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('465', 'fa-motorcycle', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('466', 'fa-mouse-pointer', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('467', 'fa-music', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('468', 'fa-navicon', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('469', 'fa-neuter', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('470', 'fa-newspaper-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('471', 'fa-object-group', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('472', 'fa-object-ungroup', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('473', 'fa-odnoklassniki', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('474', 'fa-odnoklassniki-square', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('475', 'fa-opencart', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('476', 'fa-openid', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('477', 'fa-opera', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('478', 'fa-optin-monster', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('479', 'fa-outdent', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('480', 'fa-pagelines', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('481', 'fa-paint-brush', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('482', 'fa-paper-plane', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('483', 'fa-paper-plane-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('484', 'fa-paperclip', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('485', 'fa-paragraph', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('486', 'fa-paste', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('487', 'fa-pause', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('488', 'fa-pause-circle', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('489', 'fa-pause-circle-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('490', 'fa-paw', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('491', 'fa-paypal', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('492', 'fa-pencil', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('493', 'fa-pencil-square', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('494', 'fa-pencil-square-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('495', 'fa-percent', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('496', 'fa-phone', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('497', 'fa-phone-square', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('498', 'fa-photo', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('499', 'fa-picture-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('500', 'fa-pie-chart', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('501', 'fa-pied-piper', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('502', 'fa-pied-piper-alt', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('503', 'fa-pied-piper-pp', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('504', 'fa-pinterest', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('505', 'fa-pinterest-p', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('506', 'fa-pinterest-square', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('507', 'fa-plane', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('508', 'fa-play', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('509', 'fa-play-circle', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('510', 'fa-play-circle-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('511', 'fa-plug', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('512', 'fa-plus', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('513', 'fa-plus-circle', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('514', 'fa-plus-square', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('515', 'fa-plus-square-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('516', 'fa-podcast', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('517', 'fa-power-off', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('518', 'fa-print', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('519', 'fa-product-hunt', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('520', 'fa-puzzle-piece', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('521', 'fa-qq', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('522', 'fa-qrcode', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('523', 'fa-question', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('524', 'fa-question-circle', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('525', 'fa-question-circle-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('526', 'fa-quora', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('527', 'fa-quote-left', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('528', 'fa-quote-right', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('529', 'fa-ra', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('530', 'fa-random', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('531', 'fa-ravelry', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('532', 'fa-rebel', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('533', 'fa-recycle', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('534', 'fa-reddit', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('535', 'fa-reddit-alien', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('536', 'fa-reddit-square', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('537', 'fa-refresh', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('538', 'fa-registered', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('539', 'fa-remove', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('540', 'fa-renren', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('541', 'fa-reorder', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('542', 'fa-repeat', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('543', 'fa-reply', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('544', 'fa-reply-all', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('545', 'fa-resistance', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('546', 'fa-retweet', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('547', 'fa-rmb', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('548', 'fa-road', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('549', 'fa-rocket', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('550', 'fa-rotate-left', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('551', 'fa-rotate-right', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('552', 'fa-rouble', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('553', 'fa-rss', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('554', 'fa-rss-square', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('555', 'fa-rub', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('556', 'fa-ruble', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('557', 'fa-rupee', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('558', 'fa-s15', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('559', 'fa-safari', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('560', 'fa-save', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('561', 'fa-scissors', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('562', 'fa-scribd', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('563', 'fa-search', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('564', 'fa-search-minus', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('565', 'fa-search-plus', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('566', 'fa-sellsy', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('567', 'fa-send', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('568', 'fa-send-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('569', 'fa-server', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('570', 'fa-share', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('571', 'fa-share-alt', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('572', 'fa-share-alt-square', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('573', 'fa-share-square', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('574', 'fa-share-square-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('575', 'fa-shekel', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('576', 'fa-sheqel', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('577', 'fa-shield', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('578', 'fa-ship', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('579', 'fa-shirtsinbulk', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('580', 'fa-shopping-bag', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('581', 'fa-shopping-basket', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('582', 'fa-shopping-cart', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('583', 'fa-shower', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('584', 'fa-sign-in', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('585', 'fa-sign-language', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('586', 'fa-sign-out', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('587', 'fa-signal', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('588', 'fa-signing', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('589', 'fa-simplybuilt', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('590', 'fa-sitemap', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('591', 'fa-skyatlas', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('592', 'fa-skype', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('593', 'fa-slack', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('594', 'fa-sliders', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('595', 'fa-slideshare', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('596', 'fa-smile-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('597', 'fa-snapchat', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('598', 'fa-snapchat-ghost', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('599', 'fa-snapchat-square', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('600', 'fa-snowflake-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('601', 'fa-soccer-ball-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('602', 'fa-sort', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('603', 'fa-sort-alpha-asc', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('604', 'fa-sort-alpha-desc', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('605', 'fa-sort-amount-asc', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('606', 'fa-sort-amount-desc', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('607', 'fa-sort-asc', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('608', 'fa-sort-desc', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('609', 'fa-sort-down', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('610', 'fa-sort-numeric-asc', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('611', 'fa-sort-numeric-desc', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('612', 'fa-sort-up', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('613', 'fa-soundcloud', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('614', 'fa-space-shuttle', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('615', 'fa-spinner', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('616', 'fa-spoon', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('617', 'fa-spotify', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('618', 'fa-square', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('619', 'fa-square-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('620', 'fa-stack-exchange', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('621', 'fa-stack-overflow', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('622', 'fa-star', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('623', 'fa-star-half', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('624', 'fa-star-half-empty', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('625', 'fa-star-half-full', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('626', 'fa-star-half-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('627', 'fa-star-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('628', 'fa-steam', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('629', 'fa-steam-square', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('630', 'fa-step-backward', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('631', 'fa-step-forward', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('632', 'fa-stethoscope', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('633', 'fa-sticky-note', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('634', 'fa-sticky-note-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('635', 'fa-stop', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('636', 'fa-stop-circle', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('637', 'fa-stop-circle-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('638', 'fa-street-view', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('639', 'fa-strikethrough', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('640', 'fa-stumbleupon', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('641', 'fa-stumbleupon-circle', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('642', 'fa-subscript', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('643', 'fa-subway', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('644', 'fa-suitcase', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('645', 'fa-sun-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('646', 'fa-superpowers', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('647', 'fa-superscript', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('648', 'fa-support', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('649', 'fa-table', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('650', 'fa-tablet', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('651', 'fa-tachometer', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('652', 'fa-tag', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('653', 'fa-tags', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('654', 'fa-tasks', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('655', 'fa-taxi', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('656', 'fa-telegram', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('657', 'fa-television', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('658', 'fa-tencent-weibo', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('659', 'fa-terminal', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('660', 'fa-text-height', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('661', 'fa-text-width', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('662', 'fa-th', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('663', 'fa-th-large', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('664', 'fa-th-list', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('665', 'fa-themeisle', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('666', 'fa-thermometer', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('667', 'fa-thermometer-0', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('668', 'fa-thermometer-1', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('669', 'fa-thermometer-2', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('670', 'fa-thermometer-3', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('671', 'fa-thermometer-4', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('672', 'fa-thermometer-empty', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('673', 'fa-thermometer-full', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('674', 'fa-thermometer-half', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('675', 'fa-thermometer-quarter', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('676', 'fa-thermometer-three-quarters', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('677', 'fa-thumb-tack', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('678', 'fa-thumbs-down', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('679', 'fa-thumbs-o-down', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('680', 'fa-thumbs-o-up', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('681', 'fa-thumbs-up', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('682', 'fa-ticket', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('683', 'fa-times', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('684', 'fa-times-circle', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('685', 'fa-times-circle-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('686', 'fa-times-rectangle', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('687', 'fa-times-rectangle-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('688', 'fa-tint', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('689', 'fa-toggle-down', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('690', 'fa-toggle-left', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('691', 'fa-toggle-off', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('692', 'fa-toggle-on', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('693', 'fa-toggle-right', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('694', 'fa-toggle-up', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('695', 'fa-trademark', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('696', 'fa-train', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('697', 'fa-transgender', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('698', 'fa-transgender-alt', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('699', 'fa-trash', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('700', 'fa-trash-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('701', 'fa-tree', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('702', 'fa-trello', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('703', 'fa-tripadvisor', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('704', 'fa-trophy', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('705', 'fa-truck', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('706', 'fa-try', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('707', 'fa-tty', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('708', 'fa-tumblr', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('709', 'fa-tumblr-square', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('710', 'fa-turkish-lira', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('711', 'fa-tv', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('712', 'fa-twitch', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('713', 'fa-twitter', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('714', 'fa-twitter-square', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('715', 'fa-umbrella', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('716', 'fa-underline', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('717', 'fa-undo', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('718', 'fa-universal-access', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('719', 'fa-university', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('720', 'fa-unlink', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('721', 'fa-unlock', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('722', 'fa-unlock-alt', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('723', 'fa-unsorted', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('724', 'fa-upload', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('725', 'fa-usb', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('726', 'fa-usd', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('727', 'fa-user', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('728', 'fa-user-circle', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('729', 'fa-user-circle-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('730', 'fa-user-md', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('731', 'fa-user-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('732', 'fa-user-plus', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('733', 'fa-user-secret', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('734', 'fa-user-times', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('735', 'fa-users', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('736', 'fa-vcard', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('737', 'fa-vcard-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('738', 'fa-venus', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('739', 'fa-venus-double', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('740', 'fa-venus-mars', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('741', 'fa-viacoin', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('742', 'fa-viadeo', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('743', 'fa-viadeo-square', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('744', 'fa-video-camera', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('745', 'fa-vimeo', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('746', 'fa-vimeo-square', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('747', 'fa-vine', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('748', 'fa-vk', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('749', 'fa-volume-control-phone', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('750', 'fa-volume-down', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('751', 'fa-volume-off', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('752', 'fa-volume-up', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('753', 'fa-warning', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('754', 'fa-wechat', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('755', 'fa-weibo', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('756', 'fa-weixin', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('757', 'fa-whatsapp', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('758', 'fa-wheelchair', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('759', 'fa-wheelchair-alt', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('760', 'fa-wifi', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('761', 'fa-wikipedia-w', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('762', 'fa-window-close', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('763', 'fa-window-close-o', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('764', 'fa-window-maximize', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('765', 'fa-window-minimize', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('766', 'fa-window-restore', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('767', 'fa-windows', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('768', 'fa-won', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('769', 'fa-wordpress', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('770', 'fa-wpbeginner', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('771', 'fa-wpexplorer', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('772', 'fa-wpforms', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('773', 'fa-wrench', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('774', 'fa-xing', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('775', 'fa-xing-square', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('776', 'fa-y-combinator', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('777', 'fa-y-combinator-square', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('778', 'fa-yahoo', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('779', 'fa-yc', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('780', 'fa-yc-square', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('781', 'fa-yelp', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('782', 'fa-yen', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('783', 'fa-yoast', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('784', 'fa-youtube', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('785', 'fa-youtube-play', 'fa', '-11', '2018-02-23 10:08:06.106+03');
INSERT INTO s_mt.t_icon (ck_id, cv_name, cv_font, cn_user, ct_change) VALUES ('786', 'fa-youtube-square ', 'fa', '-11', '2018-02-23 10:08:06.106+03');

--changeset artemov_i:t_message dbms:postgresql splitStatements:false stripComments:false
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (-6,'error','Ошибка разбора адреса: Найдено более одного дома (сооружения), подходящего под описание','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (-5,'error','Ошибка разбора адреса: Дом (сооружение) не найден','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (-4,'error','Ошибка разбора адреса: Найдено более одной улицы, подходящей под описание','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (-3,'error','Ошибка разбора адреса: Улица не найдена','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (-2,'error','Ошибка разбора адреса: Найдено более одного населенного пункта, подходящего под описание','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (-1,'error','Ошибка разбора адреса: Населенный пункт не найден','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (0,'info','Без ошибок','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (1,'error','Не заполнено поле "Класс"','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (2,'error','Не заполнено поле "Наименование"','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (3,'error','Не заполнено поле "Порядок сортировки"','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (4,'error','Не заполнено поле "Примечание"','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (6,'error','Атрибут не принадлежит классу, которому принадлежит объект','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (7,'error','Не заполнено поле "Признак статической страницы"','-11','2018-12-08 20:30:56.463');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (8,'error','Не заполнено поле "Порядок"','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (9,'error','Не заполнено поле "Тип страницы" (или заполнено неправильно)','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (10,'error','Модуль не может быть дочерним объектом','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (11,'error','Страницы и каталоги не могут быть объектами верхнего уровня','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (12,'error','Под страницами нельзя размещать другие страницы, каталоги или модули; это конечный элемент иерархии','-11','2019-01-04 17:19:37.501');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (13,'error','Можно добавлять дочерние объекты только при наличии связи в т. С_Иерархия классов','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (14,'error','Существует объект "{0}", связанный через ИД мастер-объекта','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (17,'error','Удаление класса невозможно, так как существуют связанные записи','-11','2018-10-18 17:13:57.903');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (18,'error','Признак возможности самостоятельного отображения в GUI должен быть заполнен только значением 0 или 1','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (19,'error','Признак выводимого набора данных должен быть заполнен только значением 0 или 1','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (20,'error','Атрибут должен принадлежать родительскому классу','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (21,'error','Редактирование Типа или Родительского объекта страницы невозможно','-11','2018-10-18 15:59:03.580');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (22,'error','Редактирование Объекта невозможно, так как не указан метод модификации данных','-11','2018-10-18 15:51:56.611');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (23,'error','При модификации объекта произошла ошибка','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (24,'error','После обновления пропал родительский объект для переиспользуемого объекта (Reusable object), он не будет привязан','-11','2018-08-01 18:56:52.662');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (25,'error','Не заполнено поле "Признак области размещения"','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (26,'error','Не заполнено поле "Описание"','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (27,'error','Не заполнено поле "Признак системности"','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (28,'error','При перепривязке связи к мастер-объекту произошла ошибка, необходимо вручную обновить привязку к мастерам по всей странице','-11','2018-08-01 18:56:52.669');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (29,'error','Удаление Объекта невозможно, так как существует привязка объекта к странице','-11','2018-10-18 15:51:56.615');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (30,'error','Не заполнено поле "Тип атрибута"','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (31,'error','При перепривязке значений из t_page_object_attr произошла ошибка, необходимо вручную доопределить атрибуты объектов на самой странице','-11','2018-08-01 18:57:25.839');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (32,'error','Вставляемое значение слишком длинное, сократите исходное название копируемого объекта','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (33,'error','Необходимо указать провайдера для модификации данных','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (34,'error','Порядок сортировки должен быть уникальным в рамках родительского объекта','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (35,'warning','Не заполнено поле "Код действия просмотра" - никто не сможет просмотреть эту страницу','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (36,'warning','Не заполнено поле "Код действия модификации" - никто не сможет изменить данные на этой странице','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (37,'error','Недопустимый тип атрибута, см. С_Тип атрибута','10020788','2018-03-18 02:03:27.525');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (38,'error','Признак обязательности должен быть заполнен только значением 0 или 1','10020788','2018-03-18 02:03:27.560');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (40,'error','Существуют объекты, привязанные к этой странице. Необходимо сначала удалить привязку','10020788','2018-05-12 16:13:39.225');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (42,'error','Не заполнено поле "ИД страницы"','10020788','2018-07-22 16:47:03.317');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (43,'error','Имя страничной (глобальной) переменной должно быть уникально в пределах страницы','10020788','2018-07-22 16:54:44.567');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (44,'error','Удаление переменной невозможно, так как она все еще используется на странице в объектах "{0}"','10020788','2018-10-18 17:23:22.302');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (45,'error','Указанная переменная не найдена в списке глобальных переменных выбранной страницы','10020788','2018-09-14 19:38:34.055');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (46,'warning','Переменной "{0}" уже задается значение в другом месте: {1}','10020788','2018-08-23 15:37:07.210');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (47,'info','Сформирован отчет {0}','10020788','2018-08-16 19:55:33.534');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (48,'error','Удаление сценария невозможно, так как добавлены шаги по нему','10020788','2018-10-18 17:23:22.307');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (49,'error','Номер шага должен быть уникален в рамках сценария','10020788','2018-08-20 19:22:56.537');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (50,'error','Не удалось сформировать отчет {0}','10020788','2018-08-21 15:17:55.494');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (51,'error','{0}','10020788','2018-08-21 15:17:55.503');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (52,'error','Номер действия должен быть уникален в рамках шага','10020788','2018-09-09 18:08:59.860');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (53,'error','Номер сценария должен быть уникален','10020788','2018-11-03 22:14:55.146');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (54,'warning','Вы уверены? Неправильное изменение системных настроек может значительно нарушить работу стенда вплоть до полной его остановки','10020788','2019-01-06 18:11:18.047');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (55,'error','Неверное значение - должно быть передано целое число от 1 до 100 со знаком процента, например: 5% или 70%','10020788','2018-12-03 20:40:35.327');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (56,'error','Существуют страницы или каталоги, находящиеся ниже по иерархии. Необходимо сначала удалить их','10020788','2019-02-07 19:25:27.309');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (57,'error','Необходимо указать наименование модуля','10020978','2019-03-19 00:01:08.097');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (58,'error','Необходимо указать версию модуля','10020978','2019-03-19 00:01:25.987');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (59,'error','Необходимо указать признак доступности модуля','10020978','2019-03-19 00:01:53.392');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (60,'error','Отключить модуль невозможно т.к. класс {0} используется.','10020978','2019-03-19 17:02:32.503');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (61,'error','Включить модуль невозможно т.к. модули классов {0} отключены. Необходимо включить хотя бы один родительский модуль.','10020978','2019-03-19 17:29:00.125');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (62,'error','Отключен модуль {0}.','10020978','2019-03-19 18:13:03.289');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (63,'error','Модуль {0} уже добавлен.','10020978','2019-03-19 21:39:32.697');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (64,'error','Значения атрибутов decimalseparator и thousandseparator не могут совпадать','40025111','2019-03-21 15:41:33.726');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (65,'error','Удаление атрибута {0} невозможно, так как существует привязка атрибута с классом {1}','40025111','2019-04-17 22:50:53.653');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (66,'error','Добавление класса невозможно, т.к. тип атрибута  не равен "placement"','20783','2019-04-29 16:29:14.246');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (500,'error','Системная ошибка: не передан тип действия (action_mode)','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (501,'error','Системная ошибка: не передан ИД объекта для обновления','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (502,'error','Системная ошибка: ожидается создание нового объекта, но при этом передан ИД уже существующего объекта','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (503,'error','Системная ошибка: не передан ИД родительского/связанного объекта','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (504,'error','Системная ошибка: объект не найден','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (505,'error','Системная ошибка: объект уже занят. Скорее всего, с ним сейчас работает другой пользователь','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (506,'error','Системная ошибка: родительский объект не найден','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (507,'error','Неправильно указан логин и/или пароль','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (508,'error','Недостаточно прав доступа, обратитесь к администратору системы','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (509,'error','Системная ошибка: нарушено ограничение уникальности','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (510,'error','Системная ошибка: нарушено ограничение целостности','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (511,'error','Системная ошибка при сохранении данных','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (512,'error','Ошибка разбора JSON','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (513,'error','Страница недоступна (нет прав доступа или страница не существует)','-11','2018-02-23 15:08:10.188');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (514,'error','Проводятся технические работы (сброс провайдера / сброс кэша / перезагрузка шлюза / т.п.), пожалуйста, подождите','10020788','2018-04-09 21:13:59.519');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (517,'error','Некорректная операция с семафором','10020788','2018-11-29 20:50:36.806');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (518,'error','Указанного семафора не существует','10020788','2018-09-09 16:08:10.994');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (900,'error','Необходимо указать тип отчета','10020788','2019-01-23 14:10:00.358');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
	VALUES (1000,'error','Неизвестная ошибка','-11','2018-02-23 15:08:10.188');

--changeset artemov_i:t_provider dbms:postgresql splitStatements:false stripComments:false
INSERT INTO s_mt.t_provider (ck_id, cv_name, cn_user, ct_change) VALUES ('admingate', 'Шлюз', '-11', '2018-03-07 09:08:46.214+03');
INSERT INTO s_mt.t_provider (ck_id, cv_name, cn_user, ct_change) VALUES ('meta', 'Метамодель', '-11', '2018-12-12 15:56:56.251854+03');
INSERT INTO s_mt.t_provider (ck_id, cv_name, cn_user, ct_change) VALUES ('auth', 'Авторизация', '-11', '2018-02-23 10:08:46.214+03');

--changeset artemov_i:t_semaphore dbms:postgresql splitStatements:false stripComments:false
INSERT INTO s_mt.t_semaphore (ck_id, cn_value) VALUES ('GUI_blocked', 0);

--changeset artemov_i:t_sys_setting dbms:postgresql splitStatements:false stripComments:false
INSERT INTO s_mt.t_sys_setting (ck_id, cv_value, cn_user, ct_change, cv_description) VALUES ('project_profile_page', '1875398035771', '20786', '2018-12-24 15:53:08.588515+03', 'ИД страницы-профиля');
INSERT INTO s_mt.t_sys_setting (ck_id, cv_value, cn_user, ct_change, cv_description) VALUES ('core_db_major_version', '1.27.0', '20788', '2019-01-04 11:55:14.369587+03', 'Версия релиза БД CORE');
INSERT INTO s_mt.t_sys_setting (ck_id, cv_value, cn_user, ct_change, cv_description) VALUES ('core_db_deployment_date', NULL, '20788', '2018-12-20 12:30:05.715705+03', 'Дата последнего деплоймента техплатформы (т.е. когда последний раз на этом стенде обновляли БД CORE)');
INSERT INTO s_mt.t_sys_setting (ck_id, cv_value, cn_user, ct_change, cv_description) VALUES ('core_db_commit', NULL, '20788', '2018-12-20 12:28:07.721659+03', 'Хэш коммита, по которому собрана установленная сборка БД CORE');
INSERT INTO s_mt.t_sys_setting (ck_id, cv_value, cn_user, ct_change, cv_description) VALUES ('core_db_patch', NULL, '10020788', '2018-12-09 00:00:00+03', 'Если стенд был пропатчен промежуточным патчем БД CORE (вне основного релиза) - в этом поле нужно указать подробности (хэш коммита или номер тикета)');
INSERT INTO s_mt.t_sys_setting (ck_id, cv_value, cn_user, ct_change, cv_description) VALUES ('project_db_major_version', NULL, '20848', '2019-05-13 14:11:03.648612+03', '## НАСТРОЙ МЕНЯ ## Версия релиза БД проекта');
INSERT INTO s_mt.t_sys_setting (ck_id, cv_value, cn_user, ct_change, cv_description) VALUES ('project_db_deployment_date', NULL, '10020788', '2018-12-09 00:00:00+03', '## НАСТРОЙ МЕНЯ ## Дата последнего деплоймента БД проектной сборки');
INSERT INTO s_mt.t_sys_setting (ck_id, cv_value, cn_user, ct_change, cv_description) VALUES ('project_db_commit', NULL, '10020788', '2018-12-09 00:00:00+03', '## НАСТРОЙ МЕНЯ ## Хэш коммита, по которому собрана установленная проектная сборка БД');
INSERT INTO s_mt.t_sys_setting (ck_id, cv_value, cn_user, ct_change, cv_description) VALUES ('project_db_patch', NULL, '10020788', '2018-12-09 00:00:00+03', '## НАСТРОЙ МЕНЯ ## Если стенд был пропатчен промежуточным проектным патчем БД (вне основного релиза) - в этом поле нужно указать подробности (хэш коммита или номер тикета)');
INSERT INTO s_mt.t_sys_setting (ck_id, cv_value, cn_user, ct_change, cv_description) VALUES ('instance_name', '/', '20788', '2018-11-24 14:35:55.99628+03', 'Имя экземпляра (по-хорошему, должно совпадать с именем в ссылке на стенд)');
INSERT INTO s_mt.t_sys_setting (ck_id, cv_value, cn_user, ct_change, cv_description) VALUES ('project_modules', 'MODULE_FIRST', '-11', '2019-01-30 11:55:14.369587+03', 'ТЕСТ (Олег Куценко)');
INSERT INTO s_mt.t_sys_setting (ck_id, cv_value, cn_user, ct_change, cv_description) VALUES ('project_about_box_title', 'CORE', '1', '2019-07-01 07:48:25.004041+03', 'Заголовок окна "О программе"');
INSERT INTO s_mt.t_sys_setting (ck_id, cv_value, cn_user, ct_change, cv_description) VALUES ('project_auth_title', 'Технологическая платформа', '1', '2019-07-01 07:49:09.903281+03', 'Заголовок окна авторизации');
INSERT INTO s_mt.t_sys_setting (ck_id, cv_value, cn_user, ct_change, cv_description) VALUES ('project_name', 'Технологическая платформа', '1', '2019-07-01 07:49:25.477157+03', 'Имя проекта (например, акроним из JIRA)');
INSERT INTO s_mt.t_sys_setting (ck_id, cv_value, cn_user, ct_change, cv_description) VALUES ('module_available', 'false', '1', '2019-07-04 10:26:31.709278+03', 'Включение загрузки всех модулей');
INSERT INTO s_mt.t_sys_setting (ck_id, cv_value, cn_user, ct_change, cv_description) VALUES ('project_about_box_footer', '', '1', '2019-07-09 17:41:53.27072+03', 'Футер окна "О программе"');
INSERT INTO s_mt.t_sys_setting (ck_id, cv_value, cn_user, ct_change, cv_description) VALUES ('project_about_box_description', '', '1', '2019-07-09 17:42:10.861909+03', 'Содержимое окна "О программе"');
INSERT INTO s_mt.t_sys_setting (ck_id, cv_value, cn_user, ct_change, cv_description) VALUES ('project_loader', 'default', '1', '2019-07-09 17:43:50.870453+03', 'Вид анимации лоадера');


--changeset artemov_i:t_icon_mdi dbms:postgresql splitStatements:false stripComments:false
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('30207564259C46109318C29AE813C26D', 'mdi-about', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('8636F2F825C946E7AAA2E75379F0EEB4', 'mdi-about-outline', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('0F17B7E984F340D5A0BF8EB363D6D823', 'mdi-ac-unit', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('64D77396E5054F8497644C4D886C1841', 'mdi-access-alarms', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('C25B62480F7A406796D3D64F084F1D64', 'mdi-access-point', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('9813A6A2EC7D41F4AD12584C2C71BAF8', 'mdi-access-point-network', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('7AF188C854DB465D99F4B068C96A5271', 'mdi-access-time', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('0C0EB9FFBFB54CB9962C3CDF2B0D9F3C', 'mdi-accessibility', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('26CDD255F05C4813A0E851B8019CBEE3', 'mdi-accessible', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('456B4643B5574AA39619E9B0EA51CB79', 'mdi-account-address', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('8761E2E915694BA3B419EBC0BD016115', 'mdi-account-alert', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('49CC659E778D497A9D7CC235F14745C2', 'mdi-account-balance', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('76110E814A6840848C3877642BD2B708', 'mdi-account-balance-wallet', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('A96385DA54124E1EA825095C5ADD6683', 'mdi-account-box', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('F8D698607A3046279F54A7B25949A548', 'mdi-account-box-multiple', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('C7AD9E94C888475583E156A33688AFD3', 'mdi-account-box-outline', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('CC6C7191A7784709851C72847B08D298', 'mdi-account-card-details', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('845E625F460642DCB207CA4F3D5A1D12', 'mdi-account-check', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('F98AC2F6053F4C088F8FDEF5933F515C', 'mdi-account-circle', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('CB6230302A894F1FB326F4E14F1D8806', 'mdi-account-convert', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('9C56747D10844553BF7D257EE5AB0BED', 'mdi-account-edit', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('BA9FBA80409D4CCCB97787CA42043F86', 'mdi-account-group', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('F6E8850AC41E467D8BDBF5B04801E6ED', 'mdi-account-heart', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('E5547100BEAC468BA4732CF65E27EBC2', 'mdi-account', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('6C14F12AAF764831A8A7E8F2F3201C5A', 'mdi-account-key', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('3B82FC9E88B4418CA2127F65241E66C7', 'mdi-account-location', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('B863F387A41B49C6A60FB54F08B00FA2', 'mdi-account-minus', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('7F261EDAAD7944BA9BB6E3B6554206CD', 'mdi-account-multiple-check', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('DEF77B4135604AF6946BC791B96966A6', 'mdi-account-multiple', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('5B990A6617244E4FAED7B1DD8F154945', 'mdi-account-multiple-minus', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('F119BEDD0C2D4BC48ABC8A619646C5CD', 'mdi-account-multiple-outline', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('07ABA8904E1D47DA97EA36CD7736668A', 'mdi-account-multiple-plus', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('85158A50D1374FF58A0C58294D6BAB1F', 'mdi-account-multiple-plus-outline', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('E051A01F3D3D4E0D84C1EEF22B673A3A', 'mdi-account-network', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('227A2D169D1B446483AEC8D773F6569F', 'mdi-account-off', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('E37C4792D1CA43FBA8BD43444C8FACA4', 'mdi-account-outline', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('B7D1583044F54594B8B1F4B27152BE22', 'mdi-account-plus', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('6DA983D48901489C8AE5838F28AD0669', 'mdi-account-plus-outline', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('76970809CEDA4A3F8E3DB5F6591F9F79', 'mdi-account-remove', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('A81945AB08184F798427445973B89C18', 'mdi-account-search', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('ED9C5D4865FE4E818CC145035143DBAB', 'mdi-account-search-outline', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('B4337250305D4286A6BAE69A5F895B5C', 'mdi-account-settings', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('49977B82225E42F395ED6BCCEF903F68', 'mdi-account-settings-variant', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('A46405FC48294EF990BCFA103521D27F', 'mdi-account-star', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('15E6B0871F9C4992831086C8FB413EA5', 'mdi-account-switch', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('679E4553948C4EA9A165F4C8525D120B', 'mdi-accusoft', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('3F9EA9D9289141FF80B62798D79B620F', 'mdi-achievement-award', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('5E4534EAFB2044CDAC468EE2D489971F', 'mdi-achievement', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('E3EE723198FA4054AEA6BC397BC91324', 'mdi-achievement-outline', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('396DE157DB1044878760B25C115F9B08', 'mdi-achievement-variant', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('8F1A2CBE1E514EE4B538616CAC32C4B7', 'mdi-alternate-email', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('FC5F283AADF947D4BD3BAEE3EB021013', 'mdi-achievement-variant-outline', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('3B4FE5CBB46F4D87B28956EC0F67F392', 'mdi-adb', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('6D475FCDD566488AA910CB23C0265E1E', 'mdi-add-alarm', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('234042415D544FFD8DF711C9F61B150B', 'mdi-add-alert', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('02C294D540934B0786412FCC01E3B285', 'mdi-add-box', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('77CFA1C337B7402692FF638F6FAC06C0', 'mdi-add-call', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('B4427B7244FF41EAAC8852C9A840799E', 'mdi-add-circle', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('42E2508613D24047A842DE2E066F9A15', 'mdi-add-circle-outline', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('5B22522913BB454C95E98626F02C4671', 'mdi-add', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('E8C4F14E72814E67BC8CB39689643052', 'mdi-add-location', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('A838E20F4DD64B688236113A0574CE30', 'mdi-add-shopping-cart', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('2038BAA193CA4198AF2487FAA22A1E4C', 'mdi-add-to-photos', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('04CD1EB8FA89431B918DA9124D213B9A', 'mdi-address-marker', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('10ECC954623C4E51B412A9CDF4ED66ED', 'mdi-adjust', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('C5D6424630144B608747D1104B3CE575', 'mdi-adobe', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('BE8AC892D4C64BE89C34BD56F47D98EB', 'mdi-aeroplane', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('7C4EA4BCD4C646BF9440C7BCFCD86E5A', 'mdi-aeroplane-landing', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('27F114AD48BA402B9BFE501B6EFCF26E', 'mdi-aeroplane-off', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('E16A0A2766954EFFA50EE28336F07156', 'mdi-aeroplane-shield', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('DCCE8D273A9D40D496D3407ECE1D9DD6', 'mdi-aeroplane-takeoff', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('BF9224EF4F654B76B1E3345F52DABB62', 'mdi-aerosol', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('6AA805A00AAB46A6B8536BF5996ECBAE', 'mdi-air-conditioner', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('4738FF77DD534DC997CB7BF7C8769E84', 'mdi-airballoon', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('7D403B4EDF0141D69B34539BD246885B', 'mdi-airline-seat-flat-angled', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('882BE1CC2BAA42949A764DC29CAA15F6', 'mdi-airline-seat-flat', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('D0CC9887F50F46A58B18A68259F1459F', 'mdi-airline-seat-individual-suite', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('4A319705CE4A4D4B84DE429F23EA5253', 'mdi-airline-seat-legroom-extra', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('5511F984FBDC406C8B4E373F976DFD63', 'mdi-airline-seat-legroom-normal', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('5BA71DBEA6EC4DA4A1B4B550C057DA2E', 'mdi-airline-seat-legroom-reduced', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('3B18B5C4F5B04447814A807E13DD1757', 'mdi-airline-seat-recline-extra', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('EA7E7A89CB614978841BCF7DB8410D32', 'mdi-airline-seat-recline-normal', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('49B3EA5E042847AEB95421EDF3D9D75E', 'mdi-airplane', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('8A42FEC013BE47528F5022D6DEAB8186', 'mdi-airplane-landing', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('384CF8F688E344CAAE2955D6B060B2C9', 'mdi-airplane-off', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('E72DCD97E84442EFA7219E057E83EF9F', 'mdi-airplane-shield', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('5FC46FF7421044648A3D47990855E4B0', 'mdi-airplane-takeoff', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('8CDBDCE9768E452F80071D96E5B47AAD', 'mdi-airplanemode-active', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('6038B4307A784CDFA5C1A97DED47A725', 'mdi-airplanemode-inactive', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('68FCFA85DF5847EAAF89D60CCD933F6A', 'mdi-airplay', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('8C80A101BBA6469BB074177EE70CB53D', 'mdi-airport', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('421F0EC5E9CF494182ECD372C4E0F47A', 'mdi-alarm-bell', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('A0764996DE24418393AD14D035427726', 'mdi-alarm-check', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('062189BEDDDA4A4EA1A06618CB876EA5', 'mdi-alarm', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('600EAAD311E449488AA3339FC4B27565', 'mdi-alarm-light', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('DC9058E6491B4C7A942C1E9DFAB57969', 'mdi-alarm-multiple', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('7C435F72BBF841E889B42842D0D52094', 'mdi-alarm-off', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('74F8BBCBC6CF4964A2280E4B3F9DA3A4', 'mdi-alarm-on', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('B9195CEA172740E5B3EC554704A0B4B1', 'mdi-alarm-plus', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('9DF88698C53D444AB9781F71DACB8BD3', 'mdi-alarm-snooze', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('0147027BCF964F85A41F96E431B32236', 'mdi-album', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('07BBE12941ED45B49588D073236A5C99', 'mdi-alert-box', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('1D613A90E6AD4BC4A7DE18999813E767', 'mdi-alert-circle', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('4209B78FE192437D87CC13837FAF7ACF', 'mdi-alert-circle-outline', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('1AC9D033246543D0B930330D203A41C0', 'mdi-alert-decagram', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('BBC5EA8613034077BED37BE7D9143737', 'mdi-alert', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('3AD029A422B34AE7A100F11232382E73', 'mdi-alert-octagon', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('C0D40A739EE24C2BAD07D55ABDE71049', 'mdi-alert-octagram', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('1997EE3432184EBFB656B7998D265ECC', 'mdi-alert-outline', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('D94DE7DB386D4CD6A46F1F88171F25C4', 'mdi-alien', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('14BD27071E5F42D783A0859F861CDC3A', 'mdi-all-inclusive', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('90AF55DBAE534E77B7C547BD6F6BE73C', 'mdi-alpha', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('9E1DF34D261D403FBB9009AA2ACF48EB', 'mdi-alphabetical', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('AD2ABC80A4014277B5D0D3DE9D554E8B', 'mdi-alternating-current', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('8CF547C3226C47449C64CE785A4FCD40', 'mdi-altimeter', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('1EC7D543460141509F85062998B041A6', 'mdi-amazon-alexa', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('80EC0D93AC2E498E92855C8654B4E26F', 'mdi-amazon-clouddrive', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('41DBE200DF5D48EA8D75F4F6A91FA784', 'mdi-amazon-drive', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('A6ED7120FC0B413BA683A8B617E26DAA', 'mdi-amazon', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('EE8415E340EC429AADE56A8931872B13', 'mdi-ambulance', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('327A5D8778B4478883E60F14368CFD6A', 'mdi-amp', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('30D4DAAC46BE4766907BBDCDDEB17692', 'mdi-amplifier', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('66E2E964D56047B39AD4002903FBEDD0', 'mdi-anchor', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('0AFFF2A83A904E499C0D7350C7A6BA09', 'mdi-android-debug-bridge', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('D02D759909694A5E859EFC22B30669A9', 'mdi-android-head', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('DB713A665696477CAF6B740C79C30406', 'mdi-android', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('CBD4A423B8DD4634A03C664DEB94BF8D', 'mdi-android-studio', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('B3413F38928B49A59C9ADA8AA3B750DB', 'mdi-angle-acute', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('5F75AB5001F243D6A62EADEA0FBA3175', 'mdi-angle-obtuse', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('1362EA8E2BAD4D61B7D9A7C5DDA3E300', 'mdi-angle-right', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('3CD74C38409448B99E7285390E767E15', 'mdi-angular', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('D458FDF7309E4F0B84BABFA412BB5C76', 'mdi-angularjs', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('5F6B4CD17AEC43FA866EB03E9CB21DB2', 'mdi-animation', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('8A20D179419C4F14AD1FC69BBD06CB35', 'mdi-animation-play', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('096B8F51DEE74BE69AF88D20258D854C', 'mdi-announcement', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('623B2FA704A44266A65BD981E68A9F50', 'mdi-anvil', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('752B8FCBCB704D07A8C59ACC26A6FD07', 'mdi-apple-finder', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('72DB1B186E4C4CAF84E4AC86D22F4CB1', 'mdi-apple-icloud', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('E40CD692BAF3480FACB095F9BC9F1D8E', 'mdi-apple', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('1C30D9CF92514925B7952FB854C15102', 'mdi-apple-ios', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('C07EA012F56749E683338516105CD4C2', 'mdi-apple-keyboard-caps', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('C3D01690E90E41C790273AC30E4968ED', 'mdi-apple-keyboard-command', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('508BD6EC9B9A4C7B93235E266233CD5A', 'mdi-apple-keyboard-control', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('18E5177338C240559BAEFD31D96DAC8C', 'mdi-apple-keyboard-option', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('FB09DAA1C01943F88420B64A514F13BE', 'mdi-apple-keyboard-shift', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('13F6975C73674492B8851A64DAE9E9E1', 'mdi-apple-mobileme', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('E1EA2C64A349435A90EB8A60DB165127', 'mdi-apple-safari', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('B4D8F105553441D0BAF23AEC6E05E560', 'mdi-application', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('578FA3D51C9D44008855E14D9F367AAA', 'mdi-approval', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('72253695A7EB41C3A22098F56CB78DD7', 'mdi-approve', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('825775D69A3B48C49CAC36B70339A497', 'mdi-apps', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('356B896FE6EC4DA783D4A5A383B4F033', 'mdi-arch', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('6EBC1AE0315F48229D15912DD4602CAF', 'mdi-archive', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('AB67521BB8814715A6C97E20601809C1', 'mdi-arena', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('AEE0A5472F394B34A2B47CCBE179F7CF', 'mdi-arrange-bring-forward', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('201D554CADB24FF08FA0BE668FEC3234', 'mdi-arrange-bring-to-front', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('544BD11AE3EF4A7D842BA81D83647458', 'mdi-arrange-send-backward', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('B157D2188B22420ABCAA5E02D339EEE7', 'mdi-arrange-send-to-back', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('F64AA4B3CD8B46F4832A1030FB5687C4', 'mdi-arrow-all', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('E785D0B0796144BB8379CAAC3A1DA2CC', 'mdi-arrow-back', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('69DEDF2E10F1410386418A1B4B341126', 'mdi-arrow-bottom-left', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('319E98E0F6B54FC194C33F87C196C6E1', 'mdi-arrow-bottom-right', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('F089BA6F5FE045F8B5342CA082219F92', 'mdi-arrow-collapse-all', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('A1BCD42E0FCA49C1A90982CA95D94AF1', 'mdi-arrow-collapse-down', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('80D0D24ADF5344BCA5DA1F61A7F18371', 'mdi-arrow-collapse-horizontal', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('1D9504D1C64E4DD894FFB4EF14E7E1A1', 'mdi-arrow-collapse', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('7B6E3AE1CF67440DB1969BA0A5779BC6', 'mdi-arrow-collapse-left', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('358D38C93F644C899DA5D7822BF51572', 'mdi-arrow-collapse-right', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('B137C0EE349745D7980691E25B675338', 'mdi-arrow-collapse-up', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('DDEAB56AA5174B47A008241B8FE97CB0', 'mdi-arrow-collapse-vertical', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('571D72AE1D254D059666C9181DB32A1D', 'mdi-arrow-compass', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('376CBF6B0F5F4081AA82DD06818865BB', 'mdi-arrow-compress-all', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('37ECDC134A104B24838FED90B87C116C', 'mdi-arrow-compress-down', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('325FD223215B437AA7A9560E81440499', 'mdi-arrow-compress', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('E363CCF56F80423DB348BC43FD1BBC4A', 'mdi-arrow-compress-left', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('00F1E28237394E7480BAFD17D5CC635E', 'mdi-arrow-compress-right', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('60ED16961B984564966ED131E84FB41B', 'mdi-arrow-compress-up', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('A2FF537BA0ED47289548FC13348E11E9', 'mdi-arrow-down-bold-box', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('9B7BDD524CFB41FEBF2121475B1D14F7', 'mdi-arrow-down-bold-box-outline', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('5005928364794274A77CFA10209D50FB', 'mdi-arrow-down-bold-circle', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('74AD54F7D713493DBA54064CBFC53030', 'mdi-arrow-down-bold-circle-outline', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('74CEA04E60C6461EA1E92591A1D57EF8', 'mdi-arrow-down-bold-hexagon-outline', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('DAD0E38CBC7C418FAF86EC814BE0F2BF', 'mdi-arrow-down-bold', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('FF9E8AAB94C64EEFAA3A3C3295421869', 'mdi-arrow-down-box', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('B85EB5D8C47142819D7A6BA4BF88601F', 'mdi-arrow-down-drop-circle', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('F8DFDAA0567E4699A1808C281DCA0031', 'mdi-arrow-down-drop-circle-outline', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('3F38A29B61D540309D6CC8BD656AC3ED', 'mdi-arrow-down', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('039D6FDBA9D54D4D9BDD7C185C6A9D18', 'mdi-arrow-down-thick', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('E35306FCADD54BF29B72D2BCD8AAE69C', 'mdi-arrow-downward', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('544AB1C4556E49EC818089B0AB53BF3F', 'mdi-arrow-drop-down-circle', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('BCECB299D9FF4BBAAA78313758C8DC2D', 'mdi-arrow-drop-down', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('DE206B119D1A4F1FB8CDC3D8D0C026D3', 'mdi-arrow-drop-up', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('B3858C2AAC2F4565ABC5E55DBDF89C38', 'mdi-arrow-expand-all', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('5EF5D2B497C7448E83CE7DA5C26A53B0', 'mdi-arrow-expand-down', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('E4F13C78BEB142EF852786652A786F25', 'mdi-arrow-expand-horizontal', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('52BB68DC3977418CA8F1D546F6A3C7B0', 'mdi-arrow-expand', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('6211DBEEFC114CA98518E1079C6A1E29', 'mdi-arrow-expand-left', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('018BC2F2EBAA42419667CB94782ED382', 'mdi-arrow-expand-right', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('56EC5FE8F4C14CA8975AD3B89E621FAF', 'mdi-arrow-expand-up', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('8919BB85F8D141F48C0C3DD5C1F6038C', 'mdi-arrow-expand-vertical', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('F4C45270BB474297BE8F13EB5B97061D', 'mdi-arrow-forward', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('63DB749378104D91BF499718BB5D3148', 'mdi-arrow-left-bold-box', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('0465E870C7BA4ECFAD6A02A3A45462B0', 'mdi-arrow-left-bold-box-outline', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('4D5D9205D8054095A9FB3D070EAFF94F', 'mdi-arrow-left-bold-circle', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('EFB6A07604494DF0A66E7422F34816E6', 'mdi-arrow-left-bold-circle-outline', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('D4DBF1F4CCDB4A8383C3C724AD6415BC', 'mdi-arrow-left-bold-hexagon-outline', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('900445DD87714C1E9DFABADD8543F4D1', 'mdi-arrow-left-bold', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('49252C96CE51425B8507F719A8EE8DF3', 'mdi-arrow-left-box', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('453C811BFE2D42B497461CD4928A1188', 'mdi-arrow-left-drop-circle', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('628875BCD7484535A155265D13D3AEDC', 'mdi-arrow-left-drop-circle-outline', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('69BC99D68B0D485F9D9A4A8B73253F97', 'mdi-arrow-left', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('2599F4932ED14C7E832CD32488EEEDCD', 'mdi-arrow-left-thick', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('4415816DB2B5415EA861B777E54BE13C', 'mdi-arrow-right-bold-box', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('79A7AF6DC5964B7EABB3E99D63C9A466', 'mdi-arrow-right-bold-box-outline', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('DED9C75F3C574FD9B715F3327610ADBC', 'mdi-arrow-right-bold-circle', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('4B0CEBE0485D465CA011416C8C6A9F08', 'mdi-arrow-right-bold-circle-outline', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('AE25511ADF3D4700BA42A20CEAFDC506', 'mdi-arrow-right-bold-hexagon-outline', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('CA60A3C3C7014DE9A79C7ADE1A3D3231', 'mdi-arrow-right-bold', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('AF4A3D3D85F34C8497CF5C79461041E4', 'mdi-arrow-right-box', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('ADE9954A96D74F11AEBFB9E51031A88C', 'mdi-arrow-right-drop-circle', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('74C18B96821C40899FE19458C31D8633', 'mdi-arrow-right-drop-circle-outline', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('CE7AE280692A47C5A3D61BA03E0AD674', 'mdi-arrow-right', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('AFD7F27BB74A47AF9F95A8751C2E860F', 'mdi-arrow-right-thick', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('E9007A8F95E141A6A15989111F3A8F50', 'mdi-arrow-rotate-left', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('1A3EDD29F2C84B5BB1FC1F3148D9DB25', 'mdi-arrow-rotate-right', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('ACC08A90FE1946B4A7A6144993F2540E', 'mdi-arrow-split-horizontal', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('A6332CEAC39D4DED8E6078D0CC39C708', 'mdi-arrow-split-vertical', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('D7E0E2A67A474407B1D17610D53E3518', 'mdi-arrow-top-left', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('C098993E3DC445B7AA8E5D811F6E2226', 'mdi-arrow-top-right', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('61877B68445E4BE883F851D4A1984928', 'mdi-arrow-up-bold-box', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('5A8619548F0B47DCA07E3D7D63CDBEAB', 'mdi-arrow-up-bold-box-outline', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('77CD99458831406FA60ABDF0D9CBD1AF', 'mdi-arrow-up-bold-circle', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('EE4BA40AD114448C97BF2AFB21BFE2F6', 'mdi-arrow-up-bold-circle-outline', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('DF8B3DF87CC344D0B9711B1AD0676542', 'mdi-arrow-up-bold-hexagon-outline', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('78C68AE22C8C4B9D8F8D38994806F4B0', 'mdi-arrow-up-bold', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('9746A1B1A9C94BD29E42589CB58F43E8', 'mdi-arrow-up-box', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('C3C25AC7241849D4B354366664D24963', 'mdi-arrow-up-drop-circle', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('300A246296CC4C9399B7073B893668ED', 'mdi-arrow-up-drop-circle-outline', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('5F151218399340B4B0DD289E1B2BE747', 'mdi-arrow-up', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('A5A7C6D6BC094AC1950C108D4385AAF8', 'mdi-arrow-up-thick', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('0C020ED971CB4CCBBB3DC7E1D73B8EC4', 'mdi-arrow-upward', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('4A206C67376240159AD40498D6CFEF39', 'mdi-artist', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('0BF8712B58574F5DA993E8637319F94B', 'mdi-assessment', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('8F2D9E605B4942AEB81A2BACF1B6ACA2', 'mdi-assignment', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('83F401DD18934C74AB97ED351CB92034', 'mdi-assignment-ind', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('9355128064C24F5090DE7EFE76FB71B0', 'mdi-assignment-late', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('FA40B78B30C1489F8BAB5B78C2DD5860', 'mdi-assignment-return', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('8C002AA619BE418596BF0C973E782F70', 'mdi-assignment-returned', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('CDDB436523274778B3A57883DD7FEB38', 'mdi-assignment-turned-in', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('AC471D348FDC41068F5C6ACEC8ED043C', 'mdi-assistant', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('710A93FBEBF24DCA857739344F03167C', 'mdi-assistant-photo', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('8660D8C8014C49809B3FAAE957A56D69', 'mdi-asterisk', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('1CC424CA04FE4CFBA49E3E827D3CA0DA', 'mdi-at', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('89C2B0A94A044D93A298602D46E30EED', 'mdi-atlassian', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('BD4FEFFD72504E259BDED33740B0514A', 'mdi-atom', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('BC3155F57CB64BBBA8D7556266234817', 'mdi-attach-drive', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('BE86ED29904E487F8E26EECCA48040A2', 'mdi-attach-file', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('101776FD0A814ECB8BC77648997997B7', 'mdi-attach-money', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('F6BD612820DF43BABE050556309E76E4', 'mdi-attachment', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('5D6DA99500674C9492D27A60F418CB17', 'mdi-attachment-vertical', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('5252C12F7EFD4080848E68E56CC1AEF7', 'mdi-audio', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('D8E7A8FA8DCD404090459BBAC6B5DB01', 'mdi-audio-off', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('EF3473E86FED44EEB6F47E0216ABD454', 'mdi-audio-video', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('35760EB7FED64C758ECF69A2F92E55C2', 'mdi-audiobook', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('531D2E986C164BD6AED29464D8BE7900', 'mdi-augmented-reality', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('B23C099CEE114511B8044F5DBA9E647A', 'mdi-auto-awesome', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('53995193A3C3474CBFD12CD7769A06A7', 'mdi-auto-awesome-mosaic', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('D888C9400F334660A71C05C5235B89EF', 'mdi-auto-awesome-motion', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('5ABF6DFE927B4E4EB1A6071FB57CB66C', 'mdi-auto-fix-high', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('0CB67A9A241E48C09EAA93E83146D0ED', 'mdi-auto-fix', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('231045F139F24EF2870DF5D71B5841D6', 'mdi-auto-stories', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('23016F6442B04E33BDA185EA90F22125', 'mdi-auto-towing', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('10ED471DAC984E00AB400400BFF6F982', 'mdi-auto-upload', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('81BABC46CBDD40F0A98F8BB201859CD7', 'mdi-autobahn', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('5306417B29894836A3A9D1501A4B08CE', 'mdi-autorenew', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('0F00F1AD32A541C1ABEBC4FA9B9CAB13', 'mdi-av-timer', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('F72A536D882A44DDA2116257FA5A1462', 'mdi-axe', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('8BEC2D4456574F52AFDE95F47E531CEF', 'mdi-azure', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('88B7FC9065F545DAAB31F683ED33307F', 'mdi-baby-buggy', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('DA7AADA95E3B424FBB4778934D596A3C', 'mdi-baby', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('883E97839D7A44958F87721B62672A72', 'mdi-backburger', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('9F012D6AFFD04ACEBEDE8CD693FD45EF', 'mdi-backspace', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('B36997E9C39747D2A9FEEBFD2E48A64A', 'mdi-backup', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('F75DDEAE39284554B7414993955B2EB2', 'mdi-backup-restore', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('1C3874C9BE1B4B18902AD308C17738FF', 'mdi-badminton', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('83FAC309D4014E8CBD136F21D01B84F0', 'mdi-ban', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('46741ECF7FE24B3680338127404850FE', 'mdi-bandcamp', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('23BB4BD5D1CA401CABF4A743DE828D25', 'mdi-bangladeshi-taka', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('4F50B69B8F664EEFAAA8009FE71ADAD0', 'mdi-bank', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('A4E49E383642435C8AB36EB42E231B93', 'mdi-bar-chart', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('1F80C1A164C045B2B837232494EA5118', 'mdi-barcode', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('D79B57058DEF45689F2BCD4E966089D0', 'mdi-barcode-scan', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('E6985E6EB9034243A249361A476E974E', 'mdi-barcode-scanner', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('F6A894AE9EE64C6FA9BF0BA33F483E57', 'mdi-barley', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('209BEED4C3C747268F4D054539EEB206', 'mdi-barrel', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('33591C59AA2E4E47B83629237A21F891', 'mdi-baseball-bat', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('B850DD3861984EABB0CA4ADC420BFB8D', 'mdi-baseball', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('73BD974A85E64752A762994FAFA582D5', 'mdi-basecamp', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('3C4DB3EB8CF8450EBF6BBDF5508B0BE8', 'mdi-basket-fill', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('A85D61F2F4C54EE9947850AC953AD379', 'mdi-basket', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('EAAC3EEDF3184B2290845B3C4B537E7C', 'mdi-basket-unfill', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('9F95CB888BD741858E19F2B1446778C8', 'mdi-basketball', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('7B21AB0AE4BC446488FDBCDE31972ADC', 'mdi-battery0', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('9A57B1FBC14C42A7AE4E4F1B8D9EDF3F', 'mdi-battery10-bluetooth', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('314474FB0336423FB095B6596DAD2C5A', 'mdi-battery10', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('5D62F0B9D75144E88343DA31A257DFD0', 'mdi-battery20-bluetooth', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('958A39E3960B425F9DF0976FCF26B76B', 'mdi-battery20', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('4D20B68499124AFDBDDAED69169018FE', 'mdi-battery30-bluetooth', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('BD01AA2C318740C5BDEB87EC33A3AFC0', 'mdi-battery30', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('A04F14863A4444BC8A8539FF681A84BD', 'mdi-battery40-bluetooth', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('028E824AB94C450F8001E15EDF89D784', 'mdi-battery40', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('A8507AC0264D441DB1768D362A955803', 'mdi-battery50-bluetooth', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('8EFA633CA78A4953BB87B1403E55BE55', 'mdi-battery50', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('A6B4623E3AE54088B30D69A82E978F77', 'mdi-battery60-bluetooth', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('01A68D43E2404DA2B0CE8127E407D015', 'mdi-battery60', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('8882234DE71D46A095E9DC5779F9C3A2', 'mdi-battery70-bluetooth', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('0CDBDFB5BF08498DA8AF092CE1337B99', 'mdi-battery70', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('9CD34DE5D5534337A2FD25E520596752', 'mdi-battery80-bluetooth', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('C770067C27EA477FA3D0B6D0DF999BAE', 'mdi-battery80', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('D1CD5843EE4C4D4C97C516666045E221', 'mdi-battery90-bluetooth', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('87805310582B4BF694AD36DF786A619F', 'mdi-battery90', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('A3A4A7C99A474A32A0025FBDC8FDC03C', 'mdi-battery100', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('79545D7AEE64466888B8B47C3C39005B', 'mdi-battery-alert-bluetooth', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('4DC3800A8B204239A1C2F27941F2206C', 'mdi-battery-alert', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('BBD8C4ADC5DA48F189064E2B35EBFC61', 'mdi-battery-bluetooth', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('271263F6D2B147DEACAFA922EF626FC8', 'mdi-battery-bluetooth-variant', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('01F1C40CB23E4D85863464E32E0D3B82', 'mdi-battery-charging10', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('F1F9C103A0174108A11A3D90E24513C4', 'mdi-battery-charging20', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('A51CE79573D342ED9BE5884706B30FD5', 'mdi-battery-charging30', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('3A51ABA651DA49369ED36E5C748A6B63', 'mdi-battery-charging40', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('CA54A5BB91F64FC38FB767659C87A1E0', 'mdi-battery-charging50', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('7BBD40A58B7E47B4A727FBBC85730727', 'mdi-battery-charging60', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('7C993F28A6A949D191FB9A28141DC716', 'mdi-battery-charging70', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('E33BDD45A36D458A84F819580130F187', 'mdi-battery-charging80', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('04697BCDC37745D3899E96125A564EB7', 'mdi-battery-charging90', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('232244AEDB294B53AAF9F08CE9146138', 'mdi-battery-charging100', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('AE8AC7128CC24363A27BF931901037D2', 'mdi-battery-charging-full', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('9A07C1F17D354B2981D50ECA323F4EF3', 'mdi-battery-charging', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('A1D3217007D246F586481551AEBF74BE', 'mdi-battery-charging-outline', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('68E71E5029C149E5B87FBCCD9D406723', 'mdi-battery-charging-wireless0', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('88DDD1134F8E4CE4997FA3F13805D81A', 'mdi-battery-charging-wireless10', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('A16A077C8B5E4D89AC033FD4A16DD922', 'mdi-battery-charging-wireless20', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('5885AC6AC1EA4EF1A23B14B9B784BE46', 'mdi-battery-charging-wireless30', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('C343C05F05064CF9B604615DEF6D71D4', 'mdi-battery-charging-wireless40', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('8528F4081B0A45A196285A7E80653F9B', 'mdi-battery-charging-wireless50', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('C8DF58F26D2B4D488767E6E3E0268670', 'mdi-battery-charging-wireless60', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('E585EEB968AA4D11ACFA350460C62167', 'mdi-battery-charging-wireless70', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('AE359F3DD188454EA104EC75859794EE', 'mdi-battery-charging-wireless80', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('DE90446566F2421890793C9649647585', 'mdi-battery-charging-wireless90', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('6DB2A8599C8B4439B4F1D66149FD42C0', 'mdi-battery-charging-wireless100', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('9077199F2EB84B69A167E1BDF93F6114', 'mdi-battery-charging-wireless-alert', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('75B13A03D8D84BFD9A9348A912D99A48', 'mdi-battery-charging-wireless-empty', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('E5931DDA01934D489302E4BEE6E6B5C5', 'mdi-battery-charging-wireless-full', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('3C39BFCB34374E27B9E336E328574FD2', 'mdi-battery-charging-wireless', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('CD062565C25B4DA799296EC5258E10A5', 'mdi-battery-charging-wireless-outline', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('8036DFEE88C242999D3C665949528BF4', 'mdi-battery-charging-wireless-warning', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('226BABB29F1D48F6BA83CA7B64F67E33', 'mdi-battery-empty', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('842BBF6AA60E4CE3AB56EF7765795F87', 'mdi-battery-full', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('C1FF662B9E494454BB28472B06B868D0', 'mdi-battery', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('F021733B3B8A4746927AD11C2F36CA7C', 'mdi-battery-minus', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('7B8156E0835043A6BEABDBDFFCB6B9AD', 'mdi-battery-negative', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('C7647B6CE49D44AE998366FF92B7021F', 'mdi-battery-outline', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('6DA0814DCA3D40D5A78CCC5B274F46BA', 'mdi-battery-plus', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('FF392EF1EA764AC9BAFD406383A86688', 'mdi-battery-positive', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('AC41E5146FCE41E7901DBB43373D807F', 'mdi-battery-saver', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('C58D521803F14C6A8CC224CE7A4E6385', 'mdi-battery-std', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('5D1C7BC60F68472CAC186CD3B76CE89F', 'mdi-battery-unknown-bluetooth', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('6A29BFABD1A3414B85C8F1FAFED605C5', 'mdi-battery-unknown', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('D098C29A107E4064BEBB2D768092E276', 'mdi-battery-warning', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('F32E8CFAE187493AA607B2080F5438A9', 'mdi-beach', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('BE707D93051941F2AA264FE9FBE292D4', 'mdi-beaker', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('C797B95FD12D44D99CF6CBA91A77EE8F', 'mdi-beats', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('585AB5747A914A58B34778E5497872E7', 'mdi-bed-empty', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('BF9D2FD091C34976AFB1DD1C5140E0B1', 'mdi-bed', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('F0007DB38EA340E18A0F17C83F2A3E20', 'mdi-beenhere', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('73947B30782A41C78BC0A4C39EA7761F', 'mdi-beer', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('A15A6B7FBC0A42578E1757F3C23BCE66', 'mdi-behance', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('B111211D73D6400FAD1023FC7F027E17', 'mdi-bell', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('C317580F90A945F68FDEAEACB3B6271E', 'mdi-bell-off', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('924A07A8FA8A4F62A407E036367C97F0', 'mdi-bell-outline', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('C11118D45019429FBB0C2249AD9E5011', 'mdi-bell-plus', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('E000474969764F869D7FE20B93CD9FE4', 'mdi-bell-ring', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('715D28047EF14804B6539ACF5A7B8CD5', 'mdi-bell-ring-outline', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('C9D5A7F0FC36482BA026C7DEEDDDC6DA', 'mdi-bell-sleep', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('63F2E2A0E3AA4606911EC0EFF4F465C1', 'mdi-beta', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('9915F6E5095D43E5AC9B26E4E19FFF46', 'mdi-bezier', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('C1FEA079F3324A06BDA01B4A67824AFA', 'mdi-bible', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('E10519BA29D74802802FC6D898D8594B', 'mdi-bicycle', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('6B1315D115A84D7A930871DEEDD547D3', 'mdi-bike', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('0C5D39C0B030409B9BC658C9A032CBA9', 'mdi-bin-circle', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('F3D339E70D88417A8E9E542152770B0D', 'mdi-bin-empty', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('433047951F8146858CCC60FC5F2E1DFE', 'mdi-bin', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('460BCE42ED6F43F3BAF8EE41735542B9', 'mdi-bin-restore', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('EBC6B052E3A84B7E938880C328A82A79', 'mdi-bin-variant', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('1261C700DC7C4EF68D7B1707B7E5E2FF', 'mdi-bing', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('B7EBE5661E4E4F9C8CAF7CC27816F88A', 'mdi-binoculars', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('6B09B8BA927C4472BA5C41F277C0609B', 'mdi-bio', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('809F2E05DD6A4DC5812D22B68D698CE5', 'mdi-biohazard', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('9B48617D1F314951A0D3EC4B2FFB06C4', 'mdi-bitbucket', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
INSERT INTO s_mt.t_icon
(ck_id, cv_name, cv_font, ck_user, ct_change)
VALUES('237CF473DCED4E6791E458C3F0F44D61', 'mdi-bitcoin', 'mdi', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405');
