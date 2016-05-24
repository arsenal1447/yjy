/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50624
Source Host           : localhost:3306
Source Database       : yunjianyi

Target Server Type    : MYSQL
Target Server Version : 50624
File Encoding         : 65001

Date: 2016-05-24 17:09:40
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `follow`
-- ----------------------------
DROP TABLE IF EXISTS `follow`;
CREATE TABLE `follow` (
  `user_id` int(11) NOT NULL COMMENT '用户',
  `follow_id` int(11) NOT NULL COMMENT '关注了',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1用户;2节点;3主题',
  PRIMARY KEY (`user_id`,`follow_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of follow
-- ----------------------------

-- ----------------------------
-- Table structure for `menu`
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL COMMENT '菜单名称',
  `route` varchar(256) DEFAULT NULL COMMENT '访问路由',
  `order` int(11) DEFAULT NULL COMMENT '排序',
  `data` text COMMENT '图标',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('3', '菜单管理', '/menu/index', '20', '<i class=\"fa fa-tags\"></i>');
INSERT INTO `menu` VALUES ('4', '建议管理', '/topic/index', '1', '<i class=\"fa fa-pencil\"></i>');
INSERT INTO `menu` VALUES ('5', '回复管理', '/reply/index', '4', '<i class=\"fa fa-reply\"></i>');
INSERT INTO `menu` VALUES ('6', '用户管理', '/user/index', '3', '<i class=\"fa fa-user\"></i>');
INSERT INTO `menu` VALUES ('7', '节点管理', '/node/index', '4', '<i class=\"fa fa-tags\"></i>');
INSERT INTO `menu` VALUES ('8', 'TAB管理', '/tab/index', '5', '<i class=\"fa fa-navicon\"></i>');
INSERT INTO `menu` VALUES ('10', '清除缓存', '/site/clean-cache', '100', '<i class=\"fa fa-trash\"></i>');
INSERT INTO `menu` VALUES ('12', 'TAB右侧菜单', '/tab-nav/index', '19', '<i class=\"fa fa-server\"></i>');
INSERT INTO `menu` VALUES ('13', '建议正文管理', '/topic-content/index', '2', '<i class=\"fa fa-pencil\"></i>');
INSERT INTO `menu` VALUES ('14', '节点广告管理', '/node-ad/index', '5', '<i class=\"fa fa-buysellads\"></i>');
INSERT INTO `menu` VALUES ('15', 'tab广告管理', '/tab-ad/index', '5', '<i class=\"fa fa-buysellads\"></i>');
INSERT INTO `menu` VALUES ('16', '节点推荐链接管理', '/node-link/index', '5', '<i class=\"fa fa-buysellads\"></i>');
INSERT INTO `menu` VALUES ('17', '后台首页', '/site/index', '0', '<i class=\"fa fa-dashboard\"></i>');

-- ----------------------------
-- Table structure for `node`
-- ----------------------------
DROP TABLE IF EXISTS `node`;
CREATE TABLE `node` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '节点ID',
  `tab_id` int(11) DEFAULT NULL COMMENT '所属tab',
  `name` varchar(50) NOT NULL COMMENT '节点名称',
  `enname` varchar(45) NOT NULL COMMENT '英文名称',
  `parent_id` int(11) DEFAULT NULL COMMENT '父节点',
  `desc` varchar(150) NOT NULL COMMENT '节点描述',
  `logo` varchar(30) NOT NULL COMMENT 'logo',
  `is_hidden` tinyint(1) DEFAULT '0' COMMENT '是否隐藏节点',
  `need_login` tinyint(1) NOT NULL DEFAULT '0' COMMENT '需要登陆',
  `bg` varchar(30) DEFAULT NULL COMMENT '背景图',
  `use_bg` tinyint(1) NOT NULL DEFAULT '0' COMMENT '启用背景图片',
  `bg_color` varchar(20) DEFAULT NULL COMMENT '背景颜色',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `created` int(11) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `tab_id` (`tab_id`),
  CONSTRAINT `node_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `node` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `node_ibfk_2` FOREIGN KEY (`tab_id`) REFERENCES `tab` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of node
-- ----------------------------
INSERT INTO `node` VALUES ('1', null, '系统建议', 'system suggest', null, '第一个', '201605240853107185.jpg', '0', '0', '201605240853108199.jpg', '0', '', '1', '1464079990');

-- ----------------------------
-- Table structure for `node_ad`
-- ----------------------------
DROP TABLE IF EXISTS `node_ad`;
CREATE TABLE `node_ad` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `node_id` int(11) NOT NULL COMMENT '节点',
  `content` text NOT NULL COMMENT '广告内容',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '启用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of node_ad
-- ----------------------------

-- ----------------------------
-- Table structure for `node_link`
-- ----------------------------
DROP TABLE IF EXISTS `node_link`;
CREATE TABLE `node_link` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `node_id` int(11) NOT NULL COMMENT '节点',
  `content` text NOT NULL COMMENT '链接正文',
  `status` tinyint(1) DEFAULT '0' COMMENT '启用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of node_link
-- ----------------------------

-- ----------------------------
-- Table structure for `notice`
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `topic_id` int(11) NOT NULL COMMENT '主题id',
  `from_user_id` int(11) NOT NULL COMMENT '来自用户',
  `to_user_id` int(11) NOT NULL COMMENT '传至用户',
  `msg` text COMMENT '消息内容',
  `is_read` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否已读',
  `type` tinyint(1) DEFAULT NULL COMMENT '1:评论;2:评论@;3:关注了主题',
  `created` int(11) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `to_user_id` (`to_user_id`,`is_read`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of notice
-- ----------------------------

-- ----------------------------
-- Table structure for `reply`
-- ----------------------------
DROP TABLE IF EXISTS `reply`;
CREATE TABLE `reply` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `user_id` int(11) NOT NULL COMMENT '评论者',
  `topic_id` int(11) NOT NULL COMMENT '主题',
  `content` text NOT NULL COMMENT '评论内容',
  `created` int(11) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `topic_id` (`topic_id`),
  CONSTRAINT `reply_ibfk_1` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of reply
-- ----------------------------

-- ----------------------------
-- Table structure for `tab`
-- ----------------------------
DROP TABLE IF EXISTS `tab`;
CREATE TABLE `tab` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'tab id',
  `name` varchar(20) NOT NULL COMMENT 'tab名称',
  `enname` varchar(20) NOT NULL COMMENT '英文名称',
  `bg` varchar(30) DEFAULT NULL COMMENT '背景图',
  `bg_color` varchar(20) DEFAULT NULL COMMENT '背景颜色',
  `use_bg` tinyint(1) NOT NULL DEFAULT '0' COMMENT '启用背景图',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tab
-- ----------------------------

-- ----------------------------
-- Table structure for `tab_ad`
-- ----------------------------
DROP TABLE IF EXISTS `tab_ad`;
CREATE TABLE `tab_ad` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `tab_id` int(11) NOT NULL COMMENT 'tab',
  `content` text NOT NULL COMMENT '广告内容',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '启用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tab_ad
-- ----------------------------

-- ----------------------------
-- Table structure for `tab_nav`
-- ----------------------------
DROP TABLE IF EXISTS `tab_nav`;
CREATE TABLE `tab_nav` (
  `tab_id` int(11) NOT NULL COMMENT 'tab id',
  `name` varchar(25) NOT NULL COMMENT '名称',
  `link` varchar(20) NOT NULL COMMENT '链接',
  `sort` int(11) NOT NULL COMMENT '排序',
  PRIMARY KEY (`tab_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tab_nav
-- ----------------------------

-- ----------------------------
-- Table structure for `topic`
-- ----------------------------
DROP TABLE IF EXISTS `topic`;
CREATE TABLE `topic` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(300) NOT NULL COMMENT '主题标题',
  `user_id` int(11) NOT NULL COMMENT '作者',
  `node_id` int(11) NOT NULL COMMENT '节点',
  `need_login` tinyint(1) NOT NULL DEFAULT '0' COMMENT '需要登录',
  `click` int(11) NOT NULL DEFAULT '0' COMMENT '点击数',
  `follow` int(11) NOT NULL DEFAULT '0' COMMENT '收藏人数',
  `reply` int(11) NOT NULL DEFAULT '0' COMMENT '回复数',
  `last_reply_user` varchar(255) DEFAULT NULL COMMENT '最后回复',
  `last_reply_time` int(11) DEFAULT NULL COMMENT '最后回复时间',
  `updated_at` int(11) NOT NULL COMMENT '最后更新',
  `created` int(11) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of topic
-- ----------------------------
INSERT INTO `topic` VALUES ('1', '订单的', '2', '1', '0', '0', '0', '0', null, null, '1464080005', '1464080005');

-- ----------------------------
-- Table structure for `topic_content`
-- ----------------------------
DROP TABLE IF EXISTS `topic_content`;
CREATE TABLE `topic_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `topic_id` int(11) NOT NULL COMMENT '主题ID',
  `content` text NOT NULL COMMENT '主题正文',
  `is_append` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否追加',
  `created` int(11) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `topic_id` (`topic_id`),
  CONSTRAINT `topic_content_ibfk_1` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of topic_content
-- ----------------------------

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL COMMENT '用户名',
  `auth_key` varchar(32) NOT NULL,
  `password_hash` varchar(255) NOT NULL COMMENT '密码',
  `password_reset_token` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL COMMENT '邮箱',
  `email_verify_token` varchar(256) DEFAULT NULL COMMENT '邮箱激活token',
  `avatar` varchar(200) NOT NULL DEFAULT 'default.png' COMMENT '头像',
  `role` smallint(6) NOT NULL DEFAULT '10',
  `status` smallint(6) NOT NULL DEFAULT '10',
  `email_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '邮箱激活',
  `desc` varchar(200) DEFAULT NULL COMMENT '一句话介绍',
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'admin', '85e7ahcThR1Btqu-wqfouYVIBfHwtd3a', '$2y$13$F9n7tFBSOy35PjDZe7hHYOS/h4omRZlGxYpUGPrdANV5fB1CC0qL.', null, 'admin@yourdomain.com', 'h_DDbTznUkIkjqO8JRRTszUrkHtzwvwC_1435751017', 'default.png', '20', '1', '1', 'yunjianyi', '1435749537', '1436710272');
INSERT INTO `user` VALUES ('2', 'zxx123', 'B4H-jbnBtAB9Epa_1dsscYSofrqt_SFf', '$2y$13$96vY434Mj8s/j.Zza.Z0Pe2l91egiBOoIYYkzrMwE5EpHJoWq8Z5e', null, '297208251@qq.com', null, '201605240837157094.jpg', '10', '1', '1', null, '1464078497', '1464079035');
