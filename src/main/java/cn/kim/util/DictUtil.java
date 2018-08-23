package cn.kim.util;

import cn.kim.common.attr.Attribute;
import cn.kim.common.attr.CacheName;
import cn.kim.common.attr.TableName;
import cn.kim.common.eu.NameSpace;
import cn.kim.entity.DictInfo;
import cn.kim.entity.DictType;
import cn.kim.service.DictService;
import cn.kim.common.annotation.Validate;
import cn.kim.common.attr.Attribute;
import cn.kim.common.attr.CacheName;
import cn.kim.common.attr.TableName;
import cn.kim.common.shiro.cache.SpringCacheManagerWrapper;
import cn.kim.entity.DictInfo;
import cn.kim.entity.DictType;
import cn.kim.service.DictService;
import com.google.common.collect.Maps;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.shiro.cache.Cache;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/3/26
 * 字典工具
 */
@Component
public class DictUtil {
    private static Logger logger = LogManager.getLogger(DictUtil.class.getName());

    @Autowired
    private DictService dictService;
    private static DictUtil dictUtil;

    public void setDictService(DictService dictService) {
        this.dictService = dictService;
    }

    @PostConstruct
    public void init() {
        dictUtil = this;
        dictUtil.dictService = this.dictService;
    }

    /**
     * 加载字典到缓存
     */
    public static void initDictToCache() {
        System.out.println("====加载字典到缓存=====");
        //清空字典表缓存
        CacheUtil.clear(NameSpace.DictMapper.getValue());
        //清空文件表缓存
        CacheUtil.clear(NameSpace.FileMapper.getValue());
        //清空cache
        CacheUtil.clear(CacheName.DICT_CACHE);

        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(3);
        //查询全部字典类型
        mapParam.put("IS_STATUS", Attribute.STATUS_SUCCESS);
        List<DictType> dictTypes = dictUtil.dictService.selectDictTypeList(mapParam);

        dictTypes.stream().forEach(dictType -> {
            mapParam.clear();
            mapParam.put("SDT_ID", dictType.getId());
            mapParam.put("SDI_PARENTID", "0");
            mapParam.put("IS_STATUS", Attribute.STATUS_SUCCESS);
            dictType.setInfos(dictUtil.dictService.selectDictInfoList(mapParam));
            //放入缓存中
            setDictType(dictType);
        });
    }

    /**
     * 设置字典缓存
     *
     * @param dict
     */
    public static void setDictType(DictType dict) {
        CacheUtil.put(CacheName.DICT_CACHE, dict.getSdtCode(), dict);
    }

    /**
     * 根据SDT_CODE获取字典
     *
     * @return
     */
    @Nullable
    public static DictType getDictType(String sdtCode) {
        Cache cache = CacheUtil.getCache(CacheName.DICT_CACHE);
        if (ValidateUtil.isEmpty(cache)) {
            initDictToCache();
            cache = CacheUtil.getCache(CacheName.DICT_CACHE);
        }
        Object val = cache.get(sdtCode);

        return ValidateUtil.isEmpty(val) ? null : (DictType) val;
    }

    /**
     * 根据字典类型和字典编码获取字典名称
     *
     * @param dictTypeCode
     * @param dictInfoCode
     * @return
     */
    public static String getDictName(@NotNull String dictTypeCode, Object dictInfoCode) {
        String result = TextUtil.toString(dictInfoCode);

        DictType dictType = getDictType(dictTypeCode.toUpperCase());
        if (ValidateUtil.isEmpty(dictType)) {
            return result;
        }
        List<DictInfo> dictInfoList = dictType.getInfos();
        if (ValidateUtil.isEmpty(dictInfoList)) {
            return result;
        }
        String dictName = getDictName(dictInfoList, dictInfoCode);
        if (ValidateUtil.isEmpty(dictName)) {
            return result;
        }

        return dictName;
    }

    /**
     * 递归查询字典名称
     *
     * @param dictInfoList
     * @param dictInfoCode
     * @return
     */
    public static String getDictName(@NotNull List<DictInfo> dictInfoList, Object dictInfoCode) {
        String result = "";
        for (DictInfo dictInfo : dictInfoList) {
            if (dictInfo.getSdiCode().equals(dictInfoCode)) {
                return dictInfo.getSdiName();
            }
            if (!ValidateUtil.isEmpty(dictInfo.getChildren())) {
                result = getDictName(dictInfo.getChildren(), dictInfoCode);
                if (!ValidateUtil.isEmpty(result)) {
                    return result;
                }
            }
        }

        return result;
    }

    /**
     * 根据字典类型和字典名称获取字典编码
     *
     * @param dictTypeCode
     * @param dictInfoName
     * @return
     */
    public static String getDictCode(@NotNull String dictTypeCode, Object dictInfoName) {
        String result = TextUtil.toString(dictInfoName);

        DictType dictType = getDictType(dictTypeCode.toUpperCase());
        if (ValidateUtil.isEmpty(dictType)) {
            return result;
        }
        List<DictInfo> dictInfoList = dictType.getInfos();
        if (ValidateUtil.isEmpty(dictInfoList)) {
            return result;
        }
        String dictCode = getDictCode(dictInfoList, dictInfoName);
        if (ValidateUtil.isEmpty(dictCode)) {
            return result;
        }

        return dictCode;
    }

    /**
     * 递归 根据字典类型和字典名称获取字典编码
     *
     * @param dictInfoList
     * @param dictInfoName
     * @return
     */
    public static String getDictCode(@NotNull List<DictInfo> dictInfoList, Object dictInfoName) {
        String result = "";
        for (DictInfo dictInfo : dictInfoList) {
            if (dictInfo.getSdiName().equals(dictInfoName)) {
                return dictInfo.getSdiCode();
            }
            if (!ValidateUtil.isEmpty(dictInfo.getChildren())) {
                result = getDictCode(dictInfo.getChildren(), dictInfoName);
                if (!ValidateUtil.isEmpty(result)) {
                    return result;
                }
            }
        }

        return result;
    }
}
