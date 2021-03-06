package cn.kim.service;

import cn.kim.entity.DataTablesView;
import cn.kim.entity.Tree;

import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/8/6
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
     * 查询系部
     *
     * @param mapParam
     * @return
     */
    List<Map<String, Object>> selectDepartmentList(Map<String, Object> mapParam);

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

    /**
     * 添加辅导员管理班级
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> insertInstructorClass(Map<String, Object> mapParam);

    /**
     * 删除辅导员管理班级
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> deleteInstructorClass(Map<String, Object> mapParam);

    /**
     * 查询辅导员列表
     *
     * @param mapParam
     * @return
     */
    DataTablesView<?> selectDepartmentInstructor(Map<String, Object> mapParam);

    /**
     * 查询辅导员列表
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> selectClassInstructor(Map<String, Object> mapParam);

    /**
     * 修改辅导员列表
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> updateClassInstructor(Map<String, Object> mapParam);
}
