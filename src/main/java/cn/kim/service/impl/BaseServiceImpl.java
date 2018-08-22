package cn.kim.service.impl;

import cn.kim.common.BaseData;
import cn.kim.common.DaoSession;
import cn.kim.common.attr.*;
import cn.kim.common.eu.AuthorizationType;
import cn.kim.common.eu.NameSpace;
import cn.kim.common.eu.SystemEnum;
import cn.kim.common.shiro.CustomRealm;
import cn.kim.dao.BaseDao;
import cn.kim.entity.ActiveUser;
import cn.kim.entity.Tree;
import cn.kim.entity.TreeState;
import cn.kim.exception.CustomException;
import cn.kim.service.BaseService;
import cn.kim.util.*;
import com.google.common.collect.Maps;
import com.sun.istack.internal.NotNull;
import com.sun.istack.internal.Nullable;
import org.apache.shiro.authz.UnauthorizedException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
     * @param type 类型
     * @param tableId 类型关联id
     * @param accountInfoName 真实姓名
     * @return
     * @throws Exception
     */
    protected String insertOperator(BaseDao baseDao, int type, String tableId, Object accountInfoName) throws Exception {
        //插入账号和账号信息
        String operatorId = getId();
        //插入账号和账号信息
        Map<String, Object> operatorMap = Maps.newHashMapWithExpectedSize(5);
        operatorMap.put(MagicValue.SVR_TABLE_NAME, TableName.SYS_OPERATOR);
        operatorMap.put("ID", operatorId);
        //设置账号和盐
        String salt = RandomSalt.salt();
        operatorMap.put("SO_SALT", salt);
        operatorMap.put("SO_PASSWORD", PasswordMd5.password(Constants.INITIAL_PASSWORD, salt));
        operatorMap.put("IS_STATUS", STATUS_SUCCESS);
        baseDao.insert(NameSpace.OperatorMapper, "insertOperator", operatorMap);

        //添加accountinfo表
        operatorMap.clear();
        operatorMap.put(MagicValue.SVR_TABLE_NAME, TableName.SYS_ACCOUNT_INFO);
        operatorMap.put("ID", getId());
        operatorMap.put("SO_ID", operatorId);
        operatorMap.put("SAI_NAME", toString(accountInfoName));
        operatorMap.put("SAI_TABLE_ID", tableId);
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
        paramMap.put("SPS_IS_CANCEL", "0");
        paramMap.put("BUS_PROCESS", process);
        paramMap.put("BUS_PROCESS2", process2);
        return baseDao.selectOne(NameSpace.ProcessMapper, "selectProcessSchedule", paramMap);
    }

    /**
     * 连接行
     *
     * @param index
     * @return
     */
    protected String joinRowStr(int index) {
        return "第" + index + "行";
    }

    /**
     * 打包错误
     *
     * @param key
     * @param val
     * @return
     */
    protected String[] packErrorData(String key, String val) {
        String[] errors = {key, val};
        return errors;
    }

    /*****************  流程使用    *******************/

    /**
     * 获取当前用户授权过滤
     * 需要字段 院系BDM_COLLEGE 系部BDM_ID 班级BC_ID
     *
     * @return
     */
    protected String getAuthorizationWhere() {
        Map<String, Object> fieldMap = Maps.newHashMapWithExpectedSize(3);
        fieldMap.put(AuthorizationType.COLLEGE.toString(), "BDM_COLLEGE");
        fieldMap.put(AuthorizationType.DEPARTMENT.toString(), "BDM_ID");
        fieldMap.put(AuthorizationType.CLS.toString(), "BC_ID");
        return getAuthorizationWhere(false, fieldMap);
    }

    /**
     * 获取当前用户授权过滤 是否流程过滤
     *
     * @param isProcess
     * @param fieldMap
     * @return
     */
    protected String getAuthorizationWhere(boolean isProcess, Map<String, Object> fieldMap) {
        StringBuilder builder = new StringBuilder();

        //拿到当前用户的角色
        ActiveUser activeUser = getActiveUser();
        String operatorId = activeUser.getId();
        int type = toInt(activeUser.getType());

        if (type == SystemEnum.MANAGER.getType()) {
            //管理员不过滤
            return "";
        } else if (type == SystemEnum.DIVISION.getType() || type == SystemEnum.DEPARTMENT.getType()) {
            //系部和部门根据授权过滤
            //查询授权
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
            paramMap.put("SO_ID", operatorId);
            List<Map<String, Object>> authorizationList = DaoSession.daoSession.baseDao.selectList(NameSpace.AuthorizationMapper, "selectAuthorizationGroupBy", paramMap);
            if (!isEmpty(fieldMap) && !isEmpty(authorizationList)) {
                StringBuilder filterWhere = new StringBuilder();
                authorizationList.forEach(authorization -> {
                    int BA_TABLE_TYPE = toInt(authorization.get("BA_TABLE_TYPE"));
                    String BA_TABLE_ID = toString(authorization.get("BA_TABLE_ID"));
                    //查询字段
                    String field = toString(fieldMap.get(toString(BA_TABLE_TYPE)));
                    //字段没有传来就不查询
                    if (!isEmpty(field)) {
                        if (BA_TABLE_TYPE == AuthorizationType.COLLEGE.getType()) {
                            //院系
                            filterWhere.append(" OR " + field + " IN(" + BA_TABLE_ID + ") ");
                        } else if (BA_TABLE_TYPE == AuthorizationType.DEPARTMENT.getType()) {
                            //系部
                            filterWhere.append(" OR " + field + " IN(" + BA_TABLE_ID + ") ");
                        } else if (BA_TABLE_TYPE == AuthorizationType.CLS.getType()) {
                            //班级
                            filterWhere.append(" OR " + field + " IN(" + BA_TABLE_ID + ") ");
                        }
                    }
                });
                //过滤语句
                String filterString = filterWhere.toString();
                if (!isEmpty(filterString)) {
                    builder.append(" AND (" + TextUtil.interceptSymbol(filterString, " OR ") + ") ");
                }
            } else {
                //不查询出数据
                builder.append(" AND SO_ID = -1 ");
            }
        } else if (type == SystemEnum.STUDENT.getType()) {
            //学生
            if (isProcess) {
                builder.append(" AND (SO_ID = " + operatorId + " OR SHOW_SO_ID = " + operatorId + ")");
            } else {
                builder.append(" AND SO_ID = " + operatorId);
            }
        } else if (type == SystemEnum.TEACHER.getType()) {
            //教师
            if (isProcess) {
                builder.append(" AND (SO_ID = " + operatorId + " OR SHOW_SO_ID = " + operatorId + ")");
            } else {
                builder.append(" AND SO_ID = " + operatorId);
            }
        } else {
            throw new UnauthorizedException("当前用户类型错误!");
        }

        return builder.toString();
    }

    /**
     * 插入流程
     *
     * @param tableId
     * @param tableName
     * @param soId
     * @param showSoId
     * @param busProcess
     * @param busProcess2
     * @throws Exception
     */
    protected void createProcessSchedule(String tableId, String tableName, String soId, String showSoId, String busProcess, String busProcess2) throws Exception {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(6);
        paramMap.put("BUS_PROCESS", busProcess);
        paramMap.put("BUS_PROCESS2", busProcess2);
        Map<String, Object> definition = baseDao.selectOne(NameSpace.ProcessFixedMapper, "selectProcessDefinition", paramMap);
        if (isEmpty(definition)) {
            throw new CustomException("没有找到流程实例!");
        }
        paramMap.clear();
        paramMap.put("ID", getId());
        paramMap.put("SPD_ID", definition.get("ID"));
        paramMap.put("SO_ID", soId);
        paramMap.put("SHOW_SO_ID", showSoId);
        paramMap.put("SPS_TABLE_ID", tableId);
        paramMap.put("SPS_TABLE_NAME", tableName);
        paramMap.put("SPS_AUDIT_STATUS", "0");
        paramMap.put("SPS_BACK_STATUS", "0");
        paramMap.put("SPS_IS_CANCEL", "0");

        baseDao.insert(NameSpace.ProcessMapper, "insertProcessSchedule", paramMap);
    }
}
