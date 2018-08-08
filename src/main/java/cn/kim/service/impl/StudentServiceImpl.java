package cn.kim.service.impl;

import cn.kim.common.attr.Constants;
import cn.kim.common.attr.MagicValue;
import cn.kim.common.attr.TableName;
import cn.kim.common.eu.NameSpace;
import cn.kim.common.eu.SystemEnum;
import cn.kim.entity.DataTablesView;
import cn.kim.entity.QuerySet;
import cn.kim.entity.Tree;
import cn.kim.entity.TreeState;
import cn.kim.exception.CustomException;
import cn.kim.service.StudentService;
import cn.kim.util.CommonUtil;
import cn.kim.util.PasswordMd5;
import cn.kim.util.RandomSalt;
import com.google.common.collect.Maps;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/8/7
 * 学生管理
 */
@Service
public class StudentServiceImpl extends BaseServiceImpl implements StudentService {

    @Override
    public DataTablesView<?> selectStudentDataTablesView(Map<String, Object> mapParam) {
        DataTablesView<Map<String, Object>> dataTablesView = new DataTablesView<>();
        QuerySet querySet = new QuerySet();

        //学生姓名
        if (!isEmpty(mapParam.get("BS_NAME"))) {
            querySet.set(QuerySet.LIKE, "BS_NAME", mapParam.get("BS_NAME"));
        }

        //学号
        if (!isEmpty(mapParam.get("BS_NUMBER"))) {
            querySet.set(QuerySet.LIKE, "BS_NUMBER", mapParam.get("BS_NUMBER"));
        }

        //身份证
        if (!isEmpty(mapParam.get("BS_ID_CARD"))) {
            querySet.set(QuerySet.LIKE, "BS_ID_CARD", mapParam.get("BS_ID_CARD"));
        }

        int offset = toInt(mapParam.get("start"));
        int limit = toInt(mapParam.get("length"));

        if (limit != -1) {
            querySet.setOffset(offset);
            querySet.setLimit(limit);
        }
        querySet.setOrderByClause("CONVERT(ID,SIGNED) DESC");

        long count = baseDao.selectOne(NameSpace.StudentMapper, "selectStudentCount", querySet.getWhereMap());
        dataTablesView.setRecordsTotal(count);
        if (limit != -1) {
            dataTablesView.setTotalPages(CommonUtil.getPage(count, limit));
        }

        List<Map<String, Object>> dataList = baseDao.selectList(NameSpace.StudentMapper, "selectStudent", querySet.getWhereMap());
        dataTablesView.setData(dataList);

        return dataTablesView;
    }

    @Override
    public Map<String, Object> selectStudent(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("ID", mapParam.get("ID"));
        return baseDao.selectOne(NameSpace.StudentMapper, "selectStudent", paramMap);
    }

