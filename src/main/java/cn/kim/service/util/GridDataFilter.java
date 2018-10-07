package cn.kim.service.util;

import cn.kim.common.attr.TableViewName;
import cn.kim.common.eu.RoleCode;
import cn.kim.common.eu.SystemEnum;
import cn.kim.entity.ActiveUser;
import cn.kim.service.impl.BaseServiceImpl;
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
                TableViewName.V_STUDENT_COMPREHENSIVE.equalsIgnoreCase(configureView)) {
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
        }


        return resultBuilder.toString();
    }
}
