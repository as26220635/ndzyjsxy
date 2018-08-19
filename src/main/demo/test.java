import cn.kim.common.attr.MagicValue;
import cn.kim.common.tag.Button;
import cn.kim.util.TextUtil;

import java.math.BigDecimal;
import java.util.*;

/**
 * Created by 余庚鑫 on 2018/8/7
 */
public class test {
    public static void main(String[] args) {
        System.out.println(Button.BTN_ID_AJAX_CLOSE.contains("cache1"));

        String[] BTN_ID_AJAX_CLOSE = {"save", "cache"};
        System.out.println(Arrays.binarySearch(BTN_ID_AJAX_CLOSE, "cache"));

    }

}
