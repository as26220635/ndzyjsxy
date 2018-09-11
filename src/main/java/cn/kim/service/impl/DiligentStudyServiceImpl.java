package cn.kim.service.impl;

import cn.kim.common.attr.MagicValue;
import cn.kim.common.attr.TableName;
import cn.kim.common.attr.Tips;
import cn.kim.common.eu.*;
import cn.kim.common.eu.Process;
import cn.kim.dao.BaseDao;
import cn.kim.entity.ActiveUser;
import cn.kim.entity.DictInfo;
import cn.kim.entity.StudentYearSemester;
import cn.kim.exception.CustomException;
import cn.kim.service.DiligentStudyService;
import cn.kim.tools.ProcessTool;
import cn.kim.util.DictUtil;
import cn.kim.util.PoiUtil;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.jetbrains.annotations.Nullable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/9/10
 * 勤工助学管理
 */
@Service
public class DiligentStudyServiceImpl extends BaseServiceImpl implements DiligentStudyService {

    @Override
    public Map<String, Object> selectDiligentStudy(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("ID", mapParam.get("ID"));
        return baseDao.selectOne(NameSpace.DiligentStudyMapper, "selectDiligentStudy", paramMap);
    }

    @Override
    @Transactional
    public Map<String, Object> insertAndUpdateDiligentStudy(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;

        ActiveUser activeUser = getActiveUser();

        String operatorId = activeUser.getId();
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(10);

            String id = toString(mapParam.get("ID"));

            paramMap.clear();
            paramMap.put("NOT_ID", id);
            paramMap.put("BDS_TABLE_ID", mapParam.get("BDS_TABLE_ID"));
            paramMap.put("BDS_TABLE_NAME", mapParam.get("BDS_TABLE_NAME"));
            paramMap.put("BDS_YEAR", mapParam.get("BDS_YEAR"));
            paramMap.put("BDS_SEMESTER", mapParam.get("BDS_SEMESTER"));
            int count = baseDao.selectOne(NameSpace.DiligentStudyMapper, "selectDiligentStudyCount", paramMap);
            if (count > 0) {
                throw new CustomException("部门同学年同学期已经存在勤工助学记录!");
            }
            //记录日志
            paramMap.clear();
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_DILIGENT_STUDY);

            paramMap.put("ID", id);
            paramMap.put("SO_ID", mapParam.get("SO_ID"));
            paramMap.put("BDS_TABLE_ID", mapParam.get("BDS_TABLE_ID"));
            paramMap.put("BDS_TABLE_NAME", mapParam.get("BDS_TABLE_NAME"));
            paramMap.put("BDS_YEAR", mapParam.get("BDS_YEAR"));
            paramMap.put("BDS_SEMESTER", mapParam.get("BDS_SEMESTER"));


