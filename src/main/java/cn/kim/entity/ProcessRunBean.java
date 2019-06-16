package cn.kim.entity;

import cn.kim.dao.BaseDao;
import lombok.Data;

import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/8/13
 * 流程传递使用
 */
@Data
public class ProcessRunBean {
    /***
     * dao
     */
    private BaseDao baseDao;
    /**
     * 流程定义ID
     */
    private String definitionId;
    /**
     * 大类
     */
    private String busProcess;
    /**
     * 小类
     */
    private String busProcess2;
    /**
     * 流程ID
     */
    private String busTableId;
    /**
     * 额外参数
     */
    private Map<String, Object> executeMap;

}
