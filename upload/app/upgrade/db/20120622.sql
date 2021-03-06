ALTER TABLE `[#DB_PREFIX#]answer_comments` CHANGE `message` `message` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL;
ALTER TABLE `[#DB_PREFIX#]question_comments` CHANGE `message` `message` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL;
INSERT INTO `[#DB_PREFIX#]system_setting` (`varname`, `value`) VALUES ('comment_limit', 's:1:"0";');
INSERT INTO `[#DB_PREFIX#]system_setting` (`varname`, `value`) VALUES ('backup_dir', '');
INSERT INTO `[#DB_PREFIX#]system_setting` (`varname`, `value`) VALUES ('best_answer_reput', 's:2:"20";');
INSERT INTO `[#DB_PREFIX#]system_setting` (`varname`, `value`) VALUES ('publisher_reputation_factor', 's:2:"10";');
ALTER TABLE `[#DB_PREFIX#]users` DROP `admin_id`;
ALTER TABLE `[#DB_PREFIX#]users` CHANGE `group_id` `group_id` SMALLINT( 5 ) NULL DEFAULT '0' COMMENT '用户组';
ALTER TABLE `[#DB_PREFIX#]users` ADD `reputation_group` TINYINT( 3 ) NULL DEFAULT '0' COMMENT '威望对应组' AFTER `group_id`;
UPDATE `[#DB_PREFIX#]users` SET group_id = 4 WHERE group_id = 11;
UPDATE `[#DB_PREFIX#]users` SET group_id = 3 WHERE valid_email = 0;
UPDATE `[#DB_PREFIX#]users` SET reputation_group = 5;

