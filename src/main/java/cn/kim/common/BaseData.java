package cn.kim.common;

import cn.kim.common.attr.MagicValue;
import cn.kim.common.eu.NameSpace;
import cn.kim.common.sequence.Sequence;
import cn.kim.dao.BaseDao;
import cn.kim.dao.impl.BaseDaoImpl;
import cn.kim.entity.ActiveUser;
import cn.kim.entity.ResultState;
import cn.kim.common.attr.Attribute;
import cn.kim.common.attr.ParamTypeResolve;
import cn.kim.common.attr.Tips;
import cn.kim.common.sequence.Sequence;
import cn.kim.entity.ResultState;
import cn.kim.entity.StudentYearSemester;
import cn.kim.util.*;
import com.google.common.collect.Maps;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.security.InvalidKeyException;
import java.util.*;

/**
 * Created by 余庚鑫 on 2018/3/31.
 * 基础数据
 */
public abstract class BaseData {

    protected static final String SERVICE_SPLIT = Attribute.SERVICE_SPLIT;

    protected static final int BACK_CODE = Attribute.BACK_CODE;
    protected static final int COMPLETE_CODE = Attribute.COMPLETE_CODE;

    protected static final int STATUS_SUCCESS = Attribute.STATUS_SUCCESS;
    protected static final int STATUS_ERROR = Attribute.STATUS_ERROR;
    protected static final String SAVE_SUCCESS = Tips.SAVE_SUCCESS;
    protected static final String SAVE_ERROR = Tips.SAVE_ERROR;
    protected static final String UPDATE_SUCCESS = Tips.UPDATE_SUCCESS;
    protected static final String UPDATE_ERROR = Tips.UPDATE_ERROR;
    protected static final String DELETE_SUCCESS = Tips.DELETE_SUCCESS;
    protected static final String DELETE_ERROR = Tips.DELETE_ERROR;
    protected static final String IMPORT_SUCCESS = Tips.IMPORT_SUCCESS;
    protected static final String IMPORT_ERROR = Tips.IMPORT_ERROR;
    
    protected static final String STATUS_SUCCESS_MESSAGE = "成功!";
    protected static final String STATUS_ERROR_MESSAGE = "失败!";


    /******************     公用方法    *********************/
    /**
     * 获取雪花ID
     *
     * @return
     */
    protected String getId() {
        return Sequence.getId();
    }

    /**
     * 获取登录账号信息
     *
     * @return
     */
    protected ActiveUser getActiveUser() {
        return AuthcUtil.getCurrentUser();
    }

    /**
     * 返回值
     *
     * @param resultMap
     * @return
     */
    protected ResultState resultState(Map<String, Object> resultMap) throws InvalidKeyException {
        //防止提交失败 不能再次提交
        resultMap.put(Attribute.SUBMIT_TOKEN_NAME, CommonUtil.idEncrypt(UUID.randomUUID().toString()));
        return ResultState.to(resultMap);
    }

    protected ResultState resultState(int status, String desc, String log) throws InvalidKeyException {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(3);
        resultMap.put(MagicValue.STATUS, status);
        resultMap.put(MagicValue.DESC, desc);
        resultMap.put(MagicValue.LOG, log);
        return resultState(resultMap);
    }

    protected ResultState resultSuccess(String desc) throws InvalidKeyException {
        return resultSuccess(desc, desc);
    }

    protected ResultState resultSuccess(String desc, String log) throws InvalidKeyException {
        return resultState(STATUS_SUCCESS, desc, log);
    }

    protected ResultState resultError() throws InvalidKeyException {
        return resultError("服务器响应失败,请重试!", "");
    }

    protected ResultState resultError(Exception e) throws InvalidKeyException {
        return resultError("服务器响应失败,请重试!", e.getMessage());
    }

    protected ResultState resultError(String log) throws InvalidKeyException {
        return resultError("服务器响应失败,请重试!", log);
    }

    protected ResultState resultError(String desc, String log) throws InvalidKeyException {
        return resultState(STATUS_ERROR, desc, log);
    }

    /**
     * 会否停用
     *
     * @param map
     * @return
     */
    protected boolean isDiscontinuation(Map<String, Object> map) {
        if (isEmpty(map)) {
            return true;
        }
        return toInt(map.get("IS_STATUS")) == STATUS_SUCCESS ? false : true;
    }

    /**
     * ID加密是否出错
     *
     * @param mapParam
     * @return
     */
    protected boolean isInvalidKey(Map<String, Object> mapParam) throws InvalidKeyException {
        if (!isEmpty(mapParam)) {
            for (Object o : mapParam.values()) {
                if (Attribute.INVALID_KEY_ERROR.equals(o)) {
                    throw new InvalidKeyException();
                }
            }
        }
        return false;
    }

