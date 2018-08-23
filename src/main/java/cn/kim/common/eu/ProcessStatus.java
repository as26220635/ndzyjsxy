package cn.kim.common.eu;

import cn.kim.util.TextUtil;

/**
 * Created by 余庚鑫 on 2018/8/23
 * 流程状态
 */
public enum ProcessStatus {
    //退回/撤回
    BACK(-1),
    //启动人员
    START(0),
    //完成
    COMPLETE(999),
    ;

    private int type;

    private ProcessStatus(int type) {
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
