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
