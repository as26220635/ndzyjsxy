package cn.kim.remote;

/**
 * Created by 余庚鑫 on 2019/6/20
 * 日志本地接口
 */
public interface LogRemoteInterface {

    /**
     * 记录日志
     * @param ip
     * @param operatorId
     * @param logEvent
     * @param logTextContent
     * @param logType
     * @param logResult
     */
    void recordLoginLog(String ip, String operatorId, String logEvent, String logTextContent, int logType, int logResult);
}
