package cn.kim.common.eu;

import cn.kim.util.TextUtil;

/**
 * Created by 余庚鑫 on 2018/8/14
 * 授权类型
 */
public enum AuthorizationType {
    //院系
    COLLEGE(1),
    //系部
    DEPARTMENT(2),
    //班级
    CLS(3),
    ;

    private int type;

    private AuthorizationType(int type) {
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
