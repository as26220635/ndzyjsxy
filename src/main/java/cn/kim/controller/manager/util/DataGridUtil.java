package cn.kim.controller.manager.util;

import cn.kim.common.BaseData;
import cn.kim.common.attr.TableViewName;
import cn.kim.dao.BaseDao;
import cn.kim.util.DictUtil;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2019/6/14
 * 数据列表设置参数
 */
@Component
public class DataGridUtil extends BaseData {
    /**
     * 配置列表额外添加返回参数
     *
     * @param configureView
     * @param extra
     * @param request
     */
    public void setExtraParams(String configureView, Map<String, Object> extra, HttpServletRequest request) {
        if (TableViewName.V_DEPARTMENT_INSTRUCTOR_CLASS.equals(configureView)) {
            //辅导员管理-班级选择
            extra.put("studnetYear", getStudentYear());
            extra.put("semester", DictUtil.getDictName("BUS_SEMESTER", getStudentSemester()));
        }
    }
}
