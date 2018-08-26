package cn.kim.service;

import org.springframework.web.multipart.MultipartFile;

import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/8/7
 * 资助管理
 */
public interface AidFinanciallyService extends BaseService {

    /**
     * 查询资助
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> selectAidFinancially(Map<String, Object> mapParam);

    /**
     * 插入或更新资助
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> insertAndUpdateAidFinancially(Map<String, Object> mapParam);

    /**
     * 删除资助
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> deleteAidFinancially(Map<String, Object> mapParam);

    /**
     * 导入学院奖学金
     *
     * @param excelFile
     * @return
     */
    Map<String, Object> importCollegeScholarship(MultipartFile excelFile);

    /**
     * 导入年度表彰
     *
     * @param excelFile
     * @return
     */
    Map<String, Object> importCommend(MultipartFile excelFile);

    /**
     * 导入绿色通道
     *
     * @param excelFile
     * @return
     */
    Map<String, Object> importGreenChannel(MultipartFile excelFile);

    /**
     * 导入减免学费
     *
     * @param excelFile
     * @return
     */
    Map<String, Object> importTuitionWaiver(MultipartFile excelFile);

    /**
     * 导入困难毕业生就业补助
     *
     * @param excelFile
     * @return
     */
    Map<String, Object> importJobseekerSupport(MultipartFile excelFile);

    /**
     * 导入应急求助
     *
     * @param excelFile
     * @return
     */
    Map<String, Object> importEmergencyHelp(MultipartFile excelFile);

    /**
     * 查询国家奖学金
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> selectNationalScholarship(Map<String, Object> mapParam);

    /**
     * 导入国家奖学金
     *
     * @param excelFile
     * @return
     */
    Map<String, Object> importNationalScholarship(MultipartFile excelFile);

    /**
     * 查询国家助学金
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> selectNationalGrants(Map<String, Object> mapParam);

    /**
     * 导入国家助学金
     *
     * @param excelFile
     * @return
     */
    Map<String, Object> importNationalGrants(MultipartFile excelFile);
}
