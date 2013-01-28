ALTER TABLE `[#DB_PREFIX#]users` DROP INDEX `user_name_fulltext`;
ALTER TABLE `[#DB_PREFIX#]users` DROP `user_name_fulltext`;
ALTER TABLE `[#DB_PREFIX#]topic` DROP INDEX `topic_title_fulltext`;
ALTER TABLE `[#DB_PREFIX#]topic` DROP `topic_title_fulltext`;

CREATE TABLE `[#DB_PREFIX#]approval` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `type` varchar(16) DEFAULT NULL,
  `data` mediumtext NOT NULL,
  `uid` int(11) NOT NULL DEFAULT '0',
  `time` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `uid` (`uid`),
  KEY `time` (`time`)
) ENGINE=[#DB_ENGINE#]  DEFAULT CHARSET=utf8;

UPDATE `[#DB_PREFIX#]system_setting` SET `value` = concat('s:', CHAR_LENGTH(`value`), ':"', `value`, '";') WHERE `varname` = 'db_engine';

ALTER TABLE `[#DB_PREFIX#]attach` ADD `wait_approval` TINYINT( 1 ) NOT NULL DEFAULT '0';
ALTER TABLE `[#DB_PREFIX#]attach` ADD INDEX (  `wait_approval` );

INSERT INTO `[#DB_PREFIX#]system_setting` (`varname`, `value`) VALUES ('default_timezone', 's:9:"Etc/GMT-8";');

ALTER TABLE `[#DB_PREFIX#]users` ADD `default_timezone` VARCHAR( 32 ) NULL;

DROP TABLE `[#DB_PREFIX#]mail_queue`;
DROP TABLE `[#DB_PREFIX#]bulk_email`;

CREATE TABLE `[#DB_PREFIX#]edm_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `message` mediumtext NOT NULL,
  `subject` varchar(255) NOT NULL,
  `from_name` varchar(255) NOT NULL,
  `time` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=[#DB_ENGINE#] DEFAULT CHARSET=utf8;

CREATE TABLE `[#DB_PREFIX#]edm_taskdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `taskid` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `sent_time` int(10) NOT NULL,
  `view_time` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `taskid` (`taskid`),
  KEY `sent_time` (`sent_time`),
  KEY `view_time` (`view_time`)
) ENGINE=[#DB_ENGINE#] DEFAULT CHARSET=utf8;

CREATE TABLE `[#DB_PREFIX#]edm_unsubscription` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `time` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `email` (`email`)
) ENGINE=[#DB_ENGINE#] DEFAULT CHARSET=utf8;

CREATE TABLE `[#DB_PREFIX#]edm_userdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usergroup` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `usergroup` (`usergroup`)
) ENGINE=[#DB_ENGINE#] DEFAULT CHARSET=utf8;


CREATE TABLE `[#DB_PREFIX#]edm_usergroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `time` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=[#DB_ENGINE#] DEFAULT CHARSET=utf8;
