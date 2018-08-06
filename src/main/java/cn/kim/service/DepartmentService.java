package cn.kim.service;

import cn.kim.entity.Tree;

import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/7/8
 * 系部管理
 */
public interface DepartmentService extends BaseService {
    /**
     * 查询系部
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> selectDepartment(Map<String, Object> mapParam);

    /**
     * 获取系部树
     *
     * @param id
     * @param notId 不显示的ID 自身和父类
     * @return
     */
    List<Tree> selectDepartmentTreeList(String id, String notId);

    /**
     * 插入或更新系部
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> insertAndUpdateDepartment(Map<String, Object> mapParam);

    /**
     * 删除系部
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> deleteDepartment(Map<String, Object> mapParam);

    /**
     * 查询系部人员
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> selectDepartmentPersonnel(Map<String, Object> mapParam);

    /**
     * 插入或更新系部人员
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> insertAndUpdateDepartmentPersonnel(Map<String, Object> mapParam);

    /**
     * 删除系部人员
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> deleteDepartmentPersonnel(Map<String, Object> mapParam);
}
