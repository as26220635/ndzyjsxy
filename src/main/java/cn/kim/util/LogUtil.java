package cn.kim.util;

import cn.kim.common.attr.ParamTypeResolve;
import cn.kim.entity.ActiveUser;
import cn.kim.service.LogService;
import cn.kim.common.attr.ParamTypeResolve;
import cn.kim.entity.ActiveUser;
import cn.kim.service.LogService;
import com.google.common.collect.Maps;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2017/3/29.
 * 日志操作类
 */
@Component
public class LogUtil {

    private static Logger logger = LogManager.getLogger(LogUtil.class.getName());

    @Autowired
    private LogService logService;
    private static LogUtil logUtil;

    public void setLogService(LogService logService) {
        this.logService = logService;
    }

    @PostConstruct
    public void init() {
        logUtil = this;
        logUtil.logService = this.logService;

    }

    /**
     * 记录日志
     *
     * @param request
     * @param logEvent
     * @param logUseType
     * @param logType
     * @param logTextContent
     * @param logResult
     */
    public static void recordLog(HttpServletRequest request, String logEvent, Integer logUseType, String logType, String logTextContent, String logResult) {
        if (ValidateUtil.isEmpty(logTextContent)) {
            return;
        }

        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(7);

        try {
            ActiveUser activeUser = AuthcUtil.getCurrentUser();
            if (activeUser != null) {
                paramMap.put("SO_ID", activeUser.getId());
            }
            if (request != null) {
                paramMap.put("SL_IP", HttpUtil.getIpAddr(request));
            }

            paramMap.put("SL_EVENT", logEvent);
            paramMap.put("SL_ENTERTIME", DateUtil.getDate());
            paramMap.put("SL_USETYPE", logUseType);
            paramMap.put("SL_TYPE", logType);

            paramMap.put("SLT_CONTENT", logTextContent);
            paramMap.put("SL_RESULT", logResult);
            //防止重复记录
            if (!toString(paramMap).equals(SessionUtil.get("LOG_SAVE"))) {
                SessionUtil.set("LOG_SAVE", toString(paramMap));
                logUtil.logService.insertLog(paramMap);
                logger.info("身份:" + ParamTypeResolve.getOpeatorTypeName(activeUser.getType()) + ",用户:" + activeUser.getUsername() + ",操作:" + logEvent + ",内容:" + logTextContent + ",结果:" + logResult);
            }
        } catch (Exception e) {
            logger.error("日志操作错误:" + e + "-------------" + e.getMessage());
        }
    }

    public static String toString(Object obj) {
        return TextUtil.toString(obj);
    }
}
