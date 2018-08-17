/*
 Navicat MySQL Data Transfer

 Source Server         : db
 Source Server Type    : MySQL
 Source Server Version : 80011
 Source Host           : localhost:3306
 Source Schema         : ndzyjsxy

 Target Server Type    : MySQL
 Target Server Version : 80011
 File Encoding         : 65001

 Date: 17/08/2018 14:57:30
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for bus_aid_financially
-- ----------------------------
DROP TABLE IF EXISTS `bus_aid_financially`;
CREATE TABLE `bus_aid_financially`  (
  `ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `SO_ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '创建人ID',
  `BS_ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学生ID',
  `BAF_YEAR` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '学年',
  `BAF_SEMESTER` int(1) NULL DEFAULT NULL COMMENT '学期 字典BUS_SEMESTER',
  `BAF_TYPE` int(5) NULL DEFAULT NULL COMMENT '资助类型',
  `BAF_AID_TYPE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '资助奖励类型',
  `BAF_REDUCTION_LEVEL` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '减免等级',
  `BAF_REDUCTION_QUOTA` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '减免额度',
  `BAF_DIFFICULTY_LEVEL` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '困难级别',
  `BAF_DIFFICULTY_TYPE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '困难类型',
  `BAF_ENTRY_TIME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '录入时间',
  `BUS_PROCESS` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '流程大类',
  `BUS_PROCESS2` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '流程小类',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `BS_ID`(`BS_ID`) USING BTREE,
  INDEX `BAF_TYPE`(`BAF_TYPE`) USING BTREE,
  INDEX `BAF_YEAR`(`BAF_YEAR`) USING BTREE,
  INDEX `BAF_SEMESTER`(`BAF_SEMESTER`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bus_aid_financially
-- ----------------------------
INSERT INTO `bus_aid_financially` VALUES ('50844794401849344', '48601651874889729', '48944951878221824', '2017-2018', 2, 9, 'FIRST-CLASS', NULL, NULL, NULL, NULL, '2018-08-12 23:32:53', '100', '109');
INSERT INTO `bus_aid_financially` VALUES ('52306243808657408', '48601651874889729', '51930103357112320', '2017-2018', 2, 10, 'THREE_GOOD_STUDENTS', NULL, NULL, NULL, NULL, '2018-08-17 00:20:09', '100', '110');

-- ----------------------------
-- Table structure for bus_authorization
-- ----------------------------
DROP TABLE IF EXISTS `bus_authorization`;
CREATE TABLE `bus_authorization`  (
  `ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `SO_ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '操作员',
  `BA_TABLE_TYPE` int(1) NOT NULL COMMENT '授权类型 1 院系 2 系部 3班级',
  `BA_TABLE_ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '授权ID',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SO_ID`(`SO_ID`) USING BTREE,
  INDEX `BA_TABLE_TYPE`(`BA_TABLE_TYPE`, `BA_TABLE_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bus_authorization
-- ----------------------------
INSERT INTO `bus_authorization` VALUES ('51585084846768128', '48601651874889729', 3, '48656602449838080');
INSERT INTO `bus_authorization` VALUES ('52308987772665856', '48303136200196097', 1, '1');
INSERT INTO `bus_authorization` VALUES ('52504551604879360', '52504512421691393', 2, '48601265252335616');

-- ----------------------------
-- Table structure for bus_class
-- ----------------------------
DROP TABLE IF EXISTS `bus_class`;
CREATE TABLE `bus_class`  (
  `ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `BDM_ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '系部ID',
  `BC_MAJOR` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '专业（字典）',
  `BC_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '班级名称',
  `BC_YEAR` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '年段',
  `BC_ENTRY_TIME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '录入时间',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `BDM_ID`(`BDM_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bus_class
-- ----------------------------
INSERT INTO `bus_class` VALUES ('48656602449838080', '48601265252335616', '1002', '18多媒体', '2018', '2018-08-06 22:37:47');

-- ----------------------------
-- Table structure for bus_department
-- ----------------------------
DROP TABLE IF EXISTS `bus_department`;
CREATE TABLE `bus_department`  (
  `ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `BDM_COLLEGE` int(5) NOT NULL COMMENT '院系字典',
  `BDM_NAME` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '系部名称',
  `BDM_ADDRESS` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '系部地址',
  `BDM_DESCRIBE` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '系部描述',
  `BDM_ORDER` int(5) NULL DEFAULT NULL COMMENT '排序',
  `BDM_ENTER_TIME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '录入时间',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `BD_NAME`(`BDM_NAME`) USING BTREE,
  INDEX `BDM_COLLEGE`(`BDM_COLLEGE`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bus_department
-- ----------------------------
INSERT INTO `bus_department` VALUES ('48601265252335616', 1, '计算机系', '123', '123', 1, NULL);

-- ----------------------------
-- Table structure for bus_department_personnel
-- ----------------------------
DROP TABLE IF EXISTS `bus_department_personnel`;
CREATE TABLE `bus_department_personnel`  (
  `ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `SO_ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '账号ID',
  `BDM_ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '系部ID',
  `BDMP_NAME` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '人员名称',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SO_ID`(`SO_ID`) USING BTREE,
  INDEX `BDM_ID`(`BDM_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bus_department_personnel
-- ----------------------------
INSERT INTO `bus_department_personnel` VALUES ('48601651874889728', '48601651874889729', '48601265252335616', 'department_test');
INSERT INTO `bus_department_personnel` VALUES ('52504512421691392', '52504512421691393', '48601265252335616', 'department_manager');

-- ----------------------------
-- Table structure for bus_division
-- ----------------------------
DROP TABLE IF EXISTS `bus_division`;
CREATE TABLE `bus_division`  (
  `ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `BD_PARENT_ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '父部门ID',
  `BD_NAME` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '部门名称',
  `BD_CONTACTS` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '部门联系人',
  `BD_PHONE` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '部门联系人手机',
  `BD_FIXED_PHONE` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '部门联系人固定电话',
  `BD_EMAIL` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '部门联系人邮箱',
  `BD_ADDRESS` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '部门地址',
  `BD_DESCRIBE` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '部门描述',
  `BD_ORDER` int(5) NULL DEFAULT NULL COMMENT '排序',
  `BD_ENTER_TIME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '录入时间',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `BD_PARENT_ID`(`BD_PARENT_ID`) USING BTREE,
  INDEX `BD_NAME`(`BD_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bus_division
-- ----------------------------
INSERT INTO `bus_division` VALUES ('48302941391552512', '0', '教务处', '', '', '', '', '', '', 1, '2018-08-05 23:12:28');
INSERT INTO `bus_division` VALUES ('48302970428719104', '0', '财务处', '', '', '', '', '', '', 2, '2018-08-05 23:12:34');
INSERT INTO `bus_division` VALUES ('48308661151334400', '0', '学生处', '', '', '', '', '', '', 3, '2018-08-05 23:35:11');

-- ----------------------------
-- Table structure for bus_division_personnel
-- ----------------------------
DROP TABLE IF EXISTS `bus_division_personnel`;
CREATE TABLE `bus_division_personnel`  (
  `ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `SO_ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '账号ID',
  `BD_ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '部门ID',
  `BDP_NAME` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '人员名称',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SO_ID`(`SO_ID`) USING BTREE,
  INDEX `BD_ID`(`BD_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bus_division_personnel
-- ----------------------------
INSERT INTO `bus_division_personnel` VALUES ('48303136200196096', '48303136200196097', '48308661151334400', 'division_test');

-- ----------------------------
-- Table structure for bus_student
-- ----------------------------
DROP TABLE IF EXISTS `bus_student`;
CREATE TABLE `bus_student`  (
  `ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `SO_ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '操作员ID',
  `BDM_ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '系部ID',
  `BC_ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '班级ID',
  `BS_NAME` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '姓名',
  `BS_NUMBER` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '学号',
  `BS_LENGTH` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '学制',
  `BS_ENROLMENT_YEAR` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '入学年度',
  `BS_EXAMINEE_NUMBER` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '考生号',
  `BS_ID_CARD` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '身份证',
  `BS_SEX` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '性别',
  `BS_NATION` char(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '民族',
  `BS_BANK` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '银行',
  `BS_BANK_CARD` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '银行卡号',
  `BS_PHONE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '电话号码',
  `BS_PERMANENT_ADDRESS` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '户籍地址',
  `BS_HOME_ADDRESS` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '家庭住址',
  `BS_ENTRY_TIME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '录入时间',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SO_ID`(`SO_ID`) USING BTREE,
  INDEX `BDM_ID`(`BDM_ID`) USING BTREE,
  INDEX `BC_ID`(`BC_ID`) USING BTREE,
  INDEX `BS_NUMBER`(`BS_NUMBER`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bus_student
-- ----------------------------
INSERT INTO `bus_student` VALUES ('48944951878221824', '48944951878221825', '48601265252335616', '48656602449838080', 'student_test', '2018053105', '3', '2018', 'tt2018053105', '350122199605020114', '1', '1', '兴业银行', '454545454545452', '17012342032', 'test&middot;', 'test2', '2018-08-07 17:43:35');
INSERT INTO `bus_student` VALUES ('51930103357112320', '51930103373889536', '48601265252335616', '48656602449838080', 'student_test2', '2018053106', '3', '2017', '2018053105', '', '1', '1', '', '', '', '', '', '2018-08-15 23:25:30');

-- ----------------------------
-- Table structure for bus_student_attendance
-- ----------------------------
DROP TABLE IF EXISTS `bus_student_attendance`;
CREATE TABLE `bus_student_attendance`  (
  `ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `BS_ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学生ID',
  `BSA_YEAR` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '年度',
  `BSA_SEMESTER` int(1) NOT NULL COMMENT '学期 字典BUS_SEMESTER',
  `BSA_WEEK` int(2) NOT NULL COMMENT '周',
  `BSA_LATE` int(3) NOT NULL DEFAULT 0 COMMENT '迟到节数',
  `BSA_ABSENTEEISM` int(3) NOT NULL DEFAULT 0 COMMENT '旷课节数',
  `BSA_ENTRY_TIME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '录入时间',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `BS_ID`(`BS_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bus_student_attendance
-- ----------------------------
INSERT INTO `bus_student_attendance` VALUES ('49398562747842560', '48944951878221824', '2017-2018', 2, 1, 4, 4, '2018-08-08 23:46:04');
INSERT INTO `bus_student_attendance` VALUES ('51009695430737920', '48944951878221824', '2017-2018', 2, 2, 4, 12, '2018-08-13 10:28:08');
INSERT INTO `bus_student_attendance` VALUES ('51014046706565120', '48944951878221824', '2017-2018', 2, 3, 1, 5, '2018-08-13 10:45:25');

-- ----------------------------
-- Table structure for bus_student_comprehensive
-- ----------------------------
DROP TABLE IF EXISTS `bus_student_comprehensive`;
CREATE TABLE `bus_student_comprehensive`  (
  `ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `BS_ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学生ID',
  `BSC_EDUCATION_PROPORTION` int(2) NULL DEFAULT NULL COMMENT '德育比例',
  `BSC_INTELLECTUAL_PROPORTION` int(2) NULL DEFAULT NULL COMMENT '智育比例',
  `BSC_VOLUNTEER_PROPORTION` int(2) NULL DEFAULT NULL COMMENT '志愿者',
  `BSC_YEAR` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '学年',
  `BSC_SEMESTER` int(1) NULL DEFAULT NULL COMMENT '学期 字典BUS_SEMESTER',
  `BSC_TOTAL` decimal(6, 2) NULL DEFAULT 0.00 COMMENT '总分',
  `BSC_RANK` int(3) NULL DEFAULT 0 COMMENT '名次',
  `BSC_POLITICAL_ATTITUDE` int(2) NULL DEFAULT 0 COMMENT '政治态度和表现10分',
  `BSC_LABOR_ATTITUDE` int(2) NULL DEFAULT 0 COMMENT '劳动态度和表现20分',
  `BSC_COMPLIANCE` int(2) NULL DEFAULT 0 COMMENT '遵纪守法10分',
  `BSC_COLLECTIVE` int(2) NULL DEFAULT 0 COMMENT '集体观念10分',
  `BSC_DECORUM` int(2) NULL DEFAULT 0 COMMENT '文明礼貌15分',
  `BSC_CARE` int(2) NULL DEFAULT 0 COMMENT '爱护公物15分',
  `BSC_PERSONAL_QUALITY` int(2) NULL DEFAULT 0 COMMENT '个人品质10分',
  `BSC_SERVICE_SPIRIT` int(2) NULL DEFAULT 0 COMMENT '服务精神10分',
  `BSC_FULL_WORK` int(3) NULL DEFAULT 0 COMMENT '满勤分',
  `BSC_BONUS_POINTS` int(3) NULL DEFAULT 0 COMMENT '奖励分',
  `BSC_EDUCATION_DEDUCTION` int(3) NULL DEFAULT 0 COMMENT '德育扣分',
  `BSC_EDUCATION_TOTAL` int(3) NULL DEFAULT 0 COMMENT '德育总分',
  `BSC_EDUCATION_SCORE` decimal(6, 2) NULL DEFAULT 0.00 COMMENT '德育得分',
  `BSC_ACADEMIC_RECORD` int(3) NULL DEFAULT 0 COMMENT '学习成绩',
  `BSC_INTELLECTUAL_POINTS` int(3) NULL DEFAULT 0 COMMENT '智育奖励分',
  `BSC_INTELLECTUAL_SCORE` decimal(6, 2) NULL DEFAULT 0.00 COMMENT '智育得分',
  `BSC_INTELLECTUAL_RANK` int(3) NULL DEFAULT 0 COMMENT '智育排名',
  `BSC_VOLUNTEER_TOTAL` int(3) NULL DEFAULT 0 COMMENT '志愿者总分',
  `BSC_VOLUNTEER_SCORE` decimal(6, 2) NULL DEFAULT 0.00 COMMENT '志愿者得分',
  `BSC_REMARKS` varchar(3000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `BS_ID`(`BS_ID`) USING BTREE,
  INDEX `BSC_YEAR`(`BSC_YEAR`, `BSC_SEMESTER`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bus_student_comprehensive
-- ----------------------------
INSERT INTO `bus_student_comprehensive` VALUES ('50372217258639360', '48944951878221824', 30, 60, 10, '2017-2018', 2, 75.20, 1, 3, 14, 1, 10, 12, 10, 4, 10, 0, 0, 0, 64, 19.20, 83, 0, 49.80, 2, 62, 6.20, NULL);
INSERT INTO `bus_student_comprehensive` VALUES ('51936364043698176', '51930103357112320', 30, 60, 10, '2017-2018', 2, 74.90, 2, 2, 3, 4, 4, 6, 6, 7, 8, 9, 10, 22, 37, 11.10, 92, 0, 55.20, 1, 86, 8.60, '15');
INSERT INTO `bus_student_comprehensive` VALUES ('52511474496569344', '51930103357112320', 30, 60, 10, '2017-2018', 1, 68.30, 1, 2, 5, 4, 4, 6, 6, 7, 8, 9, 10, 22, 39, 11.70, 80, 0, 48.00, 1, 86, 8.60, '15');

-- ----------------------------
-- Table structure for bus_student_punishment
-- ----------------------------
DROP TABLE IF EXISTS `bus_student_punishment`;
CREATE TABLE `bus_student_punishment`  (
  `ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `BS_ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学生ID',
  `BSP_TITLE` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标题',
  `BSP_FILE_NUMBER` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文件号',
  `BSP_RELEASE_TIME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发布时间',
  `BSP_TYPE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '处分类型 BUS_PUNISHMENT',
  `BSP_REVOKE_TIME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '撤销时间',
  `BSP_DESCRIBE` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
  `BSP_IS_CANCEL` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '是否作废',
  `BSP_CANCEL_TIME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '作废时间',
  `BSP_ENTRY_TIME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '录入时间',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `BS_ID`(`BS_ID`) USING BTREE,
  INDEX `BSP_IS_CANCEL`(`BSP_IS_CANCEL`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bus_student_punishment
-- ----------------------------
INSERT INTO `bus_student_punishment` VALUES ('1', '48944951878221824', '测试处分', 'q1234222', '2018-08-09', '1', '2018-08-10', '测试用啊', '1', '2018-08-14 09:20:17', '2018-08-09 23:59:58');
INSERT INTO `bus_student_punishment` VALUES ('49746696170635264', '48944951878221824', 'test3', 'test3', '2018-09-05', '2', '2018-08-10', 'test', '1', '2018-08-09 23:14:29', '2018-08-09 22:49:53');

-- ----------------------------
-- Table structure for bus_teacher
-- ----------------------------
DROP TABLE IF EXISTS `bus_teacher`;
CREATE TABLE `bus_teacher`  (
  `ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `SO_ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作员ID',
  `BDM_ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '系部id',
  `BT_NAME` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '教师名称',
  `BT_NUMBER` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '工号',
  `BT_ENTRY_TIME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '录入时间',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SO_ID`(`SO_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bus_teacher
-- ----------------------------
INSERT INTO `bus_teacher` VALUES ('48679555707174912', '48679555707174913', '48601265252335616', 'teacher_test', 't12345', '2018-08-07 00:08:59');

-- ----------------------------
-- Table structure for sys_account_info
-- ----------------------------
DROP TABLE IF EXISTS `sys_account_info`;
CREATE TABLE `sys_account_info`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SO_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SAI_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '账号名称',
  `SAI_PHONE` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机',
  `SAI_EMAIL` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `SAI_TYPE` int(5) NULL DEFAULT NULL COMMENT '用户类型1管理员2部门3系部4学生5教师',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SO_ID`(`SO_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_account_info
-- ----------------------------
INSERT INTO `sys_account_info` VALUES ('1', '1', 'admin', '17012342032', '851758629@qq.com', 1);
INSERT INTO `sys_account_info` VALUES ('28281555403145216', '28281555327647744', '测试人员2', '', '', 1);
INSERT INTO `sys_account_info` VALUES ('28281967954886656', '28281967912943616', '测试人员3', '', '', 1);
INSERT INTO `sys_account_info` VALUES ('28281983910019072', '28281983868076032', '测试人员4', '', '', 1);
INSERT INTO `sys_account_info` VALUES ('28281998485225472', '28281998451671040', '测试人员5', '', '', 1);
INSERT INTO `sys_account_info` VALUES ('4112733184196608', '4112733112893440', '测试人员', '17012342032', '851758629@qq.com', 1);
INSERT INTO `sys_account_info` VALUES ('48303136338608128', '48303136200196097', 'division_test', '17012342032', '851758629@qq.com', 2);
INSERT INTO `sys_account_info` VALUES ('48601652139130880', '48601651874889729', 'department_test', '17012342031', '851758628@qq.com', 3);
INSERT INTO `sys_account_info` VALUES ('48679555824615424', '48679555707174913', 'teacher_test', '17012342030', '851758627@qq.com', 5);
INSERT INTO `sys_account_info` VALUES ('48944951974690816', '48944951878221825', 'student_test', '17012342035', '851758621@qq.com', 4);
INSERT INTO `sys_account_info` VALUES ('51930103629742080', '51930103373889536', 'student_test2', NULL, NULL, 4);
INSERT INTO `sys_account_info` VALUES ('52504512727875584', '52504512421691393', 'department_manager', NULL, NULL, 3);

-- ----------------------------
-- Table structure for sys_allocation
-- ----------------------------
DROP TABLE IF EXISTS `sys_allocation`;
CREATE TABLE `sys_allocation`  (
  `ID` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SA_KEY` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `SA_VALUE` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `SA_MODIFY_TIME` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '变更时间',
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE INDEX `SA_KEY`(`SA_KEY`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_allocation
-- ----------------------------
INSERT INTO `sys_allocation` VALUES ('21304048766418944', 'EMAIL_USER', '17012342032@163.com', '2018-06-07 23:48:24');
INSERT INTO `sys_allocation` VALUES ('21304048955162624', 'EMAIL_PASSWORD', 'as851758629', '2018-06-07 23:48:24');
INSERT INTO `sys_allocation` VALUES ('21304049068408832', 'EMAIL_HOST', 'smtp.163.com', '2018-06-07 23:48:24');
INSERT INTO `sys_allocation` VALUES ('21311400131428352', 'EMAIL_STATUS', '1', '2018-06-07 23:48:24');
INSERT INTO `sys_allocation` VALUES ('21386471894155264', 'EMAIL_PORT', '465', '2018-06-07 23:48:24');
INSERT INTO `sys_allocation` VALUES ('21399961086197760', 'EMAIL_PROTOCOL', 'smtp', '2018-06-07 23:48:24');
INSERT INTO `sys_allocation` VALUES ('21399961480462336', 'EMAIL_AUTH', '1', '2018-06-07 23:48:24');
INSERT INTO `sys_allocation` VALUES ('21399961660817408', 'EMAIL_SSL_ENABLE', '1', '2018-06-07 23:48:24');
INSERT INTO `sys_allocation` VALUES ('50328920767070208', 'EDUCATION_PROPORTION', '20', '2018-08-12 17:07:05');
INSERT INTO `sys_allocation` VALUES ('50328920993562624', 'INTELLECTUAL_PROPORTION', '70', '2018-08-12 17:07:05');
INSERT INTO `sys_allocation` VALUES ('50328921140363264', 'VOLUNTEER_PROPORTION', '10', '2018-08-12 17:07:06');
INSERT INTO `sys_allocation` VALUES ('50331495037927424', 'LATE_PROPORTION', '2', '2018-08-11 13:33:12');
INSERT INTO `sys_allocation` VALUES ('50331495419609088', 'ABSENTEEISM_PROPORTION', '40', '2018-08-11 13:33:13');

-- ----------------------------
-- Table structure for sys_button
-- ----------------------------
DROP TABLE IF EXISTS `sys_button`;
CREATE TABLE `sys_button`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SB_NAME` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按钮名称',
  `SB_BUTTONID` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按钮ID',
  `SB_FUNC` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按钮操作方法',
  `SB_CLASS` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按钮CLASS样式',
  `SB_ICON` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按钮图标图片',
  `SB_CODE` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限编码',
  `SB_ORDER` int(5) NULL DEFAULT NULL COMMENT '排序',
  `SB_TYPE` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按钮类型 0顶部按钮 1列表按钮',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_button
-- ----------------------------
INSERT INTO `sys_button` VALUES ('1', '添加', 'addBtn', NULL, 'btn btn-info', 'mdi mdi-table-row-plus-before', 'INSERT', 1, '0');
INSERT INTO `sys_button` VALUES ('1007779779182592', '设置权限', 'setPermission', '', 'btn btn-warning', 'mdi mdi-power-plug', 'SET_PERMISSION', 7, '1');
INSERT INTO `sys_button` VALUES ('1795360737460224', '返回', 'return', 'backHtml();', 'btn btn-warning', 'mdi mdi-keyboard-return', 'RETURN', 0, '0');
INSERT INTO `sys_button` VALUES ('20703880723562496', '组', 'group', '', 'btn btn-primary', 'mdi mdi-group', 'GROUP', 6, '0');
INSERT INTO `sys_button` VALUES ('2256636777332736', '设置字段', 'setField', '', 'btn btn-warning', 'mdi mdi-table-row', 'SET_FIELD', 8, '1');
INSERT INTO `sys_button` VALUES ('2261000862564352', '正则管理', 'regex', '', 'btn btn-danger', 'mdi mdi-table-column-plus-after', 'REGEX', 4, '0');
INSERT INTO `sys_button` VALUES ('2819607190568960', '刷新缓存', 'cache', '', 'btn btn-info', 'mdi mdi-cached', 'CACHE', 5, '0');
INSERT INTO `sys_button` VALUES ('2824289539588096', '列表', 'list', '', 'btn btn-info', 'mdi mdi-format-list-numbers', 'LIST', 9, '1');
INSERT INTO `sys_button` VALUES ('28283426524102656', '重置密码', 'resetPassword', '', 'btn btn-warning', 'mdi mdi-lock-reset', 'RESET_PWD', 98, '1');
INSERT INTO `sys_button` VALUES ('3008659554566144', '设置角色', 'setRole', '', 'btn btn-warning', 'mdi mdi-account-switch', 'SET_ROLE', 11, '1');
INSERT INTO `sys_button` VALUES ('33081849764904960', '作废', 'cancel', '', 'btn btn-danger', 'mdi mdi-cancel', 'CANCEL', 98, '1');
INSERT INTO `sys_button` VALUES ('33267466964566016', '作废信息', 'cancelInfo', '', 'btn btn-info', 'mdi mdi-information-outline', 'CANCEL_INFO', 98, '1');
INSERT INTO `sys_button` VALUES ('3375831514611712', '设置账号', 'setSub', '', 'btn btn-primary', 'mdi mdi-account-group', 'SET_SUB', 10, '1');
INSERT INTO `sys_button` VALUES ('48286237202579456', '导入', 'import', '', 'btn btn-success', 'mdi mdi-import', 'IMPORT', 7, '0');
INSERT INTO `sys_button` VALUES ('48286450940116992', '导出', 'export', '', 'btn btn-success', 'mdi mdi-export', 'EXPORT', 8, '0');
INSERT INTO `sys_button` VALUES ('48287050272604160', '账号信息', 'accountInfo', '', 'btn btn-info', 'mdi mdi-account-edit', 'ACCOUNT_INFO', 9, '1');
INSERT INTO `sys_button` VALUES ('49028916572061696', '撤销', 'revoke', '', 'btn btn-danger', 'mdi mdi-backburger', 'REVOKE', 97, '1');
INSERT INTO `sys_button` VALUES ('50800567487823872', '拷贝', 'copy', '', 'btn btn-danger', 'mdi mdi-content-copy', 'COPY', 9, '1');
INSERT INTO `sys_button` VALUES ('51562014773870592', '授权', 'authorization', '', 'btn btn-warning', 'mdi mdi-graphql', 'AUTHORIZATION', 96, '1');
INSERT INTO `sys_button` VALUES ('763206804963328', '保存', 'save', '', 'btn btn-primary', 'mdi mdi-content-save', 'SAVE', 2, '0');
INSERT INTO `sys_button` VALUES ('793562643955712', '编辑', 'edit', '', 'btn btn-success', 'mdi mdi-table-edit', 'UPDATE', 1, '1');
INSERT INTO `sys_button` VALUES ('793777245519872', '删除', 'del', '', 'btn btn-danger', 'mdi mdi-table-row-remove', 'DELETE', 99, '1');
INSERT INTO `sys_button` VALUES ('794877562454016', '设置按钮', 'setButton', 'setButton', 'btn btn-warning', 'mdi mdi-menu', 'SET_MENU', 3, '1');
INSERT INTO `sys_button` VALUES ('795677957292032', '设置列', 'setColumn', '', 'btn btn-warning', 'mdi mdi-table-row', 'SET_COLUMN', 4, '1');
INSERT INTO `sys_button` VALUES ('795961550962688', '设置搜索', 'setSearch', '', 'btn btn-info', 'mdi mdi-search-web', 'SET_SEARCH', 5, '1');
INSERT INTO `sys_button` VALUES ('797443633446912', '设置菜单', 'setMenu', '', 'btn btn-info', 'mdi mdi-menu', 'SET_MENU', 6, '1');

-- ----------------------------
-- Table structure for sys_configure
-- ----------------------------
DROP TABLE IF EXISTS `sys_configure`;
CREATE TABLE `sys_configure`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SC_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '配置列表名称',
  `SC_VIEW` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '视图名',
  `SC_ORDER_BY` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ORDER BY语句',
  `SC_JSP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'JSP地址',
  `SC_IS_SINGLE` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否单选',
  `SC_IS_SELECT` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否开启选择框',
  `SC_IS_PAGING` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否分页',
  `SC_IS_SEARCH` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否开启搜索',
  `SC_IS_FILTER` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否开启自定义过滤',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `ID`(`ID`) USING BTREE,
  INDEX `ID_2`(`ID`) USING BTREE,
  INDEX `ID_3`(`ID`) USING BTREE,
  INDEX `ID_4`(`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_configure
-- ----------------------------
INSERT INTO `sys_configure` VALUES ('1', '配置列表管理', 'v_configure', 'CONVERT(ID,SIGNED) DESC', 'admin/system/configure/home', '1', '0', '1', '1', NULL);
INSERT INTO `sys_configure` VALUES ('1758638922268672', '配置列表管理-设置字段', 'v_configure_column', 'SCC_ORDER ASC', 'admin/system/configure/column/home', '1', '0', '0', '1', NULL);
INSERT INTO `sys_configure` VALUES ('1870969903775744', '配置列表管理-设置搜索', 'v_configure_search', 'SCS_ORDER ASC', 'admin/system/configure/search/home', '1', '0', '0', '1', NULL);
INSERT INTO `sys_configure` VALUES ('2', '按钮管理', 'v_button', 'SB_TYPE ASC,SB_ORDER ASC', 'admin/system/button/home', '1', '0', '0', '1', NULL);
INSERT INTO `sys_configure` VALUES ('20764730981351424', '验证管理-验证组', 'v_validate_group', 'CONVERT(ID,SIGNED) ASC', 'admin/system/validate/group/home', '', '0', '1', '0', NULL);
INSERT INTO `sys_configure` VALUES ('2244279544053760', '验证管理', 'v_validate', 'CONVERT(ID,SIGNED) DESC', 'admin/system/validate/home', '1', '0', '1', '1', NULL);
INSERT INTO `sys_configure` VALUES ('2265709233045504', '验证管理-设置字段', 'v_validate_field', '', 'admin/system/validate/field/home', '1', '0', '0', '0', NULL);
INSERT INTO `sys_configure` VALUES ('2268726246244352', '验证管理-正则管理', 'v_validate_regex', '', 'admin/system/validate/regex/home', '1', '0', '0', '1', NULL);
INSERT INTO `sys_configure` VALUES ('26491587483664384', '格式管理', 'v_format', 'CONVERT(ID,SIGNED) DESC', 'admin/system/format/home', '', '0', '1', '1', NULL);
INSERT INTO `sys_configure` VALUES ('26568354160443392', '格式管理-详细', 'v_format_detail', 'SFD_ORDER ASC', 'admin/system/format/detail/home', '', '', '0', '1', NULL);
INSERT INTO `sys_configure` VALUES ('26721805670547456', '流程管理-流程定义', 'v_process_definition', 'CONVERT(ID,SIGNED) DESC', 'admin/system/process/definition/home', '', '', '1', '1', NULL);
INSERT INTO `sys_configure` VALUES ('27187947212111872', '流程管理-流程步骤', 'v_process_step', 'SPS_ORDER ASC', 'admin/system/process/step/home', '', '', '0', '0', NULL);
INSERT INTO `sys_configure` VALUES ('27999782165282816', '流程管理-流程启动角色', 'v_process_start', 'CONVERT(ID,SIGNED) ASC', 'admin/system/process/start/home', '', '', '0', '1', NULL);
INSERT INTO `sys_configure` VALUES ('28020396255084544', '测试流程', 'v_test_process', '', 'admin/system/allocation/process/home', '', '', '1', '1', '1');
INSERT INTO `sys_configure` VALUES ('2910894828814336', '字典管理', 'v_dict_type', 'CONVERT(ID,SIGNED) ASC', 'admin/system/dict/home', '', '', '1', '1', NULL);
INSERT INTO `sys_configure` VALUES ('2912701923721216', '字典管理-信息', 'v_dict_info', 'SDI_ORDER ASC', 'admin/system/dict/info/home', '', '', '0', '1', NULL);
INSERT INTO `sys_configure` VALUES ('2997414705233920', '菜单管理', 'v_menu', 'SM_ORDER ASC', 'admin/system/menu/home', '', '', '0', '1', NULL);
INSERT INTO `sys_configure` VALUES ('3', '角色管理', 'v_role', 'CONVERT(ID,SIGNED) DESC', 'admin/system/role/home', '1', '0', '1', '1', NULL);
INSERT INTO `sys_configure` VALUES ('33080508233547776', '流程管理-流程进度', 'v_process_schedule', 'CONVERT(ID,SIGNED) DESC', 'admin/system/process/schedule/home', '', '', '1', '1', '');
INSERT INTO `sys_configure` VALUES ('3316994321416192', '操作员管理', 'v_operator', 'CONVERT(ID,SIGNED) DESC', 'admin/system/operator/home', '', '', '1', '1', NULL);
INSERT INTO `sys_configure` VALUES ('3545555946962944', '操作员管理-账号管理', 'v_operator_sub', '', 'admin/system/operator/sub/home', '', '', '0', '0', NULL);
INSERT INTO `sys_configure` VALUES ('38163489528741888', '基础信息管理-部门管理', 'v_division', 'BD_ORDER ASC', 'admin/info/division/home', '', '', '1', '1', '');
INSERT INTO `sys_configure` VALUES ('38163489528741889', '基础信息管理-系部管理', 'v_department', 'BDM_ORDER ASC', 'admin/info/department/home', '', '', '1', '1', '');
INSERT INTO `sys_configure` VALUES ('48293001511829504', '基础信息管理-部门人员管理', 'v_division_personnel', 'CONVERT(ID,SIGNED) DESC', 'admin/info/divisionPersonnel/home', '', '', '1', '1', '');
INSERT INTO `sys_configure` VALUES ('48293001511829505', '基础信息管理-系部人员管理', 'v_department_personnel', 'CONVERT(ID,SIGNED) DESC', 'admin/info/departmentPersonnel/home', '', '', '1', '1', '');
INSERT INTO `sys_configure` VALUES ('48612439985487872', '基础信息管理-班级管理', 'v_class', 'CONVERT(ID,SIGNED) DESC', 'admin/info/cls/home', '', '', '1', '1', '0');
INSERT INTO `sys_configure` VALUES ('48666703227256832', '基础信息管理-教师管理', 'v_teacher', 'CONVERT(ID,SIGNED) DESC', 'admin/info/teacher/home', '', '', '1', '1', '');
INSERT INTO `sys_configure` VALUES ('48890586014416896', '学生管理', 'v_student', 'CONVERT(ID,SIGNED) DESC', 'admin/student/student/home', '', '', '1', '1', '1');
INSERT INTO `sys_configure` VALUES ('49382988399509504', '学生管理-考勤管理', 'v_student_attendance', 'CONVERT(ID,SIGNED) DESC', 'admin/student/attendance/home', '', '', '1', '1', '1');
INSERT INTO `sys_configure` VALUES ('49623725020020736', '学生管理-处分管理', 'v_student_punishment', 'CONVERT(ID,SIGNED) DESC', 'admin/student/punishment/home', '', '', '1', '1', '1');
INSERT INTO `sys_configure` VALUES ('50338719827230720', '学生管理-综合素质测评', 'v_student_comprehensive', 'BSC_YEAR DESC,BSC_SEMESTER DESC,BSC_RANK ASC', 'admin/student/comprehensive/home', '', '', '1', '1', '1');
INSERT INTO `sys_configure` VALUES ('50831880232108032', '资助管理-学院奖学金', 'v_aid_college_scholarship', 'BAF_YEAR DESC,BAF_SEMESTER DESC,CONVERT(ID,SIGNED) DESC', 'admin/aid/collegeScholarship/home', '', '', '1', '1', '');
INSERT INTO `sys_configure` VALUES ('52185393809850368', '日志管理-系统日志', 'v_log_system', 'SL_ENTERTIME DESC', 'admin/log/system/home', '', '', '1', '1', '1');
INSERT INTO `sys_configure` VALUES ('52235707715944448', '日志管理-操作日志', 'v_log_use', 'SL_ENTERTIME DESC', 'admin/log/use/home', '', '', '1', '1', '1');
INSERT INTO `sys_configure` VALUES ('52235788951224320', '日志管理-登录日志', 'v_log_personal', 'SL_ENTERTIME DESC', 'admin/log/personal/home', '', '', '1', '1', '1');
INSERT INTO `sys_configure` VALUES ('52258927902982144', '日志管理-查看日志', 'v_log_see', 'SL_ENTERTIME DESC', 'admin/log/see/home', '', '', '1', '1', '1');
INSERT INTO `sys_configure` VALUES ('52294046697127936', '资助管理-年度表彰', 'v_aid_commend', 'BAF_YEAR DESC,BAF_SEMESTER DESC,CONVERT(ID,SIGNED) DESC', 'admin/aid/commend/home', '', '', '1', '1', '');

-- ----------------------------
-- Table structure for sys_configure_column
-- ----------------------------
DROP TABLE IF EXISTS `sys_configure_column`;
CREATE TABLE `sys_configure_column`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SC_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `SCC_NAME` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '列名',
  `SCC_FIELD` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据查询字段',
  `SCC_ALIGN` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '对齐方式',
  `SCC_WIDTH` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '宽度',
  `SCC_CLASS` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '列的classname',
  `SCC_FUNC` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '格式化函数',
  `SCC_SDT_CODE` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典SDT_CODE',
  `SCC_IS_OPERATION` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否是操作列',
  `SCC_IS_MERGE` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否合并操作列',
  `SCC_IS_VISIBLE` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否隐藏',
  `SCC_IS_STATUS` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否是状态列',
  `SCC_ORDER` int(5) NULL DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SC_ID`(`SC_ID`) USING BTREE,
  CONSTRAINT `KIM_SC_ID` FOREIGN KEY (`SC_ID`) REFERENCES `sys_configure` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_configure_column
-- ----------------------------
INSERT INTO `sys_configure_column` VALUES ('1', '1', '名称', 'SC_NAME', 'left', '200px', NULL, NULL, NULL, '0', NULL, '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('10', '2', '排序', 'SB_ORDER', 'center', '50px', NULL, NULL, NULL, '0', NULL, '1', '0', 6);
INSERT INTO `sys_configure_column` VALUES ('12', '2', '操作', '', 'center', '180px', '', '', '', '1', NULL, '1', '0', 7);
INSERT INTO `sys_configure_column` VALUES ('13', '3', '名称', 'SR_NAME', 'center', '200px', '', '', NULL, '0', NULL, '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('14', '3', '操作', '', 'center', '200px', '', '', '', '1', NULL, '1', '0', 7);
INSERT INTO `sys_configure_column` VALUES ('18', '1758638922268672', '名称', 'SCC_NAME', 'center', '70px', '', '', NULL, '0', NULL, '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('1860152030396416', '1758638922268672', '查询字段', 'SCC_FIELD', 'center', '100px', '', '', NULL, '0', NULL, '1', '0', 2);
INSERT INTO `sys_configure_column` VALUES ('1860905247703040', '1758638922268672', '对齐方式', 'SCC_ALIGN', 'center', '50px', '', '', 'SYS_ALIGN', '0', NULL, '1', '0', 3);
INSERT INTO `sys_configure_column` VALUES ('1864436302217216', '1758638922268672', '宽度', 'SCC_WIDTH', 'center', '50px', '', '', '', '0', NULL, '1', '0', 4);
INSERT INTO `sys_configure_column` VALUES ('1864567009312768', '1758638922268672', '字典CODE', 'SCC_SDT_CODE', 'center', '100px', '', '', '', '0', NULL, '1', '0', 5);
INSERT INTO `sys_configure_column` VALUES ('1864656347987968', '1758638922268672', '是否操作列', 'SCC_IS_OPERATION', 'center', '70px', '', '', 'SYS_YES_NO', '0', NULL, '1', '0', 6);
INSERT INTO `sys_configure_column` VALUES ('1864758626091008', '1758638922268672', '是否显示', 'SCC_IS_VISIBLE', 'center', '70px', '', '', 'SYS_YES_NO', '0', NULL, '1', '0', 8);
INSERT INTO `sys_configure_column` VALUES ('1864854247833600', '1758638922268672', '是否状态列', 'SCC_IS_STATUS', 'center', '70px', '', '', 'SYS_YES_NO', '0', NULL, '1', '0', 7);
INSERT INTO `sys_configure_column` VALUES ('1864960447610880', '1758638922268672', '排序', 'SCC_ORDER', 'center', '30px', '', '', '', '0', NULL, '1', '0', 9);
INSERT INTO `sys_configure_column` VALUES ('1865046737027072', '1758638922268672', '操作', '', 'center', '100px', '', '', '', '1', NULL, '1', '0', 10);
INSERT INTO `sys_configure_column` VALUES ('1868640605437952', '3', '角色编码', 'SR_CODE', 'center', '100px', '', '', '', '0', NULL, '1', '0', 2);
INSERT INTO `sys_configure_column` VALUES ('1868813838581760', '3', '说明', 'SR_EXPLAIN', 'center', '150px', '', '', '', '0', NULL, '1', '0', 3);
INSERT INTO `sys_configure_column` VALUES ('1868880834199552', '3', '备注', 'SR_REMARK', 'center', '200px', '', '', '', '0', NULL, '1', '0', 4);
INSERT INTO `sys_configure_column` VALUES ('1869275610480640', '3', '类型', 'SR_TYPE', 'center', '50px', '', '', 'SYS_ROLE_TYPE', '0', NULL, '1', '0', 5);
INSERT INTO `sys_configure_column` VALUES ('1869396372881408', '3', '状态', 'IS_STATUS', 'center', '30px', '', '', '', '0', NULL, '1', '1', 6);
INSERT INTO `sys_configure_column` VALUES ('2', '1', '视图', 'SC_VIEW', 'left', '200px', NULL, NULL, NULL, '0', NULL, '1', '0', 2);
INSERT INTO `sys_configure_column` VALUES ('20765562036551680', '20764730981351424', '组', 'SVG_GROUP', 'center', '150px', '', '', '', '0', NULL, '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('20765795134996480', '20764730981351424', '组字段', 'SVF_NAMES', 'center', '300px', '', 'formatterValidateFields(targets, field)', '', '0', NULL, '1', '0', 10);
INSERT INTO `sys_configure_column` VALUES ('20765840668360704', '20764730981351424', '操作', '', 'center', '150px', '', '', '', '1', NULL, '1', '0', 20);
INSERT INTO `sys_configure_column` VALUES ('21038555857944576', '2265709233045504', '组', 'SVG_GROUPS', 'center', '150px', '', 'formatterValidateGroups(targets, field)', '', '0', NULL, '1', '0', 65);
INSERT INTO `sys_configure_column` VALUES ('2158780263432192', '1870969903775744', '名称', 'SCS_NAME', 'center', '', '', '', '', '0', NULL, '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('2158865617518592', '1870969903775744', '查询字段', 'SCS_FIELD', 'center', '', '', '', '', '0', NULL, '1', '0', 2);
INSERT INTO `sys_configure_column` VALUES ('2158947087679488', '1870969903775744', '字典', 'SCS_SDT_CODE', 'center', '', '', '', '', '0', NULL, '1', '0', 3);
INSERT INTO `sys_configure_column` VALUES ('2159271412236288', '1870969903775744', '查询条件', 'SCS_METHOD_TYPE', 'center', '', '', '', 'SYS_SEARCH_METHOD', '0', NULL, '1', '0', 5);
INSERT INTO `sys_configure_column` VALUES ('2159361338114048', '1870969903775744', '类型', 'SCS_TYPE', 'center', '', '', '', 'SYS_SEARCH_TYPE', '0', NULL, '1', '0', 7);
INSERT INTO `sys_configure_column` VALUES ('2159444662157312', '1870969903775744', '是否显示', 'SCC_IS_VISIBLE', 'center', '', '', '', 'SYS_YES_NO', '0', NULL, '1', '0', 8);
INSERT INTO `sys_configure_column` VALUES ('2159495593590784', '1870969903775744', '排序', 'SCS_ORDER', 'center', '30px', '', '', '', '0', NULL, '1', '0', 9);
INSERT INTO `sys_configure_column` VALUES ('2159557145001984', '1870969903775744', '操作', '', 'center', '180px', '', '', '', '1', NULL, '1', '0', 10);
INSERT INTO `sys_configure_column` VALUES ('2178961341677568', '1870969903775744', '备注', 'SCS_REMARK', 'left', '', '', '', '', '0', NULL, '1', '0', 6);
INSERT INTO `sys_configure_column` VALUES ('2244934925025280', '2244279544053760', '表名', 'SV_TABLE', 'center', '', '', '', '', '0', NULL, '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('2245043909820416', '2244279544053760', '状态', 'IS_STATUS', 'center', '100px', '', '', '', '0', NULL, '1', '1', 2);
INSERT INTO `sys_configure_column` VALUES ('2245094707036160', '2244279544053760', '操作', '', 'center', '280px', '', '', '', '1', NULL, '1', '0', 3);
INSERT INTO `sys_configure_column` VALUES ('2266941783801856', '2265709233045504', '名称', 'SVF_NAME', 'center', '130px', '', '', '', '0', NULL, '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('2267042472263680', '2265709233045504', '字段', 'SVF_FIELD', 'center', '130px', '', '', '', '0', NULL, '1', '0', 2);
INSERT INTO `sys_configure_column` VALUES ('2267136751828992', '2265709233045504', '是否必填', 'SVF_IS_REQUIRED', 'center', '60px', '', '', 'SYS_YES_NO', '0', NULL, '1', '0', 5);
INSERT INTO `sys_configure_column` VALUES ('2267227038416896', '2265709233045504', '最大字数', 'SVF_MAX_LENGTH', 'center', '60px', '', '', '', '0', NULL, '1', '0', 4);
INSERT INTO `sys_configure_column` VALUES ('2267305589342208', '2265709233045504', '最小字数', 'SVF_MIN_LENGTH', 'center', '60px', '', '', '', '0', NULL, '1', '0', 3);
INSERT INTO `sys_configure_column` VALUES ('2267444773126144', '2265709233045504', '状态', 'IS_STATUS', 'center', '100px', '', '', '', '0', NULL, '1', '1', 70);
INSERT INTO `sys_configure_column` VALUES ('2267542622044160', '2265709233045504', '操作', '', 'center', '160px', '', '', '', '1', NULL, '1', '0', 80);
INSERT INTO `sys_configure_column` VALUES ('2268804033806336', '2268726246244352', '名称', 'SVR_NAME', 'center', '200px', '', '', '', '0', NULL, '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('2268850032738304', '2268726246244352', '正则', 'SVR_REGEX', 'center', '150px', '', '', '', '0', NULL, '1', '0', 2);
INSERT INTO `sys_configure_column` VALUES ('2268917275820032', '2268726246244352', '操作', '', 'center', '160px', '', '', '', '1', NULL, '1', '0', 5);
INSERT INTO `sys_configure_column` VALUES ('2268978571378688', '2268726246244352', '状态', 'IS_STATUS', 'center', '100px', '', '', '', '0', NULL, '1', '1', 4);
INSERT INTO `sys_configure_column` VALUES ('2510530543616000', '2268726246244352', '错误消息', 'SVR_REGEX_MESSAGE', 'left', '150px', '', '', '', '0', NULL, '1', '0', 3);
INSERT INTO `sys_configure_column` VALUES ('2515524864966656', '2265709233045504', '正则', 'SVR_NAME', 'center', '150px', '', '', '', '0', NULL, '1', '0', 6);
INSERT INTO `sys_configure_column` VALUES ('26505467689697280', '26491587483664384', '格式名称', 'SF_NAME', 'center', '', '', '', '', '0', NULL, '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('26505514997252096', '26491587483664384', '格式唯一标识', 'SF_CODE', 'center', '', '', '', '', '0', NULL, '1', '0', 20);
INSERT INTO `sys_configure_column` VALUES ('26505581862846464', '26491587483664384', '格式配置年份', 'SF_YEAR', 'center', '', '', '', '', '0', NULL, '1', '0', 30);
INSERT INTO `sys_configure_column` VALUES ('26505673726492672', '26491587483664384', '格式配置时间', 'SF_ENTRY_TIME', 'center', '', '', '', '', '0', NULL, '1', '0', 40);
INSERT INTO `sys_configure_column` VALUES ('26505863703298048', '26491587483664384', '操作', '', 'center', '240px', '', '', '', '1', NULL, '1', '0', 50);
INSERT INTO `sys_configure_column` VALUES ('26568881204101120', '26568354160443392', '格式详细名称', 'SFD_NAME', 'center', '', '', '', '', '0', NULL, '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('26569120757579776', '26568354160443392', '菜单名称', 'SM_NAME', 'center', '', '', '', '', '0', NULL, '1', '0', 20);
INSERT INTO `sys_configure_column` VALUES ('26569174163652608', '26568354160443392', '排序', 'SFD_ORDER', 'center', '', '', '', '', '0', NULL, '1', '0', 30);
INSERT INTO `sys_configure_column` VALUES ('26569430683090944', '26568354160443392', '状态', 'IS_STATUS', 'center', '100px', '', '', '', '0', NULL, '1', '1', 40);
INSERT INTO `sys_configure_column` VALUES ('26569508260937728', '26568354160443392', '操作', '', 'center', '160px', '', '', '', '1', NULL, '1', '0', 50);
INSERT INTO `sys_configure_column` VALUES ('26725371181268992', '26721805670547456', '流程名称', 'SPD_NAME', 'center', '200px', '', '', '', '0', NULL, '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('26725441578467328', '26721805670547456', '版本', 'SPD_VERSION', 'center', '50px', '', '', '', '0', NULL, '1', '0', 20);
INSERT INTO `sys_configure_column` VALUES ('26725572235231232', '26721805670547456', '更新表名', 'SPD_UPDATE_TABLE', 'center', '150px', '', '', '', '0', '', '1', '0', 30);
INSERT INTO `sys_configure_column` VALUES ('26725657031475200', '26721805670547456', '更新表名称字段', 'SPD_UPDATE_NAME', 'center', '100px', '', '', '', '0', '', '1', '0', 40);
INSERT INTO `sys_configure_column` VALUES ('26725837801783296', '26721805670547456', '录入时间', 'SDP_ENTRY_TIME', 'center', '150px', '', '', '', '0', NULL, '1', '0', 60);
INSERT INTO `sys_configure_column` VALUES ('26725907158794240', '26721805670547456', '状态', 'IS_STATUS', 'center', '100px', '', '', '', '0', NULL, '1', '1', 70);
INSERT INTO `sys_configure_column` VALUES ('26725940633534464', '26721805670547456', '操作', '', 'center', '140px', '', '', '', '1', '', '1', '0', 80);
INSERT INTO `sys_configure_column` VALUES ('27188897591066624', '27187947212111872', '步骤名称', 'SPS_NAME', 'center', '', '', '', '', '0', NULL, '1', '0', 10);
INSERT INTO `sys_configure_column` VALUES ('27190954163175424', '27187947212111872', '办理角色', 'SR_NAME', 'center', '', '', '', '', '0', NULL, '1', '0', 20);
INSERT INTO `sys_configure_column` VALUES ('27191092403240960', '27187947212111872', '流程状态', 'SPS_PROCESS_STATUS', 'center', '', '', '', 'SYS_PROCESS_STATUS', '0', NULL, '1', '0', 30);
INSERT INTO `sys_configure_column` VALUES ('27191203975921664', '27187947212111872', '验证超时', 'SPS_IS_OVER_TIME', 'center', '60px', '', '', 'SYS_YES_NO', '0', NULL, '1', '0', 40);
INSERT INTO `sys_configure_column` VALUES ('27191254274015232', '27187947212111872', '超时时间(分)', 'SPS_OVER_TIME', 'center', '90px', '', '', '', '0', NULL, '1', '0', 50);
INSERT INTO `sys_configure_column` VALUES ('27191384893030400', '27187947212111872', '办理类型', 'SPS_STEP_TYPE', 'center', '60px', '', '', 'SYS_STEP_TYPE', '0', NULL, '1', '0', 25);
INSERT INTO `sys_configure_column` VALUES ('27191443244187648', '27187947212111872', '排序', 'SPS_ORDER', 'center', '50px', '', '', '', '0', NULL, '1', '0', 60);
INSERT INTO `sys_configure_column` VALUES ('27191508914405376', '27187947212111872', '操作', '', 'center', '160px', '', '', '', '1', NULL, '1', '0', 70);
INSERT INTO `sys_configure_column` VALUES ('28000060813869056', '27999782165282816', '角色名称', 'SR_NAME', 'center', '', '', '', '', '0', NULL, '1', '0', 10);
INSERT INTO `sys_configure_column` VALUES ('28000165969264640', '27999782165282816', '角色编码', 'SR_CODE', 'center', '', '', '', '', '0', NULL, '1', '0', 20);
INSERT INTO `sys_configure_column` VALUES ('28000216644845568', '27999782165282816', '操作', '', 'center', '160px', '', '', '', '1', NULL, '1', '0', 30);
INSERT INTO `sys_configure_column` VALUES ('28182430565269504', '28020396255084544', 'NAME', 'NAME', 'center', '', '', '', '', '0', NULL, '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('28182511620194304', '28020396255084544', '操作', '', 'center', '', '', '', '', '1', NULL, '1', '0', 20);
INSERT INTO `sys_configure_column` VALUES ('2911711610798080', '2910894828814336', '字典名称', 'SDT_NAME', 'center', '', '', '', '', '0', NULL, '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('2911767181131776', '2910894828814336', '字典编码', 'SDT_CODE', 'center', '', '', '', '', '0', NULL, '1', '0', 2);
INSERT INTO `sys_configure_column` VALUES ('2911814169919488', '2910894828814336', '状态', 'IS_STATUS', 'center', '30px', '', '', '', '0', NULL, '1', '1', 3);
INSERT INTO `sys_configure_column` VALUES ('2911845136465920', '2910894828814336', '操作', '', 'center', '280px', '', '', '', '1', NULL, '1', '0', 4);
INSERT INTO `sys_configure_column` VALUES ('2913356109316096', '2912701923721216', '名称', 'SDI_NAME', 'left', '220px', '', '', '', '0', NULL, '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('2913416456962048', '2912701923721216', '信息编码', 'SDI_CODE', 'center', '130px', '', '', '', '0', '', '1', '0', 2);
INSERT INTO `sys_configure_column` VALUES ('2913455988277248', '2912701923721216', '连接编码', 'SDI_INNERCODE', 'center', '150px', '', '', '', '0', '', '1', '0', 3);
INSERT INTO `sys_configure_column` VALUES ('2913615233417216', '2912701923721216', '备注', 'SDI_REMARK', 'left', '200px', '', '', '', '0', '', '1', '0', 4);
INSERT INTO `sys_configure_column` VALUES ('2913660032778240', '2912701923721216', '排序', 'SDI_ORDER', 'center', '50px', '', '', '', '0', '', '1', '0', 5);
INSERT INTO `sys_configure_column` VALUES ('2913742199193600', '2912701923721216', '状态', 'IS_STATUS', 'center', '100px', '', '', '', '0', '', '1', '1', 6);
INSERT INTO `sys_configure_column` VALUES ('2913770057760768', '2912701923721216', '操作', '', 'center', '180px', '', '', '', '1', NULL, '1', '0', 7);
INSERT INTO `sys_configure_column` VALUES ('2997755832172544', '2997414705233920', '菜单名称', 'SM_NAME', 'left', '250px', '', '', '', '0', NULL, '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('2997843275022336', '2997414705233920', '配置列表', 'SC_NAME', 'left', '150px', '', '', '', '0', NULL, '1', '0', 2);
INSERT INTO `sys_configure_column` VALUES ('2997919837847552', '2997414705233920', '权限编码', 'SM_CODE', 'left', '150px', '', '', '', '0', NULL, '1', '0', 3);
INSERT INTO `sys_configure_column` VALUES ('2997976557420544', '2997414705233920', 'URL地址', 'SM_URL', 'left', '150px', '', '', '', '0', NULL, '1', '0', 4);
INSERT INTO `sys_configure_column` VALUES ('2998205407035392', '2997414705233920', '图标', 'SM_CLASSICON', 'center', '30px', '', 'formatterIcon(value, row, index);', '', '0', NULL, '1', '0', 5);
INSERT INTO `sys_configure_column` VALUES ('2998269449863168', '2997414705233920', '排序', 'SM_ORDER', 'center', '20px', '', '', '', '0', NULL, '1', '0', 6);
INSERT INTO `sys_configure_column` VALUES ('2998347505860608', '2997414705233920', '状态', 'IS_STATUS', 'center', '30px', '', '', '', '0', NULL, '1', '1', 7);
INSERT INTO `sys_configure_column` VALUES ('2998399913689088', '2997414705233920', '操作', '', 'center', '250px', '', '', '', '1', '0', '1', '0', 8);
INSERT INTO `sys_configure_column` VALUES ('3', '1', 'JSP地址', 'SC_JSP', 'left', '300px', NULL, NULL, NULL, '0', NULL, '1', '0', 3);
INSERT INTO `sys_configure_column` VALUES ('31554657063010304', '28020396255084544', '审核状态', 'PROCESS_STATUS_NAME', 'center', '100px', '', 'processLogFunc(targets, field);', '', '0', NULL, '1', '0', 5);
INSERT INTO `sys_configure_column` VALUES ('3317102362492928', '3316994321416192', '姓名', 'SAI_NAME', 'center', '130px', '', '', '', '0', '', '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('3317258654842880', '3316994321416192', '登录账号', 'SOS_USERNAME', 'left', '150px', '', '', '', '0', '', '1', '0', 2);
INSERT INTO `sys_configure_column` VALUES ('3317344390610944', '3316994321416192', '手机', 'SAI_PHONE', 'center', '80px', '', '', '', '0', '', '1', '0', 3);
INSERT INTO `sys_configure_column` VALUES ('3317375399100416', '3316994321416192', '邮箱', 'SAI_EMAIL', 'center', '100px', '', '', '', '0', '', '1', '0', 4);
INSERT INTO `sys_configure_column` VALUES ('3317518018019328', '3316994321416192', '状态', 'IS_STATUS', 'center', '30px', '', '', '', '0', '', '1', '1', 50);
INSERT INTO `sys_configure_column` VALUES ('3317579653316608', '3316994321416192', '操作', '', 'center', '360px', '', '', '', '1', '', '1', '0', 60);
INSERT INTO `sys_configure_column` VALUES ('33262437608194048', '33080508233547776', '流程定义', 'SPD_NAME', 'left', '150px', '', '', '', '0', NULL, '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('33262560820068352', '33080508233547776', '项目名称', 'SPS_TABLE_NAME', 'left', '200px', '', '', '', '0', NULL, '1', '0', 10);
INSERT INTO `sys_configure_column` VALUES ('33264112095985664', '33080508233547776', '启动人', 'INITIATOR_NAME', 'center', '100px', '', '', '', '0', NULL, '1', '0', 20);
INSERT INTO `sys_configure_column` VALUES ('33264915670106112', '33080508233547776', '当前步骤名称', 'STEP_NAME', 'center', '100px', '', '', '', '0', NULL, '1', '0', 30);
INSERT INTO `sys_configure_column` VALUES ('33264993856126976', '33080508233547776', '流程状态', 'PROCESS_STATUS_NAME', 'center', '100px', '', 'processLogFunc(targets, field);', '', '0', NULL, '1', '0', 40);
INSERT INTO `sys_configure_column` VALUES ('33265154850291712', '33080508233547776', '是否作废', 'SPS_IS_CANCEL', 'center', '80px', '', '', 'SYS_YES_NO', '0', NULL, '1', '0', 50);
INSERT INTO `sys_configure_column` VALUES ('33265501832478720', '33080508233547776', '操作', '', 'center', '80px', '', '', '', '1', NULL, '1', '0', 60);
INSERT INTO `sys_configure_column` VALUES ('3545634929901568', '3545555946962944', '登录账号', 'SOS_USERNAME', 'center', '', '', '', '', '0', NULL, '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('3547333325225984', '3545555946962944', '是否默认', 'SOS_DEFAULT', 'center', '80px', '', '', 'SYS_YES_NO', '0', NULL, '1', '0', 3);
INSERT INTO `sys_configure_column` VALUES ('3547388299968512', '3545555946962944', '状态', 'IS_STATUS', 'center', '30px', '', '', '', '0', NULL, '1', '1', 5);
INSERT INTO `sys_configure_column` VALUES ('3547457338212352', '3545555946962944', '创建时间', 'SOS_CREATETIME', 'center', '', '', '', '', '0', NULL, '1', '0', 4);
INSERT INTO `sys_configure_column` VALUES ('3547490485796864', '3545555946962944', '操作', '', 'center', '', '', '', '', '1', NULL, '1', '0', 6);
INSERT INTO `sys_configure_column` VALUES ('38164004056596480', '38163489528741888', '部门名称', 'BD_NAME', 'center', '150px', '', '', '', '0', NULL, '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('38164004056596481', '38163489528741889', '系部名称', 'BDM_NAME', 'center', '150px', '', '', '', '0', NULL, '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('38164089465208832', '38163489528741888', '上级部门', 'BD_PARENT_NAME', 'center', '150px', '', '', '', '0', NULL, '1', '0', 10);
INSERT INTO `sys_configure_column` VALUES ('38164089465208833', '38163489528741889', '院系', 'BDM_COLLEGE_NAME', 'center', '150px', '', '', '', '0', NULL, '1', '0', 10);
INSERT INTO `sys_configure_column` VALUES ('38164146021203968', '38163489528741888', '联系人', 'BD_CONTACTS', 'center', '80px', '', '', '', '0', NULL, '1', '0', 20);
INSERT INTO `sys_configure_column` VALUES ('38164215797645312', '38163489528741888', '手机', 'BD_PHONE', 'center', '100px', '', '', '', '0', NULL, '1', '0', 30);
INSERT INTO `sys_configure_column` VALUES ('38164484337958912', '38163489528741888', '描述', 'BD_DESCRIBE', 'left', '200px', '', '', '', '0', NULL, '1', '0', 40);
INSERT INTO `sys_configure_column` VALUES ('38164484337958913', '38163489528741889', '描述', 'BDM_DESCRIBE', 'left', '200px', '', '', '', '0', NULL, '1', '0', 40);
INSERT INTO `sys_configure_column` VALUES ('38164554567385088', '38163489528741888', '操作', '', 'center', '160px', '', '', '', '1', NULL, '1', '0', 50);
INSERT INTO `sys_configure_column` VALUES ('38164554567385089', '38163489528741889', '操作', '', 'center', '160px', '', '', '', '1', NULL, '1', '0', 50);
INSERT INTO `sys_configure_column` VALUES ('38446985522446336', '38163489528741888', '排序', 'BD_ORDER', 'center', '50px', '', '', '', '0', NULL, '1', '0', 45);
INSERT INTO `sys_configure_column` VALUES ('38446985522446337', '38163489528741889', '排序', 'BDM_ORDER', 'center', '50px', '', '', '', '0', NULL, '1', '0', 45);
INSERT INTO `sys_configure_column` VALUES ('4', '1', '操作', '', 'center', '320px', '', '', '', '1', NULL, '1', '0', 4);
INSERT INTO `sys_configure_column` VALUES ('48293541973065728', '48293001511829504', '人员名称', 'BDP_NAME', 'center', '150px', '', '', '', '0', '', '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('48293541973065729', '48293001511829505', '人员名称', 'BDMP_NAME', 'center', '150px', '', '', '', '0', '', '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('48293694100471808', '48293001511829504', '所属部门', 'BD_NAME', 'center', '250px', '', '', '', '0', '', '1', '0', 20);
INSERT INTO `sys_configure_column` VALUES ('48293694100471809', '48293001511829505', '所属系部', 'BDM_NAME', 'center', '250px', '', '', '', '0', '', '1', '0', 20);
INSERT INTO `sys_configure_column` VALUES ('48294220707921920', '48293001511829504', '操作', '', 'center', '400px', '', '', '', '1', '', '1', '0', 30);
INSERT INTO `sys_configure_column` VALUES ('48294220707921921', '48293001511829505', '操作', '', 'center', '400px', '', '', '', '1', '', '1', '0', 30);
INSERT INTO `sys_configure_column` VALUES ('48527923962970112', '3316994321416192', '类型', 'SAI_TYPE', 'center', '50px', '', '', 'SYS_OPERATOR_TYPE', '0', '', '1', '0', 40);
INSERT INTO `sys_configure_column` VALUES ('48612785872961536', '48612439985487872', '班级名称', 'BC_NAME', 'left', '200px', '', '', '', '0', '', '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('48613108662403072', '48612439985487872', '系部名称', 'BDM_NAME', 'left', '200px', '', '', '', '0', '', '1', '0', 20);
INSERT INTO `sys_configure_column` VALUES ('48613188865884160', '48612439985487872', '年度', 'BC_YEAR', 'center', '70px', '', '', '', '0', '', '1', '0', 30);
INSERT INTO `sys_configure_column` VALUES ('48613280037470208', '48612439985487872', '专业', 'BC_MAJOR_NAME', 'left', '150px', '', '', '', '0', '', '1', '0', 25);
INSERT INTO `sys_configure_column` VALUES ('48613355400724480', '48612439985487872', '操作', '', 'center', '150px', '', '', '', '1', '0', '1', '0', 40);
INSERT INTO `sys_configure_column` VALUES ('48666874698792960', '48666703227256832', '名称', 'BT_NAME', 'center', '150px', '', '', '', '0', '', '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('48666968101748736', '48666703227256832', '所属系部', 'BDM_NAME', 'left', '200px', '', '', '', '0', '', '1', '0', 20);
INSERT INTO `sys_configure_column` VALUES ('48667014041960448', '48666703227256832', '工号', 'BT_NUMBER', 'center', '150px', '', '', '', '0', '', '1', '0', 30);
INSERT INTO `sys_configure_column` VALUES ('48667074221834240', '48666703227256832', '操作', '', 'center', '400px', '', '', '', '1', '', '1', '0', 40);
INSERT INTO `sys_configure_column` VALUES ('48890805737226240', '48890586014416896', '姓名', 'BS_NAME', 'center', '120px', '', '', '', '0', '', '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('48890888293711872', '48890586014416896', '系部', 'BDM_NAME', 'left', '170px', '', '', '', '0', '', '1', '0', 10);
INSERT INTO `sys_configure_column` VALUES ('48890941183885312', '48890586014416896', '班级', 'BC_NAME', 'left', '170px', '', '', '', '0', '', '1', '0', 20);
INSERT INTO `sys_configure_column` VALUES ('48891009236467712', '48890586014416896', '学号', 'BS_NUMBER', 'center', '90px', '', '', '', '0', '', '1', '0', 2);
INSERT INTO `sys_configure_column` VALUES ('48891051766710272', '48890586014416896', '学制', 'BS_LENGTH', 'center', '40px', '', '', '', '0', '', '1', '0', 40);
INSERT INTO `sys_configure_column` VALUES ('48891120653959168', '48890586014416896', '身份证', 'BS_ID_CARD', 'center', '140px', '', '', '', '0', '', '1', '0', 3);
INSERT INTO `sys_configure_column` VALUES ('48891194926694400', '48890586014416896', '性别', 'BS_SEX_NAME', 'center', '50px', '', '', '', '0', '', '1', '0', 5);
INSERT INTO `sys_configure_column` VALUES ('48891240950792192', '48890586014416896', '民族', 'BS_NATION_NAME', 'center', '60px', '', '', '', '0', '', '1', '0', 6);
INSERT INTO `sys_configure_column` VALUES ('48891335788199936', '48890586014416896', '操作', '', 'center', '80px', '', '', '', '1', '1', '1', '0', 60);
INSERT INTO `sys_configure_column` VALUES ('49300938162176000', '26721805670547456', '大类', 'BUS_PROCESS', 'center', '50px', '', '', '', '0', '', '1', '0', 45);
INSERT INTO `sys_configure_column` VALUES ('49301009763139584', '26721805670547456', '小类', 'BUS_PROCESS2', 'center', '50px', '', '', '', '0', '', '1', '0', 46);
INSERT INTO `sys_configure_column` VALUES ('49383206146801664', '49382988399509504', '学生', 'BS_NAME', 'center', '100px', '', '', '', '0', '', '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('49383278167195648', '49382988399509504', '班级', 'BC_NAME', 'left', '170px', '', '', '', '0', '', '1', '0', 10);
INSERT INTO `sys_configure_column` VALUES ('49383375462465536', '49382988399509504', '学年', 'BSA_YEAR', 'center', '80px', '', '', '', '0', '', '1', '0', 20);
INSERT INTO `sys_configure_column` VALUES ('49383479741251584', '49382988399509504', '学期', 'BSA_SEMESTER', 'center', '70px', '', '', 'BUS_SEMESTER', '0', '', '1', '0', 30);
INSERT INTO `sys_configure_column` VALUES ('49383534061682688', '49382988399509504', '迟到节数', 'BSA_LATE', 'center', '100px', '', '', '', '0', '', '1', '0', 40);
INSERT INTO `sys_configure_column` VALUES ('49383601019551744', '49382988399509504', '旷节数', 'BSA_ABSENTEEISM', 'center', '100px', '', '', '', '0', '', '1', '0', 50);
INSERT INTO `sys_configure_column` VALUES ('49383645982490624', '49382988399509504', '操作', '', 'center', '140px', '', '', '', '1', '', '1', '0', 60);
INSERT INTO `sys_configure_column` VALUES ('49623930373144576', '49623725020020736', '学生', 'BS_NAME', 'center', '100px', '', '', '', '0', '', '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('49623978519560192', '49623725020020736', '班级', 'BC_NAME', 'left', '170px', '', '', '', '0', '', '1', '0', 10);
INSERT INTO `sys_configure_column` VALUES ('49624050699337728', '49623725020020736', '标题', 'BSP_TITLE', 'left', '150px', '', '', '', '0', '', '1', '0', 20);
INSERT INTO `sys_configure_column` VALUES ('49624093883891712', '49623725020020736', '文件号', 'BSP_FILE_NUMBER', 'center', '100px', '', '', '', '0', '', '1', '0', 30);
INSERT INTO `sys_configure_column` VALUES ('49624134371508224', '49623725020020736', '发布时间', 'BSP_RELEASE_TIME', 'center', '100px', '', '', '', '0', '', '1', '0', 40);
INSERT INTO `sys_configure_column` VALUES ('49624224339329024', '49623725020020736', '类型', 'BSP_TYPE', 'center', '50px', '', '', 'BUS_PUNISHMENT', '0', '', '1', '0', 50);
INSERT INTO `sys_configure_column` VALUES ('49624381759946752', '49623725020020736', '是否撤销', 'BSP_IS_CANCEL', 'center', '70px', '', '', 'SYS_YES_NO', '0', '', '1', '0', 60);
INSERT INTO `sys_configure_column` VALUES ('49624458347937792', '49623725020020736', '操作', '', 'center', '80px', '', '', '', '1', '1', '1', '0', 70);
INSERT INTO `sys_configure_column` VALUES ('5', '2', '名称', 'SB_NAME', 'center', '150px', NULL, NULL, NULL, '0', NULL, '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('50339547778646016', '50338719827230720', '学生', 'BS_NAME', 'center', '100px', '', '', '', '0', '', '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('50339601818058752', '50338719827230720', '班级', 'BC_NAME', 'left', '170px', '', '', '', '0', '', '1', '0', 20);
INSERT INTO `sys_configure_column` VALUES ('50339688694677504', '50338719827230720', '学年', 'BSC_YEAR', 'center', '80px', '', '', '', '0', '', '1', '0', 30);
INSERT INTO `sys_configure_column` VALUES ('50339748840996864', '50338719827230720', '学期', 'BSC_SEMESTER', 'center', '70px', '', '', 'BUS_SEMESTER', '0', '', '1', '0', 40);
INSERT INTO `sys_configure_column` VALUES ('50339810778284032', '50338719827230720', '总分', 'BSC_TOTAL', 'center', '50px', '', '', '', '0', '', '1', '0', 50);
INSERT INTO `sys_configure_column` VALUES ('50339886946844672', '50338719827230720', '排名', 'BSC_RANK', 'center', '50px', '', '', '', '0', '', '1', '0', 60);
INSERT INTO `sys_configure_column` VALUES ('50340030438178816', '50338719827230720', '学习成绩', 'BSC_ACADEMIC_RECORD', 'center', '60px', '', '', '', '0', '', '1', '0', 70);
INSERT INTO `sys_configure_column` VALUES ('50340096863371264', '50338719827230720', '智育排名', 'BSC_INTELLECTUAL_RANK', 'center', '60px', '', '', '', '0', '', '1', '0', 80);
INSERT INTO `sys_configure_column` VALUES ('50340160268664832', '50338719827230720', '操作', '', 'center', '150px', '', '', '', '1', '', '1', '0', 90);
INSERT INTO `sys_configure_column` VALUES ('50833257528295424', '50831880232108032', '学生', 'BS_NAME', 'center', '100px', '', '', '', '0', '', '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('50833440131514368', '50831880232108032', '学号', 'BS_NUMBER', 'center', '90px', '', '', '', '0', '', '1', '0', 20);
INSERT INTO `sys_configure_column` VALUES ('50833512873328640', '50831880232108032', '班级', 'BC_NAME', 'left', '170px', '', '', '', '0', '', '1', '0', 30);
INSERT INTO `sys_configure_column` VALUES ('50833638492733440', '50831880232108032', '综合测评', 'BSC_TOTAL', 'center', '60px', '', '', '', '0', '', '1', '0', 40);
INSERT INTO `sys_configure_column` VALUES ('50833705790341120', '50831880232108032', '测评排名', 'BSC_RANK', 'center', '60px', '', '', '', '0', '', '1', '0', 50);
INSERT INTO `sys_configure_column` VALUES ('50833777835900928', '50831880232108032', '学习成绩', 'BSC_ACADEMIC_RECORD', 'center', '60px', '', '', '', '0', '', '1', '0', 60);
INSERT INTO `sys_configure_column` VALUES ('50833829203542016', '50831880232108032', '学习排名', 'BSC_INTELLECTUAL_RANK', 'center', '60px', '', '', '', '0', '', '1', '0', 70);
INSERT INTO `sys_configure_column` VALUES ('50833943762567168', '50831880232108032', '操作', '', 'center', '190px', '', '', '', '1', '', '1', '0', 80);
INSERT INTO `sys_configure_column` VALUES ('50847196098068480', '50831880232108032', '审核状态', 'PROCESS_STATUS_NAME', 'center', '100px', '', 'processLogFunc(targets, field);', '', '0', '', '1', '0', 75);
INSERT INTO `sys_configure_column` VALUES ('51009901505282048', '49382988399509504', '周', 'BSA_WEEK', 'center', '50px', '', '', '', '0', '', '1', '0', 35);
INSERT INTO `sys_configure_column` VALUES ('52227996769058816', '52185393809850368', '操作员', 'SAI_NAME', 'center', '120px', '', '', '', '0', '', '1', '0', 10);
INSERT INTO `sys_configure_column` VALUES ('52228093506486272', '52185393809850368', 'IP地址', 'SL_IP', 'center', '100px', '', '', '', '0', '', '1', '0', 20);
INSERT INTO `sys_configure_column` VALUES ('52228151819894784', '52185393809850368', '事件', 'SL_EVENT', 'center', '100px', '', '', '', '0', '', '1', '0', 5);
INSERT INTO `sys_configure_column` VALUES ('52228262180421632', '52185393809850368', '时间', 'SL_ENTERTIME', 'center', '150px', '', '', '', '0', '', '1', '0', 30);
INSERT INTO `sys_configure_column` VALUES ('52228391499202560', '52185393809850368', '内容', 'SLT_CONTENT', 'center', '300px', '', '', '', '0', '', '1', '0', 40);
INSERT INTO `sys_configure_column` VALUES ('52228826968621056', '52185393809850368', '结果', 'SL_RESULT', 'center', '70px', '', '', 'SYS_SUCCESS_FAIL', '0', '', '1', '0', 50);
INSERT INTO `sys_configure_column` VALUES ('52235707783053312', '52235707715944448', '事件', 'SL_EVENT', 'center', '100px', '', '', '', '0', '', '1', '0', 5);
INSERT INTO `sys_configure_column` VALUES ('52235707833384960', '52235707715944448', '操作员', 'SAI_NAME', 'center', '120px', '', '', '', '0', '', '1', '0', 10);
INSERT INTO `sys_configure_column` VALUES ('52235707862745088', '52235707715944448', 'IP地址', 'SL_IP', 'center', '100px', '', '', '', '0', '', '1', '0', 20);
INSERT INTO `sys_configure_column` VALUES ('52235708106014720', '52235707715944448', '时间', 'SL_ENTERTIME', 'center', '150px', '', '', '', '0', '', '1', '0', 30);
INSERT INTO `sys_configure_column` VALUES ('52235708122791936', '52235707715944448', '内容', 'SLT_CONTENT', 'center', '300px', '', '', '', '0', '', '1', '0', 40);
INSERT INTO `sys_configure_column` VALUES ('52235708437364736', '52235707715944448', '结果', 'SL_RESULT', 'center', '70px', '', '', 'SYS_SUCCESS_FAIL', '0', '', '1', '0', 50);
INSERT INTO `sys_configure_column` VALUES ('52235788988973056', '52235788951224320', '事件', 'SL_EVENT', 'center', '100px', '', '', '', '0', '', '1', '0', 5);
INSERT INTO `sys_configure_column` VALUES ('52235789018333184', '52235788951224320', '操作员', 'SAI_NAME', 'center', '120px', '', '', '', '0', '', '1', '0', 10);
INSERT INTO `sys_configure_column` VALUES ('52235789039304704', '52235788951224320', 'IP地址', 'SL_IP', 'center', '100px', '', '', '', '0', '', '1', '0', 20);
INSERT INTO `sys_configure_column` VALUES ('52235789278380032', '52235788951224320', '时间', 'SL_ENTERTIME', 'center', '150px', '', '', '', '0', '', '1', '0', 30);
INSERT INTO `sys_configure_column` VALUES ('52235789295157248', '52235788951224320', '内容', 'SLT_CONTENT', 'center', '300px', '', '', '', '0', '', '1', '0', 40);
INSERT INTO `sys_configure_column` VALUES ('52235789605535744', '52235788951224320', '结果', 'SL_RESULT', 'center', '70px', '', '', 'SYS_SUCCESS_FAIL', '0', '', '1', '0', 50);
INSERT INTO `sys_configure_column` VALUES ('52258927953313792', '52258927902982144', '事件', 'SL_EVENT', 'center', '100px', '', '', '', '0', '', '1', '0', 5);
INSERT INTO `sys_configure_column` VALUES ('52258927982673920', '52258927902982144', '操作员', 'SAI_NAME', 'center', '120px', '', '', '', '0', '', '1', '0', 10);
INSERT INTO `sys_configure_column` VALUES ('52258927999451136', '52258927902982144', 'IP地址', 'SL_IP', 'center', '100px', '', '', '', '0', '', '1', '0', 20);
INSERT INTO `sys_configure_column` VALUES ('52258928267886592', '52258927902982144', '时间', 'SL_ENTERTIME', 'center', '150px', '', '', '', '0', '', '1', '0', 30);
INSERT INTO `sys_configure_column` VALUES ('52258928284663808', '52258927902982144', '内容', 'SLT_CONTENT', 'center', '300px', '', '', '', '0', '', '1', '0', 40);
INSERT INTO `sys_configure_column` VALUES ('52258928716677120', '52258927902982144', '结果', 'SL_RESULT', 'center', '70px', '', '', 'SYS_SUCCESS_FAIL', '0', '', '1', '0', 50);
INSERT INTO `sys_configure_column` VALUES ('52293398979149824', '50831880232108032', '奖项', 'BAF_AID_TYPE', 'center', '80px', '', '', 'BUS_COLLEGE_SCHOLARSHIP_TYPE', '0', '', '1', '0', 72);
INSERT INTO `sys_configure_column` VALUES ('52294046760042496', '52294046697127936', '学生', 'BS_NAME', 'center', '100px', '', '', '', '0', '', '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('52294046781014016', '52294046697127936', '学号', 'BS_NUMBER', 'center', '90px', '', '', '', '0', '', '1', '0', 20);
INSERT INTO `sys_configure_column` VALUES ('52294046793596928', '52294046697127936', '班级', 'BC_NAME', 'left', '170px', '', '', '', '0', '', '1', '0', 30);
INSERT INTO `sys_configure_column` VALUES ('52294047137529856', '52294046697127936', '综合测评平均', 'BSC_TOTAL', 'center', '100px', '', '', '', '0', '', '1', '0', 40);
INSERT INTO `sys_configure_column` VALUES ('52294047150112768', '52294046697127936', '测评排名', 'BSC_TOTAL_RANK', 'center', '60px', '', '', '', '0', '', '1', '0', 50);
INSERT INTO `sys_configure_column` VALUES ('52294047561154560', '52294046697127936', '学习成绩平均', 'BSC_ACADEMIC_RECORD', 'center', '100px', '', '', '', '0', '', '1', '0', 60);
INSERT INTO `sys_configure_column` VALUES ('52294047573737472', '52294046697127936', '学习排名', 'BSC_ACADEMIC_RECORD_RANK', 'center', '60px', '', '', '', '0', '', '1', '0', 70);
INSERT INTO `sys_configure_column` VALUES ('52294048001556480', '52294046697127936', '奖项', 'BAF_AID_TYPE', 'center', '80px', '', '', 'BUS_COMMEND_TYPE', '0', '', '1', '0', 72);
INSERT INTO `sys_configure_column` VALUES ('52294048018333696', '52294046697127936', '审核状态', 'PROCESS_STATUS_NAME', 'center', '100px', '', 'processLogFunc(targets, field);', '', '0', '', '1', '0', 75);
INSERT INTO `sys_configure_column` VALUES ('52294048408403968', '52294046697127936', '操作', '', 'center', '200px', '', '', '', '1', '', '1', '0', 80);
INSERT INTO `sys_configure_column` VALUES ('52300989453041664', '52294046697127936', '学年', 'BAF_YEAR', 'center', '100px', '', '', '', '0', '', '1', '0', 35);
INSERT INTO `sys_configure_column` VALUES ('52301132520751104', '50831880232108032', '学年', 'BAF_YEAR', 'center', '100px', '', '', '', '0', '', '1', '0', 35);
INSERT INTO `sys_configure_column` VALUES ('52301184400097280', '50831880232108032', '学期', 'BAF_SEMESTER', 'center', '100px', '', '', 'BUS_SEMESTER', '0', '', '1', '0', 36);
INSERT INTO `sys_configure_column` VALUES ('52510692615389184', '50338719827230720', '学号', 'BS_NUMBER', 'center', '80px', '', '', '', '0', '', '1', '0', 10);
INSERT INTO `sys_configure_column` VALUES ('6', '2', '操作ID', 'SB_BUTTONID', 'center', '100px', NULL, NULL, NULL, '0', NULL, '1', '0', 2);
INSERT INTO `sys_configure_column` VALUES ('7', '2', '图标', 'SB_ICON', 'center', '20px', NULL, 'btnClassFunc(targets,field)', NULL, '0', NULL, '1', '0', 3);
INSERT INTO `sys_configure_column` VALUES ('8', '2', '权限编码', 'SB_CODE', 'center', '100px', NULL, NULL, NULL, '0', NULL, '1', '0', 4);
INSERT INTO `sys_configure_column` VALUES ('9', '2', '按钮类型', 'SB_TYPE_NAME', 'center', '70px', NULL, NULL, NULL, '0', NULL, '1', '0', 5);

-- ----------------------------
-- Table structure for sys_configure_search
-- ----------------------------
DROP TABLE IF EXISTS `sys_configure_search`;
CREATE TABLE `sys_configure_search`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SC_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `SCS_NAME` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `SCS_FIELD` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '查询字段',
  `SCS_SDT_CODE` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典CODE',
  `SCS_METHOD_TYPE` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '查询条件',
  `SCS_TYPE` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '搜索类型',
  `SCS_IS_STUDENT_YEAR` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '是否学年搜索',
  `SCS_REMARK` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `SCC_IS_VISIBLE` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否要显示到界面上',
  `SCS_ORDER` int(5) NULL DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SC_ID`(`SC_ID`) USING BTREE,
  CONSTRAINT `SC_ID` FOREIGN KEY (`SC_ID`) REFERENCES `sys_configure` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_configure_search
-- ----------------------------
INSERT INTO `sys_configure_search` VALUES ('1', '1758638922268672', '配置列表ID', 'SC_ID', NULL, '1', '1', '1', NULL, '0', 999);
INSERT INTO `sys_configure_search` VALUES ('2', '1870969903775744', '配置列表ID', 'SC_ID', '', '1', '1', '1', NULL, '0', 999);
INSERT INTO `sys_configure_search` VALUES ('20765340250144768', '20764730981351424', '验证表ID', 'SV_ID', '', '1', '1', '1', '', '0', 999);
INSERT INTO `sys_configure_search` VALUES ('2171824976691200', '1', '名称', 'SC_NAME', '', '4', '1', '1', '', '1', 1);
INSERT INTO `sys_configure_search` VALUES ('2171865384615936', '1', '视图', 'SC_VIEW', '', '4', '1', '1', '', '1', 2);
INSERT INTO `sys_configure_search` VALUES ('2186041037422592', '2', '名称', 'SB_NAME', '', '4', '1', '1', '', '1', 1);
INSERT INTO `sys_configure_search` VALUES ('2186121794551808', '2', '按钮ID', 'SB_BUTTONID', '', '4', '1', '1', '', '1', 2);
INSERT INTO `sys_configure_search` VALUES ('2186200785879040', '2', '权限编码', 'SB_CODE', '', '4', '1', '1', '', '1', 3);
INSERT INTO `sys_configure_search` VALUES ('2186332197617664', '2', '类型', 'SB_TYPE', 'SYS_BUTTON_TYPE', '1', '2', '1', '', '1', 4);
INSERT INTO `sys_configure_search` VALUES ('2186661538562048', '3', '名称', 'SR_NAME', '', '4', '1', '1', '', '1', 1);
INSERT INTO `sys_configure_search` VALUES ('2186704823779328', '3', '角色编码', 'SR_CODE', '', '4', '1', '1', '', '1', 2);
INSERT INTO `sys_configure_search` VALUES ('2186816178356224', '3', '类型', 'SR_TYPE', 'SYS_ROLE_TYPE', '1', '2', '1', '', '1', 3);
INSERT INTO `sys_configure_search` VALUES ('2186924844384256', '3', '状态', 'IS_STATUS', 'SYS_YES_NO', '1', '2', '1', '', '1', 4);
INSERT INTO `sys_configure_search` VALUES ('2245173287321600', '2244279544053760', '表名', 'SV_TABLE', '', '4', '1', '1', '', '1', 1);
INSERT INTO `sys_configure_search` VALUES ('2509095781269504', '2265709233045504', '验证表ID', 'SV_ID', '', '1', '1', '1', '', '0', 999);
INSERT INTO `sys_configure_search` VALUES ('26571126167568384', '26568354160443392', 'SF_ID', 'SF_ID', '', '1', '1', '1', '', '0', 999);
INSERT INTO `sys_configure_search` VALUES ('26726106744750080', '26721805670547456', '流程名称', 'SPD_NAME', '', '4', '1', '1', '', '1', 10);
INSERT INTO `sys_configure_search` VALUES ('26726185870295040', '26721805670547456', '流程更新表', 'SPD_UPDATE_TABLE', '', '4', '1', '1', '', '1', 20);
INSERT INTO `sys_configure_search` VALUES ('26726269102063616', '26721805670547456', '状态', 'IS_STATUS', 'SYS_YES_NO', '1', '2', '1', '', '1', 30);
INSERT INTO `sys_configure_search` VALUES ('27188785221468160', '27187947212111872', 'SPD_ID', 'SPD_ID', '', '1', '1', '1', '', '0', 999);
INSERT INTO `sys_configure_search` VALUES ('28000645642452992', '27999782165282816', 'SPD_ID', 'SPD_ID', '', '1', '1', '1', '', '0', 99);
INSERT INTO `sys_configure_search` VALUES ('2936099735339008', '2912701923721216', 'SDT_ID', 'SDT_ID', '', '1', '1', '1', '', '0', 999);
INSERT INTO `sys_configure_search` VALUES ('29363312076521472', '2910894828814336', '是否隐藏', 'IS_HIDDEN', '', '1', '1', '1', '', '1', 999);
INSERT INTO `sys_configure_search` VALUES ('2936386403434496', '2268726246244352', '正则名称', 'SVR_NAME', '', '4', '1', '1', '', '1', 1);
INSERT INTO `sys_configure_search` VALUES ('2936517366382592', '2910894828814336', '名称', 'SDT_NAME', '', '4', '1', '1', '', '1', 1);
INSERT INTO `sys_configure_search` VALUES ('2936558080491520', '2910894828814336', '编码', 'SDT_CODE', '', '4', '1', '1', '', '1', 2);
INSERT INTO `sys_configure_search` VALUES ('3318078297341952', '3316994321416192', '姓名', 'SAI_NAME', '', '4', '1', '1', '', '1', 1);
INSERT INTO `sys_configure_search` VALUES ('3318164473511936', '3316994321416192', '登录账号', 'SOS_USERNAME', '', '4', '1', '1', '', '1', 2);
INSERT INTO `sys_configure_search` VALUES ('3318215916650496', '3316994321416192', '手机', 'SAI_PHONE', '', '4', '1', '1', '', '1', 3);
INSERT INTO `sys_configure_search` VALUES ('3318255989030912', '3316994321416192', '邮箱', 'SAI_EMAIL', '', '4', '1', '1', '', '1', 4);
INSERT INTO `sys_configure_search` VALUES ('33265648310157312', '33080508233547776', '流程定义', 'SPD_NAME', '', '4', '1', '1', '', '1', 1);
INSERT INTO `sys_configure_search` VALUES ('33265744854646784', '33080508233547776', '项目名称', 'SPS_TABLE_NAME', '', '4', '1', '1', '', '1', 10);
INSERT INTO `sys_configure_search` VALUES ('33265870629240832', '33080508233547776', '启动人', 'INITIATOR_NAME', '', '4', '1', '1', '', '1', 20);
INSERT INTO `sys_configure_search` VALUES ('33266027097751552', '33080508233547776', '流程状态', 'SPS_AUDIT_STATUS', 'SYS_PROCESS_STATUS', '1', '2', '1', '', '1', 30);
INSERT INTO `sys_configure_search` VALUES ('33266132563525632', '33080508233547776', '是否作废', 'SPS_IS_CANCEL', 'SYS_YES_NO', '1', '2', '1', '', '1', 40);
INSERT INTO `sys_configure_search` VALUES ('3547613181771776', '3545555946962944', 'SO_ID', 'SO_ID', '', '1', '1', '1', '', '0', 999);
INSERT INTO `sys_configure_search` VALUES ('38164645629919232', '38163489528741888', '部门名称', 'BD_NAME', '', '4', '1', '1', '', '1', 1);
INSERT INTO `sys_configure_search` VALUES ('38164645629919233', '38163489528741889', '系部名称', 'BDM_NAME', '', '4', '1', '1', '', '1', 1);
INSERT INTO `sys_configure_search` VALUES ('38164690009849856', '38163489528741888', '联系人', 'BD_CONTACTS', '', '4', '1', '1', '', '1', 10);
INSERT INTO `sys_configure_search` VALUES ('39603098028605440', '2997414705233920', '名称', 'SM_NAME', '', '4', '1', '1', '', '1', 1);
INSERT INTO `sys_configure_search` VALUES ('48294713588973568', '48293001511829504', '人员名称', 'BDP_NAME', '', '4', '1', '1', '', '1', 1);
INSERT INTO `sys_configure_search` VALUES ('48294713588973569', '48293001511829505', '人员名称', 'BDMP_NAME', '', '4', '1', '1', '', '1', 1);
INSERT INTO `sys_configure_search` VALUES ('48294776654528512', '48293001511829504', '所属部门', 'BD_NAME', '', '4', '1', '1', '', '1', 20);
INSERT INTO `sys_configure_search` VALUES ('48294776654528513', '48293001511829505', '所属系部', 'BDM_NAME', '', '4', '1', '1', '', '1', 20);
INSERT INTO `sys_configure_search` VALUES ('48613435075723264', '48612439985487872', '班级名称', 'BC_NAME', '', '4', '1', '1', '', '1', 1);
INSERT INTO `sys_configure_search` VALUES ('48613477098455040', '48612439985487872', '系部名称', 'BDM_NAME', '', '4', '1', '1', '', '1', 20);
INSERT INTO `sys_configure_search` VALUES ('48613546774233088', '48612439985487872', '专业', 'BC_MAJOR', 'BUS_MAJOR', '1', '2', '1', '', '1', 30);
INSERT INTO `sys_configure_search` VALUES ('48667188210434048', '48666703227256832', '教师名称', 'BT_NAME', '', '4', '1', '1', '', '1', 1);
INSERT INTO `sys_configure_search` VALUES ('48667250646843392', '48666703227256832', '所属系部', 'BDM_NAME', '', '4', '1', '1', '', '1', 20);
INSERT INTO `sys_configure_search` VALUES ('48667292443082752', '48666703227256832', '工号', 'BT_NUMBER', '', '4', '1', '1', '', '1', 30);
INSERT INTO `sys_configure_search` VALUES ('48891420307619840', '48890586014416896', '学生姓名', 'BS_NAME', '', '4', '1', '1', '', '1', 1);
INSERT INTO `sys_configure_search` VALUES ('48891465165701120', '48890586014416896', '系部', 'BDM_NAME', '', '4', '1', '1', '', '1', 10);
INSERT INTO `sys_configure_search` VALUES ('48891504432775168', '48890586014416896', '班级', 'BC_NAME', '', '4', '1', '1', '', '1', 20);
INSERT INTO `sys_configure_search` VALUES ('48891543850844160', '48890586014416896', '学号', 'BS_NUMBER', '', '4', '1', '1', '', '1', 30);
INSERT INTO `sys_configure_search` VALUES ('48891578202193920', '48890586014416896', '身份证', 'BS_ID_CARD', '', '4', '1', '1', '', '1', 40);
INSERT INTO `sys_configure_search` VALUES ('48891829847851008', '48890586014416896', '性别', 'BS_SEX', 'BUS_SEX', '1', '2', '1', '', '1', 50);
INSERT INTO `sys_configure_search` VALUES ('48891880963833856', '48890586014416896', '民族', 'BS_NATION', 'BUS_NATION', '1', '2', '1', '', '1', 60);
INSERT INTO `sys_configure_search` VALUES ('48946558678335488', '3316994321416192', '类型', 'SAI_TYPE', 'SYS_OPERATOR_TYPE', '1', '2', '1', '', '1', 5);
INSERT INTO `sys_configure_search` VALUES ('49624539285422080', '49623725020020736', '学生', 'BS_NAME', '', '4', '1', '1', '', '1', 1);
INSERT INTO `sys_configure_search` VALUES ('49624578787377152', '49623725020020736', '班级', 'BC_NAME', '', '4', '1', '1', '', '1', 10);
INSERT INTO `sys_configure_search` VALUES ('49624644126244864', '49623725020020736', '标题', 'BSP_TITLE', '', '4', '1', '1', '', '1', 20);
INSERT INTO `sys_configure_search` VALUES ('49624671217254400', '49623725020020736', '文件号', 'BSP_FILE_NUMBER', '', '4', '1', '1', '', '1', 30);
INSERT INTO `sys_configure_search` VALUES ('49624755669565440', '49623725020020736', '类型', 'BSP_TYPE', 'BUS_PUNISHMENT', '1', '2', '1', '', '1', 40);
INSERT INTO `sys_configure_search` VALUES ('49624822736486400', '49623725020020736', '是否作废', 'BSP_IS_CANCEL', 'SYS_YES_NO', '1', '2', '1', '', '1', 50);
INSERT INTO `sys_configure_search` VALUES ('50340231299203072', '50338719827230720', '学生', 'BS_NAME', '', '4', '1', '1', '', '1', 1);
INSERT INTO `sys_configure_search` VALUES ('50340297250439168', '50338719827230720', '班级', 'BC_NAME', '', '4', '1', '1', '', '1', 20);
INSERT INTO `sys_configure_search` VALUES ('50340356205576192', '50338719827230720', '学年', 'BSC_YEAR', '', '1', '4', '1', '', '1', 30);
INSERT INTO `sys_configure_search` VALUES ('50340412128231424', '50338719827230720', '学期', 'BSC_SEMESTER', 'BUS_SEMESTER', '1', '2', '1', '', '1', 40);
INSERT INTO `sys_configure_search` VALUES ('52219816479555584', '50831880232108032', '学生', 'BS_NAME', '', '4', '1', '1', '', '1', 10);
INSERT INTO `sys_configure_search` VALUES ('52219899509997568', '50831880232108032', '学年', 'BAF_YEAR', '', '1', '4', '1', '', '1', 20);
INSERT INTO `sys_configure_search` VALUES ('52219984423682048', '50831880232108032', '学期', 'BAF_SEMESTER', 'BUS_SEMESTER', '1', '2', '1', '', '1', 30);
INSERT INTO `sys_configure_search` VALUES ('52220169669312512', '50831880232108032', '奖励类型', 'BAF_AID_TYPE', 'BUS_COLLEGE_SCHOLARSHIP_TYPE', '1', '2', '1', '', '1', 40);
INSERT INTO `sys_configure_search` VALUES ('52228903812464640', '52185393809850368', '操作员', 'SAI_NAME', '', '4', '1', '1', '', '1', 10);
INSERT INTO `sys_configure_search` VALUES ('52229086726062080', '52185393809850368', '事件', 'SL_EVENT', '', '4', '1', '1', '', '1', 5);
INSERT INTO `sys_configure_search` VALUES ('52229127566000128', '52185393809850368', 'IP', 'SL_IP', '', '4', '1', '1', '', '1', 20);
INSERT INTO `sys_configure_search` VALUES ('52229287880687616', '52185393809850368', '开始时间', 'SL_ENTERTIME', '', '8', '6', '1', '', '1', 30);
INSERT INTO `sys_configure_search` VALUES ('52229361411031040', '52185393809850368', '结束时间', 'SL_ENDTIME', '', '6', '6', '1', '', '1', 40);
INSERT INTO `sys_configure_search` VALUES ('52229475181527040', '52185393809850368', '结果', 'SL_RESULT', 'SYS_SUCCESS_FAIL', '1', '2', '1', '', '1', 50);
INSERT INTO `sys_configure_search` VALUES ('52235708483502080', '52235707715944448', '事件', 'SL_EVENT', '', '4', '1', '1', '', '1', 5);
INSERT INTO `sys_configure_search` VALUES ('52235708823240704', '52235707715944448', '操作员', 'SAI_NAME', '', '4', '1', '1', '', '1', 10);
INSERT INTO `sys_configure_search` VALUES ('52235708848406528', '52235707715944448', 'IP', 'SL_IP', '', '4', '1', '1', '', '1', 20);
INSERT INTO `sys_configure_search` VALUES ('52235709121036288', '52235707715944448', '开始时间', 'SL_ENTERTIME', '', '8', '6', '1', '', '1', 30);
INSERT INTO `sys_configure_search` VALUES ('52235709142007808', '52235707715944448', '结束时间', 'SL_ENDTIME', '', '6', '6', '1', '', '1', 40);
INSERT INTO `sys_configure_search` VALUES ('52235709435609088', '52235707715944448', '结果', 'SL_RESULT', 'SYS_SUCCESS_FAIL', '1', '2', '1', '', '1', 50);
INSERT INTO `sys_configure_search` VALUES ('52235789655867392', '52235788951224320', '事件', 'SL_EVENT', '', '4', '1', '1', '', '1', 5);
INSERT INTO `sys_configure_search` VALUES ('52235789974634496', '52235788951224320', '操作员', 'SAI_NAME', '', '4', '1', '1', '', '1', 10);
INSERT INTO `sys_configure_search` VALUES ('52235789995606016', '52235788951224320', 'IP', 'SL_IP', '', '4', '1', '1', '', '1', 20);
INSERT INTO `sys_configure_search` VALUES ('52235790234681344', '52235788951224320', '开始时间', 'SL_ENTERTIME', '', '8', '6', '1', '', '1', 30);
INSERT INTO `sys_configure_search` VALUES ('52235790259847168', '52235788951224320', '结束时间', 'SL_ENDTIME', '', '6', '6', '1', '', '1', 40);
INSERT INTO `sys_configure_search` VALUES ('52235790519894016', '52235788951224320', '结果', 'SL_RESULT', 'SYS_SUCCESS_FAIL', '1', '2', '1', '', '1', 50);
INSERT INTO `sys_configure_search` VALUES ('52258929148690432', '52258927902982144', '事件', 'SL_EVENT', '', '4', '1', '1', '', '1', 5);
INSERT INTO `sys_configure_search` VALUES ('52258929173856256', '52258927902982144', '操作员', 'SAI_NAME', '', '4', '1', '1', '', '1', 10);
INSERT INTO `sys_configure_search` VALUES ('52258929484234752', '52258927902982144', 'IP', 'SL_IP', '', '4', '1', '1', '', '1', 20);
INSERT INTO `sys_configure_search` VALUES ('52258929501011968', '52258927902982144', '开始时间', 'SL_ENTERTIME', '', '8', '6', '1', '', '1', 30);
INSERT INTO `sys_configure_search` VALUES ('52258929798807552', '52258927902982144', '结束时间', 'SL_ENDTIME', '', '6', '6', '1', '', '1', 40);
INSERT INTO `sys_configure_search` VALUES ('52258929815584768', '52258927902982144', '结果', 'SL_RESULT', 'SYS_SUCCESS_FAIL', '1', '2', '1', '', '1', 50);
INSERT INTO `sys_configure_search` VALUES ('52294048873971712', '52294046697127936', '学生', 'BS_NAME', '', '4', '1', '1', '', '1', 10);
INSERT INTO `sys_configure_search` VALUES ('52294048890748928', '52294046697127936', '学年', 'BAF_YEAR', '', '1', '4', '1', '', '1', 20);
INSERT INTO `sys_configure_search` VALUES ('52294049444397056', '52294046697127936', '奖励类型', 'BAF_AID_TYPE', 'BUS_COMMEND_TYPE', '1', '2', '1', '', '1', 40);

-- ----------------------------
-- Table structure for sys_dict_info
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_info`;
CREATE TABLE `sys_dict_info`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SDT_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字典主表ID',
  `SDT_CODE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `SDI_NAME` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典名称',
  `SDI_CODE` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `SDI_INNERCODE` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '连接代码',
  `SDI_PARENTID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '父ID',
  `SDI_REMARK` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `SDI_REQUIRED` int(5) NULL DEFAULT 0 COMMENT '是否必填',
  `SDI_ORDER` int(5) NULL DEFAULT NULL COMMENT '字典排序',
  `IS_STATUS` int(5) NULL DEFAULT NULL COMMENT '状态:0停用1启用',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SDT_CODE`(`SDT_CODE`) USING BTREE,
  INDEX `SDT_ID`(`SDT_ID`) USING BTREE,
  INDEX `SDI_CODE`(`SDI_CODE`) USING BTREE,
  CONSTRAINT `SDT_ID` FOREIGN KEY (`SDT_ID`) REFERENCES `sys_dict_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_info
-- ----------------------------
INSERT INTO `sys_dict_info` VALUES ('1', '1', 'SYS_ON_OFF', '启用', '1', '1', '0', NULL, 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('10', '3', 'SYS_SEARCH_METHOD', '小于等于', '6', 'lessThan', '0', '', 0, 6, 1);
INSERT INTO `sys_dict_info` VALUES ('11', '3', 'SYS_SEARCH_METHOD', '大于', '7', 'greater', '0', '', 0, 7, 1);
INSERT INTO `sys_dict_info` VALUES ('12', '3', 'SYS_SEARCH_METHOD', '大于等于', '8', 'greaterThan', '0', '', 0, 8, 1);
INSERT INTO `sys_dict_info` VALUES ('13', '4', 'SYS_BUTTON_TYPE', '顶部按钮', '0', '0', '0', '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('14', '4', 'SYS_BUTTON_TYPE', '列表按钮', '1', '1', '0', '', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('15', '5', 'SYS_BUTTON_CLASS', '默认', 'btn btn-default', 'btn btn-default', '0', '标准的按钮', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('16', '5', 'SYS_BUTTON_CLASS', '原始', 'btn btn-primary', 'btn btn-primary', '0', '提供额外的视觉效果，标识一组按钮中的原始动作', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('17', '5', 'SYS_BUTTON_CLASS', '信息', 'btn btn-info', 'btn btn-info', '0', ' 信息警告消息的上下文按钮', 0, 3, 1);
INSERT INTO `sys_dict_info` VALUES ('18', '5', 'SYS_BUTTON_CLASS', '成功', 'btn btn-success', 'btn btn-success', '0', '表示一个成功的或积极的动作', 0, 4, 1);
INSERT INTO `sys_dict_info` VALUES ('19', '5', 'SYS_BUTTON_CLASS', '警告', 'btn btn-warning', 'btn btn-warning', '0', '表示应谨慎采取的动作', 0, 5, 1);
INSERT INTO `sys_dict_info` VALUES ('2', '1', 'SYS_ON_OFF', '关闭', '0', '0', '0', NULL, 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('20', '5', 'SYS_BUTTON_CLASS', '危险', 'btn btn-danger', 'btn btn-danger', '0', '表示一个危险的或潜在的负面动作', 0, 6, 1);
INSERT INTO `sys_dict_info` VALUES ('21', '5', 'SYS_BUTTON_CLASS', '链接', 'btn btn-link', 'btn btn-link', '0', '并不强调是一个按钮，看起来像一个链接，但同时保持按钮的行为', 0, 7, 1);
INSERT INTO `sys_dict_info` VALUES ('21390992187850752', '21390918460375040', 'SYS_EMAIL_PROTOCOL', 'pop3', 'pop3', 'pop3', '0', '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('21391049700147200', '21390918460375040', 'SYS_EMAIL_PROTOCOL', 'smtp', 'smtp', 'smtp', '0', '', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('21401881397952512', '21390918460375040', 'SYS_EMAIL_PROTOCOL', 'imap', 'imap', 'imap', '0', '', 0, 3, 1);
INSERT INTO `sys_dict_info` VALUES ('23', '2', 'SYS_YES_NO', '是', '1', '1', '0', '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('23853711512043520', '23853626858405888', 'FILE_TEST', '测试1', 'test1', 'test1', '0', '', 1, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('23854618110853120', '23853626858405888', 'FILE_TEST', '测试2', 'test2', 'test2', '0', '', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('24', '2', 'SYS_YES_NO', '否', '0', '0', '0', '', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('25', '6', 'SYS_ALIGN', '居中', 'center', 'center', '0', '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('26', '6', 'SYS_ALIGN', '左对齐', 'left', 'left', '0', '', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('27', '6', 'SYS_ALIGN', '右对齐', 'right', 'right', '0', '', 0, 3, 1);
INSERT INTO `sys_dict_info` VALUES ('27191798979887104', '27191701793669120', 'SYS_STEP_TYPE', '角色', '1', '1', '0', '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('27191845347917824', '27191701793669120', 'SYS_STEP_TYPE', '人员', '2', '2', '0', '', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('27192219035238400', '27191919998140416', 'SYS_PROCESS_STATUS', '测试1', '1', '1', '0', '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('27192237062356992', '27191919998140416', 'SYS_PROCESS_STATUS', '测试2', '2', '2', '0', '', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('27192254380638208', '27191919998140416', 'SYS_PROCESS_STATUS', '测试3', '3', '3', '0', '', 0, 3, 1);
INSERT INTO `sys_dict_info` VALUES ('27192280456626176', '27191919998140416', 'SYS_PROCESS_STATUS', '测试4', '4', '4', '0', '', 0, 4, 1);
INSERT INTO `sys_dict_info` VALUES ('27636810712612864', '27191919998140416', 'SYS_PROCESS_STATUS', '启动人员', '0', '0', '0', '未提交', 0, 0, 1);
INSERT INTO `sys_dict_info` VALUES ('27637224036106240', '27191919998140416', 'SYS_PROCESS_STATUS', '审核通过', '999', '999', '0', '', 0, 999, 1);
INSERT INTO `sys_dict_info` VALUES ('27637452621479936', '27191919998140416', 'SYS_PROCESS_STATUS', '撤回/退回', '-1', '-1', '0', '', 0, -1, 1);
INSERT INTO `sys_dict_info` VALUES ('28', '7', 'SYS_ROLE_TYPE', '管理员', '1', '1', '0', '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('29', '8', 'SYS_SEARCH_TYPE', '文本', '1', '1', '0', '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('30', '8', 'SYS_SEARCH_TYPE', '单选', '2', '2', '0', '', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('32', '8', 'SYS_SEARCH_TYPE', '多选', '3', '3', '0', '', 0, 3, 1);
INSERT INTO `sys_dict_info` VALUES ('33', '8', 'SYS_SEARCH_TYPE', '年', '4', '4', '0', '', 0, 4, 1);
INSERT INTO `sys_dict_info` VALUES ('34', '8', 'SYS_SEARCH_TYPE', '年月日', '6', '6', '0', '', 0, 6, 1);
INSERT INTO `sys_dict_info` VALUES ('35', '8', 'SYS_SEARCH_TYPE', '年月日时分', '7', '7', '0', '', 0, 7, 1);
INSERT INTO `sys_dict_info` VALUES ('3546159557640192', '3546057401171968', 'SYS_OPERATOR_TYPE', '管理员', '1', '1', '0', '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('3546984086503424', '3546057401171968', 'SYS_OPERATOR_TYPE', '部门', '2', '2', '0', '', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('36', '8', 'SYS_SEARCH_TYPE', '年月', '5', '5', '0', '', 0, 5, 1);
INSERT INTO `sys_dict_info` VALUES ('48288267103109120', '7', 'SYS_ROLE_TYPE', '部门', '2', '2', '0', '', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('48288298015129600', '7', 'SYS_ROLE_TYPE', '系部', '3', '3', '0', '', 0, 3, 1);
INSERT INTO `sys_dict_info` VALUES ('48288347461779456', '7', 'SYS_ROLE_TYPE', '学生', '4', '4', '0', '', 0, 4, 1);
INSERT INTO `sys_dict_info` VALUES ('48528552202600448', '3546057401171968', 'SYS_OPERATOR_TYPE', '系部', '3', '3', '0', '', 0, 3, 1);
INSERT INTO `sys_dict_info` VALUES ('48528576848330752', '3546057401171968', 'SYS_OPERATOR_TYPE', '学生', '4', '4', '0', '', 0, 4, 1);
INSERT INTO `sys_dict_info` VALUES ('48528600491622400', '3546057401171968', 'SYS_OPERATOR_TYPE', '教师', '5', '5', '0', '', 0, 5, 1);
INSERT INTO `sys_dict_info` VALUES ('48528662064005120', '7', 'SYS_ROLE_TYPE', '教师', '5', '5', '0', '', 0, 5, 1);
INSERT INTO `sys_dict_info` VALUES ('48538751374196736', '48538671036497920', 'BUS_COLLEGE', '福安教学点', '1', '1', '0', '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('48538794378395648', '48538671036497920', 'BUS_COLLEGE', '厦门教学点', '2', '2', '0', '', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('48538826380935168', '48538671036497920', 'BUS_COLLEGE', '福州教学点', '3', '3', '0', '', 0, 3, 1);
INSERT INTO `sys_dict_info` VALUES ('48605894635683840', '48605817624068096', 'BUS_MAJOR', '福安教学点', '1', '1', '0', '', 0, 1, 0);
INSERT INTO `sys_dict_info` VALUES ('48605957755764736', '48605817624068096', 'BUS_MAJOR', '计算机应用', '1001', '1.1001', '48605894635683840', '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('48606029667106816', '48605817624068096', 'BUS_MAJOR', '计算机网络', '1002', '1.1002', '48605894635683840', '', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('48606661161517056', '48605817624068096', 'BUS_MAJOR', '计算机多媒体', '1003', '1.1003', '48605894635683840', '', 0, 3, 1);
INSERT INTO `sys_dict_info` VALUES ('48606718606704640', '48605817624068096', 'BUS_MAJOR', '福州教学点', '3', '3', '0', '', 0, 3, 0);
INSERT INTO `sys_dict_info` VALUES ('48606788513169408', '48605817624068096', 'BUS_MAJOR', '厦门教学点', '2', '2', '0', '', 0, 2, 0);
INSERT INTO `sys_dict_info` VALUES ('48606866032295936', '48605817624068096', 'BUS_MAJOR', '厦门1', '2005', '2.1', '48606788513169408', '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('48607617320222720', '48605817624068096', 'BUS_MAJOR', '福州1', '3001', '3.3001', '48606718606704640', '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('48887969481752576', '48887622830915584', 'BUS_SEX', '男', '1', '1', '0', '1', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('48887996593733632', '48887622830915584', 'BUS_SEX', '女', '0', '0', '0', '', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('48888183223484416', '48888141926367232', 'BUS_COLLEGE_LENGTH', '3年', '3', '3', '0', '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('48888219961393152', '48888141926367232', 'BUS_COLLEGE_LENGTH', '4年', '4', '4', '0', '', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('48888372382400512', '48887681748303872', 'BUS_NATION', '汉族', '1', '1', '0', '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('48888408021401600', '48887681748303872', 'BUS_NATION', '蒙古族', '2', '2', '0', '', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('48888446600609792', '48887681748303872', 'BUS_NATION', '回族', '3', '3', '0', '', 0, 3, 1);
INSERT INTO `sys_dict_info` VALUES ('48888483112026112', '48887681748303872', 'BUS_NATION', '藏族', '4', '4', '0', '', 0, 4, 1);
INSERT INTO `sys_dict_info` VALUES ('48888508462399488', '48887681748303872', 'BUS_NATION', '维吾尔族', '5', '5', '0', '', 0, 5, 1);
INSERT INTO `sys_dict_info` VALUES ('48888533871493120', '48887681748303872', 'BUS_NATION', '苗族', '6', '6', '0', '', 0, 6, 1);
INSERT INTO `sys_dict_info` VALUES ('48888599193583616', '48887681748303872', 'BUS_NATION', '彝族', '7', '7', '0', '', 0, 7, 1);
INSERT INTO `sys_dict_info` VALUES ('48888644433346560', '48887681748303872', 'BUS_NATION', '壮族', '8', '8', '0', '', 0, 8, 1);
INSERT INTO `sys_dict_info` VALUES ('48888666000457728', '48887681748303872', 'BUS_NATION', '布依族', '9', '9', '0', '', 0, 9, 1);
INSERT INTO `sys_dict_info` VALUES ('48888693720612864', '48887681748303872', 'BUS_NATION', '朝鲜族', '10', '10', '0', '', 0, 10, 1);
INSERT INTO `sys_dict_info` VALUES ('48888719578497024', '48887681748303872', 'BUS_NATION', '满族', '11', '11', '0', '', 0, 11, 1);
INSERT INTO `sys_dict_info` VALUES ('48888744853372928', '48887681748303872', 'BUS_NATION', '侗族', '12', '12', '0', '', 0, 12, 1);
INSERT INTO `sys_dict_info` VALUES ('48888773500469248', '48887681748303872', 'BUS_NATION', '瑶族', '13', '13', '0', '', 0, 13, 1);
INSERT INTO `sys_dict_info` VALUES ('48888798708236288', '48887681748303872', 'BUS_NATION', '白族', '14', '14', '0', '', 0, 14, 1);
INSERT INTO `sys_dict_info` VALUES ('48888827015593984', '48887681748303872', 'BUS_NATION', '土家族', '15', '15', '0', '', 0, 15, 1);
INSERT INTO `sys_dict_info` VALUES ('48888853762670592', '48887681748303872', 'BUS_NATION', '哈尼族', '16', '16', '0', '', 0, 16, 1);
INSERT INTO `sys_dict_info` VALUES ('48888883080855552', '48887681748303872', 'BUS_NATION', '哈萨克族', '17', '17', '0', '', 0, 17, 1);
INSERT INTO `sys_dict_info` VALUES ('48888907055497216', '48887681748303872', 'BUS_NATION', '傣族', '18', '18', '0', '', 0, 18, 1);
INSERT INTO `sys_dict_info` VALUES ('48888937590030336', '48887681748303872', 'BUS_NATION', '黎族', '19', '19', '0', '', 0, 19, 1);
INSERT INTO `sys_dict_info` VALUES ('48888977066819584', '48887681748303872', 'BUS_NATION', '僳僳族', '20', '20', '0', '', 0, 20, 1);
INSERT INTO `sys_dict_info` VALUES ('48889010289901568', '48887681748303872', 'BUS_NATION', '佤族', '21', '21', '0', '', 0, 21, 1);
INSERT INTO `sys_dict_info` VALUES ('48889033887055872', '48887681748303872', 'BUS_NATION', '畲族', '22', '22', '0', '', 0, 22, 1);
INSERT INTO `sys_dict_info` VALUES ('48889059736551424', '48887681748303872', 'BUS_NATION', '高山族', '23', '23', '0', '', 0, 23, 1);
INSERT INTO `sys_dict_info` VALUES ('48889082213826560', '48887681748303872', 'BUS_NATION', '拉祜族', '24', '24', '0', '', 0, 24, 1);
INSERT INTO `sys_dict_info` VALUES ('48889108436615168', '48887681748303872', 'BUS_NATION', '水族', '25', '25', '0', '', 0, 25, 1);
INSERT INTO `sys_dict_info` VALUES ('48889138950176768', '48887681748303872', 'BUS_NATION', '东乡族', '26', '26', '0', '', 0, 26, 1);
INSERT INTO `sys_dict_info` VALUES ('48889173075034112', '48887681748303872', 'BUS_NATION', '纳西族', '27', '27', '0', '', 0, 27, 1);
INSERT INTO `sys_dict_info` VALUES ('48889197821427712', '48887681748303872', 'BUS_NATION', '景颇族', '28', '28', '0', '', 0, 28, 1);
INSERT INTO `sys_dict_info` VALUES ('48889225981984768', '48887681748303872', 'BUS_NATION', '柯尔克孜族', '29', '29', '0', '', 0, 29, 1);
INSERT INTO `sys_dict_info` VALUES ('48889267581091840', '48887681748303872', 'BUS_NATION', '土族', '30', '30', '0', '', 0, 30, 1);
INSERT INTO `sys_dict_info` VALUES ('48889311541592064', '48887681748303872', 'BUS_NATION', '达斡尔族', '31', '31', '0', '', 0, 31, 1);
INSERT INTO `sys_dict_info` VALUES ('48889340905914368', '48887681748303872', 'BUS_NATION', '仫佬族', '32', '32', '0', '', 0, 32, 1);
INSERT INTO `sys_dict_info` VALUES ('48889375735414784', '48887681748303872', 'BUS_NATION', '羌族', '33', '33', '0', '', 0, 33, 1);
INSERT INTO `sys_dict_info` VALUES ('48889405468835840', '48887681748303872', 'BUS_NATION', '布朗族', '34', '34', '0', '', 0, 34, 1);
INSERT INTO `sys_dict_info` VALUES ('48889437341351936', '48887681748303872', 'BUS_NATION', '撒拉族', '35', '35', '0', '', 0, 35, 1);
INSERT INTO `sys_dict_info` VALUES ('48889461580234752', '48887681748303872', 'BUS_NATION', '毛南族', '36', '36', '0', '', 0, 36, 1);
INSERT INTO `sys_dict_info` VALUES ('48889485856866304', '48887681748303872', 'BUS_NATION', '仡佬族', '37', '37', '0', '', 0, 37, 1);
INSERT INTO `sys_dict_info` VALUES ('48889524222164992', '48887681748303872', 'BUS_NATION', '锡伯族', '38', '38', '0', '', 0, 38, 1);
INSERT INTO `sys_dict_info` VALUES ('48889556245676032', '48887681748303872', 'BUS_NATION', '阿昌族', '39', '39', '0', '', 0, 39, 1);
INSERT INTO `sys_dict_info` VALUES ('48889584775331840', '48887681748303872', 'BUS_NATION', '普米族', '40', '40', '0', '', 0, 40, 1);
INSERT INTO `sys_dict_info` VALUES ('48889612109611008', '48887681748303872', 'BUS_NATION', '塔吉克族', '41', '41', '0', '', 0, 41, 1);
INSERT INTO `sys_dict_info` VALUES ('48889644711936000', '48887681748303872', 'BUS_NATION', '怒族', '42', '42', '0', '', 0, 42, 1);
INSERT INTO `sys_dict_info` VALUES ('48889668137123840', '48887681748303872', 'BUS_NATION', '乌孜别克族', '43', '43', '0', '', 0, 43, 1);
INSERT INTO `sys_dict_info` VALUES ('48889715574702080', '48887681748303872', 'BUS_NATION', '俄罗斯族', '44', '44', '0', '', 0, 44, 1);
INSERT INTO `sys_dict_info` VALUES ('48889785925763072', '48887681748303872', 'BUS_NATION', '鄂温克族', '45', '45', '0', '', 0, 45, 1);
INSERT INTO `sys_dict_info` VALUES ('48889826266578944', '48887681748303872', 'BUS_NATION', '德昂族', '46', '46', '0', '', 0, 46, 1);
INSERT INTO `sys_dict_info` VALUES ('48889865885974528', '48887681748303872', 'BUS_NATION', '保安族', '47', '47', '0', '', 0, 47, 1);
INSERT INTO `sys_dict_info` VALUES ('48889902607106048', '48887681748303872', 'BUS_NATION', '裕固族', '48', '48', '0', '', 0, 48, 1);
INSERT INTO `sys_dict_info` VALUES ('48889934232158208', '48887681748303872', 'BUS_NATION', '京族', '49', '49', '0', '', 0, 49, 1);
INSERT INTO `sys_dict_info` VALUES ('48889965408419840', '48887681748303872', 'BUS_NATION', '塔塔尔族', '50', '50', '0', '', 0, 50, 1);
INSERT INTO `sys_dict_info` VALUES ('48889999852044288', '48887681748303872', 'BUS_NATION', '独龙族', '51', '51', '0', '', 0, 51, 1);
INSERT INTO `sys_dict_info` VALUES ('48890032630530048', '48887681748303872', 'BUS_NATION', '鄂伦春族', '52', '52', '0', '', 0, 52, 1);
INSERT INTO `sys_dict_info` VALUES ('48890060250021888', '48887681748303872', 'BUS_NATION', '赫哲族', '53', '53', '0', '', 0, 53, 1);
INSERT INTO `sys_dict_info` VALUES ('48890091363368960', '48887681748303872', 'BUS_NATION', '门巴族', '54', '54', '0', '', 0, 54, 1);
INSERT INTO `sys_dict_info` VALUES ('48890125840547840', '48887681748303872', 'BUS_NATION', '珞巴族', '55', '55', '0', '', 0, 55, 1);
INSERT INTO `sys_dict_info` VALUES ('48890164021297152', '48887681748303872', 'BUS_NATION', '基诺族', '56', '56', '0', '', 0, 56, 1);
INSERT INTO `sys_dict_info` VALUES ('49270789383389184', '9', 'SYS_PROCESS_TYPE', '测试流程', '1001', '1001', '0', '', 0, 999, 1);
INSERT INTO `sys_dict_info` VALUES ('49270878021615616', '9', 'SYS_PROCESS_TYPE', '测试流程2', '2001', '1001.2001', '49270789383389184', '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('49301852625305600', '9', 'SYS_PROCESS_TYPE', '测试流程3', '2002', '1001.2002', '49270789383389184', '', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('49302304356040704', '9', 'SYS_PROCESS_TYPE', '测试2.1', '2003', '1002.2003', '49301917020454912', '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('49377568205307904', '49377509363417088', 'BUS_SEMESTER', '上学期', '1', '1', '0', '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('49377596051292160', '49377509363417088', 'BUS_SEMESTER', '下学期', '2', '2', '0', '', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('49615488942080000', '49615033952370688', 'BUS_PUNISHMENT', '记过', '1', '1', '0', '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('49615522332934144', '49615033952370688', 'BUS_PUNISHMENT', '警告', '2', '2', '0', '', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('49615554708766720', '49615033952370688', 'BUS_PUNISHMENT', '留校查看', '3', '3', '0', '', 0, 3, 1);
INSERT INTO `sys_dict_info` VALUES ('49615584148586496', '49615033952370688', 'BUS_PUNISHMENT', '开除', '4', '4', '0', '', 0, 4, 1);
INSERT INTO `sys_dict_info` VALUES ('49615720119533568', '49615343454257152', 'BUS_FILE_DEFAULT', '附件', 'DEFAULT', 'DEFAULT', '0', '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('5', '3', 'SYS_SEARCH_METHOD', '等于', '1', 'eq', '0', NULL, 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('50790095971680256', '50790022462308352', 'BUS_AID_FINANCIALLY_TYPE', '绿色通道', '1', '1', '0', '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('50790130008457216', '50790022462308352', 'BUS_AID_FINANCIALLY_TYPE', '国家奖学金', '2', '2', '0', '', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('50790166444376064', '50790022462308352', 'BUS_AID_FINANCIALLY_TYPE', '国家励志奖学金', '3', '3', '0', '', 0, 3, 1);
INSERT INTO `sys_dict_info` VALUES ('50790205401071616', '50790022462308352', 'BUS_AID_FINANCIALLY_TYPE', '国家助学金', '4', '4', '0', '', 0, 4, 1);
INSERT INTO `sys_dict_info` VALUES ('50790243997057024', '50790022462308352', 'BUS_AID_FINANCIALLY_TYPE', '助学贷款', '5', '5', '0', '', 0, 5, 1);
INSERT INTO `sys_dict_info` VALUES ('50790276431609856', '50790022462308352', 'BUS_AID_FINANCIALLY_TYPE', '服兵役学费补助', '6', '6', '0', '', 0, 6, 1);
INSERT INTO `sys_dict_info` VALUES ('50790302960582656', '50790022462308352', 'BUS_AID_FINANCIALLY_TYPE', '减免学费', '7', '7', '0', '', 0, 7, 1);
INSERT INTO `sys_dict_info` VALUES ('50790367791939584', '50790022462308352', 'BUS_AID_FINANCIALLY_TYPE', '勤工助学', '8', '8', '0', '', 0, 8, 1);
INSERT INTO `sys_dict_info` VALUES ('50790397001072640', '50790022462308352', 'BUS_AID_FINANCIALLY_TYPE', '学校奖学金', '9', '9', '0', '', 0, 9, 1);
INSERT INTO `sys_dict_info` VALUES ('50790437622906880', '50790022462308352', 'BUS_AID_FINANCIALLY_TYPE', '年度表彰', '10', '10', '0', '', 0, 10, 1);
INSERT INTO `sys_dict_info` VALUES ('50790472951529472', '50790022462308352', 'BUS_AID_FINANCIALLY_TYPE', '困难毕业生就业补助', '11', '11', '0', '', 0, 11, 1);
INSERT INTO `sys_dict_info` VALUES ('50790583232364544', '50790022462308352', 'BUS_AID_FINANCIALLY_TYPE', '应急救助', '13', '13', '0', '', 0, 13, 1);
INSERT INTO `sys_dict_info` VALUES ('50790618569375744', '50790022462308352', 'BUS_AID_FINANCIALLY_TYPE', '中职助学金', '14', '14', '0', '', 0, 14, 1);
INSERT INTO `sys_dict_info` VALUES ('50796267739021312', '50796082694717440', 'BUS_COLLEGE_SCHOLARSHIP_TYPE', '一等奖学金', 'FIRST-CLASS', 'FIRST-CLASS', '0', '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('50796380301557760', '50796082694717440', 'BUS_COLLEGE_SCHOLARSHIP_TYPE', '二等奖学金', 'SECOND-CLASS', 'SECOND-CLASS', '0', '', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('50796718186299392', '50796082694717440', 'BUS_COLLEGE_SCHOLARSHIP_TYPE', '三等奖学金', 'THIRD-CLASS', 'THIRD-CLASS', '0', '', 0, 3, 1);
INSERT INTO `sys_dict_info` VALUES ('50802464470859776', '9', 'SYS_PROCESS_TYPE', '资助管理', '100', '100', '0', '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('50802594620112896', '9', 'SYS_PROCESS_TYPE', '学校奖学金', '109', '100.109', '50802464470859776', '', 0, 9, 1);
INSERT INTO `sys_dict_info` VALUES ('50804677247238144', '9', 'SYS_PROCESS_TYPE', '年度表彰', '110', '100.110', '50802464470859776', '', 0, 10, 1);
INSERT INTO `sys_dict_info` VALUES ('50839345229201408', '27191919998140416', 'SYS_PROCESS_STATUS', '学生处', '99', '99', '0', '', 0, 99, 1);
INSERT INTO `sys_dict_info` VALUES ('52229765242814464', '10', 'SYS_SUCCESS_FAIL', '成功', '1', '1', '0', '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('52229795525689344', '10', 'SYS_SUCCESS_FAIL', '失败', '0', '0', '0', '', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('52291671479549952', '52291506974752768', 'BUS_COMMEND_TYPE', '三好学生', 'THREE_GOOD_STUDENTS', 'THREE_GOOD_STUDENTS', '0', '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('52291791042379776', '52291506974752768', 'BUS_COMMEND_TYPE', '优秀学生干部', 'OUTSTANDING_STUDENT_CADRES', 'OUTSTANDING_STUDENT_CADRES', '0', '', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('52506154542039040', '27191919998140416', 'SYS_PROCESS_STATUS', '辅导员', '50', '50', '0', '', 0, 50, 1);
INSERT INTO `sys_dict_info` VALUES ('52506480846307328', '27191919998140416', 'SYS_PROCESS_STATUS', '系部管理员', '51', '51', '0', '', 0, 51, 1);
INSERT INTO `sys_dict_info` VALUES ('6', '3', 'SYS_SEARCH_METHOD', '不等于', '2', 'ne', '0', '', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('7', '3', 'SYS_SEARCH_METHOD', '在其中', '3', 'in', '0', '', 0, 3, 1);
INSERT INTO `sys_dict_info` VALUES ('8', '3', 'SYS_SEARCH_METHOD', '模糊', '4', 'like', '0', '', 0, 4, 1);
INSERT INTO `sys_dict_info` VALUES ('9', '3', 'SYS_SEARCH_METHOD', '小于', '5', 'less', '0', '', 0, 5, 1);

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SDT_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典名称',
  `SDT_CODE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典编码',
  `SDT_ROLE_DOWN` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件拥有权限下载角色',
  `SDT_ROLE_DEL` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件拥有权限删除角色',
  `IS_STATUS` int(5) NULL DEFAULT NULL COMMENT '状态:0停用1启用',
  `IS_HIDDEN` int(5) NULL DEFAULT 0 COMMENT '是否隐藏',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES ('1', '系统_启用-关闭', 'SYS_ON_OFF', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('10', '系统_成功失败', 'SYS_SUCCESS_FAIL', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('2', '系统_是_否', 'SYS_YES_NO', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('21390918460375040', '系统_邮件协议', 'SYS_EMAIL_PROTOCOL', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('23853626858405888', '文件-测试', 'FILE_TEST', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('27191701793669120', '流程_办理状态', 'SYS_STEP_TYPE', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('27191919998140416', '流程_流程状态', 'SYS_PROCESS_STATUS', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('3', '系统_查询条件', 'SYS_SEARCH_METHOD', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('3546057401171968', '系统_用户类型', 'SYS_OPERATOR_TYPE', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('4', '系统_按钮类型', 'SYS_BUTTON_TYPE', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('48538671036497920', '业务_院系', 'BUS_COLLEGE', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('48605817624068096', '业务_专业', 'BUS_MAJOR', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('48887622830915584', '业务_性别', 'BUS_SEX', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('48887681748303872', '业务_民族', 'BUS_NATION', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('48888141926367232', '业务_学制', 'BUS_COLLEGE_LENGTH', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('49377509363417088', '业务_学期', 'BUS_SEMESTER', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('49615033952370688', '业务_处分类型', 'BUS_PUNISHMENT', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('49615343454257152', '业务_文件（默认）', 'BUS_FILE_DEFAULT', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('5', '系统_按钮样式', 'SYS_BUTTON_CLASS', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('50790022462308352', '业务_资助类型', 'BUS_AID_FINANCIALLY_TYPE', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('50796082694717440', '业务_学院奖学金类型', 'BUS_COLLEGE_SCHOLARSHIP_TYPE', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('52291506974752768', '业务_年度表彰类型', 'BUS_COMMEND_TYPE', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('6', '系统_对齐方式', 'SYS_ALIGN', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('7', '系统_角色类型', 'SYS_ROLE_TYPE', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('8', '系统_搜索类型', 'SYS_SEARCH_TYPE', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('9', '系统_流程定义', 'SYS_PROCESS_TYPE', NULL, NULL, 1, 0);

-- ----------------------------
-- Table structure for sys_file
-- ----------------------------
DROP TABLE IF EXISTS `sys_file`;
CREATE TABLE `sys_file`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SO_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `SF_TABLE_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '各表主键ID',
  `SF_TABLE_NAME` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '表名',
  `SF_SDT_CODE` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典代码',
  `SF_SDI_CODE` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典子代码',
  `SF_ORIGINAL_NAME` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件原始名称',
  `SF_NAME` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件保存名称',
  `SF_PATH` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件保存路径',
  `SF_SUFFIX` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件后缀名',
  `SF_SIZE` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件大小',
  `SF_SEE_TYPE` int(5) NULL DEFAULT 1 COMMENT '是否可以不用登录查看',
  `SF_ENTRY_TIME` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SF_TABLE_ID_NAME`(`SF_TABLE_ID`, `SF_TABLE_NAME`) USING BTREE,
  INDEX `SF_SDI_CODE`(`SF_TABLE_ID`, `SF_TABLE_NAME`, `SF_SDI_CODE`, `SF_SDT_CODE`) USING BTREE,
  INDEX `SO_ID`(`SO_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_file
-- ----------------------------
INSERT INTO `sys_file` VALUES ('24333612232998912', '1', '123456', 'SYS_FILE', 'FILE_TEST', 'test1', 'bg3.jpeg', '24333612232998912', 'file/2018-05-31/', 'jpeg', '272948', 1, '2018-05-31 19:46:58');
INSERT INTO `sys_file` VALUES ('24556195545088000', '1', '123456', 'SYS_FILE', 'FILE_TEST', 'test1', '大字段.xlsx', '24556195545088000', 'file/2018-06-01/', 'xlsx', '20433', 1, '2018-06-01 10:31:22');
INSERT INTO `sys_file` VALUES ('24556195545088001', '1', '123456', 'SYS_FILE', 'FILE_TEST', 'test1', '12.pptx', '24556195545088001', 'file/2018-06-01/', 'pptx', '1869015', 1, '2018-06-01 10:31:23');
INSERT INTO `sys_file` VALUES ('24556196404920320', '1', '123456', 'SYS_FILE', 'FILE_TEST', 'test1', '新系统漏洞.doc', '24556196404920320', 'file/2018-06-01/', 'doc', '3731456', 1, '2018-06-01 10:31:23');
INSERT INTO `sys_file` VALUES ('24562004152811520', '1', '123456', 'SYS_FILE', 'FILE_TEST', 'test2', '1.png', '24562004152811520', 'file/2018-06-01/', 'png', '1833330', 1, '2018-06-01 10:54:28');
INSERT INTO `sys_file` VALUES ('33362560342294528', '1', '123456', 'SYS_FILE', 'FILE_TEST', 'test1', '流程步骤控制.doc', '33362560342294528', 'file/2018-06-25/', 'doc', '120949', 1, '2018-06-25 17:44:43');
INSERT INTO `sys_file` VALUES ('33362752571441152', '1', '123456', 'SYS_FILE', 'FILE_TEST', 'test1', '流程步骤控制.doc', '33362752571441152', 'file/2018-06-25/', 'doc', '120949', 1, '2018-06-25 17:45:29');
INSERT INTO `sys_file` VALUES ('49746794988437504', '1', '49746696170635264', 'BUS_STUDENT_PUNISHMENT', 'BUS_FILE_DEFAULT', 'DEFAULT', 'timg.jpg', '49746794988437504', 'punishment/2018-08-09/', 'jpg', '30046', 1, '2018-08-09 22:49:51');
INSERT INTO `sys_file` VALUES ('49754111855296512', '1', '1', 'BUS_STUDENT_PUNISHMENT', 'BUS_FILE_DEFAULT', 'DEFAULT', 'u=635704053,1460945271&fm=27&gp=0.jpg', '49754111855296512', 'punishment/2018-08-09/', 'jpg', '29754', 1, '2018-08-09 23:18:54');
INSERT INTO `sys_file` VALUES ('49773713242980352', '1', '1', 'BUS_STUDENT_PUNISHMENT', 'BUS_FILE_DEFAULT', 'DEFAULT', 'timg.jpg', '49773713242980352', 'punishment/2018-08-10/', 'jpg', '30046', 1, '2018-08-10 00:36:47');

-- ----------------------------
-- Table structure for sys_format
-- ----------------------------
DROP TABLE IF EXISTS `sys_format`;
CREATE TABLE `sys_format`  (
  `ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `SF_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '名称',
  `SF_CODE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '唯一标识',
  `SF_YEAR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '配置年度',
  `SF_ENTRY_TIME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE INDEX `SF_CODE`(`SF_CODE`) USING BTREE,
  INDEX `ID`(`ID`) USING BTREE,
  INDEX `ID_2`(`ID`) USING BTREE,
  INDEX `ID_3`(`ID`) USING BTREE,
  INDEX `ID_4`(`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_format
-- ----------------------------
INSERT INTO `sys_format` VALUES ('26573352437022720', '流程定义', 'SYS_PROCESS_DEFINITION', '2018', '2018-06-07 00:06:50');

-- ----------------------------
-- Table structure for sys_format_detail
-- ----------------------------
DROP TABLE IF EXISTS `sys_format_detail`;
CREATE TABLE `sys_format_detail`  (
  `ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `SF_ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '格式表ID',
  `SM_ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜单表ID',
  `SFD_PARENT_ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '父类菜单',
  `SFD_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '名称',
  `SFD_ORDER` int(5) NULL DEFAULT NULL COMMENT '排序',
  `IS_STATUS` int(5) NULL DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SFD_SF_ID`(`SF_ID`) USING BTREE,
  CONSTRAINT `SFD_SF_ID` FOREIGN KEY (`SF_ID`) REFERENCES `sys_format` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_format_detail
-- ----------------------------
INSERT INTO `sys_format_detail` VALUES ('26579144556937216', '26573352437022720', '26845813934129152', '0', '流程定义', 1, 1);
INSERT INTO `sys_format_detail` VALUES ('26716322922496000', '26573352437022720', '26714856669315072', '0', '流程步骤', 2, 1);
INSERT INTO `sys_format_detail` VALUES ('26717060805427200', '26573352437022720', '26715728707059712', '0', '流程启动角色', 3, 1);

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SO_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户表主键',
  `SL_NAME` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日志标题',
  `SL_EVENT` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作事件',
  `SL_IP` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作IP',
  `SL_RESULT` int(1) NULL DEFAULT NULL COMMENT '日志操作结果 0 失败 1成功',
  `SL_ENTERTIME` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '录入时间',
  `SL_TYPE` int(1) NULL DEFAULT NULL COMMENT '日志类型 0查看日志 1系统运行日志2用户操作日志9用户个人日志',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SL_TYPE`(`SL_TYPE`) USING BTREE,
  INDEX `SL_RESULT`(`SL_RESULT`) USING BTREE,
  INDEX `SL_ENTERTIME`(`SL_ENTERTIME`) USING BTREE,
  INDEX `SO_ID`(`SO_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES ('52238654378082304', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 19:51:35', 2);
INSERT INTO `sys_log` VALUES ('52238674477187072', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 19:51:39', 2);
INSERT INTO `sys_log` VALUES ('52238761257336832', '1', NULL, 'SQL运行错误', '0:0:0:0:0:0:0:1', 0, '2018-08-16 19:52:00', 1);
INSERT INTO `sys_log` VALUES ('52238812784361472', '1', NULL, 'SQL运行错误', '0:0:0:0:0:0:0:1', 0, '2018-08-16 19:52:12', 1);
INSERT INTO `sys_log` VALUES ('52238844237447168', '1', NULL, '修改配置列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 19:52:20', 2);
INSERT INTO `sys_log` VALUES ('52239092649295872', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 19:53:19', 2);
INSERT INTO `sys_log` VALUES ('52239097166561280', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 19:53:20', 2);
INSERT INTO `sys_log` VALUES ('52239100517810176', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 19:53:21', 2);
INSERT INTO `sys_log` VALUES ('52239115353063424', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 19:53:25', 2);
INSERT INTO `sys_log` VALUES ('52239118289076224', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 19:53:25', 2);
INSERT INTO `sys_log` VALUES ('52239120545611776', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 19:53:26', 2);
INSERT INTO `sys_log` VALUES ('52239122512740352', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 19:53:26', 2);
INSERT INTO `sys_log` VALUES ('52239127357161472', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 19:53:27', 2);
INSERT INTO `sys_log` VALUES ('52239157828780032', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 19:53:35', 2);
INSERT INTO `sys_log` VALUES ('52239400410546176', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 19:54:33', 2);
INSERT INTO `sys_log` VALUES ('52239403526914048', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 19:54:33', 2);
INSERT INTO `sys_log` VALUES ('52239475614416896', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 19:54:50', 2);
INSERT INTO `sys_log` VALUES ('52239508036386816', '1', NULL, '登录', '0:0:0:0:0:0:0:1', 0, '2018-08-16 19:54:58', 9);
INSERT INTO `sys_log` VALUES ('52239525837012992', '1', NULL, '登录', '0:0:0:0:0:0:0:1', 0, '2018-08-16 19:55:02', 9);
INSERT INTO `sys_log` VALUES ('52239548918267904', '1', NULL, '登录', '0:0:0:0:0:0:0:1', 1, '2018-08-16 19:55:08', 9);
INSERT INTO `sys_log` VALUES ('52241867001036800', '1', NULL, '登录', '0:0:0:0:0:0:0:1', 1, '2018-08-16 20:04:21', 9);
INSERT INTO `sys_log` VALUES ('52245157851955200', '1', NULL, '登录', '0:0:0:0:0:0:0:1', 1, '2018-08-16 20:17:25', 9);
INSERT INTO `sys_log` VALUES ('52245580495192064', '1', NULL, '登录', '0:0:0:0:0:0:0:1', 1, '2018-08-16 20:19:06', 9);
INSERT INTO `sys_log` VALUES ('52245909076967424', '1', NULL, '登录', '0:0:0:0:0:0:0:1', 1, '2018-08-16 20:20:24', 9);
INSERT INTO `sys_log` VALUES ('52246330759708672', '1', NULL, '登录', '0:0:0:0:0:0:0:1', 1, '2018-08-16 20:22:05', 9);
INSERT INTO `sys_log` VALUES ('52246986690134016', '1', NULL, '登录', '0:0:0:0:0:0:0:1', 1, '2018-08-16 20:24:41', 9);
INSERT INTO `sys_log` VALUES ('52256067224076288', '1', NULL, '登录', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:00:46', 1);
INSERT INTO `sys_log` VALUES ('52257353143156736', '1', NULL, '登录', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:05:53', 9);
INSERT INTO `sys_log` VALUES ('52257408193396736', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:06:06', 2);
INSERT INTO `sys_log` VALUES ('52257502158389248', '1', NULL, '登录', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:06:28', 9);
INSERT INTO `sys_log` VALUES ('52257537667366912', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:06:37', 2);
INSERT INTO `sys_log` VALUES ('52257547968577536', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:06:39', 2);
INSERT INTO `sys_log` VALUES ('52257556722089984', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:06:41', 2);
INSERT INTO `sys_log` VALUES ('52257559997841408', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:06:42', 2);
INSERT INTO `sys_log` VALUES ('52257562506035200', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:06:43', 2);
INSERT INTO `sys_log` VALUES ('52257564515106816', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:06:43', 2);
INSERT INTO `sys_log` VALUES ('52257567207849984', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:06:44', 2);
INSERT INTO `sys_log` VALUES ('52257604075782144', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:06:53', 2);
INSERT INTO `sys_log` VALUES ('52258023346798592', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:08:33', -1);
INSERT INTO `sys_log` VALUES ('52258026593189888', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:08:33', -1);
INSERT INTO `sys_log` VALUES ('52258028883279872', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:08:34', -1);
INSERT INTO `sys_log` VALUES ('52258030758133760', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:08:34', -1);
INSERT INTO `sys_log` VALUES ('52258033828364288', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:08:35', -1);
INSERT INTO `sys_log` VALUES ('52258035950682112', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:08:36', -1);
INSERT INTO `sys_log` VALUES ('52258091210637312', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:08:49', -1);
INSERT INTO `sys_log` VALUES ('52258198198943744', '1', NULL, '登录', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:09:14', 9);
INSERT INTO `sys_log` VALUES ('52258208105889792', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:09:17', -1);
INSERT INTO `sys_log` VALUES ('52258212564434944', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:09:18', -1);
INSERT INTO `sys_log` VALUES ('52258218180608000', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:09:19', -1);
INSERT INTO `sys_log` VALUES ('52258232600625152', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:09:22', -1);
INSERT INTO `sys_log` VALUES ('52258234672611328', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:09:23', -1);
INSERT INTO `sys_log` VALUES ('52258276473044992', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:09:33', -1);
INSERT INTO `sys_log` VALUES ('52258290767233024', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:09:36', -1);
INSERT INTO `sys_log` VALUES ('52258298186956800', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:09:38', -1);
INSERT INTO `sys_log` VALUES ('52258670444019712', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:11:07', -1);
INSERT INTO `sys_log` VALUES ('52258673547804672', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:11:08', -1);
INSERT INTO `sys_log` VALUES ('52258676433485824', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:11:08', -1);
INSERT INTO `sys_log` VALUES ('52258679545659392', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:11:09', -1);
INSERT INTO `sys_log` VALUES ('52258684079702016', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:11:10', -1);
INSERT INTO `sys_log` VALUES ('52258686189436928', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:11:11', -1);
INSERT INTO `sys_log` VALUES ('52258690614427648', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:11:12', -1);
INSERT INTO `sys_log` VALUES ('52258692300537856', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:11:12', -1);
INSERT INTO `sys_log` VALUES ('52258695903444992', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:11:13', -1);
INSERT INTO `sys_log` VALUES ('52258697409200128', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:11:13', -1);
INSERT INTO `sys_log` VALUES ('52258698738794496', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:11:14', -1);
INSERT INTO `sys_log` VALUES ('52258700018057216', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:11:14', -1);
INSERT INTO `sys_log` VALUES ('52258701066633216', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:11:14', -1);
INSERT INTO `sys_log` VALUES ('52258702454947840', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:11:14', -1);
INSERT INTO `sys_log` VALUES ('52258703646130176', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:11:15', -1);
INSERT INTO `sys_log` VALUES ('52258704866672640', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:11:15', -1);
INSERT INTO `sys_log` VALUES ('52258706011717632', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:11:15', -1);
INSERT INTO `sys_log` VALUES ('52258707148374016', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:11:16', -1);
INSERT INTO `sys_log` VALUES ('52258708171784192', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:11:16', -1);
INSERT INTO `sys_log` VALUES ('52258709270691840', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:11:16', -1);
INSERT INTO `sys_log` VALUES ('52258710482845696', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:11:16', -1);
INSERT INTO `sys_log` VALUES ('52258721283178496', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:11:19', -1);
INSERT INTO `sys_log` VALUES ('52258756196564992', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:11:27', -1);
INSERT INTO `sys_log` VALUES ('52258940464922624', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:12:11', -1);
INSERT INTO `sys_log` VALUES ('52259177497624576', '1', NULL, '修改菜单', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:13:08', 2);
INSERT INTO `sys_log` VALUES ('52259250361073664', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:13:25', -1);
INSERT INTO `sys_log` VALUES ('52259253989146624', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:13:26', -1);
INSERT INTO `sys_log` VALUES ('52259312415801344', '1', NULL, '设置角色菜单权限', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:13:40', 2);
INSERT INTO `sys_log` VALUES ('52259341331333120', '1', NULL, '登录', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:13:47', 9);
INSERT INTO `sys_log` VALUES ('52259352983109632', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:13:50', -1);
INSERT INTO `sys_log` VALUES ('52259375733014528', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:13:55', -1);
INSERT INTO `sys_log` VALUES ('52259376550903808', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:13:55', -1);
INSERT INTO `sys_log` VALUES ('52259382519398400', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:13:57', -1);
INSERT INTO `sys_log` VALUES ('52259384717213696', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:13:57', -1);
INSERT INTO `sys_log` VALUES ('52259390362746880', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:13:59', -1);
INSERT INTO `sys_log` VALUES ('52259455437373440', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:14:14', -1);
INSERT INTO `sys_log` VALUES ('52259822682243072', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:15:42', 0);
INSERT INTO `sys_log` VALUES ('52259829669953536', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:15:43', 0);
INSERT INTO `sys_log` VALUES ('52259836741550080', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:15:45', 0);
INSERT INTO `sys_log` VALUES ('52259849941024768', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:15:48', 0);
INSERT INTO `sys_log` VALUES ('52260530039029760', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:18:30', 0);
INSERT INTO `sys_log` VALUES ('52260547126624256', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:18:34', 0);
INSERT INTO `sys_log` VALUES ('52260557918568448', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:18:37', 0);
INSERT INTO `sys_log` VALUES ('52260565082439680', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:18:39', 0);
INSERT INTO `sys_log` VALUES ('52260743982088192', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:19:21', 0);
INSERT INTO `sys_log` VALUES ('52260757672296448', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 21:19:24', 0);
INSERT INTO `sys_log` VALUES ('52290346398253056', '1', NULL, '登录', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:16:59', 9);
INSERT INTO `sys_log` VALUES ('52291445486256128', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:21:21', 0);
INSERT INTO `sys_log` VALUES ('52291507297714176', '1', NULL, '添加字典', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:21:36', 2);
INSERT INTO `sys_log` VALUES ('52291552529088512', '1', NULL, '修改字典', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:21:47', 2);
INSERT INTO `sys_log` VALUES ('52291558048792576', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:21:48', 0);
INSERT INTO `sys_log` VALUES ('52291672024809472', '1', NULL, '添加字典信息', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:22:15', 2);
INSERT INTO `sys_log` VALUES ('52291791386312704', '1', NULL, '添加字典信息', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:22:44', 2);
INSERT INTO `sys_log` VALUES ('52291860869152768', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:23:00', 0);
INSERT INTO `sys_log` VALUES ('52292519278411776', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:25:37', 0);
INSERT INTO `sys_log` VALUES ('52292623251013632', '1', NULL, '拷贝配置列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:26:02', 2);
INSERT INTO `sys_log` VALUES ('52292674291499008', '1', NULL, '修改配置列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:26:14', 2);
INSERT INTO `sys_log` VALUES ('52292915858243584', '1', NULL, '修改配置列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:27:12', 2);
INSERT INTO `sys_log` VALUES ('52292925345759232', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:27:14', 0);
INSERT INTO `sys_log` VALUES ('52292962268217344', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:27:23', 0);
INSERT INTO `sys_log` VALUES ('52292967968276480', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:27:24', 0);
INSERT INTO `sys_log` VALUES ('52292972154191872', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:27:25', 0);
INSERT INTO `sys_log` VALUES ('52292978554699776', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:27:27', 0);
INSERT INTO `sys_log` VALUES ('52293039187558400', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:27:41', 0);
INSERT INTO `sys_log` VALUES ('52293066916102144', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:27:48', 0);
INSERT INTO `sys_log` VALUES ('52293399218225152', '1', NULL, '添加配置列表列', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:29:07', 2);
INSERT INTO `sys_log` VALUES ('52293408647020544', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:29:09', 0);
INSERT INTO `sys_log` VALUES ('52293587353731072', '1', NULL, '修改配置列表列', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:29:52', 2);
INSERT INTO `sys_log` VALUES ('52293648112418816', '1', NULL, '修改配置列表列', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:30:06', 2);
INSERT INTO `sys_log` VALUES ('52293666340864000', '1', NULL, '修改配置列表列', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:30:11', 2);
INSERT INTO `sys_log` VALUES ('52293682132418560', '1', NULL, '修改配置列表列', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:30:14', 2);
INSERT INTO `sys_log` VALUES ('52293697173192704', '1', NULL, '修改配置列表列', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:30:18', 2);
INSERT INTO `sys_log` VALUES ('52293723018493952', '1', NULL, '修改配置列表列', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:30:24', 2);
INSERT INTO `sys_log` VALUES ('52293788365750272', '1', NULL, '修改配置列表列', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:30:40', 2);
INSERT INTO `sys_log` VALUES ('52293842489049088', '1', NULL, '修改配置列表列', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:30:53', 2);
INSERT INTO `sys_log` VALUES ('52293868653117440', '1', NULL, '修改配置列表列', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:30:59', 2);
INSERT INTO `sys_log` VALUES ('52293887267438592', '1', NULL, '修改配置列表列', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:31:03', 2);
INSERT INTO `sys_log` VALUES ('52293950215553024', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:31:18', 0);
INSERT INTO `sys_log` VALUES ('52293968083288064', '1', NULL, '删除配置列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:31:22', 2);
INSERT INTO `sys_log` VALUES ('52294050031599616', '1', NULL, '拷贝配置列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:31:42', 2);
INSERT INTO `sys_log` VALUES ('52294055748435968', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:31:43', 0);
INSERT INTO `sys_log` VALUES ('52294130881003520', '1', NULL, '修改配置列表列', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:32:01', 2);
INSERT INTO `sys_log` VALUES ('52294137977765888', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:32:03', 0);
INSERT INTO `sys_log` VALUES ('52294144411828224', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:32:05', 0);
INSERT INTO `sys_log` VALUES ('52294173566435328', '1', NULL, '修改配置列表搜索', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:32:11', 2);
INSERT INTO `sys_log` VALUES ('52294177827848192', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:32:12', 0);
INSERT INTO `sys_log` VALUES ('52294185872523264', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:32:14', 0);
INSERT INTO `sys_log` VALUES ('52294281687203840', '1', NULL, '拷贝菜单', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:32:37', 2);
INSERT INTO `sys_log` VALUES ('52294433558757376', '1', NULL, '修改菜单', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:33:13', 2);
INSERT INTO `sys_log` VALUES ('52297608307146752', '1', NULL, '修改菜单', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:45:50', 2);
INSERT INTO `sys_log` VALUES ('52297665085440000', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:46:04', 0);
INSERT INTO `sys_log` VALUES ('52297784396611584', '1', NULL, '拷贝流程定义', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:46:32', 2);
INSERT INTO `sys_log` VALUES ('52297820446654464', '1', NULL, '修改流程定义', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:46:41', 2);
INSERT INTO `sys_log` VALUES ('52297857218117632', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:46:50', 0);
INSERT INTO `sys_log` VALUES ('52297885416423424', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:46:56', 0);
INSERT INTO `sys_log` VALUES ('52297988646633472', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:47:21', 0);
INSERT INTO `sys_log` VALUES ('52298034754617344', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:47:32', 0);
INSERT INTO `sys_log` VALUES ('52298207480250368', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:48:13', 0);
INSERT INTO `sys_log` VALUES ('52298323893157888', '1', NULL, '修改配置列表搜索', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:48:41', 2);
INSERT INTO `sys_log` VALUES ('52298331241578496', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:48:43', 0);
INSERT INTO `sys_log` VALUES ('52298354176032768', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:48:48', 0);
INSERT INTO `sys_log` VALUES ('52298361692225536', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:48:50', 0);
INSERT INTO `sys_log` VALUES ('52299118122369024', '1', NULL, '删除流程启动角色', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:51:50', 2);
INSERT INTO `sys_log` VALUES ('52299124610957312', '1', NULL, '删除流程启动角色', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:51:52', 2);
INSERT INTO `sys_log` VALUES ('52299149281853440', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:51:58', 0);
INSERT INTO `sys_log` VALUES ('52299151131541504', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:51:58', 0);
INSERT INTO `sys_log` VALUES ('52299342609907712', '1', NULL, '添加角色', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:52:44', 2);
INSERT INTO `sys_log` VALUES ('52299464362164224', '1', NULL, '添加角色', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:53:13', 2);
INSERT INTO `sys_log` VALUES ('52299501276233728', '1', NULL, '修改角色', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:53:22', 2);
INSERT INTO `sys_log` VALUES ('52299546457276416', '1', NULL, '设置角色菜单权限', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:53:32', 2);
INSERT INTO `sys_log` VALUES ('52299564446646272', '1', NULL, '设置角色菜单权限', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:53:37', 2);
INSERT INTO `sys_log` VALUES ('52299612844720128', '1', NULL, '设置角色菜单权限', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:53:48', 2);
INSERT INTO `sys_log` VALUES ('52299663990063104', '1', NULL, '修改流程启动角色', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:54:00', 2);
INSERT INTO `sys_log` VALUES ('52299690963632128', '1', NULL, '修改流程定义', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:54:07', 2);
INSERT INTO `sys_log` VALUES ('52299717496799232', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:54:13', 0);
INSERT INTO `sys_log` VALUES ('52299720382480384', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:54:14', 0);
INSERT INTO `sys_log` VALUES ('52299725428228096', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:54:15', 0);
INSERT INTO `sys_log` VALUES ('52299806701256704', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:54:35', 0);
INSERT INTO `sys_log` VALUES ('52299810845229056', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:54:36', 0);
INSERT INTO `sys_log` VALUES ('52299823021293568', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:54:38', 0);
INSERT INTO `sys_log` VALUES ('52299842721939456', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:54:43', 0);
INSERT INTO `sys_log` VALUES ('52299865924829184', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:54:49', 0);
INSERT INTO `sys_log` VALUES ('52299963513700352', '1', NULL, '添加字典信息', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:55:12', 2);
INSERT INTO `sys_log` VALUES ('52299977455566848', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:55:15', 0);
INSERT INTO `sys_log` VALUES ('52300054072918016', '1', NULL, '修改流程步骤', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:55:33', 2);
INSERT INTO `sys_log` VALUES ('52300099111354368', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:55:44', 0);
INSERT INTO `sys_log` VALUES ('52300100692606976', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:55:45', 0);
INSERT INTO `sys_log` VALUES ('52300103477624832', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:55:45', 0);
INSERT INTO `sys_log` VALUES ('52300112973529088', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:55:48', 0);
INSERT INTO `sys_log` VALUES ('52300166669008896', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:56:00', 0);
INSERT INTO `sys_log` VALUES ('52300203251728384', '1', NULL, '设置角色菜单权限', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:56:09', 2);
INSERT INTO `sys_log` VALUES ('52300229998804992', '1', NULL, '设置角色菜单按钮权限', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:56:15', 2);
INSERT INTO `sys_log` VALUES ('52300235069718528', '1', NULL, '设置角色菜单按钮权限', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:56:17', 2);
INSERT INTO `sys_log` VALUES ('52300244704034816', '1', NULL, '设置角色菜单按钮权限', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:56:19', 2);
INSERT INTO `sys_log` VALUES ('52300257580548096', '1', NULL, '设置角色菜单按钮权限', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:56:22', 2);
INSERT INTO `sys_log` VALUES ('52300642550546432', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:57:54', 0);
INSERT INTO `sys_log` VALUES ('52300721059528704', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:58:13', 0);
INSERT INTO `sys_log` VALUES ('52300884893237248', '1', NULL, '修改配置列表列', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:58:52', 2);
INSERT INTO `sys_log` VALUES ('52300989650173952', '1', NULL, '添加配置列表列', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:59:17', 2);
INSERT INTO `sys_log` VALUES ('52301044700413952', '1', NULL, '添加配置列表列', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:59:30', 2);
INSERT INTO `sys_log` VALUES ('52301057245577216', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:59:33', 0);
INSERT INTO `sys_log` VALUES ('52301064203927552', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:59:34', 0);
INSERT INTO `sys_log` VALUES ('52301088480559104', '1', NULL, '删除配置列表列', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:59:40', 2);
INSERT INTO `sys_log` VALUES ('52301091445932032', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:59:41', 0);
INSERT INTO `sys_log` VALUES ('52301098769186816', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:59:43', 0);
INSERT INTO `sys_log` VALUES ('52301132659163136', '1', NULL, '添加配置列表列', '0:0:0:0:0:0:0:1', 1, '2018-08-16 23:59:51', 2);
INSERT INTO `sys_log` VALUES ('52301184609812480', '1', NULL, '添加配置列表列', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:00:03', 2);
INSERT INTO `sys_log` VALUES ('52301199713501184', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:00:07', 0);
INSERT INTO `sys_log` VALUES ('52302341759565824', '1', NULL, '登录', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:04:39', 9);
INSERT INTO `sys_log` VALUES ('52302364882763776', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:04:44', 0);
INSERT INTO `sys_log` VALUES ('52302372394762240', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:04:46', 0);
INSERT INTO `sys_log` VALUES ('52302385611014144', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:04:49', 0);
INSERT INTO `sys_log` VALUES ('52302476153454592', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:05:11', 0);
INSERT INTO `sys_log` VALUES ('52302479370485760', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:05:12', 0);
INSERT INTO `sys_log` VALUES ('52302481656381440', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:05:12', 0);
INSERT INTO `sys_log` VALUES ('52302599344357376', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:05:40', 0);
INSERT INTO `sys_log` VALUES ('52302614208970752', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:05:44', 0);
INSERT INTO `sys_log` VALUES ('52302703111438336', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:06:05', 0);
INSERT INTO `sys_log` VALUES ('52302710183034880', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:06:07', 0);
INSERT INTO `sys_log` VALUES ('52302749856956416', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:06:16', 0);
INSERT INTO `sys_log` VALUES ('52302761861054464', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:06:19', 0);
INSERT INTO `sys_log` VALUES ('52302765384269824', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:06:20', 0);
INSERT INTO `sys_log` VALUES ('52302768517414912', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:06:21', 0);
INSERT INTO `sys_log` VALUES ('52302770622955520', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:06:21', 0);
INSERT INTO `sys_log` VALUES ('52302779837841408', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:06:23', 0);
INSERT INTO `sys_log` VALUES ('52302791313457152', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:06:26', 0);
INSERT INTO `sys_log` VALUES ('52302833675927552', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:06:36', 0);
INSERT INTO `sys_log` VALUES ('52303021790461952', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:07:21', 0);
INSERT INTO `sys_log` VALUES ('52303279622717440', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:08:23', 0);
INSERT INTO `sys_log` VALUES ('52303285326970880', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:08:24', 0);
INSERT INTO `sys_log` VALUES ('52303290448216064', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:08:25', 0);
INSERT INTO `sys_log` VALUES ('52303297712750592', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:08:27', 0);
INSERT INTO `sys_log` VALUES ('52303299709239296', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:08:27', 0);
INSERT INTO `sys_log` VALUES ('52304714863214592', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:14:05', 0);
INSERT INTO `sys_log` VALUES ('52304725307031552', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:14:07', 0);
INSERT INTO `sys_log` VALUES ('52304768864878592', '1', NULL, '设置操作员角色', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:14:18', 2);
INSERT INTO `sys_log` VALUES ('52304775286358016', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:14:19', 0);
INSERT INTO `sys_log` VALUES ('52304798854152192', '1', NULL, '设置操作员角色', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:14:25', 2);
INSERT INTO `sys_log` VALUES ('52304848686678016', '48601651874889729', NULL, '登录', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:14:37', 9);
INSERT INTO `sys_log` VALUES ('52304856840404992', '48601651874889729', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:14:39', 0);
INSERT INTO `sys_log` VALUES ('52304865484865536', '48601651874889729', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:14:41', 0);
INSERT INTO `sys_log` VALUES ('52304915367723008', '1', NULL, '登录', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:14:53', 9);
INSERT INTO `sys_log` VALUES ('52304943918350336', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:14:59', 0);
INSERT INTO `sys_log` VALUES ('52305013782872064', '1', NULL, '设置角色菜单按钮权限', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:15:16', 2);
INSERT INTO `sys_log` VALUES ('52305029377294336', '48601651874889729', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:15:20', 0);
INSERT INTO `sys_log` VALUES ('52305260978372608', '48601651874889729', NULL, '导入年度表彰', '0:0:0:0:0:0:0:1', 0, '2018-08-17 00:16:15', 2);
INSERT INTO `sys_log` VALUES ('52305305198919680', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:16:25', 0);
INSERT INTO `sys_log` VALUES ('52305395540033536', '48601651874889729', NULL, '导入年度表彰', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:16:47', 2);
INSERT INTO `sys_log` VALUES ('52306084970364928', '48601651874889729', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:19:31', 0);
INSERT INTO `sys_log` VALUES ('52306244202921984', '48601651874889729', NULL, '导入年度表彰', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:20:09', 2);
INSERT INTO `sys_log` VALUES ('52306320639918080', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:20:28', 0);
INSERT INTO `sys_log` VALUES ('52306344119631872', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:20:33', 0);
INSERT INTO `sys_log` VALUES ('52306487904567296', '1', NULL, '添加配置列表列', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:21:07', 2);
INSERT INTO `sys_log` VALUES ('52307188374306816', '48303136200196097', NULL, '登录', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:23:54', 9);
INSERT INTO `sys_log` VALUES ('52307201800273920', '48303136200196097', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:23:58', 0);
INSERT INTO `sys_log` VALUES ('52307216383868928', '48303136200196097', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:24:01', 0);
INSERT INTO `sys_log` VALUES ('52307221064712192', '48303136200196097', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:24:02', 0);
INSERT INTO `sys_log` VALUES ('52307223757455360', '48303136200196097', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:24:03', 0);
INSERT INTO `sys_log` VALUES ('52307225720389632', '48303136200196097', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:24:03', 0);
INSERT INTO `sys_log` VALUES ('52307227893039104', '48303136200196097', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:24:04', 0);
INSERT INTO `sys_log` VALUES ('52307230040522752', '48303136200196097', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:24:04', 0);
INSERT INTO `sys_log` VALUES ('52307231953125376', '48303136200196097', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:24:05', 0);
INSERT INTO `sys_log` VALUES ('52307249988632576', '48303136200196097', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:24:09', 0);
INSERT INTO `sys_log` VALUES ('52307341160218624', '48303136200196097', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:24:31', 0);
INSERT INTO `sys_log` VALUES ('52307420046688256', '48303136200196097', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:24:50', 0);
INSERT INTO `sys_log` VALUES ('52308712525660160', '48303136200196097', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:29:58', 0);
INSERT INTO `sys_log` VALUES ('52308726446555136', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:30:01', 0);
INSERT INTO `sys_log` VALUES ('52308782746697728', '1', NULL, '设置菜单按钮', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:30:15', 2);
INSERT INTO `sys_log` VALUES ('52308787599507456', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:30:16', 0);
INSERT INTO `sys_log` VALUES ('52308932655316992', '1', NULL, '设置角色菜单权限', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:30:50', 2);
INSERT INTO `sys_log` VALUES ('52308943023636480', '1', NULL, '设置角色菜单按钮权限', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:30:53', 2);
INSERT INTO `sys_log` VALUES ('52308962002862080', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:30:57', 0);
INSERT INTO `sys_log` VALUES ('52308969728770048', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:30:59', 0);
INSERT INTO `sys_log` VALUES ('52309007414591488', '48303136200196097', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:31:08', 0);
INSERT INTO `sys_log` VALUES ('52309017950683136', '48303136200196097', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:31:11', 0);
INSERT INTO `sys_log` VALUES ('52309028323196928', '48303136200196097', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:31:13', 0);
INSERT INTO `sys_log` VALUES ('52309246460559360', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:32:05', 0);
INSERT INTO `sys_log` VALUES ('52309273643843584', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:32:12', 0);
INSERT INTO `sys_log` VALUES ('52309291503190016', '1', NULL, '添加操作员账号', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:32:16', 2);
INSERT INTO `sys_log` VALUES ('52309295949152256', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:32:17', 0);
INSERT INTO `sys_log` VALUES ('52309429520957440', '1', NULL, '登录', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:32:49', 9);
INSERT INTO `sys_log` VALUES ('52309475788324864', '1', NULL, '设置操作员角色', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:33:00', 2);
INSERT INTO `sys_log` VALUES ('52309515298668544', '51930103373889536', NULL, '登录', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:33:09', 9);
INSERT INTO `sys_log` VALUES ('52309705795567616', '51930103373889536', NULL, '登录', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:33:55', 9);
INSERT INTO `sys_log` VALUES ('52309712875552768', '51930103373889536', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:33:56', 0);
INSERT INTO `sys_log` VALUES ('52310552482938880', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:37:17', 0);
INSERT INTO `sys_log` VALUES ('52310581981478912', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:37:24', 0);
INSERT INTO `sys_log` VALUES ('52310611601653760', '1', NULL, '设置角色菜单权限', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:37:31', 2);
INSERT INTO `sys_log` VALUES ('52310633235873792', '51930103373889536', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:37:36', 0);
INSERT INTO `sys_log` VALUES ('52310636993970176', '51930103373889536', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:37:37', 0);
INSERT INTO `sys_log` VALUES ('52310700646727680', '48944951878221825', NULL, '登录', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:37:52', 9);
INSERT INTO `sys_log` VALUES ('52310708125171712', '48944951878221825', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:37:54', 0);
INSERT INTO `sys_log` VALUES ('52310711338008576', '48944951878221825', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 00:37:54', 0);
INSERT INTO `sys_log` VALUES ('52503679248367616', '1', NULL, '登录', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:24:42', 9);
INSERT INTO `sys_log` VALUES ('52503704674238464', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:24:48', 0);
INSERT INTO `sys_log` VALUES ('52503790779105280', '1', NULL, '登录', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:25:08', 9);
INSERT INTO `sys_log` VALUES ('52503807979945984', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:25:12', 0);
INSERT INTO `sys_log` VALUES ('52503809296957440', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:25:13', 0);
INSERT INTO `sys_log` VALUES ('52503841152696320', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:25:20', 0);
INSERT INTO `sys_log` VALUES ('52503858991071232', '1', NULL, '删除角色', '0:0:0:0:0:0:0:1', 0, '2018-08-17 13:25:24', 2);
INSERT INTO `sys_log` VALUES ('52503961923485696', '1', NULL, '删除角色', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:25:49', 2);
INSERT INTO `sys_log` VALUES ('52503993640812544', '1', NULL, '删除角色', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:25:56', 2);
INSERT INTO `sys_log` VALUES ('52504058493140992', '1', NULL, '添加角色', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:26:12', 2);
INSERT INTO `sys_log` VALUES ('52504086502703104', '1', NULL, '设置角色菜单权限', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:26:19', 2);
INSERT INTO `sys_log` VALUES ('52504173429653504', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:26:39', 0);
INSERT INTO `sys_log` VALUES ('52504181008760832', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:26:41', 0);
INSERT INTO `sys_log` VALUES ('52504239120842752', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:26:55', 0);
INSERT INTO `sys_log` VALUES ('52504248222482432', '1', NULL, '删除角色', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:26:57', 2);
INSERT INTO `sys_log` VALUES ('52504276424982528', '1', NULL, '设置角色菜单权限', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:27:04', 2);
INSERT INTO `sys_log` VALUES ('52504383505563648', '48601651874889729', NULL, '登录', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:27:29', 9);
INSERT INTO `sys_log` VALUES ('52504391139196928', '48601651874889729', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:27:31', 0);
INSERT INTO `sys_log` VALUES ('52504409040486400', '48601651874889729', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:27:36', 0);
INSERT INTO `sys_log` VALUES ('52504448412418048', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:27:45', 0);
INSERT INTO `sys_log` VALUES ('52504512954368000', '1', NULL, '添加系部人员', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:28:00', 2);
INSERT INTO `sys_log` VALUES ('52504590909702144', '1', NULL, '设置操作员角色', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:28:19', 2);
INSERT INTO `sys_log` VALUES ('52504597238906880', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:28:20', 0);
INSERT INTO `sys_log` VALUES ('52504621414875136', '1', NULL, '添加操作员账号', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:28:26', 2);
INSERT INTO `sys_log` VALUES ('52504623746908160', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:28:27', 0);
INSERT INTO `sys_log` VALUES ('52504783180791808', '52504512421691393', NULL, '登录', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:29:05', 9);
INSERT INTO `sys_log` VALUES ('52504863610765312', '52504512421691393', NULL, '登录', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:29:24', 9);
INSERT INTO `sys_log` VALUES ('52504872641101824', '52504512421691393', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:29:26', 0);
INSERT INTO `sys_log` VALUES ('52504879444262912', '52504512421691393', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:29:28', 0);
INSERT INTO `sys_log` VALUES ('52504885668610048', '52504512421691393', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:29:29', 0);
INSERT INTO `sys_log` VALUES ('52504919441145856', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:29:37', 0);
INSERT INTO `sys_log` VALUES ('52504996662476800', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:29:56', 0);
INSERT INTO `sys_log` VALUES ('52505015859806208', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:30:00', 0);
INSERT INTO `sys_log` VALUES ('52505068141805568', '1', NULL, '设置角色菜单权限', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:30:13', 2);
INSERT INTO `sys_log` VALUES ('52505080221401088', '1', NULL, '设置角色菜单按钮权限', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:30:16', 2);
INSERT INTO `sys_log` VALUES ('52505089767636992', '1', NULL, '设置角色菜单按钮权限', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:30:18', 2);
INSERT INTO `sys_log` VALUES ('52505149465165824', '48601651874889729', NULL, '登录', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:30:32', 9);
INSERT INTO `sys_log` VALUES ('52505155597238272', '48601651874889729', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:30:34', 0);
INSERT INTO `sys_log` VALUES ('52505160907227136', '48601651874889729', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:30:35', 0);
INSERT INTO `sys_log` VALUES ('52505216896991232', '48601651874889729', NULL, '删除年度表彰', '0:0:0:0:0:0:0:1', 0, '2018-08-17 13:30:48', 2);
INSERT INTO `sys_log` VALUES ('52505230893383680', '48601651874889729', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:30:51', 0);
INSERT INTO `sys_log` VALUES ('52505289051602944', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:31:05', 0);
INSERT INTO `sys_log` VALUES ('52505292725813248', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:31:06', 0);
INSERT INTO `sys_log` VALUES ('52505300548190208', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:31:08', 0);
INSERT INTO `sys_log` VALUES ('52505317660950528', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:31:12', 0);
INSERT INTO `sys_log` VALUES ('52505345188167680', '1', NULL, '修改流程步骤', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:31:19', 2);
INSERT INTO `sys_log` VALUES ('52505357590724608', '1', NULL, '修改流程步骤', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:31:22', 2);
INSERT INTO `sys_log` VALUES ('52505530022756352', '1', NULL, '登录', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:32:03', 9);
INSERT INTO `sys_log` VALUES ('52505870356971520', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:33:24', 0);
INSERT INTO `sys_log` VALUES ('52505891827613696', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:33:29', 0);
INSERT INTO `sys_log` VALUES ('52505919933644800', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:33:36', 0);
INSERT INTO `sys_log` VALUES ('52506123260919808', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:34:24', 0);
INSERT INTO `sys_log` VALUES ('52506130382848000', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:34:26', 0);
INSERT INTO `sys_log` VALUES ('52506154877583360', '1', NULL, '添加字典信息', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:34:32', 2);
INSERT INTO `sys_log` VALUES ('52506175937183744', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:34:37', 0);
INSERT INTO `sys_log` VALUES ('52506262276931584', '1', NULL, '修改流程步骤', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:34:57', 2);
INSERT INTO `sys_log` VALUES ('52506390253535232', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:35:28', 0);
INSERT INTO `sys_log` VALUES ('52506439549190144', '1', NULL, '删除字典信息', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:35:40', 2);
INSERT INTO `sys_log` VALUES ('52506449879760896', '1', NULL, '删除字典信息', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:35:42', 2);
INSERT INTO `sys_log` VALUES ('52506481018273792', '1', NULL, '添加字典信息', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:35:50', 2);
INSERT INTO `sys_log` VALUES ('52506491332067328', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:35:52', 0);
INSERT INTO `sys_log` VALUES ('52506599767408640', '1', NULL, '添加流程步骤', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:36:18', 2);
INSERT INTO `sys_log` VALUES ('52506609963761664', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:36:20', 0);
INSERT INTO `sys_log` VALUES ('52506619258339328', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:36:22', 0);
INSERT INTO `sys_log` VALUES ('52506640200499200', '1', NULL, '修改流程步骤', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:36:27', 2);
INSERT INTO `sys_log` VALUES ('52506653609689088', '1', NULL, '修改流程步骤', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:36:31', 2);
INSERT INTO `sys_log` VALUES ('52506693791121408', '1', NULL, '修改流程步骤', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:36:40', 2);
INSERT INTO `sys_log` VALUES ('52506737894227968', '1', NULL, '添加流程步骤', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:36:51', 2);
INSERT INTO `sys_log` VALUES ('52506878281777152', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:37:24', 0);
INSERT INTO `sys_log` VALUES ('52506901644050432', '1', NULL, '作废流程进度', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:37:30', 2);
INSERT INTO `sys_log` VALUES ('52506913694285824', '1', NULL, '作废流程进度', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:37:33', 2);
INSERT INTO `sys_log` VALUES ('52507491845537792', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:39:51', 0);
INSERT INTO `sys_log` VALUES ('52507508434010112', '1', NULL, '作废流程进度', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:39:54', 2);
INSERT INTO `sys_log` VALUES ('52507517787308032', '48601651874889729', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:39:57', 0);
INSERT INTO `sys_log` VALUES ('52507543976542208', '48601651874889729', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:40:03', 0);
INSERT INTO `sys_log` VALUES ('52507551526289408', '48601651874889729', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:40:05', 0);
INSERT INTO `sys_log` VALUES ('52507749275140096', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:40:52', 0);
INSERT INTO `sys_log` VALUES ('52507756099272704', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:40:54', 0);
INSERT INTO `sys_log` VALUES ('52507786164043776', '1', NULL, '修改流程启动角色', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:41:01', 2);
INSERT INTO `sys_log` VALUES ('52507789448183808', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:41:01', 0);
INSERT INTO `sys_log` VALUES ('52507797367029760', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:41:03', 0);
INSERT INTO `sys_log` VALUES ('52507826190286848', '1', NULL, '修改流程启动角色', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:41:10', 2);
INSERT INTO `sys_log` VALUES ('52507831844208640', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:41:12', 0);
INSERT INTO `sys_log` VALUES ('52508019505758208', '1', NULL, '修改流程定义', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:41:56', 2);
INSERT INTO `sys_log` VALUES ('52508024983519232', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:41:58', 0);
INSERT INTO `sys_log` VALUES ('52508163965976576', '52504512421691393', NULL, '登录', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:42:31', 9);
INSERT INTO `sys_log` VALUES ('52508170731388928', '52504512421691393', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:42:32', 0);
INSERT INTO `sys_log` VALUES ('52508243930382336', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:42:50', 0);
INSERT INTO `sys_log` VALUES ('52508279330308096', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:42:58', 0);
INSERT INTO `sys_log` VALUES ('52508290331967488', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:43:01', 0);
INSERT INTO `sys_log` VALUES ('52508294538854400', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:43:02', 0);
INSERT INTO `sys_log` VALUES ('52508590014988288', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:44:12', 0);
INSERT INTO `sys_log` VALUES ('52508603294154752', '1', NULL, '修改流程步骤', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:44:15', 2);
INSERT INTO `sys_log` VALUES ('52508675088056320', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:44:33', 0);
INSERT INTO `sys_log` VALUES ('52508723230277632', '1', NULL, '登录', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:44:44', 9);
INSERT INTO `sys_log` VALUES ('52509692592652288', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:48:35', 0);
INSERT INTO `sys_log` VALUES ('52509700041736192', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:48:37', 0);
INSERT INTO `sys_log` VALUES ('52509704416395264', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:48:38', 0);
INSERT INTO `sys_log` VALUES ('52509708216434688', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:48:39', 0);
INSERT INTO `sys_log` VALUES ('52509709999013888', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:48:39', 0);
INSERT INTO `sys_log` VALUES ('52509712628842496', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:48:40', 0);
INSERT INTO `sys_log` VALUES ('52509714436587520', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:48:40', 0);
INSERT INTO `sys_log` VALUES ('52509716357578752', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:48:41', 0);
INSERT INTO `sys_log` VALUES ('52509737148743680', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:48:46', 0);
INSERT INTO `sys_log` VALUES ('52509741594705920', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:48:47', 0);
INSERT INTO `sys_log` VALUES ('52509766450151424', '1', NULL, '设置操作员角色', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:48:53', 2);
INSERT INTO `sys_log` VALUES ('52509774612267008', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:48:55', 0);
INSERT INTO `sys_log` VALUES ('52509815682891776', '1', NULL, '登录', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:49:05', 9);
INSERT INTO `sys_log` VALUES ('52509829607981056', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:49:08', 0);
INSERT INTO `sys_log` VALUES ('52509832137146368', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:49:08', 0);
INSERT INTO `sys_log` VALUES ('52509921840726016', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:49:30', 0);
INSERT INTO `sys_log` VALUES ('52509928685830144', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:49:31', 0);
INSERT INTO `sys_log` VALUES ('52509942233432064', '1', NULL, '删除配置列表列', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:49:35', 2);
INSERT INTO `sys_log` VALUES ('52509945131696128', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:49:35', 0);
INSERT INTO `sys_log` VALUES ('52509948671688704', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:49:36', 0);
INSERT INTO `sys_log` VALUES ('52509961795665920', '1', NULL, '删除配置列表搜索', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:49:39', 2);
INSERT INTO `sys_log` VALUES ('52509964580683776', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:49:40', 0);
INSERT INTO `sys_log` VALUES ('52509971727777792', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:49:42', 0);
INSERT INTO `sys_log` VALUES ('52510283108712448', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:50:56', 0);
INSERT INTO `sys_log` VALUES ('52510295314137088', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:50:59', 0);
INSERT INTO `sys_log` VALUES ('52510304340279296', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:51:01', 0);
INSERT INTO `sys_log` VALUES ('52510381616136192', '48601651874889729', NULL, '登录', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:51:19', 9);
INSERT INTO `sys_log` VALUES ('52510391896375296', '48601651874889729', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:51:22', 0);
INSERT INTO `sys_log` VALUES ('52510452910915584', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:51:36', 0);
INSERT INTO `sys_log` VALUES ('52510464726269952', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:51:39', 0);
INSERT INTO `sys_log` VALUES ('52510494908481536', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:51:46', 0);
INSERT INTO `sys_log` VALUES ('52510504521826304', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:51:49', 0);
INSERT INTO `sys_log` VALUES ('52510532514611200', '1', NULL, '修改配置列表列', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:51:55', 2);
INSERT INTO `sys_log` VALUES ('52510544325771264', '1', NULL, '修改配置列表列', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:51:58', 2);
INSERT INTO `sys_log` VALUES ('52510569055387648', '1', NULL, '修改配置列表列', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:52:04', 2);
INSERT INTO `sys_log` VALUES ('52510607345188864', '1', NULL, '修改配置列表列', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:52:13', 2);
INSERT INTO `sys_log` VALUES ('52510692825104384', '1', NULL, '添加配置列表列', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:52:34', 2);
INSERT INTO `sys_log` VALUES ('52510953006170112', '48601651874889729', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:53:36', 0);
INSERT INTO `sys_log` VALUES ('52510976842399744', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:53:41', 0);
INSERT INTO `sys_log` VALUES ('52510985503637504', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:53:43', 0);
INSERT INTO `sys_log` VALUES ('52511038964236288', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:53:56', 0);
INSERT INTO `sys_log` VALUES ('52511057565974528', '1', NULL, '修改菜单', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:54:01', 2);
INSERT INTO `sys_log` VALUES ('52511083218337792', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:54:07', 0);
INSERT INTO `sys_log` VALUES ('52511136133677056', '1', NULL, '设置角色菜单按钮权限', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:54:19', 2);
INSERT INTO `sys_log` VALUES ('52511144186740736', '1', NULL, '设置角色菜单按钮权限', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:54:21', 2);
INSERT INTO `sys_log` VALUES ('52511150037794816', '1', NULL, '设置角色菜单按钮权限', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:54:23', 2);
INSERT INTO `sys_log` VALUES ('52511274545709056', '1', NULL, '设置角色菜单权限', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:54:52', 2);
INSERT INTO `sys_log` VALUES ('52511475331235840', '48601651874889729', NULL, '导入学生综合素质测评', '0:0:0:0:0:0:0:1', 1, '2018-08-17 13:55:40', 2);
INSERT INTO `sys_log` VALUES ('52523268673896448', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 14:42:32', 0);
INSERT INTO `sys_log` VALUES ('52523274873077760', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 14:42:33', 0);
INSERT INTO `sys_log` VALUES ('52523343118598144', '1', NULL, '修改配置列表列', '0:0:0:0:0:0:0:1', 1, '2018-08-17 14:42:50', 2);
INSERT INTO `sys_log` VALUES ('52523662779088896', '1', NULL, '修改配置列表列', '0:0:0:0:0:0:0:1', 1, '2018-08-17 14:44:06', 2);
INSERT INTO `sys_log` VALUES ('52523683356344320', '48601651874889729', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 14:44:11', 0);
INSERT INTO `sys_log` VALUES ('52523730164776960', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 14:44:22', 0);
INSERT INTO `sys_log` VALUES ('52524002186362880', '1', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 14:45:27', 0);
INSERT INTO `sys_log` VALUES ('52524045882621952', '1', NULL, '修改配置列表列', '0:0:0:0:0:0:0:1', 1, '2018-08-17 14:45:37', 2);
INSERT INTO `sys_log` VALUES ('52524081563566080', '1', NULL, '修改配置列表列', '0:0:0:0:0:0:0:1', 1, '2018-08-17 14:45:46', 2);
INSERT INTO `sys_log` VALUES ('52524158747148288', '1', NULL, '修改配置列表列', '0:0:0:0:0:0:0:1', 1, '2018-08-17 14:46:04', 2);
INSERT INTO `sys_log` VALUES ('52525067564744704', '48601651874889729', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 14:49:41', 0);
INSERT INTO `sys_log` VALUES ('52525117577625600', '48601651874889729', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 14:49:53', 0);
INSERT INTO `sys_log` VALUES ('52525120995983360', '48601651874889729', NULL, '查看数据列表', '0:0:0:0:0:0:0:1', 1, '2018-08-17 14:49:54', 0);

-- ----------------------------
-- Table structure for sys_log_text
-- ----------------------------
DROP TABLE IF EXISTS `sys_log_text`;
CREATE TABLE `sys_log_text`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SL_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '日志主表id',
  `SLT_CONTENT` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '日志内容',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SL_ID`(`SL_ID`) USING BTREE,
  CONSTRAINT `SL_ID` FOREIGN KEY (`SL_ID`) REFERENCES `sys_log` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_log_text
-- ----------------------------
INSERT INTO `sys_log_text` VALUES ('52238654508105728', '52238654378082304', '查看系统日志');
INSERT INTO `sys_log_text` VALUES ('52238674582044672', '52238674477187072', '查看操作日志');
INSERT INTO `sys_log_text` VALUES ('52238761475440640', '52238761257336832', 'SQL运行错误:sql injection violation, syntax error: syntax error, error in :\'TIME DESC1\n             \n          \', expect RPAREN, actual IDENTIFIER pos 170, line 9, column 39, token IDENTIFIER DESC1 : SELECT DG.*\n        \n         \n        FROM(\n            SELECT *\n            FROM v_log_personal\n              \n             \n                order by SL_ENTERTIME DESC1\n             \n             \n                 \n                    limit 0, 10\n                 \n                 \n             \n        )DG');
INSERT INTO `sys_log_text` VALUES ('52238812855664640', '52238812784361472', 'SQL运行错误:sql injection violation, syntax error: syntax error, error in :\'TIME DESC1\n             \n          \', expect RPAREN, actual IDENTIFIER pos 170, line 9, column 39, token IDENTIFIER DESC1 : SELECT DG.*\n        \n         \n        FROM(\n            SELECT *\n            FROM v_log_personal\n              \n             \n                order by SL_ENTERTIME DESC1\n             \n             \n                 \n                    limit 0, 10\n                 \n                 \n             \n        )DG');
INSERT INTO `sys_log_text` VALUES ('52238844283584512', '52238844237447168', '更新配置列表,更新前:{SC_IS_PAGING=1, SC_NAME=日志管理-登录日志, SC_JSP=admin/log/personal/home, SC_VIEW=v_log_personal, SC_IS_SEARCH=1, SC_IS_SELECT=, ID=52235788951224320, SC_ORDER_BY=SL_ENTERTIME DESC1, SC_IS_SINGLE=, SC_IS_FILTER=1},更新后:{SC_IS_PAGING=1, SVR_TABLE_NAME=SYS_CONFIGURE, SC_NAME=日志管理-登录日志, SC_JSP=admin/log/personal/home, SC_VIEW=v_log_personal, SC_IS_SEARCH=1, SC_IS_SELECT=, ID=52235788951224320, SC_ORDER_BY=SL_ENTERTIME DESC, SC_IS_SINGLE=, SC_IS_FILTER=1}');
INSERT INTO `sys_log_text` VALUES ('52239093156806656', '52239092649295872', '查看系统日志');
INSERT INTO `sys_log_text` VALUES ('52239097229475840', '52239097166561280', '查看登录日志');
INSERT INTO `sys_log_text` VALUES ('52239100563947520', '52239100517810176', '查看操作日志');
INSERT INTO `sys_log_text` VALUES ('52239115432755200', '52239115353063424', '查看系统日志');
INSERT INTO `sys_log_text` VALUES ('52239118318436352', '52239118289076224', '查看操作日志');
INSERT INTO `sys_log_text` VALUES ('52239120591749120', '52239120545611776', '查看登录日志');
INSERT INTO `sys_log_text` VALUES ('52239122563072000', '52239122512740352', '查看系统日志');
INSERT INTO `sys_log_text` VALUES ('52239127399104512', '52239127357161472', '查看学院奖学金');
INSERT INTO `sys_log_text` VALUES ('52239157962997760', '52239157828780032', '查看操作日志');
INSERT INTO `sys_log_text` VALUES ('52239400842559488', '52239400410546176', '查看操作日志');
INSERT INTO `sys_log_text` VALUES ('52239403573051392', '52239403526914048', '查看系统日志');
INSERT INTO `sys_log_text` VALUES ('52239476054818816', '52239475614416896', '查看登录日志');
INSERT INTO `sys_log_text` VALUES ('52239508250296320', '52239508036386816', '登录失败!第1次!登录地址:未知');
INSERT INTO `sys_log_text` VALUES ('52239526017368064', '52239525837012992', '登录失败!第2次!登录地址:未知');
INSERT INTO `sys_log_text` VALUES ('52239549178314752', '52239548918267904', '登录成功!登录地址:未知');
INSERT INTO `sys_log_text` VALUES ('52241867294638080', '52241867001036800', '登录成功!登录地址:未知');
INSERT INTO `sys_log_text` VALUES ('52245158015533056', '52245157851955200', '登录成功!登录地址:未知');
INSERT INTO `sys_log_text` VALUES ('52245580818153472', '52245580495192064', '登录成功!登录地址:未知');
INSERT INTO `sys_log_text` VALUES ('52245909244739584', '52245909076967424', '登录成功!登录地址:未知');
INSERT INTO `sys_log_text` VALUES ('52246331221082112', '52246330759708672', '登录成功!登录地址:未知');
INSERT INTO `sys_log_text` VALUES ('52246987080204288', '52246986690134016', '登录成功!登录地址:未知');
INSERT INTO `sys_log_text` VALUES ('52256067840638976', '52256067224076288', '登录成功!登录地址:未知');
INSERT INTO `sys_log_text` VALUES ('52257353575170048', '52257353143156736', '登录成功!登录地址:福建省福州市 电信');
INSERT INTO `sys_log_text` VALUES ('52257408600244224', '52257408193396736', '查看登录日志');
INSERT INTO `sys_log_text` VALUES ('52257502460379136', '52257502158389248', '登录成功!登录地址:未知');
INSERT INTO `sys_log_text` VALUES ('52257537935802368', '52257537667366912', '查看操作日志');
INSERT INTO `sys_log_text` VALUES ('52257548052463616', '52257547968577536', '查看系统日志');
INSERT INTO `sys_log_text` VALUES ('52257556814364672', '52257556722089984', '查看操作日志');
INSERT INTO `sys_log_text` VALUES ('52257560043978752', '52257559997841408', '查看系统日志');
INSERT INTO `sys_log_text` VALUES ('52257562619281408', '52257562506035200', '查看操作日志');
INSERT INTO `sys_log_text` VALUES ('52257564619964416', '52257564515106816', '查看登录日志');
INSERT INTO `sys_log_text` VALUES ('52257567321096192', '52257567207849984', '查看操作日志');
INSERT INTO `sys_log_text` VALUES ('52257604264525824', '52257604075782144', '查看操作日志');
INSERT INTO `sys_log_text` VALUES ('52258023954972672', '52258023346798592', '查看系统日志');
INSERT INTO `sys_log_text` VALUES ('52258026685464576', '52258026593189888', '查看操作日志');
INSERT INTO `sys_log_text` VALUES ('52258028971360256', '52258028883279872', '查看登录日志');
INSERT INTO `sys_log_text` VALUES ('52258030808465408', '52258030758133760', '查看操作日志');
INSERT INTO `sys_log_text` VALUES ('52258033920638976', '52258033828364288', '查看系统日志');
INSERT INTO `sys_log_text` VALUES ('52258036055539712', '52258035950682112', '查看操作日志');
INSERT INTO `sys_log_text` VALUES ('52258091684593664', '52258091210637312', '查看系统日志');
INSERT INTO `sys_log_text` VALUES ('52258198664511488', '52258198198943744', '登录成功!登录地址:未知');
INSERT INTO `sys_log_text` VALUES ('52258208248496128', '52258208105889792', '查看系统日志');
INSERT INTO `sys_log_text` VALUES ('52258212665098240', '52258212564434944', '查看操作日志');
INSERT INTO `sys_log_text` VALUES ('52258218272882688', '52258218180608000', '查看登录日志');
INSERT INTO `sys_log_text` VALUES ('52258232705482752', '52258232600625152', '查看操作日志');
INSERT INTO `sys_log_text` VALUES ('52258234731331584', '52258234672611328', '查看系统日志');
INSERT INTO `sys_log_text` VALUES ('52258276808589312', '52258276473044992', '查看登录日志');
INSERT INTO `sys_log_text` VALUES ('52258290884673536', '52258290767233024', '查看操作日志');
INSERT INTO `sys_log_text` VALUES ('52258298316980224', '52258298186956800', '查看系统日志');
INSERT INTO `sys_log_text` VALUES ('52258670959919104', '52258670444019712', '查看系统日志');
INSERT INTO `sys_log_text` VALUES ('52258673572970496', '52258673547804672', '查看操作日志');
INSERT INTO `sys_log_text` VALUES ('52258676500594688', '52258676433485824', '查看系统日志');
INSERT INTO `sys_log_text` VALUES ('52258679658905600', '52258679545659392', '查看操作日志');
INSERT INTO `sys_log_text` VALUES ('52258684180365312', '52258684079702016', '查看登录日志');
INSERT INTO `sys_log_text` VALUES ('52258686231379968', '52258686189436928', '查看操作日志');
INSERT INTO `sys_log_text` VALUES ('52258690681536512', '52258690614427648', '查看登录日志');
INSERT INTO `sys_log_text` VALUES ('52258692405395456', '52258692300537856', '查看操作日志');
INSERT INTO `sys_log_text` VALUES ('52258695945388032', '52258695903444992', '查看系统日志');
INSERT INTO `sys_log_text` VALUES ('52258697459531776', '52258697409200128', '查看操作日志');
INSERT INTO `sys_log_text` VALUES ('52258698763960320', '52258698738794496', '查看登录日志');
INSERT INTO `sys_log_text` VALUES ('52258700060000256', '52258700018057216', '查看操作日志');
INSERT INTO `sys_log_text` VALUES ('52258701104381952', '52258701066633216', '查看系统日志');
INSERT INTO `sys_log_text` VALUES ('52258702496890880', '52258702454947840', '查看操作日志');
INSERT INTO `sys_log_text` VALUES ('52258703692267520', '52258703646130176', '查看登录日志');
INSERT INTO `sys_log_text` VALUES ('52258704900227072', '52258704866672640', '查看操作日志');
INSERT INTO `sys_log_text` VALUES ('52258706053660672', '52258706011717632', '查看系统日志');
INSERT INTO `sys_log_text` VALUES ('52258707190317056', '52258707148374016', '查看操作日志');
INSERT INTO `sys_log_text` VALUES ('52258708209532928', '52258708171784192', '查看登录日志');
INSERT INTO `sys_log_text` VALUES ('52258709304246272', '52258709270691840', '查看操作日志');
INSERT INTO `sys_log_text` VALUES ('52258710520594432', '52258710482845696', '查看系统日志');
INSERT INTO `sys_log_text` VALUES ('52258721463533568', '52258721283178496', '查看学院奖学金');
INSERT INTO `sys_log_text` VALUES ('52258756255285248', '52258756196564992', '查看配置列表管理');
INSERT INTO `sys_log_text` VALUES ('52258940540420096', '52258940464922624', '查看菜单管理');
INSERT INTO `sys_log_text` VALUES ('52259177535373312', '52259177497624576', '更新菜单,更新前:{BUS_PROCESS=, SM_URL=admin/dataGrid/, SC_NAME=日志管理-登录日志, SM_URL_PARAMS=, BUS_PROCESS2=, SM_PARENT_NAME=日志管理, SM_IS_LEAF=0, IS_STATUS=1, SM_TYPE=1, SM_ORDER=30, SM_CODE=LOG:SEE, SM_NAME=查看日志, SM_PARENTID=52184510715920384, ID=52259024812376064, SC_ID=52235788951224320, SM_CLASSICON=mdi mdi-login, SM_IS_EXPAND=},更新后:{BUS_PROCESS=, SM_URL=admin/dataGrid/, SVR_TABLE_NAME=SYS_MENU, SM_URL_PARAMS=, BUS_PROCESS2=, SM_IS_LEAF=0, IS_STATUS=null, SM_TYPE=1, SM_ORDER=40, SM_CODE=LOG:SEE, SM_NAME=查看日志, SM_PARENTID=52184510715920384, ID=52259024812376064, SC_ID=52258927902982144, SM_CLASSICON=mdi mdi-eye, SM_IS_EXPAND=}');
INSERT INTO `sys_log_text` VALUES ('52259250465931264', '52259250361073664', '查看操作员管理');
INSERT INTO `sys_log_text` VALUES ('52259254135947264', '52259253989146624', '查看角色管理');
INSERT INTO `sys_log_text` VALUES ('52259312445161472', '52259312415801344', '角色:超级管理员,旧菜单:[1757509987598336, 2258969972178944, 26571410583322624, 26511186237325312, 26571551922978816, 50751117243449344, 2269941063483392, 48614229862776832, 49030149684854784, 50328019348226048, 38162771866550273, 48892279221387264, 38162771866550272, 2163861868249088, 23657888534757376, 28019952082485248, 21130604443598848, 26715728707059712, 48295058385928192, 48295058385928193, 20766815625936896, 21131205961318400, 48892124845834240, 1560059138015232, 26577844645658624, 49027088874733568, 52235902763663360, 26476504758091776, 1, 3316536806735872, 2, 26845813934129152, 3, 26714856669315072, 50338340347576320, 7, 49028146267160576, 2163592187084800, 8, 9, 49029256612675584, 48614104260149248, 49029176400805888, 52184511034687488, 1448716162564096, 3547951557246976, 49027774555357184, 2258672239509504, 50827078936821760, 38116041032728576, 52235853056966656, 33081241360138240, 38161659570683904, 48304916703215616, 48304916703215617, 38161659570683905, 13358417838080, 50827078076989440, 52184510715920384, 48667624430632960, 48673777285857280, 1451155909509120, 4103758959083520, 26577007949119488, 26579469829406720, 50341592241799168, 1846593582006272, 1427690443767808, 2910350022279168],新菜单:[1757509987598336, 2258969972178944, 26571410583322624, 26571551922978816, 26511186237325312, 50751117243449344, 2269941063483392, 48614229862776832, 49030149684854784, 50328019348226048, 48892279221387264, 38162771866550273, 38162771866550272, 23657888534757376, 2163861868249088, 28019952082485248, 21130604443598848, 26715728707059712, 48295058385928192, 48295058385928193, 20766815625936896, 21131205961318400, 48892124845834240, 26577844645658624, 1560059138015232, 49027088874733568, 52235902763663360, 26476504758091776, 3316536806735872, 1, 2, 26845813934129152, 3, 26714856669315072, 50338340347576320, 49028146267160576, 7, 2163592187084800, 8, 9, 49029256612675584, 48614104260149248, 52184511034687488, 49029176400805888, 3547951557246976, 1448716162564096, 49027774555357184, 2258672239509504, 50827078936821760, 38116041032728576, 52235853056966656, 33081241360138240, 38161659570683904, 48304916703215616, 48304916703215617, 38161659570683905, 13358417838080, 52184510715920384, 50827078076989440, 48667624430632960, 52259024812376064, 48673777285857280, 4103758959083520, 1451155909509120, 26577007949119488, 50341592241799168, 26579469829406720, 1846593582006272, 1427690443767808, 2910350022279168]');
INSERT INTO `sys_log_text` VALUES ('52259341515882496', '52259341331333120', '登录成功!登录地址:未知');
INSERT INTO `sys_log_text` VALUES ('52259353213796352', '52259352983109632', '查看查看日志');
INSERT INTO `sys_log_text` VALUES ('52259376160833536', '52259375733014528', '查看登录日志');
INSERT INTO `sys_log_text` VALUES ('52259376676732928', '52259376550903808', '查看查看日志');
INSERT INTO `sys_log_text` VALUES ('52259382947217408', '52259382519398400', '查看登录日志');
INSERT INTO `sys_log_text` VALUES ('52259384826265600', '52259384717213696', '查看查看日志');
INSERT INTO `sys_log_text` VALUES ('52259390475993088', '52259390362746880', '查看登录日志');
INSERT INTO `sys_log_text` VALUES ('52259455743557632', '52259455437373440', '查看查看日志');
INSERT INTO `sys_log_text` VALUES ('52259822858403840', '52259822682243072', '查看登录日志');
INSERT INTO `sys_log_text` VALUES ('52259829892251648', '52259829669953536', '查看操作日志');
INSERT INTO `sys_log_text` VALUES ('52259836854796288', '52259836741550080', '查看查看日志');
INSERT INTO `sys_log_text` VALUES ('52259850138157056', '52259849941024768', '查看操作日志');
INSERT INTO `sys_log_text` VALUES ('52260530550734848', '52260530039029760', '查看查看日志');
INSERT INTO `sys_log_text` VALUES ('52260547256647680', '52260547126624256', '查看学院奖学金');
INSERT INTO `sys_log_text` VALUES ('52260557981483008', '52260557918568448', '查看学院奖学金');
INSERT INTO `sys_log_text` VALUES ('52260565183102976', '52260565082439680', '查看查看日志');
INSERT INTO `sys_log_text` VALUES ('52260744103723008', '52260743982088192', '查看学生管理');
INSERT INTO `sys_log_text` VALUES ('52260757907177472', '52260757672296448', '查看查看日志');
INSERT INTO `sys_log_text` VALUES ('52290346704437248', '52290346398253056', '登录成功!登录地址:未知');
INSERT INTO `sys_log_text` VALUES ('52291445591113728', '52291445486256128', '查看字典管理');
INSERT INTO `sys_log_text` VALUES ('52291507335462912', '52291507297714176', '添加字典类型:{IS_STATUS=1, SVR_TABLE_NAME=SYS_DICT_TYPE, SDT_CODE=BUS_COMMEND_TYPE, SDT_ROLE_DEL=, SDT_NAME=业务_年度表彰, ID=52291506974752768, SDT_ROLE_DOWN=}');
INSERT INTO `sys_log_text` VALUES ('52291552562642944', '52291552529088512', '更新字典类型,更新前:{IS_STATUS=1, SDT_CODE=BUS_COMMEND_TYPE, SDT_ROLE_DEL=null, SDT_NAME=业务_年度表彰, IS_HIDDEN=0, ID=52291506974752768, SDT_ROLE_DOWN=null},更新后:{IS_STATUS=null, SVR_TABLE_NAME=SYS_DICT_TYPE, SDT_CODE=BUS_COMMEND_TYPE, SDT_ROLE_DEL=, SDT_NAME=业务_年度表彰类型, ID=52291506974752768, SDT_ROLE_DOWN=}');
INSERT INTO `sys_log_text` VALUES ('52291558128484352', '52291558048792576', '查看字典信息');
INSERT INTO `sys_log_text` VALUES ('52291672058363904', '52291672024809472', '添加字典类型:{SDI_CODE=THREE_GOOD_STUDENTS, SVR_TABLE_NAME=SYS_DICT_INFO, SDI_REQUIRED=0, SDI_ORDER=1, SDI_REMARK=, SDI_NAME=三好学生, SDI_PARENTID=0, IS_STATUS=1, SDT_CODE=BUS_COMMEND_TYPE, SDI_INNERCODE=THREE_GOOD_STUDENTS, ID=52291671479549952, SDT_ID=52291506974752768}');
INSERT INTO `sys_log_text` VALUES ('52291791587639296', '52291791386312704', '添加字典类型:{SDI_CODE=OUTSTANDING_STUDENT_CADRES, SVR_TABLE_NAME=SYS_DICT_INFO, SDI_REQUIRED=0, SDI_ORDER=2, SDI_REMARK=, SDI_NAME=优秀学生干部, SDI_PARENTID=0, IS_STATUS=1, SDT_CODE=BUS_COMMEND_TYPE, SDI_INNERCODE=OUTSTANDING_STUDENT_CADRES, ID=52291791042379776, SDT_ID=52291506974752768}');
INSERT INTO `sys_log_text` VALUES ('52291860919484416', '52291860869152768', '查看字典管理');
INSERT INTO `sys_log_text` VALUES ('52292519387463680', '52292519278411776', '查看配置列表管理');
INSERT INTO `sys_log_text` VALUES ('52292623292956672', '52292623251013632', '拷贝配置列表:{SC_IS_PAGING=1, SC_NAME=资助管理-年度表彰, SC_JSP=admin/aid/collegeScholarship/home, SC_VIEW=v_college_scholarship, SC_IS_SEARCH=1, SC_IS_SELECT=, ID=52292620512133120, SC_ORDER_BY=BAF_YEAR DESC,BAF_SEMESTER DESC,CONVERT(ID,SIGNED) DESC, SC_IS_SINGLE=, SC_IS_FILTER=}');
INSERT INTO `sys_log_text` VALUES ('52292674329247744', '52292674291499008', '更新配置列表,更新前:{SC_IS_PAGING=1, SC_NAME=资助管理-学院奖学金, SC_JSP=admin/aid/collegeScholarship/home, SC_VIEW=v_college_scholarship, SC_IS_SEARCH=1, SC_IS_SELECT=, ID=50831880232108032, SC_ORDER_BY=BAF_YEAR DESC,BAF_SEMESTER DESC,CONVERT(ID,SIGNED) DESC, SC_IS_SINGLE=, SC_IS_FILTER=},更新后:{SC_IS_PAGING=1, SVR_TABLE_NAME=SYS_CONFIGURE, SC_NAME=资助管理-学院奖学金, SC_JSP=admin/aid/collegeScholarship/home, SC_VIEW=v_aid_college_scholarship, SC_IS_SEARCH=1, SC_IS_SELECT=, ID=50831880232108032, SC_ORDER_BY=BAF_YEAR DESC,BAF_SEMESTER DESC,CONVERT(ID,SIGNED) DESC, SC_IS_SINGLE=, SC_IS_FILTER=}');
INSERT INTO `sys_log_text` VALUES ('52292915904380928', '52292915858243584', '更新配置列表,更新前:{SC_IS_PAGING=1, SC_NAME=资助管理-年度表彰, SC_JSP=admin/aid/collegeScholarship/home, SC_VIEW=v_college_scholarship, SC_IS_SEARCH=1, SC_IS_SELECT=, ID=52292620512133120, SC_ORDER_BY=BAF_YEAR DESC,BAF_SEMESTER DESC,CONVERT(ID,SIGNED) DESC, SC_IS_SINGLE=, SC_IS_FILTER=},更新后:{SC_IS_PAGING=1, SVR_TABLE_NAME=SYS_CONFIGURE, SC_NAME=资助管理-年度表彰, SC_JSP=admin/aid/commend/home, SC_VIEW=v_aid_commend, SC_IS_SEARCH=1, SC_IS_SELECT=, ID=52292620512133120, SC_ORDER_BY=BAF_YEAR DESC,BAF_SEMESTER DESC,CONVERT(ID,SIGNED) DESC, SC_IS_SINGLE=, SC_IS_FILTER=}');
INSERT INTO `sys_log_text` VALUES ('52292925421256704', '52292925345759232', '查看设置字段');
INSERT INTO `sys_log_text` VALUES ('52292962331131904', '52292962268217344', '查看配置列表管理');
INSERT INTO `sys_log_text` VALUES ('52292968022802432', '52292967968276480', '查看设置字段');
INSERT INTO `sys_log_text` VALUES ('52292972208717824', '52292972154191872', '查看配置列表管理');
INSERT INTO `sys_log_text` VALUES ('52292978688917504', '52292978554699776', '查看设置字段');
INSERT INTO `sys_log_text` VALUES ('52293039435022336', '52293039187558400', '查看设置字段');
INSERT INTO `sys_log_text` VALUES ('52293067364892672', '52293066916102144', '查看学院奖学金');
INSERT INTO `sys_log_text` VALUES ('52293399507632128', '52293399218225152', '添加配置列表字段,配置列表:资助管理-学院奖学金,字段参数{SCC_NAME=奖项, SVR_TABLE_NAME=SYS_CONFIGURE_COLUMN, SCC_FUNC=, SCC_IS_MERGE=, SCC_ALIGN=center, SCC_IS_STATUS=0, SCC_WIDTH=100px, SCC_FIELD=BAF_AID_TYPE, SCC_IS_VISIBLE=1, SCC_IS_OPERATION=0, ID=52293398979149824, SC_ID=50831880232108032, SCC_CLASS=, SCC_SDT_CODE=BUS_COLLEGE_SCHOLARSHIP_TYPE, SCC_ORDER=72}');
INSERT INTO `sys_log_text` VALUES ('52293408760266752', '52293408647020544', '查看学院奖学金');
INSERT INTO `sys_log_text` VALUES ('52293587383091200', '52293587353731072', '更新配置列表字段,配置列表:资助管理-学院奖学金,更新前:,更新后:{SCC_NAME=操作, SVR_TABLE_NAME=SYS_CONFIGURE_COLUMN, SCC_FUNC=, SCC_IS_MERGE=, SCC_ALIGN=center, SCC_IS_STATUS=0, SCC_WIDTH=200px, SCC_FIELD=, SCC_IS_VISIBLE=1, SCC_IS_OPERATION=1, ID=50833943762567168, SC_ID=50831880232108032, SCC_CLASS=, SCC_SDT_CODE=, SCC_ORDER=80}');
INSERT INTO `sys_log_text` VALUES ('52293648145973248', '52293648112418816', '更新配置列表字段,配置列表:资助管理-学院奖学金,更新前:,更新后:{SCC_NAME=综合测评, SVR_TABLE_NAME=SYS_CONFIGURE_COLUMN, SCC_FUNC=, SCC_IS_MERGE=, SCC_ALIGN=center, SCC_IS_STATUS=0, SCC_WIDTH=60px, SCC_FIELD=BSC_TOTAL, SCC_IS_VISIBLE=1, SCC_IS_OPERATION=0, ID=50833638492733440, SC_ID=50831880232108032, SCC_CLASS=, SCC_SDT_CODE=, SCC_ORDER=40}');
INSERT INTO `sys_log_text` VALUES ('52293666378612736', '52293666340864000', '更新配置列表字段,配置列表:资助管理-学院奖学金,更新前:,更新后:{SCC_NAME=测评排名, SVR_TABLE_NAME=SYS_CONFIGURE_COLUMN, SCC_FUNC=, SCC_IS_MERGE=, SCC_ALIGN=center, SCC_IS_STATUS=0, SCC_WIDTH=60px, SCC_FIELD=BSC_RANK, SCC_IS_VISIBLE=1, SCC_IS_OPERATION=0, ID=50833705790341120, SC_ID=50831880232108032, SCC_CLASS=, SCC_SDT_CODE=, SCC_ORDER=50}');
INSERT INTO `sys_log_text` VALUES ('52293682161778688', '52293682132418560', '更新配置列表字段,配置列表:资助管理-学院奖学金,更新前:,更新后:{SCC_NAME=学习成绩, SVR_TABLE_NAME=SYS_CONFIGURE_COLUMN, SCC_FUNC=, SCC_IS_MERGE=, SCC_ALIGN=center, SCC_IS_STATUS=0, SCC_WIDTH=60px, SCC_FIELD=BSC_ACADEMIC_RECORD, SCC_IS_VISIBLE=1, SCC_IS_OPERATION=0, ID=50833777835900928, SC_ID=50831880232108032, SCC_CLASS=, SCC_SDT_CODE=, SCC_ORDER=60}');
INSERT INTO `sys_log_text` VALUES ('52293697324187648', '52293697173192704', '更新配置列表字段,配置列表:资助管理-学院奖学金,更新前:,更新后:{SCC_NAME=学习排名, SVR_TABLE_NAME=SYS_CONFIGURE_COLUMN, SCC_FUNC=, SCC_IS_MERGE=, SCC_ALIGN=center, SCC_IS_STATUS=0, SCC_WIDTH=60px, SCC_FIELD=BSC_INTELLECTUAL_RANK, SCC_IS_VISIBLE=1, SCC_IS_OPERATION=0, ID=50833829203542016, SC_ID=50831880232108032, SCC_CLASS=, SCC_SDT_CODE=, SCC_ORDER=70}');
INSERT INTO `sys_log_text` VALUES ('52293723047854080', '52293723018493952', '更新配置列表字段,配置列表:资助管理-学院奖学金,更新前:,更新后:{SCC_NAME=奖项, SVR_TABLE_NAME=SYS_CONFIGURE_COLUMN, SCC_FUNC=, SCC_IS_MERGE=, SCC_ALIGN=center, SCC_IS_STATUS=0, SCC_WIDTH=80px, SCC_FIELD=BAF_AID_TYPE, SCC_IS_VISIBLE=1, SCC_IS_OPERATION=0, ID=52293398979149824, SC_ID=50831880232108032, SCC_CLASS=, SCC_SDT_CODE=BUS_COLLEGE_SCHOLARSHIP_TYPE, SCC_ORDER=72}');
INSERT INTO `sys_log_text` VALUES ('52293788399304704', '52293788365750272', '更新配置列表字段,配置列表:资助管理-学院奖学金,更新前:,更新后:{SCC_NAME=学号, SVR_TABLE_NAME=SYS_CONFIGURE_COLUMN, SCC_FUNC=, SCC_IS_MERGE=, SCC_ALIGN=center, SCC_IS_STATUS=0, SCC_WIDTH=90px, SCC_FIELD=BS_NUMBER, SCC_IS_VISIBLE=1, SCC_IS_OPERATION=0, ID=50833440131514368, SC_ID=50831880232108032, SCC_CLASS=, SCC_SDT_CODE=, SCC_ORDER=20}');
INSERT INTO `sys_log_text` VALUES ('52293842530992128', '52293842489049088', '更新配置列表字段,配置列表:资助管理-学院奖学金,更新前:,更新后:{SCC_NAME=审核状态, SVR_TABLE_NAME=SYS_CONFIGURE_COLUMN, SCC_FUNC=processLogFunc(targets, field);, SCC_IS_MERGE=, SCC_ALIGN=center, SCC_IS_STATUS=0, SCC_WIDTH=90px, SCC_FIELD=PROCESS_STATUS_NAME, SCC_IS_VISIBLE=1, SCC_IS_OPERATION=0, ID=50847196098068480, SC_ID=50831880232108032, SCC_CLASS=, SCC_SDT_CODE=, SCC_ORDER=75}');
INSERT INTO `sys_log_text` VALUES ('52293868686671872', '52293868653117440', '更新配置列表字段,配置列表:资助管理-学院奖学金,更新前:,更新后:{SCC_NAME=审核状态, SVR_TABLE_NAME=SYS_CONFIGURE_COLUMN, SCC_FUNC=processLogFunc(targets, field);, SCC_IS_MERGE=, SCC_ALIGN=center, SCC_IS_STATUS=0, SCC_WIDTH=100px, SCC_FIELD=PROCESS_STATUS_NAME, SCC_IS_VISIBLE=1, SCC_IS_OPERATION=0, ID=50847196098068480, SC_ID=50831880232108032, SCC_CLASS=, SCC_SDT_CODE=, SCC_ORDER=75}');
INSERT INTO `sys_log_text` VALUES ('52293887296798720', '52293887267438592', '更新配置列表字段,配置列表:资助管理-学院奖学金,更新前:,更新后:{SCC_NAME=操作, SVR_TABLE_NAME=SYS_CONFIGURE_COLUMN, SCC_FUNC=, SCC_IS_MERGE=, SCC_ALIGN=center, SCC_IS_STATUS=0, SCC_WIDTH=190px, SCC_FIELD=, SCC_IS_VISIBLE=1, SCC_IS_OPERATION=1, ID=50833943762567168, SC_ID=50831880232108032, SCC_CLASS=, SCC_SDT_CODE=, SCC_ORDER=80}');
INSERT INTO `sys_log_text` VALUES ('52293950446239744', '52293950215553024', '查看配置列表管理');
INSERT INTO `sys_log_text` VALUES ('52293968112648192', '52293968083288064', '删除配置列表,信息:{SC_IS_PAGING=1, SC_NAME=资助管理-年度表彰, SC_JSP=admin/aid/commend/home, SC_VIEW=v_aid_commend, SC_IS_SEARCH=1, SC_IS_SELECT=, ID=52292620512133120, SC_ORDER_BY=BAF_YEAR DESC,BAF_SEMESTER DESC,CONVERT(ID,SIGNED) DESC, SC_IS_SINGLE=, SC_IS_FILTER=}');
INSERT INTO `sys_log_text` VALUES ('52294050065154048', '52294050031599616', '拷贝配置列表:{SC_IS_PAGING=1, SC_NAME=资助管理-年度表彰, SC_JSP=admin/aid/commend/home, SC_VIEW=v_aid_commend, SC_IS_SEARCH=1, SC_IS_SELECT=, ID=52294046697127936, SC_ORDER_BY=BAF_YEAR DESC,BAF_SEMESTER DESC,CONVERT(ID,SIGNED) DESC, SC_IS_SINGLE=, SC_IS_FILTER=}');
INSERT INTO `sys_log_text` VALUES ('52294055861682176', '52294055748435968', '查看设置字段');
INSERT INTO `sys_log_text` VALUES ('52294130922946560', '52294130881003520', '更新配置列表字段,配置列表:资助管理-年度表彰,更新前:,更新后:{SCC_NAME=奖项, SVR_TABLE_NAME=SYS_CONFIGURE_COLUMN, SCC_FUNC=, SCC_IS_MERGE=, SCC_ALIGN=center, SCC_IS_STATUS=0, SCC_WIDTH=80px, SCC_FIELD=BAF_AID_TYPE, SCC_IS_VISIBLE=1, SCC_IS_OPERATION=0, ID=52294048001556480, SC_ID=52294046697127936, SCC_CLASS=, SCC_SDT_CODE=BUS_COMMEND_TYPE, SCC_ORDER=72}');
INSERT INTO `sys_log_text` VALUES ('52294138040680448', '52294137977765888', '查看配置列表管理');
INSERT INTO `sys_log_text` VALUES ('52294144525074432', '52294144411828224', '查看设置搜索');
INSERT INTO `sys_log_text` VALUES ('52294173650321408', '52294173566435328', '更新配置列表搜索,配置列表:资助管理-年度表彰,更新前:,更新后:{SCS_METHOD_TYPE=1, SCS_TYPE=2, SCS_FIELD=BAF_AID_TYPE, SVR_TABLE_NAME=SYS_CONFIGURE_SEARCH, SCS_NAME=奖励类型, SCS_IS_STUDENT_YEAR=1, SCS_SDT_CODE=BUS_COMMEND_TYPE, SCC_IS_VISIBLE=1, ID=52294049444397056, SC_ID=52294046697127936, SCS_REMARK=, SCS_ORDER=40}');
INSERT INTO `sys_log_text` VALUES ('52294177911734272', '52294177827848192', '查看配置列表管理');
INSERT INTO `sys_log_text` VALUES ('52294185985769472', '52294185872523264', '查看菜单管理');
INSERT INTO `sys_log_text` VALUES ('52294281720758272', '52294281687203840', '拷贝菜单:{BUS_PROCESS=100, SM_URL=admin/dataGrid/, SC_NAME=资助管理-学院奖学金, SM_URL_PARAMS=, BUS_PROCESS2=109, SM_PARENT_NAME=资助管理, SM_IS_LEAF=0, IS_STATUS=1, SM_TYPE=1, SM_ORDER=10, SM_CODE=AID:COLLEGE_SCHOLARSHIP, SM_NAME=学院奖学金, SM_PARENTID=50751117243449344, ID=50827078076989440, SC_ID=50831880232108032, SM_CLASSICON=mdi mdi-format-wrap-inline, SM_IS_EXPAND=}');
INSERT INTO `sys_log_text` VALUES ('52294433592311808', '52294433558757376', '更新菜单,更新前:{BUS_PROCESS=100, SM_URL=admin/dataGrid/, SC_NAME=资助管理-学院奖学金, SM_URL_PARAMS=, BUS_PROCESS2=109, SM_PARENT_NAME=资助管理, SM_IS_LEAF=0, IS_STATUS=1, SM_TYPE=1, SM_ORDER=10, SM_CODE=AID:COMMEND, SM_NAME=年度表彰, SM_PARENTID=50751117243449344, ID=52294280579907584, SC_ID=50831880232108032, SM_CLASSICON=mdi mdi-format-wrap-inline, SM_IS_EXPAND=},更新后:{BUS_PROCESS=100, SM_URL=admin/dataGrid/, SVR_TABLE_NAME=SYS_MENU, SM_URL_PARAMS=, BUS_PROCESS2=109, SM_IS_LEAF=0, IS_STATUS=null, SM_TYPE=1, SM_ORDER=20, SM_CODE=AID:COMMEND, SM_NAME=年度表彰, SM_PARENTID=50751117243449344, ID=52294280579907584, SC_ID=52294046697127936, SM_CLASSICON=mdi mdi-comment-check, SM_IS_EXPAND=}');
INSERT INTO `sys_log_text` VALUES ('52297608336506880', '52297608307146752', '更新菜单,更新前:{BUS_PROCESS=100, SM_URL=admin/dataGrid/, SC_NAME=资助管理-年度表彰, SM_URL_PARAMS=, BUS_PROCESS2=109, SM_PARENT_NAME=资助管理, SM_IS_LEAF=0, IS_STATUS=1, SM_TYPE=1, SM_ORDER=20, SM_CODE=AID:COMMEND, SM_NAME=年度表彰, SM_PARENTID=50751117243449344, ID=52294280579907584, SC_ID=52294046697127936, SM_CLASSICON=mdi mdi-comment-check, SM_IS_EXPAND=},更新后:{BUS_PROCESS=100, SM_URL=admin/dataGrid/, SVR_TABLE_NAME=SYS_MENU, SM_URL_PARAMS=, BUS_PROCESS2=110, SM_IS_LEAF=0, IS_STATUS=null, SM_TYPE=1, SM_ORDER=20, SM_CODE=AID:COMMEND, SM_NAME=年度表彰, SM_PARENTID=50751117243449344, ID=52294280579907584, SC_ID=52294046697127936, SM_CLASSICON=mdi mdi-comment-check, SM_IS_EXPAND=}');
INSERT INTO `sys_log_text` VALUES ('52297665672642560', '52297665085440000', '查看流程定义');
INSERT INTO `sys_log_text` VALUES ('52297784614715392', '52297784396611584', '拷贝流程定义:{BUS_PROCESS=100, SPD_COLLEGE_FIELD=BDM_COLLEGE, SR_ID=50858364522987520, SO_ID=1, SAI_NAME=admin, SPD_DESCRIBE=, BUS_PROCESS2=110, SPD_CLASS_FIELD=BC_ID, IS_STATUS=1, SPD_DEPARTMENT_FIELD=BDM_ID, SPD_UPDATE_TABLE=V_AID_COMMEND, IS_MULTISTAGE_BACK=1, SPD_VERSION=1.0, SDP_ENTRY_TIME=2018-08-12 23:07:07, SR_NAME=查看学校奖学金, ID=52297782794387456, SPD_UPDATE_NAME=BS_NAME, SPD_NAME=资助管理-年度表彰}');
INSERT INTO `sys_log_text` VALUES ('52297820471820288', '52297820446654464', '更新流程定义,更新前:{BUS_PROCESS=100, SPD_COLLEGE_FIELD=BDM_COLLEGE, SR_ID=50858364522987520, SO_ID=1, SAI_NAME=admin, SPD_DESCRIBE=, BUS_PROCESS2=109, SPD_CLASS_FIELD=BC_ID, IS_STATUS=1, SPD_DEPARTMENT_FIELD=BDM_ID, SPD_UPDATE_TABLE=V_COLLEGE_SCHOLARSHIP, IS_MULTISTAGE_BACK=1, SPD_VERSION=1.0, SDP_ENTRY_TIME=2018-08-12 23:07:07, SR_NAME=查看学校奖学金, ID=50838310695731200, SPD_UPDATE_NAME=BS_NAME, SPD_NAME=学院奖学金},更新后:{BUS_PROCESS=100, SPD_COLLEGE_FIELD=BDM_COLLEGE, SVR_TABLE_NAME=SYS_PROCESS_DEFINITION, SR_ID=50858364522987520, SO_ID=null, SPD_DESCRIBE=, BUS_PROCESS2=109, SPD_CLASS_FIELD=BC_ID, IS_STATUS=null, SPD_DEPARTMENT_FIELD=BDM_ID, SPD_UPDATE_TABLE=V_COLLEGE_SCHOLARSHIP, IS_MULTISTAGE_BACK=1, SPD_VERSION=1.0, SDP_ENTRY_TIME=null, ID=50838310695731200, SPD_UPDATE_NAME=BS_NAME, SPD_NAME=资助管理-学院奖学金}');
INSERT INTO `sys_log_text` VALUES ('52297857482358784', '52297857218117632', '查看流程步骤');
INSERT INTO `sys_log_text` VALUES ('52297885751967744', '52297885416423424', '查看启动角色');
INSERT INTO `sys_log_text` VALUES ('52297988839571456', '52297988646633472', '查看配置列表管理');
INSERT INTO `sys_log_text` VALUES ('52298035190824960', '52298034754617344', '查看设置搜索');
INSERT INTO `sys_log_text` VALUES ('52298207882903552', '52298207480250368', '查看启动角色');
INSERT INTO `sys_log_text` VALUES ('52298323926712320', '52298323893157888', '更新配置列表搜索,配置列表:流程管理-流程启动角色,更新前:,更新后:{SCS_METHOD_TYPE=1, SCS_TYPE=1, SCS_FIELD=SPD_ID, SVR_TABLE_NAME=SYS_CONFIGURE_SEARCH, SCS_NAME=SPD_ID, SCS_IS_STUDENT_YEAR=1, SCS_SDT_CODE=, SCC_IS_VISIBLE=0, ID=28000645642452992, SC_ID=27999782165282816, SCS_REMARK=, SCS_ORDER=99}');
INSERT INTO `sys_log_text` VALUES ('52298331333853184', '52298331241578496', '查看启动角色');
INSERT INTO `sys_log_text` VALUES ('52298354402525184', '52298354176032768', '查看流程步骤');
INSERT INTO `sys_log_text` VALUES ('52298361788694528', '52298361692225536', '查看启动角色');
INSERT INTO `sys_log_text` VALUES ('52299118164312064', '52299118122369024', '删除流程开始角色,信息:{SR_ID=27635893028257792, SPD_ID=52297782794387456, SR_NAME=测试角色2, ID=52297783830380544}');
INSERT INTO `sys_log_text` VALUES ('52299124686454784', '52299124610957312', '删除流程开始角色,信息:{SR_ID=4095556896948224, SPD_ID=52297782794387456, SR_NAME=测试角色, ID=52297783780048896}');
INSERT INTO `sys_log_text` VALUES ('52299149327990784', '52299149281853440', '查看字典管理');
INSERT INTO `sys_log_text` VALUES ('52299151274147840', '52299151131541504', '查看角色管理');
INSERT INTO `sys_log_text` VALUES ('52299342639267840', '52299342609907712', '添加角色:{SR_CODE=COMMEND, IS_STATUS=1, SVR_TABLE_NAME=SYS_ROLE, SR_EXPLAIN=年度表彰管理, SR_NAME=年度表彰管理, ID=52299342316306432, SR_REMARK=, SR_TYPE=3}');
INSERT INTO `sys_log_text` VALUES ('52299464391524352', '52299464362164224', '添加角色:{SR_CODE=ALL_COMMEND, IS_STATUS=1, SVR_TABLE_NAME=SYS_ROLE, SR_EXPLAIN=查看全部年度表彰数据, SR_NAME=查看年度表彰, ID=52299464139866112, SR_REMARK=, SR_TYPE=2}');
INSERT INTO `sys_log_text` VALUES ('52299501318176768', '52299501276233728', '更新角色,更新前:{SR_CODE=ALL_COLLEGE_SCHOLARSHIP, IS_STATUS=1, SR_EXPLAIN=, SR_NAME=查看学校奖学金, ID=50858364522987520, SR_REMARK=, SR_TYPE=2},更新后:{SR_CODE=ALL_COLLEGE_SCHOLARSHIP, IS_STATUS=null, SVR_TABLE_NAME=SYS_ROLE, SR_EXPLAIN=查看学校奖学金全部数据, SR_NAME=查看学校奖学金, ID=50858364522987520, SR_REMARK=, SR_TYPE=2}');
INSERT INTO `sys_log_text` VALUES ('52299546490830848', '52299546457276416', '角色:年度表彰管理,旧菜单:,新菜单:[52294280949006336, 52294280579907584, 50751117243449344]');
INSERT INTO `sys_log_text` VALUES ('52299564652167168', '52299564446646272', '角色:年度表彰管理,旧菜单:[52294280949006336, 50751117243449344, 52294280579907584],新菜单:[52294280949006336, 52294280579907584, 50751117243449344]');
INSERT INTO `sys_log_text` VALUES ('52299612886663168', '52299612844720128', '角色:查看年度表彰,旧菜单:,新菜单:[52294280579907584, 50751117243449344]');
INSERT INTO `sys_log_text` VALUES ('52299664023617536', '52299663990063104', '更新流程开始角色,更新前:{SR_ID=50836827770191872, SPD_ID=52297782794387456, SR_NAME=学校奖学金管理, ID=52297784262393856},更新后:{SPD_ID=52297782794387456, ID=52297784262393856, SR_ID=52299342316306432}');
INSERT INTO `sys_log_text` VALUES ('52299690988797952', '52299690963632128', '更新流程定义,更新前:{BUS_PROCESS=100, SPD_COLLEGE_FIELD=BDM_COLLEGE, SR_ID=50858364522987520, SO_ID=1, SAI_NAME=admin, SPD_DESCRIBE=, BUS_PROCESS2=110, SPD_CLASS_FIELD=BC_ID, IS_STATUS=1, SPD_DEPARTMENT_FIELD=BDM_ID, SPD_UPDATE_TABLE=V_AID_COMMEND, IS_MULTISTAGE_BACK=1, SPD_VERSION=1.0, SDP_ENTRY_TIME=2018-08-12 23:07:07, SR_NAME=查看学校奖学金, ID=52297782794387456, SPD_UPDATE_NAME=BS_NAME, SPD_NAME=资助管理-年度表彰},更新后:{BUS_PROCESS=100, SPD_COLLEGE_FIELD=BDM_COLLEGE, SVR_TABLE_NAME=SYS_PROCESS_DEFINITION, SR_ID=52299464139866112, SO_ID=null, SPD_DESCRIBE=, BUS_PROCESS2=110, SPD_CLASS_FIELD=BC_ID, IS_STATUS=null, SPD_DEPARTMENT_FIELD=BDM_ID, SPD_UPDATE_TABLE=V_AID_COMMEND, IS_MULTISTAGE_BACK=1, SPD_VERSION=1.0, SDP_ENTRY_TIME=null, ID=52297782794387456, SPD_UPDATE_NAME=BS_NAME, SPD_NAME=资助管理-年度表彰}');
INSERT INTO `sys_log_text` VALUES ('52299717844926464', '52299717496799232', '查看流程步骤');
INSERT INTO `sys_log_text` VALUES ('52299720508309504', '52299720382480384', '查看启动角色');
INSERT INTO `sys_log_text` VALUES ('52299725491142656', '52299725428228096', '查看流程步骤');
INSERT INTO `sys_log_text` VALUES ('52299807091326976', '52299806701256704', '查看配置列表管理');
INSERT INTO `sys_log_text` VALUES ('52299810912337920', '52299810845229056', '查看字典管理');
INSERT INTO `sys_log_text` VALUES ('52299823218425856', '52299823021293568', '查看字典信息');
INSERT INTO `sys_log_text` VALUES ('52299842893905920', '52299842721939456', '查看字典管理');
INSERT INTO `sys_log_text` VALUES ('52299866138738688', '52299865924829184', '查看字典信息');
INSERT INTO `sys_log_text` VALUES ('52299963543060480', '52299963513700352', '添加字典类型:{SDI_CODE=6, SVR_TABLE_NAME=SYS_DICT_INFO, SDI_REQUIRED=0, SDI_ORDER=6, SDI_REMARK=, SDI_NAME=年度表彰, SDI_PARENTID=0, IS_STATUS=1, SDT_CODE=SYS_PROCESS_STATUS, SDI_INNERCODE=6, ID=52299963194933248, SDT_ID=27191919998140416}');
INSERT INTO `sys_log_text` VALUES ('52299977623339008', '52299977455566848', '查看字典管理');
INSERT INTO `sys_log_text` VALUES ('52300054102278144', '52300054072918016', '更新流程步骤,更新前:{SPS_NAME=启动人员, SR_ID=50836827770191872, SPS_STEP_TYPE=1, SPS_OVER_TIME=, SPS_ORDER=1, SPS_TAB=系部人员, SPS_PROCESS_STATUS=5, SPS_IS_ADVANCE_CHECK=1, SPS_IS_ADVANCE_EXECUTE=0, SPD_ID=52297782794387456, SR_NAME=学校奖学金管理, ID=52297782974742528, SPS_IS_RETREAT_CHECK=0, SPS_IS_RETREAT_EXECUTE=0, SPS_IS_OVER_TIME=0},更新后:{SPS_NAME=启动人员, SVR_TABLE_NAME=SYS_PROCESS_STEP, SR_ID=52299342316306432, SPS_STEP_TYPE=1, SPS_OVER_TIME=, SPS_ORDER=1, SPS_TAB=系部人员, SPS_PROCESS_STATUS=6, SPS_IS_ADVANCE_CHECK=1, SPS_IS_ADVANCE_EXECUTE=0, SPD_ID=52297782794387456, ID=52297782974742528, SPS_IS_RETREAT_CHECK=0, NOT_ID=52297782974742528, SPS_IS_RETREAT_EXECUTE=0, SPS_IS_OVER_TIME=0}');
INSERT INTO `sys_log_text` VALUES ('52300099526590464', '52300099111354368', '查看启动角色');
INSERT INTO `sys_log_text` VALUES ('52300100818436096', '52300100692606976', '查看流程步骤');
INSERT INTO `sys_log_text` VALUES ('52300103649591296', '52300103477624832', '查看流程定义');
INSERT INTO `sys_log_text` VALUES ('52300113246158848', '52300112973529088', '查看菜单管理');
INSERT INTO `sys_log_text` VALUES ('52300167134576640', '52300166669008896', '查看角色管理');
INSERT INTO `sys_log_text` VALUES ('52300203281088512', '52300203251728384', '角色:超级管理员,旧菜单:[1757509987598336, 2258969972178944, 26571410583322624, 26511186237325312, 26571551922978816, 50751117243449344, 2269941063483392, 48614229862776832, 49030149684854784, 50328019348226048, 38162771866550273, 48892279221387264, 38162771866550272, 2163861868249088, 23657888534757376, 28019952082485248, 21130604443598848, 26715728707059712, 48295058385928192, 48295058385928193, 20766815625936896, 21131205961318400, 48892124845834240, 1560059138015232, 26577844645658624, 49027088874733568, 52235902763663360, 26476504758091776, 1, 3316536806735872, 2, 26845813934129152, 3, 26714856669315072, 50338340347576320, 7, 49028146267160576, 2163592187084800, 8, 9, 49029256612675584, 48614104260149248, 49029176400805888, 52184511034687488, 1448716162564096, 3547951557246976, 49027774555357184, 2258672239509504, 50827078936821760, 38116041032728576, 52235853056966656, 33081241360138240, 38161659570683904, 48304916703215616, 48304916703215617, 38161659570683905, 13358417838080, 50827078076989440, 52184510715920384, 48667624430632960, 52259024812376064, 48673777285857280, 1451155909509120, 4103758959083520, 26577007949119488, 26579469829406720, 50341592241799168, 1846593582006272, 1427690443767808, 2910350022279168],新菜单:[1757509987598336, 2258969972178944, 26571410583322624, 26571551922978816, 26511186237325312, 50751117243449344, 2269941063483392, 48614229862776832, 49030149684854784, 50328019348226048, 48892279221387264, 38162771866550273, 38162771866550272, 23657888534757376, 2163861868249088, 28019952082485248, 21130604443598848, 26715728707059712, 48295058385928192, 48295058385928193, 20766815625936896, 21131205961318400, 48892124845834240, 26577844645658624, 1560059138015232, 49027088874733568, 52235902763663360, 26476504758091776, 3316536806735872, 1, 2, 26845813934129152, 3, 26714856669315072, 50338340347576320, 49028146267160576, 7, 2163592187084800, 8, 9, 49029256612675584, 48614104260149248, 52184511034687488, 49029176400805888, 3547951557246976, 1448716162564096, 49027774555357184, 2258672239509504, 50827078936821760, 38116041032728576, 52235853056966656, 33081241360138240, 38161659570683904, 48304916703215616, 48304916703215617, 38161659570683905, 13358417838080, 52294280949006336, 52184510715920384, 50827078076989440, 48667624430632960, 52259024812376064, 48673777285857280, 4103758959083520, 1451155909509120, 26577007949119488, 50341592241799168, 26579469829406720, 1846593582006272, 1427690443767808, 52294280579907584, 2910350022279168]');
INSERT INTO `sys_log_text` VALUES ('52300230023970816', '52300229998804992', '角色:超级管理员,菜单名称:年度表彰,旧按钮:,新按钮:[1, 793777245519872, 793562643955712, 48286237202579456]');
INSERT INTO `sys_log_text` VALUES ('52300235111661568', '52300235069718528', '角色:超级管理员,菜单名称:年度表彰,旧按钮:[1, 793777245519872, 793562643955712, 48286237202579456],新按钮:[1, 793777245519872, 793562643955712]');
INSERT INTO `sys_log_text` VALUES ('52300244771143680', '52300244704034816', '角色:超级管理员,菜单名称:编辑,旧按钮:,新按钮:[763206804963328]');
INSERT INTO `sys_log_text` VALUES ('52300257614102528', '52300257580548096', '角色:超级管理员,菜单名称:学院奖学金,旧按钮:[1, 793777245519872, 793562643955712, 48286237202579456],新按钮:[1, 793777245519872, 793562643955712]');
INSERT INTO `sys_log_text` VALUES ('52300642730901504', '52300642550546432', '查看配置列表管理');
INSERT INTO `sys_log_text` VALUES ('52300721441210368', '52300721059528704', '查看设置字段');
INSERT INTO `sys_log_text` VALUES ('52300884930985984', '52300884893237248', '更新配置列表字段,配置列表:资助管理-年度表彰,更新前:,更新后:{SCC_NAME=操作, SVR_TABLE_NAME=SYS_CONFIGURE_COLUMN, SCC_FUNC=, SCC_IS_MERGE=, SCC_ALIGN=center, SCC_IS_STATUS=0, SCC_WIDTH=200px, SCC_FIELD=, SCC_IS_VISIBLE=1, SCC_IS_OPERATION=1, ID=52294048408403968, SC_ID=52294046697127936, SCC_CLASS=, SCC_SDT_CODE=, SCC_ORDER=80}');
INSERT INTO `sys_log_text` VALUES ('52300989708894208', '52300989650173952', '添加配置列表字段,配置列表:资助管理-年度表彰,字段参数{SCC_NAME=学年, SVR_TABLE_NAME=SYS_CONFIGURE_COLUMN, SCC_FUNC=, SCC_IS_MERGE=, SCC_ALIGN=center, SCC_IS_STATUS=0, SCC_WIDTH=100px, SCC_FIELD=BAF_YEAR, SCC_IS_VISIBLE=1, SCC_IS_OPERATION=0, ID=52300989453041664, SC_ID=52294046697127936, SCC_CLASS=, SCC_SDT_CODE=, SCC_ORDER=35}');
INSERT INTO `sys_log_text` VALUES ('52301044742356992', '52301044700413952', '添加配置列表字段,配置列表:资助管理-年度表彰,字段参数{SCC_NAME=学期, SVR_TABLE_NAME=SYS_CONFIGURE_COLUMN, SCC_FUNC=, SCC_IS_MERGE=, SCC_ALIGN=center, SCC_IS_STATUS=0, SCC_WIDTH=100px, SCC_FIELD=BAF_SEMESTER, SCC_IS_VISIBLE=1, SCC_IS_OPERATION=0, ID=52301044171931648, SC_ID=52294046697127936, SCC_CLASS=, SCC_SDT_CODE=BUS_SEMESTER, SCC_ORDER=36}');
INSERT INTO `sys_log_text` VALUES ('52301057291714560', '52301057245577216', '查看配置列表管理');
INSERT INTO `sys_log_text` VALUES ('52301064304590848', '52301064203927552', '查看设置字段');
INSERT INTO `sys_log_text` VALUES ('52301088509919232', '52301088480559104', '删除配置列表字段,配置列表:资助管理-年度表彰字段:{SCC_NAME=学期, SCC_FUNC=, SCC_IS_MERGE=, SCC_ALIGN=center, SCC_IS_STATUS=0, SCC_WIDTH=100px, SCC_FIELD=BAF_SEMESTER, SCC_IS_VISIBLE=1, SCC_IS_OPERATION=0, ID=52301044171931648, SC_ID=52294046697127936, SCC_CLASS=, SCC_SDT_CODE=BUS_SEMESTER, SCC_ORDER=36}');
INSERT INTO `sys_log_text` VALUES ('52301091546595328', '52301091445932032', '查看配置列表管理');
INSERT INTO `sys_log_text` VALUES ('52301098886627328', '52301098769186816', '查看设置字段');
INSERT INTO `sys_log_text` VALUES ('52301132743049216', '52301132659163136', '添加配置列表字段,配置列表:资助管理-学院奖学金,字段参数{SCC_NAME=学年, SVR_TABLE_NAME=SYS_CONFIGURE_COLUMN, SCC_FUNC=, SCC_IS_MERGE=, SCC_ALIGN=center, SCC_IS_STATUS=0, SCC_WIDTH=100px, SCC_FIELD=BAF_YEAR, SCC_IS_VISIBLE=1, SCC_IS_OPERATION=0, ID=52301132520751104, SC_ID=50831880232108032, SCC_CLASS=, SCC_SDT_CODE=, SCC_ORDER=35}');
INSERT INTO `sys_log_text` VALUES ('52301184643366912', '52301184609812480', '添加配置列表字段,配置列表:资助管理-学院奖学金,字段参数{SCC_NAME=学期, SVR_TABLE_NAME=SYS_CONFIGURE_COLUMN, SCC_FUNC=, SCC_IS_MERGE=, SCC_ALIGN=center, SCC_IS_STATUS=0, SCC_WIDTH=100px, SCC_FIELD=BAF_SEMESTER, SCC_IS_VISIBLE=1, SCC_IS_OPERATION=0, ID=52301184400097280, SC_ID=50831880232108032, SCC_CLASS=, SCC_SDT_CODE=BUS_SEMESTER, SCC_ORDER=36}');
INSERT INTO `sys_log_text` VALUES ('52301199818358784', '52301199713501184', '查看配置列表管理');
INSERT INTO `sys_log_text` VALUES ('52302342212550656', '52302341759565824', '登录成功!登录地址:未知');
INSERT INTO `sys_log_text` VALUES ('52302364970844160', '52302364882763776', '查看查看日志');
INSERT INTO `sys_log_text` VALUES ('52302372591894528', '52302372394762240', '查看登录日志');
INSERT INTO `sys_log_text` VALUES ('52302385824923648', '52302385611014144', '查看操作日志');
INSERT INTO `sys_log_text` VALUES ('52302476598050816', '52302476153454592', '查看登录日志');
INSERT INTO `sys_log_text` VALUES ('52302479496314880', '52302479370485760', '查看操作日志');
INSERT INTO `sys_log_text` VALUES ('52302481824153600', '52302481656381440', '查看系统日志');
INSERT INTO `sys_log_text` VALUES ('52302599591821312', '52302599344357376', '查看年度表彰');
INSERT INTO `sys_log_text` VALUES ('52302614338994176', '52302614208970752', '查看学院奖学金');
INSERT INTO `sys_log_text` VALUES ('52302703304376320', '52302703111438336', '查看学院奖学金');
INSERT INTO `sys_log_text` VALUES ('52302710279503872', '52302710183034880', '查看年度表彰');
INSERT INTO `sys_log_text` VALUES ('52302750192500736', '52302749856956416', '查看学院奖学金');
INSERT INTO `sys_log_text` VALUES ('52302761999466496', '52302761861054464', '查看年度表彰');
INSERT INTO `sys_log_text` VALUES ('52302765501710336', '52302765384269824', '查看学院奖学金');
INSERT INTO `sys_log_text` VALUES ('52302768622272512', '52302768517414912', '查看年度表彰');
INSERT INTO `sys_log_text` VALUES ('52302770673287168', '52302770622955520', '查看学院奖学金');
INSERT INTO `sys_log_text` VALUES ('52302779988836352', '52302779837841408', '查看考勤管理');
INSERT INTO `sys_log_text` VALUES ('52302791422509056', '52302791313457152', '查看学院奖学金');
INSERT INTO `sys_log_text` VALUES ('52302833944363008', '52302833675927552', '查看学生管理');
INSERT INTO `sys_log_text` VALUES ('52303022037925888', '52303021790461952', '查看学生管理');
INSERT INTO `sys_log_text` VALUES ('52303279865987072', '52303279622717440', '查看年度表彰');
INSERT INTO `sys_log_text` VALUES ('52303285440217088', '52303285326970880', '查看学院奖学金');
INSERT INTO `sys_log_text` VALUES ('52303290502742016', '52303290448216064', '查看年度表彰');
INSERT INTO `sys_log_text` VALUES ('52303297746305024', '52303297712750592', '查看学院奖学金');
INSERT INTO `sys_log_text` VALUES ('52303299751182336', '52303299709239296', '查看年度表彰');
INSERT INTO `sys_log_text` VALUES ('52304715312005120', '52304714863214592', '查看系部管理');
INSERT INTO `sys_log_text` VALUES ('52304725562884096', '52304725307031552', '查看系部人员管理');
INSERT INTO `sys_log_text` VALUES ('52304768906821632', '52304768864878592', '操作员:department_test,旧角色:[50836827770191872, 48309528801837056],新角色:[50836827770191872, 52299342316306432, 48309528801837056]');
INSERT INTO `sys_log_text` VALUES ('52304775433158656', '52304775286358016', '查看部门人员管理');
INSERT INTO `sys_log_text` VALUES ('52304798900289536', '52304798854152192', '操作员:division_test,旧角色:[50858364522987520, 48307839919194112],新角色:[50858364522987520, 48307839919194112, 52299464139866112]');
INSERT INTO `sys_log_text` VALUES ('52304848804118528', '52304848686678016', '登录成功!登录地址:未知');
INSERT INTO `sys_log_text` VALUES ('52304857259835392', '52304856840404992', '查看学院奖学金');
INSERT INTO `sys_log_text` VALUES ('52304865610694656', '52304865484865536', '查看年度表彰');
INSERT INTO `sys_log_text` VALUES ('52304915648741376', '52304915367723008', '登录成功!登录地址:未知');
INSERT INTO `sys_log_text` VALUES ('52304944098705408', '52304943918350336', '查看角色管理');
INSERT INTO `sys_log_text` VALUES ('52305013837398016', '52305013782872064', '角色:年度表彰管理,菜单名称:年度表彰,旧按钮:,新按钮:[48286237202579456]');
INSERT INTO `sys_log_text` VALUES ('52305029855444992', '52305029377294336', '查看年度表彰');
INSERT INTO `sys_log_text` VALUES ('52305261263585280', '52305260978372608', '检测数据异常!');
INSERT INTO `sys_log_text` VALUES ('52305305266028544', '52305305198919680', '查看学生管理');
INSERT INTO `sys_log_text` VALUES ('52305395598753792', '52305395540033536', '导入学院奖学金,数据:[[Ljava.lang.String;@19f61a0b]');
INSERT INTO `sys_log_text` VALUES ('52306085314297856', '52306084970364928', '查看年度表彰');
INSERT INTO `sys_log_text` VALUES ('52306244551049216', '52306244202921984', '导入学院奖学金,数据:[[Ljava.lang.String;@2f1751c1]');
INSERT INTO `sys_log_text` VALUES ('52306321101291520', '52306320639918080', '查看配置列表管理');
INSERT INTO `sys_log_text` VALUES ('52306344253849600', '52306344119631872', '查看设置字段');
INSERT INTO `sys_log_text` VALUES ('52306487938121728', '52306487904567296', '添加配置列表字段,配置列表:资助管理-年度表彰,字段参数{SCC_NAME=学期, SVR_TABLE_NAME=SYS_CONFIGURE_COLUMN, SCC_FUNC=, SCC_IS_MERGE=, SCC_ALIGN=center, SCC_IS_STATUS=0, SCC_WIDTH=100px, SCC_FIELD=BAF_SEMESTER, SCC_IS_VISIBLE=1, SCC_IS_OPERATION=0, ID=52306487673880576, SC_ID=52294046697127936, SCC_CLASS=, SCC_SDT_CODE=BUS_SEMESTER, SCC_ORDER=36}');
INSERT INTO `sys_log_text` VALUES ('52307188521107456', '52307188374306816', '登录成功!登录地址:未知');
INSERT INTO `sys_log_text` VALUES ('52307201909325824', '52307201800273920', '查看年度表彰');
INSERT INTO `sys_log_text` VALUES ('52307216434200576', '52307216383868928', '查看学院奖学金');
INSERT INTO `sys_log_text` VALUES ('52307221169569792', '52307221064712192', '查看年度表彰');
INSERT INTO `sys_log_text` VALUES ('52307223824564224', '52307223757455360', '查看学院奖学金');
INSERT INTO `sys_log_text` VALUES ('52307225850413056', '52307225720389632', '查看年度表彰');
INSERT INTO `sys_log_text` VALUES ('52307228002091008', '52307227893039104', '查看学院奖学金');
INSERT INTO `sys_log_text` VALUES ('52307230090854400', '52307230040522752', '查看年度表彰');
INSERT INTO `sys_log_text` VALUES ('52307232003457024', '52307231953125376', '查看学院奖学金');
INSERT INTO `sys_log_text` VALUES ('52307250152210432', '52307249988632576', '查看年度表彰');
INSERT INTO `sys_log_text` VALUES ('52307341533511680', '52307341160218624', '查看学院奖学金');
INSERT INTO `sys_log_text` VALUES ('52307420206071808', '52307420046688256', '查看年度表彰');
INSERT INTO `sys_log_text` VALUES ('52308713020588032', '52308712525660160', '查看部门人员管理');
INSERT INTO `sys_log_text` VALUES ('52308726593355776', '52308726446555136', '查看菜单管理');
INSERT INTO `sys_log_text` VALUES ('52308782805417984', '52308782746697728', '菜单:部门人员管理,旧按钮:[1, 48287050272604160, 3008659554566144, 28283426524102656, 793562643955712, 3375831514611712],新按钮:[51562014773870592, 1, 48287050272604160, 3008659554566144, 28283426524102656, 793562643955712, 3375831514611712]');
INSERT INTO `sys_log_text` VALUES ('52308787658227712', '52308787599507456', '查看角色管理');
INSERT INTO `sys_log_text` VALUES ('52308932785340416', '52308932655316992', '角色:超级管理员,旧菜单:[1757509987598336, 2258969972178944, 26571410583322624, 26511186237325312, 26571551922978816, 50751117243449344, 2269941063483392, 48614229862776832, 49030149684854784, 50328019348226048, 38162771866550273, 48892279221387264, 38162771866550272, 2163861868249088, 23657888534757376, 28019952082485248, 21130604443598848, 26715728707059712, 48295058385928192, 48295058385928193, 20766815625936896, 21131205961318400, 48892124845834240, 1560059138015232, 26577844645658624, 49027088874733568, 52235902763663360, 26476504758091776, 1, 3316536806735872, 2, 26845813934129152, 3, 26714856669315072, 50338340347576320, 7, 49028146267160576, 2163592187084800, 8, 9, 49029256612675584, 48614104260149248, 49029176400805888, 52184511034687488, 1448716162564096, 3547951557246976, 49027774555357184, 2258672239509504, 50827078936821760, 38116041032728576, 52235853056966656, 33081241360138240, 38161659570683904, 48304916703215616, 48304916703215617, 38161659570683905, 13358417838080, 52294280949006336, 50827078076989440, 52184510715920384, 48667624430632960, 52259024812376064, 48673777285857280, 1451155909509120, 4103758959083520, 26577007949119488, 26579469829406720, 50341592241799168, 1846593582006272, 1427690443767808, 52294280579907584, 2910350022279168],新菜单:[1757509987598336, 2258969972178944, 26571410583322624, 26571551922978816, 26511186237325312, 50751117243449344, 2269941063483392, 48614229862776832, 49030149684854784, 50328019348226048, 48892279221387264, 38162771866550273, 38162771866550272, 23657888534757376, 2163861868249088, 28019952082485248, 21130604443598848, 26715728707059712, 48295058385928192, 48295058385928193, 20766815625936896, 21131205961318400, 48892124845834240, 26577844645658624, 1560059138015232, 49027088874733568, 52235902763663360, 26476504758091776, 3316536806735872, 1, 2, 26845813934129152, 3, 26714856669315072, 50338340347576320, 49028146267160576, 7, 2163592187084800, 8, 9, 49029256612675584, 48614104260149248, 52184511034687488, 49029176400805888, 3547951557246976, 1448716162564096, 49027774555357184, 2258672239509504, 50827078936821760, 38116041032728576, 52235853056966656, 33081241360138240, 38161659570683904, 48304916703215616, 48304916703215617, 38161659570683905, 13358417838080, 52294280949006336, 52184510715920384, 50827078076989440, 48667624430632960, 52259024812376064, 48673777285857280, 4103758959083520, 1451155909509120, 26577007949119488, 50341592241799168, 26579469829406720, 1846593582006272, 1427690443767808, 52294280579907584, 2910350022279168]');
INSERT INTO `sys_log_text` VALUES ('52308943199797248', '52308943023636480', '角色:超级管理员,菜单名称:部门人员管理,旧按钮:[1, 48287050272604160, 3008659554566144, 28283426524102656, 793562643955712, 3375831514611712],新按钮:[51562014773870592, 1, 48287050272604160, 3008659554566144, 28283426524102656, 793562643955712, 3375831514611712]');
INSERT INTO `sys_log_text` VALUES ('52308962137079808', '52308962002862080', '查看系部管理');
INSERT INTO `sys_log_text` VALUES ('52308969980428288', '52308969728770048', '查看部门人员管理');
INSERT INTO `sys_log_text` VALUES ('52309007624306688', '52309007414591488', '查看部门管理');
INSERT INTO `sys_log_text` VALUES ('52309018110066688', '52309017950683136', '查看学院奖学金');
INSERT INTO `sys_log_text` VALUES ('52309028474191872', '52309028323196928', '查看年度表彰');
INSERT INTO `sys_log_text` VALUES ('52309246829658112', '52309246460559360', '查看学生管理');
INSERT INTO `sys_log_text` VALUES ('52309273723535360', '52309273643843584', '查看账户管理');
INSERT INTO `sys_log_text` VALUES ('52309291670962176', '52309291503190016', '添加账号信息:{IS_STATUS=1, SOS_CREATETIME=2018-08-17 00:32:16, SVR_TABLE_NAME=SYS_OPERATOR_SUB, SOS_REMARK=, SOS_DEFAULT=1, SO_ID=51930103373889536, ID=52309291238948864, SOS_USERNAME=student_test2}');
INSERT INTO `sys_log_text` VALUES ('52309296033038336', '52309295949152256', '查看学生管理');
INSERT INTO `sys_log_text` VALUES ('52309429999108096', '52309429520957440', '登录成功!登录地址:未知');
INSERT INTO `sys_log_text` VALUES ('52309475830267904', '52309475788324864', '操作员:student_test2,旧角色:,新角色:[48892526509162496]');
INSERT INTO `sys_log_text` VALUES ('52309515588075520', '52309515298668544', '登录成功!登录地址:未知');
INSERT INTO `sys_log_text` VALUES ('52309705858482176', '52309705795567616', '登录成功!登录地址:未知');
INSERT INTO `sys_log_text` VALUES ('52309712997187584', '52309712875552768', '查看学院奖学金');
INSERT INTO `sys_log_text` VALUES ('52310553187581952', '52310552482938880', '查看学院奖学金');
INSERT INTO `sys_log_text` VALUES ('52310582472212480', '52310581981478912', '查看角色管理');
INSERT INTO `sys_log_text` VALUES ('52310611635208192', '52310611601653760', '角色:学生,旧菜单:[50827078076989440, 50751117243449344],新菜单:[50827078076989440, 52294280579907584, 50751117243449344]');
INSERT INTO `sys_log_text` VALUES ('52310633382674432', '52310633235873792', '查看学院奖学金');
INSERT INTO `sys_log_text` VALUES ('52310637161742336', '52310636993970176', '查看年度表彰');
INSERT INTO `sys_log_text` VALUES ('52310700722225152', '52310700646727680', '登录成功!登录地址:未知');
INSERT INTO `sys_log_text` VALUES ('52310708435550208', '52310708125171712', '查看年度表彰');
INSERT INTO `sys_log_text` VALUES ('52310711447060480', '52310711338008576', '查看学院奖学金');
INSERT INTO `sys_log_text` VALUES ('52503680041091072', '52503679248367616', '登录成功!登录地址:未知');
INSERT INTO `sys_log_text` VALUES ('52503704745541632', '52503704674238464', '查看角色管理');
INSERT INTO `sys_log_text` VALUES ('52503791185952768', '52503790779105280', '登录成功!登录地址:未知');
INSERT INTO `sys_log_text` VALUES ('52503808055443456', '52503807979945984', '查看字典管理');
INSERT INTO `sys_log_text` VALUES ('52503809523449856', '52503809296957440', '查看角色管理');
INSERT INTO `sys_log_text` VALUES ('52503841383383040', '52503841152696320', '查看角色管理');
INSERT INTO `sys_log_text` VALUES ('52503859699908608', '52503858991071232', '网络异常,请联系管理员!');
INSERT INTO `sys_log_text` VALUES ('52503961957040128', '52503961923485696', '删除角色,信息:{SR_CODE=COMMEND, IS_STATUS=1, SR_EXPLAIN=年度表彰管理, SR_NAME=年度表彰管理, ID=52299342316306432, SR_REMARK=, SR_TYPE=3}');
INSERT INTO `sys_log_text` VALUES ('52503993670172672', '52503993640812544', '删除角色,信息:{SR_CODE=COLLEGE_SCHOLARSHIP, IS_STATUS=1, SR_EXPLAIN=学校奖学金管理, SR_NAME=学校奖学金管理, ID=50836827770191872, SR_REMARK=, SR_TYPE=3}');
INSERT INTO `sys_log_text` VALUES ('52504058635747328', '52504058493140992', '添加角色:{SR_CODE=DEPARTMENT_MANAGER, IS_STATUS=1, SVR_TABLE_NAME=SYS_ROLE, SR_EXPLAIN=, SR_NAME=系管理, ID=52504058379894784, SR_REMARK=, SR_TYPE=3}');
INSERT INTO `sys_log_text` VALUES ('52504086536257536', '52504086502703104', '角色:系管理,旧菜单:,新菜单:[50827078076989440, 52294280579907584, 50751117243449344]');
INSERT INTO `sys_log_text` VALUES ('52504173786169344', '52504173429653504', '查看部门人员管理');
INSERT INTO `sys_log_text` VALUES ('52504181184921600', '52504181008760832', '查看系部人员管理');
INSERT INTO `sys_log_text` VALUES ('52504239385083904', '52504239120842752', '查看角色管理');
INSERT INTO `sys_log_text` VALUES ('52504248251842560', '52504248222482432', '删除角色,信息:{SR_CODE=DEPARTMENT_MANAGER, IS_STATUS=1, SR_EXPLAIN=, SR_NAME=系管理, ID=52504058379894784, SR_REMARK=, SR_TYPE=3}');
INSERT INTO `sys_log_text` VALUES ('52504276458536960', '52504276424982528', '角色:系部管理,旧菜单:,新菜单:[50827078076989440, 52294280579907584, 50751117243449344]');
INSERT INTO `sys_log_text` VALUES ('52504383937576960', '52504383505563648', '登录成功!登录地址:未知');
INSERT INTO `sys_log_text` VALUES ('52504391294386176', '52504391139196928', '查看学生管理');
INSERT INTO `sys_log_text` VALUES ('52504409199869952', '52504409040486400', '查看处分管理');
INSERT INTO `sys_log_text` VALUES ('52504449033175040', '52504448412418048', '查看系部人员管理');
INSERT INTO `sys_log_text` VALUES ('52504513344438272', '52504512954368000', '添加系部人员:{BDMP_NAME=department_manager, SVR_TABLE_NAME=BUS_DEPARTMENT_PERSONNEL, SO_ID=52504512421691393, ID=52504512421691392, BDM_ID=48601265252335616}');
INSERT INTO `sys_log_text` VALUES ('52504590939062272', '52504590909702144', '操作员:department_manager,旧角色:,新角色:[48309996873580544]');
INSERT INTO `sys_log_text` VALUES ('52504597410873344', '52504597238906880', '查看账户管理');
INSERT INTO `sys_log_text` VALUES ('52504621440040960', '52504621414875136', '添加账号信息:{IS_STATUS=1, SOS_CREATETIME=2018-08-17 13:28:26, SVR_TABLE_NAME=SYS_OPERATOR_SUB, SOS_REMARK=, SOS_DEFAULT=1, SO_ID=52504512421691393, ID=52504620978667520, SOS_USERNAME=department_manager}');
INSERT INTO `sys_log_text` VALUES ('52504623851765760', '52504623746908160', '查看系部人员管理');
INSERT INTO `sys_log_text` VALUES ('52504783419867136', '52504783180791808', '登录成功!登录地址:未知');
INSERT INTO `sys_log_text` VALUES ('52504863816286208', '52504863610765312', '登录成功!登录地址:未知');
INSERT INTO `sys_log_text` VALUES ('52504872888565760', '52504872641101824', '查看学院奖学金');
INSERT INTO `sys_log_text` VALUES ('52504879486205952', '52504879444262912', '查看年度表彰');
INSERT INTO `sys_log_text` VALUES ('52504885710553088', '52504885668610048', '查看学院奖学金');
INSERT INTO `sys_log_text` VALUES ('52504919973822464', '52504919441145856', '查看班级管理');
INSERT INTO `sys_log_text` VALUES ('52504996834443264', '52504996662476800', '查看教师管理');
INSERT INTO `sys_log_text` VALUES ('52505015985635328', '52505015859806208', '查看角色管理');
INSERT INTO `sys_log_text` VALUES ('52505068187942912', '52505068141805568', '角色:辅导员,旧菜单:[48892124845834240, 49027774555357184, 49027088874733568, 50338340347576320, 49028146267160576],新菜单:[50827078076989440, 50338340347576320, 48892124845834240, 49028146267160576, 49027774555357184, 49027088874733568, 52294280579907584, 50751117243449344]');
INSERT INTO `sys_log_text` VALUES ('52505080246566912', '52505080221401088', '角色:辅导员,菜单名称:学院奖学金,旧按钮:,新按钮:[793777245519872, 48286237202579456]');
INSERT INTO `sys_log_text` VALUES ('52505089796997120', '52505089767636992', '角色:辅导员,菜单名称:年度表彰,旧按钮:,新按钮:[793777245519872, 48286237202579456]');
INSERT INTO `sys_log_text` VALUES ('52505149834264576', '52505149465165824', '登录成功!登录地址:未知');
INSERT INTO `sys_log_text` VALUES ('52505155882450944', '52505155597238272', '查看学院奖学金');
INSERT INTO `sys_log_text` VALUES ('52505160982724608', '52505160907227136', '查看年度表彰');
INSERT INTO `sys_log_text` VALUES ('52505216959905792', '52505216896991232', '流程办理中不能删除!');
INSERT INTO `sys_log_text` VALUES ('52505230985658368', '52505230893383680', '查看学院奖学金');
INSERT INTO `sys_log_text` VALUES ('52505289349398528', '52505289051602944', '查看字典管理');
INSERT INTO `sys_log_text` VALUES ('52505292771950592', '52505292725813248', '查看配置列表管理');
INSERT INTO `sys_log_text` VALUES ('52505300632076288', '52505300548190208', '查看流程定义');
INSERT INTO `sys_log_text` VALUES ('52505317849694208', '52505317660950528', '查看流程步骤');
INSERT INTO `sys_log_text` VALUES ('52505345221722112', '52505345188167680', '更新流程步骤,更新前:{SPS_NAME=学生处, SR_ID=48307839919194112, SPS_STEP_TYPE=1, SPS_OVER_TIME=, SPS_ORDER=2, SPS_TAB=学生处, SPS_PROCESS_STATUS=99, SPS_IS_ADVANCE_CHECK=1, SPS_IS_ADVANCE_EXECUTE=0, SPD_ID=50838310695731200, SR_NAME=学生处, ID=50839707340242944, SPS_IS_RETREAT_CHECK=0, SPS_IS_RETREAT_EXECUTE=0, SPS_IS_OVER_TIME=0},更新后:{SPS_NAME=学生处, SVR_TABLE_NAME=SYS_PROCESS_STEP, SR_ID=48307839919194112, SPS_STEP_TYPE=1, SPS_OVER_TIME=, SPS_ORDER=3, SPS_TAB=学生处, SPS_PROCESS_STATUS=99, SPS_IS_ADVANCE_CHECK=1, SPS_IS_ADVANCE_EXECUTE=0, SPD_ID=50838310695731200, ID=50839707340242944, SPS_IS_RETREAT_CHECK=0, NOT_ID=50839707340242944, SPS_IS_RETREAT_EXECUTE=0, SPS_IS_OVER_TIME=0}');
INSERT INTO `sys_log_text` VALUES ('52505357641056256', '52505357590724608', '更新流程步骤,更新前:{SPS_NAME=完成, SR_ID=, SPS_STEP_TYPE=1, SPS_OVER_TIME=, SPS_ORDER=3, SPS_TAB=, SPS_PROCESS_STATUS=999, SPS_IS_ADVANCE_CHECK=0, SPS_IS_ADVANCE_EXECUTE=0, SPD_ID=50838310695731200, SR_NAME=null, ID=50840190146576384, SPS_IS_RETREAT_CHECK=0, SPS_IS_RETREAT_EXECUTE=0, SPS_IS_OVER_TIME=0},更新后:{SPS_NAME=完成, SVR_TABLE_NAME=SYS_PROCESS_STEP, SR_ID=, SPS_STEP_TYPE=1, SPS_OVER_TIME=, SPS_ORDER=4, SPS_TAB=, SPS_PROCESS_STATUS=999, SPS_IS_ADVANCE_CHECK=0, SPS_IS_ADVANCE_EXECUTE=0, SPD_ID=50838310695731200, ID=50840190146576384, SPS_IS_RETREAT_CHECK=0, NOT_ID=50840190146576384, SPS_IS_RETREAT_EXECUTE=0, SPS_IS_OVER_TIME=0}');
INSERT INTO `sys_log_text` VALUES ('52505530127613952', '52505530022756352', '登录成功!登录地址:未知');
INSERT INTO `sys_log_text` VALUES ('52505870596046848', '52505870356971520', '查看学生管理');
INSERT INTO `sys_log_text` VALUES ('52505891957637120', '52505891827613696', '查看字典管理');
INSERT INTO `sys_log_text` VALUES ('52505920051085312', '52505919933644800', '查看字典信息');
INSERT INTO `sys_log_text` VALUES ('52506123378360320', '52506123260919808', '查看字典管理');
INSERT INTO `sys_log_text` VALUES ('52506130521260032', '52506130382848000', '查看字典信息');
INSERT INTO `sys_log_text` VALUES ('52506154990829568', '52506154877583360', '添加字典类型:{SDI_CODE=50, SVR_TABLE_NAME=SYS_DICT_INFO, SDI_REQUIRED=0, SDI_ORDER=50, SDI_REMARK=, SDI_NAME=辅导员, SDI_PARENTID=0, IS_STATUS=1, SDT_CODE=SYS_PROCESS_STATUS, SDI_INNERCODE=50, ID=52506154542039040, SDT_ID=27191919998140416}');
INSERT INTO `sys_log_text` VALUES ('52506176058818560', '52506175937183744', '查看字典管理');
INSERT INTO `sys_log_text` VALUES ('52506262306291712', '52506262276931584', '更新流程步骤,更新前:{SPS_NAME=启动人员, SR_ID=50836827770191872, SPS_STEP_TYPE=1, SPS_OVER_TIME=, SPS_ORDER=1, SPS_TAB=系部人员, SPS_PROCESS_STATUS=5, SPS_IS_ADVANCE_CHECK=1, SPS_IS_ADVANCE_EXECUTE=0, SPD_ID=50838310695731200, SR_NAME=null, ID=50839589836816384, SPS_IS_RETREAT_CHECK=0, SPS_IS_RETREAT_EXECUTE=0, SPS_IS_OVER_TIME=0},更新后:{SPS_NAME=启动人员, SVR_TABLE_NAME=SYS_PROCESS_STEP, SR_ID=48309528801837056, SPS_STEP_TYPE=1, SPS_OVER_TIME=, SPS_ORDER=1, SPS_TAB=系部人员, SPS_PROCESS_STATUS=50, SPS_IS_ADVANCE_CHECK=1, SPS_IS_ADVANCE_EXECUTE=0, SPD_ID=50838310695731200, ID=50839589836816384, SPS_IS_RETREAT_CHECK=0, NOT_ID=50839589836816384, SPS_IS_RETREAT_EXECUTE=0, SPS_IS_OVER_TIME=0}');
INSERT INTO `sys_log_text` VALUES ('52506390295478272', '52506390253535232', '查看字典信息');
INSERT INTO `sys_log_text` VALUES ('52506439582744576', '52506439549190144', '删除字典类型,信息:{SDI_CODE=6, SDI_REQUIRED=0, SDI_ORDER=6, SDI_REMARK=, SDI_NAME=年度表彰, SDI_PARENTID=0, IS_STATUS=1, SDT_CODE=SYS_PROCESS_STATUS, SDI_INNERCODE=6, SDI_PARENT_NAME=null, SDT_NAME=流程_流程状态, ID=52299963194933248, SDT_ID=27191919998140416}');
INSERT INTO `sys_log_text` VALUES ('52506449921703936', '52506449879760896', '删除字典类型,信息:{SDI_CODE=5, SDI_REQUIRED=0, SDI_ORDER=5, SDI_REMARK=, SDI_NAME=学院奖学金, SDI_PARENTID=0, IS_STATUS=1, SDT_CODE=SYS_PROCESS_STATUS, SDI_INNERCODE=5, SDI_PARENT_NAME=null, SDT_NAME=流程_流程状态, ID=50839172386127872, SDT_ID=27191919998140416}');
INSERT INTO `sys_log_text` VALUES ('52506481051828224', '52506481018273792', '添加字典类型:{SDI_CODE=51, SVR_TABLE_NAME=SYS_DICT_INFO, SDI_REQUIRED=0, SDI_ORDER=51, SDI_REMARK=, SDI_NAME=系部管理员, SDI_PARENTID=0, IS_STATUS=1, SDT_CODE=SYS_PROCESS_STATUS, SDI_INNERCODE=51, ID=52506480846307328, SDT_ID=27191919998140416}');
INSERT INTO `sys_log_text` VALUES ('52506491466285056', '52506491332067328', '查看字典管理');
INSERT INTO `sys_log_text` VALUES ('52506599805157376', '52506599767408640', '添加流程步骤:{SPS_NAME=系部管理员, SVR_TABLE_NAME=SYS_PROCESS_STEP, SR_ID=48309996873580544, SPS_STEP_TYPE=1, SPS_OVER_TIME=, SPS_ORDER=2, SPS_TAB=, SPS_PROCESS_STATUS=51, SPS_IS_ADVANCE_CHECK=0, SPS_IS_ADVANCE_EXECUTE=0, SPD_ID=50838310695731200, ID=52506599511556096, SPS_IS_RETREAT_CHECK=0, NOT_ID=, SPS_IS_RETREAT_EXECUTE=0, SPS_IS_OVER_TIME=0}');
INSERT INTO `sys_log_text` VALUES ('52506610571935744', '52506609963761664', '查看流程定义');
INSERT INTO `sys_log_text` VALUES ('52506619409334272', '52506619258339328', '查看流程步骤');
INSERT INTO `sys_log_text` VALUES ('52506640225665024', '52506640200499200', '更新流程步骤,更新前:{SPS_NAME=学生处, SR_ID=48307839919194112, SPS_STEP_TYPE=1, SPS_OVER_TIME=, SPS_ORDER=2, SPS_TAB=学生处, SPS_PROCESS_STATUS=99, SPS_IS_ADVANCE_CHECK=1, SPS_IS_ADVANCE_EXECUTE=0, SPD_ID=52297782794387456, SR_NAME=学生处, ID=52297783364812800, SPS_IS_RETREAT_CHECK=0, SPS_IS_RETREAT_EXECUTE=0, SPS_IS_OVER_TIME=0},更新后:{SPS_NAME=学生处, SVR_TABLE_NAME=SYS_PROCESS_STEP, SR_ID=48307839919194112, SPS_STEP_TYPE=1, SPS_OVER_TIME=, SPS_ORDER=3, SPS_TAB=学生处, SPS_PROCESS_STATUS=99, SPS_IS_ADVANCE_CHECK=1, SPS_IS_ADVANCE_EXECUTE=0, SPD_ID=52297782794387456, ID=52297783364812800, SPS_IS_RETREAT_CHECK=0, NOT_ID=52297783364812800, SPS_IS_RETREAT_EXECUTE=0, SPS_IS_OVER_TIME=0}');
INSERT INTO `sys_log_text` VALUES ('52506653693575168', '52506653609689088', '更新流程步骤,更新前:{SPS_NAME=完成, SR_ID=, SPS_STEP_TYPE=1, SPS_OVER_TIME=, SPS_ORDER=3, SPS_TAB=, SPS_PROCESS_STATUS=999, SPS_IS_ADVANCE_CHECK=0, SPS_IS_ADVANCE_EXECUTE=0, SPD_ID=52297782794387456, SR_NAME=null, ID=52297783385784320, SPS_IS_RETREAT_CHECK=0, SPS_IS_RETREAT_EXECUTE=0, SPS_IS_OVER_TIME=0},更新后:{SPS_NAME=完成, SVR_TABLE_NAME=SYS_PROCESS_STEP, SR_ID=, SPS_STEP_TYPE=1, SPS_OVER_TIME=, SPS_ORDER=4, SPS_TAB=, SPS_PROCESS_STATUS=999, SPS_IS_ADVANCE_CHECK=0, SPS_IS_ADVANCE_EXECUTE=0, SPD_ID=52297782794387456, ID=52297783385784320, SPS_IS_RETREAT_CHECK=0, NOT_ID=52297783385784320, SPS_IS_RETREAT_EXECUTE=0, SPS_IS_OVER_TIME=0}');
INSERT INTO `sys_log_text` VALUES ('52506693820481536', '52506693791121408', '更新流程步骤,更新前:{SPS_NAME=启动人员, SR_ID=52299342316306432, SPS_STEP_TYPE=1, SPS_OVER_TIME=, SPS_ORDER=1, SPS_TAB=系部人员, SPS_PROCESS_STATUS=6, SPS_IS_ADVANCE_CHECK=1, SPS_IS_ADVANCE_EXECUTE=0, SPD_ID=52297782794387456, SR_NAME=null, ID=52297782974742528, SPS_IS_RETREAT_CHECK=0, SPS_IS_RETREAT_EXECUTE=0, SPS_IS_OVER_TIME=0},更新后:{SPS_NAME=启动人员, SVR_TABLE_NAME=SYS_PROCESS_STEP, SR_ID=48309528801837056, SPS_STEP_TYPE=1, SPS_OVER_TIME=, SPS_ORDER=1, SPS_TAB=系部人员, SPS_PROCESS_STATUS=50, SPS_IS_ADVANCE_CHECK=1, SPS_IS_ADVANCE_EXECUTE=0, SPD_ID=52297782794387456, ID=52297782974742528, SPS_IS_RETREAT_CHECK=0, NOT_ID=52297782974742528, SPS_IS_RETREAT_EXECUTE=0, SPS_IS_OVER_TIME=0}');
INSERT INTO `sys_log_text` VALUES ('52506737923588096', '52506737894227968', '添加流程步骤:{SPS_NAME=系部管理员, SVR_TABLE_NAME=SYS_PROCESS_STEP, SR_ID=48309996873580544, SPS_STEP_TYPE=1, SPS_OVER_TIME=, SPS_ORDER=2, SPS_TAB=, SPS_PROCESS_STATUS=51, SPS_IS_ADVANCE_CHECK=0, SPS_IS_ADVANCE_EXECUTE=0, SPD_ID=52297782794387456, ID=52506737504157696, SPS_IS_RETREAT_CHECK=0, NOT_ID=, SPS_IS_RETREAT_EXECUTE=0, SPS_IS_OVER_TIME=0}');
INSERT INTO `sys_log_text` VALUES ('52506878516658176', '52506878281777152', '查看流程进度');
INSERT INTO `sys_log_text` VALUES ('52506901677604864', '52506901644050432', '作废流程进度,作废原因:52306244119035904');
INSERT INTO `sys_log_text` VALUES ('52506913723645952', '52506913694285824', '作废流程进度,作废原因:51936808040136704');
INSERT INTO `sys_log_text` VALUES ('52507492235608064', '52507491845537792', '查看流程进度');
INSERT INTO `sys_log_text` VALUES ('52507508463370240', '52507508434010112', '作废流程进度,作废原因:50855922569838592');
INSERT INTO `sys_log_text` VALUES ('52507517887971328', '52507517787308032', '查看学院奖学金');
INSERT INTO `sys_log_text` VALUES ('52507544169480192', '52507543976542208', '查看年度表彰');
INSERT INTO `sys_log_text` VALUES ('52507551622758400', '52507551526289408', '查看学院奖学金');
INSERT INTO `sys_log_text` VALUES ('52507749681987584', '52507749275140096', '查看流程定义');
INSERT INTO `sys_log_text` VALUES ('52507756170575872', '52507756099272704', '查看启动角色');
INSERT INTO `sys_log_text` VALUES ('52507786189209600', '52507786164043776', '更新流程开始角色,更新前:{SR_ID=50836827770191872, SPD_ID=50838310695731200, SR_NAME=null, ID=50839748784160768},更新后:{SPD_ID=50838310695731200, ID=50839748784160768, SR_ID=48309528801837056}');
INSERT INTO `sys_log_text` VALUES ('52507789540458496', '52507789448183808', '查看流程定义');
INSERT INTO `sys_log_text` VALUES ('52507797446721536', '52507797367029760', '查看启动角色');
INSERT INTO `sys_log_text` VALUES ('52507826219646976', '52507826190286848', '更新流程开始角色,更新前:{SR_ID=52299342316306432, SPD_ID=52297782794387456, SR_NAME=null, ID=52297784262393856},更新后:{SPD_ID=52297782794387456, ID=52297784262393856, SR_ID=48309528801837056}');
INSERT INTO `sys_log_text` VALUES ('52507831911317504', '52507831844208640', '查看流程定义');
INSERT INTO `sys_log_text` VALUES ('52508019535118336', '52508019505758208', '更新流程定义,更新前:{BUS_PROCESS=100, SPD_COLLEGE_FIELD=BDM_COLLEGE, SR_ID=50858364522987520, SO_ID=1, SAI_NAME=admin, SPD_DESCRIBE=, BUS_PROCESS2=109, SPD_CLASS_FIELD=BC_ID, IS_STATUS=1, SPD_DEPARTMENT_FIELD=BDM_ID, SPD_UPDATE_TABLE=V_COLLEGE_SCHOLARSHIP, IS_MULTISTAGE_BACK=1, SPD_VERSION=1.0, SDP_ENTRY_TIME=2018-08-12 23:07:07, SR_NAME=查看学校奖学金, ID=50838310695731200, SPD_UPDATE_NAME=BS_NAME, SPD_NAME=资助管理-学院奖学金},更新后:{BUS_PROCESS=100, SPD_COLLEGE_FIELD=BDM_COLLEGE, SVR_TABLE_NAME=SYS_PROCESS_DEFINITION, SR_ID=50858364522987520, SO_ID=null, SPD_DESCRIBE=, BUS_PROCESS2=109, SPD_CLASS_FIELD=BC_ID, IS_STATUS=null, SPD_DEPARTMENT_FIELD=BDM_ID, SPD_UPDATE_TABLE=v_aid_college_scholarship, IS_MULTISTAGE_BACK=1, SPD_VERSION=1.0, SDP_ENTRY_TIME=null, ID=50838310695731200, SPD_UPDATE_NAME=BS_NAME, SPD_NAME=资助管理-学院奖学金}');
INSERT INTO `sys_log_text` VALUES ('52508025084182528', '52508024983519232', '查看流程定义');
INSERT INTO `sys_log_text` VALUES ('52508164175691776', '52508163965976576', '登录成功!登录地址:未知');
INSERT INTO `sys_log_text` VALUES ('52508170811080704', '52508170731388928', '查看学院奖学金');
INSERT INTO `sys_log_text` VALUES ('52508244454670336', '52508243930382336', '查看流程步骤');
INSERT INTO `sys_log_text` VALUES ('52508279573577728', '52508279330308096', '查看流程定义');
INSERT INTO `sys_log_text` VALUES ('52508290399076352', '52508290331967488', '查看流程步骤');
INSERT INTO `sys_log_text` VALUES ('52508294647906304', '52508294538854400', '查看流程定义');
INSERT INTO `sys_log_text` VALUES ('52508590769963008', '52508590014988288', '查看流程步骤');
INSERT INTO `sys_log_text` VALUES ('52508603323514880', '52508603294154752', '更新流程步骤,更新前:{SPS_NAME=完成, SR_ID=, SPS_STEP_TYPE=1, SPS_OVER_TIME=, SPS_ORDER=4, SPS_TAB=, SPS_PROCESS_STATUS=999, SPS_IS_ADVANCE_CHECK=0, SPS_IS_ADVANCE_EXECUTE=0, SPD_ID=50838310695731200, SR_NAME=null, ID=50840190146576384, SPS_IS_RETREAT_CHECK=0, SPS_IS_RETREAT_EXECUTE=0, SPS_IS_OVER_TIME=0},更新后:{SPS_NAME=完成, SVR_TABLE_NAME=SYS_PROCESS_STEP, SR_ID=, SPS_STEP_TYPE=1, SPS_OVER_TIME=, SPS_ORDER=4, SPS_TAB=, SPS_PROCESS_STATUS=999, SPS_IS_ADVANCE_CHECK=0, SPS_IS_ADVANCE_EXECUTE=0, SPD_ID=50838310695731200, ID=50840190146576384, SPS_IS_RETREAT_CHECK=0, NOT_ID=50840190146576384, SPS_IS_RETREAT_EXECUTE=0, SPS_IS_OVER_TIME=0}');
INSERT INTO `sys_log_text` VALUES ('52508675192913920', '52508675088056320', '查看流程定义');
INSERT INTO `sys_log_text` VALUES ('52508723528073216', '52508723230277632', '登录成功!登录地址:未知');
INSERT INTO `sys_log_text` VALUES ('52509692944973824', '52509692592652288', '查看年度表彰');
INSERT INTO `sys_log_text` VALUES ('52509700113039360', '52509700041736192', '查看学院奖学金');
INSERT INTO `sys_log_text` VALUES ('52509704525447168', '52509704416395264', '查看年度表彰');
INSERT INTO `sys_log_text` VALUES ('52509708333875200', '52509708216434688', '查看学院奖学金');
INSERT INTO `sys_log_text` VALUES ('52509710103871488', '52509709999013888', '查看年度表彰');
INSERT INTO `sys_log_text` VALUES ('52509712737894400', '52509712628842496', '查看学院奖学金');
INSERT INTO `sys_log_text` VALUES ('52509714537250816', '52509714436587520', '查看年度表彰');
INSERT INTO `sys_log_text` VALUES ('52509716462436352', '52509716357578752', '查看学院奖学金');
INSERT INTO `sys_log_text` VALUES ('52509737261989888', '52509737148743680', '查看角色管理');
INSERT INTO `sys_log_text` VALUES ('52509741645037568', '52509741594705920', '查看操作员管理');
INSERT INTO `sys_log_text` VALUES ('52509766487900160', '52509766450151424', '操作员:admin,旧角色:[50858364522987520, 1],新角色:[1, 50858364522987520, 52299464139866112]');
INSERT INTO `sys_log_text` VALUES ('52509774754873344', '52509774612267008', '查看年度表彰');
INSERT INTO `sys_log_text` VALUES ('52509815766777856', '52509815682891776', '登录成功!登录地址:未知');
INSERT INTO `sys_log_text` VALUES ('52509829758976000', '52509829607981056', '查看学院奖学金');
INSERT INTO `sys_log_text` VALUES ('52509832250392576', '52509832137146368', '查看年度表彰');
INSERT INTO `sys_log_text` VALUES ('52509922289516544', '52509921840726016', '查看配置列表管理');
INSERT INTO `sys_log_text` VALUES ('52509928752939008', '52509928685830144', '查看设置字段');
INSERT INTO `sys_log_text` VALUES ('52509942258597888', '52509942233432064', '删除配置列表字段,配置列表:资助管理-年度表彰字段:{SCC_NAME=学期, SCC_FUNC=, SCC_IS_MERGE=, SCC_ALIGN=center, SCC_IS_STATUS=0, SCC_WIDTH=100px, SCC_FIELD=BAF_SEMESTER, SCC_IS_VISIBLE=1, SCC_IS_OPERATION=0, ID=52306487673880576, SC_ID=52294046697127936, SCC_CLASS=, SCC_SDT_CODE=BUS_SEMESTER, SCC_ORDER=36}');
INSERT INTO `sys_log_text` VALUES ('52509945182027776', '52509945131696128', '查看配置列表管理');
INSERT INTO `sys_log_text` VALUES ('52509948763963392', '52509948671688704', '查看设置搜索');
INSERT INTO `sys_log_text` VALUES ('52509961820831744', '52509961795665920', '删除配置列表搜索,配置列表:资助管理-年度表彰搜索:{SCS_METHOD_TYPE=1, SCS_TYPE=2, SCS_FIELD=BAF_SEMESTER, SCS_NAME=学期, SCS_IS_STUDENT_YEAR=1, SCS_SDT_CODE=BUS_SEMESTER, SCC_IS_VISIBLE=1, ID=52294049427619840, SC_ID=52294046697127936, SCS_REMARK=, SCS_ORDER=30}');
INSERT INTO `sys_log_text` VALUES ('52509964672958464', '52509964580683776', '查看配置列表管理');
INSERT INTO `sys_log_text` VALUES ('52509971857801216', '52509971727777792', '查看年度表彰');
INSERT INTO `sys_log_text` VALUES ('52510283402313728', '52510283108712448', '查看综合素质测评');
INSERT INTO `sys_log_text` VALUES ('52510295465132032', '52510295314137088', '查看年度表彰');
INSERT INTO `sys_log_text` VALUES ('52510304378028032', '52510304340279296', '查看综合素质测评');
INSERT INTO `sys_log_text` VALUES ('52510381905543168', '52510381616136192', '登录成功!登录地址:未知');
INSERT INTO `sys_log_text` VALUES ('52510392148033536', '52510391896375296', '查看综合素质测评');
INSERT INTO `sys_log_text` VALUES ('52510453158379520', '52510452910915584', '查看配置列表管理');
INSERT INTO `sys_log_text` VALUES ('52510464839516160', '52510464726269952', '查看设置字段');
INSERT INTO `sys_log_text` VALUES ('52510495298551808', '52510494908481536', '查看配置列表管理');
INSERT INTO `sys_log_text` VALUES ('52510504660238336', '52510504521826304', '查看设置字段');
INSERT INTO `sys_log_text` VALUES ('52510532736909312', '52510532514611200', '更新配置列表字段,配置列表:学生管理-综合素质测评,更新前:,更新后:{SCC_NAME=智育排名, SVR_TABLE_NAME=SYS_CONFIGURE_COLUMN, SCC_FUNC=, SCC_IS_MERGE=, SCC_ALIGN=center, SCC_IS_STATUS=0, SCC_WIDTH=60px, SCC_FIELD=BSC_INTELLECTUAL_RANK, SCC_IS_VISIBLE=1, SCC_IS_OPERATION=0, ID=50340096863371264, SC_ID=50338719827230720, SCC_CLASS=, SCC_SDT_CODE=, SCC_ORDER=80}');
INSERT INTO `sys_log_text` VALUES ('52510544397074432', '52510544325771264', '更新配置列表字段,配置列表:学生管理-综合素质测评,更新前:,更新后:{SCC_NAME=学习成绩, SVR_TABLE_NAME=SYS_CONFIGURE_COLUMN, SCC_FUNC=, SCC_IS_MERGE=, SCC_ALIGN=center, SCC_IS_STATUS=0, SCC_WIDTH=60px, SCC_FIELD=BSC_ACADEMIC_RECORD, SCC_IS_VISIBLE=1, SCC_IS_OPERATION=0, ID=50340030438178816, SC_ID=50338719827230720, SCC_CLASS=, SCC_SDT_CODE=, SCC_ORDER=70}');
INSERT INTO `sys_log_text` VALUES ('52510569084747776', '52510569055387648', '更新配置列表字段,配置列表:学生管理-综合素质测评,更新前:,更新后:{SCC_NAME=总分, SVR_TABLE_NAME=SYS_CONFIGURE_COLUMN, SCC_FUNC=, SCC_IS_MERGE=, SCC_ALIGN=center, SCC_IS_STATUS=0, SCC_WIDTH=60px, SCC_FIELD=BSC_TOTAL, SCC_IS_VISIBLE=1, SCC_IS_OPERATION=0, ID=50339810778284032, SC_ID=50338719827230720, SCC_CLASS=, SCC_SDT_CODE=, SCC_ORDER=50}');
INSERT INTO `sys_log_text` VALUES ('52510607370354688', '52510607345188864', '更新配置列表字段,配置列表:学生管理-综合素质测评,更新前:,更新后:{SCC_NAME=总分, SVR_TABLE_NAME=SYS_CONFIGURE_COLUMN, SCC_FUNC=, SCC_IS_MERGE=, SCC_ALIGN=center, SCC_IS_STATUS=0, SCC_WIDTH=50px, SCC_FIELD=BSC_TOTAL, SCC_IS_VISIBLE=1, SCC_IS_OPERATION=0, ID=50339810778284032, SC_ID=50338719827230720, SCC_CLASS=, SCC_SDT_CODE=, SCC_ORDER=50}');
INSERT INTO `sys_log_text` VALUES ('52510692850270208', '52510692825104384', '添加配置列表字段,配置列表:学生管理-综合素质测评,字段参数{SCC_NAME=学号, SVR_TABLE_NAME=SYS_CONFIGURE_COLUMN, SCC_FUNC=, SCC_IS_MERGE=, SCC_ALIGN=center, SCC_IS_STATUS=0, SCC_WIDTH=80px, SCC_FIELD=BS_NUMBER, SCC_IS_VISIBLE=1, SCC_IS_OPERATION=0, ID=52510692615389184, SC_ID=50338719827230720, SCC_CLASS=, SCC_SDT_CODE=, SCC_ORDER=10}');
INSERT INTO `sys_log_text` VALUES ('52510953433989120', '52510953006170112', '查看综合素质测评');
INSERT INTO `sys_log_text` VALUES ('52510976913702912', '52510976842399744', '查看菜单管理');
INSERT INTO `sys_log_text` VALUES ('52510985616883712', '52510985503637504', '查看角色管理');
INSERT INTO `sys_log_text` VALUES ('52511039035539456', '52511038964236288', '查看菜单管理');
INSERT INTO `sys_log_text` VALUES ('52511057830215680', '52511057565974528', '更新菜单,更新前:{BUS_PROCESS=null, SM_URL=, SC_NAME=null, SM_URL_PARAMS=null, BUS_PROCESS2=null, SM_PARENT_NAME=null, SM_IS_LEAF=1, IS_STATUS=1, SM_TYPE=1, SM_ORDER=1, SM_CODE=SYSTEM, SM_NAME=系统管理, SM_PARENTID=0, ID=1, SC_ID=, SM_CLASSICON=mdi mdi-laptop, SM_IS_EXPAND=},更新后:{BUS_PROCESS=, SM_URL=, SVR_TABLE_NAME=SYS_MENU, SM_URL_PARAMS=, BUS_PROCESS2=, SM_IS_LEAF=1, IS_STATUS=null, SM_TYPE=1, SM_ORDER=1, SM_CODE=SYSTEM, SM_NAME=系统管理, SM_PARENTID=0, ID=1, SC_ID=, SM_CLASSICON=mdi mdi-laptop, SM_IS_EXPAND=}');
INSERT INTO `sys_log_text` VALUES ('52511083570659328', '52511083218337792', '查看角色管理');
INSERT INTO `sys_log_text` VALUES ('52511136163037184', '52511136133677056', '角色:辅导员,菜单名称:综合素质测评,旧按钮:,新按钮:[48286237202579456]');
INSERT INTO `sys_log_text` VALUES ('52511144295792640', '52511144186740736', '角色:辅导员,菜单名称:综合素质测评,旧按钮:[48286237202579456],新按钮:[793777245519872, 48286237202579456]');
INSERT INTO `sys_log_text` VALUES ('52511150067154944', '52511150037794816', '角色:辅导员,菜单名称:综合素质测评,旧按钮:[793777245519872, 48286237202579456],新按钮:[793777245519872, 793562643955712, 48286237202579456]');
INSERT INTO `sys_log_text` VALUES ('52511274587652096', '52511274545709056', '角色:辅导员,旧菜单:[50827078076989440, 48892124845834240, 49027774555357184, 49027088874733568, 50751117243449344, 50338340347576320, 49028146267160576, 52294280579907584],新菜单:[50827078076989440, 50338340347576320, 48892124845834240, 49028146267160576, 49027774555357184, 50341592241799168, 49027088874733568, 52294280579907584, 50751117243449344]');
INSERT INTO `sys_log_text` VALUES ('52511475490619392', '52511475331235840', '导入学生综合素质测评,数据:[[Ljava.lang.String;@2689626, [Ljava.lang.String;@14246014, [Ljava.lang.String;@1ee5e8a6, [Ljava.lang.String;@7b407af6, [Ljava.lang.String;@3d5f1a1e]');
INSERT INTO `sys_log_text` VALUES ('52523268892000256', '52523268673896448', '查看配置列表管理');
INSERT INTO `sys_log_text` VALUES ('52523274915020800', '52523274873077760', '查看设置字段');
INSERT INTO `sys_log_text` VALUES ('52523343152152576', '52523343118598144', '更新配置列表字段,配置列表:资助管理-年度表彰,更新前:,更新后:{SCC_NAME=测评排名, SVR_TABLE_NAME=SYS_CONFIGURE_COLUMN, SCC_FUNC=, SCC_IS_MERGE=, SCC_ALIGN=center, SCC_IS_STATUS=0, SCC_WIDTH=60px, SCC_FIELD=BSC_TOTAL_RANK, SCC_IS_VISIBLE=1, SCC_IS_OPERATION=0, ID=52294047150112768, SC_ID=52294046697127936, SCC_CLASS=, SCC_SDT_CODE=, SCC_ORDER=50}');
INSERT INTO `sys_log_text` VALUES ('52523662804254720', '52523662779088896', '更新配置列表字段,配置列表:资助管理-年度表彰,更新前:,更新后:{SCC_NAME=学习排名, SVR_TABLE_NAME=SYS_CONFIGURE_COLUMN, SCC_FUNC=, SCC_IS_MERGE=, SCC_ALIGN=center, SCC_IS_STATUS=0, SCC_WIDTH=60px, SCC_FIELD=BSC_ACADEMIC_RECORD_RANK, SCC_IS_VISIBLE=1, SCC_IS_OPERATION=0, ID=52294047573737472, SC_ID=52294046697127936, SCC_CLASS=, SCC_SDT_CODE=, SCC_ORDER=70}');
INSERT INTO `sys_log_text` VALUES ('52523683566059520', '52523683356344320', '查看年度表彰');
INSERT INTO `sys_log_text` VALUES ('52523730672287744', '52523730164776960', '查看综合素质测评');
INSERT INTO `sys_log_text` VALUES ('52524002643542016', '52524002186362880', '查看设置字段');
INSERT INTO `sys_log_text` VALUES ('52524045911982080', '52524045882621952', '更新配置列表字段,配置列表:资助管理-年度表彰,更新前:,更新后:{SCC_NAME=综合测评平均, SVR_TABLE_NAME=SYS_CONFIGURE_COLUMN, SCC_FUNC=, SCC_IS_MERGE=, SCC_ALIGN=center, SCC_IS_STATUS=0, SCC_WIDTH=80px, SCC_FIELD=BSC_TOTAL, SCC_IS_VISIBLE=1, SCC_IS_OPERATION=0, ID=52294047137529856, SC_ID=52294046697127936, SCC_CLASS=, SCC_SDT_CODE=, SCC_ORDER=40}');
INSERT INTO `sys_log_text` VALUES ('52524081630674944', '52524081563566080', '更新配置列表字段,配置列表:资助管理-年度表彰,更新前:,更新后:{SCC_NAME=综合测评平均, SVR_TABLE_NAME=SYS_CONFIGURE_COLUMN, SCC_FUNC=, SCC_IS_MERGE=, SCC_ALIGN=center, SCC_IS_STATUS=0, SCC_WIDTH=100px, SCC_FIELD=BSC_TOTAL, SCC_IS_VISIBLE=1, SCC_IS_OPERATION=0, ID=52294047137529856, SC_ID=52294046697127936, SCC_CLASS=, SCC_SDT_CODE=, SCC_ORDER=40}');
INSERT INTO `sys_log_text` VALUES ('52524158772314112', '52524158747148288', '更新配置列表字段,配置列表:资助管理-年度表彰,更新前:,更新后:{SCC_NAME=学习成绩平均, SVR_TABLE_NAME=SYS_CONFIGURE_COLUMN, SCC_FUNC=, SCC_IS_MERGE=, SCC_ALIGN=center, SCC_IS_STATUS=0, SCC_WIDTH=100px, SCC_FIELD=BSC_ACADEMIC_RECORD, SCC_IS_VISIBLE=1, SCC_IS_OPERATION=0, ID=52294047561154560, SC_ID=52294046697127936, SCC_CLASS=, SCC_SDT_CODE=, SCC_ORDER=60}');
INSERT INTO `sys_log_text` VALUES ('52525068219056128', '52525067564744704', '查看年度表彰');
INSERT INTO `sys_log_text` VALUES ('52525118051581952', '52525117577625600', '查看学院奖学金');
INSERT INTO `sys_log_text` VALUES ('52525121088258048', '52525120995983360', '查看年度表彰');

-- ----------------------------
-- Table structure for sys_long_text
-- ----------------------------
DROP TABLE IF EXISTS `sys_long_text`;
CREATE TABLE `sys_long_text`  (
  `ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `BLT_TABLE_NAME` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '使用表',
  `BLT_TABLE_ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '使用表ID',
  `BLT_CONTENT` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '内容',
  `BLT_ENTRY_TIME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '添加时间',
  `BLT_MODIFY_TIME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '最后修改时间',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `BLT_TABLE`(`BLT_TABLE_NAME`, `BLT_TABLE_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SC_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '配置列表ID',
  `SM_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限名称',
  `SM_PARENTID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '父权限ID',
  `SM_CODE` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限编码',
  `SM_URL` varchar(400) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '访问URL',
  `SM_URL_PARAMS` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '访问URL所带的参数',
  `SM_CLASSICON` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'icon图片class',
  `BUS_PROCESS` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程大类',
  `BUS_PROCESS2` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程小类',
  `SM_IS_LEAF` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否是叶节点',
  `SM_IS_EXPAND` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否默认张开节点',
  `SM_TYPE` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户类型:1管理员 2会员',
  `SM_ORDER` int(5) NULL DEFAULT NULL COMMENT '排序号',
  `IS_STATUS` int(5) NULL DEFAULT NULL COMMENT '状态:0停用1启用',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SM_PARENTID`(`SM_PARENTID`) USING BTREE,
  INDEX `SM_CODE`(`SM_CODE`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('1', '', '系统管理', '0', 'SYSTEM', '', '', 'mdi mdi-laptop', '', '', '1', '', '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('13358417838080', '3316994321416192', '操作员管理', '1', 'SYSTEM:OPERATOR', 'admin/dataGrid/', '', 'mdi mdi-account-group', NULL, NULL, '0', '', '1', 7, 1);
INSERT INTO `sys_menu` VALUES ('1427690443767808', '', '编辑', '2', 'SYSTEM:MENU_UPDATE', '', NULL, '', NULL, NULL, '0', NULL, '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('1448716162564096', '', '编辑', '3', 'SYSTEM:BUTTON_UPDATE', '', NULL, '', NULL, NULL, '0', NULL, '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('1451155909509120', '2910894828814336', '字典管理', '1', 'SYSTEM:DICT_TYPE', 'admin/dataGrid/', '', 'mdi mdi-zip-box', NULL, NULL, '0', '', '1', 5, 1);
INSERT INTO `sys_menu` VALUES ('1560059138015232', '', '编辑', '8', 'SYSTEM:CONFIGURE_UPDATE', '', NULL, '', NULL, NULL, '0', NULL, '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('1757509987598336', '1758638922268672', '设置字段', '8', 'SYSTEM:CONFIGURE_SET_COLUMN', 'admin/dataGrid/', NULL, '', NULL, NULL, '0', NULL, '1', 2, 1);
INSERT INTO `sys_menu` VALUES ('1846593582006272', '', '编辑', '1757509987598336', 'SYSTEM:CONFIGURE_SET_COLUMN_UPDATE', '', NULL, '', NULL, NULL, '0', NULL, '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('2', '2997414705233920', '菜单管理', '1', 'SYSTEM:MENU', 'admin/dataGrid/', NULL, 'mdi mdi-menu', NULL, NULL, '0', '', '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('20766815625936896', '20764730981351424', '组', '7', 'SYSTEM:VALIDATE_GROUP', 'admin/dataGrid/', NULL, '', NULL, NULL, '0', '0', '1', 4, 1);
INSERT INTO `sys_menu` VALUES ('21130604443598848', '', '系统配置', '1', 'SYSTEM:ALLOCATION', '', NULL, 'mdi mdi-settings', NULL, NULL, '1', '', '1', 99, 1);
INSERT INTO `sys_menu` VALUES ('21131205961318400', '', '邮箱管理', '21130604443598848', 'SYSTEM:ALLOCATION_EMAIL', 'admin/allocation/email', NULL, 'mdi mdi-email-secure', NULL, NULL, '0', '', '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('2163592187084800', '1870969903775744', '设置搜索', '8', 'SYSTEM:CONFIGURE_SET_SEARCH', 'admin/dataGrid/', NULL, '', NULL, NULL, '0', NULL, '1', 3, 1);
INSERT INTO `sys_menu` VALUES ('2163861868249088', '', '编辑', '2163592187084800', 'SYSTEM:CONFIGURE_SET_SEARCH_UPDATE', '', NULL, '', NULL, NULL, '0', NULL, '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('2258672239509504', '', '编辑', '7', 'SYSTEM:VALIDATE_UPDATE', '', NULL, '', NULL, NULL, '0', NULL, '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('2258969972178944', '2265709233045504', '设置字段', '7', 'SYSTEM:VALIDATE_SET_FIELD', 'admin/dataGrid/', NULL, '', NULL, NULL, '0', NULL, '1', 2, 1);
INSERT INTO `sys_menu` VALUES ('2269941063483392', '2268726246244352', '正则管理', '7', 'SYSTEM:VALIDATE_REGEX', 'admin/dataGrid/', NULL, '', NULL, NULL, '0', NULL, '1', 3, 1);
INSERT INTO `sys_menu` VALUES ('23657888534757376', '', '文件上传测试', '21130604443598848', '', 'admin/allocation/fileInputTest', NULL, '', NULL, NULL, '0', '', '1', 90, 1);
INSERT INTO `sys_menu` VALUES ('26476504758091776', '26491587483664384', '格式管理', '1', 'SYSTEM:FORMAT', 'admin/dataGrid/', '', 'mdi mdi-format-align-left', NULL, NULL, '0', '', '1', 8, 1);
INSERT INTO `sys_menu` VALUES ('26511186237325312', '', '编辑', '26476504758091776', 'SYSTEM:FORMAT_UPDATE', '', '', '', NULL, NULL, '0', '', '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('26571410583322624', '26568354160443392', '格式详细', '26476504758091776', 'SYSTEM:FORMAT_DETAIL', 'admin/dataGrid/', '', '', NULL, NULL, '0', '', '1', 10, 1);
INSERT INTO `sys_menu` VALUES ('26571551922978816', '', '编辑', '26571410583322624', 'SYSTEM:FORMAT_DETAIL_UPDATE', '', '', '', NULL, NULL, '0', '', '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('26577007949119488', '', '流程管理', '1', 'SYSTEM:PROCESS', '', '', 'mdi mdi-stack-overflow', NULL, NULL, '1', '', '1', 9, 1);
INSERT INTO `sys_menu` VALUES ('26577844645658624', '26721805670547456', '流程定义', '26577007949119488', 'SYSTEM:PROCESS_DEFINITION', 'admin/dataGrid/', '', 'mdi mdi-book-open', NULL, NULL, '0', '', '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('26579469829406720', '', '标签列表', '26577844645658624', 'SYSTEM:PROCESS_DEFINITION_TABS', 'admin/tabs', 'SF_CODE=SYS_PROCESS_DEFINITION', '', NULL, NULL, '0', '', '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('26714856669315072', '27187947212111872', '流程步骤', '26579469829406720', 'SYSTEM:PROCESS_STEP', 'admin/dataGrid/', '', '', NULL, NULL, '0', '', '1', 20, 1);
INSERT INTO `sys_menu` VALUES ('26715728707059712', '27999782165282816', '启动角色', '26579469829406720', 'SYSTEM:PROCESS_START', 'admin/dataGrid/', '', '', NULL, NULL, '0', '', '1', 30, 1);
INSERT INTO `sys_menu` VALUES ('26845813934129152', '', '流程定义', '26579469829406720', 'SYSTEM:PROCESS_DEFINITION_UPDATE', 'admin/process/definition/update', '', '', NULL, NULL, '0', '', '1', 10, 1);
INSERT INTO `sys_menu` VALUES ('28019952082485248', '28020396255084544', '测试流程', '21130604443598848', '', 'admin/dataGrid/', '', '', '1001', '2001', '0', '', '1', 91, 1);
INSERT INTO `sys_menu` VALUES ('2910350022279168', '2912701923721216', '字典信息', '1451155909509120', 'SYSTEM:DICTINFO', 'admin/dataGrid/', NULL, '', NULL, NULL, '0', '1', '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('3', '2', '按钮管理', '1', 'SYSTEM:BUTTON', 'admin/dataGrid/', NULL, 'mdi mdi-equal-box', NULL, NULL, '0', NULL, '1', 2, 1);
INSERT INTO `sys_menu` VALUES ('33081241360138240', '33080508233547776', '流程进度', '26577007949119488', 'SYSTEM:PROCESS_SCHEDULE', 'admin/dataGrid/', '', 'mdi mdi-stack-overflow', NULL, NULL, '0', '', '1', 10, 1);
INSERT INTO `sys_menu` VALUES ('3316536806735872', '', '编辑', '13358417838080', 'SYSTEM:OPERATOR_UPDATE', '', NULL, '', NULL, NULL, '0', '', '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('3547951557246976', '3545555946962944', '账户管理', '13358417838080', 'SYSTEM:OPERATOR_SUB', 'admin/dataGrid/', NULL, '', NULL, NULL, '0', '', '1', 2, 1);
INSERT INTO `sys_menu` VALUES ('38116041032728576', '', '基础信息管理', '0', 'INFO', '', '', 'mdi mdi-information-variant', NULL, NULL, '1', '', '1', 20, 1);
INSERT INTO `sys_menu` VALUES ('38161659570683904', '38163489528741888', '部门管理', '38116041032728576', 'INFO:DIVISION', 'admin/dataGrid/', '', 'mdi mdi-division', NULL, NULL, '0', '', '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('38161659570683905', '38163489528741889', '系部管理', '38116041032728576', 'INFO:DEPARTMENT', 'admin/dataGrid/', '', 'mdi mdi-division', NULL, NULL, '0', '', '1', 30, 1);
INSERT INTO `sys_menu` VALUES ('38162771866550272', '', '编辑', '38161659570683904', 'INFO:DIVISION_UPDATE', '', '', '', NULL, NULL, '0', '', '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('38162771866550273', '', '编辑', '38161659570683905', 'INFO:DEPARTMENT_UPDATE', '', '', '', NULL, NULL, '0', '', '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('4103758959083520', '', '编辑', '9', 'SYSTEM:ROLE_UPDATE', '', NULL, '', NULL, NULL, '0', '', '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('48295058385928192', '48293001511829504', '部门人员管理', '38116041032728576', 'INFO:DIVISION_PERSONNEL', 'admin/dataGrid/', '', 'mdi mdi-account-multiple', NULL, NULL, '0', '', '1', 20, 1);
INSERT INTO `sys_menu` VALUES ('48295058385928193', '48293001511829505', '系部人员管理', '38116041032728576', 'INFO:DEPARTMENT_PERSONNEL', 'admin/dataGrid/', '', 'mdi mdi-account-multiple', NULL, NULL, '0', '', '1', 40, 1);
INSERT INTO `sys_menu` VALUES ('48304916703215616', '', '编辑', '48295058385928192', 'INFO:DIVISION_PERSONNEL_UPDATE', '', '', '', NULL, NULL, '0', '', '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('48304916703215617', '', '编辑', '48295058385928193', 'INFO:DEPARTMENT_PERSONNEL_UPDATE', '', '', '', NULL, NULL, '0', '', '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('48614104260149248', '48612439985487872', '班级管理', '38116041032728576', 'INFO:CLASS', 'admin/dataGrid/', '', 'mdi mdi-desktop-classic', NULL, NULL, '0', '', '1', 50, 1);
INSERT INTO `sys_menu` VALUES ('48614229862776832', '', '编辑', '48614104260149248', 'INFO:CLASS_UPDATE', '', '', '', NULL, NULL, '0', '', '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('48667624430632960', '48666703227256832', '教师管理', '38116041032728576', 'INFO:TEACHER', 'admin/dataGrid/', '', 'mdi mdi-school', NULL, NULL, '0', '', '1', 60, 1);
INSERT INTO `sys_menu` VALUES ('48673777285857280', '', '编辑', '48667624430632960', 'INFO:TEACHER_UPDATE', '', '', '', NULL, NULL, '0', '', '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('48892124845834240', '48890586014416896', '学生管理', '49027088874733568', 'STUDENT:BASE', 'admin/dataGrid/', '', 'mdi mdi-account-multiple-outline', NULL, NULL, '0', '', '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('48892279221387264', '', '编辑', '48892124845834240', 'STUDENT:BASE_UPDATE', '', '', '', NULL, NULL, '0', '', '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('49027088874733568', '', '学生管理', '0', 'STUDENT', '', '', 'mdi mdi-account-multiple-outline', NULL, NULL, '1', '', '1', 30, 1);
INSERT INTO `sys_menu` VALUES ('49027774555357184', '49382988399509504', '考勤管理', '49027088874733568', 'STUDENT:ATTENDANCE', 'admin/dataGrid/', '', 'mdi mdi-book-open', '', '', '0', '', '1', 10, 1);
INSERT INTO `sys_menu` VALUES ('49028146267160576', '49623725020020736', '处分管理', '49027088874733568', 'STUDENT:PUNISHMENT', 'admin/dataGrid/', '', 'mdi mdi-book-multiple', '', '', '0', '', '1', 20, 1);
INSERT INTO `sys_menu` VALUES ('49029176400805888', '', '编辑', '49027774555357184', 'STUDENT:ATTENDANCE_UPDATE', '', '', '', NULL, NULL, '0', '', '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('49029256612675584', '', '编辑', '49028146267160576', 'STUDENT:PUNISHMENT_UPDATE', '', '', '', NULL, NULL, '0', '', '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('49030149684854784', '', '迟到旷课处分配置', '21130604443598848', 'SYSTEM:ALLOCATION_PUNISHMENT', 'admin/allocation/punishment', '', 'mdi mdi-close-outline', '', '', '0', '', '1', 20, 1);
INSERT INTO `sys_menu` VALUES ('50328019348226048', '', '综合素质测评比例配置', '21130604443598848', 'SYSTEM:ALLOCATION_COMPREHENSIVE', 'admin/allocation/comprehensive', '', 'mdi mdi-tooltip-edit', '', '', '0', '', '1', 10, 1);
INSERT INTO `sys_menu` VALUES ('50338340347576320', '50338719827230720', '综合素质测评', '49027088874733568', 'STUDENT:COMPREHENSIVE', 'admin/dataGrid/', '', 'mdi mdi-elevator', '', '', '0', '', '1', 30, 1);
INSERT INTO `sys_menu` VALUES ('50341592241799168', '', '综合素质测评', '50338340347576320', 'STUDENT:COMPREHENSIVE_INSERT_AND_UPDATE', 'admin/student/comprehensive/insertAndUpdate', '', '', '', '', '0', '', '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('50751117243449344', '', '资助管理', '0', 'AID', '', '', 'mdi mdi-credit-card-multiple', '', '', '1', '', '1', 40, 1);
INSERT INTO `sys_menu` VALUES ('50827078076989440', '50831880232108032', '学院奖学金', '50751117243449344', 'AID:COLLEGE_SCHOLARSHIP', 'admin/dataGrid/', '', 'mdi mdi-format-wrap-inline', '100', '109', '0', '', '1', 10, 1);
INSERT INTO `sys_menu` VALUES ('50827078936821760', '', '编辑', '50827078076989440', 'AID:COLLEGE_SCHOLARSHIP_UPDATE', '', '', '', '', '', '0', '', '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('52184510715920384', '', '日志管理', '0', 'LOG', '', '', 'mdi mdi-note-multiple-outline', '', '', '1', '', '1', 999, 1);
INSERT INTO `sys_menu` VALUES ('52184511034687488', '52185393809850368', '系统日志', '52184510715920384', 'LOG:SYSTEM', 'admin/dataGrid/', '', 'mdi mdi-laptop-windows', '', '', '0', '', '1', 10, 1);
INSERT INTO `sys_menu` VALUES ('52235853056966656', '52235707715944448', '操作日志', '52184510715920384', 'LOG:USE', 'admin/dataGrid/', '', 'mdi mdi-developer-board', '', '', '0', '', '1', 20, 1);
INSERT INTO `sys_menu` VALUES ('52235902763663360', '52235788951224320', '登录日志', '52184510715920384', 'LOG:PERSONAL', 'admin/dataGrid/', '', 'mdi mdi-login', '', '', '0', '', '1', 30, 1);
INSERT INTO `sys_menu` VALUES ('52259024812376064', '52258927902982144', '查看日志', '52184510715920384', 'LOG:SEE', 'admin/dataGrid/', '', 'mdi mdi-eye', '', '', '0', '', '1', 40, 1);
INSERT INTO `sys_menu` VALUES ('52294280579907584', '52294046697127936', '年度表彰', '50751117243449344', 'AID:COMMEND', 'admin/dataGrid/', '', 'mdi mdi-comment-check', '100', '110', '0', '', '1', 20, 1);
INSERT INTO `sys_menu` VALUES ('52294280949006336', '', '编辑', '52294280579907584', 'AID:COMMEND_UPDATE', '', '', '', '', '', '0', '', '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('7', '2244279544053760', '验证管理', '1', 'SYSTEM:VALIDATE', 'admin/dataGrid/', NULL, 'mdi mdi-security', NULL, NULL, '0', NULL, '1', 3, 1);
INSERT INTO `sys_menu` VALUES ('8', '1', '配置列表管理', '1', 'SYSTEM:CONFIGURE', 'admin/dataGrid/', NULL, 'mdi mdi-view-list', NULL, NULL, '0', NULL, '1', 4, 1);
INSERT INTO `sys_menu` VALUES ('9', '3', '角色管理', '1', 'SYSTEM:ROLE', 'admin/dataGrid/', NULL, 'mdi mdi-account-settings-variant', NULL, NULL, '0', '', '1', 6, 1);

-- ----------------------------
-- Table structure for sys_menu_button
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu_button`;
CREATE TABLE `sys_menu_button`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SM_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单表主键',
  `SB_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按钮表主键',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SM_ID`(`SM_ID`) USING BTREE,
  INDEX `SB_ID`(`SB_ID`) USING BTREE,
  CONSTRAINT `SB_ID` FOREIGN KEY (`SB_ID`) REFERENCES `sys_button` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `SM_ID` FOREIGN KEY (`SM_ID`) REFERENCES `sys_menu` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu_button
-- ----------------------------
INSERT INTO `sys_menu_button` VALUES ('1', '3', '1');
INSERT INTO `sys_menu_button` VALUES ('1426649660784640', '2', '1');
INSERT INTO `sys_menu_button` VALUES ('1426649727893504', '2', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('1426649765642240', '2', '794877562454016');
INSERT INTO `sys_menu_button` VALUES ('1426649815973888', '2', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('1435359447613440', '1427690443767808', '763206804963328');
INSERT INTO `sys_menu_button` VALUES ('1435533670612992', '9', '1');
INSERT INTO `sys_menu_button` VALUES ('1435533712556032', '9', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('1435533750304768', '9', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('1448614282919936', '3', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('1448614316474368', '3', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('1448749549223936', '1448716162564096', '763206804963328');
INSERT INTO `sys_menu_button` VALUES ('1559887930720256', '8', '1');
INSERT INTO `sys_menu_button` VALUES ('1559888014606336', '8', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('1559888035577856', '8', '795961550962688');
INSERT INTO `sys_menu_button` VALUES ('1559888056549376', '8', '795677957292032');
INSERT INTO `sys_menu_button` VALUES ('1559888085909504', '8', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('1560095188058112', '1560059138015232', '763206804963328');
INSERT INTO `sys_menu_button` VALUES ('1757606397870080', '1757509987598336', '1');
INSERT INTO `sys_menu_button` VALUES ('1757606435618816', '1757509987598336', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('1757606464978944', '1757509987598336', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('1795406350516224', '1757509987598336', '1795360737460224');
INSERT INTO `sys_menu_button` VALUES ('1847340797263872', '1846593582006272', '763206804963328');
INSERT INTO `sys_menu_button` VALUES ('2', '9', '1007779779182592');
INSERT INTO `sys_menu_button` VALUES ('20698011151630336', '1451155909509120', '2819607190568960');
INSERT INTO `sys_menu_button` VALUES ('20704668854255616', '2258969972178944', '20703880723562496');
INSERT INTO `sys_menu_button` VALUES ('20766942985977856', '20766815625936896', '1');
INSERT INTO `sys_menu_button` VALUES ('20766943011143680', '20766815625936896', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('20766943027920896', '20766815625936896', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('20766943048892416', '20766815625936896', '1795360737460224');
INSERT INTO `sys_menu_button` VALUES ('21131452464758784', '21131205961318400', '763206804963328');
INSERT INTO `sys_menu_button` VALUES ('21135896183046144', '21131205961318400', '2819607190568960');
INSERT INTO `sys_menu_button` VALUES ('2163726220263424', '2163592187084800', '1');
INSERT INTO `sys_menu_button` VALUES ('2163726237040640', '2163592187084800', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('2163726249623552', '2163592187084800', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('2163726262206464', '2163592187084800', '1795360737460224');
INSERT INTO `sys_menu_button` VALUES ('2163929136496640', '2163861868249088', '763206804963328');
INSERT INTO `sys_menu_button` VALUES ('2258511178235904', '7', '1');
INSERT INTO `sys_menu_button` VALUES ('2258511203401728', '7', '2256636777332736');
INSERT INTO `sys_menu_button` VALUES ('2258511224373248', '7', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('2258511241150464', '7', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('2258725221957632', '2258672239509504', '763206804963328');
INSERT INTO `sys_menu_button` VALUES ('2259066357284864', '2258969972178944', '1');
INSERT INTO `sys_menu_button` VALUES ('2259066378256384', '2258969972178944', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('2259066395033600', '2258969972178944', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('2259066411810816', '2258969972178944', '1795360737460224');
INSERT INTO `sys_menu_button` VALUES ('2261093145640960', '7', '2261000862564352');
INSERT INTO `sys_menu_button` VALUES ('2270520498192384', '2269941063483392', '1');
INSERT INTO `sys_menu_button` VALUES ('2270520523358208', '2269941063483392', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('2270520540135424', '2269941063483392', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('2270520561106944', '2269941063483392', '1795360737460224');
INSERT INTO `sys_menu_button` VALUES ('26507165615259648', '26476504758091776', '2824289539588096');
INSERT INTO `sys_menu_button` VALUES ('26507165661396992', '26476504758091776', '1');
INSERT INTO `sys_menu_button` VALUES ('26507165686562816', '26476504758091776', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('26507165707534336', '26476504758091776', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('26511240272543744', '26511186237325312', '763206804963328');
INSERT INTO `sys_menu_button` VALUES ('26571609242337280', '26571410583322624', '1');
INSERT INTO `sys_menu_button` VALUES ('26571609292668928', '26571410583322624', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('26571609343000576', '26571410583322624', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('26571626401234944', '26571551922978816', '763206804963328');
INSERT INTO `sys_menu_button` VALUES ('26574787094511616', '26571410583322624', '1795360737460224');
INSERT INTO `sys_menu_button` VALUES ('26715842821488640', '26714856669315072', '1');
INSERT INTO `sys_menu_button` VALUES ('26715842855043072', '26714856669315072', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('26715842876014592', '26714856669315072', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('26715911536771072', '26715728707059712', '1');
INSERT INTO `sys_menu_button` VALUES ('26715911570325504', '26715728707059712', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('26715911599685632', '26715728707059712', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('26724486367674368', '26577844645658624', '1');
INSERT INTO `sys_menu_button` VALUES ('26724486392840192', '26577844645658624', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('26846437945901056', '26845813934129152', '763206804963328');
INSERT INTO `sys_menu_button` VALUES ('28178037900050432', '28019952082485248', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('28283745773551616', '13358417838080', '28283426524102656');
INSERT INTO `sys_menu_button` VALUES ('2910422617292800', '2910350022279168', '1');
INSERT INTO `sys_menu_button` VALUES ('2910422659235840', '2910350022279168', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('2910422688595968', '2910350022279168', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('2910422717956096', '2910350022279168', '1795360737460224');
INSERT INTO `sys_menu_button` VALUES ('2910508327895040', '1451155909509120', '2824289539588096');
INSERT INTO `sys_menu_button` VALUES ('2910508369838080', '1451155909509120', '1');
INSERT INTO `sys_menu_button` VALUES ('2910508411781120', '1451155909509120', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('2910508449529856', '1451155909509120', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('3008720116121600', '13358417838080', '1');
INSERT INTO `sys_menu_button` VALUES ('3008720158064640', '13358417838080', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('3008720174841856', '13358417838080', '3008659554566144');
INSERT INTO `sys_menu_button` VALUES ('3008720187424768', '13358417838080', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('33081904680927232', '33081241360138240', '33081849764904960');
INSERT INTO `sys_menu_button` VALUES ('3316580893065216', '3316536806735872', '763206804963328');
INSERT INTO `sys_menu_button` VALUES ('33328711105249280', '33081241360138240', '33267466964566016');
INSERT INTO `sys_menu_button` VALUES ('3375940465852416', '13358417838080', '3375831514611712');
INSERT INTO `sys_menu_button` VALUES ('3548048869294080', '3547951557246976', '1');
INSERT INTO `sys_menu_button` VALUES ('3548048898654208', '3547951557246976', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('3548048915431424', '3547951557246976', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('38163043883941888', '38162771866550272', '763206804963328');
INSERT INTO `sys_menu_button` VALUES ('38165040703995904', '38161659570683904', '1');
INSERT INTO `sys_menu_button` VALUES ('38165040754327552', '38161659570683904', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('38165040766910464', '38161659570683904', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('4086872657625088', '3547951557246976', '1795360737460224');
INSERT INTO `sys_menu_button` VALUES ('4103794426118144', '4103758959083520', '763206804963328');
INSERT INTO `sys_menu_button` VALUES ('48295416805982208', '48295058385928192', '1');
INSERT INTO `sys_menu_button` VALUES ('48295416843730944', '48295058385928192', '48287050272604160');
INSERT INTO `sys_menu_button` VALUES ('48295416856313856', '48295058385928192', '3008659554566144');
INSERT INTO `sys_menu_button` VALUES ('48295416868896768', '48295058385928192', '28283426524102656');
INSERT INTO `sys_menu_button` VALUES ('48295416881479680', '48295058385928192', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('48295416944394240', '48295058385928192', '3375831514611712');
INSERT INTO `sys_menu_button` VALUES ('48305008919183360', '48304916703215616', '763206804963328');
INSERT INTO `sys_menu_button` VALUES ('48539533641252864', '38161659570683905', '1');
INSERT INTO `sys_menu_button` VALUES ('48539533683195904', '38161659570683905', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('48539533695778816', '38161659570683905', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('48539596044107776', '48295058385928193', '1');
INSERT INTO `sys_menu_button` VALUES ('48539596094439424', '48295058385928193', '48287050272604160');
INSERT INTO `sys_menu_button` VALUES ('48539596107022336', '48295058385928193', '3008659554566144');
INSERT INTO `sys_menu_button` VALUES ('48539596119605248', '48295058385928193', '28283426524102656');
INSERT INTO `sys_menu_button` VALUES ('48539596136382464', '48295058385928193', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('48539596186714112', '48295058385928193', '3375831514611712');
INSERT INTO `sys_menu_button` VALUES ('48539622128484352', '38162771866550273', '763206804963328');
INSERT INTO `sys_menu_button` VALUES ('48539642227589120', '48304916703215617', '763206804963328');
INSERT INTO `sys_menu_button` VALUES ('48614275438084096', '48614104260149248', '1');
INSERT INTO `sys_menu_button` VALUES ('48614275488415744', '48614104260149248', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('48614275517775872', '48614104260149248', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('48614287836446720', '48614229862776832', '763206804963328');
INSERT INTO `sys_menu_button` VALUES ('48673839864872960', '48667624430632960', '1');
INSERT INTO `sys_menu_button` VALUES ('48673839923593216', '48667624430632960', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('48673839944564736', '48667624430632960', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('48673856696614912', '48673777285857280', '763206804963328');
INSERT INTO `sys_menu_button` VALUES ('48678065487740928', '48667624430632960', '48287050272604160');
INSERT INTO `sys_menu_button` VALUES ('48678065559044096', '48667624430632960', '3008659554566144');
INSERT INTO `sys_menu_button` VALUES ('48678065580015616', '48667624430632960', '28283426524102656');
INSERT INTO `sys_menu_button` VALUES ('48678065596792832', '48667624430632960', '3375831514611712');
INSERT INTO `sys_menu_button` VALUES ('48892356476272640', '48892124845834240', '1');
INSERT INTO `sys_menu_button` VALUES ('48892356576935936', '48892124845834240', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('48892356610490368', '48892124845834240', '48287050272604160');
INSERT INTO `sys_menu_button` VALUES ('48892356623073280', '48892124845834240', '3008659554566144');
INSERT INTO `sys_menu_button` VALUES ('48892356635656192', '48892124845834240', '28283426524102656');
INSERT INTO `sys_menu_button` VALUES ('48892356644044800', '48892124845834240', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('48892356652433408', '48892124845834240', '3375831514611712');
INSERT INTO `sys_menu_button` VALUES ('48892368832692224', '48892279221387264', '763206804963328');
INSERT INTO `sys_menu_button` VALUES ('48948423222624256', '48892124845834240', '48286237202579456');
INSERT INTO `sys_menu_button` VALUES ('49029025737211904', '49027774555357184', '1');
INSERT INTO `sys_menu_button` VALUES ('49029025774960640', '49027774555357184', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('49029025791737856', '49027774555357184', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('49029061376212992', '49028146267160576', '1');
INSERT INTO `sys_menu_button` VALUES ('49029061422350336', '49028146267160576', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('49029061455904768', '49028146267160576', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('49029061468487680', '49028146267160576', '49028916572061696');
INSERT INTO `sys_menu_button` VALUES ('49029296336928768', '49029256612675584', '763206804963328');
INSERT INTO `sys_menu_button` VALUES ('49029316536696832', '49029176400805888', '763206804963328');
INSERT INTO `sys_menu_button` VALUES ('49030747830353920', '49030149684854784', '763206804963328');
INSERT INTO `sys_menu_button` VALUES ('49399599131000832', '49027774555357184', '48286237202579456');
INSERT INTO `sys_menu_button` VALUES ('50328268984811520', '50328019348226048', '763206804963328');
INSERT INTO `sys_menu_button` VALUES ('50341656477564928', '50341592241799168', '763206804963328');
INSERT INTO `sys_menu_button` VALUES ('50345251260334080', '50341592241799168', '1795360737460224');
INSERT INTO `sys_menu_button` VALUES ('50345388003033088', '50338340347576320', '1');
INSERT INTO `sys_menu_button` VALUES ('50345388024004608', '50338340347576320', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('50345388044976128', '50338340347576320', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('50345388061753344', '50338340347576320', '48286237202579456');
INSERT INTO `sys_menu_button` VALUES ('50800621128777728', '2', '50800567487823872');
INSERT INTO `sys_menu_button` VALUES ('50800669417799680', '26577844645658624', '50800567487823872');
INSERT INTO `sys_menu_button` VALUES ('50800699251884032', '8', '50800567487823872');
INSERT INTO `sys_menu_button` VALUES ('50827078513197056', '50827078076989440', '1');
INSERT INTO `sys_menu_button` VALUES ('50827078571917312', '50827078076989440', '48286237202579456');
INSERT INTO `sys_menu_button` VALUES ('50827078689357824', '50827078076989440', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('50827078731300864', '50827078076989440', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('50827079347863552', '50827078936821760', '763206804963328');
INSERT INTO `sys_menu_button` VALUES ('51562091479302144', '48295058385928193', '51562014773870592');
INSERT INTO `sys_menu_button` VALUES ('52294280730902528', '52294280579907584', '1');
INSERT INTO `sys_menu_button` VALUES ('52294280756068352', '52294280579907584', '48286237202579456');
INSERT INTO `sys_menu_button` VALUES ('52294280768651264', '52294280579907584', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('52294280785428480', '52294280579907584', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('52294281204858880', '52294280949006336', '763206804963328');
INSERT INTO `sys_menu_button` VALUES ('52308782532788224', '48295058385928192', '51562014773870592');

-- ----------------------------
-- Table structure for sys_operator
-- ----------------------------
DROP TABLE IF EXISTS `sys_operator`;
CREATE TABLE `sys_operator`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SO_PASSWORD` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户密码',
  `SO_SALT` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码加盐',
  `IS_STATUS` int(5) NULL DEFAULT NULL COMMENT '状态:0停用1启用',
  `IS_DEFAULT_PWD` int(5) NULL DEFAULT 1 COMMENT '是否默认密码 1是 0 否',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SO_PASSWORD`(`SO_PASSWORD`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_operator
-- ----------------------------
INSERT INTO `sys_operator` VALUES ('1', '3060177a2cc22475a8b9c0be4d6ba6f3', 'fdb.4Q', 1, 0);
INSERT INTO `sys_operator` VALUES ('28281555327647744', 'd95e3e4dd0ccf22106945632ab230cad', 'xiClTm', 1, 0);
INSERT INTO `sys_operator` VALUES ('28281967912943616', '0c4f06052e5786bd53ec3022ede3de1e', 'zdzTNR', 1, 0);
INSERT INTO `sys_operator` VALUES ('28281983868076032', '75fc31f96deafe4e064df15672abf32f', '66KteH', 1, 0);
INSERT INTO `sys_operator` VALUES ('28281998451671040', 'c5b7436bd18576324cf3681f9184ae1f', '7fUBjR', 1, 0);
INSERT INTO `sys_operator` VALUES ('4112733112893440', 'b922b9e424696e55714bb107f6ece83a', '.7HXge', 1, 0);
INSERT INTO `sys_operator` VALUES ('48303136200196097', '262ff9c34663d5a82e45ebe5b8c27a74', 'P2jSvy', 1, 0);
INSERT INTO `sys_operator` VALUES ('48601651874889729', '87fbc3c502b40a90e978465a49effe23', '-WECW3', 1, 0);
INSERT INTO `sys_operator` VALUES ('48679555707174913', 'bcac1195eef6ce7ce8f45425580bdf41', 'fW.Ydv', 1, 0);
INSERT INTO `sys_operator` VALUES ('48944951878221825', 'b696cf2470ac88242758ac3a253c62ad', 'iHkUI,', 1, 0);
INSERT INTO `sys_operator` VALUES ('51930103373889536', '8d51b5b2f7c974d32f8b38d2617f6e15', 'S,Jn\'\'', 1, 0);
INSERT INTO `sys_operator` VALUES ('52504512421691393', '936d195dc880cdeaa54c384aab5eb2b6', '+1QicT', 1, 0);

-- ----------------------------
-- Table structure for sys_operator_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_operator_role`;
CREATE TABLE `sys_operator_role`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SR_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色表id',
  `SO_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主表id',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SO_ID`(`SO_ID`) USING BTREE,
  CONSTRAINT `SO_ID` FOREIGN KEY (`SO_ID`) REFERENCES `sys_operator` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_operator_role
-- ----------------------------
INSERT INTO `sys_operator_role` VALUES ('1', '1', '1');
INSERT INTO `sys_operator_role` VALUES ('28281733577179136', '27635893028257792', '28281555327647744');
INSERT INTO `sys_operator_role` VALUES ('28282023776878592', '27635943053721600', '28281967912943616');
INSERT INTO `sys_operator_role` VALUES ('28282034799509504', '27635966298554368', '28281983868076032');
INSERT INTO `sys_operator_role` VALUES ('28282046388371456', '27635991015587840', '28281998451671040');
INSERT INTO `sys_operator_role` VALUES ('4113478558154752', '4095556896948224', '4112733112893440');
INSERT INTO `sys_operator_role` VALUES ('48307877735038976', '48307839919194112', '48303136200196097');
INSERT INTO `sys_operator_role` VALUES ('48603182229618688', '48309528801837056', '48601651874889729');
INSERT INTO `sys_operator_role` VALUES ('48682102345957376', '48678292462501888', '48679555707174913');
INSERT INTO `sys_operator_role` VALUES ('48946995997442048', '48892526509162496', '48944951878221825');
INSERT INTO `sys_operator_role` VALUES ('50858834574442496', '50858364522987520', '48303136200196097');
INSERT INTO `sys_operator_role` VALUES ('50858913993588736', '50858364522987520', '1');
INSERT INTO `sys_operator_role` VALUES ('52304798648631296', '52299464139866112', '48303136200196097');
INSERT INTO `sys_operator_role` VALUES ('52309475645718528', '48892526509162496', '51930103373889536');
INSERT INTO `sys_operator_role` VALUES ('52504590830010368', '48309996873580544', '52504512421691393');
INSERT INTO `sys_operator_role` VALUES ('52509766273990656', '52299464139866112', '1');

-- ----------------------------
-- Table structure for sys_operator_sub
-- ----------------------------
DROP TABLE IF EXISTS `sys_operator_sub`;
CREATE TABLE `sys_operator_sub`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SO_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '帐号主表序号',
  `SOS_USERNAME` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户登录账号',
  `SOS_CREATETIME` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '录入时间',
  `SOS_REMARK` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `SOS_DEFAULT` int(1) NULL DEFAULT NULL COMMENT '是否默认账户',
  `IS_STATUS` int(1) NULL DEFAULT NULL COMMENT '状态:0停用1启用',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `KIM_OPERATORSUB_SO`(`SO_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_operator_sub
-- ----------------------------
INSERT INTO `sys_operator_sub` VALUES ('1', '1', 'admin', '2018-3-22 15:06:46', '超级管理员', 1, 1);
INSERT INTO `sys_operator_sub` VALUES ('28281761989394432', '28281555327647744', 'test2', '2018-06-11 17:15:26', '', 1, 1);
INSERT INTO `sys_operator_sub` VALUES ('28282067062095872', '28281967912943616', 'test3', '2018-06-11 17:16:39', '', 1, 1);
INSERT INTO `sys_operator_sub` VALUES ('28282094119550976', '28281983868076032', 'test4', '2018-06-11 17:16:46', '', 1, 1);
INSERT INTO `sys_operator_sub` VALUES ('28282116387110912', '28281998451671040', 'test5', '2018-06-11 17:16:51', '', 1, 1);
INSERT INTO `sys_operator_sub` VALUES ('28282832660987904', '1', '超级管理员', '2018-06-11 17:19:42', '', 0, 1);
INSERT INTO `sys_operator_sub` VALUES ('4113423134621696', '4112733112893440', 'test', '2018-04-06 00:39:05', '测试', 1, 1);
INSERT INTO `sys_operator_sub` VALUES ('48306353327833088', '48303136200196097', 'division_test', '2018-08-05 23:26:01', '', 1, 1);
INSERT INTO `sys_operator_sub` VALUES ('48529046765568000', '48303136200196097', 'division_test2', '2018-08-06 14:10:55', '', 0, 1);
INSERT INTO `sys_operator_sub` VALUES ('48602665436839936', '48601651874889729', 'department_test', '2018-08-06 19:03:27', '', 1, 1);
INSERT INTO `sys_operator_sub` VALUES ('48682071438131200', '48679555707174913', 'teacher_test', '2018-08-07 00:18:59', '', 1, 1);
INSERT INTO `sys_operator_sub` VALUES ('48946968478613504', '48944951878221825', 'student_test', '2018-08-07 17:51:36', '', 1, 1);
INSERT INTO `sys_operator_sub` VALUES ('52309291238948864', '51930103373889536', 'student_test2', '2018-08-17 00:32:16', '', 1, 1);
INSERT INTO `sys_operator_sub` VALUES ('52504620978667520', '52504512421691393', 'department_manager', '2018-08-17 13:28:26', '', 1, 1);

-- ----------------------------
-- Table structure for sys_process_definition
-- ----------------------------
DROP TABLE IF EXISTS `sys_process_definition`;
CREATE TABLE `sys_process_definition`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SO_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人',
  `SR_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '查看全部记录角色',
  `BUS_PROCESS` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程大类',
  `BUS_PROCESS2` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程小类',
  `SPD_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '流程名称',
  `SPD_VERSION` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '流程版本',
  `SPD_UPDATE_TABLE` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '流程更新表名',
  `SPD_UPDATE_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '流程更新表名称字段',
  `SPD_COLLEGE_FIELD` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '院系ID字段',
  `SPD_DEPARTMENT_FIELD` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '系部ID字段',
  `SPD_CLASS_FIELD` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '班级ID字段',
  `SPD_DESCRIBE` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程描述',
  `SDP_ENTRY_TIME` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '添加时间',
  `IS_STATUS` int(5) NULL DEFAULT NULL COMMENT '是否启用',
  `IS_MULTISTAGE_BACK` int(255) NULL DEFAULT NULL COMMENT '是否允许多级回退',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `BUS_PROCESS`(`BUS_PROCESS`, `BUS_PROCESS2`) USING BTREE,
  INDEX `IS_STATUS`(`IS_STATUS`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_process_definition
-- ----------------------------
INSERT INTO `sys_process_definition` VALUES ('26816452786913280', '1', '1', '1001', '2001', '测试流程', '1.0', 'TEST_PROCESS', 'NAME', '', '', NULL, '测试流程', '2018-06-07 16:12:49', 1, 1);
INSERT INTO `sys_process_definition` VALUES ('50838310695731200', '1', '50858364522987520', '100', '109', '资助管理-学院奖学金', '1.0', 'v_aid_college_scholarship', 'BS_NAME', 'BDM_COLLEGE', 'BDM_ID', 'BC_ID', '', '2018-08-12 23:07:07', 1, 1);
INSERT INTO `sys_process_definition` VALUES ('52297782794387456', '1', '52299464139866112', '100', '110', '资助管理-年度表彰', '1.0', 'V_AID_COMMEND', 'BS_NAME', 'BDM_COLLEGE', 'BDM_ID', 'BC_ID', '', '2018-08-12 23:07:07', 1, 1);

-- ----------------------------
-- Table structure for sys_process_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_process_log`;
CREATE TABLE `sys_process_log`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SPS_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '流程进度表ID',
  `SPL_TABLE_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '流程表ID',
  `SPL_SO_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '办理人ID',
  `SPL_PROCESS_STATUS` int(5) NULL DEFAULT NULL COMMENT '流程办理状态',
  `SPL_TRANSACTOR` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '办理人',
  `SPL_OPINION` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '办理意见',
  `SPL_ENTRY_TIME` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '办理时间',
  `SPL_TYPE` int(5) NULL DEFAULT NULL COMMENT '办理类型',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SP_LOG_ID`(`SPS_ID`) USING BTREE,
  INDEX `SPL_SO_ID`(`SPL_SO_ID`) USING BTREE,
  INDEX `SPL_TABLE_ID`(`SPL_TABLE_ID`) USING BTREE,
  CONSTRAINT `SP_LOG_ID` FOREIGN KEY (`SPS_ID`) REFERENCES `sys_process_schedule` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_process_log
-- ----------------------------
INSERT INTO `sys_process_log` VALUES ('28751861985050624', '28751861846638592', '1', '4112733112893440', 0, 'test', '通过', '2018-06-13 00:23:27', 0);
INSERT INTO `sys_process_log` VALUES ('29386037046280192', '28751861846638592', '1', '28281555327647744', 1, 'test2', '退回', '2018-06-14 18:23:26', 1);
INSERT INTO `sys_process_log` VALUES ('29407076132323328', '28751861846638592', '1', '4112733112893440', 0, 'test', '通过', '2018-06-14 19:47:02', 0);
INSERT INTO `sys_process_log` VALUES ('29411961355632640', '28751861846638592', '1', '28281555327647744', 1, 'test2', '退回', '2018-06-14 20:06:27', 1);
INSERT INTO `sys_process_log` VALUES ('29411996260630528', '28751861846638592', '1', '4112733112893440', 0, 'test', '通过', '2018-06-14 20:06:35', 0);
INSERT INTO `sys_process_log` VALUES ('29412015441182720', '28751861846638592', '1', '28281555327647744', 1, 'test2', '通过', '2018-06-14 20:06:40', 0);
INSERT INTO `sys_process_log` VALUES ('31157988051910656', '28751861846638592', '1', '28281967912943616', 2, 'test3', '通过', '2018-06-19 15:44:32', 0);
INSERT INTO `sys_process_log` VALUES ('31158090954964992', '28751861846638592', '1', '28281983868076032', 3, 'test4', '通过', '2018-06-19 15:44:57', 0);
INSERT INTO `sys_process_log` VALUES ('31162593150238720', '28751861846638592', '1', '28281998451671040', 4, 'test5', '通过', '2018-06-19 16:02:50', 0);
INSERT INTO `sys_process_log` VALUES ('31464118317744128', '31464118024142848', '10', '4112733112893440', 0, 'test', '通过', '2018-06-20 12:00:59', 0);
INSERT INTO `sys_process_log` VALUES ('31465748702429184', '31464118024142848', '10', '4112733112893440', -1, 'test', '用户撤回(系统)', '2018-06-20 12:07:28', 2);
INSERT INTO `sys_process_log` VALUES ('31467798358130688', '31464118024142848', '10', '4112733112893440', 0, 'test', '通过', '2018-06-20 12:15:37', 0);
INSERT INTO `sys_process_log` VALUES ('31467812618764288', '31464118024142848', '10', '4112733112893440', -1, 'test', '用户撤回(系统)', '2018-06-20 12:15:40', 2);
INSERT INTO `sys_process_log` VALUES ('31467831618961408', '31464118024142848', '10', '4112733112893440', 0, 'test', '通过', '2018-06-20 12:15:45', 0);
INSERT INTO `sys_process_log` VALUES ('31815520994983936', '31464118024142848', '10', '28281555327647744', 1, 'test2', '说明\r\n当应用了搜索时，会在适当位置显示表格的搜索条件。 这个配置允许打开或者关闭这个特性。\r\n\r\n需要注意的是，默认情况下信息提示显示在表格下面的左边，但是这个可以用 domDT 和 CSS来控制.\r\n\r\n数据类型\r\n这个选项用下列的数据类型赋值:\r\n\r\nbooleanJS\r\n默认值', '2018-06-21 11:17:20', 1);
INSERT INTO `sys_process_log` VALUES ('31820886759702528', '31820886659039232', '11', '4112733112893440', 0, 'test', 'test1', '2018-06-21 11:38:40', 0);
INSERT INTO `sys_process_log` VALUES ('31820931802333184', '31820886659039232', '11', '4112733112893440', -1, 'test', '用户撤回(系统)', '2018-06-21 11:38:50', 2);
INSERT INTO `sys_process_log` VALUES ('31821016380473344', '31820886659039232', '11', '4112733112893440', 0, 'test', '项目负责人不得是失信被执行人。', '2018-06-21 11:39:10', 0);
INSERT INTO `sys_process_log` VALUES ('31821124169891840', '31820886659039232', '11', '28281555327647744', 1, 'test2', '项目牵头申报单位不得是列入项目管理资信&ldquo;黑名单&rdquo;且取消申报资格处罚时限未到期。', '2018-06-21 11:39:36', 0);
INSERT INTO `sys_process_log` VALUES ('31821240096260096', '31820886659039232', '11', '28281967912943616', 2, 'test3', '省属公益类科研院所不在本批科技计划项目申报之列', '2018-06-21 11:40:04', 0);
INSERT INTO `sys_process_log` VALUES ('31821410477277184', '31820886659039232', '11', '28281983868076032', 3, 'test4', '项目负责人当年度在（专题、区域发展、创新资金、星火、对外合作、引导性、自然基金、高校产学合作、软科学、STS项目类型）中只能申请其中1个项目', '2018-06-21 11:40:44', 0);
INSERT INTO `sys_process_log` VALUES ('31821493885206528', '31820886659039232', '11', '28281998451671040', 4, 'test5', '必须有合作单位，附件有签订项目合作协议', '2018-06-21 11:41:04', 0);
INSERT INTO `sys_process_log` VALUES ('31821493948121088', '31820886659039232', '11', '28281998451671040', 999, 'test5', '审核通过(系统)', '2018-06-21 11:41:04', 0);
INSERT INTO `sys_process_log` VALUES ('33336595876675584', '33336595616628736', '1', '4112733112893440', 0, 'test', '通过', '2018-06-25 16:01:33', 0);
INSERT INTO `sys_process_log` VALUES ('33336616118386688', '33336595616628736', '1', '4112733112893440', -1, 'test', '用户撤回(系统)', '2018-06-25 16:01:38', 2);
INSERT INTO `sys_process_log` VALUES ('33339241551364096', '33336595616628736', '1', '4112733112893440', 0, 'test', '通过', '2018-06-25 16:12:04', 0);
INSERT INTO `sys_process_log` VALUES ('33339355066007552', '33336595616628736', '1', '28281555327647744', 1, 'test2', '通过21321312', '2018-06-25 16:12:31', 0);
INSERT INTO `sys_process_log` VALUES ('33339446736715776', '33336595616628736', '1', '28281967912943616', 2, 'test3', '李凯文 2018/6/25 10:33:51\r\n被爆破了？\r\n\r\n   .  2018/6/25 10:34:05\r\n不知道 很慢\r\n\r\n   .  2018/6/25 10:34:14\r\n每一步都感觉要爆炸了\r\n10:35:53\r\n李凯文 2018/6/25 10:35:53\r\n估计是代码有问题\r\n15:45:33\r\n李凯文 2018/6/25 15:45:33\r\n范贤光hkht-sq', '2018-06-25 16:12:52', 0);
INSERT INTO `sys_process_log` VALUES ('33339520153812992', '33336595616628736', '1', '28281983868076032', 3, 'test4', '哎\r\n10:33:29\r\n   .  2018/6/25 10:33:29\r\n几把爆\r\n\r\n   .  2018/6/25 10:33:34\r\n\r\n\r\n   .  2018/6/25 10:33:40\r\n卡了十年了', '2018-06-25 16:13:10', 0);
INSERT INTO `sys_process_log` VALUES ('33339631302868992', '33336595616628736', '1', '28281998451671040', 4, 'test5', '多通道（细胞）拉曼光谱快速成像仪器开发及产业化', '2018-06-25 16:13:36', 0);
INSERT INTO `sys_process_log` VALUES ('33339631344812032', '33336595616628736', '1', '28281998451671040', 999, 'test5', '审核通过(系统)', '2018-06-25 16:13:36', 0);
INSERT INTO `sys_process_log` VALUES ('33341909451669504', '33341909359394816', '7', '28281555327647744', 1, 'test2', 'ces', '2018-06-25 16:22:40', 0);
INSERT INTO `sys_process_log` VALUES ('33344268596674560', '33341909359394816', '7', '28281555327647744', -1, 'test2', '用户撤回(系统)', '2018-06-25 16:32:02', 2);
INSERT INTO `sys_process_log` VALUES ('33344288326680576', '33341909359394816', '7', '28281555327647744', 0, 'test2', '通过', '2018-06-25 16:32:07', 0);
INSERT INTO `sys_process_log` VALUES ('33392428446646272', '33392428211765248', '7', '28281555327647744', 1, 'test2', '通过', '2018-06-25 19:43:24', 0);
INSERT INTO `sys_process_log` VALUES ('33392650191110144', '33392428211765248', '7', '28281555327647744', -1, 'test2', '用户撤回(系统)', '2018-06-25 19:44:17', 2);
INSERT INTO `sys_process_log` VALUES ('33394905778749440', '33394905602588672', '7', '28281555327647744', 1, 'test2', '通过', '2018-06-25 19:53:15', 0);
INSERT INTO `sys_process_log` VALUES ('33394915509534720', '33394905602588672', '7', '28281555327647744', -1, 'test2', '用户撤回(系统)', '2018-06-25 19:53:17', 2);
INSERT INTO `sys_process_log` VALUES ('33394957167362048', '33394905602588672', '7', '28281555327647744', 1, 'test2', '通过', '2018-06-25 19:53:27', 0);
INSERT INTO `sys_process_log` VALUES ('33395132145336320', '33394905602588672', '7', '28281967912943616', 2, 'test3', '通过123', '2018-06-25 19:54:09', 0);
INSERT INTO `sys_process_log` VALUES ('33406850359623680', '33406850229600256', '7', '28281555327647744', 1, 'test2', '通过', '2018-06-25 20:40:43', 0);
INSERT INTO `sys_process_log` VALUES ('33406861902348288', '33406850229600256', '7', '28281555327647744', -1, 'test2', '用户撤回(系统)', '2018-06-25 20:40:45', 2);
INSERT INTO `sys_process_log` VALUES ('33407487583453184', '33406850229600256', '7', '28281555327647744', 1, 'test2', '通过', '2018-06-25 20:42:57', 0);
INSERT INTO `sys_process_log` VALUES ('33407585252016128', '33406850229600256', '7', '28281555327647744', -1, 'test2', '用户撤回(系统)', '2018-06-25 20:43:38', 2);
INSERT INTO `sys_process_log` VALUES ('33407615027380224', '33406850229600256', '7', '28281555327647744', 1, 'test2', '通过', '2018-06-25 20:43:45', 0);
INSERT INTO `sys_process_log` VALUES ('33408270529986560', '33406850229600256', '7', '28281967912943616', 2, 'test3', '退回', '2018-06-25 20:46:21', 1);
INSERT INTO `sys_process_log` VALUES ('33408399429337088', '33406850229600256', '7', '28281555327647744', 1, 'test2', '通过123', '2018-06-25 20:46:52', 0);
INSERT INTO `sys_process_log` VALUES ('33408410372276224', '33406850229600256', '7', '28281555327647744', -1, 'test2', '用户撤回(系统)', '2018-06-25 20:46:55', 2);
INSERT INTO `sys_process_log` VALUES ('33408426990108672', '33406850229600256', '7', '28281555327647744', 1, 'test2', '通过123', '2018-06-25 20:46:59', 0);
INSERT INTO `sys_process_log` VALUES ('33408490370236416', '33406850229600256', '7', '28281967912943616', 2, 'test3', '通过123', '2018-06-25 20:47:14', 0);
INSERT INTO `sys_process_log` VALUES ('33408600030314496', '33406850229600256', '7', '28281983868076032', 3, 'test4', '通过123123', '2018-06-25 20:47:40', 0);
INSERT INTO `sys_process_log` VALUES ('33408707257696256', '33406850229600256', '7', '28281998451671040', 4, 'test5', 'gggggggggggggggggggggg', '2018-06-25 20:48:05', 0);
INSERT INTO `sys_process_log` VALUES ('33408707295444992', '33406850229600256', '7', '28281998451671040', 999, 'test5', '审核通过(系统)', '2018-06-25 20:48:05', 0);
INSERT INTO `sys_process_log` VALUES ('33410262950215680', '33410262795026432', '1', '4112733112893440', 0, 'test', 'cessss', '2018-06-25 20:54:16', 0);
INSERT INTO `sys_process_log` VALUES ('33410274073509888', '33410262795026432', '1', '4112733112893440', -1, 'test', '用户撤回(系统)', '2018-06-25 20:54:19', 2);
INSERT INTO `sys_process_log` VALUES ('33410899645562880', '33410262795026432', '1', '4112733112893440', 0, 'test', '通过', '2018-06-25 20:56:48', 0);
INSERT INTO `sys_process_log` VALUES ('48256390354960384', '48256389629345792', '10', '4112733112893440', 0, 'test', '通过', '2018-08-05 20:07:29', 0);
INSERT INTO `sys_process_log` VALUES ('48257205937373184', '48256389629345792', '10', '28281555327647744', 1, 'test2', '通过', '2018-08-05 20:10:43', 0);
INSERT INTO `sys_process_log` VALUES ('48257624361140224', '48256389629345792', '10', '28281967912943616', 2, 'test3', '通过', '2018-08-05 20:12:23', 0);
INSERT INTO `sys_process_log` VALUES ('48257688118755328', '48256389629345792', '10', '28281983868076032', 3, 'test4', '通过', '2018-08-05 20:12:38', 0);
INSERT INTO `sys_process_log` VALUES ('48257892914036736', '48256389629345792', '10', '28281998451671040', 4, 'test5', '通过', '2018-08-05 20:13:27', 0);
INSERT INTO `sys_process_log` VALUES ('48257892968562688', '48256389629345792', '10', '28281998451671040', 999, 'test5', '审核通过(系统)', '2018-08-05 20:13:27', 0);
INSERT INTO `sys_process_log` VALUES ('48521428084981760', '33410262795026432', '1', '28281967912943616', 2, 'test3', '退回', '2018-08-06 13:40:39', 1);
INSERT INTO `sys_process_log` VALUES ('49341093661114368', '33410262795026432', '1', '4112733112893440', 0, 'test', '通过', '2018-08-08 19:57:42', 0);
INSERT INTO `sys_process_log` VALUES ('49341107045138432', '33410262795026432', '1', '4112733112893440', -1, 'test', '用户撤回(系统)', '2018-08-08 19:57:46', 2);
INSERT INTO `sys_process_log` VALUES ('49341120647266304', '33410262795026432', '1', '4112733112893440', 0, 'test', '通过', '2018-08-08 19:57:49', 0);
INSERT INTO `sys_process_log` VALUES ('50846995639697408', '50846995119603712', '50844794401849344', '48601651874889729', 5, 'department_test', '通过', '2018-08-12 23:41:37', 0);
INSERT INTO `sys_process_log` VALUES ('50852328185528320', '50846995119603712', '50844794401849344', '48303136200196097', 99, 'division_test', '退回', '2018-08-13 00:02:49', 1);
INSERT INTO `sys_process_log` VALUES ('50854681588531200', '50854681315901440', '50844794401849344', '48601651874889729', 5, 'department_test', '通过', '2018-08-13 00:12:10', 0);
INSERT INTO `sys_process_log` VALUES ('50855922913771520', '50855922569838592', '50844794401849344', '48601651874889729', 5, 'department_test', '通过', '2018-08-13 00:17:06', 0);
INSERT INTO `sys_process_log` VALUES ('51359243487412224', '51351046567493632', '51351046366167040', '48601651874889729', 5, 'department_test', '12312', '2018-08-14 09:37:07', 0);
INSERT INTO `sys_process_log` VALUES ('51360166968295424', '51351046567493632', '51351046366167040', '48601651874889729', -1, 'department_test', '用户撤回(系统)', '2018-08-14 09:40:47', 2);
INSERT INTO `sys_process_log` VALUES ('52307120808263680', '52306244119035904', '52306243808657408', '48601651874889729', 6, 'department_test', '123', '2018-08-17 00:23:38', 0);
INSERT INTO `sys_process_log` VALUES ('52309055435177984', '52306244119035904', '52306243808657408', '48303136200196097', 99, 'division_test', '12321', '2018-08-17 00:31:20', 0);
INSERT INTO `sys_process_log` VALUES ('52309055842025472', '52306244119035904', '52306243808657408', '48303136200196097', 999, 'division_test', '审核通过(系统)', '2018-08-17 00:31:20', 0);
INSERT INTO `sys_process_log` VALUES ('52505246781407232', '50855922569838592', '50844794401849344', '48601651874889729', -1, 'department_test', '用户撤回(系统)', '2018-08-17 13:30:55', 2);
INSERT INTO `sys_process_log` VALUES ('52508086329409536', '52508085763178496', '50844794401849344', '48601651874889729', 50, 'department_test', '12321', '2018-08-17 13:42:12', 0);
INSERT INTO `sys_process_log` VALUES ('52508632826249216', '52508085763178496', '50844794401849344', '52504512421691393', 51, 'department_manager', '12312', '2018-08-17 13:44:22', 0);

-- ----------------------------
-- Table structure for sys_process_schedule
-- ----------------------------
DROP TABLE IF EXISTS `sys_process_schedule`;
CREATE TABLE `sys_process_schedule`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SO_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人ID',
  `SHOW_SO_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '拥有查看权限的ID',
  `SPD_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '流程定义ID',
  `SPS_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '当前办理步骤ID',
  `SPS_TABLE_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '流程表ID',
  `SPS_TABLE_NAME` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '流程表名称',
  `SPS_AUDIT_STATUS` int(5) NOT NULL DEFAULT 0 COMMENT '审核状态',
  `SPS_BACK_STATUS` int(5) NOT NULL DEFAULT 0 COMMENT '退回状态',
  `SPS_BACK_STATUS_TRANSACTOR` int(5) NULL DEFAULT NULL COMMENT '退回到的审核状态',
  `SPS_STEP_TYPE` int(5) NULL DEFAULT NULL COMMENT '当前办理步骤类型',
  `SPS_STEP_TRANSACTOR` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '当前办理步骤办理人',
  `SPS_PREV_AUDIT_STATUS` int(5) NULL DEFAULT NULL COMMENT '上一次流程审核状态',
  `SPS_PREV_STEP_TYPE` int(5) NULL DEFAULT NULL COMMENT '上一次办理步骤类型',
  `SPS_PREV_STEP_TRANSACTOR` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上一次办理步骤办理人',
  `SPS_PREV_STEP_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上一次办理步骤ID',
  `SPS_IS_CANCEL` int(5) NULL DEFAULT 0 COMMENT '是否作废',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SP_SCHEDULE_SPD_ID`(`SPD_ID`) USING BTREE,
  INDEX `SPS_STEP_TYPE_TRANSACTOR`(`SPS_STEP_TYPE`, `SPS_STEP_TRANSACTOR`) USING BTREE,
  INDEX `SHOW_SO_ID`(`SHOW_SO_ID`) USING BTREE,
  INDEX `SPS_TABLE_ID`(`SPS_TABLE_ID`) USING BTREE,
  INDEX `SPS_IS_CANCEL`(`SPS_IS_CANCEL`) USING BTREE,
  CONSTRAINT `SP_SCHEDULE_SPD_ID` FOREIGN KEY (`SPD_ID`) REFERENCES `sys_process_definition` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_process_schedule
-- ----------------------------
INSERT INTO `sys_process_schedule` VALUES ('28751861846638592', '4112733112893440', NULL, '26816452786913280', NULL, '1', '', 999, 0, -1, 1, '0', 4, 0, '28281998451671040', NULL, 1);
INSERT INTO `sys_process_schedule` VALUES ('31464118024142848', '4112733112893440', NULL, '26816452786913280', NULL, '10', '', -1, 1, 0, 2, '4112733112893440', 1, 1, '28281555327647744', NULL, 1);
INSERT INTO `sys_process_schedule` VALUES ('31820886659039232', '4112733112893440', NULL, '26816452786913280', NULL, '11', '', 999, 0, -1, 1, '0', 4, 0, '28281998451671040', NULL, 1);
INSERT INTO `sys_process_schedule` VALUES ('33336595616628736', '4112733112893440', NULL, '26816452786913280', NULL, '1', '', 999, 0, -1, 1, '0', 4, 0, '28281998451671040', NULL, 1);
INSERT INTO `sys_process_schedule` VALUES ('33341909359394816', '28281555327647744', NULL, '26816452786913280', NULL, '7', '7', 1, 0, -1, 1, '27635893028257792', -1, 0, '28281555327647744', NULL, 1);
INSERT INTO `sys_process_schedule` VALUES ('33392428211765248', '28281555327647744', NULL, '26816452786913280', '27652261702270976', '7', '7', -1, 2, 0, 2, '28281555327647744', 2, 2, '28281555327647744', '27652330522411008', 1);
INSERT INTO `sys_process_schedule` VALUES ('33394905602588672', '28281555327647744', NULL, '26816452786913280', '27652553185427456', '7', '7', 3, 0, -1, 1, '27635966298554368', 2, 0, '28281967912943616', '27652330522411008', 1);
INSERT INTO `sys_process_schedule` VALUES ('33406850229600256', '28281555327647744', NULL, '26816452786913280', '27653508450746368', '7', '7', 999, 0, -1, 1, '0', 4, 0, '28281998451671040', '27652648370962432', 0);
INSERT INTO `sys_process_schedule` VALUES ('33410262795026432', '4112733112893440', NULL, '26816452786913280', '27652261702270976', '1', '测试流程1', 1, 0, -1, 1, '27635893028257792', -1, 0, '4112733112893440', '27650461607657472', 0);
INSERT INTO `sys_process_schedule` VALUES ('48256389629345792', '4112733112893440', NULL, '26816452786913280', '27653508450746368', '10', '10', 999, 0, -1, 1, '0', 4, 0, '28281998451671040', '27652648370962432', 0);
INSERT INTO `sys_process_schedule` VALUES ('50846995119603712', '48601651874889729', NULL, '50838310695731200', '50839589836816384', '50844794401849344', 'student_test', -1, 1, 5, 2, '48601651874889729', 99, 1, '48303136200196097', '50839707340242944', 1);
INSERT INTO `sys_process_schedule` VALUES ('50854681315901440', '48601651874889729', NULL, '50838310695731200', '50839707340242944', '50844794401849344', 'student_test', 99, 0, -1, 1, '48307839919194112', 0, 0, '48601651874889729', '50839589836816384', 1);
INSERT INTO `sys_process_schedule` VALUES ('50855922569838592', '48601651874889729', '48944951878221825', '50838310695731200', '50839589836816384', '50844794401849344', 'student_test', -1, 2, 5, 2, '48601651874889729', 99, 2, '48601651874889729', '50839707340242944', 1);
INSERT INTO `sys_process_schedule` VALUES ('51351046567493632', '48601651874889729', '48944951878221825', '50838310695731200', '50839589836816384', '51351046366167040', 'student_test', -1, 2, 5, 2, '48601651874889729', 99, 2, '48601651874889729', '50839707340242944', 1);
INSERT INTO `sys_process_schedule` VALUES ('51936808040136704', '1', '51930103373889536', '50838310695731200', NULL, '51936807884947456', 'student_test2', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_process_schedule` VALUES ('52306244119035904', '48601651874889729', '51930103373889536', '52297782794387456', '52297783385784320', '52306243808657408', 'student_test2', 999, 0, -1, 1, '0', 99, 0, '48303136200196097', '52297783364812800', 1);
INSERT INTO `sys_process_schedule` VALUES ('52508085763178496', '48601651874889729', '48944951878221825', '50838310695731200', '50839707340242944', '50844794401849344', 'student_test', 99, 0, -1, 1, '48307839919194112', 51, 0, '52504512421691393', '52506599511556096', 0);

-- ----------------------------
-- Table structure for sys_process_schedule_cancel
-- ----------------------------
DROP TABLE IF EXISTS `sys_process_schedule_cancel`;
CREATE TABLE `sys_process_schedule_cancel`  (
  `ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `SPS_ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '流程进度表',
  `SO_ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '作废人',
  `SPSC_REASON` varchar(3000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '作废原因',
  `SPSC_ENTRY_TIME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '作废时间',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SPS_ID`(`SPS_ID`) USING BTREE,
  INDEX `SO_ID`(`SO_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_process_schedule_cancel
-- ----------------------------
INSERT INTO `sys_process_schedule_cancel` VALUES ('33328432880287744', '28751861846638592', '1', '测试作废', '2018-06-25 15:29:07');
INSERT INTO `sys_process_schedule_cancel` VALUES ('33330123268685824', '31820886659039232', '1', '测试作废2', '2018-06-25 15:35:50');
INSERT INTO `sys_process_schedule_cancel` VALUES ('33330140897345536', '31464118024142848', '1', '测试作废3', '2018-06-25 15:35:54');
INSERT INTO `sys_process_schedule_cancel` VALUES ('33340008060420096', '33336595616628736', '1', '作废', '2018-06-25 16:15:06');
INSERT INTO `sys_process_schedule_cancel` VALUES ('33344463388540928', '33341909359394816', '1', '123', '2018-06-25 16:32:49');
INSERT INTO `sys_process_schedule_cancel` VALUES ('33394862799716352', '33392428211765248', '1', '123', '2018-06-25 19:53:05');
INSERT INTO `sys_process_schedule_cancel` VALUES ('33406707115753472', '33394905602588672', '1', '123', '2018-06-25 20:40:09');
INSERT INTO `sys_process_schedule_cancel` VALUES ('50854547177865216', '50846995119603712', '1', '50846995119603712', '2018-08-13 00:11:38');
INSERT INTO `sys_process_schedule_cancel` VALUES ('50854742649208832', '50854681315901440', '1', '50854681315901440', '2018-08-13 00:12:24');
INSERT INTO `sys_process_schedule_cancel` VALUES ('51360242256052224', '51351046567493632', '1', '51351046567493632', '2018-08-14 09:41:05');
INSERT INTO `sys_process_schedule_cancel` VALUES ('52506901400780800', '52306244119035904', '1', '52306244119035904', '2018-08-17 13:37:30');
INSERT INTO `sys_process_schedule_cancel` VALUES ('52506913065140224', '51936808040136704', '1', '51936808040136704', '2018-08-17 13:37:33');
INSERT INTO `sys_process_schedule_cancel` VALUES ('52507508316569600', '50855922569838592', '1', '50855922569838592', '2018-08-17 13:39:54');

-- ----------------------------
-- Table structure for sys_process_start
-- ----------------------------
DROP TABLE IF EXISTS `sys_process_start`;
CREATE TABLE `sys_process_start`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SPD_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '流程定义表ID',
  `SR_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '流程启动角色',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SPD_ID`(`SPD_ID`) USING BTREE,
  CONSTRAINT `SPD_ID` FOREIGN KEY (`SPD_ID`) REFERENCES `sys_process_definition` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_process_start
-- ----------------------------
INSERT INTO `sys_process_start` VALUES ('28011053078020096', '26816452786913280', '4095556896948224');
INSERT INTO `sys_process_start` VALUES ('28015493549916160', '26816452786913280', '27635893028257792');
INSERT INTO `sys_process_start` VALUES ('50839748784160768', '50838310695731200', '48309528801837056');
INSERT INTO `sys_process_start` VALUES ('52297784262393856', '52297782794387456', '48309528801837056');

-- ----------------------------
-- Table structure for sys_process_step
-- ----------------------------
DROP TABLE IF EXISTS `sys_process_step`;
CREATE TABLE `sys_process_step`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SPD_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '流程定义表ID',
  `SR_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属办理角色',
  `SPS_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '步骤名称',
  `SPS_ORDER` int(5) NOT NULL COMMENT '步骤顺序',
  `SPS_STEP_TYPE` int(5) NOT NULL COMMENT '办理步骤类型',
  `SPS_PROCESS_STATUS` int(5) NOT NULL COMMENT '步骤流程状态',
  `SPS_IS_OVER_TIME` int(5) NULL DEFAULT NULL COMMENT '是否验证超时(开启后不填超时时间，默认为24小时 1440分钟)',
  `SPS_OVER_TIME` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '超时时间(分)',
  `SPS_TAB` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '步骤标记',
  `SPS_IS_ADVANCE_CHECK` int(5) NULL DEFAULT NULL COMMENT '是否前进校验',
  `SPS_IS_RETREAT_CHECK` int(5) NULL DEFAULT NULL COMMENT '是否退回校验',
  `SPS_IS_ADVANCE_EXECUTE` int(5) NULL DEFAULT NULL COMMENT '是否前进执行',
  `SPS_IS_RETREAT_EXECUTE` int(5) NULL DEFAULT NULL COMMENT '是否退回执行',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SPS_SPD_ID`(`SPD_ID`) USING BTREE,
  INDEX `SPS_PROCESS_STATUS`(`SPS_PROCESS_STATUS`) USING BTREE,
  CONSTRAINT `SPS_SPD_ID` FOREIGN KEY (`SPD_ID`) REFERENCES `sys_process_definition` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_process_step
-- ----------------------------
INSERT INTO `sys_process_step` VALUES ('27650461607657472', '26816452786913280', '4095556896948224', '测试步骤1', 1, 1, 0, 0, '', '', 0, 0, 0, 0);
INSERT INTO `sys_process_step` VALUES ('27652261702270976', '26816452786913280', '27635893028257792', '测试角色2', 2, 1, 1, 0, '', '', 0, 0, 0, 0);
INSERT INTO `sys_process_step` VALUES ('27652330522411008', '26816452786913280', '27635943053721600', '测试步骤3', 3, 1, 2, 1, '', '', 0, 0, 0, 0);
INSERT INTO `sys_process_step` VALUES ('27652553185427456', '26816452786913280', '27635966298554368', '测试步骤4', 4, 1, 3, 0, '', '', 0, 0, 0, 0);
INSERT INTO `sys_process_step` VALUES ('27652648370962432', '26816452786913280', '27635991015587840', '测试步骤5', 5, 1, 4, 0, '', '', 1, 1, 1, 1);
INSERT INTO `sys_process_step` VALUES ('27653508450746368', '26816452786913280', '', '完成', 6, 1, 999, 0, '', '', 0, 0, 0, 0);
INSERT INTO `sys_process_step` VALUES ('50839589836816384', '50838310695731200', '48309528801837056', '启动人员', 1, 1, 50, 0, '', '系部人员', 1, 0, 0, 0);
INSERT INTO `sys_process_step` VALUES ('50839707340242944', '50838310695731200', '48307839919194112', '学生处', 3, 1, 99, 0, '', '学生处', 1, 0, 0, 0);
INSERT INTO `sys_process_step` VALUES ('50840190146576384', '50838310695731200', '', '完成', 4, 1, 999, 0, '', '', 0, 0, 0, 0);
INSERT INTO `sys_process_step` VALUES ('52297782974742528', '52297782794387456', '48309528801837056', '启动人员', 1, 1, 50, 0, '', '系部人员', 1, 0, 0, 0);
INSERT INTO `sys_process_step` VALUES ('52297783364812800', '52297782794387456', '48307839919194112', '学生处', 3, 1, 99, 0, '', '学生处', 1, 0, 0, 0);
INSERT INTO `sys_process_step` VALUES ('52297783385784320', '52297782794387456', '', '完成', 4, 1, 999, 0, '', '', 0, 0, 0, 0);
INSERT INTO `sys_process_step` VALUES ('52506599511556096', '50838310695731200', '48309996873580544', '系部管理员', 2, 1, 51, 0, '', '', 0, 0, 0, 0);
INSERT INTO `sys_process_step` VALUES ('52506737504157696', '52297782794387456', '48309996873580544', '系部管理员', 2, 1, 51, 0, '', '', 0, 0, 0, 0);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SR_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名',
  `SR_CODE` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色编码',
  `SR_EXPLAIN` varchar(400) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色说明',
  `SR_REMARK` varchar(400) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色备注',
  `SR_TYPE` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户类型:1管理员 2部门3系部4学生',
  `IS_STATUS` int(1) NULL DEFAULT NULL COMMENT '状态:0停用1启用',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SR_CODE`(`SR_CODE`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '超级管理员', 'ADMINISTRATOR', '超级管理员', '超级管理员', '1', 1);
INSERT INTO `sys_role` VALUES ('27635893028257792', '测试角色2', 'TEST2', '', '', '1', 1);
INSERT INTO `sys_role` VALUES ('27635943053721600', '测试角色3', 'TEST3', '', '', '1', 1);
INSERT INTO `sys_role` VALUES ('27635966298554368', '测试角色4', 'TEST4', '', '', '1', 1);
INSERT INTO `sys_role` VALUES ('27635991015587840', '测试角色5', 'TEST5', '', '', '1', 1);
INSERT INTO `sys_role` VALUES ('4095556896948224', '测试角色', 'TEST', '测试', '测试', '1', 1);
INSERT INTO `sys_role` VALUES ('48307839919194112', '学生处', 'STUDENT_DIVISION', '', '', '2', 1);
INSERT INTO `sys_role` VALUES ('48309528801837056', '辅导员', 'INSTRUCTOR_DEPARTMENT', '辅导员', '', '3', 1);
INSERT INTO `sys_role` VALUES ('48309996873580544', '系部管理', 'MANAGER_DEPARTMENT', '', '', '3', 1);
INSERT INTO `sys_role` VALUES ('48678292462501888', '教师', 'TEACHER', '基础角色', '', '5', 1);
INSERT INTO `sys_role` VALUES ('48892526509162496', '学生', 'STUDENT', '基础角色', '', '4', 1);
INSERT INTO `sys_role` VALUES ('50858364522987520', '查看学校奖学金', 'ALL_COLLEGE_SCHOLARSHIP', '查看学校奖学金全部数据', '', '2', 1);
INSERT INTO `sys_role` VALUES ('52299464139866112', '查看年度表彰', 'ALL_COMMEND', '查看全部年度表彰数据', '', '2', 1);

-- ----------------------------
-- Table structure for sys_role_button
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_button`;
CREATE TABLE `sys_role_button`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SRM_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色表主键',
  `SB_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按钮表主键',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SRM_ID`(`SRM_ID`) USING BTREE,
  INDEX `SB_ID`(`SB_ID`) USING BTREE,
  CONSTRAINT `KIM_SB_ID` FOREIGN KEY (`SB_ID`) REFERENCES `sys_button` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `SRM_ID` FOREIGN KEY (`SRM_ID`) REFERENCES `sys_role_menu` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_button
-- ----------------------------
INSERT INTO `sys_role_button` VALUES ('1', '5', '1007779779182592');
INSERT INTO `sys_role_button` VALUES ('1388372232765440', '3', '1');
INSERT INTO `sys_role_button` VALUES ('1444749370195968', '1444740876730368', '763206804963328');
INSERT INTO `sys_role_button` VALUES ('1444787366395904', '5', '1');
INSERT INTO `sys_role_button` VALUES ('1444787391561728', '5', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('1444787412533248', '5', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('1444805708087296', '2', '1');
INSERT INTO `sys_role_button` VALUES ('1444805733253120', '2', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('1444805750030336', '2', '794877562454016');
INSERT INTO `sys_role_button` VALUES ('1444805771001856', '2', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('1450641524260864', '1450627603365888', '763206804963328');
INSERT INTO `sys_role_button` VALUES ('1555298946908160', '3', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('1555298967879680', '3', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('1560147998539776', '1560135797309440', '763206804963328');
INSERT INTO `sys_role_button` VALUES ('1560163781705728', '4', '1');
INSERT INTO `sys_role_button` VALUES ('1560163815260160', '4', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('1560163832037376', '4', '795961550962688');
INSERT INTO `sys_role_button` VALUES ('1560163853008896', '4', '795677957292032');
INSERT INTO `sys_role_button` VALUES ('1560163865591808', '4', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('1759752866496512', '1759730993201152', '1');
INSERT INTO `sys_role_button` VALUES ('1759752900050944', '1759730993201152', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('1759752916828160', '1759730993201152', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('1795462185091072', '1759730993201152', '1795360737460224');
INSERT INTO `sys_role_button` VALUES ('1847371637981184', '1847264800669696', '763206804963328');
INSERT INTO `sys_role_button` VALUES ('20698089362817024', '1452479145312256', '2819607190568960');
INSERT INTO `sys_role_button` VALUES ('20704410300579840', '1065899947720704', '20703880723562496');
INSERT INTO `sys_role_button` VALUES ('20704700147957760', '2259110124847104', '20703880723562496');
INSERT INTO `sys_role_button` VALUES ('20767354631749632', '20767326123065344', '1');
INSERT INTO `sys_role_button` VALUES ('20767354690469888', '20767326123065344', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('20767354703052800', '20767326123065344', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('20767354900185088', '20767326123065344', '1795360737460224');
INSERT INTO `sys_role_button` VALUES ('21131559075577856', '21131546849181696', '763206804963328');
INSERT INTO `sys_role_button` VALUES ('21148886718480384', '21131546849181696', '2819607190568960');
INSERT INTO `sys_role_button` VALUES ('2163989190541312', '2163962472824832', '1');
INSERT INTO `sys_role_button` VALUES ('2163989207318528', '2163962472824832', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('2163989219901440', '2163962472824832', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('2163989228290048', '2163962472824832', '1795360737460224');
INSERT INTO `sys_role_button` VALUES ('2163999428837376', '2163962489602048', '763206804963328');
INSERT INTO `sys_role_button` VALUES ('2259135609438208', '1065899947720704', '1');
INSERT INTO `sys_role_button` VALUES ('2259135630409728', '1065899947720704', '2256636777332736');
INSERT INTO `sys_role_button` VALUES ('2259135642992640', '1065899947720704', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('2259135655575552', '1065899947720704', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('2259146627874816', '2259110296813568', '763206804963328');
INSERT INTO `sys_role_button` VALUES ('2259165632266240', '2259110124847104', '1');
INSERT INTO `sys_role_button` VALUES ('2259165653237760', '2259110124847104', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('2259165665820672', '2259110124847104', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('2259165678403584', '2259110124847104', '1795360737460224');
INSERT INTO `sys_role_button` VALUES ('2261127652179968', '1065899947720704', '2261000862564352');
INSERT INTO `sys_role_button` VALUES ('2270584817844224', '2270567050772480', '1');
INSERT INTO `sys_role_button` VALUES ('2270584838815744', '2270567050772480', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('2270584855592960', '2270567050772480', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('2270584868175872', '2270567050772480', '1795360737460224');
INSERT INTO `sys_role_button` VALUES ('26511328319373312', '26511298309128192', '2824289539588096');
INSERT INTO `sys_role_button` VALUES ('26511328365510656', '26511298309128192', '1');
INSERT INTO `sys_role_button` VALUES ('26511328394870784', '26511298309128192', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('26511328428425216', '26511298309128192', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('26511339627216896', '26511298258796544', '763206804963328');
INSERT INTO `sys_role_button` VALUES ('26571675722055680', '26571647033016320', '1');
INSERT INTO `sys_role_button` VALUES ('26571675826913280', '26571647033016320', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('26571675847884800', '26571647033016320', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('26571683259219968', '26571647079153664', '763206804963328');
INSERT INTO `sys_role_button` VALUES ('26716046983430144', '26716002301509632', '1');
INSERT INTO `sys_role_button` VALUES ('26716047012790272', '26716002301509632', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('26716047033761792', '26716002301509632', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('26716058782007296', '26716002242789376', '1');
INSERT INTO `sys_role_button` VALUES ('26716058807173120', '26716002242789376', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('26716058832338944', '26716002242789376', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('26724642311897088', '26716002276343808', '1');
INSERT INTO `sys_role_button` VALUES ('26724642332868608', '26716002276343808', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('26846544095346688', '26846505239314432', '763206804963328');
INSERT INTO `sys_role_button` VALUES ('26847391378309120', '26716002339258368', '1');
INSERT INTO `sys_role_button` VALUES ('26847391403474944', '26716002339258368', '1795360737460224');
INSERT INTO `sys_role_button` VALUES ('28178123719704576', '28022312963932160', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('28178178518286336', '28178169823494144', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('28178245752979456', '28178238232592384', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('28178297598771200', '28178279898808320', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('28178348647645184', '28178339227238400', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('28178391584735232', '28178381895892992', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('28283813649973248', '1383066211713024', '28283426524102656');
INSERT INTO `sys_role_button` VALUES ('2914093807697920', '1452479145312256', '2824289539588096');
INSERT INTO `sys_role_button` VALUES ('2914093849640960', '1452479145312256', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('2914093870612480', '1452479145312256', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('2914828402294784', '2914068713177088', '1');
INSERT INTO `sys_role_button` VALUES ('2914828423266304', '2914068713177088', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('2914828444237824', '2914068713177088', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('2914828465209344', '2914068713177088', '1795360737460224');
INSERT INTO `sys_role_button` VALUES ('2915213791723520', '1452479145312256', '1');
INSERT INTO `sys_role_button` VALUES ('33082001623875584', '33081991280721920', '33081849764904960');
INSERT INTO `sys_role_button` VALUES ('3316636782166016', '3316626669699072', '763206804963328');
INSERT INTO `sys_role_button` VALUES ('3316672232423424', '1383066211713024', '1');
INSERT INTO `sys_role_button` VALUES ('3316672257589248', '1383066211713024', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('3316672291143680', '1383066211713024', '3008659554566144');
INSERT INTO `sys_role_button` VALUES ('3316672316309504', '1383066211713024', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('33328765496983552', '33081991280721920', '33267466964566016');
INSERT INTO `sys_role_button` VALUES ('3375984820617216', '1383066211713024', '3375831514611712');
INSERT INTO `sys_role_button` VALUES ('38165133129678848', '38165103668887552', '1');
INSERT INTO `sys_role_button` VALUES ('38165133230342144', '38165103668887552', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('38165133242925056', '38165103668887552', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('38165145842614272', '38165103681470464', '763206804963328');
INSERT INTO `sys_role_button` VALUES ('4103843658858496', '4103830098673664', '763206804963328');
INSERT INTO `sys_role_button` VALUES ('4113066069327872', '4086505521807360', '1');
INSERT INTO `sys_role_button` VALUES ('4113066144825344', '4086505521807360', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('4113066157408256', '4086505521807360', '1795360737460224');
INSERT INTO `sys_role_button` VALUES ('4113072776019968', '4086505521807360', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('48296442816626688', '48296422964985856', '1');
INSERT INTO `sys_role_button` VALUES ('48296442917289984', '48296422964985856', '48287050272604160');
INSERT INTO `sys_role_button` VALUES ('48296442934067200', '48296422964985856', '3008659554566144');
INSERT INTO `sys_role_button` VALUES ('48296442950844416', '48296422964985856', '28283426524102656');
INSERT INTO `sys_role_button` VALUES ('48296442963427328', '48296422964985856', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('48296442976010240', '48296422964985856', '3375831514611712');
INSERT INTO `sys_role_button` VALUES ('48305067949817856', '48305052271509504', '763206804963328');
INSERT INTO `sys_role_button` VALUES ('48540446141448192', '48540395147100160', '1');
INSERT INTO `sys_role_button` VALUES ('48540446242111488', '48540395147100160', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('48540446254694400', '48540395147100160', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('48540460355944448', '48540395088379904', '763206804963328');
INSERT INTO `sys_role_button` VALUES ('48540475962949632', '48540395159683072', '1');
INSERT INTO `sys_role_button` VALUES ('48540476013281280', '48540395159683072', '48287050272604160');
INSERT INTO `sys_role_button` VALUES ('48540476030058496', '48540395159683072', '3008659554566144');
INSERT INTO `sys_role_button` VALUES ('48540476046835712', '48540395159683072', '28283426524102656');
INSERT INTO `sys_role_button` VALUES ('48540476109750272', '48540395159683072', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('48540476130721792', '48540395159683072', '3375831514611712');
INSERT INTO `sys_role_button` VALUES ('48540484443832320', '48540395134517248', '763206804963328');
INSERT INTO `sys_role_button` VALUES ('48614408695316480', '48614341418680320', '1');
INSERT INTO `sys_role_button` VALUES ('48614408728870912', '48614341418680320', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('48614408745648128', '48614341418680320', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('48614421647327232', '48614341460623360', '763206804963328');
INSERT INTO `sys_role_button` VALUES ('48673952649707520', '48673932168921088', '1');
INSERT INTO `sys_role_button` VALUES ('48673952754565120', '48673932168921088', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('48673952771342336', '48673932168921088', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('48673964695748608', '48673932244418560', '763206804963328');
INSERT INTO `sys_role_button` VALUES ('48679700456800256', '48673932168921088', '48287050272604160');
INSERT INTO `sys_role_button` VALUES ('48679700486160384', '48673932168921088', '3008659554566144');
INSERT INTO `sys_role_button` VALUES ('48679700507131904', '48673932168921088', '28283426524102656');
INSERT INTO `sys_role_button` VALUES ('48679700528103424', '48673932168921088', '3375831514611712');
INSERT INTO `sys_role_button` VALUES ('48892442975404032', '48892402647171072', '1');
INSERT INTO `sys_role_button` VALUES ('48892443008958464', '48892402647171072', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('48892443025735680', '48892402647171072', '48287050272604160');
INSERT INTO `sys_role_button` VALUES ('48892443034124288', '48892402647171072', '3008659554566144');
INSERT INTO `sys_role_button` VALUES ('48892443042512896', '48892402647171072', '28283426524102656');
INSERT INTO `sys_role_button` VALUES ('48892443151564800', '48892402647171072', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('48892443164147712', '48892402647171072', '3375831514611712');
INSERT INTO `sys_role_button` VALUES ('48892453326946304', '48892402613616640', '763206804963328');
INSERT INTO `sys_role_button` VALUES ('48948487978483712', '48892402647171072', '48286237202579456');
INSERT INTO `sys_role_button` VALUES ('49030861126893568', '49030801836212224', '763206804963328');
INSERT INTO `sys_role_button` VALUES ('49030861227556864', '49030801836212224', '2819607190568960');
INSERT INTO `sys_role_button` VALUES ('49030900104560640', '49030801920098304', '1');
INSERT INTO `sys_role_button` VALUES ('49030900142309376', '49030801920098304', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('49030900175863808', '49030801920098304', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('49030906349879296', '49030801911709696', '763206804963328');
INSERT INTO `sys_role_button` VALUES ('49030921294184448', '49030801861378048', '1');
INSERT INTO `sys_role_button` VALUES ('49030921336127488', '49030801861378048', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('49030921361293312', '49030801861378048', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('49030921373876224', '49030801861378048', '49028916572061696');
INSERT INTO `sys_role_button` VALUES ('49030937178013696', '49030801886543872', '763206804963328');
INSERT INTO `sys_role_button` VALUES ('49399672426463232', '49030801920098304', '48286237202579456');
INSERT INTO `sys_role_button` VALUES ('50328404616019968', '50328331224088576', '763206804963328');
INSERT INTO `sys_role_button` VALUES ('50345407288442880', '50345318495027200', '1');
INSERT INTO `sys_role_button` VALUES ('50345407368134656', '50345318495027200', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('50345407397494784', '50345318495027200', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('50345407418466304', '50345318495027200', '48286237202579456');
INSERT INTO `sys_role_button` VALUES ('50345418751475712', '50345318528581632', '763206804963328');
INSERT INTO `sys_role_button` VALUES ('50345418768252928', '50345318528581632', '1795360737460224');
INSERT INTO `sys_role_button` VALUES ('50800790012428288', '2', '50800567487823872');
INSERT INTO `sys_role_button` VALUES ('50800806047252480', '4', '50800567487823872');
INSERT INTO `sys_role_button` VALUES ('50800825278136320', '26716002276343808', '50800567487823872');
INSERT INTO `sys_role_button` VALUES ('50836322620801024', '50836290639233024', '1');
INSERT INTO `sys_role_button` VALUES ('50836322675326976', '50836290639233024', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('50836322713075712', '50836290639233024', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('50836353423769600', '50836290597289984', '763206804963328');
INSERT INTO `sys_role_button` VALUES ('50851824684498944', '50851533859848192', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('51562203458830336', '48540395159683072', '51562014773870592');
INSERT INTO `sys_role_button` VALUES ('52300229713592320', '52300203088150528', '1');
INSERT INTO `sys_role_button` VALUES ('52300229755535360', '52300203088150528', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('52300229768118272', '52300203088150528', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('52300244624343040', '52300203033624576', '763206804963328');
INSERT INTO `sys_role_button` VALUES ('52308942826504192', '48296422964985856', '51562014773870592');
INSERT INTO `sys_role_button` VALUES ('52505080041046016', '52505068032753664', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('52505080145903616', '52505068032753664', '48286237202579456');
INSERT INTO `sys_role_button` VALUES ('52505089658585088', '52505068062113792', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('52505089683750912', '52505068062113792', '48286237202579456');
INSERT INTO `sys_role_button` VALUES ('52511135886213120', '51587857650810880', '48286237202579456');
INSERT INTO `sys_role_button` VALUES ('52511144069300224', '51587857650810880', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('52511149924548608', '51587857650810880', '793562643955712');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SR_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色表主键',
  `SM_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单表主键',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SR_ID`(`SR_ID`) USING BTREE,
  INDEX `SM_ID`(`SM_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES ('1', '1', '1');
INSERT INTO `sys_role_menu` VALUES ('1065899947720704', '1', '7');
INSERT INTO `sys_role_menu` VALUES ('1383066211713024', '1', '13358417838080');
INSERT INTO `sys_role_menu` VALUES ('1444740876730368', '1', '1427690443767808');
INSERT INTO `sys_role_menu` VALUES ('1450627603365888', '1', '1448716162564096');
INSERT INTO `sys_role_menu` VALUES ('1452479145312256', '1', '1451155909509120');
INSERT INTO `sys_role_menu` VALUES ('1560135797309440', '1', '1560059138015232');
INSERT INTO `sys_role_menu` VALUES ('1759730993201152', '1', '1757509987598336');
INSERT INTO `sys_role_menu` VALUES ('1847264800669696', '1', '1846593582006272');
INSERT INTO `sys_role_menu` VALUES ('2', '1', '2');
INSERT INTO `sys_role_menu` VALUES ('20767326123065344', '1', '20766815625936896');
INSERT INTO `sys_role_menu` VALUES ('21131546849181696', '1', '21131205961318400');
INSERT INTO `sys_role_menu` VALUES ('21131546899513344', '1', '21130604443598848');
INSERT INTO `sys_role_menu` VALUES ('2163962472824832', '1', '2163592187084800');
INSERT INTO `sys_role_menu` VALUES ('2163962489602048', '1', '2163861868249088');
INSERT INTO `sys_role_menu` VALUES ('2259110124847104', '1', '2258969972178944');
INSERT INTO `sys_role_menu` VALUES ('2259110296813568', '1', '2258672239509504');
INSERT INTO `sys_role_menu` VALUES ('2270567050772480', '1', '2269941063483392');
INSERT INTO `sys_role_menu` VALUES ('23657988535353344', '1', '23657888534757376');
INSERT INTO `sys_role_menu` VALUES ('26511298258796544', '1', '26511186237325312');
INSERT INTO `sys_role_menu` VALUES ('26511298309128192', '1', '26476504758091776');
INSERT INTO `sys_role_menu` VALUES ('26571647033016320', '1', '26571410583322624');
INSERT INTO `sys_role_menu` VALUES ('26571647079153664', '1', '26571551922978816');
INSERT INTO `sys_role_menu` VALUES ('26716002242789376', '1', '26715728707059712');
INSERT INTO `sys_role_menu` VALUES ('26716002276343808', '1', '26577844645658624');
INSERT INTO `sys_role_menu` VALUES ('26716002301509632', '1', '26714856669315072');
INSERT INTO `sys_role_menu` VALUES ('26716002318286848', '1', '26577007949119488');
INSERT INTO `sys_role_menu` VALUES ('26716002339258368', '1', '26579469829406720');
INSERT INTO `sys_role_menu` VALUES ('26846505239314432', '1', '26845813934129152');
INSERT INTO `sys_role_menu` VALUES ('28022312963932160', '1', '28019952082485248');
INSERT INTO `sys_role_menu` VALUES ('28178169823494144', '4095556896948224', '28019952082485248');
INSERT INTO `sys_role_menu` VALUES ('28178169873825792', '4095556896948224', '21130604443598848');
INSERT INTO `sys_role_menu` VALUES ('28178238199037952', '27635893028257792', '1');
INSERT INTO `sys_role_menu` VALUES ('28178238232592384', '27635893028257792', '28019952082485248');
INSERT INTO `sys_role_menu` VALUES ('28178238257758208', '27635893028257792', '21130604443598848');
INSERT INTO `sys_role_menu` VALUES ('28178279873642496', '27635943053721600', '1');
INSERT INTO `sys_role_menu` VALUES ('28178279898808320', '27635943053721600', '28019952082485248');
INSERT INTO `sys_role_menu` VALUES ('28178279928168448', '27635943053721600', '21130604443598848');
INSERT INTO `sys_role_menu` VALUES ('28178339197878272', '27635966298554368', '1');
INSERT INTO `sys_role_menu` VALUES ('28178339227238400', '27635966298554368', '28019952082485248');
INSERT INTO `sys_role_menu` VALUES ('28178339269181440', '27635966298554368', '21130604443598848');
INSERT INTO `sys_role_menu` VALUES ('28178381870727168', '27635991015587840', '1');
INSERT INTO `sys_role_menu` VALUES ('28178381895892992', '27635991015587840', '28019952082485248');
INSERT INTO `sys_role_menu` VALUES ('28178381921058816', '27635991015587840', '21130604443598848');
INSERT INTO `sys_role_menu` VALUES ('2914068713177088', '1', '2910350022279168');
INSERT INTO `sys_role_menu` VALUES ('3', '1', '3');
INSERT INTO `sys_role_menu` VALUES ('33081991280721920', '1', '33081241360138240');
INSERT INTO `sys_role_menu` VALUES ('3316626669699072', '1', '3316536806735872');
INSERT INTO `sys_role_menu` VALUES ('38165103622750208', '1', '38116041032728576');
INSERT INTO `sys_role_menu` VALUES ('38165103668887552', '1', '38161659570683904');
INSERT INTO `sys_role_menu` VALUES ('38165103681470464', '1', '38162771866550272');
INSERT INTO `sys_role_menu` VALUES ('4', '1', '8');
INSERT INTO `sys_role_menu` VALUES ('4086505521807360', '1', '3547951557246976');
INSERT INTO `sys_role_menu` VALUES ('4103830098673664', '1', '4103758959083520');
INSERT INTO `sys_role_menu` VALUES ('4104615775698944', '4095556896948224', '1');
INSERT INTO `sys_role_menu` VALUES ('4104615863779328', '4095556896948224', '2');
INSERT INTO `sys_role_menu` VALUES ('4104615880556544', '4095556896948224', '3');
INSERT INTO `sys_role_menu` VALUES ('48296422964985856', '1', '48295058385928192');
INSERT INTO `sys_role_menu` VALUES ('48305052271509504', '1', '48304916703215616');
INSERT INTO `sys_role_menu` VALUES ('48529129443688448', '48307839919194112', '38161659570683904');
INSERT INTO `sys_role_menu` VALUES ('48529129477242880', '48307839919194112', '48295058385928192');
INSERT INTO `sys_role_menu` VALUES ('48529129489825792', '48307839919194112', '38116041032728576');
INSERT INTO `sys_role_menu` VALUES ('48540395088379904', '1', '38162771866550273');
INSERT INTO `sys_role_menu` VALUES ('48540395134517248', '1', '48304916703215617');
INSERT INTO `sys_role_menu` VALUES ('48540395147100160', '1', '38161659570683905');
INSERT INTO `sys_role_menu` VALUES ('48540395159683072', '1', '48295058385928193');
INSERT INTO `sys_role_menu` VALUES ('48614341418680320', '1', '48614104260149248');
INSERT INTO `sys_role_menu` VALUES ('48614341460623360', '1', '48614229862776832');
INSERT INTO `sys_role_menu` VALUES ('48673932168921088', '1', '48667624430632960');
INSERT INTO `sys_role_menu` VALUES ('48673932244418560', '1', '48673777285857280');
INSERT INTO `sys_role_menu` VALUES ('48892402613616640', '1', '48892279221387264');
INSERT INTO `sys_role_menu` VALUES ('48892402647171072', '1', '48892124845834240');
INSERT INTO `sys_role_menu` VALUES ('49027348581842944', '1', '49027088874733568');
INSERT INTO `sys_role_menu` VALUES ('49030801836212224', '1', '49030149684854784');
INSERT INTO `sys_role_menu` VALUES ('49030801861378048', '1', '49028146267160576');
INSERT INTO `sys_role_menu` VALUES ('49030801886543872', '1', '49029256612675584');
INSERT INTO `sys_role_menu` VALUES ('49030801911709696', '1', '49029176400805888');
INSERT INTO `sys_role_menu` VALUES ('49030801920098304', '1', '49027774555357184');
INSERT INTO `sys_role_menu` VALUES ('5', '1', '9');
INSERT INTO `sys_role_menu` VALUES ('50328331224088576', '1', '50328019348226048');
INSERT INTO `sys_role_menu` VALUES ('50345318495027200', '1', '50338340347576320');
INSERT INTO `sys_role_menu` VALUES ('50345318528581632', '1', '50341592241799168');
INSERT INTO `sys_role_menu` VALUES ('50836290467266560', '1', '50751117243449344');
INSERT INTO `sys_role_menu` VALUES ('50836290597289984', '1', '50827078936821760');
INSERT INTO `sys_role_menu` VALUES ('50836290639233024', '1', '50827078076989440');
INSERT INTO `sys_role_menu` VALUES ('50851533859848192', '48307839919194112', '50827078076989440');
INSERT INTO `sys_role_menu` VALUES ('50851533943734272', '48307839919194112', '50751117243449344');
INSERT INTO `sys_role_menu` VALUES ('50851970746941440', '48307839919194112', '50827078936821760');
INSERT INTO `sys_role_menu` VALUES ('50856034041856000', '48892526509162496', '50827078076989440');
INSERT INTO `sys_role_menu` VALUES ('50856034071216128', '48892526509162496', '50751117243449344');
INSERT INTO `sys_role_menu` VALUES ('50858444051185664', '50858364522987520', '50827078076989440');
INSERT INTO `sys_role_menu` VALUES ('50858444076351488', '50858364522987520', '50751117243449344');
INSERT INTO `sys_role_menu` VALUES ('51587857650810880', '48309528801837056', '50338340347576320');
INSERT INTO `sys_role_menu` VALUES ('51587857713725440', '48309528801837056', '48892124845834240');
INSERT INTO `sys_role_menu` VALUES ('51587857730502656', '48309528801837056', '49028146267160576');
INSERT INTO `sys_role_menu` VALUES ('51587857743085568', '48309528801837056', '49027774555357184');
INSERT INTO `sys_role_menu` VALUES ('51587857751474176', '48309528801837056', '49027088874733568');
INSERT INTO `sys_role_menu` VALUES ('52230343104659456', '1', '52184511034687488');
INSERT INTO `sys_role_menu` VALUES ('52230343138213888', '1', '52184510715920384');
INSERT INTO `sys_role_menu` VALUES ('52236350467866624', '1', '52235902763663360');
INSERT INTO `sys_role_menu` VALUES ('52236350488838144', '1', '52235853056966656');
INSERT INTO `sys_role_menu` VALUES ('52259311908290560', '1', '52259024812376064');
INSERT INTO `sys_role_menu` VALUES ('52299612349792256', '52299464139866112', '52294280579907584');
INSERT INTO `sys_role_menu` VALUES ('52299612395929600', '52299464139866112', '50751117243449344');
INSERT INTO `sys_role_menu` VALUES ('52300203033624576', '1', '52294280949006336');
INSERT INTO `sys_role_menu` VALUES ('52300203088150528', '1', '52294280579907584');
INSERT INTO `sys_role_menu` VALUES ('52310611442270208', '48892526509162496', '52294280579907584');
INSERT INTO `sys_role_menu` VALUES ('52504276026523648', '48309996873580544', '50827078076989440');
INSERT INTO `sys_role_menu` VALUES ('52504276089438208', '48309996873580544', '52294280579907584');
INSERT INTO `sys_role_menu` VALUES ('52504276110409728', '48309996873580544', '50751117243449344');
INSERT INTO `sys_role_menu` VALUES ('52505068032753664', '48309528801837056', '50827078076989440');
INSERT INTO `sys_role_menu` VALUES ('52505068062113792', '48309528801837056', '52294280579907584');
INSERT INTO `sys_role_menu` VALUES ('52505068074696704', '48309528801837056', '50751117243449344');
INSERT INTO `sys_role_menu` VALUES ('52511274000449536', '48309528801837056', '50341592241799168');

-- ----------------------------
-- Table structure for sys_validate
-- ----------------------------
DROP TABLE IF EXISTS `sys_validate`;
CREATE TABLE `sys_validate`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SV_TABLE` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表名',
  `IS_STATUS` int(5) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_validate
-- ----------------------------
INSERT INTO `sys_validate` VALUES ('21029210713751552', 'SYS_VALIDATE_GROUP', 1);
INSERT INTO `sys_validate` VALUES ('21138918841778176', 'SYS_ALLOCATION', 1);
INSERT INTO `sys_validate` VALUES ('2261226771972096', 'SYS_BUTTON', 1);
INSERT INTO `sys_validate` VALUES ('2508859939749888', 'SYS_MENU', 1);
INSERT INTO `sys_validate` VALUES ('2521910793469952', 'SYS_VALIDATE', 1);
INSERT INTO `sys_validate` VALUES ('2522562756083712', 'SYS_VALIDATE_FIELD', 1);
INSERT INTO `sys_validate` VALUES ('2526946793619456', 'SYS_VALIDATE_REGEX', 1);
INSERT INTO `sys_validate` VALUES ('2528928849723392', 'SYS_CONFIGURE', 1);
INSERT INTO `sys_validate` VALUES ('2529924065787904', 'SYS_CONFIGURE_COLUMN', 1);
INSERT INTO `sys_validate` VALUES ('2530699592597504', 'SYS_CONFIGURE_SEARCH', 1);
INSERT INTO `sys_validate` VALUES ('2531451308343296', 'SYS_ROLE', 1);
INSERT INTO `sys_validate` VALUES ('26503820167086080', 'SYS_FORMAT', 1);
INSERT INTO `sys_validate` VALUES ('26566331432173568', 'SYS_FORMAT_DETAIL', 1);
INSERT INTO `sys_validate` VALUES ('27200910899806208', 'SYS_PROCESS_DEFINITION', 1);
INSERT INTO `sys_validate` VALUES ('27201527949033472', 'SYS_PROCESS_STEP', 1);
INSERT INTO `sys_validate` VALUES ('27998590727094272', 'SYS_PROCESS_START', 1);
INSERT INTO `sys_validate` VALUES ('28616725398290432', 'SYS_PROCESS_LOG', 1);
INSERT INTO `sys_validate` VALUES ('28747238427590656', 'SYS_PROCESS_SCHEDULE', 1);
INSERT INTO `sys_validate` VALUES ('2916133099274240', 'SYS_DICT_TYPE', 1);
INSERT INTO `sys_validate` VALUES ('2916411848523776', 'SYS_DICT_INFO', 1);
INSERT INTO `sys_validate` VALUES ('33085808659398656', 'SYS_PROCESS_SCHEDULE_CANCEL', 1);
INSERT INTO `sys_validate` VALUES ('3318522176339968', 'SYS_OPERATOR_SUB', 1);
INSERT INTO `sys_validate` VALUES ('3318588060467200', 'SYS_ACCOUNT_INFO', 1);
INSERT INTO `sys_validate` VALUES ('38170193364516864', 'BUS_DIVISION', 1);
INSERT INTO `sys_validate` VALUES ('48291267339091968', 'BUS_DIVISION_PERSONNEL', 1);
INSERT INTO `sys_validate` VALUES ('48648875514265600', 'BUS_DEPARTMENT', 1);
INSERT INTO `sys_validate` VALUES ('48649104007364608', 'BUS_DEPARTMENT_PERSONNEL', 1);
INSERT INTO `sys_validate` VALUES ('48649234076925952', 'BUS_CLASS', 1);
INSERT INTO `sys_validate` VALUES ('48666240763297792', 'BUS_TEACHER', 1);
INSERT INTO `sys_validate` VALUES ('48886453991636992', 'BUS_STUDENT', 1);
INSERT INTO `sys_validate` VALUES ('49382295680843776', 'BUS_STUDENT_ATTENDANCE', 1);
INSERT INTO `sys_validate` VALUES ('50335819809947648', 'BUS_STUDENT_COMPREHENSIVE', 1);
INSERT INTO `sys_validate` VALUES ('50842353690214400', 'BUS_AID_FINANCIALLY', 1);

-- ----------------------------
-- Table structure for sys_validate_field
-- ----------------------------
DROP TABLE IF EXISTS `sys_validate_field`;
CREATE TABLE `sys_validate_field`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SV_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `SVF_NAME` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段名称',
  `SVF_FIELD` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '查询字段',
  `SVF_IS_REQUIRED` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否必填',
  `SVF_MIN_LENGTH` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最小字数',
  `SVF_MAX_LENGTH` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最大字数',
  `SVR_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '正则表ID',
  `IS_STATUS` int(5) NULL DEFAULT NULL COMMENT '是否启用',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SV_ID`(`SV_ID`) USING BTREE,
  CONSTRAINT `SV_ID` FOREIGN KEY (`SV_ID`) REFERENCES `sys_validate` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_validate_field
-- ----------------------------
INSERT INTO `sys_validate_field` VALUES ('21029354062479360', '21029210713751552', 'SVG_GROUP', 'SVG_GROUP', '1', '', '200', '', 1);
INSERT INTO `sys_validate_field` VALUES ('21029498875019264', '21029210713751552', 'SVF_IDS', 'SVF_IDS', '1', '', '', '', 1);
INSERT INTO `sys_validate_field` VALUES ('21139099456897024', '21138918841778176', '邮箱登录名', 'EMAIL_USER', '1', '', '50', '', 1);
INSERT INTO `sys_validate_field` VALUES ('21139191005970432', '21138918841778176', '授权码', 'EMAIL_PASSWORD', '1', '', '100', '', 1);
INSERT INTO `sys_validate_field` VALUES ('21139245104103424', '21138918841778176', '服务器地址', 'EMAIL_HOST', '1', '', '200', '', 1);
INSERT INTO `sys_validate_field` VALUES ('21384212485505024', '21138918841778176', '是否启用', 'EMAIL_STATUS', '1', '', '5', '', 1);
INSERT INTO `sys_validate_field` VALUES ('21386284383600640', '21138918841778176', '端口', 'EMAIL_PORT', '1', '', '5', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('21388026127056896', '21138918841778176', '是否需要是否验证', 'EMAIL_AUTH', '1', '', '5', '', 1);
INSERT INTO `sys_validate_field` VALUES ('21391241312731136', '21138918841778176', '邮件协议', 'EMAIL_PROTOCOL', '1', '', '10', '', 1);
INSERT INTO `sys_validate_field` VALUES ('21392401062952960', '21138918841778176', '是否开启SSL加密', 'EMAIL_SSL_ENABLE', '1', '', '', '', 1);
INSERT INTO `sys_validate_field` VALUES ('2275338709106688', '2261226771972096', '名称', 'SB_NAME', '1', '0', '50', NULL, 1);
INSERT INTO `sys_validate_field` VALUES ('2283799782096896', '2261226771972096', '类型', 'SB_TYPE', '1', '', '', NULL, 1);
INSERT INTO `sys_validate_field` VALUES ('2284187168014336', '2261226771972096', '按钮编码', 'SB_CODE', '1', '0', '50', NULL, 1);
INSERT INTO `sys_validate_field` VALUES ('2284278842916864', '2261226771972096', '排序', 'SB_ORDER', '1', '0', '5', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('2509555162415104', '2508859939749888', '名称', 'SM_NAME', '1', '0', '50', NULL, 1);
INSERT INTO `sys_validate_field` VALUES ('2509836394692608', '2508859939749888', '是否叶节点', 'SM_IS_LEAF', '1', '', '', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('2509917319593984', '2508859939749888', '排序', 'SM_ORDER', '1', '0', '3', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('2522152708341760', '2521910793469952', '表名', 'SV_TABLE', '1', '0', '100', '', 1);
INSERT INTO `sys_validate_field` VALUES ('2522646830907392', '2522562756083712', '名称', 'SVF_NAME', '1', '0', '50', '', 1);
INSERT INTO `sys_validate_field` VALUES ('2523512166154240', '2522562756083712', '字段', 'SVF_FIELD', '1', '0', '50', '', 1);
INSERT INTO `sys_validate_field` VALUES ('2523605007073280', '2522562756083712', '是否必填', 'SVF_IS_REQUIRED', '1', '', '', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('2526757806669824', '2522562756083712', '最小字数', 'SVF_MIN_LENGTH', '0', '', '5', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('2526823703379968', '2522562756083712', '最大字数', 'SVF_MAX_LENGTH', '0', '', '5', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('2527028670627840', '2526946793619456', '名称', 'SVR_NAME', '1', '', '50', '', 1);
INSERT INTO `sys_validate_field` VALUES ('2527090947653632', '2526946793619456', '正则', 'SVR_REGEX', '1', '', '200', '', 1);
INSERT INTO `sys_validate_field` VALUES ('2527138645278720', '2526946793619456', '错误消息', 'SVR_REGEX_MESSAGE', '1', '', '200', '', 1);
INSERT INTO `sys_validate_field` VALUES ('2529121548632064', '2528928849723392', '配置列表名称', 'SC_NAME', '1', '', '50', '', 1);
INSERT INTO `sys_validate_field` VALUES ('2529161222553600', '2528928849723392', '数据库视图', 'SC_VIEW', '1', '', '100', '', 1);
INSERT INTO `sys_validate_field` VALUES ('2529220509040640', '2528928849723392', '是否开启选择', 'SC_IS_SELECT', '0', '', '5', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('2529305837961216', '2528928849723392', '是否单选', 'SC_IS_SINGLE', '0', '', '5', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('2529387081629696', '2528928849723392', '是否分页', 'SC_IS_PAGING', '1', '', '5', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('2529446250676224', '2528928849723392', 'SQL排序语句', 'SC_ORDER_BY', '0', '', '100', '', 1);
INSERT INTO `sys_validate_field` VALUES ('2529506808037376', '2528928849723392', 'JSP地址', 'SC_JSP', '1', '', '200', '', 1);
INSERT INTO `sys_validate_field` VALUES ('2530084942512128', '2529924065787904', '配置列表ID', 'SC_ID', '1', '', '', '', 1);
INSERT INTO `sys_validate_field` VALUES ('2530165498314752', '2529924065787904', '列名称', 'SCC_NAME', '1', '', '50', '', 1);
INSERT INTO `sys_validate_field` VALUES ('2530226936479744', '2529924065787904', '查询字段', 'SCC_FIELD', '0', '', '50', '', 1);
INSERT INTO `sys_validate_field` VALUES ('2530327943708672', '2529924065787904', '对齐方式', 'SCC_ALIGN', '1', '', '20', '2522924040847360', 1);
INSERT INTO `sys_validate_field` VALUES ('2530484034732032', '2529924065787904', '是否是操作列', 'SCC_IS_OPERATION', '1', '', '5', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('2530534089555968', '2529924065787904', '是否是状态列', 'SCC_IS_STATUS', '1', '', '5', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('2530574363262976', '2529924065787904', '是否显示', 'SCC_IS_VISIBLE', '1', '', '5', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('2530632055914496', '2529924065787904', '排序', 'SCC_ORDER', '1', '', '5', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('2530737945313280', '2530699592597504', 'SC_ID', 'SC_ID', '1', '', '', '', 1);
INSERT INTO `sys_validate_field` VALUES ('2530839686545408', '2530699592597504', '搜索名称', 'SCS_NAME', '1', '', '8', '', 1);
INSERT INTO `sys_validate_field` VALUES ('2530922150756352', '2530699592597504', '查询字段', 'SCS_FIELD', '1', '', '50', '', 1);
INSERT INTO `sys_validate_field` VALUES ('2530985086287872', '2530699592597504', '类型', 'SCS_TYPE', '1', '', '5', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('2531053218562048', '2530699592597504', '查询条件', 'SCS_METHOD_TYPE', '1', '', '10', '', 1);
INSERT INTO `sys_validate_field` VALUES ('2531114551869440', '2530699592597504', '是否显示', 'SCC_IS_VISIBLE', '1', '', '5', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('2531171363717120', '2530699592597504', '排序', 'SCS_ORDER', '1', '', '5', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('2531530102538240', '2531451308343296', '角色名称', 'SR_NAME', '1', '', '50', '', 1);
INSERT INTO `sys_validate_field` VALUES ('2531589791678464', '2531451308343296', '角色编码', 'SR_CODE', '1', '', '50', '', 1);
INSERT INTO `sys_validate_field` VALUES ('2531699913129984', '2531451308343296', '类型', 'SR_TYPE', '1', '', '5', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('26472994477965312', '2508859939749888', 'URL参数', 'SM_URL_PARAMS', '0', '', '500', '', 1);
INSERT INTO `sys_validate_field` VALUES ('26473054355849216', '2508859939749888', 'URL', 'SM_URL', '0', '', '400', '', 1);
INSERT INTO `sys_validate_field` VALUES ('26504332669091840', '26503820167086080', '格式名称', 'SF_NAME', '1', '', '200', '', 1);
INSERT INTO `sys_validate_field` VALUES ('26504411106770944', '26503820167086080', '格式唯一标识', 'SF_CODE', '1', '', '100', '', 1);
INSERT INTO `sys_validate_field` VALUES ('26505027984031744', '26503820167086080', '格式配置年份', 'SF_YEAR', '1', '', '', '26504926733533184', 1);
INSERT INTO `sys_validate_field` VALUES ('26566384259432448', '26566331432173568', 'SF_ID', 'SF_ID', '1', '', '', '', 1);
INSERT INTO `sys_validate_field` VALUES ('26566459090010112', '26566331432173568', '格式详细名称', 'SFD_NAME', '1', '', '200', '', 1);
INSERT INTO `sys_validate_field` VALUES ('26566500777197568', '26566331432173568', '排序', 'SFD_ORDER', '1', '', '5', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('27200992088948736', '27200910899806208', '流程名称', 'SPD_NAME', '1', '', '200', '', 1);
INSERT INTO `sys_validate_field` VALUES ('27201053149626368', '27200910899806208', '流程版本', 'SPD_VERSION', '0', '', '100', '', 1);
INSERT INTO `sys_validate_field` VALUES ('27201123957866496', '27200910899806208', '流程更新表名', 'SPD_UPDATE_TABLE', '1', '', '200', '', 1);
INSERT INTO `sys_validate_field` VALUES ('27201243331952640', '27200910899806208', '流程更新表名称字段', 'SPD_UPDATE_NAME', '1', '', '200', '', 1);
INSERT INTO `sys_validate_field` VALUES ('27201479626457088', '27200910899806208', '流程描述', 'SPD_DESCRIBE', '0', '', '1000', '', 1);
INSERT INTO `sys_validate_field` VALUES ('27201590989422592', '27201527949033472', 'SPD_ID', 'SPD_ID', '1', '', '', '', 1);
INSERT INTO `sys_validate_field` VALUES ('27201667204120576', '27201527949033472', '办理角色', 'SR_ID', '0', '', '', '', 1);
INSERT INTO `sys_validate_field` VALUES ('27201721864290304', '27201527949033472', '步骤名称', 'SPS_NAME', '1', '', '200', '', 1);
INSERT INTO `sys_validate_field` VALUES ('27201770279141376', '27201527949033472', '步骤顺序', 'SPS_ORDER', '1', '', '5', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('27201841963991040', '27201527949033472', '办理类型', 'SPS_STEP_TYPE', '1', '', '5', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('27201911572660224', '27201527949033472', '步骤流程状态', 'SPS_PROCESS_STATUS', '1', '', '5', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('27201968753606656', '27201527949033472', '是否验证超时', 'SPS_IS_OVER_TIME', '1', '', '5', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('27202034717425664', '27201527949033472', '超时时间(分)', 'SPS_OVER_TIME', '0', '', '10', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('27202084369596416', '27201527949033472', '步骤标记', 'SPS_TAB', '0', '', '200', '', 1);
INSERT INTO `sys_validate_field` VALUES ('27202130062344192', '27201527949033472', '是否前进校验', 'SPS_IS_ADVANCE_CHECK', '1', '', '5', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('27202181903941632', '27201527949033472', '是否退回校验', 'SPS_IS_RETREAT_CHECK', '1', '', '5', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('27202572817268736', '27201527949033472', '是否前进执行', 'SPS_IS_ADVANCE_EXECUTE', '1', '', '5', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('27202624684032000', '27201527949033472', '是否退回执行', 'SPS_IS_RETREAT_EXECUTE', '1', '', '5', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('27998641947934720', '27998590727094272', 'SPD_ID', 'SPD_ID', '1', '', '', '', 1);
INSERT INTO `sys_validate_field` VALUES ('27998700735299584', '27998590727094272', 'SR_ID', 'SR_ID', '1', '', '', '', 1);
INSERT INTO `sys_validate_field` VALUES ('28616835968532480', '28616725398290432', '办理意见', 'SPL_OPINION', '1', '', '500', '', 1);
INSERT INTO `sys_validate_field` VALUES ('28617469597843456', '28616725398290432', '流程办理表主键', 'SPS_TABLE_ID', '1', '', '', '', 1);
INSERT INTO `sys_validate_field` VALUES ('28617524367065088', '28616725398290432', '流程主键', 'SPD_ID', '1', '', '', '', 1);
INSERT INTO `sys_validate_field` VALUES ('28747316554891264', '28747238427590656', '下一步办理人', 'SPS_STEP_TRANSACTOR', '1', '', '', '', 1);
INSERT INTO `sys_validate_field` VALUES ('28747488475217920', '28747238427590656', '办理类型', 'PROCESS_TYPE', '1', '', '', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('2916293984387072', '2916133099274240', '字典名称', 'SDT_NAME', '1', '', '50', '', 1);
INSERT INTO `sys_validate_field` VALUES ('2916339882655744', '2916133099274240', '字典编码', 'SDT_CODE', '1', '', '100', '', 1);
INSERT INTO `sys_validate_field` VALUES ('2916502218997760', '2916411848523776', 'SDT_ID', 'SDT_ID', '1', '', '', '', 1);
INSERT INTO `sys_validate_field` VALUES ('2916564244365312', '2916411848523776', '名称', 'SDI_NAME', '1', '', '50', '', 1);
INSERT INTO `sys_validate_field` VALUES ('2916608112590848', '2916411848523776', '编码', 'SDI_CODE', '0', '', '50', '', 1);
INSERT INTO `sys_validate_field` VALUES ('2916655382396928', '2916411848523776', '连接编码', 'SDI_INNERCODE', '1', '', '100', '', 1);
INSERT INTO `sys_validate_field` VALUES ('2916793802817536', '2916411848523776', '排序', 'SDI_ORDER', '1', '', '5', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('29363176130740224', '27200910899806208', '是否多级退回', 'IS_MULTISTAGE_BACK', '1', '', '5', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('3002802230001664', '2508859939749888', '是否开启搜索', 'SC_IS_SEARCH', '1', '', '5', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('33085871934668800', '33085808659398656', '作废原因', 'SPSC_REASON', '1', '', '1500', '', 1);
INSERT INTO `sys_validate_field` VALUES ('3318806332047360', '3318522176339968', '登录账号', 'SOS_USERNAME', '1', '2', '18', '2523171857104896', 1);
INSERT INTO `sys_validate_field` VALUES ('3318901077180416', '3318522176339968', '用户类型', 'SOS_USERTYPE', '1', '', '1', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('3319050180493312', '3318588060467200', '姓名', 'SAI_NAME', '1', '', '50', '2523171857104896', 1);
INSERT INTO `sys_validate_field` VALUES ('3319111320862720', '3318588060467200', '手机', 'SAI_PHONE', '0', '', '', '2511317080473600', 1);
INSERT INTO `sys_validate_field` VALUES ('3319156837449728', '3318588060467200', '邮箱', 'SAI_EMAIL', '0', '', '', '2511177288515584', 1);
INSERT INTO `sys_validate_field` VALUES ('38170275589652480', '38170193364516864', '部门名称', 'BD_NAME', '1', '', '50', '', 1);
INSERT INTO `sys_validate_field` VALUES ('38170315582341120', '38170193364516864', '联系人', 'BD_CONTACTS', '0', '', '25', '', 1);
INSERT INTO `sys_validate_field` VALUES ('38170393927745536', '38170193364516864', '手机', 'BD_PHONE', '0', '', '', '2511317080473600', 1);
INSERT INTO `sys_validate_field` VALUES ('38170437598838784', '38170193364516864', '固定电话', 'BD_FIXED_PHONE', '0', '', '', '2511430095994880', 1);
INSERT INTO `sys_validate_field` VALUES ('38170467474866176', '38170193364516864', '邮箱', 'BD_EMAIL', '0', '', '', '2511177288515584', 1);
INSERT INTO `sys_validate_field` VALUES ('38170504644788224', '38170193364516864', '地址', 'BD_ADDRESS', '0', '', '150', '', 1);
INSERT INTO `sys_validate_field` VALUES ('38170537758818304', '38170193364516864', '描述', 'BD_DESCRIBE', '0', '', '250', '', 1);
INSERT INTO `sys_validate_field` VALUES ('38442666630840320', '38170193364516864', '排序', 'BD_ORDER', '1', '', '5', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('48291553520648192', '48291267339091968', '人员名称', 'BDP_NAME', '1', '', '50', '', 1);
INSERT INTO `sys_validate_field` VALUES ('48291905728937984', '48291267339091968', '所属部门', 'BD_ID', '1', '', '', '', 1);
INSERT INTO `sys_validate_field` VALUES ('48648959358402560', '48648875514265600', '系部名称', 'BDM_NAME', '1', '', '100', '', 1);
INSERT INTO `sys_validate_field` VALUES ('48649001662152704', '48648875514265600', '所属院系', 'BDM_COLLEGE', '1', '', '', '', 1);
INSERT INTO `sys_validate_field` VALUES ('48649059505799168', '48648875514265600', '排序', 'BDM_ORDER', '1', '', '5', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('48649161037316096', '48649104007364608', '人员名称', 'BDMP_NAME', '1', '', '100', '', 1);
INSERT INTO `sys_validate_field` VALUES ('48649207644422144', '48649104007364608', '所属系部', 'BDM_ID', '1', '', '', '', 1);
INSERT INTO `sys_validate_field` VALUES ('48649304281186304', '48649234076925952', '班级名称', 'BC_NAME', '1', '', '100', '', 1);
INSERT INTO `sys_validate_field` VALUES ('48649365794848768', '48649234076925952', '所属系部', 'BDM_ID', '1', '', '', '', 1);
INSERT INTO `sys_validate_field` VALUES ('48649402457260032', '48649234076925952', '专业', 'BC_MAJOR', '1', '', '', '', 1);
INSERT INTO `sys_validate_field` VALUES ('48649475563978752', '48649234076925952', '年段', 'BC_YEAR', '1', '', '', '26504926733533184', 1);
INSERT INTO `sys_validate_field` VALUES ('48666310791397376', '48666240763297792', '教师名称', 'BT_NAME', '1', '', '50', '', 1);
INSERT INTO `sys_validate_field` VALUES ('48666379737366528', '48666240763297792', '系部', 'BDM_ID', '1', '', '', '', 1);
INSERT INTO `sys_validate_field` VALUES ('48666419453231104', '48666240763297792', '工号', 'BT_NUMBER', '1', '', '50', '', 1);
INSERT INTO `sys_validate_field` VALUES ('48886544924147712', '48886453991636992', '系部', 'BDM_ID', '1', '', '', '', 1);
INSERT INTO `sys_validate_field` VALUES ('48886576482091008', '48886453991636992', '班级', 'BC_ID', '1', '', '', '', 1);
INSERT INTO `sys_validate_field` VALUES ('48886613513601024', '48886453991636992', '姓名', 'BS_NAME', '1', '', '50', '', 1);
INSERT INTO `sys_validate_field` VALUES ('48886698154655744', '48886453991636992', '学号', 'BS_NUMBER', '1', '', '30', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('48886822763233280', '48886453991636992', '学制', 'BS_LENGTH', '0', '', '1', '', 1);
INSERT INTO `sys_validate_field` VALUES ('48886877721198592', '48886453991636992', '入学年度', 'BS_ENROLMENT_YEAR', '0', '', '', '26504926733533184', 1);
INSERT INTO `sys_validate_field` VALUES ('48886947506028544', '48886453991636992', '考生号', 'BS_EXAMINEE_NUMBER', '1', '', '30', '', 1);
INSERT INTO `sys_validate_field` VALUES ('48886992146006016', '48886453991636992', '身份证', 'BS_ID_CARD', '0', '', '', '2512257846083584', 1);
INSERT INTO `sys_validate_field` VALUES ('48887041059979264', '48886453991636992', '性别', 'BS_SEX', '0', '', '1', '', 1);
INSERT INTO `sys_validate_field` VALUES ('48887089801986048', '48886453991636992', '民族', 'BS_NATION', '0', '', '5', '', 1);
INSERT INTO `sys_validate_field` VALUES ('48887125612953600', '48886453991636992', '银行', 'BS_BANK', '0', '', '50', '', 1);
INSERT INTO `sys_validate_field` VALUES ('48887437023248384', '48886453991636992', '银行卡号', 'BS_BANK_CARD', '0', '', '20', '', 1);
INSERT INTO `sys_validate_field` VALUES ('48887485937221632', '48886453991636992', '电话号码', 'BS_PHONE', '0', '', '', '2511317080473600', 1);
INSERT INTO `sys_validate_field` VALUES ('48887523618848768', '48886453991636992', '户籍地址', 'BS_PERMANENT_ADDRESS', '0', '', '250', '', 1);
INSERT INTO `sys_validate_field` VALUES ('48887555059351552', '48886453991636992', '家庭地址', 'BS_HOME_ADDRESS', '0', '', '250', '', 1);
INSERT INTO `sys_validate_field` VALUES ('49300118259630080', '27200910899806208', '流程大类', 'BUS_PROCESS', '1', '', '', '', 1);
INSERT INTO `sys_validate_field` VALUES ('49300156033531904', '27200910899806208', '流程小类', 'BUS_PROCESS2', '1', '', '', '', 1);
INSERT INTO `sys_validate_field` VALUES ('49382371346087936', '49382295680843776', '年度', 'BSA_YEAR', '1', '', '', '26504926733533184', 1);
INSERT INTO `sys_validate_field` VALUES ('49382409992404992', '49382295680843776', '学期', 'BSA_SEMESTER', '1', '', '1', '', 1);
INSERT INTO `sys_validate_field` VALUES ('49382467320152064', '49382295680843776', '迟到节数', 'BSA_LATE', '1', '', '3', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('49382552611323904', '49382295680843776', '旷课节数', 'BSA_ABSENTEEISM', '1', '', '3', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('49385467933622272', '49382295680843776', '周', 'BSA_WEEK', '1', '', '2', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('49395918151090176', '49382295680843776', '学生', 'BS_NAME', '1', '', '', '', 1);
INSERT INTO `sys_validate_field` VALUES ('50327099268923392', '21138918841778176', '德育', 'EDUCATION_PROPORTION', '1', '', '2', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('50327147201429504', '21138918841778176', '智育', 'INTELLECTUAL_PROPORTION', '1', '', '2', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('50327192726405120', '21138918841778176', '志愿者', 'VOLUNTEER_PROPORTION', '1', '', '2', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('50329904402661376', '21138918841778176', '迟到几节课算旷课', 'LATE_PROPORTION', '1', '', '2', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('50329946148569088', '21138918841778176', '旷课几节课算处分', 'ABSENTEEISM_PROPORTION', '1', '', '2', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('50335893340291072', '50335819809947648', '学生', 'BS_ID', '1', '', '', '', 1);
INSERT INTO `sys_validate_field` VALUES ('50335942816301056', '50335819809947648', '学年', 'BSC_YEAR', '1', '', '', '26504926733533184', 1);
INSERT INTO `sys_validate_field` VALUES ('50335976446230528', '50335819809947648', '学期', 'BSC_SEMESTER', '1', '', '', '', 1);
INSERT INTO `sys_validate_field` VALUES ('50336135364214784', '50335819809947648', '总分', 'BSC_TOTAL', '0', '', '5', '2511687219412992', 1);
INSERT INTO `sys_validate_field` VALUES ('50336500797145088', '50335819809947648', '政治态度和表现', 'BSC_POLITICAL_ATTITUDE', '1', '', '5', '2510375538917377', 1);
INSERT INTO `sys_validate_field` VALUES ('50336554182246400', '50335819809947648', '劳动态度和表现', 'BSC_LABOR_ATTITUDE', '1', '', '5', '2510375538917377', 1);
INSERT INTO `sys_validate_field` VALUES ('50336604983656448', '50335819809947648', '遵纪守法', 'BSC_COMPLIANCE', '1', '', '5', '2510375538917377', 1);
INSERT INTO `sys_validate_field` VALUES ('50336652224102400', '50335819809947648', '集体观念', 'BSC_COLLECTIVE', '1', '', '5', '2510375538917377', 1);
INSERT INTO `sys_validate_field` VALUES ('50336690681675776', '50335819809947648', '文明礼貌', 'BSC_DECORUM', '1', '', '5', '2510375538917377', 1);
INSERT INTO `sys_validate_field` VALUES ('50336772709679104', '50335819809947648', '爱护公物', 'BSC_CARE', '1', '', '5', '2510375538917377', 1);
INSERT INTO `sys_validate_field` VALUES ('50336823502700544', '50335819809947648', '个人品质', 'BSC_PERSONAL_QUALITY', '1', '', '5', '2510375538917377', 1);
INSERT INTO `sys_validate_field` VALUES ('50336870457933824', '50335819809947648', '服务精神', 'BSC_SERVICE_SPIRIT', '1', '', '5', '2510375538917377', 1);
INSERT INTO `sys_validate_field` VALUES ('50336988305293312', '50335819809947648', '满勤分', 'BSC_FULL_WORK', '1', '', '5', '2510375538917377', 1);
INSERT INTO `sys_validate_field` VALUES ('50337045003894784', '50335819809947648', '奖励分', 'BSC_BONUS_POINTS', '1', '', '5', '2510375538917377', 1);
INSERT INTO `sys_validate_field` VALUES ('50337112662212608', '50335819809947648', '德育扣分', 'BSC_EDUCATION_DEDUCTION', '1', '', '5', '2510375538917377', 1);
INSERT INTO `sys_validate_field` VALUES ('50337186033172480', '50335819809947648', '德育总分', 'BSC_EDUCATION_TOTAL', '0', '', '5', '2510375538917377', 1);
INSERT INTO `sys_validate_field` VALUES ('50337295252848640', '50335819809947648', '德育得分', 'BSC_EDUCATION_SCORE', '0', '', '5', '2511687219412992', 1);
INSERT INTO `sys_validate_field` VALUES ('50337397790998528', '50335819809947648', '学习成绩', 'BSC_ACADEMIC_RECORD', '1', '', '5', '2510375538917377', 1);
INSERT INTO `sys_validate_field` VALUES ('50337479936442368', '50335819809947648', '智育奖励分', 'BSC_INTELLECTUAL_POINTS', '1', '', '5', '2510375538917377', 1);
INSERT INTO `sys_validate_field` VALUES ('50337538673475584', '50335819809947648', '智育得分', 'BSC_INTELLECTUAL_SCORE', '0', '', '5', '2511687219412992', 1);
INSERT INTO `sys_validate_field` VALUES ('50337758119460864', '50335819809947648', '志愿者总分', 'BSC_VOLUNTEER_TOTAL', '1', '', '5', '2510375538917377', 1);
INSERT INTO `sys_validate_field` VALUES ('50337840424288256', '50335819809947648', '志愿者得分', 'BSC_VOLUNTEER_SCORE', '0', '', '5', '2511687219412992', 1);
INSERT INTO `sys_validate_field` VALUES ('50337885945069568', '50335819809947648', '备注', 'BSC_REMARKS', '0', '', '500', '', 1);
INSERT INTO `sys_validate_field` VALUES ('50842413324828672', '50842353690214400', '学生', 'BS_ID', '1', '', '', '', 1);
INSERT INTO `sys_validate_field` VALUES ('50842455565664256', '50842353690214400', '学年', 'BAF_YEAR', '1', '', '', '26504926733533184', 1);
INSERT INTO `sys_validate_field` VALUES ('50842479963930624', '50842353690214400', '学期', 'BAF_SEMESTER', '1', '', '', '', 1);
INSERT INTO `sys_validate_field` VALUES ('50842924153307136', '50842353690214400', '类型', 'BAF_TYPE', '1', '', '', '', 1);
INSERT INTO `sys_validate_field` VALUES ('50842975307038720', '50842353690214400', '奖励类型', 'BAF_AID_TYPE', '1', '', '', '', 1);
INSERT INTO `sys_validate_field` VALUES ('50843025634492416', '50842353690214400', '减免等级', 'BAF_REDUCTION_LEVEL', '1', '', '', '', 1);
INSERT INTO `sys_validate_field` VALUES ('50843059478331392', '50842353690214400', '减免额度', 'BAF_REDUCTION_QUOTA', '1', '', '', '2521757806231552', 1);
INSERT INTO `sys_validate_field` VALUES ('50843107717021696', '50842353690214400', '困难级别', 'BAF_DIFFICULTY_LEVEL', '1', '', '', '', 1);
INSERT INTO `sys_validate_field` VALUES ('50843146975707136', '50842353690214400', '困难类型', 'BAF_DIFFICULTY_TYPE', '1', '', '', '', 1);

-- ----------------------------
-- Table structure for sys_validate_group
-- ----------------------------
DROP TABLE IF EXISTS `sys_validate_group`;
CREATE TABLE `sys_validate_group`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SV_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `SVG_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '组名称',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SV_ID`(`SV_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_validate_group
-- ----------------------------
INSERT INTO `sys_validate_group` VALUES ('21060492420186112', '21029210713751552', 'TEST1');
INSERT INTO `sys_validate_group` VALUES ('21060515270754304', '21029210713751552', 'TEST2');
INSERT INTO `sys_validate_group` VALUES ('21062378720329728', '21029210713751552', 'ALL');

-- ----------------------------
-- Table structure for sys_validate_group_field
-- ----------------------------
DROP TABLE IF EXISTS `sys_validate_group_field`;
CREATE TABLE `sys_validate_group_field`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SVG_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `SVF_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SVG_ID`(`SVG_ID`) USING BTREE,
  INDEX `SVF_ID`(`SVF_ID`) USING BTREE,
  CONSTRAINT `SVF_ID` FOREIGN KEY (`SVF_ID`) REFERENCES `sys_validate_field` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `SVG_ID` FOREIGN KEY (`SVG_ID`) REFERENCES `sys_validate_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_validate_group_field
-- ----------------------------
INSERT INTO `sys_validate_group_field` VALUES ('21060492462129152', '21060492420186112', '21029354062479360');
INSERT INTO `sys_validate_group_field` VALUES ('21060515321085952', '21060515270754304', '21029498875019264');
INSERT INTO `sys_validate_group_field` VALUES ('21065605595529216', '21062378720329728', '21029354062479360');
INSERT INTO `sys_validate_group_field` VALUES ('21065605637472256', '21062378720329728', '21029498875019264');

-- ----------------------------
-- Table structure for sys_validate_regex
-- ----------------------------
DROP TABLE IF EXISTS `sys_validate_regex`;
CREATE TABLE `sys_validate_regex`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SVR_NAME` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `SVR_REGEX` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '正则表达式',
  `SVR_REGEX_MESSAGE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '正则错误提示',
  `IS_STATUS` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_validate_regex
-- ----------------------------
INSERT INTO `sys_validate_regex` VALUES ('2510375538917376', '整数', '^-?\\d+$', '请输入整数!', '1');
INSERT INTO `sys_validate_regex` VALUES ('2510375538917377', '正整数', '^\\d+$', '请输入正整数!', '1');
INSERT INTO `sys_validate_regex` VALUES ('2510890322624512', '中文', '[\\u4e00-\\u9fa5]', '只能输入中文!', '1');
INSERT INTO `sys_validate_regex` VALUES ('2511177288515584', '邮箱', '\\w[-\\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\\.)+[A-Za-z]{2,14}', '请输入正确的邮箱!', '1');
INSERT INTO `sys_validate_regex` VALUES ('2511317080473600', '手机', '0?(13|14|15|17|18)[0-9]{9}', '请输入正确的手机号码!', '1');
INSERT INTO `sys_validate_regex` VALUES ('2511430095994880', '固定电话', '[0-9-()（）]{7,18}', '请输入正确的固定电话!', '1');
INSERT INTO `sys_validate_regex` VALUES ('2511687219412992', '浮点数', '^(-?\\d+)(\\.\\d+)?$', '请输入正确的带小数点的数字!', '1');
INSERT INTO `sys_validate_regex` VALUES ('2511798490103808', 'QQ号', '[1-9]([0-9]{5,11})', '请输入正确的QQ号!', '1');
INSERT INTO `sys_validate_regex` VALUES ('2511926852583424', '邮政编码', '\\d{6}', '请输入正确的邮政编码!', '1');
INSERT INTO `sys_validate_regex` VALUES ('2512132734189568', 'IP', '(25[0-5]|2[0-4]\\d|[0-1]\\d{2}|[1-9]?\\d)\\.(25[0-5]|2[0-4]\\d|[0-1]\\d{2}|[1-9]?\\d)\\.(25[0-5]|2[0-4]\\d|[0-1]\\d{2}|[1-9]?\\d)\\.(25[0-5]|2[0-4]\\d|[0-1]\\d{2}|[1-9]?\\d)', '请输入正确的IP地址!', '1');
INSERT INTO `sys_validate_regex` VALUES ('2512257846083584', '身份证', '^[1-9]\\d{5}(18|19|([23]\\d))\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$', '请输入正确的身份证号码!', '1');
INSERT INTO `sys_validate_regex` VALUES ('2512496095133696', '年月日日期', '\\d{4}(\\-|\\\\/|.)\\d{1,2}\\1\\d{1,2}', '请输入正确的日期(如1970-01-01)!', '1');
INSERT INTO `sys_validate_regex` VALUES ('2512815759818752', '用户名', '[A-Za-z0-9_\\-\\u4e00-\\u9fa5]+', '请输入正确的用户名(支持的标点符号-、_)', '1');
INSERT INTO `sys_validate_regex` VALUES ('2521757806231552', '正浮点数', '^(([0-9]+\\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\\.[0-9]+)|([0-9]*[1-9][0-9]*))$', '请输入正确的带小数点的正数!', '1');
INSERT INTO `sys_validate_regex` VALUES ('2522924040847360', '英文字母', '^[a-zA-Z]+$', '只能输入a-z的英文字母!', '1');
INSERT INTO `sys_validate_regex` VALUES ('2523171857104896', '匹配中文，英文字母和数字及_', '^[\\u4e00-\\u9fa5_a-zA-Z0-9]+$', '只能输入中文、英文字母、数字、_', '1');
INSERT INTO `sys_validate_regex` VALUES ('26504926733533184', '年份', '^(19\\d\\d|20\\d\\d|2100|20\\d\\d-20\\d\\d)$', '请输入正确的年份!', '1');

-- ----------------------------
-- Table structure for sys_value_record
-- ----------------------------
DROP TABLE IF EXISTS `sys_value_record`;
CREATE TABLE `sys_value_record`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SO_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作人ID',
  `SVR_TABLE_NAME` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '记录表名',
  `SVR_TABLE_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '记录表ID',
  `SVR_OLD_VALUE` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '旧值',
  `SVR_NEW_VALUE` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '新值',
  `SVR_ENTRY_TIME` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '录入时间',
  `SVR_TYPE` int(5) NULL DEFAULT NULL COMMENT '类型，1插入2更新3删除',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SVR_TABLE`(`SVR_TABLE_NAME`, `SVR_TABLE_ID`) USING BTREE,
  INDEX `SVR_TYPE`(`SVR_TYPE`) USING BTREE,
  INDEX `SO_ID`(`SO_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_value_record
-- ----------------------------
INSERT INTO `sys_value_record` VALUES ('27102827767660544', NULL, 'SYS_PROCESS_DEFINITION', '26816452786913280', '{\"IS_STATUS\":1,\"SR_ID\":\"1\",\"SPD_UPDATE_TABLE\":\"SYS_PROCESS_DEFINITION\",\"SPD_VERSION\":\"1.0\",\"SO_ID\":\"1\",\"SDP_ENTRY_TIME\":\"2018-06-07 16:12:49\",\"ID\":\"26816452786913280\",\"SPD_UPDATE_NAME\":\"SPD_NAME\",\"SPD_DESCRIBE\":\"测试流程\",\"SPD_NAME\":\"测试流程\"}', '{\"SR_ID\":\"1\",\"SPD_UPDATE_TABLE\":\"SYS_PROCESS_DEFINITION\",\"SPD_VERSION\":\"1.0\",\"ID\":\"26816452786913280\",\"SPD_UPDATE_NAME\":\"SPD_NAME\",\"SPD_DESCRIBE\":\"测试流程\",\"SPD_NAME\":\"测试流程\"}', '2018-06-08 11:10:47', 2);
INSERT INTO `sys_value_record` VALUES ('27103108022665216', NULL, 'SYS_PROCESS_DEFINITION', '26816452786913280', '{\"IS_STATUS\":1,\"ID\":\"26816452786913280\"}', '{\"IS_STATUS\":\"0\",\"ID\":\"26816452786913280\"}', '2018-06-08 11:11:53', 2);
INSERT INTO `sys_value_record` VALUES ('27192499336380416', NULL, 'SYS_PROCESS_DEFINITION', '26816452786913280', '{\"IS_STATUS\":0,\"ID\":\"26816452786913280\"}', '{\"IS_STATUS\":\"1\",\"ID\":\"26816452786913280\"}', '2018-06-08 17:07:06', 2);
INSERT INTO `sys_value_record` VALUES ('27650461708320768', NULL, 'SYS_PROCESS_STEP', '27650461607657472', NULL, NULL, '2018-06-09 23:26:53', 1);
INSERT INTO `sys_value_record` VALUES ('27652261740019712', NULL, 'SYS_PROCESS_STEP', '27652261702270976', NULL, NULL, '2018-06-09 23:34:02', 1);
INSERT INTO `sys_value_record` VALUES ('27652330593714176', NULL, 'SYS_PROCESS_STEP', '27652330522411008', NULL, NULL, '2018-06-09 23:34:18', 1);
INSERT INTO `sys_value_record` VALUES ('27652553202204672', NULL, 'SYS_PROCESS_STEP', '27652553185427456', NULL, NULL, '2018-06-09 23:35:11', 1);
INSERT INTO `sys_value_record` VALUES ('27652648387739648', NULL, 'SYS_PROCESS_STEP', '27652648370962432', NULL, NULL, '2018-06-09 23:35:34', 1);
INSERT INTO `sys_value_record` VALUES ('27653508496883712', NULL, 'SYS_PROCESS_STEP', '27653508450746368', NULL, NULL, '2018-06-09 23:38:59', 1);
INSERT INTO `sys_value_record` VALUES ('27653596623405056', NULL, 'SYS_PROCESS_STEP', '27653596606627840', NULL, NULL, '2018-06-09 23:39:20', 1);
INSERT INTO `sys_value_record` VALUES ('27654135801184256', NULL, 'SYS_PROCESS_STEP', '27652330522411008', '{\"SPS_NAME\":\"测试步骤3\",\"SR_ID\":\"27635943053721600\",\"SPS_STEP_TYPE\":1,\"SPS_OVER_TIME\":\"\",\"SPS_ORDER\":3,\"SPS_TAB\":\"\",\"SPS_PROCESS_STATUS\":3,\"SPS_IS_ADVANCE_CHECK\":0,\"SPS_IS_ADVANCE_EXECUTE\":0,\"SPD_ID\":\"26816452786913280\",\"ID\":\"27652330522411008\",\"SPS_IS_RETREAT_CHECK\":0,\"SPS_IS_RETREAT_EXECUTE\":0,\"SPS_IS_OVER_TIME\":1}', '{\"SPS_NAME\":\"测试步骤3\",\"SR_ID\":\"27635943053721600\",\"SPS_STEP_TYPE\":\"1\",\"SPS_OVER_TIME\":\"\",\"SPS_ORDER\":\"3\",\"SPS_TAB\":\"\",\"SPS_PROCESS_STATUS\":\"3\",\"SPS_IS_ADVANCE_CHECK\":\"0\",\"SPS_IS_ADVANCE_EXECUTE\":\"0\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"27652330522411008\",\"SPS_IS_RETREAT_CHECK\":\"0\",\"SPS_IS_RETREAT_EXECUTE\":\"0\",\"SPS_IS_OVER_TIME\":\"0\"}', '2018-06-09 23:41:29', 2);
INSERT INTO `sys_value_record` VALUES ('27654166658678784', NULL, 'SYS_PROCESS_STEP', '27652330522411008', '{\"SPS_NAME\":\"测试步骤3\",\"SR_ID\":\"27635943053721600\",\"SPS_STEP_TYPE\":1,\"SPS_OVER_TIME\":\"\",\"SPS_ORDER\":3,\"SPS_TAB\":\"\",\"SPS_PROCESS_STATUS\":3,\"SPS_IS_ADVANCE_CHECK\":0,\"SPS_IS_ADVANCE_EXECUTE\":0,\"SPD_ID\":\"26816452786913280\",\"ID\":\"27652330522411008\",\"SPS_IS_RETREAT_CHECK\":0,\"SPS_IS_RETREAT_EXECUTE\":0,\"SPS_IS_OVER_TIME\":0}', '{\"SPS_NAME\":\"测试步骤3\",\"SR_ID\":\"27635943053721600\",\"SPS_STEP_TYPE\":\"1\",\"SPS_OVER_TIME\":\"\",\"SPS_ORDER\":\"3\",\"SPS_TAB\":\"\",\"SPS_PROCESS_STATUS\":\"3\",\"SPS_IS_ADVANCE_CHECK\":\"0\",\"SPS_IS_ADVANCE_EXECUTE\":\"0\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"27652330522411008\",\"SPS_IS_RETREAT_CHECK\":\"0\",\"SPS_IS_RETREAT_EXECUTE\":\"0\",\"SPS_IS_OVER_TIME\":\"1\"}', '2018-06-09 23:41:36', 2);
INSERT INTO `sys_value_record` VALUES ('28000849909252096', NULL, 'SYS_PROCESS_STEP', '27652553185427456', '{\"SPS_NAME\":\"测试步骤4\",\"SR_ID\":\"27635966298554368\",\"SPS_STEP_TYPE\":1,\"SPS_OVER_TIME\":\"\",\"SPS_ORDER\":4,\"SPS_TAB\":\"\",\"SPS_PROCESS_STATUS\":-1,\"SPS_IS_ADVANCE_CHECK\":0,\"SPS_IS_ADVANCE_EXECUTE\":0,\"SPD_ID\":\"26816452786913280\",\"ID\":\"27652553185427456\",\"SPS_IS_RETREAT_CHECK\":0,\"SPS_IS_RETREAT_EXECUTE\":0,\"SPS_IS_OVER_TIME\":0}', '{\"SPS_NAME\":\"测试步骤4\",\"SR_ID\":\"27635966298554368\",\"SPS_STEP_TYPE\":\"1\",\"SPS_OVER_TIME\":\"\",\"SPS_ORDER\":\"4\",\"SPS_TAB\":\"\",\"SPS_PROCESS_STATUS\":\"4\",\"SPS_IS_ADVANCE_CHECK\":\"0\",\"SPS_IS_ADVANCE_EXECUTE\":\"0\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"27652553185427456\",\"SPS_IS_RETREAT_CHECK\":\"0\",\"SPS_IS_RETREAT_EXECUTE\":\"0\",\"SPS_IS_OVER_TIME\":\"0\"}', '2018-06-10 22:39:12', 2);
INSERT INTO `sys_value_record` VALUES ('28000873275719680', NULL, 'SYS_PROCESS_STEP', '27652330522411008', '{\"SPS_NAME\":\"测试步骤3\",\"SR_ID\":\"27635943053721600\",\"SPS_STEP_TYPE\":1,\"SPS_OVER_TIME\":\"\",\"SPS_ORDER\":3,\"SPS_TAB\":\"\",\"SPS_PROCESS_STATUS\":3,\"SPS_IS_ADVANCE_CHECK\":0,\"SPS_IS_ADVANCE_EXECUTE\":0,\"SPD_ID\":\"26816452786913280\",\"ID\":\"27652330522411008\",\"SPS_IS_RETREAT_CHECK\":0,\"SPS_IS_RETREAT_EXECUTE\":0,\"SPS_IS_OVER_TIME\":1}', '{\"SPS_NAME\":\"测试步骤3\",\"SR_ID\":\"27635943053721600\",\"SPS_STEP_TYPE\":\"1\",\"SPS_OVER_TIME\":\"\",\"SPS_ORDER\":\"3\",\"SPS_TAB\":\"\",\"SPS_PROCESS_STATUS\":\"2\",\"SPS_IS_ADVANCE_CHECK\":\"0\",\"SPS_IS_ADVANCE_EXECUTE\":\"0\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"27652330522411008\",\"SPS_IS_RETREAT_CHECK\":\"0\",\"SPS_IS_RETREAT_EXECUTE\":\"0\",\"SPS_IS_OVER_TIME\":\"1\"}', '2018-06-10 22:39:17', 2);
INSERT INTO `sys_value_record` VALUES ('28000891575468032', NULL, 'SYS_PROCESS_STEP', '27652553185427456', '{\"SPS_NAME\":\"测试步骤4\",\"SR_ID\":\"27635966298554368\",\"SPS_STEP_TYPE\":1,\"SPS_OVER_TIME\":\"\",\"SPS_ORDER\":4,\"SPS_TAB\":\"\",\"SPS_PROCESS_STATUS\":4,\"SPS_IS_ADVANCE_CHECK\":0,\"SPS_IS_ADVANCE_EXECUTE\":0,\"SPD_ID\":\"26816452786913280\",\"ID\":\"27652553185427456\",\"SPS_IS_RETREAT_CHECK\":0,\"SPS_IS_RETREAT_EXECUTE\":0,\"SPS_IS_OVER_TIME\":0}', '{\"SPS_NAME\":\"测试步骤4\",\"SR_ID\":\"27635966298554368\",\"SPS_STEP_TYPE\":\"1\",\"SPS_OVER_TIME\":\"\",\"SPS_ORDER\":\"4\",\"SPS_TAB\":\"\",\"SPS_PROCESS_STATUS\":\"3\",\"SPS_IS_ADVANCE_CHECK\":\"0\",\"SPS_IS_ADVANCE_EXECUTE\":\"0\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"27652553185427456\",\"SPS_IS_RETREAT_CHECK\":\"0\",\"SPS_IS_RETREAT_EXECUTE\":\"0\",\"SPS_IS_OVER_TIME\":\"0\"}', '2018-06-10 22:39:22', 2);
INSERT INTO `sys_value_record` VALUES ('28002557116809216', NULL, 'SYS_PROCESS_STEP', '27652648370962432', '{\"SPS_NAME\":\"测试步骤5\",\"SR_ID\":\"27635991015587840\",\"SPS_STEP_TYPE\":1,\"SPS_OVER_TIME\":\"\",\"SPS_ORDER\":5,\"SPS_TAB\":\"\",\"SPS_PROCESS_STATUS\":4,\"SPS_IS_ADVANCE_CHECK\":1,\"SPS_IS_ADVANCE_EXECUTE\":1,\"SPD_ID\":\"26816452786913280\",\"ID\":\"27652648370962432\",\"SPS_IS_RETREAT_CHECK\":1,\"SPS_IS_RETREAT_EXECUTE\":1,\"SPS_IS_OVER_TIME\":0}', '{\"SPS_NAME\":\"测试步骤5\",\"SR_ID\":\"27635991015587840\",\"SPS_STEP_TYPE\":\"1\",\"SPS_OVER_TIME\":\"\",\"SPS_ORDER\":\"5\",\"SPS_TAB\":\"\",\"SPS_PROCESS_STATUS\":\"4\",\"SPS_IS_ADVANCE_CHECK\":\"1\",\"SPS_IS_ADVANCE_EXECUTE\":\"1\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"27652648370962432\",\"SPS_IS_RETREAT_CHECK\":\"1\",\"SPS_IS_RETREAT_EXECUTE\":\"1\",\"SPS_IS_OVER_TIME\":\"0\"}', '2018-06-10 22:45:59', 2);
INSERT INTO `sys_value_record` VALUES ('28014196171997184', NULL, 'SYS_PROCESS_DEFINITION', '26816452786913280', '{\"IS_STATUS\":1,\"SR_ID\":\"1\",\"SPD_UPDATE_TABLE\":\"SYS_PROCESS_DEFINITION\",\"SPD_VERSION\":\"1.0\",\"SO_ID\":\"1\",\"SDP_ENTRY_TIME\":\"2018-06-07 16:12:49\",\"ID\":\"26816452786913280\",\"SPD_UPDATE_NAME\":\"SPD_NAME\",\"SPD_DESCRIBE\":\"测试流程\",\"SPD_NAME\":\"测试流程\"}', '{\"SR_ID\":\"1\",\"SPD_UPDATE_TABLE\":\"SYS_PROCESS_DEFINITION\",\"SPD_VERSION\":\"1.0\",\"ID\":\"26816452786913280\",\"SPD_UPDATE_NAME\":\"SPD_NAME\",\"SPD_DESCRIBE\":\"测试流程\",\"SPD_NAME\":\"测试流程\"}', '2018-06-10 23:32:14', 2);
INSERT INTO `sys_value_record` VALUES ('28014219391664128', NULL, 'SYS_PROCESS_DEFINITION', '26816452786913280', '{\"IS_STATUS\":1,\"SR_ID\":\"1\",\"SPD_UPDATE_TABLE\":\"SYS_PROCESS_DEFINITION\",\"SPD_VERSION\":\"1.0\",\"SO_ID\":\"1\",\"SDP_ENTRY_TIME\":\"2018-06-07 16:12:49\",\"ID\":\"26816452786913280\",\"SPD_UPDATE_NAME\":\"SPD_NAME\",\"SPD_DESCRIBE\":\"测试流程\",\"SPD_NAME\":\"测试流程\"}', '{\"SR_ID\":\"1\",\"SPD_UPDATE_TABLE\":\"SYS_PROCESS_DEFINITION\",\"SPD_VERSION\":\"1.0\",\"ID\":\"26816452786913280\",\"SPD_UPDATE_NAME\":\"SPD_NAME\",\"SPD_DESCRIBE\":\"测试流程\",\"SPD_NAME\":\"测试流程\"}', '2018-06-10 23:32:19', 2);
INSERT INTO `sys_value_record` VALUES ('28020853039955968', NULL, 'SYS_PROCESS_DEFINITION', '26816452786913280', '{\"IS_STATUS\":1,\"SR_ID\":\"1\",\"SPD_UPDATE_TABLE\":\"SYS_PROCESS_DEFINITION\",\"SPD_VERSION\":\"1.0\",\"SO_ID\":\"1\",\"SDP_ENTRY_TIME\":\"2018-06-07 16:12:49\",\"ID\":\"26816452786913280\",\"SPD_UPDATE_NAME\":\"SPD_NAME\",\"SPD_DESCRIBE\":\"测试流程\",\"SPD_NAME\":\"测试流程\"}', '{\"SR_ID\":\"1\",\"SPD_UPDATE_TABLE\":\"TEST_PROCESS\",\"SPD_VERSION\":\"1.0\",\"ID\":\"26816452786913280\",\"SPD_UPDATE_NAME\":\"NAME\",\"SPD_DESCRIBE\":\"测试流程\",\"SPD_NAME\":\"测试流程\"}', '2018-06-10 23:58:41', 2);
INSERT INTO `sys_value_record` VALUES ('29363751601831936', NULL, 'SYS_PROCESS_DEFINITION', '26816452786913280', '{\"IS_STATUS\":1,\"SR_ID\":\"1\",\"SPD_UPDATE_TABLE\":\"TEST_PROCESS\",\"SPD_VERSION\":\"1.0\",\"SO_ID\":\"1\",\"SDP_ENTRY_TIME\":\"2018-06-07 16:12:49\",\"ID\":\"26816452786913280\",\"SPD_UPDATE_NAME\":\"NAME\",\"SPD_DESCRIBE\":\"测试流程\",\"SPD_NAME\":\"测试流程\"}', '{\"SR_ID\":\"1\",\"SPD_UPDATE_TABLE\":\"TEST_PROCESS\",\"IS_MULTISTAGE_BACK\":\"1\",\"SPD_VERSION\":\"1.0\",\"ID\":\"26816452786913280\",\"SPD_UPDATE_NAME\":\"NAME\",\"SPD_DESCRIBE\":\"测试流程\",\"SPD_NAME\":\"测试流程\"}', '2018-06-14 16:54:53', 2);
INSERT INTO `sys_value_record` VALUES ('33336595796983808', NULL, 'SYS_PROCESS_SCHEDULE', '33336595616628736', NULL, NULL, '2018-06-25 16:01:33', 1);
INSERT INTO `sys_value_record` VALUES ('33336616042889216', NULL, 'SYS_PROCESS_SCHEDULE', '33336595616628736', '{\"SPS_STEP_TRANSACTOR\":\"27635893028257792\",\"SPS_BACK_STATUS\":0,\"SO_ID\":\"4112733112893440\",\"SPS_STEP_TYPE\":1,\"SPS_TABLE_NAME\":\"\",\"SPS_BACK_STATUS_TRANSACTOR\":-1,\"SPS_PREV_STEP_TRANSACTOR\":\"4112733112893440\",\"SPS_PREV_STEP_TYPE\":0,\"SPS_AUDIT_STATUS\":1,\"SPS_PREV_AUDIT_STATUS\":0,\"SPS_TABLE_ID\":\"1\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33336595616628736\"}', '{\"SPS_STEP_TRANSACTOR\":\"4112733112893440\",\"SPS_BACK_STATUS\":\"2\",\"SO_ID\":\"4112733112893440\",\"SPS_STEP_TYPE\":2,\"SPS_TABLE_NAME\":\"\",\"SPS_BACK_STATUS_TRANSACTOR\":\"0\",\"SPS_PREV_STEP_TRANSACTOR\":\"4112733112893440\",\"SPS_PREV_STEP_TYPE\":\"2\",\"SPS_AUDIT_STATUS\":-1,\"SPS_PREV_AUDIT_STATUS\":1,\"SPS_TABLE_ID\":\"1\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33336595616628736\"}', '2018-06-25 16:01:38', 2);
INSERT INTO `sys_value_record` VALUES ('33339241387786240', NULL, 'SYS_PROCESS_SCHEDULE', '33336595616628736', '{\"SPS_STEP_TRANSACTOR\":\"4112733112893440\",\"SPS_BACK_STATUS\":2,\"SO_ID\":\"4112733112893440\",\"SPS_STEP_TYPE\":2,\"SPS_TABLE_NAME\":\"\",\"SPS_BACK_STATUS_TRANSACTOR\":0,\"SPS_PREV_STEP_TRANSACTOR\":\"4112733112893440\",\"SPS_PREV_STEP_TYPE\":2,\"SPS_AUDIT_STATUS\":-1,\"SPS_PREV_AUDIT_STATUS\":1,\"SPS_TABLE_ID\":\"1\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33336595616628736\"}', '{\"SPS_STEP_TRANSACTOR\":\"27635893028257792\",\"SPS_BACK_STATUS\":\"0\",\"SO_ID\":\"4112733112893440\",\"SPS_STEP_TYPE\":\"1\",\"SPS_TABLE_NAME\":\"\",\"SPS_BACK_STATUS_TRANSACTOR\":\"-1\",\"SPS_PREV_STEP_TRANSACTOR\":\"4112733112893440\",\"SPS_PREV_STEP_TYPE\":\"0\",\"SPS_AUDIT_STATUS\":\"1\",\"SPS_PREV_AUDIT_STATUS\":-1,\"SPS_TABLE_ID\":\"1\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33336595616628736\"}', '2018-06-25 16:12:03', 2);
INSERT INTO `sys_value_record` VALUES ('33339354956955648', NULL, 'SYS_PROCESS_SCHEDULE', '33336595616628736', '{\"SPS_STEP_TRANSACTOR\":\"27635893028257792\",\"SPS_BACK_STATUS\":0,\"SO_ID\":\"4112733112893440\",\"SPS_STEP_TYPE\":1,\"SPS_TABLE_NAME\":\"\",\"SPS_BACK_STATUS_TRANSACTOR\":-1,\"SPS_PREV_STEP_TRANSACTOR\":\"4112733112893440\",\"SPS_PREV_STEP_TYPE\":0,\"SPS_AUDIT_STATUS\":1,\"SPS_PREV_AUDIT_STATUS\":-1,\"SPS_TABLE_ID\":\"1\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33336595616628736\"}', '{\"SPS_STEP_TRANSACTOR\":\"27635943053721600\",\"SPS_BACK_STATUS\":\"0\",\"SO_ID\":\"4112733112893440\",\"SPS_STEP_TYPE\":\"1\",\"SPS_TABLE_NAME\":\"\",\"SPS_BACK_STATUS_TRANSACTOR\":\"-1\",\"SPS_PREV_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_PREV_STEP_TYPE\":\"0\",\"SPS_AUDIT_STATUS\":\"2\",\"SPS_PREV_AUDIT_STATUS\":1,\"SPS_TABLE_ID\":\"1\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33336595616628736\"}', '2018-06-25 16:12:31', 2);
INSERT INTO `sys_value_record` VALUES ('33339446623469568', NULL, 'SYS_PROCESS_SCHEDULE', '33336595616628736', '{\"SPS_STEP_TRANSACTOR\":\"27635943053721600\",\"SPS_BACK_STATUS\":0,\"SO_ID\":\"4112733112893440\",\"SPS_STEP_TYPE\":1,\"SPS_TABLE_NAME\":\"\",\"SPS_BACK_STATUS_TRANSACTOR\":-1,\"SPS_PREV_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_PREV_STEP_TYPE\":0,\"SPS_AUDIT_STATUS\":2,\"SPS_PREV_AUDIT_STATUS\":1,\"SPS_TABLE_ID\":\"1\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33336595616628736\"}', '{\"SPS_STEP_TRANSACTOR\":\"27635966298554368\",\"SPS_BACK_STATUS\":\"0\",\"SO_ID\":\"4112733112893440\",\"SPS_STEP_TYPE\":\"1\",\"SPS_TABLE_NAME\":\"\",\"SPS_BACK_STATUS_TRANSACTOR\":\"-1\",\"SPS_PREV_STEP_TRANSACTOR\":\"28281967912943616\",\"SPS_PREV_STEP_TYPE\":\"0\",\"SPS_AUDIT_STATUS\":\"3\",\"SPS_PREV_AUDIT_STATUS\":2,\"SPS_TABLE_ID\":\"1\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33336595616628736\"}', '2018-06-25 16:12:52', 2);
INSERT INTO `sys_value_record` VALUES ('33339519981846528', NULL, 'SYS_PROCESS_SCHEDULE', '33336595616628736', '{\"SPS_STEP_TRANSACTOR\":\"27635966298554368\",\"SPS_BACK_STATUS\":0,\"SO_ID\":\"4112733112893440\",\"SPS_STEP_TYPE\":1,\"SPS_TABLE_NAME\":\"\",\"SPS_BACK_STATUS_TRANSACTOR\":-1,\"SPS_PREV_STEP_TRANSACTOR\":\"28281967912943616\",\"SPS_PREV_STEP_TYPE\":0,\"SPS_AUDIT_STATUS\":3,\"SPS_PREV_AUDIT_STATUS\":2,\"SPS_TABLE_ID\":\"1\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33336595616628736\"}', '{\"SPS_STEP_TRANSACTOR\":\"27635991015587840\",\"SPS_BACK_STATUS\":\"0\",\"SO_ID\":\"4112733112893440\",\"SPS_STEP_TYPE\":\"1\",\"SPS_TABLE_NAME\":\"\",\"SPS_BACK_STATUS_TRANSACTOR\":\"-1\",\"SPS_PREV_STEP_TRANSACTOR\":\"28281983868076032\",\"SPS_PREV_STEP_TYPE\":\"0\",\"SPS_AUDIT_STATUS\":\"4\",\"SPS_PREV_AUDIT_STATUS\":3,\"SPS_TABLE_ID\":\"1\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33336595616628736\"}', '2018-06-25 16:13:10', 2);
INSERT INTO `sys_value_record` VALUES ('33339631164456960', NULL, 'SYS_PROCESS_SCHEDULE', '33336595616628736', '{\"SPS_STEP_TRANSACTOR\":\"27635991015587840\",\"SPS_BACK_STATUS\":0,\"SO_ID\":\"4112733112893440\",\"SPS_STEP_TYPE\":1,\"SPS_TABLE_NAME\":\"\",\"SPS_BACK_STATUS_TRANSACTOR\":-1,\"SPS_PREV_STEP_TRANSACTOR\":\"28281983868076032\",\"SPS_PREV_STEP_TYPE\":0,\"SPS_AUDIT_STATUS\":4,\"SPS_PREV_AUDIT_STATUS\":3,\"SPS_TABLE_ID\":\"1\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33336595616628736\"}', '{\"SPS_STEP_TRANSACTOR\":\"0\",\"SPS_BACK_STATUS\":\"0\",\"SO_ID\":\"4112733112893440\",\"SPS_STEP_TYPE\":\"1\",\"SPS_TABLE_NAME\":\"\",\"SPS_BACK_STATUS_TRANSACTOR\":\"-1\",\"SPS_PREV_STEP_TRANSACTOR\":\"28281998451671040\",\"SPS_PREV_STEP_TYPE\":\"0\",\"SPS_AUDIT_STATUS\":\"999\",\"SPS_PREV_AUDIT_STATUS\":4,\"SPS_TABLE_ID\":\"1\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33336595616628736\"}', '2018-06-25 16:13:36', 2);
INSERT INTO `sys_value_record` VALUES ('33341909409726464', NULL, 'SYS_PROCESS_SCHEDULE', '33341909359394816', NULL, NULL, '2018-06-25 16:22:40', 1);
INSERT INTO `sys_value_record` VALUES ('33344268487622656', NULL, 'SYS_PROCESS_SCHEDULE', '33341909359394816', '{\"SPS_STEP_TRANSACTOR\":\"27635943053721600\",\"SPS_BACK_STATUS\":0,\"SO_ID\":\"28281555327647744\",\"SPS_STEP_TYPE\":1,\"SPS_TABLE_NAME\":\"7\",\"SPS_BACK_STATUS_TRANSACTOR\":-1,\"SPS_PREV_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_PREV_STEP_TYPE\":0,\"SPS_AUDIT_STATUS\":2,\"SPS_PREV_AUDIT_STATUS\":0,\"SPS_TABLE_ID\":\"7\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33341909359394816\"}', '{\"SPS_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_BACK_STATUS\":\"2\",\"SO_ID\":\"28281555327647744\",\"SPS_STEP_TYPE\":2,\"SPS_TABLE_NAME\":\"7\",\"SPS_BACK_STATUS_TRANSACTOR\":\"0\",\"SPS_PREV_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_PREV_STEP_TYPE\":\"2\",\"SPS_AUDIT_STATUS\":-1,\"SPS_PREV_AUDIT_STATUS\":2,\"SPS_TABLE_ID\":\"7\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33341909359394816\"}', '2018-06-25 16:32:02', 2);
INSERT INTO `sys_value_record` VALUES ('33344288251183104', NULL, 'SYS_PROCESS_SCHEDULE', '33341909359394816', '{\"SPS_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_BACK_STATUS\":2,\"SO_ID\":\"28281555327647744\",\"SPS_STEP_TYPE\":2,\"SPS_TABLE_NAME\":\"7\",\"SPS_BACK_STATUS_TRANSACTOR\":0,\"SPS_PREV_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_PREV_STEP_TYPE\":2,\"SPS_AUDIT_STATUS\":-1,\"SPS_PREV_AUDIT_STATUS\":2,\"SPS_TABLE_ID\":\"7\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33341909359394816\"}', '{\"SPS_STEP_TRANSACTOR\":\"27635893028257792\",\"SPS_BACK_STATUS\":\"0\",\"SO_ID\":\"28281555327647744\",\"SPS_STEP_TYPE\":\"1\",\"SPS_TABLE_NAME\":\"7\",\"SPS_BACK_STATUS_TRANSACTOR\":\"-1\",\"SPS_PREV_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_PREV_STEP_TYPE\":\"0\",\"SPS_AUDIT_STATUS\":\"1\",\"SPS_PREV_AUDIT_STATUS\":-1,\"SPS_TABLE_ID\":\"7\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33341909359394816\"}', '2018-06-25 16:32:07', 2);
INSERT INTO `sys_value_record` VALUES ('33392428312428544', NULL, 'SYS_PROCESS_SCHEDULE', '33392428211765248', NULL, NULL, '2018-06-25 19:43:24', 1);
INSERT INTO `sys_value_record` VALUES ('33392650061086720', NULL, 'SYS_PROCESS_SCHEDULE', '33392428211765248', '{\"SPS_PREV_STEP_ID\":\"27652261702270976\",\"SPS_STEP_TRANSACTOR\":\"27635943053721600\",\"SPS_BACK_STATUS\":0,\"SO_ID\":\"28281555327647744\",\"SPS_STEP_TYPE\":1,\"SPS_TABLE_NAME\":\"7\",\"SPS_BACK_STATUS_TRANSACTOR\":-1,\"SPS_PREV_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_ID\":\"27652330522411008\",\"SPS_PREV_STEP_TYPE\":0,\"SPS_AUDIT_STATUS\":2,\"SPS_PREV_AUDIT_STATUS\":0,\"SPS_TABLE_ID\":\"7\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33392428211765248\"}', '{\"SPS_PREV_STEP_ID\":\"27652330522411008\",\"SPS_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_BACK_STATUS\":\"2\",\"SO_ID\":\"28281555327647744\",\"SPS_STEP_TYPE\":2,\"SPS_TABLE_NAME\":\"7\",\"SPS_BACK_STATUS_TRANSACTOR\":\"0\",\"SPS_PREV_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_ID\":\"27652261702270976\",\"SPS_PREV_STEP_TYPE\":\"2\",\"SPS_AUDIT_STATUS\":-1,\"SPS_PREV_AUDIT_STATUS\":2,\"SPS_TABLE_ID\":\"7\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33392428211765248\"}', '2018-06-25 19:44:17', 2);
INSERT INTO `sys_value_record` VALUES ('33394905648726016', NULL, 'SYS_PROCESS_SCHEDULE', '33394905602588672', NULL, NULL, '2018-06-25 19:53:15', 1);
INSERT INTO `sys_value_record` VALUES ('33394915429842944', NULL, 'SYS_PROCESS_SCHEDULE', '33394905602588672', '{\"SPS_PREV_STEP_ID\":\"27652261702270976\",\"SPS_STEP_TRANSACTOR\":\"27635943053721600\",\"SPS_BACK_STATUS\":0,\"SO_ID\":\"28281555327647744\",\"SPS_STEP_TYPE\":1,\"SPS_TABLE_NAME\":\"7\",\"SPS_BACK_STATUS_TRANSACTOR\":-1,\"SPS_PREV_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_ID\":\"27652330522411008\",\"SPS_PREV_STEP_TYPE\":0,\"SPS_AUDIT_STATUS\":2,\"SPS_PREV_AUDIT_STATUS\":0,\"SPS_TABLE_ID\":\"7\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33394905602588672\"}', '{\"SPS_PREV_STEP_ID\":\"27652330522411008\",\"SPS_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_BACK_STATUS\":\"2\",\"SO_ID\":\"28281555327647744\",\"SPS_STEP_TYPE\":2,\"SPS_TABLE_NAME\":\"7\",\"SPS_BACK_STATUS_TRANSACTOR\":1,\"SPS_PREV_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_ID\":\"27652261702270976\",\"SPS_PREV_STEP_TYPE\":\"2\",\"SPS_AUDIT_STATUS\":-1,\"SPS_PREV_AUDIT_STATUS\":2,\"SPS_TABLE_ID\":\"7\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33394905602588672\"}', '2018-06-25 19:53:17', 2);
INSERT INTO `sys_value_record` VALUES ('33394956970229760', NULL, 'SYS_PROCESS_SCHEDULE', '33394905602588672', '{\"SPS_PREV_STEP_ID\":\"27652330522411008\",\"SPS_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_BACK_STATUS\":2,\"SO_ID\":\"28281555327647744\",\"SPS_STEP_TYPE\":2,\"SPS_TABLE_NAME\":\"7\",\"SPS_BACK_STATUS_TRANSACTOR\":1,\"SPS_PREV_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_ID\":\"27652261702270976\",\"SPS_PREV_STEP_TYPE\":2,\"SPS_AUDIT_STATUS\":-1,\"SPS_PREV_AUDIT_STATUS\":2,\"SPS_TABLE_ID\":\"7\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33394905602588672\"}', '{\"SPS_PREV_STEP_ID\":\"27652261702270976\",\"SPS_STEP_TRANSACTOR\":\"27635943053721600\",\"SPS_BACK_STATUS\":\"0\",\"SO_ID\":\"28281555327647744\",\"SPS_STEP_TYPE\":\"1\",\"SPS_TABLE_NAME\":\"7\",\"SPS_BACK_STATUS_TRANSACTOR\":\"-1\",\"SPS_PREV_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_ID\":\"27652330522411008\",\"SPS_PREV_STEP_TYPE\":\"0\",\"SPS_AUDIT_STATUS\":\"2\",\"SPS_PREV_AUDIT_STATUS\":-1,\"SPS_TABLE_ID\":\"7\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33394905602588672\"}', '2018-06-25 19:53:27', 2);
INSERT INTO `sys_value_record` VALUES ('33395132036284416', NULL, 'SYS_PROCESS_SCHEDULE', '33394905602588672', '{\"SPS_PREV_STEP_ID\":\"27652261702270976\",\"SPS_STEP_TRANSACTOR\":\"27635943053721600\",\"SPS_BACK_STATUS\":0,\"SO_ID\":\"28281555327647744\",\"SPS_STEP_TYPE\":1,\"SPS_TABLE_NAME\":\"7\",\"SPS_BACK_STATUS_TRANSACTOR\":-1,\"SPS_PREV_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_ID\":\"27652330522411008\",\"SPS_PREV_STEP_TYPE\":0,\"SPS_AUDIT_STATUS\":2,\"SPS_PREV_AUDIT_STATUS\":-1,\"SPS_TABLE_ID\":\"7\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33394905602588672\"}', '{\"SPS_PREV_STEP_ID\":\"27652330522411008\",\"SPS_STEP_TRANSACTOR\":\"27635966298554368\",\"SPS_BACK_STATUS\":\"0\",\"SO_ID\":\"28281555327647744\",\"SPS_STEP_TYPE\":\"1\",\"SPS_TABLE_NAME\":\"7\",\"SPS_BACK_STATUS_TRANSACTOR\":\"-1\",\"SPS_PREV_STEP_TRANSACTOR\":\"28281967912943616\",\"SPS_ID\":\"27652553185427456\",\"SPS_PREV_STEP_TYPE\":\"0\",\"SPS_AUDIT_STATUS\":\"3\",\"SPS_PREV_AUDIT_STATUS\":2,\"SPS_TABLE_ID\":\"7\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33394905602588672\"}', '2018-06-25 19:54:09', 2);
INSERT INTO `sys_value_record` VALUES ('33406850275737600', NULL, 'SYS_PROCESS_SCHEDULE', '33406850229600256', NULL, NULL, '2018-06-25 20:40:43', 1);
INSERT INTO `sys_value_record` VALUES ('33406861763936256', NULL, 'SYS_PROCESS_SCHEDULE', '33406850229600256', '{\"SPS_PREV_STEP_ID\":\"27652261702270976\",\"SPS_STEP_TRANSACTOR\":\"27635943053721600\",\"SPS_BACK_STATUS\":0,\"SO_ID\":\"28281555327647744\",\"SPS_STEP_TYPE\":1,\"SPS_TABLE_NAME\":\"7\",\"SPS_BACK_STATUS_TRANSACTOR\":-1,\"SPS_PREV_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_ID\":\"27652330522411008\",\"SPS_PREV_STEP_TYPE\":0,\"SPS_AUDIT_STATUS\":2,\"SPS_PREV_AUDIT_STATUS\":0,\"SPS_TABLE_ID\":\"7\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33406850229600256\"}', '{\"SPS_PREV_STEP_ID\":\"27652330522411008\",\"SPS_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_BACK_STATUS\":\"2\",\"SO_ID\":\"28281555327647744\",\"SPS_STEP_TYPE\":2,\"SPS_TABLE_NAME\":\"7\",\"SPS_BACK_STATUS_TRANSACTOR\":1,\"SPS_PREV_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_ID\":\"27652261702270976\",\"SPS_PREV_STEP_TYPE\":\"2\",\"SPS_AUDIT_STATUS\":-1,\"SPS_PREV_AUDIT_STATUS\":2,\"SPS_TABLE_ID\":\"7\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33406850229600256\"}', '2018-06-25 20:40:45', 2);
INSERT INTO `sys_value_record` VALUES ('33407394427961344', NULL, 'SYS_PROCESS_SCHEDULE', '33406850229600256', '{\"SPS_PREV_STEP_ID\":\"27652330522411008\",\"SPS_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_BACK_STATUS\":2,\"SO_ID\":\"28281555327647744\",\"SPS_STEP_TYPE\":2,\"SPS_TABLE_NAME\":\"7\",\"SPS_BACK_STATUS_TRANSACTOR\":1,\"SPS_PREV_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_ID\":\"27652261702270976\",\"SPS_PREV_STEP_TYPE\":2,\"SPS_AUDIT_STATUS\":-1,\"SPS_PREV_AUDIT_STATUS\":2,\"SPS_TABLE_ID\":\"7\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33406850229600256\"}', '{\"SPS_PREV_STEP_ID\":\"27652261702270976\",\"SPS_STEP_TRANSACTOR\":\"27635943053721600\",\"SPS_BACK_STATUS\":\"0\",\"SO_ID\":\"28281555327647744\",\"SPS_STEP_TYPE\":\"1\",\"SPS_TABLE_NAME\":\"7\",\"SPS_BACK_STATUS_TRANSACTOR\":\"-1\",\"SPS_PREV_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_ID\":\"27652330522411008\",\"SPS_PREV_STEP_TYPE\":\"0\",\"SPS_AUDIT_STATUS\":\"2\",\"SPS_PREV_AUDIT_STATUS\":-1,\"SPS_TABLE_ID\":\"7\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33406850229600256\"}', '2018-06-25 20:42:52', 2);
INSERT INTO `sys_value_record` VALUES ('33407585142964224', NULL, 'SYS_PROCESS_SCHEDULE', '33406850229600256', '{\"SPS_PREV_STEP_ID\":\"27652261702270976\",\"SPS_STEP_TRANSACTOR\":\"27635943053721600\",\"SPS_BACK_STATUS\":0,\"SO_ID\":\"28281555327647744\",\"SPS_STEP_TYPE\":1,\"SPS_TABLE_NAME\":\"7\",\"SPS_BACK_STATUS_TRANSACTOR\":-1,\"SPS_PREV_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_ID\":\"27652330522411008\",\"SPS_PREV_STEP_TYPE\":0,\"SPS_AUDIT_STATUS\":2,\"SPS_PREV_AUDIT_STATUS\":-1,\"SPS_TABLE_ID\":\"7\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33406850229600256\"}', '{\"SPS_PREV_STEP_ID\":\"27652330522411008\",\"SPS_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_BACK_STATUS\":\"2\",\"SO_ID\":\"28281555327647744\",\"SPS_STEP_TYPE\":2,\"SPS_TABLE_NAME\":\"7\",\"SPS_BACK_STATUS_TRANSACTOR\":1,\"SPS_PREV_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_ID\":\"27652261702270976\",\"SPS_PREV_STEP_TYPE\":\"2\",\"SPS_AUDIT_STATUS\":-1,\"SPS_PREV_AUDIT_STATUS\":2,\"SPS_TABLE_ID\":\"7\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33406850229600256\"}', '2018-06-25 20:43:38', 2);
INSERT INTO `sys_value_record` VALUES ('33407614909939712', NULL, 'SYS_PROCESS_SCHEDULE', '33406850229600256', '{\"SPS_PREV_STEP_ID\":\"27652330522411008\",\"SPS_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_BACK_STATUS\":2,\"SO_ID\":\"28281555327647744\",\"SPS_STEP_TYPE\":2,\"SPS_TABLE_NAME\":\"7\",\"SPS_BACK_STATUS_TRANSACTOR\":1,\"SPS_PREV_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_ID\":\"27652261702270976\",\"SPS_PREV_STEP_TYPE\":2,\"SPS_AUDIT_STATUS\":-1,\"SPS_PREV_AUDIT_STATUS\":2,\"SPS_TABLE_ID\":\"7\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33406850229600256\"}', '{\"SPS_PREV_STEP_ID\":\"27652261702270976\",\"SPS_STEP_TRANSACTOR\":\"27635943053721600\",\"SPS_BACK_STATUS\":\"0\",\"SO_ID\":\"28281555327647744\",\"SPS_STEP_TYPE\":\"1\",\"SPS_TABLE_NAME\":\"7\",\"SPS_BACK_STATUS_TRANSACTOR\":\"-1\",\"SPS_PREV_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_ID\":\"27652330522411008\",\"SPS_PREV_STEP_TYPE\":\"0\",\"SPS_AUDIT_STATUS\":\"2\",\"SPS_PREV_AUDIT_STATUS\":-1,\"SPS_TABLE_ID\":\"7\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33406850229600256\"}', '2018-06-25 20:43:45', 2);
INSERT INTO `sys_value_record` VALUES ('33408270395768832', NULL, 'SYS_PROCESS_SCHEDULE', '33406850229600256', '{\"SPS_PREV_STEP_ID\":\"27652261702270976\",\"SPS_STEP_TRANSACTOR\":\"27635943053721600\",\"SPS_BACK_STATUS\":0,\"SO_ID\":\"28281555327647744\",\"SPS_STEP_TYPE\":1,\"SPS_TABLE_NAME\":\"7\",\"SPS_BACK_STATUS_TRANSACTOR\":-1,\"SPS_PREV_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_ID\":\"27652330522411008\",\"SPS_PREV_STEP_TYPE\":0,\"SPS_AUDIT_STATUS\":2,\"SPS_PREV_AUDIT_STATUS\":-1,\"SPS_TABLE_ID\":\"7\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33406850229600256\"}', '{\"SPS_PREV_STEP_ID\":\"27652330522411008\",\"SPS_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_BACK_STATUS\":\"1\",\"SO_ID\":\"28281555327647744\",\"SPS_STEP_TYPE\":\"2\",\"SPS_TABLE_NAME\":\"7\",\"SPS_BACK_STATUS_TRANSACTOR\":\"1\",\"SPS_PREV_STEP_TRANSACTOR\":\"28281967912943616\",\"SPS_ID\":\"\",\"SPS_PREV_STEP_TYPE\":\"1\",\"SPS_AUDIT_STATUS\":\"-1\",\"SPS_PREV_AUDIT_STATUS\":2,\"SPS_TABLE_ID\":\"7\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33406850229600256\"}', '2018-06-25 20:46:21', 2);
INSERT INTO `sys_value_record` VALUES ('33408399278342144', NULL, 'SYS_PROCESS_SCHEDULE', '33406850229600256', '{\"SPS_PREV_STEP_ID\":\"27652330522411008\",\"SPS_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_BACK_STATUS\":1,\"SO_ID\":\"28281555327647744\",\"SPS_STEP_TYPE\":2,\"SPS_TABLE_NAME\":\"7\",\"SPS_BACK_STATUS_TRANSACTOR\":1,\"SPS_PREV_STEP_TRANSACTOR\":\"28281967912943616\",\"SPS_ID\":\"\",\"SPS_PREV_STEP_TYPE\":1,\"SPS_AUDIT_STATUS\":-1,\"SPS_PREV_AUDIT_STATUS\":2,\"SPS_TABLE_ID\":\"7\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33406850229600256\"}', '{\"SPS_PREV_STEP_ID\":\"27652261702270976\",\"SPS_STEP_TRANSACTOR\":\"27635943053721600\",\"SPS_BACK_STATUS\":\"0\",\"SO_ID\":\"28281555327647744\",\"SPS_STEP_TYPE\":\"1\",\"SPS_TABLE_NAME\":\"7\",\"SPS_BACK_STATUS_TRANSACTOR\":\"-1\",\"SPS_PREV_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_ID\":\"27652330522411008\",\"SPS_PREV_STEP_TYPE\":\"0\",\"SPS_AUDIT_STATUS\":\"2\",\"SPS_PREV_AUDIT_STATUS\":-1,\"SPS_TABLE_ID\":\"7\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33406850229600256\"}', '2018-06-25 20:46:52', 2);
INSERT INTO `sys_value_record` VALUES ('33408410250641408', NULL, 'SYS_PROCESS_SCHEDULE', '33406850229600256', '{\"SPS_PREV_STEP_ID\":\"27652261702270976\",\"SPS_STEP_TRANSACTOR\":\"27635943053721600\",\"SPS_BACK_STATUS\":0,\"SO_ID\":\"28281555327647744\",\"SPS_STEP_TYPE\":1,\"SPS_TABLE_NAME\":\"7\",\"SPS_BACK_STATUS_TRANSACTOR\":-1,\"SPS_PREV_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_ID\":\"27652330522411008\",\"SPS_PREV_STEP_TYPE\":0,\"SPS_AUDIT_STATUS\":2,\"SPS_PREV_AUDIT_STATUS\":-1,\"SPS_TABLE_ID\":\"7\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33406850229600256\"}', '{\"SPS_PREV_STEP_ID\":\"27652330522411008\",\"SPS_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_BACK_STATUS\":\"2\",\"SO_ID\":\"28281555327647744\",\"SPS_STEP_TYPE\":2,\"SPS_TABLE_NAME\":\"7\",\"SPS_BACK_STATUS_TRANSACTOR\":1,\"SPS_PREV_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_ID\":\"27652261702270976\",\"SPS_PREV_STEP_TYPE\":\"2\",\"SPS_AUDIT_STATUS\":-1,\"SPS_PREV_AUDIT_STATUS\":2,\"SPS_TABLE_ID\":\"7\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33406850229600256\"}', '2018-06-25 20:46:55', 2);
INSERT INTO `sys_value_record` VALUES ('33408426914611200', NULL, 'SYS_PROCESS_SCHEDULE', '33406850229600256', '{\"SPS_PREV_STEP_ID\":\"27652330522411008\",\"SPS_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_BACK_STATUS\":2,\"SO_ID\":\"28281555327647744\",\"SPS_STEP_TYPE\":2,\"SPS_TABLE_NAME\":\"7\",\"SPS_BACK_STATUS_TRANSACTOR\":1,\"SPS_PREV_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_ID\":\"27652261702270976\",\"SPS_PREV_STEP_TYPE\":2,\"SPS_AUDIT_STATUS\":-1,\"SPS_PREV_AUDIT_STATUS\":2,\"SPS_TABLE_ID\":\"7\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33406850229600256\"}', '{\"SPS_PREV_STEP_ID\":\"27652261702270976\",\"SPS_STEP_TRANSACTOR\":\"27635943053721600\",\"SPS_BACK_STATUS\":\"0\",\"SO_ID\":\"28281555327647744\",\"SPS_STEP_TYPE\":\"1\",\"SPS_TABLE_NAME\":\"7\",\"SPS_BACK_STATUS_TRANSACTOR\":\"-1\",\"SPS_PREV_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_ID\":\"27652330522411008\",\"SPS_PREV_STEP_TYPE\":\"0\",\"SPS_AUDIT_STATUS\":\"2\",\"SPS_PREV_AUDIT_STATUS\":-1,\"SPS_TABLE_ID\":\"7\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33406850229600256\"}', '2018-06-25 20:46:59', 2);
INSERT INTO `sys_value_record` VALUES ('33408490311516160', NULL, 'SYS_PROCESS_SCHEDULE', '33406850229600256', '{\"SPS_PREV_STEP_ID\":\"27652261702270976\",\"SPS_STEP_TRANSACTOR\":\"27635943053721600\",\"SPS_BACK_STATUS\":0,\"SO_ID\":\"28281555327647744\",\"SPS_STEP_TYPE\":1,\"SPS_TABLE_NAME\":\"7\",\"SPS_BACK_STATUS_TRANSACTOR\":-1,\"SPS_PREV_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_ID\":\"27652330522411008\",\"SPS_PREV_STEP_TYPE\":0,\"SPS_AUDIT_STATUS\":2,\"SPS_PREV_AUDIT_STATUS\":-1,\"SPS_TABLE_ID\":\"7\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33406850229600256\"}', '{\"SPS_PREV_STEP_ID\":\"27652330522411008\",\"SPS_STEP_TRANSACTOR\":\"27635966298554368\",\"SPS_BACK_STATUS\":\"0\",\"SO_ID\":\"28281555327647744\",\"SPS_STEP_TYPE\":\"1\",\"SPS_TABLE_NAME\":\"7\",\"SPS_BACK_STATUS_TRANSACTOR\":\"-1\",\"SPS_PREV_STEP_TRANSACTOR\":\"28281967912943616\",\"SPS_ID\":\"27652553185427456\",\"SPS_PREV_STEP_TYPE\":\"0\",\"SPS_AUDIT_STATUS\":\"3\",\"SPS_PREV_AUDIT_STATUS\":2,\"SPS_TABLE_ID\":\"7\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33406850229600256\"}', '2018-06-25 20:47:14', 2);
INSERT INTO `sys_value_record` VALUES ('33408599933845504', NULL, 'SYS_PROCESS_SCHEDULE', '33406850229600256', '{\"SPS_PREV_STEP_ID\":\"27652330522411008\",\"SPS_STEP_TRANSACTOR\":\"27635966298554368\",\"SPS_BACK_STATUS\":0,\"SO_ID\":\"28281555327647744\",\"SPS_STEP_TYPE\":1,\"SPS_TABLE_NAME\":\"7\",\"SPS_BACK_STATUS_TRANSACTOR\":-1,\"SPS_PREV_STEP_TRANSACTOR\":\"28281967912943616\",\"SPS_ID\":\"27652553185427456\",\"SPS_PREV_STEP_TYPE\":0,\"SPS_AUDIT_STATUS\":3,\"SPS_PREV_AUDIT_STATUS\":2,\"SPS_TABLE_ID\":\"7\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33406850229600256\"}', '{\"SPS_PREV_STEP_ID\":\"27652553185427456\",\"SPS_STEP_TRANSACTOR\":\"27635991015587840\",\"SPS_BACK_STATUS\":\"0\",\"SO_ID\":\"28281555327647744\",\"SPS_STEP_TYPE\":\"1\",\"SPS_TABLE_NAME\":\"7\",\"SPS_BACK_STATUS_TRANSACTOR\":\"-1\",\"SPS_PREV_STEP_TRANSACTOR\":\"28281983868076032\",\"SPS_ID\":\"27652648370962432\",\"SPS_PREV_STEP_TYPE\":\"0\",\"SPS_AUDIT_STATUS\":\"4\",\"SPS_PREV_AUDIT_STATUS\":3,\"SPS_TABLE_ID\":\"7\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33406850229600256\"}', '2018-06-25 20:47:40', 2);
INSERT INTO `sys_value_record` VALUES ('33408707098312704', NULL, 'SYS_PROCESS_SCHEDULE', '33406850229600256', '{\"SPS_PREV_STEP_ID\":\"27652553185427456\",\"SPS_STEP_TRANSACTOR\":\"27635991015587840\",\"SPS_BACK_STATUS\":0,\"SO_ID\":\"28281555327647744\",\"SPS_STEP_TYPE\":1,\"SPS_TABLE_NAME\":\"7\",\"SPS_BACK_STATUS_TRANSACTOR\":-1,\"SPS_PREV_STEP_TRANSACTOR\":\"28281983868076032\",\"SPS_ID\":\"27652648370962432\",\"SPS_PREV_STEP_TYPE\":0,\"SPS_AUDIT_STATUS\":4,\"SPS_PREV_AUDIT_STATUS\":3,\"SPS_TABLE_ID\":\"7\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33406850229600256\"}', '{\"SPS_PREV_STEP_ID\":\"27652648370962432\",\"SPS_STEP_TRANSACTOR\":\"0\",\"SPS_BACK_STATUS\":\"0\",\"SO_ID\":\"28281555327647744\",\"SPS_STEP_TYPE\":\"1\",\"SPS_TABLE_NAME\":\"7\",\"SPS_BACK_STATUS_TRANSACTOR\":\"-1\",\"SPS_PREV_STEP_TRANSACTOR\":\"28281998451671040\",\"SPS_ID\":\"27653508450746368\",\"SPS_PREV_STEP_TYPE\":\"0\",\"SPS_AUDIT_STATUS\":\"999\",\"SPS_PREV_AUDIT_STATUS\":4,\"SPS_TABLE_ID\":\"7\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33406850229600256\"}', '2018-06-25 20:48:05', 2);
INSERT INTO `sys_value_record` VALUES ('33410262820192256', NULL, 'SYS_PROCESS_SCHEDULE', '33410262795026432', NULL, NULL, '2018-06-25 20:54:16', 1);
INSERT INTO `sys_value_record` VALUES ('33410273901543424', NULL, 'SYS_PROCESS_SCHEDULE', '33410262795026432', '{\"SPS_PREV_STEP_ID\":\"27650461607657472\",\"SPS_STEP_TRANSACTOR\":\"27635893028257792\",\"SPS_BACK_STATUS\":0,\"SO_ID\":\"4112733112893440\",\"SPS_STEP_TYPE\":1,\"SPS_TABLE_NAME\":\"测试流程1\",\"SPS_BACK_STATUS_TRANSACTOR\":-1,\"SPS_PREV_STEP_TRANSACTOR\":\"4112733112893440\",\"SPS_ID\":\"27652261702270976\",\"SPS_PREV_STEP_TYPE\":0,\"SPS_AUDIT_STATUS\":1,\"SPS_PREV_AUDIT_STATUS\":0,\"SPS_TABLE_ID\":\"1\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33410262795026432\"}', '{\"SPS_PREV_STEP_ID\":\"27652261702270976\",\"SPS_STEP_TRANSACTOR\":\"4112733112893440\",\"SPS_BACK_STATUS\":\"2\",\"SO_ID\":\"4112733112893440\",\"SPS_STEP_TYPE\":2,\"SPS_TABLE_NAME\":\"测试流程1\",\"SPS_BACK_STATUS_TRANSACTOR\":0,\"SPS_PREV_STEP_TRANSACTOR\":\"4112733112893440\",\"SPS_ID\":\"27650461607657472\",\"SPS_PREV_STEP_TYPE\":\"2\",\"SPS_AUDIT_STATUS\":-1,\"SPS_PREV_AUDIT_STATUS\":1,\"SPS_TABLE_ID\":\"1\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33410262795026432\"}', '2018-06-25 20:54:19', 2);
INSERT INTO `sys_value_record` VALUES ('33410899523928064', NULL, 'SYS_PROCESS_SCHEDULE', '33410262795026432', '{\"SPS_PREV_STEP_ID\":\"27652261702270976\",\"SPS_STEP_TRANSACTOR\":\"4112733112893440\",\"SPS_BACK_STATUS\":2,\"SO_ID\":\"4112733112893440\",\"SPS_STEP_TYPE\":2,\"SPS_TABLE_NAME\":\"测试流程1\",\"SPS_BACK_STATUS_TRANSACTOR\":0,\"SPS_PREV_STEP_TRANSACTOR\":\"4112733112893440\",\"SPS_ID\":\"27650461607657472\",\"SPS_PREV_STEP_TYPE\":2,\"SPS_AUDIT_STATUS\":-1,\"SPS_PREV_AUDIT_STATUS\":1,\"SPS_TABLE_ID\":\"1\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33410262795026432\"}', '{\"SPS_PREV_STEP_ID\":\"27650461607657472\",\"SPS_STEP_TRANSACTOR\":\"27635893028257792\",\"SPS_BACK_STATUS\":\"0\",\"SO_ID\":\"4112733112893440\",\"SPS_STEP_TYPE\":\"1\",\"SPS_TABLE_NAME\":\"测试流程1\",\"SPS_BACK_STATUS_TRANSACTOR\":\"-1\",\"SPS_PREV_STEP_TRANSACTOR\":\"4112733112893440\",\"SPS_ID\":\"27652261702270976\",\"SPS_PREV_STEP_TYPE\":\"0\",\"SPS_AUDIT_STATUS\":\"1\",\"SPS_PREV_AUDIT_STATUS\":-1,\"SPS_TABLE_ID\":\"1\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33410262795026432\"}', '2018-06-25 20:56:48', 2);
INSERT INTO `sys_value_record` VALUES ('38116041091448832', NULL, 'SYS_MENU', '38116041032728576', NULL, '{\"SM_URL\":\"\",\"SVR_TABLE_NAME\":\"SYS_MENU\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":\"20\",\"SM_CODE\":\"INFO\",\"SM_NAME\":\"基础信息管理\",\"SM_PARENTID\":\"\",\"SPD_ID\":\"\",\"ID\":\"38116041032728576\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-information-variant\",\"SM_IS_EXPAND\":\"\"}', '2018-07-08 20:33:21', 1);
INSERT INTO `sys_value_record` VALUES ('38161659700707328', NULL, 'SYS_MENU', '38161659570683904', NULL, '{\"SM_URL\":\"\",\"SVR_TABLE_NAME\":\"SYS_MENU\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":\"1\",\"SM_CODE\":\"INFO:DIVISION\",\"SM_NAME\":\"部门管理\",\"SM_PARENTID\":\"38116041032728576\",\"SPD_ID\":\"\",\"ID\":\"38161659570683904\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-division\",\"SM_IS_EXPAND\":\"\"}', '2018-07-08 23:34:38', 1);
INSERT INTO `sys_value_record` VALUES ('38161931885871104', NULL, 'SYS_MENU', '38161659570683904', '{\"SM_URL\":\"\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_ORDER\":1,\"SM_CODE\":\"INFO:DIVISION\",\"SM_NAME\":\"部门管理\",\"SM_PARENTID\":\"38116041032728576\",\"SPD_ID\":\"\",\"ID\":\"38161659570683904\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-division\",\"SM_IS_EXPAND\":\"\"}', '{\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_ORDER\":\"1\",\"SM_CODE\":\"INFO:DIVISION\",\"SM_NAME\":\"部门管理\",\"SM_PARENTID\":\"38116041032728576\",\"SPD_ID\":\"\",\"ID\":\"38161659570683904\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-division\",\"SM_IS_EXPAND\":\"\"}', '2018-07-08 23:35:42', 2);
INSERT INTO `sys_value_record` VALUES ('38162011271462912', NULL, 'SYS_MENU', '38161659570683904', '{\"IS_STATUS\":1,\"ID\":\"38161659570683904\"}', '{\"IS_STATUS\":\"0\",\"ID\":\"38161659570683904\"}', '2018-07-08 23:36:01', 2);
INSERT INTO `sys_value_record` VALUES ('38162016669532160', NULL, 'SYS_MENU', '38161659570683904', '{\"IS_STATUS\":0,\"ID\":\"38161659570683904\"}', '{\"IS_STATUS\":\"1\",\"ID\":\"38161659570683904\"}', '2018-07-08 23:36:03', 2);
INSERT INTO `sys_value_record` VALUES ('38162771912687616', NULL, 'SYS_MENU', '38162771866550272', NULL, '{\"SM_URL\":\"\",\"SVR_TABLE_NAME\":\"SYS_MENU\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":\"1\",\"SM_CODE\":\"INFO:DIVISION_UPDATE\",\"SM_NAME\":\"编辑\",\"SM_PARENTID\":\"38161659570683904\",\"SPD_ID\":\"\",\"ID\":\"38162771866550272\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '2018-07-08 23:39:03', 1);
INSERT INTO `sys_value_record` VALUES ('38163489579073536', NULL, 'SYS_CONFIGURE', '38163489528741888', NULL, '{\"SC_IS_PAGING\":\"1\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE\",\"SC_NAME\":\"基础信息管理-部门管理\",\"SC_JSP\":\"1\",\"SC_VIEW\":\"v_division\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"38163489528741888\",\"SC_ORDER_BY\":\"\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '2018-07-08 23:41:54', 1);
INSERT INTO `sys_value_record` VALUES ('38163577294553088', NULL, 'SYS_CONFIGURE', '38163489528741888', '{\"SC_IS_PAGING\":\"1\",\"SC_NAME\":\"基础信息管理-部门管理\",\"SC_JSP\":\"1\",\"SC_VIEW\":\"v_division\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"38163489528741888\",\"SC_ORDER_BY\":\"\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '{\"SC_NAME\":\"基础信息管理-部门管理\",\"SC_JSP\":\"admin/info/division/home\",\"SC_VIEW\":\"v_division\",\"SC_ORDER_BY\":\"\",\"SC_IS_PAGING\":\"1\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"38163489528741888\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '2018-07-08 23:42:15', 2);
INSERT INTO `sys_value_record` VALUES ('38164004211785728', NULL, 'SYS_CONFIGURE_COLUMN', '38164004056596480', NULL, '{\"SCC_NAME\":\"部门名称\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"150px\",\"SCC_FIELD\":\"BD_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"38164004056596480\",\"SC_ID\":\"38163489528741888\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"1\"}', '2018-07-08 23:43:57', 1);
INSERT INTO `sys_value_record` VALUES ('38164089733644288', NULL, 'SYS_CONFIGURE_COLUMN', '38164089465208832', NULL, '{\"SCC_NAME\":\"上级部门\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"150px\",\"SCC_FIELD\":\"BD_PARENT_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"38164089465208832\",\"SC_ID\":\"38163489528741888\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"10\"}', '2018-07-08 23:44:17', 1);
INSERT INTO `sys_value_record` VALUES ('38164146692292608', NULL, 'SYS_CONFIGURE_COLUMN', '38164146021203968', NULL, '{\"SCC_NAME\":\"联系人\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"80px\",\"SCC_FIELD\":\"BD_CONTACTS\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"38164146021203968\",\"SC_ID\":\"38163489528741888\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"20\"}', '2018-07-08 23:44:31', 1);
INSERT INTO `sys_value_record` VALUES ('38164215814422528', NULL, 'SYS_CONFIGURE_COLUMN', '38164215797645312', NULL, '{\"SCC_NAME\":\"手机\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"BD_PHONE\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"38164215797645312\",\"SC_ID\":\"38163489528741888\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"30\"}', '2018-07-08 23:44:47', 1);
INSERT INTO `sys_value_record` VALUES ('38164268889145344', NULL, 'SYS_CONFIGURE_COLUMN', '38164268855590912', NULL, '{\"SCC_NAME\":\"固定电话\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"BD_FIXED_PHONE\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"38164268855590912\",\"SC_ID\":\"38163489528741888\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"40\"}', '2018-07-08 23:45:00', 1);
INSERT INTO `sys_value_record` VALUES ('38164315953430528', NULL, 'SYS_CONFIGURE_COLUMN', '38164315928264704', NULL, '{\"SCC_NAME\":\"邮箱\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"BD_EMAIL\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"38164315928264704\",\"SC_ID\":\"38163489528741888\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"50\"}', '2018-07-08 23:45:11', 1);
INSERT INTO `sys_value_record` VALUES ('38164392495284224', NULL, 'SYS_CONFIGURE_COLUMN', '38164315928264704', NULL, NULL, '2018-07-08 23:45:29', 3);
INSERT INTO `sys_value_record` VALUES ('38164400292495360', NULL, 'SYS_CONFIGURE_COLUMN', '38164268855590912', NULL, NULL, '2018-07-08 23:45:31', 3);
INSERT INTO `sys_value_record` VALUES ('38164484363124736', NULL, 'SYS_CONFIGURE_COLUMN', '38164484337958912', NULL, '{\"SCC_NAME\":\"描述\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_ALIGN\":\"left\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"200px\",\"SCC_FIELD\":\"BD_DESCRIBE\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"38164484337958912\",\"SC_ID\":\"38163489528741888\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"40\"}', '2018-07-08 23:45:51', 1);
INSERT INTO `sys_value_record` VALUES ('38164554626105344', NULL, 'SYS_CONFIGURE_COLUMN', '38164554567385088', NULL, '{\"SCC_NAME\":\"操作\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"160px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"38164554567385088\",\"SC_ID\":\"38163489528741888\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"50\"}', '2018-07-08 23:46:08', 1);
INSERT INTO `sys_value_record` VALUES ('38164645676056576', NULL, 'SYS_CONFIGURE_SEARCH', '38164645629919232', NULL, '{\"SCS_METHOD_TYPE\":\"4\",\"SCS_TYPE\":\"1\",\"SCS_FIELD\":\"BD_NAME\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_SEARCH\",\"SCS_NAME\":\"部门名称\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"38164645629919232\",\"SC_ID\":\"38163489528741888\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":\"1\"}', '2018-07-08 23:46:30', 1);
INSERT INTO `sys_value_record` VALUES ('38164690047598592', NULL, 'SYS_CONFIGURE_SEARCH', '38164690009849856', NULL, '{\"SCS_METHOD_TYPE\":\"4\",\"SCS_TYPE\":\"1\",\"SCS_FIELD\":\"BD_CONTACTS\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_SEARCH\",\"SCS_NAME\":\"联系人\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"38164690009849856\",\"SC_ID\":\"38163489528741888\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":\"10\"}', '2018-07-08 23:46:40', 1);
INSERT INTO `sys_value_record` VALUES ('38164832519716864', NULL, 'SYS_MENU', '38161659570683904', '{\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_ORDER\":1,\"SM_CODE\":\"INFO:DIVISION\",\"SM_NAME\":\"部门管理\",\"SM_PARENTID\":\"38116041032728576\",\"SPD_ID\":\"\",\"ID\":\"38161659570683904\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-division\",\"SM_IS_EXPAND\":\"\"}', '{\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_ORDER\":\"1\",\"SM_CODE\":\"INFO:DIVISION\",\"SM_NAME\":\"部门管理\",\"SM_PARENTID\":\"38116041032728576\",\"SPD_ID\":\"\",\"ID\":\"38161659570683904\",\"SC_ID\":\"38163489528741888\",\"SM_CLASSICON\":\"mdi mdi-division\",\"SM_IS_EXPAND\":\"\"}', '2018-07-08 23:47:14', 2);
INSERT INTO `sys_value_record` VALUES ('38167401832906752', NULL, 'SYS_MENU', '38116041032728576', '{\"SM_URL\":\"\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_ORDER\":20,\"SM_CODE\":\"INFO\",\"SM_NAME\":\"基础信息管理\",\"SM_PARENTID\":\"0\",\"SPD_ID\":\"\",\"ID\":\"38116041032728576\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-information-variant\",\"SM_IS_EXPAND\":\"\"}', '{\"SM_URL\":\"\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"1\",\"SM_ORDER\":\"20\",\"SM_CODE\":\"INFO\",\"SM_NAME\":\"基础信息管理\",\"SM_PARENTID\":\"0\",\"SPD_ID\":\"\",\"ID\":\"38116041032728576\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-information-variant\",\"SM_IS_EXPAND\":\"\"}', '2018-07-08 23:57:27', 2);
INSERT INTO `sys_value_record` VALUES ('38167402646601728', NULL, 'SYS_MENU', '38116041032728576', '{\"SM_URL\":\"\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"1\",\"IS_STATUS\":1,\"SM_ORDER\":20,\"SM_CODE\":\"INFO\",\"SM_NAME\":\"基础信息管理\",\"SM_PARENTID\":\"0\",\"SPD_ID\":\"\",\"ID\":\"38116041032728576\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-information-variant\",\"SM_IS_EXPAND\":\"\"}', '{\"SM_URL\":\"\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"1\",\"SM_ORDER\":\"20\",\"SM_CODE\":\"INFO\",\"SM_NAME\":\"基础信息管理\",\"SM_PARENTID\":\"0\",\"SPD_ID\":\"\",\"ID\":\"38116041032728576\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-information-variant\",\"SM_IS_EXPAND\":\"\"}', '2018-07-08 23:57:27', 2);
INSERT INTO `sys_value_record` VALUES ('38170193393876992', NULL, 'SYS_VALIDATE', '38170193364516864', NULL, '{\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"SYS_VALIDATE\",\"ID\":\"38170193364516864\",\"SV_TABLE\":\"BUS_DIVISION\"}', '2018-07-09 00:08:32', 1);
INSERT INTO `sys_value_record` VALUES ('38170275698704384', NULL, 'sys_validate_field', '38170275589652480', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"50\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"38170275589652480\",\"SVF_NAME\":\"部门名称\",\"SVF_FIELD\":\"BD_NAME\",\"SV_ID\":\"38170193364516864\",\"SVR_ID\":\"\"}', '2018-07-09 00:08:52', 1);
INSERT INTO `sys_value_record` VALUES ('38170315611701248', NULL, 'sys_validate_field', '38170315582341120', NULL, '{\"SVF_IS_REQUIRED\":\"0\",\"SVF_MAX_LENGTH\":\"25\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"38170315582341120\",\"SVF_NAME\":\"联系人\",\"SVF_FIELD\":\"BD_CONTACTS\",\"SV_ID\":\"38170193364516864\",\"SVR_ID\":\"\"}', '2018-07-09 00:09:01', 1);
INSERT INTO `sys_value_record` VALUES ('38170393961299968', NULL, 'sys_validate_field', '38170393927745536', NULL, '{\"SVF_IS_REQUIRED\":\"0\",\"SVF_MAX_LENGTH\":\"\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"38170393927745536\",\"SVF_NAME\":\"手机\",\"SVF_FIELD\":\"BD_PHONE\",\"SV_ID\":\"38170193364516864\",\"SVR_ID\":\"2511317080473600\"}', '2018-07-09 00:09:20', 1);
INSERT INTO `sys_value_record` VALUES ('38170437624004608', NULL, 'sys_validate_field', '38170437598838784', NULL, '{\"SVF_IS_REQUIRED\":\"0\",\"SVF_MAX_LENGTH\":\"\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"38170437598838784\",\"SVF_NAME\":\"固定电话\",\"SVF_FIELD\":\"BD_FIXED_PHONE\",\"SV_ID\":\"38170193364516864\",\"SVR_ID\":\"2511430095994880\"}', '2018-07-09 00:09:30', 1);
INSERT INTO `sys_value_record` VALUES ('38170467504226304', NULL, 'sys_validate_field', '38170467474866176', NULL, '{\"SVF_IS_REQUIRED\":\"0\",\"SVF_MAX_LENGTH\":\"\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"38170467474866176\",\"SVF_NAME\":\"邮箱\",\"SVF_FIELD\":\"BD_EMAIL\",\"SV_ID\":\"38170193364516864\",\"SVR_ID\":\"2511177288515584\"}', '2018-07-09 00:09:38', 1);
INSERT INTO `sys_value_record` VALUES ('38170504682536960', NULL, 'sys_validate_field', '38170504644788224', NULL, '{\"SVF_IS_REQUIRED\":\"0\",\"SVF_MAX_LENGTH\":\"150\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"38170504644788224\",\"SVF_NAME\":\"地址\",\"SVF_FIELD\":\"BD_ADDRESS\",\"SV_ID\":\"38170193364516864\",\"SVR_ID\":\"\"}', '2018-07-09 00:09:46', 1);
INSERT INTO `sys_value_record` VALUES ('38170537779789824', NULL, 'sys_validate_field', '38170537758818304', NULL, '{\"SVF_IS_REQUIRED\":\"0\",\"SVF_MAX_LENGTH\":\"250\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"38170537758818304\",\"SVF_NAME\":\"描述\",\"SVF_FIELD\":\"BD_DESCRIBE\",\"SV_ID\":\"38170193364516864\",\"SVR_ID\":\"\"}', '2018-07-09 00:09:54', 1);
INSERT INTO `sys_value_record` VALUES ('38171278464516096', NULL, 'SYS_CONFIGURE_COLUMN', '2266941783801856', '{\"SCC_NAME\":\"名称\",\"SCC_FUNC\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"\",\"SCC_FIELD\":\"SVF_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"2266941783801856\",\"SC_ID\":\"2265709233045504\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":1}', '{\"SCC_NAME\":\"名称\",\"SCC_FUNC\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"130px\",\"SCC_FIELD\":\"SVF_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"2266941783801856\",\"SC_ID\":\"2265709233045504\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"1\"}', '2018-07-09 00:12:51', 2);
INSERT INTO `sys_value_record` VALUES ('38344578222260224', NULL, 'SYS_CONFIGURE', '38163489528741888', '{\"SC_IS_PAGING\":\"1\",\"SC_NAME\":\"基础信息管理-部门管理\",\"SC_JSP\":\"admin/info/division/home\",\"SC_VIEW\":\"v_division\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"38163489528741888\",\"SC_ORDER_BY\":\"\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '{\"SC_NAME\":\"基础信息管理-部门管理\",\"SC_JSP\":\"admin/info/division/home\",\"SC_VIEW\":\"v_division\",\"SC_ORDER_BY\":\"CONVERT(ID,SIGNED) DESC\",\"SC_IS_PAGING\":\"1\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"38163489528741888\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '2018-07-09 11:41:29', 2);
INSERT INTO `sys_value_record` VALUES ('38344744090206208', NULL, 'BUS_DIVISION', '38344744014708736', NULL, '{\"BD_CONTACTS\":\"有意义\",\"BD_FIXED_PHONE\":\"\",\"SVR_TABLE_NAME\":\"BUS_DIVISION\",\"BD_ADDRESS\":\"6楼\",\"BD_ENTER_TIME\":\"2018-07-09 11:42:08\",\"ID\":\"38344744014708736\",\"BD_NAME\":\"院长\",\"BD_PHONE\":\"\",\"BD_DESCRIBE\":\"12321\",\"BD_EMAIL\":\"\",\"BD_PARENT_ID\":\"0\"}', '2018-07-09 11:42:08', 1);
INSERT INTO `sys_value_record` VALUES ('38345402809843712', NULL, 'BUS_DIVISION', '38345402751123456', NULL, '{\"BD_CONTACTS\":\"123\",\"BD_FIXED_PHONE\":\"\",\"SVR_TABLE_NAME\":\"BUS_DIVISION\",\"BD_ADDRESS\":\"12\",\"BD_ENTER_TIME\":\"2018-07-09 11:44:45\",\"ID\":\"38345402751123456\",\"BD_NAME\":\"副院长\",\"BD_PHONE\":\"\",\"BD_DESCRIBE\":\"321312\",\"BD_EMAIL\":\"\",\"BD_PARENT_ID\":\"38344744014708736\"}', '2018-07-09 11:44:45', 1);
INSERT INTO `sys_value_record` VALUES ('38347429602394112', NULL, 'BUS_DIVISION', '38344744014708736', '{\"BD_CONTACTS\":\"有意义\",\"BD_FIXED_PHONE\":\"\",\"BD_ADDRESS\":\"6楼\",\"ID\":\"38344744014708736\",\"BD_NAME\":\"院长\",\"BD_PHONE\":\"\",\"BD_DESCRIBE\":\"12321\",\"BD_EMAIL\":\"\",\"BD_PARENT_ID\":\"0\"}', '{\"BD_CONTACTS\":\"有意义\",\"BD_FIXED_PHONE\":\"0591-12312312\",\"BD_NAME\":\"院长\",\"BD_PHONE\":\"17012342032\",\"BD_ADDRESS\":\"6楼\",\"ID\":\"38344744014708736\",\"BD_DESCRIBE\":\"12321\",\"BD_EMAIL\":\"851758629@qq.com\",\"BD_PARENT_ID\":\"0\"}', '2018-07-09 11:52:49', 2);
INSERT INTO `sys_value_record` VALUES ('38442666714726400', NULL, 'sys_validate_field', '38442666630840320', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"5\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"38442666630840320\",\"SVF_NAME\":\"排序\",\"SVF_FIELD\":\"BD_ORDER\",\"SV_ID\":\"38170193364516864\",\"SVR_ID\":\"2510375538917376\"}', '2018-07-09 18:11:15', 1);
INSERT INTO `sys_value_record` VALUES ('38442701196099584', NULL, 'BUS_DIVISION', '38344744014708736', '{\"BD_CONTACTS\":\"有意义\",\"BD_FIXED_PHONE\":\"0591-12312312\",\"BD_ADDRESS\":\"6楼\",\"ID\":\"38344744014708736\",\"BD_NAME\":\"院长\",\"BD_PHONE\":\"17012342032\",\"BD_DESCRIBE\":\"12321\",\"BD_EMAIL\":\"851758629@qq.com\",\"BD_PARENT_ID\":\"0\"}', '{\"BD_CONTACTS\":\"有意义\",\"BD_FIXED_PHONE\":\"0591-12312312\",\"BD_ORDER\":\"1\",\"BD_NAME\":\"院长\",\"BD_PHONE\":\"17012342032\",\"BD_ADDRESS\":\"6楼\",\"ID\":\"38344744014708736\",\"BD_DESCRIBE\":\"12321\",\"BD_EMAIL\":\"851758629@qq.com\",\"BD_PARENT_ID\":\"0\"}', '2018-07-09 18:11:23', 2);
INSERT INTO `sys_value_record` VALUES ('38442718187225088', NULL, 'BUS_DIVISION', '38345402751123456', '{\"BD_CONTACTS\":\"123\",\"BD_FIXED_PHONE\":\"\",\"BD_ADDRESS\":\"12\",\"ID\":\"38345402751123456\",\"BD_NAME\":\"副院长\",\"BD_PHONE\":\"\",\"BD_DESCRIBE\":\"321312\",\"BD_EMAIL\":\"\",\"BD_PARENT_ID\":\"38344744014708736\"}', '{\"BD_CONTACTS\":\"123\",\"BD_FIXED_PHONE\":\"\",\"BD_ORDER\":\"1\",\"BD_NAME\":\"副院长\",\"BD_PHONE\":\"\",\"BD_ADDRESS\":\"12\",\"ID\":\"38345402751123456\",\"BD_DESCRIBE\":\"321312\",\"BD_EMAIL\":\"\",\"BD_PARENT_ID\":\"38344744014708736\"}', '2018-07-09 18:11:27', 2);
INSERT INTO `sys_value_record` VALUES ('38446985593749504', NULL, 'SYS_CONFIGURE_COLUMN', '38446985522446336', NULL, '{\"SCC_NAME\":\"排序\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"50px\",\"SCC_FIELD\":\"BD_ORDER\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"38446985522446336\",\"SC_ID\":\"38163489528741888\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"45\"}', '2018-07-09 18:28:25', 1);
INSERT INTO `sys_value_record` VALUES ('38533692280274944', NULL, 'SYS_VALIDATE', '38170193364516864', '{\"IS_STATUS\":1,\"ID\":\"38170193364516864\"}', '{\"IS_STATUS\":\"0\",\"ID\":\"38170193364516864\"}', '2018-07-10 00:12:57', 2);
INSERT INTO `sys_value_record` VALUES ('38533828221861888', NULL, 'SYS_VALIDATE', '38170193364516864', '{\"IS_STATUS\":0,\"ID\":\"38170193364516864\"}', '{\"IS_STATUS\":\"1\",\"ID\":\"38170193364516864\"}', '2018-07-10 00:13:29', 2);
INSERT INTO `sys_value_record` VALUES ('38533863168802816', NULL, 'SYS_VALIDATE', '38170193364516864', '{\"IS_STATUS\":1,\"ID\":\"38170193364516864\"}', '{\"IS_STATUS\":\"0\",\"ID\":\"38170193364516864\"}', '2018-07-10 00:13:38', 2);
INSERT INTO `sys_value_record` VALUES ('38533897566289920', NULL, 'SYS_VALIDATE', '38170193364516864', '{\"IS_STATUS\":0,\"ID\":\"38170193364516864\"}', '{\"IS_STATUS\":\"1\",\"ID\":\"38170193364516864\"}', '2018-07-10 00:13:46', 2);
INSERT INTO `sys_value_record` VALUES ('38533914272202752', NULL, 'SYS_VALIDATE', '38170193364516864', '{\"IS_STATUS\":1,\"ID\":\"38170193364516864\"}', '{\"IS_STATUS\":\"0\",\"ID\":\"38170193364516864\"}', '2018-07-10 00:13:50', 2);
INSERT INTO `sys_value_record` VALUES ('38534162986041344', NULL, 'SYS_VALIDATE', '38170193364516864', '{\"IS_STATUS\":0,\"ID\":\"38170193364516864\"}', '{\"IS_STATUS\":\"1\",\"ID\":\"38170193364516864\"}', '2018-07-10 00:14:49', 2);
INSERT INTO `sys_value_record` VALUES ('38535000676630528', NULL, 'SYS_VALIDATE', '38170193364516864', '{\"IS_STATUS\":1,\"ID\":\"38170193364516864\"}', '{\"IS_STATUS\":\"0\",\"ID\":\"38170193364516864\"}', '2018-07-10 00:18:09', 2);
INSERT INTO `sys_value_record` VALUES ('38535036684730368', NULL, 'SYS_VALIDATE', '38170193364516864', '{\"IS_STATUS\":0,\"ID\":\"38170193364516864\"}', '{\"IS_STATUS\":\"1\",\"ID\":\"38170193364516864\"}', '2018-07-10 00:18:18', 2);
INSERT INTO `sys_value_record` VALUES ('38535354571030528', NULL, 'SYS_VALIDATE', '38170193364516864', '{\"IS_STATUS\":1,\"ID\":\"38170193364516864\"}', '{\"IS_STATUS\":\"0\",\"ID\":\"38170193364516864\"}', '2018-07-10 00:19:33', 2);
INSERT INTO `sys_value_record` VALUES ('38535362649260032', NULL, 'SYS_VALIDATE', '38170193364516864', '{\"IS_STATUS\":0,\"ID\":\"38170193364516864\"}', '{\"IS_STATUS\":\"1\",\"ID\":\"38170193364516864\"}', '2018-07-10 00:19:35', 2);
INSERT INTO `sys_value_record` VALUES ('38535385810206720', NULL, 'SYS_MENU', '38116041032728576', '{\"IS_STATUS\":1,\"ID\":\"38116041032728576\"}', '{\"IS_STATUS\":\"0\",\"ID\":\"38116041032728576\"}', '2018-07-10 00:19:41', 2);
INSERT INTO `sys_value_record` VALUES ('38535408602054656', NULL, 'SYS_MENU', '38116041032728576', '{\"IS_STATUS\":0,\"ID\":\"38116041032728576\"}', '{\"IS_STATUS\":\"1\",\"ID\":\"38116041032728576\"}', '2018-07-10 00:19:46', 2);
INSERT INTO `sys_value_record` VALUES ('38900518566756352', NULL, 'SYS_CONFIGURE_COLUMN', '2268850032738304', '{\"SCC_NAME\":\"正则\",\"SCC_FUNC\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"\",\"SCC_FIELD\":\"SVR_REGEX\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"2268850032738304\",\"SC_ID\":\"2268726246244352\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":2}', '{\"SCC_NAME\":\"正则\",\"SCC_FUNC\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"150px\",\"SCC_FIELD\":\"SVR_REGEX\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"2268850032738304\",\"SC_ID\":\"2268726246244352\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"2\"}', '2018-07-11 00:30:35', 2);
INSERT INTO `sys_value_record` VALUES ('38900538414202880', NULL, 'SYS_CONFIGURE_COLUMN', '2510530543616000', '{\"SCC_NAME\":\"错误消息\",\"SCC_FUNC\":\"\",\"SCC_ALIGN\":\"left\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"\",\"SCC_FIELD\":\"SVR_REGEX_MESSAGE\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"2510530543616000\",\"SC_ID\":\"2268726246244352\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":3}', '{\"SCC_NAME\":\"错误消息\",\"SCC_FUNC\":\"\",\"SCC_ALIGN\":\"left\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"150px\",\"SCC_FIELD\":\"SVR_REGEX_MESSAGE\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"2510530543616000\",\"SC_ID\":\"2268726246244352\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"3\"}', '2018-07-11 00:30:40', 2);
INSERT INTO `sys_value_record` VALUES ('38900712800780288', NULL, 'SYS_CONFIGURE_COLUMN', '2268917275820032', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"180px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"2268917275820032\",\"SC_ID\":\"2268726246244352\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":5}', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"160px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"2268917275820032\",\"SC_ID\":\"2268726246244352\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"5\"}', '2018-07-11 00:31:22', 2);
INSERT INTO `sys_value_record` VALUES ('39603098095714304', '1', 'SYS_CONFIGURE_SEARCH', '39603098028605440', NULL, '{\"SCS_METHOD_TYPE\":\"4\",\"SCS_TYPE\":\"1\",\"SCS_FIELD\":\"SM_NAME\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_SEARCH\",\"SCS_NAME\":\"名称\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"39603098028605440\",\"SC_ID\":\"2997414705233920\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":\"1\"}', '2018-07-12 23:02:23', 1);
INSERT INTO `sys_value_record` VALUES ('39606092220596224', '1', 'SYS_PROCESS_DEFINITION', '26816452786913280', '{\"IS_STATUS\":1,\"SR_ID\":\"1\",\"SPD_UPDATE_TABLE\":\"TEST_PROCESS\",\"IS_MULTISTAGE_BACK\":1,\"SPD_VERSION\":\"1.0\",\"SO_ID\":\"1\",\"SDP_ENTRY_TIME\":\"2018-06-07 16:12:49\",\"ID\":\"26816452786913280\",\"SPD_UPDATE_NAME\":\"NAME\",\"SPD_DESCRIBE\":\"测试流程\",\"SPD_NAME\":\"测试流程\"}', '{\"SR_ID\":\"1\",\"SPD_DESCRIBE\":\"测试流程\",\"SPD_UPDATE_TABLE\":\"TEST_PROCESS\",\"IS_MULTISTAGE_BACK\":\"1\",\"SPD_VERSION\":\"1.0\",\"ID\":\"26816452786913280\",\"SPD_UPDATE_NAME\":\"NAME\",\"SPD_NAME\":\"测试流程\"}', '2018-07-12 23:14:17', 2);
INSERT INTO `sys_value_record` VALUES ('48256389927141376', '4112733112893440', 'SYS_PROCESS_SCHEDULE', '48256389629345792', NULL, '{\"SVR_TABLE_NAME\":\"SYS_PROCESS_SCHEDULE\",\"SPS_PREV_STEP_ID\":\"27650461607657472\",\"SPS_STEP_TRANSACTOR\":\"27635893028257792\",\"SPS_BACK_STATUS\":\"0\",\"SO_ID\":\"4112733112893440\",\"SPS_STEP_TYPE\":\"1\",\"SPS_BACK_STATUS_TRANSACTOR\":\"-1\",\"SPS_TABLE_NAME\":\"10\",\"SPS_PREV_STEP_TRANSACTOR\":\"4112733112893440\",\"SPS_ID\":\"27652261702270976\",\"SPS_PREV_STEP_TYPE\":\"0\",\"SPS_AUDIT_STATUS\":\"1\",\"SPS_PREV_AUDIT_STATUS\":\"0\",\"SPS_TABLE_ID\":\"10\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"48256389629345792\"}', '2018-08-05 20:07:29', 1);
INSERT INTO `sys_value_record` VALUES ('48257205866070016', '28281555327647744', 'SYS_PROCESS_SCHEDULE', '48256389629345792', '{\"SPS_PREV_STEP_ID\":\"27650461607657472\",\"SPS_STEP_TRANSACTOR\":\"27635893028257792\",\"SPS_BACK_STATUS\":0,\"SO_ID\":\"4112733112893440\",\"SPS_STEP_TYPE\":1,\"SPS_TABLE_NAME\":\"10\",\"SPS_BACK_STATUS_TRANSACTOR\":-1,\"SPS_PREV_STEP_TRANSACTOR\":\"4112733112893440\",\"SPS_ID\":\"27652261702270976\",\"SPS_PREV_STEP_TYPE\":0,\"SPS_AUDIT_STATUS\":1,\"SPS_PREV_AUDIT_STATUS\":0,\"SPS_TABLE_ID\":\"10\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"48256389629345792\"}', '{\"SPS_PREV_STEP_ID\":\"27652261702270976\",\"SPS_STEP_TRANSACTOR\":\"27635943053721600\",\"SPS_BACK_STATUS\":\"0\",\"SO_ID\":\"4112733112893440\",\"SPS_STEP_TYPE\":\"1\",\"SPS_TABLE_NAME\":\"10\",\"SPS_BACK_STATUS_TRANSACTOR\":\"-1\",\"SPS_PREV_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_ID\":\"27652330522411008\",\"SPS_PREV_STEP_TYPE\":\"0\",\"SPS_AUDIT_STATUS\":\"2\",\"SPS_PREV_AUDIT_STATUS\":1,\"SPS_TABLE_ID\":\"10\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"48256389629345792\"}', '2018-08-05 20:10:43', 2);
INSERT INTO `sys_value_record` VALUES ('48257624273059840', '28281967912943616', 'SYS_PROCESS_SCHEDULE', '48256389629345792', '{\"SPS_PREV_STEP_ID\":\"27652261702270976\",\"SPS_STEP_TRANSACTOR\":\"27635943053721600\",\"SPS_BACK_STATUS\":0,\"SO_ID\":\"4112733112893440\",\"SPS_STEP_TYPE\":1,\"SPS_TABLE_NAME\":\"10\",\"SPS_BACK_STATUS_TRANSACTOR\":-1,\"SPS_PREV_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_ID\":\"27652330522411008\",\"SPS_PREV_STEP_TYPE\":0,\"SPS_AUDIT_STATUS\":2,\"SPS_PREV_AUDIT_STATUS\":1,\"SPS_TABLE_ID\":\"10\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"48256389629345792\"}', '{\"SPS_PREV_STEP_ID\":\"27652330522411008\",\"SPS_STEP_TRANSACTOR\":\"27635966298554368\",\"SPS_BACK_STATUS\":\"0\",\"SO_ID\":\"4112733112893440\",\"SPS_STEP_TYPE\":\"1\",\"SPS_TABLE_NAME\":\"10\",\"SPS_BACK_STATUS_TRANSACTOR\":\"-1\",\"SPS_PREV_STEP_TRANSACTOR\":\"28281967912943616\",\"SPS_ID\":\"27652553185427456\",\"SPS_PREV_STEP_TYPE\":\"0\",\"SPS_AUDIT_STATUS\":\"3\",\"SPS_PREV_AUDIT_STATUS\":2,\"SPS_TABLE_ID\":\"10\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"48256389629345792\"}', '2018-08-05 20:12:23', 2);
INSERT INTO `sys_value_record` VALUES ('48257687711907840', '28281983868076032', 'SYS_PROCESS_SCHEDULE', '48256389629345792', '{\"SPS_PREV_STEP_ID\":\"27652330522411008\",\"SPS_STEP_TRANSACTOR\":\"27635966298554368\",\"SPS_BACK_STATUS\":0,\"SO_ID\":\"4112733112893440\",\"SPS_STEP_TYPE\":1,\"SPS_TABLE_NAME\":\"10\",\"SPS_BACK_STATUS_TRANSACTOR\":-1,\"SPS_PREV_STEP_TRANSACTOR\":\"28281967912943616\",\"SPS_ID\":\"27652553185427456\",\"SPS_PREV_STEP_TYPE\":0,\"SPS_AUDIT_STATUS\":3,\"SPS_PREV_AUDIT_STATUS\":2,\"SPS_TABLE_ID\":\"10\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"48256389629345792\"}', '{\"SPS_PREV_STEP_ID\":\"27652553185427456\",\"SPS_STEP_TRANSACTOR\":\"27635991015587840\",\"SPS_BACK_STATUS\":\"0\",\"SO_ID\":\"4112733112893440\",\"SPS_STEP_TYPE\":\"1\",\"SPS_TABLE_NAME\":\"10\",\"SPS_BACK_STATUS_TRANSACTOR\":\"-1\",\"SPS_PREV_STEP_TRANSACTOR\":\"28281983868076032\",\"SPS_ID\":\"27652648370962432\",\"SPS_PREV_STEP_TYPE\":\"0\",\"SPS_AUDIT_STATUS\":\"4\",\"SPS_PREV_AUDIT_STATUS\":3,\"SPS_TABLE_ID\":\"10\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"48256389629345792\"}', '2018-08-05 20:12:38', 2);
INSERT INTO `sys_value_record` VALUES ('48257892645601280', '28281998451671040', 'SYS_PROCESS_SCHEDULE', '48256389629345792', '{\"SPS_PREV_STEP_ID\":\"27652553185427456\",\"SPS_STEP_TRANSACTOR\":\"27635991015587840\",\"SPS_BACK_STATUS\":0,\"SO_ID\":\"4112733112893440\",\"SPS_STEP_TYPE\":1,\"SPS_TABLE_NAME\":\"10\",\"SPS_BACK_STATUS_TRANSACTOR\":-1,\"SPS_PREV_STEP_TRANSACTOR\":\"28281983868076032\",\"SPS_ID\":\"27652648370962432\",\"SPS_PREV_STEP_TYPE\":0,\"SPS_AUDIT_STATUS\":4,\"SPS_PREV_AUDIT_STATUS\":3,\"SPS_TABLE_ID\":\"10\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"48256389629345792\"}', '{\"SPS_PREV_STEP_ID\":\"27652648370962432\",\"SPS_STEP_TRANSACTOR\":\"0\",\"SPS_BACK_STATUS\":\"0\",\"SO_ID\":\"4112733112893440\",\"SPS_STEP_TYPE\":\"1\",\"SPS_TABLE_NAME\":\"10\",\"SPS_BACK_STATUS_TRANSACTOR\":\"-1\",\"SPS_PREV_STEP_TRANSACTOR\":\"28281998451671040\",\"SPS_ID\":\"27653508450746368\",\"SPS_PREV_STEP_TYPE\":\"0\",\"SPS_AUDIT_STATUS\":\"999\",\"SPS_PREV_AUDIT_STATUS\":4,\"SPS_TABLE_ID\":\"10\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"48256389629345792\"}', '2018-08-05 20:13:27', 2);
INSERT INTO `sys_value_record` VALUES ('48286237269688320', '1', 'SYS_BUTTON', '48286237202579456', NULL, '{\"SB_CODE\":\"IMPORT\",\"SVR_TABLE_NAME\":\"SYS_BUTTON\",\"SB_FUNC\":\"\",\"SB_CLASS\":\"btn btn-info\",\"SB_ORDER\":\"7\",\"SB_BUTTONID\":\"import\",\"SB_ICON\":\"mdi mdi-import\",\"ID\":\"48286237202579456\",\"SB_TYPE\":\"0\",\"SB_NAME\":\"导入\"}', '2018-08-05 22:06:05', 1);
INSERT INTO `sys_value_record` VALUES ('48286450977865728', '1', 'SYS_BUTTON', '48286450940116992', NULL, '{\"SB_CODE\":\"EXPORT\",\"SVR_TABLE_NAME\":\"SYS_BUTTON\",\"SB_FUNC\":\"\",\"SB_CLASS\":\"btn btn-info\",\"SB_ORDER\":\"8\",\"SB_BUTTONID\":\"export\",\"SB_ICON\":\"mdi mdi-export\",\"ID\":\"48286450940116992\",\"SB_TYPE\":\"0\",\"SB_NAME\":\"导出\"}', '2018-08-05 22:06:56', 1);
INSERT INTO `sys_value_record` VALUES ('48287050318741504', '1', 'SYS_BUTTON', '48287050272604160', NULL, '{\"SB_CODE\":\"ACCOUNT_INFO\",\"SVR_TABLE_NAME\":\"SYS_BUTTON\",\"SB_FUNC\":\"\",\"SB_CLASS\":\"btn btn-info\",\"SB_ORDER\":\"12\",\"SB_BUTTONID\":\"accountInfo\",\"SB_ICON\":\"mdi mdi-account-edit\",\"ID\":\"48287050272604160\",\"SB_TYPE\":\"1\",\"SB_NAME\":\"账号信息\"}', '2018-08-05 22:09:19', 1);
INSERT INTO `sys_value_record` VALUES ('48288267224743936', '1', 'SYS_DICT_INFO', '48288267103109120', NULL, '{\"SDI_CODE\":\"2\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"2\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"部门\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"SYS_ROLE_TYPE\",\"SDI_INNERCODE\":\"2\",\"ID\":\"48288267103109120\",\"SDT_ID\":\"7\"}', '2018-08-05 22:14:09', 1);
INSERT INTO `sys_value_record` VALUES ('48288298069655552', '1', 'SYS_DICT_INFO', '48288298015129600', NULL, '{\"SDI_CODE\":\"3\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"3\",\"SDI_REMARK\":\"3\",\"SDI_NAME\":\"系部\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"SYS_ROLE_TYPE\",\"SDI_INNERCODE\":\"3\",\"ID\":\"48288298015129600\",\"SDT_ID\":\"7\"}', '2018-08-05 22:14:16', 1);
INSERT INTO `sys_value_record` VALUES ('48288312942657536', '1', 'SYS_DICT_INFO', '48288298015129600', '{\"SDI_CODE\":\"3\",\"IS_STATUS\":1,\"SDT_CODE\":\"SYS_ROLE_TYPE\",\"SDI_REQUIRED\":0,\"SDI_INNERCODE\":\"3\",\"SDI_ORDER\":3,\"SDI_REMARK\":\"3\",\"SDI_NAME\":\"系部\",\"ID\":\"48288298015129600\",\"SDI_PARENTID\":\"0\",\"SDT_ID\":\"7\"}', '{\"SDI_CODE\":\"3\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"3\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"系部\",\"SDI_PARENTID\":\"0\",\"SDI_INNERCODE\":\"3\",\"ID\":\"48288298015129600\",\"SDT_ID\":\"7\"}', '2018-08-05 22:14:20', 2);
INSERT INTO `sys_value_record` VALUES ('48288347537276928', '1', 'SYS_DICT_INFO', '48288347461779456', NULL, '{\"SDI_CODE\":\"4\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"4\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"学生\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"SYS_ROLE_TYPE\",\"SDI_INNERCODE\":\"4\",\"ID\":\"48288347461779456\",\"SDT_ID\":\"7\"}', '2018-08-05 22:14:28', 1);
INSERT INTO `sys_value_record` VALUES ('48291267443949568', '1', 'SYS_VALIDATE', '48291267339091968', NULL, '{\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"SYS_VALIDATE\",\"ID\":\"48291267339091968\",\"SV_TABLE\":\"BUS_DIVISION_PERSONNEL\"}', '2018-08-05 22:26:04', 1);
INSERT INTO `sys_value_record` VALUES ('48291553642283008', '1', 'sys_validate_field', '48291553520648192', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"50\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"48291553520648192\",\"SVF_NAME\":\"人员名称\",\"SVF_FIELD\":\"BDP_NAME\",\"SV_ID\":\"48291267339091968\",\"SVR_ID\":\"\"}', '2018-08-05 22:27:13', 1);
INSERT INTO `sys_value_record` VALUES ('48291905817018368', '1', 'sys_validate_field', '48291905728937984', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"48291905728937984\",\"SVF_NAME\":\"所属部门\",\"SVF_FIELD\":\"BD_ID\",\"SV_ID\":\"48291267339091968\",\"SVR_ID\":\"\"}', '2018-08-05 22:28:36', 1);
INSERT INTO `sys_value_record` VALUES ('48293001591521280', '1', 'SYS_CONFIGURE', '48293001511829504', NULL, '{\"SC_IS_PAGING\":\"1\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE\",\"SC_NAME\":\"基础信息管理-部门人员管理\",\"SC_JSP\":\"1\",\"SC_VIEW\":\"v_division_personnel\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"48293001511829504\",\"SC_ORDER_BY\":\"\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '2018-08-05 22:32:58', 1);
INSERT INTO `sys_value_record` VALUES ('48293060454383616', '1', 'SYS_CONFIGURE', '48293001511829504', '{\"SC_IS_PAGING\":\"1\",\"SC_NAME\":\"基础信息管理-部门人员管理\",\"SC_JSP\":\"1\",\"SC_VIEW\":\"v_division_personnel\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"48293001511829504\",\"SC_ORDER_BY\":\"\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '{\"SC_NAME\":\"基础信息管理-部门人员管理\",\"SC_JSP\":\"admin/info/divisionPersonnel/home\",\"SC_VIEW\":\"v_division_personnel\",\"SC_ORDER_BY\":\"\",\"SC_IS_PAGING\":\"1\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"48293001511829504\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '2018-08-05 22:33:12', 2);
INSERT INTO `sys_value_record` VALUES ('48293097473310720', '1', 'SYS_CONFIGURE', '48293001511829504', '{\"SC_IS_PAGING\":\"1\",\"SC_NAME\":\"基础信息管理-部门人员管理\",\"SC_JSP\":\"admin/info/divisionPersonnel/home\",\"SC_VIEW\":\"v_division_personnel\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"48293001511829504\",\"SC_ORDER_BY\":\"\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '{\"SC_NAME\":\"基础信息管理-部门人员管理\",\"SC_JSP\":\"admin/info/divisionPersonnel/home\",\"SC_VIEW\":\"v_division_personnel\",\"SC_ORDER_BY\":\"CONVERT(ID,SIGNED) DESC\",\"SC_IS_PAGING\":\"1\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"48293001511829504\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '2018-08-05 22:33:21', 2);
INSERT INTO `sys_value_record` VALUES ('48293542086311936', '1', 'SYS_CONFIGURE_COLUMN', '48293541973065728', NULL, '{\"SCC_NAME\":\"人员名称\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"150px\",\"SCC_FIELD\":\"BDP_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48293541973065728\",\"SC_ID\":\"48293001511829504\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"1\"}', '2018-08-05 22:35:07', 1);
INSERT INTO `sys_value_record` VALUES ('48293694159192064', '1', 'SYS_CONFIGURE_COLUMN', '48293694100471808', NULL, '{\"SCC_NAME\":\"所属部门\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"250px\",\"SCC_FIELD\":\"BD_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48293694100471808\",\"SC_ID\":\"48293001511829504\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"20\"}', '2018-08-05 22:35:43', 1);
INSERT INTO `sys_value_record` VALUES ('48294220762447872', '1', 'SYS_CONFIGURE_COLUMN', '48294220707921920', NULL, '{\"SCC_NAME\":\"操作\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"400px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"48294220707921920\",\"SC_ID\":\"48293001511829504\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"30\"}', '2018-08-05 22:37:48', 1);
INSERT INTO `sys_value_record` VALUES ('48294252924370944', '1', 'SYS_CONFIGURE_COLUMN', '48294220707921920', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"400px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"48294220707921920\",\"SC_ID\":\"48293001511829504\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":30}', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"400px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"48294220707921920\",\"SC_ID\":\"48293001511829504\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"30\"}', '2018-08-05 22:37:56', 2);
INSERT INTO `sys_value_record` VALUES ('48294713689636864', '1', 'SYS_CONFIGURE_SEARCH', '48294713588973568', NULL, '{\"SCS_METHOD_TYPE\":\"4\",\"SCS_TYPE\":\"1\",\"SCS_FIELD\":\"BDP_NAME\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_SEARCH\",\"SCS_NAME\":\"人员名称\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"48294713588973568\",\"SC_ID\":\"48293001511829504\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":\"1\"}', '2018-08-05 22:39:46', 1);
INSERT INTO `sys_value_record` VALUES ('48294776704860160', '1', 'SYS_CONFIGURE_SEARCH', '48294776654528512', NULL, '{\"SCS_METHOD_TYPE\":\"4\",\"SCS_TYPE\":\"1\",\"SCS_FIELD\":\"BD_NAME\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_SEARCH\",\"SCS_NAME\":\"所属部门\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"48294776654528512\",\"SC_ID\":\"48293001511829504\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":\"20\"}', '2018-08-05 22:40:01', 1);
INSERT INTO `sys_value_record` VALUES ('48295058469814272', '1', 'SYS_MENU', '48295058385928192', NULL, '{\"SM_URL\":\"admin/dataGrid/\",\"SVR_TABLE_NAME\":\"SYS_MENU\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":\"20\",\"SM_CODE\":\"\",\"SM_NAME\":\"部门人员管理\",\"SM_PARENTID\":\"38116041032728576\",\"SPD_ID\":\"\",\"ID\":\"48295058385928192\",\"SC_ID\":\"48293001511829504\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '2018-08-05 22:41:08', 1);
INSERT INTO `sys_value_record` VALUES ('48295154636816384', '1', 'SYS_MENU', '48295058385928192', '{\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_ORDER\":20,\"SM_CODE\":\"\",\"SM_NAME\":\"部门人员管理\",\"SM_PARENTID\":\"38116041032728576\",\"SPD_ID\":\"\",\"ID\":\"48295058385928192\",\"SC_ID\":\"48293001511829504\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '{\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_ORDER\":\"20\",\"SM_CODE\":\"INFO:DIVISION_PERSONNEL\",\"SM_NAME\":\"部门人员管理\",\"SM_PARENTID\":\"38116041032728576\",\"SPD_ID\":\"\",\"ID\":\"48295058385928192\",\"SC_ID\":\"48293001511829504\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '2018-08-05 22:41:31', 2);
INSERT INTO `sys_value_record` VALUES ('48295468739854336', '1', 'SYS_BUTTON', '48287050272604160', '{\"SB_CODE\":\"ACCOUNT_INFO\",\"SB_FUNC\":\"\",\"SB_CLASS\":\"btn btn-info\",\"SB_ORDER\":12,\"SB_BUTTONID\":\"accountInfo\",\"SB_ICON\":\"mdi mdi-account-edit\",\"ID\":\"48287050272604160\",\"SB_TYPE\":\"1\",\"SB_NAME\":\"账号信息\"}', '{\"SB_CODE\":\"ACCOUNT_INFO\",\"SB_CLASS\":\"btn btn-info\",\"SB_ORDER\":\"9\",\"SB_BUTTONID\":\"accountInfo\",\"SB_ICON\":\"mdi mdi-account-edit\",\"SB_TYPE\":\"1\",\"SB_FUNC\":\"\",\"ID\":\"48287050272604160\",\"SB_NAME\":\"账号信息\"}', '2018-08-05 22:42:46', 2);
INSERT INTO `sys_value_record` VALUES ('48296712313241600', '1', 'SYS_MENU', '48295058385928192', '{\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_ORDER\":20,\"SM_CODE\":\"INFO:DIVISION_PERSONNEL\",\"SM_NAME\":\"部门人员管理\",\"SM_PARENTID\":\"38116041032728576\",\"SPD_ID\":\"\",\"ID\":\"48295058385928192\",\"SC_ID\":\"48293001511829504\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '{\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_ORDER\":\"20\",\"SM_CODE\":\"INFO:DIVISION_PERSONNEL\",\"SM_NAME\":\"部门人员管理\",\"SM_PARENTID\":\"38116041032728576\",\"SPD_ID\":\"\",\"ID\":\"48295058385928192\",\"SC_ID\":\"48293001511829504\",\"SM_CLASSICON\":\"mdi mdi-account-multiple\",\"SM_IS_EXPAND\":\"\"}', '2018-08-05 22:47:42', 2);
INSERT INTO `sys_value_record` VALUES ('48302878669930496', '1', 'BUS_DIVISION', '38344744014708736', NULL, NULL, '2018-08-05 23:12:13', 3);
INSERT INTO `sys_value_record` VALUES ('48302887427637248', '1', 'BUS_DIVISION', '38345402751123456', NULL, NULL, '2018-08-05 23:12:15', 3);
INSERT INTO `sys_value_record` VALUES ('48302941500604416', '1', 'BUS_DIVISION', '48302941391552512', NULL, '{\"BD_CONTACTS\":\"\",\"BD_FIXED_PHONE\":\"\",\"BD_ORDER\":\"1\",\"SVR_TABLE_NAME\":\"BUS_DIVISION\",\"BD_ADDRESS\":\"\",\"BD_ENTER_TIME\":\"2018-08-05 23:12:28\",\"ID\":\"48302941391552512\",\"BD_NAME\":\"教务处\",\"BD_PHONE\":\"\",\"BD_DESCRIBE\":\"\",\"BD_EMAIL\":\"\",\"BD_PARENT_ID\":\"0\"}', '2018-08-05 23:12:28', 1);
INSERT INTO `sys_value_record` VALUES ('48302970470662144', '1', 'BUS_DIVISION', '48302970428719104', NULL, '{\"BD_CONTACTS\":\"\",\"BD_FIXED_PHONE\":\"\",\"BD_ORDER\":\"2\",\"SVR_TABLE_NAME\":\"BUS_DIVISION\",\"BD_ADDRESS\":\"\",\"BD_ENTER_TIME\":\"2018-08-05 23:12:34\",\"ID\":\"48302970428719104\",\"BD_NAME\":\"财务处\",\"BD_PHONE\":\"\",\"BD_DESCRIBE\":\"\",\"BD_EMAIL\":\"\",\"BD_PARENT_ID\":\"0\"}', '2018-08-05 23:12:34', 1);
INSERT INTO `sys_value_record` VALUES ('48303082483744768', '1', 'SYS_CONFIGURE', '38163489528741888', '{\"SC_IS_PAGING\":\"1\",\"SC_NAME\":\"基础信息管理-部门管理\",\"SC_JSP\":\"admin/info/division/home\",\"SC_VIEW\":\"v_division\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"38163489528741888\",\"SC_ORDER_BY\":\"CONVERT(ID,SIGNED) DESC\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '{\"SC_NAME\":\"基础信息管理-部门管理\",\"SC_JSP\":\"admin/info/division/home\",\"SC_VIEW\":\"v_division\",\"SC_ORDER_BY\":\"BD_ORDER ASC\",\"SC_IS_PAGING\":\"1\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"38163489528741888\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '2018-08-05 23:13:01', 2);
INSERT INTO `sys_value_record` VALUES ('48303136321830912', '1', 'SYS_OPERATOR', '48303136200196097', NULL, '{\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"SYS_OPERATOR\",\"SO_PASSWORD\":\"21295f6c68e4fb821e15b921ed554ec5\",\"ID\":\"48303136200196097\",\"SO_SALT\":\"e45lR4\"}', '2018-08-05 23:13:14', 1);
INSERT INTO `sys_value_record` VALUES ('48303136426688512', '1', 'SYS_ACCOUNT_INFO', '48303136338608128', NULL, '{\"SVR_TABLE_NAME\":\"SYS_ACCOUNT_INFO\",\"SO_ID\":\"48303136200196097\",\"SAI_NAME\":\"test1\",\"ID\":\"48303136338608128\"}', '2018-08-05 23:13:14', 1);
INSERT INTO `sys_value_record` VALUES ('48303136477020160', '1', 'bus_division_personnel', '48303136200196096', NULL, '{\"SVR_TABLE_NAME\":\"bus_division_personnel\",\"BDP_NAME\":\"test1\",\"SO_ID\":\"48303136200196097\",\"BD_ID\":\"48302941391552512\",\"ID\":\"48303136200196096\"}', '2018-08-05 23:13:14', 1);
INSERT INTO `sys_value_record` VALUES ('48304916791296000', '1', 'SYS_MENU', '48304916703215616', NULL, '{\"SM_URL\":\"\",\"SVR_TABLE_NAME\":\"SYS_MENU\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":\"1\",\"SM_CODE\":\"INFO:DIVISION_PERSONNEL:UPDATE\",\"SM_NAME\":\"编辑\",\"SM_PARENTID\":\"0\",\"SPD_ID\":\"\",\"ID\":\"48304916703215616\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '2018-08-05 23:20:19', 1);
INSERT INTO `sys_value_record` VALUES ('48304976329441280', '1', 'SYS_MENU', '48304916703215616', '{\"SM_URL\":\"\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_ORDER\":1,\"SM_CODE\":\"INFO:DIVISION_PERSONNEL:UPDATE\",\"SM_NAME\":\"编辑\",\"SM_PARENTID\":\"0\",\"SPD_ID\":\"\",\"ID\":\"48304916703215616\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '{\"SM_URL\":\"\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_ORDER\":\"1\",\"SM_CODE\":\"INFO:DIVISION_PERSONNEL:UPDATE\",\"SM_NAME\":\"编辑\",\"SM_PARENTID\":\"48295058385928192\",\"SPD_ID\":\"\",\"ID\":\"48304916703215616\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '2018-08-05 23:20:33', 2);
INSERT INTO `sys_value_record` VALUES ('48305288813477888', '1', 'SYS_MENU', '48304916703215616', '{\"SM_URL\":\"\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_ORDER\":1,\"SM_CODE\":\"INFO:DIVISION_PERSONNEL:UPDATE\",\"SM_NAME\":\"编辑\",\"SM_PARENTID\":\"48295058385928192\",\"SPD_ID\":\"\",\"ID\":\"48304916703215616\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '{\"SM_URL\":\"\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_ORDER\":\"1\",\"SM_CODE\":\"INFO:DIVISION_PERSONNEL_UPDATE\",\"SM_NAME\":\"编辑\",\"SM_PARENTID\":\"48295058385928192\",\"SPD_ID\":\"\",\"ID\":\"48304916703215616\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '2018-08-05 23:21:47', 2);
INSERT INTO `sys_value_record` VALUES ('48305331196919808', '1', 'bus_division_personnel', '48303136200196096', '{\"BDP_NAME\":\"test1\",\"SO_ID\":\"48303136200196097\",\"BD_ID\":\"48302941391552512\",\"ID\":\"48303136200196096\"}', '{\"BDP_NAME\":\"教务处1\",\"BD_ID\":\"48302941391552512\",\"ID\":\"48303136200196096\"}', '2018-08-05 23:21:57', 2);
INSERT INTO `sys_value_record` VALUES ('48305353183461376', '1', 'bus_division_personnel', '48303136200196096', '{\"BDP_NAME\":\"教务处1\",\"SO_ID\":\"48303136200196097\",\"BD_ID\":\"48302941391552512\",\"ID\":\"48303136200196096\"}', '{\"BDP_NAME\":\"TEST1\",\"BD_ID\":\"48302970428719104\",\"ID\":\"48303136200196096\"}', '2018-08-05 23:22:03', 2);
INSERT INTO `sys_value_record` VALUES ('48305379636936704', '1', 'bus_division_personnel', '48303136200196096', '{\"BDP_NAME\":\"TEST1\",\"SO_ID\":\"48303136200196097\",\"BD_ID\":\"48302970428719104\",\"ID\":\"48303136200196096\"}', '{\"BDP_NAME\":\"财务处\",\"BD_ID\":\"48302941391552512\",\"ID\":\"48303136200196096\"}', '2018-08-05 23:22:09', 2);
INSERT INTO `sys_value_record` VALUES ('48305727038554112', '1', 'SYS_CONFIGURE_COLUMN', '3317375399100416', '{\"SCC_NAME\":\"邮箱\",\"SCC_FUNC\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"\",\"SCC_FIELD\":\"SAI_EMAIL\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"3317375399100416\",\"SC_ID\":\"3316994321416192\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":4}', '{\"SCC_NAME\":\"邮箱\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"SAI_EMAIL\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"3317375399100416\",\"SC_ID\":\"3316994321416192\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"4\"}', '2018-08-05 23:23:32', 2);
INSERT INTO `sys_value_record` VALUES ('48305746722422784', '1', 'SYS_CONFIGURE_COLUMN', '3317344390610944', '{\"SCC_NAME\":\"手机\",\"SCC_FUNC\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"\",\"SCC_FIELD\":\"SAI_PHONE\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"3317344390610944\",\"SC_ID\":\"3316994321416192\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":3}', '{\"SCC_NAME\":\"手机\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"SAI_PHONE\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"3317344390610944\",\"SC_ID\":\"3316994321416192\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"3\"}', '2018-08-05 23:23:36', 2);
INSERT INTO `sys_value_record` VALUES ('48305776556507136', '1', 'SYS_CONFIGURE_COLUMN', '3317258654842880', '{\"SCC_NAME\":\"登录账号\",\"SCC_FUNC\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"\",\"SCC_FIELD\":\"SOS_USERNAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"3317258654842880\",\"SC_ID\":\"3316994321416192\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":2}', '{\"SCC_NAME\":\"登录账号\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"left\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"200px\",\"SCC_FIELD\":\"SOS_USERNAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"3317258654842880\",\"SC_ID\":\"3316994321416192\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"2\"}', '2018-08-05 23:23:44', 2);
INSERT INTO `sys_value_record` VALUES ('48305792494862336', '1', 'SYS_CONFIGURE_COLUMN', '3317102362492928', '{\"SCC_NAME\":\"姓名\",\"SCC_FUNC\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"\",\"SCC_FIELD\":\"SAI_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"3317102362492928\",\"SC_ID\":\"3316994321416192\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":1}', '{\"SCC_NAME\":\"姓名\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"SAI_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"3317102362492928\",\"SC_ID\":\"3316994321416192\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"1\"}', '2018-08-05 23:23:47', 2);
INSERT INTO `sys_value_record` VALUES ('48305887219023872', '1', 'SYS_CONFIGURE_COLUMN', '3317258654842880', '{\"SCC_NAME\":\"登录账号\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"left\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"200px\",\"SCC_FIELD\":\"SOS_USERNAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"3317258654842880\",\"SC_ID\":\"3316994321416192\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":2}', '{\"SCC_NAME\":\"登录账号\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"left\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"150px\",\"SCC_FIELD\":\"SOS_USERNAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"3317258654842880\",\"SC_ID\":\"3316994321416192\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"2\"}', '2018-08-05 23:24:10', 2);
INSERT INTO `sys_value_record` VALUES ('48305908194738176', '1', 'SYS_CONFIGURE_COLUMN', '3317102362492928', '{\"SCC_NAME\":\"姓名\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"SAI_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"3317102362492928\",\"SC_ID\":\"3316994321416192\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":1}', '{\"SCC_NAME\":\"姓名\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"130px\",\"SCC_FIELD\":\"SAI_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"3317102362492928\",\"SC_ID\":\"3316994321416192\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"1\"}', '2018-08-05 23:24:15', 2);
INSERT INTO `sys_value_record` VALUES ('48306126395015168', '1', 'SYS_OPERATOR', '48303136200196097', '{\"IS_STATUS\":1,\"ID\":\"48303136200196097\"}', '{\"ID\":\"48303136200196097\"}', '2018-08-05 23:25:07', 2);
INSERT INTO `sys_value_record` VALUES ('48306274965651456', '1', 'SYS_OPERATOR', '48303136200196097', '{\"IS_STATUS\":1,\"ID\":\"48303136200196097\"}', '{\"ID\":\"48303136200196097\"}', '2018-08-05 23:25:42', 2);
INSERT INTO `sys_value_record` VALUES ('48306353520771072', '1', 'SYS_OPERATOR_SUB', '48306353327833088', NULL, '{\"IS_STATUS\":1,\"SOS_CREATETIME\":\"2018-08-05 23:26:01\",\"SVR_TABLE_NAME\":\"SYS_OPERATOR_SUB\",\"SOS_REMARK\":\"\",\"SOS_DEFAULT\":1,\"SO_ID\":\"48303136200196097\",\"ID\":\"48306353327833088\",\"SOS_USERNAME\":\"devision_test\",\"SOS_USERTYPE\":\"1\"}', '2018-08-05 23:26:01', 1);
INSERT INTO `sys_value_record` VALUES ('48306798318321664', '1', 'SYS_OPERATOR', '48303136200196097', '{\"SO_PASSWORD\":\"21295f6c68e4fb821e15b921ed554ec5\",\"ID\":\"48303136200196097\",\"IS_DEFAULT_PWD\":1,\"SO_SALT\":\"e45lR4\"}', '{\"IS_DEFAULT_PWD\":1,\"SO_SALT\":\"1HirhX\",\"SO_PASSWORD\":\"2a2726bfa13ce394daeade2b8236c9af\",\"ID\":\"48303136200196097\"}', '2018-08-05 23:27:47', 2);
INSERT INTO `sys_value_record` VALUES ('48306880430211072', '1', 'SYS_OPERATOR', '48303136200196097', '{\"SO_PASSWORD\":\"2a2726bfa13ce394daeade2b8236c9af\",\"ID\":\"48303136200196097\",\"IS_DEFAULT_PWD\":0,\"SO_SALT\":\"1HirhX\"}', '{\"IS_DEFAULT_PWD\":1,\"SO_SALT\":\"+;-5f4\",\"SO_PASSWORD\":\"6aafffcbfc284394c1a9482c845feb23\",\"ID\":\"48303136200196097\"}', '2018-08-05 23:28:07', 2);
INSERT INTO `sys_value_record` VALUES ('48307249507991552', '1', 'SYS_OPERATOR', '48303136200196097', '{\"SO_PASSWORD\":\"6aafffcbfc284394c1a9482c845feb23\",\"ID\":\"48303136200196097\",\"IS_DEFAULT_PWD\":1,\"SO_SALT\":\"+;-5f4\"}', '{\"IS_DEFAULT_PWD\":1,\"SO_SALT\":\"IsshtE\",\"SO_PASSWORD\":\"097e5189851d9a6747ee5454276fa204\",\"ID\":\"48303136200196097\"}', '2018-08-05 23:29:35', 2);
INSERT INTO `sys_value_record` VALUES ('48307316793016320', '1', 'SYS_OPERATOR', '48303136200196097', '{\"SO_PASSWORD\":\"097e5189851d9a6747ee5454276fa204\",\"ID\":\"48303136200196097\",\"IS_DEFAULT_PWD\":1,\"SO_SALT\":\"IsshtE\"}', '{\"IS_DEFAULT_PWD\":1,\"SO_SALT\":\"P2jSvy\",\"SO_PASSWORD\":\"262ff9c34663d5a82e45ebe5b8c27a74\",\"ID\":\"48303136200196097\"}', '2018-08-05 23:29:51', 2);
INSERT INTO `sys_value_record` VALUES ('48307443465191424', '1', 'SYS_OPERATOR', '48303136200196097', '{\"IS_STATUS\":1,\"ID\":\"48303136200196097\"}', '{\"ID\":\"48303136200196097\"}', '2018-08-05 23:30:21', 2);
INSERT INTO `sys_value_record` VALUES ('48307458908618752', '1', 'bus_division_personnel', '48303136200196096', '{\"BDP_NAME\":\"财务处\",\"SO_ID\":\"48303136200196097\",\"BD_ID\":\"48302941391552512\",\"ID\":\"48303136200196096\"}', '{\"BDP_NAME\":\"devision_test\",\"BD_ID\":\"48302941391552512\",\"ID\":\"48303136200196096\"}', '2018-08-05 23:30:25', 2);
INSERT INTO `sys_value_record` VALUES ('48307839965331456', '1', 'SYS_ROLE', '48307839919194112', NULL, '{\"SR_CODE\":\"STUDENT_DIVISION\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"SYS_ROLE\",\"SR_EXPLAIN\":\"\",\"SR_NAME\":\"学生处\",\"ID\":\"48307839919194112\",\"SR_REMARK\":\"\",\"SR_TYPE\":\"2\"}', '2018-08-05 23:31:55', 1);
INSERT INTO `sys_value_record` VALUES ('48308661189083136', '1', 'BUS_DIVISION', '48308661151334400', NULL, '{\"BD_CONTACTS\":\"\",\"BD_FIXED_PHONE\":\"\",\"BD_ORDER\":\"3\",\"SVR_TABLE_NAME\":\"BUS_DIVISION\",\"BD_ADDRESS\":\"\",\"BD_ENTER_TIME\":\"2018-08-05 23:35:11\",\"ID\":\"48308661151334400\",\"BD_NAME\":\"学生处\",\"BD_PHONE\":\"\",\"BD_DESCRIBE\":\"\",\"BD_EMAIL\":\"\",\"BD_PARENT_ID\":\"0\"}', '2018-08-05 23:35:11', 1);
INSERT INTO `sys_value_record` VALUES ('48309255131889664', '1', 'bus_division_personnel', '48303136200196096', '{\"BDP_NAME\":\"devision_test\",\"SO_ID\":\"48303136200196097\",\"BD_ID\":\"48302941391552512\",\"ID\":\"48303136200196096\"}', '{\"BDP_NAME\":\"devision_test\",\"BD_ID\":\"48308661151334400\",\"ID\":\"48303136200196096\"}', '2018-08-05 23:37:33', 2);
INSERT INTO `sys_value_record` VALUES ('48309528831197184', '1', 'SYS_ROLE', '48309528801837056', NULL, '{\"SR_CODE\":\"INSTRUCTOR\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"SYS_ROLE\",\"SR_EXPLAIN\":\"辅导员\",\"SR_NAME\":\"辅导员\",\"ID\":\"48309528801837056\",\"SR_REMARK\":\"\",\"SR_TYPE\":\"3\"}', '2018-08-05 23:38:38', 1);
INSERT INTO `sys_value_record` VALUES ('48309996915523584', '1', 'SYS_ROLE', '48309996873580544', NULL, '{\"SR_CODE\":\"MANAGER_DIVISION\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"SYS_ROLE\",\"SR_EXPLAIN\":\"\",\"SR_NAME\":\"系部管理\",\"ID\":\"48309996873580544\",\"SR_REMARK\":\"\",\"SR_TYPE\":\"3\"}', '2018-08-05 23:40:30', 1);
INSERT INTO `sys_value_record` VALUES ('48518622103994368', '4112733112893440', 'SYS_PROCESS_SCHEDULE', '33410262795026432', '{\"SPS_PREV_STEP_ID\":\"27650461607657472\",\"SPS_STEP_TRANSACTOR\":\"27635893028257792\",\"SPS_BACK_STATUS\":0,\"SO_ID\":\"4112733112893440\",\"SPS_STEP_TYPE\":1,\"SPS_TABLE_NAME\":\"测试流程1\",\"SPS_BACK_STATUS_TRANSACTOR\":-1,\"SPS_PREV_STEP_TRANSACTOR\":\"4112733112893440\",\"SPS_ID\":\"27652261702270976\",\"SPS_PREV_STEP_TYPE\":0,\"SPS_AUDIT_STATUS\":1,\"SPS_PREV_AUDIT_STATUS\":-1,\"SPS_TABLE_ID\":\"1\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33410262795026432\"}', '{\"SPS_PREV_STEP_ID\":\"27652261702270976\",\"SPS_STEP_TRANSACTOR\":\"4112733112893440\",\"SPS_BACK_STATUS\":\"2\",\"SO_ID\":\"4112733112893440\",\"SPS_STEP_TYPE\":2,\"SPS_TABLE_NAME\":\"测试流程1\",\"SPS_BACK_STATUS_TRANSACTOR\":0,\"SPS_PREV_STEP_TRANSACTOR\":\"4112733112893440\",\"SPS_ID\":\"27650461607657472\",\"SPS_PREV_STEP_TYPE\":\"2\",\"SPS_AUDIT_STATUS\":-1,\"SPS_PREV_AUDIT_STATUS\":1,\"SPS_TABLE_ID\":\"1\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33410262795026432\"}', '2018-08-06 13:29:30', 2);
INSERT INTO `sys_value_record` VALUES ('48518646938468352', '4112733112893440', 'SYS_PROCESS_SCHEDULE', '33410262795026432', '{\"SPS_PREV_STEP_ID\":\"27652261702270976\",\"SPS_STEP_TRANSACTOR\":\"4112733112893440\",\"SPS_BACK_STATUS\":2,\"SO_ID\":\"4112733112893440\",\"SPS_STEP_TYPE\":2,\"SPS_TABLE_NAME\":\"测试流程1\",\"SPS_BACK_STATUS_TRANSACTOR\":0,\"SPS_PREV_STEP_TRANSACTOR\":\"4112733112893440\",\"SPS_ID\":\"27650461607657472\",\"SPS_PREV_STEP_TYPE\":2,\"SPS_AUDIT_STATUS\":-1,\"SPS_PREV_AUDIT_STATUS\":1,\"SPS_TABLE_ID\":\"1\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33410262795026432\"}', '{\"SPS_PREV_STEP_ID\":\"27650461607657472\",\"SPS_STEP_TRANSACTOR\":\"27635893028257792\",\"SPS_BACK_STATUS\":\"0\",\"SO_ID\":\"4112733112893440\",\"SPS_STEP_TYPE\":\"1\",\"SPS_TABLE_NAME\":\"测试流程1\",\"SPS_BACK_STATUS_TRANSACTOR\":\"-1\",\"SPS_PREV_STEP_TRANSACTOR\":\"4112733112893440\",\"SPS_ID\":\"27652261702270976\",\"SPS_PREV_STEP_TYPE\":\"0\",\"SPS_AUDIT_STATUS\":\"1\",\"SPS_PREV_AUDIT_STATUS\":-1,\"SPS_TABLE_ID\":\"1\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33410262795026432\"}', '2018-08-06 13:29:36', 2);
INSERT INTO `sys_value_record` VALUES ('48518765670825984', '28281555327647744', 'SYS_PROCESS_SCHEDULE', '33410262795026432', '{\"SPS_PREV_STEP_ID\":\"27650461607657472\",\"SPS_STEP_TRANSACTOR\":\"27635893028257792\",\"SPS_BACK_STATUS\":0,\"SO_ID\":\"4112733112893440\",\"SPS_STEP_TYPE\":1,\"SPS_TABLE_NAME\":\"测试流程1\",\"SPS_BACK_STATUS_TRANSACTOR\":-1,\"SPS_PREV_STEP_TRANSACTOR\":\"4112733112893440\",\"SPS_ID\":\"27652261702270976\",\"SPS_PREV_STEP_TYPE\":0,\"SPS_AUDIT_STATUS\":1,\"SPS_PREV_AUDIT_STATUS\":-1,\"SPS_TABLE_ID\":\"1\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33410262795026432\"}', '{\"SPS_PREV_STEP_ID\":\"27652261702270976\",\"SPS_STEP_TRANSACTOR\":\"27635943053721600\",\"SPS_BACK_STATUS\":\"0\",\"SO_ID\":\"4112733112893440\",\"SPS_STEP_TYPE\":\"1\",\"SPS_TABLE_NAME\":\"测试流程1\",\"SPS_BACK_STATUS_TRANSACTOR\":\"-1\",\"SPS_PREV_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_ID\":\"27652330522411008\",\"SPS_PREV_STEP_TYPE\":\"0\",\"SPS_AUDIT_STATUS\":\"2\",\"SPS_PREV_AUDIT_STATUS\":1,\"SPS_TABLE_ID\":\"1\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33410262795026432\"}', '2018-08-06 13:30:04', 2);
INSERT INTO `sys_value_record` VALUES ('48521427866877952', '28281967912943616', 'SYS_PROCESS_SCHEDULE', '33410262795026432', '{\"SPS_PREV_STEP_ID\":\"27652261702270976\",\"SPS_STEP_TRANSACTOR\":\"27635943053721600\",\"SPS_BACK_STATUS\":0,\"SO_ID\":\"4112733112893440\",\"SPS_STEP_TYPE\":1,\"SPS_TABLE_NAME\":\"测试流程1\",\"SPS_BACK_STATUS_TRANSACTOR\":-1,\"SPS_PREV_STEP_TRANSACTOR\":\"28281555327647744\",\"SPS_ID\":\"27652330522411008\",\"SPS_PREV_STEP_TYPE\":0,\"SPS_AUDIT_STATUS\":2,\"SPS_PREV_AUDIT_STATUS\":1,\"SPS_TABLE_ID\":\"1\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33410262795026432\"}', '{\"SPS_PREV_STEP_ID\":\"27652330522411008\",\"SPS_STEP_TRANSACTOR\":\"4112733112893440\",\"SPS_BACK_STATUS\":\"1\",\"SO_ID\":\"4112733112893440\",\"SPS_STEP_TYPE\":\"2\",\"SPS_TABLE_NAME\":\"测试流程1\",\"SPS_BACK_STATUS_TRANSACTOR\":\"0\",\"SPS_PREV_STEP_TRANSACTOR\":\"28281967912943616\",\"SPS_ID\":\"27652261702270976\",\"SPS_PREV_STEP_TYPE\":\"1\",\"SPS_AUDIT_STATUS\":\"-1\",\"SPS_PREV_AUDIT_STATUS\":2,\"SPS_TABLE_ID\":\"1\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33410262795026432\"}', '2018-08-06 13:40:39', 2);
INSERT INTO `sys_value_record` VALUES ('48527629367640064', '1', 'SYS_CONFIGURE_COLUMN', '3547200810385408', NULL, NULL, '2018-08-06 14:05:17', 3);
INSERT INTO `sys_value_record` VALUES ('48527748586536960', '1', 'SYS_CONFIGURE_COLUMN', '3317518018019328', '{\"SCC_NAME\":\"状态\",\"SCC_FUNC\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"1\",\"SCC_WIDTH\":\"30px\",\"SCC_FIELD\":\"IS_STATUS\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"3317518018019328\",\"SC_ID\":\"3316994321416192\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":5}', '{\"SCC_NAME\":\"状态\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"1\",\"SCC_WIDTH\":\"30px\",\"SCC_FIELD\":\"IS_STATUS\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"3317518018019328\",\"SC_ID\":\"3316994321416192\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"50\"}', '2018-08-06 14:05:46', 2);
INSERT INTO `sys_value_record` VALUES ('48527774272454656', '1', 'SYS_CONFIGURE_COLUMN', '3317579653316608', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"400px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"3317579653316608\",\"SC_ID\":\"3316994321416192\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":6}', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"400px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"3317579653316608\",\"SC_ID\":\"3316994321416192\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"60\"}', '2018-08-06 14:05:52', 2);
INSERT INTO `sys_value_record` VALUES ('48527814881705984', '1', 'SYS_CONFIGURE_COLUMN', '3317344390610944', '{\"SCC_NAME\":\"手机\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"SAI_PHONE\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"3317344390610944\",\"SC_ID\":\"3316994321416192\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":3}', '{\"SCC_NAME\":\"手机\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"800px\",\"SCC_FIELD\":\"SAI_PHONE\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"3317344390610944\",\"SC_ID\":\"3316994321416192\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"3\"}', '2018-08-06 14:06:02', 2);
INSERT INTO `sys_value_record` VALUES ('48527829641461760', '1', 'SYS_CONFIGURE_COLUMN', '3317344390610944', '{\"SCC_NAME\":\"手机\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"800px\",\"SCC_FIELD\":\"SAI_PHONE\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"3317344390610944\",\"SC_ID\":\"3316994321416192\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":3}', '{\"SCC_NAME\":\"手机\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"80px\",\"SCC_FIELD\":\"SAI_PHONE\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"3317344390610944\",\"SC_ID\":\"3316994321416192\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"3\"}', '2018-08-06 14:06:05', 2);
INSERT INTO `sys_value_record` VALUES ('48527924092993536', '1', 'SYS_CONFIGURE_COLUMN', '48527923962970112', NULL, '{\"SCC_NAME\":\"类型\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"\",\"SCC_FIELD\":\"SAI_TYPE\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48527923962970112\",\"SC_ID\":\"3316994321416192\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"SYS_OPERATOR_TYPE\",\"SCC_ORDER\":\"40\"}', '2018-08-06 14:06:28', 1);
INSERT INTO `sys_value_record` VALUES ('48528079479373824', '1', 'SYS_CONFIGURE_COLUMN', '48527923962970112', '{\"SCC_NAME\":\"类型\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"\",\"SCC_FIELD\":\"SAI_TYPE\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48527923962970112\",\"SC_ID\":\"3316994321416192\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"SYS_OPERATOR_TYPE\",\"SCC_ORDER\":40}', '{\"SCC_NAME\":\"类型\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"50px\",\"SCC_FIELD\":\"SAI_TYPE\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48527923962970112\",\"SC_ID\":\"3316994321416192\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"SYS_OPERATOR_TYPE\",\"SCC_ORDER\":\"40\"}', '2018-08-06 14:07:05', 2);
INSERT INTO `sys_value_record` VALUES ('48528183888183296', '1', 'SYS_CONFIGURE_COLUMN', '3317579653316608', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"400px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"3317579653316608\",\"SC_ID\":\"3316994321416192\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":60}', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"370px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"3317579653316608\",\"SC_ID\":\"3316994321416192\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"60\"}', '2018-08-06 14:07:30', 2);
INSERT INTO `sys_value_record` VALUES ('48528271788212224', '1', 'SYS_CONFIGURE_COLUMN', '3317579653316608', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"370px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"3317579653316608\",\"SC_ID\":\"3316994321416192\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":60}', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"350px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"3317579653316608\",\"SC_ID\":\"3316994321416192\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"60\"}', '2018-08-06 14:07:51', 2);
INSERT INTO `sys_value_record` VALUES ('48528358446727168', '1', 'SYS_CONFIGURE_COLUMN', '3317579653316608', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"350px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"3317579653316608\",\"SC_ID\":\"3316994321416192\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":60}', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"360px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"3317579653316608\",\"SC_ID\":\"3316994321416192\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"60\"}', '2018-08-06 14:08:11', 2);
INSERT INTO `sys_value_record` VALUES ('48528526583791616', '1', 'SYS_DICT_INFO', '3546984086503424', '{\"SDI_CODE\":\"2\",\"IS_STATUS\":1,\"SDT_CODE\":\"SYS_OPERATOR_TYPE\",\"SDI_REQUIRED\":0,\"SDI_INNERCODE\":\"2\",\"SDI_ORDER\":2,\"SDI_REMARK\":\"\",\"SDI_NAME\":\"学生\",\"ID\":\"3546984086503424\",\"SDI_PARENTID\":\"0\",\"SDT_ID\":\"3546057401171968\"}', '{\"SDI_CODE\":\"2\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"2\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"部门\",\"SDI_PARENTID\":\"0\",\"SDI_INNERCODE\":\"2\",\"ID\":\"3546984086503424\",\"SDT_ID\":\"3546057401171968\"}', '2018-08-06 14:08:51', 2);
INSERT INTO `sys_value_record` VALUES ('48528552273903616', '1', 'SYS_DICT_INFO', '48528552202600448', NULL, '{\"SDI_CODE\":\"3\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"3\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"系部\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"SYS_OPERATOR_TYPE\",\"SDI_INNERCODE\":\"3\",\"ID\":\"48528552202600448\",\"SDT_ID\":\"3546057401171968\"}', '2018-08-06 14:08:57', 1);
INSERT INTO `sys_value_record` VALUES ('48528576923828224', '1', 'SYS_DICT_INFO', '48528576848330752', NULL, '{\"SDI_CODE\":\"4\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"4\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"学生\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"SYS_OPERATOR_TYPE\",\"SDI_INNERCODE\":\"4\",\"ID\":\"48528576848330752\",\"SDT_ID\":\"3546057401171968\"}', '2018-08-06 14:09:03', 1);
INSERT INTO `sys_value_record` VALUES ('48528600583897088', '1', 'SYS_DICT_INFO', '48528600491622400', NULL, '{\"SDI_CODE\":\"5\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"5\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"教师\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"SYS_OPERATOR_TYPE\",\"SDI_INNERCODE\":\"5\",\"ID\":\"48528600491622400\",\"SDT_ID\":\"3546057401171968\"}', '2018-08-06 14:09:09', 1);
INSERT INTO `sys_value_record` VALUES ('48528662101753856', '1', 'SYS_DICT_INFO', '48528662064005120', NULL, '{\"SDI_CODE\":\"5\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"5\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"教师\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"SYS_ROLE_TYPE\",\"SDI_INNERCODE\":\"5\",\"ID\":\"48528662064005120\",\"SDT_ID\":\"7\"}', '2018-08-06 14:09:24', 1);
INSERT INTO `sys_value_record` VALUES ('48529046811705344', '1', 'SYS_OPERATOR_SUB', '48529046765568000', NULL, '{\"IS_STATUS\":1,\"SOS_CREATETIME\":\"2018-08-06 14:10:55\",\"SVR_TABLE_NAME\":\"SYS_OPERATOR_SUB\",\"SOS_REMARK\":\"\",\"SOS_DEFAULT\":0,\"SO_ID\":\"48303136200196097\",\"ID\":\"48529046765568000\",\"SOS_USERNAME\":\"devision_test2\"}', '2018-08-06 14:10:55', 1);
INSERT INTO `sys_value_record` VALUES ('48529571493969920', '1', 'SYS_OPERATOR_SUB', '48306353327833088', '{\"IS_STATUS\":1,\"SOS_REMARK\":\"\",\"SO_ID\":\"48303136200196097\",\"ID\":\"48306353327833088\",\"SOS_USERNAME\":\"devision_test\"}', '{\"SO_ID\":\"48303136200196097\",\"SOS_USERNAME\":\"dvision_test\",\"SOS_REMARK\":\"\",\"ID\":\"48306353327833088\"}', '2018-08-06 14:13:00', 2);
INSERT INTO `sys_value_record` VALUES ('48529584890576896', '1', 'SYS_OPERATOR_SUB', '48529046765568000', '{\"IS_STATUS\":1,\"SOS_REMARK\":\"\",\"SO_ID\":\"48303136200196097\",\"ID\":\"48529046765568000\",\"SOS_USERNAME\":\"devision_test2\"}', '{\"SO_ID\":\"48303136200196097\",\"SOS_USERNAME\":\"dvision_test2\",\"SOS_REMARK\":\"\",\"ID\":\"48529046765568000\"}', '2018-08-06 14:13:04', 2);
INSERT INTO `sys_value_record` VALUES ('48530555301527552', '1', 'SYS_OPERATOR_SUB', '48306353327833088', '{\"IS_STATUS\":1,\"SOS_REMARK\":\"\",\"SO_ID\":\"48303136200196097\",\"ID\":\"48306353327833088\",\"SOS_USERNAME\":\"dvision_test\"}', '{\"SO_ID\":\"48303136200196097\",\"SOS_USERNAME\":\"division_test\",\"SOS_REMARK\":\"\",\"ID\":\"48306353327833088\"}', '2018-08-06 14:16:55', 2);
INSERT INTO `sys_value_record` VALUES ('48530571013390336', '1', 'SYS_OPERATOR_SUB', '48529046765568000', '{\"IS_STATUS\":1,\"SOS_REMARK\":\"\",\"SO_ID\":\"48303136200196097\",\"ID\":\"48529046765568000\",\"SOS_USERNAME\":\"dvision_test2\"}', '{\"SO_ID\":\"48303136200196097\",\"SOS_USERNAME\":\"division_test2\",\"SOS_REMARK\":\"\",\"ID\":\"48529046765568000\"}', '2018-08-06 14:16:59', 2);
INSERT INTO `sys_value_record` VALUES ('48532244641349632', '1', 'SYS_ROLE', '48309996873580544', '{\"SR_CODE\":\"MANAGER_DIVISION\",\"IS_STATUS\":1,\"SR_EXPLAIN\":\"\",\"SR_NAME\":\"系部管理\",\"ID\":\"48309996873580544\",\"SR_REMARK\":\"\",\"SR_TYPE\":\"3\"}', '{\"SR_CODE\":\"MANAGER_DEPARTMENT\",\"SR_TYPE\":\"3\",\"SR_EXPLAIN\":\"\",\"SR_NAME\":\"系部管理\",\"ID\":\"48309996873580544\",\"SR_REMARK\":\"\"}', '2018-08-06 14:23:38', 2);
INSERT INTO `sys_value_record` VALUES ('48532256410566656', '1', 'SYS_ROLE', '48309528801837056', '{\"SR_CODE\":\"INSTRUCTOR\",\"IS_STATUS\":1,\"SR_EXPLAIN\":\"辅导员\",\"SR_NAME\":\"辅导员\",\"ID\":\"48309528801837056\",\"SR_REMARK\":\"\",\"SR_TYPE\":\"3\"}', '{\"SR_CODE\":\"INSTRUCTOR_DEPARTMENT\",\"SR_TYPE\":\"3\",\"SR_EXPLAIN\":\"辅导员\",\"SR_NAME\":\"辅导员\",\"ID\":\"48309528801837056\",\"SR_REMARK\":\"\"}', '2018-08-06 14:23:41', 2);
INSERT INTO `sys_value_record` VALUES ('48538502228344832', '1', 'SYS_CONFIGURE', '38163489528741889', '{\"SC_IS_PAGING\":\"1\",\"SC_NAME\":\"基础信息管理-系部管理\",\"SC_JSP\":\"admin/info/department/home\",\"SC_VIEW\":\"v_department\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"38163489528741889\",\"SC_ORDER_BY\":\"BD_ORDER ASC\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '{\"SC_NAME\":\"基础信息管理-系部管理\",\"SC_JSP\":\"admin/info/department/home\",\"SC_VIEW\":\"v_department\",\"SC_ORDER_BY\":\"BDM_ORDER ASC\",\"SC_IS_PAGING\":\"1\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"38163489528741889\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '2018-08-06 14:48:30', 2);
INSERT INTO `sys_value_record` VALUES ('48538671086829568', '1', 'SYS_DICT_TYPE', '48538671036497920', NULL, '{\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"SYS_DICT_TYPE\",\"SDT_CODE\":\"BUS_COLLEGE\",\"SDT_ROLE_DEL\":\"\",\"SDT_NAME\":\"业务_院系\",\"ID\":\"48538671036497920\",\"SDT_ROLE_DOWN\":\"\"}', '2018-08-06 14:49:10', 1);
INSERT INTO `sys_value_record` VALUES ('48538751458082816', '1', 'SYS_DICT_INFO', '48538751374196736', NULL, '{\"SDI_CODE\":\"1\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"1\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"福安教学点\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_COLLEGE\",\"SDI_INNERCODE\":\"1\",\"ID\":\"48538751374196736\",\"SDT_ID\":\"48538671036497920\"}', '2018-08-06 14:49:29', 1);
INSERT INTO `sys_value_record` VALUES ('48538794428727296', '1', 'SYS_DICT_INFO', '48538794378395648', NULL, '{\"SDI_CODE\":\"2\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"2\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"厦门教学点\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_COLLEGE\",\"SDI_INNERCODE\":\"2\",\"ID\":\"48538794378395648\",\"SDT_ID\":\"48538671036497920\"}', '2018-08-06 14:49:39', 1);
INSERT INTO `sys_value_record` VALUES ('48538826439655424', '1', 'SYS_DICT_INFO', '48538826380935168', NULL, '{\"SDI_CODE\":\"3\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"3\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"福州教学点\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_COLLEGE\",\"SDI_INNERCODE\":\"3\",\"ID\":\"48538826380935168\",\"SDT_ID\":\"48538671036497920\"}', '2018-08-06 14:49:47', 1);
INSERT INTO `sys_value_record` VALUES ('48539938970402816', '1', 'SYS_MENU', '38161659570683905', '{\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_ORDER\":30,\"SM_CODE\":\"INFO:DEPARTMENT\",\"SM_NAME\":\"系部管理\",\"SM_PARENTID\":\"38116041032728576\",\"SPD_ID\":\"\",\"ID\":\"38161659570683905\",\"SC_ID\":\"38163489528741888\",\"SM_CLASSICON\":\"mdi mdi-division\",\"SM_IS_EXPAND\":\"\"}', '{\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_ORDER\":\"30\",\"SM_CODE\":\"INFO:DEPARTMENT\",\"SM_NAME\":\"系部管理\",\"SM_PARENTID\":\"38116041032728576\",\"SPD_ID\":\"\",\"ID\":\"38161659570683905\",\"SC_ID\":\"38163489528741889\",\"SM_CLASSICON\":\"mdi mdi-division\",\"SM_IS_EXPAND\":\"\"}', '2018-08-06 14:54:12', 2);
INSERT INTO `sys_value_record` VALUES ('48539993227919360', '1', 'SYS_MENU', '48295058385928193', '{\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_ORDER\":40,\"SM_CODE\":\"INFO:DEPARTMENT_PERSONNEL\",\"SM_NAME\":\"系部人员管理\",\"SM_PARENTID\":\"38116041032728576\",\"SPD_ID\":\"\",\"ID\":\"48295058385928193\",\"SC_ID\":\"48293001511829504\",\"SM_CLASSICON\":\"mdi mdi-account-multiple\",\"SM_IS_EXPAND\":\"\"}', '{\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_ORDER\":\"40\",\"SM_CODE\":\"INFO:DEPARTMENT_PERSONNEL\",\"SM_NAME\":\"系部人员管理\",\"SM_PARENTID\":\"38116041032728576\",\"SPD_ID\":\"\",\"ID\":\"48295058385928193\",\"SC_ID\":\"48293001511829505\",\"SM_CLASSICON\":\"mdi mdi-account-multiple\",\"SM_IS_EXPAND\":\"\"}', '2018-08-06 14:54:25', 2);
INSERT INTO `sys_value_record` VALUES ('48601265348804608', '1', 'BUS_DEPARTMENT', '48601265252335616', NULL, '{\"BDM_ADDRESS\":\"123\",\"BDM_DESCRIBE\":\"123\",\"SVR_TABLE_NAME\":\"BUS_DEPARTMENT\",\"BDM_COLLEGE\":\"1\",\"BDM_NAME\":\"计算机系\",\"BDM_ORDER\":\"1\",\"BD_ENTER_TIME\":\"2018-08-06 18:57:54\",\"ID\":\"48601265252335616\"}', '2018-08-06 18:57:54', 1);
INSERT INTO `sys_value_record` VALUES ('48601652101382144', '1', 'SYS_OPERATOR', '48601651874889729', NULL, '{\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"SYS_OPERATOR\",\"SO_PASSWORD\":\"87fbc3c502b40a90e978465a49effe23\",\"ID\":\"48601651874889729\",\"SO_SALT\":\"-WECW3\"}', '2018-08-06 18:59:26', 1);
INSERT INTO `sys_value_record` VALUES ('48601652223016960', '1', 'SYS_ACCOUNT_INFO', '48601652139130880', NULL, '{\"SVR_TABLE_NAME\":\"SYS_ACCOUNT_INFO\",\"SAI_TYPE\":3,\"SO_ID\":\"48601651874889729\",\"SAI_NAME\":\"department_test\",\"ID\":\"48601652139130880\"}', '2018-08-06 18:59:26', 1);
INSERT INTO `sys_value_record` VALUES ('48601652327874560', '1', 'BUS_DEPARTMENT_PERSONNEL', '48601651874889728', NULL, '{\"BDMP_NAME\":\"department_test\",\"SVR_TABLE_NAME\":\"BUS_DEPARTMENT_PERSONNEL\",\"SO_ID\":\"48601651874889729\",\"ID\":\"48601651874889728\",\"BDM_ID\":\"48601265252335616\"}', '2018-08-06 18:59:26', 1);
INSERT INTO `sys_value_record` VALUES ('48602448754900992', '1', 'SYS_OPERATOR', '48601651874889729', '{\"IS_STATUS\":1,\"ID\":\"48601651874889729\"}', '{\"ID\":\"48601651874889729\"}', '2018-08-06 19:02:36', 2);
INSERT INTO `sys_value_record` VALUES ('48602665575251968', '1', 'SYS_OPERATOR_SUB', '48602665436839936', NULL, '{\"IS_STATUS\":1,\"SOS_CREATETIME\":\"2018-08-06 19:03:27\",\"SVR_TABLE_NAME\":\"SYS_OPERATOR_SUB\",\"SOS_REMARK\":\"\",\"SOS_DEFAULT\":1,\"SO_ID\":\"48601651874889729\",\"ID\":\"48602665436839936\",\"SOS_USERNAME\":\"department_test\"}', '2018-08-06 19:03:27', 1);
INSERT INTO `sys_value_record` VALUES ('48605817678594048', '1', 'SYS_DICT_TYPE', '48605817624068096', NULL, '{\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"SYS_DICT_TYPE\",\"SDT_CODE\":\"BUS_MAJOR\",\"SDT_ROLE_DEL\":\"\",\"SDT_NAME\":\"业务_专业\",\"ID\":\"48605817624068096\",\"SDT_ROLE_DOWN\":\"\"}', '2018-08-06 19:15:59', 1);
INSERT INTO `sys_value_record` VALUES ('48605894727958528', '1', 'SYS_DICT_INFO', '48605894635683840', NULL, '{\"SDI_CODE\":\"1\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"1\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"福安教学点\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_MAJOR\",\"SDI_INNERCODE\":\"1\",\"ID\":\"48605894635683840\",\"SDT_ID\":\"48605817624068096\"}', '2018-08-06 19:16:17', 1);
INSERT INTO `sys_value_record` VALUES ('48605957810290688', '1', 'SYS_DICT_INFO', '48605957755764736', NULL, '{\"SDI_CODE\":\"1\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"1\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"计算机应用\",\"SDI_PARENTID\":\"48605894635683840\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_MAJOR\",\"SDI_INNERCODE\":\"1.1\",\"ID\":\"48605957755764736\",\"SDT_ID\":\"48605817624068096\"}', '2018-08-06 19:16:32', 1);
INSERT INTO `sys_value_record` VALUES ('48606029725827072', '1', 'SYS_DICT_INFO', '48606029667106816', NULL, '{\"SDI_CODE\":\"2\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"2\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"计算机网络\",\"SDI_PARENTID\":\"48605894635683840\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_MAJOR\",\"SDI_INNERCODE\":\"1.2\",\"ID\":\"48606029667106816\",\"SDT_ID\":\"48605817624068096\"}', '2018-08-06 19:16:49', 1);
INSERT INTO `sys_value_record` VALUES ('48606661220237312', '1', 'SYS_DICT_INFO', '48606661161517056', NULL, '{\"SDI_CODE\":\"3\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"3\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"计算机多媒体\",\"SDI_PARENTID\":\"48605894635683840\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_MAJOR\",\"SDI_INNERCODE\":\"1.3\",\"ID\":\"48606661161517056\",\"SDT_ID\":\"48605817624068096\"}', '2018-08-06 19:19:20', 1);
INSERT INTO `sys_value_record` VALUES ('48606718665424896', '1', 'SYS_DICT_INFO', '48606718606704640', NULL, '{\"SDI_CODE\":\"3\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"3\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"福州教学点\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_MAJOR\",\"SDI_INNERCODE\":\"3\",\"ID\":\"48606718606704640\",\"SDT_ID\":\"48605817624068096\"}', '2018-08-06 19:19:34', 1);
INSERT INTO `sys_value_record` VALUES ('48606788571889664', '1', 'SYS_DICT_INFO', '48606788513169408', NULL, '{\"SDI_CODE\":\"2\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"2\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"厦门教学点\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_MAJOR\",\"SDI_INNERCODE\":\"2\",\"ID\":\"48606788513169408\",\"SDT_ID\":\"48605817624068096\"}', '2018-08-06 19:19:50', 1);
INSERT INTO `sys_value_record` VALUES ('48606866095210496', '1', 'SYS_DICT_INFO', '48606866032295936', NULL, '{\"SDI_CODE\":\"1\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"1\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"厦门1\",\"SDI_PARENTID\":\"48606788513169408\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_MAJOR\",\"SDI_INNERCODE\":\"2.1\",\"ID\":\"48606866032295936\",\"SDT_ID\":\"48605817624068096\"}', '2018-08-06 19:20:09', 1);
INSERT INTO `sys_value_record` VALUES ('48606944843268096', '1', 'SYS_DICT_INFO', '48606866032295936', '{\"SDI_CODE\":\"1\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_MAJOR\",\"SDI_REQUIRED\":0,\"SDI_INNERCODE\":\"2.1\",\"SDI_ORDER\":1,\"SDI_REMARK\":\"\",\"SDI_NAME\":\"厦门1\",\"ID\":\"48606866032295936\",\"SDI_PARENTID\":\"48606788513169408\",\"SDT_ID\":\"48605817624068096\"}', '{\"SDI_CODE\":\"1005\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"1\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"厦门1\",\"SDI_PARENTID\":\"0\",\"SDI_INNERCODE\":\"2.1\",\"ID\":\"48606866032295936\",\"SDT_ID\":\"48605817624068096\"}', '2018-08-06 19:20:28', 2);
INSERT INTO `sys_value_record` VALUES ('48606978259288064', '1', 'SYS_DICT_INFO', '48606866032295936', '{\"SDI_CODE\":\"1005\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_MAJOR\",\"SDI_REQUIRED\":0,\"SDI_INNERCODE\":\"2.1\",\"SDI_ORDER\":1,\"SDI_REMARK\":\"\",\"SDI_NAME\":\"厦门1\",\"ID\":\"48606866032295936\",\"SDI_PARENTID\":\"0\",\"SDT_ID\":\"48605817624068096\"}', '{\"SDI_CODE\":\"1005\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"1\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"厦门1\",\"SDI_PARENTID\":\"48606788513169408\",\"SDI_INNERCODE\":\"2.1\",\"ID\":\"48606866032295936\",\"SDT_ID\":\"48605817624068096\"}', '2018-08-06 19:20:36', 2);
INSERT INTO `sys_value_record` VALUES ('48607617395720192', '1', 'SYS_DICT_INFO', '48607617320222720', NULL, '{\"SDI_CODE\":\"3001\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"1\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"福州1\",\"SDI_PARENTID\":\"48606718606704640\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_MAJOR\",\"SDI_INNERCODE\":\"3.3001\",\"ID\":\"48607617320222720\",\"SDT_ID\":\"48605817624068096\"}', '2018-08-06 19:23:08', 1);
INSERT INTO `sys_value_record` VALUES ('48607634567200768', '1', 'SYS_DICT_INFO', '48606866032295936', '{\"SDI_CODE\":\"1005\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_MAJOR\",\"SDI_REQUIRED\":0,\"SDI_INNERCODE\":\"2.1\",\"SDI_ORDER\":1,\"SDI_REMARK\":\"\",\"SDI_NAME\":\"厦门1\",\"ID\":\"48606866032295936\",\"SDI_PARENTID\":\"48606788513169408\",\"SDT_ID\":\"48605817624068096\"}', '{\"SDI_CODE\":\"2005\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"1\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"厦门1\",\"SDI_PARENTID\":\"48606788513169408\",\"SDI_INNERCODE\":\"2.1\",\"ID\":\"48606866032295936\",\"SDT_ID\":\"48605817624068096\"}', '2018-08-06 19:23:12', 2);
INSERT INTO `sys_value_record` VALUES ('48607668100661248', '1', 'SYS_DICT_INFO', '48605957755764736', '{\"SDI_CODE\":\"1\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_MAJOR\",\"SDI_REQUIRED\":0,\"SDI_INNERCODE\":\"1.1\",\"SDI_ORDER\":1,\"SDI_REMARK\":\"\",\"SDI_NAME\":\"计算机应用\",\"ID\":\"48605957755764736\",\"SDI_PARENTID\":\"48605894635683840\",\"SDT_ID\":\"48605817624068096\"}', '{\"SDI_CODE\":\"1001\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"1\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"计算机应用\",\"SDI_PARENTID\":\"48605894635683840\",\"SDI_INNERCODE\":\"1.1001\",\"ID\":\"48605957755764736\",\"SDT_ID\":\"48605817624068096\"}', '2018-08-06 19:23:20', 2);
INSERT INTO `sys_value_record` VALUES ('48607701550235648', '1', 'SYS_DICT_INFO', '48606029667106816', '{\"SDI_CODE\":\"2\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_MAJOR\",\"SDI_REQUIRED\":0,\"SDI_INNERCODE\":\"1.2\",\"SDI_ORDER\":2,\"SDI_REMARK\":\"\",\"SDI_NAME\":\"计算机网络\",\"ID\":\"48606029667106816\",\"SDI_PARENTID\":\"48605894635683840\",\"SDT_ID\":\"48605817624068096\"}', '{\"SDI_CODE\":\"1002\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"2\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"计算机网络\",\"SDI_PARENTID\":\"48605894635683840\",\"SDI_INNERCODE\":\"1.1002\",\"ID\":\"48606029667106816\",\"SDT_ID\":\"48605817624068096\"}', '2018-08-06 19:23:28', 2);
INSERT INTO `sys_value_record` VALUES ('48607751793803264', '1', 'SYS_DICT_INFO', '48606661161517056', '{\"SDI_CODE\":\"3\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_MAJOR\",\"SDI_REQUIRED\":0,\"SDI_INNERCODE\":\"1.3\",\"SDI_ORDER\":3,\"SDI_REMARK\":\"\",\"SDI_NAME\":\"计算机多媒体\",\"ID\":\"48606661161517056\",\"SDI_PARENTID\":\"48605894635683840\",\"SDT_ID\":\"48605817624068096\"}', '{\"SDI_CODE\":\"1003\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"3\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"计算机多媒体\",\"SDI_PARENTID\":\"48605894635683840\",\"SDI_INNERCODE\":\"1.1003\",\"ID\":\"48606661161517056\",\"SDT_ID\":\"48605817624068096\"}', '2018-08-06 19:23:40', 2);
INSERT INTO `sys_value_record` VALUES ('48607761935630336', '1', 'SYS_DICT_INFO', '48605894635683840', '{\"IS_STATUS\":1,\"ID\":\"48605894635683840\"}', '{\"IS_STATUS\":\"0\",\"ID\":\"48605894635683840\"}', '2018-08-06 19:23:42', 2);
INSERT INTO `sys_value_record` VALUES ('48607778125643776', '1', 'SYS_DICT_INFO', '48606788513169408', '{\"IS_STATUS\":1,\"ID\":\"48606788513169408\"}', '{\"IS_STATUS\":\"0\",\"ID\":\"48606788513169408\"}', '2018-08-06 19:23:46', 2);
INSERT INTO `sys_value_record` VALUES ('48607787017568256', '1', 'SYS_DICT_INFO', '48606718606704640', '{\"IS_STATUS\":1,\"ID\":\"48606718606704640\"}', '{\"IS_STATUS\":\"0\",\"ID\":\"48606718606704640\"}', '2018-08-06 19:23:48', 2);
INSERT INTO `sys_value_record` VALUES ('48612440119705600', '1', 'SYS_CONFIGURE', '48612439985487872', NULL, '{\"SC_IS_PAGING\":\"1\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE\",\"SC_NAME\":\"基础信息管理-班级管理\",\"SC_JSP\":\"1\",\"SC_VIEW\":\"v_class\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"48612439985487872\",\"SC_ORDER_BY\":\"\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"0\"}', '2018-08-06 19:42:18', 1);
INSERT INTO `sys_value_record` VALUES ('48612487053967360', '1', 'SYS_CONFIGURE', '48612439985487872', '{\"SC_IS_PAGING\":\"1\",\"SC_NAME\":\"基础信息管理-班级管理\",\"SC_JSP\":\"1\",\"SC_VIEW\":\"v_class\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"48612439985487872\",\"SC_ORDER_BY\":\"\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"0\"}', '{\"SC_NAME\":\"基础信息管理-班级管理\",\"SC_JSP\":\"admin/info/class/home\",\"SC_VIEW\":\"v_class\",\"SC_ORDER_BY\":\"\",\"SC_IS_PAGING\":\"1\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"48612439985487872\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"0\"}', '2018-08-06 19:42:29', 2);
INSERT INTO `sys_value_record` VALUES ('48612516334403584', '1', 'SYS_CONFIGURE', '48612439985487872', '{\"SC_IS_PAGING\":\"1\",\"SC_NAME\":\"基础信息管理-班级管理\",\"SC_JSP\":\"admin/info/class/home\",\"SC_VIEW\":\"v_class\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"48612439985487872\",\"SC_ORDER_BY\":\"\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"0\"}', '{\"SC_NAME\":\"基础信息管理-班级管理\",\"SC_JSP\":\"admin/info/class/home\",\"SC_VIEW\":\"v_class\",\"SC_ORDER_BY\":\"CONVERT(ID,SIGNED) DESC\",\"SC_IS_PAGING\":\"1\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"48612439985487872\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"0\"}', '2018-08-06 19:42:36', 2);
INSERT INTO `sys_value_record` VALUES ('48612785986207744', '1', 'SYS_CONFIGURE_COLUMN', '48612785872961536', NULL, '{\"SCC_NAME\":\"班级名称\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"left\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"200px\",\"SCC_FIELD\":\"BC_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48612785872961536\",\"SC_ID\":\"48612439985487872\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"1\"}', '2018-08-06 19:43:40', 1);
INSERT INTO `sys_value_record` VALUES ('48613108700151808', '1', 'SYS_CONFIGURE_COLUMN', '48613108662403072', NULL, '{\"SCC_NAME\":\"系部名称\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"left\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"200px\",\"SCC_FIELD\":\"BDM_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48613108662403072\",\"SC_ID\":\"48612439985487872\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"20\"}', '2018-08-06 19:44:57', 1);
INSERT INTO `sys_value_record` VALUES ('48613188916215808', '1', 'SYS_CONFIGURE_COLUMN', '48613188865884160', NULL, '{\"SCC_NAME\":\"年度\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"70px\",\"SCC_FIELD\":\"BC_YEAR\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48613188865884160\",\"SC_ID\":\"48612439985487872\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"30\"}', '2018-08-06 19:45:16', 1);
INSERT INTO `sys_value_record` VALUES ('48613280071024640', '1', 'SYS_CONFIGURE_COLUMN', '48613280037470208', NULL, '{\"SCC_NAME\":\"专业\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"left\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"150px\",\"SCC_FIELD\":\"BC_MAJOR_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48613280037470208\",\"SC_ID\":\"48612439985487872\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"25\"}', '2018-08-06 19:45:38', 1);
INSERT INTO `sys_value_record` VALUES ('48613355434278912', '1', 'SYS_CONFIGURE_COLUMN', '48613355400724480', NULL, '{\"SCC_NAME\":\"操作\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"1\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"150px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48613355400724480\",\"SC_ID\":\"48612439985487872\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"40\"}', '2018-08-06 19:45:56', 1);
INSERT INTO `sys_value_record` VALUES ('48613435142832128', '1', 'SYS_CONFIGURE_SEARCH', '48613435075723264', NULL, '{\"SCS_METHOD_TYPE\":\"4\",\"SCS_TYPE\":\"1\",\"SCS_FIELD\":\"BC_NAME\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_SEARCH\",\"SCS_NAME\":\"班级名称\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"48613435075723264\",\"SC_ID\":\"48612439985487872\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":\"1\"}', '2018-08-06 19:46:15', 1);
INSERT INTO `sys_value_record` VALUES ('48613477136203776', '1', 'SYS_CONFIGURE_SEARCH', '48613477098455040', NULL, '{\"SCS_METHOD_TYPE\":\"4\",\"SCS_TYPE\":\"1\",\"SCS_FIELD\":\"BDM_NAME\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_SEARCH\",\"SCS_NAME\":\"系部名称\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"48613477098455040\",\"SC_ID\":\"48612439985487872\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":\"20\"}', '2018-08-06 19:46:25', 1);
INSERT INTO `sys_value_record` VALUES ('48613546811981824', '1', 'SYS_CONFIGURE_SEARCH', '48613546774233088', NULL, '{\"SCS_METHOD_TYPE\":\"1\",\"SCS_TYPE\":\"2\",\"SCS_FIELD\":\"BC_MAJOR\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_SEARCH\",\"SCS_NAME\":\"专业\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"48613546774233088\",\"SC_ID\":\"48612439985487872\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":\"30\"}', '2018-08-06 19:46:42', 1);
INSERT INTO `sys_value_record` VALUES ('48613600545210368', '1', 'SYS_CONFIGURE_SEARCH', '48613546774233088', '{\"SCS_METHOD_TYPE\":\"1\",\"SCS_TYPE\":\"2\",\"SCS_FIELD\":\"BC_MAJOR\",\"SCS_NAME\":\"专业\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"48613546774233088\",\"SC_ID\":\"48612439985487872\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":30}', '{\"SCS_FIELD\":\"BC_MAJOR\",\"SCS_NAME\":\"专业\",\"SCS_SDT_CODE\":\"BUS_MAJOR\",\"SCS_ORDER\":\"30\",\"SCS_METHOD_TYPE\":\"1\",\"SCS_TYPE\":\"2\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"48613546774233088\",\"SC_ID\":\"48612439985487872\",\"SCS_REMARK\":\"\"}', '2018-08-06 19:46:54', 2);
INSERT INTO `sys_value_record` VALUES ('48614104352423936', '1', 'SYS_MENU', '48614104260149248', NULL, '{\"SM_URL\":\"admin/dataGrid/\",\"SVR_TABLE_NAME\":\"SYS_MENU\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":\"50\",\"SM_CODE\":\"INFO:CLASS\",\"SM_NAME\":\"班级管理\",\"SM_PARENTID\":\"38116041032728576\",\"SPD_ID\":\"\",\"ID\":\"48614104260149248\",\"SC_ID\":\"48612439985487872\",\"SM_CLASSICON\":\"mdi mdi-desktop-classic\",\"SM_IS_EXPAND\":\"\"}', '2018-08-06 19:48:55', 1);
INSERT INTO `sys_value_record` VALUES ('48614229921497088', '1', 'SYS_MENU', '48614229862776832', NULL, '{\"SM_URL\":\"\",\"SVR_TABLE_NAME\":\"SYS_MENU\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":\"1\",\"SM_CODE\":\"INFO:CLASS_UPDATE\",\"SM_NAME\":\"编辑\",\"SM_PARENTID\":\"48614104260149248\",\"SPD_ID\":\"\",\"ID\":\"48614229862776832\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '2018-08-06 19:49:25', 1);
INSERT INTO `sys_value_record` VALUES ('48648875610734592', '1', 'SYS_VALIDATE', '48648875514265600', NULL, '{\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"SYS_VALIDATE\",\"ID\":\"48648875514265600\",\"SV_TABLE\":\"BUS_DEPARTMENT\"}', '2018-08-06 22:07:05', 1);
INSERT INTO `sys_value_record` VALUES ('48648959509397504', '1', 'sys_validate_field', '48648959358402560', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"100\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"48648959358402560\",\"SVF_NAME\":\"系部名称\",\"SVF_FIELD\":\"BDM_NAME\",\"SV_ID\":\"48648875514265600\",\"SVR_ID\":\"\"}', '2018-08-06 22:07:25', 1);
INSERT INTO `sys_value_record` VALUES ('48649001741844480', '1', 'sys_validate_field', '48649001662152704', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"48649001662152704\",\"SVF_NAME\":\"所属院系\",\"SVF_FIELD\":\"BDM_COLLEGE\",\"SV_ID\":\"48648875514265600\",\"SVR_ID\":\"\"}', '2018-08-06 22:07:35', 1);
INSERT INTO `sys_value_record` VALUES ('48649059598073856', '1', 'sys_validate_field', '48649059505799168', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"5\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"48649059505799168\",\"SVF_NAME\":\"排序\",\"SVF_FIELD\":\"BDM_ORDER\",\"SV_ID\":\"48648875514265600\",\"SVR_ID\":\"2510375538917376\"}', '2018-08-06 22:07:49', 1);
INSERT INTO `sys_value_record` VALUES ('48649104066084864', '1', 'SYS_VALIDATE', '48649104007364608', NULL, '{\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"SYS_VALIDATE\",\"ID\":\"48649104007364608\",\"SV_TABLE\":\"BUS_DEPARTMENT_PERSONNEL\"}', '2018-08-06 22:07:59', 1);
INSERT INTO `sys_value_record` VALUES ('48649161100230656', '1', 'sys_validate_field', '48649161037316096', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"100\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"48649161037316096\",\"SVF_NAME\":\"人员名称\",\"SVF_FIELD\":\"BDMP_NAME\",\"SV_ID\":\"48649104007364608\",\"SVR_ID\":\"\"}', '2018-08-06 22:08:13', 1);
INSERT INTO `sys_value_record` VALUES ('48649207728308224', '1', 'sys_validate_field', '48649207644422144', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"48649207644422144\",\"SVF_NAME\":\"所属系部\",\"SVF_FIELD\":\"BDM_ID\",\"SV_ID\":\"48649104007364608\",\"SVR_ID\":\"\"}', '2018-08-06 22:08:24', 1);
INSERT INTO `sys_value_record` VALUES ('48649234135646208', '1', 'SYS_VALIDATE', '48649234076925952', NULL, '{\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"SYS_VALIDATE\",\"ID\":\"48649234076925952\",\"SV_TABLE\":\"BUS_CLASS\"}', '2018-08-06 22:08:30', 1);
INSERT INTO `sys_value_record` VALUES ('48649304398626816', '1', 'sys_validate_field', '48649304281186304', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"100\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"48649304281186304\",\"SVF_NAME\":\"班级名称\",\"SVF_FIELD\":\"BC_NAME\",\"SV_ID\":\"48649234076925952\",\"SVR_ID\":\"\"}', '2018-08-06 22:08:47', 1);
INSERT INTO `sys_value_record` VALUES ('48649365849374720', '1', 'sys_validate_field', '48649365794848768', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"48649365794848768\",\"SVF_NAME\":\"所属系部\",\"SVF_FIELD\":\"BDM_ID\",\"SV_ID\":\"48649234076925952\",\"SVR_ID\":\"\"}', '2018-08-06 22:09:02', 1);
INSERT INTO `sys_value_record` VALUES ('48649402511785984', '1', 'sys_validate_field', '48649402457260032', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"48649402457260032\",\"SVF_NAME\":\"专业\",\"SVF_FIELD\":\"BC_MAJOR\",\"SV_ID\":\"48649234076925952\",\"SVR_ID\":\"\"}', '2018-08-06 22:09:10', 1);
INSERT INTO `sys_value_record` VALUES ('48649475614310400', '1', 'sys_validate_field', '48649475563978752', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"48649475563978752\",\"SVF_NAME\":\"年段\",\"SVF_FIELD\":\"BC_YEAR\",\"SV_ID\":\"48649234076925952\",\"SVR_ID\":\"26504926733533184\"}', '2018-08-06 22:09:28', 1);
INSERT INTO `sys_value_record` VALUES ('48656602546307072', '1', 'BUS_CLASS', '48656602449838080', NULL, '{\"SVR_TABLE_NAME\":\"BUS_CLASS\",\"BC_ENTRY_TIME\":\"2018-08-06 22:37:47\",\"BC_NAME\":\"18多媒体\",\"ID\":\"48656602449838080\",\"BC_MAJOR\":\"1002\",\"BDM_ID\":\"48601265252335616\",\"BC_YEAR\":\"2018\"}', '2018-08-06 22:37:47', 1);
INSERT INTO `sys_value_record` VALUES ('48656689821384704', '1', 'SYS_CONFIGURE_COLUMN', '48613355400724480', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"1\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"150px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48613355400724480\",\"SC_ID\":\"48612439985487872\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":40}', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"1\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"150px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"48613355400724480\",\"SC_ID\":\"48612439985487872\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"40\"}', '2018-08-06 22:38:08', 2);
INSERT INTO `sys_value_record` VALUES ('48656767025938432', '1', 'SYS_CONFIGURE_COLUMN', '48613355400724480', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"1\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"150px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"48613355400724480\",\"SC_ID\":\"48612439985487872\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":40}', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"0\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"150px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"48613355400724480\",\"SC_ID\":\"48612439985487872\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"40\"}', '2018-08-06 22:38:26', 2);
INSERT INTO `sys_value_record` VALUES ('48666240851378176', '1', 'SYS_VALIDATE', '48666240763297792', NULL, '{\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"SYS_VALIDATE\",\"ID\":\"48666240763297792\",\"SV_TABLE\":\"BUS_TEACHER\"}', '2018-08-06 23:16:05', 1);
INSERT INTO `sys_value_record` VALUES ('48666310837534720', '1', 'sys_validate_field', '48666310791397376', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"50\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"48666310791397376\",\"SVF_NAME\":\"教师名称\",\"SVF_FIELD\":\"BT_NAME\",\"SV_ID\":\"48666240763297792\",\"SVR_ID\":\"\"}', '2018-08-06 23:16:22', 1);
INSERT INTO `sys_value_record` VALUES ('48666379804475392', '1', 'sys_validate_field', '48666379737366528', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"48666379737366528\",\"SVF_NAME\":\"系部\",\"SVF_FIELD\":\"BDM_ID\",\"SV_ID\":\"48666240763297792\",\"SVR_ID\":\"\"}', '2018-08-06 23:16:38', 1);
INSERT INTO `sys_value_record` VALUES ('48666419499368448', '1', 'sys_validate_field', '48666419453231104', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"50\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"48666419453231104\",\"SVF_NAME\":\"工号\",\"SVF_FIELD\":\"BT_NUMBER\",\"SV_ID\":\"48666240763297792\",\"SVR_ID\":\"\"}', '2018-08-06 23:16:48', 1);
INSERT INTO `sys_value_record` VALUES ('48666703340503040', '1', 'SYS_CONFIGURE', '48666703227256832', NULL, '{\"SC_IS_PAGING\":\"1\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE\",\"SC_NAME\":\"基础信息管理-教师管理\",\"SC_JSP\":\"1\",\"SC_VIEW\":\"v_teacher\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"48666703227256832\",\"SC_ORDER_BY\":\"\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '2018-08-06 23:17:55', 1);
INSERT INTO `sys_value_record` VALUES ('48666753638596608', '1', 'SYS_CONFIGURE', '48666703227256832', '{\"SC_IS_PAGING\":\"1\",\"SC_NAME\":\"基础信息管理-教师管理\",\"SC_JSP\":\"1\",\"SC_VIEW\":\"v_teacher\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"48666703227256832\",\"SC_ORDER_BY\":\"\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '{\"SC_NAME\":\"基础信息管理-教师管理\",\"SC_JSP\":\"admin/info/teacher/home\",\"SC_VIEW\":\"v_teacher\",\"SC_ORDER_BY\":\"\",\"SC_IS_PAGING\":\"1\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"48666703227256832\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '2018-08-06 23:18:07', 2);
INSERT INTO `sys_value_record` VALUES ('48666781732044800', '1', 'SYS_CONFIGURE', '48666703227256832', '{\"SC_IS_PAGING\":\"1\",\"SC_NAME\":\"基础信息管理-教师管理\",\"SC_JSP\":\"admin/info/teacher/home\",\"SC_VIEW\":\"v_teacher\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"48666703227256832\",\"SC_ORDER_BY\":\"\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '{\"SC_NAME\":\"基础信息管理-教师管理\",\"SC_JSP\":\"admin/info/teacher/home\",\"SC_VIEW\":\"v_teacher\",\"SC_ORDER_BY\":\"CONVERT(ID,SIGNED) DESC\",\"SC_IS_PAGING\":\"1\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"48666703227256832\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '2018-08-06 23:18:14', 2);
INSERT INTO `sys_value_record` VALUES ('48666874761707520', '1', 'SYS_CONFIGURE_COLUMN', '48666874698792960', NULL, '{\"SCC_NAME\":\"名称\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"150px\",\"SCC_FIELD\":\"BT_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48666874698792960\",\"SC_ID\":\"48666703227256832\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"1\"}', '2018-08-06 23:18:36', 1);
INSERT INTO `sys_value_record` VALUES ('48666968152080384', '1', 'SYS_CONFIGURE_COLUMN', '48666968101748736', NULL, '{\"SCC_NAME\":\"所属系部\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"left\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"200px\",\"SCC_FIELD\":\"BDM_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48666968101748736\",\"SC_ID\":\"48666703227256832\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"20\"}', '2018-08-06 23:18:58', 1);
INSERT INTO `sys_value_record` VALUES ('48667014092292096', '1', 'SYS_CONFIGURE_COLUMN', '48667014041960448', NULL, '{\"SCC_NAME\":\"工号\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"150px\",\"SCC_FIELD\":\"BT_NUMBER\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48667014041960448\",\"SC_ID\":\"48666703227256832\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"30\"}', '2018-08-06 23:19:09', 1);
INSERT INTO `sys_value_record` VALUES ('48667074272165888', '1', 'SYS_CONFIGURE_COLUMN', '48667074221834240', NULL, '{\"SCC_NAME\":\"操作\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"150px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"48667074221834240\",\"SC_ID\":\"48666703227256832\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"40\"}', '2018-08-06 23:19:24', 1);
INSERT INTO `sys_value_record` VALUES ('48667188298514432', '1', 'SYS_CONFIGURE_SEARCH', '48667188210434048', NULL, '{\"SCS_METHOD_TYPE\":\"4\",\"SCS_TYPE\":\"1\",\"SCS_FIELD\":\"BT_NAME\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_SEARCH\",\"SCS_NAME\":\"教师名称\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"48667188210434048\",\"SC_ID\":\"48666703227256832\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":\"1\"}', '2018-08-06 23:19:51', 1);
INSERT INTO `sys_value_record` VALUES ('48667250684592128', '1', 'SYS_CONFIGURE_SEARCH', '48667250646843392', NULL, '{\"SCS_METHOD_TYPE\":\"4\",\"SCS_TYPE\":\"1\",\"SCS_FIELD\":\"BDM_NAME\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_SEARCH\",\"SCS_NAME\":\"所属系部\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"48667250646843392\",\"SC_ID\":\"48666703227256832\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":\"20\"}', '2018-08-06 23:20:06', 1);
INSERT INTO `sys_value_record` VALUES ('48667292501803008', '1', 'SYS_CONFIGURE_SEARCH', '48667292443082752', NULL, '{\"SCS_METHOD_TYPE\":\"4\",\"SCS_TYPE\":\"1\",\"SCS_FIELD\":\"BT_NUMBER\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_SEARCH\",\"SCS_NAME\":\"工号\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"48667292443082752\",\"SC_ID\":\"48666703227256832\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":\"30\"}', '2018-08-06 23:20:16', 1);
INSERT INTO `sys_value_record` VALUES ('48667624514519040', '1', 'SYS_MENU', '48667624430632960', NULL, '{\"SM_URL\":\"admin/dataGrid/\",\"SVR_TABLE_NAME\":\"SYS_MENU\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":\"60\",\"SM_CODE\":\"INFO:TEACHER\",\"SM_NAME\":\"教师管理\",\"SM_PARENTID\":\"0\",\"SPD_ID\":\"\",\"ID\":\"48667624430632960\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-school\",\"SM_IS_EXPAND\":\"\"}', '2018-08-06 23:21:35', 1);
INSERT INTO `sys_value_record` VALUES ('48667733063106560', '1', 'SYS_MENU', '48667624430632960', '{\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_ORDER\":60,\"SM_CODE\":\"INFO:TEACHER\",\"SM_NAME\":\"教师管理\",\"SM_PARENTID\":\"0\",\"SPD_ID\":\"\",\"ID\":\"48667624430632960\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-school\",\"SM_IS_EXPAND\":\"\"}', '{\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_ORDER\":\"60\",\"SM_CODE\":\"INFO:TEACHER\",\"SM_NAME\":\"教师管理\",\"SM_PARENTID\":\"0\",\"SPD_ID\":\"\",\"ID\":\"48667624430632960\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-school\",\"SM_IS_EXPAND\":\"\"}', '2018-08-06 23:22:01', 2);
INSERT INTO `sys_value_record` VALUES ('48673683329253376', '1', 'SYS_MENU', '48667624430632960', '{\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_ORDER\":60,\"SM_CODE\":\"INFO:TEACHER\",\"SM_NAME\":\"教师管理\",\"SM_PARENTID\":\"0\",\"SPD_ID\":\"\",\"ID\":\"48667624430632960\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-school\",\"SM_IS_EXPAND\":\"\"}', '{\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_ORDER\":\"60\",\"SM_CODE\":\"INFO:TEACHER\",\"SM_NAME\":\"教师管理\",\"SM_PARENTID\":\"38116041032728576\",\"SPD_ID\":\"\",\"ID\":\"48667624430632960\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-school\",\"SM_IS_EXPAND\":\"\"}', '2018-08-06 23:45:39', 2);
INSERT INTO `sys_value_record` VALUES ('48673777348771840', '1', 'SYS_MENU', '48673777285857280', NULL, '{\"SM_URL\":\"\",\"SVR_TABLE_NAME\":\"SYS_MENU\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":\"1\",\"SM_CODE\":\"INFO:TEACHER_UPDATE\",\"SM_NAME\":\"编辑\",\"SM_PARENTID\":\"48667624430632960\",\"SPD_ID\":\"\",\"ID\":\"48673777285857280\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '2018-08-06 23:46:02', 1);
INSERT INTO `sys_value_record` VALUES ('48675372782321664', '1', 'SYS_MENU', '48667624430632960', '{\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_ORDER\":60,\"SM_CODE\":\"INFO:TEACHER\",\"SM_NAME\":\"教师管理\",\"SM_PARENTID\":\"38116041032728576\",\"SPD_ID\":\"\",\"ID\":\"48667624430632960\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-school\",\"SM_IS_EXPAND\":\"\"}', '{\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_ORDER\":\"60\",\"SM_CODE\":\"INFO:TEACHER\",\"SM_NAME\":\"教师管理\",\"SM_PARENTID\":\"38116041032728576\",\"SPD_ID\":\"\",\"ID\":\"48667624430632960\",\"SC_ID\":\"48666703227256832\",\"SM_CLASSICON\":\"mdi mdi-school\",\"SM_IS_EXPAND\":\"\"}', '2018-08-06 23:52:22', 2);
INSERT INTO `sys_value_record` VALUES ('48678120298905600', '1', 'SYS_CONFIGURE_COLUMN', '48667074221834240', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"150px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"48667074221834240\",\"SC_ID\":\"48666703227256832\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":40}', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"350px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"48667074221834240\",\"SC_ID\":\"48666703227256832\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"40\"}', '2018-08-07 00:03:17', 2);
INSERT INTO `sys_value_record` VALUES ('48678180776574976', '1', 'SYS_CONFIGURE_COLUMN', '48667074221834240', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"350px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"48667074221834240\",\"SC_ID\":\"48666703227256832\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":40}', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"400px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"48667074221834240\",\"SC_ID\":\"48666703227256832\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"40\"}', '2018-08-07 00:03:32', 2);
INSERT INTO `sys_value_record` VALUES ('48678292508639232', '1', 'SYS_ROLE', '48678292462501888', NULL, '{\"SR_CODE\":\"TEACHER\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"SYS_ROLE\",\"SR_EXPLAIN\":\"\",\"SR_NAME\":\"教师\",\"ID\":\"48678292462501888\",\"SR_REMARK\":\"\",\"SR_TYPE\":\"5\"}', '2018-08-07 00:03:58', 1);
INSERT INTO `sys_value_record` VALUES ('48679555791060992', '1', 'SYS_OPERATOR', '48679555707174913', NULL, '{\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"SYS_OPERATOR\",\"SO_PASSWORD\":\"bcac1195eef6ce7ce8f45425580bdf41\",\"ID\":\"48679555707174913\",\"SO_SALT\":\"fW.Ydv\"}', '2018-08-07 00:08:59', 1);
INSERT INTO `sys_value_record` VALUES ('48679555862364160', '1', 'SYS_ACCOUNT_INFO', '48679555824615424', NULL, '{\"SVR_TABLE_NAME\":\"SYS_ACCOUNT_INFO\",\"SAI_TYPE\":5,\"SO_ID\":\"48679555707174913\",\"SAI_NAME\":\"teacher_test\",\"ID\":\"48679555824615424\"}', '2018-08-07 00:08:59', 1);
INSERT INTO `sys_value_record` VALUES ('48679555933667328', '1', 'BUS_TEACHER', '48679555707174912', NULL, '{\"SVR_TABLE_NAME\":\"BUS_TEACHER\",\"BT_NUMBER\":\"t12345\",\"SO_ID\":\"48679555707174913\",\"BT_NAME\":\"teacher_test\",\"ID\":\"48679555707174912\",\"BDM_ID\":\"48601265252335616\",\"BT_ENTRY_TIME\":\"2018-08-07 00:08:59\"}', '2018-08-07 00:08:59', 1);
INSERT INTO `sys_value_record` VALUES ('48680578312044544', '1', 'SYS_CONFIGURE', '48612439985487872', '{\"SC_IS_PAGING\":\"1\",\"SC_NAME\":\"基础信息管理-班级管理\",\"SC_JSP\":\"admin/info/class/home\",\"SC_VIEW\":\"v_class\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"48612439985487872\",\"SC_ORDER_BY\":\"CONVERT(ID,SIGNED) DESC\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"0\"}', '{\"SC_NAME\":\"基础信息管理-班级管理\",\"SC_JSP\":\"admin/info/cls/home\",\"SC_VIEW\":\"v_class\",\"SC_ORDER_BY\":\"CONVERT(ID,SIGNED) DESC\",\"SC_IS_PAGING\":\"1\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"48612439985487872\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"0\"}', '2018-08-07 00:13:03', 2);
INSERT INTO `sys_value_record` VALUES ('48682022964559872', '1', 'SYS_OPERATOR', '48679555707174913', '{\"IS_STATUS\":1,\"ID\":\"48679555707174913\"}', '{\"ID\":\"48679555707174913\"}', '2018-08-07 00:18:48', 2);
INSERT INTO `sys_value_record` VALUES ('48682071673012224', '1', 'SYS_OPERATOR_SUB', '48682071438131200', NULL, '{\"IS_STATUS\":1,\"SOS_CREATETIME\":\"2018-08-07 00:18:59\",\"SVR_TABLE_NAME\":\"SYS_OPERATOR_SUB\",\"SOS_REMARK\":\"\",\"SOS_DEFAULT\":1,\"SO_ID\":\"48679555707174913\",\"ID\":\"48682071438131200\",\"SOS_USERNAME\":\"teacher_test\"}', '2018-08-07 00:18:59', 1);
INSERT INTO `sys_value_record` VALUES ('48886454050357248', '1', 'SYS_VALIDATE', '48886453991636992', NULL, '{\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"SYS_VALIDATE\",\"ID\":\"48886453991636992\",\"SV_TABLE\":\"BUS_STUDENT\"}', '2018-08-07 13:51:08', 1);
INSERT INTO `sys_value_record` VALUES ('48886545066754048', '1', 'sys_validate_field', '48886544924147712', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"48886544924147712\",\"SVF_NAME\":\"系部\",\"SVF_FIELD\":\"BDM_ID\",\"SV_ID\":\"48886453991636992\",\"SVR_ID\":\"\"}', '2018-08-07 13:51:30', 1);
INSERT INTO `sys_value_record` VALUES ('48886576591142912', '1', 'sys_validate_field', '48886576482091008', NULL, '{\"SVF_IS_REQUIRED\":\"0\",\"SVF_MAX_LENGTH\":\"\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"48886576482091008\",\"SVF_NAME\":\"班级\",\"SVF_FIELD\":\"BC_ID\",\"SV_ID\":\"48886453991636992\",\"SVR_ID\":\"\"}', '2018-08-07 13:51:37', 1);
INSERT INTO `sys_value_record` VALUES ('48886613568126976', '1', 'sys_validate_field', '48886613513601024', NULL, '{\"SVF_IS_REQUIRED\":\"0\",\"SVF_MAX_LENGTH\":\"50\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"48886613513601024\",\"SVF_NAME\":\"姓名\",\"SVF_FIELD\":\"BS_NAME\",\"SV_ID\":\"48886453991636992\",\"SVR_ID\":\"\"}', '2018-08-07 13:51:46', 1);
INSERT INTO `sys_value_record` VALUES ('48886627887480832', '1', 'sys_validate_field', '48886613513601024', '{\"SVF_IS_REQUIRED\":\"0\",\"SVF_MAX_LENGTH\":\"50\",\"IS_STATUS\":1,\"SVF_MIN_LENGTH\":\"\",\"ID\":\"48886613513601024\",\"SVF_NAME\":\"姓名\",\"SVF_FIELD\":\"BS_NAME\",\"SV_ID\":\"48886453991636992\",\"SVR_ID\":\"\"}', '{\"SVF_MIN_LENGTH\":\"\",\"SVF_NAME\":\"姓名\",\"SV_ID\":\"48886453991636992\",\"SVR_ID\":\"\",\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"50\",\"ID\":\"48886613513601024\",\"SVF_FIELD\":\"BS_NAME\"}', '2018-08-07 13:51:49', 2);
INSERT INTO `sys_value_record` VALUES ('48886640264871936', '1', 'sys_validate_field', '48886576482091008', '{\"SVF_IS_REQUIRED\":\"0\",\"SVF_MAX_LENGTH\":\"\",\"IS_STATUS\":1,\"SVF_MIN_LENGTH\":\"\",\"ID\":\"48886576482091008\",\"SVF_NAME\":\"班级\",\"SVF_FIELD\":\"BC_ID\",\"SV_ID\":\"48886453991636992\",\"SVR_ID\":\"\"}', '{\"SVF_MIN_LENGTH\":\"\",\"SVF_NAME\":\"班级\",\"SV_ID\":\"48886453991636992\",\"SVR_ID\":\"\",\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"\",\"ID\":\"48886576482091008\",\"SVF_FIELD\":\"BC_ID\"}', '2018-08-07 13:51:52', 2);
INSERT INTO `sys_value_record` VALUES ('48886698196598784', '1', 'sys_validate_field', '48886698154655744', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"30\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"48886698154655744\",\"SVF_NAME\":\"学号\",\"SVF_FIELD\":\"BS_NUMBER\",\"SV_ID\":\"48886453991636992\",\"SVR_ID\":\"2510375538917376\"}', '2018-08-07 13:52:06', 1);
INSERT INTO `sys_value_record` VALUES ('48886822826147840', '1', 'sys_validate_field', '48886822763233280', NULL, '{\"SVF_IS_REQUIRED\":\"0\",\"SVF_MAX_LENGTH\":\"1\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"48886822763233280\",\"SVF_NAME\":\"学制\",\"SVF_FIELD\":\"BS_LENGTH\",\"SV_ID\":\"48886453991636992\",\"SVR_ID\":\"\"}', '2018-08-07 13:52:36', 1);
INSERT INTO `sys_value_record` VALUES ('48886877792501760', '1', 'sys_validate_field', '48886877721198592', NULL, '{\"SVF_IS_REQUIRED\":\"0\",\"SVF_MAX_LENGTH\":\"4\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"48886877721198592\",\"SVF_NAME\":\"入学年度\",\"SVF_FIELD\":\"BS_ENROLMENT_YEAR\",\"SV_ID\":\"48886453991636992\",\"SVR_ID\":\"26504926733533184\"}', '2018-08-07 13:52:49', 1);
INSERT INTO `sys_value_record` VALUES ('48886896264216576', '1', 'sys_validate_field', '48886877721198592', '{\"SVF_IS_REQUIRED\":\"0\",\"SVF_MAX_LENGTH\":\"4\",\"IS_STATUS\":1,\"SVF_MIN_LENGTH\":\"\",\"ID\":\"48886877721198592\",\"SVF_NAME\":\"入学年度\",\"SVF_FIELD\":\"BS_ENROLMENT_YEAR\",\"SV_ID\":\"48886453991636992\",\"SVR_ID\":\"26504926733533184\"}', '{\"SVF_MIN_LENGTH\":\"\",\"SVF_NAME\":\"入学年度\",\"SV_ID\":\"48886453991636992\",\"SVR_ID\":\"26504926733533184\",\"SVF_IS_REQUIRED\":\"0\",\"SVF_MAX_LENGTH\":\"\",\"ID\":\"48886877721198592\",\"SVF_FIELD\":\"BS_ENROLMENT_YEAR\"}', '2018-08-07 13:52:53', 2);
INSERT INTO `sys_value_record` VALUES ('48886947606691840', '1', 'sys_validate_field', '48886947506028544', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"30\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"48886947506028544\",\"SVF_NAME\":\"考生号\",\"SVF_FIELD\":\"BS_EXAMINEE_NUMBER\",\"SV_ID\":\"48886453991636992\",\"SVR_ID\":\"\"}', '2018-08-07 13:53:05', 1);
INSERT INTO `sys_value_record` VALUES ('48886992284418048', '1', 'sys_validate_field', '48886992146006016', NULL, '{\"SVF_IS_REQUIRED\":\"0\",\"SVF_MAX_LENGTH\":\"\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"48886992146006016\",\"SVF_NAME\":\"身份证\",\"SVF_FIELD\":\"BS_ID_CARD\",\"SV_ID\":\"48886453991636992\",\"SVR_ID\":\"2512257846083584\"}', '2018-08-07 13:53:16', 1);
INSERT INTO `sys_value_record` VALUES ('48887041127088128', '1', 'sys_validate_field', '48887041059979264', NULL, '{\"SVF_IS_REQUIRED\":\"0\",\"SVF_MAX_LENGTH\":\"1\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"48887041059979264\",\"SVF_NAME\":\"性别\",\"SVF_FIELD\":\"BS_SEX\",\"SV_ID\":\"48886453991636992\",\"SVR_ID\":\"\"}', '2018-08-07 13:53:28', 1);
INSERT INTO `sys_value_record` VALUES ('48887089869094912', '1', 'sys_validate_field', '48887089801986048', NULL, '{\"SVF_IS_REQUIRED\":\"0\",\"SVF_MAX_LENGTH\":\"5\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"48887089801986048\",\"SVF_NAME\":\"民族\",\"SVF_FIELD\":\"BS_NATION\",\"SV_ID\":\"48886453991636992\",\"SVR_ID\":\"\"}', '2018-08-07 13:53:39', 1);
INSERT INTO `sys_value_record` VALUES ('48887125688451072', '1', 'sys_validate_field', '48887125612953600', NULL, '{\"SVF_IS_REQUIRED\":\"0\",\"SVF_MAX_LENGTH\":\"50\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"48887125612953600\",\"SVF_NAME\":\"银行\",\"SVF_FIELD\":\"BS_BANK\",\"SV_ID\":\"48886453991636992\",\"SVR_ID\":\"\"}', '2018-08-07 13:53:48', 1);
INSERT INTO `sys_value_record` VALUES ('48887437056802816', '1', 'sys_validate_field', '48887437023248384', NULL, '{\"SVF_IS_REQUIRED\":\"0\",\"SVF_MAX_LENGTH\":\"20\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"48887437023248384\",\"SVF_NAME\":\"银行卡号\",\"SVF_FIELD\":\"BS_BANK_CARD\",\"SV_ID\":\"48886453991636992\",\"SVR_ID\":\"\"}', '2018-08-07 13:55:02', 1);
INSERT INTO `sys_value_record` VALUES ('48887485979164672', '1', 'sys_validate_field', '48887485937221632', NULL, '{\"SVF_IS_REQUIRED\":\"0\",\"SVF_MAX_LENGTH\":\"\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"48887485937221632\",\"SVF_NAME\":\"电话号码\",\"SVF_FIELD\":\"BS_PHONE\",\"SV_ID\":\"48886453991636992\",\"SVR_ID\":\"2511317080473600\"}', '2018-08-07 13:55:14', 1);
INSERT INTO `sys_value_record` VALUES ('48887523677569024', '1', 'sys_validate_field', '48887523618848768', NULL, '{\"SVF_IS_REQUIRED\":\"0\",\"SVF_MAX_LENGTH\":\"250\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"48887523618848768\",\"SVF_NAME\":\"户籍地址\",\"SVF_FIELD\":\"BS_PERMANENT_ADDRESS\",\"SV_ID\":\"48886453991636992\",\"SVR_ID\":\"\"}', '2018-08-07 13:55:23', 1);
INSERT INTO `sys_value_record` VALUES ('48887555097100288', '1', 'sys_validate_field', '48887555059351552', NULL, '{\"SVF_IS_REQUIRED\":\"0\",\"SVF_MAX_LENGTH\":\"250\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"48887555059351552\",\"SVF_NAME\":\"家庭地址\",\"SVF_FIELD\":\"BS_HOME_ADDRESS\",\"SV_ID\":\"48886453991636992\",\"SVR_ID\":\"\"}', '2018-08-07 13:55:30', 1);
INSERT INTO `sys_value_record` VALUES ('48887622877052928', '1', 'SYS_DICT_TYPE', '48887622830915584', NULL, '{\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"SYS_DICT_TYPE\",\"SDT_CODE\":\"BS_SEX\",\"SDT_ROLE_DEL\":\"\",\"SDT_NAME\":\"业务_性别\",\"ID\":\"48887622830915584\",\"SDT_ROLE_DOWN\":\"\"}', '2018-08-07 13:55:46', 1);
INSERT INTO `sys_value_record` VALUES ('48887681769275392', '1', 'SYS_DICT_TYPE', '48887681748303872', NULL, '{\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"SYS_DICT_TYPE\",\"SDT_CODE\":\"BUS_NATION\",\"SDT_ROLE_DEL\":\"\",\"SDT_NAME\":\"业务_民族\",\"ID\":\"48887681748303872\",\"SDT_ROLE_DOWN\":\"\"}', '2018-08-07 13:56:01', 1);
INSERT INTO `sys_value_record` VALUES ('48887703579656192', '1', 'SYS_DICT_TYPE', '48887622830915584', '{\"IS_STATUS\":1,\"SDT_CODE\":\"BS_SEX\",\"SDT_NAME\":\"业务_性别\",\"ID\":\"48887622830915584\"}', '{\"SDT_CODE\":\"BUS_SEX\",\"SDT_ROLE_DEL\":\"\",\"SDT_NAME\":\"业务_性别\",\"ID\":\"48887622830915584\",\"SDT_ROLE_DOWN\":\"\"}', '2018-08-07 13:56:06', 2);
INSERT INTO `sys_value_record` VALUES ('48887969599193088', '1', 'SYS_DICT_INFO', '48887969481752576', NULL, '{\"SDI_CODE\":\"1\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"1\",\"SDI_REMARK\":\"1\",\"SDI_NAME\":\"男\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_SEX\",\"SDI_INNERCODE\":\"1\",\"ID\":\"48887969481752576\",\"SDT_ID\":\"48887622830915584\"}', '2018-08-07 13:57:09', 1);
INSERT INTO `sys_value_record` VALUES ('48887996652453888', '1', 'SYS_DICT_INFO', '48887996593733632', NULL, '{\"SDI_CODE\":\"0\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"2\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"女\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_SEX\",\"SDI_INNERCODE\":\"0\",\"ID\":\"48887996593733632\",\"SDT_ID\":\"48887622830915584\"}', '2018-08-07 13:57:16', 1);
INSERT INTO `sys_value_record` VALUES ('48888141968310272', '1', 'SYS_DICT_TYPE', '48888141926367232', NULL, '{\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"SYS_DICT_TYPE\",\"SDT_CODE\":\"BUS_COLLEGE_LENGTH\",\"SDT_ROLE_DEL\":\"\",\"SDT_NAME\":\"业务_学制\",\"ID\":\"48888141926367232\",\"SDT_ROLE_DOWN\":\"\"}', '2018-08-07 13:57:50', 1);
INSERT INTO `sys_value_record` VALUES ('48888183303176192', '1', 'SYS_DICT_INFO', '48888183223484416', NULL, '{\"SDI_CODE\":\"3\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"31\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"3年\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_COLLEGE_LENGTH\",\"SDI_INNERCODE\":\"3\",\"ID\":\"48888183223484416\",\"SDT_ID\":\"48888141926367232\"}', '2018-08-07 13:58:00', 1);
INSERT INTO `sys_value_record` VALUES ('48888220011724800', '1', 'SYS_DICT_INFO', '48888219961393152', NULL, '{\"SDI_CODE\":\"4\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"2\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"4年\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_COLLEGE_LENGTH\",\"SDI_INNERCODE\":\"4\",\"ID\":\"48888219961393152\",\"SDT_ID\":\"48888141926367232\"}', '2018-08-07 13:58:09', 1);
INSERT INTO `sys_value_record` VALUES ('48888235748753408', '1', 'SYS_DICT_INFO', '48888183223484416', '{\"SDI_CODE\":\"3\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_COLLEGE_LENGTH\",\"SDI_REQUIRED\":0,\"SDI_INNERCODE\":\"3\",\"SDI_ORDER\":31,\"SDI_REMARK\":\"\",\"SDI_NAME\":\"3年\",\"ID\":\"48888183223484416\",\"SDI_PARENTID\":\"0\",\"SDT_ID\":\"48888141926367232\"}', '{\"SDI_CODE\":\"3\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"1\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"3年\",\"SDI_PARENTID\":\"0\",\"SDI_INNERCODE\":\"3\",\"ID\":\"48888183223484416\",\"SDT_ID\":\"48888141926367232\"}', '2018-08-07 13:58:13', 2);
INSERT INTO `sys_value_record` VALUES ('48888372441120768', '1', 'SYS_DICT_INFO', '48888372382400512', NULL, '{\"SDI_CODE\":\"1\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"1\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"汉族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"1\",\"ID\":\"48888372382400512\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 13:58:45', 1);
INSERT INTO `sys_value_record` VALUES ('48888408084316160', '1', 'SYS_DICT_INFO', '48888408021401600', NULL, '{\"SDI_CODE\":\"2\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"2\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"蒙古族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"2\",\"ID\":\"48888408021401600\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 13:58:54', 1);
INSERT INTO `sys_value_record` VALUES ('48888446667718656', '1', 'SYS_DICT_INFO', '48888446600609792', NULL, '{\"SDI_CODE\":\"3\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"3\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"回族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"3\",\"ID\":\"48888446600609792\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 13:59:03', 1);
INSERT INTO `sys_value_record` VALUES ('48888483179134976', '1', 'SYS_DICT_INFO', '48888483112026112', NULL, '{\"SDI_CODE\":\"4\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"4\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"藏族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"4\",\"ID\":\"48888483112026112\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 13:59:12', 1);
INSERT INTO `sys_value_record` VALUES ('48888508529508352', '1', 'SYS_DICT_INFO', '48888508462399488', NULL, '{\"SDI_CODE\":\"5\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"5\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"维吾尔族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"5\",\"ID\":\"48888508462399488\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 13:59:18', 1);
INSERT INTO `sys_value_record` VALUES ('48888533926019072', '1', 'SYS_DICT_INFO', '48888533871493120', NULL, '{\"SDI_CODE\":\"6\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"6\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"苗族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"6\",\"ID\":\"48888533871493120\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 13:59:24', 1);
INSERT INTO `sys_value_record` VALUES ('48888599264886784', '1', 'SYS_DICT_INFO', '48888599193583616', NULL, '{\"SDI_CODE\":\"7\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"7\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"彝族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"7\",\"ID\":\"48888599193583616\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 13:59:39', 1);
INSERT INTO `sys_value_record` VALUES ('48888644479483904', '1', 'SYS_DICT_INFO', '48888644433346560', NULL, '{\"SDI_CODE\":\"8\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"8\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"壮族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"8\",\"ID\":\"48888644433346560\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 13:59:50', 1);
INSERT INTO `sys_value_record` VALUES ('48888666054983680', '1', 'SYS_DICT_INFO', '48888666000457728', NULL, '{\"SDI_CODE\":\"9\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"9\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"布依族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"9\",\"ID\":\"48888666000457728\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 13:59:55', 1);
INSERT INTO `sys_value_record` VALUES ('48888693800304640', '1', 'SYS_DICT_INFO', '48888693720612864', NULL, '{\"SDI_CODE\":\"10\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"10\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"朝鲜族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"10\",\"ID\":\"48888693720612864\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:00:02', 1);
INSERT INTO `sys_value_record` VALUES ('48888719649800192', '1', 'SYS_DICT_INFO', '48888719578497024', NULL, '{\"SDI_CODE\":\"11\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"11\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"满族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"11\",\"ID\":\"48888719578497024\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:00:08', 1);
INSERT INTO `sys_value_record` VALUES ('48888744891121664', '1', 'SYS_DICT_INFO', '48888744853372928', NULL, '{\"SDI_CODE\":\"12\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"12\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"侗族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"12\",\"ID\":\"48888744853372928\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:00:14', 1);
INSERT INTO `sys_value_record` VALUES ('48888773580161024', '1', 'SYS_DICT_INFO', '48888773500469248', NULL, '{\"SDI_CODE\":\"13\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"13\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"瑶族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"13\",\"ID\":\"48888773500469248\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:00:21', 1);
INSERT INTO `sys_value_record` VALUES ('48888798796316672', '1', 'SYS_DICT_INFO', '48888798708236288', NULL, '{\"SDI_CODE\":\"14\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"14\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"白族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"14\",\"ID\":\"48888798708236288\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:00:27', 1);
INSERT INTO `sys_value_record` VALUES ('48888827091091456', '1', 'SYS_DICT_INFO', '48888827015593984', NULL, '{\"SDI_CODE\":\"15\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"15\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"土家族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"15\",\"ID\":\"48888827015593984\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:00:34', 1);
INSERT INTO `sys_value_record` VALUES ('48888853833973760', '1', 'SYS_DICT_INFO', '48888853762670592', NULL, '{\"SDI_CODE\":\"16\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"16\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"哈尼族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"16\",\"ID\":\"48888853762670592\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:00:40', 1);
INSERT INTO `sys_value_record` VALUES ('48888883122798592', '1', 'SYS_DICT_INFO', '48888883080855552', NULL, '{\"SDI_CODE\":\"17\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"17\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"哈萨克族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"17\",\"ID\":\"48888883080855552\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:00:47', 1);
INSERT INTO `sys_value_record` VALUES ('48888907147771904', '1', 'SYS_DICT_INFO', '48888907055497216', NULL, '{\"SDI_CODE\":\"18\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"18\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"傣族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"18\",\"ID\":\"48888907055497216\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:00:53', 1);
INSERT INTO `sys_value_record` VALUES ('48888937669722112', '1', 'SYS_DICT_INFO', '48888937590030336', NULL, '{\"SDI_CODE\":\"19\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"19\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"黎族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"19\",\"ID\":\"48888937590030336\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:01:00', 1);
INSERT INTO `sys_value_record` VALUES ('48888977138122752', '1', 'SYS_DICT_INFO', '48888977066819584', NULL, '{\"SDI_CODE\":\"20\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"20\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"僳僳族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"20\",\"ID\":\"48888977066819584\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:01:09', 1);
INSERT INTO `sys_value_record` VALUES ('48889010382176256', '1', 'SYS_DICT_INFO', '48889010289901568', NULL, '{\"SDI_CODE\":\"21\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"21\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"佤族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"21\",\"ID\":\"48889010289901568\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:01:17', 1);
INSERT INTO `sys_value_record` VALUES ('48889034084188160', '1', 'SYS_DICT_INFO', '48889033887055872', NULL, '{\"SDI_CODE\":\"22\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"22\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"畲族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"22\",\"ID\":\"48889033887055872\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:01:23', 1);
INSERT INTO `sys_value_record` VALUES ('48889059774300160', '1', 'SYS_DICT_INFO', '48889059736551424', NULL, '{\"SDI_CODE\":\"23\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"23\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"高山族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"23\",\"ID\":\"48889059736551424\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:01:29', 1);
INSERT INTO `sys_value_record` VALUES ('48889082327072768', '1', 'SYS_DICT_INFO', '48889082213826560', NULL, '{\"SDI_CODE\":\"24\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"24\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"拉祜族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"24\",\"ID\":\"48889082213826560\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:01:34', 1);
INSERT INTO `sys_value_record` VALUES ('48889108491141120', '1', 'SYS_DICT_INFO', '48889108436615168', NULL, '{\"SDI_CODE\":\"25\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"25\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"水族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"25\",\"ID\":\"48889108436615168\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:01:41', 1);
INSERT INTO `sys_value_record` VALUES ('48889138992119808', '1', 'SYS_DICT_INFO', '48889138950176768', NULL, '{\"SDI_CODE\":\"26\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"26\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"东乡族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"26\",\"ID\":\"48889138950176768\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:01:48', 1);
INSERT INTO `sys_value_record` VALUES ('48889173125365760', '1', 'SYS_DICT_INFO', '48889173075034112', NULL, '{\"SDI_CODE\":\"27\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"27\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"纳西族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"27\",\"ID\":\"48889173075034112\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:01:56', 1);
INSERT INTO `sys_value_record` VALUES ('48889198383464448', '1', 'SYS_DICT_INFO', '48889197821427712', NULL, '{\"SDI_CODE\":\"28\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"28\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"景颇族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"28\",\"ID\":\"48889197821427712\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:02:02', 1);
INSERT INTO `sys_value_record` VALUES ('48889226019733504', '1', 'SYS_DICT_INFO', '48889225981984768', NULL, '{\"SDI_CODE\":\"29\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"29\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"柯尔克孜族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"29\",\"ID\":\"48889225981984768\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:02:09', 1);
INSERT INTO `sys_value_record` VALUES ('48889268516421632', '1', 'SYS_DICT_INFO', '48889267581091840', NULL, '{\"SDI_CODE\":\"30\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"30\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"土族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"30\",\"ID\":\"48889267581091840\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:02:19', 1);
INSERT INTO `sys_value_record` VALUES ('48889311579340800', '1', 'SYS_DICT_INFO', '48889311541592064', NULL, '{\"SDI_CODE\":\"31\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"31\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"达斡尔族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"31\",\"ID\":\"48889311541592064\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:02:29', 1);
INSERT INTO `sys_value_record` VALUES ('48889340964634624', '1', 'SYS_DICT_INFO', '48889340905914368', NULL, '{\"SDI_CODE\":\"32\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"32\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"仫佬族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"32\",\"ID\":\"48889340905914368\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:02:36', 1);
INSERT INTO `sys_value_record` VALUES ('48889375785746432', '1', 'SYS_DICT_INFO', '48889375735414784', NULL, '{\"SDI_CODE\":\"33\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"33\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"羌族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"33\",\"ID\":\"48889375735414784\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:02:44', 1);
INSERT INTO `sys_value_record` VALUES ('48889405519167488', '1', 'SYS_DICT_INFO', '48889405468835840', NULL, '{\"SDI_CODE\":\"34\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"34\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"布朗族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"34\",\"ID\":\"48889405468835840\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:02:52', 1);
INSERT INTO `sys_value_record` VALUES ('48889437391683584', '1', 'SYS_DICT_INFO', '48889437341351936', NULL, '{\"SDI_CODE\":\"35\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"35\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"撒拉族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"35\",\"ID\":\"48889437341351936\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:02:59', 1);
INSERT INTO `sys_value_record` VALUES ('48889461664120832', '1', 'SYS_DICT_INFO', '48889461580234752', NULL, '{\"SDI_CODE\":\"36\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"36\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"毛南族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"36\",\"ID\":\"48889461580234752\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:03:05', 1);
INSERT INTO `sys_value_record` VALUES ('48889485903003648', '1', 'SYS_DICT_INFO', '48889485856866304', NULL, '{\"SDI_CODE\":\"37\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"37\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"仡佬族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"37\",\"ID\":\"48889485856866304\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:03:11', 1);
INSERT INTO `sys_value_record` VALUES ('48889524272496640', '1', 'SYS_DICT_INFO', '48889524222164992', NULL, '{\"SDI_CODE\":\"38\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"38\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"锡伯族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"38\",\"ID\":\"48889524222164992\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:03:20', 1);
INSERT INTO `sys_value_record` VALUES ('48889556296007680', '1', 'SYS_DICT_INFO', '48889556245676032', NULL, '{\"SDI_CODE\":\"39\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"39\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"阿昌族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"39\",\"ID\":\"48889556245676032\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:03:27', 1);
INSERT INTO `sys_value_record` VALUES ('48889584834052096', '1', 'SYS_DICT_INFO', '48889584775331840', NULL, '{\"SDI_CODE\":\"40\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"40\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"普米族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"40\",\"ID\":\"48889584775331840\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:03:34', 1);
INSERT INTO `sys_value_record` VALUES ('48889612176719872', '1', 'SYS_DICT_INFO', '48889612109611008', NULL, '{\"SDI_CODE\":\"41\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"41\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"塔吉克族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"41\",\"ID\":\"48889612109611008\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:03:41', 1);
INSERT INTO `sys_value_record` VALUES ('48889644749684736', '1', 'SYS_DICT_INFO', '48889644711936000', NULL, '{\"SDI_CODE\":\"42\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"42\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"怒族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"42\",\"ID\":\"48889644711936000\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:03:49', 1);
INSERT INTO `sys_value_record` VALUES ('48889668166483968', '1', 'SYS_DICT_INFO', '48889668137123840', NULL, '{\"SDI_CODE\":\"43\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"43\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"乌孜别克族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"43\",\"ID\":\"48889668137123840\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:03:54', 1);
INSERT INTO `sys_value_record` VALUES ('48889715629228032', '1', 'SYS_DICT_INFO', '48889715574702080', NULL, '{\"SDI_CODE\":\"44\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"44\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"俄罗斯族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"44\",\"ID\":\"48889715574702080\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:04:05', 1);
INSERT INTO `sys_value_record` VALUES ('48889785976094720', '1', 'SYS_DICT_INFO', '48889785925763072', NULL, '{\"SDI_CODE\":\"45\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"45\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"鄂温克族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"45\",\"ID\":\"48889785925763072\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:04:22', 1);
INSERT INTO `sys_value_record` VALUES ('48889826325299200', '1', 'SYS_DICT_INFO', '48889826266578944', NULL, '{\"SDI_CODE\":\"46\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"46\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"德昂族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"46\",\"ID\":\"48889826266578944\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:04:32', 1);
INSERT INTO `sys_value_record` VALUES ('48889865940500480', '1', 'SYS_DICT_INFO', '48889865885974528', NULL, '{\"SDI_CODE\":\"47\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"47\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"保安族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"47\",\"ID\":\"48889865885974528\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:04:41', 1);
INSERT INTO `sys_value_record` VALUES ('48889902649049088', '1', 'SYS_DICT_INFO', '48889902607106048', NULL, '{\"SDI_CODE\":\"48\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"48\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"裕固族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"48\",\"ID\":\"48889902607106048\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:04:50', 1);
INSERT INTO `sys_value_record` VALUES ('48889934295072768', '1', 'SYS_DICT_INFO', '48889934232158208', NULL, '{\"SDI_CODE\":\"49\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"49\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"京族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"49\",\"ID\":\"48889934232158208\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:04:58', 1);
INSERT INTO `sys_value_record` VALUES ('48889965483917312', '1', 'SYS_DICT_INFO', '48889965408419840', NULL, '{\"SDI_CODE\":\"50\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"50\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"塔塔尔族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"50\",\"ID\":\"48889965408419840\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:05:05', 1);
INSERT INTO `sys_value_record` VALUES ('48890000682516480', '1', 'SYS_DICT_INFO', '48889999852044288', NULL, '{\"SDI_CODE\":\"51\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"51\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"独龙族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"51\",\"ID\":\"48889999852044288\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:05:13', 1);
INSERT INTO `sys_value_record` VALUES ('48890032685056000', '1', 'SYS_DICT_INFO', '48890032630530048', NULL, '{\"SDI_CODE\":\"52\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"52\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"鄂伦春族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"52\",\"ID\":\"48890032630530048\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:05:21', 1);
INSERT INTO `sys_value_record` VALUES ('48890060279382016', '1', 'SYS_DICT_INFO', '48890060250021888', NULL, '{\"SDI_CODE\":\"53\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"53\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"赫哲族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"53\",\"ID\":\"48890060250021888\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:05:28', 1);
INSERT INTO `sys_value_record` VALUES ('48890091417894912', '1', 'SYS_DICT_INFO', '48890091363368960', NULL, '{\"SDI_CODE\":\"54\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"54\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"门巴族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"54\",\"ID\":\"48890091363368960\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:05:35', 1);
INSERT INTO `sys_value_record` VALUES ('48890125895073792', '1', 'SYS_DICT_INFO', '48890125840547840', NULL, '{\"SDI_CODE\":\"55\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"55\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"珞巴族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"55\",\"ID\":\"48890125840547840\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:05:43', 1);
INSERT INTO `sys_value_record` VALUES ('48890164088406016', '1', 'SYS_DICT_INFO', '48890164021297152', NULL, '{\"SDI_CODE\":\"56\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"56\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"基诺族\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_NATION\",\"SDI_INNERCODE\":\"56\",\"ID\":\"48890164021297152\",\"SDT_ID\":\"48887681748303872\"}', '2018-08-07 14:05:52', 1);
INSERT INTO `sys_value_record` VALUES ('48890586081525760', '1', 'SYS_CONFIGURE', '48890586014416896', NULL, '{\"SC_IS_PAGING\":\"1\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE\",\"SC_NAME\":\"基础信息管理-学生管理\",\"SC_JSP\":\"admin/info/student/home\",\"SC_VIEW\":\"v_student\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"48890586014416896\",\"SC_ORDER_BY\":\"\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '2018-08-07 14:07:33', 1);
INSERT INTO `sys_value_record` VALUES ('48890620319629312', '1', 'SYS_CONFIGURE', '48890586014416896', '{\"SC_IS_PAGING\":\"1\",\"SC_NAME\":\"基础信息管理-学生管理\",\"SC_JSP\":\"admin/info/student/home\",\"SC_VIEW\":\"v_student\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"48890586014416896\",\"SC_ORDER_BY\":\"\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '{\"SC_NAME\":\"基础信息管理-学生管理\",\"SC_JSP\":\"admin/info/student/home\",\"SC_VIEW\":\"v_student\",\"SC_ORDER_BY\":\"CONVERT(ID,SIGNED) DESC\",\"SC_IS_PAGING\":\"1\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"48890586014416896\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '2018-08-07 14:07:41', 2);
INSERT INTO `sys_value_record` VALUES ('48890805816918016', '1', 'SYS_CONFIGURE_COLUMN', '48890805737226240', NULL, '{\"SCC_NAME\":\"姓名\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"120px\",\"SCC_FIELD\":\"BS_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48890805737226240\",\"SC_ID\":\"48890586014416896\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"1\"}', '2018-08-07 14:08:25', 1);
INSERT INTO `sys_value_record` VALUES ('48890888331460608', '1', 'SYS_CONFIGURE_COLUMN', '48890888293711872', NULL, '{\"SCC_NAME\":\"系部\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"left\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"180px\",\"SCC_FIELD\":\"BDM_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48890888293711872\",\"SC_ID\":\"48890586014416896\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"10\"}', '2018-08-07 14:08:45', 1);
INSERT INTO `sys_value_record` VALUES ('48890941221634048', '1', 'SYS_CONFIGURE_COLUMN', '48890941183885312', NULL, '{\"SCC_NAME\":\"班级\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"180px\",\"SCC_FIELD\":\"BC_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48890941183885312\",\"SC_ID\":\"48890586014416896\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"20\"}', '2018-08-07 14:08:58', 1);
INSERT INTO `sys_value_record` VALUES ('48891009278410752', '1', 'SYS_CONFIGURE_COLUMN', '48891009236467712', NULL, '{\"SCC_NAME\":\"学号\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"BS_NUMBER\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48891009236467712\",\"SC_ID\":\"48890586014416896\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"30\"}', '2018-08-07 14:09:14', 1);
INSERT INTO `sys_value_record` VALUES ('48891051787681792', '1', 'SYS_CONFIGURE_COLUMN', '48891051766710272', NULL, '{\"SCC_NAME\":\"学制\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"50px\",\"SCC_FIELD\":\"BS_LENGTH\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48891051766710272\",\"SC_ID\":\"48890586014416896\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"40\"}', '2018-08-07 14:09:24', 1);
INSERT INTO `sys_value_record` VALUES ('48891120691707904', '1', 'SYS_CONFIGURE_COLUMN', '48891120653959168', NULL, '{\"SCC_NAME\":\"身份证\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"120px\",\"SCC_FIELD\":\"BS_ID_CARD\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48891120653959168\",\"SC_ID\":\"48890586014416896\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"50\"}', '2018-08-07 14:09:40', 1);
INSERT INTO `sys_value_record` VALUES ('48891194972831744', '1', 'SYS_CONFIGURE_COLUMN', '48891194926694400', NULL, '{\"SCC_NAME\":\"性别\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"50px\",\"SCC_FIELD\":\"BS_SEX_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48891194926694400\",\"SC_ID\":\"48890586014416896\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"5\"}', '2018-08-07 14:09:58', 1);
INSERT INTO `sys_value_record` VALUES ('48891240988540928', '1', 'SYS_CONFIGURE_COLUMN', '48891240950792192', NULL, '{\"SCC_NAME\":\"民族\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"60px\",\"SCC_FIELD\":\"BS_NATION_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48891240950792192\",\"SC_ID\":\"48890586014416896\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"6\"}', '2018-08-07 14:10:09', 1);
INSERT INTO `sys_value_record` VALUES ('48891335830142976', '1', 'SYS_CONFIGURE_COLUMN', '48891335788199936', NULL, '{\"SCC_NAME\":\"操作\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"1\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"80px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"48891335788199936\",\"SC_ID\":\"48890586014416896\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"60\"}', '2018-08-07 14:10:32', 1);
INSERT INTO `sys_value_record` VALUES ('48891420366340096', '1', 'SYS_CONFIGURE_SEARCH', '48891420307619840', NULL, '{\"SCS_METHOD_TYPE\":\"4\",\"SCS_TYPE\":\"1\",\"SCS_FIELD\":\"BS_NAME\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_SEARCH\",\"SCS_NAME\":\"学生姓名\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"48891420307619840\",\"SC_ID\":\"48890586014416896\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":\"1\"}', '2018-08-07 14:10:52', 1);
INSERT INTO `sys_value_record` VALUES ('48891465207644160', '1', 'SYS_CONFIGURE_SEARCH', '48891465165701120', NULL, '{\"SCS_METHOD_TYPE\":\"4\",\"SCS_TYPE\":\"1\",\"SCS_FIELD\":\"BDM_NAME\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_SEARCH\",\"SCS_NAME\":\"系部\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"48891465165701120\",\"SC_ID\":\"48890586014416896\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":\"10\"}', '2018-08-07 14:11:03', 1);
INSERT INTO `sys_value_record` VALUES ('48891504487301120', '1', 'SYS_CONFIGURE_SEARCH', '48891504432775168', NULL, '{\"SCS_METHOD_TYPE\":\"4\",\"SCS_TYPE\":\"1\",\"SCS_FIELD\":\"BC_NAME\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_SEARCH\",\"SCS_NAME\":\"班级\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"48891504432775168\",\"SC_ID\":\"48890586014416896\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":\"20\"}', '2018-08-07 14:11:12', 1);
INSERT INTO `sys_value_record` VALUES ('48891543901175808', '1', 'SYS_CONFIGURE_SEARCH', '48891543850844160', NULL, '{\"SCS_METHOD_TYPE\":\"4\",\"SCS_TYPE\":\"1\",\"SCS_FIELD\":\"BS_NUMBER\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_SEARCH\",\"SCS_NAME\":\"学号\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"48891543850844160\",\"SC_ID\":\"48890586014416896\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":\"30\"}', '2018-08-07 14:11:21', 1);
INSERT INTO `sys_value_record` VALUES ('48891578256719872', '1', 'SYS_CONFIGURE_SEARCH', '48891578202193920', NULL, '{\"SCS_METHOD_TYPE\":\"4\",\"SCS_TYPE\":\"1\",\"SCS_FIELD\":\"BS_ID_CARD\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_SEARCH\",\"SCS_NAME\":\"身份证\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"48891578202193920\",\"SC_ID\":\"48890586014416896\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":\"40\"}', '2018-08-07 14:11:30', 1);
INSERT INTO `sys_value_record` VALUES ('48891829898182656', '1', 'SYS_CONFIGURE_SEARCH', '48891829847851008', NULL, '{\"SCS_METHOD_TYPE\":\"1\",\"SCS_TYPE\":\"2\",\"SCS_FIELD\":\"BS_SEX\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_SEARCH\",\"SCS_NAME\":\"性别\",\"SCS_SDT_CODE\":\"BUS_SEX\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"48891829847851008\",\"SC_ID\":\"48890586014416896\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":\"50\"}', '2018-08-07 14:12:30', 1);
INSERT INTO `sys_value_record` VALUES ('48891881018359808', '1', 'SYS_CONFIGURE_SEARCH', '48891880963833856', NULL, '{\"SCS_METHOD_TYPE\":\"1\",\"SCS_TYPE\":\"2\",\"SCS_FIELD\":\"BS_NATION\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_SEARCH\",\"SCS_NAME\":\"民族\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"48891880963833856\",\"SC_ID\":\"48890586014416896\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":\"60\"}', '2018-08-07 14:12:42', 1);
INSERT INTO `sys_value_record` VALUES ('48891905005584384', '1', 'SYS_CONFIGURE_SEARCH', '48891880963833856', '{\"SCS_METHOD_TYPE\":\"1\",\"SCS_TYPE\":\"2\",\"SCS_FIELD\":\"BS_NATION\",\"SCS_NAME\":\"民族\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"48891880963833856\",\"SC_ID\":\"48890586014416896\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":60}', '{\"SCS_FIELD\":\"BS_NATION\",\"SCS_NAME\":\"民族\",\"SCS_SDT_CODE\":\"BUS_NATION\",\"SCS_ORDER\":\"60\",\"SCS_METHOD_TYPE\":\"1\",\"SCS_TYPE\":\"2\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"48891880963833856\",\"SC_ID\":\"48890586014416896\",\"SCS_REMARK\":\"\"}', '2018-08-07 14:12:47', 2);
INSERT INTO `sys_value_record` VALUES ('48892124938108928', '1', 'SYS_MENU', '48892124845834240', NULL, '{\"SM_URL\":\"1\",\"SVR_TABLE_NAME\":\"SYS_MENU\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":\"70\",\"SM_CODE\":\"INFO:STUDENT\",\"SM_NAME\":\"学生管理\",\"SM_PARENTID\":\"38116041032728576\",\"SPD_ID\":\"\",\"ID\":\"48892124845834240\",\"SC_ID\":\"48890586014416896\",\"SM_CLASSICON\":\"mdi mdi-account-multiple-outline\",\"SM_IS_EXPAND\":\"\"}', '2018-08-07 14:13:40', 1);
INSERT INTO `sys_value_record` VALUES ('48892178872664064', '1', 'SYS_MENU', '48892124845834240', '{\"SM_URL\":\"1\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_ORDER\":70,\"SM_CODE\":\"INFO:STUDENT\",\"SM_NAME\":\"学生管理\",\"SM_PARENTID\":\"38116041032728576\",\"SPD_ID\":\"\",\"ID\":\"48892124845834240\",\"SC_ID\":\"48890586014416896\",\"SM_CLASSICON\":\"mdi mdi-account-multiple-outline\",\"SM_IS_EXPAND\":\"\"}', '{\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_ORDER\":\"70\",\"SM_CODE\":\"INFO:STUDENT\",\"SM_NAME\":\"学生管理\",\"SM_PARENTID\":\"38116041032728576\",\"SPD_ID\":\"\",\"ID\":\"48892124845834240\",\"SC_ID\":\"48890586014416896\",\"SM_CLASSICON\":\"mdi mdi-account-multiple-outline\",\"SM_IS_EXPAND\":\"\"}', '2018-08-07 14:13:53', 2);
INSERT INTO `sys_value_record` VALUES ('48892279259136000', '1', 'SYS_MENU', '48892279221387264', NULL, '{\"SM_URL\":\"\",\"SVR_TABLE_NAME\":\"SYS_MENU\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":\"1\",\"SM_CODE\":\"INFO:STUDENT_UPDATE\",\"SM_NAME\":\"编辑\",\"SM_PARENTID\":\"48892124845834240\",\"SPD_ID\":\"\",\"ID\":\"48892279221387264\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '2018-08-07 14:14:17', 1);
INSERT INTO `sys_value_record` VALUES ('48892526555299840', '1', 'SYS_ROLE', '48892526509162496', NULL, '{\"SR_CODE\":\"STUDENT\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"SYS_ROLE\",\"SR_EXPLAIN\":\"基础角色\",\"SR_NAME\":\"学生\",\"ID\":\"48892526509162496\",\"SR_REMARK\":\"\",\"SR_TYPE\":\"4\"}', '2018-08-07 14:15:16', 1);
INSERT INTO `sys_value_record` VALUES ('48892542598512640', '1', 'SYS_ROLE', '48678292462501888', '{\"SR_CODE\":\"TEACHER\",\"IS_STATUS\":1,\"SR_EXPLAIN\":\"\",\"SR_NAME\":\"教师\",\"ID\":\"48678292462501888\",\"SR_REMARK\":\"\",\"SR_TYPE\":\"5\"}', '{\"SR_CODE\":\"TEACHER\",\"SR_TYPE\":\"5\",\"SR_EXPLAIN\":\"基础角色\",\"SR_NAME\":\"教师\",\"ID\":\"48678292462501888\",\"SR_REMARK\":\"\"}', '2018-08-07 14:15:19', 2);
INSERT INTO `sys_value_record` VALUES ('48894160370925568', '1', 'SYS_CONFIGURE_COLUMN', '48890941183885312', '{\"SCC_NAME\":\"班级\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"180px\",\"SCC_FIELD\":\"BC_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48890941183885312\",\"SC_ID\":\"48890586014416896\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":20}', '{\"SCC_NAME\":\"班级\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"left\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"180px\",\"SCC_FIELD\":\"BC_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48890941183885312\",\"SC_ID\":\"48890586014416896\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"20\"}', '2018-08-07 14:21:45', 2);
INSERT INTO `sys_value_record` VALUES ('48942988365135872', '1', 'SYS_VALIDATE_REGEX', '2512257846083584', '{\"IS_STATUS\":\"1\",\"SVR_REGEX\":\"\\\\d{17}[\\\\d|x]|\\\\d{15}\",\"SVR_REGEX_MESSAGE\":\"请输入正确的身份证号码!\",\"ID\":\"2512257846083584\",\"SVR_NAME\":\"身份证\"}', '{\"SVR_REGEX\":\"^[1-9]\\\\d{5}(18|19|([23]\\\\d))\\\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\\\d{3}[0-9Xx]$\",\"SVR_REGEX_MESSAGE\":\"请输入正确的身份证号码!\",\"ID\":\"2512257846083584\",\"SVR_NAME\":\"身份证\"}', '2018-08-07 17:35:47', 2);
INSERT INTO `sys_value_record` VALUES ('48944951924359168', '1', 'SYS_OPERATOR', '48944951878221825', NULL, '{\"SO_PASSWORD\":\"b696cf2470ac88242758ac3a253c62ad\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"SYS_OPERATOR\",\"ID\":\"48944951878221825\",\"SO_SALT\":\"iHkUI,\"}', '2018-08-07 17:43:35', 1);
INSERT INTO `sys_value_record` VALUES ('48944952016633856', '1', 'SYS_ACCOUNT_INFO', '48944951974690816', NULL, '{\"SO_ID\":\"48944951878221825\",\"SAI_NAME\":\"student_test\",\"SVR_TABLE_NAME\":\"SYS_ACCOUNT_INFO\",\"ID\":\"48944951974690816\",\"SAI_TYPE\":4}', '2018-08-07 17:43:35', 1);
INSERT INTO `sys_value_record` VALUES ('48944952129880064', '1', 'BUS_STUDENT', '48944951878221824', NULL, '{\"SVR_TABLE_NAME\":\"BUS_STUDENT\",\"BS_LENGTH\":\"3\",\"BS_ENROLMENT_YEAR\":\"2018\",\"BS_NAME\":\"student_test\",\"BS_SEX\":\"1\",\"BS_BANK_CARD\":\"454545454545452\",\"SO_ID\":\"48944951878221825\",\"BDM_ID\":\"48601265252335616\",\"BS_EXAMINEE_NUMBER\":\"tt2018053105\",\"BS_ENTRY_TIME\":\"2018-08-07 17:43:35\",\"BS_NUMBER\":\"2018053105\",\"BC_ID\":\"48656602449838080\",\"BS_PHONE\":\"17012342032\",\"ID\":\"48944951878221824\",\"BS_PERMANENT_ADDRESS\":\"test&middot;\",\"BS_HOME_ADDRESS\":\"test2\",\"BS_BANK\":\"兴业银行\",\"BS_NATION\":\"1\",\"BS_ID_CARD\":\"350122199605020114\"}', '2018-08-07 17:43:35', 1);
INSERT INTO `sys_value_record` VALUES ('48945054781276160', '1', 'SYS_CONFIGURE_COLUMN', '48890941183885312', '{\"SCC_NAME\":\"班级\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"left\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"180px\",\"SCC_FIELD\":\"BC_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48890941183885312\",\"SC_ID\":\"48890586014416896\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":20}', '{\"SCC_NAME\":\"班级\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"left\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"160px\",\"SCC_FIELD\":\"BC_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48890941183885312\",\"SC_ID\":\"48890586014416896\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"20\"}', '2018-08-07 17:43:59', 2);
INSERT INTO `sys_value_record` VALUES ('48945073856970752', '1', 'SYS_CONFIGURE_COLUMN', '48890888293711872', '{\"SCC_NAME\":\"系部\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"left\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"180px\",\"SCC_FIELD\":\"BDM_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48890888293711872\",\"SC_ID\":\"48890586014416896\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":10}', '{\"SCC_NAME\":\"系部\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"left\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"160px\",\"SCC_FIELD\":\"BDM_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48890888293711872\",\"SC_ID\":\"48890586014416896\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"10\"}', '2018-08-07 17:44:04', 2);
INSERT INTO `sys_value_record` VALUES ('48945118786355200', '1', 'SYS_CONFIGURE_COLUMN', '48891120653959168', '{\"SCC_NAME\":\"身份证\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"120px\",\"SCC_FIELD\":\"BS_ID_CARD\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48891120653959168\",\"SC_ID\":\"48890586014416896\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":50}', '{\"SCC_NAME\":\"身份证\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"130px\",\"SCC_FIELD\":\"BS_ID_CARD\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48891120653959168\",\"SC_ID\":\"48890586014416896\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"50\"}', '2018-08-07 17:44:15', 2);
INSERT INTO `sys_value_record` VALUES ('48945163241783296', '1', 'SYS_CONFIGURE_COLUMN', '48891120653959168', '{\"SCC_NAME\":\"身份证\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"130px\",\"SCC_FIELD\":\"BS_ID_CARD\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48891120653959168\",\"SC_ID\":\"48890586014416896\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":50}', '{\"SCC_NAME\":\"身份证\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"140px\",\"SCC_FIELD\":\"BS_ID_CARD\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48891120653959168\",\"SC_ID\":\"48890586014416896\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"50\"}', '2018-08-07 17:44:25', 2);
INSERT INTO `sys_value_record` VALUES ('48946558724472832', '1', 'SYS_CONFIGURE_SEARCH', '48946558678335488', NULL, '{\"SCS_METHOD_TYPE\":\"1\",\"SCS_TYPE\":\"2\",\"SCS_FIELD\":\"SAI_TYPE\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_SEARCH\",\"SCS_NAME\":\"类型\",\"SCS_SDT_CODE\":\"SYS_OPERATOR_TYPE\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"48946558678335488\",\"SC_ID\":\"3316994321416192\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":\"5\"}', '2018-08-07 17:49:58', 1);
INSERT INTO `sys_value_record` VALUES ('48946768385146880', '1', 'SYS_OPERATOR', '48944951878221825', '{\"IS_STATUS\":1,\"ID\":\"48944951878221825\"}', '{\"ID\":\"48944951878221825\"}', '2018-08-07 17:50:48', 2);
INSERT INTO `sys_value_record` VALUES ('48946968554110976', '1', 'SYS_OPERATOR_SUB', '48946968478613504', NULL, '{\"IS_STATUS\":1,\"SOS_CREATETIME\":\"2018-08-07 17:51:36\",\"SVR_TABLE_NAME\":\"SYS_OPERATOR_SUB\",\"SOS_REMARK\":\"\",\"SOS_DEFAULT\":1,\"SO_ID\":\"48944951878221825\",\"ID\":\"48946968478613504\",\"SOS_USERNAME\":\"student_test\"}', '2018-08-07 17:51:36', 1);
INSERT INTO `sys_value_record` VALUES ('48948569184403456', '1', 'SYS_BUTTON', '48286237202579456', '{\"SB_CODE\":\"IMPORT\",\"SB_FUNC\":\"\",\"SB_CLASS\":\"btn btn-info\",\"SB_ORDER\":7,\"SB_BUTTONID\":\"import\",\"SB_ICON\":\"mdi mdi-import\",\"ID\":\"48286237202579456\",\"SB_TYPE\":\"0\",\"SB_NAME\":\"导入\"}', '{\"SB_CODE\":\"IMPORT\",\"SB_CLASS\":\"btn btn-success\",\"SB_ORDER\":\"7\",\"SB_BUTTONID\":\"import\",\"SB_ICON\":\"mdi mdi-import\",\"SB_TYPE\":\"0\",\"SB_FUNC\":\"\",\"ID\":\"48286237202579456\",\"SB_NAME\":\"导入\"}', '2018-08-07 17:57:57', 2);
INSERT INTO `sys_value_record` VALUES ('48948591607152640', '1', 'SYS_BUTTON', '48286450940116992', '{\"SB_CODE\":\"EXPORT\",\"SB_FUNC\":\"\",\"SB_CLASS\":\"btn btn-info\",\"SB_ORDER\":8,\"SB_BUTTONID\":\"export\",\"SB_ICON\":\"mdi mdi-export\",\"ID\":\"48286450940116992\",\"SB_TYPE\":\"0\",\"SB_NAME\":\"导出\"}', '{\"SB_CODE\":\"EXPORT\",\"SB_CLASS\":\"btn btn-success\",\"SB_ORDER\":\"8\",\"SB_BUTTONID\":\"export\",\"SB_ICON\":\"mdi mdi-export\",\"SB_TYPE\":\"0\",\"SB_FUNC\":\"\",\"ID\":\"48286450940116992\",\"SB_NAME\":\"导出\"}', '2018-08-07 17:58:03', 2);
INSERT INTO `sys_value_record` VALUES ('48982781190995968', '1', 'SYS_CONFIGURE_COLUMN', '48891051766710272', '{\"SCC_NAME\":\"学制\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"50px\",\"SCC_FIELD\":\"BS_LENGTH\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48891051766710272\",\"SC_ID\":\"48890586014416896\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":40}', '{\"SCC_NAME\":\"学制\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"40px\",\"SCC_FIELD\":\"BS_LENGTH\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48891051766710272\",\"SC_ID\":\"48890586014416896\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"40\"}', '2018-08-07 20:13:54', 2);
INSERT INTO `sys_value_record` VALUES ('48982800874864640', '1', 'SYS_CONFIGURE_COLUMN', '48891009236467712', '{\"SCC_NAME\":\"学号\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"BS_NUMBER\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48891009236467712\",\"SC_ID\":\"48890586014416896\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":30}', '{\"SCC_NAME\":\"学号\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"90px\",\"SCC_FIELD\":\"BS_NUMBER\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48891009236467712\",\"SC_ID\":\"48890586014416896\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"30\"}', '2018-08-07 20:13:59', 2);
INSERT INTO `sys_value_record` VALUES ('48982883552985088', '1', 'SYS_CONFIGURE_COLUMN', '48890941183885312', '{\"SCC_NAME\":\"班级\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"left\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"160px\",\"SCC_FIELD\":\"BC_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48890941183885312\",\"SC_ID\":\"48890586014416896\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":20}', '{\"SCC_NAME\":\"班级\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"left\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"170px\",\"SCC_FIELD\":\"BC_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48890941183885312\",\"SC_ID\":\"48890586014416896\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"20\"}', '2018-08-07 20:14:18', 2);
INSERT INTO `sys_value_record` VALUES ('48982897817812992', '1', 'SYS_CONFIGURE_COLUMN', '48890888293711872', '{\"SCC_NAME\":\"系部\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"left\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"160px\",\"SCC_FIELD\":\"BDM_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48890888293711872\",\"SC_ID\":\"48890586014416896\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":10}', '{\"SCC_NAME\":\"系部\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"left\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"170px\",\"SCC_FIELD\":\"BDM_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48890888293711872\",\"SC_ID\":\"48890586014416896\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"10\"}', '2018-08-07 20:14:22', 2);
INSERT INTO `sys_value_record` VALUES ('49021182724276224', '1', 'SYS_OPERATOR', '1', '{\"SO_PASSWORD\":\"48474f975022f960bc2afbe49be581e8\",\"ID\":\"1\",\"IS_DEFAULT_PWD\":1,\"SO_SALT\":\"qwerty\"}', '{\"IS_DEFAULT_PWD\":0,\"SO_SALT\":\"6,OIYn\",\"SO_PASSWORD\":\"37a5f61ca0f4af3fe8b677211279ee7b\",\"ID\":\"1\"}', '2018-08-07 22:46:30', 2);
INSERT INTO `sys_value_record` VALUES ('49021999288156160', '1', 'SYS_OPERATOR', '1', '{\"SO_PASSWORD\":\"37a5f61ca0f4af3fe8b677211279ee7b\",\"ID\":\"1\",\"IS_DEFAULT_PWD\":0,\"SO_SALT\":\"6,OIYn\"}', '{\"IS_DEFAULT_PWD\":0,\"SO_SALT\":\"g5wH;+\",\"SO_PASSWORD\":\"75dd1eda323cd6bbef5dd39e8d65da8b\",\"ID\":\"1\"}', '2018-08-07 22:49:44', 2);
INSERT INTO `sys_value_record` VALUES ('49023894199205888', '1', 'SYS_OPERATOR', '1', '{\"IS_STATUS\":1,\"ID\":\"1\"}', '{\"ID\":\"1\"}', '2018-08-07 22:57:16', 2);
INSERT INTO `sys_value_record` VALUES ('49023916936527872', '1', 'SYS_OPERATOR', '1', '{\"IS_STATUS\":1,\"ID\":\"1\"}', '{\"ID\":\"1\"}', '2018-08-07 22:57:22', 2);
INSERT INTO `sys_value_record` VALUES ('49023936591036416', '1', 'SYS_OPERATOR', '1', '{\"IS_STATUS\":1,\"ID\":\"1\"}', '{\"ID\":\"1\"}', '2018-08-07 22:57:26', 2);
INSERT INTO `sys_value_record` VALUES ('49026113367703552', '1', 'SYS_MENU', '48892124845834240', '{\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_ORDER\":70,\"SM_CODE\":\"INFO:STUDENT\",\"SM_NAME\":\"学生管理\",\"SM_PARENTID\":\"38116041032728576\",\"SPD_ID\":\"\",\"ID\":\"48892124845834240\",\"SC_ID\":\"48890586014416896\",\"SM_CLASSICON\":\"mdi mdi-account-multiple-outline\",\"SM_IS_EXPAND\":\"\"}', '{\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_ORDER\":\"30\",\"SM_CODE\":\"STUDENT\",\"SM_NAME\":\"学生管理\",\"SM_PARENTID\":\"0\",\"SPD_ID\":\"\",\"ID\":\"48892124845834240\",\"SC_ID\":\"48890586014416896\",\"SM_CLASSICON\":\"mdi mdi-account-multiple-outline\",\"SM_IS_EXPAND\":\"\"}', '2018-08-07 23:06:05', 2);
INSERT INTO `sys_value_record` VALUES ('49026162571083776', '1', 'SYS_MENU', '48892279221387264', '{\"SM_URL\":\"\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_ORDER\":1,\"SM_CODE\":\"INFO:STUDENT_UPDATE\",\"SM_NAME\":\"编辑\",\"SM_PARENTID\":\"48892124845834240\",\"SPD_ID\":\"\",\"ID\":\"48892279221387264\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '{\"SM_URL\":\"\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_ORDER\":\"1\",\"SM_CODE\":\"STUDENT:UPDATE\",\"SM_NAME\":\"编辑\",\"SM_PARENTID\":\"48892124845834240\",\"SPD_ID\":\"\",\"ID\":\"48892279221387264\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '2018-08-07 23:06:17', 2);
INSERT INTO `sys_value_record` VALUES ('49026230996959232', '1', 'SYS_MENU', '48892124845834240', '{\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_ORDER\":30,\"SM_CODE\":\"STUDENT\",\"SM_NAME\":\"学生管理\",\"SM_PARENTID\":\"0\",\"SPD_ID\":\"\",\"ID\":\"48892124845834240\",\"SC_ID\":\"48890586014416896\",\"SM_CLASSICON\":\"mdi mdi-account-multiple-outline\",\"SM_IS_EXPAND\":\"\"}', '{\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_ORDER\":\"30\",\"SM_CODE\":\"STUDENT:BASE\",\"SM_NAME\":\"学生管理\",\"SM_PARENTID\":\"0\",\"SPD_ID\":\"\",\"ID\":\"48892124845834240\",\"SC_ID\":\"48890586014416896\",\"SM_CLASSICON\":\"mdi mdi-account-multiple-outline\",\"SM_IS_EXPAND\":\"\"}', '2018-08-07 23:06:33', 2);
INSERT INTO `sys_value_record` VALUES ('49026263565729792', '1', 'SYS_MENU', '48892279221387264', '{\"SM_URL\":\"\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_ORDER\":1,\"SM_CODE\":\"STUDENT:UPDATE\",\"SM_NAME\":\"编辑\",\"SM_PARENTID\":\"48892124845834240\",\"SPD_ID\":\"\",\"ID\":\"48892279221387264\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '{\"SM_URL\":\"\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_ORDER\":\"1\",\"SM_CODE\":\"STUDENT:BASE_UPDATE\",\"SM_NAME\":\"编辑\",\"SM_PARENTID\":\"48892124845834240\",\"SPD_ID\":\"\",\"ID\":\"48892279221387264\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '2018-08-07 23:06:41', 2);
INSERT INTO `sys_value_record` VALUES ('49027089134780416', '1', 'SYS_MENU', '49027088874733568', NULL, '{\"SM_URL\":\"\",\"SVR_TABLE_NAME\":\"SYS_MENU\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"1\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":\"30\",\"SM_CODE\":\"STUDENT\",\"SM_NAME\":\"学生管理\",\"SM_PARENTID\":\"0\",\"SPD_ID\":\"\",\"ID\":\"49027088874733568\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-account-multiple-outline\",\"SM_IS_EXPAND\":\"\"}', '2018-08-07 23:09:58', 1);
INSERT INTO `sys_value_record` VALUES ('49027136580747264', '1', 'SYS_MENU', '48892124845834240', '{\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_ORDER\":30,\"SM_CODE\":\"STUDENT:BASE\",\"SM_NAME\":\"学生管理\",\"SM_PARENTID\":\"0\",\"SPD_ID\":\"\",\"ID\":\"48892124845834240\",\"SC_ID\":\"48890586014416896\",\"SM_CLASSICON\":\"mdi mdi-account-multiple-outline\",\"SM_IS_EXPAND\":\"\"}', '{\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_ORDER\":\"1\",\"SM_CODE\":\"STUDENT:BASE\",\"SM_NAME\":\"学生管理\",\"SM_PARENTID\":\"49027088874733568\",\"SPD_ID\":\"\",\"ID\":\"48892124845834240\",\"SC_ID\":\"48890586014416896\",\"SM_CLASSICON\":\"mdi mdi-account-multiple-outline\",\"SM_IS_EXPAND\":\"\"}', '2018-08-07 23:10:09', 2);
INSERT INTO `sys_value_record` VALUES ('49027774630854656', '1', 'SYS_MENU', '49027774555357184', NULL, '{\"SM_URL\":\"\",\"SVR_TABLE_NAME\":\"SYS_MENU\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":\"10\",\"SM_CODE\":\"STUDENT:ATTENDANCE\",\"SM_NAME\":\"考勤管理\",\"SM_PARENTID\":\"49027088874733568\",\"SPD_ID\":\"\",\"ID\":\"49027774555357184\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-book-open\",\"SM_IS_EXPAND\":\"\"}', '2018-08-07 23:12:41', 1);
INSERT INTO `sys_value_record` VALUES ('49027832176705536', '1', 'SYS_MENU', '49027774555357184', '{\"SM_URL\":\"\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_ORDER\":10,\"SM_CODE\":\"STUDENT:ATTENDANCE\",\"SM_NAME\":\"考勤管理\",\"SM_PARENTID\":\"49027088874733568\",\"SPD_ID\":\"\",\"ID\":\"49027774555357184\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-book-open\",\"SM_IS_EXPAND\":\"\"}', '{\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_ORDER\":\"10\",\"SM_CODE\":\"STUDENT:ATTENDANCE\",\"SM_NAME\":\"考勤管理\",\"SM_PARENTID\":\"49027088874733568\",\"SPD_ID\":\"\",\"ID\":\"49027774555357184\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-book-open\",\"SM_IS_EXPAND\":\"\"}', '2018-08-07 23:12:55', 2);
INSERT INTO `sys_value_record` VALUES ('49028146313297920', '1', 'SYS_MENU', '49028146267160576', NULL, '{\"SM_URL\":\"admin/dataGrid/\",\"SVR_TABLE_NAME\":\"SYS_MENU\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":\"20\",\"SM_CODE\":\"STUDENT:PUNISHMENT\",\"SM_NAME\":\"处分管理\",\"SM_PARENTID\":\"49027088874733568\",\"SPD_ID\":\"\",\"ID\":\"49028146267160576\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-book-multiple\",\"SM_IS_EXPAND\":\"\"}', '2018-08-07 23:14:10', 1);
INSERT INTO `sys_value_record` VALUES ('49028916626587648', '1', 'SYS_BUTTON', '49028916572061696', NULL, '{\"SB_CODE\":\"REVOKE\",\"SVR_TABLE_NAME\":\"SYS_BUTTON\",\"SB_FUNC\":\"\",\"SB_CLASS\":\"btn btn-danger\",\"SB_ORDER\":\"97\",\"SB_BUTTONID\":\"revoke\",\"SB_ICON\":\"mdi mdi-backburger\",\"ID\":\"49028916572061696\",\"SB_TYPE\":\"1\",\"SB_NAME\":\"撤销\"}', '2018-08-07 23:17:14', 1);
INSERT INTO `sys_value_record` VALUES ('49029176446943232', '1', 'SYS_MENU', '49029176400805888', NULL, '{\"SM_URL\":\"\",\"SVR_TABLE_NAME\":\"SYS_MENU\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":\"1\",\"SM_CODE\":\"STUDENT:ATTENDANCE_UPDATE\",\"SM_NAME\":\"编辑\",\"SM_PARENTID\":\"49027774555357184\",\"SPD_ID\":\"\",\"ID\":\"49029176400805888\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '2018-08-07 23:18:15', 1);
INSERT INTO `sys_value_record` VALUES ('49029256671395840', '1', 'SYS_MENU', '49029256612675584', NULL, '{\"SM_URL\":\"\",\"SVR_TABLE_NAME\":\"SYS_MENU\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":\"1\",\"SM_CODE\":\"STUDENT:PUNISHMENT_UPDATE\",\"SM_NAME\":\"编辑\",\"SM_PARENTID\":\"49028146267160576\",\"SPD_ID\":\"\",\"ID\":\"49029256612675584\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '2018-08-07 23:18:35', 1);
INSERT INTO `sys_value_record` VALUES ('49030149726797824', '1', 'SYS_MENU', '49030149684854784', NULL, '{\"SM_URL\":\"\",\"SVR_TABLE_NAME\":\"SYS_MENU\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":\"20\",\"SM_CODE\":\"\",\"SM_NAME\":\"迟到旷课处分配置\",\"SM_PARENTID\":\"21130604443598848\",\"SPD_ID\":\"\",\"ID\":\"49030149684854784\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '2018-08-07 23:22:08', 1);
INSERT INTO `sys_value_record` VALUES ('49030571317264384', '1', 'SYS_MENU', '49030149684854784', '{\"SM_URL\":\"\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_ORDER\":20,\"SM_CODE\":\"\",\"SM_NAME\":\"迟到旷课处分配置\",\"SM_PARENTID\":\"21130604443598848\",\"SPD_ID\":\"\",\"ID\":\"49030149684854784\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '{\"SM_URL\":\"\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_ORDER\":\"20\",\"SM_CODE\":\"SYSTEM:ABSENTEEISM\",\"SM_NAME\":\"迟到旷课处分配置\",\"SM_PARENTID\":\"21130604443598848\",\"SPD_ID\":\"\",\"ID\":\"49030149684854784\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-close-outline\",\"SM_IS_EXPAND\":\"\"}', '2018-08-07 23:23:48', 2);
INSERT INTO `sys_value_record` VALUES ('49030661062787072', '1', 'SYS_MENU', '49030149684854784', '{\"SM_URL\":\"\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_ORDER\":20,\"SM_CODE\":\"SYSTEM:ABSENTEEISM\",\"SM_NAME\":\"迟到旷课处分配置\",\"SM_PARENTID\":\"21130604443598848\",\"SPD_ID\":\"\",\"ID\":\"49030149684854784\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-close-outline\",\"SM_IS_EXPAND\":\"\"}', '{\"SM_URL\":\"\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_ORDER\":\"20\",\"SM_CODE\":\"SYSTEM:ALLOCATION_ABSENTEEISM\",\"SM_NAME\":\"迟到旷课处分配置\",\"SM_PARENTID\":\"21130604443598848\",\"SPD_ID\":\"\",\"ID\":\"49030149684854784\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-close-outline\",\"SM_IS_EXPAND\":\"\"}', '2018-08-07 23:24:09', 2);
INSERT INTO `sys_value_record` VALUES ('49030716884779008', '1', 'SYS_MENU', '49030149684854784', '{\"SM_URL\":\"\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_ORDER\":20,\"SM_CODE\":\"SYSTEM:ALLOCATION_ABSENTEEISM\",\"SM_NAME\":\"迟到旷课处分配置\",\"SM_PARENTID\":\"21130604443598848\",\"SPD_ID\":\"\",\"ID\":\"49030149684854784\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-close-outline\",\"SM_IS_EXPAND\":\"\"}', '{\"SM_URL\":\"admin/allocation/absenteeism\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_ORDER\":\"20\",\"SM_CODE\":\"SYSTEM:ALLOCATION_ABSENTEEISM\",\"SM_NAME\":\"迟到旷课处分配置\",\"SM_PARENTID\":\"21130604443598848\",\"SPD_ID\":\"\",\"ID\":\"49030149684854784\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-close-outline\",\"SM_IS_EXPAND\":\"\"}', '2018-08-07 23:24:23', 2);
INSERT INTO `sys_value_record` VALUES ('49253522570477568', '1', 'SYS_OPERATOR', '1', '{\"SO_PASSWORD\":\"75dd1eda323cd6bbef5dd39e8d65da8b\",\"ID\":\"1\",\"IS_DEFAULT_PWD\":0,\"SO_SALT\":\"g5wH;+\"}', '{\"IS_DEFAULT_PWD\":0,\"SO_SALT\":\"fdb.4Q\",\"SO_PASSWORD\":\"3060177a2cc22475a8b9c0be4d6ba6f3\",\"ID\":\"1\"}', '2018-08-08 14:09:44', 2);
INSERT INTO `sys_value_record` VALUES ('49270789513412608', '1', 'SYS_DICT_INFO', '49270789383389184', NULL, '{\"SDI_CODE\":\"1001\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"999\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"测试流程\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"SYS_PROCESS_TYPE\",\"SDI_INNERCODE\":\"1001\",\"ID\":\"49270789383389184\",\"SDT_ID\":\"9\"}', '2018-08-08 15:18:21', 1);
INSERT INTO `sys_value_record` VALUES ('49270878097113088', '1', 'SYS_DICT_INFO', '49270878021615616', NULL, '{\"SDI_CODE\":\"1\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"1\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"测试流程2\",\"SDI_PARENTID\":\"49270789383389184\",\"IS_STATUS\":1,\"SDT_CODE\":\"SYS_PROCESS_TYPE\",\"SDI_INNERCODE\":\"1001.1\",\"ID\":\"49270878021615616\",\"SDT_ID\":\"9\"}', '2018-08-08 15:18:42', 1);
INSERT INTO `sys_value_record` VALUES ('49278839431364608', '1', 'SYS_MENU', '28019952082485248', '{\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":91,\"SM_CODE\":\"\",\"SM_NAME\":\"测试流程\",\"SM_PARENTID\":\"21130604443598848\",\"ID\":\"28019952082485248\",\"SC_ID\":\"28020396255084544\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '{\"BUS_PROCESS\":\"1001\",\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"1\",\"SM_IS_LEAF\":\"0\",\"SM_TYPE\":\"1\",\"SM_ORDER\":\"91\",\"SM_CODE\":\"\",\"SM_NAME\":\"测试流程\",\"SM_PARENTID\":\"21130604443598848\",\"ID\":\"28019952082485248\",\"SC_ID\":\"28020396255084544\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '2018-08-08 15:50:20', 2);
INSERT INTO `sys_value_record` VALUES ('49300118351904768', '1', 'sys_validate_field', '49300118259630080', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"49300118259630080\",\"SVF_NAME\":\"流程大类\",\"SVF_FIELD\":\"BUS_PROCESS\",\"SV_ID\":\"27200910899806208\",\"SVR_ID\":\"\"}', '2018-08-08 17:14:53', 1);
INSERT INTO `sys_value_record` VALUES ('49300156079669248', '1', 'sys_validate_field', '49300156033531904', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"49300156033531904\",\"SVF_NAME\":\"流程小类\",\"SVF_FIELD\":\"BUS_PROCESS2\",\"SV_ID\":\"27200910899806208\",\"SVR_ID\":\"\"}', '2018-08-08 17:15:02', 1);
INSERT INTO `sys_value_record` VALUES ('49300850404753408', '1', 'SYS_CONFIGURE_COLUMN', '26725572235231232', '{\"SCC_NAME\":\"更新表名\",\"SCC_FUNC\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"\",\"SCC_FIELD\":\"SPD_UPDATE_TABLE\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"26725572235231232\",\"SC_ID\":\"26721805670547456\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":30}', '{\"SCC_NAME\":\"更新表名\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"150px\",\"SCC_FIELD\":\"SPD_UPDATE_TABLE\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"26725572235231232\",\"SC_ID\":\"26721805670547456\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"30\"}', '2018-08-08 17:17:48', 2);
INSERT INTO `sys_value_record` VALUES ('49300881102864384', '1', 'SYS_CONFIGURE_COLUMN', '26725657031475200', '{\"SCC_NAME\":\"更新表名称字段\",\"SCC_FUNC\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"\",\"SCC_FIELD\":\"SPD_UPDATE_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"26725657031475200\",\"SC_ID\":\"26721805670547456\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":40}', '{\"SCC_NAME\":\"更新表名称字段\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"SPD_UPDATE_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"26725657031475200\",\"SC_ID\":\"26721805670547456\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"40\"}', '2018-08-08 17:17:55', 2);
INSERT INTO `sys_value_record` VALUES ('49300938191536128', '1', 'SYS_CONFIGURE_COLUMN', '49300938162176000', NULL, '{\"SCC_NAME\":\"大类\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"50px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"49300938162176000\",\"SC_ID\":\"26721805670547456\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"45\"}', '2018-08-08 17:18:09', 1);
INSERT INTO `sys_value_record` VALUES ('49301009796694016', '1', 'SYS_CONFIGURE_COLUMN', '49301009763139584', NULL, '{\"SCC_NAME\":\"小类\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"50px\",\"SCC_FIELD\":\"BUS_PROCESS2\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"49301009763139584\",\"SC_ID\":\"26721805670547456\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"46\"}', '2018-08-08 17:18:26', 1);
INSERT INTO `sys_value_record` VALUES ('49301036002705408', '1', 'SYS_CONFIGURE_COLUMN', '49300938162176000', '{\"SCC_NAME\":\"大类\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"50px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"49300938162176000\",\"SC_ID\":\"26721805670547456\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":45}', '{\"SCC_NAME\":\"大类\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"50px\",\"SCC_FIELD\":\"BUS_PROCESS\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"49300938162176000\",\"SC_ID\":\"26721805670547456\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"45\"}', '2018-08-08 17:18:32', 2);
INSERT INTO `sys_value_record` VALUES ('49301852696608768', '1', 'SYS_DICT_INFO', '49301852625305600', NULL, '{\"SDI_CODE\":\"2\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"2\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"测试流程3\",\"SDI_PARENTID\":\"49270789383389184\",\"IS_STATUS\":1,\"SDT_CODE\":\"SYS_PROCESS_TYPE\",\"SDI_INNERCODE\":\"1001.2\",\"ID\":\"49301852625305600\",\"SDT_ID\":\"9\"}', '2018-08-08 17:21:47', 1);
INSERT INTO `sys_value_record` VALUES ('49301917112729600', '1', 'SYS_DICT_INFO', '49301917020454912', NULL, '{\"SDI_CODE\":\"1002\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"1002\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"测试2\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"SYS_PROCESS_TYPE\",\"SDI_INNERCODE\":\"1002\",\"ID\":\"49301917020454912\",\"SDT_ID\":\"9\"}', '2018-08-08 17:22:02', 1);
INSERT INTO `sys_value_record` VALUES ('49302016786169856', '1', 'SYS_CONFIGURE_COLUMN', '2913742199193600', '{\"SCC_NAME\":\"状态\",\"SCC_FUNC\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"1\",\"SCC_WIDTH\":\"30px\",\"SCC_FIELD\":\"IS_STATUS\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"2913742199193600\",\"SC_ID\":\"2912701923721216\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":6}', '{\"SCC_NAME\":\"状态\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"1\",\"SCC_WIDTH\":\"50px\",\"SCC_FIELD\":\"IS_STATUS\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"2913742199193600\",\"SC_ID\":\"2912701923721216\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"6\"}', '2018-08-08 17:22:26', 2);
INSERT INTO `sys_value_record` VALUES ('49302096935124992', '1', 'SYS_CONFIGURE_COLUMN', '2913742199193600', '{\"SCC_NAME\":\"状态\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"1\",\"SCC_WIDTH\":\"50px\",\"SCC_FIELD\":\"IS_STATUS\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"2913742199193600\",\"SC_ID\":\"2912701923721216\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":6}', '{\"SCC_NAME\":\"状态\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"1\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"IS_STATUS\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"2913742199193600\",\"SC_ID\":\"2912701923721216\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"6\"}', '2018-08-08 17:22:45', 2);
INSERT INTO `sys_value_record` VALUES ('49302133865971712', '1', 'SYS_CONFIGURE_COLUMN', '2913660032778240', '{\"SCC_NAME\":\"排序\",\"SCC_FUNC\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"30px\",\"SCC_FIELD\":\"SDI_ORDER\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"2913660032778240\",\"SC_ID\":\"2912701923721216\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":5}', '{\"SCC_NAME\":\"排序\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"50px\",\"SCC_FIELD\":\"SDI_ORDER\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"2913660032778240\",\"SC_ID\":\"2912701923721216\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"5\"}', '2018-08-08 17:22:54', 2);
INSERT INTO `sys_value_record` VALUES ('49302166090809344', '1', 'SYS_CONFIGURE_COLUMN', '2913416456962048', '{\"SCC_NAME\":\"信息编码\",\"SCC_FUNC\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"\",\"SCC_FIELD\":\"SDI_CODE\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"2913416456962048\",\"SC_ID\":\"2912701923721216\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":2}', '{\"SCC_NAME\":\"信息编码\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"SDI_CODE\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"2913416456962048\",\"SC_ID\":\"2912701923721216\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"2\"}', '2018-08-08 17:23:01', 2);
INSERT INTO `sys_value_record` VALUES ('49302184038236160', '1', 'SYS_CONFIGURE_COLUMN', '2913455988277248', '{\"SCC_NAME\":\"连接编码\",\"SCC_FUNC\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"\",\"SCC_FIELD\":\"SDI_INNERCODE\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"2913455988277248\",\"SC_ID\":\"2912701923721216\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":3}', '{\"SCC_NAME\":\"连接编码\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"SDI_INNERCODE\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"2913455988277248\",\"SC_ID\":\"2912701923721216\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"3\"}', '2018-08-08 17:23:06', 2);
INSERT INTO `sys_value_record` VALUES ('49302304418955264', '1', 'SYS_DICT_INFO', '49302304356040704', NULL, '{\"SDI_CODE\":\"1\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"1\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"测试2.1\",\"SDI_PARENTID\":\"49301917020454912\",\"IS_STATUS\":1,\"SDT_CODE\":\"SYS_PROCESS_TYPE\",\"SDI_INNERCODE\":\"1002.2\",\"ID\":\"49302304356040704\",\"SDT_ID\":\"9\"}', '2018-08-08 17:23:34', 1);
INSERT INTO `sys_value_record` VALUES ('49302833710759936', '1', 'SYS_DICT_INFO', '49302304356040704', '{\"SDI_CODE\":\"1\",\"IS_STATUS\":1,\"SDT_CODE\":\"SYS_PROCESS_TYPE\",\"SDI_REQUIRED\":0,\"SDI_INNERCODE\":\"1002.2\",\"SDI_ORDER\":1,\"SDI_REMARK\":\"\",\"SDI_NAME\":\"测试2.1\",\"ID\":\"49302304356040704\",\"SDI_PARENTID\":\"49301917020454912\",\"SDT_ID\":\"9\"}', '{\"SDI_CODE\":\"2003\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"1\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"测试2.1\",\"SDI_PARENTID\":\"49301917020454912\",\"SDI_INNERCODE\":\"1002.2003\",\"ID\":\"49302304356040704\",\"SDT_ID\":\"9\"}', '2018-08-08 17:25:40', 2);
INSERT INTO `sys_value_record` VALUES ('49302862689206272', '1', 'SYS_DICT_INFO', '49301852625305600', '{\"SDI_CODE\":\"2\",\"IS_STATUS\":1,\"SDT_CODE\":\"SYS_PROCESS_TYPE\",\"SDI_REQUIRED\":0,\"SDI_INNERCODE\":\"1001.2\",\"SDI_ORDER\":2,\"SDI_REMARK\":\"\",\"SDI_NAME\":\"测试流程3\",\"ID\":\"49301852625305600\",\"SDI_PARENTID\":\"49270789383389184\",\"SDT_ID\":\"9\"}', '{\"SDI_CODE\":\"2002\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"2\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"测试流程3\",\"SDI_PARENTID\":\"49270789383389184\",\"SDI_INNERCODE\":\"1001.2002\",\"ID\":\"49301852625305600\",\"SDT_ID\":\"9\"}', '2018-08-08 17:25:47', 2);
INSERT INTO `sys_value_record` VALUES ('49302884759633920', '1', 'SYS_DICT_INFO', '49270878021615616', '{\"SDI_CODE\":\"1\",\"IS_STATUS\":1,\"SDT_CODE\":\"SYS_PROCESS_TYPE\",\"SDI_REQUIRED\":0,\"SDI_INNERCODE\":\"1001.1\",\"SDI_ORDER\":1,\"SDI_REMARK\":\"\",\"SDI_NAME\":\"测试流程2\",\"ID\":\"49270878021615616\",\"SDI_PARENTID\":\"49270789383389184\",\"SDT_ID\":\"9\"}', '{\"SDI_CODE\":\"2001\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"1\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"测试流程2\",\"SDI_PARENTID\":\"49270789383389184\",\"SDI_INNERCODE\":\"1001.2001\",\"ID\":\"49270878021615616\",\"SDT_ID\":\"9\"}', '2018-08-08 17:25:53', 2);
INSERT INTO `sys_value_record` VALUES ('49303012715266048', '1', 'SYS_MENU', '28019952082485248', '{\"BUS_PROCESS\":\"1001\",\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"1\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":91,\"SM_CODE\":\"\",\"SM_NAME\":\"测试流程\",\"SM_PARENTID\":\"21130604443598848\",\"ID\":\"28019952082485248\",\"SC_ID\":\"28020396255084544\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '{\"BUS_PROCESS\":\"1001\",\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"2001\",\"SM_IS_LEAF\":\"0\",\"SM_TYPE\":\"1\",\"SM_ORDER\":\"91\",\"SM_CODE\":\"\",\"SM_NAME\":\"测试流程\",\"SM_PARENTID\":\"21130604443598848\",\"ID\":\"28019952082485248\",\"SC_ID\":\"28020396255084544\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '2018-08-08 17:26:23', 2);
INSERT INTO `sys_value_record` VALUES ('49304061106716672', '1', 'SYS_PROCESS_DEFINITION', '26816452786913280', '{\"SR_ID\":\"1\",\"SO_ID\":\"1\",\"SPD_DESCRIBE\":\"测试流程\",\"IS_STATUS\":1,\"SPD_UPDATE_TABLE\":\"TEST_PROCESS\",\"IS_MULTISTAGE_BACK\":1,\"SPD_VERSION\":\"1.0\",\"SDP_ENTRY_TIME\":\"2018-06-07 16:12:49\",\"ID\":\"26816452786913280\",\"SPD_UPDATE_NAME\":\"NAME\",\"SPD_NAME\":\"测试流程\"}', '{\"SR_ID\":\"1\",\"SPD_DIVISION_FIELD\":\"\",\"SPD_DESCRIBE\":\"测试流程\",\"SPD_DEPARTMENT_FIELD\":\"\",\"SPD_UPDATE_TABLE\":\"TEST_PROCESS\",\"IS_MULTISTAGE_BACK\":\"1\",\"SPD_VERSION\":\"1.0\",\"ID\":\"26816452786913280\",\"SPD_UPDATE_NAME\":\"NAME\",\"SPD_NAME\":\"测试流程\"}', '2018-08-08 17:30:33', 2);
INSERT INTO `sys_value_record` VALUES ('49305319209172992', '1', 'SYS_PROCESS_DEFINITION', '26816452786913280', '{\"SR_ID\":\"1\",\"SPD_DIVISION_FIELD\":\"\",\"SO_ID\":\"1\",\"SPD_DESCRIBE\":\"测试流程\",\"IS_STATUS\":1,\"SPD_DEPARTMENT_FIELD\":\"\",\"SPD_UPDATE_TABLE\":\"TEST_PROCESS\",\"IS_MULTISTAGE_BACK\":1,\"SPD_VERSION\":\"1.0\",\"SDP_ENTRY_TIME\":\"2018-06-07 16:12:49\",\"ID\":\"26816452786913280\",\"SPD_UPDATE_NAME\":\"NAME\",\"SPD_NAME\":\"测试流程\"}', '{\"BUS_PROCESS\":\"1001\",\"SR_ID\":\"1\",\"SPD_DIVISION_FIELD\":\"\",\"SPD_DESCRIBE\":\"测试流程\",\"BUS_PROCESS2\":\"2001\",\"SPD_DEPARTMENT_FIELD\":\"\",\"SPD_UPDATE_TABLE\":\"TEST_PROCESS\",\"IS_MULTISTAGE_BACK\":\"1\",\"SPD_VERSION\":\"1.0\",\"ID\":\"26816452786913280\",\"SPD_UPDATE_NAME\":\"NAME\",\"SPD_NAME\":\"测试流程\"}', '2018-08-08 17:35:33', 2);
INSERT INTO `sys_value_record` VALUES ('49305340709175296', '1', 'SYS_PROCESS_DEFINITION', '26816452786913280', '{\"BUS_PROCESS\":\"1001\",\"SR_ID\":\"1\",\"SPD_DIVISION_FIELD\":\"\",\"SO_ID\":\"1\",\"SPD_DESCRIBE\":\"测试流程\",\"BUS_PROCESS2\":\"2001\",\"IS_STATUS\":1,\"SPD_DEPARTMENT_FIELD\":\"\",\"SPD_UPDATE_TABLE\":\"TEST_PROCESS\",\"IS_MULTISTAGE_BACK\":1,\"SPD_VERSION\":\"1.0\",\"SDP_ENTRY_TIME\":\"2018-06-07 16:12:49\",\"ID\":\"26816452786913280\",\"SPD_UPDATE_NAME\":\"NAME\",\"SPD_NAME\":\"测试流程\"}', '{\"BUS_PROCESS\":\"1001\",\"SR_ID\":\"1\",\"SPD_DIVISION_FIELD\":\"\",\"SPD_DESCRIBE\":\"测试流程\",\"BUS_PROCESS2\":\"2001\",\"SPD_DEPARTMENT_FIELD\":\"\",\"SPD_UPDATE_TABLE\":\"TEST_PROCESS\",\"IS_MULTISTAGE_BACK\":\"1\",\"SPD_VERSION\":\"1.0\",\"ID\":\"26816452786913280\",\"SPD_UPDATE_NAME\":\"NAME\",\"SPD_NAME\":\"测试流程\"}', '2018-08-08 17:35:38', 2);
INSERT INTO `sys_value_record` VALUES ('49305342944739328', '1', 'SYS_PROCESS_DEFINITION', '26816452786913280', '{\"BUS_PROCESS\":\"1001\",\"SR_ID\":\"1\",\"SPD_DIVISION_FIELD\":\"\",\"SO_ID\":\"1\",\"SPD_DESCRIBE\":\"测试流程\",\"BUS_PROCESS2\":\"2001\",\"IS_STATUS\":1,\"SPD_DEPARTMENT_FIELD\":\"\",\"SPD_UPDATE_TABLE\":\"TEST_PROCESS\",\"IS_MULTISTAGE_BACK\":1,\"SPD_VERSION\":\"1.0\",\"SDP_ENTRY_TIME\":\"2018-06-07 16:12:49\",\"ID\":\"26816452786913280\",\"SPD_UPDATE_NAME\":\"NAME\",\"SPD_NAME\":\"测试流程\"}', '{\"BUS_PROCESS\":\"1001\",\"SR_ID\":\"1\",\"SPD_DIVISION_FIELD\":\"\",\"SPD_DESCRIBE\":\"测试流程\",\"BUS_PROCESS2\":\"2001\",\"SPD_DEPARTMENT_FIELD\":\"\",\"SPD_UPDATE_TABLE\":\"TEST_PROCESS\",\"IS_MULTISTAGE_BACK\":\"1\",\"SPD_VERSION\":\"1.0\",\"ID\":\"26816452786913280\",\"SPD_UPDATE_NAME\":\"NAME\",\"SPD_NAME\":\"测试流程\"}', '2018-08-08 17:35:39', 2);
INSERT INTO `sys_value_record` VALUES ('49312431737929728', '1', 'SYS_MENU', '28019952082485248', '{\"BUS_PROCESS\":\"1001\",\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"2001\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":91,\"SM_CODE\":\"\",\"SM_NAME\":\"测试流程\",\"SM_PARENTID\":\"21130604443598848\",\"ID\":\"28019952082485248\",\"SC_ID\":\"28020396255084544\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '{\"BUS_PROCESS\":\"1001\",\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"2001\",\"SM_IS_LEAF\":\"0\",\"SM_TYPE\":\"1\",\"SM_ORDER\":\"91\",\"SM_CODE\":\"\",\"SM_NAME\":\"测试流程\",\"SM_PARENTID\":\"21130604443598848\",\"ID\":\"28019952082485248\",\"SC_ID\":\"28020396255084544\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '2018-08-08 18:03:49', 2);
INSERT INTO `sys_value_record` VALUES ('49313211857502208', '1', 'SYS_PROCESS_DEFINITION', '26816452786913280', '{\"IS_STATUS\":1,\"ID\":\"26816452786913280\"}', '{\"IS_STATUS\":\"0\",\"ID\":\"26816452786913280\"}', '2018-08-08 18:06:55', 2);
INSERT INTO `sys_value_record` VALUES ('49313222615891968', '1', 'SYS_PROCESS_DEFINITION', '26816452786913280', '{\"IS_STATUS\":0,\"ID\":\"26816452786913280\"}', '{\"IS_STATUS\":\"1\",\"ID\":\"26816452786913280\"}', '2018-08-08 18:06:57', 2);
INSERT INTO `sys_value_record` VALUES ('49321964543672320', '4112733112893440', 'SYS_OPERATOR', '4112733112893440', '{\"SO_PASSWORD\":\"0b332f7310964946a1db499364969605\",\"ID\":\"4112733112893440\",\"IS_DEFAULT_PWD\":1,\"SO_SALT\":\"yhUNFI\"}', '{\"IS_DEFAULT_PWD\":0,\"SO_SALT\":\".7HXge\",\"SO_PASSWORD\":\"b922b9e424696e55714bb107f6ece83a\",\"ID\":\"4112733112893440\"}', '2018-08-08 18:41:42', 2);
INSERT INTO `sys_value_record` VALUES ('49341093455593472', '4112733112893440', 'SYS_PROCESS_SCHEDULE', '33410262795026432', '{\"SPS_PREV_STEP_ID\":\"27652330522411008\",\"SPS_STEP_TRANSACTOR\":\"4112733112893440\",\"SPS_BACK_STATUS\":1,\"SO_ID\":\"4112733112893440\",\"SPS_STEP_TYPE\":2,\"SPS_TABLE_NAME\":\"测试流程1\",\"SPS_BACK_STATUS_TRANSACTOR\":0,\"SPS_PREV_STEP_TRANSACTOR\":\"28281967912943616\",\"SPS_ID\":\"27652261702270976\",\"SPS_PREV_STEP_TYPE\":1,\"SPS_AUDIT_STATUS\":-1,\"SPS_PREV_AUDIT_STATUS\":2,\"SPS_TABLE_ID\":\"1\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33410262795026432\"}', '{\"SPS_PREV_STEP_ID\":\"27650461607657472\",\"SPS_STEP_TRANSACTOR\":\"27635893028257792\",\"SPS_BACK_STATUS\":\"0\",\"SO_ID\":\"4112733112893440\",\"SPS_STEP_TYPE\":\"1\",\"SPS_TABLE_NAME\":\"测试流程1\",\"SPS_BACK_STATUS_TRANSACTOR\":\"-1\",\"SPS_PREV_STEP_TRANSACTOR\":\"4112733112893440\",\"SPS_ID\":\"27652261702270976\",\"SPS_PREV_STEP_TYPE\":\"0\",\"SPS_AUDIT_STATUS\":\"1\",\"SPS_PREV_AUDIT_STATUS\":-1,\"SPS_TABLE_ID\":\"1\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33410262795026432\"}', '2018-08-08 19:57:42', 2);
INSERT INTO `sys_value_record` VALUES ('49341106931892224', '4112733112893440', 'SYS_PROCESS_SCHEDULE', '33410262795026432', '{\"SPS_PREV_STEP_ID\":\"27650461607657472\",\"SPS_STEP_TRANSACTOR\":\"27635893028257792\",\"SPS_BACK_STATUS\":0,\"SO_ID\":\"4112733112893440\",\"SPS_STEP_TYPE\":1,\"SPS_TABLE_NAME\":\"测试流程1\",\"SPS_BACK_STATUS_TRANSACTOR\":-1,\"SPS_PREV_STEP_TRANSACTOR\":\"4112733112893440\",\"SPS_ID\":\"27652261702270976\",\"SPS_PREV_STEP_TYPE\":0,\"SPS_AUDIT_STATUS\":1,\"SPS_PREV_AUDIT_STATUS\":-1,\"SPS_TABLE_ID\":\"1\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33410262795026432\"}', '{\"SPS_PREV_STEP_ID\":\"27652261702270976\",\"SPS_STEP_TRANSACTOR\":\"4112733112893440\",\"SPS_BACK_STATUS\":\"2\",\"SO_ID\":\"4112733112893440\",\"SPS_STEP_TYPE\":2,\"SPS_TABLE_NAME\":\"测试流程1\",\"SPS_BACK_STATUS_TRANSACTOR\":0,\"SPS_PREV_STEP_TRANSACTOR\":\"4112733112893440\",\"SPS_ID\":\"27650461607657472\",\"SPS_PREV_STEP_TYPE\":\"2\",\"SPS_AUDIT_STATUS\":-1,\"SPS_PREV_AUDIT_STATUS\":1,\"SPS_TABLE_ID\":\"1\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33410262795026432\"}', '2018-08-08 19:57:46', 2);
INSERT INTO `sys_value_record` VALUES ('49341120500465664', '4112733112893440', 'SYS_PROCESS_SCHEDULE', '33410262795026432', '{\"SPS_PREV_STEP_ID\":\"27652261702270976\",\"SPS_STEP_TRANSACTOR\":\"4112733112893440\",\"SPS_BACK_STATUS\":2,\"SO_ID\":\"4112733112893440\",\"SPS_STEP_TYPE\":2,\"SPS_TABLE_NAME\":\"测试流程1\",\"SPS_BACK_STATUS_TRANSACTOR\":0,\"SPS_PREV_STEP_TRANSACTOR\":\"4112733112893440\",\"SPS_ID\":\"27650461607657472\",\"SPS_PREV_STEP_TYPE\":2,\"SPS_AUDIT_STATUS\":-1,\"SPS_PREV_AUDIT_STATUS\":1,\"SPS_TABLE_ID\":\"1\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33410262795026432\"}', '{\"SPS_PREV_STEP_ID\":\"27650461607657472\",\"SPS_STEP_TRANSACTOR\":\"27635893028257792\",\"SPS_BACK_STATUS\":\"0\",\"SO_ID\":\"4112733112893440\",\"SPS_STEP_TYPE\":\"1\",\"SPS_TABLE_NAME\":\"测试流程1\",\"SPS_BACK_STATUS_TRANSACTOR\":\"-1\",\"SPS_PREV_STEP_TRANSACTOR\":\"4112733112893440\",\"SPS_ID\":\"27652261702270976\",\"SPS_PREV_STEP_TYPE\":\"0\",\"SPS_AUDIT_STATUS\":\"1\",\"SPS_PREV_AUDIT_STATUS\":-1,\"SPS_TABLE_ID\":\"1\",\"SPD_ID\":\"26816452786913280\",\"ID\":\"33410262795026432\"}', '2018-08-08 19:57:49', 2);
INSERT INTO `sys_value_record` VALUES ('49377509422137344', '1', 'SYS_DICT_TYPE', '49377509363417088', NULL, '{\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"SYS_DICT_TYPE\",\"SDT_CODE\":\"BUS_SEMESTER\",\"SDT_ROLE_DEL\":\"\",\"SDT_NAME\":\"业务_学期\",\"ID\":\"49377509363417088\",\"SDT_ROLE_DOWN\":\"\"}', '2018-08-08 22:22:25', 1);
INSERT INTO `sys_value_record` VALUES ('49377568339525632', '1', 'SYS_DICT_INFO', '49377568205307904', NULL, '{\"SDI_CODE\":\"1\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"1\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"上学期\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_SEMESTER\",\"SDI_INNERCODE\":\"1\",\"ID\":\"49377568205307904\",\"SDT_ID\":\"49377509363417088\"}', '2018-08-08 22:22:39', 1);
INSERT INTO `sys_value_record` VALUES ('49377596105818112', '1', 'SYS_DICT_INFO', '49377596051292160', NULL, '{\"SDI_CODE\":\"2\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"2\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"下学期\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_SEMESTER\",\"SDI_INNERCODE\":\"2\",\"ID\":\"49377596051292160\",\"SDT_ID\":\"49377509363417088\"}', '2018-08-08 22:22:45', 1);
INSERT INTO `sys_value_record` VALUES ('49382295752146944', '1', 'SYS_VALIDATE', '49382295680843776', NULL, '{\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"SYS_VALIDATE\",\"ID\":\"49382295680843776\",\"SV_TABLE\":\"BUS_STUDENT_ATTENDANCE\"}', '2018-08-08 22:41:26', 1);
INSERT INTO `sys_value_record` VALUES ('49382371547414528', '1', 'sys_validate_field', '49382371346087936', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"49382371346087936\",\"SVF_NAME\":\"年度\",\"SVF_FIELD\":\"BSA_YEAR\",\"SV_ID\":\"49382295680843776\",\"SVR_ID\":\"26504926733533184\"}', '2018-08-08 22:41:44', 1);
INSERT INTO `sys_value_record` VALUES ('49382410046930944', '1', 'sys_validate_field', '49382409992404992', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"1\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"49382409992404992\",\"SVF_NAME\":\"学期\",\"SVF_FIELD\":\"BSA_SEMESTER\",\"SV_ID\":\"49382295680843776\",\"SVR_ID\":\"\"}', '2018-08-08 22:41:53', 1);
INSERT INTO `sys_value_record` VALUES ('49382467454369792', '1', 'sys_validate_field', '49382467320152064', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"3\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"49382467320152064\",\"SVF_NAME\":\"迟到节数\",\"SVF_FIELD\":\"BSA_LATE\",\"SV_ID\":\"49382295680843776\",\"SVR_ID\":\"2510375538917376\"}', '2018-08-08 22:42:07', 1);
INSERT INTO `sys_value_record` VALUES ('49382552703598592', '1', 'sys_validate_field', '49382552611323904', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"3\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"49382552611323904\",\"SVF_NAME\":\"旷课节数\",\"SVF_FIELD\":\"BSA_ABSENTEEISM\",\"SV_ID\":\"49382295680843776\",\"SVR_ID\":\"2510375538917376\"}', '2018-08-08 22:42:27', 1);
INSERT INTO `sys_value_record` VALUES ('49382845084336128', '1', 'SYS_CONFIGURE', '48890586014416896', '{\"SC_IS_PAGING\":\"1\",\"SC_NAME\":\"基础信息管理-学生管理\",\"SC_JSP\":\"admin/info/student/home\",\"SC_VIEW\":\"v_student\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"48890586014416896\",\"SC_ORDER_BY\":\"CONVERT(ID,SIGNED) DESC\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '{\"SC_NAME\":\"学生管理\",\"SC_JSP\":\"admin/info/student/home\",\"SC_VIEW\":\"v_student\",\"SC_ORDER_BY\":\"CONVERT(ID,SIGNED) DESC\",\"SC_IS_PAGING\":\"1\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"48890586014416896\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '2018-08-08 22:43:37', 2);
INSERT INTO `sys_value_record` VALUES ('49382988445646848', '1', 'SYS_CONFIGURE', '49382988399509504', NULL, '{\"SC_IS_PAGING\":\"1\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE\",\"SC_NAME\":\"学生管理-考勤管理\",\"SC_JSP\":\"admin/student/attendance/home\",\"SC_VIEW\":\"v_student_attendance\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"49382988399509504\",\"SC_ORDER_BY\":\"\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '2018-08-08 22:44:11', 1);
INSERT INTO `sys_value_record` VALUES ('49383009492664320', '1', 'SYS_CONFIGURE', '48890586014416896', '{\"SC_IS_PAGING\":\"1\",\"SC_NAME\":\"学生管理\",\"SC_JSP\":\"admin/info/student/home\",\"SC_VIEW\":\"v_student\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"48890586014416896\",\"SC_ORDER_BY\":\"CONVERT(ID,SIGNED) DESC\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '{\"SC_NAME\":\"学生管理\",\"SC_JSP\":\"admin/student/student/home\",\"SC_VIEW\":\"v_student\",\"SC_ORDER_BY\":\"CONVERT(ID,SIGNED) DESC\",\"SC_IS_PAGING\":\"1\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"48890586014416896\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '2018-08-08 22:44:16', 2);
INSERT INTO `sys_value_record` VALUES ('49383089398349824', '1', 'SYS_CONFIGURE', '49382988399509504', '{\"SC_IS_PAGING\":\"1\",\"SC_NAME\":\"学生管理-考勤管理\",\"SC_JSP\":\"admin/student/attendance/home\",\"SC_VIEW\":\"v_student_attendance\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"49382988399509504\",\"SC_ORDER_BY\":\"\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '{\"SC_NAME\":\"学生管理-考勤管理\",\"SC_JSP\":\"admin/student/attendance/home\",\"SC_VIEW\":\"v_student_attendance\",\"SC_ORDER_BY\":\"CONVERT(ID,SIGNED) DESC\",\"SC_IS_PAGING\":\"1\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"49382988399509504\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '2018-08-08 22:44:35', 2);
INSERT INTO `sys_value_record` VALUES ('49383206226493440', '1', 'SYS_CONFIGURE_COLUMN', '49383206146801664', NULL, '{\"SCC_NAME\":\"学生\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"BS_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"49383206146801664\",\"SC_ID\":\"49382988399509504\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"1\"}', '2018-08-08 22:45:03', 1);
INSERT INTO `sys_value_record` VALUES ('49383278221721600', '1', 'SYS_CONFIGURE_COLUMN', '49383278167195648', NULL, '{\"SCC_NAME\":\"班级\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"left\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"170px\",\"SCC_FIELD\":\"BC_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"49383278167195648\",\"SC_ID\":\"49382988399509504\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"10\"}', '2018-08-08 22:45:20', 1);
INSERT INTO `sys_value_record` VALUES ('49383375521185792', '1', 'SYS_CONFIGURE_COLUMN', '49383375462465536', NULL, '{\"SCC_NAME\":\"年度\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"70px\",\"SCC_FIELD\":\"BSA_YEAR\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"49383375462465536\",\"SC_ID\":\"49382988399509504\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"20\"}', '2018-08-08 22:45:43', 1);
INSERT INTO `sys_value_record` VALUES ('49383479799971840', '1', 'SYS_CONFIGURE_COLUMN', '49383479741251584', NULL, '{\"SCC_NAME\":\"学期\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"70px\",\"SCC_FIELD\":\"BSA_SEMESTER\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"49383479741251584\",\"SC_ID\":\"49382988399509504\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"BUS_SEMESTER\",\"SCC_ORDER\":\"30\"}', '2018-08-08 22:46:08', 1);
INSERT INTO `sys_value_record` VALUES ('49383534120402944', '1', 'SYS_CONFIGURE_COLUMN', '49383534061682688', NULL, '{\"SCC_NAME\":\"迟到节数\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"BSA_LATE\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"49383534061682688\",\"SC_ID\":\"49382988399509504\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"40\"}', '2018-08-08 22:46:21', 1);
INSERT INTO `sys_value_record` VALUES ('49383601078272000', '1', 'SYS_CONFIGURE_COLUMN', '49383601019551744', NULL, '{\"SCC_NAME\":\"旷节数\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"BSA_ABSENTEEISM\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"49383601019551744\",\"SC_ID\":\"49382988399509504\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"50\"}', '2018-08-08 22:46:37', 1);
INSERT INTO `sys_value_record` VALUES ('49383646041210880', '1', 'SYS_CONFIGURE_COLUMN', '49383645982490624', NULL, '{\"SCC_NAME\":\"操作\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"70px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"49383645982490624\",\"SC_ID\":\"49382988399509504\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"60\"}', '2018-08-08 22:46:48', 1);
INSERT INTO `sys_value_record` VALUES ('49384084513751040', '1', 'SYS_MENU', '49027774555357184', '{\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":10,\"SM_CODE\":\"STUDENT:ATTENDANCE\",\"SM_NAME\":\"考勤管理\",\"SM_PARENTID\":\"49027088874733568\",\"ID\":\"49027774555357184\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-book-open\",\"SM_IS_EXPAND\":\"\"}', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_TYPE\":\"1\",\"SM_ORDER\":\"10\",\"SM_CODE\":\"STUDENT:ATTENDANCE\",\"SM_NAME\":\"考勤管理\",\"SM_PARENTID\":\"49027088874733568\",\"ID\":\"49027774555357184\",\"SC_ID\":\"49382988399509504\",\"SM_CLASSICON\":\"mdi mdi-book-open\",\"SM_IS_EXPAND\":\"\"}', '2018-08-08 22:48:32', 2);
INSERT INTO `sys_value_record` VALUES ('49385468067840000', '1', 'sys_validate_field', '49385467933622272', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"2\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"49385467933622272\",\"SVF_NAME\":\"周\",\"SVF_FIELD\":\"BSA_WEEK\",\"SV_ID\":\"49382295680843776\",\"SVR_ID\":\"2510375538917376\"}', '2018-08-08 22:54:02', 1);
INSERT INTO `sys_value_record` VALUES ('49395918251753472', '1', 'sys_validate_field', '49395918151090176', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"49395918151090176\",\"SVF_NAME\":\"学生\",\"SVF_FIELD\":\"BS_ID\",\"SV_ID\":\"49382295680843776\",\"SVR_ID\":\"\"}', '2018-08-08 23:35:34', 1);
INSERT INTO `sys_value_record` VALUES ('49396002897002496', '1', 'sys_validate_field', '49395918151090176', '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"\",\"IS_STATUS\":1,\"SVF_MIN_LENGTH\":\"\",\"ID\":\"49395918151090176\",\"SVF_NAME\":\"学生\",\"SVF_FIELD\":\"BS_ID\",\"SV_ID\":\"49382295680843776\",\"SVR_ID\":\"\"}', '{\"SVF_MIN_LENGTH\":\"\",\"SVF_NAME\":\"学生\",\"SV_ID\":\"49382295680843776\",\"SVR_ID\":\"\",\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"\",\"ID\":\"49395918151090176\",\"SVF_FIELD\":\"BS_NAME\"}', '2018-08-08 23:35:54', 2);
INSERT INTO `sys_value_record` VALUES ('49399175787315200', '1', 'SYS_CONFIGURE_COLUMN', '49383645982490624', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"70px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"49383645982490624\",\"SC_ID\":\"49382988399509504\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":60}', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"140px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"49383645982490624\",\"SC_ID\":\"49382988399509504\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"60\"}', '2018-08-08 23:48:30', 2);
INSERT INTO `sys_value_record` VALUES ('49615034006896640', '1', 'SYS_DICT_TYPE', '49615033952370688', NULL, '{\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"SYS_DICT_TYPE\",\"SDT_CODE\":\"BUS_PUNISHMENT\",\"SDT_ROLE_DEL\":\"\",\"SDT_NAME\":\"业务_处分类型\",\"ID\":\"49615033952370688\",\"SDT_ROLE_DOWN\":\"\"}', '2018-08-09 14:06:15', 1);
INSERT INTO `sys_value_record` VALUES ('49615343487811584', '1', 'SYS_DICT_TYPE', '49615343454257152', NULL, '{\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"SYS_DICT_TYPE\",\"SDT_CODE\":\"BUS_FILE_DEFAULT\",\"SDT_ROLE_DEL\":\"\",\"SDT_NAME\":\"业务_文件（默认）\",\"ID\":\"49615343454257152\",\"SDT_ROLE_DOWN\":\"\"}', '2018-08-09 14:07:29', 1);
INSERT INTO `sys_value_record` VALUES ('49615489109852160', '1', 'SYS_DICT_INFO', '49615488942080000', NULL, '{\"SDI_CODE\":\"1\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"1\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"记过\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_PUNISHMENT\",\"SDI_INNERCODE\":\"1\",\"ID\":\"49615488942080000\",\"SDT_ID\":\"49615033952370688\"}', '2018-08-09 14:08:03', 1);
INSERT INTO `sys_value_record` VALUES ('49615522421014528', '1', 'SYS_DICT_INFO', '49615522332934144', NULL, '{\"SDI_CODE\":\"2\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"2\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"警告\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_PUNISHMENT\",\"SDI_INNERCODE\":\"2\",\"ID\":\"49615522332934144\",\"SDT_ID\":\"49615033952370688\"}', '2018-08-09 14:08:11', 1);
INSERT INTO `sys_value_record` VALUES ('49615554767486976', '1', 'SYS_DICT_INFO', '49615554708766720', NULL, '{\"SDI_CODE\":\"3\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"3\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"留校查看\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_PUNISHMENT\",\"SDI_INNERCODE\":\"3\",\"ID\":\"49615554708766720\",\"SDT_ID\":\"49615033952370688\"}', '2018-08-09 14:08:19', 1);
INSERT INTO `sys_value_record` VALUES ('49615584236666880', '1', 'SYS_DICT_INFO', '49615584148586496', NULL, '{\"SDI_CODE\":\"4\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"4\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"开除\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_PUNISHMENT\",\"SDI_INNERCODE\":\"4\",\"ID\":\"49615584148586496\",\"SDT_ID\":\"49615033952370688\"}', '2018-08-09 14:08:26', 1);
INSERT INTO `sys_value_record` VALUES ('49615720346025984', '1', 'SYS_DICT_INFO', '49615720119533568', NULL, '{\"SDI_CODE\":\"DEFAULT\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"1\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"附件\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_FILE_DEFAULT\",\"SDI_INNERCODE\":\"DEFAULT\",\"ID\":\"49615720119533568\",\"SDT_ID\":\"49615343454257152\"}', '2018-08-09 14:08:58', 1);
INSERT INTO `sys_value_record` VALUES ('49623725200375808', '1', 'SYS_CONFIGURE', '49623725020020736', NULL, '{\"SC_IS_PAGING\":\"1\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE\",\"SC_NAME\":\"学生管理-处分管理\",\"SC_JSP\":\"admin/student/punishment/home\",\"SC_VIEW\":\"v_student_punishment\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"49623725020020736\",\"SC_ORDER_BY\":\"\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '2018-08-09 14:40:47', 1);
INSERT INTO `sys_value_record` VALUES ('49623752039727104', '1', 'SYS_CONFIGURE', '49623725020020736', '{\"SC_IS_PAGING\":\"1\",\"SC_NAME\":\"学生管理-处分管理\",\"SC_JSP\":\"admin/student/punishment/home\",\"SC_VIEW\":\"v_student_punishment\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"49623725020020736\",\"SC_ORDER_BY\":\"\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '{\"SC_NAME\":\"学生管理-处分管理\",\"SC_JSP\":\"admin/student/punishment/home\",\"SC_VIEW\":\"v_student_punishment\",\"SC_ORDER_BY\":\"CONVERT(ID,SIGNED) DESC\",\"SC_IS_PAGING\":\"1\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"49623725020020736\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '2018-08-09 14:40:53', 2);
INSERT INTO `sys_value_record` VALUES ('49623930482196480', '1', 'SYS_CONFIGURE_COLUMN', '49623930373144576', NULL, '{\"SCC_NAME\":\"学生\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"BS_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"49623930373144576\",\"SC_ID\":\"49623725020020736\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"1\"}', '2018-08-09 14:41:36', 1);
INSERT INTO `sys_value_record` VALUES ('49623978582474752', '1', 'SYS_CONFIGURE_COLUMN', '49623978519560192', NULL, '{\"SCC_NAME\":\"班级\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"left\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"170px\",\"SCC_FIELD\":\"BC_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"49623978519560192\",\"SC_ID\":\"49623725020020736\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"10\"}', '2018-08-09 14:41:47', 1);
INSERT INTO `sys_value_record` VALUES ('49624050783223808', '1', 'SYS_CONFIGURE_COLUMN', '49624050699337728', NULL, '{\"SCC_NAME\":\"标题\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"left\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"150px\",\"SCC_FIELD\":\"BSP_TITLE\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"49624050699337728\",\"SC_ID\":\"49623725020020736\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"20\"}', '2018-08-09 14:42:05', 1);
INSERT INTO `sys_value_record` VALUES ('49624094550786048', '1', 'SYS_CONFIGURE_COLUMN', '49624093883891712', NULL, '{\"SCC_NAME\":\"文件号\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"BSP_FILE_NUMBER\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"49624093883891712\",\"SC_ID\":\"49623725020020736\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"30\"}', '2018-08-09 14:42:15', 1);
INSERT INTO `sys_value_record` VALUES ('49624134442811392', '1', 'SYS_CONFIGURE_COLUMN', '49624134371508224', NULL, '{\"SCC_NAME\":\"发布时间\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"120px\",\"SCC_FIELD\":\"BSP_RELEASE_TIME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"49624134371508224\",\"SC_ID\":\"49623725020020736\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"40\"}', '2018-08-09 14:42:25', 1);
INSERT INTO `sys_value_record` VALUES ('49624224393854976', '1', 'SYS_CONFIGURE_COLUMN', '49624224339329024', NULL, '{\"SCC_NAME\":\"类型\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"BUS_PUNISHMENT\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"50px\",\"SCC_FIELD\":\"BSP_TYPE\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"49624224339329024\",\"SC_ID\":\"49623725020020736\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"50\"}', '2018-08-09 14:42:46', 1);
INSERT INTO `sys_value_record` VALUES ('49624381789306880', '1', 'SYS_CONFIGURE_COLUMN', '49624381759946752', NULL, '{\"SCC_NAME\":\"是否作废\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"70px\",\"SCC_FIELD\":\"BSP_IS_CANCEL\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"49624381759946752\",\"SC_ID\":\"49623725020020736\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"SYS_YES_NO\",\"SCC_ORDER\":\"60\"}', '2018-08-09 14:43:24', 1);
INSERT INTO `sys_value_record` VALUES ('49624405013168128', '1', 'SYS_CONFIGURE_COLUMN', '49624224339329024', '{\"SCC_NAME\":\"类型\",\"SCC_FUNC\":\"BUS_PUNISHMENT\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"50px\",\"SCC_FIELD\":\"BSP_TYPE\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"49624224339329024\",\"SC_ID\":\"49623725020020736\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":50}', '{\"SCC_NAME\":\"类型\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"50px\",\"SCC_FIELD\":\"BSP_TYPE\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"49624224339329024\",\"SC_ID\":\"49623725020020736\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"BUS_PUNISHMENT\",\"SCC_ORDER\":\"50\"}', '2018-08-09 14:43:29', 2);
INSERT INTO `sys_value_record` VALUES ('49624458419240960', '1', 'SYS_CONFIGURE_COLUMN', '49624458347937792', NULL, '{\"SCC_NAME\":\"操作\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"140px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"49624458347937792\",\"SC_ID\":\"49623725020020736\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"70\"}', '2018-08-09 14:43:42', 1);
INSERT INTO `sys_value_record` VALUES ('49624539381891072', '1', 'SYS_CONFIGURE_SEARCH', '49624539285422080', NULL, '{\"SCS_METHOD_TYPE\":\"4\",\"SCS_TYPE\":\"1\",\"SCS_FIELD\":\"BS_NAME\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_SEARCH\",\"SCS_NAME\":\"学生\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"49624539285422080\",\"SC_ID\":\"49623725020020736\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":\"1\"}', '2018-08-09 14:44:01', 1);
INSERT INTO `sys_value_record` VALUES ('49624578858680320', '1', 'SYS_CONFIGURE_SEARCH', '49624578787377152', NULL, '{\"SCS_METHOD_TYPE\":\"4\",\"SCS_TYPE\":\"1\",\"SCS_FIELD\":\"BC_NAME\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_SEARCH\",\"SCS_NAME\":\"班级\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"49624578787377152\",\"SC_ID\":\"49623725020020736\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":\"10\"}', '2018-08-09 14:44:10', 1);
INSERT INTO `sys_value_record` VALUES ('49624644155604992', '1', 'SYS_CONFIGURE_SEARCH', '49624644126244864', NULL, '{\"SCS_METHOD_TYPE\":\"4\",\"SCS_TYPE\":\"1\",\"SCS_FIELD\":\"BSP_TITLE\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_SEARCH\",\"SCS_NAME\":\"标题\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"49624644126244864\",\"SC_ID\":\"49623725020020736\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":\"20\"}', '2018-08-09 14:44:26', 1);
INSERT INTO `sys_value_record` VALUES ('49624671246614528', '1', 'SYS_CONFIGURE_SEARCH', '49624671217254400', NULL, '{\"SCS_METHOD_TYPE\":\"1\",\"SCS_TYPE\":\"1\",\"SCS_FIELD\":\"BSP_FILE_NUMBER\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_SEARCH\",\"SCS_NAME\":\"文件号\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"49624671217254400\",\"SC_ID\":\"49623725020020736\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":\"30\"}', '2018-08-09 14:44:33', 1);
INSERT INTO `sys_value_record` VALUES ('49624755707314176', '1', 'SYS_CONFIGURE_SEARCH', '49624755669565440', NULL, '{\"SCS_METHOD_TYPE\":\"1\",\"SCS_TYPE\":\"2\",\"SCS_FIELD\":\"BSP_TYPE\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_SEARCH\",\"SCS_NAME\":\"类型\",\"SCS_SDT_CODE\":\"BUS_PUNISHMENT\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"49624755669565440\",\"SC_ID\":\"49623725020020736\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":\"40\"}', '2018-08-09 14:44:53', 1);
INSERT INTO `sys_value_record` VALUES ('49624822761652224', '1', 'SYS_CONFIGURE_SEARCH', '49624822736486400', NULL, '{\"SCS_METHOD_TYPE\":\"1\",\"SCS_TYPE\":\"2\",\"SCS_FIELD\":\"BSP_IS_CANCEL\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_SEARCH\",\"SCS_NAME\":\"是否作废\",\"SCS_SDT_CODE\":\"SYS_YES_NO\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"49624822736486400\",\"SC_ID\":\"49623725020020736\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":\"50\"}', '2018-08-09 14:45:09', 1);
INSERT INTO `sys_value_record` VALUES ('49624862116806656', '1', 'SYS_CONFIGURE_SEARCH', '49624671217254400', '{\"SCS_METHOD_TYPE\":\"1\",\"SCS_TYPE\":\"1\",\"SCS_FIELD\":\"BSP_FILE_NUMBER\",\"SCS_NAME\":\"文件号\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"49624671217254400\",\"SC_ID\":\"49623725020020736\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":30}', '{\"SCS_FIELD\":\"BSP_FILE_NUMBER\",\"SCS_NAME\":\"文件号\",\"SCS_SDT_CODE\":\"\",\"SCS_ORDER\":\"30\",\"SCS_METHOD_TYPE\":\"4\",\"SCS_TYPE\":\"1\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"49624671217254400\",\"SC_ID\":\"49623725020020736\",\"SCS_REMARK\":\"\"}', '2018-08-09 14:45:18', 2);
INSERT INTO `sys_value_record` VALUES ('49624905683042304', '1', 'SYS_MENU', '49028146267160576', '{\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":20,\"SM_CODE\":\"STUDENT:PUNISHMENT\",\"SM_NAME\":\"处分管理\",\"SM_PARENTID\":\"49027088874733568\",\"ID\":\"49028146267160576\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-book-multiple\",\"SM_IS_EXPAND\":\"\"}', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_TYPE\":\"1\",\"SM_ORDER\":\"20\",\"SM_CODE\":\"STUDENT:PUNISHMENT\",\"SM_NAME\":\"处分管理\",\"SM_PARENTID\":\"49027088874733568\",\"ID\":\"49028146267160576\",\"SC_ID\":\"49623725020020736\",\"SM_CLASSICON\":\"mdi mdi-book-multiple\",\"SM_IS_EXPAND\":\"\"}', '2018-08-09 14:45:28', 2);
INSERT INTO `sys_value_record` VALUES ('49625046624239616', '1', 'SYS_CONFIGURE_COLUMN', '49624458347937792', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"140px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"49624458347937792\",\"SC_ID\":\"49623725020020736\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":70}', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"1\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"80px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"49624458347937792\",\"SC_ID\":\"49623725020020736\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"70\"}', '2018-08-09 14:46:02', 2);
INSERT INTO `sys_value_record` VALUES ('49626775214358528', '1', 'SYS_FILE', '49626764476940289', NULL, '{\"SF_NAME\":\"49626764476940289\",\"SF_TABLE_NAME\":\"BUS_STUDENT_PUNISHMENT\",\"SF_SEE_TYPE\":1,\"SVR_TABLE_NAME\":\"SYS_FILE\",\"SO_ID\":\"1\",\"SF_PATH\":\"punishment/2018-08-09/\",\"SF_ORIGINAL_NAME\":\"u=635704053,1460945271&fm=27&gp=0.jpg\",\"SF_SDT_CODE\":\"BUS_FILE_DEFAULT\",\"SF_ENTRY_TIME\":\"2018-08-09 14:52:54\",\"SF_SDI_CODE\":\"DEFAULT\",\"SF_SIZE\":29754,\"ID\":\"49626764476940289\",\"SF_SUFFIX\":\"jpg\",\"SF_TABLE_ID\":\"\"}', '2018-08-09 14:52:54', 1);
INSERT INTO `sys_value_record` VALUES ('49626775285661696', '1', 'SYS_FILE', '49626764476940288', NULL, '{\"SF_NAME\":\"49626764476940288\",\"SF_TABLE_NAME\":\"BUS_STUDENT_PUNISHMENT\",\"SF_SEE_TYPE\":1,\"SVR_TABLE_NAME\":\"SYS_FILE\",\"SO_ID\":\"1\",\"SF_PATH\":\"punishment/2018-08-09/\",\"SF_ORIGINAL_NAME\":\"timg.jpg\",\"SF_SDT_CODE\":\"BUS_FILE_DEFAULT\",\"SF_ENTRY_TIME\":\"2018-08-09 14:52:54\",\"SF_SDI_CODE\":\"DEFAULT\",\"SF_SIZE\":30046,\"ID\":\"49626764476940288\",\"SF_SUFFIX\":\"jpg\",\"SF_TABLE_ID\":\"\"}', '2018-08-09 14:52:54', 1);
INSERT INTO `sys_value_record` VALUES ('49626917321572352', '1', 'SYS_CONFIGURE_COLUMN', '49624381759946752', '{\"SCC_NAME\":\"是否作废\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"70px\",\"SCC_FIELD\":\"BSP_IS_CANCEL\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"49624381759946752\",\"SC_ID\":\"49623725020020736\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"SYS_YES_NO\",\"SCC_ORDER\":60}', '{\"SCC_NAME\":\"是否撤销\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"70px\",\"SCC_FIELD\":\"BSP_IS_CANCEL\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"49624381759946752\",\"SC_ID\":\"49623725020020736\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"SYS_YES_NO\",\"SCC_ORDER\":\"60\"}', '2018-08-09 14:53:28', 2);
INSERT INTO `sys_value_record` VALUES ('49626964520075264', '1', 'SYS_CONFIGURE_COLUMN', '49624134371508224', '{\"SCC_NAME\":\"发布时间\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"120px\",\"SCC_FIELD\":\"BSP_RELEASE_TIME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"49624134371508224\",\"SC_ID\":\"49623725020020736\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":40}', '{\"SCC_NAME\":\"发布时间\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"BSP_RELEASE_TIME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"49624134371508224\",\"SC_ID\":\"49623725020020736\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"40\"}', '2018-08-09 14:53:39', 2);
INSERT INTO `sys_value_record` VALUES ('49627457254326272', '1', 'SYS_FILE', '49627456017006592', NULL, '{\"SF_NAME\":\"49627456017006592\",\"SF_TABLE_NAME\":\"BUS_STUDENT_PUNISHMENT\",\"SF_SEE_TYPE\":1,\"SVR_TABLE_NAME\":\"SYS_FILE\",\"SO_ID\":\"1\",\"SF_PATH\":\"punishment/2018-08-09/\",\"SF_ORIGINAL_NAME\":\"u=635704053,1460945271&fm=27&gp=0.jpg\",\"SF_SDT_CODE\":\"BUS_FILE_DEFAULT\",\"SF_ENTRY_TIME\":\"2018-08-09 14:55:37\",\"SF_SDI_CODE\":\"DEFAULT\",\"SF_SIZE\":29754,\"ID\":\"49627456017006592\",\"SF_SUFFIX\":\"jpg\",\"SF_TABLE_ID\":\"8Yv65lfpNPYL2FRyA06BtgEQUALEQUAL\"}', '2018-08-09 14:55:37', 1);
INSERT INTO `sys_value_record` VALUES ('49746804069105664', '1', 'SYS_FILE', '49746794988437504', NULL, '{\"SF_NAME\":\"49746794988437504\",\"SF_TABLE_NAME\":\"BUS_STUDENT_PUNISHMENT\",\"SF_SEE_TYPE\":1,\"SVR_TABLE_NAME\":\"SYS_FILE\",\"SO_ID\":\"1\",\"SF_PATH\":\"punishment/2018-08-09/\",\"SF_ORIGINAL_NAME\":\"timg.jpg\",\"SF_SDT_CODE\":\"BUS_FILE_DEFAULT\",\"SF_ENTRY_TIME\":\"2018-08-09 22:49:51\",\"SF_SDI_CODE\":\"DEFAULT\",\"SF_SIZE\":30046,\"ID\":\"49746794988437504\",\"SF_SUFFIX\":\"jpg\",\"SF_TABLE_ID\":\"49746696170635264\"}', '2018-08-09 22:49:51', 1);
INSERT INTO `sys_value_record` VALUES ('49754112530579456', '1', 'SYS_FILE', '49754111855296512', NULL, '{\"SF_NAME\":\"49754111855296512\",\"SF_TABLE_NAME\":\"BUS_STUDENT_PUNISHMENT\",\"SF_SEE_TYPE\":1,\"SVR_TABLE_NAME\":\"SYS_FILE\",\"SO_ID\":\"1\",\"SF_PATH\":\"punishment/2018-08-09/\",\"SF_ORIGINAL_NAME\":\"u=635704053,1460945271&fm=27&gp=0.jpg\",\"SF_SDT_CODE\":\"BUS_FILE_DEFAULT\",\"SF_ENTRY_TIME\":\"2018-08-09 23:18:54\",\"SF_SDI_CODE\":\"DEFAULT\",\"SF_SIZE\":29754,\"ID\":\"49754111855296512\",\"SF_SUFFIX\":\"jpg\",\"SF_TABLE_ID\":\"1\"}', '2018-08-09 23:18:54', 1);
INSERT INTO `sys_value_record` VALUES ('49773714069258240', '1', 'SYS_FILE', '49773713242980352', NULL, '{\"SF_NAME\":\"49773713242980352\",\"SF_TABLE_NAME\":\"BUS_STUDENT_PUNISHMENT\",\"SF_SEE_TYPE\":1,\"SVR_TABLE_NAME\":\"SYS_FILE\",\"SO_ID\":\"1\",\"SF_PATH\":\"punishment/2018-08-10/\",\"SF_ORIGINAL_NAME\":\"timg.jpg\",\"SF_SDT_CODE\":\"BUS_FILE_DEFAULT\",\"SF_ENTRY_TIME\":\"2018-08-10 00:36:47\",\"SF_SDI_CODE\":\"DEFAULT\",\"SF_SIZE\":30046,\"ID\":\"49773713242980352\",\"SF_SUFFIX\":\"jpg\",\"SF_TABLE_ID\":\"1\"}', '2018-08-10 00:36:47', 1);
INSERT INTO `sys_value_record` VALUES ('50326996877574144', '1', 'SYS_VALIDATE', '21138918841778176', '{\"IS_STATUS\":1,\"SV_TABLE\":\"SYS_ALLOCATION_EMAIL\",\"ID\":\"21138918841778176\"}', '{\"SV_TABLE\":\"SYS_ALLOCATION\",\"ID\":\"21138918841778176\"}', '2018-08-11 13:15:20', 2);
INSERT INTO `sys_value_record` VALUES ('50327099310866432', '1', 'sys_validate_field', '50327099268923392', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"2\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50327099268923392\",\"SVF_NAME\":\"德育\",\"SVF_FIELD\":\"EDUCATION_PROPORTION\",\"SV_ID\":\"21138918841778176\",\"SVR_ID\":\"2510375538917376\"}', '2018-08-11 13:15:44', 1);
INSERT INTO `sys_value_record` VALUES ('50327147251761152', '1', 'sys_validate_field', '50327147201429504', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"2\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50327147201429504\",\"SVF_NAME\":\"智育\",\"SVF_FIELD\":\"INTELLECTUAL_PROPORTION\",\"SV_ID\":\"21138918841778176\",\"SVR_ID\":\"2510375538917376\"}', '2018-08-11 13:15:56', 1);
INSERT INTO `sys_value_record` VALUES ('50327192755765248', '1', 'sys_validate_field', '50327192726405120', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"2\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50327192726405120\",\"SVF_NAME\":\"志愿者\",\"SVF_FIELD\":\"VOLUNTEER_PROPORTION\",\"SV_ID\":\"21138918841778176\",\"SVR_ID\":\"2510375538917376\"}', '2018-08-11 13:16:07', 1);
INSERT INTO `sys_value_record` VALUES ('50328019390169088', '1', 'SYS_MENU', '50328019348226048', NULL, '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"\",\"SVR_TABLE_NAME\":\"SYS_MENU\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":\"10\",\"SM_CODE\":\"SYSTEM:ALLOCATION_COMPREHENSIVE\",\"SM_NAME\":\"综合素质评定\",\"SM_PARENTID\":\"21130604443598848\",\"ID\":\"50328019348226048\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '2018-08-11 13:19:24', 1);
INSERT INTO `sys_value_record` VALUES ('50328209824153600', '1', 'SYS_MENU', '50328019348226048', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":10,\"SM_CODE\":\"SYSTEM:ALLOCATION_COMPREHENSIVE\",\"SM_NAME\":\"综合素质评定\",\"SM_PARENTID\":\"21130604443598848\",\"ID\":\"50328019348226048\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"admin/allocation/comprehensive\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_TYPE\":\"1\",\"SM_ORDER\":\"10\",\"SM_CODE\":\"SYSTEM:ALLOCATION_COMPREHENSIVE\",\"SM_NAME\":\"综合素质评定\",\"SM_PARENTID\":\"21130604443598848\",\"ID\":\"50328019348226048\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-tooltip-edit\",\"SM_IS_EXPAND\":\"\"}', '2018-08-11 13:20:09', 2);
INSERT INTO `sys_value_record` VALUES ('50328920855150592', '1', 'SYS_ALLOCATION', '50328920767070208', NULL, '{\"SVR_TABLE_NAME\":\"SYS_ALLOCATION\",\"ID\":\"50328920767070208\",\"SA_KEY\":\"EDUCATION_PROPORTION\",\"SA_MODIFY_TIME\":\"2018-08-11 13:22:59\",\"SA_VALUE\":\"30\"}', '2018-08-11 13:22:59', 1);
INSERT INTO `sys_value_record` VALUES ('50328921018728448', '1', 'SYS_ALLOCATION', '50328920993562624', NULL, '{\"SVR_TABLE_NAME\":\"SYS_ALLOCATION\",\"ID\":\"50328920993562624\",\"SA_KEY\":\"INTELLECTUAL_PROPORTION\",\"SA_MODIFY_TIME\":\"2018-08-11 13:22:59\",\"SA_VALUE\":\"60\"}', '2018-08-11 13:22:59', 1);
INSERT INTO `sys_value_record` VALUES ('50328921169723392', '1', 'SYS_ALLOCATION', '50328921140363264', NULL, '{\"SVR_TABLE_NAME\":\"SYS_ALLOCATION\",\"ID\":\"50328921140363264\",\"SA_KEY\":\"VOLUNTEER_PROPORTION\",\"SA_MODIFY_TIME\":\"2018-08-11 13:22:59\",\"SA_VALUE\":\"10\"}', '2018-08-11 13:22:59', 1);
INSERT INTO `sys_value_record` VALUES ('50329009468211200', '1', 'SYS_ALLOCATION', '50328920767070208', '{\"SA_MODIFY_TIME\":\"2018-08-11 13:22:59\",\"ID\":\"50328920767070208\",\"SA_KEY\":\"EDUCATION_PROPORTION\",\"SA_VALUE\":\"30\"}', '{\"SA_MODIFY_TIME\":\"2018-08-11 13:23:20\",\"SA_KEY\":\"EDUCATION_PROPORTION\",\"SA_VALUE\":\"20\",\"ID\":\"50328920767070208\"}', '2018-08-11 13:23:20', 2);
INSERT INTO `sys_value_record` VALUES ('50329009967333376', '1', 'SYS_ALLOCATION', '50328920993562624', '{\"SA_MODIFY_TIME\":\"2018-08-11 13:22:59\",\"ID\":\"50328920993562624\",\"SA_KEY\":\"INTELLECTUAL_PROPORTION\",\"SA_VALUE\":\"60\"}', '{\"SA_MODIFY_TIME\":\"2018-08-11 13:23:20\",\"SA_KEY\":\"INTELLECTUAL_PROPORTION\",\"SA_VALUE\":\"70\",\"ID\":\"50328920993562624\"}', '2018-08-11 13:23:20', 2);
INSERT INTO `sys_value_record` VALUES ('50329010135105536', '1', 'SYS_ALLOCATION', '50328921140363264', '{\"SA_MODIFY_TIME\":\"2018-08-11 13:22:59\",\"ID\":\"50328921140363264\",\"SA_KEY\":\"VOLUNTEER_PROPORTION\",\"SA_VALUE\":\"10\"}', '{\"SA_MODIFY_TIME\":\"2018-08-11 13:23:20\",\"SA_KEY\":\"VOLUNTEER_PROPORTION\",\"SA_VALUE\":\"10\",\"ID\":\"50328921140363264\"}', '2018-08-11 13:23:20', 2);
INSERT INTO `sys_value_record` VALUES ('50329048949194752', '1', 'SYS_ALLOCATION', '50328920767070208', '{\"SA_MODIFY_TIME\":\"2018-08-11 13:23:20\",\"ID\":\"50328920767070208\",\"SA_KEY\":\"EDUCATION_PROPORTION\",\"SA_VALUE\":\"20\"}', '{\"SA_MODIFY_TIME\":\"2018-08-11 13:23:29\",\"SA_KEY\":\"EDUCATION_PROPORTION\",\"SA_VALUE\":\"30\",\"ID\":\"50328920767070208\"}', '2018-08-11 13:23:29', 2);
INSERT INTO `sys_value_record` VALUES ('50329049133744128', '1', 'SYS_ALLOCATION', '50328920993562624', '{\"SA_MODIFY_TIME\":\"2018-08-11 13:23:20\",\"ID\":\"50328920993562624\",\"SA_KEY\":\"INTELLECTUAL_PROPORTION\",\"SA_VALUE\":\"70\"}', '{\"SA_MODIFY_TIME\":\"2018-08-11 13:23:29\",\"SA_KEY\":\"INTELLECTUAL_PROPORTION\",\"SA_VALUE\":\"60\",\"ID\":\"50328920993562624\"}', '2018-08-11 13:23:29', 2);
INSERT INTO `sys_value_record` VALUES ('50329049305710592', '1', 'SYS_ALLOCATION', '50328921140363264', '{\"SA_MODIFY_TIME\":\"2018-08-11 13:23:20\",\"ID\":\"50328921140363264\",\"SA_KEY\":\"VOLUNTEER_PROPORTION\",\"SA_VALUE\":\"10\"}', '{\"SA_MODIFY_TIME\":\"2018-08-11 13:23:29\",\"SA_KEY\":\"VOLUNTEER_PROPORTION\",\"SA_VALUE\":\"10\",\"ID\":\"50328921140363264\"}', '2018-08-11 13:23:29', 2);
INSERT INTO `sys_value_record` VALUES ('50329904440410112', '1', 'sys_validate_field', '50329904402661376', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"2\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50329904402661376\",\"SVF_NAME\":\"迟到几节课算旷课\",\"SVF_FIELD\":\"LATE_PROPORTION\",\"SV_ID\":\"21138918841778176\",\"SVR_ID\":\"2510375538917376\"}', '2018-08-11 13:26:53', 1);
INSERT INTO `sys_value_record` VALUES ('50329946224066560', '1', 'sys_validate_field', '50329946148569088', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"2\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50329946148569088\",\"SVF_NAME\":\"旷课几节课算处分\",\"SVF_FIELD\":\"ABSENTEEISM_PROPORTION\",\"SV_ID\":\"21138918841778176\",\"SVR_ID\":\"2510375538917376\"}', '2018-08-11 13:27:03', 1);
INSERT INTO `sys_value_record` VALUES ('50330580948090880', '1', 'SYS_MENU', '49030149684854784', '{\"SM_URL\":\"admin/allocation/absenteeism\",\"SM_URL_PARAMS\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":20,\"SM_CODE\":\"SYSTEM:ALLOCATION_ABSENTEEISM\",\"SM_NAME\":\"迟到旷课处分配置\",\"SM_PARENTID\":\"21130604443598848\",\"ID\":\"49030149684854784\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-close-outline\",\"SM_IS_EXPAND\":\"\"}', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"admin/allocation/punishment\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_TYPE\":\"1\",\"SM_ORDER\":\"20\",\"SM_CODE\":\"SYSTEM:ALLOCATION_PUNISHMENT\",\"SM_NAME\":\"迟到旷课处分配置\",\"SM_PARENTID\":\"21130604443598848\",\"ID\":\"49030149684854784\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-close-outline\",\"SM_IS_EXPAND\":\"\"}', '2018-08-11 13:29:35', 2);
INSERT INTO `sys_value_record` VALUES ('50331495075676160', '1', 'SYS_ALLOCATION', '50331495037927424', NULL, '{\"SVR_TABLE_NAME\":\"SYS_ALLOCATION\",\"ID\":\"50331495037927424\",\"SA_KEY\":\"LATE_PROPORTION\",\"SA_MODIFY_TIME\":\"2018-08-11 13:33:12\",\"SA_VALUE\":\"2\"}', '2018-08-11 13:33:12', 1);
INSERT INTO `sys_value_record` VALUES ('50331495448969216', '1', 'SYS_ALLOCATION', '50331495419609088', NULL, '{\"SVR_TABLE_NAME\":\"SYS_ALLOCATION\",\"ID\":\"50331495419609088\",\"SA_KEY\":\"ABSENTEEISM_PROPORTION\",\"SA_MODIFY_TIME\":\"2018-08-11 13:33:13\",\"SA_VALUE\":\"40\"}', '2018-08-11 13:33:13', 1);
INSERT INTO `sys_value_record` VALUES ('50331586356314112', '1', 'SYS_MENU', '50328019348226048', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"admin/allocation/comprehensive\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":10,\"SM_CODE\":\"SYSTEM:ALLOCATION_COMPREHENSIVE\",\"SM_NAME\":\"综合素质评定\",\"SM_PARENTID\":\"21130604443598848\",\"ID\":\"50328019348226048\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-tooltip-edit\",\"SM_IS_EXPAND\":\"\"}', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"admin/allocation/comprehensive\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_TYPE\":\"1\",\"SM_ORDER\":\"10\",\"SM_CODE\":\"SYSTEM:ALLOCATION_COMPREHENSIVE\",\"SM_NAME\":\"综合素质评定比例配置\",\"SM_PARENTID\":\"21130604443598848\",\"ID\":\"50328019348226048\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-tooltip-edit\",\"SM_IS_EXPAND\":\"\"}', '2018-08-11 13:33:34', 2);
INSERT INTO `sys_value_record` VALUES ('50332101228101632', '1', 'SYS_MENU', '50328019348226048', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"admin/allocation/comprehensive\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":10,\"SM_CODE\":\"SYSTEM:ALLOCATION_COMPREHENSIVE\",\"SM_NAME\":\"综合素质评定比例配置\",\"SM_PARENTID\":\"21130604443598848\",\"ID\":\"50328019348226048\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-tooltip-edit\",\"SM_IS_EXPAND\":\"\"}', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"admin/allocation/comprehensive\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_TYPE\":\"1\",\"SM_ORDER\":\"10\",\"SM_CODE\":\"SYSTEM:ALLOCATION_COMPREHENSIVE\",\"SM_NAME\":\"综合素质测评比例配置\",\"SM_PARENTID\":\"21130604443598848\",\"ID\":\"50328019348226048\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-tooltip-edit\",\"SM_IS_EXPAND\":\"\"}', '2018-08-11 13:35:37', 2);
INSERT INTO `sys_value_record` VALUES ('50335819872862208', '1', 'SYS_VALIDATE', '50335819809947648', NULL, '{\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"SYS_VALIDATE\",\"ID\":\"50335819809947648\",\"SV_TABLE\":\"BUS_STUDENT_COMPREHENSIVE\"}', '2018-08-11 13:50:24', 1);
INSERT INTO `sys_value_record` VALUES ('50335893365456896', '1', 'sys_validate_field', '50335893340291072', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50335893340291072\",\"SVF_NAME\":\"学生\",\"SVF_FIELD\":\"BS_ID\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"\"}', '2018-08-11 13:50:41', 1);
INSERT INTO `sys_value_record` VALUES ('50335942845661184', '1', 'sys_validate_field', '50335942816301056', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50335942816301056\",\"SVF_NAME\":\"学年\",\"SVF_FIELD\":\"BSC_YEAR\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"26504926733533184\"}', '2018-08-11 13:50:53', 1);
INSERT INTO `sys_value_record` VALUES ('50335976467202048', '1', 'sys_validate_field', '50335976446230528', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50335976446230528\",\"SVF_NAME\":\"学期\",\"SVF_FIELD\":\"BSC_SEMESTER\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"\"}', '2018-08-11 13:51:01', 1);
INSERT INTO `sys_value_record` VALUES ('50336135397769216', '1', 'sys_validate_field', '50336135364214784', NULL, '{\"SVF_IS_REQUIRED\":\"0\",\"SVF_MAX_LENGTH\":\"3\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50336135364214784\",\"SVF_NAME\":\"总分\",\"SVF_FIELD\":\"BSC_TOTAL\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"2511687219412992\"}', '2018-08-11 13:51:39', 1);
INSERT INTO `sys_value_record` VALUES ('50336500818116608', '1', 'sys_validate_field', '50336500797145088', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"2\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50336500797145088\",\"SVF_NAME\":\"政治态度和表现\",\"SVF_FIELD\":\"BSC_POLITICAL_ATTITUDE\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"2510375538917376\"}', '2018-08-11 13:53:06', 1);
INSERT INTO `sys_value_record` VALUES ('50336554203217920', '1', 'sys_validate_field', '50336554182246400', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"2\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50336554182246400\",\"SVF_NAME\":\"劳动态度和表现\",\"SVF_FIELD\":\"BSC_LABOR_ATTITUDE\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"2510375538917376\"}', '2018-08-11 13:53:19', 1);
INSERT INTO `sys_value_record` VALUES ('50336605008822272', '1', 'sys_validate_field', '50336604983656448', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"2\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50336604983656448\",\"SVF_NAME\":\"遵纪守法\",\"SVF_FIELD\":\"BSC_COMPLIANCE\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"2510375538917376\"}', '2018-08-11 13:53:31', 1);
INSERT INTO `sys_value_record` VALUES ('50336652274434048', '1', 'sys_validate_field', '50336652224102400', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"2\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50336652224102400\",\"SVF_NAME\":\"集体观念\",\"SVF_FIELD\":\"BSC_COLLECTIVE\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"2510375538917376\"}', '2018-08-11 13:53:42', 1);
INSERT INTO `sys_value_record` VALUES ('50336690736201728', '1', 'sys_validate_field', '50336690681675776', NULL, '{\"SVF_IS_REQUIRED\":\"0\",\"SVF_MAX_LENGTH\":\"2\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50336690681675776\",\"SVF_NAME\":\"文明礼貌\",\"SVF_FIELD\":\"BSC_DECORUM\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"2510375538917376\"}', '2018-08-11 13:53:51', 1);
INSERT INTO `sys_value_record` VALUES ('50336712437530624', '1', 'sys_validate_field', '50336690681675776', '{\"SVF_IS_REQUIRED\":\"0\",\"SVF_MAX_LENGTH\":\"2\",\"IS_STATUS\":1,\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50336690681675776\",\"SVF_NAME\":\"文明礼貌\",\"SVF_FIELD\":\"BSC_DECORUM\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"2510375538917376\"}', '{\"SVF_MIN_LENGTH\":\"\",\"SVF_NAME\":\"文明礼貌\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"2510375538917376\",\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"2\",\"ID\":\"50336690681675776\",\"SVF_FIELD\":\"BSC_DECORUM\"}', '2018-08-11 13:53:56', 2);
INSERT INTO `sys_value_record` VALUES ('50336772751622144', '1', 'sys_validate_field', '50336772709679104', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"2\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50336772709679104\",\"SVF_NAME\":\"爱护公物\",\"SVF_FIELD\":\"BSC_CARE\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"2510375538917376\"}', '2018-08-11 13:54:11', 1);
INSERT INTO `sys_value_record` VALUES ('50336823553032192', '1', 'sys_validate_field', '50336823502700544', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"2\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50336823502700544\",\"SVF_NAME\":\"个人品质\",\"SVF_FIELD\":\"BSC_PERSONAL_QUALITY\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"2510375538917376\"}', '2018-08-11 13:54:23', 1);
INSERT INTO `sys_value_record` VALUES ('50336870512459776', '1', 'sys_validate_field', '50336870457933824', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"2\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50336870457933824\",\"SVF_NAME\":\"服务精神\",\"SVF_FIELD\":\"BSC_SERVICE_SPIRIT\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"2510375538917376\"}', '2018-08-11 13:54:34', 1);
INSERT INTO `sys_value_record` VALUES ('50336988330459136', '1', 'sys_validate_field', '50336988305293312', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"2\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50336988305293312\",\"SVF_NAME\":\"满勤分\",\"SVF_FIELD\":\"BSC_FULL_WORK\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"2510375538917376\"}', '2018-08-11 13:55:02', 1);
INSERT INTO `sys_value_record` VALUES ('50337045054226432', '1', 'sys_validate_field', '50337045003894784', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"2\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50337045003894784\",\"SVF_NAME\":\"奖励分\",\"SVF_FIELD\":\"BSC_BONUS_POINTS\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"2510375538917376\"}', '2018-08-11 13:55:16', 1);
INSERT INTO `sys_value_record` VALUES ('50337112729321472', '1', 'sys_validate_field', '50337112662212608', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"2\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50337112662212608\",\"SVF_NAME\":\"德育扣分\",\"SVF_FIELD\":\"BSC_EDUCATION_DEDUCTION\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"2510375538917376\"}', '2018-08-11 13:55:32', 1);
INSERT INTO `sys_value_record` VALUES ('50337186121252864', '1', 'sys_validate_field', '50337186033172480', NULL, '{\"SVF_IS_REQUIRED\":\"0\",\"SVF_MAX_LENGTH\":\"3\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50337186033172480\",\"SVF_NAME\":\"德育总分\",\"SVF_FIELD\":\"BSC_EDUCATION_TOTAL\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"2511687219412992\"}', '2018-08-11 13:55:49', 1);
INSERT INTO `sys_value_record` VALUES ('50337295328346112', '1', 'sys_validate_field', '50337295252848640', NULL, '{\"SVF_IS_REQUIRED\":\"0\",\"SVF_MAX_LENGTH\":\"3\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50337295252848640\",\"SVF_NAME\":\"德育得分\",\"SVF_FIELD\":\"BSC_EDUCATION_SCORE\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"2511687219412992\"}', '2018-08-11 13:56:15', 1);
INSERT INTO `sys_value_record` VALUES ('50337334830301184', '1', 'sys_validate_field', '50337186033172480', '{\"SVF_IS_REQUIRED\":\"0\",\"SVF_MAX_LENGTH\":\"3\",\"IS_STATUS\":1,\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50337186033172480\",\"SVF_NAME\":\"德育总分\",\"SVF_FIELD\":\"BSC_EDUCATION_TOTAL\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"2511687219412992\"}', '{\"SVF_MIN_LENGTH\":\"\",\"SVF_NAME\":\"德育总分\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"2510375538917376\",\"SVF_IS_REQUIRED\":\"0\",\"SVF_MAX_LENGTH\":\"3\",\"ID\":\"50337186033172480\",\"SVF_FIELD\":\"BSC_EDUCATION_TOTAL\"}', '2018-08-11 13:56:25', 2);
INSERT INTO `sys_value_record` VALUES ('50337397862301696', '1', 'sys_validate_field', '50337397790998528', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"3\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50337397790998528\",\"SVF_NAME\":\"学习成绩\",\"SVF_FIELD\":\"BSC_ACADEMIC_RECORD\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"2510375538917376\"}', '2018-08-11 13:56:40', 1);
INSERT INTO `sys_value_record` VALUES ('50337479953219584', '1', 'sys_validate_field', '50337479936442368', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"2\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50337479936442368\",\"SVF_NAME\":\"智育奖励分\",\"SVF_FIELD\":\"BSC_INTELLECTUAL_POINTS\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"2510375538917376\"}', '2018-08-11 13:56:59', 1);
INSERT INTO `sys_value_record` VALUES ('50337538728001536', '1', 'sys_validate_field', '50337538673475584', NULL, '{\"SVF_IS_REQUIRED\":\"0\",\"SVF_MAX_LENGTH\":\"3\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50337538673475584\",\"SVF_NAME\":\"智育得分\",\"SVF_FIELD\":\"BSC_INTELLECTUAL_SCORE\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"2511687219412992\"}', '2018-08-11 13:57:13', 1);
INSERT INTO `sys_value_record` VALUES ('50337758199152640', '1', 'sys_validate_field', '50337758119460864', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"3\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50337758119460864\",\"SVF_NAME\":\"志愿者总分\",\"SVF_FIELD\":\"BSC_VOLUNTEER_TOTAL\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"2510375538917376\"}', '2018-08-11 13:58:06', 1);
INSERT INTO `sys_value_record` VALUES ('50337840441065472', '1', 'sys_validate_field', '50337840424288256', NULL, '{\"SVF_IS_REQUIRED\":\"0\",\"SVF_MAX_LENGTH\":\"3\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50337840424288256\",\"SVF_NAME\":\"志愿者得分\",\"SVF_FIELD\":\"BSC_VOLUNTEER_SCORE\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"2511687219412992\"}', '2018-08-11 13:58:25', 1);
INSERT INTO `sys_value_record` VALUES ('50337885961846784', '1', 'sys_validate_field', '50337885945069568', NULL, '{\"SVF_IS_REQUIRED\":\"0\",\"SVF_MAX_LENGTH\":\"500\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50337885945069568\",\"SVF_NAME\":\"备注\",\"SVF_FIELD\":\"BSC_REMARKS\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"\"}', '2018-08-11 13:58:36', 1);
INSERT INTO `sys_value_record` VALUES ('50338340376936448', '1', 'SYS_MENU', '50338340347576320', NULL, '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"\",\"SVR_TABLE_NAME\":\"SYS_MENU\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":\"30\",\"SM_CODE\":\"\",\"SM_NAME\":\"综合素质测评\",\"SM_PARENTID\":\"49027088874733568\",\"ID\":\"50338340347576320\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-elevator\",\"SM_IS_EXPAND\":\"\"}', '2018-08-11 14:00:25', 1);
INSERT INTO `sys_value_record` VALUES ('50338456752095232', '1', 'SYS_MENU', '50338340347576320', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":30,\"SM_CODE\":\"\",\"SM_NAME\":\"综合素质测评\",\"SM_PARENTID\":\"49027088874733568\",\"ID\":\"50338340347576320\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-elevator\",\"SM_IS_EXPAND\":\"\"}', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_TYPE\":\"1\",\"SM_ORDER\":\"30\",\"SM_CODE\":\"STUDENT:COMPREHENSIVE\",\"SM_NAME\":\"综合素质测评\",\"SM_PARENTID\":\"49027088874733568\",\"ID\":\"50338340347576320\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-elevator\",\"SM_IS_EXPAND\":\"\"}', '2018-08-11 14:00:52', 2);
INSERT INTO `sys_value_record` VALUES ('50338484807794688', '1', 'SYS_MENU', '50338340347576320', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":30,\"SM_CODE\":\"STUDENT:COMPREHENSIVE\",\"SM_NAME\":\"综合素质测评\",\"SM_PARENTID\":\"49027088874733568\",\"ID\":\"50338340347576320\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-elevator\",\"SM_IS_EXPAND\":\"\"}', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_TYPE\":\"1\",\"SM_ORDER\":\"30\",\"SM_CODE\":\"STUDENT:COMPREHENSIVE\",\"SM_NAME\":\"综合素质测评\",\"SM_PARENTID\":\"49027088874733568\",\"ID\":\"50338340347576320\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-elevator\",\"SM_IS_EXPAND\":\"\"}', '2018-08-11 14:00:59', 2);
INSERT INTO `sys_value_record` VALUES ('50338719860785152', '1', 'SYS_CONFIGURE', '50338719827230720', NULL, '{\"SC_IS_PAGING\":\"1\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE\",\"SC_NAME\":\"学生管理-综合素质测评\",\"SC_JSP\":\"admin/student/comprehensive/home\",\"SC_VIEW\":\"v_student_comprehensive\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"50338719827230720\",\"SC_ORDER_BY\":\"\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '2018-08-11 14:01:55', 1);
INSERT INTO `sys_value_record` VALUES ('50338816371720192', '1', 'SYS_CONFIGURE', '50338719827230720', '{\"SC_IS_PAGING\":\"1\",\"SC_NAME\":\"学生管理-综合素质测评\",\"SC_JSP\":\"admin/student/comprehensive/home\",\"SC_VIEW\":\"v_student_comprehensive\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"50338719827230720\",\"SC_ORDER_BY\":\"\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '{\"SC_NAME\":\"学生管理-综合素质测评\",\"SC_JSP\":\"admin/student/comprehensive/home\",\"SC_VIEW\":\"v_student_comprehensive\",\"SC_ORDER_BY\":\"BSC_YEAR DESC,BSC_SEMESTER DESC,BSC_RANK ASC\",\"SC_IS_PAGING\":\"1\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"50338719827230720\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '2018-08-11 14:02:18', 2);
INSERT INTO `sys_value_record` VALUES ('50339547870920704', '1', 'SYS_CONFIGURE_COLUMN', '50339547778646016', NULL, '{\"SCC_NAME\":\"学生\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"BS_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50339547778646016\",\"SC_ID\":\"50338719827230720\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"1\"}', '2018-08-11 14:05:12', 1);
INSERT INTO `sys_value_record` VALUES ('50339601839030272', '1', 'SYS_CONFIGURE_COLUMN', '50339601818058752', NULL, '{\"SCC_NAME\":\"班级\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"left\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"170px\",\"SCC_FIELD\":\"BC_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50339601818058752\",\"SC_ID\":\"50338719827230720\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"20\"}', '2018-08-11 14:05:25', 1);
INSERT INTO `sys_value_record` VALUES ('50339688719843328', '1', 'SYS_CONFIGURE_COLUMN', '50339688694677504', NULL, '{\"SCC_NAME\":\"学年\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"70px\",\"SCC_FIELD\":\"BSC_YEAR\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50339688694677504\",\"SC_ID\":\"50338719827230720\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"30\"}', '2018-08-11 14:05:46', 1);
INSERT INTO `sys_value_record` VALUES ('50339748861968384', '1', 'SYS_CONFIGURE_COLUMN', '50339748840996864', NULL, '{\"SCC_NAME\":\"学期\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"BSC_SEMESTER\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50339748840996864\",\"SC_ID\":\"50338719827230720\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"BUS_SEMESTER\",\"SCC_ORDER\":\"40\"}', '2018-08-11 14:06:00', 1);
INSERT INTO `sys_value_record` VALUES ('50339810853781504', '1', 'SYS_CONFIGURE_COLUMN', '50339810778284032', NULL, '{\"SCC_NAME\":\"总分\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"BSC_TOTAL\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50339810778284032\",\"SC_ID\":\"50338719827230720\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"50\"}', '2018-08-11 14:06:15', 1);
INSERT INTO `sys_value_record` VALUES ('50339886963621888', '1', 'SYS_CONFIGURE_COLUMN', '50339886946844672', NULL, '{\"SCC_NAME\":\"排名\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"50px\",\"SCC_FIELD\":\"BSC_RANK\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50339886946844672\",\"SC_ID\":\"50338719827230720\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"60\"}', '2018-08-11 14:06:33', 1);
INSERT INTO `sys_value_record` VALUES ('50340030454956032', '1', 'SYS_CONFIGURE_COLUMN', '50340030438178816', NULL, '{\"SCC_NAME\":\"智育得分\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"70px\",\"SCC_FIELD\":\"BSC_INTELLECTUAL_SCORE\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50340030438178816\",\"SC_ID\":\"50338719827230720\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"70\"}', '2018-08-11 14:07:07', 1);
INSERT INTO `sys_value_record` VALUES ('50340096913702912', '1', 'SYS_CONFIGURE_COLUMN', '50340096863371264', NULL, '{\"SCC_NAME\":\"智育排名\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"50px\",\"SCC_FIELD\":\"BSC_INTELLECTUAL_RANK\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50340096863371264\",\"SC_ID\":\"50338719827230720\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"80\"}', '2018-08-11 14:07:23', 1);
INSERT INTO `sys_value_record` VALUES ('50340160289636352', '1', 'SYS_CONFIGURE_COLUMN', '50340160268664832', NULL, '{\"SCC_NAME\":\"操作\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"150px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"50340160268664832\",\"SC_ID\":\"50338719827230720\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"90\"}', '2018-08-11 14:07:38', 1);
INSERT INTO `sys_value_record` VALUES ('50340231395672064', '1', 'SYS_CONFIGURE_SEARCH', '50340231299203072', NULL, '{\"SCS_METHOD_TYPE\":\"4\",\"SCS_TYPE\":\"1\",\"SCS_FIELD\":\"BS_NAME\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_SEARCH\",\"SCS_NAME\":\"学生\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"50340231299203072\",\"SC_ID\":\"50338719827230720\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":\"1\"}', '2018-08-11 14:07:55', 1);
INSERT INTO `sys_value_record` VALUES ('50340297267216384', '1', 'SYS_CONFIGURE_SEARCH', '50340297250439168', NULL, '{\"SCS_METHOD_TYPE\":\"4\",\"SCS_TYPE\":\"1\",\"SCS_FIELD\":\"BC_NAME\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_SEARCH\",\"SCS_NAME\":\"班级\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"50340297250439168\",\"SC_ID\":\"50338719827230720\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":\"20\"}', '2018-08-11 14:08:11', 1);
INSERT INTO `sys_value_record` VALUES ('50340356226547712', '1', 'SYS_CONFIGURE_SEARCH', '50340356205576192', NULL, '{\"SCS_METHOD_TYPE\":\"1\",\"SCS_TYPE\":\"4\",\"SCS_FIELD\":\"BSC_YEAR\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_SEARCH\",\"SCS_NAME\":\"学年\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"50340356205576192\",\"SC_ID\":\"50338719827230720\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":\"30\"}', '2018-08-11 14:08:25', 1);
INSERT INTO `sys_value_record` VALUES ('50340412149202944', '1', 'SYS_CONFIGURE_SEARCH', '50340412128231424', NULL, '{\"SCS_METHOD_TYPE\":\"1\",\"SCS_TYPE\":\"2\",\"SCS_FIELD\":\"BUS_SEMESTER\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_SEARCH\",\"SCS_NAME\":\"学期\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"50340412128231424\",\"SC_ID\":\"50338719827230720\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":\"40\"}', '2018-08-11 14:08:38', 1);
INSERT INTO `sys_value_record` VALUES ('50340470169010176', '1', 'SYS_MENU', '50338340347576320', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":30,\"SM_CODE\":\"STUDENT:COMPREHENSIVE\",\"SM_NAME\":\"综合素质测评\",\"SM_PARENTID\":\"49027088874733568\",\"ID\":\"50338340347576320\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-elevator\",\"SM_IS_EXPAND\":\"\"}', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_TYPE\":\"1\",\"SM_ORDER\":\"30\",\"SM_CODE\":\"STUDENT:COMPREHENSIVE\",\"SM_NAME\":\"综合素质测评\",\"SM_PARENTID\":\"49027088874733568\",\"ID\":\"50338340347576320\",\"SC_ID\":\"50338719827230720\",\"SM_CLASSICON\":\"mdi mdi-elevator\",\"SM_IS_EXPAND\":\"\"}', '2018-08-11 14:08:52', 2);
INSERT INTO `sys_value_record` VALUES ('50341592317296640', '1', 'SYS_MENU', '50341592241799168', NULL, '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"\",\"SVR_TABLE_NAME\":\"SYS_MENU\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":\"1\",\"SM_CODE\":\"STUDENT:COMPREHENSIVE_UPDATE\",\"SM_NAME\":\"班级\",\"SM_PARENTID\":\"50338340347576320\",\"ID\":\"50341592241799168\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '2018-08-11 14:13:20', 1);
INSERT INTO `sys_value_record` VALUES ('50341636684644352', '1', 'SYS_MENU', '50341592241799168', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":1,\"SM_CODE\":\"STUDENT:COMPREHENSIVE_UPDATE\",\"SM_NAME\":\"班级\",\"SM_PARENTID\":\"50338340347576320\",\"ID\":\"50341592241799168\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_TYPE\":\"1\",\"SM_ORDER\":\"1\",\"SM_CODE\":\"STUDENT:COMPREHENSIVE_UPDATE\",\"SM_NAME\":\"编辑\",\"SM_PARENTID\":\"50338340347576320\",\"ID\":\"50341592241799168\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '2018-08-11 14:13:30', 2);
INSERT INTO `sys_value_record` VALUES ('50343501551894528', '1', 'SYS_MENU', '50341592241799168', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":1,\"SM_CODE\":\"STUDENT:COMPREHENSIVE_UPDATE\",\"SM_NAME\":\"编辑\",\"SM_PARENTID\":\"50338340347576320\",\"ID\":\"50341592241799168\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_TYPE\":\"1\",\"SM_ORDER\":\"1\",\"SM_CODE\":\"STUDENT:COMPREHENSIVE_UPDATE\",\"SM_NAME\":\"综合素质测评\",\"SM_PARENTID\":\"50338340347576320\",\"ID\":\"50341592241799168\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '2018-08-11 14:20:55', 2);
INSERT INTO `sys_value_record` VALUES ('50343577787564032', '1', 'SYS_MENU', '50341592241799168', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":1,\"SM_CODE\":\"STUDENT:COMPREHENSIVE_UPDATE\",\"SM_NAME\":\"综合素质测评\",\"SM_PARENTID\":\"50338340347576320\",\"ID\":\"50341592241799168\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_TYPE\":\"1\",\"SM_ORDER\":\"1\",\"SM_CODE\":\"STUDENT:COMPREHENSIVE_ADD_OR_UPDATE\",\"SM_NAME\":\"综合素质测评\",\"SM_PARENTID\":\"50338340347576320\",\"ID\":\"50341592241799168\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '2018-08-11 14:21:13', 2);
INSERT INTO `sys_value_record` VALUES ('50343614953291776', '1', 'SYS_MENU', '50341592241799168', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":1,\"SM_CODE\":\"STUDENT:COMPREHENSIVE_ADD_OR_UPDATE\",\"SM_NAME\":\"综合素质测评\",\"SM_PARENTID\":\"50338340347576320\",\"ID\":\"50341592241799168\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_TYPE\":\"1\",\"SM_ORDER\":\"1\",\"SM_CODE\":\"STUDENT:COMPREHENSIVE_INSERT_OR_UPDATE\",\"SM_NAME\":\"综合素质测评\",\"SM_PARENTID\":\"50338340347576320\",\"ID\":\"50341592241799168\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '2018-08-11 14:21:22', 2);
INSERT INTO `sys_value_record` VALUES ('50343886408646656', '1', 'SYS_MENU', '50341592241799168', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":1,\"SM_CODE\":\"STUDENT:COMPREHENSIVE_INSERT_OR_UPDATE\",\"SM_NAME\":\"综合素质测评\",\"SM_PARENTID\":\"50338340347576320\",\"ID\":\"50341592241799168\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_TYPE\":\"1\",\"SM_ORDER\":\"1\",\"SM_CODE\":\"STUDENT:COMPREHENSIVE_INSERT_AND_UPDATE\",\"SM_NAME\":\"综合素质测评\",\"SM_PARENTID\":\"50338340347576320\",\"ID\":\"50341592241799168\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '2018-08-11 14:22:27', 2);
INSERT INTO `sys_value_record` VALUES ('50344979142279168', '1', 'SYS_MENU', '50341592241799168', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":1,\"SM_CODE\":\"STUDENT:COMPREHENSIVE_INSERT_AND_UPDATE\",\"SM_NAME\":\"综合素质测评\",\"SM_PARENTID\":\"50338340347576320\",\"ID\":\"50341592241799168\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"admin/student/comprehensive/insertAndUpdate\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_TYPE\":\"1\",\"SM_ORDER\":\"1\",\"SM_CODE\":\"STUDENT:COMPREHENSIVE_INSERT_AND_UPDATE\",\"SM_NAME\":\"综合素质测评\",\"SM_PARENTID\":\"50338340347576320\",\"ID\":\"50341592241799168\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '2018-08-11 14:26:47', 2);
INSERT INTO `sys_value_record` VALUES ('50347333795184640', '1', 'SYS_VALIDATE', '50335819809947648', '{\"IS_STATUS\":1,\"SV_TABLE\":\"BUS_STUDENT_COMPREHENSIVE\",\"ID\":\"50335819809947648\"}', '{\"SV_TABLE\":\"BUS_STUDENT_COMPREHENSIVE\",\"ID\":\"50335819809947648\"}', '2018-08-11 14:36:09', 2);
INSERT INTO `sys_value_record` VALUES ('50353286573719552', '1', 'sys_validate_field', '50336500797145088', '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"2\",\"IS_STATUS\":1,\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50336500797145088\",\"SVF_NAME\":\"政治态度和表现\",\"SVF_FIELD\":\"BSC_POLITICAL_ATTITUDE\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"2510375538917377\"}', '{\"SVF_MIN_LENGTH\":\"\",\"SVF_NAME\":\"政治态度和表现\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"2510375538917376\",\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"2\",\"ID\":\"50336500797145088\",\"SVF_FIELD\":\"BSC_POLITICAL_ATTITUDE\"}', '2018-08-11 14:59:48', 2);
INSERT INTO `sys_value_record` VALUES ('50353313949941760', '1', 'sys_validate_field', '50336500797145088', '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"2\",\"IS_STATUS\":1,\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50336500797145088\",\"SVF_NAME\":\"政治态度和表现\",\"SVF_FIELD\":\"BSC_POLITICAL_ATTITUDE\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"2510375538917376\"}', '{\"SVF_MIN_LENGTH\":\"\",\"SVF_NAME\":\"政治态度和表现\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"2510375538917377\",\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"2\",\"ID\":\"50336500797145088\",\"SVF_FIELD\":\"BSC_POLITICAL_ATTITUDE\"}', '2018-08-11 14:59:54', 2);
INSERT INTO `sys_value_record` VALUES ('50353365426634752', '1', 'sys_validate_field', '50336554182246400', '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"2\",\"IS_STATUS\":1,\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50336554182246400\",\"SVF_NAME\":\"劳动态度和表现\",\"SVF_FIELD\":\"BSC_LABOR_ATTITUDE\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"2510375538917377\"}', '{\"SVF_MIN_LENGTH\":\"\",\"SVF_NAME\":\"劳动态度和表现\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"2510375538917377\",\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"2\",\"ID\":\"50336554182246400\",\"SVF_FIELD\":\"BSC_LABOR_ATTITUDE\"}', '2018-08-11 15:00:07', 2);
INSERT INTO `sys_value_record` VALUES ('50369960853110784', '1', 'sys_validate_field', '50337840424288256', '{\"SVF_IS_REQUIRED\":\"0\",\"SVF_MAX_LENGTH\":\"3\",\"IS_STATUS\":1,\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50337840424288256\",\"SVF_NAME\":\"志愿者得分\",\"SVF_FIELD\":\"BSC_VOLUNTEER_SCORE\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"2511687219412992\"}', '{\"SVF_MIN_LENGTH\":\"\",\"SVF_NAME\":\"志愿者得分\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"2511687219412992\",\"SVF_IS_REQUIRED\":\"0\",\"SVF_MAX_LENGTH\":\"5\",\"ID\":\"50337840424288256\",\"SVF_FIELD\":\"BSC_VOLUNTEER_SCORE\"}', '2018-08-11 16:06:03', 2);
INSERT INTO `sys_value_record` VALUES ('50369975352819712', '1', 'sys_validate_field', '50337758119460864', '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"3\",\"IS_STATUS\":1,\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50337758119460864\",\"SVF_NAME\":\"志愿者总分\",\"SVF_FIELD\":\"BSC_VOLUNTEER_TOTAL\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"2510375538917377\"}', '{\"SVF_MIN_LENGTH\":\"\",\"SVF_NAME\":\"志愿者总分\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"2510375538917377\",\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"5\",\"ID\":\"50337758119460864\",\"SVF_FIELD\":\"BSC_VOLUNTEER_TOTAL\"}', '2018-08-11 16:06:07', 2);
INSERT INTO `sys_value_record` VALUES ('50369996253036544', '1', 'sys_validate_field', '50337538673475584', '{\"SVF_IS_REQUIRED\":\"0\",\"SVF_MAX_LENGTH\":\"3\",\"IS_STATUS\":1,\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50337538673475584\",\"SVF_NAME\":\"智育得分\",\"SVF_FIELD\":\"BSC_INTELLECTUAL_SCORE\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"2511687219412992\"}', '{\"SVF_MIN_LENGTH\":\"\",\"SVF_NAME\":\"智育得分\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"2511687219412992\",\"SVF_IS_REQUIRED\":\"0\",\"SVF_MAX_LENGTH\":\"5\",\"ID\":\"50337538673475584\",\"SVF_FIELD\":\"BSC_INTELLECTUAL_SCORE\"}', '2018-08-11 16:06:12', 2);
INSERT INTO `sys_value_record` VALUES ('50370017711095808', '1', 'sys_validate_field', '50337295252848640', '{\"SVF_IS_REQUIRED\":\"0\",\"SVF_MAX_LENGTH\":\"3\",\"IS_STATUS\":1,\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50337295252848640\",\"SVF_NAME\":\"德育得分\",\"SVF_FIELD\":\"BSC_EDUCATION_SCORE\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"2511687219412992\"}', '{\"SVF_MIN_LENGTH\":\"\",\"SVF_NAME\":\"德育得分\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"2511687219412992\",\"SVF_IS_REQUIRED\":\"0\",\"SVF_MAX_LENGTH\":\"5\",\"ID\":\"50337295252848640\",\"SVF_FIELD\":\"BSC_EDUCATION_SCORE\"}', '2018-08-11 16:06:17', 2);
INSERT INTO `sys_value_record` VALUES ('50370034010161152', '1', 'sys_validate_field', '50337397790998528', '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"3\",\"IS_STATUS\":1,\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50337397790998528\",\"SVF_NAME\":\"学习成绩\",\"SVF_FIELD\":\"BSC_ACADEMIC_RECORD\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"2510375538917377\"}', '{\"SVF_MIN_LENGTH\":\"\",\"SVF_NAME\":\"学习成绩\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"2510375538917377\",\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"5\",\"ID\":\"50337397790998528\",\"SVF_FIELD\":\"BSC_ACADEMIC_RECORD\"}', '2018-08-11 16:06:21', 2);
INSERT INTO `sys_value_record` VALUES ('50370215568998400', '1', 'sys_validate_field', '50335893340291072', '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"5\",\"IS_STATUS\":1,\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50335893340291072\",\"SVF_NAME\":\"学生\",\"SVF_FIELD\":\"BS_ID\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"\"}', '{\"SVF_MIN_LENGTH\":\"\",\"SVF_NAME\":\"学生\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"\",\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"\",\"ID\":\"50335893340291072\",\"SVF_FIELD\":\"BS_ID\"}', '2018-08-11 16:07:04', 2);
INSERT INTO `sys_value_record` VALUES ('50370232245551104', '1', 'sys_validate_field', '50335942816301056', '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"5\",\"IS_STATUS\":1,\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50335942816301056\",\"SVF_NAME\":\"学年\",\"SVF_FIELD\":\"BSC_YEAR\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"26504926733533184\"}', '{\"SVF_MIN_LENGTH\":\"\",\"SVF_NAME\":\"学年\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"26504926733533184\",\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"\",\"ID\":\"50335942816301056\",\"SVF_FIELD\":\"BSC_YEAR\"}', '2018-08-11 16:07:08', 2);
INSERT INTO `sys_value_record` VALUES ('50370249102458880', '1', 'sys_validate_field', '50335976446230528', '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"5\",\"IS_STATUS\":1,\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50335976446230528\",\"SVF_NAME\":\"学期\",\"SVF_FIELD\":\"BSC_SEMESTER\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"\"}', '{\"SVF_MIN_LENGTH\":\"\",\"SVF_NAME\":\"学期\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"\",\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"\",\"ID\":\"50335976446230528\",\"SVF_FIELD\":\"BSC_SEMESTER\"}', '2018-08-11 16:07:12', 2);
INSERT INTO `sys_value_record` VALUES ('50370276751310848', '1', 'sys_validate_field', '50337885945069568', '{\"SVF_IS_REQUIRED\":\"0\",\"SVF_MAX_LENGTH\":\"5\",\"IS_STATUS\":1,\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50337885945069568\",\"SVF_NAME\":\"备注\",\"SVF_FIELD\":\"BSC_REMARKS\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"\"}', '{\"SVF_MIN_LENGTH\":\"\",\"SVF_NAME\":\"备注\",\"SV_ID\":\"50335819809947648\",\"SVR_ID\":\"\",\"SVF_IS_REQUIRED\":\"0\",\"SVF_MAX_LENGTH\":\"500\",\"ID\":\"50337885945069568\",\"SVF_FIELD\":\"BSC_REMARKS\"}', '2018-08-11 16:07:19', 2);
INSERT INTO `sys_value_record` VALUES ('50372700194996224', '1', 'SYS_CONFIGURE_COLUMN', '50340030438178816', '{\"SCC_NAME\":\"智育得分\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"70px\",\"SCC_FIELD\":\"BSC_INTELLECTUAL_SCORE\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50340030438178816\",\"SC_ID\":\"50338719827230720\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":70}', '{\"SCC_NAME\":\"学习成绩\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"70px\",\"SCC_FIELD\":\"BSC_ACADEMIC_RECORD\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50340030438178816\",\"SC_ID\":\"50338719827230720\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"70\"}', '2018-08-11 16:16:57', 2);
INSERT INTO `sys_value_record` VALUES ('50374837184495616', '1', 'SYS_CONFIGURE_COLUMN', '50340096863371264', '{\"SCC_NAME\":\"智育排名\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"50px\",\"SCC_FIELD\":\"BSC_INTELLECTUAL_RANK\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50340096863371264\",\"SC_ID\":\"50338719827230720\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":80}', '{\"SCC_NAME\":\"智育排名\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"70px\",\"SCC_FIELD\":\"BSC_INTELLECTUAL_RANK\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50340096863371264\",\"SC_ID\":\"50338719827230720\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"80\"}', '2018-08-11 16:25:26', 2);
INSERT INTO `sys_value_record` VALUES ('50374904893145088', '1', 'SYS_CONFIGURE_COLUMN', '50339810778284032', '{\"SCC_NAME\":\"总分\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"BSC_TOTAL\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50339810778284032\",\"SC_ID\":\"50338719827230720\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":50}', '{\"SCC_NAME\":\"总分\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"70px\",\"SCC_FIELD\":\"BSC_TOTAL\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50339810778284032\",\"SC_ID\":\"50338719827230720\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"50\"}', '2018-08-11 16:25:42', 2);
INSERT INTO `sys_value_record` VALUES ('50374967895785472', '1', 'SYS_CONFIGURE_COLUMN', '50339748840996864', '{\"SCC_NAME\":\"学期\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"BSC_SEMESTER\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50339748840996864\",\"SC_ID\":\"50338719827230720\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"BUS_SEMESTER\",\"SCC_ORDER\":40}', '{\"SCC_NAME\":\"学期\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"80px\",\"SCC_FIELD\":\"BSC_SEMESTER\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50339748840996864\",\"SC_ID\":\"50338719827230720\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"BUS_SEMESTER\",\"SCC_ORDER\":\"40\"}', '2018-08-11 16:25:57', 2);
INSERT INTO `sys_value_record` VALUES ('50375042252406784', '1', 'SYS_CONFIGURE_COLUMN', '50339748840996864', '{\"SCC_NAME\":\"学期\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"80px\",\"SCC_FIELD\":\"BSC_SEMESTER\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50339748840996864\",\"SC_ID\":\"50338719827230720\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"BUS_SEMESTER\",\"SCC_ORDER\":40}', '{\"SCC_NAME\":\"学期\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"70px\",\"SCC_FIELD\":\"BSC_SEMESTER\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50339748840996864\",\"SC_ID\":\"50338719827230720\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"BUS_SEMESTER\",\"SCC_ORDER\":\"40\"}', '2018-08-11 16:26:15', 2);
INSERT INTO `sys_value_record` VALUES ('50375203963797504', '1', 'SYS_CONFIGURE_SEARCH', '50340412128231424', '{\"SCS_METHOD_TYPE\":\"1\",\"SCS_TYPE\":\"2\",\"SCS_FIELD\":\"BUS_SEMESTER\",\"SCS_NAME\":\"学期\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"50340412128231424\",\"SC_ID\":\"50338719827230720\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":40}', '{\"SCS_FIELD\":\"BSC_SEMESTER\",\"SCS_NAME\":\"学期\",\"SCS_SDT_CODE\":\"BUS_SEMESTER\",\"SCS_ORDER\":\"40\",\"SCS_METHOD_TYPE\":\"1\",\"SCS_TYPE\":\"2\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"50340412128231424\",\"SC_ID\":\"50338719827230720\",\"SCS_REMARK\":\"\"}', '2018-08-11 16:26:53', 2);
INSERT INTO `sys_value_record` VALUES ('50375353167773696', '1', 'SYS_CONFIGURE_SEARCH', '50340356205576192', '{\"SCS_METHOD_TYPE\":\"1\",\"SCS_TYPE\":\"4\",\"SCS_FIELD\":\"BSC_YEAR\",\"SCS_NAME\":\"学年\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"50340356205576192\",\"SC_ID\":\"50338719827230720\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":30}', '{\"SCS_FIELD\":\"BSC_YEAR\",\"SCS_NAME\":\"学年\",\"SCS_SDT_CODE\":\"\",\"SCS_ORDER\":\"30\",\"SCS_METHOD_TYPE\":\"1\",\"SCS_TYPE\":\"6\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"50340356205576192\",\"SC_ID\":\"50338719827230720\",\"SCS_REMARK\":\"\"}', '2018-08-11 16:27:29', 2);
INSERT INTO `sys_value_record` VALUES ('50375714133770240', '1', 'SYS_CONFIGURE_SEARCH', '50340356205576192', '{\"SCS_METHOD_TYPE\":\"1\",\"SCS_TYPE\":\"6\",\"SCS_FIELD\":\"BSC_YEAR\",\"SCS_NAME\":\"学年\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"50340356205576192\",\"SC_ID\":\"50338719827230720\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":30}', '{\"SCS_FIELD\":\"BSC_YEAR\",\"SCS_NAME\":\"学年\",\"SCS_SDT_CODE\":\"\",\"SCS_ORDER\":\"30\",\"SCS_METHOD_TYPE\":\"1\",\"SCS_TYPE\":\"4\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"50340356205576192\",\"SC_ID\":\"50338719827230720\",\"SCS_REMARK\":\"\"}', '2018-08-11 16:28:55', 2);
INSERT INTO `sys_value_record` VALUES ('50375926449438720', '1', 'SYS_CONFIGURE_SEARCH', '50340356205576192', '{\"SCS_METHOD_TYPE\":\"1\",\"SCS_TYPE\":\"4\",\"SCS_FIELD\":\"BSC_YEAR\",\"SCS_NAME\":\"学年\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"50340356205576192\",\"SC_ID\":\"50338719827230720\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":30}', '{\"SCS_FIELD\":\"BSC_YEAR\",\"SCS_NAME\":\"学年\",\"SCS_SDT_CODE\":\"\",\"SCS_ORDER\":\"30\",\"SCS_METHOD_TYPE\":\"1\",\"SCS_TYPE\":\"6\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"50340356205576192\",\"SC_ID\":\"50338719827230720\",\"SCS_REMARK\":\"\"}', '2018-08-11 16:29:46', 2);
INSERT INTO `sys_value_record` VALUES ('50376566596698112', '1', 'SYS_CONFIGURE_SEARCH', '50340356205576192', '{\"SCS_METHOD_TYPE\":\"1\",\"SCS_TYPE\":\"6\",\"SCS_FIELD\":\"BSC_YEAR\",\"SCS_NAME\":\"学年\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"50340356205576192\",\"SC_ID\":\"50338719827230720\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":30}', '{\"SCS_FIELD\":\"BSC_YEAR\",\"SCS_NAME\":\"学年\",\"SCS_SDT_CODE\":\"\",\"SCS_ORDER\":\"30\",\"SCS_METHOD_TYPE\":\"1\",\"SCS_TYPE\":\"7\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"50340356205576192\",\"SC_ID\":\"50338719827230720\",\"SCS_REMARK\":\"\"}', '2018-08-11 16:32:18', 2);
INSERT INTO `sys_value_record` VALUES ('50376612222337024', '1', 'SYS_CONFIGURE_SEARCH', '50340356205576192', '{\"SCS_METHOD_TYPE\":\"1\",\"SCS_TYPE\":\"7\",\"SCS_FIELD\":\"BSC_YEAR\",\"SCS_NAME\":\"学年\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"50340356205576192\",\"SC_ID\":\"50338719827230720\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":30}', '{\"SCS_FIELD\":\"BSC_YEAR\",\"SCS_NAME\":\"学年\",\"SCS_SDT_CODE\":\"\",\"SCS_ORDER\":\"30\",\"SCS_METHOD_TYPE\":\"1\",\"SCS_TYPE\":\"4\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"50340356205576192\",\"SC_ID\":\"50338719827230720\",\"SCS_REMARK\":\"\"}', '2018-08-11 16:32:29', 2);
INSERT INTO `sys_value_record` VALUES ('50376927038406656', '1', 'SYS_ALLOCATION', '50328920767070208', '{\"SA_MODIFY_TIME\":\"2018-08-11 13:23:29\",\"ID\":\"50328920767070208\",\"SA_KEY\":\"EDUCATION_PROPORTION\",\"SA_VALUE\":\"30\"}', '{\"SA_MODIFY_TIME\":\"2018-08-11 16:33:44\",\"SA_KEY\":\"EDUCATION_PROPORTION\",\"SA_VALUE\":\"40\",\"ID\":\"50328920767070208\"}', '2018-08-11 16:33:44', 2);
INSERT INTO `sys_value_record` VALUES ('50376927222956032', '1', 'SYS_ALLOCATION', '50328920993562624', '{\"SA_MODIFY_TIME\":\"2018-08-11 13:23:29\",\"ID\":\"50328920993562624\",\"SA_KEY\":\"INTELLECTUAL_PROPORTION\",\"SA_VALUE\":\"60\"}', '{\"SA_MODIFY_TIME\":\"2018-08-11 16:33:44\",\"SA_KEY\":\"INTELLECTUAL_PROPORTION\",\"SA_VALUE\":\"50\",\"ID\":\"50328920993562624\"}', '2018-08-11 16:33:44', 2);
INSERT INTO `sys_value_record` VALUES ('50376927512363008', '1', 'SYS_ALLOCATION', '50328921140363264', '{\"SA_MODIFY_TIME\":\"2018-08-11 13:23:29\",\"ID\":\"50328921140363264\",\"SA_KEY\":\"VOLUNTEER_PROPORTION\",\"SA_VALUE\":\"10\"}', '{\"SA_MODIFY_TIME\":\"2018-08-11 16:33:44\",\"SA_KEY\":\"VOLUNTEER_PROPORTION\",\"SA_VALUE\":\"10\",\"ID\":\"50328921140363264\"}', '2018-08-11 16:33:44', 2);
INSERT INTO `sys_value_record` VALUES ('50376981979594752', '1', 'SYS_ALLOCATION', '50328920767070208', '{\"SA_MODIFY_TIME\":\"2018-08-11 16:33:44\",\"ID\":\"50328920767070208\",\"SA_KEY\":\"EDUCATION_PROPORTION\",\"SA_VALUE\":\"40\"}', '{\"SA_MODIFY_TIME\":\"2018-08-11 16:33:57\",\"SA_KEY\":\"EDUCATION_PROPORTION\",\"SA_VALUE\":\"30\",\"ID\":\"50328920767070208\"}', '2018-08-11 16:33:57', 2);
INSERT INTO `sys_value_record` VALUES ('50376982478716928', '1', 'SYS_ALLOCATION', '50328920993562624', '{\"SA_MODIFY_TIME\":\"2018-08-11 16:33:44\",\"ID\":\"50328920993562624\",\"SA_KEY\":\"INTELLECTUAL_PROPORTION\",\"SA_VALUE\":\"50\"}', '{\"SA_MODIFY_TIME\":\"2018-08-11 16:33:57\",\"SA_KEY\":\"INTELLECTUAL_PROPORTION\",\"SA_VALUE\":\"60\",\"ID\":\"50328920993562624\"}', '2018-08-11 16:33:57', 2);
INSERT INTO `sys_value_record` VALUES ('50376982638100480', '1', 'SYS_ALLOCATION', '50328921140363264', '{\"SA_MODIFY_TIME\":\"2018-08-11 16:33:44\",\"ID\":\"50328921140363264\",\"SA_KEY\":\"VOLUNTEER_PROPORTION\",\"SA_VALUE\":\"10\"}', '{\"SA_MODIFY_TIME\":\"2018-08-11 16:33:58\",\"SA_KEY\":\"VOLUNTEER_PROPORTION\",\"SA_VALUE\":\"10\",\"ID\":\"50328921140363264\"}', '2018-08-11 16:33:58', 2);
INSERT INTO `sys_value_record` VALUES ('50674382535655424', '1', 'SYS_VALIDATE_REGEX', '26504926733533184', '{\"IS_STATUS\":\"1\",\"SVR_REGEX\":\"^(19\\\\d\\\\d|20\\\\d\\\\d|2100)$\",\"SVR_REGEX_MESSAGE\":\"请输入正确的年份!\",\"ID\":\"26504926733533184\",\"SVR_NAME\":\"年份\"}', '{\"SVR_REGEX\":\"^(19\\\\d\\\\d|20\\\\d\\\\d|2100|20\\\\d\\\\d~20\\\\d\\\\d)$\",\"SVR_REGEX_MESSAGE\":\"请输入正确的年份!\",\"ID\":\"26504926733533184\",\"SVR_NAME\":\"年份\"}', '2018-08-12 12:15:43', 2);
INSERT INTO `sys_value_record` VALUES ('50675101154148352', '1', 'SYS_CONFIGURE_COLUMN', '49383375462465536', '{\"SCC_NAME\":\"年度\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"70px\",\"SCC_FIELD\":\"BSA_YEAR\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"49383375462465536\",\"SC_ID\":\"49382988399509504\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":20}', '{\"SCC_NAME\":\"学年\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"70px\",\"SCC_FIELD\":\"BSA_YEAR\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"49383375462465536\",\"SC_ID\":\"49382988399509504\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"20\"}', '2018-08-12 12:18:35', 2);
INSERT INTO `sys_value_record` VALUES ('50675751959134208', '1', 'SYS_CONFIGURE_COLUMN', '50339688694677504', '{\"SCC_NAME\":\"学年\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"70px\",\"SCC_FIELD\":\"BSC_YEAR\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50339688694677504\",\"SC_ID\":\"50338719827230720\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":30}', '{\"SCC_NAME\":\"学年\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"80px\",\"SCC_FIELD\":\"BSC_YEAR\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50339688694677504\",\"SC_ID\":\"50338719827230720\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"30\"}', '2018-08-12 12:21:10', 2);
INSERT INTO `sys_value_record` VALUES ('50675803431632896', '1', 'SYS_CONFIGURE_COLUMN', '49383375462465536', '{\"SCC_NAME\":\"学年\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"70px\",\"SCC_FIELD\":\"BSA_YEAR\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"49383375462465536\",\"SC_ID\":\"49382988399509504\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":20}', '{\"SCC_NAME\":\"学年\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"80px\",\"SCC_FIELD\":\"BSA_YEAR\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"49383375462465536\",\"SC_ID\":\"49382988399509504\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"20\"}', '2018-08-12 12:21:22', 2);
INSERT INTO `sys_value_record` VALUES ('50675964589375488', '1', 'SYS_CONFIGURE_COLUMN', '48891009236467712', '{\"SCC_NAME\":\"学号\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"90px\",\"SCC_FIELD\":\"BS_NUMBER\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48891009236467712\",\"SC_ID\":\"48890586014416896\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":30}', '{\"SCC_NAME\":\"学号\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"90px\",\"SCC_FIELD\":\"BS_NUMBER\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48891009236467712\",\"SC_ID\":\"48890586014416896\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"2\"}', '2018-08-12 12:22:00', 2);
INSERT INTO `sys_value_record` VALUES ('50676017408245760', '1', 'SYS_CONFIGURE_COLUMN', '48891120653959168', '{\"SCC_NAME\":\"身份证\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"140px\",\"SCC_FIELD\":\"BS_ID_CARD\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48891120653959168\",\"SC_ID\":\"48890586014416896\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":50}', '{\"SCC_NAME\":\"身份证\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"140px\",\"SCC_FIELD\":\"BS_ID_CARD\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"48891120653959168\",\"SC_ID\":\"48890586014416896\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"3\"}', '2018-08-12 12:22:13', 2);
INSERT INTO `sys_value_record` VALUES ('50747708385787904', '1', 'SYS_ALLOCATION', '50328920767070208', '{\"SA_MODIFY_TIME\":\"2018-08-11 16:33:57\",\"ID\":\"50328920767070208\",\"SA_KEY\":\"EDUCATION_PROPORTION\",\"SA_VALUE\":\"30\"}', '{\"SA_MODIFY_TIME\":\"2018-08-12 17:07:05\",\"SA_KEY\":\"EDUCATION_PROPORTION\",\"SA_VALUE\":\"20\",\"ID\":\"50328920767070208\"}', '2018-08-12 17:07:05', 2);
INSERT INTO `sys_value_record` VALUES ('50747708666806272', '1', 'SYS_ALLOCATION', '50328920993562624', '{\"SA_MODIFY_TIME\":\"2018-08-11 16:33:57\",\"ID\":\"50328920993562624\",\"SA_KEY\":\"INTELLECTUAL_PROPORTION\",\"SA_VALUE\":\"60\"}', '{\"SA_MODIFY_TIME\":\"2018-08-12 17:07:05\",\"SA_KEY\":\"INTELLECTUAL_PROPORTION\",\"SA_VALUE\":\"70\",\"ID\":\"50328920993562624\"}', '2018-08-12 17:07:06', 2);
INSERT INTO `sys_value_record` VALUES ('50747708977184768', '1', 'SYS_ALLOCATION', '50328921140363264', '{\"SA_MODIFY_TIME\":\"2018-08-11 16:33:58\",\"ID\":\"50328921140363264\",\"SA_KEY\":\"VOLUNTEER_PROPORTION\",\"SA_VALUE\":\"10\"}', '{\"SA_MODIFY_TIME\":\"2018-08-12 17:07:06\",\"SA_KEY\":\"VOLUNTEER_PROPORTION\",\"SA_VALUE\":\"10\",\"ID\":\"50328921140363264\"}', '2018-08-12 17:07:06', 2);
INSERT INTO `sys_value_record` VALUES ('50751117927120896', '1', 'SYS_MENU', '50751117243449344', NULL, '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"\",\"SVR_TABLE_NAME\":\"SYS_MENU\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"1\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":\"40\",\"SM_CODE\":\"AID\",\"SM_NAME\":\"资助管理\",\"SM_PARENTID\":\"0\",\"ID\":\"50751117243449344\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-credit-card-multiple\",\"SM_IS_EXPAND\":\"\"}', '2018-08-12 17:20:38', 1);
INSERT INTO `sys_value_record` VALUES ('50790022516834304', '1', 'SYS_DICT_TYPE', '50790022462308352', NULL, '{\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"SYS_DICT_TYPE\",\"SDT_CODE\":\"BUS_AID_FINANCIALLY_TYPE\",\"SDT_ROLE_DEL\":\"\",\"SDT_NAME\":\"业务_资助类型\",\"ID\":\"50790022462308352\",\"SDT_ROLE_DOWN\":\"\"}', '2018-08-12 19:55:14', 1);
INSERT INTO `sys_value_record` VALUES ('50790096101703680', '1', 'SYS_DICT_INFO', '50790095971680256', NULL, '{\"SDI_CODE\":\"1\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"1\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"绿色通道\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_AID_FINANCIALLY_TYPE\",\"SDI_INNERCODE\":\"1\",\"ID\":\"50790095971680256\",\"SDT_ID\":\"50790022462308352\"}', '2018-08-12 19:55:31', 1);
INSERT INTO `sys_value_record` VALUES ('50790130104926208', '1', 'SYS_DICT_INFO', '50790130008457216', NULL, '{\"SDI_CODE\":\"2\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"2\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"国家奖学金\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_AID_FINANCIALLY_TYPE\",\"SDI_INNERCODE\":\"2\",\"ID\":\"50790130008457216\",\"SDT_ID\":\"50790022462308352\"}', '2018-08-12 19:55:40', 1);
INSERT INTO `sys_value_record` VALUES ('50790166561816576', '1', 'SYS_DICT_INFO', '50790166444376064', NULL, '{\"SDI_CODE\":\"3\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"3\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"国家励志奖学金\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_AID_FINANCIALLY_TYPE\",\"SDI_INNERCODE\":\"3\",\"ID\":\"50790166444376064\",\"SDT_ID\":\"50790022462308352\"}', '2018-08-12 19:55:48', 1);
INSERT INTO `sys_value_record` VALUES ('50790205447208960', '1', 'SYS_DICT_INFO', '50790205401071616', NULL, '{\"SDI_CODE\":\"4\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"4\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"国家助学金\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_AID_FINANCIALLY_TYPE\",\"SDI_INNERCODE\":\"4\",\"ID\":\"50790205401071616\",\"SDT_ID\":\"50790022462308352\"}', '2018-08-12 19:55:58', 1);
INSERT INTO `sys_value_record` VALUES ('50790244752031744', '1', 'SYS_DICT_INFO', '50790243997057024', NULL, '{\"SDI_CODE\":\"5\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"5\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"助学贷款\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_AID_FINANCIALLY_TYPE\",\"SDI_INNERCODE\":\"5\",\"ID\":\"50790243997057024\",\"SDT_ID\":\"50790022462308352\"}', '2018-08-12 19:56:07', 1);
INSERT INTO `sys_value_record` VALUES ('50790276486135808', '1', 'SYS_DICT_INFO', '50790276431609856', NULL, '{\"SDI_CODE\":\"6\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"6\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"服兵役学费补助\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_AID_FINANCIALLY_TYPE\",\"SDI_INNERCODE\":\"6\",\"ID\":\"50790276431609856\",\"SDT_ID\":\"50790022462308352\"}', '2018-08-12 19:56:14', 1);
INSERT INTO `sys_value_record` VALUES ('50790303019302912', '1', 'SYS_DICT_INFO', '50790302960582656', NULL, '{\"SDI_CODE\":\"7\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"7\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"减免学费\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_AID_FINANCIALLY_TYPE\",\"SDI_INNERCODE\":\"7\",\"ID\":\"50790302960582656\",\"SDT_ID\":\"50790022462308352\"}', '2018-08-12 19:56:21', 1);
INSERT INTO `sys_value_record` VALUES ('50790367850659840', '1', 'SYS_DICT_INFO', '50790367791939584', NULL, '{\"SDI_CODE\":\"8\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"8\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"勤工助学\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_AID_FINANCIALLY_TYPE\",\"SDI_INNERCODE\":\"8\",\"ID\":\"50790367791939584\",\"SDT_ID\":\"50790022462308352\"}', '2018-08-12 19:56:36', 1);
INSERT INTO `sys_value_record` VALUES ('50790397068181504', '1', 'SYS_DICT_INFO', '50790397001072640', NULL, '{\"SDI_CODE\":\"9\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"9\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"学校奖学金\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_AID_FINANCIALLY_TYPE\",\"SDI_INNERCODE\":\"9\",\"ID\":\"50790397001072640\",\"SDT_ID\":\"50790022462308352\"}', '2018-08-12 19:56:43', 1);
INSERT INTO `sys_value_record` VALUES ('50790437694210048', '1', 'SYS_DICT_INFO', '50790437622906880', NULL, '{\"SDI_CODE\":\"10\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"10\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"年度表彰\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_AID_FINANCIALLY_TYPE\",\"SDI_INNERCODE\":\"10\",\"ID\":\"50790437622906880\",\"SDT_ID\":\"50790022462308352\"}', '2018-08-12 19:56:53', 1);
INSERT INTO `sys_value_record` VALUES ('50790473010249728', '1', 'SYS_DICT_INFO', '50790472951529472', NULL, '{\"SDI_CODE\":\"11\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"11\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"困难毕业生就业补助\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_AID_FINANCIALLY_TYPE\",\"SDI_INNERCODE\":\"11\",\"ID\":\"50790472951529472\",\"SDT_ID\":\"50790022462308352\"}', '2018-08-12 19:57:01', 1);
INSERT INTO `sys_value_record` VALUES ('50790583299473408', '1', 'SYS_DICT_INFO', '50790583232364544', NULL, '{\"SDI_CODE\":\"13\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"13\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"应急救助\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_AID_FINANCIALLY_TYPE\",\"SDI_INNERCODE\":\"13\",\"ID\":\"50790583232364544\",\"SDT_ID\":\"50790022462308352\"}', '2018-08-12 19:57:28', 1);
INSERT INTO `sys_value_record` VALUES ('50790618632290304', '1', 'SYS_DICT_INFO', '50790618569375744', NULL, '{\"SDI_CODE\":\"14\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"14\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"中职助学金\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_AID_FINANCIALLY_TYPE\",\"SDI_INNERCODE\":\"14\",\"ID\":\"50790618569375744\",\"SDT_ID\":\"50790022462308352\"}', '2018-08-12 19:57:36', 1);
INSERT INTO `sys_value_record` VALUES ('50796082757632000', '1', 'SYS_DICT_TYPE', '50796082694717440', NULL, '{\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"SYS_DICT_TYPE\",\"SDT_CODE\":\"BUS_COLLEGE_SCHOLARSHIP_TYPE\",\"SDT_ROLE_DEL\":\"\",\"SDT_NAME\":\"业务_学院奖学金类型\",\"ID\":\"50796082694717440\",\"SDT_ROLE_DOWN\":\"\"}', '2018-08-12 20:19:19', 1);
INSERT INTO `sys_value_record` VALUES ('50796267793547264', '1', 'SYS_DICT_INFO', '50796267739021312', NULL, '{\"SDI_CODE\":\"FIRST-CLASS\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"1\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"一等奖学金\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_COLLEGE_SCHOLARSHIP_TYPE\",\"SDI_INNERCODE\":\"FIRST-CLASS\",\"ID\":\"50796267739021312\",\"SDT_ID\":\"50796082694717440\"}', '2018-08-12 20:20:03', 1);
INSERT INTO `sys_value_record` VALUES ('50796380398026752', '1', 'SYS_DICT_INFO', '50796380301557760', NULL, '{\"SDI_CODE\":\"SECOND-CLASS\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"212\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"二等奖学金\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_COLLEGE_SCHOLARSHIP_TYPE\",\"SDI_INNERCODE\":\"SECOND-CLASS\",\"ID\":\"50796380301557760\",\"SDT_ID\":\"50796082694717440\"}', '2018-08-12 20:20:30', 1);
INSERT INTO `sys_value_record` VALUES ('50796394289561600', '1', 'SYS_DICT_INFO', '50796380301557760', '{\"SDI_CODE\":\"SECOND-CLASS\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_COLLEGE_SCHOLARSHIP_TYPE\",\"SDI_REQUIRED\":0,\"SDI_INNERCODE\":\"SECOND-CLASS\",\"SDI_ORDER\":212,\"SDI_REMARK\":\"\",\"SDI_NAME\":\"二等奖学金\",\"ID\":\"50796380301557760\",\"SDI_PARENTID\":\"0\",\"SDT_ID\":\"50796082694717440\"}', '{\"SDI_CODE\":\"SECOND-CLASS\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"2\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"二等奖学金\",\"SDI_PARENTID\":\"0\",\"SDI_INNERCODE\":\"SECOND-CLASS\",\"ID\":\"50796380301557760\",\"SDT_ID\":\"50796082694717440\"}', '2018-08-12 20:20:33', 2);
INSERT INTO `sys_value_record` VALUES ('50796513701396480', '1', 'SYS_CONFIGURE_COLUMN', '2913416456962048', '{\"SCC_NAME\":\"信息编码\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"SDI_CODE\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"2913416456962048\",\"SC_ID\":\"2912701923721216\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":2}', '{\"SCC_NAME\":\"信息编码\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"130px\",\"SCC_FIELD\":\"SDI_CODE\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"2913416456962048\",\"SC_ID\":\"2912701923721216\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"2\"}', '2018-08-12 20:21:02', 2);
INSERT INTO `sys_value_record` VALUES ('50796530440863744', '1', 'SYS_CONFIGURE_COLUMN', '2913455988277248', '{\"SCC_NAME\":\"连接编码\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"SDI_INNERCODE\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"2913455988277248\",\"SC_ID\":\"2912701923721216\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":3}', '{\"SCC_NAME\":\"连接编码\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"150px\",\"SCC_FIELD\":\"SDI_INNERCODE\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"2913455988277248\",\"SC_ID\":\"2912701923721216\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"3\"}', '2018-08-12 20:21:06', 2);
INSERT INTO `sys_value_record` VALUES ('50796555929649152', '1', 'SYS_CONFIGURE_COLUMN', '2913615233417216', '{\"SCC_NAME\":\"备注\",\"SCC_FUNC\":\"\",\"SCC_ALIGN\":\"left\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"280px\",\"SCC_FIELD\":\"SDI_REMARK\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"2913615233417216\",\"SC_ID\":\"2912701923721216\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":4}', '{\"SCC_NAME\":\"备注\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"left\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"200px\",\"SCC_FIELD\":\"SDI_REMARK\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"2913615233417216\",\"SC_ID\":\"2912701923721216\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"4\"}', '2018-08-12 20:21:12', 2);
INSERT INTO `sys_value_record` VALUES ('50796718224048128', '1', 'SYS_DICT_INFO', '50796718186299392', NULL, '{\"SDI_CODE\":\"THIRD-CLASS\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"3\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"三等奖学金\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_COLLEGE_SCHOLARSHIP_TYPE\",\"SDI_INNERCODE\":\"THIRD-CLASS\",\"ID\":\"50796718186299392\",\"SDT_ID\":\"50796082694717440\"}', '2018-08-12 20:21:50', 1);
INSERT INTO `sys_value_record` VALUES ('50800567542349824', '1', 'SYS_BUTTON', '50800567487823872', NULL, '{\"SB_CODE\":\"COPY\",\"SVR_TABLE_NAME\":\"SYS_BUTTON\",\"SB_FUNC\":\"\",\"SB_CLASS\":\"btn btn-danger\",\"SB_ORDER\":\"9\",\"SB_BUTTONID\":\"copy\",\"SB_ICON\":\"mdi mdi-content-copy\",\"ID\":\"50800567487823872\",\"SB_TYPE\":\"0\",\"SB_NAME\":\"拷贝\"}', '2018-08-12 20:37:08', 1);
INSERT INTO `sys_value_record` VALUES ('50802464521191424', '1', 'SYS_DICT_INFO', '50802464470859776', NULL, '{\"SDI_CODE\":\"1\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"1\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"资助管理\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"SYS_PROCESS_TYPE\",\"SDI_INNERCODE\":\"1\",\"ID\":\"50802464470859776\",\"SDT_ID\":\"9\"}', '2018-08-12 20:44:40', 1);
INSERT INTO `sys_value_record` VALUES ('50802594678833152', '1', 'SYS_DICT_INFO', '50802594620112896', NULL, '{\"SDI_CODE\":\"1\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"1\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"学校奖学金\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"SYS_PROCESS_TYPE\",\"SDI_INNERCODE\":\"1.1\",\"ID\":\"50802594620112896\",\"SDT_ID\":\"9\"}', '2018-08-12 20:45:11', 1);
INSERT INTO `sys_value_record` VALUES ('50802618443759616', '1', 'SYS_DICT_INFO', '50802594620112896', '{\"SDI_CODE\":\"1\",\"IS_STATUS\":1,\"SDT_CODE\":\"SYS_PROCESS_TYPE\",\"SDI_REQUIRED\":0,\"SDI_INNERCODE\":\"1.1\",\"SDI_ORDER\":1,\"SDI_REMARK\":\"\",\"SDI_NAME\":\"学校奖学金\",\"ID\":\"50802594620112896\",\"SDI_PARENTID\":\"0\",\"SDT_ID\":\"9\"}', '{\"SDI_CODE\":\"1\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"1\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"学校奖学金\",\"SDI_PARENTID\":\"50802464470859776\",\"SDI_INNERCODE\":\"1.1\",\"ID\":\"50802594620112896\",\"SDT_ID\":\"9\"}', '2018-08-12 20:45:17', 2);
INSERT INTO `sys_value_record` VALUES ('50804259507142656', '1', 'SYS_DICT_INFO', '50802594620112896', '{\"SDI_CODE\":\"1\",\"IS_STATUS\":1,\"SDT_CODE\":\"SYS_PROCESS_TYPE\",\"SDI_REQUIRED\":0,\"SDI_INNERCODE\":\"1.1\",\"SDI_ORDER\":1,\"SDI_REMARK\":\"\",\"SDI_NAME\":\"学校奖学金\",\"ID\":\"50802594620112896\",\"SDI_PARENTID\":\"50802464470859776\",\"SDT_ID\":\"9\"}', '{\"SDI_CODE\":\"109\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"9\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"学校奖学金\",\"SDI_PARENTID\":\"50802464470859776\",\"SDI_INNERCODE\":\"1.109\",\"ID\":\"50802594620112896\",\"SDT_ID\":\"9\"}', '2018-08-12 20:51:48', 2);
INSERT INTO `sys_value_record` VALUES ('50804289936818176', '1', 'SYS_DICT_INFO', '50802464470859776', '{\"SDI_CODE\":\"1\",\"IS_STATUS\":1,\"SDT_CODE\":\"SYS_PROCESS_TYPE\",\"SDI_REQUIRED\":0,\"SDI_INNERCODE\":\"1\",\"SDI_ORDER\":1,\"SDI_REMARK\":\"\",\"SDI_NAME\":\"资助管理\",\"ID\":\"50802464470859776\",\"SDI_PARENTID\":\"0\",\"SDT_ID\":\"9\"}', '{\"SDI_CODE\":\"100\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"1\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"资助管理\",\"SDI_PARENTID\":\"0\",\"SDI_INNERCODE\":\"100\",\"ID\":\"50802464470859776\",\"SDT_ID\":\"9\"}', '2018-08-12 20:51:56', 2);
INSERT INTO `sys_value_record` VALUES ('50804302939160576', '1', 'SYS_DICT_INFO', '50802464470859776', '{\"SDI_CODE\":\"100\",\"IS_STATUS\":1,\"SDT_CODE\":\"SYS_PROCESS_TYPE\",\"SDI_REQUIRED\":0,\"SDI_INNERCODE\":\"100\",\"SDI_ORDER\":1,\"SDI_REMARK\":\"\",\"SDI_NAME\":\"资助管理\",\"ID\":\"50802464470859776\",\"SDI_PARENTID\":\"0\",\"SDT_ID\":\"9\"}', '{\"SDI_CODE\":\"100\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"100\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"资助管理\",\"SDI_PARENTID\":\"0\",\"SDI_INNERCODE\":\"100\",\"ID\":\"50802464470859776\",\"SDT_ID\":\"9\"}', '2018-08-12 20:51:59', 2);
INSERT INTO `sys_value_record` VALUES ('50804331787583488', '1', 'SYS_DICT_INFO', '50802594620112896', '{\"SDI_CODE\":\"109\",\"IS_STATUS\":1,\"SDT_CODE\":\"SYS_PROCESS_TYPE\",\"SDI_REQUIRED\":0,\"SDI_INNERCODE\":\"1.109\",\"SDI_ORDER\":9,\"SDI_REMARK\":\"\",\"SDI_NAME\":\"学校奖学金\",\"ID\":\"50802594620112896\",\"SDI_PARENTID\":\"50802464470859776\",\"SDT_ID\":\"9\"}', '{\"SDI_CODE\":\"109\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"9\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"学校奖学金\",\"SDI_PARENTID\":\"50802464470859776\",\"SDI_INNERCODE\":\"100.109\",\"ID\":\"50802594620112896\",\"SDT_ID\":\"9\"}', '2018-08-12 20:52:06', 2);
INSERT INTO `sys_value_record` VALUES ('50804393678733312', '1', 'SYS_DICT_INFO', '50802464470859776', '{\"SDI_CODE\":\"100\",\"IS_STATUS\":1,\"SDT_CODE\":\"SYS_PROCESS_TYPE\",\"SDI_REQUIRED\":0,\"SDI_INNERCODE\":\"100\",\"SDI_ORDER\":100,\"SDI_REMARK\":\"\",\"SDI_NAME\":\"资助管理\",\"ID\":\"50802464470859776\",\"SDI_PARENTID\":\"0\",\"SDT_ID\":\"9\"}', '{\"SDI_CODE\":\"100\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"1\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"资助管理\",\"SDI_PARENTID\":\"0\",\"SDI_INNERCODE\":\"100\",\"ID\":\"50802464470859776\",\"SDT_ID\":\"9\"}', '2018-08-12 20:52:20', 2);
INSERT INTO `sys_value_record` VALUES ('50804417502380032', '1', 'SYS_DICT_INFO', '49301917020454912', NULL, NULL, '2018-08-12 20:52:26', 3);
INSERT INTO `sys_value_record` VALUES ('50804677360484352', '1', 'SYS_DICT_INFO', '50804677247238144', NULL, '{\"SDI_CODE\":\"110\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"10\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"年度表彰\",\"SDI_PARENTID\":\"50802464470859776\",\"IS_STATUS\":1,\"SDT_CODE\":\"SYS_PROCESS_TYPE\",\"SDI_INNERCODE\":\"100.110\",\"ID\":\"50804677247238144\",\"SDT_ID\":\"9\"}', '2018-08-12 20:53:28', 1);
INSERT INTO `sys_value_record` VALUES ('50825441602174976', '1', 'SYS_BUTTON', '50800567487823872', '{\"SB_CODE\":\"COPY\",\"SB_FUNC\":\"\",\"SB_CLASS\":\"btn btn-danger\",\"SB_ORDER\":9,\"SB_BUTTONID\":\"copy\",\"SB_ICON\":\"mdi mdi-content-copy\",\"ID\":\"50800567487823872\",\"SB_TYPE\":\"0\",\"SB_NAME\":\"拷贝\"}', '{\"SB_CODE\":\"COPY\",\"SB_CLASS\":\"btn btn-danger\",\"SB_ORDER\":\"9\",\"SB_BUTTONID\":\"copy\",\"SB_ICON\":\"mdi mdi-content-copy\",\"SB_TYPE\":\"1\",\"SB_FUNC\":\"\",\"ID\":\"50800567487823872\",\"SB_NAME\":\"拷贝\"}', '2018-08-12 22:15:58', 2);
INSERT INTO `sys_value_record` VALUES ('50825723417460736', '1', 'SYS_CONFIGURE_COLUMN', '2998399913689088', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"210px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"2998399913689088\",\"SC_ID\":\"2997414705233920\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":8}', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"1\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"80px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"2998399913689088\",\"SC_ID\":\"2997414705233920\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"8\"}', '2018-08-12 22:17:06', 2);
INSERT INTO `sys_value_record` VALUES ('50825932662898688', '1', 'SYS_CONFIGURE_COLUMN', '2998399913689088', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"1\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"80px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"2998399913689088\",\"SC_ID\":\"2997414705233920\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":8}', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"0\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"80px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"2998399913689088\",\"SC_ID\":\"2997414705233920\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"8\"}', '2018-08-12 22:17:56', 2);
INSERT INTO `sys_value_record` VALUES ('50825957480595456', '1', 'SYS_CONFIGURE_COLUMN', '2998399913689088', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"0\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"80px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"2998399913689088\",\"SC_ID\":\"2997414705233920\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":8}', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"0\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"250px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"2998399913689088\",\"SC_ID\":\"2997414705233920\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"8\"}', '2018-08-12 22:18:01', 2);
INSERT INTO `sys_value_record` VALUES ('50827207383187456', '1', 'SYS_MENU', '50827078936821760', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"admin/student/comprehensive/insertAndUpdate\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":1,\"SM_CODE\":\"AID:COLLEGE_SCHOLARSHIP_INSERT_AND_UPDATE\",\"SM_NAME\":\"学院奖学金\",\"SM_PARENTID\":\"50827078076989440\",\"ID\":\"50827078936821760\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"admin/student/comprehensive/insertAndUpdate\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_TYPE\":\"1\",\"SM_ORDER\":\"1\",\"SM_CODE\":\"AID:COLLEGE_SCHOLARSHIP_UPDATE\",\"SM_NAME\":\"编辑\",\"SM_PARENTID\":\"50827078076989440\",\"ID\":\"50827078936821760\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '2018-08-12 22:22:59', 2);
INSERT INTO `sys_value_record` VALUES ('50827511856103424', '1', 'SYS_MENU', '50827078076989440', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":30,\"SM_CODE\":\"AID:COLLEGE_SCHOLARSHIP\",\"SM_NAME\":\"学院奖学金\",\"SM_PARENTID\":\"50751117243449344\",\"ID\":\"50827078076989440\",\"SC_ID\":\"50338719827230720\",\"SM_CLASSICON\":\"mdi mdi-elevator\",\"SM_IS_EXPAND\":\"\"}', '{\"BUS_PROCESS\":\"100\",\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"109\",\"SM_IS_LEAF\":\"0\",\"SM_TYPE\":\"1\",\"SM_ORDER\":\"10\",\"SM_CODE\":\"AID:COLLEGE_SCHOLARSHIP\",\"SM_NAME\":\"学院奖学金\",\"SM_PARENTID\":\"50751117243449344\",\"ID\":\"50827078076989440\",\"SC_ID\":\"50338719827230720\",\"SM_CLASSICON\":\"mdi mdi-format-wrap-inline\",\"SM_IS_EXPAND\":\"\"}', '2018-08-12 22:24:12', 2);
INSERT INTO `sys_value_record` VALUES ('50827638264037376', '1', 'SYS_MENU', '50827078936821760', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"admin/student/comprehensive/insertAndUpdate\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":1,\"SM_CODE\":\"AID:COLLEGE_SCHOLARSHIP_UPDATE\",\"SM_NAME\":\"编辑\",\"SM_PARENTID\":\"50827078076989440\",\"ID\":\"50827078936821760\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"admin/aid/collegeScholarship/addAndEdit\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_TYPE\":\"1\",\"SM_ORDER\":\"1\",\"SM_CODE\":\"AID:COLLEGE_SCHOLARSHIP_UPDATE\",\"SM_NAME\":\"编辑\",\"SM_PARENTID\":\"50827078076989440\",\"ID\":\"50827078936821760\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '2018-08-12 22:24:42', 2);
INSERT INTO `sys_value_record` VALUES ('50827668064567296', '1', 'SYS_MENU', '50827078936821760', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"admin/aid/collegeScholarship/addAndEdit\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":1,\"SM_CODE\":\"AID:COLLEGE_SCHOLARSHIP_UPDATE\",\"SM_NAME\":\"编辑\",\"SM_PARENTID\":\"50827078076989440\",\"ID\":\"50827078936821760\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_TYPE\":\"1\",\"SM_ORDER\":\"1\",\"SM_CODE\":\"AID:COLLEGE_SCHOLARSHIP_UPDATE\",\"SM_NAME\":\"编辑\",\"SM_PARENTID\":\"50827078076989440\",\"ID\":\"50827078936821760\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"\",\"SM_IS_EXPAND\":\"\"}', '2018-08-12 22:24:49', 2);
INSERT INTO `sys_value_record` VALUES ('50828436414922752', '1', 'SYS_CONFIGURE_COLUMN', '26725940633534464', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"26725940633534464\",\"SC_ID\":\"26721805670547456\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":80}', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"150px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"26725940633534464\",\"SC_ID\":\"26721805670547456\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"80\"}', '2018-08-12 22:27:53', 2);
INSERT INTO `sys_value_record` VALUES ('50831880437628928', '1', 'SYS_CONFIGURE', '50831880232108032', NULL, '{\"SC_IS_PAGING\":\"1\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE\",\"SC_NAME\":\"资助管理-学院奖学金\",\"SC_JSP\":\"1\",\"SC_VIEW\":\"v_college_scholarship\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"50831880232108032\",\"SC_ORDER_BY\":\"\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '2018-08-12 22:41:34', 1);
INSERT INTO `sys_value_record` VALUES ('50831959902912512', '1', 'SYS_CONFIGURE', '50831880232108032', '{\"SC_IS_PAGING\":\"1\",\"SC_NAME\":\"资助管理-学院奖学金\",\"SC_JSP\":\"1\",\"SC_VIEW\":\"v_college_scholarship\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"50831880232108032\",\"SC_ORDER_BY\":\"\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '{\"SC_NAME\":\"资助管理-学院奖学金\",\"SC_JSP\":\"admin/aid/collegeScholarship/home\",\"SC_VIEW\":\"v_college_scholarship\",\"SC_ORDER_BY\":\"\",\"SC_IS_PAGING\":\"1\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"50831880232108032\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '2018-08-12 22:41:53', 2);
INSERT INTO `sys_value_record` VALUES ('50832115763249152', '1', 'SYS_CONFIGURE', '50831880232108032', '{\"SC_IS_PAGING\":\"1\",\"SC_NAME\":\"资助管理-学院奖学金\",\"SC_JSP\":\"admin/aid/collegeScholarship/home\",\"SC_VIEW\":\"v_college_scholarship\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"50831880232108032\",\"SC_ORDER_BY\":\"\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '{\"SC_NAME\":\"资助管理-学院奖学金\",\"SC_JSP\":\"admin/aid/collegeScholarship/home\",\"SC_VIEW\":\"v_college_scholarship\",\"SC_ORDER_BY\":\"BAF_YEAR DESC,BAF_SEMESTER DESC,\",\"SC_IS_PAGING\":\"1\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"50831880232108032\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '2018-08-12 22:42:30', 2);
INSERT INTO `sys_value_record` VALUES ('50832153398738944', '1', 'SYS_CONFIGURE', '50831880232108032', '{\"SC_IS_PAGING\":\"1\",\"SC_NAME\":\"资助管理-学院奖学金\",\"SC_JSP\":\"admin/aid/collegeScholarship/home\",\"SC_VIEW\":\"v_college_scholarship\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"50831880232108032\",\"SC_ORDER_BY\":\"BAF_YEAR DESC,BAF_SEMESTER DESC,\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '{\"SC_NAME\":\"资助管理-学院奖学金\",\"SC_JSP\":\"admin/aid/collegeScholarship/home\",\"SC_VIEW\":\"v_college_scholarship\",\"SC_ORDER_BY\":\"BAF_YEAR DESC,BAF_SEMESTER DESC,CONVERT(ID,SIGNED) DESC\",\"SC_IS_PAGING\":\"1\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"50831880232108032\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '2018-08-12 22:42:39', 2);
INSERT INTO `sys_value_record` VALUES ('50833257612181504', '1', 'SYS_CONFIGURE_COLUMN', '50833257528295424', NULL, '{\"SCC_NAME\":\"学生\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"BS_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50833257528295424\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"1\"}', '2018-08-12 22:47:02', 1);
INSERT INTO `sys_value_record` VALUES ('50833440232177664', '1', 'SYS_CONFIGURE_COLUMN', '50833440131514368', NULL, '{\"SCC_NAME\":\"学号\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"BS_NUMBER\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50833440131514368\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"20\"}', '2018-08-12 22:47:46', 1);
INSERT INTO `sys_value_record` VALUES ('50833512923660288', '1', 'SYS_CONFIGURE_COLUMN', '50833512873328640', NULL, '{\"SCC_NAME\":\"班级\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"170px\",\"SCC_FIELD\":\"BC_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50833512873328640\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"30\"}', '2018-08-12 22:48:03', 1);
INSERT INTO `sys_value_record` VALUES ('50833638530482176', '1', 'SYS_CONFIGURE_COLUMN', '50833638492733440', NULL, '{\"SCC_NAME\":\"综合素质测评\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"BSC_TOTAL\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50833638492733440\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"40\"}', '2018-08-12 22:48:33', 1);
INSERT INTO `sys_value_record` VALUES ('50833705844867072', '1', 'SYS_CONFIGURE_COLUMN', '50833705790341120', NULL, '{\"SCC_NAME\":\"综合素质测评排名\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"120px\",\"SCC_FIELD\":\"BSC_RANK\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50833705790341120\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"50\"}', '2018-08-12 22:48:49', 1);
INSERT INTO `sys_value_record` VALUES ('50833777907204096', '1', 'SYS_CONFIGURE_COLUMN', '50833777835900928', NULL, '{\"SCC_NAME\":\"学习成绩\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"BSC_ACADEMIC_RECORD\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50833777835900928\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"60\"}', '2018-08-12 22:49:06', 1);
INSERT INTO `sys_value_record` VALUES ('50833829287428096', '1', 'SYS_CONFIGURE_COLUMN', '50833829203542016', NULL, '{\"SCC_NAME\":\"学习成绩排名\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"BSC_INTELLECTUAL_RANK\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50833829203542016\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"70\"}', '2018-08-12 22:49:18', 1);
INSERT INTO `sys_value_record` VALUES ('50833943808704512', '1', 'SYS_CONFIGURE_COLUMN', '50833943762567168', NULL, '{\"SCC_NAME\":\"操作\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"250px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"50833943762567168\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"80\"}', '2018-08-12 22:49:46', 1);
INSERT INTO `sys_value_record` VALUES ('50833989207851008', '1', 'SYS_MENU', '50827078076989440', '{\"BUS_PROCESS\":\"100\",\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"109\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":10,\"SM_CODE\":\"AID:COLLEGE_SCHOLARSHIP\",\"SM_NAME\":\"学院奖学金\",\"SM_PARENTID\":\"50751117243449344\",\"ID\":\"50827078076989440\",\"SC_ID\":\"50338719827230720\",\"SM_CLASSICON\":\"mdi mdi-format-wrap-inline\",\"SM_IS_EXPAND\":\"\"}', '{\"BUS_PROCESS\":\"100\",\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"109\",\"SM_IS_LEAF\":\"0\",\"SM_TYPE\":\"1\",\"SM_ORDER\":\"10\",\"SM_CODE\":\"AID:COLLEGE_SCHOLARSHIP\",\"SM_NAME\":\"学院奖学金\",\"SM_PARENTID\":\"50751117243449344\",\"ID\":\"50827078076989440\",\"SC_ID\":\"50831880232108032\",\"SM_CLASSICON\":\"mdi mdi-format-wrap-inline\",\"SM_IS_EXPAND\":\"\"}', '2018-08-12 22:49:56', 2);
INSERT INTO `sys_value_record` VALUES ('50836827841495040', '1', 'SYS_ROLE', '50836827770191872', NULL, '{\"SR_CODE\":\"COLLEGE_SCHOLARSHIP\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"SYS_ROLE\",\"SR_EXPLAIN\":\"学校奖学金管理\",\"SR_NAME\":\"学校奖学金管理\",\"ID\":\"50836827770191872\",\"SR_REMARK\":\"\",\"SR_TYPE\":\"3\"}', '2018-08-12 23:01:13', 1);
INSERT INTO `sys_value_record` VALUES ('50838310813171712', '1', 'SYS_PROCESS_DEFINITION', '50838310695731200', NULL, '{\"BUS_PROCESS\":\"100\",\"SVR_TABLE_NAME\":\"SYS_PROCESS_DEFINITION\",\"SR_ID\":\"48307839919194112\",\"SPD_DIVISION_FIELD\":\"\",\"SO_ID\":\"1\",\"SPD_DESCRIBE\":\"\",\"BUS_PROCESS2\":\"109\",\"IS_STATUS\":1,\"SPD_DEPARTMENT_FIELD\":\"BDM_ID\",\"SPD_UPDATE_TABLE\":\"v_college_scholarship\",\"IS_MULTISTAGE_BACK\":\"1\",\"SPD_VERSION\":\"1.0\",\"SDP_ENTRY_TIME\":\"2018-08-12 23:07:07\",\"ID\":\"50838310695731200\",\"SPD_UPDATE_NAME\":\"BS_NAME\",\"SPD_NAME\":\"学院奖学金\"}', '2018-08-12 23:07:07', 1);
INSERT INTO `sys_value_record` VALUES ('50838365888577536', '1', 'SYS_PROCESS_DEFINITION', '50838310695731200', '{\"BUS_PROCESS\":\"100\",\"SR_ID\":\"48307839919194112\",\"SPD_DIVISION_FIELD\":\"\",\"SO_ID\":\"1\",\"SPD_DESCRIBE\":\"\",\"BUS_PROCESS2\":\"109\",\"IS_STATUS\":1,\"SPD_DEPARTMENT_FIELD\":\"BDM_ID\",\"SPD_UPDATE_TABLE\":\"v_college_scholarship\",\"IS_MULTISTAGE_BACK\":1,\"SPD_VERSION\":\"1.0\",\"SDP_ENTRY_TIME\":\"2018-08-12 23:07:07\",\"ID\":\"50838310695731200\",\"SPD_UPDATE_NAME\":\"BS_NAME\",\"SPD_NAME\":\"学院奖学金\"}', '{\"BUS_PROCESS\":\"100\",\"SR_ID\":\"48307839919194112\",\"SPD_DIVISION_FIELD\":\"\",\"SPD_DESCRIBE\":\"\",\"BUS_PROCESS2\":\"109\",\"SPD_DEPARTMENT_FIELD\":\"BDM_ID\",\"SPD_UPDATE_TABLE\":\"V_COLLEGE_SCHOLARSHIP\",\"IS_MULTISTAGE_BACK\":\"1\",\"SPD_VERSION\":\"1.0\",\"ID\":\"50838310695731200\",\"SPD_UPDATE_NAME\":\"BS_NAME\",\"SPD_NAME\":\"学院奖学金\"}', '2018-08-12 23:07:20', 2);
INSERT INTO `sys_value_record` VALUES ('50839172625203200', '1', 'SYS_DICT_INFO', '50839172386127872', NULL, '{\"SDI_CODE\":\"5\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"5\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"学院奖学金\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"SYS_PROCESS_STATUS\",\"SDI_INNERCODE\":\"5\",\"ID\":\"50839172386127872\",\"SDT_ID\":\"27191919998140416\"}', '2018-08-12 23:10:32', 1);
INSERT INTO `sys_value_record` VALUES ('50839345413750784', '1', 'SYS_DICT_INFO', '50839345229201408', NULL, '{\"SDI_CODE\":\"99\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"99\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"学生处\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"SYS_PROCESS_STATUS\",\"SDI_INNERCODE\":\"99\",\"ID\":\"50839345229201408\",\"SDT_ID\":\"27191919998140416\"}', '2018-08-12 23:11:13', 1);
INSERT INTO `sys_value_record` VALUES ('50839590004588544', '1', 'SYS_PROCESS_STEP', '50839589836816384', NULL, '{\"SPS_NAME\":\"启动人员\",\"SVR_TABLE_NAME\":\"SYS_PROCESS_STEP\",\"SR_ID\":\"50836827770191872\",\"SPS_STEP_TYPE\":\"1\",\"SPS_OVER_TIME\":\"\",\"SPS_ORDER\":\"1\",\"SPS_TAB\":\"\",\"SPS_PROCESS_STATUS\":\"5\",\"SPS_IS_ADVANCE_CHECK\":\"1\",\"SPS_IS_ADVANCE_EXECUTE\":\"0\",\"SPD_ID\":\"50838310695731200\",\"ID\":\"50839589836816384\",\"SPS_IS_RETREAT_CHECK\":\"0\",\"NOT_ID\":\"\",\"SPS_IS_RETREAT_EXECUTE\":\"0\",\"SPS_IS_OVER_TIME\":\"0\"}', '2018-08-12 23:12:12', 1);
INSERT INTO `sys_value_record` VALUES ('50839707369603072', '1', 'SYS_PROCESS_STEP', '50839707340242944', NULL, '{\"SPS_NAME\":\"学生处\",\"SVR_TABLE_NAME\":\"SYS_PROCESS_STEP\",\"SR_ID\":\"48307839919194112\",\"SPS_STEP_TYPE\":\"1\",\"SPS_OVER_TIME\":\"\",\"SPS_ORDER\":\"2\",\"SPS_TAB\":\"\",\"SPS_PROCESS_STATUS\":\"99\",\"SPS_IS_ADVANCE_CHECK\":\"1\",\"SPS_IS_ADVANCE_EXECUTE\":\"0\",\"SPD_ID\":\"50838310695731200\",\"ID\":\"50839707340242944\",\"SPS_IS_RETREAT_CHECK\":\"0\",\"NOT_ID\":\"\",\"SPS_IS_RETREAT_EXECUTE\":\"0\",\"SPS_IS_OVER_TIME\":\"0\"}', '2018-08-12 23:12:40', 1);
INSERT INTO `sys_value_record` VALUES ('50840190201102336', '1', 'SYS_PROCESS_STEP', '50840190146576384', NULL, '{\"SPS_NAME\":\"完成\",\"SVR_TABLE_NAME\":\"SYS_PROCESS_STEP\",\"SR_ID\":\"\",\"SPS_STEP_TYPE\":\"1\",\"SPS_OVER_TIME\":\"\",\"SPS_ORDER\":\"3\",\"SPS_TAB\":\"\",\"SPS_PROCESS_STATUS\":\"999\",\"SPS_IS_ADVANCE_CHECK\":\"0\",\"SPS_IS_ADVANCE_EXECUTE\":\"0\",\"SPD_ID\":\"50838310695731200\",\"ID\":\"50840190146576384\",\"SPS_IS_RETREAT_CHECK\":\"0\",\"NOT_ID\":\"\",\"SPS_IS_RETREAT_EXECUTE\":\"0\",\"SPS_IS_OVER_TIME\":\"0\"}', '2018-08-12 23:14:35', 1);
INSERT INTO `sys_value_record` VALUES ('50840285676044288', '1', 'SYS_PROCESS_STEP', '50839589836816384', '{\"SPS_NAME\":\"启动人员\",\"SR_ID\":\"50836827770191872\",\"SPS_STEP_TYPE\":1,\"SPS_OVER_TIME\":\"\",\"SPS_ORDER\":1,\"SPS_TAB\":\"\",\"SPS_PROCESS_STATUS\":5,\"SPS_IS_ADVANCE_CHECK\":1,\"SPS_IS_ADVANCE_EXECUTE\":0,\"SPD_ID\":\"50838310695731200\",\"ID\":\"50839589836816384\",\"SPS_IS_RETREAT_CHECK\":0,\"SPS_IS_RETREAT_EXECUTE\":0,\"SPS_IS_OVER_TIME\":0}', '{\"SPS_NAME\":\"启动人员\",\"SR_ID\":\"50836827770191872\",\"SPS_STEP_TYPE\":\"1\",\"SPS_OVER_TIME\":\"\",\"SPS_ORDER\":\"1\",\"SPS_TAB\":\"系部人员\",\"SPS_PROCESS_STATUS\":\"5\",\"SPS_IS_ADVANCE_CHECK\":\"1\",\"SPS_IS_ADVANCE_EXECUTE\":\"0\",\"SPD_ID\":\"50838310695731200\",\"ID\":\"50839589836816384\",\"SPS_IS_RETREAT_CHECK\":\"0\",\"SPS_IS_RETREAT_EXECUTE\":\"0\",\"SPS_IS_OVER_TIME\":\"0\"}', '2018-08-12 23:14:58', 2);
INSERT INTO `sys_value_record` VALUES ('50840305515102208', '1', 'SYS_PROCESS_STEP', '50839707340242944', '{\"SPS_NAME\":\"学生处\",\"SR_ID\":\"48307839919194112\",\"SPS_STEP_TYPE\":1,\"SPS_OVER_TIME\":\"\",\"SPS_ORDER\":2,\"SPS_TAB\":\"\",\"SPS_PROCESS_STATUS\":99,\"SPS_IS_ADVANCE_CHECK\":1,\"SPS_IS_ADVANCE_EXECUTE\":0,\"SPD_ID\":\"50838310695731200\",\"ID\":\"50839707340242944\",\"SPS_IS_RETREAT_CHECK\":0,\"SPS_IS_RETREAT_EXECUTE\":0,\"SPS_IS_OVER_TIME\":0}', '{\"SPS_NAME\":\"学生处\",\"SR_ID\":\"48307839919194112\",\"SPS_STEP_TYPE\":\"1\",\"SPS_OVER_TIME\":\"\",\"SPS_ORDER\":\"2\",\"SPS_TAB\":\"学生处\",\"SPS_PROCESS_STATUS\":\"99\",\"SPS_IS_ADVANCE_CHECK\":\"1\",\"SPS_IS_ADVANCE_EXECUTE\":\"0\",\"SPD_ID\":\"50838310695731200\",\"ID\":\"50839707340242944\",\"SPS_IS_RETREAT_CHECK\":\"0\",\"SPS_IS_RETREAT_EXECUTE\":\"0\",\"SPS_IS_OVER_TIME\":\"0\"}', '2018-08-12 23:15:02', 2);
INSERT INTO `sys_value_record` VALUES ('50842353715380224', '1', 'SYS_VALIDATE', '50842353690214400', NULL, '{\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"SYS_VALIDATE\",\"ID\":\"50842353690214400\",\"SV_TABLE\":\"BUS_AID_FINANCIALLY\"}', '2018-08-12 23:23:11', 1);
INSERT INTO `sys_value_record` VALUES ('50842413505183744', '1', 'sys_validate_field', '50842413324828672', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50842413324828672\",\"SVF_NAME\":\"学生\",\"SVF_FIELD\":\"BS_ID\",\"SV_ID\":\"50842353690214400\",\"SVR_ID\":\"\"}', '2018-08-12 23:23:25', 1);
INSERT INTO `sys_value_record` VALUES ('50842455620190208', '1', 'sys_validate_field', '50842455565664256', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50842455565664256\",\"SVF_NAME\":\"学年\",\"SVF_FIELD\":\"BAF_YEAR\",\"SV_ID\":\"50842353690214400\",\"SVR_ID\":\"26504926733533184\"}', '2018-08-12 23:23:35', 1);
INSERT INTO `sys_value_record` VALUES ('50842480022650880', '1', 'sys_validate_field', '50842479963930624', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50842479963930624\",\"SVF_NAME\":\"学期\",\"SVF_FIELD\":\"BAF_SEMESTER\",\"SV_ID\":\"50842353690214400\",\"SVR_ID\":\"\"}', '2018-08-12 23:23:41', 1);
INSERT INTO `sys_value_record` VALUES ('50842924266553344', '1', 'sys_validate_field', '50842924153307136', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50842924153307136\",\"SVF_NAME\":\"类型\",\"SVF_FIELD\":\"BAF_TYPE\",\"SV_ID\":\"50842353690214400\",\"SVR_ID\":\"\"}', '2018-08-12 23:25:27', 1);
INSERT INTO `sys_value_record` VALUES ('50842975361564672', '1', 'sys_validate_field', '50842975307038720', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50842975307038720\",\"SVF_NAME\":\"奖励类型\",\"SVF_FIELD\":\"BAF_AID_TYPE\",\"SV_ID\":\"50842353690214400\",\"SVR_ID\":\"\"}', '2018-08-12 23:25:39', 1);
INSERT INTO `sys_value_record` VALUES ('50843025986813952', '1', 'sys_validate_field', '50843025634492416', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50843025634492416\",\"SVF_NAME\":\"减免等级\",\"SVF_FIELD\":\"BAF_REDUCTION_LEVEL\",\"SV_ID\":\"50842353690214400\",\"SVR_ID\":\"\"}', '2018-08-12 23:25:51', 1);
INSERT INTO `sys_value_record` VALUES ('50843059553828864', '1', 'sys_validate_field', '50843059478331392', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50843059478331392\",\"SVF_NAME\":\"减免额度\",\"SVF_FIELD\":\"BAF_REDUCTION_QUOTA\",\"SV_ID\":\"50842353690214400\",\"SVR_ID\":\"\"}', '2018-08-12 23:25:59', 1);
INSERT INTO `sys_value_record` VALUES ('50843107771547648', '1', 'sys_validate_field', '50843107717021696', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50843107717021696\",\"SVF_NAME\":\"困难级别\",\"SVF_FIELD\":\"BAF_DIFFICULTY_LEVEL\",\"SV_ID\":\"50842353690214400\",\"SVR_ID\":\"\"}', '2018-08-12 23:26:10', 1);
INSERT INTO `sys_value_record` VALUES ('50843147047010304', '1', 'sys_validate_field', '50843146975707136', NULL, '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"sys_validate_field\",\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50843146975707136\",\"SVF_NAME\":\"困难类型\",\"SVF_FIELD\":\"BAF_DIFFICULTY_TYPE\",\"SV_ID\":\"50842353690214400\",\"SVR_ID\":\"\"}', '2018-08-12 23:26:20', 1);
INSERT INTO `sys_value_record` VALUES ('50843184393093120', '1', 'sys_validate_field', '50843059478331392', '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"\",\"IS_STATUS\":1,\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50843059478331392\",\"SVF_NAME\":\"减免额度\",\"SVF_FIELD\":\"BAF_REDUCTION_QUOTA\",\"SV_ID\":\"50842353690214400\",\"SVR_ID\":\"\"}', '{\"SVF_MIN_LENGTH\":\"\",\"SVF_NAME\":\"减免额度\",\"SV_ID\":\"50842353690214400\",\"SVR_ID\":\"2511687219412992\",\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"\",\"ID\":\"50843059478331392\",\"SVF_FIELD\":\"BAF_REDUCTION_QUOTA\"}', '2018-08-12 23:26:29', 2);
INSERT INTO `sys_value_record` VALUES ('50843222687088640', '1', 'sys_validate_field', '50843059478331392', '{\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"\",\"IS_STATUS\":1,\"SVF_MIN_LENGTH\":\"\",\"ID\":\"50843059478331392\",\"SVF_NAME\":\"减免额度\",\"SVF_FIELD\":\"BAF_REDUCTION_QUOTA\",\"SV_ID\":\"50842353690214400\",\"SVR_ID\":\"2511687219412992\"}', '{\"SVF_MIN_LENGTH\":\"\",\"SVF_NAME\":\"减免额度\",\"SV_ID\":\"50842353690214400\",\"SVR_ID\":\"2521757806231552\",\"SVF_IS_REQUIRED\":\"1\",\"SVF_MAX_LENGTH\":\"\",\"ID\":\"50843059478331392\",\"SVF_FIELD\":\"BAF_REDUCTION_QUOTA\"}', '2018-08-12 23:26:38', 2);
INSERT INTO `sys_value_record` VALUES ('50844794506706944', '48601651874889729', 'BUS_AID_FINANCIALLY', '50844794401849344', NULL, '{\"BS_ID\":\"48944951878221824\",\"BUS_PROCESS\":100,\"BAF_AID_TYPE\":\"FIRST-CLASS\",\"SVR_TABLE_NAME\":\"BUS_AID_FINANCIALLY\",\"SO_ID\":\"48601651874889729\",\"BAF_TYPE\":9,\"BAF_YEAR\":\"2017~2018\",\"BUS_PROCESS2\":109,\"BAF_SEMESTER\":\"2\",\"ID\":\"50844794401849344\",\"BAF_ENTRY_TIME\":\"2018-08-12 23:32:53\"}', '2018-08-12 23:32:53', 1);
INSERT INTO `sys_value_record` VALUES ('50845186275672064', '1', 'BUS_STUDENT_COMPREHENSIVE', '50372217258639360', '{\"BS_ID\":\"48944951878221824\",\"BSC_INTELLECTUAL_PROPORTION\":60,\"BSC_VOLUNTEER_TOTAL\":86,\"BSC_INTELLECTUAL_SCORE\":49.80,\"BSC_INTELLECTUAL_POINTS\":0,\"BSC_DECORUM\":12,\"BSC_SERVICE_SPIRIT\":10,\"BSC_EDUCATION_TOTAL\":64,\"ID\":\"50372217258639360\",\"BSC_COLLECTIVE\":10,\"BSC_VOLUNTEER_PROPORTION\":10,\"BSC_YEAR\":\"2018~2019\",\"BSC_EDUCATION_DEDUCTION\":0,\"BSC_ACADEMIC_RECORD\":83,\"BSC_BONUS_POINTS\":0,\"BSC_LABOR_ATTITUDE\":14,\"BSC_POLITICAL_ATTITUDE\":3,\"BSC_COMPLIANCE\":1,\"BSC_EDUCATION_SCORE\":19.20,\"BSC_FULL_WORK\":0,\"BSC_SEMESTER\":1,\"BSC_PERSONAL_QUALITY\":4,\"BSC_EDUCATION_PROPORTION\":30,\"BSC_TOTAL\":77.59,\"BSC_CARE\":10,\"BSC_VOLUNTEER_SCORE\":8.60}', '{\"BS_ID\":\"48944951878221824\",\"BSC_INTELLECTUAL_PROPORTION\":\"60\",\"BSC_VOLUNTEER_TOTAL\":\"86\",\"BSC_INTELLECTUAL_SCORE\":\"49.80\",\"BSC_INTELLECTUAL_POINTS\":\"0\",\"BSC_DECORUM\":\"12\",\"BSC_SERVICE_SPIRIT\":\"10\",\"BSC_EDUCATION_TOTAL\":\"64\",\"ID\":\"50372217258639360\",\"BSC_COLLECTIVE\":\"10\",\"BSC_VOLUNTEER_PROPORTION\":\"10\",\"BSC_YEAR\":\"2017~2018\",\"BSC_EDUCATION_DEDUCTION\":\"0\",\"BSC_ACADEMIC_RECORD\":\"83\",\"BSC_BONUS_POINTS\":\"0\",\"BSC_LABOR_ATTITUDE\":\"14\",\"BSC_POLITICAL_ATTITUDE\":\"3\",\"BSC_COMPLIANCE\":\"1\",\"BSC_EDUCATION_SCORE\":\"19.20\",\"BSC_FULL_WORK\":\"0\",\"BSC_SEMESTER\":\"2\",\"BSC_PERSONAL_QUALITY\":\"4\",\"BSC_EDUCATION_PROPORTION\":\"30\",\"BSC_TOTAL\":\"77.59\",\"BSC_CARE\":\"10\",\"BSC_VOLUNTEER_SCORE\":\"8.60\"}', '2018-08-12 23:34:26', 2);
INSERT INTO `sys_value_record` VALUES ('50846995220267008', '48601651874889729', 'SYS_PROCESS_SCHEDULE', '50846995119603712', NULL, '{\"SVR_TABLE_NAME\":\"SYS_PROCESS_SCHEDULE\",\"SPS_PREV_STEP_ID\":\"50839589836816384\",\"SPS_STEP_TRANSACTOR\":\"48307839919194112\",\"SPS_BACK_STATUS\":\"0\",\"SO_ID\":\"48601651874889729\",\"SPS_STEP_TYPE\":\"1\",\"SPS_BACK_STATUS_TRANSACTOR\":\"-1\",\"SPS_TABLE_NAME\":\"student_test\",\"SPS_PREV_STEP_TRANSACTOR\":\"48601651874889729\",\"SPS_ID\":\"50839707340242944\",\"SPS_PREV_STEP_TYPE\":\"0\",\"SPS_AUDIT_STATUS\":\"99\",\"SPS_PREV_AUDIT_STATUS\":\"0\",\"SPS_TABLE_ID\":\"50844794401849344\",\"SPD_ID\":\"50838310695731200\",\"ID\":\"50846995119603712\"}', '2018-08-12 23:41:37', 1);
INSERT INTO `sys_value_record` VALUES ('50847196169371648', '1', 'SYS_CONFIGURE_COLUMN', '50847196098068480', NULL, '{\"SCC_NAME\":\"审核状态\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"processLogFunc(targets, field);\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"PROCESS_STATUS_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50847196098068480\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"75\"}', '2018-08-12 23:42:25', 1);
INSERT INTO `sys_value_record` VALUES ('50850696181841920', '1', 'SYS_CONFIGURE_COLUMN', '50833705790341120', '{\"SCC_NAME\":\"综合素质测评排名\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"120px\",\"SCC_FIELD\":\"BSC_RANK\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50833705790341120\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":50}', '{\"SCC_NAME\":\"综合素质测评排名\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"70px\",\"SCC_FIELD\":\"BSC_RANK\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50833705790341120\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"50\"}', '2018-08-12 23:56:20', 2);
INSERT INTO `sys_value_record` VALUES ('50850714745831424', '1', 'SYS_CONFIGURE_COLUMN', '50833638492733440', '{\"SCC_NAME\":\"综合素质测评\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"BSC_TOTAL\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50833638492733440\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":40}', '{\"SCC_NAME\":\"综合素质测评\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"70px\",\"SCC_FIELD\":\"BSC_TOTAL\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50833638492733440\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"40\"}', '2018-08-12 23:56:24', 2);
INSERT INTO `sys_value_record` VALUES ('50850748082159616', '1', 'SYS_CONFIGURE_COLUMN', '50833777835900928', '{\"SCC_NAME\":\"学习成绩\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"BSC_ACADEMIC_RECORD\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50833777835900928\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":60}', '{\"SCC_NAME\":\"学习成绩\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"70px\",\"SCC_FIELD\":\"BSC_ACADEMIC_RECORD\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50833777835900928\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"60\"}', '2018-08-12 23:56:32', 2);
INSERT INTO `sys_value_record` VALUES ('50850765446578176', '1', 'SYS_CONFIGURE_COLUMN', '50833829203542016', '{\"SCC_NAME\":\"学习成绩排名\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"BSC_INTELLECTUAL_RANK\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50833829203542016\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":70}', '{\"SCC_NAME\":\"学习成绩排名\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"70px\",\"SCC_FIELD\":\"BSC_INTELLECTUAL_RANK\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50833829203542016\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"70\"}', '2018-08-12 23:56:36', 2);
INSERT INTO `sys_value_record` VALUES ('50850818902982656', '1', 'SYS_CONFIGURE_COLUMN', '50833829203542016', '{\"SCC_NAME\":\"学习成绩排名\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"70px\",\"SCC_FIELD\":\"BSC_INTELLECTUAL_RANK\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50833829203542016\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":70}', '{\"SCC_NAME\":\"学习排名\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"70px\",\"SCC_FIELD\":\"BSC_INTELLECTUAL_RANK\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50833829203542016\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"70\"}', '2018-08-12 23:56:49', 2);
INSERT INTO `sys_value_record` VALUES ('50850839668981760', '1', 'SYS_CONFIGURE_COLUMN', '50833705790341120', '{\"SCC_NAME\":\"综合素质测评排名\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"70px\",\"SCC_FIELD\":\"BSC_RANK\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50833705790341120\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":50}', '{\"SCC_NAME\":\"测评排名\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"70px\",\"SCC_FIELD\":\"BSC_RANK\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50833705790341120\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"50\"}', '2018-08-12 23:56:54', 2);
INSERT INTO `sys_value_record` VALUES ('50850893146357760', '1', 'SYS_CONFIGURE_COLUMN', '50833638492733440', '{\"SCC_NAME\":\"综合素质测评\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"70px\",\"SCC_FIELD\":\"BSC_TOTAL\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50833638492733440\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":40}', '{\"SCC_NAME\":\"综合素质测评\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"80px\",\"SCC_FIELD\":\"BSC_TOTAL\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50833638492733440\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"40\"}', '2018-08-12 23:57:07', 2);
INSERT INTO `sys_value_record` VALUES ('50850920535162880', '1', 'SYS_CONFIGURE_COLUMN', '50833638492733440', '{\"SCC_NAME\":\"综合素质测评\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"80px\",\"SCC_FIELD\":\"BSC_TOTAL\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50833638492733440\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":40}', '{\"SCC_NAME\":\"综合素质测评\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"90px\",\"SCC_FIELD\":\"BSC_TOTAL\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50833638492733440\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"40\"}', '2018-08-12 23:57:13', 2);
INSERT INTO `sys_value_record` VALUES ('50850967758831616', '1', 'SYS_CONFIGURE_COLUMN', '50833638492733440', '{\"SCC_NAME\":\"综合素质测评\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"90px\",\"SCC_FIELD\":\"BSC_TOTAL\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50833638492733440\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":40}', '{\"SCC_NAME\":\"综合测评\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"70px\",\"SCC_FIELD\":\"BSC_TOTAL\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50833638492733440\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"40\"}', '2018-08-12 23:57:24', 2);
INSERT INTO `sys_value_record` VALUES ('50851396559306752', '1', 'BUS_DIVISION_PERSONNEL', '48303136200196096', '{\"BDP_NAME\":\"devision_test\",\"SO_ID\":\"48303136200196097\",\"BD_ID\":\"48308661151334400\",\"ID\":\"48303136200196096\"}', '{\"BDP_NAME\":\"division_test\",\"BD_ID\":\"48308661151334400\",\"ID\":\"48303136200196096\"}', '2018-08-12 23:59:07', 2);
INSERT INTO `sys_value_record` VALUES ('50851408580182016', '1', 'SYS_OPERATOR', '48303136200196097', '{\"IS_STATUS\":1,\"ID\":\"48303136200196097\"}', '{\"ID\":\"48303136200196097\"}', '2018-08-12 23:59:09', 2);
INSERT INTO `sys_value_record` VALUES ('50852142109425664', '1', 'SYS_MENU', '50827078076989440', '{\"BUS_PROCESS\":\"100\",\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"109\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":10,\"SM_CODE\":\"AID:COLLEGE_SCHOLARSHIP\",\"SM_NAME\":\"学院奖学金\",\"SM_PARENTID\":\"50751117243449344\",\"ID\":\"50827078076989440\",\"SC_ID\":\"50831880232108032\",\"SM_CLASSICON\":\"mdi mdi-format-wrap-inline\",\"SM_IS_EXPAND\":\"\"}', '{\"BUS_PROCESS\":\"100\",\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"109\",\"SM_IS_LEAF\":\"0\",\"SM_TYPE\":\"1\",\"SM_ORDER\":\"10\",\"SM_CODE\":\"AID:COLLEGE_SCHOLARSHIP\",\"SM_NAME\":\"学院奖学金\",\"SM_PARENTID\":\"50751117243449344\",\"ID\":\"50827078076989440\",\"SC_ID\":\"50831880232108032\",\"SM_CLASSICON\":\"mdi mdi-format-wrap-inline\",\"SM_IS_EXPAND\":\"\"}', '2018-08-13 00:02:04', 2);
INSERT INTO `sys_value_record` VALUES ('50852327950647296', '48303136200196097', 'SYS_PROCESS_SCHEDULE', '50846995119603712', '{\"SPS_PREV_STEP_ID\":\"50839589836816384\",\"SPS_STEP_TRANSACTOR\":\"48307839919194112\",\"SPS_BACK_STATUS\":0,\"SO_ID\":\"48601651874889729\",\"SPS_STEP_TYPE\":1,\"SPS_TABLE_NAME\":\"student_test\",\"SPS_BACK_STATUS_TRANSACTOR\":-1,\"SPS_PREV_STEP_TRANSACTOR\":\"48601651874889729\",\"SPS_ID\":\"50839707340242944\",\"SPS_PREV_STEP_TYPE\":0,\"SPS_AUDIT_STATUS\":99,\"SPS_PREV_AUDIT_STATUS\":0,\"SPS_TABLE_ID\":\"50844794401849344\",\"SPD_ID\":\"50838310695731200\",\"ID\":\"50846995119603712\"}', '{\"SPS_PREV_STEP_ID\":\"50839707340242944\",\"SPS_STEP_TRANSACTOR\":\"48601651874889729\",\"SPS_BACK_STATUS\":\"1\",\"SO_ID\":\"48601651874889729\",\"SPS_STEP_TYPE\":\"2\",\"SPS_TABLE_NAME\":\"student_test\",\"SPS_BACK_STATUS_TRANSACTOR\":\"5\",\"SPS_PREV_STEP_TRANSACTOR\":\"48303136200196097\",\"SPS_ID\":\"50839589836816384\",\"SPS_PREV_STEP_TYPE\":\"1\",\"SPS_AUDIT_STATUS\":\"-1\",\"SPS_PREV_AUDIT_STATUS\":99,\"SPS_TABLE_ID\":\"50844794401849344\",\"SPD_ID\":\"50838310695731200\",\"ID\":\"50846995119603712\"}', '2018-08-13 00:02:49', 2);
INSERT INTO `sys_value_record` VALUES ('50854681391398912', '48601651874889729', 'SYS_PROCESS_SCHEDULE', '50854681315901440', NULL, '{\"SVR_TABLE_NAME\":\"SYS_PROCESS_SCHEDULE\",\"SPS_PREV_STEP_ID\":\"50839589836816384\",\"SPS_STEP_TRANSACTOR\":\"48307839919194112\",\"SPS_BACK_STATUS\":\"0\",\"SPS_STEP_TYPE\":\"1\",\"SO_ID\":\"48601651874889729\",\"SPS_BACK_STATUS_TRANSACTOR\":\"-1\",\"SPS_TABLE_NAME\":\"student_test\",\"SPS_PREV_STEP_TRANSACTOR\":\"48601651874889729\",\"SPS_ID\":\"50839707340242944\",\"SPS_PREV_STEP_TYPE\":\"0\",\"SPS_AUDIT_STATUS\":\"99\",\"SPS_PREV_AUDIT_STATUS\":\"0\",\"SPS_TABLE_ID\":\"50844794401849344\",\"SPD_ID\":\"50838310695731200\",\"ID\":\"50854681315901440\"}', '2018-08-13 00:12:10', 1);
INSERT INTO `sys_value_record` VALUES ('50855922662113280', '48601651874889729', 'SYS_PROCESS_SCHEDULE', '50855922569838592', NULL, '{\"SHOW_SO_ID\":\"48944951878221825\",\"SVR_TABLE_NAME\":\"SYS_PROCESS_SCHEDULE\",\"SPS_PREV_STEP_ID\":\"50839589836816384\",\"SPS_STEP_TRANSACTOR\":\"48307839919194112\",\"SPS_BACK_STATUS\":\"0\",\"SPS_STEP_TYPE\":\"1\",\"SO_ID\":\"48601651874889729\",\"SPS_BACK_STATUS_TRANSACTOR\":\"-1\",\"SPS_TABLE_NAME\":\"student_test\",\"SPS_PREV_STEP_TRANSACTOR\":\"48601651874889729\",\"SPS_ID\":\"50839707340242944\",\"SPS_PREV_STEP_TYPE\":\"0\",\"SPS_AUDIT_STATUS\":\"99\",\"SPS_PREV_AUDIT_STATUS\":\"0\",\"SPS_TABLE_ID\":\"50844794401849344\",\"SPD_ID\":\"50838310695731200\",\"ID\":\"50855922569838592\"}', '2018-08-13 00:17:06', 1);
INSERT INTO `sys_value_record` VALUES ('50858364548153344', '1', 'SYS_ROLE', '50858364522987520', NULL, '{\"SR_CODE\":\"ALL\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"SYS_ROLE\",\"SR_EXPLAIN\":\"\",\"SR_NAME\":\"查看学校奖学金\",\"ID\":\"50858364522987520\",\"SR_REMARK\":\"\",\"SR_TYPE\":\"2\"}', '2018-08-13 00:26:48', 1);
INSERT INTO `sys_value_record` VALUES ('50858397498605568', '1', 'SYS_ROLE', '50858364522987520', '{\"SR_CODE\":\"ALL\",\"IS_STATUS\":1,\"SR_EXPLAIN\":\"\",\"SR_NAME\":\"查看学校奖学金\",\"ID\":\"50858364522987520\",\"SR_REMARK\":\"\",\"SR_TYPE\":\"2\"}', '{\"SR_CODE\":\"ALL_COLLEGE_SCHOLARSHIP\",\"SR_TYPE\":\"2\",\"SR_EXPLAIN\":\"\",\"SR_NAME\":\"查看学校奖学金\",\"ID\":\"50858364522987520\",\"SR_REMARK\":\"\"}', '2018-08-13 00:26:56', 2);
INSERT INTO `sys_value_record` VALUES ('50858773761228800', '1', 'SYS_PROCESS_DEFINITION', '50838310695731200', '{\"BUS_PROCESS\":\"100\",\"SR_ID\":\"48307839919194112\",\"SPD_DIVISION_FIELD\":\"\",\"SO_ID\":\"1\",\"SPD_DESCRIBE\":\"\",\"BUS_PROCESS2\":\"109\",\"IS_STATUS\":1,\"SPD_DEPARTMENT_FIELD\":\"BDM_ID\",\"SPD_UPDATE_TABLE\":\"V_COLLEGE_SCHOLARSHIP\",\"IS_MULTISTAGE_BACK\":1,\"SPD_VERSION\":\"1.0\",\"SDP_ENTRY_TIME\":\"2018-08-12 23:07:07\",\"ID\":\"50838310695731200\",\"SPD_UPDATE_NAME\":\"BS_NAME\",\"SPD_NAME\":\"学院奖学金\"}', '{\"BUS_PROCESS\":\"100\",\"SR_ID\":\"50858364522987520\",\"SPD_DIVISION_FIELD\":\"\",\"SPD_DESCRIBE\":\"\",\"BUS_PROCESS2\":\"109\",\"SPD_DEPARTMENT_FIELD\":\"BDM_ID\",\"SPD_UPDATE_TABLE\":\"V_COLLEGE_SCHOLARSHIP\",\"IS_MULTISTAGE_BACK\":\"1\",\"SPD_VERSION\":\"1.0\",\"ID\":\"50838310695731200\",\"SPD_UPDATE_NAME\":\"BS_NAME\",\"SPD_NAME\":\"学院奖学金\"}', '2018-08-13 00:28:25', 2);
INSERT INTO `sys_value_record` VALUES ('51000226797846528', '1', 'SYS_CONFIGURE_COLUMN', '50833943762567168', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"250px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"50833943762567168\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":80}', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"240px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"50833943762567168\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"80\"}', '2018-08-13 09:50:31', 2);
INSERT INTO `sys_value_record` VALUES ('51000960591331328', '1', 'BUS_AID_FINANCIALLY', '50844794401849344', '{\"BS_ID\":\"48944951878221824\",\"BAF_AID_TYPE\":\"FIRST-CLASS\",\"BAF_YEAR\":\"2017~2018\",\"BAF_SEMESTER\":2,\"ID\":\"50844794401849344\"}', '{\"BS_ID\":\"48944951878221824\",\"BAF_AID_TYPE\":\"FIRST-CLASS\",\"BAF_YEAR\":\"2017~2018\",\"BAF_SEMESTER\":\"2\",\"ID\":\"50844794401849344\"}', '2018-08-13 09:53:25', 2);
INSERT INTO `sys_value_record` VALUES ('51009610198286336', '1', 'BUS_STUDENT_ATTENDANCE', '49398562747842560', '{\"BS_ID\":\"48944951878221824\",\"BSA_SEMESTER\":1,\"BSA_WEEK\":1,\"BSA_ENTRY_TIME\":\"2018-08-08 23:46:04\",\"BSA_LATE\":4,\"ID\":\"49398562747842560\",\"BSA_ABSENTEEISM\":4,\"BSA_YEAR\":\"2018\"}', '{\"BS_ID\":\"48944951878221824\",\"BSA_SEMESTER\":\"2\",\"BSA_WEEK\":\"1\",\"BSA_LATE\":\"4\",\"BSA_ABSENTEEISM\":\"4\",\"BSA_YEAR\":\"2017~2018\",\"ID\":\"49398562747842560\"}', '2018-08-13 10:27:48', 2);
INSERT INTO `sys_value_record` VALUES ('51009695489458176', '1', 'BUS_STUDENT_ATTENDANCE', '51009695430737920', NULL, '{\"BS_ID\":\"48944951878221824\",\"BSA_SEMESTER\":\"2\",\"BSA_WEEK\":\"19\",\"SVR_TABLE_NAME\":\"BUS_STUDENT_ATTENDANCE\",\"BSA_ENTRY_TIME\":\"2018-08-13 10:28:08\",\"BSA_LATE\":\"4\",\"ID\":\"51009695430737920\",\"BSA_ABSENTEEISM\":\"12\",\"BSA_YEAR\":\"2017~2018\"}', '2018-08-13 10:28:08', 1);
INSERT INTO `sys_value_record` VALUES ('51009751139483648', '1', 'BUS_STUDENT_ATTENDANCE', '51009695430737920', '{\"BS_ID\":\"48944951878221824\",\"BSA_SEMESTER\":2,\"BSA_WEEK\":19,\"BSA_ENTRY_TIME\":\"2018-08-13 10:28:08\",\"BSA_LATE\":4,\"ID\":\"51009695430737920\",\"BSA_ABSENTEEISM\":12,\"BSA_YEAR\":\"2017~2018\"}', '{\"BS_ID\":\"48944951878221824\",\"BSA_SEMESTER\":\"2\",\"BSA_WEEK\":\"2\",\"BSA_LATE\":\"4\",\"BSA_ABSENTEEISM\":\"12\",\"BSA_YEAR\":\"2017~2018\",\"ID\":\"51009695430737920\"}', '2018-08-13 10:28:21', 2);
INSERT INTO `sys_value_record` VALUES ('51009901551419392', '1', 'SYS_CONFIGURE_COLUMN', '51009901505282048', NULL, '{\"SCC_NAME\":\"周\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"50px\",\"SCC_FIELD\":\"BSA_WEEK\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"51009901505282048\",\"SC_ID\":\"49382988399509504\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"55\"}', '2018-08-13 10:28:57', 1);
INSERT INTO `sys_value_record` VALUES ('51010069050949632', '1', 'SYS_CONFIGURE_COLUMN', '51009901505282048', '{\"SCC_NAME\":\"周\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"50px\",\"SCC_FIELD\":\"BSA_WEEK\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"51009901505282048\",\"SC_ID\":\"49382988399509504\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":55}', '{\"SCC_NAME\":\"周\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"50px\",\"SCC_FIELD\":\"BSA_WEEK\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"51009901505282048\",\"SC_ID\":\"49382988399509504\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"35\"}', '2018-08-13 10:29:37', 2);
INSERT INTO `sys_value_record` VALUES ('51012702880923648', '1', 'SYS_CONFIGURE_COLUMN', '26725940633534464', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"150px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"26725940633534464\",\"SC_ID\":\"26721805670547456\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":80}', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"140px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"26725940633534464\",\"SC_ID\":\"26721805670547456\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"80\"}', '2018-08-13 10:40:05', 2);
INSERT INTO `sys_value_record` VALUES ('51014046756896768', '1', 'BUS_STUDENT_ATTENDANCE', '51014046706565120', NULL, '{\"BS_ID\":\"48944951878221824\",\"BSA_SEMESTER\":\"2\",\"BSA_WEEK\":\"3\",\"SVR_TABLE_NAME\":\"BUS_STUDENT_ATTENDANCE\",\"BSA_ENTRY_TIME\":\"2018-08-13 10:45:25\",\"BSA_LATE\":\"1\",\"ID\":\"51014046706565120\",\"BSA_ABSENTEEISM\":\"30\",\"BSA_YEAR\":\"2017~2018\"}', '2018-08-13 10:45:25', 1);
INSERT INTO `sys_value_record` VALUES ('51014625755398144', '1', 'BUS_STUDENT_ATTENDANCE', '51014046706565120', '{\"BS_ID\":\"48944951878221824\",\"BSA_SEMESTER\":2,\"BSA_WEEK\":3,\"BSA_ENTRY_TIME\":\"2018-08-13 10:45:25\",\"BSA_LATE\":1,\"ID\":\"51014046706565120\",\"BSA_ABSENTEEISM\":30,\"BSA_YEAR\":\"2017~2018\"}', '{\"BS_ID\":\"48944951878221824\",\"BSA_SEMESTER\":\"2\",\"BSA_WEEK\":\"3\",\"BSA_LATE\":\"1\",\"BSA_ABSENTEEISM\":\"20\",\"BSA_YEAR\":\"2017~2018\",\"ID\":\"51014046706565120\"}', '2018-08-13 10:47:43', 2);
INSERT INTO `sys_value_record` VALUES ('51351046445858816', '48601651874889729', 'BUS_AID_FINANCIALLY', '51351046366167040', NULL, '{\"BS_ID\":\"48944951878221824\",\"BUS_PROCESS\":\"100\",\"BAF_AID_TYPE\":\"FIRST-CLASS\",\"SVR_TABLE_NAME\":\"BUS_AID_FINANCIALLY\",\"SO_ID\":\"48601651874889729\",\"BAF_TYPE\":9,\"BAF_YEAR\":\"2017~2018\",\"BUS_PROCESS2\":\"109\",\"BAF_SEMESTER\":\"2\",\"ID\":\"51351046366167040\",\"BAF_ENTRY_TIME\":\"2018-08-14 09:04:32\"}', '2018-08-14 09:04:32', 1);
INSERT INTO `sys_value_record` VALUES ('51355006686724096', '1', 'BUS_STUDENT_PUNISHMENT', '1', '{\"BSP_CANCEL_TIME\":\"2018-08-10 00:37:03\",\"BSP_IS_CANCEL\":\"0\",\"ID\":\"1\"}', '{\"BSP_CANCEL_TIME\":\"2018-08-14 09:20:17\",\"BSP_IS_CANCEL\":1,\"ID\":\"1\"}', '2018-08-14 09:20:17', 2);
INSERT INTO `sys_value_record` VALUES ('51355064295489536', '1', 'BUS_STUDENT_ATTENDANCE', '51014046706565120', '{\"BS_ID\":\"48944951878221824\",\"BSA_SEMESTER\":2,\"BSA_WEEK\":3,\"BSA_ENTRY_TIME\":\"2018-08-13 10:45:25\",\"BSA_LATE\":1,\"ID\":\"51014046706565120\",\"BSA_ABSENTEEISM\":20,\"BSA_YEAR\":\"2017~2018\"}', '{\"BS_ID\":\"48944951878221824\",\"BSA_SEMESTER\":\"2\",\"BSA_WEEK\":\"3\",\"BSA_LATE\":\"1\",\"BSA_ABSENTEEISM\":\"5\",\"BSA_YEAR\":\"2017~2018\",\"ID\":\"51014046706565120\"}', '2018-08-14 09:20:30', 2);
INSERT INTO `sys_value_record` VALUES ('51355078933610496', '48601651874889729', 'SYS_PROCESS_SCHEDULE', '51355078891667456', NULL, '{\"SHOW_SO_ID\":\"48944951878221825\",\"SVR_TABLE_NAME\":\"SYS_PROCESS_SCHEDULE\",\"SPS_PREV_STEP_ID\":\"50839589836816384\",\"SPS_STEP_TRANSACTOR\":\"48307839919194112\",\"SPS_BACK_STATUS\":\"0\",\"SPS_STEP_TYPE\":\"1\",\"SO_ID\":\"48601651874889729\",\"SPS_BACK_STATUS_TRANSACTOR\":\"-1\",\"SPS_TABLE_NAME\":\"student_test\",\"SPS_PREV_STEP_TRANSACTOR\":\"48601651874889729\",\"SPS_ID\":\"50839707340242944\",\"SPS_PREV_STEP_TYPE\":\"0\",\"SPS_AUDIT_STATUS\":\"99\",\"SPS_PREV_AUDIT_STATUS\":\"0\",\"SPS_TABLE_ID\":\"51351046366167040\",\"SPD_ID\":\"50838310695731200\",\"ID\":\"51355078891667456\"}', '2018-08-14 09:20:34', 1);
INSERT INTO `sys_value_record` VALUES ('51357441916403712', '1', 'SYS_CONFIGURE_COLUMN', '50833512873328640', '{\"SCC_NAME\":\"班级\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"170px\",\"SCC_FIELD\":\"BC_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50833512873328640\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":30}', '{\"SCC_NAME\":\"班级\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"left\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"170px\",\"SCC_FIELD\":\"BC_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50833512873328640\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"30\"}', '2018-08-14 09:29:57', 2);
INSERT INTO `sys_value_record` VALUES ('51359243336417280', '48601651874889729', 'SYS_PROCESS_SCHEDULE', '51351046567493632', '{\"SPS_BACK_STATUS\":0,\"SPS_TABLE_NAME\":\"student_test\",\"SPS_AUDIT_STATUS\":0,\"SPS_TABLE_ID\":\"51351046366167040\",\"SPD_ID\":\"50838310695731200\",\"ID\":\"51351046567493632\"}', '{\"SPS_PREV_STEP_ID\":\"50839589836816384\",\"SPS_STEP_TRANSACTOR\":\"48307839919194112\",\"SPS_BACK_STATUS\":\"0\",\"SPS_STEP_TYPE\":\"1\",\"SPS_TABLE_NAME\":\"student_test\",\"SPS_BACK_STATUS_TRANSACTOR\":\"-1\",\"SPS_PREV_STEP_TRANSACTOR\":\"48601651874889729\",\"SPS_ID\":\"50839707340242944\",\"SPS_PREV_STEP_TYPE\":\"0\",\"SPS_AUDIT_STATUS\":\"99\",\"SPS_PREV_AUDIT_STATUS\":\"0\",\"SPS_TABLE_ID\":\"51351046366167040\",\"SPD_ID\":\"50838310695731200\",\"ID\":\"51351046567493632\"}', '2018-08-14 09:37:07', 2);
INSERT INTO `sys_value_record` VALUES ('51360166666305536', '48601651874889729', 'SYS_PROCESS_SCHEDULE', '51351046567493632', '{\"SPS_PREV_STEP_ID\":\"50839589836816384\",\"SPS_STEP_TRANSACTOR\":\"48307839919194112\",\"SPS_BACK_STATUS\":0,\"SPS_STEP_TYPE\":1,\"SPS_TABLE_NAME\":\"student_test\",\"SPS_BACK_STATUS_TRANSACTOR\":-1,\"SPS_PREV_STEP_TRANSACTOR\":\"48601651874889729\",\"SPS_ID\":\"50839707340242944\",\"SPS_PREV_STEP_TYPE\":0,\"SPS_AUDIT_STATUS\":99,\"SPS_PREV_AUDIT_STATUS\":0,\"SPS_TABLE_ID\":\"51351046366167040\",\"SPD_ID\":\"50838310695731200\",\"ID\":\"51351046567493632\"}', '{\"SPS_PREV_STEP_ID\":\"50839707340242944\",\"SPS_STEP_TRANSACTOR\":\"48601651874889729\",\"SPS_BACK_STATUS\":\"2\",\"SPS_STEP_TYPE\":2,\"SPS_TABLE_NAME\":\"student_test\",\"SPS_BACK_STATUS_TRANSACTOR\":5,\"SPS_PREV_STEP_TRANSACTOR\":\"48601651874889729\",\"SPS_ID\":\"50839589836816384\",\"SPS_PREV_STEP_TYPE\":\"2\",\"SPS_AUDIT_STATUS\":-1,\"SPS_PREV_AUDIT_STATUS\":99,\"SPS_TABLE_ID\":\"51351046366167040\",\"SPD_ID\":\"50838310695731200\",\"ID\":\"51351046567493632\"}', '2018-08-14 09:40:47', 2);
INSERT INTO `sys_value_record` VALUES ('51365861860048896', '48601651874889729', 'BUS_AID_FINANCIALLY', '51351046366167040', NULL, NULL, '2018-08-14 10:03:25', 3);
INSERT INTO `sys_value_record` VALUES ('51562014853562368', '1', 'SYS_BUTTON', '51562014773870592', NULL, '{\"SB_CODE\":\"AUTHORIZATION\",\"SVR_TABLE_NAME\":\"SYS_BUTTON\",\"SB_FUNC\":\"\",\"SB_CLASS\":\"btn btn-warning\",\"SB_ORDER\":\"96\",\"SB_BUTTONID\":\"authorization\",\"SB_ICON\":\"mdi mdi-graphql\",\"ID\":\"51562014773870592\",\"SB_TYPE\":\"1\",\"SB_NAME\":\"授权\"}', '2018-08-14 23:02:51', 1);
INSERT INTO `sys_value_record` VALUES ('51578241692991488', '1', 'SYS_PROCESS_DEFINITION', '50838310695731200', '{\"BUS_PROCESS\":\"100\",\"SR_ID\":\"50858364522987520\",\"SO_ID\":\"1\",\"SPD_DESCRIBE\":\"\",\"BUS_PROCESS2\":\"109\",\"IS_STATUS\":1,\"SPD_DEPARTMENT_FIELD\":\"BDM_ID\",\"SPD_UPDATE_TABLE\":\"V_COLLEGE_SCHOLARSHIP\",\"IS_MULTISTAGE_BACK\":1,\"SPD_VERSION\":\"1.0\",\"SDP_ENTRY_TIME\":\"2018-08-12 23:07:07\",\"ID\":\"50838310695731200\",\"SPD_UPDATE_NAME\":\"BS_NAME\",\"SPD_NAME\":\"学院奖学金\"}', '{\"BUS_PROCESS\":\"100\",\"SR_ID\":\"50858364522987520\",\"SPD_DESCRIBE\":\"\",\"BUS_PROCESS2\":\"109\",\"SPD_DEPARTMENT_FIELD\":\"BDM_ID\",\"SPD_UPDATE_TABLE\":\"V_COLLEGE_SCHOLARSHIP\",\"IS_MULTISTAGE_BACK\":\"1\",\"SPD_VERSION\":\"1.0\",\"ID\":\"50838310695731200\",\"SPD_UPDATE_NAME\":\"BS_NAME\",\"SPD_NAME\":\"学院奖学金\"}', '2018-08-15 00:07:20', 2);
INSERT INTO `sys_value_record` VALUES ('51578472077721600', '1', 'SYS_PROCESS_DEFINITION', '50838310695731200', '{\"BUS_PROCESS\":\"100\",\"SR_ID\":\"50858364522987520\",\"SO_ID\":\"1\",\"SPD_DESCRIBE\":\"\",\"BUS_PROCESS2\":\"109\",\"IS_STATUS\":1,\"SPD_DEPARTMENT_FIELD\":\"BDM_ID\",\"SPD_UPDATE_TABLE\":\"V_COLLEGE_SCHOLARSHIP\",\"IS_MULTISTAGE_BACK\":1,\"SPD_VERSION\":\"1.0\",\"SDP_ENTRY_TIME\":\"2018-08-12 23:07:07\",\"ID\":\"50838310695731200\",\"SPD_UPDATE_NAME\":\"BS_NAME\",\"SPD_NAME\":\"学院奖学金\"}', '{\"BUS_PROCESS\":\"100\",\"SR_ID\":\"50858364522987520\",\"SPD_DESCRIBE\":\"\",\"BUS_PROCESS2\":\"109\",\"SPD_DEPARTMENT_FIELD\":\"BDM_ID\",\"SPD_UPDATE_TABLE\":\"V_COLLEGE_SCHOLARSHIP\",\"IS_MULTISTAGE_BACK\":\"1\",\"SPD_VERSION\":\"1.0\",\"ID\":\"50838310695731200\",\"SPD_UPDATE_NAME\":\"BS_NAME\",\"SPD_NAME\":\"学院奖学金\"}', '2018-08-15 00:08:15', 2);
INSERT INTO `sys_value_record` VALUES ('51578495339331584', '1', 'SYS_PROCESS_DEFINITION', '50838310695731200', '{\"BUS_PROCESS\":\"100\",\"SR_ID\":\"50858364522987520\",\"SO_ID\":\"1\",\"SPD_DESCRIBE\":\"\",\"BUS_PROCESS2\":\"109\",\"IS_STATUS\":1,\"SPD_DEPARTMENT_FIELD\":\"BDM_ID\",\"SPD_UPDATE_TABLE\":\"V_COLLEGE_SCHOLARSHIP\",\"IS_MULTISTAGE_BACK\":1,\"SPD_VERSION\":\"1.0\",\"SDP_ENTRY_TIME\":\"2018-08-12 23:07:07\",\"ID\":\"50838310695731200\",\"SPD_UPDATE_NAME\":\"BS_NAME\",\"SPD_NAME\":\"学院奖学金\"}', '{\"BUS_PROCESS\":\"100\",\"SR_ID\":\"50858364522987520\",\"SPD_DESCRIBE\":\"\",\"BUS_PROCESS2\":\"109\",\"SPD_DEPARTMENT_FIELD\":\"BDM_ID\",\"SPD_UPDATE_TABLE\":\"V_COLLEGE_SCHOLARSHIP\",\"IS_MULTISTAGE_BACK\":\"1\",\"SPD_VERSION\":\"1.0\",\"ID\":\"50838310695731200\",\"SPD_UPDATE_NAME\":\"BS_NAME\",\"SPD_NAME\":\"学院奖学金\"}', '2018-08-15 00:08:20', 2);
INSERT INTO `sys_value_record` VALUES ('51578612444299264', '1', 'SYS_PROCESS_DEFINITION', '50838310695731200', '{\"BUS_PROCESS\":\"100\",\"SR_ID\":\"50858364522987520\",\"SO_ID\":\"1\",\"SPD_DESCRIBE\":\"\",\"BUS_PROCESS2\":\"109\",\"IS_STATUS\":1,\"SPD_DEPARTMENT_FIELD\":\"BDM_ID\",\"SPD_UPDATE_TABLE\":\"V_COLLEGE_SCHOLARSHIP\",\"IS_MULTISTAGE_BACK\":1,\"SPD_VERSION\":\"1.0\",\"SDP_ENTRY_TIME\":\"2018-08-12 23:07:07\",\"ID\":\"50838310695731200\",\"SPD_UPDATE_NAME\":\"BS_NAME\",\"SPD_NAME\":\"学院奖学金\"}', '{\"BUS_PROCESS\":\"100\",\"SR_ID\":\"50858364522987520\",\"SPD_DESCRIBE\":\"\",\"BUS_PROCESS2\":\"109\",\"SPD_DEPARTMENT_FIELD\":\"BDM_ID\",\"SPD_UPDATE_TABLE\":\"V_COLLEGE_SCHOLARSHIP\",\"IS_MULTISTAGE_BACK\":\"1\",\"SPD_VERSION\":\"1.0\",\"ID\":\"50838310695731200\",\"SPD_UPDATE_NAME\":\"BS_NAME\",\"SPD_NAME\":\"学院奖学金\"}', '2018-08-15 00:08:48', 2);
INSERT INTO `sys_value_record` VALUES ('51578688474447872', '1', 'SYS_PROCESS_DEFINITION', '50838310695731200', '{\"BUS_PROCESS\":\"100\",\"SPD_COLLEGE_FIELD\":\"\",\"SR_ID\":\"50858364522987520\",\"SO_ID\":\"1\",\"SPD_DESCRIBE\":\"\",\"BUS_PROCESS2\":\"109\",\"IS_STATUS\":1,\"SPD_DEPARTMENT_FIELD\":\"BDM_ID\",\"SPD_UPDATE_TABLE\":\"V_COLLEGE_SCHOLARSHIP\",\"IS_MULTISTAGE_BACK\":1,\"SPD_VERSION\":\"1.0\",\"SDP_ENTRY_TIME\":\"2018-08-12 23:07:07\",\"ID\":\"50838310695731200\",\"SPD_UPDATE_NAME\":\"BS_NAME\",\"SPD_NAME\":\"学院奖学金\"}', '{\"BUS_PROCESS\":\"100\",\"SPD_COLLEGE_FIELD\":\"BDM_COLLEGE\",\"SR_ID\":\"50858364522987520\",\"SPD_DESCRIBE\":\"\",\"BUS_PROCESS2\":\"109\",\"SPD_CLASS_FIELD\":\"BC_ID\",\"SPD_DEPARTMENT_FIELD\":\"BDM_ID\",\"SPD_UPDATE_TABLE\":\"V_COLLEGE_SCHOLARSHIP\",\"IS_MULTISTAGE_BACK\":\"1\",\"SPD_VERSION\":\"1.0\",\"ID\":\"50838310695731200\",\"SPD_UPDATE_NAME\":\"BS_NAME\",\"SPD_NAME\":\"学院奖学金\"}', '2018-08-15 00:09:07', 2);
INSERT INTO `sys_value_record` VALUES ('51586781539205120', '1', 'SYS_CONFIGURE', '48890586014416896', '{\"SC_IS_PAGING\":\"1\",\"SC_NAME\":\"学生管理\",\"SC_JSP\":\"admin/student/student/home\",\"SC_VIEW\":\"v_student\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"48890586014416896\",\"SC_ORDER_BY\":\"CONVERT(ID,SIGNED) DESC\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '{\"SC_NAME\":\"学生管理\",\"SC_JSP\":\"admin/student/student/home\",\"SC_VIEW\":\"v_student\",\"SC_ORDER_BY\":\"CONVERT(ID,SIGNED) DESC\",\"SC_IS_PAGING\":\"1\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"48890586014416896\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"1\"}', '2018-08-15 00:41:16', 2);
INSERT INTO `sys_value_record` VALUES ('51586797527891968', '1', 'SYS_CONFIGURE', '49382988399509504', '{\"SC_IS_PAGING\":\"1\",\"SC_NAME\":\"学生管理-考勤管理\",\"SC_JSP\":\"admin/student/attendance/home\",\"SC_VIEW\":\"v_student_attendance\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"49382988399509504\",\"SC_ORDER_BY\":\"CONVERT(ID,SIGNED) DESC\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '{\"SC_NAME\":\"学生管理-考勤管理\",\"SC_JSP\":\"admin/student/attendance/home\",\"SC_VIEW\":\"v_student_attendance\",\"SC_ORDER_BY\":\"CONVERT(ID,SIGNED) DESC\",\"SC_IS_PAGING\":\"1\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"49382988399509504\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"1\"}', '2018-08-15 00:41:20', 2);
INSERT INTO `sys_value_record` VALUES ('51586817857683456', '1', 'SYS_CONFIGURE', '49623725020020736', '{\"SC_IS_PAGING\":\"1\",\"SC_NAME\":\"学生管理-处分管理\",\"SC_JSP\":\"admin/student/punishment/home\",\"SC_VIEW\":\"v_student_punishment\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"49623725020020736\",\"SC_ORDER_BY\":\"CONVERT(ID,SIGNED) DESC\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '{\"SC_NAME\":\"学生管理-处分管理\",\"SC_JSP\":\"admin/student/punishment/home\",\"SC_VIEW\":\"v_student_punishment\",\"SC_ORDER_BY\":\"CONVERT(ID,SIGNED) DESC\",\"SC_IS_PAGING\":\"1\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"49623725020020736\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"1\"}', '2018-08-15 00:41:25', 2);
INSERT INTO `sys_value_record` VALUES ('51586830373486592', '1', 'SYS_CONFIGURE', '50338719827230720', '{\"SC_IS_PAGING\":\"1\",\"SC_NAME\":\"学生管理-综合素质测评\",\"SC_JSP\":\"admin/student/comprehensive/home\",\"SC_VIEW\":\"v_student_comprehensive\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"50338719827230720\",\"SC_ORDER_BY\":\"BSC_YEAR DESC,BSC_SEMESTER DESC,BSC_RANK ASC\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '{\"SC_NAME\":\"学生管理-综合素质测评\",\"SC_JSP\":\"admin/student/comprehensive/home\",\"SC_VIEW\":\"v_student_comprehensive\",\"SC_ORDER_BY\":\"BSC_YEAR DESC,BSC_SEMESTER DESC,BSC_RANK ASC\",\"SC_IS_PAGING\":\"1\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"50338719827230720\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"1\"}', '2018-08-15 00:41:28', 2);
INSERT INTO `sys_value_record` VALUES ('51787636724989952', '1', 'SYS_VALIDATE_REGEX', '26504926733533184', '{\"IS_STATUS\":\"1\",\"SVR_REGEX\":\"^(19\\\\d\\\\d|20\\\\d\\\\d|2100|20\\\\d\\\\d~20\\\\d\\\\d)$\",\"SVR_REGEX_MESSAGE\":\"请输入正确的年份!\",\"ID\":\"26504926733533184\",\"SVR_NAME\":\"年份\"}', '{\"SVR_REGEX\":\"^(19\\\\d\\\\d|20\\\\d\\\\d|2100|20\\\\d\\\\d-20\\\\d\\\\d)$\",\"SVR_REGEX_MESSAGE\":\"请输入正确的年份!\",\"ID\":\"26504926733533184\",\"SVR_NAME\":\"年份\"}', '2018-08-15 13:59:24', 2);
INSERT INTO `sys_value_record` VALUES ('51788304550461440', '1', 'BUS_STUDENT_ATTENDANCE', '51014046706565120', '{\"BS_ID\":\"48944951878221824\",\"BSA_SEMESTER\":2,\"BSA_WEEK\":3,\"BSA_ENTRY_TIME\":\"2018-08-13 10:45:25\",\"BSA_LATE\":1,\"ID\":\"51014046706565120\",\"BSA_ABSENTEEISM\":5,\"BSA_YEAR\":\"2017~2018\"}', '{\"BS_ID\":\"48944951878221824\",\"BSA_SEMESTER\":\"2\",\"BSA_WEEK\":\"3\",\"BSA_LATE\":\"1\",\"BSA_ABSENTEEISM\":\"5\",\"BSA_YEAR\":\"2017-2018\",\"ID\":\"51014046706565120\"}', '2018-08-15 14:02:03', 2);
INSERT INTO `sys_value_record` VALUES ('51788319331188736', '1', 'BUS_STUDENT_ATTENDANCE', '51009695430737920', '{\"BS_ID\":\"48944951878221824\",\"BSA_SEMESTER\":2,\"BSA_WEEK\":2,\"BSA_ENTRY_TIME\":\"2018-08-13 10:28:08\",\"BSA_LATE\":4,\"ID\":\"51009695430737920\",\"BSA_ABSENTEEISM\":12,\"BSA_YEAR\":\"2017~2018\"}', '{\"BS_ID\":\"48944951878221824\",\"BSA_SEMESTER\":\"2\",\"BSA_WEEK\":\"2\",\"BSA_LATE\":\"4\",\"BSA_ABSENTEEISM\":\"12\",\"BSA_YEAR\":\"2017-2018\",\"ID\":\"51009695430737920\"}', '2018-08-15 14:02:06', 2);
INSERT INTO `sys_value_record` VALUES ('51788331977015296', '1', 'BUS_STUDENT_ATTENDANCE', '49398562747842560', '{\"BS_ID\":\"48944951878221824\",\"BSA_SEMESTER\":2,\"BSA_WEEK\":1,\"BSA_ENTRY_TIME\":\"2018-08-08 23:46:04\",\"BSA_LATE\":4,\"ID\":\"49398562747842560\",\"BSA_ABSENTEEISM\":4,\"BSA_YEAR\":\"2017~2018\"}', '{\"BS_ID\":\"48944951878221824\",\"BSA_SEMESTER\":\"2\",\"BSA_WEEK\":\"1\",\"BSA_LATE\":\"4\",\"BSA_ABSENTEEISM\":\"4\",\"BSA_YEAR\":\"2017-2018\",\"ID\":\"49398562747842560\"}', '2018-08-15 14:02:09', 2);
INSERT INTO `sys_value_record` VALUES ('51928538709753856', '1', 'BUS_STUDENT_COMPREHENSIVE', '50372217258639360', '{\"BS_ID\":\"48944951878221824\",\"BSC_INTELLECTUAL_PROPORTION\":60,\"BSC_VOLUNTEER_TOTAL\":86,\"BSC_INTELLECTUAL_SCORE\":49.80,\"BSC_INTELLECTUAL_POINTS\":0,\"BSC_DECORUM\":12,\"BSC_SERVICE_SPIRIT\":10,\"BSC_EDUCATION_TOTAL\":64,\"ID\":\"50372217258639360\",\"BSC_COLLECTIVE\":10,\"BSC_VOLUNTEER_PROPORTION\":10,\"BSC_YEAR\":\"2017-2018\",\"BSC_EDUCATION_DEDUCTION\":0,\"BSC_ACADEMIC_RECORD\":83,\"BSC_BONUS_POINTS\":0,\"BSC_LABOR_ATTITUDE\":14,\"BSC_POLITICAL_ATTITUDE\":3,\"BSC_COMPLIANCE\":1,\"BSC_EDUCATION_SCORE\":19.20,\"BSC_FULL_WORK\":0,\"BSC_SEMESTER\":2,\"BSC_PERSONAL_QUALITY\":4,\"BSC_EDUCATION_PROPORTION\":30,\"BSC_TOTAL\":77.59,\"BSC_CARE\":10,\"BSC_VOLUNTEER_SCORE\":8.60}', '{\"BS_ID\":\"48944951878221824\",\"BSC_INTELLECTUAL_PROPORTION\":\"60\",\"BSC_VOLUNTEER_TOTAL\":\"62\",\"BSC_INTELLECTUAL_SCORE\":\"49.80\",\"BSC_INTELLECTUAL_POINTS\":\"0\",\"BSC_DECORUM\":\"12\",\"BSC_SERVICE_SPIRIT\":\"10\",\"BSC_EDUCATION_TOTAL\":\"64\",\"ID\":\"50372217258639360\",\"BSC_COLLECTIVE\":\"10\",\"BSC_VOLUNTEER_PROPORTION\":\"10\",\"BSC_YEAR\":\"2017-2018\",\"BSC_EDUCATION_DEDUCTION\":\"0\",\"BSC_ACADEMIC_RECORD\":\"83\",\"BSC_BONUS_POINTS\":\"0\",\"BSC_LABOR_ATTITUDE\":\"14\",\"BSC_POLITICAL_ATTITUDE\":\"3\",\"BSC_COMPLIANCE\":\"1\",\"BSC_EDUCATION_SCORE\":\"19.20\",\"BSC_FULL_WORK\":\"0\",\"BSC_SEMESTER\":\"2\",\"BSC_PERSONAL_QUALITY\":\"4\",\"BSC_EDUCATION_PROPORTION\":\"30\",\"BSC_TOTAL\":\"75.2\",\"BSC_CARE\":\"10\",\"BSC_VOLUNTEER_SCORE\":\"6.2\"}', '2018-08-15 23:19:17', 2);
INSERT INTO `sys_value_record` VALUES ('51930103587799040', '1', 'SYS_OPERATOR', '51930103373889536', NULL, '{\"SO_PASSWORD\":\"8d51b5b2f7c974d32f8b38d2617f6e15\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"SYS_OPERATOR\",\"ID\":\"51930103373889536\",\"SO_SALT\":\"S,Jn\'\'\"}', '2018-08-15 23:25:30', 1);
INSERT INTO `sys_value_record` VALUES ('51930103667490816', '1', 'SYS_ACCOUNT_INFO', '51930103629742080', NULL, '{\"SO_ID\":\"51930103373889536\",\"SAI_NAME\":\"student_test2\",\"SVR_TABLE_NAME\":\"SYS_ACCOUNT_INFO\",\"ID\":\"51930103629742080\",\"SAI_TYPE\":4}', '2018-08-15 23:25:30', 1);
INSERT INTO `sys_value_record` VALUES ('51930103797514240', '1', 'BUS_STUDENT', '51930103357112320', NULL, '{\"SVR_TABLE_NAME\":\"BUS_STUDENT\",\"BS_LENGTH\":\"3\",\"BS_ENROLMENT_YEAR\":\"2017\",\"BS_NAME\":\"student_test2\",\"BS_SEX\":\"1\",\"BS_BANK_CARD\":\"\",\"SO_ID\":\"51930103373889536\",\"BDM_ID\":\"48601265252335616\",\"BS_EXAMINEE_NUMBER\":\"2018053105\",\"BS_ENTRY_TIME\":\"2018-08-15 23:25:30\",\"BS_NUMBER\":\"2018053105\",\"BC_ID\":\"48656602449838080\",\"BS_PHONE\":\"\",\"ID\":\"51930103357112320\",\"BS_PERMANENT_ADDRESS\":\"\",\"BS_HOME_ADDRESS\":\"\",\"BS_BANK\":\"\",\"BS_NATION\":\"1\",\"BS_ID_CARD\":\"\"}', '2018-08-15 23:25:30', 1);
INSERT INTO `sys_value_record` VALUES ('51930141537861632', '1', 'BUS_STUDENT', '51930103357112320', '{\"BS_LENGTH\":\"3\",\"BS_ENROLMENT_YEAR\":\"2017\",\"BS_NAME\":\"student_test2\",\"BS_SEX\":\"1\",\"BS_BANK_CARD\":\"\",\"SO_ID\":\"51930103373889536\",\"BDM_ID\":\"48601265252335616\",\"BS_EXAMINEE_NUMBER\":\"2018053105\",\"BS_NUMBER\":\"2018053105\",\"BC_ID\":\"48656602449838080\",\"BS_PHONE\":\"\",\"ID\":\"51930103357112320\",\"BS_PERMANENT_ADDRESS\":\"\",\"BS_HOME_ADDRESS\":\"\",\"BS_BANK\":\"\",\"BS_NATION\":\"1\",\"BS_ID_CARD\":\"\"}', '{\"BS_LENGTH\":\"3\",\"BS_ENROLMENT_YEAR\":\"2017\",\"BS_NAME\":\"student_test2\",\"BS_SEX\":\"1\",\"BS_BANK_CARD\":\"\",\"BDM_ID\":\"48601265252335616\",\"BS_EXAMINEE_NUMBER\":\"2018053105\",\"BS_NUMBER\":\"2018053106\",\"BC_ID\":\"48656602449838080\",\"BS_PHONE\":\"\",\"ID\":\"51930103357112320\",\"BS_PERMANENT_ADDRESS\":\"\",\"BS_HOME_ADDRESS\":\"\",\"BS_BANK\":\"\",\"BS_NATION\":\"1\",\"BS_ID_CARD\":\"\"}', '2018-08-15 23:25:39', 2);
INSERT INTO `sys_value_record` VALUES ('51934928144695296', '1', 'BUS_STUDENT_COMPREHENSIVE', '51934928006283264', NULL, '{\"BS_ID\":\"51930103357112320\",\"BSC_INTELLECTUAL_PROPORTION\":60.0,\"BSC_VOLUNTEER_TOTAL\":86,\"BSC_INTELLECTUAL_SCORE\":9.19999980926513671875,\"SVR_TABLE_NAME\":\"BUS_STUDENT_COMPREHENSIVE\",\"BSC_INTELLECTUAL_POINTS\":0,\"BSC_DECORUM\":6,\"BSC_SERVICE_SPIRIT\":8,\"BSC_EDUCATION_TOTAL\":73,\"ID\":\"51934928006283264\",\"BSC_COLLECTIVE\":4,\"BSC_VOLUNTEER_PROPORTION\":10.0,\"BSC_YEAR\":\"2017-2018\",\"BSC_EDUCATION_DEDUCTION\":14,\"BSC_ACADEMIC_RECORD\":92,\"BSC_BONUS_POINTS\":10,\"BSC_LABOR_ATTITUDE\":3,\"BSC_POLITICAL_ATTITUDE\":2,\"BSC_REMARKS\":\"15\",\"BSC_COMPLIANCE\":4,\"BSC_EDUCATION_SCORE\":21.90000152587890625,\"BS_NUMBER\":\"2018053106\",\"BSC_FULL_WORK\":9,\"BSC_SEMESTER\":1,\"BSC_PERSONAL_QUALITY\":7,\"BSC_EDUCATION_PROPORTION\":30.0,\"BSC_TOTAL\":39.70000171661376953125,\"BSC_CARE\":6,\"BSC_VOLUNTEER_SCORE\":8.6000003814697265625}', '2018-08-15 23:44:41', 1);
INSERT INTO `sys_value_record` VALUES ('51935890087346176', '1', 'BUS_STUDENT_COMPREHENSIVE', '51935889848270848', NULL, '{\"BS_ID\":\"51930103357112320\",\"BSC_INTELLECTUAL_PROPORTION\":60.0,\"BSC_VOLUNTEER_TOTAL\":86,\"BSC_INTELLECTUAL_SCORE\":55.200000762939453125,\"SVR_TABLE_NAME\":\"BUS_STUDENT_COMPREHENSIVE\",\"BSC_INTELLECTUAL_POINTS\":0,\"BSC_DECORUM\":6,\"BSC_SERVICE_SPIRIT\":8,\"BSC_EDUCATION_TOTAL\":73,\"ID\":\"51935889848270848\",\"BSC_COLLECTIVE\":4,\"BSC_VOLUNTEER_PROPORTION\":10.0,\"BSC_YEAR\":\"2017-2018\",\"BSC_EDUCATION_DEDUCTION\":14,\"BSC_ACADEMIC_RECORD\":92,\"BSC_BONUS_POINTS\":10,\"BSC_LABOR_ATTITUDE\":3,\"BSC_POLITICAL_ATTITUDE\":2,\"BSC_REMARKS\":\"15\",\"BSC_COMPLIANCE\":4,\"BSC_EDUCATION_SCORE\":21.90000152587890625,\"BS_NUMBER\":\"2018053106\",\"BSC_FULL_WORK\":9,\"BSC_SEMESTER\":2,\"BSC_PERSONAL_QUALITY\":7,\"BSC_EDUCATION_PROPORTION\":30.0,\"BSC_TOTAL\":85.7000026702880859375,\"BSC_CARE\":6,\"BSC_VOLUNTEER_SCORE\":8.6000003814697265625}', '2018-08-15 23:48:30', 1);
INSERT INTO `sys_value_record` VALUES ('51936239716139008', '1', 'BUS_STUDENT_COMPREHENSIVE', '51936239661613056', NULL, '{\"BS_ID\":\"51930103357112320\",\"BSC_INTELLECTUAL_PROPORTION\":60.0,\"BSC_VOLUNTEER_TOTAL\":86,\"BSC_INTELLECTUAL_SCORE\":55.200000762939453125,\"SVR_TABLE_NAME\":\"BUS_STUDENT_COMPREHENSIVE\",\"BSC_INTELLECTUAL_POINTS\":0,\"BSC_DECORUM\":6,\"BSC_SERVICE_SPIRIT\":8,\"BSC_EDUCATION_TOTAL\":45,\"ID\":\"51936239661613056\",\"BSC_COLLECTIVE\":4,\"BSC_VOLUNTEER_PROPORTION\":10.0,\"BSC_YEAR\":\"2017-2018\",\"BSC_EDUCATION_DEDUCTION\":14,\"BSC_ACADEMIC_RECORD\":92,\"BSC_BONUS_POINTS\":10,\"BSC_LABOR_ATTITUDE\":3,\"BSC_POLITICAL_ATTITUDE\":2,\"BSC_REMARKS\":\"15\",\"BSC_COMPLIANCE\":4,\"BSC_EDUCATION_SCORE\":13.5000019073486328125,\"BS_NUMBER\":\"2018053106\",\"BSC_FULL_WORK\":9,\"BSC_SEMESTER\":2,\"BSC_PERSONAL_QUALITY\":7,\"BSC_EDUCATION_PROPORTION\":30.0,\"BSC_TOTAL\":77.3000030517578125000,\"BSC_CARE\":6,\"BSC_VOLUNTEER_SCORE\":8.6000003814697265625}', '2018-08-15 23:49:53', 1);
INSERT INTO `sys_value_record` VALUES ('51936364106612736', '1', 'BUS_STUDENT_COMPREHENSIVE', '51936364043698176', NULL, '{\"BS_ID\":\"51930103357112320\",\"BSC_INTELLECTUAL_PROPORTION\":60.0,\"BSC_VOLUNTEER_TOTAL\":86,\"BSC_INTELLECTUAL_SCORE\":55.200000762939453125,\"SVR_TABLE_NAME\":\"BUS_STUDENT_COMPREHENSIVE\",\"BSC_INTELLECTUAL_POINTS\":0,\"BSC_DECORUM\":6,\"BSC_SERVICE_SPIRIT\":8,\"BSC_EDUCATION_TOTAL\":37,\"ID\":\"51936364043698176\",\"BSC_COLLECTIVE\":4,\"BSC_VOLUNTEER_PROPORTION\":10.0,\"BSC_YEAR\":\"2017-2018\",\"BSC_EDUCATION_DEDUCTION\":22,\"BSC_ACADEMIC_RECORD\":92,\"BSC_BONUS_POINTS\":10,\"BSC_LABOR_ATTITUDE\":3,\"BSC_POLITICAL_ATTITUDE\":2,\"BSC_REMARKS\":\"15\",\"BSC_COMPLIANCE\":4,\"BSC_EDUCATION_SCORE\":11.1000003814697265625,\"BS_NUMBER\":\"2018053106\",\"BSC_FULL_WORK\":9,\"BSC_SEMESTER\":2,\"BSC_PERSONAL_QUALITY\":7,\"BSC_EDUCATION_PROPORTION\":30.0,\"BSC_TOTAL\":74.9000015258789062500,\"BSC_CARE\":6,\"BSC_VOLUNTEER_SCORE\":8.6000003814697265625}', '2018-08-15 23:50:23', 1);
INSERT INTO `sys_value_record` VALUES ('51936808023359488', '1', 'BUS_AID_FINANCIALLY', '51936807884947456', NULL, '{\"BS_ID\":\"51930103357112320\",\"BUS_PROCESS\":\"100\",\"BAF_AID_TYPE\":\"SECOND-CLASS\",\"SVR_TABLE_NAME\":\"BUS_AID_FINANCIALLY\",\"SO_ID\":\"1\",\"BAF_TYPE\":\"9\",\"BAF_YEAR\":\"2017-2018\",\"BUS_PROCESS2\":\"109\",\"BAF_SEMESTER\":2,\"ID\":\"51936807884947456\",\"BAF_ENTRY_TIME\":\"2018-08-15 23:52:09\"}', '2018-08-15 23:52:09', 1);
INSERT INTO `sys_value_record` VALUES ('51936839400947712', '1', 'BUS_AID_FINANCIALLY', '51936807884947456', NULL, NULL, '2018-08-15 23:52:16', 3);
INSERT INTO `sys_value_record` VALUES ('52184552013037568', '1', 'SYS_MENU', '52184510715920384', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"1\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":40,\"SM_CODE\":\"LOG\",\"SM_NAME\":\"日志管理\",\"SM_PARENTID\":\"0\",\"ID\":\"52184510715920384\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-credit-card-multiple\",\"SM_IS_EXPAND\":\"\"}', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"1\",\"SM_TYPE\":\"1\",\"SM_ORDER\":\"999\",\"SM_CODE\":\"LOG\",\"SM_NAME\":\"日志管理\",\"SM_PARENTID\":\"0\",\"ID\":\"52184510715920384\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-credit-card-multiple\",\"SM_IS_EXPAND\":\"\"}', '2018-08-16 16:16:36', 2);
INSERT INTO `sys_value_record` VALUES ('52184860587982848', '1', 'SYS_MENU', '52184510715920384', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"1\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":999,\"SM_CODE\":\"LOG\",\"SM_NAME\":\"日志管理\",\"SM_PARENTID\":\"0\",\"ID\":\"52184510715920384\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-credit-card-multiple\",\"SM_IS_EXPAND\":\"\"}', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"1\",\"SM_TYPE\":\"1\",\"SM_ORDER\":\"999\",\"SM_CODE\":\"LOG\",\"SM_NAME\":\"日志管理\",\"SM_PARENTID\":\"0\",\"ID\":\"52184510715920384\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-note-multiple-outline\",\"SM_IS_EXPAND\":\"\"}', '2018-08-16 16:17:49', 2);
INSERT INTO `sys_value_record` VALUES ('52184999436222464', '1', 'SYS_MENU', '52184511034687488', '{\"BUS_PROCESS\":\"100\",\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"109\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":10,\"SM_CODE\":\"LOG:COLLEGE_SCHOLARSHIP\",\"SM_NAME\":\"学院奖学金\",\"SM_PARENTID\":\"52184510715920384\",\"ID\":\"52184511034687488\",\"SC_ID\":\"50831880232108032\",\"SM_CLASSICON\":\"mdi mdi-format-wrap-inline\",\"SM_IS_EXPAND\":\"\"}', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_TYPE\":\"1\",\"SM_ORDER\":\"10\",\"SM_CODE\":\"LOG:SYSTEM\",\"SM_NAME\":\"学院奖学金\",\"SM_PARENTID\":\"52184510715920384\",\"ID\":\"52184511034687488\",\"SC_ID\":\"50831880232108032\",\"SM_CLASSICON\":\"mdi mdi-format-wrap-inline\",\"SM_IS_EXPAND\":\"\"}', '2018-08-16 16:18:22', 2);
INSERT INTO `sys_value_record` VALUES ('52185031812055040', '1', 'SYS_MENU', '52184512292978688', NULL, NULL, '2018-08-16 16:18:30', 3);
INSERT INTO `sys_value_record` VALUES ('52185205510766592', '1', 'SYS_MENU', '52184511034687488', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":10,\"SM_CODE\":\"LOG:SYSTEM\",\"SM_NAME\":\"学院奖学金\",\"SM_PARENTID\":\"52184510715920384\",\"ID\":\"52184511034687488\",\"SC_ID\":\"50831880232108032\",\"SM_CLASSICON\":\"mdi mdi-format-wrap-inline\",\"SM_IS_EXPAND\":\"\"}', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_TYPE\":\"1\",\"SM_ORDER\":\"10\",\"SM_CODE\":\"LOG:SYSTEM\",\"SM_NAME\":\"系统日志\",\"SM_PARENTID\":\"52184510715920384\",\"ID\":\"52184511034687488\",\"SC_ID\":\"50831880232108032\",\"SM_CLASSICON\":\"mdi mdi-laptop-windows\",\"SM_IS_EXPAND\":\"\"}', '2018-08-16 16:19:11', 2);
INSERT INTO `sys_value_record` VALUES ('52185647842066432', '1', 'SYS_CONFIGURE_COLUMN', '52185395265273856', NULL, NULL, '2018-08-16 16:20:57', 3);
INSERT INTO `sys_value_record` VALUES ('52185656448778240', '1', 'SYS_CONFIGURE_COLUMN', '52185395231719424', NULL, NULL, '2018-08-16 16:20:59', 3);
INSERT INTO `sys_value_record` VALUES ('52185663172247552', '1', 'SYS_CONFIGURE_COLUMN', '52185394866814976', NULL, NULL, '2018-08-16 16:21:01', 3);
INSERT INTO `sys_value_record` VALUES ('52185670730383360', '1', 'SYS_CONFIGURE_COLUMN', '52185394527076352', NULL, NULL, '2018-08-16 16:21:02', 3);
INSERT INTO `sys_value_record` VALUES ('52185676933758976', '1', 'SYS_CONFIGURE_COLUMN', '52185394501910528', NULL, NULL, '2018-08-16 16:21:04', 3);
INSERT INTO `sys_value_record` VALUES ('52185683791446016', '1', 'SYS_CONFIGURE_COLUMN', '52185394204114944', NULL, NULL, '2018-08-16 16:21:05', 3);
INSERT INTO `sys_value_record` VALUES ('52185690070319104', '1', 'SYS_CONFIGURE_COLUMN', '52185394170560512', NULL, NULL, '2018-08-16 16:21:07', 3);
INSERT INTO `sys_value_record` VALUES ('52185697859141632', '1', 'SYS_CONFIGURE_COLUMN', '52185393990205440', NULL, NULL, '2018-08-16 16:21:09', 3);
INSERT INTO `sys_value_record` VALUES ('52185704372895744', '1', 'SYS_CONFIGURE_COLUMN', '52185393906319360', NULL, NULL, '2018-08-16 16:21:10', 3);
INSERT INTO `sys_value_record` VALUES ('52219816576024576', '1', 'SYS_CONFIGURE_SEARCH', '52219816479555584', NULL, '{\"SCS_METHOD_TYPE\":\"4\",\"SCS_TYPE\":\"1\",\"SCS_FIELD\":\"BS_NAME\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_SEARCH\",\"SCS_NAME\":\"学生\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"52219816479555584\",\"SC_ID\":\"50831880232108032\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":\"10\"}', '2018-08-16 18:36:43', 1);
INSERT INTO `sys_value_record` VALUES ('52219899556134912', '1', 'SYS_CONFIGURE_SEARCH', '52219899509997568', NULL, '{\"SCS_METHOD_TYPE\":\"1\",\"SCS_TYPE\":\"4\",\"SCS_FIELD\":\"BAF_YEAR\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_SEARCH\",\"SCS_NAME\":\"学年\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"52219899509997568\",\"SC_ID\":\"50831880232108032\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":\"20\"}', '2018-08-16 18:37:03', 1);
INSERT INTO `sys_value_record` VALUES ('52219984469819392', '1', 'SYS_CONFIGURE_SEARCH', '52219984423682048', NULL, '{\"SCS_METHOD_TYPE\":\"1\",\"SCS_TYPE\":\"2\",\"SCS_FIELD\":\"BAF_SEMESTER\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_SEARCH\",\"SCS_NAME\":\"学期\",\"SCS_SDT_CODE\":\"BUS_SEMESTER\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"52219984423682048\",\"SC_ID\":\"50831880232108032\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":\"30\"}', '2018-08-16 18:37:23', 1);
INSERT INTO `sys_value_record` VALUES ('52220169711255552', '1', 'SYS_CONFIGURE_SEARCH', '52220169669312512', NULL, '{\"SCS_METHOD_TYPE\":\"1\",\"SCS_TYPE\":\"2\",\"SCS_FIELD\":\"BAF_AID_TYPE\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_SEARCH\",\"SCS_NAME\":\"奖励类型\",\"SCS_SDT_CODE\":\"BUS_COLLEGE_SCHOLARSHIP_TYPE\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"52220169669312512\",\"SC_ID\":\"50831880232108032\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":\"40\"}', '2018-08-16 18:38:08', 1);
INSERT INTO `sys_value_record` VALUES ('52227996894887936', '1', 'SYS_CONFIGURE_COLUMN', '52227996769058816', NULL, '{\"SCC_NAME\":\"操作员\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"SAI_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"52227996769058816\",\"SC_ID\":\"52185393809850368\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"10\"}', '2018-08-16 19:09:14', 1);
INSERT INTO `sys_value_record` VALUES ('52228093556817920', '1', 'SYS_CONFIGURE_COLUMN', '52228093506486272', NULL, '{\"SCC_NAME\":\"IP地址\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"SL_IP\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"52228093506486272\",\"SC_ID\":\"52185393809850368\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"20\"}', '2018-08-16 19:09:37', 1);
INSERT INTO `sys_value_record` VALUES ('52228151861837824', '1', 'SYS_CONFIGURE_COLUMN', '52228151819894784', NULL, '{\"SCC_NAME\":\"事件\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"SL_EVENT\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"52228151819894784\",\"SC_ID\":\"52185393809850368\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"5\"}', '2018-08-16 19:09:51', 1);
INSERT INTO `sys_value_record` VALUES ('52228262218170368', '1', 'SYS_CONFIGURE_COLUMN', '52228262180421632', NULL, '{\"SCC_NAME\":\"时间\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"150px\",\"SCC_FIELD\":\"SL_ENTERTIME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"52228262180421632\",\"SC_ID\":\"52185393809850368\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"30\"}', '2018-08-16 19:10:17', 1);
INSERT INTO `sys_value_record` VALUES ('52228391536951296', '1', 'SYS_CONFIGURE_COLUMN', '52228391499202560', NULL, '{\"SCC_NAME\":\"内容\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"300px\",\"SCC_FIELD\":\"SLT_CONTENT\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"52228391499202560\",\"SC_ID\":\"52185393809850368\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"40\"}', '2018-08-16 19:10:48', 1);
INSERT INTO `sys_value_record` VALUES ('52228826993786880', '1', 'SYS_CONFIGURE_COLUMN', '52228826968621056', NULL, '{\"SCC_NAME\":\"结果\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"70px\",\"SCC_FIELD\":\"SL_RESULT\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"52228826968621056\",\"SC_ID\":\"52185393809850368\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"SYS_SUCCESS_FAIL\",\"SCC_ORDER\":\"50\"}', '2018-08-16 19:12:32', 1);
INSERT INTO `sys_value_record` VALUES ('52228903875379200', '1', 'SYS_CONFIGURE_SEARCH', '52228903812464640', NULL, '{\"SCS_METHOD_TYPE\":\"4\",\"SCS_TYPE\":\"1\",\"SCS_FIELD\":\"SAI_NAME\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_SEARCH\",\"SCS_NAME\":\"操作员\",\"SCS_IS_STUDENT_YEAR\":\"1\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"52228903812464640\",\"SC_ID\":\"52185393809850368\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":\"10\"}', '2018-08-16 19:12:50', 1);
INSERT INTO `sys_value_record` VALUES ('52229086759616512', '1', 'SYS_CONFIGURE_SEARCH', '52229086726062080', NULL, '{\"SCS_METHOD_TYPE\":\"4\",\"SCS_TYPE\":\"1\",\"SCS_FIELD\":\"SL_EVENT\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_SEARCH\",\"SCS_NAME\":\"事件\",\"SCS_IS_STUDENT_YEAR\":\"1\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"52229086726062080\",\"SC_ID\":\"52185393809850368\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":\"5\"}', '2018-08-16 19:13:34', 1);
INSERT INTO `sys_value_record` VALUES ('52229127595360256', '1', 'SYS_CONFIGURE_SEARCH', '52229127566000128', NULL, '{\"SCS_METHOD_TYPE\":\"4\",\"SCS_TYPE\":\"1\",\"SCS_FIELD\":\"SL_IP\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_SEARCH\",\"SCS_NAME\":\"IP\",\"SCS_IS_STUDENT_YEAR\":\"1\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"52229127566000128\",\"SC_ID\":\"52185393809850368\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":\"20\"}', '2018-08-16 19:13:43', 1);
INSERT INTO `sys_value_record` VALUES ('52229287910047744', '1', 'SYS_CONFIGURE_SEARCH', '52229287880687616', NULL, '{\"SCS_METHOD_TYPE\":\"8\",\"SCS_TYPE\":\"1\",\"SCS_FIELD\":\"SL_ENTERTIME\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_SEARCH\",\"SCS_NAME\":\"开始时间\",\"SCS_IS_STUDENT_YEAR\":\"1\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"52229287880687616\",\"SC_ID\":\"52185393809850368\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":\"30\"}', '2018-08-16 19:14:22', 1);
INSERT INTO `sys_value_record` VALUES ('52229361440391168', '1', 'SYS_CONFIGURE_SEARCH', '52229361411031040', NULL, '{\"SCS_METHOD_TYPE\":\"6\",\"SCS_TYPE\":\"6\",\"SCS_FIELD\":\"SL_ENTERTIME\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_SEARCH\",\"SCS_NAME\":\"结束时间\",\"SCS_IS_STUDENT_YEAR\":\"1\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"52229361411031040\",\"SC_ID\":\"52185393809850368\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":\"40\"}', '2018-08-16 19:14:39', 1);
INSERT INTO `sys_value_record` VALUES ('52229377039007744', '1', 'SYS_CONFIGURE_SEARCH', '52229287880687616', '{\"SCS_METHOD_TYPE\":\"8\",\"SCS_TYPE\":\"1\",\"SCS_FIELD\":\"SL_ENTERTIME\",\"SCS_NAME\":\"开始时间\",\"SCS_IS_STUDENT_YEAR\":\"1\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"52229287880687616\",\"SC_ID\":\"52185393809850368\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":30}', '{\"SCS_FIELD\":\"SL_ENTERTIME\",\"SCS_NAME\":\"开始时间\",\"SCS_IS_STUDENT_YEAR\":\"1\",\"SCS_SDT_CODE\":\"\",\"SCS_ORDER\":\"30\",\"SCS_METHOD_TYPE\":\"8\",\"SCS_TYPE\":\"6\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"52229287880687616\",\"SC_ID\":\"52185393809850368\",\"SCS_REMARK\":\"\"}', '2018-08-16 19:14:43', 2);
INSERT INTO `sys_value_record` VALUES ('52229475219275776', '1', 'SYS_CONFIGURE_SEARCH', '52229475181527040', NULL, '{\"SCS_METHOD_TYPE\":\"1\",\"SCS_TYPE\":\"2\",\"SCS_FIELD\":\"SL_RESULT\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_SEARCH\",\"SCS_NAME\":\"结果\",\"SCS_IS_STUDENT_YEAR\":\"1\",\"SCS_SDT_CODE\":\"SYS_SUCCESS_FAIL\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"52229475181527040\",\"SC_ID\":\"52185393809850368\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":\"50\"}', '2018-08-16 19:15:06', 1);
INSERT INTO `sys_value_record` VALUES ('52229765339283456', '1', 'SYS_DICT_INFO', '52229765242814464', NULL, '{\"SDI_CODE\":\"1\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"1\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"成功\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"SYS_SUCCESS_FAIL\",\"SDI_INNERCODE\":\"1\",\"ID\":\"52229765242814464\",\"SDT_ID\":\"10\"}', '2018-08-16 19:16:15', 1);
INSERT INTO `sys_value_record` VALUES ('52229795576020992', '1', 'SYS_DICT_INFO', '52229795525689344', NULL, '{\"SDI_CODE\":\"0\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"2\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"失败\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"SYS_SUCCESS_FAIL\",\"SDI_INNERCODE\":\"0\",\"ID\":\"52229795525689344\",\"SDT_ID\":\"10\"}', '2018-08-16 19:16:23', 1);
INSERT INTO `sys_value_record` VALUES ('52230167547871232', '1', 'SYS_MENU', '52184511034687488', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":10,\"SM_CODE\":\"LOG:SYSTEM\",\"SM_NAME\":\"系统日志\",\"SM_PARENTID\":\"52184510715920384\",\"ID\":\"52184511034687488\",\"SC_ID\":\"50831880232108032\",\"SM_CLASSICON\":\"mdi mdi-laptop-windows\",\"SM_IS_EXPAND\":\"\"}', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_TYPE\":\"1\",\"SM_ORDER\":\"10\",\"SM_CODE\":\"LOG:SYSTEM\",\"SM_NAME\":\"系统日志\",\"SM_PARENTID\":\"52184510715920384\",\"ID\":\"52184511034687488\",\"SC_ID\":\"52185393809850368\",\"SM_CLASSICON\":\"mdi mdi-laptop-windows\",\"SM_IS_EXPAND\":\"\"}', '2018-08-16 19:17:51', 2);
INSERT INTO `sys_value_record` VALUES ('52233079657332736', '1', 'SYS_CONFIGURE', '52185393809850368', '{\"SC_IS_PAGING\":\"1\",\"SC_NAME\":\"日志管理-系统日志\",\"SC_JSP\":\"admin/log/system/home\",\"SC_VIEW\":\"v_log_system\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"52185393809850368\",\"SC_ORDER_BY\":\"BAF_YEAR DESC,BAF_SEMESTER DESC,CONVERT(ID,SIGNED) DESC\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '{\"SC_NAME\":\"日志管理-系统日志\",\"SC_JSP\":\"admin/log/system/home\",\"SC_VIEW\":\"v_log_system\",\"SC_ORDER_BY\":\"SL_ENTERTIME DESC\",\"SC_IS_PAGING\":\"1\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"52185393809850368\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '2018-08-16 19:29:26', 2);
INSERT INTO `sys_value_record` VALUES ('52233196674220032', '1', 'SYS_CONFIGURE_COLUMN', '52227996769058816', '{\"SCC_NAME\":\"操作员\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"SAI_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"52227996769058816\",\"SC_ID\":\"52185393809850368\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":10}', '{\"SCC_NAME\":\"操作员\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"120px\",\"SCC_FIELD\":\"SAI_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"52227996769058816\",\"SC_ID\":\"52185393809850368\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"10\"}', '2018-08-16 19:29:53', 2);
INSERT INTO `sys_value_record` VALUES ('52233418439655424', '1', 'SYS_CONFIGURE_SEARCH', '52229361411031040', '{\"SCS_METHOD_TYPE\":\"6\",\"SCS_TYPE\":\"6\",\"SCS_FIELD\":\"SL_ENTERTIME\",\"SCS_NAME\":\"结束时间\",\"SCS_IS_STUDENT_YEAR\":\"1\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"52229361411031040\",\"SC_ID\":\"52185393809850368\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":40}', '{\"SCS_FIELD\":\"SL_ENTERTIME\",\"SCS_NAME\":\"结束时间\",\"SCS_IS_STUDENT_YEAR\":\"1\",\"SCS_SDT_CODE\":\"\",\"SCS_ORDER\":\"40\",\"SCS_METHOD_TYPE\":\"6\",\"SCS_TYPE\":\"6\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"52229361411031040\",\"SC_ID\":\"52185393809850368\",\"SCS_REMARK\":\"\"}', '2018-08-16 19:30:46', 2);
INSERT INTO `sys_value_record` VALUES ('52234086726500352', '1', 'SYS_CONFIGURE_SEARCH', '52229361411031040', '{\"SCS_METHOD_TYPE\":\"6\",\"SCS_TYPE\":\"6\",\"SCS_FIELD\":\"SL_ENTERTIME\",\"SCS_NAME\":\"结束时间\",\"SCS_IS_STUDENT_YEAR\":\"1\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"52229361411031040\",\"SC_ID\":\"52185393809850368\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":40}', '{\"SCS_FIELD\":\"SL_ENDTIME\",\"SCS_NAME\":\"结束时间\",\"SCS_IS_STUDENT_YEAR\":\"1\",\"SCS_SDT_CODE\":\"\",\"SCS_ORDER\":\"40\",\"SCS_METHOD_TYPE\":\"6\",\"SCS_TYPE\":\"6\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"52229361411031040\",\"SC_ID\":\"52185393809850368\",\"SCS_REMARK\":\"\"}', '2018-08-16 19:33:26', 2);
INSERT INTO `sys_value_record` VALUES ('52234972089548800', '1', 'SYS_CONFIGURE_SEARCH', '52229361411031040', '{\"SCS_METHOD_TYPE\":\"6\",\"SCS_TYPE\":\"6\",\"SCS_FIELD\":\"SL_ENDTIME\",\"SCS_NAME\":\"结束时间\",\"SCS_IS_STUDENT_YEAR\":\"1\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"52229361411031040\",\"SC_ID\":\"52185393809850368\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":40}', '{\"SCS_FIELD\":\"SL_ENTERTIME\",\"SCS_NAME\":\"结束时间\",\"SCS_IS_STUDENT_YEAR\":\"1\",\"SCS_SDT_CODE\":\"\",\"SCS_ORDER\":\"40\",\"SCS_METHOD_TYPE\":\"6\",\"SCS_TYPE\":\"6\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"52229361411031040\",\"SC_ID\":\"52185393809850368\",\"SCS_REMARK\":\"\"}', '2018-08-16 19:36:57', 2);
INSERT INTO `sys_value_record` VALUES ('52235427867787264', '1', 'SYS_CONFIGURE_SEARCH', '52229361411031040', '{\"SCS_METHOD_TYPE\":\"6\",\"SCS_TYPE\":\"6\",\"SCS_FIELD\":\"SL_ENTERTIME\",\"SCS_NAME\":\"结束时间\",\"SCS_IS_STUDENT_YEAR\":\"1\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"52229361411031040\",\"SC_ID\":\"52185393809850368\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":40}', '{\"SCS_FIELD\":\"SL_ENDTIME\",\"SCS_NAME\":\"结束时间\",\"SCS_IS_STUDENT_YEAR\":\"1\",\"SCS_SDT_CODE\":\"\",\"SCS_ORDER\":\"40\",\"SCS_METHOD_TYPE\":\"6\",\"SCS_TYPE\":\"6\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"52229361411031040\",\"SC_ID\":\"52185393809850368\",\"SCS_REMARK\":\"\"}', '2018-08-16 19:38:45', 2);
INSERT INTO `sys_value_record` VALUES ('52236174135132160', '1', 'SYS_MENU', '52235853056966656', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":10,\"SM_CODE\":\"LOG:USE\",\"SM_NAME\":\"系统日志\",\"SM_PARENTID\":\"52184510715920384\",\"ID\":\"52235853056966656\",\"SC_ID\":\"52185393809850368\",\"SM_CLASSICON\":\"mdi mdi-laptop-windows\",\"SM_IS_EXPAND\":\"\"}', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_TYPE\":\"1\",\"SM_ORDER\":\"20\",\"SM_CODE\":\"LOG:USE\",\"SM_NAME\":\"操作日志\",\"SM_PARENTID\":\"52184510715920384\",\"ID\":\"52235853056966656\",\"SC_ID\":\"52235707715944448\",\"SM_CLASSICON\":\"mdi mdi-developer-board\",\"SM_IS_EXPAND\":\"\"}', '2018-08-16 19:41:43', 2);
INSERT INTO `sys_value_record` VALUES ('52236252149186560', '1', 'SYS_MENU', '52235902763663360', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":10,\"SM_CODE\":\"LOG:PERSONAL\",\"SM_NAME\":\"系统日志\",\"SM_PARENTID\":\"52184510715920384\",\"ID\":\"52235902763663360\",\"SC_ID\":\"52185393809850368\",\"SM_CLASSICON\":\"mdi mdi-laptop-windows\",\"SM_IS_EXPAND\":\"\"}', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_TYPE\":\"1\",\"SM_ORDER\":\"30\",\"SM_CODE\":\"LOG:PERSONAL\",\"SM_NAME\":\"登录日志\",\"SM_PARENTID\":\"52184510715920384\",\"ID\":\"52235902763663360\",\"SC_ID\":\"52235788951224320\",\"SM_CLASSICON\":\"mdi mdi-login\",\"SM_IS_EXPAND\":\"\"}', '2018-08-16 19:42:02', 2);
INSERT INTO `sys_value_record` VALUES ('52236421510987776', '1', 'SYS_CONFIGURE', '52185393809850368', '{\"SC_IS_PAGING\":\"1\",\"SC_NAME\":\"日志管理-系统日志\",\"SC_JSP\":\"admin/log/system/home\",\"SC_VIEW\":\"v_log_system\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"52185393809850368\",\"SC_ORDER_BY\":\"SL_ENTERTIME DESC\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '{\"SC_NAME\":\"日志管理-系统日志\",\"SC_JSP\":\"admin/log/system/home\",\"SC_VIEW\":\"v_log_system\",\"SC_ORDER_BY\":\"SL_ENTERTIME DESC\",\"SC_IS_PAGING\":\"1\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"52185393809850368\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"1\"}', '2018-08-16 19:42:42', 2);
INSERT INTO `sys_value_record` VALUES ('52236441341657088', '1', 'SYS_CONFIGURE', '52235707715944448', '{\"SC_IS_PAGING\":\"1\",\"SC_NAME\":\"日志管理-操作日志\",\"SC_JSP\":\"admin/log/use/home\",\"SC_VIEW\":\"v_log_use\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"52235707715944448\",\"SC_ORDER_BY\":\"SL_ENTERTIME DESC\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '{\"SC_NAME\":\"日志管理-操作日志\",\"SC_JSP\":\"admin/log/use/home\",\"SC_VIEW\":\"v_log_use\",\"SC_ORDER_BY\":\"SL_ENTERTIME DESC\",\"SC_IS_PAGING\":\"1\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"52235707715944448\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"1\"}', '2018-08-16 19:42:47', 2);
INSERT INTO `sys_value_record` VALUES ('52236454343999488', '1', 'SYS_CONFIGURE', '52235788951224320', '{\"SC_IS_PAGING\":\"1\",\"SC_NAME\":\"日志管理-登录日志\",\"SC_JSP\":\"admin/log/personal/home\",\"SC_VIEW\":\"v_log_personal\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"52235788951224320\",\"SC_ORDER_BY\":\"SL_ENTERTIME DESC\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '{\"SC_NAME\":\"日志管理-登录日志\",\"SC_JSP\":\"admin/log/personal/home\",\"SC_VIEW\":\"v_log_personal\",\"SC_ORDER_BY\":\"SL_ENTERTIME DESC\",\"SC_IS_PAGING\":\"1\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"52235788951224320\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"1\"}', '2018-08-16 19:42:50', 2);
INSERT INTO `sys_value_record` VALUES ('52237770101358592', '1', 'SYS_CONFIGURE', '52235788951224320', '{\"SC_IS_PAGING\":\"1\",\"SC_NAME\":\"日志管理-登录日志\",\"SC_JSP\":\"admin/log/personal/home\",\"SC_VIEW\":\"v_log_personal\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"52235788951224320\",\"SC_ORDER_BY\":\"SL_ENTERTIME DESC\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"1\"}', '{\"SC_NAME\":\"日志管理-登录日志\",\"SC_JSP\":\"admin/log/personal/home\",\"SC_VIEW\":\"v_log_personal\",\"SC_ORDER_BY\":\"SL_ENTERTIME DESC1\",\"SC_IS_PAGING\":\"1\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"52235788951224320\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"1\"}', '2018-08-16 19:48:04', 2);
INSERT INTO `sys_value_record` VALUES ('52238843969011712', '1', 'SYS_CONFIGURE', '52235788951224320', '{\"SC_IS_PAGING\":\"1\",\"SC_NAME\":\"日志管理-登录日志\",\"SC_JSP\":\"admin/log/personal/home\",\"SC_VIEW\":\"v_log_personal\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"52235788951224320\",\"SC_ORDER_BY\":\"SL_ENTERTIME DESC1\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"1\"}', '{\"SC_NAME\":\"日志管理-登录日志\",\"SC_JSP\":\"admin/log/personal/home\",\"SC_VIEW\":\"v_log_personal\",\"SC_ORDER_BY\":\"SL_ENTERTIME DESC\",\"SC_IS_PAGING\":\"1\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"52235788951224320\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"1\"}', '2018-08-16 19:52:20', 2);
INSERT INTO `sys_value_record` VALUES ('52259177296297984', '1', 'SYS_MENU', '52259024812376064', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":30,\"SM_CODE\":\"LOG:SEE\",\"SM_NAME\":\"查看日志\",\"SM_PARENTID\":\"52184510715920384\",\"ID\":\"52259024812376064\",\"SC_ID\":\"52235788951224320\",\"SM_CLASSICON\":\"mdi mdi-login\",\"SM_IS_EXPAND\":\"\"}', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"0\",\"SM_TYPE\":\"1\",\"SM_ORDER\":\"40\",\"SM_CODE\":\"LOG:SEE\",\"SM_NAME\":\"查看日志\",\"SM_PARENTID\":\"52184510715920384\",\"ID\":\"52259024812376064\",\"SC_ID\":\"52258927902982144\",\"SM_CLASSICON\":\"mdi mdi-eye\",\"SM_IS_EXPAND\":\"\"}', '2018-08-16 21:13:08', 2);
INSERT INTO `sys_value_record` VALUES ('52291507058638848', '1', 'SYS_DICT_TYPE', '52291506974752768', NULL, '{\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"SYS_DICT_TYPE\",\"SDT_CODE\":\"BUS_COMMEND_TYPE\",\"SDT_ROLE_DEL\":\"\",\"SDT_NAME\":\"业务_年度表彰\",\"ID\":\"52291506974752768\",\"SDT_ROLE_DOWN\":\"\"}', '2018-08-16 23:21:36', 1);
INSERT INTO `sys_value_record` VALUES ('52291552118046720', '1', 'SYS_DICT_TYPE', '52291506974752768', '{\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_COMMEND_TYPE\",\"SDT_NAME\":\"业务_年度表彰\",\"ID\":\"52291506974752768\"}', '{\"SDT_CODE\":\"BUS_COMMEND_TYPE\",\"SDT_ROLE_DEL\":\"\",\"SDT_NAME\":\"业务_年度表彰类型\",\"ID\":\"52291506974752768\",\"SDT_ROLE_DOWN\":\"\"}', '2018-08-16 23:21:46', 2);
INSERT INTO `sys_value_record` VALUES ('52291671613767680', '1', 'SYS_DICT_INFO', '52291671479549952', NULL, '{\"SDI_CODE\":\"THREE_GOOD_STUDENTS\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"1\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"三好学生\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_COMMEND_TYPE\",\"SDI_INNERCODE\":\"THREE_GOOD_STUDENTS\",\"ID\":\"52291671479549952\",\"SDT_ID\":\"52291506974752768\"}', '2018-08-16 23:22:15', 1);
INSERT INTO `sys_value_record` VALUES ('52291791101100032', '1', 'SYS_DICT_INFO', '52291791042379776', NULL, '{\"SDI_CODE\":\"OUTSTANDING_STUDENT_CADRES\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"2\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"优秀学生干部\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"BUS_COMMEND_TYPE\",\"SDI_INNERCODE\":\"OUTSTANDING_STUDENT_CADRES\",\"ID\":\"52291791042379776\",\"SDT_ID\":\"52291506974752768\"}', '2018-08-16 23:22:43', 1);
INSERT INTO `sys_value_record` VALUES ('52292674094366720', '1', 'SYS_CONFIGURE', '50831880232108032', '{\"SC_IS_PAGING\":\"1\",\"SC_NAME\":\"资助管理-学院奖学金\",\"SC_JSP\":\"admin/aid/collegeScholarship/home\",\"SC_VIEW\":\"v_college_scholarship\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"50831880232108032\",\"SC_ORDER_BY\":\"BAF_YEAR DESC,BAF_SEMESTER DESC,CONVERT(ID,SIGNED) DESC\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '{\"SC_NAME\":\"资助管理-学院奖学金\",\"SC_JSP\":\"admin/aid/collegeScholarship/home\",\"SC_VIEW\":\"v_aid_college_scholarship\",\"SC_ORDER_BY\":\"BAF_YEAR DESC,BAF_SEMESTER DESC,CONVERT(ID,SIGNED) DESC\",\"SC_IS_PAGING\":\"1\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"50831880232108032\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '2018-08-16 23:26:14', 2);
INSERT INTO `sys_value_record` VALUES ('52292915694665728', '1', 'SYS_CONFIGURE', '52292620512133120', '{\"SC_IS_PAGING\":\"1\",\"SC_NAME\":\"资助管理-年度表彰\",\"SC_JSP\":\"admin/aid/collegeScholarship/home\",\"SC_VIEW\":\"v_college_scholarship\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"52292620512133120\",\"SC_ORDER_BY\":\"BAF_YEAR DESC,BAF_SEMESTER DESC,CONVERT(ID,SIGNED) DESC\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '{\"SC_NAME\":\"资助管理-年度表彰\",\"SC_JSP\":\"admin/aid/commend/home\",\"SC_VIEW\":\"v_aid_commend\",\"SC_ORDER_BY\":\"BAF_YEAR DESC,BAF_SEMESTER DESC,CONVERT(ID,SIGNED) DESC\",\"SC_IS_PAGING\":\"1\",\"SC_IS_SEARCH\":\"1\",\"SC_IS_SELECT\":\"\",\"ID\":\"52292620512133120\",\"SC_IS_SINGLE\":\"\",\"SC_IS_FILTER\":\"\"}', '2018-08-16 23:27:12', 2);
INSERT INTO `sys_value_record` VALUES ('52293399037870080', '1', 'SYS_CONFIGURE_COLUMN', '52293398979149824', NULL, '{\"SCC_NAME\":\"奖项\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"BAF_AID_TYPE\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"52293398979149824\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"BUS_COLLEGE_SCHOLARSHIP_TYPE\",\"SCC_ORDER\":\"72\"}', '2018-08-16 23:29:07', 1);
INSERT INTO `sys_value_record` VALUES ('52293587144015872', '1', 'SYS_CONFIGURE_COLUMN', '50833943762567168', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"240px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"50833943762567168\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":80}', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"200px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"50833943762567168\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"80\"}', '2018-08-16 23:29:52', 2);
INSERT INTO `sys_value_record` VALUES ('52293647885926400', '1', 'SYS_CONFIGURE_COLUMN', '50833638492733440', '{\"SCC_NAME\":\"综合测评\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"70px\",\"SCC_FIELD\":\"BSC_TOTAL\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50833638492733440\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":40}', '{\"SCC_NAME\":\"综合测评\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"60px\",\"SCC_FIELD\":\"BSC_TOTAL\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50833638492733440\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"40\"}', '2018-08-16 23:30:06', 2);
INSERT INTO `sys_value_record` VALUES ('52293666202451968', '1', 'SYS_CONFIGURE_COLUMN', '50833705790341120', '{\"SCC_NAME\":\"测评排名\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"70px\",\"SCC_FIELD\":\"BSC_RANK\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50833705790341120\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":50}', '{\"SCC_NAME\":\"测评排名\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"60px\",\"SCC_FIELD\":\"BSC_RANK\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50833705790341120\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"50\"}', '2018-08-16 23:30:11', 2);
INSERT INTO `sys_value_record` VALUES ('52293682019172352', '1', 'SYS_CONFIGURE_COLUMN', '50833777835900928', '{\"SCC_NAME\":\"学习成绩\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"70px\",\"SCC_FIELD\":\"BSC_ACADEMIC_RECORD\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50833777835900928\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":60}', '{\"SCC_NAME\":\"学习成绩\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"60px\",\"SCC_FIELD\":\"BSC_ACADEMIC_RECORD\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50833777835900928\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"60\"}', '2018-08-16 23:30:14', 2);
INSERT INTO `sys_value_record` VALUES ('52293697064140800', '1', 'SYS_CONFIGURE_COLUMN', '50833829203542016', '{\"SCC_NAME\":\"学习排名\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"70px\",\"SCC_FIELD\":\"BSC_INTELLECTUAL_RANK\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50833829203542016\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":70}', '{\"SCC_NAME\":\"学习排名\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"60px\",\"SCC_FIELD\":\"BSC_INTELLECTUAL_RANK\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50833829203542016\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"70\"}', '2018-08-16 23:30:18', 2);
INSERT INTO `sys_value_record` VALUES ('52293722880081920', '1', 'SYS_CONFIGURE_COLUMN', '52293398979149824', '{\"SCC_NAME\":\"奖项\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"BAF_AID_TYPE\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"52293398979149824\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"BUS_COLLEGE_SCHOLARSHIP_TYPE\",\"SCC_ORDER\":72}', '{\"SCC_NAME\":\"奖项\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"80px\",\"SCC_FIELD\":\"BAF_AID_TYPE\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"52293398979149824\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"BUS_COLLEGE_SCHOLARSHIP_TYPE\",\"SCC_ORDER\":\"72\"}', '2018-08-16 23:30:24', 2);
INSERT INTO `sys_value_record` VALUES ('52293787929542656', '1', 'SYS_CONFIGURE_COLUMN', '50833440131514368', '{\"SCC_NAME\":\"学号\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"BS_NUMBER\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50833440131514368\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":20}', '{\"SCC_NAME\":\"学号\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"90px\",\"SCC_FIELD\":\"BS_NUMBER\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50833440131514368\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"20\"}', '2018-08-16 23:30:40', 2);
INSERT INTO `sys_value_record` VALUES ('52293842178670592', '1', 'SYS_CONFIGURE_COLUMN', '50847196098068480', '{\"SCC_NAME\":\"审核状态\",\"SCC_FUNC\":\"processLogFunc(targets, field);\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"PROCESS_STATUS_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50847196098068480\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":75}', '{\"SCC_NAME\":\"审核状态\",\"SCC_FUNC\":\"processLogFunc(targets, field);\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"90px\",\"SCC_FIELD\":\"PROCESS_STATUS_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50847196098068480\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"75\"}', '2018-08-16 23:30:52', 2);
INSERT INTO `sys_value_record` VALUES ('52293868460179456', '1', 'SYS_CONFIGURE_COLUMN', '50847196098068480', '{\"SCC_NAME\":\"审核状态\",\"SCC_FUNC\":\"processLogFunc(targets, field);\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"90px\",\"SCC_FIELD\":\"PROCESS_STATUS_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50847196098068480\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":75}', '{\"SCC_NAME\":\"审核状态\",\"SCC_FUNC\":\"processLogFunc(targets, field);\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"PROCESS_STATUS_NAME\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50847196098068480\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"75\"}', '2018-08-16 23:30:59', 2);
INSERT INTO `sys_value_record` VALUES ('52293887133220864', '1', 'SYS_CONFIGURE_COLUMN', '50833943762567168', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"200px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"50833943762567168\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":80}', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"190px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"50833943762567168\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"80\"}', '2018-08-16 23:31:03', 2);
INSERT INTO `sys_value_record` VALUES ('52293968007790592', '1', 'SYS_CONFIGURE', '52292620512133120', NULL, NULL, '2018-08-16 23:31:22', 3);
INSERT INTO `sys_value_record` VALUES ('52294130805506048', '1', 'SYS_CONFIGURE_COLUMN', '52294048001556480', '{\"SCC_NAME\":\"奖项\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"80px\",\"SCC_FIELD\":\"BAF_AID_TYPE\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"52294048001556480\",\"SC_ID\":\"52294046697127936\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"BUS_COLLEGE_SCHOLARSHIP_TYPE\",\"SCC_ORDER\":72}', '{\"SCC_NAME\":\"奖项\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"80px\",\"SCC_FIELD\":\"BAF_AID_TYPE\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"52294048001556480\",\"SC_ID\":\"52294046697127936\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"BUS_COMMEND_TYPE\",\"SCC_ORDER\":\"72\"}', '2018-08-16 23:32:01', 2);
INSERT INTO `sys_value_record` VALUES ('52294173222502400', '1', 'SYS_CONFIGURE_SEARCH', '52294049444397056', '{\"SCS_METHOD_TYPE\":\"1\",\"SCS_TYPE\":\"2\",\"SCS_FIELD\":\"BAF_AID_TYPE\",\"SCS_NAME\":\"奖励类型\",\"SCS_IS_STUDENT_YEAR\":\"1\",\"SCS_SDT_CODE\":\"BUS_COLLEGE_SCHOLARSHIP_TYPE\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"52294049444397056\",\"SC_ID\":\"52294046697127936\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":40}', '{\"SCS_FIELD\":\"BAF_AID_TYPE\",\"SCS_NAME\":\"奖励类型\",\"SCS_IS_STUDENT_YEAR\":\"1\",\"SCS_SDT_CODE\":\"BUS_COMMEND_TYPE\",\"SCS_ORDER\":\"40\",\"SCS_METHOD_TYPE\":\"1\",\"SCS_TYPE\":\"2\",\"SCC_IS_VISIBLE\":\"1\",\"ID\":\"52294049444397056\",\"SC_ID\":\"52294046697127936\",\"SCS_REMARK\":\"\"}', '2018-08-16 23:32:11', 2);
INSERT INTO `sys_value_record` VALUES ('52294433344847872', '1', 'SYS_MENU', '52294280579907584', '{\"BUS_PROCESS\":\"100\",\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"109\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":10,\"SM_CODE\":\"AID:COMMEND\",\"SM_NAME\":\"年度表彰\",\"SM_PARENTID\":\"50751117243449344\",\"ID\":\"52294280579907584\",\"SC_ID\":\"50831880232108032\",\"SM_CLASSICON\":\"mdi mdi-format-wrap-inline\",\"SM_IS_EXPAND\":\"\"}', '{\"BUS_PROCESS\":\"100\",\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"109\",\"SM_IS_LEAF\":\"0\",\"SM_TYPE\":\"1\",\"SM_ORDER\":\"20\",\"SM_CODE\":\"AID:COMMEND\",\"SM_NAME\":\"年度表彰\",\"SM_PARENTID\":\"50751117243449344\",\"ID\":\"52294280579907584\",\"SC_ID\":\"52294046697127936\",\"SM_CLASSICON\":\"mdi mdi-comment-check\",\"SM_IS_EXPAND\":\"\"}', '2018-08-16 23:33:13', 2);
INSERT INTO `sys_value_record` VALUES ('52297607824801792', '1', 'SYS_MENU', '52294280579907584', '{\"BUS_PROCESS\":\"100\",\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"109\",\"SM_IS_LEAF\":\"0\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":20,\"SM_CODE\":\"AID:COMMEND\",\"SM_NAME\":\"年度表彰\",\"SM_PARENTID\":\"50751117243449344\",\"ID\":\"52294280579907584\",\"SC_ID\":\"52294046697127936\",\"SM_CLASSICON\":\"mdi mdi-comment-check\",\"SM_IS_EXPAND\":\"\"}', '{\"BUS_PROCESS\":\"100\",\"SM_URL\":\"admin/dataGrid/\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"110\",\"SM_IS_LEAF\":\"0\",\"SM_TYPE\":\"1\",\"SM_ORDER\":\"20\",\"SM_CODE\":\"AID:COMMEND\",\"SM_NAME\":\"年度表彰\",\"SM_PARENTID\":\"50751117243449344\",\"ID\":\"52294280579907584\",\"SC_ID\":\"52294046697127936\",\"SM_CLASSICON\":\"mdi mdi-comment-check\",\"SM_IS_EXPAND\":\"\"}', '2018-08-16 23:45:50', 2);
INSERT INTO `sys_value_record` VALUES ('52297820031418368', '1', 'SYS_PROCESS_DEFINITION', '50838310695731200', '{\"BUS_PROCESS\":\"100\",\"SPD_COLLEGE_FIELD\":\"BDM_COLLEGE\",\"SR_ID\":\"50858364522987520\",\"SO_ID\":\"1\",\"SPD_DESCRIBE\":\"\",\"BUS_PROCESS2\":\"109\",\"SPD_CLASS_FIELD\":\"BC_ID\",\"IS_STATUS\":1,\"SPD_DEPARTMENT_FIELD\":\"BDM_ID\",\"SPD_UPDATE_TABLE\":\"V_COLLEGE_SCHOLARSHIP\",\"IS_MULTISTAGE_BACK\":1,\"SPD_VERSION\":\"1.0\",\"SDP_ENTRY_TIME\":\"2018-08-12 23:07:07\",\"ID\":\"50838310695731200\",\"SPD_UPDATE_NAME\":\"BS_NAME\",\"SPD_NAME\":\"学院奖学金\"}', '{\"BUS_PROCESS\":\"100\",\"SPD_COLLEGE_FIELD\":\"BDM_COLLEGE\",\"SR_ID\":\"50858364522987520\",\"SPD_DESCRIBE\":\"\",\"BUS_PROCESS2\":\"109\",\"SPD_CLASS_FIELD\":\"BC_ID\",\"SPD_DEPARTMENT_FIELD\":\"BDM_ID\",\"SPD_UPDATE_TABLE\":\"V_COLLEGE_SCHOLARSHIP\",\"IS_MULTISTAGE_BACK\":\"1\",\"SPD_VERSION\":\"1.0\",\"ID\":\"50838310695731200\",\"SPD_UPDATE_NAME\":\"BS_NAME\",\"SPD_NAME\":\"资助管理-学院奖学金\"}', '2018-08-16 23:46:41', 2);
INSERT INTO `sys_value_record` VALUES ('52298323754745856', '1', 'SYS_CONFIGURE_SEARCH', '28000645642452992', '{\"SCS_METHOD_TYPE\":\"1\",\"SCS_TYPE\":\"1\",\"SCS_FIELD\":\"SPD_ID\",\"SCS_NAME\":\"SPD_ID\",\"SCS_IS_STUDENT_YEAR\":\"1\",\"SCS_SDT_CODE\":\"\",\"SCC_IS_VISIBLE\":\"0\",\"ID\":\"28000645642452992\",\"SC_ID\":\"27999782165282816\",\"SCS_REMARK\":\"\",\"SCS_ORDER\":99}', '{\"SCS_FIELD\":\"SPD_ID\",\"SCS_NAME\":\"SPD_ID\",\"SCS_IS_STUDENT_YEAR\":\"1\",\"SCS_SDT_CODE\":\"\",\"SCS_ORDER\":\"99\",\"SCS_METHOD_TYPE\":\"1\",\"SCS_TYPE\":\"1\",\"SCC_IS_VISIBLE\":\"0\",\"ID\":\"28000645642452992\",\"SC_ID\":\"27999782165282816\",\"SCS_REMARK\":\"\"}', '2018-08-16 23:48:41', 2);
INSERT INTO `sys_value_record` VALUES ('52299117954596864', '1', 'SYS_PROCESS_START', '52297783830380544', NULL, NULL, '2018-08-16 23:51:50', 3);
INSERT INTO `sys_value_record` VALUES ('52299124468350976', '1', 'SYS_PROCESS_START', '52297783780048896', NULL, NULL, '2018-08-16 23:51:52', 3);
INSERT INTO `sys_value_record` VALUES ('52299342375026688', '1', 'SYS_ROLE', '52299342316306432', NULL, '{\"SR_CODE\":\"COMMEND\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"SYS_ROLE\",\"SR_EXPLAIN\":\"年度表彰管理\",\"SR_NAME\":\"年度表彰管理\",\"ID\":\"52299342316306432\",\"SR_REMARK\":\"\",\"SR_TYPE\":\"3\"}', '2018-08-16 23:52:44', 1);
INSERT INTO `sys_value_record` VALUES ('52299464173420544', '1', 'SYS_ROLE', '52299464139866112', NULL, '{\"SR_CODE\":\"ALL_COMMEND\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"SYS_ROLE\",\"SR_EXPLAIN\":\"查看全部年度表彰数据\",\"SR_NAME\":\"查看年度表彰\",\"ID\":\"52299464139866112\",\"SR_REMARK\":\"\",\"SR_TYPE\":\"2\"}', '2018-08-16 23:53:13', 1);
INSERT INTO `sys_value_record` VALUES ('52299500995215360', '1', 'SYS_ROLE', '50858364522987520', '{\"SR_CODE\":\"ALL_COLLEGE_SCHOLARSHIP\",\"IS_STATUS\":1,\"SR_EXPLAIN\":\"\",\"SR_NAME\":\"查看学校奖学金\",\"ID\":\"50858364522987520\",\"SR_REMARK\":\"\",\"SR_TYPE\":\"2\"}', '{\"SR_CODE\":\"ALL_COLLEGE_SCHOLARSHIP\",\"SR_TYPE\":\"2\",\"SR_EXPLAIN\":\"查看学校奖学金全部数据\",\"SR_NAME\":\"查看学校奖学金\",\"ID\":\"50858364522987520\",\"SR_REMARK\":\"\"}', '2018-08-16 23:53:22', 2);
INSERT INTO `sys_value_record` VALUES ('52299690686808064', '1', 'SYS_PROCESS_DEFINITION', '52297782794387456', '{\"BUS_PROCESS\":\"100\",\"SPD_COLLEGE_FIELD\":\"BDM_COLLEGE\",\"SR_ID\":\"50858364522987520\",\"SO_ID\":\"1\",\"SPD_DESCRIBE\":\"\",\"BUS_PROCESS2\":\"110\",\"SPD_CLASS_FIELD\":\"BC_ID\",\"IS_STATUS\":1,\"SPD_DEPARTMENT_FIELD\":\"BDM_ID\",\"SPD_UPDATE_TABLE\":\"V_AID_COMMEND\",\"IS_MULTISTAGE_BACK\":1,\"SPD_VERSION\":\"1.0\",\"SDP_ENTRY_TIME\":\"2018-08-12 23:07:07\",\"ID\":\"52297782794387456\",\"SPD_UPDATE_NAME\":\"BS_NAME\",\"SPD_NAME\":\"资助管理-年度表彰\"}', '{\"BUS_PROCESS\":\"100\",\"SPD_COLLEGE_FIELD\":\"BDM_COLLEGE\",\"SR_ID\":\"52299464139866112\",\"SPD_DESCRIBE\":\"\",\"BUS_PROCESS2\":\"110\",\"SPD_CLASS_FIELD\":\"BC_ID\",\"SPD_DEPARTMENT_FIELD\":\"BDM_ID\",\"SPD_UPDATE_TABLE\":\"V_AID_COMMEND\",\"IS_MULTISTAGE_BACK\":\"1\",\"SPD_VERSION\":\"1.0\",\"ID\":\"52297782794387456\",\"SPD_UPDATE_NAME\":\"BS_NAME\",\"SPD_NAME\":\"资助管理-年度表彰\"}', '2018-08-16 23:54:07', 2);
INSERT INTO `sys_value_record` VALUES ('52299963270430720', '1', 'SYS_DICT_INFO', '52299963194933248', NULL, '{\"SDI_CODE\":\"6\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"6\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"年度表彰\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"SYS_PROCESS_STATUS\",\"SDI_INNERCODE\":\"6\",\"ID\":\"52299963194933248\",\"SDT_ID\":\"27191919998140416\"}', '2018-08-16 23:55:12', 1);
INSERT INTO `sys_value_record` VALUES ('52300053687042048', '1', 'SYS_PROCESS_STEP', '52297782974742528', '{\"SPS_NAME\":\"启动人员\",\"SR_ID\":\"50836827770191872\",\"SPS_STEP_TYPE\":1,\"SPS_OVER_TIME\":\"\",\"SPS_ORDER\":1,\"SPS_TAB\":\"系部人员\",\"SPS_PROCESS_STATUS\":5,\"SPS_IS_ADVANCE_CHECK\":1,\"SPS_IS_ADVANCE_EXECUTE\":0,\"SPD_ID\":\"52297782794387456\",\"ID\":\"52297782974742528\",\"SPS_IS_RETREAT_CHECK\":0,\"SPS_IS_RETREAT_EXECUTE\":0,\"SPS_IS_OVER_TIME\":0}', '{\"SPS_NAME\":\"启动人员\",\"SR_ID\":\"52299342316306432\",\"SPS_STEP_TYPE\":\"1\",\"SPS_OVER_TIME\":\"\",\"SPS_ORDER\":\"1\",\"SPS_TAB\":\"系部人员\",\"SPS_PROCESS_STATUS\":\"6\",\"SPS_IS_ADVANCE_CHECK\":\"1\",\"SPS_IS_ADVANCE_EXECUTE\":\"0\",\"SPD_ID\":\"52297782794387456\",\"ID\":\"52297782974742528\",\"SPS_IS_RETREAT_CHECK\":\"0\",\"SPS_IS_RETREAT_EXECUTE\":\"0\",\"SPS_IS_OVER_TIME\":\"0\"}', '2018-08-16 23:55:33', 2);
INSERT INTO `sys_value_record` VALUES ('52300884763213824', '1', 'SYS_CONFIGURE_COLUMN', '52294048408403968', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"190px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"52294048408403968\",\"SC_ID\":\"52294046697127936\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":80}', '{\"SCC_NAME\":\"操作\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"200px\",\"SCC_FIELD\":\"\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"1\",\"ID\":\"52294048408403968\",\"SC_ID\":\"52294046697127936\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"80\"}', '2018-08-16 23:58:52', 2);
INSERT INTO `sys_value_record` VALUES ('52300989541122048', '1', 'SYS_CONFIGURE_COLUMN', '52300989453041664', NULL, '{\"SCC_NAME\":\"学年\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"BAF_YEAR\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"52300989453041664\",\"SC_ID\":\"52294046697127936\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"35\"}', '2018-08-16 23:59:17', 1);
INSERT INTO `sys_value_record` VALUES ('52301044205486080', '1', 'SYS_CONFIGURE_COLUMN', '52301044171931648', NULL, '{\"SCC_NAME\":\"学期\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"BAF_SEMESTER\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"52301044171931648\",\"SC_ID\":\"52294046697127936\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"BUS_SEMESTER\",\"SCC_ORDER\":\"36\"}', '2018-08-16 23:59:30', 1);
INSERT INTO `sys_value_record` VALUES ('52301088207929344', '1', 'SYS_CONFIGURE_COLUMN', '52301044171931648', NULL, NULL, '2018-08-16 23:59:40', 3);
INSERT INTO `sys_value_record` VALUES ('52301132554305536', '1', 'SYS_CONFIGURE_COLUMN', '52301132520751104', NULL, '{\"SCC_NAME\":\"学年\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"BAF_YEAR\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"52301132520751104\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"35\"}', '2018-08-16 23:59:51', 1);
INSERT INTO `sys_value_record` VALUES ('52301184467206144', '1', 'SYS_CONFIGURE_COLUMN', '52301184400097280', NULL, '{\"SCC_NAME\":\"学期\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"BAF_SEMESTER\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"52301184400097280\",\"SC_ID\":\"50831880232108032\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"BUS_SEMESTER\",\"SCC_ORDER\":\"36\"}', '2018-08-17 00:00:03', 1);
INSERT INTO `sys_value_record` VALUES ('52305394084610048', '48601651874889729', 'BUS_AID_FINANCIALLY', '52305394013306880', NULL, '{\"BS_ID\":\"51930103357112320\",\"BUS_PROCESS\":\"100\",\"BAF_AID_TYPE\":\"THREE_GOOD_STUDENTS\",\"SVR_TABLE_NAME\":\"BUS_AID_FINANCIALLY\",\"SO_ID\":\"48601651874889729\",\"BAF_TYPE\":\"10\",\"BAF_YEAR\":\"2017-2018\",\"BUS_PROCESS2\":\"110\",\"ID\":\"52305394013306880\",\"BAF_ENTRY_TIME\":\"2018-08-17 00:16:47\"}', '2018-08-17 00:16:47', 1);
INSERT INTO `sys_value_record` VALUES ('52306243871571968', '48601651874889729', 'BUS_AID_FINANCIALLY', '52306243808657408', NULL, '{\"BS_ID\":\"51930103357112320\",\"BUS_PROCESS\":\"100\",\"BAF_AID_TYPE\":\"THREE_GOOD_STUDENTS\",\"SVR_TABLE_NAME\":\"BUS_AID_FINANCIALLY\",\"SO_ID\":\"48601651874889729\",\"BAF_TYPE\":\"10\",\"BAF_YEAR\":\"2017-2018\",\"BUS_PROCESS2\":\"110\",\"BAF_SEMESTER\":2,\"ID\":\"52306243808657408\",\"BAF_ENTRY_TIME\":\"2018-08-17 00:20:09\"}', '2018-08-17 00:20:09', 1);
INSERT INTO `sys_value_record` VALUES ('52306487745183744', '1', 'SYS_CONFIGURE_COLUMN', '52306487673880576', NULL, '{\"SCC_NAME\":\"学期\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"BAF_SEMESTER\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"52306487673880576\",\"SC_ID\":\"52294046697127936\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"BUS_SEMESTER\",\"SCC_ORDER\":\"36\"}', '2018-08-17 00:21:07', 1);
INSERT INTO `sys_value_record` VALUES ('52307120422387712', '48601651874889729', 'SYS_PROCESS_SCHEDULE', '52306244119035904', '{\"SPS_BACK_STATUS\":0,\"SPS_TABLE_NAME\":\"student_test2\",\"SPS_AUDIT_STATUS\":0,\"SPS_TABLE_ID\":\"52306243808657408\",\"SPD_ID\":\"52297782794387456\",\"ID\":\"52306244119035904\"}', '{\"SPS_PREV_STEP_ID\":\"52297782974742528\",\"SPS_STEP_TRANSACTOR\":\"48307839919194112\",\"SPS_BACK_STATUS\":\"0\",\"SPS_STEP_TYPE\":\"1\",\"SPS_TABLE_NAME\":\"student_test2\",\"SPS_BACK_STATUS_TRANSACTOR\":\"-1\",\"SPS_PREV_STEP_TRANSACTOR\":\"48601651874889729\",\"SPS_ID\":\"52297783364812800\",\"SPS_PREV_STEP_TYPE\":\"0\",\"SPS_AUDIT_STATUS\":\"99\",\"SPS_PREV_AUDIT_STATUS\":\"0\",\"SPS_TABLE_ID\":\"52306243808657408\",\"SPD_ID\":\"52297782794387456\",\"ID\":\"52306244119035904\"}', '2018-08-17 00:23:38', 2);
INSERT INTO `sys_value_record` VALUES ('52309055099633664', '48303136200196097', 'SYS_PROCESS_SCHEDULE', '52306244119035904', '{\"SPS_PREV_STEP_ID\":\"52297782974742528\",\"SPS_STEP_TRANSACTOR\":\"48307839919194112\",\"SPS_BACK_STATUS\":0,\"SPS_STEP_TYPE\":1,\"SPS_TABLE_NAME\":\"student_test2\",\"SPS_BACK_STATUS_TRANSACTOR\":-1,\"SPS_PREV_STEP_TRANSACTOR\":\"48601651874889729\",\"SPS_ID\":\"52297783364812800\",\"SPS_PREV_STEP_TYPE\":0,\"SPS_AUDIT_STATUS\":99,\"SPS_PREV_AUDIT_STATUS\":0,\"SPS_TABLE_ID\":\"52306243808657408\",\"SPD_ID\":\"52297782794387456\",\"ID\":\"52306244119035904\"}', '{\"SPS_PREV_STEP_ID\":\"52297783364812800\",\"SPS_STEP_TRANSACTOR\":\"0\",\"SPS_BACK_STATUS\":\"0\",\"SPS_STEP_TYPE\":\"1\",\"SPS_TABLE_NAME\":\"student_test2\",\"SPS_BACK_STATUS_TRANSACTOR\":\"-1\",\"SPS_PREV_STEP_TRANSACTOR\":\"48303136200196097\",\"SPS_ID\":\"52297783385784320\",\"SPS_PREV_STEP_TYPE\":\"0\",\"SPS_AUDIT_STATUS\":\"999\",\"SPS_PREV_AUDIT_STATUS\":99,\"SPS_TABLE_ID\":\"52306243808657408\",\"SPD_ID\":\"52297782794387456\",\"ID\":\"52306244119035904\"}', '2018-08-17 00:31:20', 2);
INSERT INTO `sys_value_record` VALUES ('52309291322834944', '1', 'SYS_OPERATOR_SUB', '52309291238948864', NULL, '{\"IS_STATUS\":1,\"SOS_CREATETIME\":\"2018-08-17 00:32:16\",\"SVR_TABLE_NAME\":\"SYS_OPERATOR_SUB\",\"SOS_REMARK\":\"\",\"SOS_DEFAULT\":1,\"SO_ID\":\"51930103373889536\",\"ID\":\"52309291238948864\",\"SOS_USERNAME\":\"student_test2\"}', '2018-08-17 00:32:16', 1);
INSERT INTO `sys_value_record` VALUES ('52503961852182528', '1', 'SYS_ROLE', '52299342316306432', NULL, NULL, '2018-08-17 13:25:49', 3);
INSERT INTO `sys_value_record` VALUES ('52503993498206208', '1', 'SYS_ROLE', '50836827770191872', NULL, NULL, '2018-08-17 13:25:56', 3);
INSERT INTO `sys_value_record` VALUES ('52504058430226432', '1', 'SYS_ROLE', '52504058379894784', NULL, '{\"SR_CODE\":\"DEPARTMENT_MANAGER\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"SYS_ROLE\",\"SR_EXPLAIN\":\"\",\"SR_NAME\":\"系管理\",\"ID\":\"52504058379894784\",\"SR_REMARK\":\"\",\"SR_TYPE\":\"3\"}', '2018-08-17 13:26:12', 1);
INSERT INTO `sys_value_record` VALUES ('52504248151179264', '1', 'SYS_ROLE', '52504058379894784', NULL, NULL, '2018-08-17 13:26:57', 3);
INSERT INTO `sys_value_record` VALUES ('52504512706904064', '1', 'SYS_OPERATOR', '52504512421691393', NULL, '{\"SO_PASSWORD\":\"936d195dc880cdeaa54c384aab5eb2b6\",\"IS_STATUS\":1,\"SVR_TABLE_NAME\":\"SYS_OPERATOR\",\"ID\":\"52504512421691393\",\"SO_SALT\":\"+1QicT\"}', '2018-08-17 13:28:00', 1);
INSERT INTO `sys_value_record` VALUES ('52504512757235712', '1', 'SYS_ACCOUNT_INFO', '52504512727875584', NULL, '{\"SO_ID\":\"52504512421691393\",\"SAI_NAME\":\"department_manager\",\"SVR_TABLE_NAME\":\"SYS_ACCOUNT_INFO\",\"ID\":\"52504512727875584\",\"SAI_TYPE\":3}', '2018-08-17 13:28:00', 1);
INSERT INTO `sys_value_record` VALUES ('52504512870481920', '1', 'BUS_DEPARTMENT_PERSONNEL', '52504512421691392', NULL, '{\"BDMP_NAME\":\"department_manager\",\"SVR_TABLE_NAME\":\"BUS_DEPARTMENT_PERSONNEL\",\"SO_ID\":\"52504512421691393\",\"ID\":\"52504512421691392\",\"BDM_ID\":\"48601265252335616\"}', '2018-08-17 13:28:00', 1);
INSERT INTO `sys_value_record` VALUES ('52504621154828288', '1', 'SYS_OPERATOR_SUB', '52504620978667520', NULL, '{\"IS_STATUS\":1,\"SOS_CREATETIME\":\"2018-08-17 13:28:26\",\"SVR_TABLE_NAME\":\"SYS_OPERATOR_SUB\",\"SOS_REMARK\":\"\",\"SOS_DEFAULT\":1,\"SO_ID\":\"52504512421691393\",\"ID\":\"52504620978667520\",\"SOS_USERNAME\":\"department_manager\"}', '2018-08-17 13:28:26', 1);
INSERT INTO `sys_value_record` VALUES ('52505246580080640', '48601651874889729', 'SYS_PROCESS_SCHEDULE', '50855922569838592', '{\"SPS_PREV_STEP_ID\":\"50839589836816384\",\"SPS_STEP_TRANSACTOR\":\"48307839919194112\",\"SPS_BACK_STATUS\":0,\"SPS_STEP_TYPE\":1,\"SPS_TABLE_NAME\":\"student_test\",\"SPS_BACK_STATUS_TRANSACTOR\":-1,\"SPS_PREV_STEP_TRANSACTOR\":\"48601651874889729\",\"SPS_ID\":\"50839707340242944\",\"SPS_PREV_STEP_TYPE\":0,\"SPS_AUDIT_STATUS\":99,\"SPS_PREV_AUDIT_STATUS\":0,\"SPS_TABLE_ID\":\"50844794401849344\",\"SPD_ID\":\"50838310695731200\",\"ID\":\"50855922569838592\"}', '{\"SPS_PREV_STEP_ID\":\"50839707340242944\",\"SPS_STEP_TRANSACTOR\":\"48601651874889729\",\"SPS_BACK_STATUS\":\"2\",\"SPS_STEP_TYPE\":2,\"SPS_TABLE_NAME\":\"student_test\",\"SPS_BACK_STATUS_TRANSACTOR\":5,\"SPS_PREV_STEP_TRANSACTOR\":\"48601651874889729\",\"SPS_ID\":\"50839589836816384\",\"SPS_PREV_STEP_TYPE\":\"2\",\"SPS_AUDIT_STATUS\":-1,\"SPS_PREV_AUDIT_STATUS\":99,\"SPS_TABLE_ID\":\"50844794401849344\",\"SPD_ID\":\"50838310695731200\",\"ID\":\"50855922569838592\"}', '2018-08-17 13:30:55', 2);
INSERT INTO `sys_value_record` VALUES ('52505344915537920', '1', 'SYS_PROCESS_STEP', '50839707340242944', '{\"SPS_NAME\":\"学生处\",\"SR_ID\":\"48307839919194112\",\"SPS_STEP_TYPE\":1,\"SPS_OVER_TIME\":\"\",\"SPS_ORDER\":2,\"SPS_TAB\":\"学生处\",\"SPS_PROCESS_STATUS\":99,\"SPS_IS_ADVANCE_CHECK\":1,\"SPS_IS_ADVANCE_EXECUTE\":0,\"SPD_ID\":\"50838310695731200\",\"ID\":\"50839707340242944\",\"SPS_IS_RETREAT_CHECK\":0,\"SPS_IS_RETREAT_EXECUTE\":0,\"SPS_IS_OVER_TIME\":0}', '{\"SPS_NAME\":\"学生处\",\"SR_ID\":\"48307839919194112\",\"SPS_STEP_TYPE\":\"1\",\"SPS_OVER_TIME\":\"\",\"SPS_ORDER\":\"3\",\"SPS_TAB\":\"学生处\",\"SPS_PROCESS_STATUS\":\"99\",\"SPS_IS_ADVANCE_CHECK\":\"1\",\"SPS_IS_ADVANCE_EXECUTE\":\"0\",\"SPD_ID\":\"50838310695731200\",\"ID\":\"50839707340242944\",\"SPS_IS_RETREAT_CHECK\":\"0\",\"SPS_IS_RETREAT_EXECUTE\":\"0\",\"SPS_IS_OVER_TIME\":\"0\"}', '2018-08-17 13:31:19', 2);
INSERT INTO `sys_value_record` VALUES ('52505357330677760', '1', 'SYS_PROCESS_STEP', '50840190146576384', '{\"SPS_NAME\":\"完成\",\"SR_ID\":\"\",\"SPS_STEP_TYPE\":1,\"SPS_OVER_TIME\":\"\",\"SPS_ORDER\":3,\"SPS_TAB\":\"\",\"SPS_PROCESS_STATUS\":999,\"SPS_IS_ADVANCE_CHECK\":0,\"SPS_IS_ADVANCE_EXECUTE\":0,\"SPD_ID\":\"50838310695731200\",\"ID\":\"50840190146576384\",\"SPS_IS_RETREAT_CHECK\":0,\"SPS_IS_RETREAT_EXECUTE\":0,\"SPS_IS_OVER_TIME\":0}', '{\"SPS_NAME\":\"完成\",\"SR_ID\":\"\",\"SPS_STEP_TYPE\":\"1\",\"SPS_OVER_TIME\":\"\",\"SPS_ORDER\":\"4\",\"SPS_TAB\":\"\",\"SPS_PROCESS_STATUS\":\"999\",\"SPS_IS_ADVANCE_CHECK\":\"0\",\"SPS_IS_ADVANCE_EXECUTE\":\"0\",\"SPD_ID\":\"50838310695731200\",\"ID\":\"50840190146576384\",\"SPS_IS_RETREAT_CHECK\":\"0\",\"SPS_IS_RETREAT_EXECUTE\":\"0\",\"SPS_IS_OVER_TIME\":\"0\"}', '2018-08-17 13:31:22', 2);
INSERT INTO `sys_value_record` VALUES ('52506154709811200', '1', 'SYS_DICT_INFO', '52506154542039040', NULL, '{\"SDI_CODE\":\"50\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"50\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"辅导员\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"SYS_PROCESS_STATUS\",\"SDI_INNERCODE\":\"50\",\"ID\":\"52506154542039040\",\"SDT_ID\":\"27191919998140416\"}', '2018-08-17 13:34:32', 1);
INSERT INTO `sys_value_record` VALUES ('52506262037856256', '1', 'SYS_PROCESS_STEP', '50839589836816384', '{\"SPS_NAME\":\"启动人员\",\"SR_ID\":\"50836827770191872\",\"SPS_STEP_TYPE\":1,\"SPS_OVER_TIME\":\"\",\"SPS_ORDER\":1,\"SPS_TAB\":\"系部人员\",\"SPS_PROCESS_STATUS\":5,\"SPS_IS_ADVANCE_CHECK\":1,\"SPS_IS_ADVANCE_EXECUTE\":0,\"SPD_ID\":\"50838310695731200\",\"ID\":\"50839589836816384\",\"SPS_IS_RETREAT_CHECK\":0,\"SPS_IS_RETREAT_EXECUTE\":0,\"SPS_IS_OVER_TIME\":0}', '{\"SPS_NAME\":\"启动人员\",\"SR_ID\":\"48309528801837056\",\"SPS_STEP_TYPE\":\"1\",\"SPS_OVER_TIME\":\"\",\"SPS_ORDER\":\"1\",\"SPS_TAB\":\"系部人员\",\"SPS_PROCESS_STATUS\":\"50\",\"SPS_IS_ADVANCE_CHECK\":\"1\",\"SPS_IS_ADVANCE_EXECUTE\":\"0\",\"SPD_ID\":\"50838310695731200\",\"ID\":\"50839589836816384\",\"SPS_IS_RETREAT_CHECK\":\"0\",\"SPS_IS_RETREAT_EXECUTE\":\"0\",\"SPS_IS_OVER_TIME\":\"0\"}', '2018-08-17 13:34:57', 2);
INSERT INTO `sys_value_record` VALUES ('52506439297531904', '1', 'SYS_DICT_INFO', '52299963194933248', NULL, NULL, '2018-08-17 13:35:40', 3);
INSERT INTO `sys_value_record` VALUES ('52506449766514688', '1', 'SYS_DICT_INFO', '50839172386127872', NULL, NULL, '2018-08-17 13:35:42', 3);
INSERT INTO `sys_value_record` VALUES ('52506480896638976', '1', 'SYS_DICT_INFO', '52506480846307328', NULL, '{\"SDI_CODE\":\"51\",\"SVR_TABLE_NAME\":\"SYS_DICT_INFO\",\"SDI_REQUIRED\":\"0\",\"SDI_ORDER\":\"51\",\"SDI_REMARK\":\"\",\"SDI_NAME\":\"系部管理员\",\"SDI_PARENTID\":\"0\",\"IS_STATUS\":1,\"SDT_CODE\":\"SYS_PROCESS_STATUS\",\"SDI_INNERCODE\":\"51\",\"ID\":\"52506480846307328\",\"SDT_ID\":\"27191919998140416\"}', '2018-08-17 13:35:49', 1);
INSERT INTO `sys_value_record` VALUES ('52506599570276352', '1', 'SYS_PROCESS_STEP', '52506599511556096', NULL, '{\"SPS_NAME\":\"系部管理员\",\"SVR_TABLE_NAME\":\"SYS_PROCESS_STEP\",\"SR_ID\":\"48309996873580544\",\"SPS_STEP_TYPE\":\"1\",\"SPS_OVER_TIME\":\"\",\"SPS_ORDER\":\"2\",\"SPS_TAB\":\"\",\"SPS_PROCESS_STATUS\":\"51\",\"SPS_IS_ADVANCE_CHECK\":\"0\",\"SPS_IS_ADVANCE_EXECUTE\":\"0\",\"SPD_ID\":\"50838310695731200\",\"ID\":\"52506599511556096\",\"SPS_IS_RETREAT_CHECK\":\"0\",\"NOT_ID\":\"\",\"SPS_IS_RETREAT_EXECUTE\":\"0\",\"SPS_IS_OVER_TIME\":\"0\"}', '2018-08-17 13:36:18', 1);
INSERT INTO `sys_value_record` VALUES ('52506640041115648', '1', 'SYS_PROCESS_STEP', '52297783364812800', '{\"SPS_NAME\":\"学生处\",\"SR_ID\":\"48307839919194112\",\"SPS_STEP_TYPE\":1,\"SPS_OVER_TIME\":\"\",\"SPS_ORDER\":2,\"SPS_TAB\":\"学生处\",\"SPS_PROCESS_STATUS\":99,\"SPS_IS_ADVANCE_CHECK\":1,\"SPS_IS_ADVANCE_EXECUTE\":0,\"SPD_ID\":\"52297782794387456\",\"ID\":\"52297783364812800\",\"SPS_IS_RETREAT_CHECK\":0,\"SPS_IS_RETREAT_EXECUTE\":0,\"SPS_IS_OVER_TIME\":0}', '{\"SPS_NAME\":\"学生处\",\"SR_ID\":\"48307839919194112\",\"SPS_STEP_TYPE\":\"1\",\"SPS_OVER_TIME\":\"\",\"SPS_ORDER\":\"3\",\"SPS_TAB\":\"学生处\",\"SPS_PROCESS_STATUS\":\"99\",\"SPS_IS_ADVANCE_CHECK\":\"1\",\"SPS_IS_ADVANCE_EXECUTE\":\"0\",\"SPD_ID\":\"52297782794387456\",\"ID\":\"52297783364812800\",\"SPS_IS_RETREAT_CHECK\":\"0\",\"SPS_IS_RETREAT_EXECUTE\":\"0\",\"SPS_IS_OVER_TIME\":\"0\"}', '2018-08-17 13:36:27', 2);
INSERT INTO `sys_value_record` VALUES ('52506653437722624', '1', 'SYS_PROCESS_STEP', '52297783385784320', '{\"SPS_NAME\":\"完成\",\"SR_ID\":\"\",\"SPS_STEP_TYPE\":1,\"SPS_OVER_TIME\":\"\",\"SPS_ORDER\":3,\"SPS_TAB\":\"\",\"SPS_PROCESS_STATUS\":999,\"SPS_IS_ADVANCE_CHECK\":0,\"SPS_IS_ADVANCE_EXECUTE\":0,\"SPD_ID\":\"52297782794387456\",\"ID\":\"52297783385784320\",\"SPS_IS_RETREAT_CHECK\":0,\"SPS_IS_RETREAT_EXECUTE\":0,\"SPS_IS_OVER_TIME\":0}', '{\"SPS_NAME\":\"完成\",\"SR_ID\":\"\",\"SPS_STEP_TYPE\":\"1\",\"SPS_OVER_TIME\":\"\",\"SPS_ORDER\":\"4\",\"SPS_TAB\":\"\",\"SPS_PROCESS_STATUS\":\"999\",\"SPS_IS_ADVANCE_CHECK\":\"0\",\"SPS_IS_ADVANCE_EXECUTE\":\"0\",\"SPD_ID\":\"52297782794387456\",\"ID\":\"52297783385784320\",\"SPS_IS_RETREAT_CHECK\":\"0\",\"SPS_IS_RETREAT_EXECUTE\":\"0\",\"SPS_IS_OVER_TIME\":\"0\"}', '2018-08-17 13:36:31', 2);
INSERT INTO `sys_value_record` VALUES ('52506693451382784', '1', 'SYS_PROCESS_STEP', '52297782974742528', '{\"SPS_NAME\":\"启动人员\",\"SR_ID\":\"52299342316306432\",\"SPS_STEP_TYPE\":1,\"SPS_OVER_TIME\":\"\",\"SPS_ORDER\":1,\"SPS_TAB\":\"系部人员\",\"SPS_PROCESS_STATUS\":6,\"SPS_IS_ADVANCE_CHECK\":1,\"SPS_IS_ADVANCE_EXECUTE\":0,\"SPD_ID\":\"52297782794387456\",\"ID\":\"52297782974742528\",\"SPS_IS_RETREAT_CHECK\":0,\"SPS_IS_RETREAT_EXECUTE\":0,\"SPS_IS_OVER_TIME\":0}', '{\"SPS_NAME\":\"启动人员\",\"SR_ID\":\"48309528801837056\",\"SPS_STEP_TYPE\":\"1\",\"SPS_OVER_TIME\":\"\",\"SPS_ORDER\":\"1\",\"SPS_TAB\":\"系部人员\",\"SPS_PROCESS_STATUS\":\"50\",\"SPS_IS_ADVANCE_CHECK\":\"1\",\"SPS_IS_ADVANCE_EXECUTE\":\"0\",\"SPD_ID\":\"52297782794387456\",\"ID\":\"52297782974742528\",\"SPS_IS_RETREAT_CHECK\":\"0\",\"SPS_IS_RETREAT_EXECUTE\":\"0\",\"SPS_IS_OVER_TIME\":\"0\"}', '2018-08-17 13:36:40', 2);
INSERT INTO `sys_value_record` VALUES ('52506737537712128', '1', 'SYS_PROCESS_STEP', '52506737504157696', NULL, '{\"SPS_NAME\":\"系部管理员\",\"SVR_TABLE_NAME\":\"SYS_PROCESS_STEP\",\"SR_ID\":\"48309996873580544\",\"SPS_STEP_TYPE\":\"1\",\"SPS_OVER_TIME\":\"\",\"SPS_ORDER\":\"2\",\"SPS_TAB\":\"\",\"SPS_PROCESS_STATUS\":\"51\",\"SPS_IS_ADVANCE_CHECK\":\"0\",\"SPS_IS_ADVANCE_EXECUTE\":\"0\",\"SPD_ID\":\"52297782794387456\",\"ID\":\"52506737504157696\",\"SPS_IS_RETREAT_CHECK\":\"0\",\"NOT_ID\":\"\",\"SPS_IS_RETREAT_EXECUTE\":\"0\",\"SPS_IS_OVER_TIME\":\"0\"}', '2018-08-17 13:36:51', 1);
INSERT INTO `sys_value_record` VALUES ('52508019195379712', '1', 'SYS_PROCESS_DEFINITION', '50838310695731200', '{\"BUS_PROCESS\":\"100\",\"SPD_COLLEGE_FIELD\":\"BDM_COLLEGE\",\"SR_ID\":\"50858364522987520\",\"SO_ID\":\"1\",\"SPD_DESCRIBE\":\"\",\"BUS_PROCESS2\":\"109\",\"SPD_CLASS_FIELD\":\"BC_ID\",\"IS_STATUS\":1,\"SPD_DEPARTMENT_FIELD\":\"BDM_ID\",\"SPD_UPDATE_TABLE\":\"V_COLLEGE_SCHOLARSHIP\",\"IS_MULTISTAGE_BACK\":1,\"SPD_VERSION\":\"1.0\",\"SDP_ENTRY_TIME\":\"2018-08-12 23:07:07\",\"ID\":\"50838310695731200\",\"SPD_UPDATE_NAME\":\"BS_NAME\",\"SPD_NAME\":\"资助管理-学院奖学金\"}', '{\"BUS_PROCESS\":\"100\",\"SPD_COLLEGE_FIELD\":\"BDM_COLLEGE\",\"SR_ID\":\"50858364522987520\",\"SPD_DESCRIBE\":\"\",\"BUS_PROCESS2\":\"109\",\"SPD_CLASS_FIELD\":\"BC_ID\",\"SPD_DEPARTMENT_FIELD\":\"BDM_ID\",\"SPD_UPDATE_TABLE\":\"v_aid_college_scholarship\",\"IS_MULTISTAGE_BACK\":\"1\",\"SPD_VERSION\":\"1.0\",\"ID\":\"50838310695731200\",\"SPD_UPDATE_NAME\":\"BS_NAME\",\"SPD_NAME\":\"资助管理-学院奖学金\"}', '2018-08-17 13:41:56', 2);
INSERT INTO `sys_value_record` VALUES ('52508085972893696', '48601651874889729', 'SYS_PROCESS_SCHEDULE', '52508085763178496', NULL, '{\"SHOW_SO_ID\":\"48944951878221825\",\"SVR_TABLE_NAME\":\"SYS_PROCESS_SCHEDULE\",\"SPS_PREV_STEP_ID\":\"50839589836816384\",\"SPS_STEP_TRANSACTOR\":\"48309996873580544\",\"SPS_BACK_STATUS\":\"0\",\"SPS_STEP_TYPE\":\"1\",\"SO_ID\":\"48601651874889729\",\"SPS_BACK_STATUS_TRANSACTOR\":\"-1\",\"SPS_TABLE_NAME\":\"student_test\",\"SPS_PREV_STEP_TRANSACTOR\":\"48601651874889729\",\"SPS_ID\":\"52506599511556096\",\"SPS_PREV_STEP_TYPE\":\"0\",\"SPS_AUDIT_STATUS\":\"51\",\"SPS_PREV_AUDIT_STATUS\":\"0\",\"SPS_TABLE_ID\":\"50844794401849344\",\"SPD_ID\":\"50838310695731200\",\"ID\":\"52508085763178496\"}', '2018-08-17 13:42:12', 1);
INSERT INTO `sys_value_record` VALUES ('52508602966999040', '1', 'SYS_PROCESS_STEP', '50840190146576384', '{\"SPS_NAME\":\"完成\",\"SR_ID\":\"\",\"SPS_STEP_TYPE\":1,\"SPS_OVER_TIME\":\"\",\"SPS_ORDER\":4,\"SPS_TAB\":\"\",\"SPS_PROCESS_STATUS\":999,\"SPS_IS_ADVANCE_CHECK\":0,\"SPS_IS_ADVANCE_EXECUTE\":0,\"SPD_ID\":\"50838310695731200\",\"ID\":\"50840190146576384\",\"SPS_IS_RETREAT_CHECK\":0,\"SPS_IS_RETREAT_EXECUTE\":0,\"SPS_IS_OVER_TIME\":0}', '{\"SPS_NAME\":\"完成\",\"SR_ID\":\"\",\"SPS_STEP_TYPE\":\"1\",\"SPS_OVER_TIME\":\"\",\"SPS_ORDER\":\"4\",\"SPS_TAB\":\"\",\"SPS_PROCESS_STATUS\":\"999\",\"SPS_IS_ADVANCE_CHECK\":\"0\",\"SPS_IS_ADVANCE_EXECUTE\":\"0\",\"SPD_ID\":\"50838310695731200\",\"ID\":\"50840190146576384\",\"SPS_IS_RETREAT_CHECK\":\"0\",\"SPS_IS_RETREAT_EXECUTE\":\"0\",\"SPS_IS_OVER_TIME\":\"0\"}', '2018-08-17 13:44:15', 2);
INSERT INTO `sys_value_record` VALUES ('52508632549425152', '52504512421691393', 'SYS_PROCESS_SCHEDULE', '52508085763178496', '{\"SPS_PREV_STEP_ID\":\"50839589836816384\",\"SPS_STEP_TRANSACTOR\":\"48309996873580544\",\"SPS_BACK_STATUS\":0,\"SPS_STEP_TYPE\":1,\"SPS_TABLE_NAME\":\"student_test\",\"SPS_BACK_STATUS_TRANSACTOR\":-1,\"SPS_PREV_STEP_TRANSACTOR\":\"48601651874889729\",\"SPS_ID\":\"52506599511556096\",\"SPS_PREV_STEP_TYPE\":0,\"SPS_AUDIT_STATUS\":51,\"SPS_PREV_AUDIT_STATUS\":0,\"SPS_TABLE_ID\":\"50844794401849344\",\"SPD_ID\":\"50838310695731200\",\"ID\":\"52508085763178496\"}', '{\"SPS_PREV_STEP_ID\":\"52506599511556096\",\"SPS_STEP_TRANSACTOR\":\"48307839919194112\",\"SPS_BACK_STATUS\":\"0\",\"SPS_STEP_TYPE\":\"1\",\"SPS_TABLE_NAME\":\"student_test\",\"SPS_BACK_STATUS_TRANSACTOR\":\"-1\",\"SPS_PREV_STEP_TRANSACTOR\":\"52504512421691393\",\"SPS_ID\":\"50839707340242944\",\"SPS_PREV_STEP_TYPE\":\"0\",\"SPS_AUDIT_STATUS\":\"99\",\"SPS_PREV_AUDIT_STATUS\":51,\"SPS_TABLE_ID\":\"50844794401849344\",\"SPD_ID\":\"50838310695731200\",\"ID\":\"52508085763178496\"}', '2018-08-17 13:44:22', 2);
INSERT INTO `sys_value_record` VALUES ('52509942141157376', '1', 'SYS_CONFIGURE_COLUMN', '52306487673880576', NULL, NULL, '2018-08-17 13:49:35', 3);
INSERT INTO `sys_value_record` VALUES ('52509961682419712', '1', 'SYS_CONFIGURE_SEARCH', '52294049427619840', NULL, NULL, '2018-08-17 13:49:39', 3);
INSERT INTO `sys_value_record` VALUES ('52510532309090304', '1', 'SYS_CONFIGURE_COLUMN', '50340096863371264', '{\"SCC_NAME\":\"智育排名\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"70px\",\"SCC_FIELD\":\"BSC_INTELLECTUAL_RANK\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50340096863371264\",\"SC_ID\":\"50338719827230720\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":80}', '{\"SCC_NAME\":\"智育排名\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"60px\",\"SCC_FIELD\":\"BSC_INTELLECTUAL_RANK\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50340096863371264\",\"SC_ID\":\"50338719827230720\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"80\"}', '2018-08-17 13:51:55', 2);
INSERT INTO `sys_value_record` VALUES ('52510544220913664', '1', 'SYS_CONFIGURE_COLUMN', '50340030438178816', '{\"SCC_NAME\":\"学习成绩\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"70px\",\"SCC_FIELD\":\"BSC_ACADEMIC_RECORD\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50340030438178816\",\"SC_ID\":\"50338719827230720\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":70}', '{\"SCC_NAME\":\"学习成绩\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"60px\",\"SCC_FIELD\":\"BSC_ACADEMIC_RECORD\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50340030438178816\",\"SC_ID\":\"50338719827230720\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"70\"}', '2018-08-17 13:51:58', 2);
INSERT INTO `sys_value_record` VALUES ('52510568778563584', '1', 'SYS_CONFIGURE_COLUMN', '50339810778284032', '{\"SCC_NAME\":\"总分\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"70px\",\"SCC_FIELD\":\"BSC_TOTAL\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50339810778284032\",\"SC_ID\":\"50338719827230720\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":50}', '{\"SCC_NAME\":\"总分\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"60px\",\"SCC_FIELD\":\"BSC_TOTAL\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50339810778284032\",\"SC_ID\":\"50338719827230720\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"50\"}', '2018-08-17 13:52:04', 2);
INSERT INTO `sys_value_record` VALUES ('52510606984478720', '1', 'SYS_CONFIGURE_COLUMN', '50339810778284032', '{\"SCC_NAME\":\"总分\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"60px\",\"SCC_FIELD\":\"BSC_TOTAL\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50339810778284032\",\"SC_ID\":\"50338719827230720\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":50}', '{\"SCC_NAME\":\"总分\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"50px\",\"SCC_FIELD\":\"BSC_TOTAL\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"50339810778284032\",\"SC_ID\":\"50338719827230720\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"50\"}', '2018-08-17 13:52:13', 2);
INSERT INTO `sys_value_record` VALUES ('52510692644749312', '1', 'SYS_CONFIGURE_COLUMN', '52510692615389184', NULL, '{\"SCC_NAME\":\"学号\",\"SVR_TABLE_NAME\":\"SYS_CONFIGURE_COLUMN\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"80px\",\"SCC_FIELD\":\"BS_NUMBER\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"52510692615389184\",\"SC_ID\":\"50338719827230720\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"10\"}', '2018-08-17 13:52:34', 1);
INSERT INTO `sys_value_record` VALUES ('52511057360453632', '1', 'SYS_MENU', '1', '{\"SM_URL\":\"\",\"SM_IS_LEAF\":\"1\",\"IS_STATUS\":1,\"SM_TYPE\":\"1\",\"SM_ORDER\":1,\"SM_CODE\":\"SYSTEM\",\"SM_NAME\":\"系统管理\",\"SM_PARENTID\":\"0\",\"ID\":\"1\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-laptop\",\"SM_IS_EXPAND\":\"\"}', '{\"BUS_PROCESS\":\"\",\"SM_URL\":\"\",\"SM_URL_PARAMS\":\"\",\"BUS_PROCESS2\":\"\",\"SM_IS_LEAF\":\"1\",\"SM_TYPE\":\"1\",\"SM_ORDER\":\"1\",\"SM_CODE\":\"SYSTEM\",\"SM_NAME\":\"系统管理\",\"SM_PARENTID\":\"0\",\"ID\":\"1\",\"SC_ID\":\"\",\"SM_CLASSICON\":\"mdi mdi-laptop\",\"SM_IS_EXPAND\":\"\"}', '2018-08-17 13:54:01', 2);
INSERT INTO `sys_value_record` VALUES ('52511474601426944', '48601651874889729', 'BUS_STUDENT_COMPREHENSIVE', '52511474496569344', NULL, '{\"BS_ID\":\"51930103357112320\",\"BSC_INTELLECTUAL_PROPORTION\":60.0,\"BSC_VOLUNTEER_TOTAL\":86,\"BSC_INTELLECTUAL_SCORE\":48,\"SVR_TABLE_NAME\":\"BUS_STUDENT_COMPREHENSIVE\",\"BSC_INTELLECTUAL_POINTS\":0,\"BSC_DECORUM\":6,\"BSC_SERVICE_SPIRIT\":8,\"BSC_EDUCATION_TOTAL\":39,\"ID\":\"52511474496569344\",\"BSC_COLLECTIVE\":4,\"BSC_VOLUNTEER_PROPORTION\":10.0,\"BSC_YEAR\":\"2017-2018\",\"BSC_EDUCATION_DEDUCTION\":22,\"BSC_ACADEMIC_RECORD\":80,\"BSC_BONUS_POINTS\":10,\"BSC_LABOR_ATTITUDE\":5,\"BSC_POLITICAL_ATTITUDE\":2,\"BSC_REMARKS\":\"15\",\"BSC_COMPLIANCE\":4,\"BSC_EDUCATION_SCORE\":11.700000762939453125,\"BS_NUMBER\":\"2018053106\",\"BSC_FULL_WORK\":9,\"BSC_SEMESTER\":1,\"BSC_PERSONAL_QUALITY\":7,\"BSC_EDUCATION_PROPORTION\":30.0,\"BSC_TOTAL\":68.3000011444091796875,\"BSC_CARE\":6,\"BSC_VOLUNTEER_SCORE\":8.6000003814697265625}', '2018-08-17 13:55:40', 1);
INSERT INTO `sys_value_record` VALUES ('52523342892105728', '1', 'SYS_CONFIGURE_COLUMN', '52294047150112768', '{\"SCC_NAME\":\"测评排名\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"60px\",\"SCC_FIELD\":\"BSC_RANK\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"52294047150112768\",\"SC_ID\":\"52294046697127936\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":50}', '{\"SCC_NAME\":\"测评排名\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"60px\",\"SCC_FIELD\":\"BSC_TOTAL_RANK\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"52294047150112768\",\"SC_ID\":\"52294046697127936\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"50\"}', '2018-08-17 14:42:50', 2);
INSERT INTO `sys_value_record` VALUES ('52523662661648384', '1', 'SYS_CONFIGURE_COLUMN', '52294047573737472', '{\"SCC_NAME\":\"学习排名\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"60px\",\"SCC_FIELD\":\"BSC_INTELLECTUAL_RANK\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"52294047573737472\",\"SC_ID\":\"52294046697127936\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":70}', '{\"SCC_NAME\":\"学习排名\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"60px\",\"SCC_FIELD\":\"BSC_ACADEMIC_RECORD_RANK\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"52294047573737472\",\"SC_ID\":\"52294046697127936\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"70\"}', '2018-08-17 14:44:06', 2);
INSERT INTO `sys_value_record` VALUES ('52524045517717504', '1', 'SYS_CONFIGURE_COLUMN', '52294047137529856', '{\"SCC_NAME\":\"综合测评\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"60px\",\"SCC_FIELD\":\"BSC_TOTAL\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"52294047137529856\",\"SC_ID\":\"52294046697127936\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":40}', '{\"SCC_NAME\":\"综合测评平均\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"80px\",\"SCC_FIELD\":\"BSC_TOTAL\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"52294047137529856\",\"SC_ID\":\"52294046697127936\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"40\"}', '2018-08-17 14:45:37', 2);
INSERT INTO `sys_value_record` VALUES ('52524081404182528', '1', 'SYS_CONFIGURE_COLUMN', '52294047137529856', '{\"SCC_NAME\":\"综合测评平均\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"80px\",\"SCC_FIELD\":\"BSC_TOTAL\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"52294047137529856\",\"SC_ID\":\"52294046697127936\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":40}', '{\"SCC_NAME\":\"综合测评平均\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"BSC_TOTAL\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"52294047137529856\",\"SC_ID\":\"52294046697127936\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"40\"}', '2018-08-17 14:45:46', 2);
INSERT INTO `sys_value_record` VALUES ('52524158520655872', '1', 'SYS_CONFIGURE_COLUMN', '52294047561154560', '{\"SCC_NAME\":\"学习成绩\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"60px\",\"SCC_FIELD\":\"BSC_ACADEMIC_RECORD\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"52294047561154560\",\"SC_ID\":\"52294046697127936\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":60}', '{\"SCC_NAME\":\"学习成绩平均\",\"SCC_FUNC\":\"\",\"SCC_IS_MERGE\":\"\",\"SCC_ALIGN\":\"center\",\"SCC_IS_STATUS\":\"0\",\"SCC_WIDTH\":\"100px\",\"SCC_FIELD\":\"BSC_ACADEMIC_RECORD\",\"SCC_IS_VISIBLE\":\"1\",\"SCC_IS_OPERATION\":\"0\",\"ID\":\"52294047561154560\",\"SC_ID\":\"52294046697127936\",\"SCC_CLASS\":\"\",\"SCC_SDT_CODE\":\"\",\"SCC_ORDER\":\"60\"}', '2018-08-17 14:46:04', 2);

-- ----------------------------
-- Table structure for test_process
-- ----------------------------
DROP TABLE IF EXISTS `test_process`;
CREATE TABLE `test_process`  (
  `ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `NAME` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `SO_ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `BUS_PROCESS` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `BUS_PROCESS2` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of test_process
-- ----------------------------
INSERT INTO `test_process` VALUES ('1', '测试流程1', '4112733112893440', '1001', '2001');
INSERT INTO `test_process` VALUES ('10', '10', '4112733112893440', '1001', '2001');
INSERT INTO `test_process` VALUES ('11', '11', '4112733112893440', '1001', '2001');
INSERT INTO `test_process` VALUES ('2', '2', '4112733112893440', '1001', '2001');
INSERT INTO `test_process` VALUES ('3', '3', '4112733112893440', '1001', '2001');
INSERT INTO `test_process` VALUES ('4', '4', '4112733112893440', '1001', '2001');
INSERT INTO `test_process` VALUES ('5', '5', '4112733112893440', '1001', '2001');
INSERT INTO `test_process` VALUES ('6', '6', '4112733112893440', '1001', '2001');
INSERT INTO `test_process` VALUES ('7', '7', '28281555327647744', '1001', '2001');
INSERT INTO `test_process` VALUES ('8', '8', '28281555327647744', '1001', '2001');
INSERT INTO `test_process` VALUES ('9', '9', '28281555327647744', '1001', '2001');

-- ----------------------------
-- View structure for v_aid_college_scholarship
-- ----------------------------
DROP VIEW IF EXISTS `v_aid_college_scholarship`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_aid_college_scholarship` AS select `baf`.`ID` AS `ID`,`baf`.`SO_ID` AS `SO_ID`,`baf`.`BS_ID` AS `BS_ID`,`baf`.`BAF_YEAR` AS `BAF_YEAR`,`baf`.`BAF_SEMESTER` AS `BAF_SEMESTER`,`baf`.`BAF_AID_TYPE` AS `BAF_AID_TYPE`,`baf`.`BUS_PROCESS` AS `BUS_PROCESS`,`baf`.`BUS_PROCESS2` AS `BUS_PROCESS2`,`bs`.`BS_NAME` AS `BS_NAME`,`bs`.`BS_NUMBER` AS `BS_NUMBER`,`bs`.`SO_ID` AS `SHOW_SO_ID`,`bc`.`BC_NAME` AS `BC_NAME`,`bdm`.`BDM_COLLEGE` AS `BDM_COLLEGE`,`bs`.`BDM_ID` AS `BDM_ID`,`bs`.`BC_ID` AS `BC_ID`,`bsc`.`BSC_TOTAL` AS `BSC_TOTAL`,`bsc`.`BSC_RANK` AS `BSC_RANK`,`bsc`.`BSC_ACADEMIC_RECORD` AS `BSC_ACADEMIC_RECORD`,`bsc`.`BSC_INTELLECTUAL_RANK` AS `BSC_INTELLECTUAL_RANK` from ((((`bus_aid_financially` `baf` join `bus_student` `bs` on((`bs`.`ID` = `baf`.`BS_ID`))) join `bus_class` `bc` on((`bc`.`ID` = `bs`.`BC_ID`))) join `bus_department` `bdm` on((`bdm`.`ID` = `bs`.`BDM_ID`))) join `bus_student_comprehensive` `bsc` on(((`bsc`.`BS_ID` = `baf`.`BS_ID`) and (`bsc`.`BSC_YEAR` = `baf`.`BAF_YEAR`) and (`bsc`.`BSC_SEMESTER` = `baf`.`BAF_SEMESTER`)))) where (`baf`.`BAF_TYPE` = 9);

-- ----------------------------
-- View structure for v_aid_commend
-- ----------------------------
DROP VIEW IF EXISTS `v_aid_commend`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_aid_commend` AS select `baf`.`ID` AS `ID`,`baf`.`SO_ID` AS `SO_ID`,`baf`.`BS_ID` AS `BS_ID`,`baf`.`BAF_YEAR` AS `BAF_YEAR`,`baf`.`BAF_SEMESTER` AS `BAF_SEMESTER`,`baf`.`BAF_AID_TYPE` AS `BAF_AID_TYPE`,`baf`.`BUS_PROCESS` AS `BUS_PROCESS`,`baf`.`BUS_PROCESS2` AS `BUS_PROCESS2`,`bs`.`BS_NAME` AS `BS_NAME`,`bs`.`BS_NUMBER` AS `BS_NUMBER`,`bs`.`SO_ID` AS `SHOW_SO_ID`,`bc`.`BC_NAME` AS `BC_NAME`,`bdm`.`BDM_COLLEGE` AS `BDM_COLLEGE`,`bs`.`BDM_ID` AS `BDM_ID`,`bs`.`BC_ID` AS `BC_ID`,`vsay`.`BSC_TOTAL` AS `BSC_TOTAL`,`vsay`.`BSC_TOTAL_RANK` AS `BSC_TOTAL_RANK`,`vsay`.`BSC_ACADEMIC_RECORD` AS `BSC_ACADEMIC_RECORD`,`vsay`.`BSC_ACADEMIC_RECORD_RANK` AS `BSC_ACADEMIC_RECORD_RANK` from ((((`bus_aid_financially` `baf` join `bus_student` `bs` on((`bs`.`ID` = `baf`.`BS_ID`))) join `bus_class` `bc` on((`bc`.`ID` = `bs`.`BC_ID`))) join `bus_department` `bdm` on((`bdm`.`ID` = `bs`.`BDM_ID`))) join `v_student_avg_year` `vsay` on(((`vsay`.`BS_ID` = `baf`.`BS_ID`) and (`vsay`.`BSC_YEAR` = `baf`.`BAF_YEAR`)))) where (`baf`.`BAF_TYPE` = 10);

-- ----------------------------
-- View structure for v_button
-- ----------------------------
DROP VIEW IF EXISTS `v_button`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_button` AS select `sb`.`ID` AS `ID`,`sb`.`SB_NAME` AS `SB_NAME`,`sb`.`SB_BUTTONID` AS `SB_BUTTONID`,`sb`.`SB_ICON` AS `SB_ICON`,`sb`.`SB_CODE` AS `SB_CODE`,`sb`.`SB_ORDER` AS `SB_ORDER`,`sb`.`SB_TYPE` AS `SB_TYPE`,`sdi`.`SDI_NAME` AS `SB_TYPE_NAME` from (`sys_button` `sb` left join `sys_dict_info` `sdi` on(((`sdi`.`SDT_CODE` = 'SYS_BUTTON_TYPE') and (`sdi`.`SDI_CODE` = `sb`.`SB_TYPE`))));

-- ----------------------------
-- View structure for v_class
-- ----------------------------
DROP VIEW IF EXISTS `v_class`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_class` AS select `bc`.`ID` AS `ID`,`bc`.`BDM_ID` AS `BDM_ID`,`bc`.`BC_MAJOR` AS `BC_MAJOR`,`bc`.`BC_NAME` AS `BC_NAME`,`bc`.`BC_YEAR` AS `BC_YEAR`,`bc`.`BC_ENTRY_TIME` AS `BC_ENTRY_TIME`,`bdm`.`BDM_NAME` AS `BDM_NAME`,`sdi`.`SDI_NAME` AS `BC_MAJOR_NAME` from ((`bus_class` `bc` join `bus_department` `bdm` on((`bdm`.`ID` = `bc`.`BDM_ID`))) left join `sys_dict_info` `sdi` on(((`sdi`.`SDT_CODE` = 'BUS_MAJOR') and (convert(`sdi`.`SDI_CODE` using utf8mb4) = `bc`.`BC_MAJOR`))));

-- ----------------------------
-- View structure for v_configure
-- ----------------------------
DROP VIEW IF EXISTS `v_configure`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_configure` AS select `sc`.`ID` AS `ID`,`sc`.`SC_NAME` AS `SC_NAME`,`sc`.`SC_JSP` AS `SC_JSP`,`sc`.`SC_VIEW` AS `SC_VIEW` from `sys_configure` `sc`;

-- ----------------------------
-- View structure for v_configure_column
-- ----------------------------
DROP VIEW IF EXISTS `v_configure_column`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_configure_column` AS select `scc`.`ID` AS `ID`,`scc`.`SC_ID` AS `SC_ID`,`scc`.`SCC_NAME` AS `SCC_NAME`,`scc`.`SCC_FIELD` AS `SCC_FIELD`,`scc`.`SCC_ALIGN` AS `SCC_ALIGN`,`scc`.`SCC_WIDTH` AS `SCC_WIDTH`,`scc`.`SCC_SDT_CODE` AS `SCC_SDT_CODE`,`scc`.`SCC_IS_OPERATION` AS `SCC_IS_OPERATION`,`scc`.`SCC_IS_VISIBLE` AS `SCC_IS_VISIBLE`,`scc`.`SCC_IS_STATUS` AS `SCC_IS_STATUS`,`scc`.`SCC_ORDER` AS `SCC_ORDER` from `sys_configure_column` `scc`;

-- ----------------------------
-- View structure for v_configure_search
-- ----------------------------
DROP VIEW IF EXISTS `v_configure_search`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_configure_search` AS select `scs`.`ID` AS `ID`,`scs`.`SC_ID` AS `SC_ID`,`scs`.`SCS_NAME` AS `SCS_NAME`,`scs`.`SCS_FIELD` AS `SCS_FIELD`,`scs`.`SCS_SDT_CODE` AS `SCS_SDT_CODE`,`scs`.`SCS_METHOD_TYPE` AS `SCS_METHOD_TYPE`,`scs`.`SCS_TYPE` AS `SCS_TYPE`,`scs`.`SCC_IS_VISIBLE` AS `SCC_IS_VISIBLE`,`scs`.`SCS_ORDER` AS `SCS_ORDER`,`scs`.`SCS_REMARK` AS `SCS_REMARK` from `sys_configure_search` `scs`;

-- ----------------------------
-- View structure for v_department
-- ----------------------------
DROP VIEW IF EXISTS `v_department`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_department` AS select `bdm`.`ID` AS `ID`,`bdm`.`BDM_COLLEGE` AS `BDM_COLLEGE`,`bdm`.`BDM_NAME` AS `BDM_NAME`,`bdm`.`BDM_ADDRESS` AS `BDM_ADDRESS`,`bdm`.`BDM_DESCRIBE` AS `BDM_DESCRIBE`,`bdm`.`BDM_ORDER` AS `BDM_ORDER`,`bdm`.`BDM_ENTER_TIME` AS `BDM_ENTER_TIME`,`sdi`.`SDI_NAME` AS `BDM_COLLEGE_NAME` from (`bus_department` `bdm` left join `sys_dict_info` `sdi` on(((`sdi`.`SDT_CODE` = 'BUS_COLLEGE') and (`sdi`.`SDI_CODE` = `bdm`.`BDM_COLLEGE`))));

-- ----------------------------
-- View structure for v_department_personnel
-- ----------------------------
DROP VIEW IF EXISTS `v_department_personnel`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_department_personnel` AS select `bdmp`.`ID` AS `ID`,`bdmp`.`SO_ID` AS `SO_ID`,`bdmp`.`BDM_ID` AS `BDM_ID`,`bdmp`.`BDMP_NAME` AS `BDMP_NAME`,`bdm`.`BDM_NAME` AS `BDM_NAME` from (`bus_department_personnel` `bdmp` join `bus_department` `bdm` on((`bdm`.`ID` = `bdmp`.`BDM_ID`)));

-- ----------------------------
-- View structure for v_dict_info
-- ----------------------------
DROP VIEW IF EXISTS `v_dict_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_dict_info` AS select `sdi`.`ID` AS `ID`,`sdi`.`SDT_ID` AS `SDT_ID`,`sdi`.`SDT_CODE` AS `SDT_CODE`,`sdi`.`SDI_NAME` AS `SDI_NAME`,`sdi`.`SDI_CODE` AS `SDI_CODE`,`sdi`.`SDI_INNERCODE` AS `SDI_INNERCODE`,`sdi`.`SDI_PARENTID` AS `SDI_PARENTID`,`sdi`.`SDI_REMARK` AS `SDI_REMARK`,`sdi`.`SDI_ORDER` AS `SDI_ORDER`,`sdi`.`IS_STATUS` AS `IS_STATUS` from `sys_dict_info` `sdi`;

-- ----------------------------
-- View structure for v_dict_type
-- ----------------------------
DROP VIEW IF EXISTS `v_dict_type`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_dict_type` AS select `sdt`.`ID` AS `ID`,`sdt`.`SDT_NAME` AS `SDT_NAME`,`sdt`.`SDT_CODE` AS `SDT_CODE`,`sdt`.`IS_STATUS` AS `IS_STATUS` from `sys_dict_type` `sdt`;

-- ----------------------------
-- View structure for v_division
-- ----------------------------
DROP VIEW IF EXISTS `v_division`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_division` AS select `bd`.`ID` AS `ID`,`bd`.`BD_PARENT_ID` AS `BD_PARENT_ID`,`bd`.`BD_NAME` AS `BD_NAME`,`bd`.`BD_CONTACTS` AS `BD_CONTACTS`,`bd`.`BD_PHONE` AS `BD_PHONE`,`bd`.`BD_FIXED_PHONE` AS `BD_FIXED_PHONE`,`bd`.`BD_EMAIL` AS `BD_EMAIL`,`bd`.`BD_ADDRESS` AS `BD_ADDRESS`,`bd`.`BD_DESCRIBE` AS `BD_DESCRIBE`,`bd`.`BD_ORDER` AS `BD_ORDER`,`bd`.`BD_ENTER_TIME` AS `BD_ENTER_TIME`,`pbd`.`BD_NAME` AS `BD_PARENT_NAME` from (`bus_division` `bd` left join `bus_division` `pbd` on((`pbd`.`ID` = `bd`.`BD_PARENT_ID`)));

-- ----------------------------
-- View structure for v_division_personnel
-- ----------------------------
DROP VIEW IF EXISTS `v_division_personnel`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_division_personnel` AS select `bdp`.`ID` AS `ID`,`bdp`.`SO_ID` AS `SO_ID`,`bdp`.`BD_ID` AS `BD_ID`,`bdp`.`BDP_NAME` AS `BDP_NAME`,`bd`.`BD_NAME` AS `BD_NAME` from (`bus_division_personnel` `bdp` join `bus_division` `bd` on((`bd`.`ID` = `bdp`.`BD_ID`)));

-- ----------------------------
-- View structure for v_format
-- ----------------------------
DROP VIEW IF EXISTS `v_format`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_format` AS select `sf`.`ID` AS `ID`,`sf`.`SF_NAME` AS `SF_NAME`,`sf`.`SF_CODE` AS `SF_CODE`,`sf`.`SF_YEAR` AS `SF_YEAR`,`sf`.`SF_ENTRY_TIME` AS `SF_ENTRY_TIME` from `sys_format` `sf`;

-- ----------------------------
-- View structure for v_format_detail
-- ----------------------------
DROP VIEW IF EXISTS `v_format_detail`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_format_detail` AS select `sfd`.`ID` AS `ID`,`sfd`.`SF_ID` AS `SF_ID`,`sfd`.`SM_ID` AS `SM_ID`,`sfd`.`SFD_PARENT_ID` AS `SFD_PARENT_ID`,`sfd`.`SFD_NAME` AS `SFD_NAME`,`sfd`.`SFD_ORDER` AS `SFD_ORDER`,`sfd`.`IS_STATUS` AS `IS_STATUS`,`sm`.`SM_NAME` AS `SM_NAME` from (`sys_format_detail` `sfd` left join `sys_menu` `sm` on((convert(`sm`.`ID` using utf8mb4) = `sfd`.`SM_ID`)));

-- ----------------------------
-- View structure for v_log_personal
-- ----------------------------
DROP VIEW IF EXISTS `v_log_personal`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_log_personal` AS select `sl`.`ID` AS `ID`,`sl`.`SO_ID` AS `SO_ID`,`sl`.`SL_NAME` AS `SL_NAME`,`sl`.`SL_EVENT` AS `SL_EVENT`,`sl`.`SL_IP` AS `SL_IP`,`sl`.`SL_RESULT` AS `SL_RESULT`,`sl`.`SL_ENTERTIME` AS `SL_ENTERTIME`,`sl`.`SL_ENTERTIME` AS `SL_ENDTIME`,`slt`.`SLT_CONTENT` AS `SLT_CONTENT`,`sai`.`SAI_NAME` AS `SAI_NAME` from ((`sys_log` `sl` left join `sys_log_text` `slt` on((`slt`.`SL_ID` = `sl`.`ID`))) left join `sys_account_info` `sai` on((`sai`.`SO_ID` = `sl`.`SO_ID`))) where (`sl`.`SL_TYPE` = 9);

-- ----------------------------
-- View structure for v_log_see
-- ----------------------------
DROP VIEW IF EXISTS `v_log_see`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_log_see` AS select `sl`.`ID` AS `ID`,`sl`.`SO_ID` AS `SO_ID`,`sl`.`SL_NAME` AS `SL_NAME`,`sl`.`SL_EVENT` AS `SL_EVENT`,`sl`.`SL_IP` AS `SL_IP`,`sl`.`SL_RESULT` AS `SL_RESULT`,`sl`.`SL_ENTERTIME` AS `SL_ENTERTIME`,`sl`.`SL_ENTERTIME` AS `SL_ENDTIME`,`slt`.`SLT_CONTENT` AS `SLT_CONTENT`,`sai`.`SAI_NAME` AS `SAI_NAME` from ((`sys_log` `sl` left join `sys_log_text` `slt` on((`slt`.`SL_ID` = `sl`.`ID`))) left join `sys_account_info` `sai` on((`sai`.`SO_ID` = `sl`.`SO_ID`))) where (`sl`.`SL_TYPE` = 0);

-- ----------------------------
-- View structure for v_log_system
-- ----------------------------
DROP VIEW IF EXISTS `v_log_system`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_log_system` AS select `sl`.`ID` AS `ID`,`sl`.`SO_ID` AS `SO_ID`,`sl`.`SL_NAME` AS `SL_NAME`,`sl`.`SL_EVENT` AS `SL_EVENT`,`sl`.`SL_IP` AS `SL_IP`,`sl`.`SL_RESULT` AS `SL_RESULT`,`sl`.`SL_ENTERTIME` AS `SL_ENTERTIME`,`sl`.`SL_ENTERTIME` AS `SL_ENDTIME`,`slt`.`SLT_CONTENT` AS `SLT_CONTENT`,`sai`.`SAI_NAME` AS `SAI_NAME` from ((`sys_log` `sl` left join `sys_log_text` `slt` on((`slt`.`SL_ID` = `sl`.`ID`))) left join `sys_account_info` `sai` on((`sai`.`SO_ID` = `sl`.`SO_ID`))) where (`sl`.`SL_TYPE` = 1);

-- ----------------------------
-- View structure for v_log_use
-- ----------------------------
DROP VIEW IF EXISTS `v_log_use`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_log_use` AS select `sl`.`ID` AS `ID`,`sl`.`SO_ID` AS `SO_ID`,`sl`.`SL_NAME` AS `SL_NAME`,`sl`.`SL_EVENT` AS `SL_EVENT`,`sl`.`SL_IP` AS `SL_IP`,`sl`.`SL_RESULT` AS `SL_RESULT`,`sl`.`SL_ENTERTIME` AS `SL_ENTERTIME`,`sl`.`SL_ENTERTIME` AS `SL_ENDTIME`,`slt`.`SLT_CONTENT` AS `SLT_CONTENT`,`sai`.`SAI_NAME` AS `SAI_NAME` from ((`sys_log` `sl` left join `sys_log_text` `slt` on((`slt`.`SL_ID` = `sl`.`ID`))) left join `sys_account_info` `sai` on((`sai`.`SO_ID` = `sl`.`SO_ID`))) where (`sl`.`SL_TYPE` = 2);

-- ----------------------------
-- View structure for v_menu
-- ----------------------------
DROP VIEW IF EXISTS `v_menu`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_menu` AS select `sm`.`ID` AS `ID`,`sm`.`SC_ID` AS `SC_ID`,`sm`.`SM_NAME` AS `SM_NAME`,`sm`.`SM_PARENTID` AS `SM_PARENTID`,`sm`.`SM_CODE` AS `SM_CODE`,`sm`.`SM_URL` AS `SM_URL`,`sm`.`SM_CLASSICON` AS `SM_CLASSICON`,`sm`.`SM_IS_LEAF` AS `SM_IS_LEAF`,`sm`.`SM_IS_EXPAND` AS `SM_IS_EXPAND`,`sm`.`SM_TYPE` AS `SM_TYPE`,`sm`.`SM_ORDER` AS `SM_ORDER`,`sm`.`IS_STATUS` AS `IS_STATUS`,`sc`.`SC_NAME` AS `SC_NAME` from (`sys_menu` `sm` left join `sys_configure` `sc` on((`sc`.`ID` = `sm`.`SC_ID`)));

-- ----------------------------
-- View structure for v_operator
-- ----------------------------
DROP VIEW IF EXISTS `v_operator`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_operator` AS select `so`.`ID` AS `ID`,`so`.`IS_STATUS` AS `IS_STATUS`,`sai`.`SAI_NAME` AS `SAI_NAME`,`sai`.`SAI_PHONE` AS `SAI_PHONE`,`sai`.`SAI_EMAIL` AS `SAI_EMAIL`,`sos`.`SOS_USERNAME` AS `SOS_USERNAME`,`sai`.`SAI_TYPE` AS `SAI_TYPE` from ((`sys_operator` `so` join `sys_account_info` `sai` on((`sai`.`SO_ID` = `so`.`ID`))) left join (select `sos`.`SO_ID` AS `SO_ID`,group_concat(distinct `sos`.`SOS_USERNAME` separator ',') AS `SOS_USERNAME` from `sys_operator_sub` `sos` group by `sos`.`SO_ID`) `sos` on((`sos`.`SO_ID` = `so`.`ID`)));

-- ----------------------------
-- View structure for v_operator_sub
-- ----------------------------
DROP VIEW IF EXISTS `v_operator_sub`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_operator_sub` AS select `sos`.`ID` AS `ID`,`sos`.`SO_ID` AS `SO_ID`,`sos`.`SOS_USERNAME` AS `SOS_USERNAME`,`sos`.`SOS_CREATETIME` AS `SOS_CREATETIME`,`sos`.`SOS_REMARK` AS `SOS_REMARK`,`sos`.`SOS_DEFAULT` AS `SOS_DEFAULT`,`sos`.`IS_STATUS` AS `IS_STATUS` from `sys_operator_sub` `sos`;

-- ----------------------------
-- View structure for v_process_definition
-- ----------------------------
DROP VIEW IF EXISTS `v_process_definition`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_process_definition` AS select `spd`.`ID` AS `ID`,`spd`.`SO_ID` AS `SO_ID`,`spd`.`SR_ID` AS `SR_ID`,`spd`.`BUS_PROCESS` AS `BUS_PROCESS`,`spd`.`BUS_PROCESS2` AS `BUS_PROCESS2`,`spd`.`SPD_NAME` AS `SPD_NAME`,`spd`.`SPD_VERSION` AS `SPD_VERSION`,`spd`.`SPD_UPDATE_TABLE` AS `SPD_UPDATE_TABLE`,`spd`.`SPD_UPDATE_NAME` AS `SPD_UPDATE_NAME`,`spd`.`SPD_COLLEGE_FIELD` AS `SPD_COLLEGE_FIELD`,`spd`.`SPD_DEPARTMENT_FIELD` AS `SPD_DEPARTMENT_FIELD`,`spd`.`SPD_CLASS_FIELD` AS `SPD_CLASS_FIELD`,`spd`.`SPD_DESCRIBE` AS `SPD_DESCRIBE`,`spd`.`SDP_ENTRY_TIME` AS `SDP_ENTRY_TIME`,`spd`.`IS_STATUS` AS `IS_STATUS`,`spd`.`IS_MULTISTAGE_BACK` AS `IS_MULTISTAGE_BACK` from `sys_process_definition` `spd`;

-- ----------------------------
-- View structure for v_process_schedule
-- ----------------------------
DROP VIEW IF EXISTS `v_process_schedule`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_process_schedule` AS select `sps`.`ID` AS `ID`,`sps`.`SO_ID` AS `SO_ID`,`sps`.`SHOW_SO_ID` AS `SHOW_SO_ID`,`sps`.`SPD_ID` AS `SPD_ID`,`sps`.`SPS_ID` AS `SPS_ID`,`sps`.`SPS_TABLE_ID` AS `SPS_TABLE_ID`,`sps`.`SPS_TABLE_NAME` AS `SPS_TABLE_NAME`,`sps`.`SPS_AUDIT_STATUS` AS `SPS_AUDIT_STATUS`,`sps`.`SPS_BACK_STATUS` AS `SPS_BACK_STATUS`,`sps`.`SPS_BACK_STATUS_TRANSACTOR` AS `SPS_BACK_STATUS_TRANSACTOR`,`sps`.`SPS_STEP_TYPE` AS `SPS_STEP_TYPE`,`sps`.`SPS_STEP_TRANSACTOR` AS `SPS_STEP_TRANSACTOR`,`sps`.`SPS_PREV_AUDIT_STATUS` AS `SPS_PREV_AUDIT_STATUS`,`sps`.`SPS_PREV_STEP_TYPE` AS `SPS_PREV_STEP_TYPE`,`sps`.`SPS_PREV_STEP_TRANSACTOR` AS `SPS_PREV_STEP_TRANSACTOR`,`sps`.`SPS_PREV_STEP_ID` AS `SPS_PREV_STEP_ID`,`sps`.`SPS_IS_CANCEL` AS `SPS_IS_CANCEL`,`spd`.`SPD_NAME` AS `SPD_NAME`,`sai`.`SAI_NAME` AS `INITIATOR_NAME`,`saic`.`SAI_NAME` AS `CANCEL_NAME`,`spsc`.`ID` AS `SPSC_ID`,`spsc`.`SPSC_REASON` AS `SPSC_REASON`,`spsc`.`SPSC_ENTRY_TIME` AS `SPSC_ENTRY_TIME`,`sdi`.`SDI_NAME` AS `PROCESS_STATUS_NAME`,`spt`.`SPS_NAME` AS `STEP_NAME` from ((((((`sys_process_schedule` `sps` left join `sys_process_step` `spt` on((`spt`.`ID` = `sps`.`SPS_ID`))) left join `sys_process_definition` `spd` on((`spd`.`ID` = `sps`.`SPD_ID`))) left join `sys_process_schedule_cancel` `spsc` on((`spsc`.`SPS_ID` = convert(`sps`.`ID` using utf8mb4)))) left join `sys_account_info` `sai` on((`sai`.`SO_ID` = `sps`.`SO_ID`))) left join `sys_account_info` `saic` on((convert(`saic`.`SO_ID` using utf8mb4) = `spsc`.`SO_ID`))) left join `sys_dict_info` `sdi` on(((`sdi`.`SDT_CODE` = 'SYS_PROCESS_STATUS') and (`sdi`.`SDI_CODE` = `sps`.`SPS_AUDIT_STATUS`))));

-- ----------------------------
-- View structure for v_process_start
-- ----------------------------
DROP VIEW IF EXISTS `v_process_start`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_process_start` AS select `sps`.`ID` AS `ID`,`sps`.`SPD_ID` AS `SPD_ID`,`sps`.`SR_ID` AS `SR_ID`,`sr`.`SR_NAME` AS `SR_NAME`,`sr`.`SR_CODE` AS `SR_CODE` from (`sys_process_start` `sps` left join `sys_role` `sr` on((`sr`.`ID` = `sps`.`SR_ID`)));

-- ----------------------------
-- View structure for v_process_step
-- ----------------------------
DROP VIEW IF EXISTS `v_process_step`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_process_step` AS select `sps`.`ID` AS `ID`,`sps`.`SPD_ID` AS `SPD_ID`,`sps`.`SR_ID` AS `SR_ID`,`sps`.`SPS_NAME` AS `SPS_NAME`,`sps`.`SPS_ORDER` AS `SPS_ORDER`,`sps`.`SPS_STEP_TYPE` AS `SPS_STEP_TYPE`,`sps`.`SPS_PROCESS_STATUS` AS `SPS_PROCESS_STATUS`,`sps`.`SPS_IS_OVER_TIME` AS `SPS_IS_OVER_TIME`,`sps`.`SPS_OVER_TIME` AS `SPS_OVER_TIME`,`sps`.`SPS_TAB` AS `SPS_TAB`,`sps`.`SPS_IS_ADVANCE_CHECK` AS `SPS_IS_ADVANCE_CHECK`,`sps`.`SPS_IS_RETREAT_CHECK` AS `SPS_IS_RETREAT_CHECK`,`sps`.`SPS_IS_ADVANCE_EXECUTE` AS `SPS_IS_ADVANCE_EXECUTE`,`sps`.`SPS_IS_RETREAT_EXECUTE` AS `SPS_IS_RETREAT_EXECUTE`,`sr`.`SR_NAME` AS `SR_NAME` from (`sys_process_step` `sps` left join `sys_role` `sr` on((`sr`.`ID` = `sps`.`SR_ID`)));

-- ----------------------------
-- View structure for v_role
-- ----------------------------
DROP VIEW IF EXISTS `v_role`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_role` AS select `sr`.`ID` AS `ID`,`sr`.`SR_TYPE` AS `SR_TYPE`,`sr`.`SR_CODE` AS `SR_CODE`,`sr`.`SR_NAME` AS `SR_NAME`,`sr`.`SR_EXPLAIN` AS `SR_EXPLAIN`,`sr`.`SR_REMARK` AS `SR_REMARK`,`sr`.`IS_STATUS` AS `IS_STATUS` from `sys_role` `sr`;

-- ----------------------------
-- View structure for v_student
-- ----------------------------
DROP VIEW IF EXISTS `v_student`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_student` AS select `bs`.`ID` AS `ID`,`bdm`.`BDM_COLLEGE` AS `BDM_COLLEGE`,`bs`.`BDM_ID` AS `BDM_ID`,`bs`.`BC_ID` AS `BC_ID`,`bs`.`BS_NAME` AS `BS_NAME`,`bs`.`BS_NUMBER` AS `BS_NUMBER`,`bs`.`BS_LENGTH` AS `BS_LENGTH`,`bs`.`BS_ID_CARD` AS `BS_ID_CARD`,`bs`.`BS_SEX` AS `BS_SEX`,`bs`.`BS_NATION` AS `BS_NATION`,`bs`.`SO_ID` AS `SO_ID`,`sdi`.`SDI_NAME` AS `BS_SEX_NAME`,`ndi`.`SDI_NAME` AS `BS_NATION_NAME`,`bdm`.`BDM_NAME` AS `BDM_NAME`,`bc`.`BC_NAME` AS `BC_NAME` from ((((`bus_student` `bs` join `bus_department` `bdm` on((`bdm`.`ID` = `bs`.`BDM_ID`))) join `bus_class` `bc` on((`bc`.`ID` = `bs`.`BC_ID`))) left join `sys_dict_info` `sdi` on(((`sdi`.`SDT_CODE` = 'BUS_SEX') and (convert(`sdi`.`SDI_CODE` using utf8mb4) = `bs`.`BS_SEX`)))) left join `sys_dict_info` `ndi` on(((`ndi`.`SDT_CODE` = 'BUS_NATION') and (convert(`ndi`.`SDI_CODE` using utf8mb4) = `bs`.`BS_NATION`))));

-- ----------------------------
-- View structure for v_student_attendance
-- ----------------------------
DROP VIEW IF EXISTS `v_student_attendance`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_student_attendance` AS select `bsa`.`ID` AS `ID`,`bsa`.`BS_ID` AS `BS_ID`,`bsa`.`BSA_YEAR` AS `BSA_YEAR`,`bsa`.`BSA_SEMESTER` AS `BSA_SEMESTER`,`bsa`.`BSA_WEEK` AS `BSA_WEEK`,`bsa`.`BSA_LATE` AS `BSA_LATE`,`bsa`.`BSA_ABSENTEEISM` AS `BSA_ABSENTEEISM`,`bsa`.`BSA_ENTRY_TIME` AS `BSA_ENTRY_TIME`,`bs`.`BS_NAME` AS `BS_NAME`,`bc`.`BC_NAME` AS `BC_NAME`,`bdm`.`BDM_COLLEGE` AS `BDM_COLLEGE`,`bs`.`BDM_ID` AS `BDM_ID`,`bs`.`BC_ID` AS `BC_ID` from (((`bus_student_attendance` `bsa` join `bus_student` `bs` on((`bs`.`ID` = `bsa`.`BS_ID`))) join `bus_class` `bc` on((`bc`.`ID` = `bs`.`BC_ID`))) join `bus_department` `bdm` on((`bdm`.`ID` = `bs`.`BDM_ID`)));

-- ----------------------------
-- View structure for v_student_avg_year
-- ----------------------------
DROP VIEW IF EXISTS `v_student_avg_year`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_student_avg_year` AS select `bsc`.`BS_ID` AS `BS_ID`,`bsc`.`BC_ID` AS `BC_ID`,`bsc`.`BSC_YEAR` AS `BSC_YEAR`,`bsc`.`BSC_TOTAL` AS `BSC_TOTAL`,`bsc`.`BSC_ACADEMIC_RECORD` AS `BSC_ACADEMIC_RECORD`,(select (count(0) + 1) from (select `bsc`.`BS_ID` AS `BS_ID`,`bs`.`BC_ID` AS `BC_ID`,`bsc`.`BSC_YEAR` AS `BSC_YEAR`,avg(`bsc`.`BSC_TOTAL`) AS `BSC_TOTAL` from (`bus_student_comprehensive` `bsc` join `bus_student` `bs` on((`bs`.`ID` = `bsc`.`BS_ID`))) group by `bsc`.`BS_ID`,`bsc`.`BSC_YEAR`) `s` where ((`s`.`BC_ID` = `bsc`.`BC_ID`) and (`s`.`BSC_YEAR` = `bsc`.`BSC_YEAR`) and (`s`.`BSC_TOTAL` > `bsc`.`BSC_TOTAL`))) AS `BSC_TOTAL_RANK`,(select (count(0) + 1) from (select `bsc`.`BS_ID` AS `BS_ID`,`bs`.`BC_ID` AS `BC_ID`,`bsc`.`BSC_YEAR` AS `BSC_YEAR`,avg(`bsc`.`BSC_TOTAL`) AS `BSC_TOTAL`,avg(`bsc`.`BSC_ACADEMIC_RECORD`) AS `BSC_ACADEMIC_RECORD` from (`bus_student_comprehensive` `bsc` join `bus_student` `bs` on((`bs`.`ID` = `bsc`.`BS_ID`))) group by `bsc`.`BS_ID`,`bsc`.`BSC_YEAR`) `s` where ((`s`.`BC_ID` = `bsc`.`BC_ID`) and (`s`.`BSC_YEAR` = `bsc`.`BSC_YEAR`) and (`s`.`BSC_ACADEMIC_RECORD` > `bsc`.`BSC_ACADEMIC_RECORD`))) AS `BSC_ACADEMIC_RECORD_RANK` from (select `bsc`.`BS_ID` AS `BS_ID`,`bs`.`BC_ID` AS `BC_ID`,`bsc`.`BSC_YEAR` AS `BSC_YEAR`,avg(`bsc`.`BSC_TOTAL`) AS `BSC_TOTAL`,avg(`bsc`.`BSC_ACADEMIC_RECORD`) AS `BSC_ACADEMIC_RECORD` from (`bus_student_comprehensive` `bsc` join `bus_student` `bs` on((`bs`.`ID` = `bsc`.`BS_ID`))) group by `bsc`.`BS_ID`,`bsc`.`BSC_YEAR`) `bsc`;

-- ----------------------------
-- View structure for v_student_comprehensive
-- ----------------------------
DROP VIEW IF EXISTS `v_student_comprehensive`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_student_comprehensive` AS select `bsc`.`ID` AS `ID`,`bsc`.`BSC_YEAR` AS `BSC_YEAR`,`bsc`.`BSC_SEMESTER` AS `BSC_SEMESTER`,`bsc`.`BSC_TOTAL` AS `BSC_TOTAL`,`bsc`.`BSC_RANK` AS `BSC_RANK`,`bsc`.`BSC_ACADEMIC_RECORD` AS `BSC_ACADEMIC_RECORD`,`bsc`.`BSC_INTELLECTUAL_RANK` AS `BSC_INTELLECTUAL_RANK`,`bs`.`BS_NAME` AS `BS_NAME`,`bs`.`BS_NUMBER` AS `BS_NUMBER`,`bc`.`BC_NAME` AS `BC_NAME`,`bdm`.`BDM_COLLEGE` AS `BDM_COLLEGE`,`bs`.`BDM_ID` AS `BDM_ID`,`bs`.`BC_ID` AS `BC_ID` from (((`bus_student_comprehensive` `bsc` join `bus_student` `bs` on((`bs`.`ID` = `bsc`.`BS_ID`))) join `bus_class` `bc` on((`bc`.`ID` = `bs`.`BC_ID`))) join `bus_department` `bdm` on((`bdm`.`ID` = `bs`.`BDM_ID`)));

-- ----------------------------
-- View structure for v_student_punishment
-- ----------------------------
DROP VIEW IF EXISTS `v_student_punishment`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_student_punishment` AS select `bsp`.`ID` AS `ID`,`bsp`.`BS_ID` AS `BS_ID`,`bsp`.`BSP_TITLE` AS `BSP_TITLE`,`bsp`.`BSP_FILE_NUMBER` AS `BSP_FILE_NUMBER`,`bsp`.`BSP_RELEASE_TIME` AS `BSP_RELEASE_TIME`,`bsp`.`BSP_TYPE` AS `BSP_TYPE`,`bsp`.`BSP_REVOKE_TIME` AS `BSP_REVOKE_TIME`,`bsp`.`BSP_DESCRIBE` AS `BSP_DESCRIBE`,`bsp`.`BSP_IS_CANCEL` AS `BSP_IS_CANCEL`,`bsp`.`BSP_CANCEL_TIME` AS `BSP_CANCEL_TIME`,`bsp`.`BSP_ENTRY_TIME` AS `BSP_ENTRY_TIME`,`bs`.`BS_NAME` AS `BS_NAME`,`bc`.`BC_NAME` AS `BC_NAME`,`bdm`.`BDM_COLLEGE` AS `BDM_COLLEGE`,`bs`.`BDM_ID` AS `BDM_ID`,`bs`.`BC_ID` AS `BC_ID` from (((`bus_student_punishment` `bsp` join `bus_student` `bs` on((`bs`.`ID` = `bsp`.`BS_ID`))) join `bus_class` `bc` on((`bc`.`ID` = `bs`.`BC_ID`))) join `bus_department` `bdm` on((`bdm`.`ID` = `bs`.`BDM_ID`)));

-- ----------------------------
-- View structure for v_teacher
-- ----------------------------
DROP VIEW IF EXISTS `v_teacher`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_teacher` AS select `bt`.`ID` AS `ID`,`bt`.`SO_ID` AS `SO_ID`,`bt`.`BDM_ID` AS `BDM_ID`,`bt`.`BT_NAME` AS `BT_NAME`,`bt`.`BT_NUMBER` AS `BT_NUMBER`,`bt`.`BT_ENTRY_TIME` AS `BT_ENTRY_TIME`,`bdm`.`BDM_NAME` AS `BDM_NAME` from (`bus_teacher` `bt` join `bus_department` `bdm` on((`bdm`.`ID` = `bt`.`BDM_ID`)));

-- ----------------------------
-- View structure for v_test_process
-- ----------------------------
DROP VIEW IF EXISTS `v_test_process`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_test_process` AS select `test_process`.`ID` AS `ID`,`test_process`.`NAME` AS `NAME`,`test_process`.`SO_ID` AS `SO_ID`,`test_process`.`BUS_PROCESS` AS `BUS_PROCESS`,`test_process`.`BUS_PROCESS2` AS `BUS_PROCESS2` from `test_process`;

-- ----------------------------
-- View structure for v_validate
-- ----------------------------
DROP VIEW IF EXISTS `v_validate`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_validate` AS select `sv`.`ID` AS `ID`,`sv`.`SV_TABLE` AS `SV_TABLE`,`sv`.`IS_STATUS` AS `IS_STATUS` from `sys_validate` `sv`;

-- ----------------------------
-- View structure for v_validate_field
-- ----------------------------
DROP VIEW IF EXISTS `v_validate_field`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_validate_field` AS select `svf`.`ID` AS `ID`,`svf`.`SV_ID` AS `SV_ID`,`svf`.`SVF_NAME` AS `SVF_NAME`,`svf`.`SVF_FIELD` AS `SVF_FIELD`,`svf`.`SVF_IS_REQUIRED` AS `SVF_IS_REQUIRED`,`svf`.`SVF_MIN_LENGTH` AS `SVF_MIN_LENGTH`,`svf`.`SVF_MAX_LENGTH` AS `SVF_MAX_LENGTH`,`svf`.`SVR_ID` AS `SVR_ID`,`svf`.`IS_STATUS` AS `IS_STATUS`,`svr`.`SVR_NAME` AS `SVR_NAME`,`svg`.`SVG_GROUPS` AS `SVG_GROUPS` from ((`sys_validate_field` `svf` left join `sys_validate_regex` `svr` on((`svr`.`ID` = `svf`.`SVR_ID`))) left join (select `svgf`.`SVF_ID` AS `SVF_ID`,group_concat(`svg`.`SVG_GROUP` order by cast(`svg`.`ID` as signed) ASC separator ',') AS `SVG_GROUPS` from (`sys_validate_group` `svg` join `sys_validate_group_field` `svgf` on((`svgf`.`SVG_ID` = `svg`.`ID`))) group by `svg`.`SV_ID`,`svgf`.`SVF_ID` order by cast(`svg`.`ID` as signed)) `svg` on((`svf`.`ID` = `svg`.`SVF_ID`)));

-- ----------------------------
-- View structure for v_validate_group
-- ----------------------------
DROP VIEW IF EXISTS `v_validate_group`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_validate_group` AS select `svg`.`ID` AS `ID`,`svg`.`SV_ID` AS `SV_ID`,`svg`.`SVG_GROUP` AS `SVG_GROUP`,`svgf`.`SVF_NAMES` AS `SVF_NAMES` from (`sys_validate_group` `svg` left join (select `svgf`.`SVG_ID` AS `SVG_ID`,group_concat(`svf`.`SVF_NAME` separator ',') AS `SVF_NAMES` from (`sys_validate_group_field` `svgf` join `sys_validate_field` `svf` on((`svf`.`ID` = `svgf`.`SVF_ID`))) group by `svgf`.`SVG_ID`) `svgf` on((`svgf`.`SVG_ID` = `svg`.`ID`)));

-- ----------------------------
-- View structure for v_validate_regex
-- ----------------------------
DROP VIEW IF EXISTS `v_validate_regex`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_validate_regex` AS select `svr`.`ID` AS `ID`,`svr`.`SVR_NAME` AS `SVR_NAME`,`svr`.`SVR_REGEX` AS `SVR_REGEX`,`svr`.`SVR_REGEX_MESSAGE` AS `SVR_REGEX_MESSAGE`,`svr`.`IS_STATUS` AS `IS_STATUS` from `sys_validate_regex` `svr`;

SET FOREIGN_KEY_CHECKS = 1;
