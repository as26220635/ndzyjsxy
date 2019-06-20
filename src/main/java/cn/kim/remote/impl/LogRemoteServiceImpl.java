package cn.kim.remote.impl;

import cn.kim.remote.LogRemoteInterface;
import cn.kim.util.HttpUtil;
import cn.kim.util.LogUtil;

/**
 * Created by 余庚鑫 on 2019/6/20
 * 本地记录日志实现
 */
public class LogRemoteServiceImpl implements LogRemoteInterface {

    @Override
    public void recordLoginLog(String ip, String operatorId, String logEvent, String logTextContent, int logType, int logResult) {
        //获得登录地址
        String loginAddress = HttpUtil.getIpAddressName(ip);
        //替换地址
        logTextContent = logTextContent.replace("#{IP_ADDRESS}", loginAddress);
        LogUtil.recordLog(ip, operatorId, logEvent, logTextContent, logType, logResult);
    }
}
