package cn.kim.service.impl;

import cn.kim.common.attr.MagicValue;
import cn.kim.common.attr.ParamTypeResolve;
import cn.kim.common.attr.TableName;
import cn.kim.common.attr.Tips;
import cn.kim.common.eu.NameSpace;
import cn.kim.exception.CustomException;
import cn.kim.service.ConfigureService;
import cn.kim.util.CommonUtil;
import cn.kim.util.FileUtil;
import com.google.common.collect.Maps;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/3/26
 * 配置列表
 */
@Service
public class ConfigureServiceImpl extends BaseServiceImpl implements ConfigureService {

    @Override
    public Map<String, Object> selectConfigure(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("ID", mapParam.get("ID"));
        return baseDao.selectOne(NameSpace.ConfigureMapper, "selectConfigure", paramMap);
    }

    @Override
    public List<Map<String, Object>> selectConfigureList(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(2);
        return baseDao.selectList(NameSpace.ConfigureMapper, "selectConfigure", paramMap);
    }

    @Override
    public List<Map<String, Object>> selectConfigureColumnList(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(2);
        paramMap.put("ID", mapParam.get("ID"));
        paramMap.put("SC_ID", mapParam.get("SC_ID"));
        return baseDao.selectList(NameSpace.ConfigureMapper, "selectConfigureColumn", paramMap);
    }

    @Override
    public List<Map<String, Object>> selectConfigureSearchList(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(2);
        paramMap.put("ID", mapParam.get("ID"));
        paramMap.put("SC_ID", mapParam.get("SC_ID"));
        return baseDao.selectList(NameSpace.ConfigureMapper, "selectConfigureSearch", paramMap);
    }

    @Override
    @Transactional
    public Map<String, Object> insertAndUpdateConfigure(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(10);
            String id = toString(mapParam.get("ID"));
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.SYS_CONFIGURE);

            paramMap.put("ID", id);
            paramMap.put("SC_NAME", mapParam.get("SC_NAME"));
            paramMap.put("SC_VIEW", mapParam.get("SC_VIEW"));
            paramMap.put("SC_ORDER_BY", mapParam.get("SC_ORDER_BY"));
            paramMap.put("SC_JSP", mapParam.get("SC_JSP"));
            paramMap.put("SC_IS_SELECT", mapParam.get("SC_IS_SELECT"));
            paramMap.put("SC_IS_PAGING", mapParam.get("SC_IS_PAGING"));
            paramMap.put("SC_IS_SEARCH", mapParam.get("SC_IS_SEARCH"));
            paramMap.put("SC_IS_FILTER", mapParam.get("SC_IS_FILTER"));
            if (isEmpty(id)) {
                id = getId();
                paramMap.put("ID", id);

                baseDao.insert(NameSpace.ConfigureMapper, "insertConfigure", paramMap);
                resultMap.put(MagicValue.LOG, "添加配置列表:" + formatColumnName(TableName.SYS_CONFIGURE, paramMap));
            } else {
                Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
                oldMap.put("ID", id);
                oldMap = selectConfigure(oldMap);

                baseDao.update(NameSpace.ConfigureMapper, "updateConfigure", paramMap);
                resultMap.put(MagicValue.LOG, "更新配置列表,更新前:" + formatColumnName(TableName.SYS_CONFIGURE, oldMap) + ",更新后:" + formatColumnName(TableName.SYS_CONFIGURE, paramMap));
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
    public Map<String, Object> copyConfigure(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
            String id = toString(mapParam.get("ID"));
            String SC_NAME = toString(mapParam.get("SC_NAME"));
            String SC_VIEW = toString(mapParam.get("SC_VIEW"));
            String SC_JSP = toString(mapParam.get("SC_JSP"));

            paramMap.put("ID", id);
            Map<String, Object> configure = this.selectConfigure(paramMap);

            String newConfigureId = getId();
            configure.put("ID", newConfigureId);
            configure.put("SC_NAME", SC_NAME);
            configure.put("SC_VIEW", SC_VIEW);
            configure.put("SC_JSP", SC_JSP);
            baseDao.insert(NameSpace.ConfigureMapper, "insertConfigure", configure);

            paramMap.clear();
            paramMap.put("SC_ID", id);
            List<Map<String, Object>> columnList = this.selectConfigureColumnList(paramMap);
            for (Map<String, Object> column : columnList) {
                column.put("ID", getId());
                column.put("SC_ID", newConfigureId);
                baseDao.insert(NameSpace.ConfigureMapper, "insertConfigureColumn", column);
            }

            paramMap.clear();
            paramMap.put("SC_ID", id);
            List<Map<String, Object>> searchList = this.selectConfigureSearchList(paramMap);
            for (Map<String, Object> search : searchList) {
                search.put("ID", getId());
                search.put("SC_ID", newConfigureId);
                baseDao.insert(NameSpace.ConfigureMapper, "insertConfigureSearch", search);
            }

            resultMap.put(MagicValue.LOG, "拷贝配置列表:" + formatColumnName(TableName.SYS_CONFIGURE, configure));

            status = STATUS_SUCCESS;
            desc = SAVE_SUCCESS;
        } catch (Exception e) {
            desc = catchException(e, baseDao, resultMap);
        }
        resultMap.put(MagicValue.STATUS, status);
        resultMap.put(MagicValue.DESC, desc);
        return resultMap;
    }

