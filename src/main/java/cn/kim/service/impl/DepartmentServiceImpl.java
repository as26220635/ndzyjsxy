package cn.kim.service.impl;

import cn.kim.common.attr.Constants;
import cn.kim.common.attr.MagicValue;
import cn.kim.common.attr.TableName;
import cn.kim.common.attr.Tips;
import cn.kim.common.eu.NameSpace;
import cn.kim.common.eu.SystemEnum;
import cn.kim.entity.DataTablesView;
import cn.kim.entity.QuerySet;
import cn.kim.entity.Tree;
import cn.kim.entity.TreeState;
import cn.kim.exception.CustomException;
import cn.kim.service.DepartmentService;
import cn.kim.util.CommonUtil;
import cn.kim.util.DictUtil;
import cn.kim.util.PasswordMd5;
import cn.kim.util.RandomSalt;
import com.google.common.collect.Lists;
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
                throw new CustomException(Tips.ID_NULL_ERROR);
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
            paramMap.put("BDMP_POST", mapParam.get("BDMP_POST"));

            if (isEmpty(id)) {
                id = getId();
                paramMap.put("ID", id);
                //插入账号和账号信息
                String operatorId = insertOperator(baseDao, SystemEnum.DEPARTMENT.getType(), id, mapParam.get("BDMP_NAME"));
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
                throw new CustomException(Tips.ID_NULL_ERROR);
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
     * 添加辅导员管理班级
     *
     * @param mapParam
     * @return
     */
    @Override
    @Transactional
    public Map<String, Object> insertInstructorClass(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(10);
            String IDS = toString(mapParam.get("IDS"));
            String BDMP_ID = toString(mapParam.get("BDMP_ID"));

            if (isEmpty(IDS) || isEmpty(BDMP_ID)) {
                throw new CustomException(Tips.ID_NULL_ERROR);
            }

            String studentYear = getStudentYear();
            int studentSemester = getStudentSemester();

            StringBuilder errorBuilder = new StringBuilder();
            int success = 0;
            int error = 0;

            for (String ID : IDS.split(SERVICE_SPLIT)) {
                //查询是否已经被选中
                paramMap.clear();
                paramMap.put("BC_ID", ID);
                paramMap.put("BDI_YEAR", studentYear);
                paramMap.put("BDI_SEMESTER", studentSemester);
                Map<String, Object> instructor = baseDao.selectOne(NameSpace.DepartmentMapper, "selectDepartmentInstructor", paramMap);
                if (!isEmpty(instructor)) {
                    error++;
                    errorBuilder.append("班级(" + instructor.get("BC_NAME") + ")已经分配辅导员(" + instructor.get("BDMP_NAME") + ")!");
                    continue;
                }
                //查询班级
                paramMap.clear();
                paramMap.put("ID", ID);
                Map<String, Object> cls = baseDao.selectOne(NameSpace.ClsMapper, "selectClass", paramMap);
                //查询系部人员
                paramMap.clear();
                paramMap.put("ID", BDMP_ID);
                Map<String, Object> personnel = baseDao.selectOne(NameSpace.DepartmentMapper, "selectDepartmentPersonnel", paramMap);
                //插入记录
                String BDI_ID = getId();
                paramMap.clear();
                paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_DEPARTMENT_INSTRUCTOR);

                paramMap.put("ID", BDI_ID);
                paramMap.put("BDMP_ID", BDMP_ID);
                paramMap.put("BC_ID", ID);
                paramMap.put("BDI_YEAR", getStudentYear());
                paramMap.put("BDI_SEMESTER", getStudentSemester());
                paramMap.put("BDI_ENTRY_TIME", getDate());
                baseDao.insert(NameSpace.DepartmentMapper, "insertDepartmentInstructor", paramMap);

                //插入日志
                paramMap.clear();
                paramMap.put("ID", getId());
                paramMap.put("BDI_ID", BDI_ID);
                paramMap.put("BDMP_ID", BDMP_ID);
                paramMap.put("BDMP_NAME", personnel.get("BDMP_NAME"));
                paramMap.put("BC_ID", ID);
                paramMap.put("BC_NAME", cls.get("BC_NAME"));
                paramMap.put("BDMIL_YEAR", getStudentYear());
                paramMap.put("BDMIL_SEMESTER", getStudentSemester());
                paramMap.put("BDMIL_ENTRY_TIME", getDate());
                paramMap.put("SO_ID", getActiveUser().getId());
                paramMap.put("BDMIL_TYPE", MagicValue.RECODE_TYPE_INSERT);
                baseDao.insert(NameSpace.DepartmentMapper, "insertDepartmentInstructorLog", paramMap);

                success++;
            }

            status = STATUS_SUCCESS;
            desc = "分配成功" + success + "个班级,失败" + error + "个班级<br>" + errorBuilder.toString();

        } catch (Exception e) {
            desc = catchException(e, baseDao, resultMap);
        }
        resultMap.put(MagicValue.STATUS, status);
        resultMap.put(MagicValue.DESC, desc);
        return resultMap;
    }

    /**
     * 删除辅导员管理班级
     *
     * @param mapParam
     * @return
     */
    @Override
    @Transactional
    public Map<String, Object> deleteInstructorClass(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(10);
            String IDS = toString(mapParam.get("IDS"));

            if (isEmpty(IDS)) {
                throw new CustomException(Tips.ID_NULL_ERROR);
            }

            StringBuilder errorBuilder = new StringBuilder();
            int success = 0;
            int error = 0;

            for (String ID : IDS.split(SERVICE_SPLIT)) {
                paramMap.clear();
                paramMap.put("ID", ID);
                Map<String, Object> instructor = baseDao.selectOne(NameSpace.DepartmentMapper, "selectDepartmentInstructor", paramMap);

                //查看是否已经不能删除
                String studentYear = getStudentYear();
                int studentSemester = getStudentSemester();
                if (!studentYear.equals(toString(instructor.get("BDI_YEAR"))) || studentSemester != toInt(instructor.get("BDI_SEMESTER"))) {
                    error++;
                    errorBuilder.append("班级(" + instructor.get("BC_NAME") + ")分配学期(" + instructor.get("BDI_YEAR") + DictUtil.getDictName("BUS_SEMESTER", instructor.get("BDI_SEMESTER")) + ")已超过分配时间,不能删除!");
                    continue;
                }

                //删除记录
                paramMap.clear();
                paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_DEPARTMENT_INSTRUCTOR);

                paramMap.put("ID", ID);
                baseDao.delete(NameSpace.DepartmentMapper, "deleteDepartmentInstructor", paramMap);

                //插入日志
                paramMap.clear();
                paramMap.put("ID", getId());
                paramMap.put("BDI_ID", ID);
                paramMap.put("BDMP_ID", instructor.get("BDMP_ID"));
                paramMap.put("BDMP_NAME", instructor.get("BDMP_NAME"));
                paramMap.put("BC_ID", instructor.get("BC_ID"));
                paramMap.put("BC_NAME", instructor.get("BC_NAME"));
                paramMap.put("BDMIL_YEAR", instructor.get("BDI_YEAR"));
                paramMap.put("BDMIL_SEMESTER", instructor.get("BDI_SEMESTER"));
                paramMap.put("BDMIL_ENTRY_TIME", getDate());
                paramMap.put("SO_ID", getActiveUser().getId());
                paramMap.put("BDMIL_TYPE", MagicValue.RECODE_TYPE_DELETE);

                baseDao.insert(NameSpace.DepartmentMapper, "insertDepartmentInstructorLog", paramMap);
                success++;
            }

            status = STATUS_SUCCESS;
            desc = "删除成功" + success + "个班级,失败" + error + "个班级<br>" + errorBuilder.toString();

        } catch (Exception e) {
            desc = catchException(e, baseDao, resultMap);
        }
        resultMap.put(MagicValue.STATUS, status);
        resultMap.put(MagicValue.DESC, desc);
        return resultMap;
    }

    @Override
    public DataTablesView<?> selectDepartmentInstructor(Map<String, Object> mapParam) {
        DataTablesView<Map<String, Object>> dataTablesView = new DataTablesView<>();
        QuerySet querySet = new QuerySet();

        //学生姓名
        if (!isEmpty(mapParam.get("name"))) {
            querySet.set(QuerySet.LIKE, "BDMP_NAME", mapParam.get("name"));
        }

        //当前系部
        querySet.set(QuerySet.EQ, "BDM_ID", mapParam.get("BDM_ID"));

        int offset = toInt(mapParam.get("start"));
        int limit = toInt(mapParam.get("length"));

        querySet.setOffset(offset);
        querySet.setLimit(limit);

        querySet.setOrderByClause("CONVERT(ID,SIGNED) DESC");

        long count = baseDao.selectOne(NameSpace.DepartmentMapper, "selectDepartmentInstructorCount", querySet.getWhereMap());
        dataTablesView.setRecordsTotal(count);
        dataTablesView.setTotalPages(CommonUtil.getPage(count, limit));

        System.out.println(toString(querySet.getWhereMap()));
        List<Map<String, Object>> dataList = baseDao.selectList(NameSpace.DepartmentMapper, "selectDepartmentInstructorList", querySet.getWhereMap());
        dataTablesView.setData(dataList);

        return dataTablesView;
    }

    @Override
    public Map<String, Object> selectClassInstructor(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(3);
        paramMap.put("ID", mapParam.get("ID"));
        paramMap.put("BDI_YEAR", getStudentYear());
        paramMap.put("BDI_SEMESTER", getStudentSemester());
        return baseDao.selectOne(NameSpace.DepartmentMapper, "selectClassInstructor", paramMap);
    }

    @Override
    @Transactional
    public Map<String, Object> updateClassInstructor(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(10);

            String BC_ID = toString(mapParam.get("BC_ID"));
            String BC_NAME = toString(mapParam.get("BC_NAME"));
            String BDMP_ID = toString(mapParam.get("BDMP_ID"));
            String BDMP_NAME = toString(mapParam.get("BDMP_NAME"));

            String studentYear = getStudentYear();
            int studentSemester = getStudentSemester();

            //查询当前学期是否能修改
            if (!isNowChangeInstructor(BC_ID)) {
                throw new CustomException(Tips.CLASS_LOCKED);
            }
            //是否变更
            boolean isChange = true;

            //查询当前学期旧辅导员信息
            paramMap.clear();
            paramMap.put("BC_ID", BC_ID);
            paramMap.put("BDI_YEAR", studentYear);
            paramMap.put("BDI_SEMESTER", studentSemester);
            Map<String, Object> instructor = baseDao.selectOne(NameSpace.DepartmentMapper, "selectDepartmentInstructor", paramMap);

            if (!isEmpty(instructor)) {
                if (toString(instructor.get("BDMP_ID")).equals(BDMP_ID)) {
                    isChange = false;
                }
            }

            if (isChange) {
                if (!isEmpty(instructor)) {
                    //删除旧辅导员信息并插入日志
                    //删除记录
                    paramMap.clear();
                    paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_DEPARTMENT_INSTRUCTOR);

                    paramMap.put("ID", instructor.get("ID"));
                    baseDao.delete(NameSpace.DepartmentMapper, "deleteDepartmentInstructor", paramMap);

                    //插入日志
                    paramMap.clear();
                    paramMap.put("ID", getId());
                    paramMap.put("BDI_ID", instructor.get("ID"));
                    paramMap.put("BDMP_ID", instructor.get("BDMP_ID"));
                    paramMap.put("BDMP_NAME", instructor.get("BDMP_NAME"));
                    paramMap.put("BC_ID", instructor.get("BC_ID"));
                    paramMap.put("BC_NAME", instructor.get("BC_NAME"));
                    paramMap.put("BDMIL_YEAR", instructor.get("BDI_YEAR"));
                    paramMap.put("BDMIL_SEMESTER", instructor.get("BDI_SEMESTER"));
                    paramMap.put("BDMIL_ENTRY_TIME", getDate());
                    paramMap.put("SO_ID", getActiveUser().getId());
                    paramMap.put("BDMIL_TYPE", MagicValue.RECODE_TYPE_DELETE);

                    baseDao.insert(NameSpace.DepartmentMapper, "insertDepartmentInstructorLog", paramMap);
                }

                //插入新日志

                //插入记录
                String BDI_ID = getId();
                paramMap.clear();
                paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_DEPARTMENT_INSTRUCTOR);

                paramMap.put("ID", BDI_ID);
                paramMap.put("BDMP_ID", BDMP_ID);
                paramMap.put("BC_ID", BC_ID);
                paramMap.put("BDI_YEAR", studentYear);
                paramMap.put("BDI_SEMESTER", studentSemester);
                paramMap.put("BDI_ENTRY_TIME", getDate());
                baseDao.insert(NameSpace.DepartmentMapper, "insertDepartmentInstructor", paramMap);

                //插入日志
                paramMap.clear();
                paramMap.put("ID", getId());
                paramMap.put("BDI_ID", BDI_ID);
                paramMap.put("BDMP_ID", BDMP_ID);
                paramMap.put("BDMP_NAME", BDMP_NAME);
                paramMap.put("BC_ID", BC_ID);
                paramMap.put("BC_NAME", BC_NAME);
                paramMap.put("BDMIL_YEAR", studentYear);
                paramMap.put("BDMIL_SEMESTER", studentSemester);
                paramMap.put("BDMIL_ENTRY_TIME", getDate());
                paramMap.put("SO_ID", getActiveUser().getId());
                paramMap.put("BDMIL_TYPE", MagicValue.RECODE_TYPE_INSERT);
                baseDao.insert(NameSpace.DepartmentMapper, "insertDepartmentInstructorLog", paramMap);
            }

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
     * 获取系部树
     *
     * @param selectId 选中的ID
     * @param notId    不显示id和父类id
     * @return
     */
    public List<Tree> getDepartmentTreeList(String selectId, String notId) {
        List<Tree> treeList = Lists.newArrayList();

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
//                        "电话:" + toHtmlBColor(button.get("BD_PHONE")),
                        "院系:" + toHtmlBColor(button.get("BDM_COLLEGE_NAME"))
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
