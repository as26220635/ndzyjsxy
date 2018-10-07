package cn.kim.common.eu;

import cn.kim.util.TextUtil;

/**
 * Created by 余庚鑫 on 2018/10/6
 * 角色编码
 */
public enum RoleCode {
    //学生
    STUDENT("STUDENT"),
    //教师
    TEACHER("TEACHER"),
    //辅导员
    INSTRUCTOR_DEPARTMENT("INSTRUCTOR_DEPARTMENT"),
    //系部管理
    MANAGER_DEPARTMENT("MANAGER_DEPARTMENT"),
    //学生处角色编码
    STUDENT_DIVISION("STUDENT_DIVISION"),
    ;

    private String type;

    private RoleCode(String type) {
        this.type = type;
    }

    public String getType() {
        return this.type;
    }

}
