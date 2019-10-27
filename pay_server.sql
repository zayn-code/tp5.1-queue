/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50553
Source Host           : 127.0.0.1:3306
Source Database       : pay_server

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2019-10-27 23:15:53
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for jobs
-- ----------------------------
DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jobs
-- ----------------------------
INSERT INTO `jobs` VALUES ('1', 'NotifyOrder', '{\"job\":\"app\\\\queue\\\\job\\\\NotifyOrder\",\"data\":{\"id\":13,\"order_id\":\"201910272300187399\",\"attach\":\"10012\",\"money\":\"1.00\",\"date\":\"2019-10-27 23:00:18\",\"notify_url\":\"http:\\/\\/127.0.0.1\\/cs.php\",\"status\":0,\"uid\":1}}', '0', '0', null, '1572188439', '1572188439');

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` varchar(255) DEFAULT NULL,
  `attach` varchar(255) DEFAULT NULL,
  `money` decimal(10,2) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `notify_url` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0未支付，1支付成功',
  `uid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES ('1', '201910132056298145', '10012', '1.00', '2019-10-13 20:56:29', 'http://127.0.0.1/cs.php', '0', '0');
INSERT INTO `order` VALUES ('2', '201910132105238037', '10012', '1.00', '2019-10-13 21:05:23', 'http://127.0.0.1/cs.php', '1', '0');
INSERT INTO `order` VALUES ('3', '201910132105412316', '10012', '2.00', '2019-10-13 21:05:41', 'http://127.0.0.1/cs.php', '0', '0');
INSERT INTO `order` VALUES ('4', '201910132118333462', '10012', '1.00', '2019-10-13 21:18:33', 'http://127.0.0.1/cs.php', '1', '0');
INSERT INTO `order` VALUES ('5', '201910132120378691', '10012', '1.00', '2019-10-13 21:20:37', 'http://127.0.0.1/cs.php', '1', '0');
INSERT INTO `order` VALUES ('6', '201910132120518077', '10012', '2.00', '2019-10-13 21:20:51', 'http://127.0.0.1/cs.php', '0', '0');
INSERT INTO `order` VALUES ('7', '201910132121189425', '10012', '3.00', '2019-10-13 21:21:18', 'http://127.0.0.1/cs.php', '0', '0');
INSERT INTO `order` VALUES ('8', '201910132121245978', '10012', '4.00', '2019-10-13 21:21:24', 'http://127.0.0.1/cs.php', '0', '0');
INSERT INTO `order` VALUES ('9', '201910132124019825', '10012', '1.00', '2019-10-13 21:24:01', 'http://127.0.0.1/cs.php', '1', '1');
INSERT INTO `order` VALUES ('10', '201910132236264234', '10012', '1.00', '2019-10-13 22:36:26', 'http://127.0.0.1/cs.php', '1', '1');
INSERT INTO `order` VALUES ('11', '201910272217077182', '10012', '1.00', '2019-10-27 22:17:07', 'http://127.0.0.1/cs.php', '0', '10');
INSERT INTO `order` VALUES ('12', '201910272234109164', '10012', '1.00', '2019-10-27 22:34:10', 'http://127.0.0.1/cs.php', '0', '1');
INSERT INTO `order` VALUES ('13', '201910272300187399', '10012', '1.00', '2019-10-27 23:00:18', 'http://127.0.0.1/cs.php', '1', '1');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(20) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态0未启用1已启用',
  `ewm` varchar(500) DEFAULT NULL,
  `moneys` varchar(255) DEFAULT NULL,
  `total_money` decimal(10,2) NOT NULL DEFAULT '0.00',
  `token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'zayn1', 'e10adc3949ba59abbe56e057f20f883e', '1', '/uploads/20191027/91f63f9e7f34e900ec6c29bfacadcac9.png', '1,5', '6.00', 'b8afd92884c94a2b74a7f58eba287fea');
INSERT INTO `user` VALUES ('2', 'zayn2', 'e10adc3949ba59abbe56e057f20f883e', '0', null, null, '0.00', '5d9720758cb4d9f6b4ea6ec15c0bb32e');
INSERT INTO `user` VALUES ('3', 'zayn3', 'e10adc3949ba59abbe56e057f20f883e', '0', null, null, '0.00', 'd24b3f3786da3e5eba83c4c3f8c18bcf');
INSERT INTO `user` VALUES ('4', 'zayn4', 'e10adc3949ba59abbe56e057f20f883e', '0', null, null, '0.00', 'c44bccbba23e8eae51a6d1d46134d65b');
INSERT INTO `user` VALUES ('5', 'zayn5', 'e10adc3949ba59abbe56e057f20f883e', '0', null, null, '0.00', '8b4b98b85c9beed003f8240e0d83fca4');

-- ----------------------------
-- Table structure for user_moneys
-- ----------------------------
DROP TABLE IF EXISTS `user_moneys`;
CREATE TABLE `user_moneys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `money` decimal(10,2) NOT NULL,
  `datetime` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of user_moneys
-- ----------------------------
INSERT INTO `user_moneys` VALUES ('11', '1', '5.00', '1970-01-01 00:00:00');
INSERT INTO `user_moneys` VALUES ('10', '1', '1.00', '1970-01-01 00:00:00');
INSERT INTO `user_moneys` VALUES ('9', '2', '2.00', '1970-01-01 00:00:00');
