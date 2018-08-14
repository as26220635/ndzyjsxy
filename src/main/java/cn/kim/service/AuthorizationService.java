package cn.kim.service;

import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/8/14
 * 授权
 */
public interface AuthorizationService extends BaseService {
    /**
     * 查询配置
     * @param mapParam
     * @return
     */
    Map<String, Object> selectAuthorization(Map<String, Object> mapParam);

    /**
     * 插入或更新系统配置
     * @param mapParam
     * @return
     */
    Map<String, Object> insertAndUpdateAuthorization(Map<String, Object> mapParam);

    /**
     * 删除系统配置
     * @param mapParam
     * @return
     */
    Map<String, Object> deleteAuthorization(Map<String, Object> mapParam);

}
