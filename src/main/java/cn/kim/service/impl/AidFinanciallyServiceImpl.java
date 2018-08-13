package cn.kim.service.impl;

import cn.kim.common.attr.Attribute;
import cn.kim.common.attr.MagicValue;
import cn.kim.common.attr.TableName;
import cn.kim.common.eu.NameSpace;
import cn.kim.common.eu.SystemEnum;
import cn.kim.entity.ActiveUser;
import cn.kim.entity.DataTablesView;
import cn.kim.entity.QuerySet;
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
                paramMap.put("BUS_PROCESS", mapParam.get("BUS_PROCESS"));
                paramMap.put("BUS_PROCESS2", mapParam.get("BUS_PROCESS2"));
                paramMap.put("SO_ID", getActiveUser().getId());
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
            paramMap.clear();
            paramMap.put("ID", id);
            Map<String, Object> oldMap = selectAidFinancially(paramMap);

            //删除资助表
            Map<String, Object> schedule = getProcessSchedule(id, toString(oldMap.get("BUS_PROCESS")), toString(oldMap.get("BUS_PROCESS2")));
            if (!isEmpty(schedule) && !isEmpty(schedule.get("SPS_AUDIT_STATUS")) && !"0".equals(toString(schedule.get("SPS_AUDIT_STATUS")))) {
                throw new CustomException("流程办理中不能删除!");
            }

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

    @Override
    @Transactional
    public Map<String, Object> importCollegeScholarship(MultipartFile excelFile) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = DELETE_ERROR;
        ActiveUser activeUser = getActiveUser();
        try {
            List<String[]> dataList = PoiUtil.readExcel(excelFile, 0, 1);
            //校验数据
            List<Map<String, String>> errorList = checkExcelData(dataList, "BUS_COLLEGE_SCHOLARSHIP_TYPE");
            if (!isEmpty(errorList)) {
                resultMap.put(MagicValue.DATA, errorList);
                throw new CustomException("检测数据异常!");
            }

            String year = getStudentYear();
            String semester = getStudentSemester();

            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(6);

            //导入数据
            for (String[] data : dataList) {
                //学号
                String BS_NUMBER = data[1];
                //奖项
                String BAF_AID_TYPE = data[7];

                paramMap.clear();
                paramMap.put("BS_NUMBER", BS_NUMBER);
                Map<String, Object> student = baseDao.selectOne(NameSpace.StudentMapper, "selectStudent", paramMap);

                String BAF_ID = getId();
                paramMap.clear();
                paramMap.put("ID", BAF_ID);
                paramMap.put("BS_ID", student.get("ID"));
                paramMap.put("BAF_YEAR", year);
                paramMap.put("BAF_SEMESTER", semester);
                paramMap.put("BAF_AID_TYPE", DictUtil.getDictCode("BUS_COLLEGE_SCHOLARSHIP_TYPE", BAF_AID_TYPE));
                paramMap.put("BAF_TYPE", Attribute.AID_COLLEGE_SCHOLARSHIP);
                paramMap.put("SO_ID", activeUser.getId());
                paramMap.put("BUS_PROCESS", Attribute.PROCESS_AID);
                paramMap.put("BUS_PROCESS2", Attribute.PROCESS_AID_COLLEGE_SCHOLARSHIP);
                paramMap.put("SO_ID", activeUser.getId());
                paramMap.put("BAF_ENTRY_TIME", getDate());
                baseDao.insert(NameSpace.AidFinanciallyMapper, "insertAidFinancially", paramMap);

//                paramMap.clear();
//                paramMap.put("BS_ID", student.get("ID"));
//                paramMap.put("BAF_YEAR", year);
//                paramMap.put("BAF_SEMESTER", semester);
//                paramMap.put("BAF_AID_TYPE", DictUtil.getDictCode("BUS_COLLEGE_SCHOLARSHIP_TYPE", BAF_AID_TYPE));
//                paramMap.put("BAF_TYPE", Attribute.AID_COLLEGE_SCHOLARSHIP);
//                paramMap.put("SO_ID", activeUser.getId());
//                paramMap.put("BUS_PROCESS", Attribute.PROCESS_AID);
//                paramMap.put("BUS_PROCESS2", Attribute.PROCESS_AID_COLLEGE_SCHOLARSHIP);
//                Map<String, Object> insertMap = this.insertAndUpdateAidFinancially(paramMap);
//                validateResultMap(insertMap);

                //插入流程
                createProcessSchedule(baseDao, BAF_ID, toString(student.get("BS_NAME")),
                        activeUser.getId(), toString(student.get("SO_ID")), Attribute.PROCESS_AID, Attribute.PROCESS_AID_COLLEGE_SCHOLARSHIP);
            }

            resultMap.put(MagicValue.LOG, "导入学院奖学金,数据:" + toString(dataList));
            status = STATUS_SUCCESS;
            desc = DELETE_SUCCESS;
        } catch (Exception e) {
            baseDao.rollback();
            desc = catchException(e, baseDao, resultMap);
        }
        resultMap.put(MagicValue.STATUS, status);
        resultMap.put(MagicValue.DESC, desc);
        return resultMap;
    }

    /**
     * 检测excel数据是否有问题
     *
     * @return
     */
    public List<Map<String, String>> checkExcelData(List<String[]> dataList, String sdtCode) {
        List<Map<String, String>> resultList = new ArrayList<>();
        if (isEmpty(dataList)) {
            resultList.add(packErrorMap("文件数据错误", "没有找到可以导入数据"));
            return resultList;
        }
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);

        String year = getStudentYear();
        String semester = getStudentSemester();

        for (int i = 0; i < dataList.size(); i++) {
            //行
            String row = joinRowStr(i + 2);

            String[] data = dataList.get(i);
            if (data.length <= 7) {
                resultList.add(packErrorMap(row, "数据错误!"));
                continue;
            }
            //学号
            String BS_NUMBER = data[1];
            //奖项
            String BAF_AID_TYPE = data[7];
            if (isEmpty(BS_NUMBER)) {
                resultList.add(packErrorMap(row, "学号为空"));
            } else {
                //查询数据库检查学号是否为空
                paramMap.clear();
                paramMap.put("BS_NUMBER", BS_NUMBER);
                Map<String, Object> student = baseDao.selectOne(NameSpace.StudentMapper, "selectStudent", paramMap);
                if (isEmpty(student)) {
                    resultList.add(packErrorMap(row, "学号错误,没有找到对应的学生!"));
                } else {
                    //查询综合素质评测
                    paramMap.clear();
                    paramMap.put("BS_ID", student.get("ID"));
                    paramMap.put("BSC_YEAR", year);
                    paramMap.put("BSC_SEMESTER", semester);
                    Map<String, Object> comprehensive = baseDao.selectOne(NameSpace.StudentExtendMapper, "selectStudentComprehensive", paramMap);
                    if (isEmpty(comprehensive)) {
                        resultList.add(packErrorMap(row, "学生综合素质测评没有导入!"));
                    }
                }
            }

            if (isEmpty(BAF_AID_TYPE)) {
                resultList.add(packErrorMap(row, "奖项为空"));
            } else {
                String sdiCode = DictUtil.getDictCode(sdtCode, BAF_AID_TYPE);
                if (isEmpty(sdiCode)) {
                    resultList.add(packErrorMap(row, "奖项数据错误,请检查!"));
                }
            }
        }

        return resultList;
    }

}
