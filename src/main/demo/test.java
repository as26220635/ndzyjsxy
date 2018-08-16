import cn.kim.common.attr.MagicValue;
import cn.kim.util.TextUtil;

import java.math.BigDecimal;
import java.util.*;

/**
 * Created by 余庚鑫 on 2018/8/7
 */
public class test {
    public static void main(String[] args) {
        System.out.println(TextUtil.getSubBetween("/**/ip({\"status\":\"0\",\"t\":\"1412300361645\",\"set_cache_time\":\"\",\"data\":[{\"location\":\"福建省福州市 电信\",\"titlecont\":\"IP地址查询\",\"origip\":\"59.56.176.120\",\"origipquery\":\"59.56.176.120\",\"showlamp\":\"1\",\"showLikeShare\":1,\"shareImage\":1,\"ExtendedLocation\":\"\",\"OriginQuery\":\"59.56.176.120\",\"tplt\":\"ip\",\"resourceid\":\"6006\",\"fetchkey\":\"59.56.176.120\",\"appinfo\":\"\",\"role_id\":0,\"disp_type\":0}]});\n","/\\*\\*/(",");"));
    }

}