    @Override
    @Transactional
    public Map<String, Object> deleteConfigure(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = DELETE_ERROR;
        try {
            if (isEmpty(mapParam.get("ID"))) {
                throw new CustomException(Tips.ID_NULL_ERROR);
            }
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
            String id = toString(mapParam.get("ID"));

            paramMap.put("SC_ID", id);
            //删除配置列表字段
            baseDao.delete(NameSpace.ConfigureMapper, "deleteConfigureColumn", paramMap);
            //删除配置列表搜索
            baseDao.delete(NameSpace.ConfigureMapper, "deleteConfigureSearch", paramMap);
            //删除配置列表表
            paramMap.clear();
            paramMap.put("ID", id);
            Map<String, Object> oldMap = selectConfigure(paramMap);
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.SYS_CONFIGURE);
            baseDao.delete(NameSpace.ConfigureMapper, "deleteConfigure", paramMap);

            resultMap.put(MagicValue.LOG, "删除配置列表,信息:" + formatColumnName(TableName.SYS_CONFIGURE, oldMap));
            status = STATUS_SUCCESS;
            desc = DELETE_SUCCESS;
        } catch (Exception e) {
            desc = catchException(e, baseDao, resultMap);
        }
        resultMap.put(MagicValue.STATUS, status);
        resultMap.put(MagicValue.DESC, desc);
        return resultMap;
    }

    @Override
    public Map<String, Object> selectConfigureColumn(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("ID", mapParam.get("ID"));
        return baseDao.selectOne(NameSpace.ConfigureMapper, "selectConfigureColumn", paramMap);
    }

    @Override
    @Transactional
    public Map<String, Object> insertAndUpdateConfigureColumn(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(13);
            String id = toString(mapParam.get("ID"));
            String configureId = toString(mapParam.get("SC_ID"));

            paramMap.put("ID", configureId);
            Map<String, Object> configure = selectConfigure(paramMap);

            paramMap.clear();
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.SYS_CONFIGURE_COLUMN);

            paramMap.put("ID", id);
            paramMap.put("SC_ID", configureId);
            paramMap.put("SCC_NAME", mapParam.get("SCC_NAME"));
            paramMap.put("SCC_FIELD", mapParam.get("SCC_FIELD"));
            paramMap.put("SCC_ALIGN", mapParam.get("SCC_ALIGN"));
            paramMap.put("SCC_WIDTH", mapParam.get("SCC_WIDTH"));
            paramMap.put("SCC_CLASS", mapParam.get("SCC_CLASS"));
            paramMap.put("SCC_FUNC", mapParam.get("SCC_FUNC"));
            paramMap.put("SCC_SDT_CODE", mapParam.get("SCC_SDT_CODE"));
            paramMap.put("SCC_IS_FIXED", mapParam.get("SCC_IS_FIXED"));
            paramMap.put("SCC_IS_EXPORT", mapParam.get("SCC_IS_EXPORT"));
            paramMap.put("SCC_IS_OPERATION", mapParam.get("SCC_IS_OPERATION"));
            paramMap.put("SCC_IS_MERGE", mapParam.get("SCC_IS_MERGE"));
            paramMap.put("SCC_IS_VISIBLE", mapParam.get("SCC_IS_VISIBLE"));
            paramMap.put("SCC_IS_STATUS", mapParam.get("SCC_IS_STATUS"));
            paramMap.put("SCC_ORDER", mapParam.get("SCC_ORDER"));

            if (isEmpty(id)) {
                id = getId();
                paramMap.put("ID", id);

                baseDao.insert(NameSpace.ConfigureMapper, "insertConfigureColumn", paramMap);
                resultMap.put(MagicValue.LOG, "添加配置列表字段:" + formatColumnName(TableName.SYS_CONFIGURE_COLUMN, paramMap));
            } else {
                Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
                oldMap.put("ID", id);
                oldMap = selectConfigureColumn(oldMap);

                baseDao.update(NameSpace.ConfigureMapper, "updateConfigureColumn", paramMap);
                resultMap.put(MagicValue.LOG, "更新配置列表字段,更新前:" + formatColumnName(TableName.SYS_CONFIGURE_COLUMN, oldMap) + ",更新后:" + formatColumnName(TableName.SYS_CONFIGURE_COLUMN, paramMap));
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
    public Map<String, Object> deleteConfigureColumn(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = DELETE_ERROR;
        try {
            if (isEmpty(mapParam.get("ID"))) {
                throw new CustomException(Tips.ID_NULL_ERROR);
            }
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
            String id = toString(mapParam.get("ID"));

            //删除配置列表表
            paramMap.put("ID", id);
            Map<String, Object> oldMap = selectConfigureColumn(paramMap);
            paramMap.clear();
            paramMap.put("ID", oldMap.get("SC_ID"));
            Map<String, Object> configure = selectConfigure(paramMap);

            paramMap.clear();
            paramMap.put("ID", id);
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.SYS_CONFIGURE_COLUMN);
            baseDao.delete(NameSpace.ConfigureMapper, "deleteConfigureColumn", paramMap);

            resultMap.put(MagicValue.LOG, "删除配置列表字段:" + formatColumnName(TableName.SYS_CONFIGURE_COLUMN, oldMap));
            status = STATUS_SUCCESS;
            desc = DELETE_SUCCESS;
        } catch (Exception e) {
            desc = catchException(e, baseDao, resultMap);
        }
        resultMap.put(MagicValue.STATUS, status);
        resultMap.put(MagicValue.DESC, desc);
        return resultMap;
    }

    @Override
    public Map<String, Object> selectConfigureSearch(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("ID", mapParam.get("ID"));
        return baseDao.selectOne(NameSpace.ConfigureMapper, "selectConfigureSearch", paramMap);
    }

    @Override
    @Transactional
    public Map<String, Object> insertAndUpdateConfigureSearch(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(10);
            String id = toString(mapParam.get("ID"));
            String configureId = toString(mapParam.get("SC_ID"));

            paramMap.put("ID", configureId);
            Map<String, Object> configure = selectConfigure(paramMap);

            paramMap.clear();
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.SYS_CONFIGURE_SEARCH);
            paramMap.put("ID", id);
            paramMap.put("SC_ID", configureId);
            paramMap.put("SCS_NAME", mapParam.get("SCS_NAME"));
            paramMap.put("SCS_FIELD", mapParam.get("SCS_FIELD"));
            paramMap.put("SCS_SDT_CODE", mapParam.get("SCS_SDT_CODE"));
            paramMap.put("SCS_METHOD_TYPE", mapParam.get("SCS_METHOD_TYPE"));
            paramMap.put("SCS_TYPE", mapParam.get("SCS_TYPE"));
            paramMap.put("SCS_IS_STUDENT_YEAR", mapParam.get("SCS_IS_STUDENT_YEAR"));
            paramMap.put("SCS_REMARK", mapParam.get("SCS_REMARK"));
            paramMap.put("SCC_IS_VISIBLE", mapParam.get("SCC_IS_VISIBLE"));
            paramMap.put("SCS_ORDER", mapParam.get("SCS_ORDER"));

            if (isEmpty(id)) {
                id = getId();
                paramMap.put("ID", id);

                baseDao.insert(NameSpace.ConfigureMapper, "insertConfigureSearch", paramMap);
                resultMap.put(MagicValue.LOG, "添加配置列表搜索:" + formatColumnName(TableName.SYS_CONFIGURE_SEARCH, paramMap));
            } else {
                Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
                oldMap.put("ID", id);
                oldMap = selectConfigureSearch(oldMap);

                baseDao.update(NameSpace.ConfigureMapper, "updateConfigureSearch", paramMap);
                resultMap.put(MagicValue.LOG, "更新配置列表搜索,更新前:" + formatColumnName(TableName.SYS_CONFIGURE_SEARCH, oldMap) + ",更新后:" + formatColumnName(TableName.SYS_CONFIGURE_SEARCH, paramMap));
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
    public Map<String, Object> deleteConfigureSearch(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = DELETE_ERROR;
        try {
            if (isEmpty(mapParam.get("ID"))) {
                throw new CustomException(Tips.ID_NULL_ERROR);
            }
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
            String id = toString(mapParam.get("ID"));

            //删除配置列表表
            paramMap.put("ID", id);
            Map<String, Object> oldMap = selectConfigureSearch(paramMap);
            paramMap.clear();
            paramMap.put("ID", oldMap.get("SC_ID"));
            Map<String, Object> configure = selectConfigure(paramMap);
            //记录日志
            paramMap.clear();
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.SYS_CONFIGURE_SEARCH);
            paramMap.put("ID", id);
            baseDao.delete(NameSpace.ConfigureMapper, "deleteConfigureSearch", paramMap);

            resultMap.put(MagicValue.LOG, "删除配置列表搜索:" + formatColumnName(TableName.SYS_CONFIGURE_SEARCH, oldMap));
            status = STATUS_SUCCESS;
            desc = DELETE_SUCCESS;
        } catch (Exception e) {
            desc = catchException(e, baseDao, resultMap);
        }
        resultMap.put(MagicValue.STATUS, status);
        resultMap.put(MagicValue.DESC, desc);
        return resultMap;
    }

    @Override
    public Map<String, Object> selectConfigureFile(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("ID", mapParam.get("ID"));
        return baseDao.selectOne(NameSpace.ConfigureMapper, "selectConfigureFile", paramMap);
    }

    @Override
    @Transactional
    public Map<String, Object> insertAndUpdateConfigureFile(Map<String, Object> mapParam, MultipartFile file) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            if (isEmpty(file)) {
                throw new CustomException("文件为空!");
            }

            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(5);
            String id = toString(mapParam.get("ID"));

            paramMap.clear();
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.SYS_CONFIGURE_FILE);
            paramMap.put("ID", id);
            paramMap.put("SC_ID", mapParam.get("SC_ID"));
            paramMap.put("SCF_NAME", mapParam.get("SCF_NAME"));
            paramMap.put("IS_STATUS", mapParam.get("IS_STATUS"));

            if (isEmpty(id)) {
                id = getId();
                paramMap.put("ID", id);
                paramMap.put("SCF_ENTRY_TIME", getSqlDate());

                baseDao.insert(NameSpace.ConfigureMapper, "insertConfigureFile", paramMap);
                resultMap.put(MagicValue.LOG, "添加配置列表文件:" + formatColumnName(TableName.SYS_CONFIGURE_FILE, paramMap));
            } else {
                Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
                oldMap.put("ID", id);
                oldMap = selectConfigureFile(oldMap);

                baseDao.update(NameSpace.ConfigureMapper, "updateConfigureFile", paramMap);

                //删除文件
                if (!deleteFile(id, TableName.SYS_CONFIGURE_FILE)) {
                    throw new CustomException("文件删除失败！");
                }

                resultMap.put(MagicValue.LOG, "更新配置列表文件,更新前:" + formatColumnName(TableName.SYS_CONFIGURE_FILE, oldMap) + ",更新后:" + formatColumnName(TableName.SYS_CONFIGURE_FILE, paramMap));
            }

            //上传文件
            Map<String, Object> result = insertFile(file, id, TableName.SYS_CONFIGURE_FILE, STATUS_SUCCESS);
            if (!result.get("code").equals(STATUS_SUCCESS)) {
                throw new CustomException(toString(result.get("message")));
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
    public Map<String, Object> changeConfigureFileStatus(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(2);
            String id = toString(mapParam.get("ID"));

            paramMap.put("ID", id);
            paramMap.put("IS_STATUS", mapParam.get("IS_STATUS"));

            Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
            oldMap.put("ID", id);
            oldMap = selectConfigureFile(oldMap);
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.SYS_CONFIGURE_FILE);
            baseDao.update(NameSpace.ConfigureMapper, "updateConfigureFile", paramMap);
            resultMap.put(MagicValue.LOG, "更新配置列表文件状态,配置列表:" + toString(oldMap.get("SC_NAME")) + ",状态更新为:" + ParamTypeResolve.statusExplain(mapParam.get("IS_STATUS")));

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
    public Map<String, Object> deleteConfigureFile(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = DELETE_ERROR;
        try {
            if (isEmpty(mapParam.get("ID"))) {
                throw new CustomException(Tips.ID_NULL_ERROR);
            }
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
            String id = toString(mapParam.get("ID"));

            //删除配置列表表
            paramMap.put("ID", id);
            Map<String, Object> oldMap = selectConfigureFile(paramMap);
            //记录日志
            paramMap.clear();
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.SYS_CONFIGURE_FILE);
            paramMap.put("ID", id);
            baseDao.delete(NameSpace.ConfigureMapper, "deleteConfigureFile", paramMap);

            //删除文件
            paramMap.clear();
            paramMap.put("SF_TABLE_ID", id);
            paramMap.put("SF_TABLE_NAME", TableName.SYS_CONFIGURE_FILE);
            Map<String, Object> file = baseDao.selectOne(NameSpace.FileMapper, "selectFile", paramMap);
            if (!isEmpty(file)) {
                FileUtil.delServiceFile(toString(file.get("ID")));
            }

            resultMap.put(MagicValue.LOG, "删除配置列表文件:" + formatColumnName(TableName.SYS_CONFIGURE_FILE, oldMap));
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
