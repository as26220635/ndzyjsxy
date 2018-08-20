package cn.kim.controller.manager;

import cn.kim.common.annotation.NotEmptyLogin;
import cn.kim.entity.DataTablesView;
import cn.kim.service.LogService;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Maps;
import com.google.common.collect.Sets;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

/**
 * Created by 余庚鑫 on 2018/8/20
 * 日志管理
 */
@Controller
@RequestMapping("/admin/log")
public class LogController extends BaseController {

    @Autowired
    private LogService logService;

    /***************    数据变动日志  *****************/

    /**
     * 数据变动字段详细变动
     * 格式化字段名称和值
     *
     * @param ID
     * @param model
     * @return
     * @throws Exception
     */
    @GetMapping("/valueRecord/detail/column")
    @RequiresPermissions("LOG:VALUE_RECORD_DETAIL_DETAIL_LOG")
    public String valueRecordLog(String ID, Model model) throws Exception {
        Map<String, Object> valueRecord = logService.selectValueRecordById(ID);

        String SVR_TABLE_NAME = toString(valueRecord.get("SVR_TABLE_NAME"));

        //JSON转为MAP
        Map<String, Object> oldMap = isEmpty(valueRecord.get("SVR_OLD_VALUE")) ? new HashMap<>(0) : JSONObject.parseObject(toString(valueRecord.get("SVR_OLD_VALUE"))).getInnerMap();
        Map<String, Object> newMap = isEmpty(valueRecord.get("SVR_NEW_VALUE")) ? new HashMap<>(0) : JSONObject.parseObject(toString(valueRecord.get("SVR_NEW_VALUE"))).getInnerMap();
        //格式化字段
        oldMap = formatColumnNameMap(SVR_TABLE_NAME, oldMap);
        newMap = formatColumnNameMap(SVR_TABLE_NAME, newMap);

        //返回data
        JSONArray resultArray = new JSONArray();
        //合并字段
        Set<String> keySet = new LinkedHashSet<>();

        //比对出不同处
        if (!isEmpty(oldMap) && !isEmpty(newMap)) {
            keySet.addAll(oldMap.keySet());
            keySet.addAll(newMap.keySet());
        } else if (!isEmpty(oldMap)) {
            keySet.addAll(oldMap.keySet());
        } else if (!isEmpty(newMap)) {
            keySet.addAll(newMap.keySet());
        }
        //比对
        if (!isEmpty(keySet)) {
            for (String key : keySet) {
                JSONObject jsonObject = new JSONObject();
                Object oldValue = oldMap.get(key);
                Object newValue = newMap.get(key);
                String type = "";
                if (isEmpty(oldValue) && !isEmpty(newValue)) {
                    type = "添加";
                } else if (!isEmpty(oldValue) && isEmpty(newValue)) {
                    type = "删除";
                } else if (toString(oldValue).trim().equals(toString(newValue).trim())) {
                    type = "无";
                } else {
                    type = "修改";
                }
                //字段
                jsonObject.put("field", key);
                //旧值
                jsonObject.put("oldValue", oldValue);
                //类型
                jsonObject.put("type", type);
                //新值
                jsonObject.put("newValue", newValue);

                resultArray.add(jsonObject);
            }
        }

        //显示参数
        model.addAttribute("data", resultArray.toJSONString());
        return "admin/log/record/detail/column";
    }
}