DROP TABLE IF EXISTS `[#DB_PREFIX#]users_group`;
CREATE TABLE `[#DB_PREFIX#]users_group` (
  `group_id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(3) DEFAULT '0' COMMENT '0-会员组 1-系统组',
  `custom` tinyint(1) DEFAULT '0' COMMENT '是否自定义',
  `group_name` varchar(50) NOT NULL,
  `reputation_lower` int(11) DEFAULT '0',
  `reputation_higer` int(11) DEFAULT '0',
  `reputation_factor` float DEFAULT '0' COMMENT '威望系数',
  `permission` text COMMENT '权限设置',
  PRIMARY KEY (`group_id`)
) ENGINE=[#DB_ENGINE#]  DEFAULT CHARSET=utf8;

INSERT INTO `[#DB_PREFIX#]users_group` (`group_id`, `type`, `custom`, `group_name`, `reputation_lower`, `reputation_higer`, `reputation_factor`, `permission`) VALUES
(1, 0, 0, '超级管理员', 0, 0, 5, 'a:10:{s:16:"is_administortar";s:1:"1";s:12:"is_moderator";s:1:"0";s:16:"publish_question";s:1:"1";s:13:"edit_question";s:1:"1";s:10:"edit_topic";s:1:"1";s:13:"upload_attach";s:1:"1";s:11:"publish_url";s:1:"1";s:11:"human_valid";s:1:"0";s:19:"question_valid_hour";s:1:"0";s:17:"answer_valid_hour";s:1:"0";}'),
(2, 0, 0, '前台管理员', 0, 0, 4, 'a:10:{s:16:"is_administortar";s:1:"0";s:12:"is_moderator";s:1:"1";s:16:"publish_question";s:1:"1";s:13:"edit_question";s:1:"1";s:10:"edit_topic";s:1:"1";s:13:"upload_attach";s:1:"1";s:11:"publish_url";s:1:"1";s:11:"human_valid";s:1:"0";s:19:"question_valid_hour";s:1:"0";s:17:"answer_valid_hour";s:1:"0";}'),
(3, 0, 0, '未验证会员', 0, 0, 0, 'a:10:{s:16:"is_administortar";s:1:"0";s:12:"is_moderator";s:1:"0";s:16:"publish_question";s:1:"1";s:13:"edit_question";s:1:"0";s:10:"edit_topic";s:1:"0";s:13:"upload_attach";s:1:"0";s:11:"publish_url";s:1:"0";s:11:"human_valid";s:1:"1";s:19:"question_valid_hour";s:1:"2";s:17:"answer_valid_hour";s:1:"2";}'),
(4, 0, 0, '普通会员', 0, 0, 0, 'a:10:{s:16:"is_administortar";s:1:"0";s:12:"is_moderator";s:1:"0";s:16:"publish_question";s:1:"1";s:13:"edit_question";s:1:"0";s:10:"edit_topic";s:1:"0";s:13:"upload_attach";s:1:"1";s:11:"publish_url";s:1:"0";s:11:"human_valid";s:1:"1";s:19:"question_valid_hour";s:2:"10";s:17:"answer_valid_hour";s:2:"10";}'),
(5, 1, 0, '注册会员', 0, 100, 1, 'a:10:{s:16:"is_administortar";s:1:"0";s:12:"is_moderator";s:1:"0";s:16:"publish_question";s:1:"1";s:13:"edit_question";s:1:"0";s:10:"edit_topic";s:1:"0";s:13:"upload_attach";s:1:"0";s:11:"publish_url";s:1:"0";s:11:"human_valid";s:1:"1";s:19:"question_valid_hour";s:1:"5";s:17:"answer_valid_hour";s:1:"5";}'),
(6, 1, 0, '初级会员', 100, 200, 1, 'a:10:{s:16:"is_administortar";s:1:"0";s:12:"is_moderator";s:1:"0";s:16:"publish_question";s:1:"1";s:13:"edit_question";s:1:"0";s:10:"edit_topic";s:1:"0";s:13:"upload_attach";s:1:"1";s:11:"publish_url";s:1:"1";s:11:"human_valid";s:1:"1";s:19:"question_valid_hour";s:1:"5";s:17:"answer_valid_hour";s:1:"5";}'),
(7, 1, 0, '中级会员', 200, 500, 1, 'a:10:{s:16:"is_administortar";s:1:"0";s:12:"is_moderator";s:1:"0";s:16:"publish_question";s:1:"1";s:13:"edit_question";s:1:"0";s:10:"edit_topic";s:1:"1";s:13:"upload_attach";s:1:"1";s:11:"publish_url";s:1:"1";s:11:"human_valid";s:1:"0";s:19:"question_valid_hour";s:1:"0";s:17:"answer_valid_hour";s:1:"0";}'),
(8, 1, 0, '高级会员', 500, 1000, 1, 'a:10:{s:16:"is_administortar";s:1:"0";s:12:"is_moderator";s:1:"0";s:16:"publish_question";s:1:"1";s:13:"edit_question";s:1:"1";s:10:"edit_topic";s:1:"1";s:13:"upload_attach";s:1:"1";s:11:"publish_url";s:1:"1";s:11:"human_valid";s:1:"0";s:19:"question_valid_hour";s:1:"0";s:17:"answer_valid_hour";s:1:"0";}'),
(9, 1, 0, '核心会员', 1000, 999999, 1, 'a:10:{s:16:"is_administortar";s:1:"0";s:12:"is_moderator";s:1:"0";s:16:"publish_question";s:1:"1";s:13:"edit_question";s:1:"1";s:10:"edit_topic";s:1:"1";s:13:"upload_attach";s:1:"1";s:11:"publish_url";s:1:"1";s:11:"human_valid";s:1:"0";s:19:"question_valid_hour";s:1:"0";s:17:"answer_valid_hour";s:1:"0";}');

ALTER TABLE `[#DB_PREFIX#]users_sina` DROP `oauth_token`;
ALTER TABLE `[#DB_PREFIX#]users_sina` DROP `oauth_token_secret`;
ALTER TABLE `[#DB_PREFIX#]users_sina` DROP `domain`;
ALTER TABLE `[#DB_PREFIX#]users_sina` ADD `access_token` VARCHAR (64) NULL DEFAULT '';
DELETE FROM `[#DB_PREFIX#]users_sina`;
ALTER TABLE `[#DB_PREFIX#]answer_vote` ADD `reputation_factor` INT (10) NULL DEFAULT '0';

ALTER TABLE `[#DB_PREFIX#]users` DROP `credit`;
ALTER TABLE `[#DB_PREFIX#]users` DROP `integral`;

DROP TABLE IF EXISTS `[#DB_PREFIX#]cache`;
CREATE TABLE `[#DB_PREFIX#]cache` (
  `key` varchar(255) NOT NULL DEFAULT '',
  `data` text,
  `expire` int(10) DEFAULT NULL,
  PRIMARY KEY (`key`),
  KEY `expire` (`expire`)
) ENGINE=[#DB_ENGINE#] DEFAULT CHARSET=utf8;

ALTER TABLE `[#DB_PREFIX#]question_keyword` CHANGE `auto_id` `auto_id` INT(10) NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY(`auto_id`);
ALTER TABLE `[#DB_PREFIX#]question_keyword` DROP INDEX `auto_id`;
ALTER TABLE `[#DB_PREFIX#]users_ucenter` DROP INDEX `uc_uid`;