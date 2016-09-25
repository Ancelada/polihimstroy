-- phpMyAdmin SQL Dump
-- version 4.4.6.1
-- http://www.phpmyadmin.net
--
-- Хост: taurus.shared
-- Время создания: Сен 22 2016 г., 16:54
-- Версия сервера: 10.1.17-MariaDB
-- Версия PHP: 5.4.45-pl0-gentoo

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `danydonatt_polih`
--

-- --------------------------------------------------------

--
-- Структура таблицы `auth_group`
--

CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(80) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `auth_group_permissions`
--

CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `auth_permission`
--

CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can add permission', 2, 'add_permission'),
(5, 'Can change permission', 2, 'change_permission'),
(6, 'Can delete permission', 2, 'delete_permission'),
(7, 'Can add group', 3, 'add_group'),
(8, 'Can change group', 3, 'change_group'),
(9, 'Can delete group', 3, 'delete_group'),
(10, 'Can add user', 4, 'add_user'),
(11, 'Can change user', 4, 'change_user'),
(12, 'Can delete user', 4, 'delete_user'),
(13, 'Can add content type', 5, 'add_contenttype'),
(14, 'Can change content type', 5, 'change_contenttype'),
(15, 'Can delete content type', 5, 'delete_contenttype'),
(16, 'Can add session', 6, 'add_session'),
(17, 'Can change session', 6, 'change_session'),
(18, 'Can delete session', 6, 'delete_session'),
(19, 'Can add paragraph', 7, 'add_paragraph'),
(20, 'Can change paragraph', 7, 'change_paragraph'),
(21, 'Can delete paragraph', 7, 'delete_paragraph'),
(22, 'Can add unit', 8, 'add_unit'),
(23, 'Can change unit', 8, 'change_unit'),
(24, 'Can delete unit', 8, 'delete_unit'),
(25, 'Can add order', 9, 'add_order'),
(26, 'Can change order', 9, 'change_order'),
(27, 'Can delete order', 9, 'delete_order'),
(28, 'Can add get in touch', 10, 'add_getintouch'),
(29, 'Can change get in touch', 10, 'change_getintouch'),
(30, 'Can delete get in touch', 10, 'delete_getintouch'),
(31, 'Can add transport order', 11, 'add_transportorder'),
(32, 'Can change transport order', 11, 'change_transportorder'),
(33, 'Can delete transport order', 11, 'delete_transportorder');

-- --------------------------------------------------------

--
-- Структура таблицы `auth_user`
--

CREATE TABLE IF NOT EXISTS `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `first_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(254) COLLATE utf8_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$20000$bp1iH8eShQnA$920N+jubbS0beG6xpw/1s0av0vyc4zW2VgMwMjyPWEw=', '2016-09-21 19:18:24', 1, 'ancel', '', '', 'anceladamusic@gmail.com', 1, 1, '2016-07-30 15:15:25'),
(2, 'pbkdf2_sha256$24000$EFU6HDOUMwda$TCLiR45vUAgvLZ3otHiE7Ccb7t9YxCfVZRF7UZcwyz8=', '2016-08-13 13:08:42', 0, 'leonid', '', '', '', 0, 1, '2016-08-13 13:08:09');

-- --------------------------------------------------------

--
-- Структура таблицы `auth_user_groups`
--

CREATE TABLE IF NOT EXISTS `auth_user_groups` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `auth_user_user_permissions`
--

