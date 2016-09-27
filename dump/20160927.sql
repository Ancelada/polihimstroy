USE `danydonatt_polih`;
-- MySQL dump 10.13  Distrib 5.5.46, for debian-linux-gnu (i686)
--
-- Host: 127.0.0.1    Database: polihimstroy
-- ------------------------------------------------------
-- Server version	5.5.46-0ubuntu0.14.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `KeyWord`
--

DROP TABLE IF EXISTS `KeyWord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `KeyWord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Unit_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `KeyWord_Unit_id_51407983_fk_Unit_id` (`Unit_id`),
  CONSTRAINT `KeyWord_Unit_id_51407983_fk_Unit_id` FOREIGN KEY (`Unit_id`) REFERENCES `Unit` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `KeyWord`
--

LOCK TABLES `KeyWord` WRITE;
/*!40000 ALTER TABLE `KeyWord` DISABLE KEYS */;
INSERT INTO `KeyWord` VALUES (1,'Бензол-толуольная фракция',14),(2,'Бентол технические характеристики',14),(3,'Фракция бензол-толуольная',14),(4,'Бентол описание продукта',14);
/*!40000 ALTER TABLE `KeyWord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Article`
--

DROP TABLE IF EXISTS `Article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Text` longtext COLLATE utf8_unicode_ci,
  `KeyWord_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Article_88be9101` (`KeyWord_id`),
  CONSTRAINT `Article_KeyWord_id_f3612dd9_fk_KeyWord_id` FOREIGN KEY (`KeyWord_id`) REFERENCES `KeyWord` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Article`
--

LOCK TABLES `Article` WRITE;
/*!40000 ALTER TABLE `Article` DISABLE KEYS */;
INSERT INTO `Article` VALUES (1,'Применение\r\n\r\nПродукт может найти применение в качестве растворителя в лакокрасочной промышленности, компонента моторных топлив, а также для выделения бензола и толуола.\r\nПолезная информация\r\n\r\nКомпоненты продукта имеют регистрацию по REACH\r\nRON = 115, MON 103\r\nRVP = 2.9 KPa\r\nПлотность = 870 кг/м3\r\nTotal sulphur = less than 100 ppm\r\nБензол = 20%\r\nКод ТНВЭД определяется в зависимости от целей использования.\r\nБензол для топлива	\r\n \r\n\r\n2707101000\r\nБензол для прочих целей	\r\n \r\n\r\n2707109000\r\nТолуол для топлива	\r\n \r\n\r\n2707201000\r\nТолуол для прочих целей	\r\n \r\n\r\n2707209000',1),(2,'Бензол-толуольная фракция (бентол) – высокооктановая ароматическая добавка к прямогонным бензинам.\r\nБентол – растворитель нефтяной ТУ 2458-001-98803446-2013 октановое число 103 единицы по моторному методу, запах характерный бензину.\r\nПаспорт\r\n№	Наименование показателя	Норма по ТУ	Показатели партии\r\n1	Внешний вид	Прозрачная жидкость светлого цвета	Прозрачная жидкость светло-желтого цвета\r\n2	Плотность при 20 0С, г/см3	0,650-0,950	0,854\r\n3	Температура застывания не ниже, 0С	-30	-38\r\n4 Кинематическая вязкость при 20 0С, не более, мм2/с	15	2,1\r\n5	Температура начала кипения, не ниже, 0С	30	82\r\n6	Испаряется до 185 0С, не менее, %	70	111\r\n7	Конец кипения, не выше, 0С	290	129\r\n8	Объемная доля бензола, %	10,0-20,0	11,7 \r\n9	Объемная доля толуола, %	50,0-70,0	63,7\r\nГрупповой состав:	\r\n10	Объемная доля парафинов (алканов), %	0,5-1,5	1,0\r\n11	Объемная доля изопарафинов , %	2,5-5,0	3,7\r\n12	Объемная доля ароматических углеводородов, %	60,0-80,0	76,1\r\n13	Объемная доля нафтенов, %	10,0-20,0	10,6\r\n14	Объемная доля олефинов, %	2,0-10,0	4,4\r\n15	Объемная доля оксигенатов, %	отсутствие\r\n16	Октановое число по исследовательскому методу	104\r\nПроизводитель гарантирует стабильность показателей качества в течение 1 года, при соблюдении условий хранения.\r\nОтгрузка производится авто наливом.\r\nВозможность с нашей стороны доставки бензовозами объемом 40,230; 35,180; 23,330; 16,700; 6,720 кубов.\r\nНорма ввода: на 1 тонну топлива 2-10 % Октан + не менее 6-15 ед.',3),(3,'Технические характеристики\r\n\r\nНаименование \r\nпоказателя\r\nНорма\r\n1 Внешний вид\r\nБесцветная или слабожелтая \r\nжидкость\r\n\r\n2 Плотность при 20 0С, г/см3\r\n\r\n0,867 – 0,873\r\n\r\n3 Массовая доля компонентов, %:\r\n- бензола\r\n- толуола\r\n - этилбензола и стирола, не более\r\n\r\n\r\n20,0 – 50,0\r\n50,0 – 80,0\r\n6,0',2),(4,'Бентол используется как товарный продукт на коксохимических заводах для получения из него бензола и толуола, а этилбензол снова поступает на дегидрирование. \r\n\r\nБентол, легковоспламеняющаяся жидкость, представляющая собой смесь бензола, этилбензола и толуола. С; в воде нерастворим. \r\n\r\nПри ректификации печное масло разделяется на стирол-ректификат I и II сортов, бентол, возвратный этилбензол и тяжелый остаток. Ректификация ведется под вакуумом, создаваемым пароэжекционными установками. Стирол-ректификат и бентол представляют собой товарную продукцию. \r\n\r\nНа основе проделанных опытов подобраны следующие условия анализа для рассольного конденсата, печного масла, бентола, технического этшгбензола, возвратного этилбензола. \r\n\r\nНа следующие сутки и через 12 суток брали по 1 г полученных смесей, мелко нарезали и помещали в патрон из текстиля в 100 мл бентола в колбы с притертыми пробками. По разности весов А - Б находилось количество растворенного ( несвязанного) каучука во взятом объеме раствора. \r\n\r\nТак, в качестве добавок предлагается в соляную кислоту вводить: пеназолин ( гидрохлорид), оксиэтилирован-ный алкилфенол С5 - С7, алкиловый спирт Cj - C5, фосфоно-метилированное производное 1 3-диаминопропанола - 2, хлорид натрия, бентол и ОП-10, инкредол, гидрооксиэтилированные алкилфенолы. Разработан ряд составов с добавлением к соляной кислоте реагентов Т-66 и ЗМ, которые позволили на 13 % повысить эффективность растворения гипсоуглеводородных отложений.\r\n\r\nПри ректификации печное масло разделяется на стирол-ректификат I и II сортов, бентол, возвратный этилбензол и тяжелый остаток. Ректификация ведется под вакуумом, создаваемым пароэжекционными установками. Стирол-ректификат и бентол представляют собой товарную продукцию.',4);
/*!40000 ALTER TABLE `Article` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-09-27  8:48:04
