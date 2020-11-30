/*
 Navicat Premium Data Transfer

 Source Server         : Local
 Source Server Type    : MySQL
 Source Server Version : 100414
 Source Host           : localhost:3306
 Source Schema         : surveyflash

 Target Server Type    : MySQL
 Target Server Version : 100414
 File Encoding         : 65001

 Date: 30/11/2020 14:13:48
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for accesscode
-- ----------------------------
DROP TABLE IF EXISTS `accesscode`;
CREATE TABLE `accesscode`  (
  `accessCodeId` int(11) NOT NULL AUTO_INCREMENT,
  `surveyId` int(11) NOT NULL,
  `code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `firstName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `lastName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cellPhone` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `active` tinyint(4) NULL DEFAULT NULL,
  `timestampCreated` timestamp(0) NULL DEFAULT NULL,
  `timestampModified` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`accessCodeId`) USING BTREE,
  INDEX `surveyId`(`surveyId`) USING BTREE,
  CONSTRAINT `accesscode_ibfk_1` FOREIGN KEY (`surveyId`) REFERENCES `survey` (`surveyId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for alternative
-- ----------------------------
DROP TABLE IF EXISTS `alternative`;
CREATE TABLE `alternative`  (
  `alternativeId` int(11) NOT NULL AUTO_INCREMENT,
  `questionId` int(11) NULL DEFAULT NULL,
  `userId` int(11) NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `active` tinyint(4) NULL DEFAULT NULL,
  `timestampCreated` timestamp(0) NULL DEFAULT NULL,
  `timestampModified` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`alternativeId`) USING BTREE,
  INDEX `questionId`(`questionId`) USING BTREE,
  CONSTRAINT `alternative_ibfk_1` FOREIGN KEY (`questionId`) REFERENCES `question` (`questionId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for answer
-- ----------------------------
DROP TABLE IF EXISTS `answer`;
CREATE TABLE `answer`  (
  `answerId` int(11) NOT NULL AUTO_INCREMENT,
  `accessCodeId` int(11) NOT NULL,
  `surveyId` int(11) NULL DEFAULT NULL,
  `complete` tinyint(4) NULL DEFAULT NULL,
  `timestampCreated` timestamp(0) NULL DEFAULT NULL,
  `timestampModified` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`answerId`) USING BTREE,
  INDEX `accessCodeId`(`accessCodeId`) USING BTREE,
  INDEX `surveyId`(`surveyId`) USING BTREE,
  CONSTRAINT `answer_ibfk_1` FOREIGN KEY (`accessCodeId`) REFERENCES `accesscode` (`accessCodeId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `answer_ibfk_2` FOREIGN KEY (`surveyId`) REFERENCES `survey` (`surveyId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for answerdetail
-- ----------------------------
DROP TABLE IF EXISTS `answerdetail`;
CREATE TABLE `answerdetail`  (
  `answerId` int(11) NOT NULL,
  `questionId` int(11) NOT NULL,
  `alternativeId` int(11) NULL DEFAULT NULL,
  `answer` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `score` tinyint(4) NULL DEFAULT NULL,
  `timestampCreated` timestamp(0) NULL DEFAULT NULL,
  `timestampModified` timestamp(0) NULL DEFAULT NULL,
  INDEX `answerId`(`answerId`) USING BTREE,
  INDEX `questionId`(`questionId`) USING BTREE,
  INDEX `alternativeId`(`alternativeId`) USING BTREE,
  CONSTRAINT `answerdetail_ibfk_1` FOREIGN KEY (`answerId`) REFERENCES `answer` (`answerId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `answerdetail_ibfk_2` FOREIGN KEY (`questionId`) REFERENCES `question` (`questionId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `answerdetail_ibfk_3` FOREIGN KEY (`alternativeId`) REFERENCES `alternative` (`alternativeId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for company
-- ----------------------------
DROP TABLE IF EXISTS `company`;
CREATE TABLE `company`  (
  `companyId` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `logo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `active` tinyint(4) NULL DEFAULT NULL,
  `timestampCreated` timestamp(0) NULL DEFAULT current_timestamp(0),
  `timestampModified` timestamp(0) NULL DEFAULT current_timestamp(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`companyId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of company
-- ----------------------------
INSERT INTO `company` VALUES (1, 'TOPITOP', 'http://localhost:8080/surveyFlash/assets/images/company1.jpg', 1, '2020-11-28 20:01:51', '2020-11-28 20:02:15');
INSERT INTO `company` VALUES (2, 'BATA', 'http://localhost:8080/surveyFlash/assets/images/company3.jpg', 1, '2020-11-28 21:25:18', '2020-11-28 21:25:44');
INSERT INTO `company` VALUES (3, 'ADIDAS', 'http://localhost:8080/surveyFlash/assets/images/company4.jpg', 1, '2020-11-28 21:25:18', '2020-11-28 21:25:44');
INSERT INTO `company` VALUES (4, 'MC DONALD\'s', 'http://localhost:8080/surveyFlash/assets/images/company5.jpg', 1, '2020-11-28 21:25:18', '2020-11-28 21:25:44');

-- ----------------------------
-- Table structure for question
-- ----------------------------
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question`  (
  `questionId` int(11) NOT NULL AUTO_INCREMENT,
  `surveyId` int(11) NULL DEFAULT NULL,
  `typeQuestionId` int(11) NULL DEFAULT NULL,
  `question` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `active` tinyint(4) NULL DEFAULT NULL,
  `timestampCreated` timestamp(0) NULL DEFAULT current_timestamp(0),
  `timestampModified` timestamp(0) NULL DEFAULT current_timestamp(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`questionId`) USING BTREE,
  INDEX `surveyId`(`surveyId`) USING BTREE,
  INDEX `typeQuestionId`(`typeQuestionId`) USING BTREE,
  CONSTRAINT `question_ibfk_1` FOREIGN KEY (`surveyId`) REFERENCES `survey` (`surveyId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `question_ibfk_2` FOREIGN KEY (`typeQuestionId`) REFERENCES `typequestion` (`typeQuestionId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of question
-- ----------------------------
INSERT INTO `question` VALUES (1, 1, 1, '¿Que tan satisfecho te encuentras con la atención brindada?', 1, '2020-11-29 19:24:56', '2020-11-29 19:25:30');
INSERT INTO `question` VALUES (11, 1, 2, '¿Qué tan satisfecho te encuentras con el servicio de delivey?', 0, '2020-11-30 13:25:00', '2020-11-30 13:27:28');

-- ----------------------------
-- Table structure for survey
-- ----------------------------
DROP TABLE IF EXISTS `survey`;
CREATE TABLE `survey`  (
  `surveyId` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) NULL DEFAULT NULL,
  `userId` int(11) NULL DEFAULT NULL,
  `description` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `discount` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `bannerDiscount` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `timestampExpiration` timestamp(0) NULL DEFAULT NULL,
  `active` tinyint(4) NULL DEFAULT NULL,
  `timestampCreated` timestamp(0) NULL DEFAULT current_timestamp(0),
  `timestampModified` timestamp(0) NULL DEFAULT current_timestamp(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`surveyId`) USING BTREE,
  INDEX `companyId`(`companyId`) USING BTREE,
  INDEX `userId`(`userId`) USING BTREE,
  CONSTRAINT `survey_ibfk_1` FOREIGN KEY (`companyId`) REFERENCES `company` (`companyId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `survey_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of survey
-- ----------------------------
INSERT INTO `survey` VALUES (1, 1, 1, 'Encuesta de satisfacción', '15%', NULL, '2020-12-24 00:03:33', 1, '2020-11-28 23:54:55', '2020-11-30 13:23:08');
INSERT INTO `survey` VALUES (10, 1, 1, 'Encuesta de navidad 2', '21%', '', '2020-12-25 00:00:00', 0, '2020-11-30 13:22:36', '2020-11-30 13:23:31');

-- ----------------------------
-- Table structure for typequestion
-- ----------------------------
DROP TABLE IF EXISTS `typequestion`;
CREATE TABLE `typequestion`  (
  `typeQuestionId` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `active` tinyint(4) NULL DEFAULT NULL,
  `timestampCreated` timestamp(0) NULL DEFAULT current_timestamp(0),
  `timestampModified` timestamp(0) NULL DEFAULT current_timestamp(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`typeQuestionId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of typequestion
-- ----------------------------
INSERT INTO `typequestion` VALUES (1, 'score', 1, '2020-11-29 19:24:07', '2020-11-29 19:24:07');
INSERT INTO `typequestion` VALUES (2, 'checkbox', 1, '2020-11-29 19:24:15', '2020-11-29 19:24:23');
INSERT INTO `typequestion` VALUES (3, 'text', 1, '2020-11-29 19:24:21', '2020-11-29 19:24:24');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) NULL DEFAULT NULL,
  `firstName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `lastName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `password` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `active` tinyint(4) NULL DEFAULT NULL,
  `timestampCreated` timestamp(0) NULL DEFAULT current_timestamp(0),
  `timestampModified` timestamp(0) NULL DEFAULT current_timestamp(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`userId`) USING BTREE,
  INDEX `companyId`(`companyId`) USING BTREE,
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`companyId`) REFERENCES `company` (`companyId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 1, 'Julio Cesar', 'Wong Rodriguez', 'julioo.wong@gmail.com', '6545700ab0c5f892423b7a3b78bc3612', 1, '2020-11-28 20:03:40', '2020-11-28 21:39:59');

-- ----------------------------
-- Procedure structure for spDelQuestion
-- ----------------------------
DROP PROCEDURE IF EXISTS `spDelQuestion`;
delimiter ;;
CREATE PROCEDURE `spDelQuestion`(pQuestionId INT)
BEGIN
	
	UPDATE question
	SET active = 0
	WHERE questionId = pQuestionId;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for spGetCompanies
-- ----------------------------
DROP PROCEDURE IF EXISTS `spGetCompanies`;
delimiter ;;
CREATE PROCEDURE `spGetCompanies`()
BEGIN
	
	SELECT
	companyId,
	description,
	logo
	FROM company
	LIMIT 4;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for spGetLogin
-- ----------------------------
DROP PROCEDURE IF EXISTS `spGetLogin`;
delimiter ;;
CREATE PROCEDURE `spGetLogin`(IN pEmail VARCHAR(30), IN pPassword VARCHAR(30))
BEGIN
	
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

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for spGetQuestions
-- ----------------------------
DROP PROCEDURE IF EXISTS `spGetQuestions`;
delimiter ;;
CREATE PROCEDURE `spGetQuestions`(pSurveyId INT)
BEGIN
	
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

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for spGetSurveys
-- ----------------------------
DROP PROCEDURE IF EXISTS `spGetSurveys`;
delimiter ;;
CREATE PROCEDURE `spGetSurveys`(IN pIdCompany INT)
BEGIN
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

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for spGetTypeQuestions
-- ----------------------------
DROP PROCEDURE IF EXISTS `spGetTypeQuestions`;
delimiter ;;
CREATE PROCEDURE `spGetTypeQuestions`()
BEGIN
	
	SELECT
	typeQuestionId,
	description
	FROM typequestion
	WHERE active = 1;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for spInsQuestion
-- ----------------------------
DROP PROCEDURE IF EXISTS `spInsQuestion`;
delimiter ;;
CREATE PROCEDURE `spInsQuestion`(pSurveyId INT, pTypeQuestionId INT, pQuestion VARCHAR(255))
BEGIN
	
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

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for spInsSurvey
-- ----------------------------
DROP PROCEDURE IF EXISTS `spInsSurvey`;
delimiter ;;
CREATE PROCEDURE `spInsSurvey`(pCompanyId INT, pUserId INT, pDescription VARCHAR(30), pDiscount VARCHAR(30), pBannerDiscount VARCHAR(50), pTimestampExpiration VARCHAR(20))
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for spSetActiveSurvey
-- ----------------------------
DROP PROCEDURE IF EXISTS `spSetActiveSurvey`;
delimiter ;;
CREATE PROCEDURE `spSetActiveSurvey`(pSurveyId INT, pCompanyId INT, pActive TINYINT)
BEGIN
	
	IF pActive = 1 THEN
	
		UPDATE survey
		SET active = 0
		WHERE companyId = pCompanyId;
		
	END IF;

	UPDATE survey
	SET active = pActive
	WHERE surveyId = pSurveyId;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for spUpdQuestion
-- ----------------------------
DROP PROCEDURE IF EXISTS `spUpdQuestion`;
delimiter ;;
CREATE PROCEDURE `spUpdQuestion`(pQuestionId int, pTypeQuestionId int, pQuestion VARCHAR(255))
BEGIN
	
	UPDATE question
	SET 
	question = pQuestion,
	typeQuestionId = pTypeQuestionId
	WHERE questionId = pQuestionId;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for spUpdSurvey
-- ----------------------------
DROP PROCEDURE IF EXISTS `spUpdSurvey`;
delimiter ;;
CREATE PROCEDURE `spUpdSurvey`(pSurveyId INT, pDescription VARCHAR(30), pDiscount VARCHAR(30), pBannerDiscount VARCHAR(50), pTimestampExpiration VARCHAR(20))
BEGIN
	
	UPDATE survey
	SET
	description = pDescription,
	discount = pDiscount,
	bannerDiscount = pBannerDiscount,
	timestampExpiration = pTimestampExpiration
	WHERE surveyId = pSurveyId;

END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