CREATE TABLE IF NOT EXISTS `auth_user_user_permissions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `django_admin_log`
--

CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime NOT NULL,
  `object_id` longtext COLLATE utf8_unicode_ci,
  `object_repr` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext COLLATE utf8_unicode_ci NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=165 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2016-07-31 12:32:19', '1', 'химическое сырье', 1, 'Добавлено.', 7, 1),
(2, '2016-07-31 12:32:58', '2', 'бочки, кубовые ёмкости', 1, 'Добавлено.', 7, 1),
(3, '2016-07-31 12:33:29', '3', 'лакокрасочная продукция', 1, 'Добавлено.', 7, 1),
(4, '2016-07-31 12:34:23', '3', 'продукция для разметки дорожного покрытия', 2, 'Изменен Name.', 7, 1),
(5, '2016-07-31 12:34:57', '4', 'автошампунь (пена)', 1, 'Добавлено.', 7, 1),
(6, '2016-07-31 12:35:26', '5', 'теплоноситель, антифриз, тосол', 1, 'Добавлено.', 7, 1),
(7, '2016-08-06 12:12:39', '3', 'продукция для разметки дорог', 2, 'Изменен Name.', 7, 1),
(8, '2016-08-09 05:29:20', '1', 'Бутилцеллозольв', 1, 'Добавлено.', 8, 1),
(9, '2016-08-09 05:30:54', '2', 'Дипроксамин 157', 1, 'Добавлено.', 8, 1),
(10, '2016-08-09 05:32:41', '3', 'Дипроксамин 157-65', 1, 'Добавлено.', 8, 1),
(11, '2016-08-09 05:33:23', '2', 'Дипроксамин 157', 2, 'Изменен Description.', 8, 1),
(12, '2016-08-09 05:34:52', '4', 'Диэтаноламин чист.', 1, 'Добавлено.', 8, 1),
(13, '2016-08-09 05:36:15', '5', 'Диэтаноламин м.Б', 1, 'Добавлено.', 8, 1),
(14, '2016-08-09 05:36:47', '1', 'бутилцеллозольв', 2, 'Изменен Name.', 8, 1),
(15, '2016-08-09 05:36:52', '2', 'дипроксамин 157', 2, 'Изменен Name.', 8, 1),
(16, '2016-08-09 05:36:56', '3', 'дипроксамин 157-65', 2, 'Изменен Name.', 8, 1),
(17, '2016-08-09 05:37:01', '4', 'диэтаноламин чист.', 2, 'Изменен Name.', 8, 1),
(18, '2016-08-09 05:37:08', '5', 'диэтаноламин м.б', 2, 'Изменен Name.', 8, 1),
(19, '2016-08-09 05:38:38', '6', 'моноэтаноламин в/с', 1, 'Добавлено.', 8, 1),
(20, '2016-08-09 05:40:11', '7', 'триэтаноламин', 1, 'Добавлено.', 8, 1),
(21, '2016-08-09 05:40:46', '7', 'триэтаноламин м.а', 2, 'Изменен Name.', 8, 1),
(22, '2016-08-09 05:41:15', '8', 'триэтаноламин м.б', 1, 'Добавлено.', 8, 1),
(23, '2016-08-09 05:44:54', '9', 'этиленгликоль в/с', 1, 'Добавлено.', 8, 1),
(24, '2016-08-09 05:46:17', '10', 'этилцеллозольв', 1, 'Добавлено.', 8, 1),
(25, '2016-08-09 05:47:51', '11', 'этилацетат', 1, 'Добавлено.', 8, 1),
(26, '2016-08-09 05:50:09', '12', 'ацетон', 1, 'Добавлено.', 8, 1),
(27, '2016-08-09 05:50:55', '13', 'толуол', 1, 'Добавлено.', 8, 1),
(28, '2016-08-09 05:52:14', '14', 'бентол', 1, 'Добавлено.', 8, 1),
(29, '2016-08-09 05:54:14', '15', 'arbreak', 1, 'Добавлено.', 8, 1),
(30, '2016-08-09 05:59:29', '15', 'arbreak', 2, 'Изменен Description.', 8, 1),
(31, '2016-08-09 06:03:51', '16', 'стеариновая кислота', 1, 'Добавлено.', 8, 1),
(32, '2016-08-09 06:08:26', '17', 'олеиновая кислота Б-115', 1, 'Добавлено.', 8, 1),
(33, '2016-08-09 06:36:33', '18', 'олеиновая кислота марки В', 1, 'Добавлено.', 8, 1),
(34, '2016-08-09 06:38:55', '19', 'дистилированные жирные кислоты соапстока', 1, 'Добавлено.', 8, 1),
(35, '2016-08-09 06:46:35', '20', 'глицерин дистилированный марок д-98 и пк-94', 1, 'Добавлено.', 8, 1),
(36, '2016-08-09 06:49:16', '21', 'лауретсульфат натрия (сульфоэтоксилат)', 1, 'Добавлено.', 8, 1),
(37, '2016-08-09 06:57:00', '22', 'каустическая сода (гидроксид натрия)', 1, 'Добавлено.', 8, 1),
(38, '2016-08-09 06:58:24', '23', 'оксиэтилидендифосфоновая кислота (ОЭДФ)', 1, 'Добавлено.', 8, 1),
(39, '2016-08-09 06:59:46', '24', 'тетранатриевая соль', 1, 'Добавлено.', 8, 1),
(40, '2016-08-09 07:03:26', '25', 'нитрилотриуксусная кислота', 1, 'Добавлено.', 8, 1),
(41, '2016-08-09 07:05:24', '26', 'кокамидопропиламиноксид', 1, 'Добавлено.', 8, 1),
(42, '2016-08-09 07:08:57', '27', 'теплоноситель', 1, 'Добавлено.', 8, 1),
(43, '2016-08-09 07:10:28', '28', 'пропиленгликоль', 1, 'Добавлено.', 8, 1),
(44, '2016-08-09 07:10:59', '29', 'Глицерин', 1, 'Добавлено.', 8, 1),
(45, '2016-08-09 07:11:05', '29', 'глицерин', 2, 'Изменен Name.', 8, 1),
(46, '2016-08-09 07:13:30', '30', 'вода дистиллированная', 1, 'Добавлено.', 8, 1),
(47, '2016-08-09 07:15:20', '31', 'алькилбензолсульфокислота (АБСК)', 1, 'Добавлено.', 8, 1),
(48, '2016-08-09 09:32:56', '1', 'химическое сырье', 2, 'Изменен Large.', 7, 1),
(49, '2016-08-09 09:33:06', '4', 'автошампунь (пена)', 2, 'Изменен Large.', 7, 1),
(50, '2016-08-09 09:33:19', '3', 'продукция для разметки дорог', 2, 'Изменен Large.', 7, 1),
(51, '2016-08-09 09:33:35', '2', 'бочки, кубовые ёмкости', 2, 'Изменен Large.', 7, 1),
(52, '2016-08-09 09:33:59', '6', 'автогрузоперевозки', 1, 'Добавлено.', 7, 1),
(53, '2016-08-09 09:34:11', '5', 'теплоноситель, антифриз, тосол', 2, 'Изменен Large.', 7, 1),
(54, '2016-08-09 09:35:01', '7', 'собственная спецтехника', 1, 'Добавлено.', 7, 1),
(55, '2016-08-09 09:38:40', '1', 'химическое сырье', 2, 'Изменен Image.', 7, 1),
(56, '2016-08-09 09:41:48', '1', 'химическое сырье', 2, 'Изменен Image.', 7, 1),
(57, '2016-08-09 09:46:42', '1', 'химическое сырье', 2, 'Изменен Image.', 7, 1),
(58, '2016-08-09 09:49:08', '6', 'автогрузоперевозки', 2, 'Изменен Image.', 7, 1),
(59, '2016-08-09 09:49:48', '7', 'собственная спецтехника', 2, 'Изменен Image.', 7, 1),
(60, '2016-08-09 09:50:15', '6', 'автогрузоперевозки', 2, 'Изменен Image.', 7, 1),
(61, '2016-08-09 09:54:17', '6', 'автогрузоперевозки', 2, 'Изменен Image.', 7, 1),
(62, '2016-08-09 10:04:30', '2', 'бочки, кубовые ёмкости', 2, 'Изменен Image.', 7, 1),
(63, '2016-08-09 10:07:20', '1', 'химическое сырье', 2, 'Изменен Image.', 7, 1),
(64, '2016-08-09 10:08:56', '1', 'химическое сырье', 2, 'Изменен No.', 7, 1),
(65, '2016-08-09 10:09:06', '4', 'автошампунь (пена)', 2, 'Изменен No.', 7, 1),
(66, '2016-08-09 10:09:12', '3', 'продукция для разметки дорог', 2, 'Изменен No.', 7, 1),
(67, '2016-08-09 10:09:19', '2', 'бочки, кубовые ёмкости', 2, 'Изменен No.', 7, 1),
(68, '2016-08-09 10:09:29', '6', 'автогрузоперевозки', 2, 'Изменен No.', 7, 1),
(69, '2016-08-09 10:09:42', '5', 'теплоноситель, антифриз, тосол', 2, 'Изменен No.', 7, 1),
(70, '2016-08-09 10:09:52', '7', 'собственная спецтехника', 2, 'Изменен No.', 7, 1),
(71, '2016-08-09 10:27:00', '1', 'химическое сырье', 2, 'Изменен Image.', 7, 1),
(72, '2016-08-09 11:03:18', '32', 'автошампунь (пена) 1кг', 1, 'Добавлено.', 8, 1),
(73, '2016-08-09 11:03:46', '33', 'автошампунь (пена) 5кг', 1, 'Добавлено.', 8, 1),
(74, '2016-08-09 11:04:06', '34', 'автошампунь (пена) 10кг', 1, 'Добавлено.', 8, 1),
(75, '2016-08-09 11:04:17', '35', 'автошампунь (пена) 20кг', 1, 'Добавлено.', 8, 1),
(76, '2016-08-09 11:04:34', '36', 'автошампунь (пена) 225кг', 1, 'Добавлено.', 8, 1),
(77, '2016-08-09 11:06:30', '37', 'Эмаль КО-525 20-25л.', 1, 'Добавлено.', 8, 1),
(78, '2016-08-09 11:06:41', '37', 'эмаль КО-525 20-25л.', 2, 'Изменен Name.', 8, 1),
(79, '2016-08-09 11:07:28', '38', 'эмаль КО-525 50л.', 1, 'Добавлено.', 8, 1),
(80, '2016-08-09 11:08:04', '39', 'эмаль КО-525 200л.', 1, 'Добавлено.', 8, 1),
(81, '2016-08-09 11:09:58', '40', 'бочки металические', 1, 'Добавлено.', 8, 1),
(82, '2016-08-09 11:10:11', '41', 'кубовые емкости', 1, 'Добавлено.', 8, 1),
(83, '2016-08-09 11:11:18', '42', 'контейнером', 1, 'Добавлено.', 8, 1),
(84, '2016-08-09 11:11:45', '43', 'ж/д вагонами', 1, 'Добавлено.', 8, 1),
(85, '2016-08-09 11:55:16', '1', 'химическое сырье', 2, 'Изменен AlignLeft.', 7, 1),
(86, '2016-08-09 11:55:25', '4', 'автошампунь (пена)', 2, 'Изменен AlignLeft.', 7, 1),
(87, '2016-08-09 11:55:35', '3', 'продукция для разметки дорог', 2, 'Изменен AlignLeft.', 7, 1),
(88, '2016-08-09 11:55:43', '2', 'бочки, кубовые ёмкости', 2, 'Изменен AlignLeft.', 7, 1),
(89, '2016-08-09 11:55:53', '6', 'автогрузоперевозки', 2, 'Изменен AlignLeft.', 7, 1),
(90, '2016-08-09 11:56:02', '5', 'теплоноситель, антифриз, тосол', 2, 'Изменен AlignLeft.', 7, 1),
(91, '2016-08-09 11:56:10', '7', 'собственная спецтехника', 2, 'Изменен AlignLeft.', 7, 1),
(92, '2016-08-09 12:23:34', '1', 'химическое сырье', 2, 'Изменен Image.', 7, 1),
(93, '2016-08-09 12:33:05', '44', 'cклад временного хранения', 1, 'Добавлено.', 8, 1),
(94, '2016-08-09 12:33:24', '45', 'разгрузочно погрузочные работы', 1, 'Добавлено.', 8, 1),
(95, '2016-08-09 12:33:57', '46', 'вилочный погрузчик (1500 кг)', 1, 'Добавлено.', 8, 1),
(96, '2016-08-09 12:34:13', '47', 'фронтальный погрузчик', 1, 'Добавлено.', 8, 1),
(97, '2016-08-09 12:34:50', '48', 'трактор-экскаватор', 1, 'Добавлено.', 8, 1),
(98, '2016-08-09 12:35:12', '49', 'манипулятор', 1, 'Добавлено.', 8, 1),
(99, '2016-08-09 12:35:44', '50', 'газель (1,5-2 тн)', 1, 'Добавлено.', 8, 1),
(100, '2016-08-09 12:36:01', '51', 'волдай (5 тн)', 1, 'Добавлено.', 8, 1),
(101, '2016-08-09 12:36:39', '52', 'фура (20 тн тент. )', 1, 'Добавлено.', 8, 1),
(102, '2016-08-09 12:42:07', '53', 'антифриз стандарт G11 (синий)', 1, 'Добавлено.', 8, 1),
(103, '2016-08-09 12:42:22', '54', 'антифриз премиум G11 (зеленый)', 1, 'Добавлено.', 8, 1),
(104, '2016-08-09 12:42:38', '55', 'антифриз красный G12', 1, 'Добавлено.', 8, 1),
(105, '2016-08-09 12:43:00', '56', 'антифриз спорт G12++', 1, 'Добавлено.', 8, 1),
(106, '2016-08-09 12:43:21', '57', 'теплоноситель для системы отопления', 1, 'Добавлено.', 8, 1),
(107, '2016-08-09 13:04:47', '1', 'химическое сырье', 2, 'Изменен Image.', 7, 1),
(108, '2016-08-09 13:17:37', '2', 'бочки, кубовые ёмкости', 2, 'Изменен Image.', 7, 1),
(109, '2016-08-09 13:19:37', '6', 'автогрузоперевозки', 2, 'Изменен Image.', 7, 1),
(110, '2016-08-09 13:20:45', '6', 'перевозка грузов', 2, 'Изменен Name.', 7, 1),
(111, '2016-08-09 13:21:11', '6', 'перевозка грузов', 2, 'Изменен Image.', 7, 1),
(112, '2016-08-09 13:26:18', '7', 'собственная спецтехника', 2, 'Изменен Image.', 7, 1),
(113, '2016-08-13 12:41:35', '8', 'изделия из полипропилена', 1, 'Добавлено.', 7, 1),
(114, '2016-08-13 12:41:47', '7', 'собственная спецтехника', 2, 'Изменен No и AlignLeft.', 7, 1),
(115, '2016-08-13 12:44:11', '58', 'нить полипропиленовая', 1, 'Добавлено.', 8, 1),
(116, '2016-08-13 12:45:54', '59', 'полотно полипропиленовое', 1, 'Добавлено.', 8, 1),
(117, '2016-08-13 12:47:51', '59', 'полотно полипропиленовое', 2, 'Изменен Description.', 8, 1),
(118, '2016-08-13 12:48:44', '60', 'рукавная ткань', 1, 'Добавлено.', 8, 1),
(119, '2016-08-13 12:49:22', '61', 'мешок полипропиленовый с клапаном коробчатого типа', 1, 'Добавлено.', 8, 1),
(120, '2016-08-13 12:50:17', '62', 'мешок полипропиленовый (коробчатое дно) с открытым верхом', 1, 'Добавлено.', 8, 1),
(121, '2016-08-13 12:51:07', '63', 'мешок полипропиленовый с прошивным дном', 1, 'Добавлено.', 8, 1),
(122, '2016-08-13 12:51:58', '64', 'сумка полипропиленовая с прошивным дном и прорубными ручками', 1, 'Добавлено.', 8, 1),
(123, '2016-08-13 12:52:37', '65', 'сумка полипропиленовая с прошивным дном с ручками', 1, 'Добавлено.', 8, 1),
(124, '2016-08-13 13:08:09', '2', 'leonid', 1, 'Добавлено.', 4, 1),
(125, '2016-08-21 08:28:55', '2', 'бочки, кубовые ёмкости', 2, 'Изменен Image.', 7, 1),
(126, '2016-08-21 10:36:40', '1', 'химическое сырье', 2, 'Изменен AlphabetOrder.', 7, 1),
(127, '2016-08-21 11:09:59', '32', 'автошампунь (пена) 1кг', 2, 'Изменен Description.', 8, 1),
(128, '2016-08-21 11:10:08', '33', 'автошампунь (пена) 5кг', 2, 'Изменен Description.', 8, 1),
(129, '2016-08-21 11:10:14', '34', 'автошампунь (пена) 10кг', 2, 'Изменен Description.', 8, 1),
(130, '2016-08-21 11:10:21', '36', 'автошампунь (пена) 225кг', 2, 'Изменен Description.', 8, 1),
(131, '2016-08-21 11:10:26', '35', 'автошампунь (пена) 20кг', 2, 'Изменен Description.', 8, 1),
(132, '2016-08-27 13:31:27', '6', 'перевозка грузов', 2, 'Изменен TransportFlag.', 7, 1),
(133, '2016-09-07 04:43:19', '31', 'алкилбензолсульфокислота (АБСК)', 2, 'Изменен Name.', 8, 1),
(134, '2016-09-07 04:44:26', '31', 'алкилбензолсульфокислота (АБСК)', 2, 'Изменен Eng.', 8, 1),
(135, '2016-09-07 04:45:29', '15', 'arbreak', 2, 'Изменен Eng.', 8, 1),
(136, '2016-09-07 04:52:04', '19', 'дистилированные жирные кислоты соапстока', 2, 'Изменен Eng.', 8, 1),
(137, '2016-09-07 04:54:35', '12', 'ацетон технический', 2, 'Изменен Name и Eng.', 8, 1),
(138, '2016-09-07 04:56:58', '14', 'бентол', 2, 'Изменен Eng.', 8, 1),
(139, '2016-09-07 04:58:10', '1', 'бутилцеллозольв', 2, 'Изменен Eng.', 8, 1),
(140, '2016-09-07 04:59:06', '30', 'вода дистиллированная', 2, 'Изменен Eng.', 8, 1),
(141, '2016-09-07 04:59:47', '29', 'глицерин', 2, 'Изменен Eng.', 8, 1),
(142, '2016-09-07 05:01:02', '20', 'глицерин дистилированный марок д-98 и пк-94', 2, 'Изменен Eng.', 8, 1),
(143, '2016-09-07 05:03:38', '2', 'дипроксамин 157', 2, 'Изменен Eng.', 8, 1),
(144, '2016-09-07 05:04:05', '3', 'дипроксамин 157-65', 2, 'Изменен Eng.', 8, 1),
(145, '2016-09-07 05:05:32', '5', 'диэтаноламин м.б', 2, 'Изменен Eng.', 8, 1),
(146, '2016-09-07 05:05:56', '4', 'диэтаноламин чист.', 2, 'Изменен Eng.', 8, 1),
(147, '2016-09-07 05:06:38', '22', 'каустическая сода (гидроксид натрия)', 2, 'Изменен Eng.', 8, 1),
(148, '2016-09-07 05:09:25', '26', 'кокамидопропиламиноксид', 2, 'Изменен Eng.', 8, 1),
(149, '2016-09-07 05:10:09', '21', 'лауретсульфат натрия (сульфоэтоксилат)', 2, 'Изменен Eng.', 8, 1),
(150, '2016-09-07 05:10:45', '6', 'моноэтаноламин в/с', 2, 'Изменен Eng.', 8, 1),
(151, '2016-09-07 05:12:19', '25', 'нитрилотриуксусная кислота', 2, 'Изменен Eng.', 8, 1),
(152, '2016-09-07 05:12:59', '23', 'оксиэтилидендифосфоновая кислота (ОЭДФ)', 2, 'Изменен Eng.', 8, 1),
(153, '2016-09-07 05:13:29', '17', 'олеиновая кислота Б-115', 2, 'Изменен Eng.', 8, 1),
(154, '2016-09-07 05:14:13', '18', 'олеиновая кислота марки В', 2, 'Изменен Eng.', 8, 1),
(155, '2016-09-07 05:14:49', '28', 'пропиленгликоль', 2, 'Изменен Eng.', 8, 1),
(156, '2016-09-07 05:15:28', '16', 'стеариновая кислота', 2, 'Изменен Eng.', 8, 1),
(157, '2016-09-07 05:16:08', '27', 'теплоноситель', 2, 'Изменен Eng.', 8, 1),
(158, '2016-09-07 05:16:34', '24', 'тетранатриевая соль', 2, 'Изменен Eng.', 8, 1),
(159, '2016-09-07 05:16:54', '13', 'толуол', 2, 'Изменен Eng.', 8, 1),
(160, '2016-09-07 05:17:23', '7', 'триэтаноламин м.а', 2, 'Изменен Eng.', 8, 1),
(161, '2016-09-07 05:17:47', '8', 'триэтаноламин м.б', 2, 'Изменен Eng.', 8, 1),
(162, '2016-09-07 05:18:17', '11', 'этилацетат', 2, 'Изменен Eng.', 8, 1),
(163, '2016-09-07 05:18:45', '9', 'этиленгликоль в/с', 2, 'Изменен Eng.', 8, 1),
(164, '2016-09-07 05:19:12', '10', 'этилцеллозольв', 2, 'Изменен Eng.', 8, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `django_content_type`
--

CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `model` varchar(100) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(10, 'mainapp', 'getintouch'),
(9, 'mainapp', 'order'),
(7, 'mainapp', 'paragraph'),
(11, 'mainapp', 'transportorder'),
(8, 'mainapp', 'unit'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Структура таблицы `django_migrations`
--

CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` int(11) NOT NULL,
  `app` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `applied` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2016-07-30 12:59:58'),
