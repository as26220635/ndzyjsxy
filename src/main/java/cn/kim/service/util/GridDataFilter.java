package cn.kim.service.util;

import cn.kim.common.attr.MagicValue;
import cn.kim.common.attr.TableViewName;
import cn.kim.entity.ActiveUser;
import cn.kim.service.impl.BaseServiceImpl;
import org.springframework.stereotype.Component;

import javax.swing.text.TableView;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/6/11
 * 自定义过滤
 */
@Component
public class GridDataFilter extends BaseServiceImpl {

    private Map<String, Object> configure;

    public GridDataFilter(Map<String, Object> configure) {
        this.configure = configure;
    }

    public static GridDataFilter getInstance(Map<String, Object> configure) {
        return new GridDataFilter(configure);
    }

    /**
     * 获取自定义过滤where条件
     *
     * @return
     */
    public String filterWhereSql() {
        StringBuilder resultBuilder = new StringBuilder();

        ActiveUser activeUser = getActiveUser();
        String configureView = toString(this.configure.get("SC_VIEW")).toLowerCase();

        if (TableViewName.V_TEST_PROCESS.equals(configureView)) {
            //测试流程
            resultBuilder.append(" AND SO_ID = " + activeUser.getId());
        }


        return resultBuilder.toString();
    }
}
