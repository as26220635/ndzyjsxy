package cn.kim.service;

import cn.kim.entity.Tree;

import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/5/22
 * 系统配置
 */
public interface AllocationService extends BaseService {

    Map<String, Object> selectAllocation(Map<String, Object> mapParam);

    String selectAllocation(String key);

    Map<String, Object> insertAndUpdateAllocation(Map<String, Object> mapParam);

    Map<String, Object> insertAndUpdateAllocation(String key, Object value);

    Map<String, Object> deleteAllocation(Map<String, Object> mapParam);

    Map<String, Object> deleteAllocation(String key);

}
