package cn.kim.remote;

import org.redisson.api.RFuture;
import org.redisson.api.annotation.RRemoteAsync;

/**
 * Created by 余庚鑫 on 2019/6/20
 * 日志异步接口
 */
@RRemoteAsync(LogRemoteInterface.class)
public interface LogRemoteInterfaceAsync {

    /**
     * 记录日志
     *
     * @param ip
     * @param operatorId
     * @param logEvent
     * @param logTextContent
     * @param logType
     * @param logResult
     * @return
     */
    RFuture<Void> recordLoginLog(String ip, String operatorId, String logEvent, String logTextContent, int logType, int logResult);
}
