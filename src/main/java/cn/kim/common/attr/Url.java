package cn.kim.common.attr;

/**
 * Created by 余庚鑫 on 2019/3/27
 * 全局URL
 */
public class Url {
    /**
     * URL地址
     */
    public static final String MANAGER_URL = "admin/";
    public static final String EDIT_USER = MANAGER_URL + "editUser";
    public static final String EDIT_PASSWORD = MANAGER_URL + "editPwd";
    /**
     * 图片地址url
     */
    public static final String IMG_URL = AttributePath.FILE_PREVIEW_URL;
    public static final String DOWN_URL = AttributePath.FILE_DOWNLOAD_URL;
    public static final String DOWN_CACHE_URL = AttributePath.FILE_DOWNLOAD_URL + AttributePath.FILE_SERVICE_CACHE_PATH;
    /**
     * excel导出地址
     */
    public static final String EXPORT_URL = "file/export/";
    /**
     * 列表地址
     */
    public static final String DATA_GRID_URL = MANAGER_URL + "dataGrid/data/";
    public static final String TREE_GRID_URL = MANAGER_URL + "treeGrid/data/";
    public static final String DIFF_URL = MANAGER_URL + "diff";
    /**
     * 系统配置管理
     */
    public static final String ALLOCATION_BASE_URL = MANAGER_URL + "allocation/";
    /**
     * 邮箱配置管理
     */
    public static final String EMAIL_BASE_URL = ALLOCATION_BASE_URL + "email";
    public static final String EMAIL_CACHE_URL = EMAIL_BASE_URL + "/cache";
    /**
     * 综合素质测评比例配置管理
     */
    public static final String COMPREHENSIVE_BASE_URL = ALLOCATION_BASE_URL + "comprehensive";
    /**
     * 迟到旷课处分配置管理
     */
    public static final String PUNISHMENT_BASE_URL = ALLOCATION_BASE_URL + "punishment";
    /**
     * 授权
     */
    public static final String AUTHORIZATION_BASE_URL = MANAGER_URL + "authorization/";
    public static final String AUTHORIZATION_TREE_URL = AUTHORIZATION_BASE_URL + "tree";
    public static final String AUTHORIZATION_UPDATE_URL = AUTHORIZATION_BASE_URL + "update";
    /**
     * 日志
     */
    public static final String LOG_BASE_URL = MANAGER_URL + "log/";
    /**
     * 变动记录
     */
    public static final String LOG_VALUE_RECORD_BASE_URL = LOG_BASE_URL + "valueRecord/";
    public static final String LOG_VALUE_RECORD_DETAIL_URL = LOG_VALUE_RECORD_BASE_URL + "detail/column";
    /**
     * 菜单管理
     */
    public static final String MENU_BASE_URL = MANAGER_URL + "menu/";
    public static final String MENU_LIST_URL = MENU_BASE_URL + "list";
    public static final String MENU_TREE_DATA_URL = MENU_BASE_URL + "getMenuTreeData";
    public static final String MENU_TREE_BUTTON_DATA_URL = MENU_BASE_URL + "getMenuButtonTreeData";
    public static final String MENU_TREE_BUTTON_DATA_UPDATE_URL = MENU_BASE_URL + "updateMenuButton";
    public static final String MENU_ADD_URL = MENU_BASE_URL + "add";
    public static final String MENU_UPDATE_URL = MENU_BASE_URL + "update";
    public static final String MENU_COPY_URL = MENU_BASE_URL + "copy";
    public static final String MENU_SWITCH_STATUS_URL = MENU_BASE_URL + "switchStatus";
    public static final String MENU_DELETE_URL = MENU_BASE_URL + "delete";
    /**
     * 配置列表
     */
    public static final String CONFIGURE_BASE_URL = MANAGER_URL + "configure/";
    public static final String CONFIGURE_TREE_DATA_URL = CONFIGURE_BASE_URL + "getConfigureTreeData";
    public static final String CONFIGURE_ADD_URL = CONFIGURE_BASE_URL + "add";
    public static final String CONFIGURE_UPDATE_URL = CONFIGURE_BASE_URL + "update";
    public static final String CONFIGURE_COPY_URL = CONFIGURE_BASE_URL + "copy";
    public static final String CONFIGURE_DELETE_URL = CONFIGURE_BASE_URL + "delete";
    /**
     * 配置列表列
     */
    public static final String CONFIGURE_COLUMN_BASE_URL = CONFIGURE_BASE_URL + "column/";
    public static final String CONFIGURE_COLUMN_ADD_URL = CONFIGURE_COLUMN_BASE_URL + "add";
    public static final String CONFIGURE_COLUMN_UPDATE_URL = CONFIGURE_COLUMN_BASE_URL + "update";
    public static final String CONFIGURE_COLUMN_DELETE_URL = CONFIGURE_COLUMN_BASE_URL + "delete";
    /**
     * 配置列表搜索
     */
    public static final String CONFIGURE_SEARCH_BASE_URL = CONFIGURE_BASE_URL + "search/";
    public static final String CONFIGURE_SEARCH_ADD_URL = CONFIGURE_SEARCH_BASE_URL + "add";
    public static final String CONFIGURE_SEARCH_UPDATE_URL = CONFIGURE_SEARCH_BASE_URL + "update";
    public static final String CONFIGURE_SEARCH_DELETE_URL = CONFIGURE_SEARCH_BASE_URL + "delete";
    /***
     * 配置列表文件
     */
    public static final String CONFIGURE_FILE_BASE_URL = CONFIGURE_BASE_URL + "file/";
    public static final String CONFIGURE_FILE_ADD_URL = CONFIGURE_FILE_BASE_URL + "add";
    public static final String CONFIGURE_FILE_UPDATE_URL = CONFIGURE_FILE_BASE_URL + "update";
    public static final String CONFIGURE_FILE_SWITCH_STATUS_URL = CONFIGURE_FILE_BASE_URL + "switchStatus";
    public static final String CONFIGURE_FILE_DELETE_URL = CONFIGURE_FILE_BASE_URL + "delete";
    /**
     * 按钮列表
     */
    public static final String BUTTON_BASE_URL = MANAGER_URL + "button/";
    public static final String BUTTON_ADD_URL = BUTTON_BASE_URL + "add";
    public static final String BUTTON_UPDATE_URL = BUTTON_BASE_URL + "update";
    public static final String BUTTON_DELETE_URL = BUTTON_BASE_URL + "delete";
    /**
     * 角色
     */
    public static final String ROLE_BASE_URL = MANAGER_URL + "role/";
    public static final String ROLE_LIST_URL = ROLE_BASE_URL + "list";
    public static final String ROLE_TREE_DATA_URL = ROLE_BASE_URL + "tree";
    public static final String ROLE_ADD_URL = ROLE_BASE_URL + "add";
    public static final String ROLE_UPDATE_URL = ROLE_BASE_URL + "update";
    public static final String ROLE_PERMISSION_TREE_MENU = ROLE_BASE_URL + "menuTree/";
    public static final String ROLE_PERMISSION_TREE_MENU_DATA = ROLE_BASE_URL + "getMenuTreeData/";
    public static final String ROLE_PERMISSION_TREE_MENU_UPDATE = ROLE_BASE_URL + "updateRoleMenuPermission";
    public static final String ROLE_PERMISSION_TREE_BUTTON = ROLE_BASE_URL + "buttonTree/";
    public static final String ROLE_PERMISSION_TREE_BUTTON_DATA = ROLE_BASE_URL + "getButtonTreeData/";
    public static final String ROLE_PERMISSION_TREE_BUTTON_UPDATE = ROLE_BASE_URL + "updateRoleButtonPermission";
    public static final String ROLE_SWITCH_STATUS_URL = ROLE_BASE_URL + "switchStatus";
    public static final String ROLE_DELETE_URL = ROLE_BASE_URL + "delete";
    /**
     * 验证
     */
    public static final String VALIDATE_BASE_URL = MANAGER_URL + "validate/";
    public static final String VALIDATE_ADD_URL = VALIDATE_BASE_URL + "add";
    public static final String VALIDATE_UPDATE_URL = VALIDATE_BASE_URL + "update";
    public static final String VALIDATE_SWITCH_STATUS_URL = VALIDATE_BASE_URL + "switchStatus";
    public static final String VALIDATE_DELETE_URL = VALIDATE_BASE_URL + "delete";
    /**
     * 验证字段
     */
    public static final String VALIDATE_FIELD_BASE_URL = VALIDATE_BASE_URL + "field/";
    public static final String VALIDATE_FIELD_LIST_URL = VALIDATE_FIELD_BASE_URL + "list";
    public static final String VALIDATE_FIELD_ADD_URL = VALIDATE_FIELD_BASE_URL + "add";
    public static final String VALIDATE_FIELD_UPDATE_URL = VALIDATE_FIELD_BASE_URL + "update";
    public static final String VALIDATE_FIELD_SWITCH_STATUS_URL = VALIDATE_FIELD_BASE_URL + "switchStatus";
    public static final String VALIDATE_FIELD_DELETE_URL = VALIDATE_FIELD_BASE_URL + "delete";
    /**
     * 验证组
     */
    public static final String VALIDATE_GROUP_BASE_URL = VALIDATE_BASE_URL + "group/";
    public static final String VALIDATE_GROUP_ADD_URL = VALIDATE_GROUP_BASE_URL + "add";
    public static final String VALIDATE_GROUP_UPDATE_URL = VALIDATE_GROUP_BASE_URL + "update";
    public static final String VALIDATE_GROUP_DELETE_URL = VALIDATE_GROUP_BASE_URL + "delete";
    /**
     * 验证正则
     */
    public static final String VALIDATE_REGEX_BASE_URL = VALIDATE_BASE_URL + "regex/";
    public static final String VALIDATE_REGEX_TREE_DATA_URL = VALIDATE_REGEX_BASE_URL + "tree";
    public static final String VALIDATE_REGEX_ADD_URL = VALIDATE_REGEX_BASE_URL + "add";
    public static final String VALIDATE_REGEX_UPDATE_URL = VALIDATE_REGEX_BASE_URL + "update";
    public static final String VALIDATE_REGEX_SWITCH_STATUS_URL = VALIDATE_REGEX_BASE_URL + "switchStatus";
    public static final String VALIDATE_REGEX_DELETE_URL = VALIDATE_REGEX_BASE_URL + "delete";
    /**
     * 字典
     */
    public static final String DICT_BASE_URL = MANAGER_URL + "dict/";
    public static final String DICT_ADD_URL = DICT_BASE_URL + "add";
    public static final String DICT_UPDATE_URL = DICT_BASE_URL + "update";
    public static final String DICT_SWITCH_STATUS_URL = DICT_BASE_URL + "switchStatus";
    public static final String DICT_DELETE_URL = DICT_BASE_URL + "delete";
    public static final String DICT_CACHE_URL = DICT_BASE_URL + "cache";
    /**
     * 字典信息
     */
    public static final String DICT_INFO_BASE_URL = DICT_BASE_URL + "info/";
    public static final String DICT_INFO_TREE_URL = DICT_INFO_BASE_URL + "tree";
    public static final String DICT_INFO_ADD_URL = DICT_INFO_BASE_URL + "add";
    public static final String DICT_INFO_UPDATE_URL = DICT_INFO_BASE_URL + "update";
    public static final String DICT_INFO_SWITCH_STATUS_URL = DICT_INFO_BASE_URL + "switchStatus";
    public static final String DICT_INFO_DELETE_URL = DICT_INFO_BASE_URL + "delete";
    /**
     * 操作员列表
     */
    public static final String OPERATOR_BASE_URL = MANAGER_URL + "operator/";
    public static final String OPERATOR_ADD_URL = OPERATOR_BASE_URL + "add";
    public static final String OPERATOR_UPDATE_URL = OPERATOR_BASE_URL + "update";
    public static final String OPERATOR_SWITCH_STATUS_URL = OPERATOR_BASE_URL + "switchStatus";
    public static final String OPERATOR_RESET_PWD_URL = OPERATOR_BASE_URL + "resetPwd";
    public static final String OPERATOR_DELETE_URL = OPERATOR_BASE_URL + "delete";
    public static final String OPERATOR_TREE_ROLE_DATA_URL = OPERATOR_BASE_URL + "roles";
    public static final String OPERATOR_TREE_ROLE_DATA_UPDATE_URL = OPERATOR_BASE_URL + "updateOperatorRoles";
    /**
     * 操作员账号列表
     */
    public static final String OPERATOR_SUB_BASE_URL = OPERATOR_BASE_URL + "sub/";
    public static final String OPERATOR_SUB_ADD_URL = OPERATOR_SUB_BASE_URL + "add";
    public static final String OPERATOR_SUB_UPDATE_URL = OPERATOR_SUB_BASE_URL + "update";
    public static final String OPERATOR_SUB_SWITCH_STATUS_URL = OPERATOR_SUB_BASE_URL + "switchStatus";
    public static final String OPERATOR_SUB_DELETE_URL = OPERATOR_SUB_BASE_URL + "delete";
    /**
     * 格式管理
     */
    public static final String FORMAT_BASE_URL = MANAGER_URL + "format/";
    public static final String FORMAT_ADD_URL = FORMAT_BASE_URL + "add";
    public static final String FORMAT_UPDATE_URL = FORMAT_BASE_URL + "update";
    public static final String FORMAT_DELETE_URL = FORMAT_BASE_URL + "delete";
    /**
     * 格式详细管理
     */
    public static final String FORMAT_DETAIL_BASE_URL = FORMAT_BASE_URL + "detail/";
    public static final String FORMAT_DETAIL_TREE_URL = FORMAT_DETAIL_BASE_URL + "tree";
    public static final String FORMAT_DETAIL_ADD_URL = FORMAT_DETAIL_BASE_URL + "add";
    public static final String FORMAT_DETAIL_UPDATE_URL = FORMAT_DETAIL_BASE_URL + "update";
    public static final String FORMAT_DETAIL_SWITCH_STATUS_URL = FORMAT_DETAIL_BASE_URL + "switchStatus";
    public static final String FORMAT_DETAIL_DELETE_URL = FORMAT_DETAIL_BASE_URL + "delete";
    /**
     * 流程列表
     */
    public static final String PROCESS_BASE_URL = MANAGER_URL + "process/";
    public static final String PROCESS_DATAGRID_BTN = PROCESS_BASE_URL + "showDataGridBtn";
    public static final String PROCESS_DATAGRID_IS_EDIT = PROCESS_BASE_URL + "showDataGridIsEdit";
    public static final String PROCESS_PROCESS_STATUS = PROCESS_BASE_URL + "getProcessAuditStatus";
    public static final String PROCESS_SHOW_HOME = PROCESS_BASE_URL + "showDataGridProcess";
    public static final String PROCESS_SUBMIT = PROCESS_BASE_URL + "submit";
    public static final String PROCESS_WITHDRAW = PROCESS_BASE_URL + "withdraw";
    public static final String PROCESS_LOG = PROCESS_BASE_URL + "log";
    public static final String PROCESS_LOG_LIST = PROCESS_BASE_URL + "log/list";
    /**
     * 流程定义列表
     */
    public static final String PROCESS_DEFINITION_BASE_URL = PROCESS_BASE_URL + "definition/";
    public static final String PROCESS_DEFINITION_TREE_DATA = PROCESS_DEFINITION_BASE_URL + "tree";
    public static final String PROCESS_DEFINITION_ADD_URL = PROCESS_DEFINITION_BASE_URL + "add";
    public static final String PROCESS_DEFINITION_UPDATE_URL = PROCESS_DEFINITION_BASE_URL + "update";
    public static final String PROCESS_DEFINITION_SWITCH_STATUS_URL = PROCESS_DEFINITION_BASE_URL + "switchStatus";
    public static final String PROCESS_DEFINITION_COPY_URL = PROCESS_DEFINITION_BASE_URL + "copy";
    /**
     * 流程定义列表
     */
    public static final String PROCESS_STEP_BASE_URL = PROCESS_BASE_URL + "step/";
    public static final String PROCESS_STEP_ADD_URL = PROCESS_STEP_BASE_URL + "add";
    public static final String PROCESS_STEP_UPDATE_URL = PROCESS_STEP_BASE_URL + "update";
    public static final String PROCESS_STEP_DELETE_URL = PROCESS_STEP_BASE_URL + "delete";
    /**
     * 流程启动角色列表
     */
    public static final String PROCESS_START_BASE_URL = PROCESS_BASE_URL + "start/";
    public static final String PROCESS_START_ADD_URL = PROCESS_START_BASE_URL + "add";
    public static final String PROCESS_START_UPDATE_URL = PROCESS_START_BASE_URL + "update";
    public static final String PROCESS_START_DELETE_URL = PROCESS_START_BASE_URL + "delete";
    /**
     * 流程进度列表
     */
    public static final String PROCESS_SCHEDULE_BASE_URL = PROCESS_BASE_URL + "schedule/";
    public static final String PROCESS_SCHEDULE_CANCEL_URL = PROCESS_SCHEDULE_BASE_URL + "cancel";
    /**
     * 部门
     */
    public static final String DIVISION_BASE_URL = MANAGER_URL + "division/";
    public static final String DIVISION_ADD_URL = DIVISION_BASE_URL + "add";
    public static final String DIVISION_UPDATE_URL = DIVISION_BASE_URL + "update";
    public static final String DIVISION_DELETE_URL = DIVISION_BASE_URL + "delete";
    public static final String DIVISION_TREE_DATA_URL = DIVISION_BASE_URL + "tree";
    /**
     * 部门人员
     */
    public static final String DIVISION_PERSONNEL_BASE_URL = DIVISION_BASE_URL + "personnel/";
    public static final String DIVISION_PERSONNEL_ADD_URL = DIVISION_PERSONNEL_BASE_URL + "add";
    public static final String DIVISION_PERSONNEL_UPDATE_URL = DIVISION_PERSONNEL_BASE_URL + "update";
    public static final String DIVISION_PERSONNEL_ADDOUNT_INFO_URL = DIVISION_PERSONNEL_BASE_URL + "accountInfo";
    public static final String DIVISION_PERSONNEL_RESET_PWD_URL = DIVISION_PERSONNEL_BASE_URL + "resetPwd";
    public static final String DIVISION_PERSONNEL_DELETE_URL = DIVISION_PERSONNEL_BASE_URL + "delete";
    /**
     * 系部
     */
    public static final String DEPARTMENT_BASE_URL = MANAGER_URL + "department/";
    public static final String DEPARTMENT_ADD_URL = DEPARTMENT_BASE_URL + "add";
    public static final String DEPARTMENT_UPDATE_URL = DEPARTMENT_BASE_URL + "update";
    public static final String DEPARTMENT_DELETE_URL = DEPARTMENT_BASE_URL + "delete";
    public static final String DEPARTMENT_TREE_DATA_URL = DEPARTMENT_BASE_URL + "tree";
    /**
     * 辅导员管理
     */
    public static final String DEPARTMENT_INSTRUCTOR_URL= DEPARTMENT_BASE_URL + "instructor/";
    public static final String DEPARTMENT_INSTRUCTOR_LIST_URL = DEPARTMENT_INSTRUCTOR_URL + "list";
    public static final String DEPARTMENT_INSTRUCTOR_CLASS_ADD_URL = DEPARTMENT_INSTRUCTOR_URL + "class/add";
    public static final String DEPARTMENT_INSTRUCTOR_CLASS_DELETE_URL = DEPARTMENT_INSTRUCTOR_URL + "class/delete";
    /**
     * 系部人员
     */
    public static final String DEPARTMENT_PERSONNEL_BASE_URL = DEPARTMENT_BASE_URL + "personnel/";
    public static final String DEPARTMENT_PERSONNEL_ADD_URL = DEPARTMENT_PERSONNEL_BASE_URL + "add";
    public static final String DEPARTMENT_PERSONNEL_UPDATE_URL = DEPARTMENT_PERSONNEL_BASE_URL + "update";
    public static final String DEPARTMENT_PERSONNEL_ADDOUNT_INFO_URL = DEPARTMENT_PERSONNEL_BASE_URL + "accountInfo";
    public static final String DEPARTMENT_PERSONNEL_RESET_PWD_URL = DEPARTMENT_PERSONNEL_BASE_URL + "resetPwd";
    public static final String DEPARTMENT_PERSONNEL_DELETE_URL = DEPARTMENT_PERSONNEL_BASE_URL + "delete";
    /**
     * 班级
     */
    public static final String CLASS_BASE_URL = MANAGER_URL + "cls/";
    public static final String CLASS_SELECT_DEPARTMENT_URL = CLASS_BASE_URL + "department";
    public static final String CLASS_ADD_URL = CLASS_BASE_URL + "add";
    public static final String CLASS_UPDATE_URL = CLASS_BASE_URL + "update";
    public static final String CLASS_DELETE_URL = CLASS_BASE_URL + "delete";
    public static final String CLASS_INSTRUCTOR_UPDATE_URL = CLASS_BASE_URL + "/instructor/update";
    /**
     * 教师
     */
    public static final String TEACHER_BASE_URL = MANAGER_URL + "teacher/";
    public static final String TEACHER_ADD_URL = TEACHER_BASE_URL + "add";
    public static final String TEACHER_UPDATE_URL = TEACHER_BASE_URL + "update";
    public static final String TEACHER_ADDOUNT_INFO_URL = TEACHER_BASE_URL + "accountInfo";
    public static final String TEACHER_RESET_PWD_URL = TEACHER_BASE_URL + "resetPwd";
    public static final String TEACHER_DELETE_URL = TEACHER_BASE_URL + "delete";
    /**
     * 文件管理
     */
    public static final String DOCUMENT_BASE_URL = MANAGER_URL + "document/";
    public static final String DOCUMENT_ADD_URL = DOCUMENT_BASE_URL + "add";
    public static final String DOCUMENT_UPDATE_URL = DOCUMENT_BASE_URL + "update";
    public static final String DOCUMENT_REPLY_URL = DOCUMENT_BASE_URL + "reply";
    public static final String DOCUMENT_DELETE_URL = DOCUMENT_BASE_URL + "delete";
    /**
     * 学生
     */
    public static final String STUDENT_BASE_URL = MANAGER_URL + "student/";
    public static final String STUDENT_LIST_URL = STUDENT_BASE_URL + "list";
    public static final String STUDENT_IMPORT_URL = STUDENT_BASE_URL + "import";
    public static final String STUDENT_IMPORT_QUERY_URL = STUDENT_BASE_URL + "importQuery";
    public static final String STUDENT_ADD_URL = STUDENT_BASE_URL + "add";
    public static final String STUDENT_UPDATE_URL = STUDENT_BASE_URL + "update";
    public static final String STUDENT_ADDOUNT_INFO_URL = STUDENT_BASE_URL + "accountInfo";
    public static final String STUDENT_RESET_PWD_URL = STUDENT_BASE_URL + "resetPwd";
    public static final String STUDENT_DELETE_URL = STUDENT_BASE_URL + "delete";
    /**
     * 学生考勤
     */
    public static final String STUDENT_ATTENDANCE_BASE_URL = STUDENT_BASE_URL + "attendance/";
    public static final String STUDENT_ATTENDANCE_ADD_URL = STUDENT_ATTENDANCE_BASE_URL + "add";
    public static final String STUDENT_ATTENDANCE_UPDATE_URL = STUDENT_ATTENDANCE_BASE_URL + "update";
    public static final String STUDENT_ATTENDANCE_DELETE_URL = STUDENT_ATTENDANCE_BASE_URL + "delete";
    /**
     * 学生处分
     */
    public static final String STUDENT_PUNISHMENT_BASE_URL = STUDENT_BASE_URL + "punishment/";
    public static final String STUDENT_PUNISHMENT_ADD_URL = STUDENT_PUNISHMENT_BASE_URL + "add";
    public static final String STUDENT_PUNISHMENT_UPDATE_URL = STUDENT_PUNISHMENT_BASE_URL + "update";
    public static final String STUDENT_PUNISHMENT_REVOKE_URL = STUDENT_PUNISHMENT_BASE_URL + "revoke";
    public static final String STUDENT_PUNISHMENT_DELETE_URL = STUDENT_PUNISHMENT_BASE_URL + "delete";
    /**
     * 学生综合素质评测
     */
    public static final String STUDENT_COMPREHENSIVE_BASE_URL = STUDENT_BASE_URL + "comprehensive/";
    public static final String STUDENT_COMPREHENSIVE_INSERT_AND_UPDATE_URL = STUDENT_COMPREHENSIVE_BASE_URL + "insertAndUpdate";
    public static final String STUDENT_COMPREHENSIVE_DELETE_URL = STUDENT_COMPREHENSIVE_BASE_URL + "delete";
    public static final String STUDENT_COMPREHENSIVE_IMPORT_URL = STUDENT_COMPREHENSIVE_BASE_URL + "import";
    /**
     * 困难学生认定
     */
    public static final String STUDENT_DIFFICULTY_BASE_URL = STUDENT_BASE_URL + "difficulty/";
    public static final String STUDENT_DIFFICULTY_ADD_URL = STUDENT_DIFFICULTY_BASE_URL + "add";
    public static final String STUDENT_DIFFICULTY_UPDATE_URL = STUDENT_DIFFICULTY_BASE_URL + "update";
    public static final String STUDENT_DIFFICULTY_DELETE_URL = STUDENT_DIFFICULTY_BASE_URL + "delete";
    public static final String STUDENT_DIFFICULTY_IMPORT_URL = STUDENT_DIFFICULTY_BASE_URL + "import";
    /**
     * 资助管理
     */
    public static final String AID_BASE_URL = MANAGER_URL + "aidFinancially/";
    /**
     * 学院奖学金
     */
    public static final String COLLEGE_SCHOLARSHIP_BASE_URL = AID_BASE_URL + "collegeScholarship/";
    public static final String COLLEGE_SCHOLARSHIP_ADD_URL = COLLEGE_SCHOLARSHIP_BASE_URL + "add";
    public static final String COLLEGE_SCHOLARSHIP_UPDATE_URL = COLLEGE_SCHOLARSHIP_BASE_URL + "update";
    public static final String COLLEGE_SCHOLARSHIP_DELETE_URL = COLLEGE_SCHOLARSHIP_BASE_URL + "delete";
    public static final String COLLEGE_SCHOLARSHIP_IMPORT_URL = COLLEGE_SCHOLARSHIP_BASE_URL + "import";
    /**
     * 年度表彰
     */
    public static final String COMMEND_BASE_URL = AID_BASE_URL + "commend/";
    public static final String COMMEND_ADD_URL = COMMEND_BASE_URL + "add";
    public static final String COMMEND_UPDATE_URL = COMMEND_BASE_URL + "update";
    public static final String COMMEND_DELETE_URL = COMMEND_BASE_URL + "delete";
    public static final String COMMEND_IMPORT_URL = COMMEND_BASE_URL + "import";
    /**
     * 绿色通道
     */
    public static final String GREEN_CHANNEL_BASE_URL = AID_BASE_URL + "greenChannel/";
    public static final String GREEN_CHANNEL_ADD_URL = GREEN_CHANNEL_BASE_URL + "add";
    public static final String GREEN_CHANNEL_UPDATE_URL = GREEN_CHANNEL_BASE_URL + "update";
    public static final String GREEN_CHANNEL_DELETE_URL = GREEN_CHANNEL_BASE_URL + "delete";
    public static final String GREEN_CHANNEL_IMPORT_URL = GREEN_CHANNEL_BASE_URL + "import";
    /**
     * 减免学费
     */
    public static final String TUITION_WAIVER_BASE_URL = AID_BASE_URL + "tuitionWaiver/";
    public static final String TUITION_WAIVER_ADD_URL = TUITION_WAIVER_BASE_URL + "add";
    public static final String TUITION_WAIVER_UPDATE_URL = TUITION_WAIVER_BASE_URL + "update";
    public static final String TUITION_WAIVER_DELETE_URL = TUITION_WAIVER_BASE_URL + "delete";
    public static final String TUITION_WAIVER_IMPORT_URL = TUITION_WAIVER_BASE_URL + "import";
    /**
     * 困难毕业生就业补助
     */
    public static final String JOBSEEKER_SUPPORT_BASE_URL = AID_BASE_URL + "jobseekerSupport/";
    public static final String JOBSEEKER_SUPPORT_ADD_URL = JOBSEEKER_SUPPORT_BASE_URL + "add";
    public static final String JOBSEEKER_SUPPORT_UPDATE_URL = JOBSEEKER_SUPPORT_BASE_URL + "update";
    public static final String JOBSEEKER_SUPPORT_DELETE_URL = JOBSEEKER_SUPPORT_BASE_URL + "delete";
    public static final String JOBSEEKER_SUPPORT_IMPORT_URL = JOBSEEKER_SUPPORT_BASE_URL + "import";
    /**
     * 应急求助
     */
    public static final String EMERGENCY_HELP_BASE_URL = AID_BASE_URL + "emergencyHelp/";
    public static final String EMERGENCY_HELP_ADD_URL = EMERGENCY_HELP_BASE_URL + "add";
    public static final String EMERGENCY_HELP_UPDATE_URL = EMERGENCY_HELP_BASE_URL + "update";
    public static final String EMERGENCY_HELP_DELETE_URL = EMERGENCY_HELP_BASE_URL + "delete";
    public static final String EMERGENCY_HELP_IMPORT_URL = EMERGENCY_HELP_BASE_URL + "import";
    /**
     * 国家奖学金
     */
    public static final String NATIONAL_SCHOLARSHIP_BASE_URL = AID_BASE_URL + "nationalScholarship/";
    public static final String NATIONAL_SCHOLARSHIP_ADD_URL = NATIONAL_SCHOLARSHIP_BASE_URL + "add";
    public static final String NATIONAL_SCHOLARSHIP_UPDATE_URL = NATIONAL_SCHOLARSHIP_BASE_URL + "update";
    public static final String NATIONAL_SCHOLARSHIP_DELETE_URL = NATIONAL_SCHOLARSHIP_BASE_URL + "delete";
    public static final String NATIONAL_SCHOLARSHIP_IMPORT_URL = NATIONAL_SCHOLARSHIP_BASE_URL + "import";
    /**
     * 国家助学金
     */
    public static final String NATIONAL_GRANTS_BASE_URL = AID_BASE_URL + "nationalGrants/";
    public static final String NATIONAL_GRANTS_ADD_URL = NATIONAL_GRANTS_BASE_URL + "add";
    public static final String NATIONAL_GRANTS_UPDATE_URL = NATIONAL_GRANTS_BASE_URL + "update";
    public static final String NATIONAL_GRANTS_DELETE_URL = NATIONAL_GRANTS_BASE_URL + "delete";
    public static final String NATIONAL_GRANTS_IMPORT_URL = NATIONAL_GRANTS_BASE_URL + "import";
    /**
     * 国家励志奖学金
     */
    public static final String NATIONAL_ENDEAVOR_BASE_URL = AID_BASE_URL + "nationalEndeavor/";
    public static final String NATIONAL_ENDEAVOR_ADD_URL = NATIONAL_ENDEAVOR_BASE_URL + "add";
    public static final String NATIONAL_ENDEAVOR_UPDATE_URL = NATIONAL_ENDEAVOR_BASE_URL + "update";
    public static final String NATIONAL_ENDEAVOR_DELETE_URL = NATIONAL_ENDEAVOR_BASE_URL + "delete";
    public static final String NATIONAL_ENDEAVOR_IMPORT_URL = NATIONAL_ENDEAVOR_BASE_URL + "import";
    /**
     * 勤工助学
     */
    public static final String DILIGENT_BASE_URL = MANAGER_URL + "diligent/";
    public static final String DILIGENT_STUDY_BASE_URL = DILIGENT_BASE_URL + "study/";
    public static final String DILIGENT_STUDY_ADD_URL = DILIGENT_STUDY_BASE_URL + "add";
    public static final String DILIGENT_STUDY_UPDATE_URL = DILIGENT_STUDY_BASE_URL + "update";
    public static final String DILIGENT_STUDY_DELETE_URL = DILIGENT_STUDY_BASE_URL + "delete";
    /**
     * 勤工助学岗位
     */
    public static final String DILIGENT_STUDY_POST_BASE_URL = DILIGENT_BASE_URL + "post/";
    public static final String DILIGENT_STUDY_POST_ADD_URL = DILIGENT_STUDY_POST_BASE_URL + "add";
    public static final String DILIGENT_STUDY_POST_UPDATE_URL = DILIGENT_STUDY_POST_BASE_URL + "update";
    public static final String DILIGENT_STUDY_POST_DELETE_URL = DILIGENT_STUDY_POST_BASE_URL + "delete";
    /**
     * 勤工助学学生
     */
    public static final String DILIGENT_STUDY_STUDENT_BASE_URL = DILIGENT_BASE_URL + "student/";
    public static final String DILIGENT_STUDY_STUDENT_ADD_URL = DILIGENT_STUDY_STUDENT_BASE_URL + "add";
    public static final String DILIGENT_STUDY_STUDENT_UPDATE_URL = DILIGENT_STUDY_STUDENT_BASE_URL + "update";
    public static final String DILIGENT_STUDY_STUDENT_DELETE_URL = DILIGENT_STUDY_STUDENT_BASE_URL + "delete";
    public static final String DILIGENT_STUDY_STUDENT_IMPORT_URL = DILIGENT_STUDY_STUDENT_BASE_URL + "import";
    /**
     * 勤工助学月工资
     */
    public static final String DILIGENT_STUDY_MONTH_WAGES_BASE_URL = DILIGENT_BASE_URL + "monthWages/";
    public static final String DILIGENT_STUDY_MONTH_WAGES_ADD_URL = DILIGENT_STUDY_MONTH_WAGES_BASE_URL + "add";
    public static final String DILIGENT_STUDY_MONTH_WAGES_UPDATE_URL = DILIGENT_STUDY_MONTH_WAGES_BASE_URL + "update";
    public static final String DILIGENT_STUDY_MONTH_WAGES_DELETE_URL = DILIGENT_STUDY_MONTH_WAGES_BASE_URL + "delete";
    public static final String DILIGENT_STUDY_MONTH_WAGES_IMPORT_URL = DILIGENT_STUDY_MONTH_WAGES_BASE_URL + "import";
}