    /**
     * 状态解释
     *
     * @param map
     * @return
     */
    protected String statusExplain(Map<String, Object> map) {
        return ParamTypeResolve.statusExplain(map.get("IS_STATUS"));
    }

    /**
     * 判断权限
     *
     * @param precode
     * @return
     */
    protected boolean isPermitted(String precode) {
        return AuthcUtil.isPermitted(precode);
    }

    /**
     * 验证当前角色是否存在
     *
     * @param containsRole
     * @return
     */
    protected boolean containsRole(String containsRole) {
        if (isEmpty(containsRole)) {
            return false;
        }
        try {
            String[] containsRoles = containsRole.split(SERVICE_SPLIT);
            String[] nowRoles = getActiveUser().getRoleIds().split(SERVICE_SPLIT);
            for (String role : containsRoles) {
                for (String nowRole : nowRoles) {
                    if (nowRole.equals(role)) {
                        return true;
                    }
                }
            }
        } catch (Exception e) {
        }

        return false;
    }

    /**
     * 获取验证角色和自身角色中存在的角色
     *
     * @param containsRole
     * @return
     */
    protected List<String> getExistRoleList(String containsRole) {
        List<String> existRoleList = new ArrayList<>();
        String[] containsRoles = containsRole.split(SERVICE_SPLIT);
        String[] nowRoles = getActiveUser().getRoleIds().split(SERVICE_SPLIT);
        for (String role : containsRoles) {
            for (String nowRole : nowRoles) {
                if (nowRole.equals(role)) {
                    existRoleList.add(nowRole);
                }
            }
        }
        if (isEmpty(existRoleList)) {
            existRoleList.add("-1");
        }
        return existRoleList;
    }

    /**
     * 加密
     *
     * @param val
     * @return
     * @throws InvalidKeyException
     */
    protected Object idEncrypt(Object val) throws InvalidKeyException {
        return CommonUtil.idEncrypt(val);
    }

    /**
     * 是否加密
     *
     * @param key
     * @param val
     * @return
     */
    protected boolean isEncrypt(Object key, Object val) {
        return CommonUtil.isEncrypt(key, val);
    }

    protected boolean isEncrypt(Object key, Class<?> type) {
        return CommonUtil.isEncrypt(key, type);
    }

    protected boolean isEncrypt(Object key, String type) {
        return CommonUtil.isEncrypt(key, type);
    }

    protected boolean isEncrypt(Object key, boolean isString) {
        return CommonUtil.isEncrypt(key, isString);
    }

    /**
     * 解密
     *
     * @param val
     * @return
     * @throws InvalidKeyException
     */
    protected Object idDecrypt(Object val) throws InvalidKeyException {
        return CommonUtil.idDecrypt(val);
    }

    protected String getPinYinHeadChar(String str) {
        return TextUtil.getPinYinHeadChar(str);
    }

    protected String toString(Object str) {
        return TextUtil.toString(str);
    }

    protected Integer toInt(Object str) {
        return TextUtil.toInt(str);
    }

    protected String getNumbers(String str) {
        return TextUtil.getNumbers(str);
    }

    protected BigDecimal toBigDecimal(Object bigDecimal) {
        return TextUtil.toBigDecimal(bigDecimal);
    }

    protected long toLong(Object str) {
        return TextUtil.toLong(str);
    }

    protected <T> List<T> toList(Object str) {
        return TextUtil.toList(str);
    }

    protected Map<?, ?> toMap(Object str) {
        return TextUtil.toMap(str);
    }

    protected boolean toBoolean(Object str) {
        return TextUtil.toBoolean(str);
    }

    protected <K> Set<K> toKeySet(Map<K, ?> map) {
        if (isEmpty(map)) {
            return null;
        }
        return map.keySet();
    }

    //验证
    protected boolean isEmpty(Object value) {
        return ValidateUtil.isEmpty(value);
    }

    protected boolean isEmpty(CharSequence value) {
        return ValidateUtil.isEmpty(value);
    }

    protected boolean isEmpty(Integer value) {
        return ValidateUtil.isEmpty(value);
    }

    protected boolean isEmpty(Long value) {
        return ValidateUtil.isEmpty(value);
    }

    protected boolean isEmpty(List<?> list) {
        return ValidateUtil.isEmpty(list);
    }

    protected boolean isEmpty(Map<?, ?> map) {
        return ValidateUtil.isEmpty(map);
    }

    protected boolean isEmpty(String[] value) {
        return ValidateUtil.isEmpty(value);
    }

    protected boolean isJson(String json) {
        return ValidateUtil.isJson(json);
    }

    /**
     * 是否成功
     *
     * @param resultMap
     * @return
     */
    protected boolean isSuccess(Map<String, Object> resultMap) {
        return toString(resultMap.get("status")).equals(toString(Attribute.STATUS_SUCCESS)) ? true : false;
    }

    /**
     * 获取当前日期
     *
     * @return
     */
    protected String getDate() {
        return DateUtil.getDate();
    }

