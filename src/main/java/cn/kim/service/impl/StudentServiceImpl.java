package cn.kim.service.impl;

import cn.kim.common.attr.Constants;
import cn.kim.common.attr.MagicValue;
import cn.kim.common.attr.TableName;
import cn.kim.common.attr.Tips;
import cn.kim.common.eu.*;
import cn.kim.common.eu.Process;
import cn.kim.dao.BaseDao;
import cn.kim.entity.*;
import cn.kim.exception.CustomException;
import cn.kim.service.StudentService;
import cn.kim.tools.ExportExcelTool;
import cn.kim.util.*;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.google.common.collect.Sets;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.*;

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

        querySet.setOffset(offset);
        querySet.setLimit(limit);

        querySet.setOrderByClause("CONVERT(ID,SIGNED) DESC");

        long count = baseDao.selectOne(NameSpace.StudentMapper, "selectStudentCount", querySet.getWhereMap());
        dataTablesView.setRecordsTotal(count);
        dataTablesView.setTotalPages(CommonUtil.getPage(count, limit));

        System.out.println(toString(querySet.getWhereMap()));
        List<Map<String, Object>> dataList = baseDao.selectList(NameSpace.StudentMapper, "selectStudentList", querySet.getWhereMap());
        dataTablesView.setData(dataList);

        return dataTablesView;
    }

    @Override
    public Map<String, Object> selectStudent(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(2);
        paramMap.put("ID", mapParam.get("ID"));
        paramMap.put("BS_NUMBER", mapParam.get("BS_NUMBER"));
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
            //学号
            String studentNumber = toString(mapParam.get("BS_NUMBER"));
            //验证学号 身份证 手机号是否重复
            paramMap.clear();
            paramMap.put("NOT_ID", id);
            paramMap.put("BS_NUMBER", studentNumber);
            int count = baseDao.selectOne(NameSpace.StudentMapper, "selectStudentCheckCount", paramMap);
            if (count > 0) {
                throw new CustomException("学号重复!");
            }
            if (!isEmpty(mapParam.get("BS_ID_CARD"))) {
                paramMap.clear();
                paramMap.put("NOT_ID", id);
                paramMap.put("BS_ID_CARD", mapParam.get("BS_ID_CARD"));
                count = baseDao.selectOne(NameSpace.StudentMapper, "selectStudentCheckCount", paramMap);
                if (count > 0) {
                    throw new CustomException("身份证重复!");
                }
            }
            if (!isEmpty(mapParam.get("BS_PHONE"))) {
                paramMap.clear();
                paramMap.put("NOT_ID", id);
                paramMap.put("BS_PHONE", mapParam.get("BS_PHONE"));
                count = baseDao.selectOne(NameSpace.StudentMapper, "selectStudentCheckCount", paramMap);
                if (count > 0) {
                    throw new CustomException("电话号码重复!");
                }
            }
            //记录日志
            paramMap.clear();
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_STUDENT);

            paramMap.put("ID", id);
            paramMap.put("SO_ID", mapParam.get("SO_ID"));
            paramMap.put("BDM_ID", mapParam.get("BDM_ID"));
            paramMap.put("BC_ID", mapParam.get("BC_ID"));
            paramMap.put("BS_NAME", mapParam.get("BS_NAME"));
            paramMap.put("BS_NUMBER", studentNumber);
            paramMap.put("BS_LENGTH", mapParam.get("BS_LENGTH"));
            paramMap.put("BS_ENROLMENT", mapParam.get("BS_ENROLMENT"));
            paramMap.put("BS_EXAMINEE_NUMBER", mapParam.get("BS_EXAMINEE_NUMBER"));
            paramMap.put("BS_ID_CARD", mapParam.get("BS_ID_CARD"));
            paramMap.put("BS_SEX", mapParam.get("BS_SEX"));
            paramMap.put("BS_NATION", mapParam.get("BS_NATION"));
            paramMap.put("BS_BANK", mapParam.get("BS_BANK"));
            paramMap.put("BS_BANK_CARD", mapParam.get("BS_BANK_CARD"));
            paramMap.put("BS_PHONE", mapParam.get("BS_PHONE"));
            paramMap.put("BS_PERMANENT_ADDRESS", mapParam.get("BS_PERMANENT_ADDRESS"));
            paramMap.put("BS_HOME_ADDRESS", mapParam.get("BS_HOME_ADDRESS"));
            paramMap.put("BS_EDUCATION", mapParam.get("BS_EDUCATION"));
            paramMap.put("BS_POLITICAL_OUTLOOK", mapParam.get("BS_POLITICAL_OUTLOOK"));
            paramMap.put("BS_BIRTH_DATE", mapParam.get("BS_BIRTH_DATE"));
            paramMap.put("BS_STATUS", mapParam.get("BS_STATUS"));

            if (isEmpty(id)) {
                id = getId();
                paramMap.put("ID", id);
                paramMap.put("BS_ENTRY_TIME", getDate());
                //插入账号和账号信息
                String operatorId = insertOperator(baseDao, SystemEnum.STUDENT.getType(), id, mapParam.get("BS_NAME"), mapParam.get("BS_PHONE"), null);
                //插入登入账号
                insertOperatorSub(baseDao, operatorId, studentNumber);
                //插入角色
                insertOperatorRole(baseDao, operatorId, RoleCode.STUDENT.getType());

                paramMap.put("SO_ID", operatorId);

                baseDao.insert(NameSpace.StudentMapper, "insertStudent", paramMap);
                resultMap.put(MagicValue.LOG, "添加学生:" + formatColumnName(TableName.BUS_STUDENT, paramMap));
            } else {
                Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
                oldMap.put("ID", id);
                oldMap = selectStudent(oldMap);

                baseDao.update(NameSpace.StudentMapper, "updateStudent", paramMap);
                resultMap.put(MagicValue.LOG, "更新学生,更新前:" + formatColumnName(TableName.BUS_STUDENT, oldMap) + ",更新后:" + formatColumnName(TableName.BUS_STUDENT, paramMap));
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
                throw new CustomException(Tips.ID_NULL_ERROR);
            }
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
            String id = toString(mapParam.get("ID"));

            //删除学生表
            paramMap.clear();
            paramMap.put("ID", id);
            Map<String, Object> oldMap = selectStudent(paramMap);
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_STUDENT);
            baseDao.delete(NameSpace.StudentMapper, "deleteStudent", paramMap);

            resultMap.put(MagicValue.LOG, "删除学生,信息:" + formatColumnName(TableName.BUS_STUDENT, oldMap));
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
    public List<Map<String, Object>> importQueryStudent(MultipartFile excelFile) throws Exception {
        List<Map<String, Object>> resultList = Lists.newLinkedList();
        //读取ecel
        List<String[]> dataList = PoiUtil.readExcel(excelFile, 0, 2);

        if (!isEmpty(dataList)) {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);

            for (String[] datas : dataList) {
                if (datas.length > 0) {
                    //导入查询信息（可为学号、姓名或身份证之一）
                    String condition = datas[0];
                    if (!isEmpty(condition) && condition.length() <= 18) {
                        //查询学生
                        paramMap.clear();
                        paramMap.put("IMPORT_QUERY_CONDITION", condition);
                        //加上自定义过滤
                        paramMap.put("whereClause", getAuthorizationWhere());
                        List<Map<String, Object>> studentList = baseDao.selectList(NameSpace.StudentMapper, "selectStudent", paramMap);
                        //没有找到记录插入一条查询失败记录
                        if (isEmpty(studentList)) {
                            studentList = Lists.newArrayList();
                            Map<String, Object> errorMap = Maps.newHashMapWithExpectedSize(6);
                            errorMap.put("BDM_NAME", "???");
                            errorMap.put("BC_MAJOR_NAME", "???");
                            errorMap.put("BC_NAME", "???");
                            errorMap.put("BS_NUMBER", "???");
                            errorMap.put("BS_NAME", "???");
                            errorMap.put("BS_ID_CARD", "???");
                            studentList.add(errorMap);
                        }
                        //转换成excel导出格式
                        FuncUtil.forEach(studentList, (index, student) -> {
                            Map<String, Object> excelMap = Maps.newHashMapWithExpectedSize(9);

                            String BDM_NAME = toString(student.get("BDM_NAME"));
                            String BC_MAJOR_NAME = toString(student.get("BC_MAJOR_NAME"));
                            String BC_NAME = toString(student.get("BC_NAME"));
                            String BS_NUMBER = toString(student.get("BS_NUMBER"));
                            String BS_NAME = toString(student.get("BS_NAME"));
                            String BS_ID_CARD = toString(student.get("BS_ID_CARD"));
                            String CONTRAST_RESULTS = "";
                            //背景颜色
                            short backGroundIndex = IndexedColors.YELLOW.getIndex();
                            if (condition.equals(BS_NUMBER)) {
                                CONTRAST_RESULTS = "同学号";
                                excelMap.put("BS_NUMBER" + ExportExcelTool.BACKGROUND, IndexedColors.YELLOW.getIndex());
                            } else if (condition.equals(BS_NAME)) {
                                CONTRAST_RESULTS = "同名";
                                excelMap.put("BS_NAME" + ExportExcelTool.BACKGROUND, IndexedColors.YELLOW.getIndex());
                            } else if (condition.equals(BS_ID_CARD)) {
                                CONTRAST_RESULTS = "同身份证";
                                excelMap.put("BS_ID_CARD" + ExportExcelTool.BACKGROUND, IndexedColors.YELLOW.getIndex());
                            } else {
                                CONTRAST_RESULTS = "查询失败";
                                backGroundIndex = IndexedColors.CORNFLOWER_BLUE.getIndex();
                            }

                            //条件
                            if (index == 0) {
                                excelMap.put("CONDITION", condition);
                            }
                            //系
                            excelMap.put("BDM_NAME", BDM_NAME);
                            //专业
                            excelMap.put("BC_MAJOR_NAME", BC_MAJOR_NAME);
                            //班级
                            excelMap.put("BC_NAME", BC_NAME);
                            //学号
                            excelMap.put("BS_NUMBER", BS_NUMBER);
                            //姓名
                            excelMap.put("BS_NAME", BS_NAME);
                            //身份证
                            excelMap.put("BS_ID_CARD", BS_ID_CARD);
                            //对比结果
                            excelMap.put("CONTRAST_RESULTS", CONTRAST_RESULTS);
                            excelMap.put("CONTRAST_RESULTS" + ExportExcelTool.BACKGROUND, backGroundIndex);
                            //查询失败全部变成蓝色
                            if (backGroundIndex == IndexedColors.CORNFLOWER_BLUE.getIndex()) {
                                Set<String> keySet = Sets.newHashSet(excelMap.keySet());
                                keySet.forEach(key -> {
                                    if (!"CONDITION".equals(key)) {
                                        excelMap.put(key + ExportExcelTool.BACKGROUND, IndexedColors.CORNFLOWER_BLUE.getIndex());
                                    }
                                });
                            }

                            resultList.add(excelMap);
                        });
                    }
                }
            }
        }

        return resultList;
    }

    @Override
    @Transactional
    public Map<String, Object> importStudent(MultipartFile excelFile) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = IMPORT_ERROR;
        try {
            List<String[]> dataList = PoiUtil.readExcel(excelFile, 0, 1);
            //校验数据
            List<String[]> errorList = this.checkStudentExcelData(dataList);
            if (!isEmpty(errorList)) {
                resultMap.put(MagicValue.DATA, errorList);
                throw new CustomException("检测数据异常!");
            }

            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(16);

            //导入数据
            for (String[] data : dataList) {
                //学院
                String BDM_COLLEGE = data[0];
                //系
                String BDM_NAME = data[1];
                //专业
                String BC_MAJOR = data[2];
                //班级
                String BC_NAME = data[3];
                //学号
                String BS_NUMBER = data[4];
                //姓名
                String BS_NAME = data[5];
                //状态
                String BS_STATUS = data[6];
                //身份证号
                String BS_ID_CARD = data[7];
                //攻读学历
                String BS_EDUCATION = data[8];
                //学制
                String BS_LENGTH = data[9];
                //入学日期
                String BS_ENROLMENT = data[10];
                //银行卡号
                String BS_BANK_CARD = data[11];
                //政治面貌
                String BS_POLITICAL_OUTLOOK = data[12];
                //民族
                String BS_NATION = data[13];
                //手机号
                String BS_PHONE = data[14];
                //户籍所在地地址
                String BS_PERMANENT_ADDRESS = data[15];
                //现家庭住址
                String BS_HOME_ADDRESS = data[16];


                //查询系部
                paramMap.clear();
                paramMap.put("BDM_NAME", BDM_NAME);
                Map<String, Object> department = baseDao.selectOne(NameSpace.DepartmentMapper, "selectDepartment", paramMap);
                //查询班级
                paramMap.clear();
                paramMap.put("BC_NAME", BC_NAME);
                Map<String, Object> cls = baseDao.selectOne(NameSpace.ClsMapper, "selectClass", paramMap);

                paramMap.clear();
                paramMap.put("BDM_ID", department.get("ID"));
                paramMap.put("BC_ID", cls.get("ID"));
                paramMap.put("BS_NAME", BS_NAME);
                paramMap.put("BS_NUMBER", BS_NUMBER);
                paramMap.put("BS_LENGTH", DictUtil.getDictCode("BUS_COLLEGE_LENGTH", BS_LENGTH));
                paramMap.put("BS_ENROLMENT", DateUtil.dateToDate(BS_ENROLMENT, DateUtil.FORMAT3, DateUtil.FORMAT2));
                paramMap.put("BS_ID_CARD", BS_ID_CARD);
                paramMap.put("BS_SEX", IdCardUtil.getGenderByIdCard(BS_ID_CARD));
                paramMap.put("BS_BIRTH_DATE", IdCardUtil.getBirthByIdCard(BS_ID_CARD));
                paramMap.put("BS_NATION", DictUtil.getDictCode("BUS_NATION", BS_NATION));
                paramMap.put("BS_BANK_CARD", BS_BANK_CARD);
                paramMap.put("BS_PHONE", BS_PHONE);
                paramMap.put("BS_PERMANENT_ADDRESS", BS_PERMANENT_ADDRESS);
                paramMap.put("BS_HOME_ADDRESS", BS_HOME_ADDRESS);
                paramMap.put("BS_EDUCATION", DictUtil.getDictCode("BUS_EDUCATION", BS_EDUCATION));
                paramMap.put("BS_POLITICAL_OUTLOOK", DictUtil.getDictCode("BUS_POLITICAL_OUTLOOK", BS_POLITICAL_OUTLOOK));
                paramMap.put("BS_STATUS", DictUtil.getDictCode("BUS_STUDENT_STATUS", BS_STATUS));

                Map<String, Object> studentResultMap = this.insertAndUpdateStudent(paramMap);
                //校验
                validateResultMap(studentResultMap);
            }

            resultMap.put(MagicValue.LOG, "导入学生信息,数据:" + listToString(dataList));
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
     * 检测导入数据
     *
     * @param dataList
     * @return
     */
    public List<String[]> checkStudentExcelData(List<String[]> dataList) {
        List<String[]> resultList = Lists.newArrayList();

        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(3);

        if (isEmpty(dataList)) {
            resultList.add(packErrorData("文件数据错误", "没有找到可以导入数据"));
            return resultList;
        }

        for (int i = 0; i < dataList.size(); i++) {
            //行
            String row = joinRowStr(i + 2);

            String[] data = dataList.get(i);
            if (data.length < 16) {
                resultList.add(packErrorData(row, "数据错误列数应为17列,当前为" + (data.length + 1) + "列"));
                continue;
            }

            //检查数据
            List<String[]> checkIsEmptyList = checkIsEmpty(row, data, new int[]{0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10});
            if (!isEmpty(checkIsEmptyList)) {
                resultList.addAll(checkIsEmptyList);
                continue;
            } else {
                checkIsEmptyList = checkIsNumber(row, data, new int[]{9, 14});
                if (!isEmpty(checkIsEmptyList)) {
                    resultList.addAll(checkIsEmptyList);
                    continue;
                }
            }
            //学院
            String BDM_COLLEGE = data[0];
            //系
            String BDM_NAME = data[1];
            //专业
            String BC_MAJOR = data[2];
            //班级
            String BC_NAME = data[3];
            //学号
            String BS_NUMBER = data[4];
            //状态
            String BS_STATUS = data[6];
            //身份证号
            String BS_ID_CARD = data[7];
            //攻读学历
            String BS_EDUCATION = data[8];
            //学制
            String BS_LENGTH = data[9];
            //入学日期
            String BS_ENROLMENT = data[10];
            //银行卡号
            String BS_BANK_CARD = data[11];
            //政治面貌
            String BS_POLITICAL_OUTLOOK = data[12];
            //民族
            String BS_NATION = data[13];
            //手机号
            String BS_PHONE = data[14];

            //校验学院是否存在
            DictInfo college = DictUtil.getDictInfoByName("BUS_COLLEGE", BDM_COLLEGE);
            if (isEmpty(college)) {
                resultList.add(packErrorData(row, "没有找到学院,请检查", data));
            }
            //校验系是否存在
            paramMap.clear();
            paramMap.put("BDM_NAME", BDM_NAME);
            Map<String, Object> department = baseDao.selectOne(NameSpace.DepartmentMapper, "selectDepartment", paramMap);
            if (isEmpty(department)) {
                resultList.add(packErrorData(row, "没有找到系部,请检查", data));
            } else {
                if (isEmpty(college) || !college.getSdiCode().equals(toString(department.get("BDM_COLLEGE")))) {
                    resultList.add(packErrorData(row, "系部对应学院信息错误,当前系部学院:" + department.get("BDM_COLLEGE_NAME") + ",请检查", data));
                }
            }
            //校验专业
            DictInfo major = DictUtil.getDictInfoByName("BUS_MAJOR", BC_MAJOR);
            if (isEmpty(major)) {
                resultList.add(packErrorData(row, "没有找到专业,请检查", data));
            }
            //校验班级是否存在
            paramMap.clear();
            paramMap.put("BC_NAME", BC_NAME);
            Map<String, Object> cls = baseDao.selectOne(NameSpace.ClsMapper, "selectClass", paramMap);
            if (isEmpty(cls)) {
                resultList.add(packErrorData(row, "没有找到班级,请检查", data));
            } else {
                if (isEmpty(major) || !major.getSdiCode().equals(toString(cls.get("BC_MAJOR")))) {
                    resultList.add(packErrorData(row, "班级对应专业信息错误,当前班级专业:" + cls.get("BC_MAJOR_NAME") + ",请检查", data));
                } else {
                    if (!toString(cls.get("BDM_ID")).equals(toString(department.get("ID")))) {
                        resultList.add(packErrorData(row, "班级对应系部错误,当前班级系部:" + cls.get("BDM_NAME") + ",请检查", data));
                    }
                }
            }
            //校验学号、身份证、手机号是否重复
            paramMap.clear();
            paramMap.put("BS_NUMBER", BS_NUMBER);
            int count = baseDao.selectOne(NameSpace.StudentMapper, "selectStudentCheckCount", paramMap);
            if (count > 0) {
                resultList.add(packErrorData(row, "学号重复,请检查", data));
            }
            //验证身份证是否合法
            if (!IdCardUtil.validateCardCodeVerifySimple(BS_ID_CARD) || !IdCardUtil.validateCardCodeVerify(BS_ID_CARD)) {
                resultList.add(packErrorData(row, "身份证错误,请检查", data));
            } else {
                paramMap.clear();
                paramMap.put("BS_ID_CARD", BS_ID_CARD);
                count = baseDao.selectOne(NameSpace.StudentMapper, "selectStudentCheckCount", paramMap);
                if (count > 0) {
                    resultList.add(packErrorData(row, "身份证重复,请检查", data));
                }
                if (!isEmpty(BS_PHONE)) {
                    paramMap.clear();
                    paramMap.put("BS_PHONE", BS_PHONE);
                    count = baseDao.selectOne(NameSpace.StudentMapper, "selectStudentCheckCount", paramMap);
                    if (count > 0) {
                        resultList.add(packErrorData(row, "电话号码重复,请检查", data));
                    }
                }
            }
            //校验学制
            DictInfo collegeLength = DictUtil.getDictInfoByName("BUS_COLLEGE_LENGTH", BS_LENGTH);
            if (isEmpty(collegeLength)) {
                resultList.add(packErrorData(row, "没有找到对应学制,请检查", data));
            }
            //攻读学历
            DictInfo education = DictUtil.getDictInfoByName("BUS_EDUCATION", BS_EDUCATION);
            if (isEmpty(education)) {
                resultList.add(packErrorData(row, "没有找到对应攻读学历,请检查", data));
            }
            //状态
            DictInfo studentStatus = DictUtil.getDictInfoByName("BUS_STUDENT_STATUS", BS_STATUS);
            if (isEmpty(studentStatus)) {
                resultList.add(packErrorData(row, "没有找到对应状态,请检查", data));
            }
            //政治面貌
            DictInfo politicalOutlook = DictUtil.getDictInfoByName("BUS_POLITICAL_OUTLOOK", BS_POLITICAL_OUTLOOK);
            if (!isEmpty(BS_POLITICAL_OUTLOOK) && isEmpty(politicalOutlook)) {
                resultList.add(packErrorData(row, "没有找到对应政治面貌,请检查", data));
            }
            //民族
            DictInfo nation = DictUtil.getDictInfoByName("BUS_NATION", BS_NATION);
            if (!isEmpty(BS_NATION) && isEmpty(nation)) {
                resultList.add(packErrorData(row, "没有找到对应民族,请检查", data));
            }
            //检测日期
            if (!isEmpty(BS_ENROLMENT) && !ValidateUtil.checkDate(DateUtil.FORMAT3, BS_ENROLMENT)) {
                resultList.add(packErrorData(row, "入学日期格式错误,参考格式(20160901),请检查", data));
            }
            //检测银行卡号
            if (!isEmpty(BS_BANK_CARD) && !ValidateUtil.checkBankCard(BS_BANK_CARD)) {
                resultList.add(packErrorData(row, "银行卡号格式错误,请检查", data));
            }
        }

        return resultList;
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
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_STUDENT_ATTENDANCE);

            paramMap.put("ID", id);
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
                resultMap.put(MagicValue.LOG, "添加学生考勤:" + formatColumnName(TableName.BUS_STUDENT_ATTENDANCE, paramMap));
            } else {
                Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
                oldMap.put("ID", id);
                oldMap = selectStudentAttendance(oldMap);

                baseDao.update(NameSpace.StudentExtendMapper, "updateStudentAttendance", paramMap);
                resultMap.put(MagicValue.LOG, "更新学生考勤,更新前:" + formatColumnName(TableName.BUS_STUDENT_ATTENDANCE, oldMap) + ",更新后:" + formatColumnName(TableName.BUS_STUDENT_ATTENDANCE, paramMap));
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
                throw new CustomException(Tips.ID_NULL_ERROR);
            }
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
            String id = toString(mapParam.get("ID"));

            //删除学生考勤表
            paramMap.clear();
            paramMap.put("ID", id);
            Map<String, Object> oldMap = selectStudentAttendance(paramMap);
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_STUDENT_ATTENDANCE);

            baseDao.delete(NameSpace.StudentExtendMapper, "deleteStudentAttendance", paramMap);

            resultMap.put(MagicValue.LOG, "删除学生考勤,信息:" + formatColumnName(TableName.BUS_STUDENT_ATTENDANCE, oldMap));
            status = STATUS_SUCCESS;
            desc = DELETE_SUCCESS;
        } catch (Exception e) {
            desc = catchException(e, baseDao, resultMap);
        }
        resultMap.put(MagicValue.STATUS, status);
        resultMap.put(MagicValue.DESC, desc);
        return resultMap;
    }

    /***********    学生处分    *********/

    @Override
    public Map<String, Object> selectStudentPunishment(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("ID", mapParam.get("ID"));
        return baseDao.selectOne(NameSpace.StudentExtendMapper, "selectStudentPunishment", paramMap);
    }

    @Override
    @Transactional
    public Map<String, Object> insertAndUpdateStudentPunishment(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(10);
            String id = toString(mapParam.get("ID"));
            String insertId = toString(mapParam.get("insertId"));

            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_STUDENT_PUNISHMENT);

            paramMap.put("ID", id);
            paramMap.put("BS_ID", mapParam.get("BS_ID"));
            paramMap.put("BSP_TITLE", mapParam.get("BSP_TITLE"));
            paramMap.put("BSP_FILE_NUMBER", mapParam.get("BSP_FILE_NUMBER"));
            paramMap.put("BSP_RELEASE_TIME", mapParam.get("BSP_RELEASE_TIME"));
            paramMap.put("BSP_TYPE", mapParam.get("BSP_TYPE"));
            paramMap.put("BSP_REVOKE_TIME", mapParam.get("BSP_REVOKE_TIME"));
            paramMap.put("BSP_DESCRIBE", mapParam.get("BSP_DESCRIBE"));
            paramMap.put("BSP_IS_CANCEL", mapParam.get("BSP_IS_CANCEL"));
            paramMap.put("BSP_CANCEL_TIME", mapParam.get("BSP_CANCEL_TIME"));

            if (isEmpty(id)) {
                id = insertId;
                paramMap.put("ID", id);
                paramMap.put("BSP_ENTRY_TIME", getDate());

                baseDao.insert(NameSpace.StudentExtendMapper, "insertStudentPunishment", paramMap);
                resultMap.put(MagicValue.LOG, "添加学生处分:" + formatColumnName(TableName.BUS_STUDENT_PUNISHMENT, paramMap));
            } else {
                Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
                oldMap.put("ID", id);
                oldMap = selectStudentPunishment(oldMap);

                baseDao.update(NameSpace.StudentExtendMapper, "updateStudentPunishment", paramMap);
                resultMap.put(MagicValue.LOG, "更新学生处分,更新前:" + formatColumnName(TableName.BUS_STUDENT_ATTENDANCE, oldMap) + ",更新后:" + formatColumnName(TableName.BUS_STUDENT_PUNISHMENT, paramMap));
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
    public Map<String, Object> revokeStudentPunishment(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(10);
            String id = toString(mapParam.get("ID"));
            if (isEmpty(id)) {
                throw new CustomException("参数错误!");
            }

            paramMap.put("ID", id);
            paramMap.put("BSP_IS_CANCEL", STATUS_SUCCESS);
            paramMap.put("BSP_CANCEL_TIME", getDate());

            Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
            oldMap.put("ID", id);
            oldMap = selectStudentPunishment(oldMap);
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_STUDENT_PUNISHMENT);

            baseDao.update(NameSpace.StudentExtendMapper, "updateStudentPunishment", paramMap);
            resultMap.put(MagicValue.LOG, "作废学生处分,处分标题:" + oldMap.get("BSP_TITLE"));

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
    public Map<String, Object> deleteStudentPunishment(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = DELETE_ERROR;
        try {
            if (isEmpty(mapParam.get("ID"))) {
                throw new CustomException(Tips.ID_NULL_ERROR);
            }
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
            String id = toString(mapParam.get("ID"));

            //删除学生处分表
            paramMap.clear();
            paramMap.put("ID", id);
            Map<String, Object> oldMap = selectStudentPunishment(paramMap);
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_STUDENT_PUNISHMENT);

            baseDao.delete(NameSpace.StudentExtendMapper, "deleteStudentPunishment", paramMap);

            resultMap.put(MagicValue.LOG, "删除学生处分,信息:" + formatColumnName(TableName.BUS_STUDENT_PUNISHMENT, oldMap));
            status = STATUS_SUCCESS;
            desc = DELETE_SUCCESS;
        } catch (Exception e) {
            desc = catchException(e, baseDao, resultMap);
        }
        resultMap.put(MagicValue.STATUS, status);
        resultMap.put(MagicValue.DESC, desc);
        return resultMap;
    }

    /***********    学生综合素质测评    *********/

    @Override
    public Map<String, Object> selectStudentComprehensive(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(4);
        paramMap.put("ID", mapParam.get("ID"));
        paramMap.put("BS_ID", mapParam.get("BS_ID"));
        paramMap.put("BSC_YEAR", mapParam.get("BSC_YEAR"));
        paramMap.put("BSC_SEMESTER", mapParam.get("BSC_SEMESTER"));
        return baseDao.selectOne(NameSpace.StudentExtendMapper, "selectStudentComprehensive", paramMap);
    }

    @Override
    @Transactional
    public Map<String, Object> insertAndUpdateStudentComprehensive(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            //判断比例
            String educationProportion = toString(mapParam.get("BSC_EDUCATION_PROPORTION"));
            String intellectualProportion = toString(mapParam.get("BSC_INTELLECTUAL_PROPORTION"));
            String volunteerProportion = toString(mapParam.get("BSC_VOLUNTEER_PROPORTION"));
            if (isEmpty(educationProportion) || isEmpty(intellectualProportion) || isEmpty(volunteerProportion)) {
                throw new CustomException("比例不能为空!");
            }
            if (toInt(educationProportion) + toInt(intellectualProportion) + toInt(volunteerProportion) != 100) {
                throw new CustomException("比例错误!");
            }

            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(10);
            String id = toString(mapParam.get("ID"));

            paramMap.put("NOT_ID", id);
            paramMap.put("BS_ID", mapParam.get("BS_ID"));
            paramMap.put("BSC_YEAR", mapParam.get("BSC_YEAR"));
            paramMap.put("BSC_SEMESTER", mapParam.get("BSC_SEMESTER"));
            int count = baseDao.selectOne(NameSpace.StudentExtendMapper, "selectStudentComprehensiveCount", paramMap);
            if (count > 0) {
                throw new CustomException("该学生" + mapParam.get("BSC_YEAR") + "学年" +
                        DictUtil.getDictName("BUS_SEMESTER", mapParam.get("BSC_SEMESTER")) +
                        "已经拥有综合素质测评!");
            }

            paramMap.clear();

            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_STUDENT_COMPREHENSIVE);

            paramMap.put("ID", id);
            paramMap.put("BS_ID", mapParam.get("BS_ID"));
            paramMap.put("BSC_EDUCATION_PROPORTION", mapParam.get("BSC_EDUCATION_PROPORTION"));
            paramMap.put("BSC_INTELLECTUAL_PROPORTION", mapParam.get("BSC_INTELLECTUAL_PROPORTION"));
            paramMap.put("BSC_VOLUNTEER_PROPORTION", mapParam.get("BSC_VOLUNTEER_PROPORTION"));
            paramMap.put("BSC_YEAR", mapParam.get("BSC_YEAR"));
            paramMap.put("BSC_SEMESTER", mapParam.get("BSC_SEMESTER"));
            paramMap.put("BSC_TOTAL", mapParam.get("BSC_TOTAL"));
            paramMap.put("BSC_POLITICAL_ATTITUDE", mapParam.get("BSC_POLITICAL_ATTITUDE"));
            paramMap.put("BSC_LABOR_ATTITUDE", mapParam.get("BSC_LABOR_ATTITUDE"));
            paramMap.put("BSC_COMPLIANCE", mapParam.get("BSC_COMPLIANCE"));
            paramMap.put("BSC_COLLECTIVE", mapParam.get("BSC_COLLECTIVE"));
            paramMap.put("BSC_DECORUM", mapParam.get("BSC_DECORUM"));
            paramMap.put("BSC_CARE", mapParam.get("BSC_CARE"));
            paramMap.put("BSC_PERSONAL_QUALITY", mapParam.get("BSC_PERSONAL_QUALITY"));
            paramMap.put("BSC_SERVICE_SPIRIT", mapParam.get("BSC_SERVICE_SPIRIT"));
            paramMap.put("BSC_FULL_WORK", mapParam.get("BSC_FULL_WORK"));
            paramMap.put("BSC_BONUS_POINTS", mapParam.get("BSC_BONUS_POINTS"));
            paramMap.put("BSC_EDUCATION_DEDUCTION", mapParam.get("BSC_EDUCATION_DEDUCTION"));
            paramMap.put("BSC_EDUCATION_TOTAL", mapParam.get("BSC_EDUCATION_TOTAL"));
            paramMap.put("BSC_EDUCATION_SCORE", mapParam.get("BSC_EDUCATION_SCORE"));
            paramMap.put("BSC_ACADEMIC_RECORD", mapParam.get("BSC_ACADEMIC_RECORD"));
            paramMap.put("BSC_INTELLECTUAL_POINTS", mapParam.get("BSC_INTELLECTUAL_POINTS"));
            paramMap.put("BSC_INTELLECTUAL_SCORE", mapParam.get("BSC_INTELLECTUAL_SCORE"));
            paramMap.put("BSC_VOLUNTEER_TOTAL", mapParam.get("BSC_VOLUNTEER_TOTAL"));
            paramMap.put("BSC_VOLUNTEER_SCORE", mapParam.get("BSC_VOLUNTEER_SCORE"));
            paramMap.put("BSC_REMARKS", mapParam.get("BSC_REMARKS"));

            if (isEmpty(id)) {
                id = getId();
                paramMap.put("ID", id);

                baseDao.insert(NameSpace.StudentExtendMapper, "insertStudentComprehensive", paramMap);
                resultMap.put(MagicValue.LOG, "添加学生综合素质测评:" + formatColumnName(TableName.BUS_STUDENT_COMPREHENSIVE, paramMap));
            } else {
                Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
                oldMap.put("ID", id);
                oldMap = selectStudentComprehensive(oldMap);

                baseDao.update(NameSpace.StudentExtendMapper, "updateStudentComprehensive", paramMap);
                resultMap.put(MagicValue.LOG, "更新学生综合素质测评,更新前:" + formatColumnName(TableName.BUS_STUDENT_COMPREHENSIVE, oldMap) + ",更新后:" + formatColumnName(TableName.BUS_STUDENT_COMPREHENSIVE, paramMap));
            }

            //计算排名
            paramMap.clear();
            paramMap.put("ID", mapParam.get("ID"));
            Map<String, Object> comprehensive = baseDao.selectOne(NameSpace.StudentExtendMapper, "selectStudentComprehensive", paramMap);

            calculationRank(baseDao, toString(comprehensive.get("BC_ID")), toString(mapParam.get("BSC_YEAR")), toInt(mapParam.get("BSC_SEMESTER")));

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
    public Map<String, Object> deleteStudentComprehensive(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = DELETE_ERROR;
        try {
            if (isEmpty(mapParam.get("ID"))) {
                throw new CustomException(Tips.ID_NULL_ERROR);
            }
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
            String id = toString(mapParam.get("ID"));

            //删除学生综合素质测评表
            paramMap.clear();
            paramMap.put("ID", id);
            Map<String, Object> oldMap = selectStudentComprehensive(paramMap);
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_STUDENT_COMPREHENSIVE);

            baseDao.delete(NameSpace.StudentExtendMapper, "deleteStudentComprehensive", paramMap);

            resultMap.put(MagicValue.LOG, "删除学生综合素质测评,信息:" + formatColumnName(TableName.BUS_STUDENT_COMPREHENSIVE, oldMap));
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
    @Transactional
    public Map<String, Object> importStudentComprehensive(MultipartFile excelFile) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = IMPORT_ERROR;
        try {
            List<String[]> dataList = PoiUtil.readExcel(excelFile, 0, 0);
            //校验数据
            List<String[]> errorList = checkComprehensiveExcelData(dataList);
            if (!isEmpty(errorList)) {
                resultMap.put(MagicValue.DATA, errorList);
                throw new CustomException("检测数据异常!");
            }

            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(16);

            //拿到学年
            String title = dataList.get(0)[0];
            StudentYearSemester studentYearSemester = parseStudentYearSemester(title);
            //拿到班级
            String className = TextUtil.replaceBlank(TextUtil.getSubBetween(title, "学期", "班"));
            paramMap.clear();
            paramMap.put("BC_NAME", className);
            Map<String, Object> cls = baseDao.selectOne(NameSpace.ClsMapper, "selectClass", paramMap);
            //拿到评分比例
            String[] proportion = dataList.get(2);
            //德育比例
            float BSC_EDUCATION_PROPORTION = toInt(getNumbers(proportion[4]));
            //智育比例
            float BSC_INTELLECTUAL_PROPORTION = toInt(getNumbers(proportion[17]));
            //志愿者比例
            float BSC_VOLUNTEER_PROPORTION = toInt(getNumbers(proportion[21]));
            //学年
            String year = studentYearSemester.getYear();
            //学期
            int semester = studentYearSemester.getSemester();

            //导入数据
            for (int i = 4; i < dataList.size(); i++) {
                String[] data = dataList.get(i);
                //学号
                String BS_NUMBER = data[0];
                //数据
                //德育
                int BSC_POLITICAL_ATTITUDE = toInt(data[4]);
                int BSC_LABOR_ATTITUDE = toInt(data[5]);
                int BSC_COMPLIANCE = toInt(data[6]);
                int BSC_COLLECTIVE = toInt(data[7]);
                int BSC_DECORUM = toInt(data[8]);
                int BSC_CARE = toInt(data[9]);
                int BSC_PERSONAL_QUALITY = toInt(data[10]);
                int BSC_SERVICE_SPIRIT = toInt(data[11]);
                int BSC_FULL_WORK = toInt(data[12]);
                int BSC_BONUS_POINTS = toInt(data[13]);
                int BSC_EDUCATION_DEDUCTION = toInt(data[14]);
                //智育
                int BSC_ACADEMIC_RECORD = toInt(data[17]);
                int BSC_INTELLECTUAL_POINTS = toInt(data[18]);
                //志愿者
                int BSC_VOLUNTEER_TOTAL = toInt(data[21]);
                //备注
                String BSC_REMARKS = data[25];
                //德育总分
                int BSC_EDUCATION_TOTAL = BSC_POLITICAL_ATTITUDE + BSC_LABOR_ATTITUDE + BSC_COMPLIANCE + BSC_COLLECTIVE + BSC_DECORUM + BSC_CARE + BSC_PERSONAL_QUALITY
                        + BSC_SERVICE_SPIRIT + BSC_FULL_WORK + BSC_BONUS_POINTS - BSC_EDUCATION_DEDUCTION;
                //德育得分
                BigDecimal BSC_EDUCATION_SCORE = new BigDecimal((BSC_EDUCATION_TOTAL * (BSC_EDUCATION_PROPORTION / 100) * 10) / 10);
                //智育得分
                BigDecimal BSC_INTELLECTUAL_SCORE = new BigDecimal(((BSC_ACADEMIC_RECORD + BSC_INTELLECTUAL_POINTS) * (BSC_INTELLECTUAL_PROPORTION / 100) * 10) / 10);
                //志愿者得分
                BigDecimal BSC_VOLUNTEER_SCORE = new BigDecimal((BSC_VOLUNTEER_TOTAL * (BSC_VOLUNTEER_PROPORTION / 100) * 10) / 10);
                //总分
                BigDecimal BSC_TOTAL = BSC_EDUCATION_SCORE.add(BSC_INTELLECTUAL_SCORE.add(BSC_VOLUNTEER_SCORE));

                //查询学生
                Map<String, Object> student = this.selectStudentByNumber(BS_NUMBER);

                //记录日志
                paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_STUDENT_COMPREHENSIVE);

                paramMap.put("ID", getId());
                paramMap.put("BS_ID", student.get("ID"));
                paramMap.put("BSC_EDUCATION_PROPORTION", BSC_EDUCATION_PROPORTION);
                paramMap.put("BSC_INTELLECTUAL_PROPORTION", BSC_INTELLECTUAL_PROPORTION);
                paramMap.put("BSC_VOLUNTEER_PROPORTION", BSC_VOLUNTEER_PROPORTION);
                paramMap.put("BSC_YEAR", year);
                paramMap.put("BSC_SEMESTER", semester);
                paramMap.put("BSC_TOTAL", BSC_TOTAL);
                paramMap.put("BSC_POLITICAL_ATTITUDE", BSC_POLITICAL_ATTITUDE);
                paramMap.put("BSC_LABOR_ATTITUDE", BSC_LABOR_ATTITUDE);
                paramMap.put("BSC_COMPLIANCE", BSC_COMPLIANCE);
                paramMap.put("BSC_COLLECTIVE", BSC_COLLECTIVE);
                paramMap.put("BSC_DECORUM", BSC_DECORUM);
                paramMap.put("BSC_CARE", BSC_CARE);
                paramMap.put("BSC_PERSONAL_QUALITY", BSC_PERSONAL_QUALITY);
                paramMap.put("BSC_SERVICE_SPIRIT", BSC_SERVICE_SPIRIT);
                paramMap.put("BSC_FULL_WORK", BSC_FULL_WORK);
                paramMap.put("BSC_BONUS_POINTS", BSC_BONUS_POINTS);
                paramMap.put("BSC_EDUCATION_DEDUCTION", BSC_EDUCATION_DEDUCTION);
                paramMap.put("BSC_EDUCATION_TOTAL", BSC_EDUCATION_TOTAL);
                paramMap.put("BSC_EDUCATION_SCORE", BSC_EDUCATION_SCORE);
                paramMap.put("BSC_ACADEMIC_RECORD", BSC_ACADEMIC_RECORD);
                paramMap.put("BSC_INTELLECTUAL_POINTS", BSC_INTELLECTUAL_POINTS);
                paramMap.put("BSC_INTELLECTUAL_SCORE", BSC_INTELLECTUAL_SCORE);
                paramMap.put("BSC_VOLUNTEER_TOTAL", BSC_VOLUNTEER_TOTAL);
                paramMap.put("BSC_VOLUNTEER_SCORE", BSC_VOLUNTEER_SCORE);
                paramMap.put("BSC_REMARKS", BSC_REMARKS);

                baseDao.insert(NameSpace.StudentExtendMapper, "insertStudentComprehensive", paramMap);
            }

            //计算排名
            calculationRank(baseDao, toString(cls.get("ID")), year, semester);

            resultMap.put(MagicValue.LOG, "导入学生综合素质测评,数据:" + listToString(dataList));
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
     * 检测导入数据
     *
     * @param dataList
     * @return
     */
    public List<String[]> checkComprehensiveExcelData(List<String[]> dataList) {
        List<String[]> resultList = Lists.newArrayList();

        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(3);

        if (isEmpty(dataList) || dataList.size() < 5) {
            resultList.add(packErrorData("文件数据错误", "没有找到可以导入数据"));
            return resultList;
        }
        //拿到学年
        String title = dataList.get(0)[0];
        if (!checkStudentYearSemester(title)) {
            resultList.add(packErrorData("学期学年填写错误", "标题学年学期填写错误"));
            return resultList;
        }
        //拿到班级
        String className = TextUtil.replaceBlank(TextUtil.getSubBetween(title, "学期", "班"));
        if (isEmpty(className)) {
            resultList.add(packErrorData("班级填写错误", "标题班级填写错误"));
            return resultList;
        }

        //查询班级是否存在
        paramMap.clear();
        paramMap.put("BC_NAME", className);
        Map<String, Object> cls = baseDao.selectOne(NameSpace.ClsMapper, "selectClass", paramMap);
        if (isEmpty(cls)) {
            resultList.add(packErrorData("班级填写错误", "没有找到班级:" + className));
            return resultList;
        }

        StudentYearSemester studentYearSemester = parseStudentYearSemester(title);
        //拿到评分比例
        String[] proportion = dataList.get(2);
        //德育比例
        int BSC_EDUCATION_PROPORTION = toInt(getNumbers(proportion[4]));
        //智育比例
        int BSC_INTELLECTUAL_PROPORTION = toInt(getNumbers(proportion[17]));
        //志愿者比例
        int BSC_VOLUNTEER_PROPORTION = toInt(getNumbers(proportion[21]));
        if (BSC_EDUCATION_PROPORTION + BSC_INTELLECTUAL_PROPORTION + BSC_VOLUNTEER_PROPORTION != 100) {
            resultList.add(packErrorData("比例错误", "德育、智育、志愿者总和必须等于100"));
            return resultList;
        }
        //学年
        String year = studentYearSemester.getYear();
        //学期
        int semester = studentYearSemester.getSemester();

        for (int i = 4; i < dataList.size(); i++) {
            //行
            String row = joinRowStr(i + 1);

            String[] data = dataList.get(i);
            if (data.length < 25) {
                resultList.add(packErrorData(row, "数据错误"));
            }

            //学号
            String BS_NUMBER = data[0];
            if (isEmpty(BS_NUMBER)) {
                resultList.add(packErrorData(row, "学号错误"));
                continue;
            }
            //判断是否找到对应学生
            Map<String, Object> student = this.selectStudentByNumber(BS_NUMBER);
            if (isEmpty(student)) {
                resultList.add(packErrorData(row, "学号错误,没有找到对应的学生"));
            } else {
                if (!toString(student.get("BC_ID")).equals(toString(cls.get("ID")))) {
                    resultList.add(packErrorData(row, "学生班级与导入的班级不对应,请检查"));
                } else {
                    paramMap.clear();
                    paramMap.put("BS_ID", student.get("ID"));
                    paramMap.put("BSC_YEAR", year);
                    paramMap.put("BSC_SEMESTER", semester);
                    int count = baseDao.selectOne(NameSpace.StudentExtendMapper, "selectStudentComprehensiveCount", paramMap);

                    if (count > 0) {
                        resultList.add(packErrorData(row, "数据重复导入"));
                    }
                }
            }
        }

        return resultList;
    }

    /**
     * 计算排名
     *
     * @param baseDao
     * @param classId
     * @param year
     * @param semester
     */
    private void calculationRank(BaseDao baseDao, String classId, String year, int semester) throws Exception {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(3);
        paramMap.put("BC_ID", classId);
        paramMap.put("BSC_YEAR", year);
        paramMap.put("BSC_SEMESTER", semester);
        List<Map<String, Object>> comprehensiveList = baseDao.selectList(NameSpace.StudentExtendMapper, "selectStudentComprehensive", paramMap);
        //总排名
        List<BigDecimal> totalList = Lists.newArrayList();
        Map<String, BigDecimal> totalRankMap = Maps.newHashMapWithExpectedSize(16);
        //智育排名
        List<BigDecimal> intellectualList = Lists.newArrayList();
        Map<String, BigDecimal> intellectualRankMap = Maps.newHashMapWithExpectedSize(16);

        comprehensiveList.forEach(map -> {
            BigDecimal total = toBigDecimal(map.get("BSC_TOTAL"));
            BigDecimal intellectualScore = toBigDecimal(map.get("BSC_INTELLECTUAL_SCORE"));
            totalList.add(total);
            intellectualList.add(intellectualScore);
            totalRankMap.put(toString(map.get("ID")), total);
            intellectualRankMap.put(toString(map.get("ID")), intellectualScore);
        });
        //计算排名
        for (String key : totalRankMap.keySet()) {
            int rank = rank(totalList, totalRankMap.get(key));
            paramMap.clear();
            paramMap.put("ID", key);
            paramMap.put("BSC_RANK", rank);
            baseDao.update(NameSpace.StudentExtendMapper, "updateStudentComprehensive", paramMap);
        }
        for (String key : intellectualRankMap.keySet()) {
            int rank = rank(intellectualList, intellectualRankMap.get(key));
            paramMap.clear();
            paramMap.put("ID", key);
            paramMap.put("BSC_INTELLECTUAL_RANK", rank);
            baseDao.update(NameSpace.StudentExtendMapper, "updateStudentComprehensive", paramMap);
        }
    }

    /***********    困难学生认定    *********/

    @Override
    public Map<String, Object> selectStudentDifficulty(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(4);
        paramMap.put("ID", mapParam.get("ID"));
        paramMap.put("BS_ID", mapParam.get("BS_ID"));
        return baseDao.selectOne(NameSpace.StudentExtendMapper, "selectStudentDifficulty", paramMap);
    }

    @Override
    @Transactional
    public Map<String, Object> insertAndUpdateStudentDifficulty(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(10);
            String id = toString(mapParam.get("ID"));

            paramMap.put("NOT_ID", id);
            paramMap.put("BS_ID", mapParam.get("BS_ID"));
            int count = baseDao.selectOne(NameSpace.StudentExtendMapper, "selectStudentDifficultyCount", paramMap);
            if (count > 0) {
                throw new CustomException("该学生已经认定困难学生!");
            }

            paramMap.clear();

            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_STUDENT_DIFFICULTY);

            paramMap.put("ID", id);
            paramMap.put("BS_ID", mapParam.get("BS_ID"));
            paramMap.put("BSD_TYPE", mapParam.get("BSD_TYPE"));
            paramMap.put("BSD_COGNIZANCE_TIME", mapParam.get("BSD_COGNIZANCE_TIME"));
            paramMap.put("BSD_COGNIZANCE_REASON", mapParam.get("BSD_COGNIZANCE_REASON"));
            paramMap.put("BSD_CLASS_REASON", mapParam.get("BSD_CLASS_REASON"));
            paramMap.put("BSD_GRADE_REASON", mapParam.get("BSD_GRADE_REASON"));

            if (isEmpty(id)) {
                id = getId();
                paramMap.put("ID", id);
                paramMap.put("BSD_ENTRY_TIME", getDate());

                baseDao.insert(NameSpace.StudentExtendMapper, "insertStudentDifficulty", paramMap);
                resultMap.put(MagicValue.LOG, "添加困难学生认定:" + formatColumnName(TableName.BUS_STUDENT_DIFFICULTY, paramMap));
            } else {
                Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
                oldMap.put("ID", id);
                oldMap = selectStudentDifficulty(oldMap);

                baseDao.update(NameSpace.StudentExtendMapper, "updateStudentDifficulty", paramMap);
                resultMap.put(MagicValue.LOG, "更新困难学生认定,更新前:" + formatColumnName(TableName.BUS_STUDENT_DIFFICULTY, oldMap) + ",更新后:" + formatColumnName(TableName.BUS_STUDENT_DIFFICULTY, paramMap));
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
    public Map<String, Object> deleteStudentDifficulty(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = DELETE_ERROR;
        try {
            if (isEmpty(mapParam.get("ID"))) {
                throw new CustomException(Tips.ID_NULL_ERROR);
            }
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
            String id = toString(mapParam.get("ID"));

            //删除困难学生认定表
            paramMap.clear();
            paramMap.put("ID", id);
            Map<String, Object> oldMap = selectStudentDifficulty(paramMap);
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_STUDENT_DIFFICULTY);

            baseDao.delete(NameSpace.StudentExtendMapper, "deleteStudentDifficulty", paramMap);

            resultMap.put(MagicValue.LOG, "删除困难学生认定,信息:" + formatColumnName(TableName.BUS_STUDENT_DIFFICULTY, oldMap));
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
    @Transactional
    public Map<String, Object> importStudentDifficulty(MultipartFile excelFile) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = IMPORT_ERROR;
        try {
            List<String[]> dataList = PoiUtil.readExcel(excelFile, 0, 2);
            //校验数据
            List<String[]> errorList = this.checkStudentDifficultyExcelData(dataList);
            if (!isEmpty(errorList)) {
                resultMap.put(MagicValue.DATA, errorList);
                throw new CustomException("检测数据异常!");
            }

            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(16);

            //导入数据
            for (String[] data : dataList) {
                //学号
                String BS_NUMBER = data[3];
                //认定困难级别名称
                String BSD_TYPE = data[7];
                //认定时间
                String BSD_COGNIZANCE_TIME = data[8];
                //认定时间
                String BSD_COGNIZANCE_REASON = data[9];
                //认定时间
                String BSD_CLASS_REASON = data.length > 10 ? data[10] : null;
                //认定时间
                String BSD_GRADE_REASON = data.length > 11 ? data[11] : null;

                //查询学生
                Map<String, Object> student = this.selectStudentByNumber(BS_NUMBER);

                paramMap.clear();
                paramMap.put("BS_ID", student.get("ID"));
                paramMap.put("BSD_TYPE", DictUtil.getDictCode("BUS_DIFFICULTY_TYPE", BSD_TYPE));
                paramMap.put("BSD_COGNIZANCE_TIME", BSD_COGNIZANCE_TIME);
                paramMap.put("BSD_COGNIZANCE_REASON", BSD_COGNIZANCE_REASON);
                paramMap.put("BSD_CLASS_REASON", BSD_CLASS_REASON);
                paramMap.put("BSD_GRADE_REASON", BSD_GRADE_REASON);
                Map<String, Object> difficultyResultMap = this.insertAndUpdateStudentDifficulty(paramMap);
                //校验
                validateResultMap(difficultyResultMap);
            }

            resultMap.put(MagicValue.LOG, "导入困难学生认定信息,数据:" + listToString(dataList));
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
     * 检测导入数据
     *
     * @param dataList
     * @return
     */
    public List<String[]> checkStudentDifficultyExcelData(List<String[]> dataList) {
        List<String[]> resultList = Lists.newArrayList();

        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(3);

        if (isEmpty(dataList)) {
            resultList.add(packErrorData("文件数据错误", "没有找到可以导入数据"));
            return resultList;
        }

        for (int i = 0; i < dataList.size(); i++) {
            //行
            String row = joinRowStr(i + 1);

            String[] data = dataList.get(i);
            if (data.length < 9) {
                resultList.add(packErrorData(row, "数据错误"));
                continue;
            }

            //检查数据
            List<String[]> checkIsEmptyList = checkIsEmpty(row, data, new int[]{0, 1, 2, 3, 4, 6, 7, 8, 9});
            if (!isEmpty(checkIsEmptyList)) {
                resultList.addAll(checkIsEmptyList);
                continue;
            }
            //学院
            String BDM_COLLEGE = data[0];
            //系
            String BDM_NAME = data[1];
            //班级
            String BC_NAME = data[2];
            //学号
            String BS_NUMBER = data[3];
            //身份证号
            String BS_ID_CARD = data[6];
            //认定困难级别名称
            String BSD_TYPE = data[7];
            //认定时间
            String BSD_COGNIZANCE_TIME = data[8];

            //校验学院是否存在
            DictInfo college = DictUtil.getDictInfoByName("BUS_COLLEGE", BDM_COLLEGE);
            if (isEmpty(college)) {
                resultList.add(packErrorData(row, "没有找到学院,请检查"));
            }
            //校验系是否存在
            paramMap.clear();
            paramMap.put("BDM_NAME", BDM_NAME);
            Map<String, Object> department = baseDao.selectOne(NameSpace.DepartmentMapper, "selectDepartment", paramMap);
            if (isEmpty(department)) {
                resultList.add(packErrorData(row, "没有找到系部,请检查"));
            } else {
                if (isEmpty(college) || !college.getSdiCode().equals(toString(department.get("BDM_COLLEGE")))) {
                    resultList.add(packErrorData(row, "系部对应学院信息错误,当前系部学院:" + department.get("BDM_COLLEGE_NAME") + ",请检查"));
                }
            }
            //校验班级是否存在
            paramMap.clear();
            paramMap.put("BC_NAME", BC_NAME);
            Map<String, Object> cls = baseDao.selectOne(NameSpace.ClsMapper, "selectClass", paramMap);
            if (isEmpty(cls)) {
                resultList.add(packErrorData(row, "没有找到班级,请检查"));
            } else {
                if (!toString(cls.get("BDM_ID")).equals(toString(department.get("ID")))) {
                    resultList.add(packErrorData(row, "班级对应系部错误,当前班级系部:" + cls.get("BDM_NAME") + ",请检查"));
                }
            }

            //验证身份证是否合法
            if (!IdCardUtil.validateCardCodeVerifySimple(BS_ID_CARD) || !IdCardUtil.validateCardCodeVerify(BS_ID_CARD)) {
                resultList.add(packErrorData(row, "身份证错误,请检查"));
            }

            //验证学生是否存在
            Map<String, Object> student = this.selectStudentByNumber(BS_NUMBER);
            if (isEmpty(student)) {
                resultList.add(packErrorData(row, "根据学号没有找到学生,请检查"));
            } else {
                //验证是否重复导入
                paramMap.clear();
                paramMap.put("BS_ID", student.get("ID"));
                int count = baseDao.selectOne(NameSpace.StudentExtendMapper, "selectStudentDifficultyCount", paramMap);
                if (count > 0) {
                    resultList.add(packErrorData(row, "困难学生认定重复导入,请检查"));
                }
            }

            //校验困难级别
            DictInfo difficulty = DictUtil.getDictInfoByName("BUS_DIFFICULTY_TYPE", BSD_TYPE);
            if (isEmpty(difficulty)) {
                resultList.add(packErrorData(row, "困难级别名称填写错误,请检查"));
            }

            //认定时间校验
            if (!DateUtil.validateDate(DateUtil.FORMAT3, BSD_COGNIZANCE_TIME)) {
                resultList.add(packErrorData(row, "认定时间填写错误(格式如20020112),请检查"));
            }
        }

        return resultList;
    }
}
