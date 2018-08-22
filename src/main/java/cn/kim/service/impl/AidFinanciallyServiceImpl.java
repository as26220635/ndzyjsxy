package cn.kim.service.impl;

import cn.kim.common.attr.Attribute;
import cn.kim.common.attr.MagicValue;
import cn.kim.common.attr.TableName;
import cn.kim.common.eu.AidType;
import cn.kim.common.eu.NameSpace;
import cn.kim.common.eu.Process;
import cn.kim.common.eu.SystemEnum;
import cn.kim.dao.BaseDao;
import cn.kim.entity.ActiveUser;
import cn.kim.entity.DataTablesView;
import cn.kim.entity.QuerySet;
import cn.kim.entity.StudentYearSemester;
import cn.kim.exception.CustomException;
import cn.kim.service.AidFinanciallyService;
import cn.kim.util.CommonUtil;
import cn.kim.util.DictUtil;
import cn.kim.util.PoiUtil;
import com.google.common.collect.Maps;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.w3c.dom.Attr;

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
            if (count == 0) {
                throw new CustomException("该学生" + mapParam.get("BS_NAME") + "学年" +
                        DictUtil.getDictName("BUS_SEMESTER", mapParam.get("BAF_SEMESTER")) +
                        "没有存在综合素质测评!");
            }

            //记录日志
            paramMap.clear();
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_AID_FINANCIALLY);

            paramMap.put("ID", id);
            paramMap.put("BS_ID", mapParam.get("BS_ID"));
            paramMap.put("BAF_YEAR", mapParam.get("BAF_YEAR"));
            paramMap.put("BAF_SEMESTER", mapParam.get("BAF_SEMESTER"));
            paramMap.put("BAF_AID_TYPE", mapParam.get("BAF_AID_TYPE"));
            paramMap.put("BAF_REDUCTION_LEVEL", mapParam.get("BAF_REDUCTION_LEVEL"));
            paramMap.put("BAF_REDUCTION_QUOTA", mapParam.get("BAF_REDUCTION_QUOTA"));
            paramMap.put("BAF_DIFFICULTY_LEVEL", mapParam.get("BAF_DIFFICULTY_LEVEL"));
            paramMap.put("BAF_DIFFICULTY_TYPE", mapParam.get("BAF_DIFFICULTY_TYPE"));
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
                resultMap.put(MagicValue.LOG, "添加资助:" + formatColumnName(TableName.BUS_AID_FINANCIALLY, paramMap));
            } else {
                Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
                oldMap.put("ID", id);
                oldMap = selectAidFinancially(oldMap);

                baseDao.update(NameSpace.AidFinanciallyMapper, "updateAidFinancially", paramMap);
                resultMap.put(MagicValue.LOG, "更新资助,更新前:" + formatColumnName(TableName.BUS_AID_FINANCIALLY, oldMap) + ",更新后:" + formatColumnName(TableName.BUS_AID_FINANCIALLY, paramMap));
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
            paramMap.clear();
            paramMap.put("ID", id);
            Map<String, Object> oldMap = selectAidFinancially(paramMap);

            //删除资助表
            Map<String, Object> schedule = getProcessSchedule(id, toString(oldMap.get("BUS_PROCESS")), toString(oldMap.get("BUS_PROCESS2")));
            if (!isEmpty(schedule) && !isEmpty(schedule.get("SPS_AUDIT_STATUS")) && !"0".equals(toString(schedule.get("SPS_AUDIT_STATUS")))) {
                throw new CustomException("流程办理中不能删除!");
            }

            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_AID_FINANCIALLY);

            baseDao.delete(NameSpace.AidFinanciallyMapper, "deleteAidFinancially", paramMap);

            //删除流程
            deleteProcessSchedule(id, TableName.BUS_AID_FINANCIALLY);
            resultMap.put(MagicValue.LOG, "删除资助,信息:" + formatColumnName(TableName.BUS_AID_FINANCIALLY, oldMap));
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
     * 导入年度表彰
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
            ActiveUser activeUser = getActiveUser();

            List<String[]> dataList = PoiUtil.readExcel(excelFile, 0, 1);
            //校验数据
            List<String[]> errorList = checkExcelDataGreenChannel(dataList);
            if (!isEmpty(errorList)) {
                resultMap.put(MagicValue.DATA, errorList);
                throw new CustomException("检测数据异常!");
            }

            String year;

            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(6);

            //导入数据
            for (String[] data : dataList) {
                //学号
                String BS_NUMBER = data[2];
                //解析学年和学期
                StudentYearSemester studentYearSemester = parseStudentYear(data[4]);
                year = studentYearSemester.getYear();

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

                paramMap.put("BAF_TYPE", AidType.GREEN_CHANNEL.getType());
                paramMap.put("SO_ID", activeUser.getId());
                paramMap.put("BUS_PROCESS", Process.AID.toString());
                paramMap.put("BUS_PROCESS2", Process.AID_GREEN_CHANNEL.toString());
                //备注
                paramMap.put("BUS_REMARKS", data.length >= 6 ? data[5] : null);
                Map<String, Object> insertMap = this.insertAndUpdateAidFinancially(paramMap);
                validateResultMap(insertMap);

                //插入流程
                createProcessSchedule(toString(insertMap.get("ID")), toString(student.get("BS_NAME")),
                        activeUser.getId(), toString(student.get("SO_ID")), Process.AID.toString(), Process.AID_GREEN_CHANNEL.toString());
            }

            resultMap.put(MagicValue.LOG, "导入绿色通道数据,数据:" + toString(dataList));
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
    private List<String[]> importAid(Map<String, Object> resultMap, BaseDao baseDao, MultipartFile excelFile, AidType aidType, Process busProcess, Process busProcess2, String sdtCode) throws Exception {
        ActiveUser activeUser = getActiveUser();

        List<String[]> dataList = PoiUtil.readExcel(excelFile, 0, 1);
        //校验数据
        List<String[]> errorList = checkExcelData(dataList, aidType, sdtCode);
        if (!isEmpty(errorList)) {
            resultMap.put(MagicValue.DATA, errorList);
            throw new CustomException("检测数据异常!");
        }

        String year;
        Integer semester;

        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(6);

        //导入数据
        for (String[] data : dataList) {
            //学号
            String BS_NUMBER = data[1];
            //奖项
            String BAF_AID_TYPE = data[7];
            //学年字段
            String YEAR_FIELD_DATA = data.length >= 9 ? data[8] : null;

            //解析学年和学期
            StudentYearSemester studentYearSemester = null;
            if (aidType == AidType.COMMEND) {
                //只解析学年
                studentYearSemester = parseStudentYear(YEAR_FIELD_DATA);
            } else {
                studentYearSemester = parseStudentYearSemester(YEAR_FIELD_DATA);
            }
            year = studentYearSemester.getYear();
            semester = studentYearSemester.getSemester();

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
            //年度表彰没有学期
            if (aidType == AidType.COMMEND) {
                paramMap.put("BAF_SEMESTER", semester);
            }

            paramMap.put("BAF_AID_TYPE", DictUtil.getDictCode(sdtCode, BAF_AID_TYPE));
            paramMap.put("BAF_TYPE", aidType.toString());
            paramMap.put("SO_ID", activeUser.getId());
            paramMap.put("BUS_PROCESS", busProcess.toString());
            paramMap.put("BUS_PROCESS2", busProcess2.toString());
            Map<String, Object> insertMap = this.insertAndUpdateAidFinancially(paramMap);
            validateResultMap(insertMap);

            //插入流程
            createProcessSchedule(toString(insertMap.get("ID")), toString(student.get("BS_NAME")),
                    activeUser.getId(), toString(student.get("SO_ID")), busProcess.toString(), busProcess2.toString());
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
    public List<String[]> checkExcelData(List<String[]> dataList, AidType aidType, String sdtCode) {
        List<String[]> resultList = new ArrayList<>();
        if (isEmpty(dataList)) {
            resultList.add(packErrorData("文件数据错误", "没有找到可以导入数据"));
            return resultList;
        }
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);

        String year;
        Integer semester;

        for (int i = 0; i < dataList.size(); i++) {
            //行
            String row = joinRowStr(i + 2);

            String[] data = dataList.get(i);
            if (data.length <= 7) {
                resultList.add(packErrorData(row, "数据错误!"));
                continue;
            }
            //学号
            String BS_NUMBER = data[1];
            //奖项
            String BAF_AID_TYPE = data[7];
            //学年字段
            String YEAR_FIELD_DATA = data.length >= 9 ? data[8] : null;
            //解析学年和学期
            StudentYearSemester studentYearSemester = null;
            if (aidType == AidType.COMMEND) {
                //只解析学年
                studentYearSemester = parseStudentYear(YEAR_FIELD_DATA);
            } else {
                studentYearSemester = parseStudentYearSemester(YEAR_FIELD_DATA);
            }
            year = studentYearSemester.getYear();
            semester = studentYearSemester.getSemester();

            if (isEmpty(BAF_AID_TYPE)) {
                resultList.add(packErrorData(row, "奖项为空"));
            } else {
                String sdiCode = DictUtil.getDictCode(sdtCode, BAF_AID_TYPE);
                if (isEmpty(sdiCode)) {
                    resultList.add(packErrorData(row, "奖项数据错误,请检查"));
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
                    paramMap.clear();
                    paramMap.put("BS_ID", student.get("ID"));
                    paramMap.put("BSC_YEAR", year);

                    //年度表彰计算一年的数据
                    if (aidType == AidType.COMMEND) {
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

                    //检测是否重复导入
                    paramMap.clear();
                    paramMap.put("BS_ID", student.get("ID"));
                    paramMap.put("BAF_TYPE", aidType.getType());
                    paramMap.put("BAF_YEAR", year);
                    if (aidType == AidType.COMMEND) {
                        paramMap.put("BAF_SEMESTER", semester);
                    }

                    Map<String, Object> aid = baseDao.selectOne(NameSpace.AidFinanciallyMapper, "selectAidFinancially", paramMap);
                    if (!isEmpty(aid)) {
                        resultList.add(packErrorData(row, "数据重复导入"));
                    }
                }
            }
        }

        return resultList;
    }

    /**
     * 检测excel数据是否有问题
     * 绿色通道
     *
     * @param dataList
     * @return
     */
    public List<String[]> checkExcelDataGreenChannel(List<String[]> dataList) {
        List<String[]> resultList = new ArrayList<>();
        if (isEmpty(dataList)) {
            resultList.add(packErrorData("文件数据错误", "没有找到可以导入数据"));
            return resultList;
        }
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);

        for (int i = 0; i < dataList.size(); i++) {
            //行
            String row = joinRowStr(i + 2);

            String[] data = dataList.get(i);
            if (data.length <= 5) {
                resultList.add(packErrorData(row, "数据错误!"));
                continue;
            }
            //学号
            String BS_NUMBER = data[2];
            String year = data[4];

            if (!checkStudentYear(year)) {
                resultList.add(packErrorData(row, "学年错误!"));
                continue;
            } else {
                //解析学年和学期
                StudentYearSemester studentYearSemester = parseStudentYear(data[4]);
                year = studentYearSemester.getYear();
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
                    //检测是否重复导入
                    paramMap.clear();
                    paramMap.put("BS_ID", student.get("ID"));
                    paramMap.put("BAF_TYPE", AidType.GREEN_CHANNEL.getType());
                    paramMap.put("BAF_YEAR", year);

                    Map<String, Object> aid = baseDao.selectOne(NameSpace.AidFinanciallyMapper, "selectAidFinancially", paramMap);
                    if (!isEmpty(aid)) {
                        resultList.add(packErrorData(row, "数据重复导入"));
                    }
                }
            }
        }

        return resultList;
    }
}
