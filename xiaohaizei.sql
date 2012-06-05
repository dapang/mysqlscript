#查询是否用重复帐号
select count(role_id),passport from `mem_role` group by passport having count(role_id)>1;

#创建临时表保存重复帐号 role_id
DROP TABLE IF EXISTS `mem_role_tmp`;

CREATE TABLE `mem_role_tmp` (
	`id` INTEGER(11) NOT NULL AUTO_INCREMENT,
	`role_id` INTEGER(11) NOT NULL DEFAULT '0',
	`passport` VARCHAR(40) NOT NULL DEFAULT '',
	PRIMARY KEY(`id`)
)TYPE=InnoDB;

INSERT INTO `mem_role_tmp` (`role_id`,`passport`) select max(role_id),passport from `mem_role` group by passport having count(role_id)>1;

#去重
update `mem_role` set passport=concat('back_',passport) where passport=any(select passport from `mem_role_tmp`) and role_id in (select role_id from `meme_role_tmp`);
