package cn.kim.common;

import afu.org.checkerframework.checker.units.qual.A;
import cn.kim.common.attr.ConfigProperties;
import cn.kim.common.eu.NameSpace;
import cn.kim.controller.manager.BaseDataController;
import cn.kim.dao.BaseDao;
import cn.kim.service.*;
import cn.kim.util.*;
import cn.kim.common.attr.Attribute;
import cn.kim.entity.DictType;
import cn.kim.service.AllocationService;
import cn.kim.util.EmailUtil;
import com.google.common.collect.Maps;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.validation.support.BindingAwareConcurrentModel;
import org.springframework.web.servlet.ModelAndView;

import java.security.Security;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2017/7/3.
 * spring/mvc 启动完成后初始化数据
 */
@Component("DataInitialization")
public class DataInitialization implements ApplicationListener<ContextRefreshedEvent> {

    @Autowired
    public BaseDao baseDao;

    @Autowired
    private AllocationService allocationService;

    @Autowired
    private DataGridService dataGridService;

    @Autowired
    private MenuService menuService;


    @Override
    public void onApplicationEvent(ContextRefreshedEvent contextRefreshedEvent) {
        if (contextRefreshedEvent.getApplicationContext().getParent() == null) {
            //设置AES加密包
            Security.addProvider(new org.bouncycastle.jce.provider.BouncyCastleProvider());
            //加载字典
            DictUtil.initDictToCache();

            //加载邮箱配置
            EmailUtil.init();

            CacheUtil.clear(NameSpace.MenuMapper.getValue());
            CacheUtil.clear(NameSpace.ConfigureMapper.getValue());
            CacheUtil.clear(NameSpace.DbMapper.getValue());

            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(2);

            //启动刷新全部菜单缓存
            List<Map<String, Object>> menuList = menuService.selectMenuList(new HashMap<>());
            menuList.forEach(menu -> {
                menuService.queryMenuById(TextUtil.toString(menu.get("ID")));
                if (!ValidateUtil.isEmpty(menu.get("SC_ID"))) {
                    dataGridService.selectConfigureById(TextUtil.toString(menu.get("SC_ID")));
                    System.out.println("缓存菜单:" + menu.get("SM_NAME"));
                }
            });

            //缓存全库的表备注信息
            paramMap.put("TABLE_SCHEMA", ConfigProperties.DB_DBNAME);
            List<Map<String, Object>> tableList = baseDao.selectList(NameSpace.DbMapper, "selectDBTableName", paramMap);

            tableList.forEach(map -> {
                paramMap.clear();
                paramMap.put("TABLE_SCHEMA", ConfigProperties.DB_DBNAME);
                paramMap.put("TABLE_NAME", map.get("TABLE_NAME"));
                baseDao.selectList(NameSpace.DbMapper, "selectColumnsComment", paramMap);
            });
        }
    }
}
