package cn.kim.service.impl;

import cn.kim.common.attr.Attribute;
import cn.kim.common.attr.TableViewName;
import cn.kim.common.eu.NameSpace;
import cn.kim.common.eu.Process;
import cn.kim.common.eu.SystemEnum;
import cn.kim.dao.BaseDao;
import cn.kim.exception.ParameterException;
import cn.kim.service.ManagerService;
import cn.kim.util.CommonUtil;
import cn.kim.util.TextUtil;
import cn.kim.util.ValidateUtil;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.security.InvalidKeyException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/3/21
 */
@Service
public class ManagerServiceImpl extends BaseServiceImpl implements ManagerService {

    /**
     * 登录账号是否存在
     *
     * @param operatorUserName
     * @return
     */
    @Override
    public boolean checkLoginUsername(String operatorUserName) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("SOS_USERNAME", operatorUserName);
        int count = baseDao.selectOne(NameSpace.ManagerMapper, "checkLoginUsername", paramMap);
        return count > 0;
    }

    /**
     * 根据账号查询信息
     *
     * @param operatorUserName
     * @return
     */
    @Override
    public Map<String, Object> queryLoginUsername(String operatorUserName) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("SOS_USERNAME", operatorUserName);
        return baseDao.selectOne(NameSpace.ManagerMapper, "queryLoginUsername", paramMap);
    }

    /**
     * 根据SO_ID查询用户角色
     *
     * @param mapParam
     * @return
     * @throws Exception
     */
    @Override
    public List<Map<String, Object>> queryOperatorRole(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("SO_ID", mapParam.get("SO_ID"));
        List<Map<String, Object>> roles = baseDao.selectList(NameSpace.ManagerMapper, "queryOperatorRole", paramMap);
        return roles;
    }

    /**
     * 查询账号信息
     *
     * @param mapParam
     * @return
     */
    @Override
    public Map<String, Object> queryAccountInfo(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("SO_ID", mapParam.get("SO_ID"));
        return baseDao.selectOne(NameSpace.ManagerMapper, "queryAccountInfo", paramMap);
    }

    /**
     * 根据SO_ID查询用户角色菜单按钮权限
     *
     * @param mapParam
     * @return
     * @throws Exception
     */
    @Override
    public List<Map<String, Object>> queryOperatorMenuButtonPrecode(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("SO_ID", mapParam.get("SO_ID"));
        List<Map<String, Object>> precodes = baseDao.selectList(NameSpace.ManagerMapper, "queryOperatorMenuButtonPrecode", paramMap);
        return precodes;
    }

    /**
     * 根据SO_ID查询用户角色菜单权限
     *
     * @param mapParam
     * @return
     */
    @Override
    public List<Map<String, Object>> queryOperatorMenu(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(2);
        paramMap.put("SO_ID", mapParam.get("SO_ID"));
        paramMap.put("SM_PARENTID", mapParam.get("SM_PARENTID"));
        return baseDao.selectList(NameSpace.ManagerMapper, "queryOperatorMenu", paramMap);
    }

    /**
     * 获取菜单树
     *
     * @param operatorId
     * @return
     */
    @Override
    public List<Map<String, Object>> queryOperatorMenuTree(String operatorId) {
        return getOperatorMenuTree(baseDao, NameSpace.ManagerMapper, "queryOperatorMenu", operatorId, "0", "-1", null, null);
    }

    @Override
    public Map<String, Object> selectProcessScheduleBacklog(String operatorId) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);

        List<Map<String, Object>> backlogList = Lists.newArrayList();
        int backlogNumber = 0;

        //资助管理-绿色通道
        getBacklog(backlogList, operatorId, Process.AID.toString(), Process.AID_GREEN_CHANNEL.toString(), TableViewName.V_AID_GREEN_CHANNEL, true);
        //资助管理-国家奖学金
        getBacklog(backlogList, operatorId, Process.AID.toString(), Process.AID_NATIONAL_SCHOLARSHIP.toString(), TableViewName.V_AID_NATIONAL_SCHOLARSHIP, true);
        //资助管理-国家励志奖学金
        getBacklog(backlogList, operatorId, Process.AID.toString(), Process.AID_NATIONAL_ENDEAVOR.toString(), TableViewName.V_AID_NATIONAL_ENDEAVOR, true);
        //资助管理-国家助学金
        getBacklog(backlogList, operatorId, Process.AID.toString(), Process.AID_NATIONAL_GRANTS.toString(), TableViewName.V_AID_NATIONAL_GRANTS, true);
        //资助管理-减免学费
        getBacklog(backlogList, operatorId, Process.AID.toString(), Process.AID_TUITION_WAIVER.toString(), TableViewName.V_AID_TUITION_WAIVER, true);
        //资助管理-学院奖学金
        getBacklog(backlogList, operatorId, Process.AID.toString(), Process.AID_COLLEGE_SCHOLARSHIP.toString(), TableViewName.V_AID_COLLEGE_SCHOLARSHIP, true);
        //资助管理-年度表彰
        getBacklog(backlogList, operatorId, Process.AID.toString(), Process.AID_COMMEND.toString(), TableViewName.V_AID_COMMEND, true);
        //资助管理-困难毕业生就业补助
        getBacklog(backlogList, operatorId, Process.AID.toString(), Process.AID_JOBSEEKER_SUPPORT.toString(), TableViewName.V_AID_JOBSEEKER_SUPPORT, true);
        //资助管理-应急求助
        getBacklog(backlogList, operatorId, Process.AID.toString(), Process.AID_EMERGENCY_HELP.toString(), TableViewName.V_AID_EMERGENCY_HELP, true);
        //勤工助学
        getBacklog(backlogList, operatorId, Process.DILIGENT.toString(), Process.DILIGENT_STUDY.toString(), TableViewName.V_DILIGENT_STUDY, false);
        //	勤工助学-岗位-学生-月工资
        getBacklog(backlogList, operatorId, Process.DILIGENT.toString(), Process.DILIGENT_STUDY_MONTH_WAGES.toString(), TableViewName.V_DILIGENT_STUDY_MONTH_WAGES, false);

        if (isEmpty(backlogList)) {
            backlogList = new ArrayList<>();
            Map<String, Object> backlog = Maps.newHashMapWithExpectedSize(2);
            backlog.put("SPD_NAME", "没有待办事项");
            backlog.put("BACKLOG_NUM", "0");
            backlogList.add(backlog);
        }else{
            //计算总数
            for (Map<String, Object> backlog : backlogList) {
                backlogNumber += toInt(backlog.get("BACKLOG_NUM"));
            }
        }
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(2);
        resultMap.put("backlogNumber", backlogNumber);
        resultMap.put("backlogList", backlogList);
        return resultMap;
    }

    /**
     * 获取待办事项
     *
     * @param backlogList
     * @param operatorId
     * @param busProcess
     * @param busProcess2
     * @param tableView
     * @param isAuthorization
     */
    private void getBacklog(List<Map<String, Object>> backlogList, String operatorId, String busProcess, String busProcess2, String tableView, boolean isAuthorization) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(4);
        paramMap.put("SO_ID", operatorId);
        paramMap.put("BUS_PROCESS", busProcess);
        paramMap.put("BUS_PROCESS2", busProcess2);
        paramMap.put("AUTHORIZATION", !isAuthorization ? null : getAuthorizationWhere(tableView));
        Map<String, Object> backlog = baseDao.selectOne(NameSpace.ManagerMapper, "selectProcessScheduleBacklog", paramMap);
        if (!isEmpty(backlog)) {
            backlogList.add(backlog);
        }
    }

    private String getAuthorizationWhere(String tableView) {
        return "SELECT ID FROM " + tableView + " WHERE 1=1 " + getAuthorizationWhere();
    }
}
