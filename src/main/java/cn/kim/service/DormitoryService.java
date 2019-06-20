package cn.kim.service;

import cn.kim.entity.DataTablesView;

import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2019/6/16
 * 宿舍管理
 */
public interface DormitoryService extends BaseService {
    /**
     * 查询楼
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> selectDormitoryFloor(Map<String, Object> mapParam);

    /**
     * 插入或更新楼
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> insertAndUpdateDormitoryFloor(Map<String, Object> mapParam);

    /**
     * 删除室
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> deleteDormitoryFloor(Map<String, Object> mapParam);

    /**
     * 查询室
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> selectDormitoryRoom(Map<String, Object> mapParam);

    /**
     * 插入或更新室
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> insertAndUpdateDormitoryRoom(Map<String, Object> mapParam);

    /**
     * 删除室
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> deleteDormitoryRoom(Map<String, Object> mapParam);

    /**
     * 查询铺位
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> selectDormitoryBerth(Map<String, Object> mapParam);

    /**
     * 插入或更新铺位
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> insertAndUpdateDormitoryBerth(Map<String, Object> mapParam);

    /**
     * 删除铺位
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> deleteDormitoryBerth(Map<String, Object> mapParam);

    /**
     * 查询铺位列表
     *
     * @param mapParam
     * @return
     */
    DataTablesView<?> selectDormitoryBerthList(Map<String, Object> mapParam);

    /**
     * 查询人员
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> selectDormitoryPersonnel(Map<String, Object> mapParam);

    /**
     * 插入或更新人员
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> insertAndUpdateDormitoryPersonnel(Map<String, Object> mapParam);

    /**
     * 删除人员
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> deleteDormitoryPersonnel(Map<String, Object> mapParam);

}
