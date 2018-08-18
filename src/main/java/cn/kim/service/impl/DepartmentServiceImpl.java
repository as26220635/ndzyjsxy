package cn.kim.service.impl;

import cn.kim.common.attr.Constants;
import cn.kim.common.attr.MagicValue;
import cn.kim.common.attr.TableName;
import cn.kim.common.eu.NameSpace;
import cn.kim.common.eu.SystemEnum;
import cn.kim.entity.Tree;
import cn.kim.entity.TreeState;
import cn.kim.exception.CustomException;
import cn.kim.service.DepartmentService;
import cn.kim.util.PasswordMd5;
import cn.kim.util.RandomSalt;
import com.google.common.collect.Maps;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/8/6
 * 系部管理
 */
@Service
public class DepartmentServiceImpl extends BaseServiceImpl implements DepartmentService {

    @Override
    public Map<String, Object> selectDepartment(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("ID", mapParam.get("ID"));
        return baseDao.selectOne(NameSpace.DepartmentMapper, "selectDepartment", paramMap);
    }

    @Override
    public List<Map<String, Object>> selectDepartmentList(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("ID", mapParam.get("ID"));
        return baseDao.selectOne(NameSpace.DepartmentMapper, "selectDepartment", paramMap);
    }

    @Override
    public List<Tree> selectDepartmentTreeList(String id, String notId) {
        return getDepartmentTreeList(id, notId);
    }


    @Override
    @Transactional
    public Map<String, Object> insertAndUpdateDepartment(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(10);
            String id = toString(mapParam.get("ID"));
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_DEPARTMENT);

            paramMap.put("ID", id);
            paramMap.put("BDM_COLLEGE", mapParam.get("BDM_COLLEGE"));
            paramMap.put("BDM_NAME", mapParam.get("BDM_NAME"));
            paramMap.put("BDM_ADDRESS", mapParam.get("BDM_ADDRESS"));
            paramMap.put("BDM_DESCRIBE", mapParam.get("BDM_DESCRIBE"));
            paramMap.put("BDM_ORDER", mapParam.get("BDM_ORDER"));
            paramMap.put("BDM_ENTER_TIME", mapParam.get("BDM_ENTER_TIME"));

