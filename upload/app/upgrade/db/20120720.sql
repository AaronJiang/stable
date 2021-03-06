CREATE TABLE `[#DB_PREFIX#]user_action_history_data` (
  `history_id` int(11) unsigned NOT NULL,
  `associate_content` text,
  `associate_attached` text,
  PRIMARY KEY (`history_id`)
) ENGINE=[#DB_ENGINE#] DEFAULT CHARSET=utf8;

INSERT INTO  `[#DB_PREFIX#]user_action_history_data` (
 `history_id` ,
 `associate_content` ,
 `associate_attached`
)
SELECT `history_id` ,  `associate_content` ,  `associate_attached` FROM `[#DB_PREFIX#]user_action_history`;

ALTER TABLE `[#DB_PREFIX#]user_action_history` DROP `associate_content`;
ALTER TABLE `[#DB_PREFIX#]user_action_history` DROP `associate_attached`;

ALTER TABLE `[#DB_PREFIX#]user_action_history` ADD  `associate_attached` INT( 11 ) NULL DEFAULT NULL;
ALTER TABLE `[#DB_PREFIX#]user_action_history` DROP INDEX `associate_type`;
ALTER TABLE `[#DB_PREFIX#]user_action_history` ADD KEY `associate` (`associate_type`,`associate_action`);
ALTER TABLE `[#DB_PREFIX#]user_action_history` ADD KEY (  `add_time` );
ALTER TABLE `[#DB_PREFIX#]user_action_history` ADD KEY (  `uid` );
ALTER TABLE `[#DB_PREFIX#]user_action_history` ADD KEY (  `associate_attached` );
ALTER TABLE `[#DB_PREFIX#]user_action_history` ADD KEY `associate_with_id` (  `associate_id`, `associate_type`, `associate_action` );


CREATE TABLE `[#DB_PREFIX#]notification_data` (
  `notification_id` int(11) unsigned NOT NULL,
  `data` text,
  PRIMARY KEY (`notification_id`)
) ENGINE=[#DB_ENGINE#] DEFAULT CHARSET=utf8;

INSERT INTO  `[#DB_PREFIX#]notification_data` (
 `notification_id` ,
 `data`
)
SELECT `notification_id` , `data` FROM `[#DB_PREFIX#]notification`;

ALTER TABLE `[#DB_PREFIX#]notification` DROP `data`;
ALTER TABLE `[#DB_PREFIX#]notification` ADD KEY `recipient_read_flag` (`recipient_uid`,`read_flag`);
ALTER TABLE `[#DB_PREFIX#]notification` ADD KEY `model` (`model_type`,`source_id`);

ALTER TABLE `[#DB_PREFIX#]user_action_history` CHANGE `associate_type` `associate_type` TINYINT( 1 ) NULL DEFAULT NULL COMMENT '关联类型: 1 问题 2 回答 3 评论 4 话题';
ALTER TABLE `[#DB_PREFIX#]user_action_history` CHANGE  `associate_action`  `associate_action` SMALLINT( 3 ) NULL DEFAULT NULL COMMENT  '操作类型';

ALTER TABLE `[#DB_PREFIX#]users` ADD KEY (  `reputation` );
ALTER TABLE `[#DB_PREFIX#]users` ADD KEY (  `reputation_update_time` );
ALTER TABLE `[#DB_PREFIX#]users` ADD KEY (  `group_id` );
ALTER TABLE `[#DB_PREFIX#]users` ADD KEY (  `agree_count` );
ALTER TABLE `[#DB_PREFIX#]users` ADD KEY (  `thanks_count` );
ALTER TABLE `[#DB_PREFIX#]users` ADD KEY (  `forbidden` );
ALTER TABLE `[#DB_PREFIX#]users` ADD KEY (  `valid_email` );
ALTER TABLE `[#DB_PREFIX#]reputation_topic` ADD KEY (  `topic_count` );
ALTER TABLE `[#DB_PREFIX#]answer` ADD KEY (  `agree_count` );
ALTER TABLE `[#DB_PREFIX#]answer` ADD KEY (  `against_count` );
ALTER TABLE `[#DB_PREFIX#]answer` ADD KEY (  `add_time` );
ALTER TABLE `[#DB_PREFIX#]question` ADD KEY (  `update_time` );
ALTER TABLE `[#DB_PREFIX#]question` ADD KEY (  `add_time` );
ALTER TABLE `[#DB_PREFIX#]question` ADD KEY (  `published_uid` );
ALTER TABLE `[#DB_PREFIX#]question` ADD KEY (  `answer_count` );
ALTER TABLE `[#DB_PREFIX#]question` ADD KEY (  `question_content` );
ALTER TABLE `[#DB_PREFIX#]question_keyword` DROP INDEX `keyword`;
ALTER TABLE `[#DB_PREFIX#]question_keyword` ADD KEY (  `question_id` );
ALTER TABLE `[#DB_PREFIX#]question_keyword` ADD KEY (  `keyword` );


ALTER TABLE `[#DB_PREFIX#]notice` ADD KEY ( `dialog_id` );
ALTER TABLE `[#DB_PREFIX#]notice_dialog` ADD KEY ( `recipient_uid` );
ALTER TABLE `[#DB_PREFIX#]notice_dialog` ADD KEY ( `sender_uid` );
ALTER TABLE `[#DB_PREFIX#]notice_dialog` ADD KEY ( `last_time` );
ALTER TABLE `[#DB_PREFIX#]notice_recipient` ADD KEY ( `recipient_uid` );
ALTER TABLE `[#DB_PREFIX#]notice_recipient` ADD KEY ( `sender_uid` );
ALTER TABLE `[#DB_PREFIX#]notice_recipient` ADD KEY ( `notice_id` );
ALTER TABLE `[#DB_PREFIX#]notice_recipient` ADD KEY ( `dialog_id` );

ALTER TABLE `[#DB_PREFIX#]answer` ADD `force_fold` TINYINT( 1 ) NULL DEFAULT '0' COMMENT '强制折叠';

ALTER TABLE `[#DB_PREFIX#]users_online` CHANGE `last_active` `last_active` INT( 11 ) NULL DEFAULT '0' COMMENT '上次活动时间';
ALTER TABLE `[#DB_PREFIX#]users_online` CHANGE `ip` `ip` BIGINT( 12 ) NULL DEFAULT '0' COMMENT '客户端ip';
ALTER TABLE `[#DB_PREFIX#]users_online` CHANGE `active_url` `active_url` VARCHAR( 255 ) NULL DEFAULT NULL COMMENT '停留页面';
ALTER TABLE `[#DB_PREFIX#]users_online` CHANGE `user_agent` `user_agent` VARCHAR( 255 ) NULL DEFAULT NULL COMMENT '用户客户端信息';

ALTER TABLE `[#DB_PREFIX#]topic_question` ADD KEY ( `topic_id` );
ALTER TABLE `[#DB_PREFIX#]topic_focus` ADD KEY ( `topic_id` );
ALTER TABLE `[#DB_PREFIX#]topic_focus` ADD KEY `topic_uid` ( `topic_id`, `uid` );
ALTER TABLE `[#DB_PREFIX#]topic_experience` ADD KEY `topic_uid` ( `topic_id`, `uid` );
ALTER TABLE `[#DB_PREFIX#]user_follow` ADD KEY `user_follow` ( `fans_uid`, `friend_uid` );
ALTER TABLE `[#DB_PREFIX#]question_focus` ADD KEY `question_uid` ( `question_id`, `uid` );
ALTER TABLE `[#DB_PREFIX#]answer_comments` ADD KEY ( `time` );
ALTER TABLE `[#DB_PREFIX#]question_comments` ADD KEY ( `time` );

DELETE FROM `[#DB_PREFIX#]notification` WHERE `action_type` IN (109, 112);
