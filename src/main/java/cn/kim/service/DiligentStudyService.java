package cn.kim.service;

import org.springframework.web.multipart.MultipartFile;

import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/9/10
 * 勤工助学管理
 */
public interface DiligentStudyService extends BaseService {

    /**
     * 查询勤工助学
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> selectDiligentStudy(Map<String, Object> mapParam);

    /**
     * 插入或更新勤工助学
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> insertAndUpdateDiligentStudy(Map<String, Object> mapParam);

    /**
     * 删除勤工助学
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> deleteDiligentStudy(Map<String, Object> mapParam);
    
    /******************     岗位     *****************/
    /**
     * 查询勤工助学岗位
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> selectDiligentStudyPost(Map<String, Object> mapParam);

    /**
     * 插入或更新勤工助学岗位
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> insertAndUpdateDiligentStudyPost(Map<String, Object> mapParam);

    /**
     * 删除勤工助学岗位
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> deleteDiligentStudyPost(Map<String, Object> mapParam);

    /******************     学生     *****************/
    /**
     * 查询勤工助学学生
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> selectDiligentStudyStudent(Map<String, Object> mapParam);

    /**
     * 插入或更新勤工助学学生
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> insertAndUpdateDiligentStudyStudent(Map<String, Object> mapParam);

    /**
     * 删除勤工助学学生
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> deleteDiligentStudyStudent(Map<String, Object> mapParam);

    /**
     * 导入勤工助学学生
     *
     * @param excelFile
     * @return
     */
    Map<String, Object> importDiligentStudyStudent(MultipartFile excelFile);

    /******************     学生月工资     *****************/



    /**
     * 根据勤工助学学生id查询学生信息
     *
     * @param id
     * @return
     */
    Map<String, Object> selectStudentByDiligentStudyStudentId(String id);

    /**
     * 查询勤工助学月工资
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> selectDiligentStudyMonthWages(Map<String, Object> mapParam);

    /**
     * 插入或更新勤工助学月工资
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> insertAndUpdateDiligentStudyMonthWages(Map<String, Object> mapParam);

    /**
     * 删除勤工助学月工资
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> deleteDiligentStudyMonthWages(Map<String, Object> mapParam);

    /**
     * 导入勤工助学月工资
     *
     * @param excelFile
     * @return
     */
    Map<String, Object> importDiligentStudyMonthWages(MultipartFile excelFile);
}
