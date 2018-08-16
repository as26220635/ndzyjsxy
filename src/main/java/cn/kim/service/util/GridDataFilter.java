package cn.kim.service.util;

import cn.kim.common.attr.MagicValue;
import cn.kim.common.attr.TableViewName;
import cn.kim.common.eu.SystemEnum;
import cn.kim.entity.ActiveUser;
import cn.kim.service.impl.BaseServiceImpl;
import org.jetbrains.annotations.Contract;
import org.jetbrains.annotations.NotNull;
import org.springframework.stereotype.Component;

import javax.swing.text.TableView;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/6/11
 * 自定义过滤
 */
@Component
public class GridDataFilter extends BaseServiceImpl {

    /**
     * 配置列表
     */
    private Map<String, Object> configure;

    /**
     * 请求参数
     */
    private Map<String, Object> requestMap;

    public GridDataFilter(Map<String, Object> configure, Map<String, Object> requestMap) {
        this.configure = configure;
        this.requestMap = requestMap;
    }

    /**
     * 初始化
     *
     * @param configure
     * @param requestMap
     * @return
     */
    @Contract("_, _ -> new")
    @NotNull
    public static GridDataFilter getInstance(Map<String, Object> configure, Map<String, Object> requestMap) {
        return new GridDataFilter(configure, requestMap);
    }

    /**
     * 获取自定义过滤where条件
     *
     * @return
     */
    public String filterWhereSql() {
        StringBuilder resultBuilder = new StringBuilder();

        ActiveUser activeUser = getActiveUser();
        //用户类型
        String operatorType = activeUser.getType();
        //用户ID
        String operatorId = activeUser.getId();

        String configureView = toString(this.configure.get("SC_VIEW")).toLowerCase();

        if (TableViewName.V_TEST_PROCESS.equals(configureView)) {
            //测试流程
            resultBuilder.append(" AND SO_ID = " + operatorId);
        } else if (TableViewName.V_STUDENT.equals(configureView) ||
                TableViewName.V_STUDENT_ATTENDANCE.equals(configureView) ||
                TableViewName.V_STUDENT_PUNISHMENT.equals(configureView) ||
                TableViewName.V_STUDENT_COMPREHENSIVE.equals(configureView)) {
            //学生管理
            resultBuilder.append(getAuthorizationWhere());
        } else if (TableViewName.V_LOG_SYSTEM.equals(configureView) ||
                TableViewName.V_LOG_USE.equals(configureView) ||
                TableViewName.V_LOG_PERSONAL.equals(configureView) ||
                TableViewName.V_LOG_SEE.equals(configureView)) {
            //日志 管理员可以看到全部
            if (!SystemEnum.MANAGER.toString().equals(operatorType)) {
                resultBuilder.append(" AND SO_ID =" + operatorId);
            }
        }


        return resultBuilder.toString();
    }
}
