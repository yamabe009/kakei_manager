-- --------------------------------------------------------
-- ホスト:                          127.0.0.1
-- サーバのバージョン:                    5.6.24 - MySQL Community Server (GPL)
-- サーバー OS:                      Win32
-- HeidiSQL バージョン:               9.2.0.4947
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for テーブル kakei_manager.items
CREATE TABLE IF NOT EXISTS `items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) DEFAULT NULL COMMENT '大分類ID',
  `title` varchar(255) NOT NULL COMMENT '小分類',
  `ord` int(11) NOT NULL DEFAULT '0' COMMENT '表示順序',
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id_title` (`group_id`,`title`),
  CONSTRAINT `group_key` FOREIGN KEY (`group_id`) REFERENCES `item_groups` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='費目　小分類';

-- エクスポートするデータが選択されていません


-- Dumping structure for テーブル kakei_manager.item_groups
CREATE TABLE IF NOT EXISTS `item_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '大分類ID',
  `title` varchar(255) NOT NULL COMMENT '大分類',
  `ord` int(11) NOT NULL DEFAULT '0' COMMENT '表示順序',
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='費目　大分類';

-- エクスポートするデータが選択されていません


-- Dumping structure for テーブル kakei_manager.members
CREATE TABLE IF NOT EXISTS `members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT 'メンバー名（夫、妻、名前など）',
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='家族';

-- エクスポートするデータが選択されていません


-- Dumping structure for テーブル kakei_manager.payments
CREATE TABLE IF NOT EXISTS `payments` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `date` date NOT NULL COMMENT '購入日付',
  `item_group_title` varchar(255) DEFAULT NULL COMMENT '費目 大分類',
  `item_title` varchar(255) DEFAULT NULL COMMENT '費目 小分類',
  `memo` varchar(255) DEFAULT NULL COMMENT 'メモ',
  `paid_way` varchar(255) DEFAULT NULL COMMENT '支払方法',
  `paid_by` varchar(255) DEFAULT NULL COMMENT '支払者',
  `paid_for` varchar(255) DEFAULT NULL COMMENT '誰のためのお金か',
  `debtor` varchar(255) DEFAULT NULL COMMENT '支払うべき人',
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `item_group_title` (`item_group_title`),
  KEY `debtor` (`debtor`),
  KEY `paid_by` (`paid_by`),
  KEY `paid_way` (`paid_way`),
  CONSTRAINT `deptor_key` FOREIGN KEY (`debtor`) REFERENCES `members` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `item_group_key` FOREIGN KEY (`item_group_title`) REFERENCES `item_groups` (`title`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `paid_by` FOREIGN KEY (`paid_by`) REFERENCES `members` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `paid_way` FOREIGN KEY (`paid_way`) REFERENCES `pay_ways` (`title`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='支出';

-- エクスポートするデータが選択されていません


-- Dumping structure for テーブル kakei_manager.payment_tags
CREATE TABLE IF NOT EXISTS `payment_tags` (
  `payment_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`payment_id`,`tag_id`),
  KEY `tag_key` (`tag_id`),
  CONSTRAINT `payment_key` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tag_key` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- エクスポートするデータが選択されていません


-- Dumping structure for テーブル kakei_manager.pay_ways
CREATE TABLE IF NOT EXISTS `pay_ways` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL COMMENT '支払方法名',
  `paid_by` varchar(255) DEFAULT NULL COMMENT '支払者',
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='支払方法';

-- エクスポートするデータが選択されていません


-- Dumping structure for テーブル kakei_manager.tags
CREATE TABLE IF NOT EXISTS `tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) DEFAULT NULL COMMENT 'タグ名',
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='出張にかかった費用とか、クリスマスの為に食材を奮発したとか、普段とは違う用途をタグ付けしたり、自由にグルーピングできる';

-- エクスポートするデータが選択されていません
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