    /**
     * 获取sql数据库日期
     *
     * @return
     */
    protected String getSqlDate() {
        return DateUtil.getSqlDate();
    }

    /**
     * 吧MAP中的一个参数作为KEY
     *
     * @param list
     * @param keys
     * @return
     */
    protected Map<String, String> toMapKey(List<Map<String, Object>> list, String... keys) {
        return CommonUtil.toMapKey(list, keys);
    }

    /**
     * 吧MAP中的一个参数作为KEY
     *
     * @param list
     * @param join
     * @param keys
     * @return
     */
    protected Map<String, String> toMapJoinKey(List<Map<String, Object>> list, String join, String... keys) {
        return CommonUtil.toMapJoinKey(list, join, keys);
    }

    /**
     * 吧map中的一个参数作为KEY 自身作为VALUE
     *
     * @param list
     * @param key
     * @return
     */
    protected Map<String, Map<String, Object>> toMapsKey(List<Map<String, Object>> list, String key) {
        return CommonUtil.toMapsKey(list, key);
    }

    /**
     * 格式化前台HTML颜色
     *
     * @param val
     * @param color
     * @return
     */
    protected String toHtmlBColor(Object val, String color) {
        return "<b style='color:" + color + "'>" + toString(val) + "</b>";
    }

    /**
     * 替换参数
     *
     * @param str
     * @param replaceMap
     * @return
     */
    protected String replaceMap(String str, Map<String, String> replaceMap) {
        for (String key : replaceMap.keySet()) {
            str = str.replaceAll(key, replaceMap.get(key));
        }
        return str;
    }

    /**
     * 获得当前学年
     *
     * @return
     */
    protected String getStudentYear() {
        //拿到当前年份
        int nowYear = DateUtil.getYear();
        //拿到当前月份
        int nowMonth = DateUtil.getMonth();

        if (nowMonth >= 9) {
            return nowYear + "~" + (nowYear + 1);
        } else {
            return (nowYear - 1) + "~" + nowYear;
        }
    }

    /**
     * 获得学期
     *
     * @return
     */
    protected int getStudentSemester() {
        //拿到当前月份
        int nowMonth = DateUtil.getMonth();

        if (nowMonth >= 9) {
            return 1;
        } else {
            return 2;
        }
    }


    /**
     * 根据时间设置学年和学期
     *
     * @param map
     * @param yearField
     * @param semesterField
     */
    protected Map<String, Object> setStudentYearSemester(Map<String, Object> map, String yearField, String semesterField) {
        map.put(yearField, getStudentYear());
        map.put(semesterField, getStudentSemester());

        return map;
    }

    /**
     * 检测文本中学年和学期是否正确
     *
     * @param title
     * @return
     */
    protected boolean checkStudentYearSemester(String title) {
        try {
            if (isEmpty(title)) {
                return false;
            }
            //去除空格
            title = TextUtil.replaceBlank(title);
            //2017-2018 中间符号的位置
            int startYearindex = title.indexOf("-");
            if (startYearindex == -1) {
                return false;
            }
            String year = title.substring(startYearindex - 4, startYearindex) + "-" + title.substring(startYearindex + 1, startYearindex + 5);
            if (!TextUtil.isStudentYear(year)) {
                return false;
            }
            if (!title.contains("第一学期") && !title.contains("第1学期") && !title.contains("第二学期") && !title.contains("第2学期")) {
                return false;
            }

            return true;
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * 根据标题解析出学年和学期
     * 空就返回当前的学年和学期
     *
     * @param title
     * @return
     */
    protected StudentYearSemester parseStudentYearSemester(String title) {
        StudentYearSemester studentYearSemester = new StudentYearSemester();
        if (checkStudentYearSemester(title)) {
            //去除空格
            title = TextUtil.replaceBlank(title);
            //2017-2018 中间符号的位置
            int startYearindex = title.indexOf("-");
            //2017-2018学年第一学期
            studentYearSemester.setYear(title.substring(startYearindex - 4, startYearindex) + "-" + title.substring(startYearindex + 1, startYearindex + 5));
            if (title.contains("第一学期") || title.contains("第1学期")) {
                studentYearSemester.setSemester(1);
                studentYearSemester.setSemesterStr("第一学期");
            } else if (title.contains("第二学期") || title.contains("第2学期")) {
                studentYearSemester.setSemester(2);
                studentYearSemester.setSemesterStr("第二学期");
            }
        } else {
            studentYearSemester.setYear(getStudentYear());
            studentYearSemester.setSemester(getStudentSemester());
        }

        return studentYearSemester;
    }

    /**
     * 检测标题中是否有班级字段
     * @param title
     * @return
     */
    protected boolean checkStudentClass(String title) {
        try {

        } catch (Exception e) {
            return false;
        }
        return true;
    }
}
