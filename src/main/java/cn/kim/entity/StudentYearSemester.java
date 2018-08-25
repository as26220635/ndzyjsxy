package cn.kim.entity;

import lombok.Data;

/**
 * Created by 余庚鑫 on 2018/8/15
 */
@Data
public class StudentYearSemester {
    /**
     * 学年
     */
    private String year;
    /**
     * 学期
     */
    private String semesterStr;
    /**
     * 学期
     */
    private Integer semester;

}
