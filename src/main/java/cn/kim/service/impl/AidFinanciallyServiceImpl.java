package cn.kim.service.impl;

import cn.kim.common.attr.Attribute;
import cn.kim.common.attr.MagicValue;
import cn.kim.common.attr.TableName;
import cn.kim.common.eu.NameSpace;
import cn.kim.common.eu.SystemEnum;
import cn.kim.entity.DataTablesView;
import cn.kim.entity.QuerySet;
import cn.kim.exception.CustomException;
import cn.kim.service.AidFinanciallyService;
import cn.kim.util.CommonUtil;
import cn.kim.util.DictUtil;
import com.google.common.collect.Maps;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/8/12
 * 资助管理
 */
@Service
public class AidFinanciallyServiceImpl extends BaseServiceImpl implements AidFinanciallyService {

    @Override
    public Map<String, Object> selectAidFinancially(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(4);
        paramMap.put("ID", mapParam.get("ID"));
        paramMap.put("BS_ID", mapParam.get("BS_ID"));
        return baseDao.selectOne(NameSpace.AidFinanciallyMapper, "selectAidFinancially", paramMap);
    }

    @Override
    @Transactional
    public Map<String, Object> insertAndUpdateAidFinancially(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(10);
            String id = toString(mapParam.get("ID"));

            //判断综合素质测评是否存在
            paramMap.put("BS_ID", mapParam.get("BS_ID"));
            paramMap.put("BSC_YEAR", mapParam.get("BSC_YEAR"));
            paramMap.put("BSC_SEMESTER", mapParam.get("BSC_SEMESTER"));
            int count = baseDao.selectOne(NameSpace.StudentExtendMapper, "selectStudentComprehensiveCount", paramMap);
            if (count == 0 ) {
                throw new CustomException("该学生" + mapParam.get("BS_NAME") + "学年" +
                        DictUtil.getDictName("BUS_SEMESTER", mapParam.get("BAF_SEMESTER")) +
                        "没有存在综合素质测评!");
            }

            //记录日志
            paramMap.clear();
            paramMap.put("SVR_TABLE_NAME", TableName.BUS_AID_FINANCIALLY);

            paramMap.put("ID", id);
            paramMap.put("BS_ID", mapParam.get("BS_ID"));
            paramMap.put("BAF_YEAR", mapParam.get("BAF_YEAR"));
            paramMap.put("BAF_SEMESTER", mapParam.get("BAF_SEMESTER"));
            paramMap.put("BAF_AID_TYPE", mapParam.get("BAF_AID_TYPE"));
            paramMap.put("BAF_REDUCTION_LEVEL", mapParam.get("BAF_REDUCTION_LEVEL"));
            paramMap.put("BAF_REDUCTION_QUOTA", mapParam.get("BAF_REDUCTION_QUOTA"));
            paramMap.put("BAF_DIFFICULTY_LEVEL", mapParam.get("BAF_DIFFICULTY_LEVEL"));
            paramMap.put("BAF_DIFFICULTY_TYPE", mapParam.get("BAF_DIFFICULTY_TYPE"));

            if (isEmpty(id)) {
                id = getId();
                paramMap.put("ID", id);
                paramMap.put("BAF_TYPE", mapParam.get("BAF_TYPE"));
                paramMap.put("SO_ID", getActiveUser().getId());
                paramMap.put("BUS_PROCESS", mapParam.get("BUS_PROCESS"));
                paramMap.put("BUS_PROCESS2", mapParam.get("BUS_PROCESS2"));
                paramMap.put("BAF_ENTRY_TIME", getDate());

                baseDao.insert(NameSpace.AidFinanciallyMapper, "insertAidFinancially", paramMap);
                resultMap.put(MagicValue.LOG, "添加资助:" + toString(paramMap));
            } else {
                Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
                oldMap.put("ID", id);
                oldMap = selectAidFinancially(oldMap);

                baseDao.update(NameSpace.AidFinanciallyMapper, "updateAidFinancially", paramMap);
                resultMap.put(MagicValue.LOG, "更新资助,更新前:" + toString(oldMap) + ",更新后:" + toString(paramMap));
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
    public Map<String, Object> deleteAidFinancially(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = DELETE_ERROR;
        try {
            if (isEmpty(mapParam.get("ID"))) {
                throw new CustomException("ID不能为空!");
            }
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
            String id = toString(mapParam.get("ID"));

            //删除资助表
            paramMap.clear();
            paramMap.put("ID", id);
            Map<String, Object> oldMap = selectAidFinancially(paramMap);
            if (!isEmpty(oldMap.get("SPS_AUDIT_STATUS")) && !"0".equals(toString(oldMap.get("SPS_AUDIT_STATUS")))) {
                throw new CustomException("流程办理中不能删除!");
            }
            //记录日志
            paramMap.put("SVR_TABLE_NAME", TableName.BUS_AID_FINANCIALLY);

            baseDao.delete(NameSpace.AidFinanciallyMapper, "deleteAidFinancially", paramMap);

            resultMap.put(MagicValue.LOG, "删除资助,信息:" + toString(oldMap));
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
