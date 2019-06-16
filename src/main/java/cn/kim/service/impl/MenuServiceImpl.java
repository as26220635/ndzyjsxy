package cn.kim.service.impl;

import cn.kim.common.attr.*;
import cn.kim.common.eu.NameSpace;
import cn.kim.dao.BaseDao;
import cn.kim.exception.CustomException;
import cn.kim.service.MenuService;
import cn.kim.util.CacheUtil;
import cn.kim.util.ValidateUtil;
import com.google.common.collect.Maps;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * Created by 余庚鑫 on 2018/3/21
 */
@Service
public class MenuServiceImpl extends BaseServiceImpl implements MenuService {


    @Override
    public Map<String, Object> selectMenu(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(4);
        paramMap.put("ID", mapParam.get("ID"));
        paramMap.put("SM_PARENTID", mapParam.get("SM_PARENTID"));
        paramMap.put("SM_URL", mapParam.get("SM_URL"));
        paramMap.put("SM_CODE", mapParam.get("SM_CODE"));
        return baseDao.selectOne(NameSpace.MenuMapper, "selectMenu", paramMap);
    }

    @Override
    public List<Map<String, Object>> selectMenuList(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(2);
        paramMap.put("SO_ID", mapParam.get("SO_ID"));
        paramMap.put("SM_PARENTID", mapParam.get("SM_PARENTID"));
        return baseDao.selectList(NameSpace.MenuMapper, "selectMenu", paramMap);
    }

    /**
     * 获取全部菜单
     *
     * @return
     */
    @Override
    public List<Map<String, Object>> queryMenuList() {
        return selectMenuList(new HashMap<>(0));
    }

    /**
     * 获取菜单树
     *
     * @param selectId    选中ID
     * @param notParentId 不显示父ID
     * @return
     */
    @Override
    public List<Map<String, Object>> selectMenuTreeSelectID(String selectId, String notParentId) {
        return getOperatorMenuTree(baseDao, NameSpace.MenuMapper, "selectMenu", null, "0", selectId, notParentId, null);
    }

