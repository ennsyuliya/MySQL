-- MariaDB dump 10.19  Distrib 10.5.12-MariaDB, for Linux (x86_64)
--
-- Host: mysql.hostinger.ro    Database: u574849695_19
-- ------------------------------------------------------
-- Server version	10.5.12-MariaDB-cll-lve

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `communities`
--
/*i. Заполнить все таблицы БД vk данными (не больше 10-20 записей в каждой таблице)*/
DROP TABLE IF EXISTS `communities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `communities` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admin_user_id` bigint(20) unsigned NOT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `communities_name_idx` (`name`),
  KEY `admin_user_id` (`admin_user_id`),
  CONSTRAINT `communities_ibfk_1` FOREIGN KEY (`admin_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `communities`
--

LOCK TABLES `communities` WRITE;
/*!40000 ALTER TABLE `communities` DISABLE KEYS */;
INSERT INTO `communities` VALUES (1,'animi',1),(2,'in',2),(3,'velit',3),(4,'dolores',4),(5,'totam',5),(6,'porro',6),(7,'quisquam',7),(8,'sint',8),(9,'odit',9),(10,'officiis',10);
/*!40000 ALTER TABLE `communities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friend_requests`
--

DROP TABLE IF EXISTS `friend_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `friend_requests` (
  `initiator_user_id` bigint(20) unsigned NOT NULL,
  `target_user_id` bigint(20) unsigned NOT NULL,
  `status` enum('requested','approved','declined','unfriended') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `requested_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`initiator_user_id`,`target_user_id`),
  KEY `target_user_id` (`target_user_id`),
  CONSTRAINT `friend_requests_ibfk_1` FOREIGN KEY (`initiator_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `friend_requests_ibfk_2` FOREIGN KEY (`target_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friend_requests`
--

LOCK TABLES `friend_requests` WRITE;
/*!40000 ALTER TABLE `friend_requests` DISABLE KEYS */;
INSERT INTO `friend_requests` VALUES (1,1,'unfriended','2001-11-17 16:08:09','1972-06-30 03:55:18'),(2,2,'unfriended','1995-08-03 09:00:42','2016-10-27 03:58:42'),(3,3,'approved','2012-07-02 08:58:44','2004-10-06 01:01:14'),(4,4,'unfriended','1982-07-21 09:20:19','2003-06-26 23:54:12'),(5,5,'declined','2002-06-04 08:04:47','1992-01-03 03:36:26'),(6,6,'approved','1994-02-22 01:44:42','1991-11-01 01:13:57'),(7,7,'requested','2015-11-19 19:52:40','2002-05-07 05:24:30'),(8,8,'requested','2010-07-30 06:32:21','1992-11-23 05:41:20'),(9,9,'unfriended','2004-02-08 16:28:33','1976-04-05 04:02:55'),(10,10,'approved','2022-02-12 08:12:46','1971-08-07 08:11:17');
/*!40000 ALTER TABLE `friend_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `likes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `media_id` bigint(20) unsigned NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES (1,1,1,'1998-11-17 13:25:38'),(2,2,2,'2016-04-02 03:46:23'),(3,3,3,'1991-03-07 12:05:37'),(4,4,4,'1977-10-23 21:50:06'),(5,5,5,'2000-09-16 09:23:11'),(6,6,6,'1974-02-04 19:18:39'),(7,7,7,'2008-09-05 12:06:24'),(8,8,8,'1999-11-14 09:40:52'),(9,9,9,'2011-01-30 23:40:47'),(10,10,10,'2000-07-09 17:47:17');
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `media_type_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  KEY `media_type_id` (`media_type_id`),
  CONSTRAINT `media_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `media_ibfk_2` FOREIGN KEY (`media_type_id`) REFERENCES `media_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
INSERT INTO `media` VALUES (1,1,1,'Amet est ut expedita sed suscipit. Est non est enim. Ut laboriosam aspernatur iure repudiandae.','nisi',7084002,NULL,'1988-01-07 18:20:15','1980-11-23 22:40:09'),(2,2,2,'Voluptatum perspiciatis incidunt vel. Ipsa doloribus repudiandae aperiam. Possimus quis quia in aut natus labore. Suscipit labore aliquid dolorem autem.','veritatis',28094918,NULL,'1980-05-01 14:36:52','2011-04-15 19:25:26'),(3,3,3,'Eligendi laudantium tempore similique optio. Soluta eius a ut. Aspernatur dignissimos accusantium corporis molestias reprehenderit.','rerum',88564,NULL,'2000-11-07 02:08:35','1975-12-24 05:17:26'),(4,4,4,'Modi deleniti in commodi neque quod et. Sapiente dolore quas rem consequatur et ea ea. Ut debitis est inventore repellat eligendi dolore enim. Et sunt velit quibusdam eius sapiente molestiae. Architecto voluptatem quaerat architecto.','voluptatum',3971,NULL,'2006-03-02 05:48:09','1990-01-24 10:29:01'),(5,5,5,'Aut vitae vel dolore accusamus aliquam unde. Consequuntur quos deserunt eveniet dicta excepturi consequatur enim. Architecto in labore consequuntur distinctio.','culpa',0,NULL,'1983-02-04 01:06:12','2021-01-09 19:49:25'),(6,6,6,'Quis eaque quia qui magni. Sed et perspiciatis sint. Eius id voluptate quae amet velit aut.','est',5,NULL,'1989-07-15 23:45:17','1989-05-26 10:02:20'),(7,7,7,'Maiores neque perferendis dolorem ea aut harum. Deserunt nobis qui ea optio eveniet a. Dolorum quia dicta aut sequi non sequi voluptatem. Sed facere reiciendis dolor sit.','assumenda',56,NULL,'1994-06-13 23:51:07','1984-11-12 09:16:50'),(8,8,8,'Explicabo velit architecto temporibus qui magni distinctio aspernatur. Eum molestiae odio beatae earum adipisci est nihil. Molestiae provident perferendis dolore ducimus dolorum adipisci nesciunt. Sint magnam tenetur dignissimos enim dolor officiis quaerat aut.','necessitatibus',886221,NULL,'1971-01-28 14:22:25','1999-07-05 03:02:53'),(9,9,9,'Quo unde praesentium sint saepe aperiam nostrum. Aut autem maxime molestiae quae exercitationem eum. Est non omnis illo quis autem ut in.','repellat',4952929,NULL,'2012-07-12 07:50:35','1978-05-21 04:13:31'),(10,10,10,'Libero est autem sit. Est aspernatur porro accusamus debitis in dolore. In consectetur doloremque quia vel est. Voluptates deleniti a rem voluptatem vel.','nobis',9706604,NULL,'1983-04-17 13:48:42','1983-08-29 23:15:08');
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_types`
--

DROP TABLE IF EXISTS `media_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_types`
--

LOCK TABLES `media_types` WRITE;
/*!40000 ALTER TABLE `media_types` DISABLE KEYS */;
INSERT INTO `media_types` VALUES (1,'voluptatem','2019-02-11 11:37:57','2003-01-13 07:53:37'),(2,'laborum','2013-11-08 23:45:32','1972-07-14 05:06:00'),(3,'omnis','2000-10-30 04:23:27','1978-09-28 07:49:35'),(4,'aliquam','1979-11-08 14:38:46','1976-12-04 20:28:25');
/*!40000 ALTER TABLE `media_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `from_user_id` bigint(20) unsigned NOT NULL,
  `to_user_id` bigint(20) unsigned NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  UNIQUE KEY `id` (`id`),
  KEY `from_user_id` (`from_user_id`),
  KEY `to_user_id` (`to_user_id`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`from_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`to_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,1,1,'Voluptate soluta quod perferendis quia distinctio expedita quasi enim. Aut recusandae voluptatibus recusandae in facere. Distinctio autem mollitia quaerat debitis placeat.','1990-01-07 18:02:40'),(2,2,2,'Sunt accusantium ipsum magni minima esse voluptatem dolor. Debitis autem incidunt corrupti possimus est impedit in vel. Officia consequatur earum id atque.','2002-09-12 06:24:07'),(3,3,3,'Velit voluptate quod culpa quae et voluptatem voluptatem. Dolorem aut impedit et aut alias assumenda. Id sed sapiente et nam ipsum esse sed.','1981-12-02 17:42:09'),(4,4,4,'Eum incidunt enim sint aut facere rerum. Minima expedita modi nemo quam cupiditate impedit harum quod. Tempore ad ducimus saepe ut magnam velit. Cum mollitia quia voluptatem quae dolores.','1995-04-15 14:56:32'),(5,5,5,'Veritatis reiciendis iure perspiciatis est nesciunt. Repudiandae sit sint cumque et qui non ut fugiat. Sed quaerat eum ratione facere. Ipsam ex nostrum aut eveniet.','1970-04-02 15:13:34'),(6,6,6,'Ipsum reprehenderit voluptas sunt neque voluptas est. Nesciunt ea et nemo nemo non excepturi. Error nobis qui ab ut.','1977-05-18 07:28:39'),(7,7,7,'Voluptatem qui aut optio ex libero. Maiores nam in et officia quod dolorem. Veniam sint alias unde aspernatur id.','1984-07-05 20:41:24'),(8,8,8,'Quia in ut quia dolor enim dolorem deleniti. Et iure accusantium aut voluptas. Et et molestiae alias dolorem quia. Voluptatibus explicabo magnam tempore commodi amet illo. Consequatur perferendis quaerat quia et.','2015-03-13 06:51:01'),(9,9,9,'At sit quas et. Corporis accusantium explicabo dolorum laboriosam. Accusantium aspernatur culpa deserunt autem molestiae. Dignissimos facere laudantium inventore fugit voluptatem id.','1981-05-04 14:57:32'),(10,10,10,'Porro possimus voluptatem delectus nulla pariatur quos. Qui ut ipsum in commodi expedita excepturi. Voluptas laboriosam nihil non ducimus optio facilis. Ipsum maiores ea minima corrupti rem itaque.','1984-06-30 16:21:55');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photo_albums`
--

DROP TABLE IF EXISTS `photo_albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `photo_albums` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `photo_albums_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photo_albums`
--

LOCK TABLES `photo_albums` WRITE;
/*!40000 ALTER TABLE `photo_albums` DISABLE KEYS */;
INSERT INTO `photo_albums` VALUES (1,'autem',1),(2,'quo',2),(3,'optio',3),(4,'et',4),(5,'perferendis',5),(6,'consequatur',6),(7,'alias',7),(8,'consequatur',8),(9,'eum',9),(10,'fugit',10);
/*!40000 ALTER TABLE `photo_albums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photos`
--

DROP TABLE IF EXISTS `photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `photos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `album_id` bigint(20) unsigned DEFAULT NULL,
  `media_id` bigint(20) unsigned NOT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `album_id` (`album_id`),
  KEY `media_id` (`media_id`),
  CONSTRAINT `photos_ibfk_1` FOREIGN KEY (`album_id`) REFERENCES `photo_albums` (`id`),
  CONSTRAINT `photos_ibfk_2` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photos`
--

LOCK TABLES `photos` WRITE;
/*!40000 ALTER TABLE `photos` DISABLE KEYS */;
INSERT INTO `photos` VALUES (1,1,1),(2,2,2),(3,3,3),(4,4,4),(5,5,5),(6,6,6),(7,7,7),(8,8,8),(9,9,9),(10,10,10);
/*!40000 ALTER TABLE `photos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profiles` (
  `user_id` bigint(20) unsigned NOT NULL,
  `gender` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `photo_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `hometown` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` VALUES (1,NULL,'2003-01-07',1,'1980-08-18 13:06:54',NULL),(2,NULL,'1982-03-19',2,'1987-06-01 08:12:50',NULL),(3,NULL,'1996-10-17',3,'1971-11-30 06:12:06',NULL),(4,NULL,'1985-04-04',4,'2019-05-10 03:47:16',NULL),(5,NULL,'1970-03-07',5,'1973-01-24 07:34:00',NULL),(6,NULL,'2018-10-25',6,'2016-08-29 23:11:45',NULL),(7,NULL,'1999-09-27',7,'2013-05-23 09:16:32',NULL),(8,NULL,'1991-01-31',8,'2008-08-02 18:36:55',NULL),(9,NULL,'2011-09-26',9,'2020-04-17 03:19:39',NULL),(10,NULL,'1977-04-16',10,'2001-01-19 02:42:13',NULL);
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Р¤Р°Р�?РёР»СЊ',
  `email` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password_hash` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`),
  KEY `users_firstname_lastname_idx` (`firstname`,`lastname`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='СЋР·РµСЂС‹';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Brandt','Denesik','stacey62@example.com','989ed14d99d6c8ac078e64f6dfc4c00bd30608a9',89226471191),(2,'Pamela','Keebler','eschimmel@example.net','4fe082dfe7680d03317e083eb340320e10956267',89029058479),(3,'Justice','Collins','johnson.jose@example.net','3f7b5b037b034aeda26d6483094cfa1125c33119',89491597966),(4,'Gustave','Upton','kwiegand@example.com','ad81c754963be80949f5ac5333dacb9e9a8d5ab6',89093559464),(5,'Karina','Turcotte','brakus.chance@example.org','a4d525e989c11e0a71d885c8393ce5ac1202fb6a',89364221424),(6,'Alexandra','Pfeffer','abshire.edyth@example.com','d000861c47940bd46b7a6412f7ff15e1ec8ddb00',89449554337),(7,'Lyda','Boyle','matteo92@example.org','39b6e6c2bc7f127a6accb5b493c17e275052bf8e',89196343895),(8,'Myrtis','Pouros','irunolfsson@example.net','e254a6ce08142d05b248bf65e431bcee4e42754d',89373501910),(9,'Russel','Schmeler','monica38@example.net','aff96f17a7348195b952d2dc5d96ead9d2ab8977',89196577185),(10,'Norwood','Metz','gmayert@example.org','5821c7d9037e4739828b165620a98921cc843435',89301129962);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_communities`
--

DROP TABLE IF EXISTS `users_communities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_communities` (
  `user_id` bigint(20) unsigned NOT NULL,
  `community_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`community_id`),
  KEY `community_id` (`community_id`),
  CONSTRAINT `users_communities_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `users_communities_ibfk_2` FOREIGN KEY (`community_id`) REFERENCES `communities` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_communities`
--

LOCK TABLES `users_communities` WRITE;
/*!40000 ALTER TABLE `users_communities` DISABLE KEYS */;
INSERT INTO `users_communities` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10);
/*!40000 ALTER TABLE `users_communities` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-17  6:34:29

/*2.  Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке*/ 
SELECT DISTINCT firstname
FROM users



 /*3.Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = false). Предварительно добавить такое поле в таблицу profiles со значением по умолчанию = true (или 1)*/

ALTER TABLE profiles ADD is_active BIT DEFAULT false NULL;

/* Написать скрипт, удаляющий сообщения «из будущего» (дата больше сегодняшней)*/
UPDATE profiles
SET is_active = 1
WHERE YEAR(CURRENT_TIMESTAMP) - YEAR(birthday) - (RIGHT(CURRENT_TIMESTAMP, 5) < RIGHT(birthday, 5)) < 18
;
-- ������� � ��������� ������������
ALTER TABLE profiles ADD age bigint(5);
-- ������� � ������� age ������� �������������
UPDATE profiles
SET age = YEAR(CURRENT_TIMESTAMP) - YEAR(birthday) - (RIGHT(CURRENT_TIMESTAMP, 5) < RIGHT(birthday, 5))
;


/*4.  Написать название темы курсового проекта (в комментарии) */ 

--�������� ��������� � id 4 ���� �� ��������
UPDATE messages
	SET created_at='2222-11-24 04:06:29'
	WHERE id = 4;

-- ������ ��������� �� ��������
DELETE FROM messages
WHERE created_at > now()
;

