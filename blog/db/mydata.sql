-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2015-04-14 05:29:50
-- 服务器版本: 5.5.41-0ubuntu0.14.04.1
-- PHP 版本: 5.5.9-1ubuntu4.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 数据库: `mydata`
--

-- --------------------------------------------------------

--
-- 表的结构 `my_content`
--

CREATE TABLE IF NOT EXISTS `my_content` (
  `f_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `f_time` datetime NOT NULL,
  `f_name` varchar(32) NOT NULL,
  `f_content` varchar(280) NOT NULL,
  PRIMARY KEY (`f_id`),
  KEY `f_time` (`f_time`),
  KEY `f_name` (`f_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='content table' AUTO_INCREMENT=1 ;

--
-- 表的结构 `my_user`
--

CREATE TABLE IF NOT EXISTS `my_user` (
  `f_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `f_name` varchar(32) NOT NULL,
  `f_key` varchar(32) NOT NULL,
  `f_email` varchar(64) NOT NULL,
  PRIMARY KEY (`f_id`),
  UNIQUE KEY `f_name` (`f_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=gbk COMMENT='user table' AUTO_INCREMENT=2 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
