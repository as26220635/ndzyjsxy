package cn.kim.service.util;

import cn.kim.entity.ProcessRunBean;
import cn.kim.service.impl.BaseServiceImpl;
import org.springframework.stereotype.Component;

import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/6/14
 * 流程执行
 */
@Component
public class ProcessExecute extends BaseServiceImpl {

    /**
     * 前进执行
     *
     * @return
     */
    public String advanceExecute(ProcessRunBean run) {
        String error = "";

        return error;
    }

    /**
     * 后退执行
     *
     * @return
     */
    public String retreatExecute(ProcessRunBean run) {
        String error = "";

        return error;
    }
}
