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
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
            paramMap.put("ID", id);
            Map<String, Object> aid = baseDao.selectOne(NameSpace.AidFinanciallyMapper, "selectAidFinancially", paramMap);

            //查询学生处分
            paramMap.clear();
            paramMap.put("BS_ID", aid.get("BS_ID"));
            paramMap.put("BSP_IS_CANCEL", "0");
            int count = baseDao.selectOne(NameSpace.StudentExtendMapper, "selectStudentPunishmentCount", paramMap);
            if (count > 0) {
                throw new CustomException("学生拥有处分不能提交流程!");
            }
            //查询学生迟到旷课数据
            paramMap.clear();
            paramMap.put("BS_ID",aid.get("BS_ID"));
            paramMap.put("BSA_YEAR",aid.get("BAF_YEAR"));
            //学院年度表彰 查询一年数据
            if(Process.AID_COMMEND.toString().equals(busProcess2)){
                paramMap.put("BSA_SEMESTER",aid.get("BAF_SEMESTER"));
            }
            Map<String,Object> attendance = baseDao.selectOne(NameSpace.StudentExtendMapper, "selectStudentAttendanceGroupByCount", paramMap);
            if(isEmpty(attendance)){
                throw new CustomException("学生没有考勤数据,请检查!");
            }
            //多少节迟到算旷课默认2节
            int lateProportion = toInt(AllocationUtil.get("LATE_PROPORTION",2));
            //多少节旷课算处分默认40节
            int absenteeismProportion = toInt(AllocationUtil.get("ABSENTEEISM_PROPORTION",40));
            //迟到节数
            int late = toInt(attendance.get("BSA_LATE"));
            //旷课节数
            int absenteeism = toInt(attendance.get("BSA_ABSENTEEISM"));
            //是否算处分
            if ((late / lateProportion) + absenteeism >= absenteeismProportion) {
                throw new CustomException("学生迟到旷课节数达到处分不能提交流程!");
            }

        } catch (Exception e) {
            error = e.getMessage();
        }


        return error;
    }
}
