-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 26-12-2020 a las 12:55:47
-- Versión del servidor: 10.4.14-MariaDB
-- Versión de PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `surveyflash`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `spDelAccessCode` (IN `pAccessCodeId` INT)  NO SQL
BEGIN

UPDATE accesscode
SET active = 0
WHERE accessCodeId = pAccessCodeId;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spDelAlternative` (IN `pAlternativeId` INT)  NO SQL
BEGIN

	UPDATE alternative
    SET active = 0
    WHERE alternativeId = pAlternativeId;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spDelQuestion` (`pQuestionId` INT)  BEGIN
	
	UPDATE question
	SET active = 0
	WHERE questionId = pQuestionId;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetAccessCode` (IN `pSurveyId` INT)  NO SQL
BEGIN

SELECT
accessCodeId,
code,
firstName,
lastName,
email,
cellPhone
FROM accesscode
WHERE surveyId = pSurveyId AND active = 1;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetAlternatives` (IN `pQuestionId` INT)  NO SQL
BEGIN
	
SELECT
questionId,
alternativeId,
description
FROM alternative t1
WHERE questionId = pQuestionId AND t1.active = 1
ORDER BY timestampCreated DESC;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetAlternativesByQuestion` (IN `pQuestionId` INT)  NO SQL
BEGIN

SELECT
alternativeId,
description
FROM alternative
WHERE questionId = pQuestionId AND active = 1;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetCompanies` ()  BEGIN
	
	SELECT
	companyId,
	description,
	logo
	FROM company
	LIMIT 4;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetCurrentQuestion` (IN `pSurveyId` INT, IN `pCurrent` INT)  NO SQL
BEGIN

SELECT
t1.questionId,
t1.question,
t2.description type
FROM question t1
INNER JOIN typequestion t2 ON t2.typeQuestionId = t1.typeQuestionId
WHERE t1.surveyId = pSurveyId AND t1.active = 1
ORDER BY t1.timestampCreated
LIMIT pCurrent, 1;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetLogin` (IN `pEmail` VARCHAR(30), IN `pPassword` VARCHAR(30))  BEGIN
	
	SELECT
	t1.userId,
	t1.firstName,
	t1.lastName,
	t1.email,
	t1.companyId,
	t2.description,
	t2.logo
	FROM user t1
	INNER JOIN company t2 ON t2.companyId = t1.companyId AND t2.active = 1
	WHERE t1.email = pEmail AND t1.`password` = md5(pPassword) AND t1.active = 1;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetOverviewAnswer` (IN `pSurveyId` INT)  NO SQL
BEGIN

SELECT
t1.questionId,
t1.question,
COUNT(t2.answerId) countReplies
FROM question t1
 LEFT JOIN (
 	SELECT
    answerId,
    questionId
    FROM answerdetail
    GROUP BY questionId, answerId
 ) t2 ON t2.questionId = t1.questionId
WHERE t1.surveyId = pSurveyId AND t1.active = 1
GROUP BY t1.questionId;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetOverviewAnswerForQuestion` (IN `pQuestionId` INT)  NO SQL
BEGIN

SELECT
*
FROM answerdetail t1
WHERE t1.questionId = pQuestionId;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetQuestions` (`pSurveyId` INT)  BEGIN
	
SELECT
t1.questionId,
t1.question,
t1.typeQuestionId,
t2.description typeQuestion,
DATE_FORMAT(t1.timestampCreated, '%d-%b-%Y %r') timestampCreated
FROM question t1
INNER JOIN typequestion t2 ON t2.typeQuestionId = t1.typeQuestionId
WHERE t1.surveyId = pSurveyId AND t1.active = 1
ORDER BY timestampCreated DESC;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetSurvey` (IN `pSurveyId` INT)  NO SQL
BEGIN

