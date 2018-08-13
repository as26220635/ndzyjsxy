package cn.kim.service.impl;

import cn.kim.common.BaseData;
import cn.kim.common.attr.*;
import cn.kim.common.eu.NameSpace;
import cn.kim.common.eu.SystemEnum;
import cn.kim.common.sequence.Sequence;
import cn.kim.common.shiro.CustomRealm;
import cn.kim.dao.BaseDao;
import cn.kim.entity.Tree;
import cn.kim.entity.TreeState;
import cn.kim.exception.CustomException;
import cn.kim.service.BaseService;
import cn.kim.util.*;
import com.google.common.collect.Maps;
import com.sun.istack.internal.NotNull;
import com.sun.istack.internal.Nullable;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.security.InvalidKeyException;
import java.util.*;

/**
 * Created by 余庚鑫 on 2017/11/1.
 */

@Service
public abstract class BaseServiceImpl extends BaseData implements BaseService {

    /**
     * 数据库基础DAO
     */
    @Autowired
    protected BaseDao baseDao;
    /**
     * shiro域
     */
    @Autowired
    protected CustomRealm customRealm;


    /******************     公用方法    *********************/
    /**
     * 验证返回结果是否出错
     *
     * @param resultMap
     * @throws CustomException
     */
    protected void validateResultMap(Map<String, Object> resultMap) throws CustomException {
        if (toInt(resultMap.get(MagicValue.STATUS)) == STATUS_ERROR) {
            throw new CustomException(toString(resultMap.get(MagicValue.DESC)));
        }
    }

