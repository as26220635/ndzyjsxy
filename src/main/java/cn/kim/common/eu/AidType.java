package cn.kim.common.eu;

import cn.kim.util.TextUtil;

/**
 * Created by 余庚鑫 on 2018/8/14
 * 资助类型
 */
public enum AidType {
    //学院奖学金
    COLLEGE_SCHOLARSHIP(9),
    //年度表彰
    COMMEND(10),

    ;

    private int type;

    private AidType(int type) {
        this.type = type;
    }

    @Override
    public String toString() {
        return TextUtil.toString(this.type);
    }

    public int getType() {
        return this.type;
    }

}
