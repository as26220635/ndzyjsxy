package cn.kim.service.impl;

import cn.kim.common.BaseData;
import cn.kim.common.DaoSession;
import cn.kim.common.attr.*;
import cn.kim.common.eu.*;
import cn.kim.common.shiro.CustomRealm;
import cn.kim.dao.BaseDao;
import cn.kim.entity.ActiveUser;
import cn.kim.entity.Tree;
import cn.kim.entity.TreeState;
import cn.kim.exception.CustomException;
import cn.kim.service.BaseService;
import cn.kim.service.ProcessService;
import cn.kim.tools.ProcessTool;
import cn.kim.util.*;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import lombok.extern.java.Log;
import lombok.extern.log4j.Log4j2;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;
import org.apache.shiro.authz.UnauthorizedException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * Created by 余庚鑫 on 2017/11/1.
 */

@Service
@Log4j2
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
        String desc = catchExceptionMessage(e);
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
     * 根据ID获取操作人
     *
     * @param operatorId
     * @return
     */
    public Map<String, Object> getOperatorById(String operatorId) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("ID", operatorId);
        return baseDao.selectOne(NameSpace.OperatorMapper, "selectOperator", paramMap);
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
        List<Map<String, Object>> trees = Lists.newArrayList();
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
        List<Tree> operatorRoleTree = Lists.newArrayList();
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
        return this.insertOperator(baseDao, type, tableId, accountInfoName, null, null);
    }

    /***
     * 插入账号  SYS_OPERATOR SYS_ACCOUNT_INFO
     * @param baseDao
     * @param type 类型
     * @param tableId 类型关联id
     * @param accountInfoName 真实姓名
     * @param accountPhone 手机号
     * @param accountEmail 邮箱
     * @return
     * @throws Exception
     */
    protected String insertOperator(BaseDao baseDao, int type, String tableId, Object accountInfoName, Object accountPhone, Object accountEmail) throws Exception {
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
        operatorMap.put("SAI_PHONE", accountPhone);
        operatorMap.put("SAI_EMAIL", accountEmail);
        operatorMap.put("SAI_TABLE_ID", tableId);
        operatorMap.put("SAI_TYPE", type);
        baseDao.insert(NameSpace.OperatorMapper, "insertAccountInfo", operatorMap);

        return operatorId;
    }

    /**
     * 插入登入账号  SYS_OPERATOR_SUB
     *
     * @param baseDao
     * @param operatorId 用户id
     * @param userName   用户名
     */
    protected void insertOperatorSub(BaseDao baseDao, String operatorId, String userName) throws Exception {
        Map<String, Object> operatorMap = Maps.newHashMapWithExpectedSize(6);
        operatorMap.put(MagicValue.SVR_TABLE_NAME, TableName.SYS_OPERATOR_SUB);
        operatorMap.put("ID", getId());
        operatorMap.put("SO_ID", operatorId);
        operatorMap.put("SOS_USERNAME", userName);
        operatorMap.put("SOS_CREATETIME", getDate());
        operatorMap.put("SOS_DEFAULT", STATUS_SUCCESS);
        operatorMap.put("IS_STATUS", STATUS_SUCCESS);
        baseDao.insert(NameSpace.OperatorMapper, "insertOperatorSub", operatorMap);
    }

    /**
     * 插入用户所属角色
     *
     * @param baseDao
     * @param operatorId 用户id
     * @param roleCode   角色编码
     */
    protected void insertOperatorRole(BaseDao baseDao, String operatorId, String roleCode) throws Exception {
        Map<String, Object> role = this.selectRoleByCode(roleCode);
        if (isEmpty(role)) {
            throw new NullPointerException("根据角色编码没有查询到角色!");
        }

        //插入用户所属角色
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(3);
        paramMap.put("ID", getId());
        paramMap.put("SO_ID", operatorId);
        paramMap.put("SR_ID", role.get("ID"));
        baseDao.insert(NameSpace.OperatorMapper, "insertOperatorRole", paramMap);
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

    /**
     * 检测是否为空
     *
     * @param row        行
     * @param dataArray  数据
     * @param indexArray 检测位
     */
    protected List<String[]> checkIsEmpty(String row, String[] dataArray, int[] indexArray) {
        List<String[]> checkIsEmptyList = Lists.newArrayList();
        for (int index : indexArray) {
            if (index > dataArray.length) {
                checkIsEmptyList.add(packErrorData(row, "数据错误"));
                break;
            }
            if (isEmpty(dataArray[index])) {
                checkIsEmptyList.add(packErrorData(row, (index + 1) + "列数据为空"));
            }
        }
        return checkIsEmptyList;
    }

    /**
     * 检测参数是否是数字
     *
     * @param row
     * @param dataArray
     * @param indexArray
     * @return
     */
    protected List<String[]> checkIsNumber(String row, String[] dataArray, int[] indexArray) {
        List<String[]> checkIsEmptyList = Lists.newArrayList();
        for (int index : indexArray) {
            if (!isNumber(dataArray[index])) {
                checkIsEmptyList.add(packErrorData(row, (index + 1) + "列数据不是为数字类型"));
            }
        }
        return checkIsEmptyList;
    }

    /**
     * 移除ID字段
     *
     * @param map
     * @return
     */
    protected Map<String, ?> removeMapId(Map<String, ?> map) {
        Objects.requireNonNull(map);
        map.remove("ID");
        return map;
    }

    /**
     * 上传文件
     *
     * @param file
     * @param tableId
     * @param tableName
     * @param isSee
     * @return
     * @throws IOException
     */
    protected Map<String, Object> insertFile(MultipartFile file, String tableId, String tableName, int isSee) throws IOException {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(6);
        paramMap.put("SF_TABLE_ID", tableId);
        paramMap.put("SF_TABLE_NAME", tableName);
        paramMap.put("SF_TYPE_CODE", tableName);
        paramMap.put("SF_SEE_TYPE", isSee);
        paramMap.put("SF_SDT_CODE", "BUS_FILE_DEFAULT");
        paramMap.put("SF_SDI_CODE", "DEFAULT");

        return FileUtil.saveFile(file, paramMap);
    }

    /**
     * 删除文件
     *
     * @param tableId
     * @param tableName
     * @return
     * @throws Exception
     */
    protected boolean deleteFile(String tableId, String tableName) throws Exception {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(2);
        paramMap.put("SF_TABLE_ID", tableId);
        paramMap.put("SF_TABLE_NAME", TableName.SYS_CONFIGURE_FILE);
        List<Map<String, Object>> oldFileList = baseDao.selectList(NameSpace.FileMapper, "selectFile", paramMap);
        for (Map<String, Object> oldFile : oldFileList) {
            FileUtil.delServiceFile(toString(oldFile.get("ID")));
        }
        return true;
    }

    /**
     * 根据ID查询学生
     *
     * @param id
     * @return
     */
    protected Map<String, Object> selectStudentById(Object id) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("ID", id);
        return baseDao.selectOne(NameSpace.StudentMapper, "selectStudent", paramMap);
    }

    /**
     * 根据学号查询学生
     *
     * @param studentNumber
     * @return
     */
    protected Map<String, Object> selectStudentByNumber(Object studentNumber) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("BS_NUMBER", studentNumber);
        return baseDao.selectOne(NameSpace.StudentMapper, "selectStudent", paramMap);
    }


    /**
     * 根据角色编码查询角色
     *
     * @param roleCode
     * @return
     */
    protected Map<String, Object> selectRoleByCode(Object roleCode) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("SR_CODE", roleCode);
        return baseDao.selectOne(NameSpace.RoleMapper, "selectRole", paramMap);
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
                if (isProcess) {
                    builder.append(" AND (DG.SO_ID = " + operatorId + " OR SPS.SO_ID = " + operatorId + " OR SPS.SHOW_SO_ID = " + operatorId + ")");
                } else {
                    builder.append(" AND SO_ID = " + operatorId);
                }
            }
        } else if (type == SystemEnum.STUDENT.getType()) {
            //学生
            if (isProcess) {
                builder.append(" AND (DG.SO_ID = " + operatorId + " OR SPS.SO_ID = " + operatorId + " OR SPS.SHOW_SO_ID = " + operatorId + ")");
            } else {
                builder.append(" AND SO_ID = " + operatorId);
            }
        } else if (type == SystemEnum.TEACHER.getType()) {
            //教师
            if (isProcess) {
                builder.append(" AND (DG.SO_ID = " + operatorId + " OR SPS.SO_ID = " + operatorId + " OR SPS.SHOW_SO_ID = " + operatorId + ")");
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
     * @param operatorId
     * @param showSoId
     * @param busProcess
     * @param busProcess2
     * @throws Exception
     */
    protected void createProcessSchedule(String tableId, String tableName, String operatorId, @Nullable String showSoId, String busProcess, String busProcess2) throws Exception {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(6);
        paramMap.put("BUS_PROCESS", busProcess);
        paramMap.put("BUS_PROCESS2", busProcess2);
        Map<String, Object> definition = baseDao.selectOne(NameSpace.ProcessFixedMapper, "selectProcessDefinition", paramMap);
        if (isEmpty(definition)) {
            throw new CustomException("没有找到流程实例!");
        }
        Map<String, Object> createOperator = getOperatorById(operatorId);
        String SPS_ID = getId();

        paramMap.clear();
        paramMap.put("ID", SPS_ID);
        paramMap.put("SPD_ID", definition.get("ID"));
        paramMap.put("SO_ID", operatorId);
        paramMap.put("SHOW_SO_ID", showSoId);
        paramMap.put("SPS_TABLE_ID", tableId);
        paramMap.put("SPS_TABLE_NAME", tableName);
        paramMap.put("SPS_AUDIT_STATUS", "0");
        paramMap.put("SPS_BACK_STATUS", "0");
        paramMap.put("SPS_IS_CANCEL", "0");

        baseDao.insert(NameSpace.ProcessMapper, "insertProcessSchedule", paramMap);

        //插入启动流程日志
        paramMap.clear();
        paramMap.put("ID", getId());
        paramMap.put("SPS_ID", SPS_ID);
        paramMap.put("SPL_TABLE_ID", tableId);
        paramMap.put("SPL_SO_ID", operatorId);
        paramMap.put("SPL_TRANSACTOR", createOperator.get("SAI_NAME"));
        paramMap.put("SPL_OPINION", "创建流程(系统)");
        paramMap.put("SPL_ENTRY_TIME", getSqlDate());
        paramMap.put("SPL_TYPE", ProcessType.SUBMIT.toString());
        paramMap.put("SPL_PROCESS_STATUS", ProcessStatus.START.toString());

        baseDao.insert(NameSpace.ProcessMapper, "insertProcessLog", paramMap);

        log.info("插入流程,参数:" + toString(paramMap));
    }

    /**
     * 删除流程
     *
     * @param tableId
     * @throws Exception
     */
    protected void deleteProcessSchedule(String tableId) throws Exception {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("SPS_TABLE_ID", tableId);
        List<Map<String, Object>> scheduleList = baseDao.selectList(NameSpace.ProcessMapper, "selectProcessSchedule", paramMap);
        if (!isEmpty(scheduleList)) {
            for (Map<String, Object> schedule : scheduleList) {
                //删除日志
                paramMap.clear();
                paramMap.put("SPS_ID", schedule.get("ID"));
                baseDao.delete(NameSpace.ProcessMapper, "deleteProcessLog", paramMap);

                paramMap.clear();
                paramMap.put("ID", schedule.get("ID"));
                baseDao.delete(NameSpace.ProcessMapper, "deleteProcessSchedule", paramMap);
            }
        }
        log.info("删除流程,参数:" + toString(paramMap));
    }

    /**
     * 验证流程学状态
     *
     * @param id
     * @param busProcess
     * @param busProcess2
     * @throws Exception
     */
    public void validateProcessStatus(String id, String busProcess, String busProcess2) throws Exception {
        //查询是否正在进行流程
        Map<String, Object> schedule = getProcessSchedule(id, busProcess, busProcess2);
        if (!isEmpty(schedule)) {
            String SPS_AUDIT_STATUS = toString(schedule.get("SPS_AUDIT_STATUS"));
            boolean isEdit = true;
            //审核通过
            if (isEdit && ProcessStatus.COMPLETE.toString().equals(SPS_AUDIT_STATUS)) {
                isEdit = false;
            }
            //是否流程到达自身
            if (isEdit && !ProcessTool.showDataGridProcessBtn(id, busProcess, busProcess2).contains(ProcessType.SUBMIT.toString())) {
                isEdit = false;
            }
            //是否流程到达自身
            if (!isEdit && ProcessTool.selectNowActiveProcessStepIsEdit(busProcess, busProcess2)) {
                isEdit = true;
            }
            if (!isEdit) {
                throw new CustomException(Tips.PROCESS_DELETE_ERROR);
            }
        }
    }
}