            if (isEmpty(id)) {
                id = getId();
                paramMap.put("ID", id);
                paramMap.put("BD_ENTER_TIME", getDate());

                baseDao.insert(NameSpace.DepartmentMapper, "insertDepartment", paramMap);
                resultMap.put(MagicValue.LOG, "添加系部:" + formatColumnName(TableName.BUS_DEPARTMENT, paramMap));
            } else {
                Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
                oldMap.put("ID", id);
                oldMap = selectDepartment(oldMap);

                baseDao.update(NameSpace.DepartmentMapper, "updateDepartment", paramMap);
                resultMap.put(MagicValue.LOG, "更新系部,更新前:" + formatColumnName(TableName.BUS_DEPARTMENT, oldMap) + ",更新后:" + formatColumnName(TableName.BUS_DEPARTMENT, paramMap));
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

    @Override
    @Transactional
    public Map<String, Object> deleteDepartment(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = DELETE_ERROR;
        try {
            if (isEmpty(mapParam.get("ID"))) {
                throw new CustomException("ID不能为空!");
            }
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
            String id = toString(mapParam.get("ID"));

            //删除系部表
            paramMap.clear();
            paramMap.put("ID", id);
            Map<String, Object> oldMap = selectDepartment(paramMap);
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_DEPARTMENT);
            baseDao.delete(NameSpace.DepartmentMapper, "deleteDepartment", paramMap);

            resultMap.put(MagicValue.LOG, "删除系部,信息:" + formatColumnName(TableName.BUS_DEPARTMENT, oldMap));
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
    public Map<String, Object> selectDepartmentPersonnel(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("ID", mapParam.get("ID"));
        return baseDao.selectOne(NameSpace.DepartmentMapper, "selectDepartmentPersonnel", paramMap);
    }

    @Override
    @Transactional
    public Map<String, Object> insertAndUpdateDepartmentPersonnel(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(10);
            String id = toString(mapParam.get("ID"));
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_DEPARTMENT_PERSONNEL);

            paramMap.put("ID", id);
            paramMap.put("SO_ID", mapParam.get("SO_ID"));
            paramMap.put("BDM_ID", mapParam.get("BDM_ID"));
            paramMap.put("BDMP_NAME", mapParam.get("BDMP_NAME"));

            if (isEmpty(id)) {
                id = getId();
                paramMap.put("ID", id);
                //插入账号和账号信息
                String operatorId = insertOperator(baseDao, mapParam.get("BDMP_NAME"), SystemEnum.DEPARTMENT.getType());
                paramMap.put("SO_ID", operatorId);

                //插入系部人员
                baseDao.insert(NameSpace.DepartmentMapper, "insertDepartmentPersonnel", paramMap);
                resultMap.put(MagicValue.LOG, "添加系部人员:" + formatColumnName(TableName.BUS_DEPARTMENT_PERSONNEL, paramMap));
            } else {
                Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
                oldMap.put("ID", id);
                oldMap = selectDepartmentPersonnel(oldMap);

                baseDao.update(NameSpace.DepartmentMapper, "updateDepartmentPersonnel", paramMap);
                resultMap.put(MagicValue.LOG, "更新系部人员,更新前:" + formatColumnName(TableName.BUS_DEPARTMENT_PERSONNEL, oldMap) + ",更新后:" + formatColumnName(TableName.BUS_DEPARTMENT_PERSONNEL, paramMap));
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

    @Override
    @Transactional
    public Map<String, Object> deleteDepartmentPersonnel(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = DELETE_ERROR;
        try {
            if (isEmpty(mapParam.get("ID"))) {
                throw new CustomException("ID不能为空!");
            }
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
            String id = toString(mapParam.get("ID"));

            //删除系部人员表
            paramMap.clear();
            paramMap.put("ID", id);
            Map<String, Object> oldMap = selectDepartmentPersonnel(paramMap);
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_DEPARTMENT_PERSONNEL);
            baseDao.delete(NameSpace.DepartmentMapper, "deleteDepartmentPersonnel", paramMap);

            resultMap.put(MagicValue.LOG, "删除系部人员,信息:" + formatColumnName(TableName.BUS_DEPARTMENT_PERSONNEL, oldMap));
            status = STATUS_SUCCESS;
            desc = DELETE_SUCCESS;
        } catch (Exception e) {
            desc = catchException(e, baseDao, resultMap);
        }
        resultMap.put(MagicValue.STATUS, status);
        resultMap.put(MagicValue.DESC, desc);
        return resultMap;
    }

    /**
     * 获取系部树
     *
     * @param selectId 选中的ID
     * @param notId    不显示id和父类id
     * @return
     */
    public List<Tree> getDepartmentTreeList(String selectId, String notId) {
        List<Tree> treeList = new ArrayList<>();

        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(3);
        paramMap.put("NOT_ID", notId);
        List<Map<String, Object>> divisionList = baseDao.selectList(NameSpace.DepartmentMapper, "selectDepartment", paramMap);

        if (!isEmpty(divisionList)) {
            divisionList.forEach(button -> {
                String id = toString(button.get("ID"));

                Tree tree = new Tree();
                tree.setId(id);
                tree.setText(toString(button.get("BDM_NAME")));
                tree.setTags(new String[]{
//                        "电话:" + toHtmlBColor(button.get("BD_PHONE"), "yellow"),
                        !isEmpty(button.get("BDM_COLLEGE_NAME")) ? "院系:" + toHtmlBColor(button.get("BDM_COLLEGE_NAME"), "yellow") : null
                });

                TreeState state = new TreeState();
                //是否选中
                if (!isEmpty(selectId) && selectId.equals(id)) {
                    state.setChecked(true);
                    //选中的设置打开
                    state.setExpanded(true);
                }

                //设置状态
                tree.setState(state);

                treeList.add(tree);
            });
        }

        return treeList;
    }
}
