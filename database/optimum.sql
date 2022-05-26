CREATE DATABASE  IF NOT EXISTS `optimum` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `optimum`;
-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: localhost    Database: optimum
-- ------------------------------------------------------
-- Server version	8.0.27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `day_stat`
--

DROP TABLE IF EXISTS `day_stat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `day_stat` (
  `date` date NOT NULL,
  `user_id` int unsigned NOT NULL,
  `day_stat_id` int NOT NULL,
  `food_id` int unsigned NOT NULL,
  `weight` decimal(5,2) unsigned NOT NULL,
  PRIMARY KEY (`date`,`user_id`,`day_stat_id`,`food_id`),
  KEY `day_stat_dish_id_idx` (`food_id`),
  KEY `user_date_fk_idx` (`user_id`),
  CONSTRAINT `food_fk` FOREIGN KEY (`food_id`) REFERENCES `food` (`food_id`),
  CONSTRAINT `user_day_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `day_stat`
--

LOCK TABLES `day_stat` WRITE;
/*!40000 ALTER TABLE `day_stat` DISABLE KEYS */;
INSERT INTO `day_stat` VALUES ('2022-03-07',1,0,102,254.00),('2022-03-08',1,0,6,100.00),('2022-03-08',1,1,118,20.00),('2022-03-08',1,2,117,16.00),('2022-03-14',1,0,6,100.00),('2022-03-17',1,0,165,100.00),('2022-04-04',1,0,8,100.00),('2022-04-04',1,1,118,20.00),('2022-04-04',1,2,117,16.00),('2022-04-04',1,3,102,254.00),('2022-04-04',1,4,157,116.00),('2022-04-04',1,5,153,195.00),('2022-04-04',1,6,23,227.00),('2022-04-04',1,7,138,375.00),('2022-04-04',1,8,60,28.00),('2022-04-04',1,9,128,8.00),('2022-04-05',1,0,115,96.00),('2022-04-05',1,1,72,44.00),('2022-04-05',1,2,88,10.00),('2022-04-05',1,3,131,10.00),('2022-04-05',1,4,3,125.00),('2022-04-05',1,5,118,17.00),('2022-04-05',1,6,117,10.00),('2022-04-05',1,7,102,264.00),('2022-04-05',1,8,41,85.00),('2022-04-05',1,9,138,367.00),('2022-04-05',1,10,80,19.00),('2022-04-06',1,0,4,135.00),('2022-04-06',1,1,119,15.00),('2022-04-06',1,2,102,280.00),('2022-04-06',1,3,41,117.00),('2022-04-06',1,4,159,160.00),('2022-04-06',1,5,23,230.00),('2022-04-06',1,6,115,191.00),('2022-04-06',1,7,60,30.00),('2022-04-06',1,8,88,6.00),('2022-04-07',1,0,2,150.00),('2022-04-07',1,1,76,172.00),('2022-04-07',1,2,127,8.00),('2022-04-07',1,3,60,110.00),('2022-04-07',1,4,162,64.00),('2022-04-07',1,5,16,162.00),('2022-04-07',1,6,160,416.00),('2022-04-07',1,7,81,19.00),('2022-04-07',1,8,108,15.00),('2022-04-08',1,0,149,190.00),('2022-04-08',1,1,81,19.00),('2022-04-08',1,2,162,64.00),('2022-04-08',1,3,143,230.00),('2022-04-08',1,4,153,100.00),('2022-04-09',1,0,163,524.00),('2022-04-09',1,1,162,69.00),('2022-04-09',1,2,152,154.00),('2022-04-10',1,0,8,120.00),('2022-04-10',1,1,102,295.00),('2022-04-10',1,2,162,70.00),('2022-04-10',1,3,152,175.00),('2022-04-10',1,4,128,8.00),('2022-04-10',1,5,131,25.00),('2022-04-10',1,6,115,160.00),('2022-04-10',1,7,88,6.00),('2022-04-10',1,8,60,32.00),('2022-04-10',1,9,108,5.00),('2022-04-11',1,0,128,8.00),('2022-04-11',1,1,131,30.00),('2022-04-11',1,2,153,120.00),('2022-04-11',1,3,102,300.00),('2022-04-11',1,4,97,141.00),('2022-04-11',1,5,83,30.00),('2022-04-11',1,6,162,80.00);
/*!40000 ALTER TABLE `day_stat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `food`
--

DROP TABLE IF EXISTS `food`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `food` (
  `food_id` int unsigned NOT NULL AUTO_INCREMENT,
  `food_name` varchar(64) NOT NULL,
  `weight` decimal(6,2) unsigned DEFAULT NULL,
  `is_dish` bit(1) NOT NULL DEFAULT b'0',
  `kcal_1` decimal(5,4) unsigned DEFAULT NULL,
  `proteins_1` decimal(5,4) unsigned DEFAULT NULL,
  `fats_1` decimal(5,4) unsigned DEFAULT NULL,
  `carbohydrates_1` decimal(5,4) unsigned DEFAULT NULL,
  `added_by_user` int unsigned NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`food_id`)
) ENGINE=InnoDB AUTO_INCREMENT=241 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food`
--

LOCK TABLES `food` WRITE;
/*!40000 ALTER TABLE `food` DISABLE KEYS */;
INSERT INTO `food` VALUES (1,'Крупа пшеничная полба цельная Агро-Альянс',NULL,_binary '\0',3.5000,0.1200,0.0200,0.7200,1,'2022-01-01'),(2,'Крупа гречневая',NULL,_binary '\0',3.0800,0.1260,0.0330,0.5710,1,'2022-01-01'),(3,'Крупа перловая №1 Столичная мельница',NULL,_binary '\0',3.2000,0.0950,0.0100,0.6900,1,'2022-01-01'),(4,'Крупа пшённая Эколайн',NULL,_binary '\0',3.4000,0.1200,0.0350,0.6600,1,'2022-01-01'),(5,'Крупа булгур',NULL,_binary '\0',3.4200,0.1230,0.0130,0.5760,1,'2022-01-01'),(6,'Хлопья овсяные Прибужская нива',NULL,_binary '\0',3.7000,0.1000,0.0600,0.6800,1,'2022-01-01'),(7,'Хлопья овсяные Геркулес №1 Лидкон',NULL,_binary '\0',3.0000,0.1100,0.0600,0.5000,1,'2022-01-01'),(8,'Крупа овсяная недробленая сорт 2 Столичная мельница',NULL,_binary '\0',3.5000,0.1300,0.0600,0.6000,1,'2022-01-01'),(9,'Рис белый',NULL,_binary '\0',3.3300,0.0700,0.0100,0.7400,1,'2022-01-01'),(10,'Рис бурый',NULL,_binary '\0',3.3700,0.0740,0.0180,0.7290,1,'2022-01-01'),(11,'Крупа манная',NULL,_binary '\0',3.3300,0.1030,0.0100,0.7060,1,'2022-01-01'),(12,'Кукуруза',NULL,_binary '\0',3.2500,0.1030,0.0490,0.6000,1,'2022-01-01'),(13,'Чечевица красная Фермер',NULL,_binary '\0',2.8500,0.2400,0.0100,0.5400,1,'2022-01-01'),(14,'Чечевица зелёная',NULL,_binary '\0',2.8400,0.2400,0.0110,0.5370,1,'2022-01-01'),(15,'Горох колотый',NULL,_binary '\0',2.9900,0.2300,0.0160,0.4810,1,'2022-01-01'),(16,'Фасоль консервированная в соусе Heinz',NULL,_binary '\0',0.7800,0.0470,0.0020,0.1250,1,'2022-01-01'),(17,'Фасоль белая',NULL,_binary '\0',3.2500,0.2090,0.0180,0.6400,1,'2022-01-01'),(18,'Фасоль красная шапочка',NULL,_binary '\0',2.9800,0.2100,0.0200,0.4700,1,'2022-01-01'),(19,'Фасоль красная',NULL,_binary '\0',3.1000,0.2100,0.0160,0.5270,1,'2022-01-01'),(20,'Фасоль красная в классическом барбекю Bonduelle',NULL,_binary '\0',1.1000,0.0523,0.0120,0.2000,1,'2022-01-01'),(21,'Нут Natural Spar',NULL,_binary '\0',3.9000,0.2000,0.0500,0.6600,1,'2022-01-01'),(22,'Маш Агро-Альянс',NULL,_binary '\0',3.6000,0.2300,0.0200,0.6200,1,'2022-01-01'),(23,'Огурцы тепличные',NULL,_binary '\0',0.1100,0.0070,0.0010,0.0190,1,'2022-01-01'),(24,'Помидоры тепличные',NULL,_binary '\0',0.1700,0.0090,0.0010,0.0290,1,'2022-01-01'),(25,'Перец сладкий',NULL,_binary '\0',0.2600,0.0130,0.0010,0.0490,1,'2022-01-01'),(26,'Морковь',NULL,_binary '\0',0.3500,0.0130,0.0010,0.0690,1,'2022-01-01'),(27,'Капуста белокочанная',NULL,_binary '\0',0.2800,0.0180,0.0010,0.0470,1,'2022-01-01'),(28,'Баклажан',NULL,_binary '\0',0.2400,0.0120,0.0010,0.0450,1,'2022-01-01'),(29,'Лук репчатый',NULL,_binary '\0',0.4100,0.0140,0.0020,0.0820,1,'2022-01-01'),(30,'Лук красный',NULL,_binary '\0',0.4200,0.0140,0.0000,0.0910,1,'2022-01-01'),(31,'Картоха',NULL,_binary '\0',0.7700,0.0200,0.0040,0.1630,1,'2022-01-01'),(32,'Руккола',NULL,_binary '\0',0.2500,0.0260,0.0070,0.0210,1,'2022-01-01'),(33,'Цветная капуста',NULL,_binary '\0',0.3000,0.0250,0.0030,0.0540,1,'2022-01-01'),(34,'Мексиканская смесь с красной фасолью',NULL,_binary '\0',0.9150,0.0400,0.0185,0.1500,1,'2022-01-01'),(35,'Тыква',NULL,_binary '\0',0.2800,0.0130,0.0030,0.0770,1,'2022-01-01'),(36,'Свекла',NULL,_binary '\0',0.4300,0.0150,0.0010,0.0880,1,'2022-01-01'),(37,'Кабачок',NULL,_binary '\0',0.2400,0.0060,0.0030,0.0460,1,'2022-01-01'),(38,'Капуста квашеная',NULL,_binary '\0',0.1900,0.0180,0.0010,0.0440,1,'2022-01-01'),(39,'Чеснок',NULL,_binary '\0',1.4300,0.0650,0.0050,0.2990,1,'2022-01-01'),(40,'Бройлер 1 кат.',NULL,_binary '\0',2.2000,0.1870,0.1610,0.0000,1,'2022-01-01'),(41,'Бройлер бедро',NULL,_binary '\0',1.8500,0.2130,0.1100,0.0010,1,'2022-01-01'),(42,'Куриная грудка',NULL,_binary '\0',1.1300,0.2360,0.0190,0.0000,1,'2022-01-01'),(43,'Куриная голень',NULL,_binary '\0',1.9800,0.1800,0.1400,0.0000,1,'2022-01-01'),(44,'Куриные окорочка',NULL,_binary '\0',1.5800,0.1680,0.1020,0.0000,1,'2022-01-01'),(45,'Куриное филе',NULL,_binary '\0',1.1000,0.2310,0.0120,0.0000,1,'2022-01-01'),(46,'Куриное бедро',NULL,_binary '\0',1.8500,0.2130,0.1100,0.0010,1,'2022-01-01'),(47,'Курица',NULL,_binary '\0',1.9000,0.1600,0.1400,0.0000,1,'2022-01-01'),(48,'Свинина мясная',NULL,_binary '\0',3.5700,0.1430,0.3330,0.0000,1,'2022-01-01'),(49,'Свиные рёбра',NULL,_binary '\0',3.2100,0.1520,0.2930,0.0000,1,'2022-01-01'),(50,'Рыба скумбрия',NULL,_binary '\0',1.9100,0.1800,0.1320,0.0000,1,'2022-01-01'),(51,'Рыба судак',NULL,_binary '\0',0.8400,0.1840,0.0110,0.0000,1,'2022-01-01'),(52,'Рыба линь',NULL,_binary '\0',0.4000,0.0700,0.0180,0.0000,1,'2022-01-01'),(53,'Рыба форель',NULL,_binary '\0',0.9700,0.1920,0.0210,0.0000,1,'2022-01-01'),(54,'Рыба окунь морской',NULL,_binary '\0',0.7900,0.1530,0.0150,0.0000,1,'2022-01-01'),(55,'Рыба треска',NULL,_binary '\0',0.7800,0.1770,0.0070,0.0000,1,'2022-01-01'),(56,'Сардельки телячьи',NULL,_binary '\0',2.6800,0.1040,0.2250,0.0190,1,'2022-01-01'),(57,'Сардельки из индейки Брестский мясокомбинат',NULL,_binary '\0',1.7000,0.1100,0.1200,0.0200,1,'2022-01-01'),(58,'Сало',NULL,_binary '\0',7.9700,0.0240,0.8900,0.0000,1,'2022-01-01'),(59,'Консервы горбуша Спецзаказ',NULL,_binary '\0',1.4000,0.2100,0.0600,0.0000,1,'2022-01-01'),(60,'Хлеб Чисто ржаное чудо',NULL,_binary '\0',2.2100,0.0530,0.0050,0.4830,1,'2022-01-01'),(61,'Хлеб тёмный на закваске',NULL,_binary '\0',2.1000,0.0650,0.0050,0.4500,1,'2022-01-01'),(62,'Хлеб заварной Foodhack',NULL,_binary '\0',2.7000,0.0750,0.0200,0.5500,1,'2022-01-01'),(63,'Хлеб Белорусская нива',NULL,_binary '\0',2.2000,0.0600,0.0050,0.4800,1,'2022-01-01'),(64,'Хлеб ржаной бездрожжевой Foodhack',NULL,_binary '\0',2.1000,0.0250,0.0100,0.4300,1,'2022-01-01'),(65,'Хлеб кефирный заварной Foodhack',NULL,_binary '\0',2.3000,0.0700,0.0100,0.4800,1,'2022-01-01'),(66,'Хлеб латышский с тмином Foodhack',NULL,_binary '\0',2.4000,0.0700,0.0100,0.5100,1,'2022-01-01'),(67,'Хлеб капустный Foodhack',NULL,_binary '\0',3.0000,0.1400,0.0200,0.5600,1,'2022-01-01'),(68,'Хлеб Маг',NULL,_binary '\0',2.2000,0.0550,0.0050,0.4900,1,'2022-01-01'),(69,'Хлеб классический Нарочанский',NULL,_binary '\0',2.1000,0.0550,0.0050,0.4500,1,'2022-01-01'),(70,'Хлеб полевой со льном Слуцкий каравай',NULL,_binary '\0',2.5800,0.0860,0.0240,0.4930,1,'2022-01-01'),(71,'Хлебцы бородинские Щедрые',NULL,_binary '\0',3.7500,0.1200,0.0300,0.7500,1,'2022-01-01'),(72,'Багет',NULL,_binary '\0',2.6200,0.0750,0.0290,0.5140,1,'2022-01-01'),(73,'Багет французский Foodhack',NULL,_binary '\0',2.5000,0.0850,0.0100,0.5200,1,'2022-01-01'),(74,'Батон нарезной',NULL,_binary '\0',2.6400,0.0750,0.0290,0.5090,1,'2022-01-01'),(75,'Сухари из нарезного батона',NULL,_binary '\0',3.9800,0.1140,0.0440,0.7810,1,'2022-01-01'),(76,'Молоко Брест-Литовск 2.8%',NULL,_binary '\0',0.5600,0.0300,0.0280,0.0470,1,'2022-01-01'),(77,'Молоко Брест-Литовск 3.6%',NULL,_binary '\0',0.6320,0.0300,0.0360,0.0470,1,'2022-01-01'),(78,'Молоко Здравушка 3.2%',NULL,_binary '\0',0.6000,0.0310,0.0320,0.0470,1,'2022-01-01'),(79,'Молоко Здравушка 3.4-6.0%',NULL,_binary '\0',0.6000,0.0310,0.0470,0.0470,1,'2022-01-01'),(80,'Сметана Брест-Литовск 15%',NULL,_binary '\0',1.5700,0.0270,0.1500,0.0290,1,'2022-01-01'),(81,'Сметана Брест-Литовск 20%',NULL,_binary '\0',2.0200,0.0260,0.2000,0.0290,1,'2022-01-01'),(82,'Сметана Здравушка 20%',NULL,_binary '\0',2.0000,0.0250,0.2000,0.0290,1,'2022-01-01'),(83,'Сыр классический 45% Брест-Литовск',NULL,_binary '\0',3.4000,0.2630,0.2610,0.0000,1,'2022-01-01'),(84,'Сыр полутвёрдый 50% Брест-Литовск',NULL,_binary '\0',3.3550,0.2250,0.2950,0.0000,1,'2022-01-01'),(85,'Сыр финский 45% Брест-Литовск',NULL,_binary '\0',3.0800,0.2300,0.2400,0.0000,1,'2022-01-01'),(86,'Сыр голландский 45% Брест-Литовск',NULL,_binary '\0',3.3200,0.2630,0.2520,0.0000,1,'2022-01-01'),(87,'Сыр плавленный Дружба Ласковое лето',NULL,_binary '\0',3.0300,0.2640,0.1640,0.0000,1,'2022-01-01'),(88,'Масло сливочное 82.5% Брест-Литовск',NULL,_binary '\0',7.4700,0.0050,0.8250,0.0060,1,'2022-01-01'),(89,'Творог Молочный мир 10%',NULL,_binary '\0',1.6500,0.1700,0.1000,0.0150,1,'2022-01-01'),(90,'Творог Савушкин продукт 5%',NULL,_binary '\0',1.1700,0.1650,0.0500,0.0150,1,'2022-01-01'),(91,'Творог Савушкин продукт 9%',NULL,_binary '\0',1.5100,0.1600,0.0900,0.0150,1,'2022-01-01'),(92,'Творог Стары Менск 5%',NULL,_binary '\0',1.2000,0.1700,0.0500,0.0150,1,'2022-01-01'),(93,'Творог Минская марка 5%',NULL,_binary '\0',1.1000,0.1500,0.0500,0.0150,1,'2022-01-01'),(94,'Творог Берёзка 4%',NULL,_binary '\0',1.0840,0.1670,0.0400,0.0140,1,'2022-01-01'),(95,'Творог Савушкин продукт 2%',NULL,_binary '\0',0.9320,0.1750,0.0200,0.0130,1,'2022-01-01'),(96,'Творог Ляховичок 5%',NULL,_binary '\0',1.1100,0.1500,0.0500,0.0150,1,'2022-01-01'),(97,'Макароны Primeluci',NULL,_binary '\0',3.5500,0.1150,0.0120,0.7250,1,'2022-01-01'),(98,'Макароны capellini Barilla',NULL,_binary '\0',3.5900,0.1400,0.0200,0.6970,1,'2022-01-01'),(99,'Макароны spaghettini Barilla',NULL,_binary '\0',3.5900,0.1400,0.0200,0.6970,1,'2022-01-01'),(100,'Макароны перья рифлёные сорт высший Pastavera',NULL,_binary '\0',3.5000,0.1300,0.0100,0.7300,1,'2022-01-01'),(101,'Макароны спакателле Colavita',NULL,_binary '\0',3.5900,0.1350,0.0100,0.7400,1,'2022-01-01'),(102,'Яблоко',NULL,_binary '\0',0.4700,0.0040,0.0040,0.0980,1,'2022-01-01'),(103,'Груша',NULL,_binary '\0',0.4700,0.0040,0.0030,0.1030,1,'2022-01-01'),(104,'Банан',NULL,_binary '\0',0.9500,0.0150,0.0020,0.2180,1,'2022-01-01'),(105,'Виноград кишмиш',NULL,_binary '\0',0.6900,0.0070,0.0020,0.1720,1,'2022-01-01'),(106,'Мандарин',NULL,_binary '\0',0.3300,0.0080,0.0020,0.0750,1,'2022-01-01'),(107,'Хурма',NULL,_binary '\0',0.6700,0.0050,0.0040,0.1530,1,'2022-01-01'),(108,'Орех грецкий',NULL,_binary '\0',6.5600,0.1620,0.6080,0.1110,1,'2022-01-01'),(109,'Арахис с беконом BigBob',NULL,_binary '\0',6.2260,0.2700,0.5420,0.0670,1,'2022-01-01'),(110,'Арахис в оболочке BigBob',NULL,_binary '\0',5.1100,0.1490,0.3450,0.3520,1,'2022-01-01'),(111,'Арахисовое ассорти Seven Nuts',NULL,_binary '\0',6.2000,0.2800,0.4800,0.1500,1,'2022-01-01'),(112,'Пельмени с говядиной и свининой Добровский',NULL,_binary '\0',2.3680,0.0950,0.1000,0.2720,1,'2022-01-01'),(113,'Пельмени с куриным филе Добровский',NULL,_binary '\0',2.2130,0.1260,0.1010,0.2000,1,'2022-01-01'),(114,'Яйцо куриное',NULL,_binary '\0',1.5700,0.1270,0.1090,0.0070,1,'2022-01-01'),(115,'Яйца куриные С1 Кобринские',NULL,_binary '\0',1.5700,0.1280,0.1180,0.0100,1,'2022-01-01'),(116,'Мука пшеничная высший сорт Лидская',NULL,_binary '\0',3.3000,0.1000,0.0100,0.6900,1,'2022-01-01'),(117,'Семена льна Василева слобода',NULL,_binary '\0',5.6000,0.2600,0.3900,0.1200,1,'2022-01-01'),(118,'Отруби пшеничные Здоровое питание',NULL,_binary '\0',3.3000,0.1400,0.0300,0.6100,1,'2022-01-01'),(119,'Отруби ржаные Бородински Здоровое питание',NULL,_binary '\0',2.2100,0.1320,0.0320,0.3500,1,'2022-01-01'),(120,'Отруби пшеничные с топинамбуром Elmika',NULL,_binary '\0',2.2600,0.1350,0.0300,0.3620,1,'2022-01-01'),(121,'Отруби ржаные с морской капустой Elmika',NULL,_binary '\0',2.2000,0.1300,0.0320,0.3480,1,'2022-01-01'),(122,'Масло рафинированное рапсовое Золотая капля',NULL,_binary '\0',9.0000,0.0000,1.0000,0.0000,1,'2022-01-01'),(123,'Масло оливковое нерафинированное Santangelo',NULL,_binary '\0',8.2400,0.0000,0.9160,0.0000,1,'2022-01-01'),(124,'Сахар Слуцкий',NULL,_binary '\0',4.0000,0.0000,0.0000,1.0000,1,'2022-01-01'),(125,'Сахар ванильный',NULL,_binary '\0',3.6000,0.0000,0.0000,0.9000,1,'2022-01-01'),(126,'Конфета Albeni',NULL,_binary '\0',4.8600,0.0390,0.2630,0.5840,1,'2022-01-01'),(127,'Шоколад молочный с начинкой Коммунарка',NULL,_binary '\0',5.6000,0.0400,0.3600,0.5600,1,'2022-01-01'),(128,'Шоколад горький десертный с начинкой Столичный',NULL,_binary '\0',4.9000,0.0500,0.2700,0.5700,1,'2022-01-01'),(129,'Печенье с миндялём Любятово',NULL,_binary '\0',4.6000,0.0700,0.1800,0.0600,1,'2022-01-01'),(130,'Пряники заварные глазированные Слодыч',NULL,_binary '\0',3.8000,0.0700,0.0700,0.7000,1,'2022-01-01'),(131,'Печенье Мариэрта Слодыч',NULL,_binary '\0',4.0000,0.0950,0.0900,0.7100,1,'2022-01-01'),(132,'Арахисовая паста Bazaar',NULL,_binary '\0',6.4000,0.2500,0.5200,0.1700,1,'2022-01-01'),(133,'Мёд гречишный',NULL,_binary '\0',3.0900,0.0050,0.0000,0.7680,1,'2022-01-01'),(134,'Пряник имбирный',NULL,_binary '\0',3.5300,0.0590,0.0650,0.7050,1,'2022-01-01'),(135,'Суфле Коммунарка',NULL,_binary '\0',4.3300,0.0190,0.2070,0.6000,1,'2022-01-01'),(136,'Кетчуп для гриля и шашлыка Heinz',NULL,_binary '\0',1.1000,0.0100,0.0010,0.2500,1,'2022-01-01'),(137,'Курага',NULL,_binary '\0',2.3200,0.0520,0.0030,0.5100,1,'2022-01-01'),(138,'фасолевый суп',1544.00,_binary '',0.2655,0.0114,0.0057,0.0414,1,'2022-01-01'),(139,'пшёнка с молоком',862.00,_binary '',0.9951,0.0302,0.0310,0.1503,1,'2022-01-01'),(140,'котлеты из свинины и курятины',585.00,_binary '',2.5464,0.1395,0.1973,0.0471,1,'2022-01-01'),(141,'тушёный кабачок',681.00,_binary '',0.3337,0.0103,0.0025,0.0657,1,'2022-01-01'),(142,'сырники',533.00,_binary '',2.0549,0.1406,0.1296,0.0800,1,'2022-01-01'),(143,'фасоль гарнир',654.00,_binary '',2.0717,0.1248,0.0227,0.3841,1,'2022-01-01'),(144,'драники',792.00,_binary '',1.2566,0.0303,0.0499,0.1700,1,'2022-01-01'),(145,'лечо',3162.00,_binary '',0.7084,0.0133,0.0329,0.0879,1,'2022-01-01'),(146,'тефтели',1014.00,_binary '',1.5531,0.0817,0.1063,0.0643,1,'2022-01-01'),(147,'подлива для тефтелей',200.00,_binary '',1.3315,0.0232,0.0629,0.1623,1,'2022-01-01'),(148,'блины',768.00,_binary '',1.8447,0.0640,0.0735,0.2263,1,'2022-01-01'),(149,'пельмени',2690.00,_binary '',3.0684,0.1290,0.1578,0.2777,1,'2022-01-01'),(150,'тушёная цветная капуста',565.00,_binary '',1.1648,0.0248,0.0879,0.0754,1,'2022-01-01'),(151,'щи',1637.00,_binary '',0.5039,0.0224,0.0314,0.0331,1,'2022-01-01'),(152,'чечевица гарнир',468.00,_binary '',1.0362,0.0811,0.0040,0.1972,1,'2022-01-01'),(153,'рис с овощами',588.00,_binary '',1.2061,0.0301,0.0167,0.2347,1,'2022-01-01'),(154,'тушёные овощи',830.00,_binary '',0.9222,0.0231,0.0425,0.1100,1,'2022-01-01'),(155,'тыквенный суп',1342.00,_binary '',0.4541,0.0096,0.0222,0.0649,1,'2022-01-01'),(156,'салат мимоза',690.00,_binary '',1.5203,0.1560,0.0955,0.0026,1,'2022-01-01'),(157,'окунь тушёный',617.00,_binary '',1.6393,0.1519,0.0961,0.0305,1,'2022-01-01'),(158,'рис гарнир',742.00,_binary '',1.1389,0.0161,0.0480,0.1602,1,'2022-01-01'),(159,'булгур с овощами',657.00,_binary '',1.3870,0.0408,0.0439,0.1792,1,'2022-01-01'),(160,'борщ',1766.00,_binary '',0.3880,0.0082,0.0224,0.0379,1,'2022-01-01'),(161,'фасоль гарнир',400.00,_binary '',1.7373,0.0792,0.0619,0.2447,1,'2022-01-01'),(162,'котлеты из свинины и курятины',606.00,_binary '',3.7065,0.1449,0.3038,0.0966,1,'2022-01-01'),(163,'яблочный пирог',769.00,_binary '',2.2589,0.0536,0.0269,0.4418,1,'2022-01-01'),(164,'голубцы ленивые',661.00,_binary '',4.7554,0.2350,0.2746,0.3280,1,'2022-01-01'),(165,'meat',NULL,_binary '\0',0.0200,0.0000,0.0000,0.0000,1,'2022-01-01'),(173,'meat',NULL,_binary '\0',0.0100,0.0000,0.0000,0.0000,1,'2022-01-01'),(233,'еда 1',500.00,_binary '',0.8560,0.0334,0.0044,0.1690,1,'2022-04-11'),(234,'еда 2',500.00,_binary '',1.0500,0.0360,0.0060,0.2160,1,'2022-04-11'),(235,'еда 3',500.00,_binary '',0.4680,0.0282,0.0012,0.0750,1,'2022-04-11'),(238,'еда 4',500.00,_binary '',1.8480,0.0756,0.0198,0.3426,1,'2022-04-12'),(239,'еда 5',500.00,_binary '',0.2124,0.0091,0.0046,0.0331,1,'2022-04-12');
/*!40000 ALTER TABLE `food` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingridients`
--

DROP TABLE IF EXISTS `ingridients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingridients` (
  `dish_id` int unsigned NOT NULL,
  `ingridient_id` int unsigned NOT NULL,
  `weight` decimal(6,2) NOT NULL,
  PRIMARY KEY (`dish_id`,`ingridient_id`),
  KEY `ingridient_fk_idx` (`ingridient_id`),
  CONSTRAINT `dish_fk` FOREIGN KEY (`dish_id`) REFERENCES `food` (`food_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ingridient_fk` FOREIGN KEY (`ingridient_id`) REFERENCES `food` (`food_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingridients`
--

LOCK TABLES `ingridients` WRITE;
/*!40000 ALTER TABLE `ingridients` DISABLE KEYS */;
INSERT INTO `ingridients` VALUES (138,6,13.00),(138,18,43.00),(138,26,47.00),(138,31,194.00),(138,48,19.00),(139,4,170.00),(139,76,150.00),(139,88,20.00),(139,137,20.00),(140,29,65.00),(140,45,138.00),(140,48,277.00),(140,74,43.00),(140,114,47.00),(140,122,15.00),(141,24,64.00),(141,26,126.00),(141,29,47.00),(141,30,94.00),(141,37,473.00),(142,11,30.00),(142,91,400.00),(142,114,62.00),(142,122,26.00),(142,124,15.00),(143,17,362.00),(143,24,144.00),(143,29,122.00),(143,39,13.00),(143,108,13.00),(144,29,67.00),(144,31,790.00),(144,114,57.00),(144,122,30.00),(145,24,1000.00),(145,25,1500.00),(145,26,500.00),(145,29,500.00),(145,122,100.00),(145,124,100.00),(146,9,80.00),(146,29,68.00),(146,45,133.00),(146,48,267.00),(146,114,58.00),(146,122,10.00),(147,76,85.00),(147,116,13.00),(147,122,10.00),(147,136,78.00),(148,76,437.00),(148,114,110.00),(148,116,221.00),(148,122,30.00),(149,29,317.00),(149,47,483.00),(149,48,965.00),(149,76,650.00),(149,114,62.00),(149,116,1000.00),(150,26,107.00),(150,29,155.00),(150,33,417.00),(150,122,48.00),(151,26,72.00),(151,27,292.00),(151,29,46.00),(151,31,195.00),(151,49,171.00),(152,14,149.00),(152,26,84.00),(152,29,79.00),(153,9,150.00),(153,34,180.00),(153,122,5.00),(154,12,90.00),(154,24,160.00),(154,25,90.00),(154,26,85.00),(154,27,240.00),(154,29,135.00),(154,122,30.00),(155,29,62.00),(155,31,241.00),(155,35,555.00),(155,122,27.00),(156,59,247.00),(156,83,90.00),(156,114,253.00),(157,26,64.00),(157,29,176.00),(157,54,591.00),(157,122,50.00),(158,9,150.00),(158,26,58.00),(158,29,47.00),(158,122,34.00),(159,5,150.00),(159,34,209.00),(159,122,23.00),(160,24,123.00),(160,26,42.00),(160,29,50.00),(160,31,224.00),(160,36,225.00),(160,49,28.00),(160,122,30.00),(161,17,150.00),(161,29,23.00),(161,122,22.00),(162,29,48.00),(162,47,161.00),(162,48,322.00),(162,75,68.00),(162,81,38.00),(162,114,52.00),(162,122,38.00),(163,102,339.00),(163,114,159.00),(163,116,197.00),(163,124,156.00),(163,125,15.00),(164,9,277.00),(164,29,126.00),(164,45,242.00),(164,48,485.00),(164,81,36.00),(164,114,63.00),(233,1,100.00),(233,16,100.00),(234,1,150.00),(235,16,300.00),(238,2,300.00),(239,138,400.00);
/*!40000 ALTER TABLE `ingridients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `total`
--

DROP TABLE IF EXISTS `total`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `total` (
  `date` date NOT NULL,
  `user_id` int unsigned NOT NULL,
  `morning_weight` decimal(5,2) unsigned DEFAULT NULL,
  `kcal_total` decimal(6,2) unsigned DEFAULT NULL,
  `proteins_total` decimal(5,2) unsigned DEFAULT NULL,
  `fats_total` decimal(5,2) unsigned DEFAULT NULL,
  `carbohydrates_total` decimal(5,2) unsigned DEFAULT NULL,
  PRIMARY KEY (`date`,`user_id`),
  KEY `user_total_fk_idx` (`user_id`),
  CONSTRAINT `user_total_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `total`
--

LOCK TABLES `total` WRITE;
/*!40000 ALTER TABLE `total` DISABLE KEYS */;
INSERT INTO `total` VALUES ('2022-03-07',1,NULL,119.38,1.02,1.02,24.89),('2022-03-08',1,NULL,525.60,16.96,12.84,82.12),('2022-03-14',1,NULL,370.00,10.00,6.00,68.00),('2022-03-17',1,NULL,2.00,0.00,0.00,0.00),('2022-04-04',1,NULL,1275.94,52.22,32.94,186.24),('2022-04-05',1,NULL,1301.40,57.31,42.77,170.26),('2022-04-06',1,NULL,1498.41,78.43,54.09,171.39),('2022-04-07',1,NULL,1507.99,53.42,55.20,195.76),('2022-04-08',1,NULL,1455.70,65.98,60.11,171.30),('2022-04-09',1,NULL,1598.98,50.58,35.68,268.54),('2022-04-10',1,NULL,1538.18,66.91,61.79,182.15),('2022-04-11',1,NULL,1344.00,43.75,41.88,193.37);
/*!40000 ALTER TABLE `total` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(64) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Omnistrom');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'optimum'
--
/*!50003 DROP PROCEDURE IF EXISTS `select_cooked_ingridients` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `select_cooked_ingridients`(IN cooked_id INT UNSIGNED)
BEGIN
	SELECT
		i.ingridient_id AS id,
		f.food_name AS name,
		i.weight AS weight,
		f.kcal_1,
		f.proteins_1,
		f.fats_1,
		f.carbohydrates_1
	FROM 
		ingridients i INNER JOIN food f
		ON i.ingridient_id = f.food_id
	WHERE i.dish_id = cooked_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `select_cooked_matches` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `select_cooked_matches`(IN providedFilter VARCHAR(64))
BEGIN
	SELECT 
		food_id AS id, 
		food_name AS name,
        weight,
		ROUND(kcal_1 * 100, 2) AS kcal,
		ROUND(proteins_1 * 100, 2) AS proteins,
		ROUND(fats_1 * 100, 2) AS fats,
		ROUND(carbohydrates_1 * 100, 2) AS carbohydrates,
		date
	FROM food
	WHERE
		is_dish = 1 AND 
        added_by_user = 1 AND
        food_name LIKE providedFilter;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `select_day_total_stat` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `select_day_total_stat`(IN providedDate VARCHAR(32))
BEGIN
	SELECT 
      kcal_total AS kcal,
      proteins_total AS proteins,
      fats_total AS fats,
      carbohydrates_total AS carbohydrates
      FROM total
      WHERE date = str_to_date(providedDate, "%W %M %d %Y");
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `select_first_from_last` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `select_first_from_last`()
BEGIN
	call select_last_cooked(6);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `select_first_from_last_cooked` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `select_first_from_last_cooked`(IN providedCount INT)
BEGIN
	(SELECT 
		food_id AS id, 
		food_name AS name,
        weight,
		ROUND(kcal_1 * 100, 2) AS kcal,
		ROUND(proteins_1 * 100, 2) AS proteins,
		ROUND(fats_1 * weight, 2) AS fats,
		ROUND(carbohydrates_1 * 100, 2) AS carbohydrates,
		date
	FROM food
	WHERE
		is_dish = 1 AND added_by_user = 1
	ORDER BY id DESC
	LIMIT providedCount) 
    ORDER BY id ASC 
    LIMIT 1;   
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `select_food_matches` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `select_food_matches`(IN filter VARCHAR(64))
BEGIN
	SELECT 
		food_id AS id,
        food_name AS name,
		CASE 
			WHEN is_dish = 0
				THEN NULL
			WHEN is_dish = 1
				THEN date
		END date
	FROM food
    WHERE food_name LIKE filter;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `select_food_on_date` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `select_food_on_date`(IN providedDate VARCHAR(32))
BEGIN
	SELECT
        d.day_stat_id AS dayStatId,
		f.food_name AS name, 
		d.weight AS weight,
		ROUND(f.kcal_1 * d.weight, 2) AS kcal,
		ROUND(f.proteins_1 * d.weight, 2) AS proteins,
		ROUND(f.fats_1 * d.weight, 2) AS fats,
		ROUND(f.carbohydrates_1 * d.weight, 2) AS carbohydrates
	FROM 
		day_stat d INNER JOIN food f
		ON d.food_id = f.food_id
	WHERE d.date = str_to_date(providedDate, '%W %M %d %Y');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `select_last_cooked` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `select_last_cooked`(IN providedCount INT)
BEGIN
	(SELECT 
		food_id AS id, 
		food_name AS name,
        weight,
		ROUND(kcal_1 * 100, 2) AS kcal,
		ROUND(proteins_1 * 100, 2) AS proteins,
		ROUND(fats_1 * 100, 2) AS fats,
		ROUND(carbohydrates_1 * 100, 2) AS carbohydrates,
		date
	FROM food
	WHERE
		is_dish = 1 AND added_by_user = 1
	ORDER BY id DESC
	LIMIT providedCount) 
    ORDER BY id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `select_totalstat_list` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `select_totalstat_list`(IN fromDate VARCHAR(32), IN toDate VARCHAR(32))
BEGIN
	SELECT
		date,
		kcal_total AS kcal,
		proteins_total AS proteins,
		fats_total AS fats,
		carbohydrates_total AS carbohydrates
	FROM total
	WHERE
		user_id = 1 AND
		date >= str_to_date(fromDate, "%W %M %d %Y") AND
		date <= str_to_date(toDate, "%W %M %d %Y");
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `select_totalstat_period` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `select_totalstat_period`(IN fromDate VARCHAR(32), IN toDate VARCHAR(32))
BEGIN
	SELECT
		date,
		kcal_total AS kcal,
		proteins_total AS proteins,
		fats_total AS fats,
		carbohydrates_total AS carbohydrates
	FROM total
	WHERE
		user_id = 1 AND
		date >= str_to_date(fromDate, "%W %M %d %Y") AND
		date <= str_to_date(toDate, "%W %M %d %Y");
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-27 11:58:36
