package cn.kim.common;

import cn.kim.remote.LogRemoteInterface;
import cn.kim.remote.LogRemoteInterfaceAsync;
import cn.kim.remote.impl.LogRemoteServiceImpl;
import org.redisson.Redisson;
import org.redisson.api.RRemoteService;
import org.redisson.api.RedissonClient;
import org.redisson.api.RemoteInvocationOptions;
import org.redisson.config.Config;
import org.redisson.spring.cache.RedissonSpringCacheManager;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.Resource;

import java.io.IOException;

/**
 * Created by 余庚鑫 on 2018/3/22.
 * redisson配置
 */
@Configuration
@ComponentScan
@EnableCaching
public class WebAppConfig {

    @Bean(destroyMethod = "shutdown")
    public RedissonClient redisson(@Value("classpath:redis/spring-redisson.yaml") Resource configFile) throws IOException {
        Config config = Config.fromYAML(configFile.getInputStream());
        return Redisson.create(config);
    }

    @Bean("cacheManager")
    public CacheManager cacheManager(RedissonClient redissonClient) throws IOException {
        return new RedissonSpringCacheManager(redissonClient, "classpath:redis/spring-cache-config.yaml");
    }

    /**
     * 异步
     *
     * @param redissonClient
     * @return
     */
    @Bean("remoteService")
    public RRemoteService rRemoteService(RedissonClient redissonClient) {
        RRemoteService remoteService = redissonClient.getRemoteService();
        LogRemoteInterface serviceImpl = new LogRemoteServiceImpl();
        remoteService.register(LogRemoteInterface.class, serviceImpl);

        return remoteService;
    }


    @Bean("LogRemoteInterfaceAsync")
    public LogRemoteInterfaceAsync logRemoteInterfaceAsync(RRemoteService remoteService) {
        RemoteInvocationOptions options = RemoteInvocationOptions.defaults().noAck().noResult();
        return remoteService.get(LogRemoteInterfaceAsync.class, options);
    }
}