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
DROP TABLE IF EXISTS `items`;
CREATE TABLE IF NOT EXISTS `items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) DEFAULT NULL COMMENT '大分類ID',
  `title` varchar(255) NOT NULL COMMENT '小分類',
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id_title` (`group_id`,`title`),
  CONSTRAINT `group_key` FOREIGN KEY (`group_id`) REFERENCES `item_groups` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='費目　小分類';

-- エクスポートするデータが選択されていません


-- Dumping structure for テーブル kakei_manager.item_groups
DROP TABLE IF EXISTS `item_groups`;
CREATE TABLE IF NOT EXISTS `item_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '大分類ID',
  `title` varchar(255) NOT NULL COMMENT '大分類',
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='費目　大分類';

-- エクスポートするデータが選択されていません


-- Dumping structure for テーブル kakei_manager.members
DROP TABLE IF EXISTS `members`;
CREATE TABLE IF NOT EXISTS `members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT 'メンバー名（夫、妻、名前など）',
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='家族';

-- エクスポートするデータが選択されていません


-- Dumping structure for テーブル kakei_manager.receipt_bds
DROP TABLE IF EXISTS `receipt_bds`;
CREATE TABLE IF NOT EXISTS `receipt_bds` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'レシートBDのid',
  `hd_id` int(11) NOT NULL DEFAULT '0' COMMENT 'receipt_hdのid',
  `item_group_title` varchar(255) DEFAULT NULL COMMENT '費目 大分類',
  `item_title` varchar(255) DEFAULT NULL COMMENT '費目 小分類',
  `memo` varchar(255) DEFAULT NULL COMMENT 'メモ',
  `paid_for` varchar(255) DEFAULT NULL COMMENT '誰のためのお金か',
  `debtor` varchar(255) DEFAULT NULL COMMENT '支払うべき人',
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `receiot_hd_key` (`hd_id`),
  KEY `item_group_title` (`item_group_title`),
  KEY `debtor` (`debtor`),
  CONSTRAINT `debtor` FOREIGN KEY (`debtor`) REFERENCES `members` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `item_group_title` FOREIGN KEY (`item_group_title`) REFERENCES `item_groups` (`title`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `receiot_hd_key` FOREIGN KEY (`hd_id`) REFERENCES `receipt_hds` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='レシートの詳細データ\r\n・receipt_hd : receipt_bdは1:1～n\r\n・詳細データは、同じ種類の複数品目の集合';

-- エクスポートするデータが選択されていません


-- Dumping structure for テーブル kakei_manager.receipt_hds
DROP TABLE IF EXISTS `receipt_hds`;
CREATE TABLE IF NOT EXISTS `receipt_hds` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'レシートヘッダid',
  `date` date NOT NULL COMMENT '購入日',
  `total_amount` int(11) NOT NULL DEFAULT '0' COMMENT 'レシートの金額',
  `tax_type` int(1) NOT NULL DEFAULT '0' COMMENT '0:内税/1:外税',
  `paid_way` int(11) DEFAULT '0' COMMENT '支払方法',
  `paid_by` varchar(255) DEFAULT NULL COMMENT '支払者',
  `created` datetime DEFAULT '0000-00-00 00:00:00',
  `modified` datetime DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `paid_by_key` (`paid_by`),
  CONSTRAINT `paid_by_key` FOREIGN KEY (`paid_by`) REFERENCES `members` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='レシートのヘッダ情報';

-- エクスポートするデータが選択されていません


-- Dumping structure for テーブル kakei_manager.tags
DROP TABLE IF EXISTS `tags`;
CREATE TABLE IF NOT EXISTS `tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='出張にかかった費用とか、クリスマスの為に食材を奮発したとか、普段とは違う用途をタグ付けしたり、自由にグルーピングできる';

-- エクスポートするデータが選択されていません
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