(2, 'auth', '0001_initial', '2016-07-30 13:00:02'),
(3, 'admin', '0001_initial', '2016-07-30 13:00:03'),
(4, 'admin', '0002_logentry_remove_auto_add', '2016-07-30 13:00:03'),
(5, 'contenttypes', '0002_remove_content_type_name', '2016-07-30 13:00:04'),
(6, 'auth', '0002_alter_permission_name_max_length', '2016-07-30 13:00:04'),
(7, 'auth', '0003_alter_user_email_max_length', '2016-07-30 13:00:04'),
(8, 'auth', '0004_alter_user_username_opts', '2016-07-30 13:00:04'),
(9, 'auth', '0005_alter_user_last_login_null', '2016-07-30 13:00:05'),
(10, 'auth', '0006_require_contenttypes_0002', '2016-07-30 13:00:05'),
(11, 'auth', '0007_alter_validators_add_error_messages', '2016-07-30 13:00:05'),
(12, 'sessions', '0001_initial', '2016-07-30 13:00:05'),
(13, 'mainapp', '0001_initial', '2016-07-30 15:10:02'),
(14, 'mainapp', '0002_unit_image', '2016-07-31 12:29:48'),
(15, 'mainapp', '0003_auto_20160731_1531', '2016-07-31 12:31:37'),
(16, 'mainapp', '0004_paragraph_large', '2016-08-09 09:31:33'),
(17, 'mainapp', '0005_paragraph_no', '2016-08-09 10:08:17'),
(18, 'mainapp', '0006_paragraph_alignleft', '2016-08-09 11:54:13'),
(19, 'mainapp', '0007_order', '2016-08-13 06:58:48'),
(20, 'mainapp', '0008_auto_20160813_1005', '2016-08-13 07:06:06'),
(21, 'mainapp', '0009_paragraph_alphabetorder', '2016-08-21 10:35:59'),
(22, 'mainapp', '0010_getintouch', '2016-08-27 12:24:12'),
(23, 'mainapp', '0011_paragraph_transportflag', '2016-08-27 13:31:10'),
(24, 'mainapp', '0012_transportorder', '2016-08-27 14:29:11'),
(25, 'mainapp', '0013_transportorder_volume', '2016-08-27 14:45:20'),
(26, 'mainapp', '0014_unit_eng', '2016-09-07 04:38:34');

