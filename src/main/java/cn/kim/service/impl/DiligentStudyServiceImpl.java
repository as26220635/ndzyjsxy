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
import cn.kim.util.BigDecimalUtil;
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
            validateProcessStatus(toString(oldMap.get("BDS_ID")), toString(oldMap.get("BUS_PROCESS")), toString(oldMap.get("BUS_PROCESS2")));

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
            Map<String, Object> oldMap = this.selectDiligentStudyStudent(paramMap);

            //验证勤工助学状态
            validateProcessStatus(toString(oldMap.get("BDS_ID")), Process.DILIGENT.toString(), Process.DILIGENT_STUDY.toString());

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
                Map<String, Object> diligentStudyStudent = this.insertAndUpdateDiligentStudyStudent(paramMap);
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

    @Override
    public Map<String, Object> selectStudentByDiligentStudyStudentId(String id) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("ID", id);
        return baseDao.selectOne(NameSpace.StudentMapper, "selectStudentByDiligentStudyStudentId", paramMap);
    }

    @Override
    public Map<String, Object> selectDiligentStudyMonthWages(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(3);
        paramMap.put("ID", mapParam.get("ID"));
        paramMap.put("BDSS_ID", mapParam.get("BDSS_ID"));
        return baseDao.selectOne(NameSpace.DiligentStudyMapper, "selectDiligentStudyMonthWages", paramMap);
    }

    @Override
    @Transactional
    public Map<String, Object> insertAndUpdateDiligentStudyMonthWages(Map<String, Object> mapParam) {
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
            paramMap.put("BDSS_ID", mapParam.get("BDSS_ID"));
            paramMap.put("BDSMW_MONTH", mapParam.get("BDSMW_MONTH"));
            int count = baseDao.selectOne(NameSpace.DiligentStudyMapper, "selectDiligentStudyMonthWagesCount", paramMap);
            if (count > 0) {
                throw new CustomException("学生月工资重复添加!");
            }
            //查询岗位每小时工资
            paramMap.clear();
            paramMap.put("ID", mapParam.get("BDSS_ID"));
            Map<String, Object> post = baseDao.selectOne(NameSpace.StudentMapper, "selectPostByDiligentStudyStudentId", paramMap);

            //记录日志
            paramMap.clear();
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_DILIGENT_STUDY_MONTH_WAGES);

            paramMap.put("ID", id);
            paramMap.put("SO_ID", mapParam.get("SO_ID"));
            paramMap.put("BDSS_ID", mapParam.get("BDSS_ID"));
            paramMap.put("BDSMW_HOUR", mapParam.get("BDSMW_HOUR"));
            //计算工资
            paramMap.put("BDSMW_WAGES", BigDecimalUtil.multiply(mapParam.get("BDSMW_HOUR"), post.get("BDSP_HOURLY_WAGE")));
            paramMap.put("BDSMW_MONTH", mapParam.get("BDSMW_MONTH"));

            if (isEmpty(id)) {
                id = getId();
                paramMap.put("ID", id);
                paramMap.put("SO_ID", operatorId);
                paramMap.put("BDSMW_ENRTY_TIME", getDate());
                paramMap.put("BUS_PROCESS", Process.DILIGENT.toString());
                paramMap.put("BUS_PROCESS2", Process.DILIGENT_STUDY_MONTH_WAGES.toString());

                baseDao.insert(NameSpace.DiligentStudyMapper, "insertDiligentStudyMonthWages", paramMap);

                //查询学生
                paramMap.clear();
                paramMap.put("ID", mapParam.get("BDSS_ID"));
                Map<String, Object> student = baseDao.selectOne(NameSpace.StudentMapper, "selectStudentByDiligentStudyStudentId", paramMap);

                //插入流程
                createProcessSchedule(id, toString(student.get("BS_NAME")),
                        operatorId, toString(student.get("SO_ID")), Process.DILIGENT.toString(), Process.DILIGENT_STUDY_MONTH_WAGES.toString());

                resultMap.put(MagicValue.LOG, "添加勤工助学月工资:" + formatColumnName(String.join(SERVICE_SPLIT, TableName.BUS_DILIGENT_STUDY_MONTH_WAGES), paramMap));
            } else {
                Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
                oldMap.put("ID", id);
                oldMap = this.selectDiligentStudyMonthWages(oldMap);

                baseDao.update(NameSpace.DiligentStudyMapper, "updateDiligentStudyMonthWages", paramMap);

                resultMap.put(MagicValue.LOG, "更新勤工助学月工资,更新前:" + formatColumnName(String.join(SERVICE_SPLIT, TableName.BUS_DILIGENT_STUDY_MONTH_WAGES), oldMap) +
                        ",更新后:" + formatColumnName(String.join(SERVICE_SPLIT, TableName.BUS_DILIGENT_STUDY_MONTH_WAGES), paramMap));
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
    public Map<String, Object> deleteDiligentStudyMonthWages(Map<String, Object> mapParam) {
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
            Map<String, Object> oldMap = this.selectDiligentStudyMonthWages(paramMap);

            //验证勤工助学状态
            validateProcessStatus(toString(oldMap.get("BDS_ID")), Process.DILIGENT.toString(), Process.DILIGENT_STUDY.toString());
            //验证自身流程
            validateProcessStatus(id, Process.DILIGENT.toString(), Process.DILIGENT_STUDY_MONTH_WAGES.toString());

            //删除勤工助学月工资
            paramMap.clear();
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_DILIGENT_STUDY_MONTH_WAGES);
            paramMap.put("ID", id);
            baseDao.delete(NameSpace.DiligentStudyMapper, "deleteDiligentStudyMonthWages", paramMap);

            //删除流程
            deleteProcessSchedule(id);
            resultMap.put(MagicValue.LOG, "删除勤工助学月工资,信息:" + formatColumnName(String.join(SERVICE_SPLIT, TableName.BUS_DILIGENT_STUDY_MONTH_WAGES), oldMap));
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
     * 导入勤工助学月工资
     *
     * @param excelFile
     * @return
     */
    @Override
    @Transactional
    public Map<String, Object> importDiligentStudyMonthWages(MultipartFile excelFile) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = IMPORT_ERROR;
        try {
            List<String[]> dataList = PoiUtil.readExcel(excelFile, 0, 1);
            //校验数据
            List<String[]> errorList = checkDiligentStudyMonthWagesExcelData(dataList);
            if (!isEmpty(errorList)) {
                resultMap.put(MagicValue.DATA, errorList);
                throw new CustomException("检测数据异常!");
            }

            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(6);

            //导入数据
            for (String[] data : dataList) {
                //岗位编号
                String BDSP_NUMBER = data[0];
                //学号
                String BS_NUMBER = data[1];
                //工作时长
                String BDSMW_HOUR = data[3];
                //月份
                String BDSMW_MONTH = data[6];

                //查询学生
                paramMap.clear();
                paramMap.put("BS_NUMBER", BS_NUMBER);
                Map<String, Object> student = baseDao.selectOne(NameSpace.StudentMapper, "selectStudent", paramMap);
                //查询岗位
                paramMap.clear();
                paramMap.put("BDSP_NUMBER", BDSP_NUMBER);
                Map<String, Object> post = baseDao.selectOne(NameSpace.DiligentStudyMapper, "selectDiligentStudyPost", paramMap);
                //根据岗位和学生信息找到勤工助学学生信息
                paramMap.clear();
                paramMap.put("BS_ID", student.get("ID"));
                paramMap.put("BDSP_ID", post.get("ID"));
                Map<String, Object> diligentStudent = this.selectDiligentStudyStudent(paramMap);

                paramMap.clear();
                paramMap.put("BDSS_ID", diligentStudent.get("ID"));
                paramMap.put("BDSMW_HOUR", BDSMW_HOUR);
                paramMap.put("BDSMW_MONTH", BDSMW_MONTH);

                Map<String, Object> diligentStudyMonthWages = this.insertAndUpdateDiligentStudyMonthWages(paramMap);
                validateResultMap(diligentStudyMonthWages);
            }

            resultMap.put(MagicValue.LOG, "导入勤工助学月工资数据,数据:" + toString(dataList));
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

    /**
     * 校验勤工助学月工资导入数据
     *
     * @param dataList
     * @return
     */
    public List<String[]> checkDiligentStudyMonthWagesExcelData(List<String[]> dataList) {
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
            //岗位编号
            String BDSP_NUMBER = data[0];
            //学号
            String BS_NUMBER = data[1];
            //工作时长
            String BDSMW_HOUR = data[3];
            //月份
            String BDSMW_MONTH = data[6];

            List<String[]> checkIsEmptyList = checkIsEmpty(row, data, new int[]{0, 1, 3, 6});
            if (!isEmpty(checkIsEmptyList)) {
                resultList.addAll(checkIsEmptyList);
                continue;
            }
            checkIsEmptyList = checkIsNumber(row, data, new int[]{3, 6});
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
                    //根据岗位和学生信息找到勤工助学学生信息
                    paramMap.clear();
                    paramMap.put("BS_ID", student.get("ID"));
                    paramMap.put("BDSP_ID", post.get("ID"));
                    Map<String, Object> diligentStudent = this.selectDiligentStudyStudent(paramMap);
                    if (isEmpty(diligentStudent)) {
                        resultList.add(packErrorData(row, "根据岗位和学号没有查询到该岗位下面的勤工助学学生信息"));
                    } else {
                        //检测月工资是否重复添加
                        paramMap.clear();
                        paramMap.put("BDSS_ID", diligentStudent.get("ID"));
                        paramMap.put("BDSMW_MONTH", BDSMW_MONTH);
                        int count = baseDao.selectOne(NameSpace.DiligentStudyMapper, "selectDiligentStudyMonthWagesCount", paramMap);
                        if (count > 0) {
                            resultList.add(packErrorData(row, "该岗位学生已经拥有相同月份工资记录"));
                        }
                    }
                }

            }
        }

        return resultList;
    }
}
