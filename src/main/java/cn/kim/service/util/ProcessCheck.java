package cn.kim.service.util;

import cn.kim.common.BaseData;
import cn.kim.common.attr.Attribute;
import cn.kim.common.eu.NameSpace;
import cn.kim.common.eu.Process;
import cn.kim.dao.BaseDao;
import cn.kim.entity.ProcessRunBean;
import cn.kim.service.impl.BaseServiceImpl;
import cn.kim.service.util.check.AidProcessCheck;
import cn.kim.util.DateUtil;
import com.google.common.collect.Maps;
import org.checkerframework.checker.units.qual.A;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.util.Date;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/6/14
 * 流程校验
 */
@Component
public class ProcessCheck extends BaseData {

    /**
     * 资助验证
     */
    @Autowired
    private AidProcessCheck aidProcessCheck;

    /**
     * 前进校验
     *
     * @return
     */
    public String advanceCheck(ProcessRunBean run) {
        String error = "";
        //大类
        String busProcess = run.getBusProcess();
        //小类
        String busProcess2 = run.getBusProcess2();

        //是否在提交时间范围内
        String timeError = isSubmitTime(run);
        if (!isEmpty(timeError)) {
            return timeError;
        }

        //资助管理
        if (Process.AID.toString().equals(busProcess)) {
            error += aidProcessCheck.checkStudentPunishment(run);
        }
        //资助管理-年度表彰
        if (Process.AID.toString().equals(busProcess) && Process.AID_COMMEND.toString().equals(busProcess2)) {
            //检测成绩是否达到要求
            error += aidProcessCheck.checkCommendScore(run);
        }


        return error;
    }

    /**
     * 后退校验
     *
     * @return
     */
    public String retreatCheck(ProcessRunBean run) {
        String error = "";

        return error;
    }

    /**
     * 通用检测 时间在提交范围内
     *
     * @param run
     * @return
     */
    public String isSubmitTime(ProcessRunBean run) {
        BaseDao baseDao = run.getBaseDao();
        //流程定义ID
        String definitionId = run.getDefinitionId();
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);

        paramMap.put("ID", definitionId);
        Map<String, Object> definition = baseDao.selectOne(NameSpace.ProcessFixedMapper, "selectProcessDefinition", paramMap);

        int IS_TIME_CONTROL = toInt(definition.get("IS_TIME_CONTROL"));
        if (IS_TIME_CONTROL == STATUS_SUCCESS) {
            //查看时间范围
            paramMap.clear();
            paramMap.put("SDP_ID", definitionId);
            paramMap.put("IS_STATUS", Attribute.STATUS_SUCCESS);
            Map<String, Object> timeControl = baseDao.selectOne(NameSpace.ProcessFixedMapper, "selectProcessTimeControl", paramMap);

            if (!isEmpty(timeControl)) {
                long SPTC_START_TIME = DateUtil.getDateTime(DateUtil.FORMAT, toString(timeControl.get("SPTC_START_TIME"))).getTime();
                long SPTC_END_TIME = DateUtil.getDateTime(DateUtil.FORMAT, toString(timeControl.get("SPTC_END_TIME"))).getTime();
                long nowTime = DateUtil.getDateTime(DateUtil.FORMAT, DateUtil.getDate()).getTime();

                if (nowTime < SPTC_START_TIME || nowTime > SPTC_END_TIME) {
                    return "流程不在提交时间范围内(" + timeControl.get("SPTC_START_TIME") + "  -  " + timeControl.get("SPTC_END_TIME") + ")!";
                }
            } else {
                return "未找到定义的流程提交时间范围!";
            }
        }
        return null;
    }
}
