package cn.kim.common.attr;

import cn.kim.entity.DictInfo;
import cn.kim.util.DictUtil;
import cn.kim.util.TextUtil;
import cn.kim.util.ValidateUtil;

/**
 * Created by 余庚鑫 on 2018/3/21
 * 类型解析
 */
public class ParamTypeResolve {
    /**
     * 根据登录类型获取名称
     *
     * @param tyep
     * @return
     */
    public static String getOpeatorTypeName(String tyep) {
        DictInfo dictInfo = DictUtil.getDictInfo("SYS_ROLE_TYPE", tyep);
        if (!ValidateUtil.isEmpty(dictInfo)) {
            return dictInfo.getSdiName();
        } else {
            return "未知!";
        }
    }

    /**
     * 获取状态解释
     *
     * @param val
     * @return
     */
    public static String statusExplain(Object val) {
        try {
            int status = TextUtil.toInt(val);
            if (status == Attribute.STATUS_SUCCESS) {
                return "开启";
            } else {
                return "关闭";
            }
        } catch (Exception e) {
            return "未知";
        }
    }

}
