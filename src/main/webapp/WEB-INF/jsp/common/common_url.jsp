<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--URL地址--%>
<c:set var="BASE_URL" value="${pageContext.request.contextPath}/" scope="application"/>
<c:set var="MANAGER_URL" value="${BASE_URL}admin/" scope="application"/>
<c:set var="EDIT_USER" value="${MANAGER_URL}editUser" scope="application"/>
<c:set var="EDIT_PASSWORD" value="${MANAGER_URL}editPwd" scope="application"/>
<%--图片地址url--%>
<c:set var="IMG_URL" value="${BASE_URL}${AttributePath.FILE_PREVIEW_URL}" scope="application"/>
<c:set var="DOWN_URL" value="${BASE_URL}${AttributePath.FILE_DOWNLOAD_URL}" scope="application"/>
<c:set var="DOWN_CACHE_URL"
       value="${BASE_URL}${AttributePath.FILE_DOWNLOAD_URL}${AttributePath.FILE_SERVICE_CACHE_PATH}"
       scope="application"/>
<%--excel导出地址--%>
<c:set var="EXPORT_URL" value="${BASE_URL}file/export/" scope="application"/>
<%--列表地址--%>
<c:set var="DATA_GRID_URL" value="${MANAGER_URL}dataGrid/data/" scope="application"/>
<c:set var="TREE_GRID_URL" value="${MANAGER_URL}treeGrid/data/" scope="application"/>
<c:set var="DIFF_URL" value="${MANAGER_URL}diff" scope="application"/>
<%--系统配置管理--%>
<c:set var="ALLOCATION_BASE_URL" value="${MANAGER_URL}allocation/" scope="application"/>
<%--邮箱配置管理--%>
<c:set var="EMAIL_BASE_URL" value="${ALLOCATION_BASE_URL}email" scope="application"/>
<c:set var="EMAIL_CACHE_URL" value="${EMAIL_BASE_URL}/cache" scope="application"/>
<%--综合素质测评比例配置管理--%>
<c:set var="COMPREHENSIVE_BASE_URL" value="${ALLOCATION_BASE_URL}comprehensive" scope="application"/>
<%--迟到旷课处分配置管理--%>
<c:set var="PUNISHMENT_BASE_URL" value="${ALLOCATION_BASE_URL}punishment" scope="application"/>
<%--授权--%>
<c:set var="AUTHORIZATION_BASE_URL" value="${MANAGER_URL}authorization/" scope="application"/>
<c:set var="AUTHORIZATION_TREE_URL" value="${AUTHORIZATION_BASE_URL}tree" scope="application"/>
<c:set var="AUTHORIZATION_UPDATE_URL" value="${AUTHORIZATION_BASE_URL}update" scope="application"/>
<%--日志--%>
<c:set var="LOG_BASE_URL" value="${MANAGER_URL}log/" scope="application"/>
<%--变动记录--%>
<c:set var="LOG_VALUE_RECORD_BASE_URL" value="${LOG_BASE_URL}valueRecord/" scope="application"/>
<c:set var="LOG_VALUE_RECORD_DETAIL_URL" value="${LOG_VALUE_RECORD_BASE_URL}detail/column" scope="application"/>
<%--菜单管理--%>
<c:set var="MENU_BASE_URL" value="${MANAGER_URL}menu/" scope="application"/>
<c:set var="MENU_LIST_URL" value="${MENU_BASE_URL}list" scope="application"/>
<c:set var="MENU_TREE_DATA_URL" value="${MENU_BASE_URL}getMenuTreeData" scope="application"/>
<c:set var="MENU_TREE_BUTTON_DATA_URL" value="${MENU_BASE_URL}getMenuButtonTreeData" scope="application"/>
<c:set var="MENU_TREE_BUTTON_DATA_UPDATE_URL" value="${MENU_BASE_URL}updateMenuButton" scope="application"/>
<c:set var="MENU_ADD_URL" value="${MENU_BASE_URL}add" scope="application"/>
<c:set var="MENU_UPDATE_URL" value="${MENU_BASE_URL}update" scope="application"/>
<c:set var="MENU_COPY_URL" value="${MENU_BASE_URL}copy" scope="application"/>
<c:set var="MENU_SWITCH_STATUS_URL" value="${MENU_BASE_URL}switchStatus" scope="application"/>
<c:set var="MENU_DELETE_URL" value="${MENU_BASE_URL}delete" scope="application"/>
<%--配置列表--%>
<c:set var="CONFIGURE_BASE_URL" value="${MANAGER_URL}configure/" scope="application"/>
<c:set var="CONFIGURE_TREE_DATA_URL" value="${CONFIGURE_BASE_URL}getConfigureTreeData" scope="application"/>
<c:set var="CONFIGURE_ADD_URL" value="${CONFIGURE_BASE_URL}add" scope="application"/>
<c:set var="CONFIGURE_UPDATE_URL" value="${CONFIGURE_BASE_URL}update" scope="application"/>
<c:set var="CONFIGURE_COPY_URL" value="${CONFIGURE_BASE_URL}copy" scope="application"/>
<c:set var="CONFIGURE_DELETE_URL" value="${CONFIGURE_BASE_URL}delete" scope="application"/>
<%--配置列表列--%>
<c:set var="CONFIGURE_COLUMN_BASE_URL" value="${CONFIGURE_BASE_URL}column/" scope="application"/>
<c:set var="CONFIGURE_COLUMN_ADD_URL" value="${CONFIGURE_COLUMN_BASE_URL}add" scope="application"/>
<c:set var="CONFIGURE_COLUMN_UPDATE_URL" value="${CONFIGURE_COLUMN_BASE_URL}update" scope="application"/>
<c:set var="CONFIGURE_COLUMN_DELETE_URL" value="${CONFIGURE_COLUMN_BASE_URL}delete" scope="application"/>
<%--配置列表搜索--%>
<c:set var="CONFIGURE_SEARCH_BASE_URL" value="${CONFIGURE_BASE_URL}search/" scope="application"/>
<c:set var="CONFIGURE_SEARCH_ADD_URL" value="${CONFIGURE_SEARCH_BASE_URL}add" scope="application"/>
<c:set var="CONFIGURE_SEARCH_UPDATE_URL" value="${CONFIGURE_SEARCH_BASE_URL}update" scope="application"/>
<c:set var="CONFIGURE_SEARCH_DELETE_URL" value="${CONFIGURE_SEARCH_BASE_URL}delete" scope="application"/>
<%--配置列表文件--%>
<c:set var="CONFIGURE_FILE_BASE_URL" value="${CONFIGURE_BASE_URL}file/" scope="application"/>
<c:set var="CONFIGURE_FILE_ADD_URL" value="${CONFIGURE_FILE_BASE_URL}add" scope="application"/>
<c:set var="CONFIGURE_FILE_UPDATE_URL" value="${CONFIGURE_FILE_BASE_URL}update" scope="application"/>
<c:set var="CONFIGURE_FILE_SWITCH_STATUS_URL" value="${CONFIGURE_FILE_BASE_URL}switchStatus" scope="application"/>
<c:set var="CONFIGURE_FILE_DELETE_URL" value="${CONFIGURE_FILE_BASE_URL}delete" scope="application"/>
<%--按钮列表--%>
<c:set var="BUTTON_BASE_URL" value="${MANAGER_URL}button/" scope="application"/>
<c:set var="BUTTON_ADD_URL" value="${BUTTON_BASE_URL}add" scope="application"/>
<c:set var="BUTTON_UPDATE_URL" value="${BUTTON_BASE_URL}update" scope="application"/>
<c:set var="BUTTON_DELETE_URL" value="${BUTTON_BASE_URL}delete" scope="application"/>
<%--角色--%>
<c:set var="ROLE_BASE_URL" value="${MANAGER_URL}role/" scope="application"/>
<c:set var="ROLE_LIST_URL" value="${ROLE_BASE_URL}list" scope="application"/>
<c:set var="ROLE_TREE_DATA_URL" value="${ROLE_BASE_URL}tree" scope="application"/>
<c:set var="ROLE_ADD_URL" value="${ROLE_BASE_URL}add" scope="application"/>
<c:set var="ROLE_UPDATE_URL" value="${ROLE_BASE_URL}update" scope="application"/>
<c:set var="ROLE_PERMISSION_TREE_MENU" value="${ROLE_BASE_URL}menuTree/" scope="application"/>
<c:set var="ROLE_PERMISSION_TREE_MENU_DATA" value="${ROLE_BASE_URL}getMenuTreeData/" scope="application"/>
<c:set var="ROLE_PERMISSION_TREE_MENU_UPDATE" value="${ROLE_BASE_URL}updateRoleMenuPermission" scope="application"/>
<c:set var="ROLE_PERMISSION_TREE_BUTTON" value="${ROLE_BASE_URL}buttonTree/" scope="application"/>
<c:set var="ROLE_PERMISSION_TREE_BUTTON_DATA" value="${ROLE_BASE_URL}getButtonTreeData/" scope="application"/>
<c:set var="ROLE_PERMISSION_TREE_BUTTON_UPDATE" value="${ROLE_BASE_URL}updateRoleButtonPermission" scope="application"/>
<c:set var="ROLE_SWITCH_STATUS_URL" value="${ROLE_BASE_URL}switchStatus" scope="application"/>
<c:set var="ROLE_DELETE_URL" value="${ROLE_BASE_URL}delete" scope="application"/>
<%--验证--%>
<c:set var="VALIDATE_BASE_URL" value="${MANAGER_URL}validate/" scope="application"/>
<c:set var="VALIDATE_ADD_URL" value="${VALIDATE_BASE_URL}add" scope="application"/>
<c:set var="VALIDATE_UPDATE_URL" value="${VALIDATE_BASE_URL}update" scope="application"/>
<c:set var="VALIDATE_SWITCH_STATUS_URL" value="${VALIDATE_BASE_URL}switchStatus" scope="application"/>
<c:set var="VALIDATE_DELETE_URL" value="${VALIDATE_BASE_URL}delete" scope="application"/>
<%--验证字段--%>
<c:set var="VALIDATE_FIELD_BASE_URL" value="${VALIDATE_BASE_URL}field/" scope="application"/>
<c:set var="VALIDATE_FIELD_LIST_URL" value="${VALIDATE_FIELD_BASE_URL}list" scope="application"/>
<c:set var="VALIDATE_FIELD_ADD_URL" value="${VALIDATE_FIELD_BASE_URL}add" scope="application"/>
<c:set var="VALIDATE_FIELD_UPDATE_URL" value="${VALIDATE_FIELD_BASE_URL}update" scope="application"/>
<c:set var="VALIDATE_FIELD_SWITCH_STATUS_URL" value="${VALIDATE_FIELD_BASE_URL}switchStatus" scope="application"/>
<c:set var="VALIDATE_FIELD_DELETE_URL" value="${VALIDATE_FIELD_BASE_URL}delete" scope="application"/>
<%--验证组--%>
<c:set var="VALIDATE_GROUP_BASE_URL" value="${VALIDATE_BASE_URL}group/" scope="application"/>
<c:set var="VALIDATE_GROUP_ADD_URL" value="${VALIDATE_GROUP_BASE_URL}add" scope="application"/>
<c:set var="VALIDATE_GROUP_UPDATE_URL" value="${VALIDATE_GROUP_BASE_URL}update" scope="application"/>
<c:set var="VALIDATE_GROUP_DELETE_URL" value="${VALIDATE_GROUP_BASE_URL}delete" scope="application"/>
<%--验证正则--%>
<c:set var="VALIDATE_REGEX_BASE_URL" value="${VALIDATE_BASE_URL}regex/" scope="application"/>
<c:set var="VALIDATE_REGEX_TREE_DATA_URL" value="${VALIDATE_REGEX_BASE_URL}tree" scope="application"/>
<c:set var="VALIDATE_REGEX_ADD_URL" value="${VALIDATE_REGEX_BASE_URL}add" scope="application"/>
<c:set var="VALIDATE_REGEX_UPDATE_URL" value="${VALIDATE_REGEX_BASE_URL}update" scope="application"/>
<c:set var="VALIDATE_REGEX_SWITCH_STATUS_URL" value="${VALIDATE_REGEX_BASE_URL}switchStatus" scope="application"/>
<c:set var="VALIDATE_REGEX_DELETE_URL" value="${VALIDATE_REGEX_BASE_URL}delete" scope="application"/>
<%--字典--%>
<c:set var="DICT_BASE_URL" value="${MANAGER_URL}dict/" scope="application"/>
<c:set var="DICT_ADD_URL" value="${DICT_BASE_URL}add" scope="application"/>
<c:set var="DICT_UPDATE_URL" value="${DICT_BASE_URL}update" scope="application"/>
<c:set var="DICT_SWITCH_STATUS_URL" value="${DICT_BASE_URL}switchStatus" scope="application"/>
<c:set var="DICT_DELETE_URL" value="${DICT_BASE_URL}delete" scope="application"/>
<c:set var="DICT_CACHE_URL" value="${DICT_BASE_URL}cache" scope="application"/>
<%--字典信息--%>
<c:set var="DICT_INFO_BASE_URL" value="${DICT_BASE_URL}info/" scope="application"/>
<c:set var="DICT_INFO_TREE_URL" value="${DICT_INFO_BASE_URL}tree" scope="application"/>
<c:set var="DICT_INFO_ADD_URL" value="${DICT_INFO_BASE_URL}add" scope="application"/>
<c:set var="DICT_INFO_UPDATE_URL" value="${DICT_INFO_BASE_URL}update" scope="application"/>
<c:set var="DICT_INFO_SWITCH_STATUS_URL" value="${DICT_INFO_BASE_URL}switchStatus" scope="application"/>
<c:set var="DICT_INFO_DELETE_URL" value="${DICT_INFO_BASE_URL}delete" scope="application"/>
<%--操作员列表--%>
<c:set var="OPERATOR_BASE_URL" value="${MANAGER_URL}operator/" scope="application"/>
<c:set var="OPERATOR_ADD_URL" value="${OPERATOR_BASE_URL}add" scope="application"/>
<c:set var="OPERATOR_UPDATE_URL" value="${OPERATOR_BASE_URL}update" scope="application"/>
<c:set var="OPERATOR_SWITCH_STATUS_URL" value="${OPERATOR_BASE_URL}switchStatus" scope="application"/>
<c:set var="OPERATOR_RESET_PWD_URL" value="${OPERATOR_BASE_URL}resetPwd" scope="application"/>
<c:set var="OPERATOR_DELETE_URL" value="${OPERATOR_BASE_URL}delete" scope="application"/>
<c:set var="OPERATOR_TREE_ROLE_DATA_URL" value="${OPERATOR_BASE_URL}roles" scope="application"/>
<c:set var="OPERATOR_TREE_ROLE_DATA_UPDATE_URL" value="${OPERATOR_BASE_URL}updateOperatorRoles" scope="application"/>
<%--操作员账号列表--%>
<c:set var="OPERATOR_SUB_BASE_URL" value="${OPERATOR_BASE_URL}sub/" scope="application"/>
<c:set var="OPERATOR_SUB_ADD_URL" value="${OPERATOR_SUB_BASE_URL}add" scope="application"/>
<c:set var="OPERATOR_SUB_UPDATE_URL" value="${OPERATOR_SUB_BASE_URL}update" scope="application"/>
<c:set var="OPERATOR_SUB_SWITCH_STATUS_URL" value="${OPERATOR_SUB_BASE_URL}switchStatus" scope="application"/>
<c:set var="OPERATOR_SUB_DELETE_URL" value="${OPERATOR_SUB_BASE_URL}delete" scope="application"/>
<%--格式管理--%>
<c:set var="FORMAT_BASE_URL" value="${MANAGER_URL}format/" scope="application"/>
<c:set var="FORMAT_ADD_URL" value="${FORMAT_BASE_URL}add" scope="application"/>
<c:set var="FORMAT_UPDATE_URL" value="${FORMAT_BASE_URL}update" scope="application"/>
<c:set var="FORMAT_DELETE_URL" value="${FORMAT_BASE_URL}delete" scope="application"/>
<%--格式详细管理--%>
<c:set var="FORMAT_DETAIL_BASE_URL" value="${FORMAT_BASE_URL}detail/" scope="application"/>
<c:set var="FORMAT_DETAIL_TREE_URL" value="${FORMAT_DETAIL_BASE_URL}tree" scope="application"/>
<c:set var="FORMAT_DETAIL_ADD_URL" value="${FORMAT_DETAIL_BASE_URL}add" scope="application"/>
<c:set var="FORMAT_DETAIL_UPDATE_URL" value="${FORMAT_DETAIL_BASE_URL}update" scope="application"/>
<c:set var="FORMAT_DETAIL_SWITCH_STATUS_URL" value="${FORMAT_DETAIL_BASE_URL}switchStatus" scope="application"/>
<c:set var="FORMAT_DETAIL_DELETE_URL" value="${FORMAT_DETAIL_BASE_URL}delete" scope="application"/>
<%--流程列表--%>
<c:set var="PROCESS_BASE_URL" value="${MANAGER_URL}process/" scope="application"/>
<c:set var="PROCESS_DATAGRID_BTN" value="${PROCESS_BASE_URL}showDataGridBtn" scope="application"/>
<c:set var="PROCESS_DATAGRID_IS_EDIT" value="${PROCESS_BASE_URL}showDataGridIsEdit" scope="application"/>
<c:set var="PROCESS_SHOW_HOME" value="${PROCESS_BASE_URL}showDataGridProcess" scope="application"/>
<c:set var="PROCESS_SUBMIT" value="${PROCESS_BASE_URL}submit" scope="application"/>
<c:set var="PROCESS_WITHDRAW" value="${PROCESS_BASE_URL}withdraw" scope="application"/>
<c:set var="PROCESS_LOG" value="${PROCESS_BASE_URL}log" scope="application"/>
<c:set var="PROCESS_LOG_LIST" value="${PROCESS_BASE_URL}log/list" scope="application"/>
<%--流程定义列表--%>
<c:set var="PROCESS_DEFINITION_BASE_URL" value="${PROCESS_BASE_URL}definition/" scope="application"/>
<c:set var="PROCESS_DEFINITION_TREE_DATA" value="${PROCESS_DEFINITION_BASE_URL}tree" scope="application"/>
<c:set var="PROCESS_DEFINITION_ADD_URL" value="${PROCESS_DEFINITION_BASE_URL}add" scope="application"/>
<c:set var="PROCESS_DEFINITION_UPDATE_URL" value="${PROCESS_DEFINITION_BASE_URL}update" scope="application"/>
<c:set var="PROCESS_DEFINITION_SWITCH_STATUS_URL" value="${PROCESS_DEFINITION_BASE_URL}switchStatus"
       scope="application"/>
