package cn.kim.common.eu;

import cn.kim.util.TextUtil;

/**
 * Created by 余庚鑫 on 2018/8/14
 * 流程大类小类
 */
public enum Process {
    //资助大类
    AID(100),
    //学院奖学金
    AID_COLLEGE_SCHOLARSHIP(109),
    //年度表彰
    AID_COMMEND (110),
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
