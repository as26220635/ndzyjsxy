package cn.kim.service.util;

import cn.kim.common.attr.TableViewName;
import cn.kim.common.eu.NameSpace;
import cn.kim.common.eu.RoleCode;
import cn.kim.common.eu.SystemEnum;
import cn.kim.entity.ActiveUser;
import cn.kim.service.impl.BaseServiceImpl;
import com.google.common.collect.Maps;
import org.springframework.stereotype.Component;

import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/6/11
 * 自定义过滤
 */
@Component
public class GridDataFilter extends BaseServiceImpl {
    /**
     * 获取自定义过滤where条件
     *
     * @return
     */
    public String filterWhereSql(Map<String, Object> configure, Map<String, Object> requestMap) {
        StringBuilder resultBuilder = new StringBuilder();
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(10);

        ActiveUser activeUser = getActiveUser();
        //用户类型
        String operatorType = activeUser.getType();
        //用户ID
        String operatorId = activeUser.getId();
        //用户类型关联ID
        String tableId = activeUser.getTableId();

        String configureView = toString(configure.get("SC_VIEW")).toLowerCase();

        if (TableViewName.V_TEST_PROCESS.equals(configureView)) {
            //测试流程
            resultBuilder.append(" AND SO_ID = " + operatorId);
        } else if (TableViewName.V_STUDENT.equalsIgnoreCase(configureView) ||
                TableViewName.V_STUDENT_ATTENDANCE.equalsIgnoreCase(configureView) ||
                TableViewName.V_STUDENT_PUNISHMENT.equalsIgnoreCase(configureView) ||
                TableViewName.V_STUDENT_COMPREHENSIVE.equalsIgnoreCase(configureView) ||
                TableViewName.V_STUDENT_DIFFICULTY.equalsIgnoreCase(configureView)) {
            //学生管理
            resultBuilder.append(getAuthorizationWhere());
        } else if (TableViewName.V_LOG_SYSTEM.equalsIgnoreCase(configureView) ||
                TableViewName.V_LOG_USE.equalsIgnoreCase(configureView) ||
                TableViewName.V_LOG_PERSONAL.equalsIgnoreCase(configureView) ||
                TableViewName.V_LOG_SEE.equalsIgnoreCase(configureView)) {
            //日志管理 管理员可以看到全部
            if (!SystemEnum.MANAGER.toString().equals(operatorType)) {
                resultBuilder.append(" AND SO_ID =" + operatorId);
            }
        } else if (TableViewName.V_DOCUMENT.equalsIgnoreCase(configureView)) {
            //文件管理
            resultBuilder.append(" AND SO_ID =" + operatorId);
        } else if (TableViewName.V_DILIGENT_STUDY_POST.equalsIgnoreCase(configureView) ||
                TableViewName.V_DILIGENT_STUDY_STUDENT.equalsIgnoreCase(configureView)) {
            //勤工助学
            if (SystemEnum.STUDENT.toString().equals(operatorType)) {
                //学生过滤
                resultBuilder.append(" AND BS_ID =" + tableId);
            } else if (!SystemEnum.MANAGER.toString().equals(operatorType)) {
                //管理员和学生处不过滤
                //根据角色编码查询角色
                Map<String, Object> role = this.selectRoleByCode(RoleCode.STUDENT_DIVISION.getType());
                if (!containsRole(toString(role.get("ID")))) {
                    resultBuilder.append(" AND BDS_TABLE_ID =" + tableId);
                }
            }
        } else if (TableViewName.V_DEPARTMENT.equalsIgnoreCase(configureView) ||
                TableViewName.V_DEPARTMENT_PERSONNEL.equalsIgnoreCase(configureView) ||
                TableViewName.V_DEPARTMENT_INSTRUCTOR.equalsIgnoreCase(configureView) ||
                TableViewName.V_DIVISION.equalsIgnoreCase(configureView) ||
                TableViewName.V_DIVISION_PERSONNEL.equalsIgnoreCase(configureView)) {
            //勤工助学
            resultBuilder.append(getAuthorizationWhere());
        } else if (TableViewName.V_DEPARTMENT_INSTRUCTOR_CLASS.equalsIgnoreCase(configureView)) {
            //辅导员-选择班级
            String BDMP_ID = toString(requestMap.get("BDMP_ID"));
            //查询可以显示的班级
            paramMap.clear();
            paramMap.put("ID", BDMP_ID);
            Map<String, Object> personnel = baseDao.selectOne(NameSpace.DepartmentMapper, "selectDepartmentPersonnel", paramMap);

            resultBuilder.append(" AND BDM_ID = " + personnel.get("BDM_ID"));

            //只能选择当前学期的班级
            String studentYear  = getStudentYear();
            int startYear = getStudentYearStart();
            int endYear = getStudentYearEnd();
            int semester = getStudentSemester();
            resultBuilder.append(" AND BC_YEAR <=" + endYear);
            resultBuilder.append(" AND BC_YEAR >" + startYear + " - BC_LENGTH");
            resultBuilder.append(" AND ID NOT IN(SELECT BC_ID FROM BUS_DEPARTMENT_INSTRUCTOR WHERE BDI_YEAR = '" + studentYear + "' AND BDI_SEMESTER = " + semester + ")");

        }


        return resultBuilder.toString();
    }
}