SELECT
t1.surveyId,
t2.logo,
t1.description,
COUNT(t3.questionId) countQuestion,
t1.discount,
DATE_FORMAT(t1.timestampExpiration, "%d/%m/%Y") timestampExpiration,
t1.bannerDiscount
FROM survey t1
INNER JOIN company t2 ON t2.companyId = t1.companyId
LEFT JOIN question t3 ON t3.surveyId = t1.surveyId AND t3.active = 1
WHERE t1.surveyId = pSurveyId AND t1.active = 1
GROUP BY t1.surveyId;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetSurveys` (IN `pIdCompany` INT)  BEGIN
	SET lc_time_names = 'es_ES';

	SELECT
	surveyId,
	description,
	discount,
	bannerDiscount,
	IF(active = true, "Si", "No") active,
	DATE_FORMAT(timestampExpiration, '%Y-%m-%d') timestampExpiration,
	DATE_FORMAT(timestampCreated, '%d-%b-%Y %r') timestampCreated
	FROM survey
	ORDER BY timestampCreated DESC;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetTypeQuestions` ()  BEGIN
	
	SELECT
	typeQuestionId,
	description
	FROM typequestion
	WHERE active = 1;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spInsAccessCode` (IN `pSurveyId` INT, IN `pCode` VARCHAR(100), IN `pFirstName` VARCHAR(100), IN `pLastName` VARCHAR(100), IN `pEmail` VARCHAR(100), IN `pCellPhone` VARCHAR(20))  NO SQL
BEGIN

INSERT INTO accesscode (
surveyId,
code,
firstName,
lastName,
email,
cellPhone,
active
) VALUES (
pSurveyId,
pCode,
pFirstName,
pLastName,
pEmail,
pCellPhone,
1
);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spInsAlternative` (IN `pQuestionId` INT, IN `pDescription` VARCHAR(100))  NO SQL
BEGIN
	
	INSERT INTO alternative (
	questionId,
    description,
    active
	) VALUES (
	pQuestionId,
	pDescription,
	1
	);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spInsQuestion` (`pSurveyId` INT, `pTypeQuestionId` INT, `pQuestion` VARCHAR(255))  BEGIN
	
	INSERT INTO question (
	surveyId,
	typeQuestionId,
	question,
	active
	) VALUES (
	pSurveyId,
	pTypeQuestionId,
	pQuestion,
	1
	);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spInsSurvey` (`pCompanyId` INT, `pUserId` INT, `pDescription` VARCHAR(30), `pDiscount` VARCHAR(30), `pBannerDiscount` VARCHAR(50), `pTimestampExpiration` VARCHAR(20))  BEGIN
	INSERT INTO survey (
	companyId,
	userId,
	description,
	discount,
	bannerDiscount,
	timestampExpiration,
	active
	) VALUES (
	pCompanyId,
	pUserId,
	pDescription,
	pDiscount,
	pBannerDiscount,
	pTimestampExpiration,
	0
	);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spSetActiveSurvey` (`pSurveyId` INT, `pCompanyId` INT, `pActive` TINYINT)  BEGIN
	
	IF pActive = 1 THEN
	
		UPDATE survey
		SET active = 0
		WHERE companyId = pCompanyId;
		
	END IF;

	UPDATE survey
	SET active = pActive
	WHERE surveyId = pSurveyId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spSetAnswer` (IN `pAccessCodeId` INT, IN `pSurveyId` INT)  NO SQL
BEGIN

DECLARE vAnswerId INT;

SELECT
answerId
INTO
vAnswerId
FROM answer
WHERE accessCodeId = pAccessCodeId AND surveyId = pSurveyId;

IF vAnswerId IS NULL THEN
    INSERT IGNORE INTO answer (
    accessCodeId,
    surveyId
    ) VALUES (
    pAccessCodeId,
    pSurveyId
    );

    SET vAnswerId = LAST_INSERT_ID();
END IF;

