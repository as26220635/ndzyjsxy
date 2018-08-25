package cn.kim.common.annotation;

import cn.kim.common.eu.UseType;

import java.lang.annotation.*;

/**
 * Created by 余庚鑫 on 2017/7/5.
 * 自定义注解 拦截Controller  记录日志
 */
@Target({ElementType.PARAMETER, ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface SystemControllerLog {

    //日志类型
    UseType useType() default UseType.USE;

    //日志的操作
    String event() default "";

    /**
     * 是否是查看操作列表
     *
     * @return
     */
    boolean isDataGrid() default false;

    /**
     * 是否是导出excel
     *
     * @return
     */
    boolean isExport() default false;

}
