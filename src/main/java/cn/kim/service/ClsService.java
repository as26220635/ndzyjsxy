package cn.kim.service;

import cn.kim.entity.Tree;

import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/8/6
 * 班级管理
 */
public interface ClsService extends BaseService {
    /**
     * 查询班级
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> selectClass(Map<String, Object> mapParam);

    /**
     * 查询班级
     *
     * @param mapParam
     * @return
     */
    List<Map<String, Object>> selectClassList(Map<String, Object> mapParam);

    /**
     * 插入或更新班级
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> insertAndUpdateClass(Map<String, Object> mapParam);

    /**
     * 删除班级
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> deleteClass(Map<String, Object> mapParam);

}