    /**
     * 查询菜单
     *
     * @param id
     * @return
     */
    @Override
    public Map<String, Object> queryMenuById(String id) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("ID", id);
        return baseDao.selectOne(NameSpace.MenuMapper, "selectMenu", paramMap);
    }

    /**
     * 插入或菜单
     *
     * @param mapParam
     * @return
     */
    @Override
    @Transactional
    public Map<String, Object> insertAndUpdateMenu(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            if (!isEmpty(mapParam.get("ID")) && !isEmpty(mapParam.get("SM_PARENTID")) &&
                    toString(mapParam.get("ID")).equals(toString(mapParam.get("SM_PARENTID")))) {
                throw new CustomException("不能选择自身!");
            }
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(16);
            String id = toString(mapParam.get("ID"));
            //查询权限编码是否重复
//            if (!isEmpty(mapParam.get("SM_CODE"))) {
//                paramMap.put("NOT_ID", id);
//                paramMap.put("SM_CODE", mapParam.get("SM_CODE"));
//                int count = baseDao.selectOne(NameSpace.MenuMapper, "selectMenuCount", paramMap);
//                if (count > 0) {
//                    throw new CustomException("菜单权限编码重复,请检查!");
//                }
//            }

            paramMap.clear();
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.SYS_MENU);

            paramMap.put("ID", id);
            paramMap.put("SC_ID", mapParam.get("SC_ID"));
            paramMap.put("SM_NAME", mapParam.get("SM_NAME"));
            //父ID默认为0
            paramMap.put("SM_PARENTID", isEmpty(mapParam.get("SM_PARENTID")) ? MagicValue.ZERO : mapParam.get("SM_PARENTID"));
            paramMap.put("SM_CODE", mapParam.get("SM_CODE"));
            paramMap.put("SM_URL", mapParam.get("SM_URL"));
            paramMap.put("SM_URL_PARAMS", mapParam.get("SM_URL_PARAMS"));
            paramMap.put("SM_CLASSICON", mapParam.get("SM_CLASSICON"));
            paramMap.put("BUS_PROCESS", mapParam.get("BUS_PROCESS"));
            paramMap.put("BUS_PROCESS2", mapParam.get("BUS_PROCESS2"));
            paramMap.put("SM_IS_LEAF", mapParam.get("SM_IS_LEAF"));
            paramMap.put("SM_IS_EXPAND", mapParam.get("SM_IS_EXPAND"));
            paramMap.put("SM_TYPE", mapParam.get("SM_TYPE"));
            paramMap.put("SM_ORDER", mapParam.get("SM_ORDER"));
            paramMap.put("IS_STATUS", mapParam.get("IS_STATUS"));

            if (isEmpty(id)) {
                id = getId();
                paramMap.put("ID", id);
                paramMap.put("SM_TYPE", mapParam.get("SM_TYPE"));
                paramMap.put("IS_STATUS", Attribute.STATUS_SUCCESS);

                baseDao.insert(NameSpace.MenuMapper, "insertMenu", paramMap);
                resultMap.put(MagicValue.LOG, "添加菜单:" + formatColumnName(TableName.SYS_MENU, paramMap));
            } else {
                Map<String, Object> oldMap = queryMenuById(id);

                baseDao.update(NameSpace.MenuMapper, "updateMenu", paramMap);
                resultMap.put(MagicValue.LOG, "更新菜单,更新前:" + formatColumnName(TableName.SYS_MENU, oldMap) + ",更新后:" + formatColumnName(TableName.SYS_MENU, paramMap));
            }
            status = STATUS_SUCCESS;
            desc = SAVE_SUCCESS;

            resultMap.put("ID", id);
        } catch (Exception e) {
            desc = catchException(e, baseDao, resultMap);
        }
        resultMap.put(MagicValue.STATUS, status);
        resultMap.put(MagicValue.DESC, desc);
        return resultMap;
    }

    /**
     * 更新菜单变更状态
     *
     * @param mapParam
     * @return
     */
    @Override
    @Transactional
    public Map<String, Object> changeMenuStatus(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(2);
            String id = toString(mapParam.get("ID"));

            paramMap.put("ID", id);
            paramMap.put("IS_STATUS", mapParam.get("IS_STATUS"));

            Map<String, Object> oldMap = queryMenuById(id);
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.SYS_MENU);
            baseDao.update(NameSpace.MenuMapper, "updateMenu", paramMap);
            resultMap.put(MagicValue.LOG, "更新菜单状态,菜单:" + toString(oldMap.get("SM_NAME")) + ",状态更新为:" + ParamTypeResolve.statusExplain(mapParam.get("IS_STATUS")));

            status = STATUS_SUCCESS;
            desc = SAVE_SUCCESS;

            resultMap.put("ID", id);
        } catch (Exception e) {
            desc = catchException(e, baseDao, resultMap);
        }
        resultMap.put(MagicValue.STATUS, status);
        resultMap.put(MagicValue.DESC, desc);
        return resultMap;
    }

    /**
     * 更新菜单关联按钮
     *
     * @param mapParam
     * @return
     */
    @Override
    @Transactional
    public Map<String, Object> updateMenuButton(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(3);
            String id = toString(mapParam.get("ID"));
            //选中的按钮ID
            String[] buttonIds = toString(mapParam.get("BUTTONIDS")).split(SERVICE_SPLIT);

            //查询菜单
            Map<String, Object> menu = queryMenuById(id);
            //查询sys_menu_button表
            paramMap.clear();
            paramMap.put("SM_ID", id);
            Map<String, String> oldMenuButtonIds = toMapKey(baseDao.selectList(NameSpace.MenuMapper, "selectMenuButton", paramMap), "SB_ID");
            //新菜单权限
            Map<String, String> newMenuButtonIds = Arrays.stream(buttonIds).collect(Collectors.toMap(String::toString, String::toString));

            //原来没有的就添加
            if (!isEmpty(newMenuButtonIds)) {
                for (String buttonId : newMenuButtonIds.keySet()) {
                    if (!isEmpty(buttonId)) {
                        if (isEmpty(oldMenuButtonIds) || !oldMenuButtonIds.containsKey(buttonId)) {
                            //添加
                            paramMap.clear();
                            paramMap.put("ID", getId());
                            paramMap.put("SM_ID", id);
                            paramMap.put("SB_ID", buttonId);
                            baseDao.insert(NameSpace.MenuMapper, "insertMenuButton", paramMap);
                        }
                    }
                }
            }
            //新的菜单id 旧的还存在的就要删除
            if (!isEmpty(oldMenuButtonIds)) {
                for (String oldButtonId : oldMenuButtonIds.keySet()) {
                    if (!isEmpty(oldButtonId)) {
                        if (isEmpty(newMenuButtonIds) || !newMenuButtonIds.containsKey(oldButtonId)) {
                            //删除
                            paramMap.clear();
                            paramMap.put("SM_ID", id);
                            paramMap.put("SB_ID", oldButtonId);
                            baseDao.delete(NameSpace.MenuMapper, "deleteMenuButton", paramMap);
                        }
                    }
                }
            }
            //清除缓存
            customRealm.clearCached();
            CacheUtil.clear(NameSpace.MenuMapper.getValue());

            status = STATUS_SUCCESS;
            desc = UPDATE_SUCCESS;

            resultMap.put("ID", id);
            resultMap.put(MagicValue.LOG, "菜单:" + menu.get("SM_NAME") + ",旧按钮:" + toString(toKeySet(oldMenuButtonIds)) + ",新按钮:" + toString(toKeySet(newMenuButtonIds)));
        } catch (Exception e) {
            desc = catchException(e, baseDao, resultMap);
        }

        resultMap.put(MagicValue.STATUS, status);
        resultMap.put(MagicValue.DESC, desc);
        return resultMap;
    }

    @Override
    @Transactional
    public Map<String, Object> deleteMenu(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = DELETE_ERROR;
        try {
            if (isEmpty(mapParam.get("ID"))) {
                throw new CustomException(Tips.ID_NULL_ERROR);
            }
            Map<String, Object> oldMap = queryMenuById(toString(mapParam.get("ID")));

            deleteMenuByParentId(baseDao, toString(mapParam.get("ID")));

            resultMap.put(MagicValue.LOG, "删除菜单,信息:" + formatColumnName(TableName.SYS_MENU, oldMap));
            status = STATUS_SUCCESS;
            desc = DELETE_SUCCESS;
        } catch (Exception e) {
            desc = catchException(e, baseDao, resultMap);
        }
        resultMap.put(MagicValue.STATUS, status);
        resultMap.put(MagicValue.DESC, desc);
        return resultMap;
    }

    @Override
    public List<Map<String, Object>> selectOperatorNowMenu(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(3);
        paramMap.put("SM_ID", mapParam.get("SM_ID"));
        paramMap.put("SO_ID", mapParam.get("SO_ID"));
        paramMap.put("SB_TYPE", mapParam.get("SB_TYPE"));
        return baseDao.selectList(NameSpace.MenuMapper, "selectOperatorNowMenu", paramMap);
    }

    /**
     * 拷贝菜单
     *
     * @param mapParam
     * @return
     */
    @Override
    @Transactional
    public Map<String, Object> copyMenu(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {

            String ID = toString(mapParam.get("ID"));
            String SM_PARENTID = isEmpty(mapParam.get("SM_PARENTID")) ? "0" : toString(mapParam.get("SM_PARENTID"));
            String SM_NAME = toString(mapParam.get("SM_NAME"));
            String SM_CODE = toString(mapParam.get("SM_CODE"));

            Map<String, Object> menu = this.queryMenuById(ID);
            Map<String, String> replaceMap = Maps.newHashMapWithExpectedSize(2);
            replaceMap.put(toString(menu.get("SM_NAME")), SM_NAME);
            replaceMap.put(toString(menu.get("SM_CODE")), SM_CODE);

            copyMenuByParentId(baseDao, ID, SM_PARENTID, replaceMap);

            resultMap.put(MagicValue.LOG, "拷贝菜单:" + formatColumnName(TableName.SYS_MENU, menu));

            status = STATUS_SUCCESS;
            desc = SAVE_SUCCESS;
        } catch (Exception e) {
            desc = catchException(e, baseDao, resultMap);
        }
        resultMap.put(MagicValue.STATUS, status);
        resultMap.put(MagicValue.DESC, desc);
        return resultMap;
    }

    /**
     * 递归复制菜单
     *
     * @param baseDao
     * @param menuId
     * @param copyMenuParentId
     * @param replaceMap
     */
    public void copyMenuByParentId(BaseDao baseDao, String menuId, String copyMenuParentId, Map<String, String> replaceMap) throws Exception {
        if (isEmpty(menuId)) {
            return;
        }
        String newMenuId = getId();
        Map<String, Object> menu = this.queryMenuById(menuId);
        menu.put("ID", newMenuId);
        menu.put("SM_NAME", replaceMap(toString(menu.get("SM_NAME")), replaceMap));
        menu.put("SM_CODE", replaceMap(toString(menu.get("SM_CODE")), replaceMap));
        menu.put("SM_PARENTID", copyMenuParentId);

        baseDao.insert(NameSpace.MenuMapper, "insertMenu", menu);

        //插入菜单按钮
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("SM_ID", menuId);
        List<Map<String, Object>> menuButtonList = baseDao.selectList(NameSpace.MenuMapper, "selectMenuButton", paramMap);

        for (Map<String, Object> button : menuButtonList) {
            button.put("ID", getId());
            button.put("SM_ID", newMenuId);
            baseDao.insert(NameSpace.MenuMapper, "insertMenuButton", button);
        }
        //查询子类
        paramMap.clear();
        paramMap.put("SM_PARENTID", menuId);
        List<Map<String, Object>> menuList = baseDao.selectList(NameSpace.MenuMapper, "selectMenu", paramMap);
        if (!isEmpty(menuList)) {
            for (Map<String, Object> childrenMenu : menuList) {
                this.copyMenuByParentId(baseDao, toString(childrenMenu.get("ID")), newMenuId, replaceMap);
            }
        }
    }

    /**
     * 递归删除菜单
     *
     * @param baseDao
     * @param menuParentId
     * @throws Exception
     */
    public void deleteMenuByParentId(BaseDao baseDao, String menuParentId) throws Exception {
        if (isEmpty(menuParentId)) {
            return;
        }
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("SM_ID", menuParentId);
        //删除菜单关联按钮
        baseDao.delete(NameSpace.MenuMapper, "deleteMenuButton", paramMap);
        //删除菜单角色关联按钮表
        paramMap.clear();
        paramMap.put("SM_ID", menuParentId);
        List<Map<String, Object>> roleMenus = baseDao.selectList(NameSpace.RoleMapper, "selectRoleMenu", paramMap);
        for (Map<String, Object> roleMenu : roleMenus) {
            paramMap.clear();
            paramMap.put("SRM_ID", roleMenu.get("ID"));
            baseDao.delete(NameSpace.RoleMapper, "deleteRoleButton", paramMap);
        }
        //删除菜单角色关联菜单表
        paramMap.clear();
        paramMap.put("SM_ID", menuParentId);
        baseDao.delete(NameSpace.RoleMapper, "deleteRoleMenu", paramMap);
        //先删除自身
        paramMap.clear();
        //记录日志
        paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.SYS_MENU);
        paramMap.put("ID", menuParentId);
        baseDao.delete(NameSpace.MenuMapper, "deleteMenu", paramMap);
        //查询子菜单
        paramMap.clear();
        paramMap.put("SM_PARENTID", menuParentId);
        List<Map<String, Object>> menus = this.selectMenuList(paramMap);
        if (!ValidateUtil.isEmpty(menus)) {
            for (Map<String, Object> menu : menus) {
                deleteMenuByParentId(baseDao, toString(menu.get("ID")));
            }
        }
    }
}
