package cn.kim.common.eu;

import cn.kim.util.TextUtil;

/**
 * Created by 余庚鑫 on 2018/8/14
 * 资助类型
 */
public enum AidType {
    //绿色通道
    GREEN_CHANNEL(1),
    //国家奖学金
    NATIONAL_SCHOLARSHIP(2),
    //国家励志奖学金
    NATIONAL_ENDEAVOR(3),
    //国家助学金
    NATIONAL_GRANTS(4),
    //减免学费
    TUITION_WAIVER(7),
    //学院奖学金
    COLLEGE_SCHOLARSHIP(9),
    //年度表彰
    COMMEND(10),
    //困难毕业生就业补助
    JOBSEEKER_SUPPORT(11),
    //应急求助
    EMERGENCY_HELP(13),
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
