package cn.kim.service;

import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/9/4
 * 文件管理
 */
public interface DocumentService extends BaseService {
    /**
     * 查询文件
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> selectDocument(Map<String, Object> mapParam);

    /**
     * 插入或更新文件
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> insertAndUpdateDocument(Map<String, Object> mapParam, MultipartFile file);

    /**
     * 删除文件
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> deleteDocument(Map<String, Object> mapParam);

}