    /**
     * 返回参数
     *
     * @param code
     * @param message
     * @param value
     * @return
     */
    protected Map<String, Object> resultMap(int code, String message, Object value) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(3);
        resultMap.put("code", code);
        resultMap.put("message", message);
        resultMap.put("val", value);
        return resultMap;
    }

    /**
     * 捕获异常处理
     *
     * @param e
     * @param baseDao   回滚
     * @param resultMap
     * @return 异常提示
     */
    protected String catchException(@NotNull Exception e, @NotNull BaseDao baseDao, @NotNull Map<String, Object> resultMap) {
        String desc = "";
        if (e instanceof CustomException) {
            desc = e.getMessage();
        } else {
            desc = "网络异常,请联系管理员!";
        }
        resultMap.put(MagicValue.DESC, desc);
        resultMap.put(MagicValue.STATUS, STATUS_ERROR);
        resultMap.put(MagicValue.LOG, e.getMessage());
        //回滚
        baseDao.rollback();
        //输出异常
        e.printStackTrace();
        return desc;
    }

    /**
     * 递归菜单
     *
     * @param operatorId
     * @param menuParentId
     * @param selectId     选中菜单的ID
     * @param notParentId  不显示父的ID
     * @param roleMenus    当前角色拥有的菜单
     * @return
     */
    public List<Map<String, Object>> getOperatorMenuTree(BaseDao baseDao, NameSpace nameSpace, String sqlId, String operatorId, String menuParentId, @Nullable String selectId, @Nullable String notParentId, @Nullable Map<String, String> roleMenus) {
        List<Map<String, Object>> trees = new ArrayList<>();
        if (!isEmpty(notParentId) && menuParentId.equals(notParentId)) {
            return trees;
        }

        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(2);
        paramMap.put("SO_ID", operatorId);
        paramMap.put("SM_PARENTID", menuParentId);
        paramMap.put("NOT_ID", notParentId);

        List<Map<String, Object>> menus = baseDao.selectList(nameSpace, sqlId, paramMap);
        if (!ValidateUtil.isEmpty(menus)) {
            menus.forEach(menu -> {
                        String id = toString(menu.get("ID"));
                        //选中菜单
                        menu.put("IS_HAVE", false);
                        if (!isEmpty(selectId)) {
                            if (id.equals(selectId)) {
                                menu.put("IS_HAVE", true);
                            }
                        }
                        if (!isEmpty(roleMenus)) {
                            if (roleMenus.containsKey(id)) {
                                menu.put("IS_HAVE", true);
                            }
                        }
                        //连接url
                        String menuUrl = toString(menu.get("SM_URL"));
                        String menuUrlParams = toString(menu.get("SM_URL_PARAMS"));

                        menu.put("SM_URL", CommonUtil.getMenuUrlJoin(toString(menu.get("ID")), menuUrl, menuUrlParams));
                        trees.add(menu);
                    }
            );
        }

        if (!ValidateUtil.isEmpty(trees)) {
            for (Map<String, Object> tree : trees) {
                //遇到不是叶节点的 直接return;
                if ("-1".equals(selectId) && toInt(tree.get("SM_IS_LEAF")) == STATUS_ERROR) {
                    continue;
                }
                tree.put("CHILDREN_MENU", getOperatorMenuTree(baseDao, nameSpace, sqlId, operatorId, toString(tree.get("ID")), selectId, notParentId, roleMenus));
            }
        }
        return trees;
    }

    /**
     * 转为TREE 并选中已经选择的按钮
     *
     * @param roles
     * @param operatorRoles
     * @return
     */
    public List<Tree> getOperatorRoleTree(List<Map<String, Object>> roles, Map<String, String> operatorRoles) {
        List<Tree> operatorRoleTree = new ArrayList<>();
        if (!isEmpty(roles)) {
            roles.forEach(role -> {
                String id = toString(role.get("ID"));

                Tree tree = new Tree();
                tree.setId(id);
                tree.setText(toString(role.get("SR_NAME")));
                tree.setTags(new String[]{toString(role.get("SR_CODE"))});

                TreeState state = new TreeState();
                //是否选中
                if (!isEmpty(operatorRoles) && operatorRoles.containsKey(id)) {
                    state.setChecked(true);
                    //选中的设置打开
                    state.setExpanded(true);
                }

                //设置状态
                tree.setState(state);

                operatorRoleTree.add(tree);
            });
        }

        return operatorRoleTree;
    }

    /***
     * 插入账号  SYS_OPERATOR SYS_ACCOUNT_INFO
     * @param baseDao
     * @param accountInfoName
     * @param type
     * @return
     * @throws Exception
     */
    protected String insertOperator(BaseDao baseDao, Object accountInfoName, int type) throws Exception {
        //插入账号和账号信息
        String operatorId = getId();
        //插入账号和账号信息
        Map<String, Object> operatorMap = Maps.newHashMapWithExpectedSize(5);
        operatorMap.put("SVR_TABLE_NAME", TableName.SYS_OPERATOR);
        operatorMap.put("ID", operatorId);
        //设置账号和盐
        String salt = RandomSalt.salt();
        operatorMap.put("SO_SALT", salt);
        operatorMap.put("SO_PASSWORD", PasswordMd5.password(Constants.INITIAL_PASSWORD, salt));
        operatorMap.put("IS_STATUS", STATUS_SUCCESS);
        baseDao.insert(NameSpace.OperatorMapper, "insertOperator", operatorMap);

        //添加accountinfo表
        operatorMap.clear();
        operatorMap.put("SVR_TABLE_NAME", TableName.SYS_ACCOUNT_INFO);
        operatorMap.put("ID", getId());
        operatorMap.put("SO_ID", operatorId);
        operatorMap.put("SAI_NAME", toString(accountInfoName));
        operatorMap.put("SAI_TYPE", type);
        baseDao.insert(NameSpace.OperatorMapper, "insertAccountInfo", operatorMap);

        return operatorId;
    }

    /**
     * 排名
     *
     * @param list
     * @param score
     * @return
     */
    protected int rank(List<Integer> list, int score) {
        for (Integer i : list) {
            if (i == score) {
                return (int) (list.stream().filter(integer -> integer > i).count() + 1);
            }
        }
        return 0;
    }

    /**
     * 排名
     * -1 小于
     * 0 等于
     * 1 大于
     *
     * @param list
     * @param score
     * @return
     */
    protected int rank(List<BigDecimal> list, BigDecimal score) {
        for (BigDecimal i : list) {
            if (i.compareTo(score) == 0) {
                return (int) (list.stream().filter(integer -> integer.compareTo(i) == 1).count() + 1);
            }
        }
        return 0;
    }

    /**
     * 根据tableId获取流程进度
     *
     * @param tableId
     * @param process
     * @param process2
     * @return
     */
    protected Map<String, Object> getProcessSchedule(String tableId, String process, String process2) {
        if (isEmpty(tableId) || isEmpty(process) || isEmpty(process2)) {
            return null;
        }
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(4);
        paramMap.put("SPS_TABLE_ID", tableId);
        paramMap.put("SPS_IS_CANCEL", STATUS_ERROR);
        paramMap.put("BUS_PROCESS", process);
        paramMap.put("BUS_PROCESS2", process2);
        return baseDao.selectOne(NameSpace.ProcessMapper, "selectProcessSchedule", paramMap);
    }
}