<c:set var="PROCESS_DEFINITION_COPY_URL" value="${PROCESS_DEFINITION_BASE_URL}copy" scope="application"/>
<%--流程定义列表--%>
<c:set var="PROCESS_STEP_BASE_URL" value="${PROCESS_BASE_URL}step/" scope="application"/>
<c:set var="PROCESS_STEP_ADD_URL" value="${PROCESS_STEP_BASE_URL}add" scope="application"/>
<c:set var="PROCESS_STEP_UPDATE_URL" value="${PROCESS_STEP_BASE_URL}update" scope="application"/>
<c:set var="PROCESS_STEP_DELETE_URL" value="${PROCESS_STEP_BASE_URL}delete" scope="application"/>
<%--流程启动角色列表--%>
<c:set var="PROCESS_START_BASE_URL" value="${PROCESS_BASE_URL}start/" scope="application"/>
<c:set var="PROCESS_START_ADD_URL" value="${PROCESS_START_BASE_URL}add" scope="application"/>
<c:set var="PROCESS_START_UPDATE_URL" value="${PROCESS_START_BASE_URL}update" scope="application"/>
<c:set var="PROCESS_START_DELETE_URL" value="${PROCESS_START_BASE_URL}delete" scope="application"/>
<%--流程进度列表--%>
<c:set var="PROCESS_SCHEDULE_BASE_URL" value="${PROCESS_BASE_URL}schedule/" scope="application"/>
<c:set var="PROCESS_SCHEDULE_CANCEL_URL" value="${PROCESS_SCHEDULE_BASE_URL}cancel" scope="application"/>
<%--部门--%>
<c:set var="DIVISION_BASE_URL" value="${MANAGER_URL}division/" scope="application"/>
<c:set var="DIVISION_ADD_URL" value="${DIVISION_BASE_URL}add" scope="application"/>
<c:set var="DIVISION_UPDATE_URL" value="${DIVISION_BASE_URL}update" scope="application"/>
<c:set var="DIVISION_DELETE_URL" value="${DIVISION_BASE_URL}delete" scope="application"/>
<c:set var="DIVISION_TREE_DATA_URL" value="${DIVISION_BASE_URL}tree" scope="application"/>
<%--部门人员--%>
<c:set var="DIVISION_PERSONNEL_BASE_URL" value="${DIVISION_BASE_URL}personnel/" scope="application"/>
<c:set var="DIVISION_PERSONNEL_ADD_URL" value="${DIVISION_PERSONNEL_BASE_URL}add" scope="application"/>
<c:set var="DIVISION_PERSONNEL_UPDATE_URL" value="${DIVISION_PERSONNEL_BASE_URL}update" scope="application"/>
<c:set var="DIVISION_PERSONNEL_ADDOUNT_INFO_URL" value="${DIVISION_PERSONNEL_BASE_URL}accountInfo" scope="application"/>
<c:set var="DIVISION_PERSONNEL_RESET_PWD_URL" value="${DIVISION_PERSONNEL_BASE_URL}resetPwd" scope="application"/>
<c:set var="DIVISION_PERSONNEL_DELETE_URL" value="${DIVISION_PERSONNEL_BASE_URL}delete" scope="application"/>
<%--系部--%>
<c:set var="DEPARTMENT_BASE_URL" value="${MANAGER_URL}department/" scope="application"/>
<c:set var="DEPARTMENT_ADD_URL" value="${DEPARTMENT_BASE_URL}add" scope="application"/>
<c:set var="DEPARTMENT_UPDATE_URL" value="${DEPARTMENT_BASE_URL}update" scope="application"/>
<c:set var="DEPARTMENT_DELETE_URL" value="${DEPARTMENT_BASE_URL}delete" scope="application"/>
<c:set var="DEPARTMENT_TREE_DATA_URL" value="${DEPARTMENT_BASE_URL}tree" scope="application"/>
<%--系部人员--%>
<c:set var="DEPARTMENT_PERSONNEL_BASE_URL" value="${DEPARTMENT_BASE_URL}personnel/" scope="application"/>
<c:set var="DEPARTMENT_PERSONNEL_ADD_URL" value="${DEPARTMENT_PERSONNEL_BASE_URL}add" scope="application"/>
<c:set var="DEPARTMENT_PERSONNEL_UPDATE_URL" value="${DEPARTMENT_PERSONNEL_BASE_URL}update" scope="application"/>
<c:set var="DEPARTMENT_PERSONNEL_ADDOUNT_INFO_URL" value="${DEPARTMENT_PERSONNEL_BASE_URL}accountInfo"
       scope="application"/>
