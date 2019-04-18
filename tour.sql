/*
Navicat MySQL Data Transfer

Source Server         : 本地
Source Server Version : 50713
Source Host           : localhost:3306
Source Database       : tour

Target Server Type    : MYSQL
Target Server Version : 50713
File Encoding         : 65001

Date: 2019-04-19 00:26:24
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for app_demo_base
-- ----------------------------
DROP TABLE IF EXISTS `app_demo_base`;
CREATE TABLE `app_demo_base` (
  `id` bigint(20) NOT NULL COMMENT '编号',
  `title` varchar(50) DEFAULT NULL COMMENT '标题',
  `publish` datetime DEFAULT NULL COMMENT '发布时间',
  `content` mediumtext COMMENT '正文',
  `deleted` bit(1) DEFAULT b'0' COMMENT '删除',
  `version` smallint(6) DEFAULT '0' COMMENT '版本',
  `createAt` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updateAt` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `createBy` bigint(20) DEFAULT NULL COMMENT '创建者',
  `updateBy` bigint(20) DEFAULT NULL COMMENT '更新者',
  `price` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='基础表';

-- ----------------------------
-- Records of app_demo_base
-- ----------------------------
INSERT INTO `app_demo_base` VALUES ('1027118616500408321', 'Vue 2.0 Hello World', '2018-08-17 11:59:00', '这是我的征文', '\0', '7', '2018-08-08 17:05:35', '2018-08-22 15:34:46', '1', '1', null);

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `title` varchar(256) DEFAULT '' COMMENT '标题',
  `content` longtext COMMENT '内容',
  `editMode` varchar(32) DEFAULT 'html' COMMENT '编辑模式，默认为html，其他可选项包括html，markdown ..',
  `summary` text COMMENT '摘要',
  `linkTo` varchar(512) DEFAULT NULL COMMENT '连接到(常用于谋文章只是一个连接)',
  `thumbnail` varchar(128) DEFAULT NULL COMMENT '缩略图',
  `createUserName` varchar(255) DEFAULT NULL COMMENT '用户ID',
  `orderNumber` int(11) DEFAULT '0' COMMENT '排序编号',
  `status` int(11) DEFAULT '1' COMMENT '状态(0:已发布，1:审核中，2:未通过审核，3:已隐藏)',
  `commentStatus` tinyint(1) DEFAULT '1' COMMENT '评论状态，默认允许评论',
  `commentCount` int(11) unsigned DEFAULT '0' COMMENT '评论总数',
  `commentTime` datetime DEFAULT NULL COMMENT '最后评论时间',
  `viewCount` int(11) unsigned DEFAULT '0' COMMENT '访问量',
  `createTime` datetime DEFAULT NULL COMMENT '创建日期',
  `modifyTime` datetime DEFAULT NULL COMMENT '最后更新日期',
  `metaTitle` varchar(1000) DEFAULT NULL,
  `metaKeywords` varchar(1000) DEFAULT NULL COMMENT 'SEO关键字',
  `metaDescription` text COMMENT 'SEO描述信息',
  `remarks` text COMMENT '备注信息',
  `style` int(1) NOT NULL,
  `author` varchar(500) DEFAULT NULL COMMENT '作者',
  `fackbook` text,
  `linkedin` text,
  `twitter` text,
  `medium` text,
  `instagram` text,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_id` (`createUserName`) USING BTREE,
  KEY `created` (`createTime`) USING BTREE,
  KEY `view_count` (`viewCount`) USING BTREE,
  KEY `order_number` (`orderNumber`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='文章表';

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES ('10', '视觉中国开盘封死跌停 创始人身家瞬间缩水1.3亿', '<p>原标题：视觉中国开盘封死跌停 柴继军身价瞬间缩水1.3亿</p><p>　　4月12日早盘，视觉中国开盘无悬念跌停，封单近41万手，报25.20元/股，一夜间总市值从196亿元缩水至176.5亿元，市值蒸发19.6亿元。</p><p>　　早些时候，视觉中国发公告称，天津市互联网信息办公室依法约谈其网站负责人，责令公司网站全面彻底整改并在此期间暂时关闭网站。</p><p>　　4月11日，因“人类首张黑洞照片”版权标注问题，A股上市公司视觉中国陷入舆论风暴。网友和机构随即发现，国旗国徽也被视觉中国打了版权售卖。国徽图片页面“价格提示”显示，“用于内文不低于150元，整版跨页不低于500元，杂志封面不低于1000元，商业使用价格另议。”虽然连续发声明解释、道歉，但是网友并不买账，直至该公司关闭网站。</p><p>　　根据计划，视觉中国4月12日有3.88亿股限售股上市流通，占公司总股本比例的55.39%。此次解禁是五年前视觉中国借壳远东股份所定向增发的股份，当时定增发行价为5.28元/股，五年期间未实施过股份送转。</p>', 'html', '4月12日早盘，视觉中国开盘无悬念跌停，封单近41万手，报25.20元/股，一夜间总市值从196亿元缩水至176.5亿元，市值蒸发19.6亿元。', null, '', 'admin', '0', '0', '1', '0', null, '0', '2019-04-12 11:59:12', null, '你好', '我好', '大家好', null, '4', '北京青年报', '{\"order\":\"\",\"type\":\"Fackbook\",\"url\":\"http://www.baidu.com\"}', null, null, null, null);
INSERT INTO `article` VALUES ('11', '1231fsv etget', '<p>Balala...</p>', 'html', '123123', null, null, 'admin', '0', '0', '1', '0', null, '0', '2019-04-12 13:02:00', null, '', '', '', null, '4', '1231', null, null, null, null, null);
INSERT INTO `article` VALUES ('12', 'swfwsfasf', '<p style=\"text-align: center;\">Balala...acvasasfc</p>', 'html', 'dsvgffwef', null, null, 'admin', '0', '0', '1', '0', null, '0', '2019-04-12 13:07:35', null, '', '', '', null, '4', 'ad', '{\"order\":\"1\",\"type\":\"Fackbook\",\"url\":\"http://www.baidu.com\"}', '{\"order\":\"\",\"type\":\"Linkedin\",\"url\":\"http://www.baidu.com\"}', '{\"order\":\"\",\"type\":\"Twitter\",\"url\":\"http://www.baidu.com\"}', null, null);
INSERT INTO `article` VALUES ('13', '13', '<p>Balala...</p><p><br></p><p><img alt=\"Image\" src=\"https://n.sinaimg.cn/news/crawl/726/w550h976/20190412/OfKe-hvntnkq9510568.jpg\"><br></p><p>afafasfasdf</p><p><br></p><p>sdfsd</p><p>sdfsds</p>', 'html', '123', null, null, 'admin', '0', '0', '1', '0', null, '0', '2019-04-12 15:24:51', null, '', '', '', null, '4', '123', null, null, null, null, null);
INSERT INTO `article` VALUES ('14', '13', '<p>Balala...</p><p><br></p><p><img alt=\"Image\" src=\"https://n.sinaimg.cn/news/crawl/726/w550h976/20190412/OfKe-hvntnkq9510568.jpg\"><br></p><p>afafasfasdf</p><p><br></p><p>sdfsd</p><p>sdfsds</p>', 'html', '', null, null, 'admin', '0', '0', '1', '0', null, '0', '2019-04-12 15:25:49', null, '', '', '', null, '4', '123', null, null, null, null, null);
INSERT INTO `article` VALUES ('15', 'asfsaf', '<p>Balala...</p><p>svsvasv</p><p>svasvasvasv</p><p>svasvasv</p>', 'html', 'savasdv', null, null, 'admin', '0', '0', '1', '0', null, '0', '2019-04-12 15:26:45', null, '', '', '', null, '4', 'svasv', null, null, null, null, null);
INSERT INTO `article` VALUES ('16', '12313', '<p>Balala... 12123e123</p><p>131231312313</p><p>13123123</p>', 'html', '1313', null, null, 'admin', '0', '0', '1', '0', null, '0', '2019-04-12 15:28:22', null, '', '', '', null, '4', '13123', null, null, null, null, null);
INSERT INTO `article` VALUES ('17', 'Don T Let The Outtakes Take You Out Don T Let The Outtakes Take You ...', '<p style=\"text-align: center;\">Balala...</p><p style=\"text-align: center;\">sfasfasfoajhfoewnfpowufe hwjefnwoehfauwehfwo;efjowihfwjebnfwefhj</p><p style=\"text-align: center;\">wnefojwhnefowefjwbfeowehfwjebfwoefhewjfn</p>', 'html', 'Nullam quis risus eget urna mollis ornare vel eu leo. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Nullam quis risus eget urna mollis ornare vel eu leo. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis ……', null, '', 'admin', '0', '0', '1', '0', null, '0', '2019-04-12 15:56:57', null, '', '', '', null, '4', 'Vincent', '{\"order\":\"2\",\"type\":\"Fackbook\",\"url\":\"http://www.baidu.com\"}', '{\"order\":\"1\",\"type\":\"Linkedin\",\"url\":\"http://www.qq.com\"}', null, null, null);

-- ----------------------------
-- Table structure for article_tag
-- ----------------------------
DROP TABLE IF EXISTS `article_tag`;
CREATE TABLE `article_tag` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `articleId` bigint(20) NOT NULL,
  `tagId` bigint(20) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FKesqp7s9jj2wumlnhssbme5ule` (`tagId`) USING BTREE,
  KEY `FKenqeees0y8hkm7x1p1ittuuye` (`articleId`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of article_tag
-- ----------------------------
INSERT INTO `article_tag` VALUES ('4', '17', '4');
INSERT INTO `article_tag` VALUES ('5', '17', '3');
INSERT INTO `article_tag` VALUES ('6', '17', '5');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `onShelvesNum` int(11) DEFAULT NULL,
  `offShelvesNum` int(11) DEFAULT NULL,
  `updateTime` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('2', '水果', null, null, null);

-- ----------------------------
-- Table structure for event
-- ----------------------------
DROP TABLE IF EXISTS `event`;
CREATE TABLE `event` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `title` varchar(256) DEFAULT '' COMMENT '标题',
  `content` longtext COMMENT '内容',
  `linkTo` varchar(512) DEFAULT NULL COMMENT '连接到(常用于谋文章只是一个连接)',
  `thumbnail` varchar(128) DEFAULT NULL COMMENT '缩略图',
  `userId` int(11) unsigned DEFAULT NULL COMMENT '用户ID',
  `orderNumber` int(11) DEFAULT '0' COMMENT '排序编号',
  `status` varchar(32) DEFAULT NULL COMMENT '状态',
  `commentStatus` tinyint(1) DEFAULT '1' COMMENT '评论状态，默认允许评论',
  `commentCount` int(11) unsigned DEFAULT '0' COMMENT '评论总数',
  `commentTime` datetime DEFAULT NULL COMMENT '最后评论时间',
  `viewCount` int(11) unsigned DEFAULT '0' COMMENT '访问量',
  `createTime` datetime DEFAULT NULL COMMENT '创建日期',
  `modifyTime` datetime DEFAULT NULL COMMENT '最后更新日期',
  `startTime` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `endTime` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `price` varchar(255) DEFAULT NULL,
  `address` varchar(1000) DEFAULT NULL,
  `metaKeywords` varchar(512) DEFAULT NULL COMMENT 'SEO关键字',
  `metaDescription` varchar(512) DEFAULT NULL COMMENT 'SEO描述信息',
  `remarks` text COMMENT '备注信息',
  `type` int(1) NOT NULL COMMENT '类型',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_id` (`userId`) USING BTREE,
  KEY `created` (`createTime`) USING BTREE,
  KEY `view_count` (`viewCount`) USING BTREE,
  KEY `order_number` (`orderNumber`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='文章表';

-- ----------------------------
-- Records of event
-- ----------------------------
INSERT INTO `event` VALUES ('3', '123', '1231', 'www.baidu.com', '', null, '1', '', '1', '0', null, '0', null, null, '2019-04-10 18:13:11', '2019-04-10 18:13:13', '$123', '你家', '', '', '', '1');
INSERT INTO `event` VALUES ('4', '123', '1231', 'www.baidu.com', '', null, '1', '', '1', '0', null, '0', null, null, '2019-04-10 18:13:11', '2019-04-10 18:13:13', '$123', '你家', '', '', '', '1');
INSERT INTO `event` VALUES ('5', '123', '1231', 'www.baidu.com', '', null, '1', '', '1', '0', null, '0', null, null, '2019-04-10 18:13:11', '2019-04-10 18:13:13', '$123', '你家', '', '', '', '1');
INSERT INTO `event` VALUES ('6', '123', '1231', 'www.baidu.com', '', null, '1', '', '1', '0', null, '0', null, null, '2019-04-10 18:13:11', '2019-04-10 18:13:13', '$123', '你家', '', '', '', '1');
INSERT INTO `event` VALUES ('7', '123', '1231', 'www.baidu.com', '', null, '1', '', '1', '0', null, '0', null, null, '2019-04-10 18:13:11', '2019-04-10 18:13:13', '$123', '你家', '', '', '', '1');
INSERT INTO `event` VALUES ('8', '123', '1231', 'www.baidu.com', '', null, '1', '', '1', '0', null, '0', null, null, '2019-04-10 18:13:11', '2019-04-10 18:13:13', '$123', '你家', '', '', '', '1');
INSERT INTO `event` VALUES ('9', '123', '1231', 'www.baidu.com', '', null, '1', '', '1', '0', null, '0', null, null, '2019-04-10 18:13:11', '2019-04-10 18:13:13', '$123', '你家', '', '', '', '1');
INSERT INTO `event` VALUES ('10', '123', '1231', 'www.baidu.com', '', null, '1', '', '1', '0', null, '0', null, null, '2019-04-10 18:13:11', '2019-04-10 18:13:13', '$123', '你家', '', '', '', '1');
INSERT INTO `event` VALUES ('12', '123', '1231', 'www.baidu.com', '', null, '1', '', '1', '0', null, '0', null, null, '2019-04-10 18:13:11', '2019-04-10 18:13:13', '$123', '你家', '', '', '', '1');
INSERT INTO `event` VALUES ('13', '123', '1231', 'www.baidu.com', '', null, '1', '', '1', '0', null, '0', null, null, '2019-04-10 18:13:11', '2019-04-10 18:13:13', '$123', '你家', '', '', '', '3');
INSERT INTO `event` VALUES ('14', '123', '1231', 'http://www.baidu.com', 'http://localhost:8088/upload/20190414\\6\\6\\home-bg.jpg', null, '1', '', '1', '0', null, '0', null, null, '2019-04-10 18:13:11', '2019-04-10 18:13:13', '$123', '你家', '', '', '', '2');

-- ----------------------------
-- Table structure for nav
-- ----------------------------
DROP TABLE IF EXISTS `nav`;
CREATE TABLE `nav` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(255) NOT NULL COMMENT '导航名称',
  `background` varchar(2000) DEFAULT NULL COMMENT '背景图',
  `url` varchar(1000) DEFAULT NULL COMMENT '访问链接',
  `order` int(11) DEFAULT NULL COMMENT '排序',
  `type` int(11) DEFAULT NULL COMMENT '类型',
  `isShow` int(11) DEFAULT '1' COMMENT '是否显示',
  `updateTime` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `content` text,
  `metaTitle` varchar(1000) DEFAULT NULL COMMENT 'SEO标题',
  `metaKeywords` varchar(1000) DEFAULT NULL COMMENT 'SEO关键字',
  `metaDescription` text COMMENT 'SEO描述信息',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of nav
-- ----------------------------
INSERT INTO `nav` VALUES ('1', 'techtour', '', '/techtour', '1', '2', '0', '2019-04-18 10:31:31', '{\"title\":\"Tech Tour\",\"content\":\"Tours4Tech offers a range of study tours in Shenzhen that allow you to experience real-life business not only in the tech industry, but also manufacturing and market trade. Our tours provide a thoroughly educational experience for business school students, and give professors a unique teaching opportunity that can’t be found in books\",\"video\":\"\",\"model1title\":\"Enterprise\",\"model1content\":\"Learn from professionals who work for Chinese companies in a variety of industries, such as Tencent, DJI, PingAn, Huawei, Country Garden, Dentons Law Offices, and more. This eye-opening tour can help you determine what specific direction to take your education, while providing you with plenty of insight into what to expect, no matter what specific field you ultimately choose.\",\"model1video\":\"\",\"model2title\":\"Manufacturing\",\"model2content\":\"Learn from professionals who work for Chinese companies in a variety of industries, such as Tencent, DJI, PingAn, Huawei, Country Garden, Dentons Law Offices, and more. This eye-opening tour can help you determine what specific direction to take your education, while providing you with plenty of insight into what to expect, no matter what specific field you ultimately choose.\",\"model2video\":\"\",\"model3title\":\"Startups\",\"model3content\":\"Learn from professionals who work for Chinese companies in a variety of industries, such as Tencent, DJI, PingAn, Huawei, Country Garden, Dentons Law Offices, and more. This eye-opening tour can help you determine what specific direction to take your education, while providing you with plenty of insight into what to expect, no matter what specific field you ultimately choose.\",\"model3video\":\"\",\"model4title\":\"We often visit\"}', 'techtour', 'techtour', '');
INSERT INTO `nav` VALUES ('2', 'workshop', '', '/workshop', '2', '3', '1', '2019-04-18 16:23:40', '{\"title\":\"Workshops\",\"content\":\"Tours4Tech offers a range of study tours in Shenzhen that allow you to experience real-life business not only in the tech industry, but also manufacturing and market trade. Our tours provide a thoroughly educational experience for business school students, and give professors a unique teaching opportunity that can’t be found in books.\",\"video1\":\"http://s.amazeui.org/media/i/demos/bing-1.jpg\",\"video2\":\"http://s.amazeui.org/media/i/demos/bing-2.jpg\",\"video3\":\"http://s.amazeui.org/media/i/demos/bing-3.jpg\",\"model\":[{\"title\":\"How To Work In Tech In Shenzhen\",\"content\":\"Whether you are a returning Chinese student from overseas or an expat who wants to get a taste of the tech excitement, this workshop will prepare you for entering the tech industry in Shenzhen. We cover how to go about getting a job, where to apply, how to prepare a resume, how to improve your chances of getting hired, and how to give an unforgettable interview that is specific to the tech industry.\",\"image\":\"http://s.amazeui.org/media/i/demos/bing-4.jpg\",\"isShow\":\"on\"},{\"title\":\"How To Work In Tech In GuangZhou\",\"content\":\"Whether you are a returning Chinese student from overseas or an expat who wants to get a taste of the tech excitement, this workshop will prepare you for entering the tech industry in Shenzhen. We cover how to go about getting a job, where to apply, how to prepare a resume, how to improve your chances of getting hired, and how to give an unforgettable interview that is specific to the tech industry.\",\"image\":\"http://s.amazeui.org/media/i/demos/bing-4.jpg\",\"isShow\":\"on\"},{\"title\":\"\",\"content\":\"\",\"image\":\"\",\"isShow\":\"on\"},{\"title\":\"\",\"content\":\"\",\"image\":\"\",\"isShow\":\"on\"},{\"title\":\"\",\"content\":\"\",\"image\":\"\",\"isShow\":\"on\"}]}', 'workshop', 'workshop', '');
INSERT INTO `nav` VALUES ('3', 'service', '', '/service', '3', '4', '0', '2019-04-18 21:40:43', '{\"headtitle\":\"Service\",\"headcontent\":\"Your customized consultancy service will focus on your most critical issues and opportunities in China. Whether it’s business matching, partnership, supply chain management, marketing strategy, or other custom services, you will be helped by a team with a wealth of experience, meaningful connections, and enduring value. Since 2015, many of America’s and Japan’s largest organizations have already trusted this team to guide them through the challenging processes in China with practical support.\",\"model1title\":\"Ecosystem Partnership\",\"model1content\":\"Finding the right local partners can help you strengthen your business in China. Tours4tech consultancy service can help identify and connect you with the right partners, including those in supply chain partners that can help accelerate your manufacturing process and innovative IT solutions partners that can help increase your ability to accomplish your business goals. For us, a productive cooperation between our clients and partners matters.\",\"model1image\":\"\",\"model2title\":\"Tailored and Supportive Advice\",\"model2content\":\"Your consultancy service will start with tailored advice and practical support. This is ideal for private sector companies, regulated industries, government departments, or other public institutions. Tours4tech will analyze multiple strategies and work with you to identify the best for achieving your objectives. No matter what, your team will understand how to execute your projects in China to bring the greatest benefit to your company\",\"model2image\":\"\",\"model3title\":\"Step-by-Step Guide\",\"model3content\":\"You will always get actionable information and value out of Tour4Tech’s consulting services. Step by step, we can help you connect to the local mindset of business in China to achieve success. Most of our clients find our project based pricing to be ideal, as it enables them to always consult with us no matter what challenge arises. Now you can take advantage of the opportunities in China with confidence.\",\"model3image\":\"\"}', 'service', 'service', '');
INSERT INTO `nav` VALUES ('4', 'about', '', '/about', '4', '6', '1', '2019-04-18 17:35:20', '{\"tab1\":{\"title\":\"WHO\",\"content\":\"Founded by the best ，Not robots but humans\",\"model\":[{\"name\":\"Marc Gutierrez\",\"description\":\"Co-fouder and CEO\",\"order\":\"1\",\"content\":\"How to make effective business? Best software platform for running an internet business. We build the most powerful and flexible tools for internet commerce. Our company make high responce products.How to make effective business? Best software platform for running an internet business. We build the most powerful and flexible tools for internet commerce. Our company make high responce products.How to make effective business? Best software platform for running an internet business. We build the most powerful and flexible tools for internet commerce. \",\"social\":[{\"type\":\"Linkedin\",\"url\":\"http://www.qq.com\",\"order\":\"2\"},{\"type\":\"Fackbook\",\"url\":\"http://www.baidu.com\",\"order\":\"1\"}]}]},\"tab2\":{\"title\":\"WHAT\",\"content\":\"We inspire people to impact 。By giving them a closer look at the best companies\",\"model\":[{\"content\":\"Tours4Tech Was founded by - you know- amazing people that wanted to bring you a better insight of china. People with experience in the Tech industry and in the chinese market. Tours4Tech Was founded by - you know- amazing people that wanted to bring you a better insight of china. People with experience in the Tech industry and in the chinese market. Tours4Tech Was founded by - you know- amazing people that wanted to bring you a better insight of china. People with experience in the Tech industry and in the chinese marke\"},{\"content\":\"Tours4Tech Was founded by - you know- amazing people that wanted to bring you a better insight of china. People with experience in the Tech industry and in the chinese market. Tours4Tech Was founded by - you know- amazing people that wanted to bring you a better insight of china. People with experience in the Tech industry and in the chinese market. Tours4Tech Was founded by - you know- amazing people that wanted to bring you a better insight of china. People with experience in the Tech industry and in the chinese market.\"},{\"content\":\"Tours4Tech Was founded by - you know- amazing people that wanted to bring you a better insight of china. People with experience in the Tech industry and in the chinese market. Tours4Tech Was founded by - you know- amazing people that wanted to bring you a better insight of china. People with experience in the Tech industry and in the chinese market. Tours4Tech Was founded by - you know- amazing people that wanted to bring you a better insight of china. People with experience in the Tech industry and in the chinese market.\"},{\"content\":\"Tours4Tech Was founded by - you know- amazing people that wanted to bring you a better insight of china. People with experience in the Tech industry and in the chinese market. Tours4Tech Was founded by - you know- amazing people that wanted to bring you a better insight of china. People with experience in the Tech industry and in the chinese market. Tours4Tech Was founded by - you know- amazing people that wanted to bring you a better insight of china. People with experience in the Tech industry and in the chinese market. \"}]}}', 'about', 'about', '');

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT,
  `categoryId` int(11) DEFAULT NULL COMMENT '分类id',
  `name` varchar(1000) NOT NULL COMMENT '产品名称',
  `description` text COMMENT '产品简要描述',
  `detail` text COMMENT '产品详细描述',
  `price` varchar(50) NOT NULL COMMENT '价格',
  `sale` varchar(255) DEFAULT '' COMMENT '打折价',
  `url` varchar(2000) DEFAULT NULL COMMENT '跳转url',
  `order` int(11) DEFAULT NULL COMMENT '排序',
  `tags` varchar(1000) DEFAULT NULL COMMENT '标签',
  `status` int(1) DEFAULT '0' COMMENT '状态',
  `image1` varchar(2000) NOT NULL COMMENT '产品主图',
  `image2` varchar(2000) DEFAULT NULL COMMENT '产品主图',
  `image3` varchar(2000) DEFAULT NULL COMMENT '产品图片',
  `image4` varchar(2000) DEFAULT NULL COMMENT '产品图片',
  `image5` varchar(2000) DEFAULT NULL COMMENT '产品图片',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES ('1', null, 'qwrfwf', 'wefwef', 'wefwef', '$123', '$123', 'https://www.amazon.com/dp/B00T4BHYLY', '1', 'q1qe,qwe1', '0', 'http://localhost:8088/upload/20190414\\8\\f\\about-bg.jpg', 'http://localhost:8088/upload/20190414\\5\\0\\contact-bg.jpg', 'http://localhost:8088/upload/20190414\\6\\6\\home-bg.jpg', '', '');
INSERT INTO `product` VALUES ('3', null, '爱和福建傲', '色粉啊', '唔使娃娃儿', '$123', '$123', 'https://www.amazon.com/dp/B00C0KI8YS?psc=1', '1', '345ty,qwe1,123', '0', 'http://localhost:8088/upload/20190414\\8\\f\\post-sample-image.jpg', null, null, null, null);
INSERT INTO `product` VALUES ('4', null, 'qwrfwf', '', '', '$123', '$123', 'https://www.amazon.com/dp/B00T4BHYLY', '1', 'q1qe,qwe1', '0', 'http://localhost:8088/upload/20190414\\8\\f\\about-bg.jpg', 'http://localhost:8088/upload/20190414\\5\\0\\contact-bg.jpg', 'http://localhost:8088/upload/20190414\\6\\6\\home-bg.jpg', null, null);
INSERT INTO `product` VALUES ('5', null, '篮球', '打篮球', '篮球好好打', '$123', '$123', 'https://www.amazon.com/dp/B00T4BHYLY', '1', 'q1qe,qwe1', '0', 'http://localhost:8088/upload/20190414\\8\\f\\about-bg.jpg', 'http://localhost:8088/upload/20190414\\5\\0\\contact-bg.jpg', 'http://localhost:8088/upload/20190414\\6\\6\\home-bg.jpg', null, null);
INSERT INTO `product` VALUES ('6', null, '足球', '13123', '篮球好好打', '$123', '$123', 'https://www.amazon.com/dp/B00T4BHYLY', '1', 'q1qe,qwe1', '0', 'http://localhost:8088/upload/20190414\\8\\f\\about-bg.jpg', 'http://localhost:8088/upload/20190414\\5\\0\\contact-bg.jpg', 'http://localhost:8088/upload/20190414\\6\\6\\home-bg.jpg', null, null);

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `k` varchar(100) DEFAULT NULL COMMENT '键',
  `v` varchar(1000) DEFAULT NULL COMMENT '值',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `kvType` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES ('2', 'oss_qiniu', '{\"AccessKey\" : \"8-HMj9EgGNIP-xuOCpSzTn-OMyGOFtR3TxLdn4Uu\",\"SecretKey\" : \"SjpGg3V6PsMdJgn42PeEd5Ik-6aNyuwdqV5CPM6A\",\"bucket\" : \"ifast\",\"AccessUrl\" : \"http://p6r7ke2jc.bkt.clouddn.com/\"}', '七牛对象存储配置', '2018-04-06 14:31:26', '4300');
INSERT INTO `sys_config` VALUES ('3', 'author', 'Aron', '代码生成器配置', '2018-05-27 19:57:04', '4401');
INSERT INTO `sys_config` VALUES ('4', 'email', 'izenglong@163.com', '代码生成器配置', '2018-05-27 19:57:04', '4401');
INSERT INTO `sys_config` VALUES ('5', 'package', 'com.cms', '代码生成器配置', '2018-05-27 19:57:04', '4401');
INSERT INTO `sys_config` VALUES ('6', 'autoRemovePre', 'true', '代码生成器配置', '2018-05-27 19:57:04', '4401');
INSERT INTO `sys_config` VALUES ('7', 'tablePrefix', 'app', '代码生成器配置', '2018-05-27 19:57:04', '4401');
INSERT INTO `sys_config` VALUES ('8', 'tinyint', 'Integer', '代码生成器配置', '2018-05-27 19:57:04', '4400');
INSERT INTO `sys_config` VALUES ('9', 'smallint', 'Integer', '代码生成器配置', '2018-05-27 19:57:04', '4400');
INSERT INTO `sys_config` VALUES ('10', 'mediumint', 'Integer', '代码生成器配置', '2018-05-27 19:57:04', '4400');
INSERT INTO `sys_config` VALUES ('11', 'int', 'Integer', '代码生成器配置', '2018-05-27 19:57:04', '4400');
INSERT INTO `sys_config` VALUES ('12', 'integer', 'Integer', '代码生成器配置', '2018-05-27 19:57:04', '4400');
INSERT INTO `sys_config` VALUES ('13', 'bigint', 'Long', '代码生成器配置', '2018-05-27 19:57:04', '4400');
INSERT INTO `sys_config` VALUES ('14', 'float', 'Float', '代码生成器配置', '2018-05-27 19:57:04', '4400');
INSERT INTO `sys_config` VALUES ('15', 'double', 'Double', '代码生成器配置', '2018-05-27 19:57:04', '4400');
INSERT INTO `sys_config` VALUES ('16', 'decimal', 'BigDecimal', '代码生成器配置', '2018-05-27 19:57:04', '4400');
INSERT INTO `sys_config` VALUES ('17', 'bit', 'Boolean', '代码生成器配置', '2018-05-27 19:57:04', '4400');
INSERT INTO `sys_config` VALUES ('18', 'char', 'String', '代码生成器配置', '2018-05-27 19:57:04', '4400');
INSERT INTO `sys_config` VALUES ('19', 'varchar', 'String', '代码生成器配置', '2018-05-27 19:57:04', '4400');
INSERT INTO `sys_config` VALUES ('20', 'tinytext', 'String', '代码生成器配置', '2018-05-27 19:57:04', '4400');
INSERT INTO `sys_config` VALUES ('21', 'text', 'String', '代码生成器配置', '2018-05-27 19:57:04', '4400');
INSERT INTO `sys_config` VALUES ('22', 'mediumtext', 'String', '代码生成器配置', '2018-05-27 19:57:04', '4400');
INSERT INTO `sys_config` VALUES ('23', 'longtext', 'String', '代码生成器配置', '2018-05-27 19:57:04', '4400');
INSERT INTO `sys_config` VALUES ('24', 'date', 'Date', '代码生成器配置', '2018-05-27 19:57:04', '4400');
INSERT INTO `sys_config` VALUES ('25', 'datetime', 'Date', '代码生成器配置', '2018-05-27 19:57:04', '4400');
INSERT INTO `sys_config` VALUES ('26', 'timestamp', 'Date', '代码生成器配置', '2018-05-27 19:57:04', '4400');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parentId` bigint(20) DEFAULT NULL COMMENT '上级部门ID，一级部门为0',
  `name` varchar(50) DEFAULT NULL COMMENT '部门名称',
  `orderNum` int(11) DEFAULT NULL COMMENT '排序',
  `delFlag` tinyint(4) DEFAULT '0' COMMENT '是否删除  -1：已删除  0：正常',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='部门管理';

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES ('6', '0', '研发部', '1', '1');
INSERT INTO `sys_dept` VALUES ('7', '6', '研发一部', '1', '1');
INSERT INTO `sys_dept` VALUES ('8', '6', '研发二部', '2', '1');
INSERT INTO `sys_dept` VALUES ('9', '0', '销售部', '2', '1');
INSERT INTO `sys_dept` VALUES ('11', '0', '产品部', '3', '1');
INSERT INTO `sys_dept` VALUES ('12', '11', '产品一部', '1', '1');
INSERT INTO `sys_dept` VALUES ('13', '0', '测试部', '5', '1');
INSERT INTO `sys_dept` VALUES ('14', '13', '测试一部', '1', '1');
INSERT INTO `sys_dept` VALUES ('15', '13', '测试二部', '2', '1');
INSERT INTO `sys_dept` VALUES ('16', '9', '销售一部', '0', '1');

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict` (
  `id` bigint(64) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '标签名',
  `value` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '数据值',
  `type` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '类型',
  `description` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `sort` decimal(10,0) DEFAULT NULL COMMENT '排序（升序）',
  `parentId` bigint(64) DEFAULT '0' COMMENT '父级编号',
  `createBy` int(64) DEFAULT NULL COMMENT '创建者',
  `createDate` datetime DEFAULT NULL COMMENT '创建时间',
  `updateBy` bigint(64) DEFAULT NULL COMMENT '更新者',
  `updateDate` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `delFlag` char(1) COLLATE utf8_bin DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `sys_dict_value` (`value`) USING BTREE,
  KEY `sys_dict_label` (`name`) USING BTREE,
  KEY `sys_dict_del_flag` (`delFlag`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='字典表';

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES ('1', '正常', '0', 'del_flag', '删除标记', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('3', '显示', '1', 'show_hide', '显示/隐藏', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('4', '隐藏', '0', 'show_hide', '显示/隐藏', '20', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('5', '是', '1', 'yes_no', '是/否', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('6', '否', '0', 'yes_no', '是/否', '20', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('7', '红色', 'red', 'color', '颜色值', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('8', '绿色', 'green', 'color', '颜色值', '20', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('9', '蓝色', 'blue', 'color', '颜色值', '30', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('10', '黄色', 'yellow', 'color', '颜色值', '40', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('11', '橙色', 'orange', 'color', '颜色值', '50', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('12', '默认主题', 'default', 'theme', '主题方案', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('13', '天蓝主题', 'cerulean', 'theme', '主题方案', '20', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('14', '橙色主题', 'readable', 'theme', '主题方案', '30', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('15', '红色主题', 'united', 'theme', '主题方案', '40', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('16', 'Flat主题', 'flat', 'theme', '主题方案', '60', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('17', '国家', '1', 'sys_area_type', '区域类型', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('18', '省份、直辖市', '2', 'sys_area_type', '区域类型', '20', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('19', '地市', '3', 'sys_area_type', '区域类型', '30', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('20', '区县', '4', 'sys_area_type', '区域类型', '40', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('21', '公司', '1', 'sys_office_type', '机构类型', '60', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('22', '部门', '2', 'sys_office_type', '机构类型', '70', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('23', '小组', '3', 'sys_office_type', '机构类型', '80', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('24', '其它', '4', 'sys_office_type', '机构类型', '90', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('25', '综合部', '1', 'sys_office_common', '快捷通用部门', '30', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('26', '开发部', '2', 'sys_office_common', '快捷通用部门', '40', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('27', '人力部', '3', 'sys_office_common', '快捷通用部门', '50', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('28', '一级', '1', 'sys_office_grade', '机构等级', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('29', '二级', '2', 'sys_office_grade', '机构等级', '20', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('30', '三级', '3', 'sys_office_grade', '机构等级', '30', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('31', '四级', '4', 'sys_office_grade', '机构等级', '40', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('32', '所有数据', '1', 'sys_data_scope', '数据范围', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('33', '所在公司及以下数据', '2', 'sys_data_scope', '数据范围', '20', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('34', '所在公司数据', '3', 'sys_data_scope', '数据范围', '30', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('35', '所在部门及以下数据', '4', 'sys_data_scope', '数据范围', '40', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('36', '所在部门数据', '5', 'sys_data_scope', '数据范围', '50', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('37', '仅本人数据', '8', 'sys_data_scope', '数据范围', '90', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('38', '按明细设置', '9', 'sys_data_scope', '数据范围', '100', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('39', '系统管理', '1', 'sys_user_type', '用户类型', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('40', '部门经理', '2', 'sys_user_type', '用户类型', '20', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('41', '普通用户', '3', 'sys_user_type', '用户类型', '30', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('42', '基础主题', 'basic', 'cms_theme', '站点主题', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('43', '蓝色主题', 'blue', 'cms_theme', '站点主题', '20', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict` VALUES ('44', '红色主题', 'red', 'cms_theme', '站点主题', '30', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict` VALUES ('45', '文章模型', 'article', 'cms_module', '栏目模型', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('46', '图片模型', 'picture', 'cms_module', '栏目模型', '20', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict` VALUES ('47', '下载模型', 'download', 'cms_module', '栏目模型', '30', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict` VALUES ('48', '链接模型', 'link', 'cms_module', '栏目模型', '40', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('49', '专题模型', 'special', 'cms_module', '栏目模型', '50', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict` VALUES ('50', '默认展现方式', '0', 'cms_show_modes', '展现方式', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('51', '首栏目内容列表', '1', 'cms_show_modes', '展现方式', '20', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('52', '栏目第一条内容', '2', 'cms_show_modes', '展现方式', '30', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('53', '发布', '0', 'cms_del_flag', '内容状态', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('54', '删除', '1', 'cms_del_flag', '内容状态', '20', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('55', '审核', '2', 'cms_del_flag', '内容状态', '15', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('56', '首页焦点图', '1', 'cms_posid', '推荐位', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('57', '栏目页文章推荐', '2', 'cms_posid', '推荐位', '20', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('58', '咨询', '1', 'cms_guestbook', '留言板分类', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('59', '建议', '2', 'cms_guestbook', '留言板分类', '20', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('60', '投诉', '3', 'cms_guestbook', '留言板分类', '30', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('61', '其它', '4', 'cms_guestbook', '留言板分类', '40', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('62', '公休', '1', 'oa_leave_type', '请假类型', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('63', '病假', '2', 'oa_leave_type', '请假类型', '20', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('64', '事假', '3', 'oa_leave_type', '请假类型', '30', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('65', '调休', '4', 'oa_leave_type', '请假类型', '40', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('66', '婚假', '5', 'oa_leave_type', '请假类型', '60', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('67', '接入日志', '1', 'sys_log_type', '日志类型', '30', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('68', '异常日志', '2', 'sys_log_type', '日志类型', '40', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('69', '请假流程', 'leave', 'act_type', '流程类型', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('70', '审批测试流程', 'test_audit', 'act_type', '流程类型', '20', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('71', '分类1', '1', 'act_category', '流程分类', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('72', '分类2', '2', 'act_category', '流程分类', '20', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('73', '增删改查', 'crud', 'gen_category', '代码生成分类', '10', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict` VALUES ('74', '增删改查（包含从表）', 'crud_many', 'gen_category', '代码生成分类', '20', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict` VALUES ('75', '树结构', 'tree', 'gen_category', '代码生成分类', '30', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict` VALUES ('76', '=', '=', 'gen_query_type', '查询方式', '10', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict` VALUES ('77', '!=', '!=', 'gen_query_type', '查询方式', '20', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict` VALUES ('78', '&gt;', '&gt;', 'gen_query_type', '查询方式', '30', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict` VALUES ('79', '&lt;', '&lt;', 'gen_query_type', '查询方式', '40', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict` VALUES ('80', 'Between', 'between', 'gen_query_type', '查询方式', '50', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict` VALUES ('81', 'Like', 'like', 'gen_query_type', '查询方式', '60', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict` VALUES ('82', 'Left Like', 'left_like', 'gen_query_type', '查询方式', '70', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict` VALUES ('83', 'Right Like', 'right_like', 'gen_query_type', '查询方式', '80', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict` VALUES ('84', '文本框', 'input', 'gen_show_type', '字段生成方案', '10', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict` VALUES ('85', '文本域', 'textarea', 'gen_show_type', '字段生成方案', '20', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict` VALUES ('86', '下拉框', 'select', 'gen_show_type', '字段生成方案', '30', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict` VALUES ('87', '复选框', 'checkbox', 'gen_show_type', '字段生成方案', '40', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict` VALUES ('88', '单选框', 'radiobox', 'gen_show_type', '字段生成方案', '50', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict` VALUES ('89', '日期选择', 'dateselect', 'gen_show_type', '字段生成方案', '60', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict` VALUES ('90', '人员选择', 'userselect', 'gen_show_type', '字段生成方案', '70', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict` VALUES ('91', '部门选择', 'officeselect', 'gen_show_type', '字段生成方案', '80', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict` VALUES ('92', '区域选择', 'areaselect', 'gen_show_type', '字段生成方案', '90', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict` VALUES ('93', 'String', 'String', 'gen_java_type', 'Java类型', '10', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict` VALUES ('94', 'Long', 'Long', 'gen_java_type', 'Java类型', '20', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict` VALUES ('95', '仅持久层', 'dao', 'gen_category', '代码生成分类\0\0', '40', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict` VALUES ('96', '男', '1', 'sex', '性别', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('97', '女', '2', 'sex', '性别', '20', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('98', 'Integer', 'Integer', 'gen_java_type', 'Java类型', '30', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict` VALUES ('99', 'Double', 'Double', 'gen_java_type', 'Java类型', '40', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict` VALUES ('100', 'Date', 'java.util.Date', 'gen_java_type', 'Java类型', '50', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict` VALUES ('104', 'Custom', 'Custom', 'gen_java_type', 'Java类型', '90', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict` VALUES ('105', '会议通告', '1', 'oa_notify_type', '通知通告类型', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('106', '奖惩通告', '2', 'oa_notify_type', '通知通告类型', '20', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('107', '活动通告', '3', 'oa_notify_type', '通知通告类型', '30', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('108', '草稿', '0', 'oa_notify_status', '通知通告状态', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('109', '发布', '1', 'oa_notify_status', '通知通告状态', '20', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('110', '未读', '0', 'oa_notify_read', '通知通告状态', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('111', '已读', '1', 'oa_notify_read', '通知通告状态', '20', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict` VALUES ('112', '草稿', '0', 'oa_notify_status', '通知通告状态', '10', '0', '1', null, '1', null, '', '0');
INSERT INTO `sys_dict` VALUES ('113', '删除', '0', 'del_flag', '删除标记', null, null, null, null, null, null, '', '');
INSERT INTO `sys_dict` VALUES ('118', '关于', 'about', 'blog_type', '博客类型', null, null, null, null, null, null, '全url是:/blog/open/page/about', '');
INSERT INTO `sys_dict` VALUES ('119', '交流', 'communication', 'blog_type', '博客类型', null, null, null, null, null, null, '', '');
INSERT INTO `sys_dict` VALUES ('120', '文章', 'article', 'blog_type', '博客类型', null, null, null, null, null, null, '', '');

-- ----------------------------
-- Table structure for sys_file
-- ----------------------------
DROP TABLE IF EXISTS `sys_file`;
CREATE TABLE `sys_file` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` int(11) DEFAULT NULL COMMENT '文件类型',
  `url` varchar(200) DEFAULT NULL COMMENT 'URL地址',
  `createDate` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1118453357372059650 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='文件上传';

-- ----------------------------
-- Records of sys_file
-- ----------------------------
INSERT INTO `sys_file` VALUES ('1117128742548828161', '0', 'http://localhost:8088/upload/20190414\\6\\6\\home-bg.jpg', '2019-04-14 02:13:42');
INSERT INTO `sys_file` VALUES ('1117129033700634625', '0', 'http://localhost:8088/upload/20190414\\8\\f\\about-bg.jpg', '2019-04-14 02:14:52');
INSERT INTO `sys_file` VALUES ('1117129131557941249', '0', 'http://localhost:8088/upload/20190414\\5\\0\\contact-bg.jpg', '2019-04-14 02:15:15');
INSERT INTO `sys_file` VALUES ('1117130330357133313', '0', 'http://localhost:8088/upload/20190414\\6\\6\\home-bg.jpg', '2019-04-14 02:20:01');
INSERT INTO `sys_file` VALUES ('1117131595422183425', '0', 'http://localhost:8088/upload/20190414\\6\\6\\home-bg.jpg', '2019-04-14 02:25:02');
INSERT INTO `sys_file` VALUES ('1117132465668960258', '0', 'http://localhost:8088/upload/20190414\\5\\0\\contact-bg.jpg', '2019-04-14 02:28:30');
INSERT INTO `sys_file` VALUES ('1117133697565405185', '0', 'http://localhost:8088/upload/20190414\\8\\f\\post-sample-image.jpg', '2019-04-14 02:33:23');
INSERT INTO `sys_file` VALUES ('1117134033600458754', '0', 'http://localhost:8088/upload/20190414\\6\\6\\home-bg.jpg', '2019-04-14 02:34:44');
INSERT INTO `sys_file` VALUES ('1117134174751371266', '0', 'http://localhost:8088/upload/20190414\\6\\6\\home-bg.jpg', '2019-04-14 02:35:17');
INSERT INTO `sys_file` VALUES ('1117134248629841921', '0', 'http://localhost:8088/upload/20190414\\5\\8\\post-bg.jpg', '2019-04-14 02:35:35');
INSERT INTO `sys_file` VALUES ('1117134404288851969', '0', 'http://localhost:8088/upload/20190414\\8\\f\\about-bg.jpg', '2019-04-14 02:36:12');
INSERT INTO `sys_file` VALUES ('1117136339159035906', '0', 'http://localhost:8088/upload/20190414\\8\\f\\post-sample-image.jpg', '2019-04-14 02:43:53');
INSERT INTO `sys_file` VALUES ('1117136520587849730', '0', 'http://localhost:8088/upload/20190414\\5\\8\\post-bg.jpg', '2019-04-14 02:44:37');
INSERT INTO `sys_file` VALUES ('1117138606364897281', '0', 'http://localhost:8088/upload/20190414\\6\\6\\home-bg.jpg', '2019-04-14 02:52:54');
INSERT INTO `sys_file` VALUES ('1117323205762125826', '0', 'http://localhost:8088/upload/20190414\\8\\f\\about-bg.jpg', '2019-04-14 15:06:26');
INSERT INTO `sys_file` VALUES ('1117323205762125827', '0', 'http://localhost:8088/upload/20190414\\5\\0\\contact-bg.jpg', '2019-04-14 15:06:26');
INSERT INTO `sys_file` VALUES ('1117327660335276034', '0', 'http://localhost:8088/upload/20190414\\8\\f\\about-bg.jpg', '2019-04-14 15:24:08');
INSERT INTO `sys_file` VALUES ('1117327660561768450', '0', 'http://localhost:8088/upload/20190414\\5\\0\\contact-bg.jpg', '2019-04-14 15:24:08');
INSERT INTO `sys_file` VALUES ('1117327660758900737', '0', 'http://localhost:8088/upload/20190414\\6\\6\\home-bg.jpg', '2019-04-14 15:24:08');
INSERT INTO `sys_file` VALUES ('1117327661249634306', '0', 'http://localhost:8088/upload/20190414\\5\\8\\post-bg.jpg', '2019-04-14 15:24:08');
INSERT INTO `sys_file` VALUES ('1117327661560012802', '0', 'http://localhost:8088/upload/20190414\\8\\f\\post-sample-image.jpg', '2019-04-14 15:24:08');
INSERT INTO `sys_file` VALUES ('1117331535511461889', '0', 'http://localhost:8088/upload/20190414\\8\\f\\about-bg.jpg', '2019-04-14 15:39:32');
INSERT INTO `sys_file` VALUES ('1117331535796674562', '0', 'http://localhost:8088/upload/20190414\\5\\0\\contact-bg.jpg', '2019-04-14 15:39:32');
INSERT INTO `sys_file` VALUES ('1117331536157384705', '0', 'http://localhost:8088/upload/20190414\\6\\6\\home-bg.jpg', '2019-04-14 15:39:32');
INSERT INTO `sys_file` VALUES ('1117331536467763202', '0', 'http://localhost:8088/upload/20190414\\5\\8\\post-bg.jpg', '2019-04-14 15:39:32');
INSERT INTO `sys_file` VALUES ('1117331536815890433', '0', 'http://localhost:8088/upload/20190414\\8\\f\\post-sample-image.jpg', '2019-04-14 15:39:32');
INSERT INTO `sys_file` VALUES ('1117331684660912130', '0', 'http://localhost:8088/upload/20190414\\8\\f\\about-bg.jpg', '2019-04-14 15:40:07');
INSERT INTO `sys_file` VALUES ('1117331684904181761', '0', 'http://localhost:8088/upload/20190414\\5\\0\\contact-bg.jpg', '2019-04-14 15:40:07');
INSERT INTO `sys_file` VALUES ('1117331685227143170', '0', 'http://localhost:8088/upload/20190414\\6\\6\\home-bg.jpg', '2019-04-14 15:40:07');
INSERT INTO `sys_file` VALUES ('1117333748136845313', '0', 'http://localhost:8088/upload/20190414\\8\\f\\about-bg.jpg', '2019-04-14 15:48:19');
INSERT INTO `sys_file` VALUES ('1117338359551754242', '0', 'http://localhost:8088/upload/20190414\\8\\f\\about-bg.jpg', '2019-04-14 16:06:39');
INSERT INTO `sys_file` VALUES ('1117339637010923522', '0', 'http://localhost:8088/upload/20190414\\8\\f\\about-bg.jpg', '2019-04-14 16:11:43');
INSERT INTO `sys_file` VALUES ('1117340721133649921', '0', 'http://localhost:8088/upload/20190414\\8\\f\\about-bg.jpg', '2019-04-14 16:16:02');
INSERT INTO `sys_file` VALUES ('1117340766667014146', '0', 'http://localhost:8088/upload/20190414\\8\\f\\about-bg.jpg', '2019-04-14 16:16:13');
INSERT INTO `sys_file` VALUES ('1117341499453865986', '0', 'http://localhost:8088/upload/20190414\\8\\f\\about-bg.jpg', '2019-04-14 16:19:07');
INSERT INTO `sys_file` VALUES ('1117341525743763457', '0', 'http://localhost:8088/upload/20190414\\5\\0\\contact-bg.jpg', '2019-04-14 16:19:14');
INSERT INTO `sys_file` VALUES ('1117341526037364737', '0', 'http://localhost:8088/upload/20190414\\6\\6\\home-bg.jpg', '2019-04-14 16:19:14');
INSERT INTO `sys_file` VALUES ('1117341526242885634', '0', 'http://localhost:8088/upload/20190414\\5\\8\\post-bg.jpg', '2019-04-14 16:19:14');
INSERT INTO `sys_file` VALUES ('1117341526326771713', '0', 'http://localhost:8088/upload/20190414\\8\\f\\post-sample-image.jpg', '2019-04-14 16:19:14');
INSERT INTO `sys_file` VALUES ('1117341608547713025', '0', 'http://localhost:8088/upload/20190414\\6\\6\\home-bg.jpg', '2019-04-14 16:19:33');
INSERT INTO `sys_file` VALUES ('1117341608665153537', '0', 'http://localhost:8088/upload/20190414\\8\\f\\post-sample-image.jpg', '2019-04-14 16:19:33');
INSERT INTO `sys_file` VALUES ('1117341608950366210', '0', 'http://localhost:8088/upload/20190414\\5\\0\\contact-bg.jpg', '2019-04-14 16:19:33');
INSERT INTO `sys_file` VALUES ('1117342805501411330', '0', 'http://localhost:8088/upload/20190414\\8\\f\\about-bg.jpg', '2019-04-14 16:24:19');
INSERT INTO `sys_file` VALUES ('1117342805874704386', '0', 'http://localhost:8088/upload/20190414\\5\\0\\contact-bg.jpg', '2019-04-14 16:24:19');
INSERT INTO `sys_file` VALUES ('1117342806281551874', '0', 'http://localhost:8088/upload/20190414\\6\\6\\home-bg.jpg', '2019-04-14 16:24:19');
INSERT INTO `sys_file` VALUES ('1117348932553277441', '0', 'http://localhost:8088/upload/20190414\\8\\f\\about-bg.jpg', '2019-04-14 16:48:40');
INSERT INTO `sys_file` VALUES ('1117348932792352770', '0', 'http://localhost:8088/upload/20190414\\5\\0\\contact-bg.jpg', '2019-04-14 16:48:40');
INSERT INTO `sys_file` VALUES ('1117351912220405762', '0', 'http://localhost:8088/upload/20190414\\8\\f\\about-bg.jpg', '2019-04-14 17:00:30');
INSERT INTO `sys_file` VALUES ('1117351912564338689', '0', 'http://localhost:8088/upload/20190414\\5\\0\\contact-bg.jpg', '2019-04-14 17:00:30');
INSERT INTO `sys_file` VALUES ('1117351912748888065', '0', 'http://localhost:8088/upload/20190414\\6\\6\\home-bg.jpg', '2019-04-14 17:00:30');
INSERT INTO `sys_file` VALUES ('1117353586871787521', '0', 'http://localhost:8088/upload/20190414\\5\\8\\post-bg.jpg', '2019-04-14 17:07:09');
INSERT INTO `sys_file` VALUES ('1117354582574391297', '0', 'http://localhost:8088/upload/20190414\\8\\f\\post-sample-image.jpg', '2019-04-14 17:11:07');
INSERT INTO `sys_file` VALUES ('1118055010236637186', '0', 'http://localhost:8088/upload/20190416/2/b/u5898.png', '2019-04-16 15:34:22');
INSERT INTO `sys_file` VALUES ('1118066220105469954', '0', 'http://localhost:8088/upload/20190416/2/b/u5898.png', '2019-04-16 16:18:54');
INSERT INTO `sys_file` VALUES ('1118066523190071297', '0', 'http://localhost:8088/upload/20190416/2/b/u5898.png', '2019-04-16 16:20:06');
INSERT INTO `sys_file` VALUES ('1118066575916666881', '0', 'http://localhost:8088/upload/20190416/5/9/u5967.png', '2019-04-16 16:20:19');
INSERT INTO `sys_file` VALUES ('1118066757571973122', '0', 'http://localhost:8088/upload/20190416/2/b/u5898.png', '2019-04-16 16:21:02');
INSERT INTO `sys_file` VALUES ('1118066769936781314', '0', 'http://localhost:8088/upload/20190416/5/9/u5967.png', '2019-04-16 16:21:05');
INSERT INTO `sys_file` VALUES ('1118066843462930433', '0', 'http://localhost:8088/upload/20190416/2/b/u5898.png', '2019-04-16 16:21:23');
INSERT INTO `sys_file` VALUES ('1118371646881689602', '0', 'http://localhost:8088/upload/20190417/2/b/u5898.png', '2019-04-17 12:32:34');
INSERT INTO `sys_file` VALUES ('1118452952261013506', '0', 'http://localhost:8088/upload/20190417/5/9/u5967.png', '2019-04-17 17:55:38');
INSERT INTO `sys_file` VALUES ('1118453199007723522', '0', 'http://localhost:8088/upload/20190417/2/b/u5898.png', '2019-04-17 17:56:37');
INSERT INTO `sys_file` VALUES ('1118453357372059649', '0', 'http://localhost:8088/upload/20190417/7/a/261_expand_12rollover1.png', '2019-04-17 17:57:15');

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) DEFAULT NULL COMMENT '用户id',
  `username` varchar(50) DEFAULT NULL COMMENT '用户名',
  `operation` varchar(50) DEFAULT NULL COMMENT '用户操作',
  `time` int(11) DEFAULT NULL COMMENT '响应时间',
  `method` varchar(200) DEFAULT NULL COMMENT '请求方法',
  `params` varchar(5000) DEFAULT NULL COMMENT '请求参数',
  `ip` varchar(64) DEFAULT NULL COMMENT 'IP地址',
  `gmtCreate` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1118908854827085826 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='系统日志';

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES ('1115161117115674626', '1', 'admin', '登录', '51', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-08 15:55:04');
INSERT INTO `sys_log` VALUES ('1115168362725502978', '1', 'admin', '登录', '6', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-08 16:23:51');
INSERT INTO `sys_log` VALUES ('1115169809181450242', '1', 'admin', '登录', '48', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-08 16:29:36');
INSERT INTO `sys_log` VALUES ('1115172390666547201', '1', 'admin', '登录', '56', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-08 16:39:51');
INSERT INTO `sys_log` VALUES ('1115174549009219586', '1', 'admin', '登录', '50', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-08 16:48:26');
INSERT INTO `sys_log` VALUES ('1115175280672096257', '1', 'admin', '登录', '46', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-08 16:51:21');
INSERT INTO `sys_log` VALUES ('1115176123278331906', '1', 'admin', '登录', '46', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-08 16:54:41');
INSERT INTO `sys_log` VALUES ('1115177907187126273', '1', 'admin', '登录', '7', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-08 17:01:47');
INSERT INTO `sys_log` VALUES ('1115179024721678337', '1', 'admin', '保存菜单', '85', 'POST /sys/menu/save', '{\"parentId\":[\"0\"],\"type\":[\"0\"],\"name\":[\"内容模块\"],\"url\":[\"\"],\"perms\":[\"\"],\"orderNum\":[\"1\"],\"icon\":[\"fa fa-pencil-square-o\"]}', '127.0.0.1', '2019-04-08 17:06:13');
INSERT INTO `sys_log` VALUES ('1115179976774160385', '1', 'admin', '更新菜单', '110', 'POST /sys/menu/update', '{\"parentId\":[\"0\"],\"id\":[\"1115179024377745410\"],\"type\":[\"0\"],\"name\":[\"内容模块\"],\"url\":[\"\"],\"perms\":[\"\"],\"orderNum\":[\"0\"],\"icon\":[\"fa fa-pencil-square-o\"]}', '127.0.0.1', '2019-04-08 17:10:00');
INSERT INTO `sys_log` VALUES ('1115180109158977538', '1', 'admin', '保存菜单', '75', 'POST /sys/menu/save', '{\"parentId\":[\"1115179024377745410\"],\"type\":[\"1\"],\"name\":[\"文章内容管理\"],\"url\":[\"\"],\"perms\":[\"\"],\"orderNum\":[\"\"],\"icon\":[\"\"]}', '127.0.0.1', '2019-04-08 17:10:32');
INSERT INTO `sys_log` VALUES ('1115180279368028161', '1', 'admin', '保存菜单', '57', 'POST /sys/menu/save', '{\"parentId\":[\"1115179024377745410\"],\"type\":[\"1\"],\"name\":[\"活动内容管理\"],\"url\":[\"\"],\"perms\":[\"\"],\"orderNum\":[\"\"],\"icon\":[\"\"]}', '127.0.0.1', '2019-04-08 17:11:12');
INSERT INTO `sys_log` VALUES ('1115180862476947458', '1', 'admin', '登录', '4', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-08 17:13:31');
INSERT INTO `sys_log` VALUES ('1115181502443851778', '1', 'admin', '更新角色', '246', 'POST /sys/role/update', '{\"id\":[\"1\"],\"menuIds\":[\"193,194,195,196,197,79,80,81,83,176,177,178,179,180,207,208,209,210,211,20,21,22,61,12,13,14,24,25,26,15,55,56,62,74,75,76,48,72,28,29,30,57,92,71,78,175,206,1,2,6,7,73,3,77,27,91,1115179024377745410,1115180108840210434,1115180279120564226,-1\"],\"roleName\":[\"超级用户角色\"],\"remark\":[\"超级管理员\"]}', '127.0.0.1', '2019-04-08 17:16:04');
INSERT INTO `sys_log` VALUES ('1115182776765681665', '1', 'admin', '保存菜单', '80', 'POST /sys/menu/save', '{\"parentId\":[\"0\"],\"type\":[\"0\"],\"name\":[\"商品模块\"],\"url\":[\"\"],\"perms\":[\"\"],\"orderNum\":[\"1\"],\"icon\":[\"\"]}', '127.0.0.1', '2019-04-08 17:21:08');
INSERT INTO `sys_log` VALUES ('1115182861515788290', '1', 'admin', '保存菜单', '28', 'POST /sys/menu/save', '{\"parentId\":[\"1115182776430137345\"],\"type\":[\"1\"],\"name\":[\"商品类别管理\"],\"url\":[\"\"],\"perms\":[\"\"],\"orderNum\":[\"\"],\"icon\":[\"\"]}', '127.0.0.1', '2019-04-08 17:21:28');
INSERT INTO `sys_log` VALUES ('1115182933435518977', '1', 'admin', '保存菜单', '75', 'POST /sys/menu/save', '{\"parentId\":[\"1115182776430137345\"],\"type\":[\"1\"],\"name\":[\"商品管理\"],\"url\":[\"\"],\"perms\":[\"\"],\"orderNum\":[\"\"],\"icon\":[\"\"]}', '127.0.0.1', '2019-04-08 17:21:45');
INSERT INTO `sys_log` VALUES ('1115183012531703809', '1', 'admin', '保存菜单', '87', 'POST /sys/menu/save', '{\"parentId\":[\"0\"],\"type\":[\"0\"],\"name\":[\"运营管理\"],\"url\":[\"\"],\"perms\":[\"\"],\"orderNum\":[\"\"],\"icon\":[\"\"]}', '127.0.0.1', '2019-04-08 17:22:04');
INSERT INTO `sys_log` VALUES ('1115183035910754305', '1', 'admin', '更新菜单', '32', 'POST /sys/menu/update', '{\"parentId\":[\"0\"],\"id\":[\"1115183012166799361\"],\"type\":[\"0\"],\"name\":[\"运营管理\"],\"url\":[\"\"],\"perms\":[\"\"],\"orderNum\":[\"\"],\"icon\":[\"\"]}', '127.0.0.1', '2019-04-08 17:22:10');
INSERT INTO `sys_log` VALUES ('1115183127480799233', '1', 'admin', '保存菜单', '78', 'POST /sys/menu/save', '{\"parentId\":[\"0\"],\"type\":[\"0\"],\"name\":[\"个人设置\"],\"url\":[\"\"],\"perms\":[\"\"],\"orderNum\":[\"\"],\"icon\":[\"\"]}', '127.0.0.1', '2019-04-08 17:22:31');
INSERT INTO `sys_log` VALUES ('1115183213937987585', '1', 'admin', '保存菜单', '53', 'POST /sys/menu/save', '{\"parentId\":[\"1115183127149449218\"],\"type\":[\"1\"],\"name\":[\"个人资料\"],\"url\":[\"\"],\"perms\":[\"\"],\"orderNum\":[\"\"],\"icon\":[\"\"]}', '127.0.0.1', '2019-04-08 17:22:52');
INSERT INTO `sys_log` VALUES ('1115183247882489857', '1', 'admin', '保存菜单', '90', 'POST /sys/menu/save', '{\"parentId\":[\"1115183127149449218\"],\"type\":[\"1\"],\"name\":[\"我的通知\"],\"url\":[\"\"],\"perms\":[\"\"],\"orderNum\":[\"\"],\"icon\":[\"\"]}', '127.0.0.1', '2019-04-08 17:23:00');
INSERT INTO `sys_log` VALUES ('1115183358821830658', '1', 'admin', '保存菜单', '63', 'POST /sys/menu/save', '{\"parentId\":[\"1115183012166799361\"],\"type\":[\"1\"],\"name\":[\"导航管理\"],\"url\":[\"\"],\"perms\":[\"\"],\"orderNum\":[\"\"],\"icon\":[\"\"]}', '127.0.0.1', '2019-04-08 17:23:27');
INSERT INTO `sys_log` VALUES ('1115183445056720897', '1', 'admin', '保存菜单', '96', 'POST /sys/menu/save', '{\"parentId\":[\"1115183012166799361\"],\"type\":[\"1\"],\"name\":[\"首页管理\"],\"url\":[\"\"],\"perms\":[\"\"],\"orderNum\":[\"\"],\"icon\":[\"\"]}', '127.0.0.1', '2019-04-08 17:23:47');
INSERT INTO `sys_log` VALUES ('1115184160902778881', '1', 'admin', '保存菜单', '53', 'POST /sys/menu/save', '{\"parentId\":[\"1115183012166799361\"],\"type\":[\"1\"],\"name\":[\"消息管理\"],\"url\":[\"\"],\"perms\":[\"\"],\"orderNum\":[\"\"],\"icon\":[\"\"]}', '127.0.0.1', '2019-04-08 17:26:38');
INSERT INTO `sys_log` VALUES ('1115184208709455874', '1', 'admin', '保存菜单', '81', 'POST /sys/menu/save', '{\"parentId\":[\"1115183012166799361\"],\"type\":[\"1\"],\"name\":[\"媒体管理\"],\"url\":[\"\"],\"perms\":[\"\"],\"orderNum\":[\"\"],\"icon\":[\"\"]}', '127.0.0.1', '2019-04-08 17:26:49');
INSERT INTO `sys_log` VALUES ('1115184263180881921', '1', 'admin', '更新角色', '191', 'POST /sys/role/update', '{\"id\":[\"1\"],\"menuIds\":[\"193,194,195,196,197,79,80,81,83,176,177,178,179,180,207,208,209,210,211,20,21,22,61,12,13,14,24,25,26,15,55,56,62,74,75,76,48,72,28,29,30,57,92,1115180108840210434,1115180279120564226,71,78,175,206,1,2,6,7,73,3,77,27,91,1115179024377745410,-1,98,182,183,184,185,186,188,189,190,191,192,205,181,187,1115182861398347778,1115182933116751873,1115183358557589505,1115183444654067714,1115184160676286466,1115184208369717250,1115183213711495170,1115183247500808194,97,199,1034089959238385666,1034090238251876354,1115182776430137345,1115183012166799361,1115183127149449218\"],\"roleName\":[\"超级用户角色\"],\"remark\":[\"超级管理员\"]}', '127.0.0.1', '2019-04-08 17:27:02');
INSERT INTO `sys_log` VALUES ('1115184440318922754', '1', 'admin', '更新菜单', '38', 'POST /sys/menu/update', '{\"parentId\":[\"0\"],\"id\":[\"1115182776430137345\"],\"type\":[\"0\"],\"name\":[\"商品模块\"],\"url\":[\"\"],\"perms\":[\"\"],\"orderNum\":[\"1\"],\"icon\":[\"\"]}', '127.0.0.1', '2019-04-08 17:27:44');
INSERT INTO `sys_log` VALUES ('1115187892403081217', '1', 'admin', '登录', '5', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-08 17:41:27');
INSERT INTO `sys_log` VALUES ('1115188085651443713', '1', 'admin', '更新菜单', '78', 'POST /sys/menu/update', '{\"parentId\":[\"0\"],\"id\":[\"1115183012166799361\"],\"type\":[\"0\"],\"name\":[\"运营管理\"],\"url\":[\"\"],\"perms\":[\"\"],\"orderNum\":[\"2\"],\"icon\":[\"\"]}', '127.0.0.1', '2019-04-08 17:42:13');
INSERT INTO `sys_log` VALUES ('1115188133399400450', '1', 'admin', '更新菜单', '55', 'POST /sys/menu/update', '{\"parentId\":[\"0\"],\"id\":[\"1115183127149449218\"],\"type\":[\"0\"],\"name\":[\"个人设置\"],\"url\":[\"\"],\"perms\":[\"\"],\"orderNum\":[\"3\"],\"icon\":[\"\"]}', '127.0.0.1', '2019-04-08 17:42:25');
INSERT INTO `sys_log` VALUES ('1115188249199939585', '1', 'admin', '更新菜单', '47', 'POST /sys/menu/update', '{\"parentId\":[\"0\"],\"id\":[\"3\"],\"type\":[\"0\"],\"name\":[\"系统管理\"],\"url\":[\"\"],\"perms\":[\"\"],\"orderNum\":[\"5\"],\"icon\":[\"fa fa-desktop\"]}', '127.0.0.1', '2019-04-08 17:42:52');
INSERT INTO `sys_log` VALUES ('1115188282599182338', '1', 'admin', '更新菜单', '95', 'POST /sys/menu/update', '{\"parentId\":[\"0\"],\"id\":[\"1\"],\"type\":[\"0\"],\"name\":[\"基础管理\"],\"url\":[\"\"],\"perms\":[\"\"],\"orderNum\":[\"4\"],\"icon\":[\"fa fa-bars\"]}', '127.0.0.1', '2019-04-08 17:43:00');
INSERT INTO `sys_log` VALUES ('1115188978547462145', '1', 'admin', '更新菜单', '62', 'POST /sys/menu/update', '{\"parentId\":[\"0\"],\"id\":[\"1115182776430137345\"],\"type\":[\"0\"],\"name\":[\"商品模块\"],\"url\":[\"\"],\"perms\":[\"\"],\"orderNum\":[\"1\"],\"icon\":[\"fa fa-pencil-square-o\"]}', '127.0.0.1', '2019-04-08 17:45:46');
INSERT INTO `sys_log` VALUES ('1115189038656032770', '1', 'admin', '更新菜单', '49', 'POST /sys/menu/update', '{\"parentId\":[\"0\"],\"id\":[\"1115183012166799361\"],\"type\":[\"0\"],\"name\":[\"运营管理\"],\"url\":[\"\"],\"perms\":[\"\"],\"orderNum\":[\"2\"],\"icon\":[\"fa fa-tasks\"]}', '127.0.0.1', '2019-04-08 17:46:01');
INSERT INTO `sys_log` VALUES ('1115189322681716738', '1', 'admin', '更新菜单', '62', 'POST /sys/menu/update', '{\"parentId\":[\"0\"],\"id\":[\"1115183127149449218\"],\"type\":[\"0\"],\"name\":[\"个人设置\"],\"url\":[\"\"],\"perms\":[\"\"],\"orderNum\":[\"3\"],\"icon\":[\"fa fa-gear\"]}', '127.0.0.1', '2019-04-08 17:47:08');
INSERT INTO `sys_log` VALUES ('1115189420362862594', '1', 'admin', '更新菜单', '63', 'POST /sys/menu/update', '{\"parentId\":[\"0\"],\"id\":[\"1115183127149449218\"],\"type\":[\"0\"],\"name\":[\"个人设置\"],\"url\":[\"\"],\"perms\":[\"\"],\"orderNum\":[\"3\"],\"icon\":[\"fa fa-address-card-o\"]}', '127.0.0.1', '2019-04-08 17:47:32');
INSERT INTO `sys_log` VALUES ('1115189540559032322', '1', 'admin', '更新角色', '266', 'POST /sys/role/update', '{\"id\":[\"1\"],\"menuIds\":[\"193,194,195,196,197,79,80,81,83,176,177,178,179,180,207,208,209,210,211,20,21,22,61,12,13,14,24,25,26,15,55,56,62,74,75,76,48,72,28,29,30,57,92,1115180108840210434,1115180279120564226,1115182861398347778,1115182933116751873,1115183358557589505,1115183444654067714,1115184160676286466,1115184208369717250,1115183213711495170,1115183247500808194,71,78,175,206,1,2,6,7,73,3,77,27,91,1115179024377745410,1115182776430137345,1115183012166799361,1115183127149449218,-1\"],\"roleName\":[\"超级用户角色\"],\"remark\":[\"超级管理员\"]}', '127.0.0.1', '2019-04-08 17:48:00');
INSERT INTO `sys_log` VALUES ('1115196778279374849', '1', 'admin', '登录', '4', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-08 18:16:46');
INSERT INTO `sys_log` VALUES ('1115198391119286274', '1', 'admin', '根据数据表生成代码', '212', 'GET /common/generator/code/article', '{}', '127.0.0.1', '2019-04-08 18:23:10');
INSERT INTO `sys_log` VALUES ('1115199536789229569', '1', 'admin', '更新代码生成配置', '1032', 'POST /common/generator/update', '{\"author\":[\"Aron\"],\"email\":[\"izenglong@163.com\"],\"package\":[\"com.cms\"],\"autoRemovePre\":[\"on\"],\"tablePrefix\":[\"app\"],\"tinyint\":[\"Integer\"],\"smallint\":[\"Integer\"],\"mediumint\":[\"Integer\"],\"int\":[\"Integer\"],\"integer\":[\"Integer\"],\"bigint\":[\"Long\"],\"float\":[\"Float\"],\"double\":[\"Double\"],\"decimal\":[\"BigDecimal\"],\"bit\":[\"Boolean\"],\"char\":[\"String\"],\"varchar\":[\"String\"],\"tinytext\":[\"String\"],\"text\":[\"String\"],\"mediumtext\":[\"String\"],\"longtext\":[\"String\"],\"date\":[\"Date\"],\"datetime\":[\"Date\"],\"timestamp\":[\"Date\"]}', '127.0.0.1', '2019-04-08 18:27:44');
INSERT INTO `sys_log` VALUES ('1115200156510228481', '1', 'admin', '根据数据表生成代码', '29', 'GET /common/generator/code/article', '{}', '127.0.0.1', '2019-04-08 18:30:11');
INSERT INTO `sys_log` VALUES ('1115200365369790465', '1', 'admin', '更新代码生成配置', '830', 'POST /common/generator/update', '{\"author\":[\"Aron\"],\"email\":[\"izenglong@163.com\"],\"package\":[\"com.cms\"],\"autoRemovePre\":[\"on\"],\"tablePrefix\":[\"app\"],\"tinyint\":[\"Integer\"],\"smallint\":[\"Integer\"],\"mediumint\":[\"Integer\"],\"int\":[\"Integer\"],\"integer\":[\"Integer\"],\"bigint\":[\"Long\"],\"float\":[\"Float\"],\"double\":[\"Double\"],\"decimal\":[\"BigDecimal\"],\"bit\":[\"Boolean\"],\"char\":[\"String\"],\"varchar\":[\"String\"],\"tinytext\":[\"String\"],\"text\":[\"String\"],\"mediumtext\":[\"String\"],\"longtext\":[\"String\"],\"date\":[\"Date\"],\"datetime\":[\"Date\"],\"timestamp\":[\"Date\"]}', '127.0.0.1', '2019-04-08 18:31:01');
INSERT INTO `sys_log` VALUES ('1115200465651404801', '1', 'admin', '根据数据表生成代码', '39', 'GET /common/generator/code/article', '{}', '127.0.0.1', '2019-04-08 18:31:25');
INSERT INTO `sys_log` VALUES ('1115202578641166337', '1', 'admin', '登录', '49', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-08 18:39:49');
INSERT INTO `sys_log` VALUES ('1115202691220480001', '1', 'admin', '更新角色', '210', 'POST /sys/role/update', '{\"id\":[\"1\"],\"menuIds\":[\"193,194,195,196,197,79,80,81,83,176,177,178,179,180,207,208,209,210,211,20,21,22,61,12,13,14,24,25,26,15,55,56,62,74,75,76,48,72,28,29,30,57,92,1115180108840210434,1115180279120564226,1115182861398347778,1115182933116751873,1115183358557589505,1115183444654067714,1115184160676286466,1115184208369717250,1115183213711495170,1115183247500808194,71,78,175,206,2,6,7,73,3,77,27,91,1115179024377745410,1115182776430137345,1115183012166799361,1115183127149449218,1115184208369717251,1115184208369717252,1115184208369717253,1115184208369717254,1115184208369717255,1115184208369717256,1,-1\"],\"roleName\":[\"超级用户角色\"],\"remark\":[\"超级管理员\"]}', '127.0.0.1', '2019-04-08 18:40:16');
INSERT INTO `sys_log` VALUES ('1115205174491709441', '1', 'admin', '登录', '52', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-08 18:50:08');
INSERT INTO `sys_log` VALUES ('1115207537130577921', '1', 'admin', '登录', '50', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-08 18:59:31');
INSERT INTO `sys_log` VALUES ('1115207943839653890', '1', 'admin', '更新菜单', '44', 'POST /sys/menu/update', '{\"parentId\":[\"1\"],\"id\":[\"1115184208369717251\"],\"type\":[\"0\"],\"name\":[\"文章表\"],\"url\":[\"/cms/article\"],\"perms\":[\"\"],\"orderNum\":[\"6\"],\"icon\":[\"fa fa-file-code-o\"]}', '127.0.0.1', '2019-04-08 19:01:08');
INSERT INTO `sys_log` VALUES ('1115208115608985602', '1', 'admin', '更新菜单', '28', 'POST /sys/menu/update', '{\"parentId\":[\"1\"],\"id\":[\"1115184208369717251\"],\"type\":[\"1\"],\"name\":[\"文章表\"],\"url\":[\"/cms/article\"],\"perms\":[\"\"],\"orderNum\":[\"6\"],\"icon\":[\"fa fa-file-code-o\"]}', '127.0.0.1', '2019-04-08 19:01:49');
INSERT INTO `sys_log` VALUES ('1115244254399041538', '1', 'admin', '??', '137', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-08 21:25:25');
INSERT INTO `sys_log` VALUES ('1115252764222504961', '1', 'admin', '??', '93', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-08 21:59:14');
INSERT INTO `sys_log` VALUES ('1115254344229404673', '1', 'admin', '???????', '80', 'POST /cms/article/batchRemove', '{\"ids[]\":[\"1\"]}', '127.0.0.1', '2019-04-08 22:05:31');
INSERT INTO `sys_log` VALUES ('1115256172094431234', '1', 'admin', '??', '61', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-08 22:12:46');
INSERT INTO `sys_log` VALUES ('1115263915224211458', '1', 'admin', '??', '42', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-08 22:43:33');
INSERT INTO `sys_log` VALUES ('1115264011399602178', '1', 'admin', '???????????', '451', 'GET /common/generator/batchCode', '{\"tables\":[\"category,product,event,article\"]}', '127.0.0.1', '2019-04-08 22:43:56');
INSERT INTO `sys_log` VALUES ('1115264332762980353', '1', 'admin', '???????????', '109', 'GET /common/generator/batchCode', '{\"tables\":[\"category,product,event\"]}', '127.0.0.1', '2019-04-08 22:45:12');
INSERT INTO `sys_log` VALUES ('1115265339924422657', '1', 'admin', '????', '268', 'POST /sys/role/update', '{\"id\":[\"1\"],\"menuIds\":[\"193,194,195,196,197,79,80,81,83,176,177,178,179,180,207,208,209,210,211,20,21,22,61,12,13,14,24,25,26,15,55,56,62,74,75,76,48,72,28,29,30,57,92,1115184208369717252,1115184208369717253,1115184208369717254,1115184208369717255,1115184208369717256,1115183358557589505,1115183444654067714,1115184160676286466,1115184208369717250,1115183213711495170,1115183247500808194,71,78,175,206,1,2,6,7,73,3,77,27,91,1115184208369717251,1115183012166799361,1115183127149449218,1115184208369717263,1115184208369717264,1115184208369717265,1115184208369717266,1115184208369717267,1115184208369717268,1115179024377745410,1115182776430137345,1115184208369717258,1115184208369717259,1115184208369717260,1115184208369717261,1115184208369717262,1115184208369717270,1115184208369717271,1115184208369717272,1115184208369717273,1115184208369717274,1115184208369717257,1115184208369717269,-1\"],\"roleName\":[\"??????\"],\"remark\":[\"?????\"]}', '127.0.0.1', '2019-04-08 22:49:12');
INSERT INTO `sys_log` VALUES ('1115266698333655042', '1', 'admin', '??', '80', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-08 22:54:36');
INSERT INTO `sys_log` VALUES ('1115267617829986305', '1', 'admin', '??', '59', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-08 22:58:15');
INSERT INTO `sys_log` VALUES ('1115268909885407234', '1', 'admin', '??', '59', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-08 23:03:23');
INSERT INTO `sys_log` VALUES ('1115269943928090626', '1', 'admin', '??', '61', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-08 23:07:30');
INSERT INTO `sys_log` VALUES ('1115272378889293826', '1', 'admin', '??', '56', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-08 23:17:10');
INSERT INTO `sys_log` VALUES ('1115273258057363457', '1', 'admin', '??', '60', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-08 23:20:40');
INSERT INTO `sys_log` VALUES ('1115273654997934081', '1', 'admin', '??', '58', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-08 23:22:15');
INSERT INTO `sys_log` VALUES ('1115273674883129345', '1', 'admin', '??', '38', 'POST /cms/category/remove', '{\"id\":[\"1\"]}', '127.0.0.1', '2019-04-08 23:22:20');
INSERT INTO `sys_log` VALUES ('1115274000084299777', '1', 'admin', '??', '58', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-08 23:23:37');
INSERT INTO `sys_log` VALUES ('1115281528826425346', '1', 'admin', '??', '39', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-08 23:53:32');
INSERT INTO `sys_log` VALUES ('1115281630131449857', '1', 'admin', '?????????', '459', 'GET /common/generator/code/nav', '{}', '127.0.0.1', '2019-04-08 23:53:56');
INSERT INTO `sys_log` VALUES ('1115282261504225282', '1', 'admin', '????', '247', 'POST /sys/role/update', '{\"id\":[\"1\"],\"menuIds\":[\"193,194,195,196,197,79,80,81,83,176,177,178,179,180,207,208,209,210,211,20,21,22,61,12,13,14,24,25,26,15,55,56,62,74,75,76,48,72,28,29,30,57,92,1115184208369717252,1115184208369717253,1115184208369717254,1115184208369717255,1115184208369717256,1115184208369717264,1115184208369717265,1115184208369717266,1115184208369717267,1115184208369717268,1115184208369717258,1115184208369717259,1115184208369717260,1115184208369717261,1115184208369717262,1115184208369717270,1115184208369717271,1115184208369717272,1115184208369717273,1115184208369717274,1115183358557589505,1115183444654067714,1115184160676286466,1115184208369717250,1115183213711495170,1115183247500808194,71,78,175,206,1,2,6,7,73,3,77,27,91,1115184208369717251,1115184208369717263,1115179024377745410,1115184208369717257,1115184208369717269,1115182776430137345,1115183127149449218,1115184208369717275,1115184208369717276,1115184208369717277,1115184208369717278,1115184208369717279,1115184208369717280,1115183012166799361,-1\"],\"roleName\":[\"??????\"],\"remark\":[\"?????\"]}', '127.0.0.1', '2019-04-08 23:56:27');
INSERT INTO `sys_log` VALUES ('1115282338046078977', '1', 'admin', '????', '32', 'POST /sys/menu/remove', '{\"id\":[\"1115183358557589505\"]}', '127.0.0.1', '2019-04-08 23:56:45');
INSERT INTO `sys_log` VALUES ('1115282885507571713', '1', 'admin', '??', '69', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-08 23:58:55');
INSERT INTO `sys_log` VALUES ('1115283432058920961', '1', 'admin', '??', '59', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-09 00:01:06');
INSERT INTO `sys_log` VALUES ('1115421380603600897', '1', 'admin', '登录', '45', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-09 09:09:15');
INSERT INTO `sys_log` VALUES ('1115433726604591105', '1', 'admin', '登录', '47', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-09 09:58:19');
INSERT INTO `sys_log` VALUES ('1115433791368839170', '1', 'admin', '登录', '7', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-09 09:58:34');
INSERT INTO `sys_log` VALUES ('1115434199638118402', '1', 'admin', '登录', '50', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-09 10:00:12');
INSERT INTO `sys_log` VALUES ('1115434264427532290', '1', 'admin', '登录', '5', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-09 10:00:27');
INSERT INTO `sys_log` VALUES ('1115434565230436354', '1', 'admin', '登录', '55', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-09 10:01:39');
INSERT INTO `sys_log` VALUES ('1115434594687033346', '1', 'admin', '登录', '6', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-09 10:01:46');
INSERT INTO `sys_log` VALUES ('1115435070178578433', '1', 'admin', '登录', '50', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-09 10:03:39');
INSERT INTO `sys_log` VALUES ('1115435100314652674', '1', 'admin', '登录', '5', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-09 10:03:46');
INSERT INTO `sys_log` VALUES ('1115440520743735297', '1', 'admin', '登录', '50', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-09 10:25:19');
INSERT INTO `sys_log` VALUES ('1115441649967693826', '1', 'admin', '登录', '47', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-09 10:29:48');
INSERT INTO `sys_log` VALUES ('1115441694259544066', '1', 'admin', '添加', '93', 'POST /cms/category/save', '{\"name\":[\"水果\"],\"updateTime\":[\"\"]}', '127.0.0.1', '2019-04-09 10:29:58');
INSERT INTO `sys_log` VALUES ('1115447279667478530', '1', 'admin', '登录', '47', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-09 10:52:10');
INSERT INTO `sys_log` VALUES ('1115447472433496065', '1', 'admin', '添加', '75', 'POST /cms/nav/save', '{\"name\":[\"techtour\"],\"background\":[\"\"],\"url\":[\"/techtour\"],\"order\":[\"\"],\"type\":[\"\"],\"isshow\":[\"\"],\"updatetime\":[\"\"]}', '127.0.0.1', '2019-04-09 10:52:56');
INSERT INTO `sys_log` VALUES ('1115449479097507842', '1', 'admin', '登录', '47', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-09 11:00:55');
INSERT INTO `sys_log` VALUES ('1115449723562553346', '1', 'admin', '登录', '48', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-09 11:01:53');
INSERT INTO `sys_log` VALUES ('1115450173129084930', '1', 'admin', '登录', '53', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-09 11:03:40');
INSERT INTO `sys_log` VALUES ('1115456947353669634', '1', 'admin', '登录', '10', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-09 11:30:35');
INSERT INTO `sys_log` VALUES ('1115456990844407810', '1', 'admin', '根据数据表生成代码', '108', 'GET /common/generator/code/nav_content', '{}', '127.0.0.1', '2019-04-09 11:30:45');
INSERT INTO `sys_log` VALUES ('1115460690010820610', '1', 'admin', '登录', '16', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-09 11:45:27');
INSERT INTO `sys_log` VALUES ('1115485855390179329', '1', 'admin', '登录', '52', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-09 13:25:27');
INSERT INTO `sys_log` VALUES ('1115506151484592130', '1', 'admin', '登录', '56', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-09 14:46:06');
INSERT INTO `sys_log` VALUES ('1115506902151786498', '1', 'admin', '登录', '46', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-09 14:49:05');
INSERT INTO `sys_log` VALUES ('1115507304180047873', '1', 'admin', '登录', '47', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-09 14:50:41');
INSERT INTO `sys_log` VALUES ('1115507332831338497', '1', 'admin', '删除', '40', 'POST /cms/nav/remove', '{\"id\":[\"2\"]}', '127.0.0.1', '2019-04-09 14:50:48');
INSERT INTO `sys_log` VALUES ('1115507440599785474', '1', 'admin', '添加', '122', 'POST /cms/nav/save', '{\"name\":[\"techtour\"],\"background\":[\"\"],\"url\":[\"/techtour\"],\"order\":[\"1\"],\"type\":[\"2\"],\"isshow\":[\"\"],\"updatetime\":[\"\"]}', '127.0.0.1', '2019-04-09 14:51:14');
INSERT INTO `sys_log` VALUES ('1115507902757560321', '1', 'admin', '添加', '98', 'POST /cms/nav/save', '{\"name\":[\"techtour\"],\"background\":[\"\"],\"url\":[\"\"],\"order\":[\"1\"],\"type\":[\"2\"],\"isshow\":[\"\"],\"updatetime\":[\"\"]}', '127.0.0.1', '2019-04-09 14:53:04');
INSERT INTO `sys_log` VALUES ('1115508059100241921', '1', 'admin', '根据数据表生成代码', '132', 'GET /common/generator/code/website', '{}', '127.0.0.1', '2019-04-09 14:53:41');
INSERT INTO `sys_log` VALUES ('1115509761597542402', '1', 'admin', '登录', '39', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-09 15:00:27');
INSERT INTO `sys_log` VALUES ('1115509821437677570', '1', 'admin', '添加', '112', 'POST /cms/nav/save', '{\"name\":[\"techtour\"],\"background\":[\"\"],\"url\":[\"\"],\"order\":[\"1\"],\"type\":[\"2\"],\"isshow\":[\"\"],\"updatetime\":[\"\"]}', '127.0.0.1', '2019-04-09 15:00:41');
INSERT INTO `sys_log` VALUES ('1115510588257112065', '1', 'admin', '添加', '38', 'POST /cms/nav/save', '{\"name\":[\"techtour\"],\"background\":[\"\"],\"url\":[\"\"],\"order\":[\"1\"],\"type\":[\"2\"],\"isshow\":[\"\"],\"updatetime\":[\"\"]}', '127.0.0.1', '2019-04-09 15:03:44');
INSERT INTO `sys_log` VALUES ('1115510646121730049', '1', 'admin', '添加', '68', 'POST /cms/nav/save', '{\"name\":[\"techtour\"],\"background\":[\"\"],\"url\":[\"\"],\"order\":[\"1\"],\"type\":[\"2\"],\"isshow\":[\"\"],\"updatetime\":[\"\"]}', '127.0.0.1', '2019-04-09 15:03:58');
INSERT INTO `sys_log` VALUES ('1115510734474743810', '1', 'admin', '添加', '39', 'POST /cms/nav/save', '{\"name\":[\"techtour\"],\"background\":[\"\"],\"url\":[\"\"],\"order\":[\"1\"],\"type\":[\"2\"],\"isshow\":[\"\"],\"updatetime\":[\"\"]}', '127.0.0.1', '2019-04-09 15:04:19');
INSERT INTO `sys_log` VALUES ('1115510916650143745', '1', 'admin', '添加', '138', 'POST /cms/nav/save', '{\"name\":[\"techtour\"],\"background\":[\"\"],\"url\":[\"\"],\"order\":[\"1\"],\"type\":[\"2\"],\"isshow\":[\"1\"],\"updatetime\":[\"\"]}', '127.0.0.1', '2019-04-09 15:05:02');
INSERT INTO `sys_log` VALUES ('1115511288936595457', '1', 'admin', '登录', '44', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-09 15:06:31');
INSERT INTO `sys_log` VALUES ('1115511358251663361', '1', 'admin', '添加', '107', 'POST /cms/nav/save', '{\"name\":[\"techtour\"],\"background\":[\"\"],\"url\":[\"\"],\"order\":[\"1\"],\"type\":[\"2\"],\"isshow\":[\"1\"],\"updatetime\":[\"\"]}', '127.0.0.1', '2019-04-09 15:06:48');
INSERT INTO `sys_log` VALUES ('1115512284542730241', '1', 'admin', '更新角色', '231', 'POST /sys/role/update', '{\"id\":[\"1\"],\"menuIds\":[\"193,194,195,196,197,79,80,81,83,176,177,178,179,180,207,208,209,210,211,20,21,22,61,12,13,14,24,25,26,15,55,56,62,74,75,76,48,72,28,29,30,57,92,1115184208369717252,1115184208369717253,1115184208369717254,1115184208369717255,1115184208369717256,1115184208369717264,1115184208369717265,1115184208369717266,1115184208369717267,1115184208369717268,1115184208369717258,1115184208369717259,1115184208369717260,1115184208369717261,1115184208369717262,1115184208369717270,1115184208369717271,1115184208369717272,1115184208369717273,1115184208369717274,1115183444654067714,1115184160676286466,1115184208369717250,1115184208369717276,1115184208369717277,1115184208369717278,1115184208369717279,1115184208369717280,1115183213711495170,1115183247500808194,71,78,175,206,1,2,6,7,73,3,77,27,91,1115184208369717251,1115184208369717263,1115179024377745410,1115184208369717257,1115184208369717269,1115182776430137345,1115183127149449218,1115184208369717281,1115184208369717282,1115184208369717283,1115184208369717284,1115184208369717285,1115184208369717286,1115184208369717275,1115183012166799361,-1\"],\"roleName\":[\"??????\"],\"remark\":[\"?????\"]}', '127.0.0.1', '2019-04-09 15:10:29');
INSERT INTO `sys_log` VALUES ('1115512478021779458', '1', 'admin', '添加', '133', 'POST /cms/nav/save', '{\"name\":[\"techtour\"],\"background\":[\"\"],\"url\":[\"\"],\"order\":[\"1\"],\"type\":[\"2\"],\"isshow\":[\"1\"],\"updatetime\":[\"\"]}', '127.0.0.1', '2019-04-09 15:11:15');
INSERT INTO `sys_log` VALUES ('1115524917790629890', '1', 'admin', '登录', '47', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-09 16:00:41');
INSERT INTO `sys_log` VALUES ('1115524971511275522', '1', 'admin', '添加', '106', 'POST /cms/nav/save', '{\"name\":[\"techtour\"],\"background\":[\"\"],\"url\":[\"\"],\"order\":[\"1\"],\"type\":[\"2\"],\"isshow\":[\"1\"],\"updatetime\":[\"\"]}', '127.0.0.1', '2019-04-09 16:00:53');
INSERT INTO `sys_log` VALUES ('1115528762176331777', '1', 'admin', '登录', '47', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-09 16:15:57');
INSERT INTO `sys_log` VALUES ('1115528807328014337', '1', 'admin', '添加', '74', 'POST /cms/nav/save', '{\"name\":[\"techtour\"],\"background\":[\"\"],\"url\":[\"\"],\"order\":[\"1\"],\"type\":[\"2\"],\"isshow\":[\"1\"],\"updatetime\":[\"\"]}', '127.0.0.1', '2019-04-09 16:16:08');
INSERT INTO `sys_log` VALUES ('1115529933653827585', '1', 'admin', '添加', '123', 'POST /cms/nav/save', '{\"name\":[\"techtour\"],\"background\":[\"\"],\"url\":[\"\"],\"order\":[\"1\"],\"type\":[\"2\"],\"isshow\":[\"1\"],\"updatetime\":[\"\"]}', '127.0.0.1', '2019-04-09 16:20:36');
INSERT INTO `sys_log` VALUES ('1115536214695370753', '1', 'admin', '登录', '4', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-09 16:45:34');
INSERT INTO `sys_log` VALUES ('1115536269833691137', '1', 'admin', '添加', '89', 'POST /cms/nav/save', '{\"name\":[\"techtour\"],\"background\":[\"\"],\"url\":[\"\"],\"order\":[\"1\"],\"type\":[\"2\"],\"isshow\":[\"1\"],\"updatetime\":[\"\"]}', '127.0.0.1', '2019-04-09 16:45:47');
INSERT INTO `sys_log` VALUES ('1115537428426285057', '1', 'admin', '添加', '60', 'POST /cms/nav/save', '{\"name\":[\"techtour\"],\"background\":[\"\"],\"url\":[\"\"],\"order\":[\"\"],\"type\":[\"2\"],\"isshow\":[\"\"],\"updatetime\":[\"\"]}', '127.0.0.1', '2019-04-09 16:50:23');
INSERT INTO `sys_log` VALUES ('1115542472081014785', '1', 'admin', '登录', '46', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-09 17:10:26');
INSERT INTO `sys_log` VALUES ('1115542537298247682', '1', 'admin', '添加', '106', 'POST /cms/nav/save', '{\"name\":[\"techtour\"],\"background\":[\"\"],\"url\":[\"\"],\"order\":[\"2\"],\"type\":[\"2\"],\"isshow\":[\"1\"],\"updatetime\":[\"\"]}', '127.0.0.1', '2019-04-09 17:10:41');
INSERT INTO `sys_log` VALUES ('1115542672182870017', '1', 'admin', '添加', '37', 'POST /cms/nav/save', '{\"name\":[\"techtour\"],\"background\":[\"\"],\"url\":[\"\"],\"order\":[\"2\"],\"type\":[\"2\"],\"isshow\":[\"1\"],\"updatetime\":[\"\"]}', '127.0.0.1', '2019-04-09 17:11:13');
INSERT INTO `sys_log` VALUES ('1115542702985838594', '1', 'admin', '添加', '37', 'POST /cms/nav/save', '{\"name\":[\"techtour\"],\"background\":[\"\"],\"url\":[\"\"],\"order\":[\"2\"],\"type\":[\"2\"],\"isshow\":[\"1\"],\"updatetime\":[\"\"]}', '127.0.0.1', '2019-04-09 17:11:21');
INSERT INTO `sys_log` VALUES ('1115542847718686721', '1', 'admin', '添加', '93', 'POST /cms/nav/save', '{\"name\":[\"techtour\"],\"background\":[\"\"],\"url\":[\"\"],\"order\":[\"1\"],\"type\":[\"2\"],\"isshow\":[\"\"],\"updatetime\":[\"\"]}', '127.0.0.1', '2019-04-09 17:11:55');
INSERT INTO `sys_log` VALUES ('1115543448041029633', '1', 'admin', '添加', '94', 'POST /cms/nav/save', '{\"name\":[\"techtour\"],\"background\":[\"\"],\"url\":[\"\"],\"order\":[\"1\"],\"type\":[\"2\"],\"isshow\":[\"1\"],\"updatetime\":[\"\"]}', '127.0.0.1', '2019-04-09 17:14:18');
INSERT INTO `sys_log` VALUES ('1115544891766722561', '1', 'admin', '登录', '46', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-09 17:20:03');
INSERT INTO `sys_log` VALUES ('1115548550403469313', '1', 'admin', '登录', '45', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-09 17:34:35');
INSERT INTO `sys_log` VALUES ('1115550070633172993', '1', 'admin', '登录', '48', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-09 17:40:37');
INSERT INTO `sys_log` VALUES ('1115551195931381762', '1', 'admin', '添加', '73', 'POST /cms/nav/save', '{\"name\":[\"techtour\"],\"background\":[\"\"],\"url\":[\"\"],\"order\":[\"1\"],\"type\":[\"2\"],\"isshow\":[\"\"],\"updatetime\":[\"\"]}', '127.0.0.1', '2019-04-09 17:45:06');
INSERT INTO `sys_log` VALUES ('1115552173690843137', '1', 'admin', '登录', '46', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-09 17:48:59');
INSERT INTO `sys_log` VALUES ('1115552214342037505', '1', 'admin', '添加', '80', 'POST /cms/nav/save', '{\"name\":[\"techtour\"],\"background\":[\"\"],\"url\":[\"\"],\"order\":[\"1\"],\"type\":[\"2\"],\"isshow\":[\"\"],\"updatetime\":[\"\"]}', '127.0.0.1', '2019-04-09 17:49:09');
INSERT INTO `sys_log` VALUES ('1115552725493477377', '1', 'admin', '添加', '114222', 'POST /website/save', '{\"navid\":[\"23\"],\"title\":[\"123\"],\"content\":[\"123\"],\"video\":[\"\"],\"order\":[\"\"],\"model-1-title\":[\"123\"],\"model-1-content\":[\"123\"],\"model-1-video\":[\"\"],\"model-1-order\":[\"\"],\"model-2-title\":[\"123\"],\"model-2-content\":[\"123\"],\"model-2-video\":[\"\"],\"model-2-order\":[\"\"],\"model-3-title\":[\"123\"],\"model-3-content\":[\"123\"],\"model-3-video\":[\"\"],\"model-3-order\":[\"\"],\"model-4-title\":[\"\"],\"type\":[\"title\"]}', '127.0.0.1', '2019-04-09 17:51:10');
INSERT INTO `sys_log` VALUES ('1115552956167544833', '1', 'admin', '登录', '46', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-09 17:52:05');
INSERT INTO `sys_log` VALUES ('1115552999599562753', '1', 'admin', '添加', '146', 'POST /cms/nav/save', '{\"name\":[\"techtour\"],\"background\":[\"\"],\"url\":[\"\"],\"order\":[\"1\"],\"type\":[\"2\"],\"isshow\":[\"\"],\"updatetime\":[\"\"]}', '127.0.0.1', '2019-04-09 17:52:16');
INSERT INTO `sys_log` VALUES ('1115553488491831297', '1', 'admin', '添加', '105115', 'POST /website/save', '{\"navid\":[\"24\"],\"title\":[\"123\"],\"content\":[\"123\"],\"video\":[\"\"],\"order\":[\"\"],\"model-1-title\":[\"12312\"],\"model-1-content\":[\"3123\"],\"model-1-video\":[\"\"],\"model-1-order\":[\"\"],\"model-2-title\":[\"123\"],\"model-2-content\":[\"213\"],\"model-2-video\":[\"\"],\"model-2-order\":[\"\"],\"model-3-title\":[\"1313\"],\"model-3-content\":[\"13123\"],\"model-3-video\":[\"\"],\"model-3-order\":[\"\"],\"model-4-title\":[\"123\"],\"type\":[\"title\"]}', '127.0.0.1', '2019-04-09 17:54:12');
INSERT INTO `sys_log` VALUES ('1115553783137562626', '1', 'admin', '登录', '47', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-09 17:55:23');
INSERT INTO `sys_log` VALUES ('1115553830101184514', '1', 'admin', '添加', '65', 'POST /cms/nav/save', '{\"name\":[\"techtour\"],\"background\":[\"\"],\"url\":[\"\"],\"order\":[\"1\"],\"type\":[\"2\"],\"isshow\":[\"\"],\"updatetime\":[\"\"]}', '127.0.0.1', '2019-04-09 17:55:34');
INSERT INTO `sys_log` VALUES ('1115553891572903938', '1', 'admin', '添加', '2', 'POST /website/save', '{\"navid\":[\"25\"],\"title\":[\"12\"],\"content\":[\"12\"],\"video\":[\"\"],\"order\":[\"\"],\"model-1-title\":[\"12\"],\"model-1-content\":[\"12\"],\"model-1-video\":[\"\"],\"model-1-order\":[\"\"],\"model-2-title\":[\"12\"],\"model-2-content\":[\"12\"],\"model-2-video\":[\"\"],\"model-2-order\":[\"\"],\"model-3-title\":[\"12\"],\"model-3-content\":[\"12\"],\"model-3-video\":[\"\"],\"model-3-order\":[\"\"],\"model-4-title\":[\"12\"],\"type\":[\"title\"]}', '127.0.0.1', '2019-04-09 17:55:48');
INSERT INTO `sys_log` VALUES ('1115554071101698050', '1', 'admin', '添加', '26702', 'POST /website/save', '{\"navid\":[\"25\"],\"title\":[\"12\"],\"content\":[\"12\"],\"video\":[\"\"],\"order\":[\"\"],\"model-1-title\":[\"12\"],\"model-1-content\":[\"12\"],\"model-1-video\":[\"\"],\"model-1-order\":[\"\"],\"model-2-title\":[\"12\"],\"model-2-content\":[\"12\"],\"model-2-video\":[\"\"],\"model-2-order\":[\"\"],\"model-3-title\":[\"12\"],\"model-3-content\":[\"12\"],\"model-3-video\":[\"\"],\"model-3-order\":[\"\"],\"model-4-title\":[\"12\"],\"type\":[\"title\"]}', '127.0.0.1', '2019-04-09 17:56:31');
INSERT INTO `sys_log` VALUES ('1115554183949332482', '1', 'admin', '登录', '46', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-09 17:56:58');
INSERT INTO `sys_log` VALUES ('1115554213888274433', '1', 'admin', '添加', '154', 'POST /cms/nav/save', '{\"name\":[\"techtour\"],\"background\":[\"\"],\"url\":[\"\"],\"order\":[\"1\"],\"type\":[\"2\"],\"isshow\":[\"\"],\"updatetime\":[\"\"]}', '127.0.0.1', '2019-04-09 17:57:05');
INSERT INTO `sys_log` VALUES ('1115554263683051522', '1', 'admin', '添加', '3793', 'POST /website/save', '{\"navid\":[\"26\"],\"title\":[\"123\"],\"content\":[\"123\"],\"video\":[\"\"],\"order\":[\"\"],\"model-1-title\":[\"123\"],\"model-1-content\":[\"123\"],\"model-1-video\":[\"\"],\"model-1-order\":[\"\"],\"model-2-title\":[\"123\"],\"model-2-content\":[\"123\"],\"model-2-video\":[\"\"],\"model-2-order\":[\"\"],\"model-3-title\":[\"13\"],\"model-3-content\":[\"123\"],\"model-3-video\":[\"\"],\"model-3-order\":[\"\"],\"model-4-title\":[\"1231\"],\"type\":[\"title\"]}', '127.0.0.1', '2019-04-09 17:57:17');
INSERT INTO `sys_log` VALUES ('1115558120572174338', '1', 'admin', '登录', '46', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-09 18:12:37');
INSERT INTO `sys_log` VALUES ('1115558152574713857', '1', 'admin', '添加', '68', 'POST /cms/nav/save', '{\"name\":[\"techtour\"],\"background\":[\"\"],\"url\":[\"\"],\"order\":[\"1\"],\"type\":[\"2\"],\"isshow\":[\"\"],\"updatetime\":[\"\"]}', '127.0.0.1', '2019-04-09 18:12:44');
INSERT INTO `sys_log` VALUES ('1115558340060102657', '1', 'admin', '添加', '110', 'POST /website/save', '{\"navid\":[\"27\"],\"title\":[\"12\"],\"content\":[\"12\"],\"video\":[\"\"],\"order\":[\"\"],\"model-1-title\":[\"12\"],\"model-1-content\":[\"12\"],\"model-1-video\":[\"\"],\"model-1-order\":[\"\"],\"model-2-title\":[\"14214\"],\"model-2-content\":[\"25rt34tf\"],\"model-2-video\":[\"\"],\"model-2-order\":[\"\"],\"model-3-title\":[\"svsv\"],\"model-3-content\":[\"wt23rtf\"],\"model-3-video\":[\"\"],\"model-3-order\":[\"\"],\"model-4-title\":[\"123\"],\"type\":[\"title\"]}', '127.0.0.1', '2019-04-09 18:13:29');
INSERT INTO `sys_log` VALUES ('1115559675266449409', '1', 'admin', '批量删除', '72', 'POST /cms/nav/batchRemove', '{\"ids[]\":[\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\"]}', '127.0.0.1', '2019-04-09 18:18:47');
INSERT INTO `sys_log` VALUES ('1115559701103362049', '1', 'admin', '批量删除', '33', 'POST /cms/nav/batchRemove', '{\"ids[]\":[\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\"]}', '127.0.0.1', '2019-04-09 18:18:53');
INSERT INTO `sys_log` VALUES ('1115559718870433793', '1', 'admin', '批量删除', '39', 'POST /cms/nav/batchRemove', '{\"ids[]\":[\"8\",\"7\",\"6\",\"5\",\"4\",\"3\"]}', '127.0.0.1', '2019-04-09 18:18:58');
INSERT INTO `sys_log` VALUES ('1115560061985370114', '1', 'admin', '登录', '49', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-09 18:20:20');
INSERT INTO `sys_log` VALUES ('1115560636114386945', '1', 'admin', '登录', '46', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-09 18:22:36');
INSERT INTO `sys_log` VALUES ('1115561131373608962', '1', 'admin', '登录', '15', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-09 18:24:34');
INSERT INTO `sys_log` VALUES ('1115561510484066306', '1', 'admin', '登录', '47', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-09 18:26:05');
INSERT INTO `sys_log` VALUES ('1115562341774147585', '1', 'admin', '登录', '51', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-09 18:29:23');
INSERT INTO `sys_log` VALUES ('1115562363462893570', '1', 'admin', '删除', '53', 'POST /cms/nav/remove', '{\"id\":[\"27\"]}', '127.0.0.1', '2019-04-09 18:29:28');
INSERT INTO `sys_log` VALUES ('1115562394756595714', '1', 'admin', '添加', '126', 'POST /cms/nav/save', '{\"name\":[\"techtour\"],\"background\":[\"\"],\"url\":[\"1\"],\"order\":[\"1\"],\"type\":[\"2\"],\"isshow\":[\"\"],\"updatetime\":[\"\"]}', '127.0.0.1', '2019-04-09 18:29:36');
INSERT INTO `sys_log` VALUES ('1115562442106093570', '1', 'admin', '添加', '113', 'POST /website/save', '{\"navid\":[\"28\"],\"title\":[\"1231wtf\"],\"content\":[\"svsv dsv\"],\"video\":[\"\"],\"order\":[\"\"],\"model1title\":[\"rsadvasv1\"],\"model1content\":[\"123\"],\"model1video\":[\"\"],\"model1order\":[\"\"],\"model2title\":[\"sdv114\"],\"model2content\":[\"asvcwef\"],\"model2video\":[\"\"],\"model2order\":[\"\"],\"model3title\":[\"12312sa\"],\"model3content\":[\"asdvas12e\"],\"model3video\":[\"\"],\"model3order\":[\"\"],\"model4title\":[\"123c\"],\"type\":[\"title\"]}', '127.0.0.1', '2019-04-09 18:29:47');
INSERT INTO `sys_log` VALUES ('1115788170324135937', '1', 'admin', '登录', '72', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-10 09:26:45');
INSERT INTO `sys_log` VALUES ('1115789992875048962', '1', 'admin', '登录', '47', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-10 09:33:59');
INSERT INTO `sys_log` VALUES ('1115792434983350274', '1', 'admin', '登录', '48', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-10 09:43:42');
INSERT INTO `sys_log` VALUES ('1115793432862806017', '1', 'admin', '登录', '20', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-10 09:47:39');
INSERT INTO `sys_log` VALUES ('1115793586047176706', '1', 'admin', '添加', '114', 'POST /cms/nav/save', '{\"name\":[\"techtour\"],\"background\":[\"\"],\"url\":[\"/techtour\"],\"order\":[\"1\"],\"type\":[\"2\"],\"isshow\":[\"1\"],\"updatetime\":[\"\"]}', '127.0.0.1', '2019-04-10 09:48:16');
INSERT INTO `sys_log` VALUES ('1115796058081873921', '1', 'admin', '删除', '109', 'POST /cms/nav/remove', '{\"id\":[\"29\"]}', '127.0.0.1', '2019-04-10 09:58:05');
INSERT INTO `sys_log` VALUES ('1115796130496532481', '1', 'admin', '添加', '52', 'POST /cms/nav/save', '{\"name\":[\"techtour\"],\"background\":[\"\"],\"url\":[\"/techtour\"],\"order\":[\"1\"],\"type\":[\"2\"],\"isshow\":[\"\"],\"updatetime\":[\"\"]}', '127.0.0.1', '2019-04-10 09:58:23');
INSERT INTO `sys_log` VALUES ('1115797823485460482', '1', 'admin', '登录', '21', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-10 10:05:06');
INSERT INTO `sys_log` VALUES ('1115797921229520897', '1', 'admin', '添加', '135', 'POST /cms/nav/save', '{\"name\":[\"techtour\"],\"background\":[\"\"],\"url\":[\"/techtour\"],\"order\":[\"1\"],\"type\":[\"2\"],\"isshow\":[\"\"],\"updatetime\":[\"\"]}', '127.0.0.1', '2019-04-10 10:05:30');
INSERT INTO `sys_log` VALUES ('1115810137961984001', '1', 'admin', '登录', '45', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-10 10:54:02');
INSERT INTO `sys_log` VALUES ('1115826459429105666', '1', 'admin', '登录', '13', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-10 11:58:54');
INSERT INTO `sys_log` VALUES ('1115832942170480642', '1', 'admin', '登录', '46', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-10 12:24:39');
INSERT INTO `sys_log` VALUES ('1115835575769767937', '1', 'admin', '删除', '75', 'POST /cms/nav/remove', '{\"id\":[\"28\"]}', '127.0.0.1', '2019-04-10 12:35:07');
INSERT INTO `sys_log` VALUES ('1115835583038496770', '1', 'admin', '删除', '292', 'POST /cms/nav/remove', '{\"id\":[\"31\"]}', '127.0.0.1', '2019-04-10 12:35:09');
INSERT INTO `sys_log` VALUES ('1115835592064638978', '1', 'admin', '删除', '36', 'POST /cms/nav/remove', '{\"id\":[\"30\"]}', '127.0.0.1', '2019-04-10 12:35:11');
INSERT INTO `sys_log` VALUES ('1115866740945973249', '1', 'admin', '登录', '48', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-10 14:38:57');
INSERT INTO `sys_log` VALUES ('1115868861950853122', '1', 'admin', '登录', '22', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-10 14:47:23');
INSERT INTO `sys_log` VALUES ('1115870491517665281', '1', 'admin', '登录', '23', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-10 14:53:52');
INSERT INTO `sys_log` VALUES ('1115872513029681154', '1', 'admin', '登录', '48', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-10 15:01:54');
INSERT INTO `sys_log` VALUES ('1115874717501337602', '1', 'admin', '添加', '101', 'POST /cms/nav/save', '{}', '127.0.0.1', '2019-04-10 15:10:39');
INSERT INTO `sys_log` VALUES ('1115875498874929154', '1', 'admin', '登录', '46', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-10 15:13:46');
INSERT INTO `sys_log` VALUES ('1115875749249712129', '1', 'admin', '删除', '47', 'POST /cms/nav/remove', '{\"id\":[\"32\"]}', '127.0.0.1', '2019-04-10 15:14:45');
INSERT INTO `sys_log` VALUES ('1115877617925365762', '1', 'admin', '登录', '53', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-10 15:22:11');
INSERT INTO `sys_log` VALUES ('1115880130640617473', '1', 'admin', '登录', '5', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-10 15:32:10');
INSERT INTO `sys_log` VALUES ('1115881122006310913', '1', 'admin', '登录', '17', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-10 15:36:06');
INSERT INTO `sys_log` VALUES ('1115882979420364801', '1', 'admin', '登录', '50', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-10 15:43:29');
INSERT INTO `sys_log` VALUES ('1115883056671055874', '1', 'admin', '添加', '115', 'POST /cms/nav/save', '{}', '127.0.0.1', '2019-04-10 15:43:47');
INSERT INTO `sys_log` VALUES ('1115890943598354433', '1', 'admin', '登录', '8', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-10 16:15:08');
INSERT INTO `sys_log` VALUES ('1115893780071874561', '1', 'admin', '登录', '49', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-10 16:26:24');
INSERT INTO `sys_log` VALUES ('1115893785272811522', '1', 'admin', '登录', '11', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-10 16:26:25');
INSERT INTO `sys_log` VALUES ('1115900144294854658', '1', 'admin', '登录', '6', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-10 16:51:41');
INSERT INTO `sys_log` VALUES ('1115916502390804482', '1', 'admin', '登录', '21', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-10 17:56:42');
INSERT INTO `sys_log` VALUES ('1115916640647647234', '1', 'admin', '添加文章表', '8819', 'POST /cms/article/save', '{}', '127.0.0.1', '2019-04-10 17:57:15');
INSERT INTO `sys_log` VALUES ('1115918139029204994', '1', 'admin', '登录', '47', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-10 18:03:12');
INSERT INTO `sys_log` VALUES ('1115918647609536514', '1', 'admin', '添加文章表', '18191', 'POST /cms/article/save', '{\"title\":[\"13123svgw\"],\"summary\":[\"1231342qrdwq\"],\"createTime\":[\"2014-11-11\"],\"author\":[\"dahao\"],\"style\":[\"4\"],\"content\":[\"<p>Balala...1drwfwsfvswv</p>\"],\"metaTitle\":[\"fqwfqwf\"],\"metaKeywords\":[\"wq\"],\"metaDescription\":[\"wfwf\"]}', '127.0.0.1', '2019-04-10 18:05:13');
INSERT INTO `sys_log` VALUES ('1115919081346707458', '1', 'admin', '添加文章表', '4555', 'POST /cms/article/save', '{\"title\":[\"123e12\"],\"summary\":[\"ewqfeqwfe\"],\"createTime\":[\"2014-11-11\"],\"author\":[\"daafdwf\"],\"style\":[\"4\"],\"content\":[\"<p>Balala...wfcwgfevdevdesbv ebv&nbsp; wfc</p>\"],\"metaTitle\":[\"wf wq\"],\"metaKeywords\":[\"fwsfwf\"],\"metaDescription\":[\"wfwe\"]}', '127.0.0.1', '2019-04-10 18:06:56');
INSERT INTO `sys_log` VALUES ('1115920710158528513', '1', 'admin', '添加文章表', '117', 'POST /cms/event/save', '{\"title\":[\"123\"],\"content\":[\"1231\"],\"linkto\":[\"www.baidu.com\"],\"thumbnail\":[\"\"],\"ordernumber\":[\"1\"],\"status\":[\"\"],\"starttime\":[\"2019-04-10 18:13:11\"],\"endtime\":[\"2019-04-10 18:13:13\"],\"price\":[\"$123\"],\"address\":[\"你家\"],\"metakeywords\":[\"\"],\"metadescription\":[\"\"],\"remarks\":[\"\"],\"type\":[\"1\"]}', '127.0.0.1', '2019-04-10 18:13:25');
INSERT INTO `sys_log` VALUES ('1115921271687753730', '1', 'admin', '删除文章表', '77', 'POST /cms/event/remove', '{\"id\":[\"2\"]}', '127.0.0.1', '2019-04-10 18:15:39');
INSERT INTO `sys_log` VALUES ('1116263930516283393', '1', 'admin', '登录', '42', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-11 16:57:15');
INSERT INTO `sys_log` VALUES ('1116276480305852417', '1', 'admin', '登录', '20', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-11 17:47:07');
INSERT INTO `sys_log` VALUES ('1116276534873747458', '1', 'admin', '删除文章表', '97', 'POST /cms/event/remove', '{\"id\":[\"15\"]}', '127.0.0.1', '2019-04-11 17:47:20');
INSERT INTO `sys_log` VALUES ('1116277842821373954', '1', 'admin', '登录', '46', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-11 17:52:32');
INSERT INTO `sys_log` VALUES ('1116281804639297537', '1', 'admin', '登录', '9', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-11 18:08:16');
INSERT INTO `sys_log` VALUES ('1116281855121940481', '1', 'admin', '修改文章表', '93', 'POST /cms/event/update', '{\"id\":[\"14\"],\"title\":[\"123\"],\"content\":[\"1231\"],\"linkto\":[\"www.baidu.com\"],\"thumbnail\":[\"\"],\"starttime\":[\"2019-04-10 18:13:11\"],\"endtime\":[\"2019-04-10 18:13:13\"],\"price\":[\"$123\"],\"address\":[\"你家\"],\"metakeywords\":[\"\"],\"metadescription\":[\"\"],\"type\":[\"2\"]}', '127.0.0.1', '2019-04-11 18:08:28');
INSERT INTO `sys_log` VALUES ('1116283250013233153', '1', 'admin', '修改文章表', '36', 'POST /cms/event/update', '{\"id\":[\"13\"],\"title\":[\"123\"],\"content\":[\"1231\"],\"linkto\":[\"www.baidu.com\"],\"thumbnail\":[\"\"],\"starttime\":[\"2019-04-10 18:13:11\"],\"endtime\":[\"2019-04-10 18:13:13\"],\"price\":[\"$123\"],\"address\":[\"你家\"],\"metakeywords\":[\"\"],\"metadescription\":[\"\"],\"type\":[\"3\"]}', '127.0.0.1', '2019-04-11 18:14:01');
INSERT INTO `sys_log` VALUES ('1116283344766754818', '1', 'admin', '删除文章表', '36', 'POST /cms/event/remove', '{\"id\":[\"11\"]}', '127.0.0.1', '2019-04-11 18:14:24');
INSERT INTO `sys_log` VALUES ('1116285961655934978', '1', 'admin', '登录', '5', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-11 18:24:48');
INSERT INTO `sys_log` VALUES ('1116286732220862465', '1', 'admin', '登录', '47', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-11 18:27:51');
INSERT INTO `sys_log` VALUES ('1116287099058884609', '1', 'admin', '登录', '46', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-11 18:29:19');
INSERT INTO `sys_log` VALUES ('1116288858703556610', '1', 'admin', '登录', '46', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-11 18:36:18');
INSERT INTO `sys_log` VALUES ('1116289068624310273', '1', 'admin', '登录', '46', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-11 18:37:08');
INSERT INTO `sys_log` VALUES ('1116289874601734145', '1', 'admin', '登录', '48', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-11 18:40:20');
INSERT INTO `sys_log` VALUES ('1116290387707707393', '1', 'admin', '登录', '33796', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-11 18:42:23');
INSERT INTO `sys_log` VALUES ('1116290757385281537', '1', 'admin', '登录', '2891', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-11 18:43:51');
INSERT INTO `sys_log` VALUES ('1116292000375660545', '1', 'admin', '添加文章表', '83', 'POST /cms/article/save', '{\"title\":[\"1231fsv etget\"],\"summary\":[\"sdfaswhfwonefpowshv9sbnfwjefpo\"],\"createTime\":[\"2019-04-11 18:48:22\"],\"author\":[\"Aron\"],\"style\":[\"4\"],\"content\":[\"<p>Balala...fwsfrv年房屋评估费那我给福建南王府我基恩非叫我呢发票我回复我发我而飞机我负责哦我为你服务佛无法就饿哦我佛我我飞机而欧文服务费吴海峰</p>\"],\"metaTitle\":[\"驱动器无\"],\"metaKeywords\":[\"  抢我的群无多\"],\"metaDescription\":[\"琴晚琴晚\"]}', '127.0.0.1', '2019-04-11 18:48:47');
INSERT INTO `sys_log` VALUES ('1116294381280804866', '1', 'admin', '登录', '47', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-11 18:58:15');
INSERT INTO `sys_log` VALUES ('1116294611392905217', '1', 'admin', '添加文章表', '61', 'POST /cms/article/save', '{\"title\":[\"1231fsv etget\"],\"summary\":[\"\"],\"createTime\":[\"2019-04-10 18:58:34\"],\"author\":[\"dahao\"],\"style\":[\"4\"],\"content\":[\"<p><b><i>Balala...fwsfrv年房屋评估费那我给福建南王府我基恩非叫我呢发票我回复我发我而飞机我负责哦我为你服务佛无法就饿哦我佛我我飞机而欧文服务费吴海峰sv</i></b></p><p><b><u>vsvsv</u></b></p><p><b><u><br></u></b></p><ol><li><b><u>svasv</u></b></li><li><b><u>svsav</u></b></li><li><b><u>wvwav</u></b></li></ol>\"],\"metaTitle\":[\"qfwfw \"],\"metaKeywords\":[\"  抢我的群无多\"],\"metaDescription\":[\"12e12\"]}', '127.0.0.1', '2019-04-11 18:59:10');
INSERT INTO `sys_log` VALUES ('1116294869380349953', '1', 'admin', '添加文章表', '70', 'POST /cms/article/save', '{\"title\":[\"1231fsv etget\"],\"summary\":[\"\"],\"createTime\":[\"Wed Apr 10 18:58:34 CST 2019\"],\"author\":[\"adadasdad\"],\"style\":[\"4\"],\"content\":[\"<p><b><i>Balala...fwsfrv年房屋评估费那我给福建南王府我基恩非叫我呢发票我回复我发我而飞机我负责哦我为你服务佛无法就饿哦我佛我我飞机而欧文服务费吴海峰sv</i></b></p><p><b><u>vsvsv</u></b></p><p><b><u><br></u></b></p><ol><li><b><u>svasv</u></b></li><li><b><u>svsav</u></b></li><li><b><u>wvwav</u></b></li></ol>\"],\"metaTitle\":[\"qfwfw \"],\"metaKeywords\":[\"  抢我的群无多\"],\"metaDescription\":[\"\"]}', '127.0.0.1', '2019-04-11 19:00:11');
INSERT INTO `sys_log` VALUES ('1116295292380102657', '1', 'admin', '添加文章表', '45', 'POST /cms/article/save', '{\"id\":[\"7\"],\"title\":[\"1231fsv etget\"],\"summary\":[\"\"],\"createTime\":[\"2019-04-02 19:01:32\"],\"author\":[\" d fvsvv\"],\"style\":[\"4\"],\"content\":[\"<p><b><i>Balala...fwsfrv年房屋评估费那我给福建南王府我基恩非叫我呢发票我回复我发我而飞机我负责哦我为你服务佛无法就饿哦我佛我我飞机而欧文服务费吴海峰sv</i></b></p><p><b><u>vsvsv</u></b></p><p><b><u><br></u></b></p><ol><li><b><u>svasv</u></b></li><li><b><u>svsav</u></b></li><li><b><u>wvwav</u></b></li></ol>\"],\"metaTitle\":[\"qfwfw \"],\"metaKeywords\":[\"  抢我的群无多\"],\"metaDescription\":[\"\"]}', '127.0.0.1', '2019-04-11 19:01:52');
INSERT INTO `sys_log` VALUES ('1116295370603872258', '1', 'admin', '删除文章表', '74', 'POST /cms/article/remove', '{\"id\":[\"8\"]}', '127.0.0.1', '2019-04-11 19:02:11');
INSERT INTO `sys_log` VALUES ('1116295402262478849', '1', 'admin', '添加文章表', '123', 'POST /cms/article/save', '{\"id\":[\"7\"],\"title\":[\"1231fsv etget\"],\"summary\":[\"\"],\"createTime\":[\"\"],\"author\":[\"adadasdad\"],\"style\":[\"4\"],\"content\":[\"<p><b><i>Balala...fwsfrv年房屋评估费那我给福建南王府我基恩非叫我呢发票我回复我发我而飞机我负责哦我为你服务佛无法就饿哦我佛我我飞机而欧文服务费吴海峰sv</i></b></p><p><b><u>vsvsv</u></b></p><p><b><u><br></u></b></p><ol><li><b><u>svasv</u></b></li><li><b><u>svsav</u></b></li><li><b><u>wvwav</u></b></li></ol>\"],\"metaTitle\":[\"qfwfw \"],\"metaKeywords\":[\"  抢我的群无多\"],\"metaDescription\":[\"\"]}', '127.0.0.1', '2019-04-11 19:02:18');
INSERT INTO `sys_log` VALUES ('1116511869675302914', '1', 'admin', '登录', '71', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-12 09:22:28');
INSERT INTO `sys_log` VALUES ('1116515364801409026', '1', 'admin', '登录', '7', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-12 09:36:21');
INSERT INTO `sys_log` VALUES ('1116518967930843138', '1', 'admin', '登录', '4', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-12 09:50:41');
INSERT INTO `sys_log` VALUES ('1116548772894097409', '1', 'admin', '登录', '24', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-12 11:49:07');
INSERT INTO `sys_log` VALUES ('1116550294541479938', '1', 'admin', '登录', '45', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-12 11:55:09');
INSERT INTO `sys_log` VALUES ('1116550331241639938', '1', 'admin', '删除文章表', '90', 'POST /cms/article/remove', '{\"id\":[\"9\"]}', '127.0.0.1', '2019-04-12 11:55:18');
INSERT INTO `sys_log` VALUES ('1116550338548117505', '1', 'admin', '删除文章表', '90', 'POST /cms/article/remove', '{\"id\":[\"7\"]}', '127.0.0.1', '2019-04-12 11:55:20');
INSERT INTO `sys_log` VALUES ('1116550349461696514', '1', 'admin', '批量删除文章表', '30', 'POST /cms/article/batchRemove', '{\"ids[]\":[\"6\",\"5\",\"4\",\"3\",\"2\"]}', '127.0.0.1', '2019-04-12 11:55:22');
INSERT INTO `sys_log` VALUES ('1116551160535224322', '1', 'admin', '登录', '45', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-12 11:58:36');
INSERT INTO `sys_log` VALUES ('1116551310791970817', '1', 'admin', '添加文章表', '54', 'POST /cms/article/save', '{\"title\":[\"视觉中国开盘封死跌停 创始人身家瞬间缩水1.3亿\"],\"summary\":[\"4月12日早盘，视觉中国开盘无悬念跌停，封单近41万手，报25.20元/股，一夜间总市值从196亿元缩水至176.5亿元，市值蒸发19.6亿元。\"],\"author\":[\"北京青年报\"],\"style\":[\"4\"],\"content\":[\"<p>原标题：视觉中国开盘封死跌停 柴继军身价瞬间缩水1.3亿</p><p>　　4月12日早盘，视觉中国开盘无悬念跌停，封单近41万手，报25.20元/股，一夜间总市值从196亿元缩水至176.5亿元，市值蒸发19.6亿元。</p><p>　　早些时候，视觉中国发公告称，天津市互联网信息办公室依法约谈其网站负责人，责令公司网站全面彻底整改并在此期间暂时关闭网站。</p><p>　　4月11日，因“人类首张黑洞照片”版权标注问题，A股上市公司视觉中国陷入舆论风暴。网友和机构随即发现，国旗国徽也被视觉中国打了版权售卖。国徽图片页面“价格提示”显示，“用于内文不低于150元，整版跨页不低于500元，杂志封面不低于1000元，商业使用价格另议。”虽然连续发声明解释、道歉，但是网友并不买账，直至该公司关闭网站。</p><p>　　根据计划，视觉中国4月12日有3.88亿股限售股上市流通，占公司总股本比例的55.39%。此次解禁是五年前视觉中国借壳远东股份所定向增发的股份，当时定增发行价为5.28元/股，五年期间未实施过股份送转。</p>\"],\"metaTitle\":[\"你好\"],\"metaKeywords\":[\"我好\"],\"metaDescription\":[\"大家好\"],\"createUserName\":[\"\"]}', '127.0.0.1', '2019-04-12 11:59:12');
INSERT INTO `sys_log` VALUES ('1116559495594541057', '1', 'admin', '登录', '44', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-12 12:31:43');
INSERT INTO `sys_log` VALUES ('1116566971220021250', '1', 'admin', '登录', '46', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-12 13:01:25');
INSERT INTO `sys_log` VALUES ('1116567116825284609', '1', 'admin', '添加文章表', '11613', 'POST /cms/article/save', '{\"title\":[\"1231fsv etget\"],\"summary\":[\"123123\"],\"author\":[\"1231\"],\"style\":[\"4\"],\"social[0][type]\":[\"Fackbook\"],\"social[0][url]\":[\"1\"],\"social[0][order]\":[\"1\"],\"social[1][type]\":[\"\"],\"social[1][url]\":[\"\"],\"social[1][order]\":[\"\"],\"social[2][type]\":[\"\"],\"social[2][url]\":[\"\"],\"social[2][order]\":[\"\"],\"social[3][type]\":[\"\"],\"social[3][url]\":[\"\"],\"social[3][order]\":[\"\"],\"social[4][type]\":[\"\"],\"social[4][url]\":[\"\"],\"social[4][order]\":[\"\"],\"content\":[\"<p>Balala...</p>\"],\"metaTitle\":[\"\"],\"metaKeywords\":[\"\"],\"metaDescription\":[\"\"],\"createUserName\":[\"\"]}', '127.0.0.1', '2019-04-12 13:02:00');
INSERT INTO `sys_log` VALUES ('1116568358402162690', '1', 'admin', '登录', '46', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-12 13:06:56');
INSERT INTO `sys_log` VALUES ('1116568597217443842', '1', 'admin', '添加文章表', '23705', 'POST /cms/article/save', '{\"title\":[\"swfwsfasf\"],\"summary\":[\"dsvgffwef\"],\"author\":[\"ad\"],\"style\":[\"4\"],\"social[0][type]\":[\"Fackbook\"],\"social[0][url]\":[\"adaadad\"],\"social[0][order]\":[\"1\"],\"social[1][type]\":[\"Linkedin\"],\"social[1][url]\":[\"svaasvasv\"],\"social[1][order]\":[\"sav\"],\"social[2][type]\":[\"Twitter\"],\"social[2][url]\":[\"12eedwqfwf\"],\"social[2][order]\":[\"\"],\"social[3][type]\":[\"\"],\"social[3][url]\":[\"\"],\"social[3][order]\":[\"\"],\"social[4][type]\":[\"\"],\"social[4][url]\":[\"\"],\"social[4][order]\":[\"\"],\"content\":[\"<p>Balala...acvasasfc</p>\"],\"metaTitle\":[\"\"],\"metaKeywords\":[\"\"],\"metaDescription\":[\"\"],\"createUserName\":[\"\"]}', '127.0.0.1', '2019-04-12 13:07:53');
INSERT INTO `sys_log` VALUES ('1116569732556816386', '1', 'admin', '更新菜单', '141', 'POST /sys/menu/update', '{\"parentId\":[\"1115179024377745410\"],\"id\":[\"1115184208369717251\"],\"type\":[\"1\"],\"name\":[\"文章内容管理\"],\"url\":[\"/cms/article\"],\"perms\":[\"\"],\"orderNum\":[\"1\"],\"icon\":[\"fa fa-file-code-o\"]}', '127.0.0.1', '2019-04-12 13:12:24');
INSERT INTO `sys_log` VALUES ('1116569763926016001', '1', 'admin', '更新菜单', '50', 'POST /sys/menu/update', '{\"parentId\":[\"1115179024377745410\"],\"id\":[\"1115184208369717263\"],\"type\":[\"1\"],\"name\":[\"活动内容管理\"],\"url\":[\"/cms/event\"],\"perms\":[\"\"],\"orderNum\":[\"2\"],\"icon\":[\"fa fa-file-code-o\"]}', '127.0.0.1', '2019-04-12 13:12:31');
INSERT INTO `sys_log` VALUES ('1116569810776391682', '1', 'admin', '更新菜单', '85', 'POST /sys/menu/update', '{\"parentId\":[\"1115183012166799361\"],\"id\":[\"1115184208369717275\"],\"type\":[\"1\"],\"name\":[\"导航管理\"],\"url\":[\"/cms/nav\"],\"perms\":[\"\"],\"orderNum\":[\"1\"],\"icon\":[\"fa fa-file-code-o\"]}', '127.0.0.1', '2019-04-12 13:12:42');
INSERT INTO `sys_log` VALUES ('1116569893454512129', '1', 'admin', '更新菜单', '68', 'POST /sys/menu/update', '{\"parentId\":[\"1115183012166799361\"],\"id\":[\"1115183444654067714\"],\"type\":[\"1\"],\"name\":[\"首页管理\"],\"url\":[\"\"],\"perms\":[\"\"],\"orderNum\":[\"2\"],\"icon\":[\"\"]}', '127.0.0.1', '2019-04-12 13:13:02');
INSERT INTO `sys_log` VALUES ('1116569925381554177', '1', 'admin', '更新菜单', '61', 'POST /sys/menu/update', '{\"parentId\":[\"1115183012166799361\"],\"id\":[\"1115184160676286466\"],\"type\":[\"1\"],\"name\":[\"消息管理\"],\"url\":[\"\"],\"perms\":[\"\"],\"orderNum\":[\"3\"],\"icon\":[\"\"]}', '127.0.0.1', '2019-04-12 13:13:10');
INSERT INTO `sys_log` VALUES ('1116569968113123329', '1', 'admin', '更新菜单', '45', 'POST /sys/menu/update', '{\"parentId\":[\"1115183012166799361\"],\"id\":[\"1115184208369717250\"],\"type\":[\"1\"],\"name\":[\"媒体管理\"],\"url\":[\"\"],\"perms\":[\"\"],\"orderNum\":[\"4\"],\"icon\":[\"\"]}', '127.0.0.1', '2019-04-12 13:13:20');
INSERT INTO `sys_log` VALUES ('1116595667150602241', '1', 'admin', '登录', '12', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-12 14:55:27');
INSERT INTO `sys_log` VALUES ('1116603066250985474', '1', 'admin', '添加文章表', '31', 'POST /cms/article/save', '{\"title\":[\"13\"],\"summary\":[\"123\"],\"author\":[\"123\"],\"style\":[\"4\"],\"social[0][type]\":[\"\"],\"social[0][url]\":[\"\"],\"social[0][order]\":[\"\"],\"social[1][type]\":[\"\"],\"social[1][url]\":[\"\"],\"social[1][order]\":[\"\"],\"social[2][type]\":[\"\"],\"social[2][url]\":[\"\"],\"social[2][order]\":[\"\"],\"social[3][type]\":[\"\"],\"social[3][url]\":[\"\"],\"social[3][order]\":[\"\"],\"social[4][type]\":[\"\"],\"social[4][url]\":[\"\"],\"social[4][order]\":[\"\"],\"tag[0]\":[\"\"],\"tag[1]\":[\"\"],\"tag[2]\":[\"\"],\"content\":[\"<p>Balala...</p><p><br></p><p><img alt=\\\"Image\\\" src=\\\"https://n.sinaimg.cn/news/crawl/726/w550h976/20190412/OfKe-hvntnkq9510568.jpg\\\" data-image-size=\\\"550,976\\\"><br></p><p>afafasfasdf</p><p><br></p><p>sdfsd</p><p>sdfsds</p>\"],\"metaTitle\":[\"\"],\"metaKeywords\":[\"\"],\"metaDescription\":[\"\"],\"createUserName\":[\"\"]}', '127.0.0.1', '2019-04-12 15:24:51');
INSERT INTO `sys_log` VALUES ('1116603310623719426', '1', 'admin', '添加文章表', '53', 'POST /cms/article/save', '{\"id\":[\"13\"],\"title\":[\"13\"],\"summary\":[\"\"],\"createTime\":[\"Fri Apr 12 15:24:51 CST 2019\"],\"author\":[\"123\"],\"style\":[\"4\"],\"content\":[\"<p data-indent=\\\"1\\\">Balala...</p><p><br></p><p data-indent=\\\"3\\\"><img alt=\\\"Image\\\" src=\\\"https://n.sinaimg.cn/news/crawl/726/w550h976/20190412/OfKe-hvntnkq9510568.jpg\\\"><br></p><p>afafasfasdf</p><p><br></p><p>sdfsd</p><p>sdfsds</p>\"],\"metaTitle\":[\"\"],\"metaKeywords\":[\"\"],\"metaDescription\":[\"\"],\"createUserName\":[\"\"]}', '127.0.0.1', '2019-04-12 15:25:49');
INSERT INTO `sys_log` VALUES ('1116603543487283202', '1', 'admin', '添加文章表', '32', 'POST /cms/article/save', '{\"title\":[\"asfsaf\"],\"summary\":[\"savasdv\"],\"author\":[\"svasv\"],\"style\":[\"4\"],\"social[0][type]\":[\"\"],\"social[0][url]\":[\"\"],\"social[0][order]\":[\"\"],\"social[1][type]\":[\"\"],\"social[1][url]\":[\"\"],\"social[1][order]\":[\"\"],\"social[2][type]\":[\"\"],\"social[2][url]\":[\"\"],\"social[2][order]\":[\"\"],\"social[3][type]\":[\"\"],\"social[3][url]\":[\"\"],\"social[3][order]\":[\"\"],\"social[4][type]\":[\"\"],\"social[4][url]\":[\"\"],\"social[4][order]\":[\"\"],\"tag[0]\":[\"\"],\"tag[1]\":[\"\"],\"tag[2]\":[\"\"],\"content\":[\"<p data-indent=\\\"10\\\">Balala...</p><p data-indent=\\\"10\\\">svsvasv</p><p data-indent=\\\"8\\\">svasvasvasv</p><p data-indent=\\\"8\\\">svasvasv</p>\"],\"metaTitle\":[\"\"],\"metaKeywords\":[\"\"],\"metaDescription\":[\"\"],\"createUserName\":[\"\"]}', '127.0.0.1', '2019-04-12 15:26:45');
INSERT INTO `sys_log` VALUES ('1116603951001665537', '1', 'admin', '添加文章表', '50', 'POST /cms/article/save', '{\"title\":[\"12313\"],\"summary\":[\"1313\"],\"author\":[\"13123\"],\"style\":[\"4\"],\"social[0][type]\":[\"\"],\"social[0][url]\":[\"\"],\"social[0][order]\":[\"\"],\"social[1][type]\":[\"\"],\"social[1][url]\":[\"\"],\"social[1][order]\":[\"\"],\"social[2][type]\":[\"\"],\"social[2][url]\":[\"\"],\"social[2][order]\":[\"\"],\"social[3][type]\":[\"\"],\"social[3][url]\":[\"\"],\"social[3][order]\":[\"\"],\"social[4][type]\":[\"\"],\"social[4][url]\":[\"\"],\"social[4][order]\":[\"\"],\"tag[0]\":[\"\"],\"tag[1]\":[\"\"],\"tag[2]\":[\"\"],\"content\":[\"<p data-indent=\\\"0\\\">Balala... 12123e123</p><p data-indent=\\\"0\\\">131231312313</p><p data-indent=\\\"4\\\">13123123</p>\"],\"metaTitle\":[\"\"],\"metaKeywords\":[\"\"],\"metaDescription\":[\"\"],\"createUserName\":[\"\"]}', '127.0.0.1', '2019-04-12 15:28:22');
INSERT INTO `sys_log` VALUES ('1116605301412442113', '1', 'admin', '登录', '47', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-12 15:33:44');
INSERT INTO `sys_log` VALUES ('1116606739605626881', '1', 'admin', '登录', '49', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-12 15:39:27');
INSERT INTO `sys_log` VALUES ('1116611144853757954', '1', 'admin', '添加文章表', '53', 'POST /cms/article/save', '{\"title\":[\"123\"],\"summary\":[\"123\"],\"author\":[\"123\"],\"style\":[\"4\"],\"social[0][type]\":[\"\"],\"social[0][url]\":[\"\"],\"social[0][order]\":[\"\"],\"social[1][type]\":[\"\"],\"social[1][url]\":[\"\"],\"social[1][order]\":[\"\"],\"social[2][type]\":[\"\"],\"social[2][url]\":[\"\"],\"social[2][order]\":[\"\"],\"social[3][type]\":[\"\"],\"social[3][url]\":[\"\"],\"social[3][order]\":[\"\"],\"social[4][type]\":[\"\"],\"social[4][url]\":[\"\"],\"social[4][order]\":[\"\"],\"tag[0]\":[\"\"],\"tag[1]\":[\"\"],\"tag[2]\":[\"\"],\"content\":[\"<p style=\\\"text-align: center;\\\">Balala...</p><p style=\\\"text-align: center;\\\">sfasfasfoajhfoewnfpowufe hwjefnwoehfauwehfwo;efjowihfwjebnfwefhj</p><p style=\\\"text-align: center;\\\">wnefojwhnefowefjwbfeowehfwjebfwoefhewjfn</p>\"],\"metaTitle\":[\"\"],\"metaKeywords\":[\"\"],\"metaDescription\":[\"\"],\"createUserName\":[\"\"]}', '127.0.0.1', '2019-04-12 15:56:57');
INSERT INTO `sys_log` VALUES ('1116614261171298306', '1', 'admin', '根据数据表生成代码', '238', 'GET /common/generator/code/tag', '{}', '127.0.0.1', '2019-04-12 16:09:20');
INSERT INTO `sys_log` VALUES ('1116615265690329089', '1', 'admin', '更新角色', '179', 'POST /sys/role/update', '{\"id\":[\"1\"],\"menuIds\":[\"193,194,195,196,197,79,80,81,83,176,177,178,179,180,207,208,209,210,211,20,21,22,61,12,13,14,24,25,26,15,55,56,62,74,75,76,48,72,28,29,30,57,92,1115184208369717252,1115184208369717253,1115184208369717254,1115184208369717255,1115184208369717256,1115184208369717264,1115184208369717265,1115184208369717266,1115184208369717267,1115184208369717268,1115184208369717258,1115184208369717259,1115184208369717260,1115184208369717261,1115184208369717262,1115184208369717270,1115184208369717271,1115184208369717272,1115184208369717273,1115184208369717274,1115183444654067714,1115184160676286466,1115184208369717250,1115184208369717276,1115184208369717277,1115184208369717278,1115184208369717279,1115184208369717280,1115184208369717282,1115184208369717283,1115184208369717284,1115184208369717285,1115184208369717286,1115183213711495170,1115183247500808194,71,78,175,206,1,2,6,7,73,3,77,27,91,1115184208369717251,1115184208369717263,1115179024377745410,1115184208369717257,1115184208369717269,1115182776430137345,1115184208369717281,1115184208369717275,1115183127149449218,1115184208369717287,1115184208369717288,1115184208369717289,1115184208369717290,1115184208369717291,1115184208369717292,1115183012166799361,-1\"],\"roleName\":[\"??????\"],\"remark\":[\"?????\"]}', '127.0.0.1', '2019-04-12 16:13:20');
INSERT INTO `sys_log` VALUES ('1116623088008687617', '1', 'admin', '登录', '47', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-12 16:44:25');
INSERT INTO `sys_log` VALUES ('1116623107776442369', '1', 'admin', '根据数据表生成代码', '121', 'GET /common/generator/code/article_tag', '{}', '127.0.0.1', '2019-04-12 16:44:29');
INSERT INTO `sys_log` VALUES ('1116625019456192514', '1', 'admin', '登录', '45', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-12 16:52:05');
INSERT INTO `sys_log` VALUES ('1116625377301635073', '1', 'admin', '登录', '46', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-12 16:53:30');
INSERT INTO `sys_log` VALUES ('1116635441060122625', '1', 'admin', '登录', '48', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-12 17:33:30');
INSERT INTO `sys_log` VALUES ('1116635948868808706', '1', 'admin', '登录', '48', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-12 17:35:31');
INSERT INTO `sys_log` VALUES ('1116646760735944706', '1', 'admin', '登录', '10', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-12 18:18:29');
INSERT INTO `sys_log` VALUES ('1116647347791593474', '1', 'admin', '登录', '45', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-12 18:20:49');
INSERT INTO `sys_log` VALUES ('1116649102747107330', '1', 'admin', '登录', '45', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-12 18:27:47');
INSERT INTO `sys_log` VALUES ('1116649837866049537', '1', 'admin', '登录', '48', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-12 18:30:42');
INSERT INTO `sys_log` VALUES ('1116651443516923906', '1', 'admin', '登录', '47', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-12 18:37:05');
INSERT INTO `sys_log` VALUES ('1117058903083954178', '1', 'admin', '??', '61', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-13 21:36:11');
INSERT INTO `sys_log` VALUES ('1117059580443078658', '1', 'admin', '?????', '235', 'POST /cms/article/update', '{\"id\":[\"17\"],\"title\":[\"123\"],\"summary\":[\"123\"],\"author\":[\"123\"],\"style\":[\"4\"],\"social[0][type]\":[\"Linkedin\"],\"social[0][url]\":[\"http://www.baidu.com\"],\"social[0][order]\":[\"1\"],\"social[1][type]\":[\"\"],\"social[1][url]\":[\"\"],\"social[1][order]\":[\"\"],\"social[2][type]\":[\"\"],\"social[2][url]\":[\"\"],\"social[2][order]\":[\"\"],\"social[3][type]\":[\"\"],\"social[3][url]\":[\"\"],\"social[3][order]\":[\"\"],\"social[4][type]\":[\"\"],\"social[4][url]\":[\"\"],\"social[4][order]\":[\"\"],\"tag[0]\":[\"123\"],\"tag[1]\":[\"\"],\"tag[2]\":[\"\"],\"content\":[\"<p style=\\\"text-align: center;\\\">Balala...</p><p style=\\\"text-align: center;\\\">sfasfasfoajhfoewnfpowufe hwjefnwoehfauwehfwo;efjowihfwjebnfwefhj</p><p style=\\\"text-align: center;\\\">wnefojwhnefowefjwbfeowehfwjebfwoefhewjfn</p>\"],\"metaTitle\":[\"\"],\"metaKeywords\":[\"\"],\"metaDescription\":[\"\"]}', '127.0.0.1', '2019-04-13 21:38:53');
INSERT INTO `sys_log` VALUES ('1117059873532653569', '1', 'admin', '?????', '283', 'POST /cms/article/update', '{\"id\":[\"10\"],\"title\":[\"?????????? ?????????1.3?\"],\"summary\":[\"4?12???????????????????41????25.20?/?????????196?????176.5???????19.6???\"],\"author\":[\"?????\"],\"style\":[\"4\"],\"social[0][type]\":[\"Fackbook\"],\"social[0][url]\":[\"http://www.baidu.com\"],\"social[0][order]\":[\"0\"],\"social[1][type]\":[\"\"],\"social[1][url]\":[\"\"],\"social[1][order]\":[\"\"],\"social[2][type]\":[\"\"],\"social[2][url]\":[\"\"],\"social[2][order]\":[\"\"],\"social[3][type]\":[\"\"],\"social[3][url]\":[\"\"],\"social[3][order]\":[\"\"],\"social[4][type]\":[\"\"],\"social[4][url]\":[\"\"],\"social[4][order]\":[\"\"],\"tag[0]\":[\"12313\"],\"tag[1]\":[\"123\"],\"tag[2]\":[\"\"],\"content\":[\"<p>?????????????? ?????????1.3?</p><p>??4?12???????????????????41????25.20?/?????????196?????176.5???????19.6???</p><p>??????????????????????????????????????????????????????????????</p><p>??4?11???“????????”???????A?????????????????????????????????????????????????“????”???“???????150?????????500?????????1000???????????”????????????????????????????????</p><p>???????????4?12??3.88???????????????????55.39%????????????????????????????????????5.28?/???????????????</p>\"],\"metaTitle\":[\"??\"],\"metaKeywords\":[\"??\"],\"metaDescription\":[\"???\"]}', '127.0.0.1', '2019-04-13 21:40:02');
INSERT INTO `sys_log` VALUES ('1117076181204709378', '1', 'admin', '??', '21', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-13 22:44:51');
INSERT INTO `sys_log` VALUES ('1117076442518237185', '1', 'admin', '?????', '43298', 'POST /cms/article/update', '{\"id\":[\"10\"],\"title\":[\"????\"],\"summary\":[\"????\"],\"author\":[\"????\"],\"style\":[\"4\"],\"social[0][type]\":[\"Fackbook\"],\"social[0][url]\":[\"http://www.baidu.com\"],\"social[0][order]\":[\"0\"],\"social[1][type]\":[\"\"],\"social[1][url]\":[\"\"],\"social[1][order]\":[\"\"],\"social[2][type]\":[\"\"],\"social[2][url]\":[\"\"],\"social[2][order]\":[\"\"],\"social[3][type]\":[\"\"],\"social[3][url]\":[\"\"],\"social[3][order]\":[\"\"],\"social[4][type]\":[\"\"],\"social[4][url]\":[\"\"],\"social[4][order]\":[\"\"],\"tag[0]\":[\"123\"],\"tag[1]\":[\"\"],\"tag[2]\":[\"12313\"],\"content\":[\"<p>?????????????? ?????????1.3?</p><p>??4?12???????????????????41????25.20?/?????????196?????176.5???????19.6???</p><p>??????????????????????????????????????????????????????????????</p><p>??4?11???“????????”???????A?????????????????????????????????????????????????“????”???“???????150?????????500?????????1000???????????”????????????????????????????????</p><p>???????????4?12??3.88???????????????????55.39%????????????????????????????????????5.28?/???????????????</p>\"],\"metaTitle\":[\"??\"],\"metaKeywords\":[\"??\"],\"metaDescription\":[\"???\"]}', '127.0.0.1', '2019-04-13 22:45:53');
INSERT INTO `sys_log` VALUES ('1117079494272802817', '1', 'admin', '登录', '62', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-13 22:58:00');
INSERT INTO `sys_log` VALUES ('1117079641274769409', '1', 'admin', '修改文章表', '6766', 'POST /cms/article/update', '{\"id\":[\"10\"],\"title\":[\"视觉中国开盘封死跌停 创始人身家瞬间缩水1.3亿\"],\"summary\":[\"4月12日早盘，视觉中国开盘无悬念跌停，封单近41万手，报25.20元/股，一夜间总市值从196亿元缩水至176.5亿元，市值蒸发19.6亿元。\"],\"author\":[\"北京青年报\"],\"style\":[\"4\"],\"social[0][type]\":[\"Fackbook\"],\"social[0][url]\":[\"http://www.baidu.com\"],\"social[0][order]\":[\"\"],\"social[1][type]\":[\"\"],\"social[1][url]\":[\"\"],\"social[1][order]\":[\"\"],\"social[2][type]\":[\"\"],\"social[2][url]\":[\"\"],\"social[2][order]\":[\"\"],\"social[3][type]\":[\"\"],\"social[3][url]\":[\"\"],\"social[3][order]\":[\"\"],\"social[4][type]\":[\"\"],\"social[4][url]\":[\"\"],\"social[4][order]\":[\"\"],\"tag[0]\":[\"123\"],\"tag[1]\":[\"\"],\"tag[2]\":[\"12313\"],\"content\":[\"<p>原标题：视觉中国开盘封死跌停 柴继军身价瞬间缩水1.3亿</p><p>　　4月12日早盘，视觉中国开盘无悬念跌停，封单近41万手，报25.20元/股，一夜间总市值从196亿元缩水至176.5亿元，市值蒸发19.6亿元。</p><p>　　早些时候，视觉中国发公告称，天津市互联网信息办公室依法约谈其网站负责人，责令公司网站全面彻底整改并在此期间暂时关闭网站。</p><p>　　4月11日，因“人类首张黑洞照片”版权标注问题，A股上市公司视觉中国陷入舆论风暴。网友和机构随即发现，国旗国徽也被视觉中国打了版权售卖。国徽图片页面“价格提示”显示，“用于内文不低于150元，整版跨页不低于500元，杂志封面不低于1000元，商业使用价格另议。”虽然连续发声明解释、道歉，但是网友并不买账，直至该公司关闭网站。</p><p>　　根据计划，视觉中国4月12日有3.88亿股限售股上市流通，占公司总股本比例的55.39%。此次解禁是五年前视觉中国借壳远东股份所定向增发的股份，当时定增发行价为5.28元/股，五年期间未实施过股份送转。</p>\"],\"metaTitle\":[\"你好\"],\"metaKeywords\":[\"我好\"],\"metaDescription\":[\"大家好\"]}', '127.0.0.1', '2019-04-13 22:58:35');
INSERT INTO `sys_log` VALUES ('1117095295663017985', '1', 'admin', '登录', '77', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-14 00:00:48');
INSERT INTO `sys_log` VALUES ('1117108257475850242', '1', 'admin', '登录', '58', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-14 00:52:18');
INSERT INTO `sys_log` VALUES ('1117113617146245122', '1', 'admin', '登录', '14', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-14 01:13:36');
INSERT INTO `sys_log` VALUES ('1117116920928190465', '1', 'admin', '登录', '55', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-14 01:26:44');
INSERT INTO `sys_log` VALUES ('1117117506062954498', '1', 'admin', '登录', '57', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-14 01:29:03');
INSERT INTO `sys_log` VALUES ('1117127072758657026', '1', 'admin', '登录', '58', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-14 02:07:04');
INSERT INTO `sys_log` VALUES ('1117127239247360002', '1', 'admin', '上传文件', '9679', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_0\"],\"name\":[\"about-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"34869\"]}', '127.0.0.1', '2019-04-14 02:07:44');
INSERT INTO `sys_log` VALUES ('1117127564083621890', '1', 'admin', '上传文件', '21539', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_1\"],\"name\":[\"contact-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"235068\"]}', '127.0.0.1', '2019-04-14 02:09:01');
INSERT INTO `sys_log` VALUES ('1117128742687240194', '1', 'admin', '上传文件', '5780', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_2\"],\"name\":[\"home-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"155751\"]}', '127.0.0.1', '2019-04-14 02:13:42');
INSERT INTO `sys_log` VALUES ('1117129033834852353', '1', 'admin', '上传文件', '34', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_0\"],\"name\":[\"about-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"34869\"]}', '127.0.0.1', '2019-04-14 02:14:52');
INSERT INTO `sys_log` VALUES ('1117129131742490626', '1', 'admin', '上传文件', '37', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_1\"],\"name\":[\"contact-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"235068\"]}', '127.0.0.1', '2019-04-14 02:15:15');
INSERT INTO `sys_log` VALUES ('1117129747277574146', '1', 'admin', '删除文件', '59', 'POST /common/sysFile/remove', '{\"id\":[\"1117127239134113794\"]}', '127.0.0.1', '2019-04-14 02:17:42');
INSERT INTO `sys_log` VALUES ('1117129850868494337', '1', 'admin', '删除文件', '29', 'POST /common/sysFile/remove', '{\"id\":[\"1117127563945209858\"]}', '127.0.0.1', '2019-04-14 02:18:06');
INSERT INTO `sys_log` VALUES ('1117130330516516866', '1', 'admin', '上传文件', '14162', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_2\"],\"name\":[\"home-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"155751\"]}', '127.0.0.1', '2019-04-14 02:20:01');
INSERT INTO `sys_log` VALUES ('1117131129476952065', '1', 'admin', '登录', '60', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-14 02:23:11');
INSERT INTO `sys_log` VALUES ('1117131547955245058', '1', 'admin', '登录', '25', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-14 02:24:51');
INSERT INTO `sys_log` VALUES ('1117131595556401153', '1', 'admin', '上传文件', '2406', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_0\"],\"name\":[\"home-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"155751\"]}', '127.0.0.1', '2019-04-14 02:25:02');
INSERT INTO `sys_log` VALUES ('1117131612849516545', '1', 'admin', '修改文章表', '135', 'POST /cms/article/update', '{\"id\":[\"10\"],\"title\":[\"视觉中国开盘封死跌停 创始人身家瞬间缩水1.3亿\"],\"summary\":[\"4月12日早盘，视觉中国开盘无悬念跌停，封单近41万手，报25.20元/股，一夜间总市值从196亿元缩水至176.5亿元，市值蒸发19.6亿元。\"],\"author\":[\"北京青年报\"],\"style\":[\"4\"],\"social[0][type]\":[\"Fackbook\"],\"social[0][url]\":[\"http://www.baidu.com\"],\"social[0][order]\":[\"\"],\"social[1][type]\":[\"\"],\"social[1][url]\":[\"\"],\"social[1][order]\":[\"\"],\"social[2][type]\":[\"\"],\"social[2][url]\":[\"\"],\"social[2][order]\":[\"\"],\"social[3][type]\":[\"\"],\"social[3][url]\":[\"\"],\"social[3][order]\":[\"\"],\"social[4][type]\":[\"\"],\"social[4][url]\":[\"\"],\"social[4][order]\":[\"\"],\"tag[0]\":[\"\"],\"tag[1]\":[\"\"],\"tag[2]\":[\"\"],\"content\":[\"<p>原标题：视觉中国开盘封死跌停 柴继军身价瞬间缩水1.3亿</p><p>　　4月12日早盘，视觉中国开盘无悬念跌停，封单近41万手，报25.20元/股，一夜间总市值从196亿元缩水至176.5亿元，市值蒸发19.6亿元。</p><p>　　早些时候，视觉中国发公告称，天津市互联网信息办公室依法约谈其网站负责人，责令公司网站全面彻底整改并在此期间暂时关闭网站。</p><p>　　4月11日，因“人类首张黑洞照片”版权标注问题，A股上市公司视觉中国陷入舆论风暴。网友和机构随即发现，国旗国徽也被视觉中国打了版权售卖。国徽图片页面“价格提示”显示，“用于内文不低于150元，整版跨页不低于500元，杂志封面不低于1000元，商业使用价格另议。”虽然连续发声明解释、道歉，但是网友并不买账，直至该公司关闭网站。</p><p>　　根据计划，视觉中国4月12日有3.88亿股限售股上市流通，占公司总股本比例的55.39%。此次解禁是五年前视觉中国借壳远东股份所定向增发的股份，当时定增发行价为5.28元/股，五年期间未实施过股份送转。</p>\"],\"metaTitle\":[\"你好\"],\"metaKeywords\":[\"我好\"],\"metaDescription\":[\"大家好\"]}', '127.0.0.1', '2019-04-14 02:25:06');
INSERT INTO `sys_log` VALUES ('1117132465811566594', '1', 'admin', '上传文件', '36', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_0\"],\"name\":[\"contact-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"235068\"]}', '127.0.0.1', '2019-04-14 02:28:30');
INSERT INTO `sys_log` VALUES ('1117133697745760257', '1', 'admin', '上传文件', '37', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_0\"],\"name\":[\"post-sample-image.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"122082\"]}', '127.0.0.1', '2019-04-14 02:33:24');
INSERT INTO `sys_log` VALUES ('1117134033780813826', '1', 'admin', '上传文件', '35', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_0\"],\"name\":[\"home-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"155751\"]}', '127.0.0.1', '2019-04-14 02:34:44');
INSERT INTO `sys_log` VALUES ('1117134174952697858', '1', 'admin', '上传文件', '50', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_0\"],\"name\":[\"home-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"155751\"]}', '127.0.0.1', '2019-04-14 02:35:17');
INSERT INTO `sys_log` VALUES ('1117134248772448258', '1', 'admin', '上传文件', '35', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_0\"],\"name\":[\"post-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"122546\"]}', '127.0.0.1', '2019-04-14 02:35:35');
INSERT INTO `sys_log` VALUES ('1117134404448235521', '1', 'admin', '上传文件', '47', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_0\"],\"name\":[\"about-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"34869\"]}', '127.0.0.1', '2019-04-14 02:36:12');
INSERT INTO `sys_log` VALUES ('1117134412258029569', '1', 'admin', '修改文章表', '32', 'POST /cms/article/update', '{\"id\":[\"10\"],\"title\":[\"视觉中国开盘封死跌停 创始人身家瞬间缩水1.3亿\"],\"summary\":[\"4月12日早盘，视觉中国开盘无悬念跌停，封单近41万手，报25.20元/股，一夜间总市值从196亿元缩水至176.5亿元，市值蒸发19.6亿元。\"],\"author\":[\"北京青年报\"],\"style\":[\"4\"],\"thumbnail\":[\"http://localhost:8088/upload/20190414\\\\8\\\\f\\\\about-bg.jpg\"],\"social[0][type]\":[\"Fackbook\"],\"social[0][url]\":[\"http://www.baidu.com\"],\"social[0][order]\":[\"\"],\"social[1][type]\":[\"\"],\"social[1][url]\":[\"\"],\"social[1][order]\":[\"\"],\"social[2][type]\":[\"\"],\"social[2][url]\":[\"\"],\"social[2][order]\":[\"\"],\"social[3][type]\":[\"\"],\"social[3][url]\":[\"\"],\"social[3][order]\":[\"\"],\"social[4][type]\":[\"\"],\"social[4][url]\":[\"\"],\"social[4][order]\":[\"\"],\"tag[0]\":[\"\"],\"tag[1]\":[\"\"],\"tag[2]\":[\"\"],\"content\":[\"<p>原标题：视觉中国开盘封死跌停 柴继军身价瞬间缩水1.3亿</p><p>　　4月12日早盘，视觉中国开盘无悬念跌停，封单近41万手，报25.20元/股，一夜间总市值从196亿元缩水至176.5亿元，市值蒸发19.6亿元。</p><p>　　早些时候，视觉中国发公告称，天津市互联网信息办公室依法约谈其网站负责人，责令公司网站全面彻底整改并在此期间暂时关闭网站。</p><p>　　4月11日，因“人类首张黑洞照片”版权标注问题，A股上市公司视觉中国陷入舆论风暴。网友和机构随即发现，国旗国徽也被视觉中国打了版权售卖。国徽图片页面“价格提示”显示，“用于内文不低于150元，整版跨页不低于500元，杂志封面不低于1000元，商业使用价格另议。”虽然连续发声明解释、道歉，但是网友并不买账，直至该公司关闭网站。</p><p>　　根据计划，视觉中国4月12日有3.88亿股限售股上市流通，占公司总股本比例的55.39%。此次解禁是五年前视觉中国借壳远东股份所定向增发的股份，当时定增发行价为5.28元/股，五年期间未实施过股份送转。</p>\"],\"metaTitle\":[\"你好\"],\"metaKeywords\":[\"我好\"],\"metaDescription\":[\"大家好\"]}', '127.0.0.1', '2019-04-14 02:36:14');
INSERT INTO `sys_log` VALUES ('1117136339360362497', '1', 'admin', '上传文件', '49', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_0\"],\"name\":[\"post-sample-image.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"122082\"]}', '127.0.0.1', '2019-04-14 02:43:53');
INSERT INTO `sys_log` VALUES ('1117136520755621889', '1', 'admin', '上传文件', '42', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_0\"],\"name\":[\"post-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"122546\"]}', '127.0.0.1', '2019-04-14 02:44:37');
INSERT INTO `sys_log` VALUES ('1117138606541058049', '1', 'admin', '上传文件', '43', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_0\"],\"name\":[\"home-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"155751\"]}', '127.0.0.1', '2019-04-14 02:52:54');
INSERT INTO `sys_log` VALUES ('1117138613008674818', '1', 'admin', '修改文章表', '48', 'POST /cms/event/update', '{\"id\":[\"14\"],\"title\":[\"123\"],\"content\":[\"1231\"],\"linkto\":[\"www.baidu.com\"],\"thumbnail\":[\"http://localhost:8088/upload/20190414\\\\6\\\\6\\\\home-bg.jpg\"],\"starttime\":[\"2019-04-10 18:13:11\"],\"endtime\":[\"2019-04-10 18:13:13\"],\"price\":[\"$123\"],\"address\":[\"你家\"],\"metakeywords\":[\"\"],\"metadescription\":[\"\"],\"type\":[\"2\"]}', '127.0.0.1', '2019-04-14 02:52:55');
INSERT INTO `sys_log` VALUES ('1117140791949561857', '1', 'admin', '登录', '57', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-14 03:01:35');
INSERT INTO `sys_log` VALUES ('1117284244331175937', '1', 'admin', '登录', '66', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-14 12:31:37');
INSERT INTO `sys_log` VALUES ('1117301898781659137', '1', 'admin', '登录', '108', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-14 13:41:46');
INSERT INTO `sys_log` VALUES ('1117309672483721217', '1', 'admin', '登录', '8', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-14 14:12:39');
INSERT INTO `sys_log` VALUES ('1117310141092438018', '1', 'admin', '登录', '63', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-14 14:14:31');
INSERT INTO `sys_log` VALUES ('1117311429863575553', '1', 'admin', '登录', '66', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-14 14:19:38');
INSERT INTO `sys_log` VALUES ('1117321642205286401', '1', 'admin', '登录', '8', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-14 15:00:13');
INSERT INTO `sys_log` VALUES ('1117323205921509378', '1', 'admin', '上传文件', '63', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_0\"],\"name\":[\"about-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"34869\"]}', '127.0.0.1', '2019-04-14 15:06:26');
INSERT INTO `sys_log` VALUES ('1117323206034755585', '1', 'admin', '上传文件', '68', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_1\"],\"name\":[\"contact-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"235068\"]}', '127.0.0.1', '2019-04-14 15:06:26');
INSERT INTO `sys_log` VALUES ('1117327609017966594', '1', 'admin', '登录', '65', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-14 15:23:56');
INSERT INTO `sys_log` VALUES ('1117327660473688066', '1', 'admin', '上传文件', '39', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_0\"],\"name\":[\"about-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"34869\"]}', '127.0.0.1', '2019-04-14 15:24:08');
INSERT INTO `sys_log` VALUES ('1117327660784066562', '1', 'admin', '上传文件', '55', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_1\"],\"name\":[\"contact-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"235068\"]}', '127.0.0.1', '2019-04-14 15:24:08');
INSERT INTO `sys_log` VALUES ('1117327660893118466', '1', 'admin', '上传文件', '34', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_2\"],\"name\":[\"home-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"155751\"]}', '127.0.0.1', '2019-04-14 15:24:08');
INSERT INTO `sys_log` VALUES ('1117327661341908994', '1', 'admin', '上传文件', '23', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_3\"],\"name\":[\"post-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"122546\"]}', '127.0.0.1', '2019-04-14 15:24:08');
INSERT INTO `sys_log` VALUES ('1117327661702619137', '1', 'admin', '上传文件', '76', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_4\"],\"name\":[\"post-sample-image.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"122082\"]}', '127.0.0.1', '2019-04-14 15:24:08');
INSERT INTO `sys_log` VALUES ('1117331535633096706', '1', 'admin', '上传文件', '29', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_1\"],\"name\":[\"about-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"34869\"]}', '127.0.0.1', '2019-04-14 15:39:32');
INSERT INTO `sys_log` VALUES ('1117331536023166977', '1', 'admin', '上传文件', '57', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_2\"],\"name\":[\"contact-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"235068\"]}', '127.0.0.1', '2019-04-14 15:39:32');
INSERT INTO `sys_log` VALUES ('1117331536295796738', '1', 'admin', '上传文件', '35', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_3\"],\"name\":[\"home-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"155751\"]}', '127.0.0.1', '2019-04-14 15:39:32');
INSERT INTO `sys_log` VALUES ('1117331536627146753', '1', 'admin', '上传文件', '26', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_4\"],\"name\":[\"post-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"122546\"]}', '127.0.0.1', '2019-04-14 15:39:32');
INSERT INTO `sys_log` VALUES ('1117331537059160065', '1', 'admin', '上传文件', '59', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_5\"],\"name\":[\"post-sample-image.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"122082\"]}', '127.0.0.1', '2019-04-14 15:39:32');
INSERT INTO `sys_log` VALUES ('1117331684769964034', '1', 'admin', '上传文件', '27', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_0\"],\"name\":[\"about-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"34869\"]}', '127.0.0.1', '2019-04-14 15:40:07');
INSERT INTO `sys_log` VALUES ('1117331685013233666', '1', 'admin', '上传文件', '27', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_1\"],\"name\":[\"contact-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"235068\"]}', '127.0.0.1', '2019-04-14 15:40:07');
INSERT INTO `sys_log` VALUES ('1117331685453635585', '1', 'admin', '上传文件', '56', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_2\"],\"name\":[\"home-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"155751\"]}', '127.0.0.1', '2019-04-14 15:40:07');
INSERT INTO `sys_log` VALUES ('1117333748287840257', '1', 'admin', '上传文件', '37', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_0\"],\"name\":[\"about-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"34869\"]}', '127.0.0.1', '2019-04-14 15:48:19');
INSERT INTO `sys_log` VALUES ('1117337865034924034', '1', 'admin', '登录', '61', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-14 16:04:41');
INSERT INTO `sys_log` VALUES ('1117337929480404993', '1', 'admin', '更新菜单', '70', 'POST /sys/menu/update', '{\"parentId\":[\"1115182776430137345\"],\"id\":[\"1115184208369717257\"],\"type\":[\"1\"],\"name\":[\"商品类别管理\"],\"url\":[\"/cms/category\"],\"perms\":[\"\"],\"orderNum\":[\"1\"],\"icon\":[\"fa fa-file-code-o\"]}', '127.0.0.1', '2019-04-14 16:04:56');
INSERT INTO `sys_log` VALUES ('1117338279939670018', '1', 'admin', '更新菜单', '39', 'POST /sys/menu/update', '{\"parentId\":[\"1115182776430137345\"],\"id\":[\"1115184208369717269\"],\"type\":[\"1\"],\"name\":[\"商品管理\"],\"url\":[\"/cms/product\"],\"perms\":[\"\"],\"orderNum\":[\"2\"],\"icon\":[\"fa fa-shopping-bag\"]}', '127.0.0.1', '2019-04-14 16:06:20');
INSERT INTO `sys_log` VALUES ('1117338360017321986', '1', 'admin', '上传文件', '116', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_0\"],\"name\":[\"about-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"34869\"]}', '127.0.0.1', '2019-04-14 16:06:39');
INSERT INTO `sys_log` VALUES ('1117339637182889986', '1', 'admin', '上传文件', '43', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_0\"],\"name\":[\"about-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"34869\"]}', '127.0.0.1', '2019-04-14 16:11:43');
INSERT INTO `sys_log` VALUES ('1117340721305616385', '1', 'admin', '上传文件', '34', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_0\"],\"name\":[\"about-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"34869\"]}', '127.0.0.1', '2019-04-14 16:16:02');
INSERT INTO `sys_log` VALUES ('1117340766784454657', '1', 'admin', '上传文件', '28', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_0\"],\"name\":[\"about-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"34869\"]}', '127.0.0.1', '2019-04-14 16:16:13');
INSERT INTO `sys_log` VALUES ('1117341499579695105', '1', 'admin', '上传文件', '31', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_0\"],\"name\":[\"about-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"34869\"]}', '127.0.0.1', '2019-04-14 16:19:07');
INSERT INTO `sys_log` VALUES ('1117341525865398273', '1', 'admin', '上传文件', '30', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_1\"],\"name\":[\"contact-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"235068\"]}', '127.0.0.1', '2019-04-14 16:19:14');
INSERT INTO `sys_log` VALUES ('1117341526146416642', '1', 'admin', '上传文件', '26', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_2\"],\"name\":[\"home-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"155751\"]}', '127.0.0.1', '2019-04-14 16:19:14');
INSERT INTO `sys_log` VALUES ('1117341526351937538', '1', 'admin', '上传文件', '27', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_3\"],\"name\":[\"post-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"122546\"]}', '127.0.0.1', '2019-04-14 16:19:14');
INSERT INTO `sys_log` VALUES ('1117341526469378049', '1', 'admin', '上传文件', '34', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_4\"],\"name\":[\"post-sample-image.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"122082\"]}', '127.0.0.1', '2019-04-14 16:19:14');
INSERT INTO `sys_log` VALUES ('1117341608665153538', '1', 'admin', '上传文件', '30', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_0\"],\"name\":[\"home-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"155751\"]}', '127.0.0.1', '2019-04-14 16:19:33');
INSERT INTO `sys_log` VALUES ('1117341608765816833', '1', 'admin', '上传文件', '25', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_1\"],\"name\":[\"post-sample-image.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"122082\"]}', '127.0.0.1', '2019-04-14 16:19:33');
INSERT INTO `sys_log` VALUES ('1117341609092972545', '1', 'admin', '上传文件', '35', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_3\"],\"name\":[\"contact-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"235068\"]}', '127.0.0.1', '2019-04-14 16:19:33');
INSERT INTO `sys_log` VALUES ('1117342805614657538', '1', 'admin', '上传文件', '27', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_0\"],\"name\":[\"about-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"34869\"]}', '127.0.0.1', '2019-04-14 16:24:19');
INSERT INTO `sys_log` VALUES ('1117342805971173378', '1', 'admin', '上传文件', '27', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_1\"],\"name\":[\"contact-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"235068\"]}', '127.0.0.1', '2019-04-14 16:24:19');
INSERT INTO `sys_log` VALUES ('1117342806382215169', '1', 'admin', '上传文件', '27', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_2\"],\"name\":[\"home-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"155751\"]}', '127.0.0.1', '2019-04-14 16:24:19');
INSERT INTO `sys_log` VALUES ('1117348865729626114', '1', 'admin', '登录', '5', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-14 16:48:24');
INSERT INTO `sys_log` VALUES ('1117348932679106561', '1', 'admin', '上传文件', '31', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_0\"],\"name\":[\"about-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"34869\"]}', '127.0.0.1', '2019-04-14 16:48:40');
INSERT INTO `sys_log` VALUES ('1117348932888821762', '1', 'admin', '上传文件', '25', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_1\"],\"name\":[\"contact-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"235068\"]}', '127.0.0.1', '2019-04-14 16:48:40');
INSERT INTO `sys_log` VALUES ('1117351728631525378', '1', 'admin', '登录', '65', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-14 16:59:46');
INSERT INTO `sys_log` VALUES ('1117351912417538050', '1', 'admin', '上传文件', '52', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_0\"],\"name\":[\"about-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"34869\"]}', '127.0.0.1', '2019-04-14 17:00:30');
INSERT INTO `sys_log` VALUES ('1117351912698556417', '1', 'admin', '上传文件', '47', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_1\"],\"name\":[\"contact-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"235068\"]}', '127.0.0.1', '2019-04-14 17:00:30');
INSERT INTO `sys_log` VALUES ('1117351912908271618', '1', 'admin', '上传文件', '39', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_2\"],\"name\":[\"home-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"155751\"]}', '127.0.0.1', '2019-04-14 17:00:30');
INSERT INTO `sys_log` VALUES ('1117352004654477313', '1', 'admin', '添加', '87', 'POST /cms/product/save', '{\"categoryid\":[\"\"],\"name\":[\"qwrfwf\"],\"description\":[\"wefwef\"],\"detail\":[\"wefwef\"],\"image[0]\":[\"http://localhost:8088/upload/20190414\\\\8\\\\f\\\\about-bg.jpg\"],\"image[1]\":[\"http://localhost:8088/upload/20190414\\\\5\\\\0\\\\contact-bg.jpg\"],\"image[2]\":[\"http://localhost:8088/upload/20190414\\\\6\\\\6\\\\home-bg.jpg\"],\"image[3]\":[\"\"],\"image[4]\":[\"\"],\"price\":[\"$123\"],\"sale\":[\"$123\"],\"url\":[\"https://www.amazon.com/dp/B00T4BHYLY\"],\"order\":[\"1\"],\"tagList[0]\":[\"q1qe\"],\"tagList[1]\":[\"qwe1\"],\"tagList[2]\":[\"\"]}', '127.0.0.1', '2019-04-14 17:00:52');
INSERT INTO `sys_log` VALUES ('1117353179701338114', '1', 'admin', '登录', '196', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-14 17:05:32');
INSERT INTO `sys_log` VALUES ('1117353273183985665', '1', 'admin', '删除菜单', '67', 'POST /sys/menu/remove', '{\"id\":[\"72\"]}', '127.0.0.1', '2019-04-14 17:05:54');
INSERT INTO `sys_log` VALUES ('1117353331866492929', '1', 'admin', '修改', '59', 'POST /cms/product/update', '{\"id\":[\"1\"],\"categoryid\":[\"\"],\"name\":[\"qwrfwf\"],\"description\":[\"wefwef\"],\"detail\":[\"wefwef\"],\"image\":[\"\"],\"price\":[\"$123\"],\"sale\":[\"$123\"],\"url\":[\"https://www.amazon.com/dp/B00T4BHYLY\"],\"order\":[\"1\"],\"tags\":[\"q1qe,qwe1\"],\"status\":[\"0\"]}', '127.0.0.1', '2019-04-14 17:06:08');
INSERT INTO `sys_log` VALUES ('1117353587018588161', '1', 'admin', '上传文件', '39', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_0\"],\"name\":[\"post-bg.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"122546\"]}', '127.0.0.1', '2019-04-14 17:07:09');
INSERT INTO `sys_log` VALUES ('1117353703020453890', '1', 'admin', '添加', '41', 'POST /cms/product/save', '{\"categoryid\":[\"\"],\"name\":[\"2sdgf\"],\"description\":[\"afaf\"],\"detail\":[\"dsfbdrgreg\"],\"image[0]\":[\"http://localhost:8088/upload/20190414\\\\5\\\\8\\\\post-bg.jpg\"],\"image[1]\":[\"\"],\"image[2]\":[\"\"],\"image[3]\":[\"\"],\"image[4]\":[\"\"],\"price\":[\"$123\"],\"sale\":[\"$123\"],\"url\":[\"https://www.amazon.com/dp/B00C0KI8YS?psc=1\"],\"order\":[\"2\"],\"tagList[0]\":[\"345ty\"],\"tagList[1]\":[\"b dfb\"],\"tagList[2]\":[\"\"]}', '127.0.0.1', '2019-04-14 17:07:37');
INSERT INTO `sys_log` VALUES ('1117354582721191937', '1', 'admin', '上传文件', '33', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_0\"],\"name\":[\"post-sample-image.jpg\"],\"type\":[\"image/jpeg\"],\"lastModifiedDate\":[\"Mon Apr 08 2019 21:02:16 GMT+0800 (中国标准时间)\"],\"size\":[\"122082\"]}', '127.0.0.1', '2019-04-14 17:11:07');
INSERT INTO `sys_log` VALUES ('1117354622948761602', '1', 'admin', '添加', '59', 'POST /cms/product/save', '{\"categoryid\":[\"\"],\"name\":[\"爱和福建傲\"],\"description\":[\"色粉啊\"],\"detail\":[\"唔使娃娃儿\"],\"image[0]\":[\"http://localhost:8088/upload/20190414\\\\8\\\\f\\\\post-sample-image.jpg\"],\"image[1]\":[\"\"],\"image[2]\":[\"\"],\"image[3]\":[\"\"],\"image[4]\":[\"\"],\"price\":[\"$123\"],\"sale\":[\"$123\"],\"url\":[\"https://www.amazon.com/dp/B00C0KI8YS?psc=1\"],\"order\":[\"1\"],\"tagList[0]\":[\"345ty\"],\"tagList[1]\":[\"qwe1\"],\"tagList[2]\":[\"123\"]}', '127.0.0.1', '2019-04-14 17:11:16');
INSERT INTO `sys_log` VALUES ('1117355081717559297', '1', 'admin', '登录', '200', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-14 17:13:06');
INSERT INTO `sys_log` VALUES ('1117357758153273346', '1', 'admin', '登录', '8', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-14 17:23:44');
INSERT INTO `sys_log` VALUES ('1117358468118880257', '1', 'admin', '登录', '196', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-14 17:26:33');
INSERT INTO `sys_log` VALUES ('1117362991818457090', '1', 'admin', '登录', '203', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-14 17:44:31');
INSERT INTO `sys_log` VALUES ('1117363557571346434', '1', 'admin', '添加', '60', 'POST /cms/product/save', '{\"categoryid\":[\"\"],\"name\":[\"qwrfwf\"],\"description\":[\"\"],\"detail\":[\"\"],\"image[0]\":[\"http://localhost:8088/upload/20190414\\\\8\\\\f\\\\about-bg.jpg\"],\"image[1]\":[\"http://localhost:8088/upload/20190414\\\\5\\\\0\\\\contact-bg.jpg\"],\"image[2]\":[\"http://localhost:8088/upload/20190414\\\\6\\\\6\\\\home-bg.jpg\"],\"price\":[\"$123\"],\"sale\":[\"$123\"],\"url\":[\"https://www.amazon.com/dp/B00T4BHYLY\"],\"order\":[\"1\"],\"tagList[0]\":[\"q1qe\"],\"tagList[1]\":[\"qwe1\"]}', '127.0.0.1', '2019-04-14 17:46:46');
INSERT INTO `sys_log` VALUES ('1117684352025649154', '1', 'admin', '登录', '55', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-15 15:01:30');
INSERT INTO `sys_log` VALUES ('1117705839151439873', '1', 'admin', '登录', '5', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-15 16:26:53');
INSERT INTO `sys_log` VALUES ('1117714288501350401', '1', 'admin', '登录', '5', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-15 17:00:27');
INSERT INTO `sys_log` VALUES ('1117715920865738754', '1', 'admin', '登录', '158', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-15 17:06:56');
INSERT INTO `sys_log` VALUES ('1117716708866519042', '1', 'admin', '登录', '161', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-15 17:10:04');
INSERT INTO `sys_log` VALUES ('1117717082566422530', '1', 'admin', '登录', '11', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-15 17:11:33');
INSERT INTO `sys_log` VALUES ('1117719714521485314', '1', 'admin', '登录', '155', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-15 17:22:01');
INSERT INTO `sys_log` VALUES ('1117730564451930114', '1', 'admin', '登录', '5', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-15 18:05:08');
INSERT INTO `sys_log` VALUES ('1117732165715554305', '1', 'admin', '登录', '157', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-15 18:11:29');
INSERT INTO `sys_log` VALUES ('1117739051948998657', '1', 'admin', '登录', '166', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-15 18:38:51');
INSERT INTO `sys_log` VALUES ('1117746466912239617', '1', 'admin', '添加', '89', 'POST /cms/nav/save', '{}', '127.0.0.1', '2019-04-15 19:08:19');
INSERT INTO `sys_log` VALUES ('1117746863391408129', '1', 'admin', '添加', '42', 'POST /cms/nav/save', '{}', '127.0.0.1', '2019-04-15 19:09:54');
INSERT INTO `sys_log` VALUES ('1118054810877173762', '1', 'admin', '登录', '45', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-16 15:33:34');
INSERT INTO `sys_log` VALUES ('1118055010400215042', '1', 'admin', '上传文件', '40', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_0\"],\"name\":[\"u5898.png\"],\"type\":[\"image/png\"],\"lastModifiedDate\":[\"Tue Mar 26 2019 18:27:19 GMT+0800 (China Standard Time)\"],\"size\":[\"555\"]}', '127.0.0.1', '2019-04-16 15:34:22');
INSERT INTO `sys_log` VALUES ('1118055175207002113', '1', 'admin', '添加', '60', 'POST /cms/nav/save', '{}', '127.0.0.1', '2019-04-16 15:35:01');
INSERT INTO `sys_log` VALUES ('1118060967721177089', '1', 'admin', '登录', '34', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-16 15:58:02');
INSERT INTO `sys_log` VALUES ('1118066011715670018', '1', 'admin', '登录', '13', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-16 16:18:05');
INSERT INTO `sys_log` VALUES ('1118066220298407938', '1', 'admin', '上传文件', '53', 'POST /common/sysFile/upload', '{}', '127.0.0.1', '2019-04-16 16:18:54');
INSERT INTO `sys_log` VALUES ('1118066523433340930', '1', 'admin', '上传文件', '59', 'POST /common/sysFile/upload', '{}', '127.0.0.1', '2019-04-16 16:20:07');
INSERT INTO `sys_log` VALUES ('1118066576050884610', '1', 'admin', '上传文件', '33', 'POST /common/sysFile/upload', '{}', '127.0.0.1', '2019-04-16 16:20:19');
INSERT INTO `sys_log` VALUES ('1118066757915906050', '1', 'admin', '上传文件', '70', 'POST /common/sysFile/upload', '{}', '127.0.0.1', '2019-04-16 16:21:02');
INSERT INTO `sys_log` VALUES ('1118066770180050945', '1', 'admin', '上传文件', '59', 'POST /common/sysFile/upload', '{}', '127.0.0.1', '2019-04-16 16:21:05');
INSERT INTO `sys_log` VALUES ('1118066843769114626', '1', 'admin', '上传文件', '74', 'POST /common/sysFile/upload', '{}', '127.0.0.1', '2019-04-16 16:21:23');
INSERT INTO `sys_log` VALUES ('1118072817921822721', '1', 'admin', '登录', '3', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-16 16:45:07');
INSERT INTO `sys_log` VALUES ('1118074951891423234', '1', 'admin', '添加', '42', 'POST /cms/nav/save', '{}', '127.0.0.1', '2019-04-16 16:53:36');
INSERT INTO `sys_log` VALUES ('1118078133124206593', '1', 'admin', '登录', '6', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-16 17:06:14');
INSERT INTO `sys_log` VALUES ('1118081872308473858', '1', 'admin', '登录', '3', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-16 17:21:06');
INSERT INTO `sys_log` VALUES ('1118093414492016642', '1', 'admin', '添加', '68', 'POST /cms/nav/save', '{}', '127.0.0.1', '2019-04-16 18:06:58');
INSERT INTO `sys_log` VALUES ('1118094900793970689', '1', 'admin', '修改文章表', '18262', 'POST /cms/article/update', '{\"id\":[\"10\"],\"title\":[\"视觉中国开盘封死跌停 创始人身家瞬间缩水1.3亿\"],\"summary\":[\"4月12日早盘，视觉中国开盘无悬念跌停，封单近41万手，报25.20元/股，一夜间总市值从196亿元缩水至176.5亿元，市值蒸发19.6亿元。\"],\"author\":[\"北京青年报\"],\"style\":[\"4\"],\"thumbnail\":[\"\"],\"social[0][type]\":[\"Fackbook\"],\"social[0][url]\":[\"http://www.baidu.com\"],\"social[0][order]\":[\"\"],\"social[1][type]\":[\"\"],\"social[1][url]\":[\"\"],\"social[1][order]\":[\"\"],\"social[2][type]\":[\"\"],\"social[2][url]\":[\"\"],\"social[2][order]\":[\"\"],\"social[3][type]\":[\"\"],\"social[3][url]\":[\"\"],\"social[3][order]\":[\"\"],\"social[4][type]\":[\"\"],\"social[4][url]\":[\"\"],\"social[4][order]\":[\"\"],\"tag[0]\":[\"\"],\"tag[1]\":[\"\"],\"tag[2]\":[\"\"],\"content\":[\"<p>原标题：视觉中国开盘封死跌停 柴继军身价瞬间缩水1.3亿</p><p>　　4月12日早盘，视觉中国开盘无悬念跌停，封单近41万手，报25.20元/股，一夜间总市值从196亿元缩水至176.5亿元，市值蒸发19.6亿元。</p><p>　　早些时候，视觉中国发公告称，天津市互联网信息办公室依法约谈其网站负责人，责令公司网站全面彻底整改并在此期间暂时关闭网站。</p><p>　　4月11日，因“人类首张黑洞照片”版权标注问题，A股上市公司视觉中国陷入舆论风暴。网友和机构随即发现，国旗国徽也被视觉中国打了版权售卖。国徽图片页面“价格提示”显示，“用于内文不低于150元，整版跨页不低于500元，杂志封面不低于1000元，商业使用价格另议。”虽然连续发声明解释、道歉，但是网友并不买账，直至该公司关闭网站。</p><p>　　根据计划，视觉中国4月12日有3.88亿股限售股上市流通，占公司总股本比例的55.39%。此次解禁是五年前视觉中国借壳远东股份所定向增发的股份，当时定增发行价为5.28元/股，五年期间未实施过股份送转。</p>\"],\"metaTitle\":[\"你好\"],\"metaKeywords\":[\"我好\"],\"metaDescription\":[\"大家好\"]}', '127.0.0.1', '2019-04-16 18:12:52');
INSERT INTO `sys_log` VALUES ('1118095958677131266', '1', 'admin', '添加', '31', 'POST /cms/nav/save', '{}', '127.0.0.1', '2019-04-16 18:17:04');
INSERT INTO `sys_log` VALUES ('1118102222933069825', '1', 'admin', '登录', '6', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-16 18:41:58');
INSERT INTO `sys_log` VALUES ('1118102283247161346', '1', 'admin', '添加', '57', 'POST /cms/nav/save', '{}', '127.0.0.1', '2019-04-16 18:42:12');
INSERT INTO `sys_log` VALUES ('1118349295230152706', '1', 'admin', '登录', '33', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-17 11:03:45');
INSERT INTO `sys_log` VALUES ('1118355196414554113', '1', 'admin', '登录', '6', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-17 11:27:12');
INSERT INTO `sys_log` VALUES ('1118359324998004738', '1', 'admin', '登录', '4', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-17 11:43:36');
INSERT INTO `sys_log` VALUES ('1118362426442543105', '1', 'admin', '登录', '14', 'POST /login', '{\"username\":[\"admi\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-17 11:55:55');
INSERT INTO `sys_log` VALUES ('1118362439264530434', '1', 'admin', '登录', '5', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-17 11:55:58');
INSERT INTO `sys_log` VALUES ('1118371647041073153', '1', 'admin', '上传文件', '42', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_0\"],\"name\":[\"u5898.png\"],\"type\":[\"image/png\"],\"lastModifiedDate\":[\"Tue Mar 26 2019 18:27:19 GMT+0800 (China Standard Time)\"],\"size\":[\"555\"]}', '127.0.0.1', '2019-04-17 12:32:34');
INSERT INTO `sys_log` VALUES ('1118438778302656513', '1', 'admin', '登录', '4', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-17 16:59:19');
INSERT INTO `sys_log` VALUES ('1118442748081385473', '1', 'admin', '登录', '157', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-17 17:15:05');
INSERT INTO `sys_log` VALUES ('1118444975894417409', '1', 'admin', '登录', '156', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-17 17:23:57');
INSERT INTO `sys_log` VALUES ('1118448755775946754', '1', 'admin', '登录', '158', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-17 17:38:58');
INSERT INTO `sys_log` VALUES ('1118451654824370178', '1', 'admin', '登录', '157', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-17 17:50:29');
INSERT INTO `sys_log` VALUES ('1118452897084944386', '1', 'admin', '登录', '162', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-17 17:55:25');
INSERT INTO `sys_log` VALUES ('1118452952382648322', '1', 'admin', '上传文件', '31', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_0\"],\"name\":[\"u5967.png\"],\"type\":[\"image/png\"],\"lastModifiedDate\":[\"Tue Mar 26 2019 18:27:19 GMT+0800 (China Standard Time)\"],\"size\":[\"791\"]}', '127.0.0.1', '2019-04-17 17:55:38');
INSERT INTO `sys_log` VALUES ('1118453199175495682', '1', 'admin', '上传文件', '40', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_0\"],\"name\":[\"u5898.png\"],\"type\":[\"image/png\"],\"lastModifiedDate\":[\"Tue Mar 26 2019 18:27:19 GMT+0800 (China Standard Time)\"],\"size\":[\"555\"]}', '127.0.0.1', '2019-04-17 17:56:37');
INSERT INTO `sys_log` VALUES ('1118453357468528642', '1', 'admin', '上传文件', '23', 'POST /common/sysFile/upload', '{\"id\":[\"WU_FILE_1\"],\"name\":[\"261_expand_12rollover1.png\"],\"type\":[\"image/png\"],\"lastModifiedDate\":[\"Tue Feb 06 2018 07:13:03 GMT+0800 (China Standard Time)\"],\"size\":[\"2835\"]}', '127.0.0.1', '2019-04-17 17:57:15');
INSERT INTO `sys_log` VALUES ('1118453445519552514', '1', 'admin', '添加', '58', 'POST /cms/nav/save', '{}', '127.0.0.1', '2019-04-17 17:57:36');
INSERT INTO `sys_log` VALUES ('1118463803168743425', '1', 'admin', '登录', '159', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-17 18:38:45');
INSERT INTO `sys_log` VALUES ('1118703383771893762', '1', 'admin', '登录', '72', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-18 10:30:46');
INSERT INTO `sys_log` VALUES ('1118703576835706881', '1', 'admin', '修改', '86', 'POST /cms/nav/update', '{}', '127.0.0.1', '2019-04-18 10:31:32');
INSERT INTO `sys_log` VALUES ('1118707136466014210', '1', 'admin', '添加', '57', 'POST /cms/nav/save', '{}', '127.0.0.1', '2019-04-18 10:45:41');
INSERT INTO `sys_log` VALUES ('1118707194871697409', '1', 'admin', '修改', '40', 'POST /cms/nav/update', '{}', '127.0.0.1', '2019-04-18 10:45:54');
INSERT INTO `sys_log` VALUES ('1118708365954928642', '1', 'admin', '修改', '37', 'POST /cms/nav/update', '{}', '127.0.0.1', '2019-04-18 10:50:34');
INSERT INTO `sys_log` VALUES ('1118772877915697153', '1', 'admin', '登录', '40', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-18 15:06:55');
INSERT INTO `sys_log` VALUES ('1118789852188487682', '1', 'admin', '登录', '4', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-18 16:14:22');
INSERT INTO `sys_log` VALUES ('1118792074032951297', '1', 'admin', '修改', '57', 'POST /cms/nav/update', '{}', '127.0.0.1', '2019-04-18 16:23:11');
INSERT INTO `sys_log` VALUES ('1118792195969757185', '1', 'admin', '修改', '33', 'POST /cms/nav/update', '{}', '127.0.0.1', '2019-04-18 16:23:40');
INSERT INTO `sys_log` VALUES ('1118792793033125890', '1', 'admin', '添加', '67', 'POST /cms/nav/save', '{}', '127.0.0.1', '2019-04-18 16:26:03');
INSERT INTO `sys_log` VALUES ('1118796075721928705', '1', 'admin', '修改', '26', 'POST /cms/nav/update', '{}', '127.0.0.1', '2019-04-18 16:39:05');
INSERT INTO `sys_log` VALUES ('1118796358648705026', '1', 'admin', '修改', '3', 'POST /cms/nav/update', '{}', '127.0.0.1', '2019-04-18 16:40:13');
INSERT INTO `sys_log` VALUES ('1118796571589324801', '1', 'admin', '修改', '2', 'POST /cms/nav/update', '{}', '127.0.0.1', '2019-04-18 16:41:04');
INSERT INTO `sys_log` VALUES ('1118798073217265665', '1', 'admin', '添加', '133', 'POST /cms/nav/save', '{}', '127.0.0.1', '2019-04-18 16:47:02');
INSERT INTO `sys_log` VALUES ('1118803463808069634', '1', 'admin', '登录', '5', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-18 17:08:27');
INSERT INTO `sys_log` VALUES ('1118808448012726274', '1', 'admin', '登录', '160', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-18 17:28:15');
INSERT INTO `sys_log` VALUES ('1118808756138885121', '1', 'admin', '登录', '155', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-18 17:29:29');
INSERT INTO `sys_log` VALUES ('1118809263817416705', '1', 'admin', '登录', '162', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-18 17:31:30');
INSERT INTO `sys_log` VALUES ('1118810233670524930', '1', 'admin', '修改', '51', 'POST /cms/nav/update', '{}', '127.0.0.1', '2019-04-18 17:35:21');
INSERT INTO `sys_log` VALUES ('1118812653834260482', '1', 'admin', '登录', '157', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-18 17:44:58');
INSERT INTO `sys_log` VALUES ('1118812723346460673', '1', 'admin', '添加', '87', 'POST /cms/tag/save', '{\"name\":[\"水果\"],\"type\":[\"1\"]}', '127.0.0.1', '2019-04-18 17:45:14');
INSERT INTO `sys_log` VALUES ('1118813400697188353', '1', 'admin', '登录', '157', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-18 17:47:56');
INSERT INTO `sys_log` VALUES ('1118813433458896897', '1', 'admin', '修改', '156', 'POST /cms/tag/update', '{\"id\":[\"1\"],\"name\":[\"水果\"],\"type\":[\"2\"],\"isenable\":[\"1\"]}', '127.0.0.1', '2019-04-18 17:48:04');
INSERT INTO `sys_log` VALUES ('1118813465557905409', '1', 'admin', '修改', '89', 'POST /cms/tag/update', '{\"id\":[\"1\"],\"name\":[\"水果\"],\"type\":[\"1\"],\"isenable\":[\"0\"]}', '127.0.0.1', '2019-04-18 17:48:11');
INSERT INTO `sys_log` VALUES ('1118814069386686465', '1', 'admin', '修改', '61', 'POST /cms/tag/update', '{\"id\":[\"1\"],\"name\":[\"水果\"],\"type\":[\"1\"],\"isenable\":[\"1\"]}', '127.0.0.1', '2019-04-18 17:50:35');
INSERT INTO `sys_log` VALUES ('1118814082267394050', '1', 'admin', '修改', '92', 'POST /cms/tag/update', '{\"id\":[\"1\"],\"name\":[\"水果\"],\"type\":[\"1\"],\"isenable\":[\"0\"]}', '127.0.0.1', '2019-04-18 17:50:38');
INSERT INTO `sys_log` VALUES ('1118814097274613761', '1', 'admin', '修改', '69', 'POST /cms/tag/update', '{\"id\":[\"1\"],\"name\":[\"水果\"],\"type\":[\"3\"],\"isenable\":[\"1\"]}', '127.0.0.1', '2019-04-18 17:50:42');
INSERT INTO `sys_log` VALUES ('1118814140140400642', '1', 'admin', '删除', '72', 'POST /cms/tag/remove', '{\"id\":[\"1\"]}', '127.0.0.1', '2019-04-18 17:50:52');
INSERT INTO `sys_log` VALUES ('1118814157597093890', '1', 'admin', '添加', '83', 'POST /cms/tag/save', '{\"name\":[\"水果\"],\"type\":[\"1\"]}', '127.0.0.1', '2019-04-18 17:50:56');
INSERT INTO `sys_log` VALUES ('1118814176098168834', '1', 'admin', '修改', '95', 'POST /cms/tag/update', '{\"id\":[\"2\"],\"name\":[\"水果\"],\"type\":[\"1\"],\"isenable\":[\"0\"]}', '127.0.0.1', '2019-04-18 17:51:01');
INSERT INTO `sys_log` VALUES ('1118814208209760257', '1', 'admin', '添加', '109', 'POST /cms/tag/save', '{\"name\":[\"123\"],\"type\":[\"1\"]}', '127.0.0.1', '2019-04-18 17:51:08');
INSERT INTO `sys_log` VALUES ('1118814242791796738', '1', 'admin', '删除', '29', 'POST /cms/tag/remove', '{\"id\":[\"3\"]}', '127.0.0.1', '2019-04-18 17:51:17');
INSERT INTO `sys_log` VALUES ('1118815007333724162', '1', 'admin', '更新角色', '247', 'POST /sys/role/update', '{\"id\":[\"1\"],\"menuIds\":[\"193,194,195,196,197,79,80,81,83,176,177,178,179,180,207,208,209,210,211,20,21,22,61,12,13,14,24,25,26,15,55,56,62,74,75,76,48,28,29,30,57,92,1115184208369717252,1115184208369717253,1115184208369717254,1115184208369717255,1115184208369717256,1115184208369717264,1115184208369717265,1115184208369717266,1115184208369717267,1115184208369717268,1115184208369717258,1115184208369717259,1115184208369717260,1115184208369717261,1115184208369717262,1115184208369717270,1115184208369717271,1115184208369717272,1115184208369717273,1115184208369717274,1115183444654067714,1115184160676286466,1115184208369717250,1115184208369717276,1115184208369717277,1115184208369717278,1115184208369717279,1115184208369717280,1115184208369717282,1115184208369717283,1115184208369717284,1115184208369717285,1115184208369717286,1115184208369717288,1115184208369717289,1115184208369717290,1115184208369717291,1115184208369717292,1115183213711495170,1115183247500808194,71,78,175,206,1,2,6,7,73,3,77,27,91,1115184208369717251,1115184208369717263,1115179024377745410,1115184208369717257,1115184208369717269,1115182776430137345,1115184208369717281,1115184208369717275,1115184208369717287,1115183012166799361,1115183127149449218,-1\"],\"roleName\":[\"超级管理员\"],\"remark\":[\"超级管理员\"]}', '127.0.0.1', '2019-04-18 17:54:19');
INSERT INTO `sys_log` VALUES ('1118816108984446978', '1', 'admin', '修改文章表', '6518', 'POST /cms/article/update', '{\"id\":[\"17\"],\"title\":[\"123\"],\"summary\":[\"123\"],\"author\":[\"123\"],\"style\":[\"4\"],\"thumbnail\":[\"\"],\"social[0][type]\":[\"Fackbook\"],\"social[0][url]\":[\"http://www.baidu.com\"],\"social[0][order]\":[\"2\"],\"social[1][type]\":[\"\"],\"social[1][url]\":[\"\"],\"social[1][order]\":[\"\"],\"social[2][type]\":[\"\"],\"social[2][url]\":[\"\"],\"social[2][order]\":[\"\"],\"social[3][type]\":[\"\"],\"social[3][url]\":[\"\"],\"social[3][order]\":[\"\"],\"social[4][type]\":[\"\"],\"social[4][url]\":[\"\"],\"social[4][order]\":[\"\"],\"tag[0]\":[\"123\"],\"tag[1]\":[\"123\"],\"tag[2]\":[\"evgeg\"],\"content\":[\"<p style=\\\"text-align: center;\\\">Balala...</p><p style=\\\"text-align: center;\\\">sfasfasfoajhfoewnfpowufe hwjefnwoehfauwehfwo;efjowihfwjebnfwefhj</p><p style=\\\"text-align: center;\\\">wnefojwhnefowefjwbfeowehfwjebfwoefhewjfn</p>\"],\"metaTitle\":[\"\"],\"metaKeywords\":[\"\"],\"metaDescription\":[\"\"]}', '127.0.0.1', '2019-04-18 17:58:42');
INSERT INTO `sys_log` VALUES ('1118816377398931458', '1', 'admin', '修改文章表', '43', 'POST /cms/event/update', '{\"id\":[\"14\"],\"title\":[\"123\"],\"content\":[\"1231\"],\"linkto\":[\"http://www.baidu.com\"],\"thumbnail\":[\"http://localhost:8088/upload/20190414\\\\6\\\\6\\\\home-bg.jpg\"],\"starttime\":[\"2019-04-10 18:13:11\"],\"endtime\":[\"2019-04-10 18:13:13\"],\"price\":[\"$123\"],\"address\":[\"你家\"],\"metakeywords\":[\"\"],\"metadescription\":[\"\"],\"type\":[\"1\"]}', '127.0.0.1', '2019-04-18 17:59:46');
INSERT INTO `sys_log` VALUES ('1118816414497550337', '1', 'admin', '修改文章表', '40', 'POST /cms/event/update', '{\"id\":[\"14\"],\"title\":[\"123\"],\"content\":[\"1231\"],\"linkto\":[\"http://www.baidu.com\"],\"thumbnail\":[\"http://localhost:8088/upload/20190414\\\\6\\\\6\\\\home-bg.jpg\"],\"starttime\":[\"2019-04-10 18:13:11\"],\"endtime\":[\"2019-04-10 18:13:13\"],\"price\":[\"$123\"],\"address\":[\"你家\"],\"metakeywords\":[\"\"],\"metadescription\":[\"\"],\"type\":[\"2\"]}', '127.0.0.1', '2019-04-18 17:59:54');
INSERT INTO `sys_log` VALUES ('1118816787710914562', '1', 'admin', '添加', '76', 'POST /cms/product/save', '{\"categoryid\":[\"\"],\"name\":[\"篮球\"],\"description\":[\"打篮球\"],\"detail\":[\"篮球好好打\"],\"image[0]\":[\"http://localhost:8088/upload/20190414\\\\8\\\\f\\\\about-bg.jpg\"],\"image[1]\":[\"http://localhost:8088/upload/20190414\\\\5\\\\0\\\\contact-bg.jpg\"],\"image[2]\":[\"http://localhost:8088/upload/20190414\\\\6\\\\6\\\\home-bg.jpg\"],\"price\":[\"$123\"],\"sale\":[\"$123\"],\"url\":[\"https://www.amazon.com/dp/B00T4BHYLY\"],\"order\":[\"1\"],\"tagList[0]\":[\"q1qe\"],\"tagList[1]\":[\"qwe1\"]}', '127.0.0.1', '2019-04-18 18:01:23');
INSERT INTO `sys_log` VALUES ('1118817890221469698', '1', 'admin', '添加', '78', 'POST /cms/product/save', '{\"categoryid\":[\"\"],\"name\":[\"篮球\"],\"description\":[\"打篮球\"],\"detail\":[\"篮球好好打\"],\"image[0]\":[\"http://localhost:8088/upload/20190414\\\\8\\\\f\\\\about-bg.jpg\"],\"image[1]\":[\"http://localhost:8088/upload/20190414\\\\5\\\\0\\\\contact-bg.jpg\"],\"image[2]\":[\"http://localhost:8088/upload/20190414\\\\6\\\\6\\\\home-bg.jpg\"],\"price\":[\"$123\"],\"sale\":[\"$123\"],\"url\":[\"https://www.amazon.com/dp/B00T4BHYLY\"],\"order\":[\"1\"],\"tagList[0]\":[\"q1qe\"],\"tagList[1]\":[\"qwe1\"]}', '127.0.0.1', '2019-04-18 18:05:46');
INSERT INTO `sys_log` VALUES ('1118818568373317634', '1', 'admin', '修改', '15', 'POST /cms/product/update', '{\"categoryid\":[\"\"],\"name\":[\"篮球\"],\"description\":[\"打篮球\"],\"detail\":[\"篮球好好打\"],\"image[0]\":[\"http://localhost:8088/upload/20190414\\\\8\\\\f\\\\about-bg.jpg\"],\"image[1]\":[\"http://localhost:8088/upload/20190414\\\\5\\\\0\\\\contact-bg.jpg\"],\"image[2]\":[\"http://localhost:8088/upload/20190414\\\\6\\\\6\\\\home-bg.jpg\"],\"price\":[\"$123\"],\"sale\":[\"$123\"],\"url\":[\"https://www.amazon.com/dp/B00T4BHYLY\"],\"order\":[\"1\"],\"tagList[0]\":[\"q1qe\"],\"tagList[1]\":[\"qwe1\"]}', '127.0.0.1', '2019-04-18 18:08:28');
INSERT INTO `sys_log` VALUES ('1118819540671705090', '1', 'admin', '修改', '3', 'POST /cms/product/update', '{\"categoryid\":[\"\"],\"name\":[\"篮球\"],\"description\":[\"打篮球\"],\"detail\":[\"篮球好好打\"],\"image[0]\":[\"http://localhost:8088/upload/20190414\\\\8\\\\f\\\\about-bg.jpg\"],\"image[1]\":[\"http://localhost:8088/upload/20190414\\\\5\\\\0\\\\contact-bg.jpg\"],\"image[2]\":[\"http://localhost:8088/upload/20190414\\\\6\\\\6\\\\home-bg.jpg\"],\"price\":[\"$123\"],\"sale\":[\"$123\"],\"url\":[\"https://www.amazon.com/dp/B00T4BHYLY\"],\"order\":[\"1\"],\"tagList[0]\":[\"q1qe\"],\"tagList[1]\":[\"qwe1\"]}', '127.0.0.1', '2019-04-18 18:12:20');
INSERT INTO `sys_log` VALUES ('1118819830951096322', '1', 'admin', '修改', '55', 'POST /cms/product/update', '{\"id\":[\"6\"],\"categoryid\":[\"\"],\"name\":[\"篮球\"],\"description\":[\"打篮球\"],\"detail\":[\"篮球好好打\"],\"image[0]\":[\"http://localhost:8088/upload/20190414\\\\8\\\\f\\\\about-bg.jpg\"],\"image[1]\":[\"http://localhost:8088/upload/20190414\\\\5\\\\0\\\\contact-bg.jpg\"],\"image[2]\":[\"http://localhost:8088/upload/20190414\\\\6\\\\6\\\\home-bg.jpg\"],\"price\":[\"$123\"],\"sale\":[\"$123\"],\"url\":[\"https://www.amazon.com/dp/B00T4BHYLY\"],\"order\":[\"1\"],\"tagList[0]\":[\"q1qe\"],\"tagList[1]\":[\"qwe1\"]}', '127.0.0.1', '2019-04-18 18:13:29');
INSERT INTO `sys_log` VALUES ('1118819868330733570', '1', 'admin', '修改', '25', 'POST /cms/product/update', '{\"id\":[\"6\"],\"categoryid\":[\"\"],\"name\":[\"篮球\"],\"description\":[\"13123\"],\"detail\":[\"篮球好好打\"],\"image[0]\":[\"http://localhost:8088/upload/20190414\\\\8\\\\f\\\\about-bg.jpg\"],\"image[1]\":[\"http://localhost:8088/upload/20190414\\\\5\\\\0\\\\contact-bg.jpg\"],\"image[2]\":[\"http://localhost:8088/upload/20190414\\\\6\\\\6\\\\home-bg.jpg\"],\"price\":[\"$123\"],\"sale\":[\"$123\"],\"url\":[\"https://www.amazon.com/dp/B00T4BHYLY\"],\"order\":[\"1\"],\"tagList[0]\":[\"q1qe\"],\"tagList[1]\":[\"qwe1\"]}', '127.0.0.1', '2019-04-18 18:13:38');
INSERT INTO `sys_log` VALUES ('1118820022374936577', '1', 'admin', '修改', '38', 'POST /cms/product/update', '{\"id\":[\"6\"],\"categoryid\":[\"\"],\"name\":[\"排球\"],\"description\":[\"13123\"],\"detail\":[\"篮球好好打\"],\"image[0]\":[\"http://localhost:8088/upload/20190414\\\\8\\\\f\\\\about-bg.jpg\"],\"image[1]\":[\"http://localhost:8088/upload/20190414\\\\5\\\\0\\\\contact-bg.jpg\"],\"image[2]\":[\"http://localhost:8088/upload/20190414\\\\6\\\\6\\\\home-bg.jpg\"],\"price\":[\"$123\"],\"sale\":[\"$123\"],\"url\":[\"https://www.amazon.com/dp/B00T4BHYLY\"],\"order\":[\"1\"],\"tagList[0]\":[\"q1qe\"],\"tagList[1]\":[\"qwe1\"]}', '127.0.0.1', '2019-04-18 18:14:15');
INSERT INTO `sys_log` VALUES ('1118821297669799937', '1', 'admin', '登录', '161', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-18 18:19:19');
INSERT INTO `sys_log` VALUES ('1118824207111684098', '1', 'admin', '修改', '63', 'POST /cms/product/update', '{\"id\":[\"6\"],\"categoryid\":[\"\"],\"name\":[\"足球\"],\"description\":[\"13123\"],\"detail\":[\"篮球好好打\"],\"image[0]\":[\"http://localhost:8088/upload/20190414\\\\8\\\\f\\\\about-bg.jpg\"],\"image[1]\":[\"http://localhost:8088/upload/20190414\\\\5\\\\0\\\\contact-bg.jpg\"],\"image[2]\":[\"http://localhost:8088/upload/20190414\\\\6\\\\6\\\\home-bg.jpg\"],\"price\":[\"$123\"],\"sale\":[\"$123\"],\"url\":[\"https://www.amazon.com/dp/B00T4BHYLY\"],\"order\":[\"1\"],\"tagList[0]\":[\"q1qe\"],\"tagList[1]\":[\"qwe1\"]}', '127.0.0.1', '2019-04-18 18:30:52');
INSERT INTO `sys_log` VALUES ('1118824230402654209', '1', 'admin', '删除', '56', 'POST /cms/product/remove', '{\"id\":[\"2\"]}', '127.0.0.1', '2019-04-18 18:30:58');
INSERT INTO `sys_log` VALUES ('1118860387505221634', '1', 'admin', '修改', '62', 'POST /cms/tag/update', '{\"id\":[\"2\"],\"name\":[\"水果\"],\"type\":[\"1\"],\"isenable\":[\"1\"]}', '127.0.0.1', '2019-04-18 20:54:38');
INSERT INTO `sys_log` VALUES ('1118860403267416065', '1', 'admin', '修改', '30', 'POST /cms/tag/update', '{\"id\":[\"4\"],\"name\":[\"123\"],\"type\":[\"1\"],\"isenable\":[\"0\"]}', '127.0.0.1', '2019-04-18 20:54:42');
INSERT INTO `sys_log` VALUES ('1118861073953402882', '1', 'admin', '登录', '16', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-18 20:57:22');
INSERT INTO `sys_log` VALUES ('1118861567505543170', '1', 'admin', '删除', '31', 'POST /cms/tag/remove', '{\"id\":[\"5\"]}', '127.0.0.1', '2019-04-18 20:59:20');
INSERT INTO `sys_log` VALUES ('1118861602565730306', '1', 'admin', '添加', '55', 'POST /cms/tag/save', '{\"name\":[\"你好\"],\"type\":[\"1\"]}', '127.0.0.1', '2019-04-18 20:59:28');
INSERT INTO `sys_log` VALUES ('1118861629375721473', '1', 'admin', '修改', '27', 'POST /cms/tag/update', '{\"id\":[\"6\"],\"name\":[\"你好\"],\"type\":[\"2\"],\"isenable\":[\"1\"]}', '127.0.0.1', '2019-04-18 20:59:35');
INSERT INTO `sys_log` VALUES ('1118861656223461378', '1', 'admin', '修改', '31', 'POST /cms/tag/update', '{\"id\":[\"6\"],\"name\":[\"你好\"],\"type\":[\"3\"],\"isenable\":[\"1\"]}', '127.0.0.1', '2019-04-18 20:59:41');
INSERT INTO `sys_log` VALUES ('1118861674951028738', '1', 'admin', '修改', '24', 'POST /cms/tag/update', '{\"id\":[\"6\"],\"name\":[\"你好\"],\"type\":[\"1\"],\"isenable\":[\"0\"]}', '127.0.0.1', '2019-04-18 20:59:45');
INSERT INTO `sys_log` VALUES ('1118861700473368578', '1', 'admin', '修改', '36', 'POST /cms/tag/update', '{\"id\":[\"6\"],\"name\":[\"你好\"],\"type\":[\"1\"],\"isenable\":[\"1\"]}', '127.0.0.1', '2019-04-18 20:59:51');
INSERT INTO `sys_log` VALUES ('1118863601222852609', '1', 'admin', '登录', '69', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-18 21:07:25');
INSERT INTO `sys_log` VALUES ('1118863684781776898', '1', 'admin', '修改文章表', '347', 'POST /cms/article/update', '{\"id\":[\"10\"],\"title\":[\"视觉中国开盘封死跌停 创始人身家瞬间缩水1.3亿\"],\"summary\":[\"4月12日早盘，视觉中国开盘无悬念跌停，封单近41万手，报25.20元/股，一夜间总市值从196亿元缩水至176.5亿元，市值蒸发19.6亿元。\"],\"author\":[\"北京青年报\"],\"style\":[\"4\"],\"thumbnail\":[\"\"],\"social[0][type]\":[\"Fackbook\"],\"social[0][url]\":[\"http://www.baidu.com\"],\"social[0][order]\":[\"\"],\"social[1][type]\":[\"\"],\"social[1][url]\":[\"\"],\"social[1][order]\":[\"\"],\"social[2][type]\":[\"\"],\"social[2][url]\":[\"\"],\"social[2][order]\":[\"\"],\"social[3][type]\":[\"\"],\"social[3][url]\":[\"\"],\"social[3][order]\":[\"\"],\"social[4][type]\":[\"\"],\"social[4][url]\":[\"\"],\"social[4][order]\":[\"\"],\"tag[0]\":[\"Dahao\"],\"tag[1]\":[\"Tour\"],\"tag[2]\":[\"Tech\"],\"content\":[\"<p>原标题：视觉中国开盘封死跌停 柴继军身价瞬间缩水1.3亿</p><p>　　4月12日早盘，视觉中国开盘无悬念跌停，封单近41万手，报25.20元/股，一夜间总市值从196亿元缩水至176.5亿元，市值蒸发19.6亿元。</p><p>　　早些时候，视觉中国发公告称，天津市互联网信息办公室依法约谈其网站负责人，责令公司网站全面彻底整改并在此期间暂时关闭网站。</p><p>　　4月11日，因“人类首张黑洞照片”版权标注问题，A股上市公司视觉中国陷入舆论风暴。网友和机构随即发现，国旗国徽也被视觉中国打了版权售卖。国徽图片页面“价格提示”显示，“用于内文不低于150元，整版跨页不低于500元，杂志封面不低于1000元，商业使用价格另议。”虽然连续发声明解释、道歉，但是网友并不买账，直至该公司关闭网站。</p><p>　　根据计划，视觉中国4月12日有3.88亿股限售股上市流通，占公司总股本比例的55.39%。此次解禁是五年前视觉中国借壳远东股份所定向增发的股份，当时定增发行价为5.28元/股，五年期间未实施过股份送转。</p>\"],\"metaTitle\":[\"你好\"],\"metaKeywords\":[\"我好\"],\"metaDescription\":[\"大家好\"]}', '127.0.0.1', '2019-04-18 21:07:45');
INSERT INTO `sys_log` VALUES ('1118871889532469249', '1', 'admin', '登录', '56', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-18 21:40:21');
INSERT INTO `sys_log` VALUES ('1118871985900797954', '1', 'admin', '修改', '8454', 'POST /cms/nav/update', '{}', '127.0.0.1', '2019-04-18 21:40:44');
INSERT INTO `sys_log` VALUES ('1118871986274091009', '1', 'admin', '修改', '6', 'POST /cms/nav/update', '{}', '127.0.0.1', '2019-04-18 21:40:44');
INSERT INTO `sys_log` VALUES ('1118906562748952577', '1', 'admin', '登录', '38', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-18 23:58:07');
INSERT INTO `sys_log` VALUES ('1118906612673753089', '1', 'admin', '修改文章表', '321', 'POST /cms/article/update', '{\"id\":[\"17\"],\"title\":[\"123\"],\"summary\":[\"123\"],\"author\":[\"123\"],\"style\":[\"4\"],\"thumbnail\":[\"\"],\"social[0][type]\":[\"Fackbook\"],\"social[0][url]\":[\"http://www.baidu.com\"],\"social[0][order]\":[\"2\"],\"social[1][type]\":[\"\"],\"social[1][url]\":[\"\"],\"social[1][order]\":[\"\"],\"social[2][type]\":[\"\"],\"social[2][url]\":[\"\"],\"social[2][order]\":[\"\"],\"social[3][type]\":[\"\"],\"social[3][url]\":[\"\"],\"social[3][order]\":[\"\"],\"social[4][type]\":[\"\"],\"social[4][url]\":[\"\"],\"social[4][order]\":[\"\"],\"tag[0]\":[\"123\"],\"tag[1]\":[\"dada\"],\"tag[2]\":[\"hao\"],\"content\":[\"<p style=\\\"text-align: center;\\\">Balala...</p><p style=\\\"text-align: center;\\\">sfasfasfoajhfoewnfpowufe hwjefnwoehfauwehfwo;efjowihfwjebnfwefhj</p><p style=\\\"text-align: center;\\\">wnefojwhnefowefjwbfeowehfwjebfwoefhewjfn</p>\"],\"metaTitle\":[\"\"],\"metaKeywords\":[\"\"],\"metaDescription\":[\"\"]}', '127.0.0.1', '2019-04-18 23:58:19');
INSERT INTO `sys_log` VALUES ('1118906678205558785', '1', 'admin', '删除', '54', 'POST /cms/tag/remove', '{\"id\":[\"1\"]}', '127.0.0.1', '2019-04-18 23:58:35');
INSERT INTO `sys_log` VALUES ('1118907326061998081', '1', 'admin', '登录', '199', 'POST /login', '{\"username\":[\"admin\"],\"password\":[\"1\"]}', '127.0.0.1', '2019-04-19 00:01:09');
INSERT INTO `sys_log` VALUES ('1118907465812013058', '1', 'admin', '修改文章表', '310', 'POST /cms/article/update', '{\"id\":[\"17\"],\"title\":[\"123\"],\"summary\":[\"123\"],\"author\":[\"123\"],\"style\":[\"4\"],\"thumbnail\":[\"\"],\"social[0][type]\":[\"Fackbook\"],\"social[0][url]\":[\"http://www.baidu.com\"],\"social[0][order]\":[\"2\"],\"social[1][type]\":[\"Linkedin\"],\"social[1][url]\":[\"http://www.qq.com\"],\"social[1][order]\":[\"1\"],\"social[2][type]\":[\"\"],\"social[2][url]\":[\"\"],\"social[2][order]\":[\"\"],\"social[3][type]\":[\"\"],\"social[3][url]\":[\"\"],\"social[3][order]\":[\"\"],\"social[4][type]\":[\"\"],\"social[4][url]\":[\"\"],\"social[4][order]\":[\"\"],\"tag[0]\":[\"123\"],\"tag[1]\":[\"Tom\"],\"tag[2]\":[\"Alex\"],\"content\":[\"<p style=\\\"text-align: center;\\\">Balala...</p><p style=\\\"text-align: center;\\\">sfasfasfoajhfoewnfpowufe hwjefnwoehfauwehfwo;efjowihfwjebnfwefhj</p><p style=\\\"text-align: center;\\\">wnefojwhnefowefjwbfeowehfwjebfwoefhewjfn</p>\"],\"metaTitle\":[\"\"],\"metaKeywords\":[\"\"],\"metaDescription\":[\"\"]}', '127.0.0.1', '2019-04-19 00:01:43');
INSERT INTO `sys_log` VALUES ('1118907549207359489', '1', 'admin', '删除', '112', 'POST /cms/tag/remove', '{\"id\":[\"1\"]}', '127.0.0.1', '2019-04-19 00:02:03');
INSERT INTO `sys_log` VALUES ('1118908854827085825', '1', 'admin', '修改文章表', '279', 'POST /cms/article/update', '{\"id\":[\"17\"],\"title\":[\"Don T Let The Outtakes Take You Out Don T Let The Outtakes Take You ...\"],\"summary\":[\"Nullam quis risus eget urna mollis ornare vel eu leo. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Nullam quis risus eget urna mollis ornare vel eu leo. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis ……\"],\"author\":[\"Vincent\"],\"style\":[\"4\"],\"thumbnail\":[\"\"],\"social[0][type]\":[\"Fackbook\"],\"social[0][url]\":[\"http://www.baidu.com\"],\"social[0][order]\":[\"2\"],\"social[1][type]\":[\"Linkedin\"],\"social[1][url]\":[\"http://www.qq.com\"],\"social[1][order]\":[\"1\"],\"social[2][type]\":[\"\"],\"social[2][url]\":[\"\"],\"social[2][order]\":[\"\"],\"social[3][type]\":[\"\"],\"social[3][url]\":[\"\"],\"social[3][order]\":[\"\"],\"social[4][type]\":[\"\"],\"social[4][url]\":[\"\"],\"social[4][order]\":[\"\"],\"tag[0]\":[\"Mask\"],\"tag[1]\":[\"Alex\"],\"tag[2]\":[\"Vincent\"],\"content\":[\"<p style=\\\"text-align: center;\\\">Balala...</p><p style=\\\"text-align: center;\\\">sfasfasfoajhfoewnfpowufe hwjefnwoehfauwehfwo;efjowihfwjebnfwefhj</p><p style=\\\"text-align: center;\\\">wnefojwhnefowefjwbfeowehfwjebfwoefhewjfn</p>\"],\"metaTitle\":[\"\"],\"metaKeywords\":[\"\"],\"metaDescription\":[\"\"]}', '127.0.0.1', '2019-04-19 00:07:14');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parentId` bigint(20) DEFAULT NULL COMMENT '父菜单ID，一级菜单为0',
  `name` varchar(50) DEFAULT NULL COMMENT '菜单名称',
  `url` varchar(200) DEFAULT NULL COMMENT '菜单URL',
  `perms` varchar(500) DEFAULT NULL COMMENT '授权(多个用逗号分隔，如：user:list,user:create)',
  `type` int(11) DEFAULT NULL COMMENT '类型   0：目录   1：菜单   2：按钮',
  `icon` varchar(50) DEFAULT NULL COMMENT '菜单图标',
  `orderNum` int(11) DEFAULT NULL COMMENT '排序',
  `gmtCreate` datetime DEFAULT NULL COMMENT '创建时间',
  `gmtModified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1115184208369717293 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='菜单管理';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('1', '0', '基础管理', '', '', '0', 'fa fa-bars', '4', '2017-08-09 22:49:47', null);
INSERT INTO `sys_menu` VALUES ('2', '3', '系统菜单', '/sys/menu/', 'sys:menu:menu', '1', 'fa fa-th-list', '2', '2017-08-09 22:55:15', null);
INSERT INTO `sys_menu` VALUES ('3', '0', '系统管理', '', '', '0', 'fa fa-desktop', '5', '2017-08-09 23:06:55', '2017-08-14 14:13:43');
INSERT INTO `sys_menu` VALUES ('6', '3', '用户管理', '/sys/user/', 'sys:user:user', '1', 'fa fa-user', '0', '2017-08-10 14:12:11', null);
INSERT INTO `sys_menu` VALUES ('7', '3', '角色管理', '/sys/role', 'sys:role:role', '1', 'fa fa-paw', '1', '2017-08-10 14:13:19', null);
INSERT INTO `sys_menu` VALUES ('12', '6', '新增', '', 'sys:user:add', '2', '', '0', '2017-08-14 10:51:35', null);
INSERT INTO `sys_menu` VALUES ('13', '6', '编辑', '', 'sys:user:edit', '2', '', '0', '2017-08-14 10:52:06', null);
INSERT INTO `sys_menu` VALUES ('14', '6', '删除', null, 'sys:user:remove', '2', null, '0', '2017-08-14 10:52:24', null);
INSERT INTO `sys_menu` VALUES ('15', '7', '新增', '', 'sys:role:add', '2', '', '0', '2017-08-14 10:56:37', null);
INSERT INTO `sys_menu` VALUES ('20', '2', '新增', '', 'sys:menu:add', '2', '', '0', '2017-08-14 10:59:32', null);
INSERT INTO `sys_menu` VALUES ('21', '2', '编辑', '', 'sys:menu:edit', '2', '', '0', '2017-08-14 10:59:56', null);
INSERT INTO `sys_menu` VALUES ('22', '2', '删除', '', 'sys:menu:remove', '2', '', '0', '2017-08-14 11:00:26', null);
INSERT INTO `sys_menu` VALUES ('24', '6', '批量删除', '', 'sys:user:batchRemove', '2', '', '0', '2017-08-14 17:27:18', null);
INSERT INTO `sys_menu` VALUES ('25', '6', '停用', null, 'sys:user:disable', '2', null, '0', '2017-08-14 17:27:43', null);
INSERT INTO `sys_menu` VALUES ('26', '6', '重置密码', '', 'sys:user:resetPwd', '2', '', '0', '2017-08-14 17:28:34', null);
INSERT INTO `sys_menu` VALUES ('27', '91', '系统日志', '/common/log', 'common:log', '1', 'fa fa-warning', '0', '2017-08-14 22:11:53', null);
INSERT INTO `sys_menu` VALUES ('28', '27', '刷新', null, 'sys:log:list', '2', null, '0', '2017-08-14 22:30:22', null);
INSERT INTO `sys_menu` VALUES ('29', '27', '删除', null, 'sys:log:remove', '2', null, '0', '2017-08-14 22:30:43', null);
INSERT INTO `sys_menu` VALUES ('30', '27', '清空', null, 'sys:log:clear', '2', null, '0', '2017-08-14 22:31:02', null);
INSERT INTO `sys_menu` VALUES ('48', '77', '代码生成', '/common/generator', 'common:generator', '1', 'fa fa-code', '3', null, null);
INSERT INTO `sys_menu` VALUES ('55', '7', '编辑', '', 'sys:role:edit', '2', '', null, null, null);
INSERT INTO `sys_menu` VALUES ('56', '7', '删除', '', 'sys:role:remove', '2', null, null, null, null);
INSERT INTO `sys_menu` VALUES ('57', '91', '运行监控', '/druid/index.html', '', '1', 'fa fa-caret-square-o-right', '1', null, null);
INSERT INTO `sys_menu` VALUES ('61', '2', '批量删除', '', 'sys:menu:batchRemove', '2', null, null, null, null);
INSERT INTO `sys_menu` VALUES ('62', '7', '批量删除', '', 'sys:role:batchRemove', '2', null, null, null, null);
INSERT INTO `sys_menu` VALUES ('71', '1', '文件管理', '/common/sysFile', 'oss:file:file', '1', 'fa fa-folder-open', '2', null, null);
INSERT INTO `sys_menu` VALUES ('73', '3', '部门管理', '/sys/dept', 'system:sysDept:sysDept', '1', 'fa fa-users', '3', null, null);
INSERT INTO `sys_menu` VALUES ('74', '73', '增加', '/sys/dept/add', 'system:sysDept:add', '2', null, '1', null, null);
INSERT INTO `sys_menu` VALUES ('75', '73', '刪除', '/sys/dept/remove', 'system:sysDept:remove', '2', null, '2', null, null);
INSERT INTO `sys_menu` VALUES ('76', '73', '编辑', '/sys/dept/edit', 'system:sysDept:edit', '2', null, '3', null, null);
INSERT INTO `sys_menu` VALUES ('77', '0', '系统工具', '', '', '0', 'fa fa-gear', '4', null, null);
INSERT INTO `sys_menu` VALUES ('78', '1', '数据字典', '/common/sysDict', 'common:sysDict:sysDict', '1', 'fa fa-book', '1', null, null);
INSERT INTO `sys_menu` VALUES ('79', '78', '增加', '/common/sysDict/add', 'common:sysDict:add', '2', null, '2', null, null);
INSERT INTO `sys_menu` VALUES ('80', '78', '编辑', '/common/sysDict/edit', 'common:sysDict:edit', '2', null, '2', null, null);
INSERT INTO `sys_menu` VALUES ('81', '78', '删除', '/common/sysDict/remove', 'common:sysDict:remove', '2', '', '3', null, null);
INSERT INTO `sys_menu` VALUES ('83', '78', '批量删除', '/common/sysDict/batchRemove', 'common:sysDict:batchRemove', '2', '', '4', null, null);
INSERT INTO `sys_menu` VALUES ('91', '0', '系统监控', '', '', '0', 'fa fa-video-camera', '5', null, null);
INSERT INTO `sys_menu` VALUES ('92', '91', '在线用户', '/sys/online', '', '1', 'fa fa-user', null, null, null);
INSERT INTO `sys_menu` VALUES ('97', '0', '图表管理', '', '', '0', 'fa fa-bar-chart', '7', null, null);
INSERT INTO `sys_menu` VALUES ('98', '97', '百度chart', '/chart/graph_echarts.html', '', '1', 'fa fa-area-chart', null, null, null);
INSERT INTO `sys_menu` VALUES ('175', '1', '系统配置', '/common/config', null, '1', 'fa fa-file-code-o', '6', null, null);
INSERT INTO `sys_menu` VALUES ('176', '175', '查看', '', 'common:config:config', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('177', '175', '新增', null, 'common:config:add', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('178', '175', '修改', null, 'common:config:edit', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('179', '175', '删除', null, 'common:config:remove', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('180', '175', '批量删除', null, 'common:config:batchRemove', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('181', '199', '公众号管理', '/wxmp/mpConfig', null, '1', 'fa fa-file-code-o', '6', null, null);
INSERT INTO `sys_menu` VALUES ('182', '181', '查看', null, 'wxmp:mpConfig:mpConfig', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('183', '181', '新增', null, 'wxmp:mpConfig:add', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('184', '181', '修改', null, 'wxmp:mpConfig:edit', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('185', '181', '删除', null, 'wxmp:mpConfig:remove', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('186', '181', '批量删除', null, 'wxmp:mpConfig:batchRemove', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('187', '199', '微信粉丝表', '/wxmp/mpFans', null, '1', 'fa fa-file-code-o', '6', null, null);
INSERT INTO `sys_menu` VALUES ('188', '187', '查看', null, 'wxmp:mpFans:mpFans', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('189', '187', '新增', null, 'wxmp:mpFans:add', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('190', '187', '修改', null, 'wxmp:mpFans:edit', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('191', '187', '删除', null, 'wxmp:mpFans:remove', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('192', '187', '批量删除', null, 'wxmp:mpFans:batchRemove', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('193', '71', '增加', '/common/sysFile/add', 'oss:file:add', '2', null, null, null, null);
INSERT INTO `sys_menu` VALUES ('194', '71', '列表', '/common/sysFile/list', 'oss:file:list', '2', null, null, null, null);
INSERT INTO `sys_menu` VALUES ('195', '71', '编辑', '/common/sysFile/edit', 'oss:file:update', '2', null, null, null, null);
INSERT INTO `sys_menu` VALUES ('196', '71', '查询', '/common/sysFile/info', 'oss:file:info', '2', null, null, null, null);
INSERT INTO `sys_menu` VALUES ('197', '71', '删除', '/common/sysFile/remove', 'oss:file:remove', '2', null, null, null, null);
INSERT INTO `sys_menu` VALUES ('199', '0', '微信公众号', null, null, '0', 'fa fa-file-code-o', '3', null, null);
INSERT INTO `sys_menu` VALUES ('205', '187', '同步', null, 'wxmp:mpFans:sync', '2', 'fa fa-refresh', '5', null, null);
INSERT INTO `sys_menu` VALUES ('206', '1', '[Demo]基础表', '/demo/demoBase', '', '1', 'fa fa-file-code-o', '6', null, null);
INSERT INTO `sys_menu` VALUES ('207', '206', '查看', null, 'demo:demoBase:demoBase', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('208', '206', '新增', null, 'demo:demoBase:add', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('209', '206', '修改', null, 'demo:demoBase:edit', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('210', '206', '删除', null, 'demo:demoBase:remove', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('211', '206', '批量删除', null, 'demo:demoBase:batchRemove', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('1034089959238385666', '0', 'api测试-用户更新', '', 'api:user:update', '2', '', null, null, null);
INSERT INTO `sys_menu` VALUES ('1034090238251876354', '0', 'api测试-appUser角色', '', 'api:user:role', '2', '', null, null, null);
INSERT INTO `sys_menu` VALUES ('1115179024377745410', '0', '内容模块', '', '', '0', 'fa fa-pencil-square-o', '0', null, null);
INSERT INTO `sys_menu` VALUES ('1115182776430137345', '0', '商品模块', '', '', '0', 'fa fa-pencil-square-o', '1', null, null);
INSERT INTO `sys_menu` VALUES ('1115183012166799361', '0', '运营管理', '', '', '0', 'fa fa-tasks', '2', null, null);
INSERT INTO `sys_menu` VALUES ('1115183127149449218', '0', '个人设置', '', '', '0', 'fa fa-address-card-o', '3', null, null);
INSERT INTO `sys_menu` VALUES ('1115183213711495170', '1115183127149449218', '个人资料', '/sys/user/personal', '', '1', '', null, null, null);
INSERT INTO `sys_menu` VALUES ('1115183247500808194', '1115183127149449218', '我的通知', '', '', '1', '', null, null, null);
INSERT INTO `sys_menu` VALUES ('1115183444654067714', '1115183012166799361', '首页管理', '/common/config', '', '1', '', '2', null, null);
INSERT INTO `sys_menu` VALUES ('1115184160676286466', '1115183012166799361', '消息管理', '/common/log', '', '1', '', '3', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717250', '1115183012166799361', '媒体管理', '/common/sysFile', '', '1', '', '4', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717251', '1115179024377745410', '文章内容管理', '/cms/article', '', '1', 'fa fa-file-code-o', '1', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717252', '1115184208369717251', '查看', null, 'cms:article:article', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717253', '1115184208369717251', '新增', null, 'cms:article:add', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717254', '1115184208369717251', '修改', null, 'cms:article:edit', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717255', '1115184208369717251', '删除', null, 'cms:article:remove', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717256', '1115184208369717251', '批量删除', null, 'cms:article:batchRemove', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717257', '1115182776430137345', '商品类别管理', '/cms/category', '', '1', 'fa fa-file-code-o', '1', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717258', '1115184208369717257', '查看', null, 'cms:category:category', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717259', '1115184208369717257', '新增', null, 'cms:category:add', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717260', '1115184208369717257', '修改', null, 'cms:category:edit', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717261', '1115184208369717257', '删除', null, 'cms:category:remove', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717262', '1115184208369717257', '批量删除', null, 'cms:category:batchRemove', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717263', '1115179024377745410', '活动内容管理', '/cms/event', '', '1', 'fa fa-file-code-o', '2', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717264', '1115184208369717263', '查看', null, 'cms:event:event', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717265', '1115184208369717263', '新增', null, 'cms:event:add', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717266', '1115184208369717263', '修改', null, 'cms:event:edit', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717267', '1115184208369717263', '删除', null, 'cms:event:remove', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717268', '1115184208369717263', '批量删除', null, 'cms:event:batchRemove', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717269', '1115182776430137345', '商品管理', '/cms/product', '', '1', 'fa fa-shopping-bag', '2', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717270', '1115184208369717269', '查看', null, 'cms:product:product', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717271', '1115184208369717269', '新增', null, 'cms:product:add', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717272', '1115184208369717269', '修改', null, 'cms:product:edit', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717273', '1115184208369717269', '删除', null, 'cms:product:remove', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717274', '1115184208369717269', '批量删除', null, 'cms:product:batchRemove', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717275', '1115183012166799361', '导航管理', '/cms/nav', '', '1', 'fa fa-file-code-o', '1', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717276', '1115184208369717275', '查看', null, 'cms:nav:nav', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717277', '1115184208369717275', '新增', null, 'cms:nav:add', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717278', '1115184208369717275', '修改', null, 'cms:nav:edit', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717279', '1115184208369717275', '删除', null, 'cms:nav:remove', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717280', '1115184208369717275', '批量删除', null, 'cms:nav:batchRemove', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717281', '1115184208369717275', '网页内容', '', null, '1', 'fa fa-file-code-o', '6', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717282', '1115184208369717281', '查看', null, 'cms:website:website', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717283', '1115184208369717281', '新增', null, 'cms:website:add', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717284', '1115184208369717281', '修改', null, 'cms:website:edit', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717285', '1115184208369717281', '删除', null, 'cms:website:remove', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717286', '1115184208369717281', '批量删除', null, 'cms:website:batchRemove', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717287', '1115183012166799361', '标签管理', '/cms/tag', null, '1', 'fa fa-file-code-o', '6', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717288', '1115184208369717287', '查看', null, 'cms:tag:tag', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717289', '1115184208369717287', '新增', null, 'cms:tag:add', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717290', '1115184208369717287', '修改', null, 'cms:tag:edit', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717291', '1115184208369717287', '删除', null, 'cms:tag:remove', '2', null, '6', null, null);
INSERT INTO `sys_menu` VALUES ('1115184208369717292', '1115184208369717287', '批量删除', null, 'cms:tag:batchRemove', '2', null, '6', null, null);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `roleName` varchar(100) DEFAULT NULL COMMENT '角色名称',
  `roleSign` varchar(100) DEFAULT NULL COMMENT '角色标识',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `userIdCreate` bigint(255) DEFAULT NULL COMMENT '创建用户id',
  `gmtCreate` datetime DEFAULT NULL COMMENT '创建时间',
  `gmtModified` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1034088931742957570 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='角色';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '超级管理员', 'adminRole', '超级管理员', '2', '2017-08-12 00:43:52', '2017-08-12 19:14:59');
INSERT INTO `sys_role` VALUES ('56', '普通用户', null, '普通用户', null, null, null);
INSERT INTO `sys_role` VALUES ('1034088931742957569', '前端API', 'apiRole', '前端API', null, null, null);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `roleId` bigint(20) DEFAULT NULL COMMENT '角色ID',
  `menuId` bigint(20) DEFAULT NULL COMMENT '菜单ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5349 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='角色与菜单对应关系';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES ('367', '44', '1');
INSERT INTO `sys_role_menu` VALUES ('368', '44', '32');
INSERT INTO `sys_role_menu` VALUES ('369', '44', '33');
INSERT INTO `sys_role_menu` VALUES ('370', '44', '34');
INSERT INTO `sys_role_menu` VALUES ('371', '44', '35');
INSERT INTO `sys_role_menu` VALUES ('372', '44', '28');
INSERT INTO `sys_role_menu` VALUES ('373', '44', '29');
INSERT INTO `sys_role_menu` VALUES ('374', '44', '30');
INSERT INTO `sys_role_menu` VALUES ('375', '44', '38');
INSERT INTO `sys_role_menu` VALUES ('376', '44', '4');
INSERT INTO `sys_role_menu` VALUES ('377', '44', '27');
INSERT INTO `sys_role_menu` VALUES ('378', '45', '38');
INSERT INTO `sys_role_menu` VALUES ('379', '46', '3');
INSERT INTO `sys_role_menu` VALUES ('380', '46', '20');
INSERT INTO `sys_role_menu` VALUES ('381', '46', '21');
INSERT INTO `sys_role_menu` VALUES ('382', '46', '22');
INSERT INTO `sys_role_menu` VALUES ('383', '46', '23');
INSERT INTO `sys_role_menu` VALUES ('384', '46', '11');
INSERT INTO `sys_role_menu` VALUES ('385', '46', '12');
INSERT INTO `sys_role_menu` VALUES ('386', '46', '13');
INSERT INTO `sys_role_menu` VALUES ('387', '46', '14');
INSERT INTO `sys_role_menu` VALUES ('388', '46', '24');
INSERT INTO `sys_role_menu` VALUES ('389', '46', '25');
INSERT INTO `sys_role_menu` VALUES ('390', '46', '26');
INSERT INTO `sys_role_menu` VALUES ('391', '46', '15');
INSERT INTO `sys_role_menu` VALUES ('392', '46', '2');
INSERT INTO `sys_role_menu` VALUES ('393', '46', '6');
INSERT INTO `sys_role_menu` VALUES ('394', '46', '7');
INSERT INTO `sys_role_menu` VALUES ('598', '50', '38');
INSERT INTO `sys_role_menu` VALUES ('632', '38', '42');
INSERT INTO `sys_role_menu` VALUES ('737', '51', '38');
INSERT INTO `sys_role_menu` VALUES ('738', '51', '39');
INSERT INTO `sys_role_menu` VALUES ('739', '51', '40');
INSERT INTO `sys_role_menu` VALUES ('740', '51', '41');
INSERT INTO `sys_role_menu` VALUES ('741', '51', '4');
INSERT INTO `sys_role_menu` VALUES ('742', '51', '32');
INSERT INTO `sys_role_menu` VALUES ('743', '51', '33');
INSERT INTO `sys_role_menu` VALUES ('744', '51', '34');
INSERT INTO `sys_role_menu` VALUES ('745', '51', '35');
INSERT INTO `sys_role_menu` VALUES ('746', '51', '27');
INSERT INTO `sys_role_menu` VALUES ('747', '51', '28');
INSERT INTO `sys_role_menu` VALUES ('748', '51', '29');
INSERT INTO `sys_role_menu` VALUES ('749', '51', '30');
INSERT INTO `sys_role_menu` VALUES ('750', '51', '1');
INSERT INTO `sys_role_menu` VALUES ('1064', '54', '53');
INSERT INTO `sys_role_menu` VALUES ('1095', '55', '2');
INSERT INTO `sys_role_menu` VALUES ('1096', '55', '6');
INSERT INTO `sys_role_menu` VALUES ('1097', '55', '7');
INSERT INTO `sys_role_menu` VALUES ('1098', '55', '3');
INSERT INTO `sys_role_menu` VALUES ('1099', '55', '50');
INSERT INTO `sys_role_menu` VALUES ('1100', '55', '49');
INSERT INTO `sys_role_menu` VALUES ('1101', '55', '1');
INSERT INTO `sys_role_menu` VALUES ('1856', '53', '28');
INSERT INTO `sys_role_menu` VALUES ('1857', '53', '29');
INSERT INTO `sys_role_menu` VALUES ('1858', '53', '30');
INSERT INTO `sys_role_menu` VALUES ('1859', '53', '27');
INSERT INTO `sys_role_menu` VALUES ('1860', '53', '57');
INSERT INTO `sys_role_menu` VALUES ('1861', '53', '71');
INSERT INTO `sys_role_menu` VALUES ('1862', '53', '48');
INSERT INTO `sys_role_menu` VALUES ('1863', '53', '72');
INSERT INTO `sys_role_menu` VALUES ('1864', '53', '1');
INSERT INTO `sys_role_menu` VALUES ('1865', '53', '7');
INSERT INTO `sys_role_menu` VALUES ('1866', '53', '55');
INSERT INTO `sys_role_menu` VALUES ('1867', '53', '56');
INSERT INTO `sys_role_menu` VALUES ('1868', '53', '62');
INSERT INTO `sys_role_menu` VALUES ('1869', '53', '15');
INSERT INTO `sys_role_menu` VALUES ('1870', '53', '2');
INSERT INTO `sys_role_menu` VALUES ('1871', '53', '61');
INSERT INTO `sys_role_menu` VALUES ('1872', '53', '20');
INSERT INTO `sys_role_menu` VALUES ('1873', '53', '21');
INSERT INTO `sys_role_menu` VALUES ('1874', '53', '22');
INSERT INTO `sys_role_menu` VALUES ('2247', '63', '-1');
INSERT INTO `sys_role_menu` VALUES ('2248', '63', '84');
INSERT INTO `sys_role_menu` VALUES ('2249', '63', '85');
INSERT INTO `sys_role_menu` VALUES ('2250', '63', '88');
INSERT INTO `sys_role_menu` VALUES ('2251', '63', '87');
INSERT INTO `sys_role_menu` VALUES ('2252', '64', '84');
INSERT INTO `sys_role_menu` VALUES ('2253', '64', '89');
INSERT INTO `sys_role_menu` VALUES ('2254', '64', '88');
INSERT INTO `sys_role_menu` VALUES ('2255', '64', '87');
INSERT INTO `sys_role_menu` VALUES ('2256', '64', '86');
INSERT INTO `sys_role_menu` VALUES ('2257', '64', '85');
INSERT INTO `sys_role_menu` VALUES ('2258', '65', '89');
INSERT INTO `sys_role_menu` VALUES ('2259', '65', '88');
INSERT INTO `sys_role_menu` VALUES ('2260', '65', '86');
INSERT INTO `sys_role_menu` VALUES ('2262', '67', '48');
INSERT INTO `sys_role_menu` VALUES ('2263', '68', '88');
INSERT INTO `sys_role_menu` VALUES ('2264', '68', '87');
INSERT INTO `sys_role_menu` VALUES ('2265', '69', '89');
INSERT INTO `sys_role_menu` VALUES ('2266', '69', '88');
INSERT INTO `sys_role_menu` VALUES ('2267', '69', '86');
INSERT INTO `sys_role_menu` VALUES ('2268', '69', '87');
INSERT INTO `sys_role_menu` VALUES ('2269', '69', '85');
INSERT INTO `sys_role_menu` VALUES ('2270', '69', '84');
INSERT INTO `sys_role_menu` VALUES ('2271', '70', '85');
INSERT INTO `sys_role_menu` VALUES ('2272', '70', '89');
INSERT INTO `sys_role_menu` VALUES ('2273', '70', '88');
INSERT INTO `sys_role_menu` VALUES ('2274', '70', '87');
INSERT INTO `sys_role_menu` VALUES ('2275', '70', '86');
INSERT INTO `sys_role_menu` VALUES ('2276', '70', '84');
INSERT INTO `sys_role_menu` VALUES ('2277', '71', '87');
INSERT INTO `sys_role_menu` VALUES ('2278', '72', '59');
INSERT INTO `sys_role_menu` VALUES ('2279', '73', '48');
INSERT INTO `sys_role_menu` VALUES ('2280', '74', '88');
INSERT INTO `sys_role_menu` VALUES ('2281', '74', '87');
INSERT INTO `sys_role_menu` VALUES ('2282', '75', '88');
INSERT INTO `sys_role_menu` VALUES ('2283', '75', '87');
INSERT INTO `sys_role_menu` VALUES ('2284', '76', '85');
INSERT INTO `sys_role_menu` VALUES ('2285', '76', '89');
INSERT INTO `sys_role_menu` VALUES ('2286', '76', '88');
INSERT INTO `sys_role_menu` VALUES ('2287', '76', '87');
INSERT INTO `sys_role_menu` VALUES ('2288', '76', '86');
INSERT INTO `sys_role_menu` VALUES ('2289', '76', '84');
INSERT INTO `sys_role_menu` VALUES ('2292', '78', '88');
INSERT INTO `sys_role_menu` VALUES ('2293', '78', '87');
INSERT INTO `sys_role_menu` VALUES ('2294', '78', null);
INSERT INTO `sys_role_menu` VALUES ('2295', '78', null);
INSERT INTO `sys_role_menu` VALUES ('2296', '78', null);
INSERT INTO `sys_role_menu` VALUES ('2308', '80', '87');
INSERT INTO `sys_role_menu` VALUES ('2309', '80', '86');
INSERT INTO `sys_role_menu` VALUES ('2310', '80', '-1');
INSERT INTO `sys_role_menu` VALUES ('2311', '80', '84');
INSERT INTO `sys_role_menu` VALUES ('2312', '80', '85');
INSERT INTO `sys_role_menu` VALUES ('2328', '79', '72');
INSERT INTO `sys_role_menu` VALUES ('2329', '79', '48');
INSERT INTO `sys_role_menu` VALUES ('2330', '79', '77');
INSERT INTO `sys_role_menu` VALUES ('2331', '79', '84');
INSERT INTO `sys_role_menu` VALUES ('2332', '79', '89');
INSERT INTO `sys_role_menu` VALUES ('2333', '79', '88');
INSERT INTO `sys_role_menu` VALUES ('2334', '79', '87');
INSERT INTO `sys_role_menu` VALUES ('2335', '79', '86');
INSERT INTO `sys_role_menu` VALUES ('2336', '79', '85');
INSERT INTO `sys_role_menu` VALUES ('2337', '79', '-1');
INSERT INTO `sys_role_menu` VALUES ('2338', '77', '89');
INSERT INTO `sys_role_menu` VALUES ('2339', '77', '88');
INSERT INTO `sys_role_menu` VALUES ('2340', '77', '87');
INSERT INTO `sys_role_menu` VALUES ('2341', '77', '86');
INSERT INTO `sys_role_menu` VALUES ('2342', '77', '85');
INSERT INTO `sys_role_menu` VALUES ('2343', '77', '84');
INSERT INTO `sys_role_menu` VALUES ('2344', '77', '72');
INSERT INTO `sys_role_menu` VALUES ('2345', '77', '-1');
INSERT INTO `sys_role_menu` VALUES ('2346', '77', '77');
INSERT INTO `sys_role_menu` VALUES ('3178', '56', '68');
INSERT INTO `sys_role_menu` VALUES ('3179', '56', '60');
INSERT INTO `sys_role_menu` VALUES ('3180', '56', '59');
INSERT INTO `sys_role_menu` VALUES ('3181', '56', '58');
INSERT INTO `sys_role_menu` VALUES ('3182', '56', '51');
INSERT INTO `sys_role_menu` VALUES ('3183', '56', '50');
INSERT INTO `sys_role_menu` VALUES ('3184', '56', '49');
INSERT INTO `sys_role_menu` VALUES ('3185', '56', '-1');
INSERT INTO `sys_role_menu` VALUES ('4544', '1034088931742957569', '1034089959238385666');
INSERT INTO `sys_role_menu` VALUES ('4545', '1034088931742957569', '1034090238251876354');
INSERT INTO `sys_role_menu` VALUES ('4546', '1034088931742957569', '-1');
INSERT INTO `sys_role_menu` VALUES ('5242', '1', '193');
INSERT INTO `sys_role_menu` VALUES ('5243', '1', '194');
INSERT INTO `sys_role_menu` VALUES ('5244', '1', '195');
INSERT INTO `sys_role_menu` VALUES ('5245', '1', '196');
INSERT INTO `sys_role_menu` VALUES ('5246', '1', '197');
INSERT INTO `sys_role_menu` VALUES ('5247', '1', '79');
INSERT INTO `sys_role_menu` VALUES ('5248', '1', '80');
INSERT INTO `sys_role_menu` VALUES ('5249', '1', '81');
INSERT INTO `sys_role_menu` VALUES ('5250', '1', '83');
INSERT INTO `sys_role_menu` VALUES ('5251', '1', '176');
INSERT INTO `sys_role_menu` VALUES ('5252', '1', '177');
INSERT INTO `sys_role_menu` VALUES ('5253', '1', '178');
INSERT INTO `sys_role_menu` VALUES ('5254', '1', '179');
INSERT INTO `sys_role_menu` VALUES ('5255', '1', '180');
INSERT INTO `sys_role_menu` VALUES ('5256', '1', '207');
INSERT INTO `sys_role_menu` VALUES ('5257', '1', '208');
INSERT INTO `sys_role_menu` VALUES ('5258', '1', '209');
INSERT INTO `sys_role_menu` VALUES ('5259', '1', '210');
INSERT INTO `sys_role_menu` VALUES ('5260', '1', '211');
INSERT INTO `sys_role_menu` VALUES ('5261', '1', '20');
INSERT INTO `sys_role_menu` VALUES ('5262', '1', '21');
INSERT INTO `sys_role_menu` VALUES ('5263', '1', '22');
INSERT INTO `sys_role_menu` VALUES ('5264', '1', '61');
INSERT INTO `sys_role_menu` VALUES ('5265', '1', '12');
INSERT INTO `sys_role_menu` VALUES ('5266', '1', '13');
INSERT INTO `sys_role_menu` VALUES ('5267', '1', '14');
INSERT INTO `sys_role_menu` VALUES ('5268', '1', '24');
INSERT INTO `sys_role_menu` VALUES ('5269', '1', '25');
INSERT INTO `sys_role_menu` VALUES ('5270', '1', '26');
INSERT INTO `sys_role_menu` VALUES ('5271', '1', '15');
INSERT INTO `sys_role_menu` VALUES ('5272', '1', '55');
INSERT INTO `sys_role_menu` VALUES ('5273', '1', '56');
INSERT INTO `sys_role_menu` VALUES ('5274', '1', '62');
INSERT INTO `sys_role_menu` VALUES ('5275', '1', '74');
INSERT INTO `sys_role_menu` VALUES ('5276', '1', '75');
INSERT INTO `sys_role_menu` VALUES ('5277', '1', '76');
INSERT INTO `sys_role_menu` VALUES ('5278', '1', '48');
INSERT INTO `sys_role_menu` VALUES ('5279', '1', '28');
INSERT INTO `sys_role_menu` VALUES ('5280', '1', '29');
INSERT INTO `sys_role_menu` VALUES ('5281', '1', '30');
INSERT INTO `sys_role_menu` VALUES ('5282', '1', '57');
INSERT INTO `sys_role_menu` VALUES ('5283', '1', '92');
INSERT INTO `sys_role_menu` VALUES ('5284', '1', '1115184208369717252');
INSERT INTO `sys_role_menu` VALUES ('5285', '1', '1115184208369717253');
INSERT INTO `sys_role_menu` VALUES ('5286', '1', '1115184208369717254');
INSERT INTO `sys_role_menu` VALUES ('5287', '1', '1115184208369717255');
INSERT INTO `sys_role_menu` VALUES ('5288', '1', '1115184208369717256');
INSERT INTO `sys_role_menu` VALUES ('5289', '1', '1115184208369717264');
INSERT INTO `sys_role_menu` VALUES ('5290', '1', '1115184208369717265');
INSERT INTO `sys_role_menu` VALUES ('5291', '1', '1115184208369717266');
INSERT INTO `sys_role_menu` VALUES ('5292', '1', '1115184208369717267');
INSERT INTO `sys_role_menu` VALUES ('5293', '1', '1115184208369717268');
INSERT INTO `sys_role_menu` VALUES ('5294', '1', '1115184208369717258');
INSERT INTO `sys_role_menu` VALUES ('5295', '1', '1115184208369717259');
INSERT INTO `sys_role_menu` VALUES ('5296', '1', '1115184208369717260');
INSERT INTO `sys_role_menu` VALUES ('5297', '1', '1115184208369717261');
INSERT INTO `sys_role_menu` VALUES ('5298', '1', '1115184208369717262');
INSERT INTO `sys_role_menu` VALUES ('5299', '1', '1115184208369717270');
INSERT INTO `sys_role_menu` VALUES ('5300', '1', '1115184208369717271');
INSERT INTO `sys_role_menu` VALUES ('5301', '1', '1115184208369717272');
INSERT INTO `sys_role_menu` VALUES ('5302', '1', '1115184208369717273');
INSERT INTO `sys_role_menu` VALUES ('5303', '1', '1115184208369717274');
INSERT INTO `sys_role_menu` VALUES ('5304', '1', '1115183444654067714');
INSERT INTO `sys_role_menu` VALUES ('5305', '1', '1115184160676286466');
INSERT INTO `sys_role_menu` VALUES ('5306', '1', '1115184208369717250');
INSERT INTO `sys_role_menu` VALUES ('5307', '1', '1115184208369717276');
INSERT INTO `sys_role_menu` VALUES ('5308', '1', '1115184208369717277');
INSERT INTO `sys_role_menu` VALUES ('5309', '1', '1115184208369717278');
INSERT INTO `sys_role_menu` VALUES ('5310', '1', '1115184208369717279');
INSERT INTO `sys_role_menu` VALUES ('5311', '1', '1115184208369717280');
INSERT INTO `sys_role_menu` VALUES ('5312', '1', '1115184208369717282');
INSERT INTO `sys_role_menu` VALUES ('5313', '1', '1115184208369717283');
INSERT INTO `sys_role_menu` VALUES ('5314', '1', '1115184208369717284');
INSERT INTO `sys_role_menu` VALUES ('5315', '1', '1115184208369717285');
INSERT INTO `sys_role_menu` VALUES ('5316', '1', '1115184208369717286');
INSERT INTO `sys_role_menu` VALUES ('5317', '1', '1115184208369717288');
INSERT INTO `sys_role_menu` VALUES ('5318', '1', '1115184208369717289');
INSERT INTO `sys_role_menu` VALUES ('5319', '1', '1115184208369717290');
INSERT INTO `sys_role_menu` VALUES ('5320', '1', '1115184208369717291');
INSERT INTO `sys_role_menu` VALUES ('5321', '1', '1115184208369717292');
INSERT INTO `sys_role_menu` VALUES ('5322', '1', '1115183213711495170');
INSERT INTO `sys_role_menu` VALUES ('5323', '1', '1115183247500808194');
INSERT INTO `sys_role_menu` VALUES ('5324', '1', '71');
INSERT INTO `sys_role_menu` VALUES ('5325', '1', '78');
INSERT INTO `sys_role_menu` VALUES ('5326', '1', '175');
INSERT INTO `sys_role_menu` VALUES ('5327', '1', '206');
INSERT INTO `sys_role_menu` VALUES ('5328', '1', '1');
INSERT INTO `sys_role_menu` VALUES ('5329', '1', '2');
INSERT INTO `sys_role_menu` VALUES ('5330', '1', '6');
INSERT INTO `sys_role_menu` VALUES ('5331', '1', '7');
INSERT INTO `sys_role_menu` VALUES ('5332', '1', '73');
INSERT INTO `sys_role_menu` VALUES ('5333', '1', '3');
INSERT INTO `sys_role_menu` VALUES ('5334', '1', '77');
INSERT INTO `sys_role_menu` VALUES ('5335', '1', '27');
INSERT INTO `sys_role_menu` VALUES ('5336', '1', '91');
INSERT INTO `sys_role_menu` VALUES ('5337', '1', '1115184208369717251');
INSERT INTO `sys_role_menu` VALUES ('5338', '1', '1115184208369717263');
INSERT INTO `sys_role_menu` VALUES ('5339', '1', '1115179024377745410');
INSERT INTO `sys_role_menu` VALUES ('5340', '1', '1115184208369717257');
INSERT INTO `sys_role_menu` VALUES ('5341', '1', '1115184208369717269');
INSERT INTO `sys_role_menu` VALUES ('5342', '1', '1115182776430137345');
INSERT INTO `sys_role_menu` VALUES ('5343', '1', '1115184208369717281');
INSERT INTO `sys_role_menu` VALUES ('5344', '1', '1115184208369717275');
INSERT INTO `sys_role_menu` VALUES ('5345', '1', '1115184208369717287');
INSERT INTO `sys_role_menu` VALUES ('5346', '1', '1115183012166799361');
INSERT INTO `sys_role_menu` VALUES ('5347', '1', '1115183127149449218');
INSERT INTO `sys_role_menu` VALUES ('5348', '1', '-1');

-- ----------------------------
-- Table structure for sys_task
-- ----------------------------
DROP TABLE IF EXISTS `sys_task`;
CREATE TABLE `sys_task` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cronExpression` varchar(255) DEFAULT NULL COMMENT 'cron表达式',
  `methodName` varchar(255) DEFAULT NULL COMMENT '任务调用的方法名',
  `isConcurrent` varchar(255) DEFAULT NULL COMMENT '任务是否有状态',
  `description` varchar(255) DEFAULT NULL COMMENT '任务描述',
  `updateBy` varchar(64) DEFAULT NULL COMMENT '更新者',
  `beanClass` varchar(255) DEFAULT NULL COMMENT '任务执行时调用哪个类的方法 包名+类名',
  `createDate` datetime DEFAULT NULL COMMENT '创建时间',
  `jobStatus` varchar(255) DEFAULT NULL COMMENT '任务状态',
  `jobGroup` varchar(255) DEFAULT NULL COMMENT '任务分组',
  `updateDate` datetime DEFAULT NULL COMMENT '更新时间',
  `createBy` varchar(64) DEFAULT NULL COMMENT '创建者',
  `springBean` varchar(255) DEFAULT NULL COMMENT 'Spring bean',
  `jobName` varchar(255) DEFAULT NULL COMMENT '任务名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=1020572889410367491 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_task
-- ----------------------------
INSERT INTO `sys_task` VALUES ('2', '0/10 * * * * ?', 'run1', '1', '', '4028ea815a3d2a8c015a3d2f8d2a0002', 'com.ifast.job.TestJob', '2017-05-19 18:30:56', '0', 'group1', '2017-05-19 18:31:07', null, '', 'TestJob');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL COMMENT '用户名',
  `name` varchar(100) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL COMMENT '密码',
  `deptId` bigint(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `mobile` varchar(100) DEFAULT NULL COMMENT '手机号',
  `status` tinyint(255) DEFAULT NULL COMMENT '状态 0:禁用，1:正常',
  `userIdCreate` bigint(255) DEFAULT NULL COMMENT '创建用户id',
  `gmtCreate` datetime DEFAULT NULL COMMENT '创建时间',
  `gmtModified` datetime DEFAULT NULL COMMENT '修改时间',
  `sex` bigint(32) DEFAULT NULL COMMENT '性别',
  `birth` datetime DEFAULT NULL COMMENT '出身日期',
  `picId` bigint(32) DEFAULT NULL,
  `liveAddress` varchar(500) DEFAULT NULL COMMENT '现居住地',
  `hobby` varchar(255) DEFAULT NULL COMMENT '爱好',
  `province` varchar(255) DEFAULT NULL COMMENT '省份',
  `city` varchar(255) DEFAULT NULL COMMENT '所在城市',
  `district` varchar(255) DEFAULT NULL COMMENT '所在地区',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1034088697579159555 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', 'admin', '超级管理员', '33808479d49ca8a3cdc93d4f976d1e3d', '6', 'izenglong@163.com', '15277778888', '1', '1', '2017-08-15 21:40:39', '2017-08-15 21:41:00', '96', '2018-04-02 00:00:00', '151', '创客基地', '', '广东省', '广州市', '番禺区');
INSERT INTO `sys_user` VALUES ('2', 'test', '临时用户', 'b132f5f968c9373261f74025c23c2222', '6', 'test@ifast.com', '15278792752', '1', '1', '2017-08-14 13:43:05', '2017-08-14 21:15:36', '96', '2018-08-22 00:00:00', null, '', '', '北京市', '北京市市辖区', '东城区');
INSERT INTO `sys_user` VALUES ('1034088697579159554', 'appUser', 'user', 'fc4d8bf7d69f03344a58f9381dd75dfe', '12', 'appUser@ifast.com', null, '1', null, null, null, null, null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `roleId` bigint(20) DEFAULT NULL COMMENT '角色ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=134 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户与角色对应关系';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('73', '30', '48');
INSERT INTO `sys_user_role` VALUES ('74', '30', '49');
INSERT INTO `sys_user_role` VALUES ('75', '30', '50');
INSERT INTO `sys_user_role` VALUES ('76', '31', '48');
INSERT INTO `sys_user_role` VALUES ('77', '31', '49');
INSERT INTO `sys_user_role` VALUES ('78', '31', '52');
INSERT INTO `sys_user_role` VALUES ('79', '32', '48');
INSERT INTO `sys_user_role` VALUES ('80', '32', '49');
INSERT INTO `sys_user_role` VALUES ('81', '32', '50');
INSERT INTO `sys_user_role` VALUES ('82', '32', '51');
INSERT INTO `sys_user_role` VALUES ('83', '32', '52');
INSERT INTO `sys_user_role` VALUES ('84', '33', '38');
INSERT INTO `sys_user_role` VALUES ('85', '33', '49');
INSERT INTO `sys_user_role` VALUES ('86', '33', '52');
INSERT INTO `sys_user_role` VALUES ('87', '34', '50');
INSERT INTO `sys_user_role` VALUES ('88', '34', '51');
INSERT INTO `sys_user_role` VALUES ('89', '34', '52');
INSERT INTO `sys_user_role` VALUES ('110', '1', '1');
INSERT INTO `sys_user_role` VALUES ('111', '2', '1');
INSERT INTO `sys_user_role` VALUES ('117', '135', '1');
INSERT INTO `sys_user_role` VALUES ('120', '134', '1');
INSERT INTO `sys_user_role` VALUES ('121', '134', '48');
INSERT INTO `sys_user_role` VALUES ('124', null, '48');
INSERT INTO `sys_user_role` VALUES ('127', null, '1');
INSERT INTO `sys_user_role` VALUES ('128', null, '1');
INSERT INTO `sys_user_role` VALUES ('129', null, '1');
INSERT INTO `sys_user_role` VALUES ('131', '137', '57');
INSERT INTO `sys_user_role` VALUES ('133', '1034088697579159554', '1034088931742957569');

-- ----------------------------
-- Table structure for tag
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '名称',
  `type` int(1) NOT NULL COMMENT '用途',
  `isEnable` int(1) NOT NULL DEFAULT '1' COMMENT '是否可用',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` int(11) DEFAULT NULL,
  `updateTime` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tag
-- ----------------------------
INSERT INTO `tag` VALUES ('2', 'Tom', '1', '1', '2019-04-19 00:01:43', null, null, null);
INSERT INTO `tag` VALUES ('3', 'Alex', '1', '1', '2019-04-19 00:01:43', null, null, null);
INSERT INTO `tag` VALUES ('4', 'Mask', '1', '1', '2019-04-19 00:07:14', null, null, null);
INSERT INTO `tag` VALUES ('5', 'Vincent', '1', '1', '2019-04-19 00:07:14', null, null, null);
