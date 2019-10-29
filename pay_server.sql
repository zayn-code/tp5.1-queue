-- phpMyAdmin SQL Dump
-- version 4.4.15.10
-- https://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: 2019-10-29 21:02:49
-- 服务器版本： 5.5.57-log
-- PHP Version: 5.4.45

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pay_server`
--

-- --------------------------------------------------------

--
-- 表的结构 `front_notify`
--

CREATE TABLE IF NOT EXISTS `front_notify` (
  `id` int(11) NOT NULL,
  `money` decimal(10,2) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `datetime` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `front_notify`
--

INSERT INTO `front_notify` (`id`, `money`, `uid`, `token`, `datetime`) VALUES
(1, '1.00', 1, 'b8afd92884c94a2b74a7f58eba287fea', '2019-10-29 19:59:10'),
(2, '1.00', 1, 'b8afd92884c94a2b74a7f58eba287fea', '2019-10-29 20:00:53');

-- --------------------------------------------------------

--
-- 表的结构 `jobs`
--

CREATE TABLE IF NOT EXISTS `jobs` (
  `id` int(11) NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `jobs`
--

INSERT INTO `jobs` (`id`, `queue`, `payload`, `attempts`, `reserved`, `reserved_at`, `available_at`, `created_at`) VALUES
(1, 'NotifyOrder', '{"job":"app\\\\queue\\\\job\\\\NotifyOrder","data":{"id":13,"order_id":"201910272300187399","attach":"10012","money":"1.00","date":"2019-10-27 23:00:18","notify_url":"http:\\/\\/127.0.0.1\\/cs.php","status":0,"uid":1}}', 0, 0, NULL, 1572188439, 1572188439);

-- --------------------------------------------------------

--
-- 表的结构 `order`
--

CREATE TABLE IF NOT EXISTS `order` (
  `id` int(11) NOT NULL,
  `order_id` varchar(255) DEFAULT NULL,
  `attach` varchar(255) DEFAULT NULL,
  `money` decimal(10,2) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `notify_url` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0未支付，1支付成功',
  `uid` int(11) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `order`
--

INSERT INTO `order` (`id`, `order_id`, `attach`, `money`, `date`, `notify_url`, `status`, `uid`) VALUES
(1, '201910132056298145', '10012', '1.00', '2019-10-13 20:56:29', 'http://127.0.0.1/cs.php', 0, 0),
(2, '201910132105238037', '10012', '1.00', '2019-10-13 21:05:23', 'http://127.0.0.1/cs.php', 1, 0),
(3, '201910132105412316', '10012', '2.00', '2019-10-13 21:05:41', 'http://127.0.0.1/cs.php', 0, 0),
(4, '201910132118333462', '10012', '1.00', '2019-10-13 21:18:33', 'http://127.0.0.1/cs.php', 1, 0),
(5, '201910132120378691', '10012', '1.00', '2019-10-13 21:20:37', 'http://127.0.0.1/cs.php', 1, 0),
(6, '201910132120518077', '10012', '2.00', '2019-10-13 21:20:51', 'http://127.0.0.1/cs.php', 0, 0),
(7, '201910132121189425', '10012', '3.00', '2019-10-13 21:21:18', 'http://127.0.0.1/cs.php', 0, 0),
(8, '201910132121245978', '10012', '4.00', '2019-10-13 21:21:24', 'http://127.0.0.1/cs.php', 0, 0),
(9, '201910132124019825', '10012', '1.00', '2019-10-13 21:24:01', 'http://127.0.0.1/cs.php', 1, 1),
(10, '201910132236264234', '10012', '1.00', '2019-10-13 22:36:26', 'http://127.0.0.1/cs.php', 1, 1),
(11, '201910272217077182', '10012', '1.00', '2019-10-27 22:17:07', 'http://127.0.0.1/cs.php', 0, 10),
(12, '201910272234109164', '10012', '1.00', '2019-10-27 22:34:10', 'http://127.0.0.1/cs.php', 0, 1),
(13, '201910272300187399', '10012', '1.00', '2019-10-27 23:00:18', 'http://127.0.0.1/cs.php', 1, 1),
(14, '201910292059188930', '7303', '1.00', '2019-10-29 20:59:18', 'http://rywa.grdszgs.com/Home/Wxpay/threePayNotify', 0, 1);

-- --------------------------------------------------------

--
-- 表的结构 `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL,
  `account` varchar(20) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态0未启用1已启用',
  `ewm` varchar(500) DEFAULT NULL,
  `moneys` varchar(255) DEFAULT NULL,
  `total_money` decimal(10,2) NOT NULL DEFAULT '0.00',
  `token` varchar(255) DEFAULT NULL
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `user`
--

INSERT INTO `user` (`id`, `account`, `password`, `status`, `ewm`, `moneys`, `total_money`, `token`) VALUES
(1, 'zayn1', 'e10adc3949ba59abbe56e057f20f883e', 1, '/uploads/20191027/91f63f9e7f34e900ec6c29bfacadcac9.png', '1,5', '6.00', 'b8afd92884c94a2b74a7f58eba287fea'),
(2, 'zayn2', 'e10adc3949ba59abbe56e057f20f883e', 0, NULL, NULL, '0.00', '5d9720758cb4d9f6b4ea6ec15c0bb32e'),
(3, 'zayn3', 'e10adc3949ba59abbe56e057f20f883e', 0, NULL, NULL, '0.00', 'd24b3f3786da3e5eba83c4c3f8c18bcf'),
(4, 'zayn4', 'e10adc3949ba59abbe56e057f20f883e', 0, NULL, NULL, '0.00', 'c44bccbba23e8eae51a6d1d46134d65b'),
(5, 'zayn5', 'e10adc3949ba59abbe56e057f20f883e', 0, NULL, NULL, '0.00', '8b4b98b85c9beed003f8240e0d83fca4');

-- --------------------------------------------------------

--
-- 表的结构 `user_moneys`
--

CREATE TABLE IF NOT EXISTS `user_moneys` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `money` decimal(10,2) NOT NULL,
  `datetime` datetime NOT NULL DEFAULT '1970-01-01 00:00:00'
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `user_moneys`
--

INSERT INTO `user_moneys` (`id`, `uid`, `money`, `datetime`) VALUES
(11, 1, '5.00', '1970-01-01 00:00:00'),
(10, 1, '1.00', '2019-10-29 20:59:18'),
(9, 2, '2.00', '1970-01-01 00:00:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `front_notify`
--
ALTER TABLE `front_notify`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_moneys`
--
ALTER TABLE `user_moneys`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `front_notify`
--
ALTER TABLE `front_notify`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `order`
--
ALTER TABLE `order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `user_moneys`
--
ALTER TABLE `user_moneys`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=12;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