<c:set var="DEPARTMENT_PERSONNEL_RESET_PWD_URL" value="${DEPARTMENT_PERSONNEL_BASE_URL}resetPwd" scope="application"/>
<c:set var="DEPARTMENT_PERSONNEL_DELETE_URL" value="${DEPARTMENT_PERSONNEL_BASE_URL}delete" scope="application"/>
<%--班级--%>
<c:set var="CLASS_BASE_URL" value="${MANAGER_URL}cls/" scope="application"/>
<c:set var="CLASS_SELECT_DEPARTMENT_URL" value="${CLASS_BASE_URL}department" scope="application"/>
<c:set var="CLASS_ADD_URL" value="${CLASS_BASE_URL}add" scope="application"/>
<c:set var="CLASS_UPDATE_URL" value="${CLASS_BASE_URL}update" scope="application"/>
<c:set var="CLASS_DELETE_URL" value="${CLASS_BASE_URL}delete" scope="application"/>
<%--教师--%>
<c:set var="TEACHER_BASE_URL" value="${MANAGER_URL}teacher/" scope="application"/>
<c:set var="TEACHER_ADD_URL" value="${TEACHER_BASE_URL}add" scope="application"/>
<c:set var="TEACHER_UPDATE_URL" value="${TEACHER_BASE_URL}update" scope="application"/>
<c:set var="TEACHER_ADDOUNT_INFO_URL" value="${TEACHER_BASE_URL}accountInfo" scope="application"/>
<c:set var="TEACHER_RESET_PWD_URL" value="${TEACHER_BASE_URL}resetPwd" scope="application"/>
<c:set var="TEACHER_DELETE_URL" value="${TEACHER_BASE_URL}delete" scope="application"/>
<%--文件管理--%>
<c:set var="DOCUMENT_BASE_URL" value="${MANAGER_URL}document/" scope="application"/>
<c:set var="DOCUMENT_ADD_URL" value="${DOCUMENT_BASE_URL}add" scope="application"/>
<c:set var="DOCUMENT_UPDATE_URL" value="${DOCUMENT_BASE_URL}update" scope="application"/>
<c:set var="DOCUMENT_REPLY_URL" value="${DOCUMENT_BASE_URL}reply" scope="application"/>
<c:set var="DOCUMENT_DELETE_URL" value="${DOCUMENT_BASE_URL}delete" scope="application"/>
<%--学生--%>
<c:set var="STUDENT_BASE_URL" value="${MANAGER_URL}student/" scope="application"/>
<c:set var="STUDENT_LIST_URL" value="${STUDENT_BASE_URL}list" scope="application"/>
<c:set var="STUDENT_IMPORT_QUERY_URL" value="${STUDENT_BASE_URL}importQuery" scope="application"/>
<c:set var="STUDENT_ADD_URL" value="${STUDENT_BASE_URL}add" scope="application"/>
<c:set var="STUDENT_UPDATE_URL" value="${STUDENT_BASE_URL}update" scope="application"/>
<c:set var="STUDENT_ADDOUNT_INFO_URL" value="${STUDENT_BASE_URL}accountInfo" scope="application"/>
<c:set var="STUDENT_RESET_PWD_URL" value="${STUDENT_BASE_URL}resetPwd" scope="application"/>
<c:set var="STUDENT_DELETE_URL" value="${STUDENT_BASE_URL}delete" scope="application"/>
<%--学生考勤--%>
<c:set var="STUDENT_ATTENDANCE_BASE_URL" value="${STUDENT_BASE_URL}attendance/" scope="application"/>
<c:set var="STUDENT_ATTENDANCE_ADD_URL" value="${STUDENT_ATTENDANCE_BASE_URL}add" scope="application"/>
<c:set var="STUDENT_ATTENDANCE_UPDATE_URL" value="${STUDENT_ATTENDANCE_BASE_URL}update" scope="application"/>
<c:set var="STUDENT_ATTENDANCE_DELETE_URL" value="${STUDENT_ATTENDANCE_BASE_URL}delete" scope="application"/>
<%--学生处分--%>
<c:set var="STUDENT_PUNISHMENT_BASE_URL" value="${STUDENT_BASE_URL}punishment/" scope="application"/>
<c:set var="STUDENT_PUNISHMENT_ADD_URL" value="${STUDENT_PUNISHMENT_BASE_URL}add" scope="application"/>
<c:set var="STUDENT_PUNISHMENT_UPDATE_URL" value="${STUDENT_PUNISHMENT_BASE_URL}update" scope="application"/>
<c:set var="STUDENT_PUNISHMENT_REVOKE_URL" value="${STUDENT_PUNISHMENT_BASE_URL}revoke" scope="application"/>
<c:set var="STUDENT_PUNISHMENT_DELETE_URL" value="${STUDENT_PUNISHMENT_BASE_URL}delete" scope="application"/>
<%--学生综合素质评测--%>
<c:set var="STUDENT_COMPREHENSIVE_BASE_URL" value="${STUDENT_BASE_URL}comprehensive/" scope="application"/>
<c:set var="STUDENT_COMPREHENSIVE_INSERT_AND_UPDATE_URL" value="${STUDENT_COMPREHENSIVE_BASE_URL}insertAndUpdate"
       scope="application"/>
