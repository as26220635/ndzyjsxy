package cn.kim.service;

import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/8/6
 * 教师管理
 */
public interface TeacherService extends BaseService {
    /**
     * 查询教师
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> selectTeacher(Map<String, Object> mapParam);

    /**
     * 插入或更新教师
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> insertAndUpdateTeacher(Map<String, Object> mapParam);

    /**
     * 删除教师
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> deleteTeacher(Map<String, Object> mapParam);

}
