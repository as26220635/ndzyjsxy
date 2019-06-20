package cn.kim.util;

import cn.kim.common.attr.ConfigProperties;
import cn.kim.common.attr.MagicValue;
import cn.kim.controller.ManagerController;
import cn.kim.controller.reception.home.MyHomeController;
import cn.kim.tools.HttpClient;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Maps;
import org.apache.shiro.cache.Cache;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.ServletException;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2017/4/15.
 */
public class HttpUtil {

    public static HttpServletRequest getRequest() {
        return ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
    }

    public static HttpServletResponse getResponse() {
        return ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getResponse();
    }

    /**
     * 获取访问者IP
     *
     * @return
     */
    public static String getIpAddr() {
        return getIpAddr(getRequest());
    }

    /**
     * 获取访问者IP
     *
     * @param request
     * @return
     */
    public static String getIpAddr(HttpServletRequest request) {
        // 获取请求主机IP地址,如果通过代理进来，则透过防火墙获取真实IP地址
        String ip = request.getHeader("X-Forwarded-For");

        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
                ip = request.getHeader("Proxy-Client-IP");
            }
            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
                ip = request.getHeader("WL-Proxy-Client-IP");
            }
            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
                ip = request.getHeader("HTTP_CLIENT_IP");
            }
            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
                ip = request.getHeader("HTTP_X_FORWARDED_FOR");
            }
            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
                ip = request.getRemoteAddr();
            }
        } else if (ip.length() > 15) {
            String[] ips = ip.split(",");
            for (int index = 0; index < ips.length; index++) {
                String strIp = (String) ips[index];
                if (!("unknown".equalsIgnoreCase(strIp))) {
                    ip = strIp;
                    break;
                }
            }
        }
        return ip;
    }

    /**
     * 拿到完整URL
     *
     * @param request
     * @param isQuery 是否带URL参数
     * @return
     */
    public static String getUrl(HttpServletRequest request, boolean isQuery) {
        return request.getRequestURL() + (ValidateUtil.isEmpty(request.getQueryString()) ? "" : isQuery ? "?" + request.getQueryString() : "");
    }

    /**
     * 拿到服务器路径
     *
     * @return
     */
    public static String getContextPath() {
        return getRequest().getContextPath() + "/";
    }

    public static String getContextPath(HttpServletRequest request) {
        return request.getContextPath() + "/";
    }

    /**
     * 根据IP获取IP地址的信息
     *
     * @param ip
     * @return
     */
    public static String getIpAddressName(String ip) {
        String result = "未知";

        Map<String, String> params = Maps.newHashMapWithExpectedSize(1);
        params.put("query", ip);
        HttpClient httpClient = new HttpClient();
        Map<String, Object> getMap = httpClient.get(ConfigProperties.IP_SEARCH_URL, params);

        JSONObject jsonObject = JSONObject.parseObject(TextUtil.getSubBetween(TextUtil.toString(getMap.get(MagicValue.DESC)), "/\\*\\*/ip\\(", "\\);"));
        if (ValidateUtil.isEmpty(jsonObject)) {
            return result;
        }
        JSONArray dataArray = JSONArray.parseArray(jsonObject.getString("data"));

        if (ValidateUtil.isEmpty(dataArray) || ValidateUtil.isEmpty(dataArray) || dataArray.size() == 0) {
            return result;
        }

        JSONObject data = dataArray.getJSONObject(0);
        result = data.getString("location");
        return result;
    }

    /**
     * 判断缓存中是否存在这个东西,没有就存入
     *
     * @param cacheName
     * @param key
     * @return
     */
    public static boolean isExistenceInCache(String cacheName, String key) {
        Cache cache = CacheUtil.getCache(cacheName);
        boolean isFlag = true;
        try {
            isFlag = cache.get(key) != null;
            if (!isFlag) {
                cache.put(key, key);
            }
        } catch (Exception e) {
        }
        return isFlag;
    }

    /**
     * 拿到ajax中的传来的参数
     *
     * @param req
     * @return
     */
    public static String getRequestPayload(HttpServletRequest req) {
        StringBuilder sb = new StringBuilder();
        ServletInputStream reader = null;
        try {
            reader = req.getInputStream();
            byte[] buff = new byte[1024];
            int len;
            while ((len = reader.read(buff)) != -1) {

                sb.append(new String(buff), 0, len);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return sb.toString();
    }

    /**
     * 转发
     */
    public static void forward(HttpServletRequest request, HttpServletResponse response, String url, Map<String, Object> params) {
        try {
            if (!ValidateUtil.isEmpty(params)) {
                for (String key : params.keySet()) {
                    request.setAttribute(key, params.get(key));
                }
            }
            request.getRequestDispatcher(url).forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * 重定向
     *
     * @param response
     * @param url
     */
    public static void sendRedirect(HttpServletResponse response, String url) {
        try {
            response.sendRedirect(url);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * 获取后台管理的url
     *
     * @return
     */
    public static String getManagerHomeUrl() {
        return ManagerController.MANAGER_URL + "home";
    }

    /**
     * 获取前台管理的url
     *
     * @return
     */
    public static String getMyHomeUrl() {
        return MyHomeController.HOME_URL + "home";
    }
}