<c:set var="STUDENT_COMPREHENSIVE_DELETE_URL" value="${STUDENT_COMPREHENSIVE_BASE_URL}delete" scope="application"/>
<c:set var="STUDENT_COMPREHENSIVE_IMPORT_URL" value="${STUDENT_COMPREHENSIVE_BASE_URL}import" scope="application"/>
<%--资助管理--%>
<c:set var="AID_BASE_URL" value="${MANAGER_URL}aidFinancially/" scope="application"/>
<%--学院奖学金--%>
<c:set var="COLLEGE_SCHOLARSHIP_BASE_URL" value="${AID_BASE_URL}collegeScholarship/" scope="application"/>
<c:set var="COLLEGE_SCHOLARSHIP_ADD_URL" value="${COLLEGE_SCHOLARSHIP_BASE_URL}add" scope="application"/>
<c:set var="COLLEGE_SCHOLARSHIP_UPDATE_URL" value="${COLLEGE_SCHOLARSHIP_BASE_URL}update" scope="application"/>
<c:set var="COLLEGE_SCHOLARSHIP_DELETE_URL" value="${COLLEGE_SCHOLARSHIP_BASE_URL}delete" scope="application"/>
<c:set var="COLLEGE_SCHOLARSHIP_IMPORT_URL" value="${COLLEGE_SCHOLARSHIP_BASE_URL}import" scope="application"/>
<%--年度表彰--%>
<c:set var="COMMEND_BASE_URL" value="${AID_BASE_URL}commend/" scope="application"/>
<c:set var="COMMEND_ADD_URL" value="${COMMEND_BASE_URL}add" scope="application"/>
<c:set var="COMMEND_UPDATE_URL" value="${COMMEND_BASE_URL}update" scope="application"/>
<c:set var="COMMEND_DELETE_URL" value="${COMMEND_BASE_URL}delete" scope="application"/>
<c:set var="COMMEND_IMPORT_URL" value="${COMMEND_BASE_URL}import" scope="application"/>
<%--绿色通道--%>
<c:set var="GREEN_CHANNEL_BASE_URL" value="${AID_BASE_URL}greenChannel/" scope="application"/>
<c:set var="GREEN_CHANNEL_ADD_URL" value="${GREEN_CHANNEL_BASE_URL}add" scope="application"/>
<c:set var="GREEN_CHANNEL_UPDATE_URL" value="${GREEN_CHANNEL_BASE_URL}update" scope="application"/>
<c:set var="GREEN_CHANNEL_DELETE_URL" value="${GREEN_CHANNEL_BASE_URL}delete" scope="application"/>
<c:set var="GREEN_CHANNEL_IMPORT_URL" value="${GREEN_CHANNEL_BASE_URL}import" scope="application"/>
<%--减免学费--%>
<c:set var="TUITION_WAIVER_BASE_URL" value="${AID_BASE_URL}tuitionWaiver/" scope="application"/>
<c:set var="TUITION_WAIVER_ADD_URL" value="${TUITION_WAIVER_BASE_URL}add" scope="application"/>
<c:set var="TUITION_WAIVER_UPDATE_URL" value="${TUITION_WAIVER_BASE_URL}update" scope="application"/>
<c:set var="TUITION_WAIVER_DELETE_URL" value="${TUITION_WAIVER_BASE_URL}delete" scope="application"/>
<c:set var="TUITION_WAIVER_IMPORT_URL" value="${TUITION_WAIVER_BASE_URL}import" scope="application"/>
<%--困难毕业生就业补助--%>
<c:set var="JOBSEEKER_SUPPORT_BASE_URL" value="${AID_BASE_URL}jobseekerSupport/" scope="application"/>
<c:set var="JOBSEEKER_SUPPORT_ADD_URL" value="${JOBSEEKER_SUPPORT_BASE_URL}add" scope="application"/>
<c:set var="JOBSEEKER_SUPPORT_UPDATE_URL" value="${JOBSEEKER_SUPPORT_BASE_URL}update" scope="application"/>
<c:set var="JOBSEEKER_SUPPORT_DELETE_URL" value="${JOBSEEKER_SUPPORT_BASE_URL}delete" scope="application"/>
<c:set var="JOBSEEKER_SUPPORT_IMPORT_URL" value="${JOBSEEKER_SUPPORT_BASE_URL}import" scope="application"/>
<%--应急求助--%>
<c:set var="EMERGENCY_HELP_BASE_URL" value="${AID_BASE_URL}emergencyHelp/" scope="application"/>
<c:set var="EMERGENCY_HELP_ADD_URL" value="${EMERGENCY_HELP_BASE_URL}add" scope="application"/>
<c:set var="EMERGENCY_HELP_UPDATE_URL" value="${EMERGENCY_HELP_BASE_URL}update" scope="application"/>
<c:set var="EMERGENCY_HELP_DELETE_URL" value="${EMERGENCY_HELP_BASE_URL}delete" scope="application"/>
<c:set var="EMERGENCY_HELP_IMPORT_URL" value="${EMERGENCY_HELP_BASE_URL}import" scope="application"/>
<%--国家奖学金--%>
<c:set var="NATIONAL_SCHOLARSHIP_BASE_URL" value="${AID_BASE_URL}nationalScholarship/" scope="application"/>
<c:set var="NATIONAL_SCHOLARSHIP_ADD_URL" value="${NATIONAL_SCHOLARSHIP_BASE_URL}add" scope="application"/>
<c:set var="NATIONAL_SCHOLARSHIP_UPDATE_URL" value="${NATIONAL_SCHOLARSHIP_BASE_URL}update" scope="application"/>
<c:set var="NATIONAL_SCHOLARSHIP_DELETE_URL" value="${NATIONAL_SCHOLARSHIP_BASE_URL}delete" scope="application"/>
<c:set var="NATIONAL_SCHOLARSHIP_IMPORT_URL" value="${NATIONAL_SCHOLARSHIP_BASE_URL}import" scope="application"/>
<%--国家助学金--%>
<c:set var="NATIONAL_GRANTS_BASE_URL" value="${AID_BASE_URL}nationalGrants/" scope="application"/>
<c:set var="NATIONAL_GRANTS_ADD_URL" value="${NATIONAL_GRANTS_BASE_URL}add" scope="application"/>
<c:set var="NATIONAL_GRANTS_UPDATE_URL" value="${NATIONAL_GRANTS_BASE_URL}update" scope="application"/>
<c:set var="NATIONAL_GRANTS_DELETE_URL" value="${NATIONAL_GRANTS_BASE_URL}delete" scope="application"/>
<c:set var="NATIONAL_GRANTS_IMPORT_URL" value="${NATIONAL_GRANTS_BASE_URL}import" scope="application"/>
<%--国家励志奖学金--%>
<c:set var="NATIONAL_ENDEAVOR_BASE_URL" value="${AID_BASE_URL}nationalEndeavor/" scope="application"/>
<c:set var="NATIONAL_ENDEAVOR_ADD_URL" value="${NATIONAL_ENDEAVOR_BASE_URL}add" scope="application"/>
<c:set var="NATIONAL_ENDEAVOR_UPDATE_URL" value="${NATIONAL_ENDEAVOR_BASE_URL}update" scope="application"/>
<c:set var="NATIONAL_ENDEAVOR_DELETE_URL" value="${NATIONAL_ENDEAVOR_BASE_URL}delete" scope="application"/>
<c:set var="NATIONAL_ENDEAVOR_IMPORT_URL" value="${NATIONAL_ENDEAVOR_BASE_URL}import" scope="application"/>
<%--勤工助学--%>
<c:set var="DILIGENT_BASE_URL" value="${MANAGER_URL}diligent/" scope="application"/>
<c:set var="DILIGENT_STUDY_BASE_URL" value="${DILIGENT_BASE_URL}study/" scope="application"/>
<c:set var="DILIGENT_STUDY_ADD_URL" value="${DILIGENT_STUDY_BASE_URL}add" scope="application"/>
<c:set var="DILIGENT_STUDY_UPDATE_URL" value="${DILIGENT_STUDY_BASE_URL}update" scope="application"/>
<c:set var="DILIGENT_STUDY_DELETE_URL" value="${DILIGENT_STUDY_BASE_URL}delete" scope="application"/>
<%--勤工助学岗位--%>
<c:set var="DILIGENT_STUDY_POST_BASE_URL" value="${DILIGENT_BASE_URL}post/" scope="application"/>
<c:set var="DILIGENT_STUDY_POST_ADD_URL" value="${DILIGENT_STUDY_POST_BASE_URL}add" scope="application"/>
<c:set var="DILIGENT_STUDY_POST_UPDATE_URL" value="${DILIGENT_STUDY_POST_BASE_URL}update" scope="application"/>
<c:set var="DILIGENT_STUDY_POST_DELETE_URL" value="${DILIGENT_STUDY_POST_BASE_URL}delete" scope="application"/>
<%--勤工助学学生--%>
<c:set var="DILIGENT_STUDY_STUDENT_BASE_URL" value="${DILIGENT_BASE_URL}student/" scope="application"/>
<c:set var="DILIGENT_STUDY_STUDENT_ADD_URL" value="${DILIGENT_STUDY_STUDENT_BASE_URL}add" scope="application"/>
<c:set var="DILIGENT_STUDY_STUDENT_UPDATE_URL" value="${DILIGENT_STUDY_STUDENT_BASE_URL}update" scope="application"/>
<c:set var="DILIGENT_STUDY_STUDENT_DELETE_URL" value="${DILIGENT_STUDY_STUDENT_BASE_URL}delete" scope="application"/>
<c:set var="DILIGENT_STUDY_STUDENT_IMPORT_URL" value="${DILIGENT_STUDY_STUDENT_BASE_URL}import" scope="application"/>
<%--勤工助学月工资--%>
<c:set var="DILIGENT_STUDY_MONTH_WAGES_BASE_URL" value="${DILIGENT_BASE_URL}monthWages/" scope="application"/>
<c:set var="DILIGENT_STUDY_MONTH_WAGES_ADD_URL" value="${DILIGENT_STUDY_MONTH_WAGES_BASE_URL}add" scope="application"/>
<c:set var="DILIGENT_STUDY_MONTH_WAGES_UPDATE_URL" value="${DILIGENT_STUDY_MONTH_WAGES_BASE_URL}update" scope="application"/>
<c:set var="DILIGENT_STUDY_MONTH_WAGES_DELETE_URL" value="${DILIGENT_STUDY_MONTH_WAGES_BASE_URL}delete" scope="application"/>
<c:set var="DILIGENT_STUDY_MONTH_WAGES_IMPORT_URL" value="${DILIGENT_STUDY_MONTH_WAGES_BASE_URL}import" scope="application"/>