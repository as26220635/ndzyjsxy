package cn.kim.service.impl;

import cn.kim.common.attr.MagicValue;
import cn.kim.common.attr.TableName;
import cn.kim.common.eu.NameSpace;
import cn.kim.common.eu.SystemEnum;
import cn.kim.exception.CustomException;
import cn.kim.service.TeacherService;
import cn.kim.util.PasswordMd5;
import cn.kim.util.RandomSalt;
import com.google.common.collect.Maps;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/8/6
 * 教师管理
 */
@Service
public class TeacherServiceImpl extends BaseServiceImpl implements TeacherService {

    @Override
    public Map<String, Object> selectTeacher(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("ID", mapParam.get("ID"));
        return baseDao.selectOne(NameSpace.TeacherMapper, "selectTeacher", paramMap);
    }

    @Override
    @Transactional
    public Map<String, Object> insertAndUpdateTeacher(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(10);
            String id = toString(mapParam.get("ID"));
            //记录日志
            paramMap.put("SVR_TABLE_NAME", TableName.BUS_TEACHER);

            paramMap.put("ID", id);
            paramMap.put("BDM_ID", mapParam.get("BDM_ID"));
            paramMap.put("BT_NAME", mapParam.get("BT_NAME"));
            paramMap.put("BT_NUMBER", mapParam.get("BT_NUMBER"));

            if (isEmpty(id)) {
                id = getId();
                paramMap.put("ID", id);
                paramMap.put("BT_ENTRY_TIME", getDate());

                //插入账号和账号信息
                String operatorId = getId();
                paramMap.put("SO_ID", operatorId);

                //插入账号和账号信息
                Map<String, Object> operatorMap = Maps.newHashMapWithExpectedSize(10);
                operatorMap.put("SVR_TABLE_NAME", TableName.SYS_OPERATOR);
                operatorMap.put("ID", operatorId);
                //设置账号和盐
                String salt = RandomSalt.salt();
                operatorMap.put("SO_SALT", salt);
                operatorMap.put("SO_PASSWORD", PasswordMd5.password("123456", salt));
                operatorMap.put("IS_STATUS", STATUS_SUCCESS);
                baseDao.insert(NameSpace.OperatorMapper, "insertOperator", operatorMap);

                //添加accountinfo表
                operatorMap.clear();
                operatorMap.put("SVR_TABLE_NAME", TableName.SYS_ACCOUNT_INFO);
                operatorMap.put("ID", getId());
                operatorMap.put("SO_ID", operatorId);
                operatorMap.put("SAI_NAME", mapParam.get("BT_NAME"));
                operatorMap.put("SAI_TYPE", SystemEnum.TEACHER.getType());
                baseDao.insert(NameSpace.OperatorMapper, "insertAccountInfo", operatorMap);

                baseDao.insert(NameSpace.TeacherMapper, "insertTeacher", paramMap);
                resultMap.put(MagicValue.LOG, "添加教师:" + toString(paramMap));
            } else {
                Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
                oldMap.put("ID", id);
                oldMap = selectTeacher(oldMap);

                baseDao.update(NameSpace.TeacherMapper, "updateTeacher", paramMap);
                resultMap.put(MagicValue.LOG, "更新教师,更新前:" + toString(oldMap) + ",更新后:" + toString(paramMap));
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
    public Map<String, Object> deleteTeacher(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = DELETE_ERROR;
        try {
            if (isEmpty(mapParam.get("ID"))) {
                throw new CustomException("ID不能为空!");
            }
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
            String id = toString(mapParam.get("ID"));

            //删除教师表
            paramMap.clear();
            paramMap.put("ID", id);
            Map<String, Object> oldMap = selectTeacher(paramMap);
            //记录日志
            paramMap.put("SVR_TABLE_NAME", TableName.BUS_TEACHER);
            baseDao.delete(NameSpace.TeacherMapper, "deleteTeacher", paramMap);

            resultMap.put(MagicValue.LOG, "删除教师,信息:" + toString(oldMap));
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