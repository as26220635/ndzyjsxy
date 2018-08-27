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
        }
    }
}
