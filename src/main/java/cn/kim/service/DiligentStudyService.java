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
}
