package cn.kim.service;

import cn.kim.entity.DataTablesView;

import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2017/4/2.
 */
public interface LogService extends BaseService {

    DataTablesView<Map<String, Object>> findByMap(Map<String, Object> mapParam) throws Exception;

    void insertLog(Map<String, Object> mapParam) throws Exception;

    Map<String,Object> selectValueRecordById(String id);
}
