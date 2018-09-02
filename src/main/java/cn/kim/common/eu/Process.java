package cn.kim.common.eu;

import cn.kim.util.TextUtil;

/**
 * Created by 余庚鑫 on 2018/8/14
 * 流程大类小类
 */
public enum Process {
    //资助大类
    AID(100),
    //绿色通道
    AID_GREEN_CHANNEL(101),
    //国家奖学金
    AID_NATIONAL_SCHOLARSHIP(102),
    //国家励志奖学金
    AID_NATIONAL_ENDEAVOR(103),
    //国家助学金
    AID_NATIONAL_GRANTS(104),
    //减免学费
    AID_TUITION_WAIVER(107),
    //学院奖学金
    AID_COLLEGE_SCHOLARSHIP(109),
    //年度表彰
    AID_COMMEND(110),
    //困难毕业生就业补助
    AID_JOBSEEKER_SUPPORT(111),
    //应急求助
    AID_EMERGENCY_HELP(113),
    ;

    private int type;

    private Process(int type) {
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
