/*
 Navicat Premium Data Transfer

 Source Server         : 本地数据库mysql
 Source Server Type    : MySQL
 Source Server Version : 100428
 Source Host           : localhost:3306
 Source Schema         : hotel_management_db

 Target Server Type    : MySQL
 Target Server Version : 100428
 File Encoding         : 65001

 Date: 10/03/2025 11:19:34
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'group' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group
-- ----------------------------
INSERT INTO `auth_group` VALUES (1, '顾客');

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id`, `permission_id`) USING BTREE,
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'group-permission relationship' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------
INSERT INTO `auth_group_permissions` VALUES (1, 1, 33);
INSERT INTO `auth_group_permissions` VALUES (2, 1, 34);
INSERT INTO `auth_group_permissions` VALUES (3, 1, 35);
INSERT INTO `auth_group_permissions` VALUES (4, 1, 36);
INSERT INTO `auth_group_permissions` VALUES (5, 1, 57);
INSERT INTO `auth_group_permissions` VALUES (6, 1, 58);
INSERT INTO `auth_group_permissions` VALUES (7, 1, 59);
INSERT INTO `auth_group_permissions` VALUES (8, 1, 60);

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id`, `codename`) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 61 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'permission' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO `auth_permission` VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO `auth_permission` VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO `auth_permission` VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO `auth_permission` VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO `auth_permission` VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO `auth_permission` VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO `auth_permission` VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO `auth_permission` VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO `auth_permission` VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO `auth_permission` VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO `auth_permission` VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO `auth_permission` VALUES (13, 'Can add user', 4, 'add_user');
INSERT INTO `auth_permission` VALUES (14, 'Can change user', 4, 'change_user');
INSERT INTO `auth_permission` VALUES (15, 'Can delete user', 4, 'delete_user');
INSERT INTO `auth_permission` VALUES (16, 'Can view user', 4, 'view_user');
INSERT INTO `auth_permission` VALUES (17, 'Can add content type', 5, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (18, 'Can change content type', 5, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (19, 'Can delete content type', 5, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (20, 'Can view content type', 5, 'view_contenttype');
INSERT INTO `auth_permission` VALUES (21, 'Can add session', 6, 'add_session');
INSERT INTO `auth_permission` VALUES (22, 'Can change session', 6, 'change_session');
INSERT INTO `auth_permission` VALUES (23, 'Can delete session', 6, 'delete_session');
INSERT INTO `auth_permission` VALUES (24, 'Can view session', 6, 'view_session');
INSERT INTO `auth_permission` VALUES (25, 'Can add room', 7, 'add_room');
INSERT INTO `auth_permission` VALUES (26, 'Can change room', 7, 'change_room');
INSERT INTO `auth_permission` VALUES (27, 'Can delete room', 7, 'delete_room');
INSERT INTO `auth_permission` VALUES (28, 'Can view room', 7, 'view_room');
INSERT INTO `auth_permission` VALUES (29, 'Can add customer', 8, 'add_customer');
INSERT INTO `auth_permission` VALUES (30, 'Can change customer', 8, 'change_customer');
INSERT INTO `auth_permission` VALUES (31, 'Can delete customer', 8, 'delete_customer');
INSERT INTO `auth_permission` VALUES (32, 'Can view customer', 8, 'view_customer');
INSERT INTO `auth_permission` VALUES (33, 'Can add reservation', 9, 'add_reservation');
INSERT INTO `auth_permission` VALUES (34, 'Can change reservation', 9, 'change_reservation');
INSERT INTO `auth_permission` VALUES (35, 'Can delete reservation', 9, 'delete_reservation');
INSERT INTO `auth_permission` VALUES (36, 'Can view reservation', 9, 'view_reservation');
INSERT INTO `auth_permission` VALUES (37, 'Can add expense', 10, 'add_expense');
INSERT INTO `auth_permission` VALUES (38, 'Can change expense', 10, 'change_expense');
INSERT INTO `auth_permission` VALUES (39, 'Can delete expense', 10, 'delete_expense');
INSERT INTO `auth_permission` VALUES (40, 'Can view expense', 10, 'view_expense');
INSERT INTO `auth_permission` VALUES (41, 'Can add income', 11, 'add_income');
INSERT INTO `auth_permission` VALUES (42, 'Can change income', 11, 'change_income');
INSERT INTO `auth_permission` VALUES (43, 'Can delete income', 11, 'delete_income');
INSERT INTO `auth_permission` VALUES (44, 'Can view income', 11, 'view_income');
INSERT INTO `auth_permission` VALUES (45, 'Can add employee', 12, 'add_employee');
INSERT INTO `auth_permission` VALUES (46, 'Can change employee', 12, 'change_employee');
INSERT INTO `auth_permission` VALUES (47, 'Can delete employee', 12, 'delete_employee');
INSERT INTO `auth_permission` VALUES (48, 'Can view employee', 12, 'view_employee');
INSERT INTO `auth_permission` VALUES (49, 'Can add 用户', 13, 'add_customuser');
INSERT INTO `auth_permission` VALUES (50, 'Can change 用户', 13, 'change_customuser');
INSERT INTO `auth_permission` VALUES (51, 'Can delete 用户', 13, 'delete_customuser');
INSERT INTO `auth_permission` VALUES (52, 'Can view 用户', 13, 'view_customuser');
INSERT INTO `auth_permission` VALUES (53, 'Can add 运营指标', 14, 'add_dashboardmetric');
INSERT INTO `auth_permission` VALUES (54, 'Can change 运营指标', 14, 'change_dashboardmetric');
INSERT INTO `auth_permission` VALUES (55, 'Can delete 运营指标', 14, 'delete_dashboardmetric');
INSERT INTO `auth_permission` VALUES (56, 'Can view 运营指标', 14, 'view_dashboardmetric');
INSERT INTO `auth_permission` VALUES (57, 'Can add 订单评价', 15, 'add_orderreview');
INSERT INTO `auth_permission` VALUES (58, 'Can change 订单评价', 15, 'change_orderreview');
INSERT INTO `auth_permission` VALUES (59, 'Can delete 订单评价', 15, 'delete_orderreview');
INSERT INTO `auth_permission` VALUES (60, 'Can view 订单评价', 15, 'view_orderreview');

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_login` datetime(6) NULL DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `first_name` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_name` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'user' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
INSERT INTO `auth_user` VALUES (1, 'pbkdf2_sha256$600000$k3jggXPi7lWW586H7pIvSn$qM4sxEZEojXAUNcGETpU8jNKVrlH9xE/wWHuMYv/Eho=', '2025-03-08 15:42:26.380705', 1, 'admin', '', '', 'admin@163.com', 1, 1, '2025-01-07 08:17:17.712962');
INSERT INTO `auth_user` VALUES (4, 'pbkdf2_sha256$600000$FAWsr7NWWxkxrhl6tvrFQe$obK+MaOZjzeaSeR/twkdmhl/m+uwQRlc5BK5ry3OhpI=', '2025-03-08 15:42:09.840567', 0, 'zhangsan', '', '', 'zhangsan@163.com', 1, 1, '2025-03-05 23:55:31.023981');

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_groups_user_id_group_id_94350c0c_uniq`(`user_id`, `group_id`) USING BTREE,
  INDEX `auth_user_groups_group_id_97559544_fk_auth_group_id`(`group_id`) USING BTREE,
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'user-group relationship' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------
INSERT INTO `auth_user_groups` VALUES (1, 4, 1);

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq`(`user_id`, `permission_id`) USING BTREE,
  INDEX `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'user-permission relationship' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for customers_customer
-- ----------------------------
DROP TABLE IF EXISTS `customers_customer`;
CREATE TABLE `customers_customer`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `address` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `phone_number` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `customers_customer_user_id_a9568d6c_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'customer' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customers_customer
-- ----------------------------
INSERT INTO `customers_customer` VALUES (1, '张三', 'zsh_blackcat@163.com', '湖北武汉', '2025-03-05 23:55:08.837070', '', '2025-03-05 23:55:08.870400', NULL);
INSERT INTO `customers_customer` VALUES (2, '李四', 'zsh_blackcat@163.com', '', '2025-03-05 23:55:08.837070', '', '2025-03-05 23:55:08.870400', NULL);
INSERT INTO `customers_customer` VALUES (3, '徐倩', 'xia43@example.net', '北京市嘉禾市大东荆门街j座 931628', '2025-03-05 23:55:08.837070', '', '2025-03-05 23:55:08.870400', NULL);
INSERT INTO `customers_customer` VALUES (4, '李刚', 'bxiong@example.net', '山东省长春市清河魏街y座 756107', '2025-03-05 23:55:08.837070', '', '2025-03-05 23:55:08.870400', NULL);
INSERT INTO `customers_customer` VALUES (5, '李建军', 'yuli@example.org', '澳门特别行政区玲县沙湾荆门街m座 412542', '2025-03-05 23:55:08.837070', '', '2025-03-05 23:55:08.870400', NULL);
INSERT INTO `customers_customer` VALUES (6, '李丽', 'guiyingxu@example.com', '海南省齐齐哈尔市浔阳通辽街G座 593616', '2025-03-05 23:55:08.837070', '', '2025-03-05 23:55:08.870400', NULL);
INSERT INTO `customers_customer` VALUES (7, '李玉', 'nafu@example.org', '新疆维吾尔自治区桂英县龙潭王路I座 649651', '2025-03-05 23:55:08.837070', '', '2025-03-05 23:55:08.870400', NULL);
INSERT INTO `customers_customer` VALUES (8, '崔海燕', 'azhou@example.com', '湖北省长春县花溪张街G座 331548', '2025-03-05 23:55:08.837070', '', '2025-03-05 23:55:08.870400', NULL);
INSERT INTO `customers_customer` VALUES (9, '王春梅', 'juanqin@example.net', '黑龙江省秀英市海港陈街Z座 364129', '2025-03-05 23:55:08.837070', '', '2025-03-05 23:55:08.870400', NULL);
INSERT INTO `customers_customer` VALUES (10, '张萍', 'momin@example.net', '河北省荆门市门头沟惠州路q座 915398', '2025-03-05 23:55:08.837070', '', '2025-03-05 23:55:08.870400', NULL);
INSERT INTO `customers_customer` VALUES (11, '韩玉', 'mengwei@example.net', '新疆维吾尔自治区勇县新城银川街C座 716102', '2025-03-05 23:55:08.837070', '', '2025-03-05 23:55:08.870400', NULL);
INSERT INTO `customers_customer` VALUES (12, '王桂兰', 'lei45@example.com', '黑龙江省大冶县清河兴安盟路z座 767313', '2025-03-05 23:55:08.837070', '', '2025-03-05 23:55:08.870400', NULL);
INSERT INTO `customers_customer` VALUES (13, 'zhangsan', 'zhangsan@163.com', '', '2025-03-05 23:55:31.190641', '13211112222', '2025-03-05 23:55:31.190641', NULL);

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `object_repr` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content_type_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `django_admin_log_content_type_id_c4bce8eb_fk_django_co`(`content_type_id`) USING BTREE,
  INDEX `django_admin_log_user_id_c564eba6_fk_auth_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'log entry' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
INSERT INTO `django_admin_log` VALUES (1, '2025-01-08 10:01:55.990072', '1', '201', 1, '[{\"added\": {}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (2, '2025-01-08 10:04:30.488472', '1', '201', 2, '[{\"changed\": {\"fields\": [\"\\u623f\\u95f4\\u4e3b\\u56fe\"]}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (3, '2025-01-08 10:05:22.212162', '1', '201', 2, '[{\"changed\": {\"fields\": [\"\\u623f\\u95f4\\u4e3b\\u56fe\"]}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (4, '2025-01-09 15:55:51.862358', '1', '张三', 1, '[{\"added\": {}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (5, '2025-01-09 15:56:18.000773', '2', '李四', 1, '[{\"added\": {}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (6, '2025-01-09 16:00:53.112839', '1', '预订号: 1 - 李四 - 201', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (7, '2025-01-09 16:07:09.269623', '1', '2024-12-13 - Room: 200', 1, '[{\"added\": {}}]', 11, 1);
INSERT INTO `django_admin_log` VALUES (8, '2025-01-09 16:43:40.824176', '1', '2024-12-13 - Salary: 5000', 1, '[{\"added\": {}}]', 10, 1);
INSERT INTO `django_admin_log` VALUES (9, '2025-01-09 16:44:28.043916', '1', '李阿姨', 1, '[{\"added\": {}}]', 12, 1);
INSERT INTO `django_admin_log` VALUES (10, '2025-01-09 16:46:07.058779', '2', '302', 1, '[{\"added\": {}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (11, '2025-01-09 16:47:46.667549', '3', '401', 1, '[{\"added\": {}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (12, '2025-01-09 16:47:56.087827', '3', '401', 2, '[{\"changed\": {\"fields\": [\"\\u623f\\u95f4\\u4e3b\\u56fe\"]}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (13, '2025-03-06 00:11:49.570459', '1', '顾客', 1, '[{\"added\": {}}]', 3, 1);
INSERT INTO `django_admin_log` VALUES (14, '2025-03-07 10:10:44.463639', '1', '顾客', 2, '[{\"changed\": {\"fields\": [\"Permissions\"]}}]', 3, 1);

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label`, `model`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'content type' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (14, 'analytics', 'dashboardmetric');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (2, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (4, 'auth', 'user');
INSERT INTO `django_content_type` VALUES (5, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (8, 'customers', 'customer');
INSERT INTO `django_content_type` VALUES (13, 'employees', 'customuser');
INSERT INTO `django_content_type` VALUES (12, 'employees', 'employee');
INSERT INTO `django_content_type` VALUES (10, 'finance', 'expense');
INSERT INTO `django_content_type` VALUES (11, 'finance', 'income');
INSERT INTO `django_content_type` VALUES (15, 'finance', 'orderreview');
INSERT INTO `django_content_type` VALUES (9, 'reservations', 'reservation');
INSERT INTO `django_content_type` VALUES (7, 'rooms', 'room');
INSERT INTO `django_content_type` VALUES (6, 'sessions', 'session');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'migration' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES (1, 'contenttypes', '0001_initial', '2025-01-07 08:16:31.090469');
INSERT INTO `django_migrations` VALUES (2, 'auth', '0001_initial', '2025-01-07 08:16:31.339696');
INSERT INTO `django_migrations` VALUES (3, 'admin', '0001_initial', '2025-01-07 08:16:31.402380');
INSERT INTO `django_migrations` VALUES (4, 'admin', '0002_logentry_remove_auto_add', '2025-01-07 08:16:31.407885');
INSERT INTO `django_migrations` VALUES (5, 'admin', '0003_logentry_add_action_flag_choices', '2025-01-07 08:16:31.413890');
INSERT INTO `django_migrations` VALUES (6, 'contenttypes', '0002_remove_content_type_name', '2025-01-07 08:16:31.445455');
INSERT INTO `django_migrations` VALUES (7, 'auth', '0002_alter_permission_name_max_length', '2025-01-07 08:16:31.473565');
INSERT INTO `django_migrations` VALUES (8, 'auth', '0003_alter_user_email_max_length', '2025-01-07 08:16:31.499422');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0004_alter_user_username_opts', '2025-01-07 08:16:31.504424');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0005_alter_user_last_login_null', '2025-01-07 08:16:31.528463');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0006_require_contenttypes_0002', '2025-01-07 08:16:31.530462');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0007_alter_validators_add_error_messages', '2025-01-07 08:16:31.535463');
INSERT INTO `django_migrations` VALUES (13, 'auth', '0008_alter_user_username_max_length', '2025-01-07 08:16:31.545520');
INSERT INTO `django_migrations` VALUES (14, 'auth', '0009_alter_user_last_name_max_length', '2025-01-07 08:16:31.557123');
INSERT INTO `django_migrations` VALUES (15, 'auth', '0010_alter_group_name_max_length', '2025-01-07 08:16:31.587202');
INSERT INTO `django_migrations` VALUES (16, 'auth', '0011_update_proxy_permissions', '2025-01-07 08:16:31.592744');
INSERT INTO `django_migrations` VALUES (17, 'auth', '0012_alter_user_first_name_max_length', '2025-01-07 08:16:31.599394');
INSERT INTO `django_migrations` VALUES (18, 'customers', '0001_initial', '2025-01-07 08:16:31.614651');
INSERT INTO `django_migrations` VALUES (19, 'employees', '0001_initial', '2025-01-07 08:16:31.622375');
INSERT INTO `django_migrations` VALUES (20, 'finance', '0001_initial', '2025-01-07 08:16:31.636470');
INSERT INTO `django_migrations` VALUES (21, 'rooms', '0001_initial', '2025-01-07 08:16:31.647978');
INSERT INTO `django_migrations` VALUES (22, 'reservations', '0001_initial', '2025-01-07 08:16:31.715863');
INSERT INTO `django_migrations` VALUES (23, 'sessions', '0001_initial', '2025-01-07 08:16:31.733882');
INSERT INTO `django_migrations` VALUES (24, 'rooms', '0002_room_pictures', '2025-01-08 09:52:53.212047');
INSERT INTO `django_migrations` VALUES (25, 'reservations', '0002_alter_reservation_status', '2025-01-09 16:06:33.279184');
INSERT INTO `django_migrations` VALUES (26, 'customers', '0002_alter_customer_options_remove_customer_id_number_and_more', '2025-03-05 23:55:08.929019');
INSERT INTO `django_migrations` VALUES (27, 'rooms', '0003_alter_room_options_alter_room_description_and_more', '2025-03-05 23:55:09.018616');
INSERT INTO `django_migrations` VALUES (28, 'reservations', '0003_alter_reservation_options_reservation_user_and_more', '2025-03-06 00:23:05.314992');
INSERT INTO `django_migrations` VALUES (29, 'rooms', '0004_alter_room_options_alter_room_description_and_more', '2025-03-06 00:32:48.207484');
INSERT INTO `django_migrations` VALUES (30, 'reservations', '0004_alter_reservation_created_at_and_more', '2025-03-07 01:17:43.795097');
INSERT INTO `django_migrations` VALUES (31, 'finance', '0002_alter_expense_options_alter_income_options_and_more', '2025-03-07 01:17:43.930575');
INSERT INTO `django_migrations` VALUES (32, 'customers', '0003_alter_customer_options_customer_user_and_more', '2025-03-07 01:38:14.178696');
INSERT INTO `django_migrations` VALUES (33, 'reservations', '0005_alter_reservation_options_reservation_notes_and_more', '2025-03-07 10:20:12.107082');
INSERT INTO `django_migrations` VALUES (34, 'finance', '0003_alter_orderreview_options', '2025-03-07 10:49:32.631484');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'session' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('0nxdd587xmmgduvufgnk3p5nguznf4a1', '.eJydlt9yoyAUxl-l43WNiqLSy73fJ9h0MgjH6FYxI9hup5N3X44ak1jdOHsT_n2BH985IF_OgXemOHQa2kMpnRcncJ5v-zIu3kDhgPzN1bHZiUaZtsx2KNmNo3r3s5FQ_Ri1dxMUXBf23yQMZcAETST4IieREFKGkDAqo1wAYyQJg4z5qYyjmAgWJoQxKuLI1kkaR_2kNahO27l-fe0dfjrtnZenvdM2Ta33zrOtKl7D0LnfdyygxBYUWGKLJOMBFpEfD9rS7mPQ5lw_5dwtGgPVMFbjZjSO4kp3s8YkzHFymkebZs1ADiNdW93wevjrDSMnaOtS6_Lyz16wey_h44DVQQSlxNHA98n5-WlOxdIEcK8ZJ5uoMDB6xiU6bZra9nuX2grfJBwYL805Z7jImUY9J-ObOAWvbD7x1hUFiLe5kWB38c6NBbN-Xhtrtt7IR3evPXP46PyKHYcPKI-FwU7_XhAMu5uyMC8VVwIW8jCVpM9DMmz24Z7rRsGnm5VV5fLKPE5IGsY4fRDTTdPLRnEDMytHeq9UwoZyxcBRNHg3KOe2xQsxjynJe8B8W8zzTimoLGdV8XaFE_6cQOlNoKN0TposkKbD8aEhpX1LYK5GkCcrpNqsAlpzThUYkG7TSjxTgy6ruHpDpWk7uAdKv2VccC-gs4wDu0LzCbB099GIplhI2JYUeB-4poRlP6eVRkfH5sPU_B8K7YrmODN1Wt-71FYC_0_QycnA_2Y1ubeazazmilefphRLVsc08bEI4_4GJj6exjhh_tqVVvDWuFWpVsye1hr2IO3XM2t4K2uwX13x0PM0l4iTRgQ9j1mKGZ0yka7gGC4Ke5CNjf9020zGexOMN3GsWL8F-xoB8i0C4b1gfr3ic2LB_ETkGRYg823fk-aoV_jxNdOjYxY-tPl2qSnRN54zXZRQzV8FuL6Hw2v-LvBd7YoWbrMxFRMQ214qa6evJzu2TXd6iNar5mz0W6yje0F4fnXOfwEGiFbA:1tqTBW:NrR_2-SP-mCP2oDHtjeJEX15pwtC1kNJu_N1ZDEzwg4', '2025-03-21 16:35:58.754951');
INSERT INTO `django_session` VALUES ('7mllwvvk8i3nkdv0e4wcxad5w5eg21fc', '.eJydlt9yoyAUxl-l43WNiqLSy73fJ9h0MgjH6FYxI9hup5N3X44ak1jdOHsT_n2BH985IF_OgXemOHQa2kMpnRcncJ5v-zIu3kDhgPzN1bHZiUaZtsx2KNmNo3r3s5FQ_Ri1dxMUXBf23yQMZcAETST4IieREFKGkDAqo1wAYyQJg4z5qYyjmAgWJoQxKuLI1kkaR_2kNahO27l-fe0dfjrtnZenvdM2Ta33zrOtKl7D0LnfdyygxBYUWGKLJOMBFpEfD9rS7mPQ5lw_5dwtGgPVMFbjZjSO4kp3s8YkzHFymkebZs1ADiNdW93wevjrDSMnaOtS6_Lyz16wey_h44DVQQSlxNHA98n5-WlOxdIEcK8ZJ5uoMDB6xiU6bZra9nuX2grfJBwYL805Z7jImUY9J-ObOAWvbD7x1hUFiLe5kWB38c6NBbN-Xhtrtt7IR3evPXP46PyKHYcPKI-FwU7_XhAMu5uyMC8VVwIW8jCVpM9DMmz24Z7rRsGnm5VV5fLKPE5IGsY4fRDTTdPLRnEDMytHeq9UwoZyxcBRNHg3KOe2xQsxjynJe8B8W8zzTimoLGdV8XaFE_6cQOlNoKN0TposkKbD8aEhpX1LYK5GkCcrpNqsAlpzThUYkG7TSjxTgy6ruHpDpWk7uAdKv2VccC-gs4wDu0LzCbB099GIplhI2JYUeB-4poRlP6eVRkfH5sPU_B8K7YrmODN1Wt-71FYC_0_QycnA_2Y1ubeazazmilefphRLVsc08bEI4_4GJj6exjhh_tqVVvDWuFWpVsye1hr2IO3XM2t4K2uwX13x0PM0l4iTRgQ9j1mKGZ0yka7gGC4Ke5CNjf9020zGexOMN3GsWL8F-xoB8i0C4b1gfr3ic2LB_ETkGRYg823fk-aoV_jxNdOjYxY-tPl2qSnRN54zXZRQzV8FuL6Hw2v-LvBd7YoWbrMxFRMQ214qa6evJzu2TXd6iNar5mz0W6yje0F4fnXOfwEGiFbA:1tqQ7x:MdZnBtJwPQ2Df6YgC5m1Sw3mx2A1GLPzpjF7cNLS0WU', '2025-03-21 13:20:05.134973');
INSERT INTO `django_session` VALUES ('8m8z60ym2c7zlx2ggapklwp7qjujj4o0', '.eJyllU1yozAQha_iYm0bECBQlrOfE4xTLiE1QRl-XAiSSaV891EDxgaD7SQbS0iP1tdPbfrT2vOmTveNhmqvpPVkudb6ci3m4i8UuCFfefFSbkVZ1JWKtyjZ9rt6-7uUkP3qtaMAKdepeZt4nnSZCEIJjkiIL4SUHoQskH4igDESem7MnEhSnxLBvJAwFgjqmzmJqN8GzaFotIn153Nn8cNhZz2tzMSctLPWZlbwHLq13a5hbkDMEAALzRDG3MXBd2inVSaNTptwvUr4Blk3OlWQyU6RY0YaNXjcKDYlXoJHBIl_LzaGrtNNpnTdbTZV1u1VZZlrG3_tbucAVa60VqeXW8H2TcH7HqedCJTEXddxyHG9moKxKARMOubk-2Ci0XWZQ6Xt02wBcBB2kKfHKag3Cxr5LSjjP3AQzJ298doAGSPPD0t-Xsh7W88rU2j_-IwL-3dQL2mNi85Y4M5kFUnS1hzp0vlSVrfKLfAohnVp8EhYrOSJU4kqeCHAVoUwN7TgTy_qrOmUU1foTNI0IElLlzx0lTfo4N8BCv0QXi-d8oVXt-aOBcFMAoEfRDhIeMje0a1NISE_ZOUHQF9gp8e7V_xFhhkTh5Pt02zBx5uIZ6fYlZVkLIhmayF0cPBo-xkiDtYtDZmz8NEVKa9qY2cB86y84NlHrUTPKk0riUteyRxMCxJ3XY0SiTiRT9BVyiL8d0ZMRAs4NRepqfradAKeTb829gBjDxwLFj-CPRjpuldOe2OBM-N0KJIYB5DJj4u27eQt6UtVNoe7tl6eNpTud2oWD7ZxfcnHAez88tmWub7Sl1wI4qHOvMTU-nAX6sKtM9V14_DHAnJ8to7_AS86_i8:1tq6w2:5WmMr7ozxof9vxxK2nOYojOr6pz5NY8jW9Ii9o3hfL4', '2025-03-20 16:50:30.564731');
INSERT INTO `django_session` VALUES ('9gr7izwit2i873la49r0ieih7qn8knw1', '.eJydlt9yoyAUxl-l43WNiqLSy73fJ9h0MgjH6FYxI9hup5N3X44ak1jdOHsT_n2BH985IF_OgXemOHQa2kMpnRcncJ5v-zIu3kDhgPzN1bHZiUaZtsx2KNmNo3r3s5FQ_Ri1dxMUXBf23yQMZcAETST4IieREFKGkDAqo1wAYyQJg4z5qYyjmAgWJoQxKuLI1kkaR_2kNahO27l-fe0dfjrtnZenvdM2Ta33zrOtKl7D0LnfdyygxBYUWGKLJOMBFpEfD9rS7mPQ5lw_5dwtGgPVMFbjZjSO4kp3s8YkzHFymkebZs1ADiNdW93wevjrDSMnaOtS6_Lyz16wey_h44DVQQSlxNHA98n5-WlOxdIEcK8ZJ5uoMDB6xiU6bZra9nuX2grfJBwYL805Z7jImUY9J-ObOAWvbD7x1hUFiLe5kWB38c6NBbN-Xhtrtt7IR3evPXP46PyKHYcPKI-FwU7_XhAMu5uyMC8VVwIW8jCVpM9DMmz24Z7rRsGnm5VV5fLKPE5IGsY4fRDTTdPLRnEDMytHeq9UwoZyxcBRNHg3KOe2xQsxjynJe8B8W8zzTimoLGdV8XaFE_6cQOlNoKN0TposkKbD8aEhpX1LYK5GkCcrpNqsAlpzThUYkG7TSjxTgy6ruHpDpWk7uAdKv2VccC-gs4wDu0LzCbB099GIplhI2JYUeB-4poRlP6eVRkfH5sPU_B8K7YrmODN1Wt-71FYC_0_QycnA_2Y1ubeazazmilefphRLVsc08bEI4_4GJj6exjhh_tqVVvDWuFWpVsye1hr2IO3XM2t4K2uwX13x0PM0l4iTRgQ9j1mKGZ0yka7gGC4Ke5CNjf9020zGexOMN3GsWL8F-xoB8i0C4b1gfr3ic2LB_ETkGRYg823fk-aoV_jxNdOjYxY-tPl2qSnRN54zXZRQzV8FuL6Hw2v-LvBd7YoWbrMxFRMQ214qa6evJzu2TXd6iNar5mz0W6yje0F4fnXOfwEGiFbA:1tqQ09:5SI9kcpMZasVDDmeSX3tMkxwabLqC2GegbZQeCIlwHw', '2025-03-21 13:12:01.159438');
INSERT INTO `django_session` VALUES ('9jcs2few765jqlgyr9i6b4hpu1uisj7b', '.eJyllduSoyAQhl9lyusYzwfmcu_3CTZTKYQ2skGxBGcqNZV3X9DEiUZHd_cKhd-m--On_bSOuFXFsZXQHBm1Xi3P2j3OZZicoTIL9DeuTmJPRKUalu2NZH9blfufggL_cdOOAhRYFvprPwioh0iUUHBJ7oeEUBpAgiIa5gQQ8pPAy5Cb0jiMfYKCxEcoInGon_00DrugJVSt1LF-fR4sXNcH6_XlYDVClPJg7fRjhUvoJw-HFnmRr4cIUKKHJMOeGUI37rVM19FrcyxfcmwXQgHv10pTjDSrZqdx1DQNTdQM4U1RCeaaCG5sUgA596K24bfUQQN6x4qJSjoPL06vq6EpmZTsHvJRvn9n8HF8mOk_AUaN1nNd__pmJo4fwE6FMpPuWOBddy-PHHNW4YrADMmU-h1Jvy92teZSVHCxM8a5jblaRZpmuAsfRNE2pJzVmcANtTmTaoL0VoVDRFlzUEBt0VBo5A1pxnF1NkrVtDDmET4B88aCYAIM9A7iAjBnviiMUjNQ2FaTuSm2YjB_8MNO_anfX1fJ_ksW0ibiNIE67O_cnxYc-m2iXyTjJ9T-WBBNUOMK84tiZA51HCWuGYIYOpPq6vRbgtwl-xS4Udo61QLsYa--BqrbV-e2EnTbI-tuzqlJJw19wzxGqfF2iki6kI7CpBA6tj7_4bIM4J0hGWfIYwH9lrS_AKc94DFIAOOP2HPzrm_i-C941nfvPt1EqduTzDExTcruspRsw3VETx4JxoJk6hH9x5mxR0LyzAxA823dRZzkAmHzw-vgmnuyaoTHrYaruLETyIIBpxOgZn_HLC85YCa_AZfnzZz47XATIOF_9Ycus1Mj2no1tU41ze35XxWOBe71zbr-ARHDvuM:1tqopG:k_9NQAUty1QAdNCw4bJXbwfbyqIP29FzNW8s-zPixvU', '2025-03-22 15:42:26.401881');
INSERT INTO `django_session` VALUES ('adrz5jjkvs3h89hs74yfcmq1jbgdzcl5', '.eJytVNtymzAQ_RUPz7ZBQhIoj33vF5SMR0iroNYID4JeJuN_r9YkbTBM4qR9YZfdwzl7Vowek4Mah-YwBugPziR3CUm2L2u10t_AY8N8Vf6h2-vOD72r9wjZP3XD_nNn4PjpCTsjaFRo4tc0zw2RmhcGMm0p09qYHArJDbMapKRFTmqZlUYwQbXMCyol14LFnJaCXUhb8GOIXF8eq0SdTlVyt4lJVKqSbcy8amGqVdUoCacxcJBFDEWtCAaWiQnroo0Ja1XYWLXDWXehcXA0E6JFRwExKDfjFjS3KMEte4sbqYdmd3RhmJpjf5x6fde1IcVnOnXAGeyQLKPn7eZaU5YFoJ9a0Y9r6jEMXQt9SJ-zhXa-ql2yi7ZU_-AX4oa_q8F1Ptr--7KYgJ3vsXD4Ae6hGbCYzQFkZcTS0Mtx02m2d4342knzXCAtEfwWWvyJrmxb55XXkDqv474XZsWKF8GpvYjam9b9iij8PIEPS9VisWIyB_CVsTjjJQYDN-3i1hW_k3bFLbSnY_cLIKTP2cKwXBimc0C5YrjQtsYAxv5Pwy-J_tj_iG-8-VKsX9slZGE3nwOy831y_g39WdJX:1tVoDP:Npcmt1_DLfFL_0iNOzRz3sWmnxa9kYCaf5VnjgrOC80', '2025-01-23 16:48:31.371236');
INSERT INTO `django_session` VALUES ('aideza7f0m6jrokgadr7x1rfhvihv3ga', '.eJyNkN1u4yAQRl8l4jpxjAP-6eXe9wnqyhpgqNnaEIHdqqry7jXBKzndVu3VmJnDZ-a8kw7mqe_mgL4zitwRRvbbngD5jDYO1F-wTy6Tzk7eiCwi2ToN2b1TOPxZ2ZuAHkK_3C5ySqumhFxIJrhStKm0gEpVtKiFLmkluKgYlKzgOT812GhOtZYlk0WjsZQxdEQ7hyXr4b0lcD635G7XEu_cGFqyXz4tjJiabTs3lBdL4dhUS6kE0FhYXibWLHskVkPYaTj0bsIhzca4TIjT-Kfb1LpmMVU08KtUCcNiBPxB9iifEzT7YX06LoJeYDLOhuPmcEzcGf1oQjD_Ird49mLwtdt00hU0KrI0z4vLY2x0r2ie-ik281uAXva7rUdtLFiJX5isVXE1WaRlf9x5dBbfDsIMwwGG6UeltYBr_Inz60lGwQx19U18mMB_Erm-_ei8Qu8xuvnG4UomfRv8sz72nz56C5wuj-TyAVyuCA4:1tqNXm:NpMpNvlVR-VKtTACpgG9O03BITZIgbsRhwpua69QNBk', '2025-03-21 10:34:34.368534');
INSERT INTO `django_session` VALUES ('fze44fwsxrvfqs3t00yheh5w6vuf3hoy', '.eJydVV1zoyAU_Ssdn2sUFNE-7vv-gk0nw8clslXIiLbb6eS_L8Q2Wz8ycfYlIPfmHM69B_iIDmzo68PgoDtoGT1FefT4fY0z8QImBORvZo52J6zpO813IWX3GXW7n1ZC8-MzdwJQM1f7f-MUIVoVLOUi50RKVFHFGZUU4ZKrAlFOOM1ZkWOSkqyCShGklChygSsFhQigLZjBeaxfH_uInU776OnBTzzTPnr0M8NaGNf2-6FCBPuBQEX9QDlDYcjTYszVXsaYq5h7UCyubQ_NGGuDFheigWiCWuBMBXCi8k2oHOQYGbpmDHTWti4Jv8kYAS1DBKUpPj8-zAmrkkKQwRneRBhK7maUYnC9bf168jVbUGer1GV-oa7YJmrBGt981sWiBvEylw1-Y6-s19Z49f8-FjvJz89h4fAG-lj3YTGdJqBxq9f-K22YEbBigVLiiwXwuPO7Alpr4D3mumli1vT3vUCyIsCjgmyCPzWDi4XuRAOz4nxKSLQRvjuLkhQrzSkIVhdyta05rTb32OHPCYxb0tMV-nL0I8kIuXyJ4JQcFL1B73rW3aC1nYSug1cNbwvqcmEGNE0gK3sjOSnDIGFbX8KRiXsNdxv-P8C-5vY4Uw7tqbHvAC75ms2Fo3QhHE-FV6ueoGkYsuJyZeA02LOgVXrrwNas6-NGm_vSSyUDdOlv54BZlaH7ZSXKG9A9E7W3cu8rez1KV_0JM6x577VwifSPA7esk4sK4EUFsmkCWqkAFYqHAaTadmXZo7ur_TvM1QQbbeVqDc38CQgvVhLCC9H5mp3HPlIQ256cW667sB47O5wWtGRR63yakJ2fo_NfTq-Akg:1tqFE1:MYF0JOu4JaKsUSLEKNKJBc_Wy_Dw8rFHplxCsPCXdPQ', '2025-03-21 01:41:37.922029');
INSERT INTO `django_session` VALUES ('hc98gxna5n254u07hh1ey7l5jucohcwa', '.eJytVNtymzAQ_RUPz7ZBQhIoj33vF5SMR0iroNYID4JeJuN_r9YkbTBM4qR9YZfdwzl7Vowek4Mah-YwBugPziR3CUm2L2u10t_AY8N8Vf6h2-vOD72r9wjZP3XD_nNn4PjpCTsjaFRo4tc0zw2RmhcGMm0p09qYHArJDbMapKRFTmqZlUYwQbXMCyol14LFnJaCXUhb8GOIXF8eq0SdTlVyt4lJVKqSbcy8amGqVdUoCacxcJBFDEWtCAaWiQnroo0Ja1XYWLXDWXehcXA0E6JFRwExKDfjFjS3KMEte4sbqYdmd3RhmJpjf5x6fde1IcVnOnXAGeyQLKPn7eZaU5YFoJ9a0Y9r6jEMXQt9SJ-zhXa-ql2yi7ZU_-AX4oa_q8F1Ptr--7KYgJ3vsXD4Ae6hGbCYzQFkZcTS0Mtx02m2d4342knzXCAtEfwWWvyJrmxb55XXkDqv474XZsWKF8GpvYjam9b9iij8PIEPS9VisWIyB_CVsTjjJQYDN-3i1hW_k3bFLbSnY_cLIKTP2cKwXBimc0C5YrjQtsYAxv5Pwy-J_tj_iG-8-VKsX9slZGE3nwOy831y_g39WdJX:1tc645:fHzMquT1_l53SukwM3E_K4s71O0-nfebzMpk-T-tiBg', '2025-02-10 01:04:53.392311');
INSERT INTO `django_session` VALUES ('k5m17d64bsrbqsh4c8yvqbuj00u588xm', '.eJyVkM1ygyAUhV8lwzoaICKSZfd9gppxLgKR1p-MaLLI-O6Fks5oNp2uLp77cY6HB6pgnppqdnqsrEInlKH9WpNQf-k-LNQn9JchrYd-Gq1MA5I-ty59H5Ru357sxqAB1_jbFBPCRQ5Y1plkShHBjQSuOKGFNDnhkkmeQZ5RhtlRaGEYMabOs5oKo_M6mHa6n533-niUCK7XEp12_uCTSrT3px46HbWynAVh1A-mBfeDSyBhZDiPrPU1ImvA7Qwk4V8T11jdqkh0oZELTIjbehdFFrylgL-8g_XUJK11U1zOYxt3o_aJN5js0LvD6uMQuaseO-uc_bVa4-nN6nu1UuIVbVVgCcZ0OQehumt7aaYg4i1Alv3utVWh6M-L0VjnX61Wj_WaTLbJx-WMlm8UosaB:1tps54:xPAywjOdngSFZeajeV4lz3i1UWXTWjGbp4X8onliOBE', '2025-03-20 00:58:50.994095');
INSERT INTO `django_session` VALUES ('yxy2mjjhn6gfpl5eresndcamfsi742a1', '.eJyNkE1upDAQRq_S8rqhMc1vlrOfEwwRKtvl4GljI9skGkV998GBSJBESlZlVz1_UO-V9DCHoZ89ul4J8kAKct73GPAbmjgQf8E82ZRbE5xiaUTSberT31ag_rWxh4AB_LC8zjNK67aCjPGClULQtpYMalHTvGGyojUrWV1AVeRlVl5bbGVJpeRVwfNWYsVj6Ihm9kvWn9eOwDR15OHUEWft6DtyXo4GRlybXTe3tMyXUmJbL6VmQGMpsmpl1bLHykrwJwnJYAPqdTbGZXycxi8dU5umiKmshR-lctCLEXAJH5DfVmh2evt1XAQ9Q1DW-Mvuclm5Cd2ovFfvkXs8fVb40u866xNUIrI0y_L7Y2z0L6iehhCb2RGg9_Np71EqA4bjFyYbkb-ZzNdlv915tAb_JUxpnYAO3yptGLzFX8vyZ0q1mpgFJxKtfPigdNviwu04aQwoEusEOr8pZRrMLZLBzXj0UXwSRo_A9f5I7v8BkL8CBg:1tqYcV:GggO7ZcoGQBEcjRl3W4ErnTiKcl1WO5tBIw7IF5djSA', '2025-03-21 22:24:11.400070');

-- ----------------------------
-- Table structure for employees_employee
-- ----------------------------
DROP TABLE IF EXISTS `employees_employee`;
CREATE TABLE `employees_employee`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `position` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `phone` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `address` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `salary` decimal(10, 2) NOT NULL,
  `hire_date` date NOT NULL,
  `status` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'employee' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of employees_employee
-- ----------------------------
INSERT INTO `employees_employee` VALUES (1, '李阿姨', '清洁工', '13255558888', 'zsh_blackcat@163.com', '', 2500.00, '2023-03-12', 'Active');
INSERT INTO `employees_employee` VALUES (2, '汪玉梅', '客房服务员', '13170981559', 'fang12@example.net', '江西省波市蓟州南昌街S座 771402', 14220.87, '2022-06-12', 'On Leave');
INSERT INTO `employees_employee` VALUES (3, '罗杰', '前台', '15346829422', 'jiekong@example.org', '福建省雪梅市清城汪街I座 802302', 13000.78, '2023-05-21', 'On Leave');
INSERT INTO `employees_employee` VALUES (4, '严丽', '经理', '13461773715', 'min60@example.net', '安徽省潮州市孝南陈街y座 208818', 7939.84, '2023-03-06', 'Active');
INSERT INTO `employees_employee` VALUES (5, '孔杰', '经理', '13371114829', 'nafang@example.com', '宁夏回族自治区秀兰市南湖王路R座 641320', 12045.54, '2023-11-24', 'Active');
INSERT INTO `employees_employee` VALUES (6, '朱雪', '客房服务员', '14732815955', 'tbai@example.com', '天津市娜市南长朱路E座 601426', 7045.76, '2023-02-19', 'Active');
INSERT INTO `employees_employee` VALUES (7, '杨秀英', '经理', '15656059883', 'rzhou@example.com', '北京市勇县和平荆门街n座 987984', 6233.68, '2023-08-22', 'Active');
INSERT INTO `employees_employee` VALUES (8, '卢丽丽', '前台', '15829086391', 'junren@example.net', '浙江省畅县合川哈尔滨路f座 198476', 6168.61, '2024-04-10', 'Resigned');
INSERT INTO `employees_employee` VALUES (9, '邓娟', '主管', '18806341585', 'cyin@example.com', '贵州省桂芝县永川哈尔滨路T座 420347', 14544.63, '2023-09-28', 'On Leave');

-- ----------------------------
-- Table structure for finance_expense
-- ----------------------------
DROP TABLE IF EXISTS `finance_expense`;
CREATE TABLE `finance_expense`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `amount` decimal(10, 2) NOT NULL,
  `category` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'expense' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of finance_expense
-- ----------------------------
INSERT INTO `finance_expense` VALUES (1, '2024-12-13', 5000.00, 'Salary', '');
INSERT INTO `finance_expense` VALUES (2, '2025-01-26', 2822.20, 'Utilities', '拥有地址美国北京分析.');
INSERT INTO `finance_expense` VALUES (3, '2025-01-26', 1334.12, 'Salary', '标准全国音乐发布以及.');
INSERT INTO `finance_expense` VALUES (4, '2025-01-26', 2492.49, 'Salary', '开发分析部分系统工程国内.');
INSERT INTO `finance_expense` VALUES (5, '2025-01-26', 1150.92, 'Utilities', '发生音乐推荐.');
INSERT INTO `finance_expense` VALUES (6, '2025-01-26', 634.94, 'Utilities', '电子地区地区品牌商品完成.');
INSERT INTO `finance_expense` VALUES (7, '2025-01-26', 931.02, 'Other', '来自以及国家之后人民.');
INSERT INTO `finance_expense` VALUES (8, '2025-01-26', 900.96, 'Maintenance', '开发直接资料在线一种技术社区.');
INSERT INTO `finance_expense` VALUES (9, '2025-01-26', 2435.86, 'Salary', '个人最后以下表示.');
INSERT INTO `finance_expense` VALUES (10, '2025-01-26', 1914.16, 'Utilities', '成为程序得到.');
INSERT INTO `finance_expense` VALUES (11, '2025-01-26', 1300.62, 'Utilities', '情况情况已经.');
INSERT INTO `finance_expense` VALUES (12, '2025-01-26', 1892.20, 'Other', '类型回复有限帖子增加.');
INSERT INTO `finance_expense` VALUES (13, '2025-01-26', 2273.81, 'Utilities', '空间为什你们问题资源女人.');
INSERT INTO `finance_expense` VALUES (14, '2025-01-26', 2916.48, 'Utilities', '操作参加合作您的可以文化情况.');
INSERT INTO `finance_expense` VALUES (15, '2025-01-26', 2926.04, 'Maintenance', '最后解决电影推荐虽然社会.');
INSERT INTO `finance_expense` VALUES (16, '2025-01-26', 1715.32, 'Maintenance', '没有开始成为原因要求.');

-- ----------------------------
-- Table structure for finance_income
-- ----------------------------
DROP TABLE IF EXISTS `finance_income`;
CREATE TABLE `finance_income`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `amount` decimal(10, 2) NOT NULL,
  `source` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `reservation_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `reservation_id`(`reservation_id`) USING BTREE,
  CONSTRAINT `finance_income_reservation_id_ba14e16b_fk_reservati` FOREIGN KEY (`reservation_id`) REFERENCES `reservations_reservation` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'income' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of finance_income
-- ----------------------------
INSERT INTO `finance_income` VALUES (1, '2024-12-13', 200.00, 'Room', '', NULL);
INSERT INTO `finance_income` VALUES (2, '2025-01-26', 1282.58, 'Room', '两个包括功能.', NULL);
INSERT INTO `finance_income` VALUES (3, '2025-01-26', 4097.80, 'Food', '都是大家阅读比较开发能力不同.', NULL);
INSERT INTO `finance_income` VALUES (4, '2025-01-26', 1578.03, 'Room', '得到国家来源北京情况设备她的.', NULL);
INSERT INTO `finance_income` VALUES (5, '2025-01-26', 4587.78, 'Room', '一下名称政府一些文章.', NULL);
INSERT INTO `finance_income` VALUES (6, '2025-01-26', 4287.15, 'Other', '我们城市参加特别经验这么今天.', NULL);
INSERT INTO `finance_income` VALUES (7, '2025-01-26', 2032.51, 'Food', '系统为了部分网上显示表示相关显示.', NULL);
INSERT INTO `finance_income` VALUES (8, '2025-01-26', 2926.59, 'Other', '责任记者由于如此提高.', NULL);
INSERT INTO `finance_income` VALUES (9, '2025-01-26', 3144.92, 'Other', '类型的话现在可能日本.', NULL);
INSERT INTO `finance_income` VALUES (10, '2025-01-26', 2395.84, 'Room', '关于联系经验程序合作欢迎.', NULL);
INSERT INTO `finance_income` VALUES (11, '2025-01-26', 2109.25, 'Other', '国际威望运行法律.', NULL);
INSERT INTO `finance_income` VALUES (12, '2025-01-26', 2072.93, 'Food', '设备商品标准会员来自有关但是信息.', NULL);
INSERT INTO `finance_income` VALUES (13, '2025-01-26', 754.67, 'Food', '时候开始之后.', NULL);
INSERT INTO `finance_income` VALUES (14, '2025-01-26', 677.99, 'Other', '论坛设备世界你们中文.', NULL);
INSERT INTO `finance_income` VALUES (15, '2025-01-26', 3333.71, 'Room', '国家社区得到喜欢所有文化社区.', NULL);
INSERT INTO `finance_income` VALUES (16, '2025-01-26', 3795.96, 'Other', '价格回复游戏类别应用如果.', NULL);
INSERT INTO `finance_income` VALUES (17, '2025-03-07', 195.00, 'Room', '房间 201 的住宿费用', 24);
INSERT INTO `finance_income` VALUES (18, '2025-03-07', 350.00, 'Room', '房间 302 的住宿费用', 25);
INSERT INTO `finance_income` VALUES (19, '2025-03-07', 195.00, 'Room', '房间 201 的住宿费用', 26);
INSERT INTO `finance_income` VALUES (20, '2025-03-07', 195.00, 'Room', '房间 201 的住宿费用', 27);

-- ----------------------------
-- Table structure for finance_orderreview
-- ----------------------------
DROP TABLE IF EXISTS `finance_orderreview`;
CREATE TABLE `finance_orderreview`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `rating` int(11) NOT NULL,
  `comment` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `reservation_id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `reservation_id`(`reservation_id`) USING BTREE,
  INDEX `finance_orderreview_user_id_e59db8ca_fk_auth_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `finance_orderreview_reservation_id_ea1c7487_fk_reservati` FOREIGN KEY (`reservation_id`) REFERENCES `reservations_reservation` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `finance_orderreview_user_id_e59db8ca_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of finance_orderreview
-- ----------------------------
INSERT INTO `finance_orderreview` VALUES (1, 5, '环境不错', '2025-03-07 13:08:31.883549', '2025-03-07 13:08:31.883549', 25, 4);
INSERT INTO `finance_orderreview` VALUES (2, 4, '很好', '2025-03-07 13:14:08.119309', '2025-03-07 13:14:08.119309', 24, 4);

-- ----------------------------
-- Table structure for reservations_reservation
-- ----------------------------
DROP TABLE IF EXISTS `reservations_reservation`;
CREATE TABLE `reservations_reservation`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `check_in_date` date NOT NULL,
  `check_out_date` date NOT NULL,
  `number_of_guests` int(11) NOT NULL,
  `special_requests` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `customer_id` bigint(20) NOT NULL,
  `room_id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `notes` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `total_price` decimal(10, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `reservations_reserva_customer_id_9e54bd39_fk_customers`(`customer_id`) USING BTREE,
  INDEX `reservations_reservation_room_id_f7d9ba76_fk_rooms_room_id`(`room_id`) USING BTREE,
  INDEX `reservations_reservation_user_id_6ed5b1c9_fk_auth_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `reservations_reserva_customer_id_9e54bd39_fk_customers` FOREIGN KEY (`customer_id`) REFERENCES `customers_customer` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `reservations_reservation_room_id_f7d9ba76_fk_rooms_room_id` FOREIGN KEY (`room_id`) REFERENCES `rooms_room` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `reservations_reservation_user_id_6ed5b1c9_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'reservation' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reservations_reservation
-- ----------------------------
INSERT INTO `reservations_reservation` VALUES (1, '2025-01-09', '2025-01-10', 2, '无', 'cancelled', '2025-01-09 16:00:53.112839', '2025-03-07 10:27:47.521265', 2, 1, 1, '', 195.00);
INSERT INTO `reservations_reservation` VALUES (2, '2025-01-26', '2025-02-01', 4, '无', 'Pending', '2025-01-27 01:04:48.748443', '2025-01-27 01:04:48.748443', 6, 2, 1, '', NULL);
INSERT INTO `reservations_reservation` VALUES (3, '2025-01-26', '2025-01-30', 2, '无', 'Pending', '2025-01-27 01:04:48.750443', '2025-01-27 01:04:48.750443', 10, 1, 1, '', NULL);
INSERT INTO `reservations_reservation` VALUES (4, '2025-01-26', '2025-01-28', 3, '无', 'Pending', '2025-01-27 01:04:48.751443', '2025-01-27 01:04:48.751443', 7, 2, 1, '', NULL);
INSERT INTO `reservations_reservation` VALUES (5, '2025-01-26', '2025-02-02', 1, '无', 'CheckOut', '2025-01-27 01:04:48.753956', '2025-01-27 01:04:48.753956', 7, 3, 1, '', NULL);
INSERT INTO `reservations_reservation` VALUES (6, '2025-01-26', '2025-01-30', 4, '无', 'Pending', '2025-01-27 01:04:48.755109', '2025-01-27 01:04:48.755109', 12, 3, 1, '', NULL);
INSERT INTO `reservations_reservation` VALUES (7, '2025-01-26', '2025-01-31', 4, '无', 'CheckOut', '2025-01-27 01:04:48.756109', '2025-01-27 01:04:48.756109', 9, 3, 1, '', NULL);
INSERT INTO `reservations_reservation` VALUES (8, '2025-01-26', '2025-01-29', 4, '无', 'CheckOut', '2025-01-27 01:04:48.757109', '2025-01-27 01:04:48.757109', 12, 2, 1, '', NULL);
INSERT INTO `reservations_reservation` VALUES (9, '2025-01-26', '2025-02-01', 3, '无', 'CheckOut', '2025-01-27 01:04:48.758109', '2025-01-27 01:04:48.758109', 12, 1, 1, '', NULL);
INSERT INTO `reservations_reservation` VALUES (10, '2025-01-26', '2025-02-01', 3, '无', 'Pending', '2025-01-27 01:04:48.760110', '2025-01-27 01:04:48.760110', 9, 3, 1, '', NULL);
INSERT INTO `reservations_reservation` VALUES (11, '2025-01-26', '2025-01-27', 4, '无', 'CheckIn', '2025-01-27 01:04:48.761110', '2025-01-27 01:04:48.761110', 11, 1, 1, '', NULL);
INSERT INTO `reservations_reservation` VALUES (12, '2025-01-26', '2025-01-30', 1, '无', 'CheckOut', '2025-01-27 01:04:48.762110', '2025-01-27 01:04:48.762110', 3, 2, 1, '', NULL);
INSERT INTO `reservations_reservation` VALUES (13, '2025-01-26', '2025-01-30', 4, '无', 'CheckOut', '2025-01-27 01:04:48.764613', '2025-01-27 01:04:48.764613', 4, 3, 1, '', NULL);
INSERT INTO `reservations_reservation` VALUES (14, '2025-01-26', '2025-01-30', 1, '无', 'CheckIn', '2025-01-27 01:04:48.765614', '2025-01-27 01:04:48.765614', 6, 1, 1, '', NULL);
INSERT INTO `reservations_reservation` VALUES (15, '2025-01-26', '2025-01-28', 4, '无', 'Pending', '2025-01-27 01:04:48.766614', '2025-01-27 01:04:48.766614', 5, 3, 1, '', NULL);
INSERT INTO `reservations_reservation` VALUES (16, '2025-01-26', '2025-01-29', 3, '无', 'CheckOut', '2025-01-27 01:04:48.768615', '2025-01-27 01:04:48.768615', 9, 3, 1, '', NULL);
INSERT INTO `reservations_reservation` VALUES (17, '2025-01-26', '2025-01-31', 3, '无', 'CheckIn', '2025-01-27 01:04:48.769615', '2025-01-27 01:04:48.769615', 8, 1, 1, '', NULL);
INSERT INTO `reservations_reservation` VALUES (18, '2025-01-26', '2025-01-29', 2, '无', 'CheckOut', '2025-01-27 01:04:48.770615', '2025-01-27 01:04:48.770615', 6, 1, 1, '', NULL);
INSERT INTO `reservations_reservation` VALUES (19, '2025-01-26', '2025-01-27', 1, '无', 'CheckOut', '2025-01-27 01:04:48.771615', '2025-01-27 01:04:48.771615', 3, 2, 1, '', NULL);
INSERT INTO `reservations_reservation` VALUES (20, '2025-01-26', '2025-01-31', 1, '无', 'CheckIn', '2025-01-27 01:04:48.773118', '2025-01-27 01:04:48.773118', 12, 2, 1, '', NULL);
INSERT INTO `reservations_reservation` VALUES (21, '2025-01-26', '2025-01-29', 2, '无', 'CheckOut', '2025-01-27 01:04:48.774127', '2025-03-06 00:58:39.506228', 5, 2, 1, '', NULL);
INSERT INTO `reservations_reservation` VALUES (22, '2025-03-07', '2025-03-09', 2, '暂无', 'CheckOut', '2025-03-06 00:33:31.804111', '2025-03-06 00:58:46.031072', 13, 1, 4, '', NULL);
INSERT INTO `reservations_reservation` VALUES (23, '2025-03-08', '2025-03-09', 2, '', 'CheckOut', '2025-03-07 10:15:21.350918', '2025-03-07 10:16:25.637567', 13, 1, 4, '', NULL);
INSERT INTO `reservations_reservation` VALUES (24, '2025-03-07', '2025-03-08', 1, '', 'checked_out', '2025-03-07 10:24:04.689501', '2025-03-07 10:28:08.227757', 13, 1, 4, '', 195.00);
INSERT INTO `reservations_reservation` VALUES (25, '2025-03-08', '2025-03-09', 1, '', 'checked_out', '2025-03-07 10:55:51.186948', '2025-03-07 10:56:42.558285', 13, 2, 4, '', 350.00);
INSERT INTO `reservations_reservation` VALUES (26, '2025-03-07', '2025-03-08', 1, '', 'checked_out', '2025-03-07 11:03:43.161158', '2025-03-07 11:03:57.575239', 13, 1, 4, '', 195.00);
INSERT INTO `reservations_reservation` VALUES (27, '2025-03-07', '2025-03-08', 1, '', 'checked_out', '2025-03-07 11:24:47.191088', '2025-03-07 11:25:01.876856', 13, 1, 4, '', 195.00);
INSERT INTO `reservations_reservation` VALUES (28, '2025-03-07', '2025-03-08', 1, '', 'confirmed', '2025-03-07 13:13:57.737510', '2025-03-07 13:14:25.992836', 13, 1, 4, '', 195.00);

-- ----------------------------
-- Table structure for rooms_room
-- ----------------------------
DROP TABLE IF EXISTS `rooms_room`;
CREATE TABLE `rooms_room`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `room_number` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `room_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `price` decimal(10, 2) NOT NULL,
  `facilities` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `floor` int(11) NOT NULL,
  `capacity` int(11) NOT NULL,
  `description` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `pictures` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `room_number`(`room_number`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'room' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rooms_room
-- ----------------------------
INSERT INTO `rooms_room` VALUES (1, '201', 'Double', 195.00, '桌椅，双人床，wifi,电视，烟灰缸，热水器，拖鞋', 'reserved', 2, 2, '', 'pictures/201.png');
INSERT INTO `rooms_room` VALUES (2, '302', 'Deluxe', 350.00, '桌椅，双人床，wifi,电视，烟灰缸，热水器，拖鞋', 'available', 3, 2, '', 'pictures/202.jpg');
INSERT INTO `rooms_room` VALUES (3, '401', 'Suite', 50.00, '桌椅，双人床，wifi,电视，烟灰缸，热水器，拖鞋, 浴缸，书桌，沙发', 'available', 4, 3, '', 'pictures/401.jpg');

SET FOREIGN_KEY_CHECKS = 1;
