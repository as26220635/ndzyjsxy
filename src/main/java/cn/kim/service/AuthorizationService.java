package cn.kim.service;

import cn.kim.entity.Tree;

import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/8/14
 * 授权
 */
public interface AuthorizationService extends BaseService {

    /**
     * 授权数据树列表
     *
     * @param mapParam
     * @return
     */
    List<Tree> selectAuthorizationTreeList(Map<String, Object> mapParam);


    /**
     * 保存授权信息
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> updateAuthorization(Map<String, Object> mapParam);
}
