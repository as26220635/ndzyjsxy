package cn.kim.entity;

import cn.kim.dao.BaseDao;

import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/8/13
 * 流程传递使用
 */
public class ProcessRunBean {
    /***
     * dao
     */
    private BaseDao baseDao;
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
    private String tableId;
    /**
     * 额外参数
     */
    private Map<String, Object> executeMap;


    public BaseDao getBaseDao() {
        return baseDao;
    }

    public void setBaseDao(BaseDao baseDao) {
        this.baseDao = baseDao;
    }

    public String getBusProcess() {
        return busProcess;
    }

    public void setBusProcess(String busProcess) {
        this.busProcess = busProcess;
    }

    public String getBusProcess2() {
        return busProcess2;
    }

    public void setBusProcess2(String busProcess2) {
        this.busProcess2 = busProcess2;
    }

    public String getTableId() {
        return tableId;
    }

    public void setTableId(String tableId) {
        this.tableId = tableId;
    }

    public Map<String, Object> getExecuteMap() {
        return executeMap;
    }

    public void setExecuteMap(Map<String, Object> executeMap) {
        this.executeMap = executeMap;
    }
}
