package cn.kim.service.impl;

import cn.kim.common.attr.MagicValue;
import cn.kim.common.attr.TableName;
import cn.kim.common.attr.Tips;
import cn.kim.common.eu.NameSpace;
import cn.kim.exception.CustomException;
import cn.kim.service.DocumentService;
import com.google.common.collect.Maps;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/9/4
 * 文件管理
 */
@Service
public class DocumentServiceImpl extends BaseServiceImpl implements DocumentService {

    @Override
    public Map<String, Object> selectDocument(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("ID", mapParam.get("ID"));
        return baseDao.selectOne(NameSpace.DocumentMapper, "selectDocument", paramMap);
    }

    @Override
    @Transactional
    public Map<String, Object> insertAndUpdateDocument(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(10);
            String id = toString(mapParam.get("ID"));
            String insertId = toString(mapParam.get("insertId"));
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_DOCUMENT);

            paramMap.put("ID", id);
            paramMap.put("BD_YEAR", mapParam.get("BD_YEAR"));
            paramMap.put("BD_NUMBER", mapParam.get("BD_NUMBER"));
            paramMap.put("BD_TITLE", mapParam.get("BD_TITLE"));
            paramMap.put("BD_DATE", mapParam.get("BD_DATE"));
            paramMap.put("BD_IS_NEED_REPLY", toNull(mapParam.get("BD_IS_NEED_REPLY")));
            paramMap.put("BD_REPLY_TIME", mapParam.get("BD_REPLY_TIME"));
            paramMap.put("BD_IS_REPLY", toNull(mapParam.get("BD_IS_REPLY")));
            paramMap.put("BD_REPLY_CONTENT", mapParam.get("BD_REPLY_CONTENT"));
            paramMap.put("BD_REMARKS", mapParam.get("BD_REMARKS"));

            if (isEmpty(id)) {
                id = insertId;
                paramMap.put("ID", id);
                paramMap.put("SO_ID", getActiveUser().getId());
                paramMap.put("BD_TYPE", mapParam.get("BD_TYPE"));
                paramMap.put("BD_ENTRY_TIME", getDate());

                baseDao.insert(NameSpace.DocumentMapper, "insertDocument", paramMap);
                resultMap.put(MagicValue.LOG, "添加文件:" + formatColumnName(TableName.BUS_DOCUMENT, paramMap));
            } else {
                Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
                oldMap.put("ID", id);
                oldMap = selectDocument(oldMap);

                baseDao.update(NameSpace.DocumentMapper, "updateDocument", paramMap);

                resultMap.put(MagicValue.LOG, "更新文件,更新前:" + formatColumnName(TableName.BUS_DOCUMENT, oldMap) + ",更新后:" + formatColumnName(TableName.BUS_DOCUMENT, paramMap));
            }

            status = STATUS_SUCCESS;
            desc = SAVE_SUCCESS;

            resultMap.put("ID", id);
        } catch (Exception e) {
            desc = catchException(e, baseDao, resultMap);
        }
        resultMap.put(MagicValue.STATUS, status);
        resultMap.put(MagicValue.DESC, desc);
        return resultMap;
    }

    @Override
    @Transactional
    public Map<String, Object> deleteDocument(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = DELETE_ERROR;
        try {
            if (isEmpty(mapParam.get("ID"))) {
                throw new CustomException(Tips.ID_NULL_ERROR);
            }
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
            String id = toString(mapParam.get("ID"));

            //删除文件表
            paramMap.clear();
            paramMap.put("ID", id);
            Map<String, Object> oldMap = selectDocument(paramMap);
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_DOCUMENT);
            baseDao.delete(NameSpace.DocumentMapper, "deleteDocument", paramMap);

            resultMap.put(MagicValue.LOG, "删除文件,信息:" + formatColumnName(TableName.BUS_DOCUMENT, oldMap));
            status = STATUS_SUCCESS;
            desc = DELETE_SUCCESS;
        } catch (Exception e) {
            desc = catchException(e, baseDao, resultMap);
        }
        resultMap.put(MagicValue.STATUS, status);
        resultMap.put(MagicValue.DESC, desc);
        return resultMap;
    }
}
