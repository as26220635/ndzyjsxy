package cn.kim.service.impl;

import cn.kim.common.attr.MagicValue;
import cn.kim.common.attr.TableName;
import cn.kim.common.eu.AidType;
import cn.kim.common.eu.NameSpace;
import cn.kim.common.eu.Process;
import cn.kim.dao.BaseDao;
import cn.kim.entity.ActiveUser;
import cn.kim.entity.DictInfo;
import cn.kim.entity.StudentYearSemester;
import cn.kim.exception.CustomException;
import cn.kim.service.AidFinanciallyService;
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

        ActiveUser activeUser = getActiveUser();
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(10);
            //记录表名
            List<String> tableNameList = Lists.newArrayList(TableName.BUS_AID_FINANCIALLY);

            String id = toString(mapParam.get("ID"));
            int BAF_TYPE = toInt(mapParam.get("BAF_TYPE"));


            paramMap.clear();
            paramMap.put("ID", mapParam.get("BS_ID"));
            Map<String, Object> student = baseDao.selectOne(NameSpace.StudentMapper, "selectStudent", paramMap);
            if (isEmpty(student)) {
                throw new CustomException("学生数据查询出错!");
            }
            //记录日志
            paramMap.clear();
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_AID_FINANCIALLY);

            paramMap.put("ID", id);
            paramMap.put("BS_ID", mapParam.get("BS_ID"));
            paramMap.put("BAF_YEAR", mapParam.get("BAF_YEAR"));
            paramMap.put("BAF_SEMESTER", mapParam.get("BAF_SEMESTER"));
            paramMap.put("BAF_AID_TYPE", mapParam.get("BAF_AID_TYPE"));
            paramMap.put("BAF_REDUCTION_QUOTA", mapParam.get("BAF_REDUCTION_QUOTA"));
            paramMap.put("BAF_DIFFICULTY_QUOTA", mapParam.get("BAF_DIFFICULTY_QUOTA"));
            paramMap.put("BUS_REMARKS", mapParam.get("BUS_REMARKS"));

            if (isEmpty(id)) {
                id = getId();
                paramMap.put("ID", id);
                paramMap.put("BAF_TYPE", mapParam.get("BAF_TYPE"));
                paramMap.put("BUS_PROCESS", mapParam.get("BUS_PROCESS"));
                paramMap.put("BUS_PROCESS2", mapParam.get("BUS_PROCESS2"));
                paramMap.put("SO_ID", getActiveUser().getId());
                paramMap.put("BAF_ENTRY_TIME", getDate());

                baseDao.insert(NameSpace.AidFinanciallyMapper, "insertAidFinancially", paramMap);

                if (BAF_TYPE == AidType.NATIONAL_SCHOLARSHIP.getType()) {
                    //国家奖学金
                    paramMap.clear();
                    paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_AID_NATIONAL_SCHOLARSHIP);

                    paramMap.put("ID", getId());
                    paramMap.put("BAF_ID", id);
                    paramMap.put("BANS_SCORE_RANK_TOTAL", mapParam.get("BANS_SCORE_RANK_TOTAL"));
                    paramMap.put("BANS_SCORE_RANK", mapParam.get("BANS_SCORE_RANK"));
                    paramMap.put("BANS_REQUIRED_COURSE_PASS_NUMBER", mapParam.get("BANS_REQUIRED_COURSE_PASS_NUMBER"));
                    paramMap.put("BANS_REQUIRED_COURSE_NUMBER", mapParam.get("BANS_REQUIRED_COURSE_NUMBER"));
                    paramMap.put("BANS_IS_COMPREHENSIVE_RANK", mapParam.get("BANS_IS_COMPREHENSIVE_RANK"));
                    paramMap.put("BANS_COMPREHENSIVE_RANK", toNull(mapParam.get("BANS_COMPREHENSIVE_RANK")));
                    paramMap.put("BANS_COMPREHENSIVE_RANK_NUMBER", toNull(mapParam.get("BANS_COMPREHENSIVE_RANK_NUMBER")));
                    paramMap.put("BANS_ACTUAL_AMOUNT", mapParam.get("BANS_ACTUAL_AMOUNT"));
                    paramMap.put("BANS_ISSUANCE_TIME", mapParam.get("BANS_ISSUANCE_TIME"));

                    baseDao.insert(NameSpace.AidFinanciallyMapper, "insertAidNationalScholarship", paramMap);

                    //子表
                    tableNameList.add(TableName.BUS_AID_NATIONAL_SCHOLARSHIP);
                } else if (BAF_TYPE == AidType.NATIONAL_GRANTS.getType()) {
                    //国家助学金
                    paramMap.clear();
                    paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_AID_NATIONAL_GRANTS);

                    paramMap.put("ID", getId());
                    paramMap.put("BAF_ID", id);
                    paramMap.put("BANG_FUNDING_STANDARDS", mapParam.get("BANG_FUNDING_STANDARDS"));
                    paramMap.put("BANG_AMOUNT_PAYABLE", mapParam.get("BANG_AMOUNT_PAYABLE"));
                    paramMap.put("BANG_ACTUAL_AMOUNT", mapParam.get("BANG_ACTUAL_AMOUNT"));
                    paramMap.put("BANG_APPLY_REASONS", mapParam.get("BANG_APPLY_REASONS"));
                    paramMap.put("BANG_ISSUANCE_TIME", mapParam.get("BANG_ISSUANCE_TIME"));

                    baseDao.insert(NameSpace.AidFinanciallyMapper, "insertAidNationalGrants", paramMap);

                    //子表
                    tableNameList.add(TableName.BUS_AID_NATIONAL_GRANTS);
                }

                //插入流程
                createProcessSchedule(id, toString(student.get("BS_NAME")),
                        activeUser.getId(), toString(student.get("SO_ID")), toString(mapParam.get("BUS_PROCESS")), toString(mapParam.get("BUS_PROCESS2")));

                resultMap.put(MagicValue.LOG, "添加资助:" + formatColumnName(String.join(SERVICE_SPLIT, tableNameList), paramMap));
            } else {
                Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
                oldMap.put("ID", id);
                oldMap = selectAidFinancially(oldMap);

                baseDao.update(NameSpace.AidFinanciallyMapper, "updateAidFinancially", paramMap);

                if (BAF_TYPE == AidType.NATIONAL_SCHOLARSHIP.getType()) {
                    //国家奖学金
                    paramMap.clear();
                    paramMap.put("BAF_ID", id);
                    Map<String, Object> nationalScholarship = this.selectNationalScholarship(paramMap);
                    paramMap.clear();
                    paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_AID_NATIONAL_SCHOLARSHIP);

                    paramMap.put("ID", nationalScholarship.get("ID"));
                    paramMap.put("BANS_SCORE_RANK_TOTAL", mapParam.get("BANS_SCORE_RANK_TOTAL"));
                    paramMap.put("BANS_SCORE_RANK", mapParam.get("BANS_SCORE_RANK"));
                    paramMap.put("BANS_REQUIRED_COURSE_PASS_NUMBER", mapParam.get("BANS_REQUIRED_COURSE_PASS_NUMBER"));
                    paramMap.put("BANS_REQUIRED_COURSE_NUMBER", mapParam.get("BANS_REQUIRED_COURSE_NUMBER"));
                    paramMap.put("BANS_IS_COMPREHENSIVE_RANK", mapParam.get("BANS_IS_COMPREHENSIVE_RANK"));
                    paramMap.put("BANS_COMPREHENSIVE_RANK", toNull(mapParam.get("BANS_COMPREHENSIVE_RANK")));
                    paramMap.put("BANS_COMPREHENSIVE_RANK_NUMBER", toNull(mapParam.get("BANS_COMPREHENSIVE_RANK_NUMBER")));
                    paramMap.put("BANS_ACTUAL_AMOUNT", mapParam.get("BANS_ACTUAL_AMOUNT"));
                    paramMap.put("BANS_ISSUANCE_TIME", mapParam.get("BANS_ISSUANCE_TIME"));

                    baseDao.update(NameSpace.AidFinanciallyMapper, "updateAidNationalScholarship", paramMap);

                    //子表
                    tableNameList.add(TableName.BUS_AID_NATIONAL_SCHOLARSHIP);
                    oldMap.putAll(removeMapId(nationalScholarship));
                } else if (BAF_TYPE == AidType.NATIONAL_GRANTS.getType()) {
                    //国家助学金
                    paramMap.clear();
                    paramMap.put("BAF_ID", id);
                    Map<String, Object> nationalGrants = this.selectNationalGrants(paramMap);
                    paramMap.clear();
                    paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_AID_NATIONAL_GRANTS);

                    paramMap.put("ID", nationalGrants.get("ID"));
                    paramMap.put("BANG_FUNDING_STANDARDS", mapParam.get("BANG_FUNDING_STANDARDS"));
                    paramMap.put("BANG_AMOUNT_PAYABLE", mapParam.get("BANG_AMOUNT_PAYABLE"));
                    paramMap.put("BANG_ACTUAL_AMOUNT", mapParam.get("BANG_ACTUAL_AMOUNT"));
                    paramMap.put("BANG_APPLY_REASONS", mapParam.get("BANG_APPLY_REASONS"));
                    paramMap.put("BANG_ISSUANCE_TIME", mapParam.get("BANG_ISSUANCE_TIME"));

                    baseDao.insert(NameSpace.AidFinanciallyMapper, "updateAidNationalGrants", paramMap);

                    //子表
                    tableNameList.add(TableName.BUS_AID_NATIONAL_GRANTS);
                    oldMap.putAll(removeMapId(nationalGrants));
                }

                resultMap.put(MagicValue.LOG, "更新资助,更新前:" + formatColumnName(String.join(SERVICE_SPLIT, tableNameList), oldMap) +
                        ",更新后:" + formatColumnName(String.join(SERVICE_SPLIT, tableNameList), paramMap));
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
            //记录表名
            List<String> tableNameList = Lists.newArrayList(TableName.BUS_AID_FINANCIALLY);

            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(2);
            String id = toString(mapParam.get("ID"));
            paramMap.clear();
            paramMap.put("ID", id);
            Map<String, Object> oldMap = selectAidFinancially(paramMap);
            //类型
            int BAF_TYPE = toInt(oldMap.get("BAF_TYPE"));

            //查询资助是否正在进行流程
            Map<String, Object> schedule = getProcessSchedule(id, toString(oldMap.get("BUS_PROCESS")), toString(oldMap.get("BUS_PROCESS2")));
            if (!isEmpty(schedule) && !isEmpty(schedule.get("SPS_AUDIT_STATUS")) && !"0".equals(toString(schedule.get("SPS_AUDIT_STATUS")))) {
                throw new CustomException("流程办理中不能删除!");
            }
            //先删除子表
            if (BAF_TYPE == AidType.NATIONAL_SCHOLARSHIP.getType()) {
                //国家奖学金
                paramMap.clear();
                paramMap.put("BAF_ID", id);
                Map<String, Object> nationalScholarship = this.selectNationalScholarship(paramMap);
                paramMap.clear();
                paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_AID_NATIONAL_SCHOLARSHIP);
                paramMap.put("ID", nationalScholarship.get("ID"));
                baseDao.delete(NameSpace.AidFinanciallyMapper, "deleteAidNationalScholarship", paramMap);

                //子表
                tableNameList.add(TableName.BUS_AID_NATIONAL_SCHOLARSHIP);
                oldMap.putAll(removeMapId(nationalScholarship));
            } else if (BAF_TYPE == AidType.NATIONAL_GRANTS.getType()) {
                //国家助学金
                paramMap.clear();
                paramMap.put("BAF_ID", id);
                Map<String, Object> nationalGrants = this.selectNationalGrants(paramMap);
                paramMap.clear();
                paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_AID_NATIONAL_GRANTS);
                paramMap.put("ID", nationalGrants.get("ID"));
                baseDao.delete(NameSpace.AidFinanciallyMapper, "deleteAidNationalGrants", paramMap);

                //子表
                tableNameList.add(TableName.BUS_AID_NATIONAL_GRANTS);
                oldMap.putAll(removeMapId(nationalGrants));
            }
            //删除资助
            paramMap.clear();
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_AID_FINANCIALLY);
            paramMap.put("ID", id);
            baseDao.delete(NameSpace.AidFinanciallyMapper, "deleteAidFinancially", paramMap);

            //删除流程
            deleteProcessSchedule(id);
            resultMap.put(MagicValue.LOG, "删除资助,信息:" + formatColumnName(String.join(SERVICE_SPLIT, tableNameList), oldMap));
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
     * 导入学院奖学金
     *
     * @param excelFile
     * @return
     */
    @Override
    @Transactional
    public Map<String, Object> importCollegeScholarship(MultipartFile excelFile) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = IMPORT_ERROR;
        try {

            List<String[]> dataList = importAid(resultMap, baseDao, excelFile, AidType.COLLEGE_SCHOLARSHIP, Process.AID, Process.AID_COLLEGE_SCHOLARSHIP, "BUS_COLLEGE_SCHOLARSHIP_TYPE");

            resultMap.put(MagicValue.LOG, "导入学院奖学金,数据:" + toString(dataList));
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
     * 导入年度表彰
     *
     * @param excelFile
     * @return
     */
    @Override
    @Transactional
    public Map<String, Object> importCommend(MultipartFile excelFile) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = IMPORT_ERROR;
        try {
            //导入
            List<String[]> dataList = importAid(resultMap, baseDao, excelFile, AidType.COMMEND, Process.AID, Process.AID_COMMEND, "BUS_COMMEND_TYPE");

            resultMap.put(MagicValue.LOG, "导入学院奖学金,数据:" + toString(dataList));
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
     * 导入绿色通道
     *
     * @param excelFile
     * @return
     */
    @Override
    @Transactional
    public Map<String, Object> importGreenChannel(MultipartFile excelFile) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = IMPORT_ERROR;
        try {
            //导入
            List<String[]> dataList = importAid(resultMap, baseDao, excelFile, AidType.GREEN_CHANNEL, Process.AID, Process.AID_GREEN_CHANNEL, null);

            resultMap.put(MagicValue.LOG, "导入绿色通道,数据:" + toString(dataList));
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
     * 导入减免学费
     *
     * @param excelFile
     * @return
     */
    @Override
    @Transactional
    public Map<String, Object> importTuitionWaiver(MultipartFile excelFile) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = IMPORT_ERROR;
        try {
            //导入
            List<String[]> dataList = importAid(resultMap, baseDao, excelFile, AidType.TUITION_WAIVER, Process.AID, Process.AID_TUITION_WAIVER, "BUS_TUITION_WAIVER");

            resultMap.put(MagicValue.LOG, "导入减免学费,数据:" + toString(dataList));
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
     * 导入困难毕业生就业补助
     *
     * @param excelFile
     * @return
     */
    @Override
    @Transactional
    public Map<String, Object> importJobseekerSupport(MultipartFile excelFile) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = IMPORT_ERROR;
        try {
            //导入
            List<String[]> dataList = importAid(resultMap, baseDao, excelFile, AidType.JOBSEEKER_SUPPORT, Process.AID, Process.AID_JOBSEEKER_SUPPORT, "BUS_DIFFICULTY_TYPE");

            resultMap.put(MagicValue.LOG, "导入困难毕业生就业补助,数据:" + toString(dataList));
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
     * 导入应急求助
     *
     * @param excelFile
     * @return
     */
    @Override
    @Transactional
    public Map<String, Object> importEmergencyHelp(MultipartFile excelFile) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = IMPORT_ERROR;
        try {
            //导入
            List<String[]> dataList = importAid(resultMap, baseDao, excelFile, AidType.EMERGENCY_HELP, Process.AID, Process.AID_EMERGENCY_HELP, "BUS_DIFFICULTY_TYPE");

            resultMap.put(MagicValue.LOG, "导入应急求助,数据:" + toString(dataList));
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
    public Map<String, Object> selectNationalScholarship(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("BAF_ID", mapParam.get("BAF_ID"));
        return baseDao.selectOne(NameSpace.AidFinanciallyMapper, "selectAidNationalScholarship", paramMap);
    }


    /**
     * 导入国家奖学金
     *
     * @param excelFile
     * @return
     */
    @Override
    @Transactional
    public Map<String, Object> importNationalScholarship(MultipartFile excelFile) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = IMPORT_ERROR;
        try {
            //导入
            List<String[]> dataList = importAid(resultMap, baseDao, excelFile, AidType.NATIONAL_SCHOLARSHIP, Process.AID, Process.AID_NATIONAL_SCHOLARSHIP, null);

            resultMap.put(MagicValue.LOG, "导入国家奖学金,数据:" + toString(dataList));
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
    public Map<String, Object> selectNationalGrants(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("BAF_ID", mapParam.get("BAF_ID"));
        return baseDao.selectOne(NameSpace.AidFinanciallyMapper, "selectAidNationalGrants", paramMap);
    }

    /**
     * 导入国家助学金
     *
     * @param excelFile
     * @return
     */
    @Override
    @Transactional
    public Map<String, Object> importNationalGrants(MultipartFile excelFile) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = IMPORT_ERROR;
        try {
            //导入
            List<String[]> dataList = importAid(resultMap, baseDao, excelFile, AidType.NATIONAL_GRANTS, Process.AID, Process.AID_NATIONAL_GRANTS, null);

            resultMap.put(MagicValue.LOG, "导入国家助学金,数据:" + toString(dataList));
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
    public Map<String, Object> selectNationalEndeavor(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("BAF_ID", mapParam.get("BAF_ID"));
        return baseDao.selectOne(NameSpace.AidFinanciallyMapper, "selectAidNationalScholarship", paramMap);
    }

    /**
     * 导入国家助学金
     *
     * @param excelFile
     * @return
     */
    @Override
    @Transactional
    public Map<String, Object> importNationalEndeavor(MultipartFile excelFile) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = IMPORT_ERROR;
        try {
            //导入
            List<String[]> dataList = importAid(resultMap, baseDao, excelFile, AidType.NATIONAL_ENDEAVOR, Process.AID, Process.AID_NATIONAL_ENDEAVOR, null);

            resultMap.put(MagicValue.LOG, "导入国家励志奖学金,数据:" + toString(dataList));
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
     * 获取导入学号
     *
     * @param data
     * @param aidType
     * @return
     */
    public String getImportStudentNumber(String[] data, AidType aidType) {
        //学号
        String BS_NUMBER = null;
        if (aidType == AidType.COLLEGE_SCHOLARSHIP || aidType == AidType.COMMEND) {
            BS_NUMBER = data[1];
        } else if (aidType == AidType.GREEN_CHANNEL || aidType == AidType.TUITION_WAIVER ||
                aidType == AidType.JOBSEEKER_SUPPORT || aidType == AidType.EMERGENCY_HELP ||
                aidType == AidType.NATIONAL_SCHOLARSHIP || aidType == AidType.NATIONAL_GRANTS ||
                aidType == AidType.NATIONAL_ENDEAVOR) {
            BS_NUMBER = data[2];
        }
        return BS_NUMBER;
    }

    /**
     * 获取导入奖励类型
     *
     * @param data
     * @param aidType
     * @return
     */
    public String getImportAidType(String[] data, AidType aidType) {
        //学号
        String BAF_AID_TYPE = null;
        if (aidType == AidType.COMMEND || aidType == AidType.COLLEGE_SCHOLARSHIP) {
            BAF_AID_TYPE = data[7];
        } else if (aidType == AidType.TUITION_WAIVER) {
            BAF_AID_TYPE = data[4];
        } else if (aidType == AidType.JOBSEEKER_SUPPORT || aidType == AidType.EMERGENCY_HELP) {
            BAF_AID_TYPE = data[5];
        }
        return BAF_AID_TYPE;
    }

    /**
     * 获取导入学年学期
     *
     * @param data
     * @param aidType
     * @return
     */
    public StudentYearSemester getImportStudentYearSemester(String[] data, AidType aidType) {
        //学年字段
        String YEAR_FIELD_DATA = null;
        if (aidType == AidType.GREEN_CHANNEL) {
            YEAR_FIELD_DATA = data[4];
        } else if (aidType == AidType.TUITION_WAIVER || aidType == AidType.JOBSEEKER_SUPPORT) {
            YEAR_FIELD_DATA = data[6];
        } else if (aidType == AidType.EMERGENCY_HELP) {
            YEAR_FIELD_DATA = data[7];
        } else if (aidType == AidType.COMMEND || aidType == AidType.COLLEGE_SCHOLARSHIP) {
            YEAR_FIELD_DATA = data.length >= 9 ? data[8] : null;
        } else if (aidType == AidType.NATIONAL_SCHOLARSHIP || aidType == AidType.NATIONAL_ENDEAVOR) {
            YEAR_FIELD_DATA = data[13];
        } else if (aidType == AidType.NATIONAL_GRANTS) {
            YEAR_FIELD_DATA = data[8];
        }

        //解析学年和学期
        StudentYearSemester studentYearSemester = null;
        if (aidType == AidType.COMMEND || aidType == AidType.GREEN_CHANNEL || aidType == AidType.NATIONAL_SCHOLARSHIP || aidType == AidType.NATIONAL_ENDEAVOR) {
            //只解析学年
            studentYearSemester = parseStudentYear(YEAR_FIELD_DATA);
        } else {
            studentYearSemester = parseStudentYearSemester(YEAR_FIELD_DATA);
        }

        return studentYearSemester;
    }

    /**
     * 获取减免金额
     *
     * @param data
     * @param aidType
     * @return
     */
    public String getImportReductionQuota(String[] data, AidType aidType) {
        //减免金额
        String BAF_REDUCTION_QUOTA = null;
        if (aidType == AidType.TUITION_WAIVER) {
            BAF_REDUCTION_QUOTA = data[5];
        }
        return BAF_REDUCTION_QUOTA;
    }

    /**
     * 获取困难补助金额
     *
     * @param data
     * @param aidType
     * @return
     */
    public String getImportDifficultyQuota(String[] data, AidType aidType) {
        //减免金额
        String BAF_DIFFICULTY_QUOTA = null;
        if (aidType == AidType.JOBSEEKER_SUPPORT || aidType == AidType.EMERGENCY_HELP) {
            BAF_DIFFICULTY_QUOTA = data[4];
        }
        return BAF_DIFFICULTY_QUOTA;
    }

    /**
     * 获取备注
     *
     * @param data
     * @param aidType
     * @return
     */
    public String getImportRemarks(String[] data, AidType aidType) {
        //获取备注
        String BUS_REMARKS = null;
        if (aidType == AidType.GREEN_CHANNEL) {
            BUS_REMARKS = data.length >= 6 ? data[5] : null;
        } else if (aidType == AidType.EMERGENCY_HELP || aidType == AidType.NATIONAL_SCHOLARSHIP || aidType == AidType.NATIONAL_ENDEAVOR) {
            BUS_REMARKS = data[6];
        } else if (aidType == AidType.NATIONAL_GRANTS) {
            BUS_REMARKS = data[10];
        }
        return BUS_REMARKS;
    }

    /**
     * 资助通用导入
     *
     * @param resultMap   返回map
     * @param baseDao
     * @param excelFile   导入的文件
     * @param aidType     资助类型
     * @param busProcess  流程小类
     * @param busProcess2 流程大类
     * @param sdtCode     字典code
     * @return
     * @throws Exception
     */
    private List<String[]> importAid(Map<String, Object> resultMap, BaseDao baseDao, MultipartFile excelFile, AidType aidType, Process busProcess, Process busProcess2, @Nullable String sdtCode) throws Exception {
        ActiveUser activeUser = getActiveUser();

        List<String[]> dataList = PoiUtil.readExcel(excelFile, 0, 1);
        //校验数据
        List<String[]> errorList = checkExcelData(dataList, aidType, sdtCode);
        if (!isEmpty(errorList)) {
            resultMap.put(MagicValue.DATA, errorList);
            throw new CustomException("检测数据异常!");
        }

        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(6);

        //导入数据
        for (String[] data : dataList) {
            //学号
            String BS_NUMBER = getImportStudentNumber(data, aidType);
            //奖项
            String BAF_AID_TYPE = getImportAidType(data, aidType);
            //学年字段
            //解析学年和学期
            StudentYearSemester studentYearSemester = getImportStudentYearSemester(data, aidType);
            String year = studentYearSemester.getYear();
            Integer semester = studentYearSemester.getSemester();

            //减免金额
            String BAF_REDUCTION_QUOTA = getImportReductionQuota(data, aidType);
            //补助金额
            String BAF_DIFFICULTY_QUOTA = getImportDifficultyQuota(data, aidType);

            //备注
            String BUS_REMARKS = getImportRemarks(data, aidType);

            paramMap.clear();
            paramMap.put("BS_NUMBER", BS_NUMBER);
            Map<String, Object> student = baseDao.selectOne(NameSpace.StudentMapper, "selectStudent", paramMap);
            if (isEmpty(student)) {
                throw new CustomException("学生数据查询出错!");
            }

            paramMap.clear();
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_AID_FINANCIALLY);

            paramMap.put("BS_ID", student.get("ID"));
            paramMap.put("BAF_YEAR", year);
            //学期
            if (aidType == AidType.COLLEGE_SCHOLARSHIP || aidType == AidType.EMERGENCY_HELP || aidType == AidType.NATIONAL_GRANTS) {
                paramMap.put("BAF_SEMESTER", semester);
            }
            //解析奖励类型
            if (aidType == AidType.COMMEND || aidType == AidType.COLLEGE_SCHOLARSHIP ||
                    aidType == AidType.TUITION_WAIVER || aidType == AidType.JOBSEEKER_SUPPORT ||
                    aidType == AidType.EMERGENCY_HELP) {
                paramMap.put("BAF_AID_TYPE", DictUtil.getDictCode(sdtCode, BAF_AID_TYPE));
            }
            paramMap.put("BAF_TYPE", aidType.toString());
            paramMap.put("SO_ID", activeUser.getId());
            paramMap.put("BUS_PROCESS", busProcess.toString());
            paramMap.put("BUS_PROCESS2", busProcess2.toString());
            paramMap.put("BAF_REDUCTION_QUOTA", BAF_REDUCTION_QUOTA);
            paramMap.put("BAF_DIFFICULTY_QUOTA", BAF_DIFFICULTY_QUOTA);
            paramMap.put("BUS_REMARKS", BUS_REMARKS);

            //导入子类
            if (aidType == AidType.NATIONAL_SCHOLARSHIP || aidType == AidType.NATIONAL_ENDEAVOR) {
                //国家奖学金 国家励志奖学金
                paramMap.put("BANS_SCORE_RANK_TOTAL", data[4]);
                paramMap.put("BANS_SCORE_RANK", data[5]);
                paramMap.put("BANS_REQUIRED_COURSE_PASS_NUMBER", data[7]);
                paramMap.put("BANS_REQUIRED_COURSE_NUMBER", data[8]);
                paramMap.put("BANS_IS_COMPREHENSIVE_RANK", DictUtil.getDictCode("SYS_YES_NO", data[9]));
                paramMap.put("BANS_COMPREHENSIVE_RANK", toNull(data[10]));
                paramMap.put("BANS_COMPREHENSIVE_RANK_NUMBER", toNull(data[11]));
                paramMap.put("BANS_ACTUAL_AMOUNT", data[12]);
                paramMap.put("BANS_ISSUANCE_TIME", data[14]);
            } else if (aidType == AidType.NATIONAL_GRANTS) {
                //国家助学金
                paramMap.put("BANG_FUNDING_STANDARDS", data[4]);
                paramMap.put("BANG_AMOUNT_PAYABLE", data[5]);
                paramMap.put("BANG_ACTUAL_AMOUNT", data[6]);
                paramMap.put("BANG_APPLY_REASONS", data[7]);
                paramMap.put("BANG_ISSUANCE_TIME", data[9]);
            }

            Map<String, Object> insertMap = this.insertAndUpdateAidFinancially(paramMap);
            validateResultMap(insertMap);
        }

        return dataList;
    }

    /**
     * 检测excel数据是否有问题
     *
     * @param dataList
     * @param aidType
     * @param sdtCode
     * @return
     */
    public List<String[]> checkExcelData(List<String[]> dataList, AidType aidType, @Nullable String sdtCode) {
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

            if (aidType == AidType.GREEN_CHANNEL) {
                if (data.length <= 4) {
                    resultList.add(packErrorData(row, "数据错误!"));
                    continue;
                }
            } else if (aidType == AidType.TUITION_WAIVER || aidType == AidType.JOBSEEKER_SUPPORT) {
                if (data.length <= 6) {
                    resultList.add(packErrorData(row, "数据错误!"));
                    continue;
                }
            } else if (aidType == AidType.NATIONAL_SCHOLARSHIP || aidType == AidType.NATIONAL_ENDEAVOR) {
                if (data.length <= 14) {
                    resultList.add(packErrorData(row, "数据错误!"));
                    continue;
                }
            } else if (aidType == AidType.NATIONAL_GRANTS) {
                if (data.length <= 10) {
                    resultList.add(packErrorData(row, "数据错误!"));
                    continue;
                }
            } else {
                if (data.length <= 7) {
                    resultList.add(packErrorData(row, "数据错误!"));
                    continue;
                }
            }

            //检测数据是否正确
            List<String[]> checkIsEmptyList = null;
            if (aidType == AidType.GREEN_CHANNEL) {
                checkIsEmptyList = checkIsEmpty(row, data, new int[]{2});
            } else if (aidType == AidType.TUITION_WAIVER) {
                checkIsEmptyList = checkIsEmpty(row, data, new int[]{2, 4, 5});
            } else if (aidType == AidType.COMMEND) {
                checkIsEmptyList = checkIsEmpty(row, data, new int[]{2, 7});
            } else if (aidType == AidType.JOBSEEKER_SUPPORT) {
                checkIsEmptyList = checkIsEmpty(row, data, new int[]{2, 4, 5});
            } else if (aidType == AidType.EMERGENCY_HELP) {
                checkIsEmptyList = checkIsEmpty(row, data, new int[]{2, 4, 5});
            } else if (aidType == AidType.NATIONAL_SCHOLARSHIP || aidType == AidType.NATIONAL_ENDEAVOR) {
                checkIsEmptyList = checkIsEmpty(row, data, new int[]{2, 4, 5, 7, 8, 9, 12, 13, 14});
            } else if (aidType == AidType.NATIONAL_GRANTS) {
                checkIsEmptyList = checkIsEmpty(row, data, new int[]{2, 4, 5, 6, 7, 8, 9});
            }
            if (!isEmpty(checkIsEmptyList)) {
                resultList.addAll(checkIsEmptyList);
                continue;
            } else {
                //检测是否为数字
                if (aidType == AidType.GREEN_CHANNEL) {
                    checkIsEmptyList = checkIsNumber(row, data, new int[]{2});
                } else if (aidType == AidType.TUITION_WAIVER) {
                    checkIsEmptyList = checkIsNumber(row, data, new int[]{2, 5});
                } else if (aidType == AidType.COMMEND) {
                    checkIsEmptyList = checkIsNumber(row, data, new int[]{2});
                } else if (aidType == AidType.JOBSEEKER_SUPPORT) {
                    checkIsEmptyList = checkIsNumber(row, data, new int[]{2, 4});
                } else if (aidType == AidType.EMERGENCY_HELP) {
                    checkIsEmptyList = checkIsNumber(row, data, new int[]{2, 4});
                } else if (aidType == AidType.NATIONAL_SCHOLARSHIP || aidType == AidType.NATIONAL_ENDEAVOR) {
                    checkIsEmptyList = checkIsNumber(row, data, new int[]{2, 4, 5, 7, 8, 12});
                } else if (aidType == AidType.NATIONAL_GRANTS) {
                    checkIsEmptyList = checkIsNumber(row, data, new int[]{4, 5, 6});
                }
                if (!isEmpty(checkIsEmptyList)) {
                    resultList.addAll(checkIsEmptyList);
                    continue;
                }
            }

            //学号
            String BS_NUMBER = getImportStudentNumber(data, aidType);
            //奖项
            String BAF_AID_TYPE = getImportAidType(data, aidType);
            //学年字段
            //解析学年和学期
            StudentYearSemester studentYearSemester = getImportStudentYearSemester(data, aidType);
            //学年
            String year = studentYearSemester.getYear();
            //学期
            Integer semester = studentYearSemester.getSemester();

            //减免金额
            String BAF_REDUCTION_QUOTA = getImportReductionQuota(data, aidType);
            if (aidType == AidType.TUITION_WAIVER) {
                if (isEmpty(BAF_REDUCTION_QUOTA) || !isNumber(BAF_REDUCTION_QUOTA)) {
                    resultList.add(packErrorData(row, "减免金额错误"));
                }
            }
            //补助金额
            String BAF_DIFFICULTY_QUOTA = getImportDifficultyQuota(data, aidType);
            if (aidType == AidType.JOBSEEKER_SUPPORT || aidType == AidType.EMERGENCY_HELP) {
                if (isEmpty(BAF_DIFFICULTY_QUOTA) || !isNumber(BAF_DIFFICULTY_QUOTA)) {
                    resultList.add(packErrorData(row, "补助金额错误"));
                }
            }

            //检测参数
            if (aidType == AidType.NATIONAL_SCHOLARSHIP || aidType == AidType.NATIONAL_ENDEAVOR) {
                //是否实行综合考评排名
                String BANS_IS_COMPREHENSIVE_RANK = DictUtil.getDictCode("SYS_YES_NO", data[9]);
                String BANS_COMPREHENSIVE_RANK = data[10];
                String BANS_COMPREHENSIVE_RANK_NUMBER = data[11];

                if (isEmpty(BANS_IS_COMPREHENSIVE_RANK) || !isNumber(BANS_IS_COMPREHENSIVE_RANK) ||
                        (toInt(BANS_IS_COMPREHENSIVE_RANK) != STATUS_SUCCESS && toInt(BANS_IS_COMPREHENSIVE_RANK) != STATUS_ERROR)) {
                    resultList.add(packErrorData(row, "是否实行综合考评排名参数错误"));
                } else if (toInt(BANS_IS_COMPREHENSIVE_RANK) == STATUS_SUCCESS) {
                    if (isEmpty(BANS_COMPREHENSIVE_RANK) || !isNumber(BANS_COMPREHENSIVE_RANK)) {
                        resultList.add(packErrorData(row, "综合考评排名名次参数错误"));
                    }
                    if (isEmpty(BANS_COMPREHENSIVE_RANK_NUMBER) || !isNumber(BANS_COMPREHENSIVE_RANK_NUMBER)) {
                        resultList.add(packErrorData(row, "综合考评排名总人数参数错误"));
                    }
                }

            }

            //判断奖励类型
            if (aidType == AidType.COMMEND || aidType == AidType.COLLEGE_SCHOLARSHIP ||
                    aidType == AidType.TUITION_WAIVER || aidType == AidType.JOBSEEKER_SUPPORT ||
                    aidType == AidType.EMERGENCY_HELP) {
                if (isEmpty(BAF_AID_TYPE)) {
                    resultList.add(packErrorData(row, "奖项为空"));
                } else {
                    DictInfo dictInfo = DictUtil.getDictInfo(sdtCode, BAF_AID_TYPE);
                    if (isEmpty(dictInfo)) {
                        resultList.add(packErrorData(row, "奖项数据错误,请检查"));
                    } else {
                        //校验额外信息
                        if (aidType == AidType.TUITION_WAIVER) {
                            //是否相等
                            if (new BigDecimal(BAF_REDUCTION_QUOTA).compareTo(new BigDecimal(dictInfo.getSdiRemark())) != 0) {
                                resultList.add(packErrorData(row, "减免金额:" + BAF_REDUCTION_QUOTA + "错误,正确对应金额:" + dictInfo.getSdiRemark()));
                            }
                        }
                    }
                }
            }

            if (isEmpty(BS_NUMBER)) {
                resultList.add(packErrorData(row, "学号为空"));
            } else {
                //查询数据库检查学号是否为空
                paramMap.clear();
                paramMap.put("BS_NUMBER", BS_NUMBER);
                Map<String, Object> student = baseDao.selectOne(NameSpace.StudentMapper, "selectStudent", paramMap);
                if (isEmpty(student)) {
                    resultList.add(packErrorData(row, "学号错误,没有找到对应的学生"));
                } else {
                    //查询综合素质评测
                    if (aidType == AidType.COMMEND || aidType == AidType.COLLEGE_SCHOLARSHIP) {
                        paramMap.clear();
                        paramMap.put("BS_ID", student.get("ID"));
                        paramMap.put("BSC_YEAR", year);

                        //学期 有的一年的没有学期
                        if (aidType == AidType.COLLEGE_SCHOLARSHIP || aidType == AidType.EMERGENCY_HELP) {
                            paramMap.put("BSC_SEMESTER", semester);
                        }

                        int count = baseDao.selectOne(NameSpace.StudentExtendMapper, "selectStudentComprehensiveCount", paramMap);
                        if (aidType == AidType.COMMEND) {
                            if (count < 2) {
                                resultList.add(packErrorData(row, "学生综合素质测评没有导入,请检查是否上下学期都导入"));
                            }
                        } else {
                            if (count == 0) {
                                resultList.add(packErrorData(row, "学生综合素质测评没有导入"));
                            }
                        }
                    }

                    //检测是否重复导入
                    paramMap.clear();
                    paramMap.put("BS_ID", student.get("ID"));
                    paramMap.put("BAF_TYPE", aidType.getType());
                    paramMap.put("BAF_YEAR", year);
                    if (aidType == AidType.COLLEGE_SCHOLARSHIP || aidType == AidType.EMERGENCY_HELP || aidType == AidType.NATIONAL_GRANTS) {
                        paramMap.put("BAF_SEMESTER", semester);
                    }

                    int count = baseDao.selectOne(NameSpace.AidFinanciallyMapper, "selectAidFinanciallyCount", paramMap);
                    if (count > 0) {
                        resultList.add(packErrorData(row, "数据重复导入"));
                    }
                }
            }
        }

        return resultList;
    }

    /**
     * 检测是否为空
     *
     * @param row        行
     * @param dataArray  数据
     * @param indexArray 检测位
     */
    private List<String[]> checkIsEmpty(String row, String[] dataArray, int[] indexArray) {
        List<String[]> checkIsEmptyList = Lists.newArrayList();
        for (int index : indexArray) {
            if (index > dataArray.length) {
                checkIsEmptyList.add(packErrorData(row, "数据错误"));
                break;
            }
            if (isEmpty(dataArray[index])) {
                checkIsEmptyList.add(packErrorData(row, (index + 1) + "列数据为空"));
            }
        }
        return checkIsEmptyList;
    }

    /**
     * 检测参数是否是数字
     *
     * @param row
     * @param dataArray
     * @param indexArray
     * @return
     */
    private List<String[]> checkIsNumber(String row, String[] dataArray, int[] indexArray) {
        List<String[]> checkIsEmptyList = Lists.newArrayList();
        for (int index : indexArray) {
            if (!isNumber(dataArray[index])) {
                checkIsEmptyList.add(packErrorData(row, (index + 1) + "列数据不是为数字类型"));
            }
        }
        return checkIsEmptyList;
    }
}
