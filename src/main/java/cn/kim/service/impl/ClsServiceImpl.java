package cn.kim.service.impl;

import cn.kim.common.attr.MagicValue;
import cn.kim.common.attr.TableName;
import cn.kim.common.eu.NameSpace;
import cn.kim.exception.CustomException;
import cn.kim.service.ClsService;
import com.google.common.collect.Maps;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/8/6
 * 班级管理
 */
@Service
public class ClsServiceImpl extends BaseServiceImpl implements ClsService {

    @Override
    public Map<String, Object> selectClass(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("ID", mapParam.get("ID"));
        return baseDao.selectOne(NameSpace.ClsMapper, "selectClass", paramMap);
    }

    @Override
    public List<Map<String, Object>> selectClassList(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("BDM_ID", mapParam.get("BDM_ID"));
        return baseDao.selectList(NameSpace.ClsMapper, "selectClass", paramMap);
    }

    @Override
    @Transactional
    public Map<String, Object> insertAndUpdateClass(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(10);
            String id = toString(mapParam.get("ID"));
            //记录日志
            paramMap.put("SVR_TABLE_NAME", TableName.BUS_CLASS);

            paramMap.put("ID", id);
            paramMap.put("BDM_ID", mapParam.get("BDM_ID"));
            paramMap.put("BC_MAJOR", mapParam.get("BC_MAJOR"));
            paramMap.put("BC_NAME", mapParam.get("BC_NAME"));
            paramMap.put("BC_YEAR", mapParam.get("BC_YEAR"));

            if (isEmpty(id)) {
                id = getId();
                paramMap.put("ID", id);
                paramMap.put("BC_ENTRY_TIME", getDate());

                baseDao.insert(NameSpace.ClsMapper, "insertClass", paramMap);
                resultMap.put(MagicValue.LOG, "添加班级:" + toString(paramMap));
            } else {
                Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
                oldMap.put("ID", id);
                oldMap = selectClass(oldMap);

                baseDao.update(NameSpace.ClsMapper, "updateClass", paramMap);
                resultMap.put(MagicValue.LOG, "更新班级,更新前:" + toString(oldMap) + ",更新后:" + toString(paramMap));
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
    public Map<String, Object> deleteClass(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = DELETE_ERROR;
        try {
            if (isEmpty(mapParam.get("ID"))) {
                throw new CustomException("ID不能为空!");
            }
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
            String id = toString(mapParam.get("ID"));

            //删除班级表
            paramMap.clear();
            paramMap.put("ID", id);
            Map<String, Object> oldMap = selectClass(paramMap);
            //记录日志
            paramMap.put("SVR_TABLE_NAME", TableName.BUS_CLASS);
            baseDao.delete(NameSpace.ClsMapper, "deleteClass", paramMap);

            resultMap.put(MagicValue.LOG, "删除班级,信息:" + toString(oldMap));
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
