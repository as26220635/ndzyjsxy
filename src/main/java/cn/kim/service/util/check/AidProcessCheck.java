package cn.kim.service.util.check;

import cn.kim.common.BaseData;
import cn.kim.common.eu.AidType;
import cn.kim.common.eu.NameSpace;
import cn.kim.common.eu.Process;
import cn.kim.dao.BaseDao;
import cn.kim.entity.ProcessRunBean;
import cn.kim.exception.CustomException;
import cn.kim.util.AllocationUtil;
import com.google.common.collect.Maps;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/8/13
 * 资助流程验证
 */
public class AidProcessCheck extends BaseData {

    /**
     * 验证学生是否拥有处分
     *
     * @param run
     * @return
     */
    public String checkStudentPunishment(ProcessRunBean run) {
        String error = "";
        String id = run.getBusTableId();
        BaseDao baseDao = run.getBaseDao();
        //流程小类
        String busProcess2 = run.getBusProcess2();
        try {
            //多少节迟到算旷课默认2节
            int lateProportion = toInt(AllocationUtil.get("LATE_PROPORTION", 2));
            //多少节旷课算处分默认40节
            int absenteeismProportion = toInt(AllocationUtil.get("ABSENTEEISM_PROPORTION", 40));

            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
            paramMap.put("ID", id);
            Map<String, Object> aid = baseDao.selectOne(NameSpace.AidFinanciallyMapper, "selectAidFinancially", paramMap);
            String BS_NAME = toString(aid.get("BS_NAME"));

            //查询学生处分
            paramMap.clear();
            paramMap.put("BS_ID", aid.get("BS_ID"));
            paramMap.put("BSP_IS_CANCEL", "0");
            int count = baseDao.selectOne(NameSpace.StudentExtendMapper, "selectStudentPunishmentCount", paramMap);
            if (count > 0) {
                throw new CustomException("学生:" + BS_NAME + ",拥有处分不能提交流程!");
            }
            //查询学生迟到旷课数据
            paramMap.clear();
            paramMap.put("BS_ID", aid.get("BS_ID"));
            paramMap.put("BSA_YEAR", aid.get("BAF_YEAR"));
            paramMap.put("LATE_PROPORTION", lateProportion);
            //学院年度表彰 查询一年数据 查出最大的旷课节数
            if (Process.AID_COMMEND.toString().equals(busProcess2)) {
                paramMap.put("BSA_SEMESTER", aid.get("BAF_SEMESTER"));
            }
            Map<String, Object> attendance = baseDao.selectOne(NameSpace.StudentExtendMapper, "selectStudentAttendanceGroupBySum", paramMap);
            if (!isEmpty(attendance)) {
//                throw new CustomException("学生:" + BS_NAME + ",没有考勤数据,请检查!");

                //旷课节数
                int absenteeism = toInt(attendance.get("BSA_ABSENTEEISM"));
                //是否算处分
                if (absenteeism >= absenteeismProportion) {
                    throw new CustomException("学生:" + BS_NAME + ",迟到旷课节数达到处分不能提交流程!");
                }
            }


        } catch (Exception e) {
            error = e.getMessage();
        }


        return error;
    }

    /**
     * 检查年度表彰学生成绩是否达到要求
     *
     * @param run
     * @return
     */
    public String checkCommendScore(ProcessRunBean run) {
        String error = "";
        String id = run.getBusTableId();
        BaseDao baseDao = run.getBaseDao();
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
            paramMap.put("ID", id);
            Map<String, Object> aid = baseDao.selectOne(NameSpace.AidFinanciallyMapper, "selectAidFinancially", paramMap);

            String BS_NAME = toString(aid.get("BS_NAME"));
            String BAF_AID_TYPE = toString(aid.get("BAF_AID_TYPE"));
            String BAF_YEAR = toString(aid.get("BAF_YEAR"));

            //查询学年平均成绩
            paramMap.clear();
            paramMap.put("BS_ID", aid.get("BS_ID"));
            paramMap.put("BSC_YEAR", BAF_YEAR);
            Map<String, Object> avgScore = baseDao.selectOne(NameSpace.StudentExtendMapper, "selectStudentAvgYearScore", paramMap);
            //总成绩
            BigDecimal totalScore = new BigDecimal(toString(avgScore.get("BSC_TOTAL"))).setScale(2, BigDecimal.ROUND_DOWN);
            //学习成绩
            BigDecimal academicScore = new BigDecimal(toString(avgScore.get("BSC_ACADEMIC_RECORD"))).setScale(2, BigDecimal.ROUND_DOWN);

            if ("THREE_GOOD_STUDENTS".equalsIgnoreCase(BAF_AID_TYPE)) {
                //三好学生 要求学习成绩 平均分要85分以上
                if (academicScore.compareTo(new BigDecimal(85)) == -1) {
                    throw new CustomException("学生:" + BS_NAME + ",学年:" + BAF_YEAR + ",学习平均成绩:" + academicScore.toString() + ",小于要求的85分。");
                }
            } else if ("OUTSTANDING_STUDENT_CADRES".equalsIgnoreCase(BAF_AID_TYPE)) {
                //优秀学生干部要求学习成绩+测评成绩 成绩75分以 上综合素质测评80分以上
                if (academicScore.compareTo(new BigDecimal(75)) == -1) {
                    throw new CustomException("学生:" + BS_NAME + ",学年:" + BAF_YEAR + ",学习平均成绩:" + academicScore.toString() + ",小于要求的75分。");
                }
                if (totalScore.compareTo(new BigDecimal(80)) == -1) {
                    throw new CustomException("学生:" + BS_NAME + ",学年:" + BAF_YEAR + ",综合素质测评平均成绩:" + totalScore.toString() + ",小于要求的70分。");
                }
            }


        } catch (Exception e) {
            error = e.getMessage();
        }
        return error;
    }

}
