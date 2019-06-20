package cn.kim.util;

import cn.kim.common.attr.MagicValue;
import cn.kim.common.attr.ParamTypeResolve;
import cn.kim.entity.ActiveUser;
import cn.kim.remote.LogRemoteInterface;
import cn.kim.remote.LogRemoteInterfaceAsync;
import cn.kim.service.LogService;
import cn.kim.common.attr.ParamTypeResolve;
import cn.kim.entity.ActiveUser;
import cn.kim.service.LogService;
import com.google.common.collect.Maps;
import lombok.extern.log4j.Log4j2;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.checkerframework.checker.units.qual.A;
import org.redisson.api.RFuture;
import org.redisson.api.RRemoteService;
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
@Log4j2
public class LogUtil {

    /**
     * 上一次日志记录到session中的key
     */
    private static final String PREV_LOG_SAVE_KEY = "LOG_SAVE";

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
     * @param logEvent
     * @param logTextContent
     * @param logType
     * @param logResult
     */
    public static void recordLog(String logEvent, String logTextContent, int logType, int logResult) {
        HttpServletRequest request = HttpUtil.getRequest();
        ActiveUser activeUser = AuthcUtil.getCurrentUser();

        String operatorId = activeUser != null ? activeUser.getId() : null;
        String ip = request != null ? HttpUtil.getIpAddr(request) : null;
        recordLog(ip, operatorId, logEvent, logTextContent, logType, logResult);
    }

    /**
     * 记录日志
     *
     * @param ip
     * @param operatorId
     * @param logEvent
     * @param logTextContent
     * @param logType
     * @param logResult
     */
    public static void recordLog(String ip, String operatorId, String logEvent, String logTextContent, int logType, int logResult) {

        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(7);

        try {
            paramMap.put("SO_ID", operatorId);
            paramMap.put("SL_IP", ip);
            paramMap.put("SL_EVENT", logEvent);
            paramMap.put("SL_ENTERTIME", DateUtil.getDate());
            paramMap.put("SL_TYPE", logType);

            paramMap.put("SL_RESULT", logResult);
            //日志内容
            paramMap.put("SLT_CONTENT", logTextContent);
            //防止重复记录
            if (MagicValue.LOG_LOGIN_EVENT.equals(logEvent)) {
                logUtil.logService.insertLog(paramMap);
            } else {
                if (!toString(paramMap).equals(SessionUtil.get(PREV_LOG_SAVE_KEY))) {
                    SessionUtil.set(PREV_LOG_SAVE_KEY, toString(paramMap));
                    logUtil.logService.insertLog(paramMap);

                    ActiveUser activeUser = AuthcUtil.getCurrentUser();
                    log.info("身份:" + (activeUser != null ? ParamTypeResolve.getOpeatorTypeName(activeUser.getType()) : "")
                            + ",用户:" + activeUser.getUsername()
                            + ",操作:" + logEvent
                            + ",内容:" + logTextContent
                            + ",结果:" + logResult);
                }
            }
        } catch (Exception e) {
            log.error("日志操作错误:" + e + "-------------" + e.getMessage());
        }
    }

    public static String toString(Object obj) {
        return TextUtil.toString(obj);
    }
}
