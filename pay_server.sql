/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50553
Source Host           : 127.0.0.1:3306
Source Database       : pay_server

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2019-11-06 16:28:02
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for front_notify
-- ----------------------------
DROP TABLE IF EXISTS `front_notify`;
CREATE TABLE `front_notify` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `money` decimal(10,2) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='前台回调';

-- ----------------------------
-- Records of front_notify
-- ----------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='异步回调任务';

-- ----------------------------
-- Records of jobs
-- ----------------------------

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
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COMMENT='下单订单';

-- ----------------------------
-- Records of order
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(20) DEFAULT NULL,
  `nickname` varchar(50) NOT NULL,
  `password` varchar(50) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态0未启用1已启用',
  `ewm` varchar(500) DEFAULT NULL,
  `moneys` varchar(255) DEFAULT NULL,
  `total_money` decimal(10,2) NOT NULL DEFAULT '0.00',
  `token` varchar(255) DEFAULT NULL,
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常1删除',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COMMENT='收款用户';

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'zayn1', '呵呵', 'e10adc3949ba59abbe56e057f20f883e', '0', '/uploads/20191030/29f2ae714a2013725a458e4a4fd70e7e.png', '1,5', '12.00', 'b8afd92884c94a2b74a7f58eba287fea', '0');
INSERT INTO `user` VALUES ('6', 'abcd55', '', 'ab25cdbd759039967bac0dbd12f05bbc', '0', '/uploads/20191029/bc020b0b69b9986edd8002dda33dd16b.png', '0.1,0.2,0.3,0.4,0.5', '27.70', '7638ee5f4b8ac3a2dc1a96ea7127e1f3', '0');
INSERT INTO `user` VALUES ('7', 'zayn2', '', 'e10adc3949ba59abbe56e057f20f883e', '0', null, null, '0.00', '984a51cc7ef7108e798c7dbd92a41ccf', '0');
INSERT INTO `user` VALUES ('8', 'xxxxxxxxx', '等等等等', '4338a860fedb6bf55b6adcc7e9d6337a', '1', '/uploads/20191103/bf0c5ba310d07e6c18471e417282912d.png', '12,24,36,50,200', '25.60', '0fa0c84bfc08c7a8d13ed770e3010b0b', '0');
INSERT INTO `user` VALUES ('9', 'zayn123', 'hhbj', 'e10adc3949ba59abbe56e057f20f883e', '0', '/uploads/20191103/a73a815918a2652b91b8a8c62d16f17d.png', '55,67', '0.00', '4a9fc6ef01a835308e139416b0265231', '0');
INSERT INTO `user` VALUES ('10', 'hl111111', '共勉', '670b14728ad9902aecba32e22fa4f6bd', '1', '/uploads/20191105/4cb139b120a09d74f4a900db3c84c8a5.png', '12,24,36,50,100,200', '36.00', '28c60c377a142f3a101ea6c021be9801', '0');

-- ----------------------------
-- Table structure for user_moneys
-- ----------------------------
DROP TABLE IF EXISTS `user_moneys`;
CREATE TABLE `user_moneys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `money` decimal(10,2) NOT NULL,
  `datetime` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '下单时间，判断二维码是否被占用',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COMMENT='收款用户的赞赏码金额列表';

-- ----------------------------
-- Records of user_moneys
-- ----------------------------
