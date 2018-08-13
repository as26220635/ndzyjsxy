package cn.kim.service;

import cn.kim.entity.DataTablesView;
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
}