-- --------------------------------------------------------

--
-- Структура таблицы `django_session`
--

CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `session_data` longtext COLLATE utf8_unicode_ci NOT NULL,
  `expire_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('2sabjiabmmn9ktwc82pzmtvj0915vm1t', 'NTNiMGZmYmFlYjBhZTQzOTc0ZDRiNDY4NmFjZWEzYWE2OTdkYjNlMjp7Il9hdXRoX3VzZXJfaGFzaCI6IjRiN2M0OWNlYmY3MTFkYTJkOWZlZTMxZGQzMWNiZjBjNWZkYTU0MTciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=', '2016-09-21 04:40:20'),
('44kvx4nbrtdvol8b98d9v4q35lge77nw', 'MjMwMTYzZDFkZjY3NGE0NjBjNDgxYmQ3MzYxMjVhZmQyNTYyOWQ3MDp7Il9hdXRoX3VzZXJfaGFzaCI6IjgwOGRmNDQ0NWJjNGQ2ODBiYmZiNjhlYjY5YTg1MGFjOWI0NWNhYTQiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=', '2016-08-27 13:08:43'),
('46sx0z90a7ny1f2jbtjcnhts1pwf03vw', 'NTNiMGZmYmFlYjBhZTQzOTc0ZDRiNDY4NmFjZWEzYWE2OTdkYjNlMjp7Il9hdXRoX3VzZXJfaGFzaCI6IjRiN2M0OWNlYmY3MTFkYTJkOWZlZTMxZGQzMWNiZjBjNWZkYTU0MTciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=', '2016-09-11 07:17:46'),
('7f3m18ykulgextwhvbx63tv7e6cf3tbn', 'NTNiMGZmYmFlYjBhZTQzOTc0ZDRiNDY4NmFjZWEzYWE2OTdkYjNlMjp7Il9hdXRoX3VzZXJfaGFzaCI6IjRiN2M0OWNlYmY3MTFkYTJkOWZlZTMxZGQzMWNiZjBjNWZkYTU0MTciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=', '2016-08-22 11:42:37'),
('8pv1y1x0i7yn4p9cl6y3b2ewhywdxo6u', 'NTNiMGZmYmFlYjBhZTQzOTc0ZDRiNDY4NmFjZWEzYWE2OTdkYjNlMjp7Il9hdXRoX3VzZXJfaGFzaCI6IjRiN2M0OWNlYmY3MTFkYTJkOWZlZTMxZGQzMWNiZjBjNWZkYTU0MTciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=', '2016-08-20 12:12:24'),
('95olvkuwuqvwqvex7idfnkorxopf0w8f', 'NTNiMGZmYmFlYjBhZTQzOTc0ZDRiNDY4NmFjZWEzYWE2OTdkYjNlMjp7Il9hdXRoX3VzZXJfaGFzaCI6IjRiN2M0OWNlYmY3MTFkYTJkOWZlZTMxZGQzMWNiZjBjNWZkYTU0MTciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=', '2016-09-11 09:32:16'),
('9f58irhg1nvrfb18d69s589w4r5xzbmr', 'NTNiMGZmYmFlYjBhZTQzOTc0ZDRiNDY4NmFjZWEzYWE2OTdkYjNlMjp7Il9hdXRoX3VzZXJfaGFzaCI6IjRiN2M0OWNlYmY3MTFkYTJkOWZlZTMxZGQzMWNiZjBjNWZkYTU0MTciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=', '2016-08-23 09:41:20'),
('bjtun5uc2y3n1et428nt6c8xlqj8o326', 'YzdmYWU5NjNjNGJiYjI0MTcwMDI5NTgxNDRlNmFmMmQxNzliZTViNzp7Il9hdXRoX3VzZXJfaGFzaCI6IjQzNGUxYTVmOTIwZmQ2YzEwNzVjMDkxNzE5YzdiZjgyYTc4ZGYzMzgiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=', '2016-09-22 12:55:49'),
('c6d8x5dy6pu5n4aeubiux9kci0xl9rdx', 'NTNiMGZmYmFlYjBhZTQzOTc0ZDRiNDY4NmFjZWEzYWE2OTdkYjNlMjp7Il9hdXRoX3VzZXJfaGFzaCI6IjRiN2M0OWNlYmY3MTFkYTJkOWZlZTMxZGQzMWNiZjBjNWZkYTU0MTciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=', '2016-09-04 09:37:39'),
('eqeve937i7b3hwj8peusbdgdaj2seyvp', 'NTNiMGZmYmFlYjBhZTQzOTc0ZDRiNDY4NmFjZWEzYWE2OTdkYjNlMjp7Il9hdXRoX3VzZXJfaGFzaCI6IjRiN2M0OWNlYmY3MTFkYTJkOWZlZTMxZGQzMWNiZjBjNWZkYTU0MTciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=', '2016-08-13 15:15:38'),
('f5ty0bhta7y2lu1c4r45ny6q1iw3sfwb', 'YzdmYWU5NjNjNGJiYjI0MTcwMDI5NTgxNDRlNmFmMmQxNzliZTViNzp7Il9hdXRoX3VzZXJfaGFzaCI6IjQzNGUxYTVmOTIwZmQ2YzEwNzVjMDkxNzE5YzdiZjgyYTc4ZGYzMzgiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=', '2016-09-23 12:34:35'),
('fqtdbf4ni5ogthitz6dqrus637p96t7r', 'NTNiMGZmYmFlYjBhZTQzOTc0ZDRiNDY4NmFjZWEzYWE2OTdkYjNlMjp7Il9hdXRoX3VzZXJfaGFzaCI6IjRiN2M0OWNlYmY3MTFkYTJkOWZlZTMxZGQzMWNiZjBjNWZkYTU0MTciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=', '2016-09-03 05:52:49'),
('gn1pq9vvla47y5jiivecirfy3lgxax1s', 'YzdmYWU5NjNjNGJiYjI0MTcwMDI5NTgxNDRlNmFmMmQxNzliZTViNzp7Il9hdXRoX3VzZXJfaGFzaCI6IjQzNGUxYTVmOTIwZmQ2YzEwNzVjMDkxNzE5YzdiZjgyYTc4ZGYzMzgiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=', '2016-10-04 04:39:11'),
('k8hccwzys7sjvj1vsbeavdbre0834am2', 'NTNiMGZmYmFlYjBhZTQzOTc0ZDRiNDY4NmFjZWEzYWE2OTdkYjNlMjp7Il9hdXRoX3VzZXJfaGFzaCI6IjRiN2M0OWNlYmY3MTFkYTJkOWZlZTMxZGQzMWNiZjBjNWZkYTU0MTciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=', '2016-09-04 09:23:17'),
('lpku2x4yy7030luukk2a56jae5pmtpzu', 'YzdmYWU5NjNjNGJiYjI0MTcwMDI5NTgxNDRlNmFmMmQxNzliZTViNzp7Il9hdXRoX3VzZXJfaGFzaCI6IjQzNGUxYTVmOTIwZmQ2YzEwNzVjMDkxNzE5YzdiZjgyYTc4ZGYzMzgiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=', '2016-10-05 19:18:25'),
('lv10cggpc43l7aytr7afzpsaysvfkbsh', 'NTNiMGZmYmFlYjBhZTQzOTc0ZDRiNDY4NmFjZWEzYWE2OTdkYjNlMjp7Il9hdXRoX3VzZXJfaGFzaCI6IjRiN2M0OWNlYmY3MTFkYTJkOWZlZTMxZGQzMWNiZjBjNWZkYTU0MTciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=', '2016-08-23 13:01:23'),
('qmp5wqcxqt4w7w9tyxgd8syff7jfvzn2', 'MjdjYmVmMDhhNjU0MmE2NjFmYzFjZTYwOTQ2Mzg3ODUxYjBhMzZhNDp7Il9hdXRoX3VzZXJfaGFzaCI6IjQzNGUxYTVmOTIwZmQ2YzEwNzVjMDkxNzE5YzdiZjgyYTc4ZGYzMzgiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=', '2016-10-01 10:42:05'),
('tnfuenb4k2w7rp4fucyzjikupogqjopg', 'NTNiMGZmYmFlYjBhZTQzOTc0ZDRiNDY4NmFjZWEzYWE2OTdkYjNlMjp7Il9hdXRoX3VzZXJfaGFzaCI6IjRiN2M0OWNlYmY3MTFkYTJkOWZlZTMxZGQzMWNiZjBjNWZkYTU0MTciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=', '2016-08-23 12:32:20'),
('uilxj9po5rjqd5jp67kp39dhr261o245', 'NTNiMGZmYmFlYjBhZTQzOTc0ZDRiNDY4NmFjZWEzYWE2OTdkYjNlMjp7Il9hdXRoX3VzZXJfaGFzaCI6IjRiN2M0OWNlYmY3MTFkYTJkOWZlZTMxZGQzMWNiZjBjNWZkYTU0MTciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=', '2016-09-03 06:16:15'),
('v4greb2ud2x9h66lwuetmh7k7dfo6cuh', 'YzdmYWU5NjNjNGJiYjI0MTcwMDI5NTgxNDRlNmFmMmQxNzliZTViNzp7Il9hdXRoX3VzZXJfaGFzaCI6IjQzNGUxYTVmOTIwZmQ2YzEwNzVjMDkxNzE5YzdiZjgyYTc4ZGYzMzgiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=', '2016-09-23 07:56:46');

-- --------------------------------------------------------

--
-- Структура таблицы `GetInTouch`
--

CREATE TABLE IF NOT EXISTS `GetInTouch` (
  `id` int(11) NOT NULL,
  `Name` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TelNo` bigint(20) DEFAULT NULL,
  `Email` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Text` longtext COLLATE utf8_unicode_ci,
  `DateTime` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `GetInTouch`
--

INSERT INTO `GetInTouch` (`id`, `Name`, `TelNo`, `Email`, `Text`, `DateTime`) VALUES
(1, 'Максим', 9876603669, '9790195@bk.ru', 'Добрый день, планируем закупку Неонол 9-10, 9-12. Объем закупки одна авто цистерна 20 т. Прошу дать Ваше предложение как по доставке продукции в Москву Вашей автоцистерной так и на условиях самовывоза с завода.', '2016-08-30 11:42:00'),
(5, 'Эльвира', 3439858267, 'elvira.nabeeva@rusal.com', 'Добрый день, прошу рассмотреть возможность поставки в адрес нашего предприятия  евро-кубов в количестве 65 шт.', '2016-08-30 09:20:46'),
(6, 'Майя', 9030432986, 'vvhk@yandex.ru', 'Наша компания предлагает этиленгликоль по цене 70 руб/кг с НДС(пр-во Казаньоргсинтез)', '2016-09-02 10:54:46'),
(7, 'Елена Хевел', 9876603669, 'E.Stepanova@hevelsolar.com', 'Добрый день!\r\n\r\nПрошу уточнить по цене и срока поставки:\r\nкислота оксиэтилдифосфоновой \r\nОЭДФК чистотой не менее 98% 	1 кг\r\n\r\nСпасибо!\r\n\r\nС уважением,\r\nЕлена Степанова\r\nМенеджер по закупкам\r\nООО «Хевел»/ Hevel LLC\r\n \r\nРоссия, Чувашская Республика, \r\nг. Новочебоксарск, Шоршельский проезд, владение 12\r\nТел.: + 7 8352 765000 (доб. 499)\r\nМоб.: +7 987 660 36 69\r\ne-mail: E.Stepanova@hevelsolar.com', '2016-09-13 06:42:46');

-- --------------------------------------------------------

--
-- Структура таблицы `Order`
--

CREATE TABLE IF NOT EXISTS `Order` (
  `id` int(11) NOT NULL,
  `Name` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `watsup` tinyint(1) DEFAULT NULL,
  `DateTime` datetime DEFAULT NULL,
  `Unit_id` int(11) NOT NULL,
  `TelNo` bigint(20) DEFAULT NULL,
  `email` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `Paragraph`
--

CREATE TABLE IF NOT EXISTS `Paragraph` (
  `id` int(11) NOT NULL,
  `Name` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Image` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Large` tinyint(1) DEFAULT NULL,
  `No` int(11) DEFAULT NULL,
  `AlignLeft` tinyint(1) DEFAULT NULL,
  `AlphabetOrder` tinyint(1) DEFAULT NULL,
  `TransportFlag` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `Paragraph`
--

INSERT INTO `Paragraph` (`id`, `Name`, `Image`, `Large`, `No`, `AlignLeft`, `AlphabetOrder`, `TransportFlag`) VALUES
(1, 'химическое сырье', './him_veshestva-1024x681.jpg', 1, 1, 1, 1, NULL),
(2, 'бочки, кубовые ёмкости', './tr-3wFMXe7w.jpg', 1, 4, 0, NULL, NULL),
(3, 'продукция для разметки дорог', './autodor_emal_d3H8t2a.jpg', 0, 3, 1, NULL, NULL),
(4, 'автошампунь (пена)', './autoshampoo_a04O8mp.jpg', 0, 2, 0, NULL, NULL),
(5, 'теплоноситель, антифриз, тосол', './antifreeze_8bDaKrm.jpg', 0, 6, 0, NULL, NULL),
(6, 'перевозка грузов', './04.jpg', 1, 5, 1, NULL, 1),
(7, 'собственная спецтехника', './zakaz-manipulator.jpg', 1, 8, 0, NULL, NULL),
(8, 'изделия из полипропилена', './polipropilen.jpg', 0, 7, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `TransportOrder`
--

CREATE TABLE IF NOT EXISTS `TransportOrder` (
  `id` int(11) NOT NULL,
  `Name` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TelNo` bigint(20) DEFAULT NULL,
  `From` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `To` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `watsup` tinyint(1) DEFAULT NULL,
  `email` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DateTime` datetime DEFAULT NULL,
  `Unit_id` int(11) NOT NULL,
  `Volume` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `Unit`
--

CREATE TABLE IF NOT EXISTS `Unit` (
  `id` int(11) NOT NULL,
  `Name` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Description` longtext COLLATE utf8_unicode_ci,
  `Paragraph_id` int(11) NOT NULL,
  `Eng` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `Unit`