    @Override
    @Transactional
    public Map<String, Object> insertAndUpdateStudent(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(10);
            String id = toString(mapParam.get("ID"));
            //记录日志
            paramMap.put("SVR_TABLE_NAME", TableName.BUS_STUDENT);

            paramMap.put("ID", id);
            paramMap.put("SO_ID", mapParam.get("SO_ID"));
            paramMap.put("BDM_ID", mapParam.get("BDM_ID"));
            paramMap.put("BC_ID", mapParam.get("BC_ID"));
            paramMap.put("BS_NAME", mapParam.get("BS_NAME"));
            paramMap.put("BS_NUMBER", mapParam.get("BS_NUMBER"));
            paramMap.put("BS_LENGTH", mapParam.get("BS_LENGTH"));
            paramMap.put("BS_ENROLMENT_YEAR", mapParam.get("BS_ENROLMENT_YEAR"));
            paramMap.put("BS_EXAMINEE_NUMBER", mapParam.get("BS_EXAMINEE_NUMBER"));
            paramMap.put("BS_ID_CARD", mapParam.get("BS_ID_CARD"));
            paramMap.put("BS_SEX", mapParam.get("BS_SEX"));
            paramMap.put("BS_NATION", mapParam.get("BS_NATION"));
            paramMap.put("BS_BANK", mapParam.get("BS_BANK"));
            paramMap.put("BS_BANK_CARD", mapParam.get("BS_BANK_CARD"));
            paramMap.put("BS_PHONE", mapParam.get("BS_PHONE"));
            paramMap.put("BS_PERMANENT_ADDRESS", mapParam.get("BS_PERMANENT_ADDRESS"));
            paramMap.put("BS_HOME_ADDRESS", mapParam.get("BS_HOME_ADDRESS"));

            if (isEmpty(id)) {
                id = getId();
                paramMap.put("ID", id);
                paramMap.put("BS_ENTRY_TIME", getDate());
                //插入账号和账号信息
                String operatorId = insertOperator(baseDao, mapParam.get("BS_NAME"), SystemEnum.STUDENT.getType());
                paramMap.put("SO_ID", operatorId);

                baseDao.insert(NameSpace.StudentMapper, "insertStudent", paramMap);
                resultMap.put(MagicValue.LOG, "添加学生:" + toString(paramMap));
            } else {
                Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
                oldMap.put("ID", id);
                oldMap = selectStudent(oldMap);

                baseDao.update(NameSpace.StudentMapper, "updateStudent", paramMap);
                resultMap.put(MagicValue.LOG, "更新学生,更新前:" + toString(oldMap) + ",更新后:" + toString(paramMap));
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
    public Map<String, Object> deleteStudent(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = DELETE_ERROR;
        try {
            if (isEmpty(mapParam.get("ID"))) {
                throw new CustomException("ID不能为空!");
            }
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
            String id = toString(mapParam.get("ID"));

            //删除学生表
            paramMap.clear();
            paramMap.put("ID", id);
            Map<String, Object> oldMap = selectStudent(paramMap);
            //记录日志
            paramMap.put("SVR_TABLE_NAME", TableName.BUS_STUDENT);
            baseDao.delete(NameSpace.StudentMapper, "deleteStudent", paramMap);

            resultMap.put(MagicValue.LOG, "删除学生,信息:" + toString(oldMap));
            status = STATUS_SUCCESS;
            desc = DELETE_SUCCESS;
        } catch (Exception e) {
            desc = catchException(e, baseDao, resultMap);
        }
        resultMap.put(MagicValue.STATUS, status);
        resultMap.put(MagicValue.DESC, desc);
        return resultMap;
    }

    /***********    学生考勤    *********/

    @Override
    public Map<String, Object> selectStudentAttendance(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("ID", mapParam.get("ID"));
        return baseDao.selectOne(NameSpace.StudentExtendMapper, "selectStudentAttendance", paramMap);
    }

    @Override
    @Transactional
    public Map<String, Object> insertAndUpdateStudentAttendance(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(10);
            String id = toString(mapParam.get("ID"));

            paramMap.put("BS_ID", mapParam.get("BS_ID"));
            paramMap.put("BSA_YEAR", mapParam.get("BSA_YEAR"));
            paramMap.put("BSA_SEMESTER", mapParam.get("BSA_SEMESTER"));
            paramMap.put("BSA_WEEK", mapParam.get("BSA_WEEK"));
            paramMap.put("BSA_LATE", mapParam.get("BSA_LATE"));
            paramMap.put("BSA_ABSENTEEISM", mapParam.get("BSA_ABSENTEEISM"));
            paramMap.put("BSA_ENTRY_TIME", mapParam.get("BSA_ENTRY_TIME"));

            if (isEmpty(id)) {
                id = getId();
                paramMap.put("ID", id);
                paramMap.put("BSA_ENTRY_TIME", getDate());

                baseDao.insert(NameSpace.StudentExtendMapper, "insertStudentAttendance", paramMap);
                resultMap.put(MagicValue.LOG, "添加学生考勤:" + toString(paramMap));
            } else {
                Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
                oldMap.put("ID", id);
                oldMap = selectStudentAttendance(oldMap);

                baseDao.update(NameSpace.StudentExtendMapper, "updateStudentAttendance", paramMap);
                resultMap.put(MagicValue.LOG, "更新学生考勤,更新前:" + toString(oldMap) + ",更新后:" + toString(paramMap));
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
    public Map<String, Object> deleteStudentAttendance(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = DELETE_ERROR;
        try {
            if (isEmpty(mapParam.get("ID"))) {
                throw new CustomException("ID不能为空!");
            }
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
            String id = toString(mapParam.get("ID"));

            //删除学生考勤表
            paramMap.clear();
            paramMap.put("ID", id);
            Map<String, Object> oldMap = selectStudentAttendance(paramMap);

            baseDao.delete(NameSpace.StudentExtendMapper, "deleteStudentAttendance", paramMap);

            resultMap.put(MagicValue.LOG, "删除学生考勤,信息:" + toString(oldMap));
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
