package cn.kim.util;

import cn.kim.common.attr.CacheName;
import cn.kim.common.shiro.cache.SpringCacheManagerWrapper;
import cn.kim.common.attr.CacheName;
import cn.kim.common.attr.TableName;
import cn.kim.common.shiro.cache.SpringCacheManagerWrapper;
import cn.kim.entity.DictType;
import lombok.extern.log4j.Log4j2;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.shiro.cache.Cache;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.util.List;

/**
 * Created by 余庚鑫 on 2017/5/7.
 * cache工具类
 */
@Component
@Log4j2
public class CacheUtil {

    @Autowired
    private SpringCacheManagerWrapper shiroCacheManager;
    private static CacheUtil cacheUtil;

    public void setCacheManager(SpringCacheManagerWrapper shiroCacheManager) {
        this.shiroCacheManager = shiroCacheManager;
    }

    @PostConstruct
    public void init() {
        cacheUtil = this;
        cacheUtil.shiroCacheManager = this.shiroCacheManager;
    }

    public static SpringCacheManagerWrapper getCacheManager() {
        return cacheUtil.shiroCacheManager;
    }

    public static void put(String cacheName, String key, Object value) {
        Cache cache = cacheUtil.shiroCacheManager.getCache(cacheName);
        cache.put(key, value);
    }

    public static Cache getCache(String cacheName) {
        return cacheUtil.shiroCacheManager.getCache(cacheName);
    }

    public static Object get(String cacheName, String key) {
        Cache cache = cacheUtil.shiroCacheManager.getCache(cacheName);
        return cache.get(key);
    }

    public static void remove(String cacheName, String key) {
        Cache cache = cacheUtil.shiroCacheManager.getCache(cacheName);
        cache.remove(key);
    }

    public static void clear(String cacheName) {
        log.info("移除缓存:" + cacheName + ",的全部缓存数据");
        cacheUtil.shiroCacheManager.getCache(cacheName).clear();
    }

    /***
     * 获取参数缓存
     * @param key
     * @return
     */
    public static Object getParam(String key) {
        return get(CacheName.VALUE_COLLECTION, key);
    }

    /**
     * 设置缓存
     *
     * @param key
     * @param value
     */
    public static void setParam(@NotNull String key, Object value) {
        put(CacheName.VALUE_COLLECTION, key, value);
    }
}