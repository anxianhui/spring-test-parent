/*
Navicat MySQL Data Transfer

Source Server         : 
Source Server Version : 50707
Source Host           : 172.16.11.79:3306
Source Database       : 

Target Server Type    : MYSQL
Target Server Version : 50707
File Encoding         : 65001

Date: 2016-08-05 14:07:11
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `t_authority`
-- ----------------------------
DROP TABLE IF EXISTS `t_authority`;
CREATE TABLE `t_authority` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `createDate` datetime DEFAULT NULL,
  `modifyDate` datetime DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `introduction` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_2de1894kluppxvqidwgwl8w5c` (`parent_id`),
  CONSTRAINT `FK_2de1894kluppxvqidwgwl8w5c` FOREIGN KEY (`parent_id`) REFERENCES `t_authority` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_authority
-- ----------------------------
INSERT INTO `t_authority` VALUES ('1', null, null, null, null, '系统管理', null, null);
INSERT INTO `t_authority` VALUES ('2', null, null, 'admin:role', null, '角色管理', 'admin/role/list.htm', '1');
INSERT INTO `t_authority` VALUES ('3', null, null, 'admin:user', null, '用户管理', 'admin/user/list.htm', '1');
INSERT INTO `t_authority` VALUES ('4', null, null, null, null, '员工管理', null, null);
INSERT INTO `t_authority` VALUES ('5', null, null, 'admin:employee', null, '员工管理', 'admin/employee/list.htm', '4');

-- ----------------------------
-- Table structure for `t_role`
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `createDate` datetime DEFAULT NULL,
  `modifyDate` datetime DEFAULT NULL,
  `introduction` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_role
-- ----------------------------
INSERT INTO `t_role` VALUES ('1', null, '2016-08-05 11:10:09', '管理员', '管理员');
INSERT INTO `t_role` VALUES ('2', '2016-08-05 13:19:46', null, '普通用户普通用户普通用户', '普通用户');

-- ----------------------------
-- Table structure for `t_user`
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `createDate` datetime DEFAULT NULL,
  `modifyDate` datetime DEFAULT NULL,
  `isEnabled` bit(1) DEFAULT NULL,
  `pwdSalt` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `userName` varchar(50) NOT NULL,
  `userPwd` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_31dvqbihssv9g5q18n72w9vs2` (`userName`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('1', null, null, '', 'uD8yaf2p86JHVh1tiMUwzQ==', null, 'admin', 'QqhsW2lCn/ZcgsJOim04qIPCehIo50rObtqFFqe1+hQ=');
INSERT INTO `t_user` VALUES ('4', null, null, '', '6XNxj8W5XlDAxUcrj4XEwQ==', '11111', 'zhangsan', 'O/jX+gw33pL6kBEF/TiiOcAijZvdShWfo74VlUo3pRI=');

-- ----------------------------
-- Table structure for `xx_role_authority`
-- ----------------------------
DROP TABLE IF EXISTS `xx_role_authority`;
CREATE TABLE `xx_role_authority` (
  `role_id` bigint(20) NOT NULL,
  `authority_id` bigint(20) NOT NULL,
  PRIMARY KEY (`role_id`,`authority_id`),
  KEY `FK_2em6c40j733uhebtxw48v2k3x` (`authority_id`),
  CONSTRAINT `FK_2em6c40j733uhebtxw48v2k3x` FOREIGN KEY (`authority_id`) REFERENCES `t_authority` (`id`),
  CONSTRAINT `FK_6e83ele4qv6xh8f368acwu9ci` FOREIGN KEY (`role_id`) REFERENCES `t_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xx_role_authority
-- ----------------------------
INSERT INTO `xx_role_authority` VALUES ('1', '2');
INSERT INTO `xx_role_authority` VALUES ('1', '3');
INSERT INTO `xx_role_authority` VALUES ('1', '5');
INSERT INTO `xx_role_authority` VALUES ('2', '5');

-- ----------------------------
-- Table structure for `xx_user_role`
-- ----------------------------
DROP TABLE IF EXISTS `xx_user_role`;
CREATE TABLE `xx_user_role` (
  `user_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `FK_t8mw49lowyfbefdjjrowh8hmx` (`role_id`),
  CONSTRAINT `FK_bcpge6300fug84eutcvbtouo9` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`),
  CONSTRAINT `FK_t8mw49lowyfbefdjjrowh8hmx` FOREIGN KEY (`role_id`) REFERENCES `t_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xx_user_role
-- ----------------------------
INSERT INTO `xx_user_role` VALUES ('1', '1');
INSERT INTO `xx_user_role` VALUES ('4', '2');
