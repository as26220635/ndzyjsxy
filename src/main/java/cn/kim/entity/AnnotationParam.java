package cn.kim.entity;

import lombok.Data;

import java.lang.annotation.Annotation;

/**
 * Created by 余庚鑫 on 2018/4/1.
 * 注解参数
 */
@Data
public class AnnotationParam {
    /**
     * 简单名字
     */
    private String simpleName;
    /**
     * 名字
     */
    private String name;
    /**
     * 类型
     */
    private Class<?> type;
    /**
     * 值
     */
    private Object value;
    /**
     * 注解
     */
    private Annotation anno;
    /**
     * 参数位置
     */
    private int index;

    public AnnotationParam() {
        super();
    }

    public AnnotationParam(String simpleName, String name, Class<?> type, Object value, Annotation anno, int index) {
        super();
        this.simpleName = simpleName;
        this.name = name;
        this.type = type;
        this.value = value;
        this.anno = anno;
        this.index = index;
    }
}