SELECT vAnswerId answerId;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spSetAnswerDetail` (IN `pAnswerId` INT, IN `pQuestionId` INT, IN `pAlternativeId` INT, IN `pAnswer` TEXT, IN `pScore` INT)  NO SQL
BEGIN

DELETE FROM answerdetail
WHERE answerId = pAnswerId AND
questionId = pQuestionId AND
alternativeId <=> IF(pAlternativeId = 0, null, pAlternativeId);

INSERT INTO answerdetail (
answerId,
questionId,
alternativeId,
answer,
score
) VALUES (
pAnswerId,
pQuestionId,
IF(pAlternativeId = 0, null, pAlternativeId),
IF(pAnswer = "", null, pAnswer),
pScore
) ON DUPLICATE KEY UPDATE
alternativeId = VALUES(alternativeId),
answer = VALUES(answer),
score = VALUES(score);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spUpdQuestion` (`pQuestionId` INT, `pTypeQuestionId` INT, `pQuestion` VARCHAR(255))  BEGIN
	
	UPDATE question
	SET 
	question = pQuestion,
	typeQuestionId = pTypeQuestionId
	WHERE questionId = pQuestionId;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spUpdSurvey` (`pSurveyId` INT, `pDescription` VARCHAR(30), `pDiscount` VARCHAR(30), `pBannerDiscount` VARCHAR(50), `pTimestampExpiration` VARCHAR(20))  BEGIN
	
	UPDATE survey
	SET
	description = pDescription,
	discount = pDiscount,
	bannerDiscount = pBannerDiscount,
	timestampExpiration = pTimestampExpiration
	WHERE surveyId = pSurveyId;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spVerififyAccessCode` (IN `pCode` VARCHAR(100))  NO SQL
BEGIN

SELECT
t1.accessCodeId,
t1.surveyId,
t1.firstName,
t1.lastName
FROM accesscode t1
INNER JOIN survey t2 ON t2.surveyId = t1.surveyId AND t2.active = 1
WHERE t1.code = pCode AND t1.active = 1;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `accesscode`
--

