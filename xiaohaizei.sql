DROP TABLE IF EXISTS `test`;

CREATE TABLE `test` (
	`id` INTEGER(11) NOT NULL AUTO_INCREMENT,
	`passport` VARCHAR(40) NOT NULL DEFAULT '',	
	`role_level` INTEGER(11) NOT NULL DEFAULT '0', 
	`name` VARCHAR(256) NOT NULL DEFAULT '',
	PRIMARY KEY(`id`)
)TYPE=InnoDB;

INSERT INTO `test` (`passport`,`role_level`,`name`) VALUES ('1001',20,'test1');
INSERT INTO `test` (`passport`,`role_level`,`name`) VALUES ('1002',22,'test2');
INSERT INTO `test` (`passport`,`role_level`,`name`) VALUES ('1003',23,'test3');
INSERT INTO `test` (`passport`,`role_level`,`name`) VALUES ('1004',25,'test4');
INSERT INTO `test` (`passport`,`role_level`,`name`) VALUES ('1005',28,'test5');
INSERT INTO `test` (`passport`,`role_level`,`name`) VALUES ('1006',18,'test6');
INSERT INTO `test` (`passport`,`role_level`,`name`) VALUES ('1007',19,'test7');
INSERT INTO `test` (`passport`,`role_level`,`name`) VALUES ('1008',32,'test8');
INSERT INTO `test` (`passport`,`role_level`,`name`) VALUES ('1009',27,'test9');
INSERT INTO `test` (`passport`,`role_level`,`name`) VALUES ('1010',22,'test10');
INSERT INTO `test` (`passport`,`role_level`,`name`) VALUES ('1011',43,'test11');
INSERT INTO `test` (`passport`,`role_level`,`name`) VALUES ('1012',45,'test12');
INSERT INTO `test` (`passport`,`role_level`,`name`) VALUES ('1001',1,'test13');
INSERT INTO `test` (`passport`,`role_level`,`name`) VALUES ('1004',2,'test14');
INSERT INTO `test` (`passport`,`role_level`,`name`) VALUES ('1005',1,'test15');
INSERT INTO `test` (`passport`,`role_level`,`name`) VALUES ('1008',1,'test16');

select count(*),passport from test group by passport having count(*)>1;

DROP TABLE IF EXISTS `tmp`;

CREATE TABLE `tmp` (
	`id` INTEGER(11) NOT NULL AUTO_INCREMENT,
	`mem_id` INTEGER(11) NOT NULL DEFAULT '0',
	`passport` VARCHAR(40) NOT NULL DEFAULT '',
	PRIMARY KEY(`id`)
)TYPE=InnoDB;

INSERT INTO `tmp` (`mem_id`,`passport`) select max(id),passport from test group by passport having count(*)>1;

update `test` set passport=concat('back_',passport) where passport=any(select passport from `tmp`) and id in (select mem_id from `tmp`);
