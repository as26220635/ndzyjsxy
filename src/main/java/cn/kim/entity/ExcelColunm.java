package cn.kim.entity;

import lombok.Data;

import java.io.Serializable;

/**
 * Created by 余庚鑫 on 2018/8/24
 * 导出excel 列配置参数
 */
@Data
public class ExcelColunm implements Serializable {

    /**
     * 字段名称
     */
    private String name;
    /**
     * 宽度
     */
    private int width = 100;
}