CREATE TABLE `accesscode` (
  `accessCodeId` int(11) NOT NULL,
  `surveyId` int(11) NOT NULL,
  `code` varchar(20) DEFAULT NULL,
  `firstName` varchar(50) DEFAULT NULL,
  `lastName` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `cellPhone` varchar(10) DEFAULT NULL,
  `active` tinyint(4) DEFAULT NULL,
  `timestampCreated` timestamp NULL DEFAULT NULL,
  `timestampModified` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `accesscode`
--

INSERT INTO `accesscode` (`accessCodeId`, `surveyId`, `code`, `firstName`, `lastName`, `email`, `cellPhone`, `active`, `timestampCreated`, `timestampModified`) VALUES
(1, 1, '46742688', 'Julio Cesar', 'Wong Rodriguez', 'julioo.wong@gmail.com', '954127922', 1, NULL, NULL),
(4, 1, '46941595', 'Yessenia', 'Gamonal', 'yesseniagamonal@gmail.com', '', 1, NULL, NULL),
(5, 1, '46941595', 'Yessenia', 'Gamonal', 'dsdsa', '', 0, NULL, NULL),
(6, 1, '8787', 'sds', 'kl', 'jhdjsa@wqkeq.q', '8989898', 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alternative`
--

CREATE TABLE `alternative` (
  `alternativeId` int(11) NOT NULL,
  `questionId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `active` tinyint(4) DEFAULT NULL,
  `timestampCreated` timestamp NULL DEFAULT NULL,
  `timestampModified` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `alternative`
--

INSERT INTO `alternative` (`alternativeId`, `questionId`, `userId`, `description`, `active`, `timestampCreated`, `timestampModified`) VALUES
(1, 15, NULL, 'alternativa1', 1, NULL, NULL),
(2, 15, NULL, 'Alternativa 2', 1, NULL, NULL),
(3, 15, NULL, 'hola', 0, NULL, NULL),
(4, 15, NULL, 'dsa', 0, NULL, NULL),
(5, 15, NULL, 'oooo', 0, NULL, NULL),
(6, 15, NULL, 'qwerty', 0, NULL, NULL),
(7, 1, NULL, 'qwerty2', 1, NULL, NULL),
(8, 1, NULL, 'qwert3', 0, NULL, NULL),
(9, 1, NULL, 'qwert4', 0, NULL, NULL),
(10, 1, NULL, 'oil', 0, NULL, NULL),
(11, 15, NULL, 'jeje', 0, NULL, NULL),
(12, 1, NULL, 'xD', 0, NULL, NULL),
(13, 1, NULL, 'hola', 0, NULL, NULL),
(14, 1, NULL, 'test', 0, NULL, NULL),
(15, 1, NULL, 'test', 0, NULL, NULL),
(16, 1, NULL, 'HOLA', 0, NULL, NULL),
(17, 1, NULL, 'JO', 0, NULL, NULL),
(18, 1, NULL, 'hhhh', 0, NULL, NULL),
(19, 1, NULL, 'holii', 0, NULL, NULL),
(20, 1, NULL, 'holii', 0, NULL, NULL),
(21, 1, NULL, 'dskdsa', 0, NULL, NULL),
(22, 1, NULL, 'daskdas', 0, NULL, NULL),
(23, 1, NULL, 'daskdas', 0, NULL, NULL),
(24, 1, NULL, 'daskdasa', 0, NULL, NULL),
(25, 1, NULL, 'ooo', 1, NULL, NULL),
(26, 15, NULL, 'alternativa3', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `answer`
--

CREATE TABLE `answer` (
  `answerId` int(11) NOT NULL,
  `accessCodeId` int(11) NOT NULL,
  `surveyId` int(11) DEFAULT NULL,
  `complete` tinyint(4) DEFAULT NULL,
  `timestampCreated` timestamp NULL DEFAULT NULL,
  `timestampModified` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `answer`
--

INSERT INTO `answer` (`answerId`, `accessCodeId`, `surveyId`, `complete`, `timestampCreated`, `timestampModified`) VALUES
(16, 1, 1, NULL, NULL, NULL),
(17, 4, 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `answerdetail`
--

CREATE TABLE `answerdetail` (
  `answerId` int(11) NOT NULL,
  `questionId` int(11) NOT NULL,
  `alternativeId` int(11) DEFAULT NULL,
  `answer` text DEFAULT NULL,
  `score` tinyint(4) DEFAULT NULL,
  `timestampCreated` timestamp NULL DEFAULT NULL,
  `timestampModified` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `answerdetail`
--

INSERT INTO `answerdetail` (`answerId`, `questionId`, `alternativeId`, `answer`, `score`, `timestampCreated`, `timestampModified`) VALUES
(16, 1, NULL, NULL, 2, NULL, NULL),
(16, 15, 1, NULL, 0, NULL, NULL),
(16, 15, 2, NULL, 0, NULL, NULL),
(16, 17, NULL, NULL, 4, NULL, NULL),
(16, 18, NULL, 'adsa', 0, NULL, NULL),
(17, 1, NULL, NULL, 2, NULL, NULL),
(17, 15, 2, NULL, 0, NULL, NULL),
(17, 17, NULL, NULL, 3, NULL, NULL),
(17, 18, NULL, 'jeje', 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `company`
--

CREATE TABLE `company` (
  `companyId` int(11) NOT NULL,
  `description` varchar(50) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `active` tinyint(4) DEFAULT NULL,
  `timestampCreated` timestamp NULL DEFAULT current_timestamp(),
  `timestampModified` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `company`
--

INSERT INTO `company` (`companyId`, `description`, `logo`, `active`, `timestampCreated`, `timestampModified`) VALUES
(1, 'TOPITOP', 'http://localhost:8080/surveyFlash2.0/assets/images/company1.jpg', 1, '2020-11-29 01:01:51', '2020-12-22 06:16:33'),
(2, 'BATA', 'http://localhost:8080/surveyFlash2.0/assets/images/company3.jpg', 1, '2020-11-29 02:25:18', '2020-12-22 06:16:41'),
(3, 'ADIDAS', 'http://localhost:8080/surveyFlash2.0/assets/images/company4.jpg', 1, '2020-11-29 02:25:18', '2020-12-22 06:16:50'),
(4, 'MC DONALD\'s', 'http://localhost:8080/surveyFlash2.0/assets/images/company5.jpg', 1, '2020-11-29 02:25:18', '2020-12-22 06:16:57');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `question`
--

CREATE TABLE `question` (
  `questionId` int(11) NOT NULL,
  `surveyId` int(11) DEFAULT NULL,
  `typeQuestionId` int(11) DEFAULT NULL,
  `question` varchar(255) DEFAULT NULL,
  `active` tinyint(4) DEFAULT NULL,
  `timestampCreated` timestamp NULL DEFAULT current_timestamp(),
  `timestampModified` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `question`
--

INSERT INTO `question` (`questionId`, `surveyId`, `typeQuestionId`, `question`, `active`, `timestampCreated`, `timestampModified`) VALUES
(1, 1, 1, '¿Que tan satisfecho te encuentras con la atención brindada?', 1, '2020-11-30 00:24:56', '2020-12-26 07:36:14'),
(11, 1, 2, '¿Qué tan satisfecho te encuentras con el servicio de delivey?', 0, '2020-11-30 18:25:00', '2020-11-30 18:27:28'),
(12, 1, 1, 'test2', 0, '2020-12-25 21:59:18', '2020-12-25 22:23:50'),
(13, 1, 2, 'test5', 0, '2020-12-25 22:01:00', '2020-12-25 22:23:52'),
(14, 1, 2, 'test6', 0, '2020-12-25 22:05:43', '2020-12-25 22:23:54'),
(15, 1, 2, 'eerew', 1, '2020-12-25 22:05:53', '2020-12-25 22:24:01'),
(16, 1, 2, 'aaaaaaaaaaa', 0, '2020-12-25 22:06:09', '2020-12-25 22:23:47'),
(17, 1, 1, 'test', 1, '2020-12-25 23:52:51', '2020-12-25 23:52:51'),
(18, 1, 3, 'Holitas', 1, '2020-12-26 09:51:23', '2020-12-26 09:51:23');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `survey`
--

CREATE TABLE `survey` (
  `surveyId` int(11) NOT NULL,
  `companyId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `discount` varchar(30) DEFAULT NULL,
  `bannerDiscount` varchar(255) DEFAULT NULL,
  `timestampExpiration` timestamp NULL DEFAULT NULL,
  `active` tinyint(4) DEFAULT NULL,
  `timestampCreated` timestamp NULL DEFAULT current_timestamp(),
  `timestampModified` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `survey`
--

INSERT INTO `survey` (`surveyId`, `companyId`, `userId`, `description`, `discount`, `bannerDiscount`, `timestampExpiration`, `active`, `timestampCreated`, `timestampModified`) VALUES
(1, 1, 1, 'Encuesta de satisfacción', '15%', NULL, '2020-12-24 05:03:33', 1, '2020-11-29 04:54:55', '2020-12-26 10:59:02'),
(10, 1, 1, 'Encuesta de navidad 2', '21%', '', '2020-12-25 05:00:00', 0, '2020-11-30 18:22:36', '2020-12-26 10:59:02'),
(11, 1, 1, 'test', '19', '', '2020-12-29 05:00:00', 0, '2020-12-24 23:45:43', '2020-12-24 23:45:43'),
(12, 1, 1, 'test2', '19', '', '2020-12-18 05:00:00', 0, '2020-12-24 23:46:44', '2020-12-24 23:46:44'),
(13, 1, 1, 'test2', '12', '', '2020-12-17 05:00:00', 0, '2020-12-24 23:55:54', '2020-12-24 23:55:54'),
(14, 1, 1, 'julioo', '12', '', '2020-12-17 05:00:00', 0, '2020-12-24 23:56:07', '2020-12-24 23:56:07'),
(15, 1, 1, 'assa', '21', '', '2021-01-02 05:00:00', 0, '2020-12-25 00:09:44', '2020-12-25 00:09:44'),
(16, 1, 1, 'blabla', '12', '', '2020-12-02 05:00:00', 0, '2020-12-25 00:13:36', '2020-12-25 00:13:36'),
(17, 1, 1, 'lsdlas', '213', '', '2020-12-19 05:00:00', 0, '2020-12-25 00:17:18', '2020-12-25 00:17:18'),
(18, 1, 1, 'ooooo', '10', '', '2020-12-23 05:00:00', 0, '2020-12-25 00:19:39', '2020-12-25 00:19:39'),
(19, 1, 1, 'holaaa1..', '12', '', '2020-12-19 05:00:00', 0, '2020-12-25 02:38:14', '2020-12-25 03:35:14'),
(20, 1, 1, 'holaaa2', '2', '', '1991-02-01 05:00:00', 0, '2020-12-25 17:08:28', '2020-12-25 17:08:28'),
(21, 1, 1, 'holaaa3', '9', '', '2020-12-19 05:00:00', 0, '2020-12-25 17:08:44', '2020-12-25 17:09:16'),
(22, 1, 1, '', '', '', '0000-00-00 00:00:00', 0, '2020-12-25 18:26:30', '2020-12-25 18:26:30'),
(23, 1, 1, 'navidad2', '10', '', '2020-12-18 05:00:00', 0, '2020-12-25 22:09:48', '2020-12-25 22:10:04');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `typequestion`
--

CREATE TABLE `typequestion` (
  `typeQuestionId` int(11) NOT NULL,
  `description` varchar(50) DEFAULT NULL,
  `active` tinyint(4) DEFAULT NULL,
  `timestampCreated` timestamp NULL DEFAULT current_timestamp(),
  `timestampModified` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `typequestion`
--

INSERT INTO `typequestion` (`typeQuestionId`, `description`, `active`, `timestampCreated`, `timestampModified`) VALUES
(1, 'score', 1, '2020-11-30 00:24:07', '2020-11-30 00:24:07'),
(2, 'checkbox', 1, '2020-11-30 00:24:15', '2020-11-30 00:24:23'),
(3, 'text', 1, '2020-11-30 00:24:21', '2020-11-30 00:24:24');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--

CREATE TABLE `user` (
  `userId` int(11) NOT NULL,
  `companyId` int(11) DEFAULT NULL,
  `firstName` varchar(20) DEFAULT NULL,
  `lastName` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `active` tinyint(4) DEFAULT NULL,
  `timestampCreated` timestamp NULL DEFAULT current_timestamp(),
  `timestampModified` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `user`
--

INSERT INTO `user` (`userId`, `companyId`, `firstName`, `lastName`, `email`, `password`, `active`, `timestampCreated`, `timestampModified`) VALUES
(1, 1, 'Julio Cesar', 'Wong Rodriguez', 'julioo.wong@gmail.com', '6545700ab0c5f892423b7a3b78bc3612', 1, '2020-11-29 01:03:40', '2020-11-29 02:39:59');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `accesscode`
--
ALTER TABLE `accesscode`
  ADD PRIMARY KEY (`accessCodeId`),
  ADD KEY `surveyId` (`surveyId`);

--
-- Indices de la tabla `alternative`
--
ALTER TABLE `alternative`
  ADD PRIMARY KEY (`alternativeId`) USING BTREE,
  ADD KEY `questionId` (`questionId`);

--
-- Indices de la tabla `answer`
--
ALTER TABLE `answer`
  ADD PRIMARY KEY (`answerId`),
  ADD UNIQUE KEY `accessCodeId` (`accessCodeId`,`surveyId`),
  ADD KEY `surveyId` (`surveyId`);

--
-- Indices de la tabla `answerdetail`
--
ALTER TABLE `answerdetail`
  ADD UNIQUE KEY `answerId_2` (`answerId`,`questionId`,`alternativeId`),
  ADD KEY `questionId` (`questionId`),
  ADD KEY `alternativeId` (`alternativeId`),
  ADD KEY `answerId` (`answerId`,`questionId`);

--
-- Indices de la tabla `company`
--
ALTER TABLE `company`
  ADD PRIMARY KEY (`companyId`);

--
-- Indices de la tabla `question`
--
ALTER TABLE `question`
  ADD PRIMARY KEY (`questionId`),
  ADD KEY `surveyId` (`surveyId`),
  ADD KEY `typeQuestionId` (`typeQuestionId`);

--
-- Indices de la tabla `survey`
--
ALTER TABLE `survey`
  ADD PRIMARY KEY (`surveyId`),
  ADD KEY `companyId` (`companyId`),
  ADD KEY `userId` (`userId`);

--
-- Indices de la tabla `typequestion`
--
ALTER TABLE `typequestion`
  ADD PRIMARY KEY (`typeQuestionId`);

--
-- Indices de la tabla `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`userId`),
  ADD KEY `companyId` (`companyId`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `accesscode`
--
ALTER TABLE `accesscode`
  MODIFY `accessCodeId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `alternative`
--
ALTER TABLE `alternative`
  MODIFY `alternativeId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT de la tabla `answer`
--
ALTER TABLE `answer`
  MODIFY `answerId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `company`
--
ALTER TABLE `company`
  MODIFY `companyId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `question`
--
ALTER TABLE `question`
  MODIFY `questionId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `survey`
--
ALTER TABLE `survey`
  MODIFY `surveyId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `typequestion`
--
ALTER TABLE `typequestion`
  MODIFY `typeQuestionId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `user`
--
ALTER TABLE `user`
  MODIFY `userId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `accesscode`
--
ALTER TABLE `accesscode`
  ADD CONSTRAINT `accesscode_ibfk_1` FOREIGN KEY (`surveyId`) REFERENCES `survey` (`surveyId`);

--
-- Filtros para la tabla `alternative`
--
ALTER TABLE `alternative`
  ADD CONSTRAINT `alternative_ibfk_1` FOREIGN KEY (`questionId`) REFERENCES `question` (`questionId`);

--
-- Filtros para la tabla `answer`
--
ALTER TABLE `answer`
  ADD CONSTRAINT `answer_ibfk_1` FOREIGN KEY (`accessCodeId`) REFERENCES `accesscode` (`accessCodeId`),
  ADD CONSTRAINT `answer_ibfk_2` FOREIGN KEY (`surveyId`) REFERENCES `survey` (`surveyId`);

--
-- Filtros para la tabla `answerdetail`
--
ALTER TABLE `answerdetail`
  ADD CONSTRAINT `answerdetail_ibfk_1` FOREIGN KEY (`answerId`) REFERENCES `answer` (`answerId`),
  ADD CONSTRAINT `answerdetail_ibfk_2` FOREIGN KEY (`questionId`) REFERENCES `question` (`questionId`),
  ADD CONSTRAINT `answerdetail_ibfk_3` FOREIGN KEY (`alternativeId`) REFERENCES `alternative` (`alternativeId`);

--
-- Filtros para la tabla `question`
--
ALTER TABLE `question`
  ADD CONSTRAINT `question_ibfk_1` FOREIGN KEY (`surveyId`) REFERENCES `survey` (`surveyId`),
  ADD CONSTRAINT `question_ibfk_2` FOREIGN KEY (`typeQuestionId`) REFERENCES `typequestion` (`typeQuestionId`);

--
-- Filtros para la tabla `survey`
--
ALTER TABLE `survey`
  ADD CONSTRAINT `survey_ibfk_1` FOREIGN KEY (`companyId`) REFERENCES `company` (`companyId`),
  ADD CONSTRAINT `survey_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`);

--
-- Filtros para la tabla `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`companyId`) REFERENCES `company` (`companyId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
