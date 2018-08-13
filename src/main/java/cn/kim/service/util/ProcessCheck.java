package cn.kim.service.util;

import cn.kim.common.attr.Attribute;
import cn.kim.entity.ProcessRunBean;
import cn.kim.service.impl.BaseServiceImpl;
import cn.kim.service.util.check.AidProcessCheck;
import org.springframework.stereotype.Component;

import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/6/14
 * 流程校验
 */
@Component
public class ProcessCheck extends BaseServiceImpl {

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
        if (Attribute.PROCESS_AID.equals(busProcess)) {
            AidProcessCheck aidProcessCheck = new AidProcessCheck();
            error += aidProcessCheck.checkStudentPunishment(run);
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