--

INSERT INTO `Unit` (`id`, `Name`, `Description`, `Paragraph_id`, `Eng`) VALUES
(1, 'бутилцеллозольв', 'Технический бутилцеллозольв может растворять алкидные смолы, ацетаты и нитраты целлюлозы, а также, используется для очистки металлов, в качестве растворителя смол, лаков и красок, как гидравлическая жидкость и для органического синтеза. Бутилцеллозольвы являются универсальными и безопасными при производстве лакокрасочных покрытий.', 1, 'butilcellozol'),
(2, 'дипроксамин 157', 'Применяется как эмульгатор в нефтеперерабатывающей промышленности, для улучшения качественных характеристик турбинных масел и смазочных материалов.', 1, 'diproksamin-157'),
(3, 'дипроксамин 157-65', 'Применяется как эмульгатор в нефтеперерабатывающей промышленности, для улучшения качественных характеристик турбинных масел и смазочных материалов.', 1, 'diproksamin-157-65'),
(4, 'диэтаноламин чист.', 'Применяются в технике в качестве эмульгатора и поверхностно-активного вещества, а также в различных процессах газоочистки, в том числе для извлечения углекислого газа из топочных газов при производстве сухого льда, также применяется в процессе обработки древесины, при производстве иминов. Является исходным веществом в промышленном синтезе лекарственного средства таурина.', 1, 'dietanolamin-chist.'),
(5, 'диэтаноламин м.б', 'Применяются в технике в качестве эмульгатора и поверхностно-активного вещества, а также в различных процессах газоочистки, в том числе для извлечения углекислого газа из топочных газов при производстве сухого льда, также применяется в процессе обработки древесины, при производстве иминов. Является исходным веществом в промышленном синтезе лекарственного средства таурина.', 1, 'dietanolamin-m.b'),
(6, 'моноэтаноламин в/с', 'Применяются в технике в качестве эмульгаторов, и других поверхностно-активных веществ, а также в различных процессах газоочистки, в том числе для извлечения углекислого газа из топочных газов при производстве сухого льда, также применяется в процессе обработки древесины, при производстве иминов. Является исходным веществом в промышленном синтезе лекарственного средства таурина.\r\n\r\nПри производстве косметики и бытовой химии продукт применяется в качестве буферного агента (стабилизирует уровень Ph). Моноэтаноламин также применяется в кожевенной, текстильной промышленности и при производстве смазочно-охлаждающих жидкостей (СОЖ). Моноэтаноламин входит в состав клеев и чернил для печати.', 1, 'monoetanolamin-v-s'),
(7, 'триэтаноламин м.а', 'Абсорбент кислых газов, ингибитор коррозии, входит в состав мягчителей для каучука, охлаждающих жидкостей.\r\n\r\nТриэтаноламин является исходным веществом в синтезе триэтаноламинтринитрата, азотистого иприта.', 1, 'trietanolamin-m.a'),
(8, 'триэтаноламин м.б', 'Абсорбент кислых газов, ингибитор коррозии, входит в состав мягчителей для каучука, охлаждающих жидкостей.\r\n\r\nТриэтаноламин является исходным веществом в синтезе триэтаноламинтринитрата, азотистого иприта.', 1, 'trietanolamin-m.b'),
(9, 'этиленгликоль в/с', 'Применяется:\r\n -как компонент автомобильных антифризов и тормозных жидкостей;\r\n- в качестве теплоносителя в виде раствора в автомобилях, в системах жидкостного охлаждения компьютеров;\r\n- в производстве целлофана, полиуретанов и ряда других полимеров.\r\n- как растворитель красящих веществ;\r\n- в органическом синтезе;\r\n- при производстве конденсаторов;\r\n- при производстве 1,4-диоксана;\r\n- как теплоноситель в системах чиллер-фанкойл;\r\n- в качестве компонента крема для обуви (1—2 %);\r\n- в составе для мытья стёкол вместе с изопропиловым спиртом;\r\n- при криоконсрвировании биологических объектов (в крионике) в качестве криопротектора.', 1, 'etilenglikol-v-s'),
(10, 'этилцеллозольв', 'Используется в качестве растворителя многих лакокрасочных материалов на самой разнообразной химической основе. Этилцеллозольв также используют в качестве растворителя в чистящих целях (для снятия нагаров, старой краски и т.п.), в печатном деле, в качестве антифриза в авиационном топливе с целью предотвращения замерзания содержащейся в нём воды, основной компонент противоводокристаллизационных жидкостей («жидкость И» и «жидкость И-М»), в качестве азеотропной добавки для разделения различных углеводородов и спиртов.', 1, 'etilcellozolv'),
(11, 'этилацетат', 'Этилацетат широко используется как растворитель нитратов целлюлозы, ацетилцеллюлозы, жиров, восков, для чистки печатных плат, в смеси со спиртом — растворитель в производстве искусственной кожи. \r\nОдин из самых популярных ядов, применяемых в энтомологических морилках для умерщвления насекомых. Насекомые после умерщвления в его парах гораздо мягче и податливее в препарировании, чем после умерщвления в парах хлороформа.\r\nЭтилацетат часто используется для экстракции, а также для колоночной и тонкослойной хроматографии. Редко в качестве растворителя для проведения реакций из-за склонности к гидролизу и переэтерефикации.\r\nИспользуется для получения ацетоуксусного эфира.', 1, 'etilacetat1'),
(12, 'ацетон технический', 'Ацетон также является популярным растворителем, значительно превосходящим в плане безопасности уайт-спирит, скипидар и отчасти керосин. В частности он используется как растворитель:\r\n- в производстве лаков;\r\n- в производстве взрывчатых веществ;\r\n- в производстве лекарственных препаратов;\r\n- в составе клея для киноплёнок как растворитель ацетата целлюлозы и целлулоида;\r\n- компонент для очистки поверхностей в различных производственных процессах;\r\n- как очиститель инструмента и поверхностей от монтажной пены — в аэрозольных баллонах.', 1, 'aceton'),
(13, 'толуол', 'Сырьё для производства бензола, бензойной кислоты, нитротолуолов (в том числе тринитротолуола), толуилендиизоцианатов (через динитротолуол и толуилендиамин) бензилхлорида и др. органических веществ.\r\nЯвляется растворителем для многих полимеров, входит в состав различных товарных растворителей для лаков и красок. Входит в состав растворителей: Р-40, Р-4, 645, 646, 647, 648. Применяется как растворитель в химическом синтезе.', 1, 'toluol'),
(14, 'бентол', 'Бентол может использоваться в лакокрасочной, химической, нефтехимической промышленности или разгоняться на фракции.', 1, 'bentol'),
(15, 'arbreak', 'Нефтерастворимый деэмульгатор ARBREAK 8381E, ARBREAK 8144E, ARBREAK 8191E. Применяется в нефтяной промышленности.', 1, 'arbreak'),
(16, 'стеариновая кислота', 'Широко используется в косметической промышленности: стеарат натрия является одним из основных компонентов мыла, сама стеариновая кислота входит в состав многих косметических средств. Применяется в производстве свечей и как мягчитель в производстве резины. Стеараты натрия, кальция, свинца используются как компоненты пластичных смазок.', 1, 'stearinovaya-kislota'),
(17, 'олеиновая кислота Б-115', 'Олеиновая кислота и её эфиры применяют для получения лакокрасочных материалов, как пластификаторы. Применяется в мыловарении, олеиновая кислота и её соли широко применяется в качестве эмульгаторов, в частности, в составе смазочно-охлаждающих жидкостей) при обработке металлов резанием — хонингованием, протягиванием, развертыванием и пр. Также используется в качестве стабилизатора магнитных жидкостей на основе углеводородных носителей ферромагнитных частиц.\r\n\r\nВ производстве замасливающих средств (для химических волокон), флотореагентов, синтетического каучука, пеногасителей, смачивателя для крашения дисперсными красителями, пластификаторов. Входит в состав косметических средств. Входит в состав олеина.', 1, 'oleinovaya-kislota-b-115'),
(18, 'олеиновая кислота марки В', 'Олеиновая кислота и её эфиры применяют для получения лакокрасочных материалов, как пластификаторы. Применяется в мыловарении, олеиновая кислота и её соли широко применяется в качестве эмульгаторов, в частности, в составе смазочно-охлаждающих жидкостей) при обработке металлов резанием — хонингованием, протягиванием, развертыванием и пр. Также используется в качестве стабилизатора магнитных жидкостей на основе углеводородных носителей ферромагнитных частиц.\r\n\r\nВ производстве замасливающих средств (для химических волокон), флотореагентов, синтетического каучука, пеногасителей, смачивателя для крашения дисперсными красителями, пластификаторов. Входит в состав косметических средств. Входит в состав олеина.', 1, 'oleinovaya-kislota-marki-v'),
(19, 'дистилированные жирные кислоты соапстока', 'Жирные кислоты соапстока используют в качестве технического олеина в производстве смазок и смазочно-охлаждающих жидкостей, в мыловарении, в производстве реагентов для буровых установок, а также в качестве кормовых добавок для животных. Жирные кислоты соапстока служат основным сырьем при производстве биотоплива, широко используются в производстве лакокрасочных материалов, в металлургической и резино-технической промышленности.', 1, 'distilirovannye-zhirnye-kisloty-soa'),
(20, 'глицерин дистилированный марок д-98 и пк-94', 'применяется:\r\n- для получения нитроглицерина;\r\n- для изготовления незамерзающих растворов в различных двигателях, тормозной и нагревающей жидкости;\r\n- для охлаждения стволов орудий;\r\n- для регулирования влажности табака;\r\n- при получении пластмасс и смол;\r\n- для приготовления экстрактов чая, кофе, имбиря и других растительных веществ;\r\n- при производстве безалкогольных напитков;\r\n- при получении горчицы, желе и уксуса;\r\n- для получения пищевых поверхностно-активных веществ;\r\n- при обработке семян и сеянцев;\r\n- в фармакопейном производстве;\r\n- в производстве электролитических конденсаторов и в области электроплатинирования;\r\n- при выпуске кальки, пергамента, папиросной бумаги, бумажных салфеток и жиронепроницаемой бумаги;\r\n- компонент полировочных составов;\r\n- в производстве чистящих и моющих средств\r\n- в косметической промышленности', 1, 'distillirovanny-glicerin'),
(21, 'лауретсульфат натрия (сульфоэтоксилат)', 'Используется в качестве мощного детергента в промышленности, фармакологии, косметологии. Наиболее распространённое поверхностно-активное вещество, часто в составе различных смесей, таких, как Авироль и другие. Его включают в большинство очищающих рецептур, в том числе, во многие зубные пасты, шампуни, так как он дешёв и обеспечивает эффективное пенообразование и очищение.', 1, 'lauretsulfat-natriya-sulfoetoksilat'),
(22, 'каустическая сода (гидроксид натрия)', 'Каустик применяется:\r\n- в целлюлозно-бумажной промышленности в производстве бумаги, картона, искусственных волокон, древесно-волоконных плит;\r\n- для омыления жиров при производстве мыла, шампуня и других моющих средств. \r\n- в сфере промышленной мойки для очистки изделий из нержавеющей стали от жира и других масляных веществ, а также остатков механической обработки;\r\n- в химических отраслях промышленности — для нейтрализации кислот и кислотных оксидов, как реагент или катализатор в химических реакциях, в химическом анализе для титрования, для травления алюминия и в производстве чистых металлов, в нефтепереработке — для производства масел;\r\n- в изготовлении биодизельного топлива;\r\n- для устранения засоров.\r\n- в гражданской обороне для дегазации и нейтрализации отравляющих веществ, в том числе зарина, в ребризерах (изолирующих дыхательных аппаратах (ИДА), для очистки выдыхаемого воздуха от углекислого газа.\r\n- для мойки пресс-форм автопокрышек;\r\n- в приготовлении пищи: для мытья и очистки фруктов и овощей от кожицы, в производстве шоколада и какао, напитков, мороженого, окрашивания карамели, для размягчения маслин и придания им чёрной окраски, при производстве хлебобулочных изделий. Зарегистрирован в качестве пищевой добавки E-524.\r\n -в косметологии для удаления ороговевших участков кожи, бородавок, папиллом.', 1, 'kausticheskaya-soda-gidroksid-natriya'),
(23, 'оксиэтилидендифосфоновая кислота (ОЭДФ)', 'Применяется в качестве комплексообразующего реагента в энергетике и нефтедобыче, ингибитора солеотложений в водооборотных системах охлаждения промышленных предприятий и тепловых электростанций.', 1, 'oksietilidendifosfonovaya-kislota-oedf'),
(24, 'тетранатриевая соль', 'Используется в производстве бытовой химии и синтетических моющих средств, в качестве дезинфектанта и растворителя накипи, виде стабилизатора в процессах полимеризации, целлюлозно-бумажной индустрии, в текстильной промышленности, и в многих других областях.', 1, 'tetranatrievaya-sol'),
(25, 'нитрилотриуксусная кислота', 'Нитрилотриуксусная кислота применяется для смягчения воды и удаления следов щелочноземельных и тяжелых металлов; входит в состав моющих и чистящих средств и др.', 1, 'nitrilotriacetic-acid'),
(26, 'кокамидопропиламиноксид', 'Применяется как пенообразователь, стабилизатор пены, загуститель в жидких, пастообразных, моющих, средствах. Эффективный загуститель в щелочных и гипохлоритных чистящих составах.', 1, 'cocamidopropylamineoxide'),
(27, 'теплоноситель', 'Применяется в большинстве приборов/инженерных систем и др., служащих для передачи/распределения тепла: системы отопления зданий, холодильников, кондиционеров, тепловых пунктов, котельных, солнечных коллекторов, солнечных водонагревателей и др.', 1, 'teplonositel'),
(28, 'пропиленгликоль', 'Низкозамерзающие теплоносители на основе водного раствора пропиленгликоля широко используются в различных отраслях промышленности в качестве теплоносителей (антифризов), в том числе в системах отопления, вентиляции, кондиционирования жилых домов и общественных зданий, в системах охлаждения пищевых производств, а также в другом теплообменном оборудовании в интервале температур от −40 °C до +108 °C.\r\nВ пищевой промышленности пропиленгликоль зарегистрирован в качестве пищевой добавки E1520 как влагоудерживающий, смягчающий и диспергирующий агент. Используется в качестве одного из компонентов жидкостей для электронных парогенераторов.', 1, 'propilenglikol'),
(29, 'глицерин', 'применяется:\r\n- для получения нитроглицерина;\r\n- для изготовления незамерзающих растворов в различных двигателях, тормозной и нагревающей жидкости;\r\n- для охлаждения стволов орудий;\r\n- для регулирования влажности табака;\r\n- при получении пластмасс и смол;\r\n- для приготовления экстрактов чая, кофе, имбиря и других растительных веществ;\r\n- при производстве безалкогольных напитков;\r\n- при получении горчицы, желе и уксуса;\r\n- для получения пищевых поверхностно-активных веществ;\r\n- при обработке семян и сеянцев;\r\n- в фармакопейном производстве;\r\n- в производстве электролитических конденсаторов и в области электроплатинирования;\r\n- при выпуске кальки, пергамента, папиросной бумаги, бумажных салфеток и жиронепроницаемой бумаги;\r\n- компонент полировочных составов;\r\n- в производстве чистящих и моющих средств\r\n- в косметической промышленности', 1, 'glicerin'),
(30, 'вода дистиллированная', 'Применяется:\r\n- в химических лабораториях, где её используют для приготовления растворов, проведения анализов и ополаскивания химической посуды после мытья;\r\n- для корректировки плотности электролитов, безопасной эксплуатации аккумуляторов, промывки систем жидкостного охлаждения, разбавления концентратов различных жидкостей и для прочих бытовых нужд;\r\n- для корректировки температуры замерзания незамерзающей стеклоомывающей жидкости и при цветной фотопечати.', 1, 'voda-distillirovannaya'),
(31, 'алкилбензолсульфокислота (АБСК)', 'Применяется в качестве пенообразователя для пеноизола.', 1, 'alkilbenzolsulfokislota-absk'),
(32, 'автошампунь (пена) 1кг', 'Профессиональное концентрированное двухкомпонентное щелочное средство для бесконтактной мойки. Обладает мощным очистительным эффектом. Быстро, эффективно и бережно вытесняет с поверхности автомобиля все типы загрязнений. Не оставляет разводов. Облегчает последующую полировку автомобиля. Не оказывает вредного воздействия на пластик, резину, хромированные детали и лакокрасочное покрытие.', 4, NULL),
(33, 'автошампунь (пена) 5кг', 'Профессиональное концентрированное двухкомпонентное щелочное средство для бесконтактной мойки. Обладает мощным очистительным эффектом. Быстро, эффективно и бережно вытесняет с поверхности автомобиля все типы загрязнений. Не оставляет разводов. Облегчает последующую полировку автомобиля. Не оказывает вредного воздействия на пластик, резину, хромированные детали и лакокрасочное покрытие.', 4, NULL),
(34, 'автошампунь (пена) 10кг', 'Профессиональное концентрированное двухкомпонентное щелочное средство для бесконтактной мойки. Обладает мощным очистительным эффектом. Быстро, эффективно и бережно вытесняет с поверхности автомобиля все типы загрязнений. Не оставляет разводов. Облегчает последующую полировку автомобиля. Не оказывает вредного воздействия на пластик, резину, хромированные детали и лакокрасочное покрытие.', 4, NULL),
(35, 'автошампунь (пена) 20кг', 'Профессиональное концентрированное двухкомпонентное щелочное средство для бесконтактной мойки. Обладает мощным очистительным эффектом. Быстро, эффективно и бережно вытесняет с поверхности автомобиля все типы загрязнений. Не оставляет разводов. Облегчает последующую полировку автомобиля. Не оказывает вредного воздействия на пластик, резину, хромированные детали и лакокрасочное покрытие.', 4, NULL),
(36, 'автошампунь (пена) 225кг', 'Профессиональное концентрированное двухкомпонентное щелочное средство для бесконтактной мойки. Обладает мощным очистительным эффектом. Быстро, эффективно и бережно вытесняет с поверхности автомобиля все типы загрязнений. Не оставляет разводов. Облегчает последующую полировку автомобиля. Не оказывает вредного воздействия на пластик, резину, хромированные детали и лакокрасочное покрытие.', 4, NULL),
(37, 'эмаль КО-525 20-25л.', '', 3, NULL),
(38, 'эмаль КО-525 50л.', '', 3, NULL),
(39, 'эмаль КО-525 200л.', '', 3, NULL),
(40, 'бочки металические', '', 2, NULL),
(41, 'кубовые емкости', '', 2, NULL),
(42, 'контейнером', '', 6, NULL),
(43, 'ж/д вагонами', '', 6, NULL),
(44, 'cклад временного хранения', '', 6, NULL),
(45, 'разгрузочно погрузочные работы', '', 6, NULL),
(46, 'вилочный погрузчик (1500 кг)', '', 7, NULL),
(47, 'фронтальный погрузчик', '', 7, NULL),
(48, 'трактор-экскаватор', '', 7, NULL),
(49, 'манипулятор', '', 7, NULL),
(50, 'газель (1,5-2 тн)', '', 7, NULL),
(51, 'волдай (5 тн)', '', 7, NULL),
(52, 'фура (20 тн тент. )', '', 7, NULL),
(53, 'антифриз стандарт G11 (синий)', '', 5, NULL),
(54, 'антифриз премиум G11 (зеленый)', '', 5, NULL),
(55, 'антифриз красный G12', '', 5, NULL),
(56, 'антифриз спорт G12++', '', 5, NULL),
(57, 'теплоноситель для системы отопления', '', 5, NULL),
(58, 'нить полипропиленовая', 'Высокопрочные полипропиленовые нити применяются при изготовлении \r\nплетеных и скрученных канатов, шнуров, ремней, шпагатов, тканых лент, плетеных сетей, \r\nфильтрующих тканей; а также применяются для прошивки мешков, обуви, сумок, чемоданов.', 8, NULL),
(59, 'полотно полипропиленовое', 'Полипропиленовое полотно применяют в строительстве в качестве укрытия строительных площадок от атмосферных осадков, пыли и грязи. Кроме того, его применяют для укрытия различных ограждений временных сооружений, для пошива вагонных вкладышей и т. д.', 8, NULL),
(60, 'рукавная ткань', 'Применяется для пошива мешков', 8, NULL),
(61, 'мешок полипропиленовый с клапаном коробчатого типа', 'Применяется для тарирования пищевых и непищевых сыпучих материалов. \r\nФорма кирпича удобна при формировании паллеты.', 8, NULL),
(62, 'мешок полипропиленовый (коробчатое дно) с открытым верхом', 'Применяется для тарирования, перевозки и хранения пищевых и непищевых сыпучих материалов. Подходит для любого фасовочного оборудования.', 8, NULL),
(63, 'мешок полипропиленовый с прошивным дном', 'Применяется для тарирования, хранения, перевозки сыпучих пищевых и непищевых материалов', 8, NULL),
(64, 'сумка полипропиленовая с прошивным дном и прорубными ручками', 'Применяется для хранения, перевозки сыпучих пищевых и непищевых материалов', 8, NULL),
(65, 'сумка полипропиленовая с прошивным дном с ручками', 'Применяется  для хранения, перевозки сыпучих пищевых и непищевых материалов', 8, NULL);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Индексы таблицы `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissi_permission_id_84c5c92e_fk_auth_permission_id` (`permission_id`);

