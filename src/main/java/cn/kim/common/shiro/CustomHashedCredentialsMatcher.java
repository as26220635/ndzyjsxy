package cn.kim.common.shiro;

import cn.kim.common.attr.*;
import cn.kim.common.eu.UseType;
import cn.kim.entity.ActiveUser;
import cn.kim.remote.LogRemoteInterfaceAsync;
import cn.kim.service.ManagerService;
import cn.kim.util.*;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.ExcessiveAttemptsException;
import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.cache.Cache;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * Created by 余庚鑫 on 2017/4/22.
 * 如果是自动登录就直接判断md5，密码错误5次直接等待10分钟
 */
public class CustomHashedCredentialsMatcher extends HashedCredentialsMatcher {

    @Autowired
    private ManagerService managerService;

    @Autowired
    private LogRemoteInterfaceAsync logRemoteInterfaceAsync;

    @Override
    public boolean doCredentialsMatch(AuthenticationToken authcToken, AuthenticationInfo info) {
        CaptchaUsernamePasswordToken token = (CaptchaUsernamePasswordToken) authcToken;
        if (token.isAuto()) {
            Object accountCredentials = getCredentials(info);
            String pwd = String.valueOf(token.getPassword());
            return ((SimpleHash) accountCredentials).toString().equals(pwd);
        } else {
            String username = token.getUsername();
            Cache cache = CacheUtil.getCache(CacheName.PASSWORD_RETRY_CACHE);

            AtomicInteger retryCount = ValidateUtil.isEmpty(cache.get(username)) ? null : (AtomicInteger) cache.get(username);
            if (retryCount == null) {
                retryCount = new AtomicInteger();
            }
            //连续登录5次失败
            if (retryCount.get() >= 5) {
                throw new ExcessiveAttemptsException();
            }
            //查询账号
            Map<String, Object> user = managerService.queryLoginUsername(token.getUsername());

            //成功失败都记录日志
            ActiveUser activeUser = new ActiveUser();
            //设置类型
            activeUser.setType(TextUtil.toString(user.get("SAI_TYPE")));
            activeUser.setId(TextUtil.toString(user.get("ID")));
            activeUser.setUsername(TextUtil.toString(user.get("SOS_USERNAME")));
            activeUser.setUsercode(TextUtil.toString(user.get("SAI_NAME")));
            activeUser.setTableId(TextUtil.toString(user.get("SAI_TABLE_ID")));
            activeUser.setRole(TextUtil.toString(user.get("SR_NAME")));
            activeUser.setRoleIds(TextUtil.toString(user.get("SR_ID")));
            activeUser.setIsDefaultPwd(TextUtil.toInt(user.get("IS_DEFAULT_PWD")));
            activeUser.setTypeName(ParamTypeResolve.getOpeatorTypeName(activeUser.getType()));

            //获得登录地址
            String ip = HttpUtil.getIpAddr(HttpUtil.getRequest());
            //清除验证码SESSION
            SessionUtil.remove("validateCode");
            //密码是否输入正确
            boolean matchs = super.doCredentialsMatch(token, info);
            if (matchs) {
                //移除输入失败记录
                cache.remove(username);
                //设置到session中
                SessionUtil.set(Constants.SESSION_USERNAME, activeUser);

                //记录日志
                logRemoteInterfaceAsync.recordLoginLog(ip, activeUser.getId(), MagicValue.LOG_LOGIN_EVENT, "登录成功!登录地址:#{IP_ADDRESS},登录时间:" + DateUtil.getDate(), UseType.PERSONAL.getType(), Attribute.STATUS_SUCCESS);
            } else {
                retryCount.getAndIncrement();
                cache.put(username, retryCount);
                SessionUtil.set(Constants.SESSION_USERNAME, activeUser);
                //记录日志
                logRemoteInterfaceAsync.recordLoginLog(ip, activeUser.getId(), MagicValue.LOG_LOGIN_EVENT, "登录失败!第" + retryCount.get() + "次!登录地址:#{IP_ADDRESS},登录时间:" + DateUtil.getDate(), UseType.PERSONAL.getType(), Attribute.STATUS_ERROR);
                SessionUtil.remove(Constants.SESSION_USERNAME);
            }
            return matchs;
        }
    }
}