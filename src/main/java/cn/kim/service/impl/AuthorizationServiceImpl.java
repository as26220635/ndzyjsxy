package cn.kim.service.impl;

import cn.kim.common.attr.Attribute;
import cn.kim.common.attr.MagicValue;
import cn.kim.common.attr.TableName;
import cn.kim.common.eu.AuthorizationType;
import cn.kim.common.eu.NameSpace;
import cn.kim.entity.DictInfo;
import cn.kim.entity.DictType;
import cn.kim.entity.Tree;
import cn.kim.entity.TreeState;
import cn.kim.service.AuthorizationService;
import cn.kim.util.DictUtil;
import com.google.common.collect.Maps;
import jdk.nashorn.internal.runtime.regexp.joni.constants.OPCode;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * Created by 余庚鑫 on 2018/8/14
 * 授权
 */
@Service
public class AuthorizationServiceImpl extends BaseServiceImpl implements AuthorizationService {

    @Override
    public List<Tree> selectAuthorizationTreeList(Map<String, Object> mapParam) {
        //显示级别 1院系 2系部 3班级
        int level = toInt(mapParam.get("level"));
        //是否显示子级别
        int isChildren = toInt(mapParam.get("isChildren"));
        //父类ID
        String parentId = toString(mapParam.get("parentId"));
        //操作员id
        String operatorId = toString(mapParam.get("operatorId"));

        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("SO_ID", operatorId);
        List<Map<String, Object>> selectList = baseDao.selectList(NameSpace.AuthorizationMapper, "selectAuthorization", paramMap);
        Map<String, String> selectMap = toMapKey(selectList, "BA_TABLE_TYPE", "BA_TABLE_ID");

        return getAuthorizationTree(level, isChildren, parentId, selectMap);
    }

    @Override
    @Transactional
    public Map<String, Object> updateAuthorization(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(3);
            String operatorId = toString(mapParam.get("operatorId"));
            //选中的按钮ID
            String[] ids = toString(mapParam.get("authorizations")).split(SERVICE_SPLIT);
            //ID解密
            for (int i = 0; i < ids.length; i++) {
                String[] newGroup = ids[i].split(Attribute.COMPLEX_SPLIT);
                if(newGroup.length == 2){
                    newGroup[1] = toString(idDecrypt(newGroup[1]));
                    ids[i] = Arrays.stream(newGroup).collect(Collectors.joining(Attribute.COMPLEX_SPLIT));
                }
            }
            //查询原本的授权列表
            paramMap.clear();
            paramMap.put("SO_ID", operatorId);
            Map<String, String> oldIds = toMapJoinKey(baseDao.selectList(NameSpace.AuthorizationMapper, "selectAuthorization", paramMap), Attribute.COMPLEX_SPLIT, "BA_TABLE_TYPE", "BA_TABLE_ID");
            //新授权列表
            Map<String, String> newIds = Arrays.stream(ids).collect(Collectors.toMap(String::toString, String::toString));


            //原来没有的就添加
            if (!isEmpty(newIds)) {
                for (String newId : newIds.keySet()) {
                    if (!isEmpty(newId)) {
                        String[] newGroup = newId.split(Attribute.COMPLEX_SPLIT);
                        String containsKey = Arrays.stream(newGroup).collect(Collectors.joining(Attribute.COMPLEX_SPLIT));
                        if (isEmpty(oldIds) || !oldIds.containsKey(containsKey)) {
                            //添加
                            paramMap.clear();
                            paramMap.put("ID", getId());
                            paramMap.put("SO_ID", operatorId);
                            paramMap.put("BA_TABLE_TYPE", newGroup[0]);
                            paramMap.put("BA_TABLE_ID", newGroup[1]);
                            baseDao.insert(NameSpace.AuthorizationMapper, "insertAuthorization", paramMap);
                        }
                    }
                }
            }
            //新的授权 旧的还存在的就要删除
            if (!isEmpty(oldIds)) {
                for (String oldId : oldIds.keySet()) {
                    if (!isEmpty(oldId)) {
                        String[] oldGroup = oldId.split(Attribute.COMPLEX_SPLIT);
                        String containsKey = Arrays.stream(oldGroup).collect(Collectors.joining(Attribute.COMPLEX_SPLIT));
                        if (isEmpty(newIds) || !newIds.containsKey(containsKey)) {
                            //删除
                            paramMap.clear();
                            paramMap.put("BA_TABLE_TYPE", oldGroup[0]);
                            paramMap.put("BA_TABLE_ID", oldGroup[1]);
                            baseDao.delete(NameSpace.AuthorizationMapper, "deleteAuthorization", paramMap);
                        }
                    }
                }
            }

            status = STATUS_SUCCESS;
            desc = SAVE_SUCCESS;

            resultMap.put("ID", operatorId);
        } catch (Exception e) {
            desc = catchException(e, baseDao, resultMap);
        }
        resultMap.put(MagicValue.STATUS, status);
        resultMap.put(MagicValue.DESC, desc);
        return resultMap;
    }

    /**
     * 递归授权树列表
     *
     * @param level
     * @param isChildren
     * @param parentId
     * @param selectMap
     * @return
     */
    public List<Tree> getAuthorizationTree(int level, int isChildren, String parentId, Map<String, String> selectMap) {
        List<Tree> resultTreeList = new ArrayList<>();
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(2);

        List<Map<String, Object>> dataList = new ArrayList<>();
        //根据等级查询不同的数据
        if (level == AuthorizationType.COLLEGE.getType()) {
            //院系
            DictType dictType = DictUtil.getDictType("BUS_COLLEGE");
            for (DictInfo info : dictType.getInfos()) {
                Map<String, Object> map = Maps.newHashMapWithExpectedSize(2);
                map.put("ID", info.getSdiCode());
                map.put("NAME", info.getSdiName());

                dataList.add(map);
            }

        } else if (level == AuthorizationType.DEPARTMENT.getType()) {
            //系部
            paramMap.clear();
            paramMap.put("AUTHORIZATION", parentId);
            dataList = baseDao.selectList(NameSpace.DepartmentMapper, "selectDepartment", paramMap);
        } else if (level == AuthorizationType.CLS.getType()) {
            //班级
            paramMap.clear();
            paramMap.put("AUTHORIZATION", parentId);
            dataList = baseDao.selectList(NameSpace.ClsMapper, "selectClass", paramMap);
        }
        if (isEmpty(dataList)) {
            return null;
        }

        if (!isEmpty(dataList)) {
            dataList.forEach(data -> {
                String id = toString(data.get("ID"));
                String name = "";
                if (level == AuthorizationType.COLLEGE.getType()) {
                    //院系
                    name = toString(data.get("NAME"));
                } else if (level == AuthorizationType.DEPARTMENT.getType()) {
                    //系部
                    name = toString(data.get("BDM_NAME"));
                } else if (level == AuthorizationType.CLS.getType()) {
                    //班级
                    name = toString(data.get("BC_NAME"));
                }
                Tree tree = new Tree();
                tree.setId(id);
                tree.setText(name);
                tree.setLevel(level);

                TreeState state = new TreeState();
                //是否选中
                if (!isEmpty(selectMap) && selectMap.containsKey(level + id)) {
                    state.setChecked(true);
                    //选中的设置打开
                    state.setExpanded(true);
                }

                //设置状态
                tree.setState(state);

                //递归
                if (isChildren == STATUS_SUCCESS) {
                    tree.setNodes(getAuthorizationTree(level + 1, isChildren, id, selectMap));
                }

                resultTreeList.add(tree);
            });
        }

        return resultTreeList;
    }
}