--
-- Индексы таблицы `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Индексы таблицы `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Индексы таблицы `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Индексы таблицы `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_perm_permission_id_1fbb5f2c_fk_auth_permission_id` (`permission_id`);

--
-- Индексы таблицы `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin__content_type_id_c4bce8eb_fk_django_content_type_id` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Индексы таблицы `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Индексы таблицы `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_de54fa62` (`expire_date`);

--
-- Индексы таблицы `GetInTouch`
--
ALTER TABLE `GetInTouch`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `Order`
--
ALTER TABLE `Order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Order_Unit_id_d7dbd70a_fk_Unit_id` (`Unit_id`);

--
-- Индексы таблицы `Paragraph`
--
ALTER TABLE `Paragraph`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `TransportOrder`
--
ALTER TABLE `TransportOrder`
  ADD PRIMARY KEY (`id`),
  ADD KEY `TransportOrder_Unit_id_59911665_fk_Unit_id` (`Unit_id`);

--
-- Индексы таблицы `Unit`
--
ALTER TABLE `Unit`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Unit_Paragraph_id_07098157_fk_Paragraph_id` (`Paragraph_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=34;
--
-- AUTO_INCREMENT для таблицы `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблицы `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=165;
--
-- AUTO_INCREMENT для таблицы `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT для таблицы `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=27;
--
-- AUTO_INCREMENT для таблицы `GetInTouch`
--
ALTER TABLE `GetInTouch`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT для таблицы `Order`
--
ALTER TABLE `Order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `Paragraph`
--
ALTER TABLE `Paragraph`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT для таблицы `TransportOrder`
--
ALTER TABLE `TransportOrder`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `Unit`
--
ALTER TABLE `Unit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=66;
--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissi_permission_id_84c5c92e_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Ограничения внешнего ключа таблицы `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permissi_content_type_id_2f476e4b_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Ограничения внешнего ключа таблицы `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_perm_permission_id_1fbb5f2c_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin__content_type_id_c4bce8eb_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения внешнего ключа таблицы `Order`
--
ALTER TABLE `Order`
  ADD CONSTRAINT `Order_Unit_id_d7dbd70a_fk_Unit_id` FOREIGN KEY (`Unit_id`) REFERENCES `Unit` (`id`);

--
-- Ограничения внешнего ключа таблицы `TransportOrder`
--
ALTER TABLE `TransportOrder`
  ADD CONSTRAINT `TransportOrder_Unit_id_59911665_fk_Unit_id` FOREIGN KEY (`Unit_id`) REFERENCES `Unit` (`id`);

--
-- Ограничения внешнего ключа таблицы `Unit`
--
ALTER TABLE `Unit`
  ADD CONSTRAINT `Unit_Paragraph_id_07098157_fk_Paragraph_id` FOREIGN KEY (`Paragraph_id`) REFERENCES `Paragraph` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
