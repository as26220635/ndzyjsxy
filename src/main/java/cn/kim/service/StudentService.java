package cn.kim.service;

import cn.kim.entity.DataTablesView;
import cn.kim.entity.Tree;

import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/8/7
 * 学生管理
 */
public interface StudentService extends BaseService {

    /**
     * 查询学生列表
     *
     * @param mapParam
     * @return
     */
    DataTablesView<?> selectStudentDataTablesView(Map<String, Object> mapParam);

    /**
     * 查询学生
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> selectStudent(Map<String, Object> mapParam);

    /**
     * 插入或更新学生
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> insertAndUpdateStudent(Map<String, Object> mapParam);

    /**
     * 删除学生
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> deleteStudent(Map<String, Object> mapParam);

    /**
     * 查询学生考勤
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> selectStudentAttendance(Map<String, Object> mapParam);

    /**
     * 插入或更新学生考勤
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> insertAndUpdateStudentAttendance(Map<String, Object> mapParam);

    /**
     * 删除学生考勤
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> deleteStudentAttendance(Map<String, Object> mapParam);

    /**
     * 查询学生处分
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> selectStudentPunishment(Map<String, Object> mapParam);

    /**
     * 插入或更新学生处分
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> insertAndUpdateStudentPunishment(Map<String, Object> mapParam);

    /**
     * 撤销学生处分
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> revokeStudentPunishment(Map<String, Object> mapParam);

    /**
     * 删除学生处分
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> deleteStudentPunishment(Map<String, Object> mapParam);

    /**
     * 查询学生综合素质评测
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> selectStudentComprehensive(Map<String, Object> mapParam);

    /**
     * 插入或更新学生综合素质评测
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> insertAndUpdateStudentComprehensive(Map<String, Object> mapParam);

    /**
     * 删除学生综合素质评测
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> deleteStudentComprehensive(Map<String, Object> mapParam);
}
