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
                throw new CustomException(Tips.ID_NULL_ERROR);
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
                throw new CustomException(Tips.ID_NULL_ERROR);
            }
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(2);
            String id = toString(mapParam.get("ID"));
            paramMap.clear();
            paramMap.put("ID", id);
            Map<String, Object> oldMap = selectDiligentStudyPost(paramMap);

            //验证勤工助学状态
            validateDiligentStudyStatus(toString(oldMap.get("BDS_ID")), toString(oldMap.get("BUS_PROCESS")), toString(oldMap.get("BUS_PROCESS2")));

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

    @Override
    public Map<String, Object> selectDiligentStudyStudent(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(3);
        paramMap.put("ID", mapParam.get("ID"));
        paramMap.put("BS_ID", mapParam.get("BS_ID"));
        paramMap.put("BDSP_ID", mapParam.get("BDSP_ID"));
        return baseDao.selectOne(NameSpace.DiligentStudyMapper, "selectDiligentStudyStudent", paramMap);
    }

    @Override
    @Transactional
    public Map<String, Object> insertAndUpdateDiligentStudyStudent(Map<String, Object> mapParam) {
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
            paramMap.put("BS_ID", mapParam.get("BS_ID"));
            paramMap.put("BDSP_ID", mapParam.get("BDSP_ID"));
            int count = baseDao.selectOne(NameSpace.DiligentStudyMapper, "selectDiligentStudyStudentCount", paramMap);
            if (count > 0) {
                throw new CustomException("岗位学生重复添加!");
            }

            //记录日志
            paramMap.clear();
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_DILIGENT_STUDY_STUDENT);

            paramMap.put("ID", id);
            paramMap.put("BS_ID", mapParam.get("BS_ID"));
            paramMap.put("BDSP_ID", mapParam.get("BDSP_ID"));

            if (isEmpty(id)) {
                id = getId();
                paramMap.put("ID", id);
                paramMap.put("SO_ID", operatorId);
                paramMap.put("BDSS_ENTRY_TIME", getDate());

                baseDao.insert(NameSpace.DiligentStudyMapper, "insertDiligentStudyStudent", paramMap);

                resultMap.put(MagicValue.LOG, "添加勤工助学学生:" + formatColumnName(String.join(SERVICE_SPLIT, TableName.BUS_DILIGENT_STUDY_STUDENT), paramMap));
            } else {
                Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
                oldMap.put("ID", id);
                oldMap = selectDiligentStudyStudent(oldMap);

                baseDao.update(NameSpace.DiligentStudyMapper, "updateDiligentStudyStudent", paramMap);

                resultMap.put(MagicValue.LOG, "更新勤工助学学生,更新前:" + formatColumnName(String.join(SERVICE_SPLIT, TableName.BUS_DILIGENT_STUDY_STUDENT), oldMap) +
                        ",更新后:" + formatColumnName(String.join(SERVICE_SPLIT, TableName.BUS_DILIGENT_STUDY_STUDENT), paramMap));
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
    public Map<String, Object> deleteDiligentStudyStudent(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = DELETE_ERROR;
        try {
            if (isEmpty(mapParam.get("ID"))) {
                throw new CustomException(Tips.ID_NULL_ERROR);
            }
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(2);
            String id = toString(mapParam.get("ID"));
            paramMap.clear();
            paramMap.put("ID", id);
            Map<String, Object> oldMap = selectDiligentStudyStudent(paramMap);

            //验证勤工助学状态
            validateDiligentStudyStatus(toString(oldMap.get("BDS_ID")), toString(oldMap.get("BUS_PROCESS")), toString(oldMap.get("BUS_PROCESS2")));

            //删除勤工助学学生
            paramMap.clear();
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_DILIGENT_STUDY_STUDENT);
            paramMap.put("ID", id);
            baseDao.delete(NameSpace.DiligentStudyMapper, "deleteDiligentStudyStudent", paramMap);

            resultMap.put(MagicValue.LOG, "删除勤工助学学生,信息:" + formatColumnName(String.join(SERVICE_SPLIT, TableName.BUS_DILIGENT_STUDY_STUDENT), oldMap));
            status = STATUS_SUCCESS;
            desc = DELETE_SUCCESS;
        } catch (Exception e) {
            desc = catchException(e, baseDao, resultMap);
        }
        resultMap.put(MagicValue.STATUS, status);
        resultMap.put(MagicValue.DESC, desc);
        return resultMap;
    }

    /**
     * 导入勤工助学学生
     *
     * @param excelFile
     * @return
     */
    @Override
    @Transactional
    public Map<String, Object> importDiligentStudyStudent(MultipartFile excelFile) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = IMPORT_ERROR;
        try {
            List<String[]> dataList = PoiUtil.readExcel(excelFile, 0, 1);
            //校验数据
            List<String[]> errorList = checkDiligentStudyStudentExcelData(dataList);
            if (!isEmpty(errorList)) {
                resultMap.put(MagicValue.DATA, errorList);
                throw new CustomException("检测数据异常!");
            }

            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(6);

            //导入数据
            for (String[] data : dataList) {
                //学号
                String BS_NUMBER = data[2];
                //岗位编号
                String BDSP_NUMBER = data[4];
                //查询学生
                paramMap.clear();
                paramMap.put("BS_NUMBER", BS_NUMBER);
                Map<String, Object> student = baseDao.selectOne(NameSpace.StudentMapper, "selectStudent", paramMap);
                //查询岗位
                paramMap.clear();
                paramMap.put("BDSP_NUMBER", BDSP_NUMBER);
                Map<String, Object> post = baseDao.selectOne(NameSpace.DiligentStudyMapper, "selectDiligentStudyPost", paramMap);

                paramMap.clear();
                paramMap.put("BS_ID", student.get("ID"));
                paramMap.put("BDSP_ID", post.get("ID"));
                Map<String, Object> diligentStudyStudent = insertAndUpdateDiligentStudyStudent(paramMap);
                validateResultMap(diligentStudyStudent);
            }

            resultMap.put(MagicValue.LOG, "导入勤工助学学生数据,数据:" + toString(dataList));
            status = STATUS_SUCCESS;
            desc = IMPORT_SUCCESS;
        } catch (Exception e) {
            desc = catchException(e, baseDao, resultMap);
        }
        resultMap.put(MagicValue.STATUS, status);
        resultMap.put(MagicValue.DESC, desc);
        return resultMap;
    }

    /**
     * 验证勤工助学状态
     *
     * @param diligentStudyId
     * @param busProcess
     * @param busProcess2
     * @throws Exception
     */
    public void validateDiligentStudyStatus(String diligentStudyId, String busProcess, String busProcess2) throws Exception {
        //查询勤工助学是否正在进行流程
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
    }

    /**
     * 校验勤工助学学生导入数据
     *
     * @param dataList
     * @return
     */
    public List<String[]> checkDiligentStudyStudentExcelData(List<String[]> dataList) {
        List<String[]> resultList = Lists.newArrayList();
        if (isEmpty(dataList)) {
            resultList.add(packErrorData("文件数据错误", "没有找到可以导入数据"));
            return resultList;
        }
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);

        for (int i = 0; i < dataList.size(); i++) {
            //行
            String row = joinRowStr(i + 2);

            String[] data = dataList.get(i);
            //学号
            String BS_NUMBER = data[2];
            //岗位编号
            String BDSP_NUMBER = data[4];

            List<String[]> checkIsEmptyList = checkIsEmpty(row, data, new int[]{2, 4});
            if (!isEmpty(checkIsEmptyList)) {
                resultList.addAll(checkIsEmptyList);
                continue;
            }
            //查询数据库检查学号是否为空
            paramMap.clear();
            paramMap.put("BS_NUMBER", BS_NUMBER);
            Map<String, Object> student = baseDao.selectOne(NameSpace.StudentMapper, "selectStudent", paramMap);
            if (isEmpty(student)) {
                resultList.add(packErrorData(row, "学号错误,没有找到对应的学生"));
            } else {
                //检测岗位
                paramMap.clear();
                paramMap.put("BDSP_NUMBER", BDSP_NUMBER);
                Map<String, Object> post = baseDao.selectOne(NameSpace.DiligentStudyMapper, "selectDiligentStudyPost", paramMap);

                if (isEmpty(post)) {
                    resultList.add(packErrorData(row, "岗位编号错误,没有找到对应的岗位"));
                } else {
                    //检测学生是否重复添加
                    paramMap.clear();
                    paramMap.put("BS_ID", student.get("ID"));
                    paramMap.put("BDSP_ID", post.get("ID"));
                    int count = baseDao.selectOne(NameSpace.DiligentStudyMapper, "selectDiligentStudyStudentCount", paramMap);
                    if (count > 0) {
                        resultList.add(packErrorData(row, "该岗位已经存在相同的学生记录"));
                    }
                }

            }
        }

        return resultList;
    }
}