            if (isEmpty(id)) {
                id = getId();
                paramMap.put("ID", id);
                paramMap.put("SO_ID", operatorId);
                paramMap.put("BDS_ENTRY_TIME", getDate());
                paramMap.put("BUS_PROCESS", Process.DILIGENT.toString());
                paramMap.put("BUS_PROCESS2", Process.DILIGENT_STUDY.toString());

                baseDao.insert(NameSpace.DiligentStudyMapper, "insertDiligentStudy", paramMap);

                //插入流程
                createProcessSchedule(id, toString(paramMap.get("BDS_TABLE_ID")),
                        operatorId, null, toString(paramMap.get("BUS_PROCESS")), toString(paramMap.get("BUS_PROCESS2")));

                resultMap.put(MagicValue.LOG, "添加勤工助学:" + formatColumnName(String.join(SERVICE_SPLIT, TableName.BUS_DILIGENT_STUDY), paramMap));
            } else {
                Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
                oldMap.put("ID", id);
                oldMap = selectDiligentStudy(oldMap);

                baseDao.update(NameSpace.DiligentStudyMapper, "updateDiligentStudy", paramMap);

                resultMap.put(MagicValue.LOG, "更新勤工助学,更新前:" + formatColumnName(String.join(SERVICE_SPLIT, TableName.BUS_DILIGENT_STUDY), oldMap) +
                        ",更新后:" + formatColumnName(String.join(SERVICE_SPLIT, TableName.BUS_DILIGENT_STUDY), paramMap));
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
    public Map<String, Object> deleteDiligentStudy(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = DELETE_ERROR;
        try {
            if (isEmpty(mapParam.get("ID"))) {
                throw new CustomException("ID不能为空!");
            }
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(2);
            String id = toString(mapParam.get("ID"));
            paramMap.clear();
            paramMap.put("ID", id);
            Map<String, Object> oldMap = selectDiligentStudy(paramMap);

            //查询勤工助学是否正在进行流程
            Map<String, Object> schedule = getProcessSchedule(id, toString(oldMap.get("BUS_PROCESS")), toString(oldMap.get("BUS_PROCESS2")));
            if (!isEmpty(schedule)) {
                String SPS_AUDIT_STATUS = toString(schedule.get("SPS_AUDIT_STATUS"));
                if (!isEmpty(SPS_AUDIT_STATUS) &&
                        !ProcessStatus.START.toString().equals(SPS_AUDIT_STATUS) &&
                        !ProcessStatus.BACK.toString().equals(SPS_AUDIT_STATUS)) {
                    throw new CustomException(Tips.PROCESS_DELETE_ERROR);
                }
            }

            //删除勤工助学
            paramMap.clear();
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_DILIGENT_STUDY);
            paramMap.put("ID", id);
            baseDao.delete(NameSpace.DiligentStudyMapper, "deleteDiligentStudy", paramMap);

            //删除流程
            deleteProcessSchedule(id);
            resultMap.put(MagicValue.LOG, "删除勤工助学,信息:" + formatColumnName(String.join(SERVICE_SPLIT, TableName.BUS_DILIGENT_STUDY), oldMap));
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
    public Map<String, Object> selectDiligentStudyPost(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(4);
        paramMap.put("ID", mapParam.get("ID"));
        paramMap.put("BDS_ID", mapParam.get("BDS_ID"));
        paramMap.put("BDSP_NUMBER", mapParam.get("BDSP_NUMBER"));
        paramMap.put("BDSP_NAME", mapParam.get("BDSP_NAME"));
        return baseDao.selectOne(NameSpace.DiligentStudyMapper, "selectDiligentStudyPost", paramMap);
    }

    @Override
    @Transactional
    public Map<String, Object> insertAndUpdateDiligentStudyPost(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;

        ActiveUser activeUser = getActiveUser();

        String operatorId = activeUser.getId();
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(10);

            String id = toString(mapParam.get("ID"));

            paramMap.clear();
            paramMap.put("NOT_ID", id);
            paramMap.put("BDSP_NUMBER", mapParam.get("BDSP_NUMBER"));
            int count = baseDao.selectOne(NameSpace.DiligentStudyMapper, "selectDiligentStudyPostCount", paramMap);
            if (count > 0) {
                throw new CustomException("岗位编号重复!");
            }

            //记录日志
            paramMap.clear();
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_DILIGENT_STUDY_POST);

            paramMap.put("ID", id);
            paramMap.put("BDS_ID", mapParam.get("BDS_ID"));
            paramMap.put("BDSP_NUMBER", mapParam.get("BDSP_NUMBER"));
            paramMap.put("BDSP_NAME", mapParam.get("BDSP_NAME"));
            paramMap.put("BDSP_HOURLY_WAGE", mapParam.get("BDSP_HOURLY_WAGE"));
            paramMap.put("BDSP_ORDER", mapParam.get("BDSP_ORDER"));

            if (isEmpty(id)) {
                id = getId();
                paramMap.put("ID", id);
                paramMap.put("SO_ID", operatorId);
                paramMap.put("BDSP_ENTRY_TIME", getDate());

                baseDao.insert(NameSpace.DiligentStudyMapper, "insertDiligentStudyPost", paramMap);

                resultMap.put(MagicValue.LOG, "添加勤工助学岗位:" + formatColumnName(String.join(SERVICE_SPLIT, TableName.BUS_DILIGENT_STUDY_POST), paramMap));
            } else {
                Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
                oldMap.put("ID", id);
                oldMap = selectDiligentStudyPost(oldMap);

                baseDao.update(NameSpace.DiligentStudyMapper, "updateDiligentStudyPost", paramMap);

                resultMap.put(MagicValue.LOG, "更新勤工助学岗位,更新前:" + formatColumnName(String.join(SERVICE_SPLIT, TableName.BUS_DILIGENT_STUDY_POST), oldMap) +
                        ",更新后:" + formatColumnName(String.join(SERVICE_SPLIT, TableName.BUS_DILIGENT_STUDY_POST), paramMap));
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
    public Map<String, Object> deleteDiligentStudyPost(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = DELETE_ERROR;
        try {
            if (isEmpty(mapParam.get("ID"))) {
                throw new CustomException("ID不能为空!");
            }
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(2);
            String id = toString(mapParam.get("ID"));
            paramMap.clear();
            paramMap.put("ID", id);
            Map<String, Object> oldMap = selectDiligentStudyPost(paramMap);

            //查询勤工助学是否正在进行流程
            String diligentStudyId = toString(oldMap.get("BDS_ID"));
            String busProcess = toString(oldMap.get("BUS_PROCESS"));
            String busProcess2 = toString(oldMap.get("BUS_PROCESS2"));
            Map<String, Object> schedule = getProcessSchedule(diligentStudyId, busProcess, busProcess2);
            if (!isEmpty(schedule)) {
                String SPS_AUDIT_STATUS = toString(schedule.get("SPS_AUDIT_STATUS"));
                boolean isEdit = true;
                //审核通过
                if (isEdit && ProcessStatus.COMPLETE.toString().equals(SPS_AUDIT_STATUS)) {
                    isEdit = false;
                }
                //是否流程到达自身
                if (isEdit && !ProcessTool.showDataGridProcessBtn(diligentStudyId, busProcess, busProcess2).contains(ProcessType.SUBMIT.toString())) {
                    isEdit = false;
                }
                //是否流程到达自身
                if (!isEdit && ProcessTool.selectNowActiveProcessStepIsEdit(busProcess, busProcess2)) {
                    isEdit = true;
                }
                if (!isEdit) {
                    throw new CustomException(Tips.PROCESS_DELETE_ERROR);
                }
            }

            //删除勤工助学岗位
            paramMap.clear();
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_DILIGENT_STUDY_POST);
            paramMap.put("ID", id);
            baseDao.delete(NameSpace.DiligentStudyMapper, "deleteDiligentStudyPost", paramMap);

            resultMap.put(MagicValue.LOG, "删除勤工助学岗位,信息:" + formatColumnName(String.join(SERVICE_SPLIT, TableName.BUS_DILIGENT_STUDY_POST), oldMap));
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
