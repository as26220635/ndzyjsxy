package cn.kim.service.util;

import cn.kim.common.BaseData;
import cn.kim.common.eu.Process;
import cn.kim.entity.ProcessRunBean;
import cn.kim.service.impl.BaseServiceImpl;
import cn.kim.service.util.check.AidProcessCheck;
import org.checkerframework.checker.units.qual.A;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;

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
}
