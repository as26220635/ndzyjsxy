package cn.kim.service.impl;

import cn.kim.common.attr.*;
import cn.kim.exception.CustomException;
import cn.kim.common.eu.NameSpace;
import cn.kim.dao.BaseDao;
import cn.kim.entity.DictInfo;
import cn.kim.entity.DictType;
import cn.kim.entity.Tree;
import cn.kim.entity.TreeState;
import cn.kim.exception.CustomException;
import cn.kim.service.DictService;
import cn.kim.util.ValidateUtil;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.sun.xml.internal.ws.wsdl.writer.document.ParamType;
import org.checkerframework.checker.units.qual.C;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/3/21
 */
@Service
public class DictServiceImpl extends BaseServiceImpl implements DictService {
    /**
     * 查询字典
     *
     * @param mapParam
     * @return
     */
    @Override
    public Map<String, Object> selectDictType(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(5);
        paramMap.put("ID", mapParam.get("ID"));
        return baseDao.selectOne(NameSpace.DictMapper, "selectDictType", paramMap);
    }

    @Override
    public List<DictType> selectDictTypeList(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("ID", mapParam.get("ID"));
        List<Map<String, Object>> results = baseDao.selectList(NameSpace.DictMapper, "selectDictType", paramMap);

        List<DictType> dictTypes = Lists.newArrayList();
        results.stream().forEach(map -> {
            DictType dictType = new DictType();
            dictType.setId(toString(map.get("ID")));
            dictType.setSdtName(toString(map.get("SDT_NAME")));
            dictType.setSdtCode(toString(map.get("SDT_CODE")));
            dictType.setIsStatus(toInt(map.get("IS_STATUS")));
            dictTypes.add(dictType);
        });

        return dictTypes;
    }

    @Override
    public Map<String, Object> selectDictInfo(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(5);
        paramMap.put("ID", mapParam.get("ID"));
        paramMap.put("SDT_CODE", mapParam.get("SDT_CODE"));
        paramMap.put("SDI_CODE", mapParam.get("SDI_CODE"));
        return baseDao.selectOne(NameSpace.DictMapper, "selectDictInfo", paramMap);
    }

    @Override
    public List<DictInfo> selectDictInfoList(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(5);
        paramMap.put("SDT_ID", mapParam.get("SDT_ID"));
        paramMap.put("SDT_CODE", mapParam.get("SDT_CODE"));
        paramMap.put("SDI_CODE", mapParam.get("SDI_CODE"));
        paramMap.put("SDI_PARENTID", mapParam.get("SDI_PARENTID"));
        return setDictInfoChildrenList(baseDao, baseDao.selectList(NameSpace.DictMapper, "selectDictInfo", paramMap), null);
    }

    @Override
    @Transactional
    public Map<String, Object> insertAndUpdateDictType(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(8);
            String id = toString(mapParam.get("ID"));
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.SYS_DICT_TYPE);

            paramMap.put("ID", id);
            paramMap.put("SDT_NAME", mapParam.get("SDT_NAME"));
            paramMap.put("SDT_CODE", mapParam.get("SDT_CODE"));
            paramMap.put("SDT_ROLE_DOWN", mapParam.get("SDT_ROLE_DOWN"));
            paramMap.put("SDT_ROLE_DEL", mapParam.get("SDT_ROLE_DEL"));
            paramMap.put("IS_STATUS", mapParam.get("IS_STATUS"));

            if (isEmpty(id)) {
                id = getId();
                paramMap.put("ID", id);
                paramMap.put("IS_STATUS", Attribute.STATUS_SUCCESS);

                baseDao.insert(NameSpace.DictMapper, "insertDictType", paramMap);
                resultMap.put(MagicValue.LOG, "添加字典类型:" + formatColumnName(TableName.SYS_DICT_TYPE, paramMap));
            } else {
                Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
                oldMap.put("ID", id);
                oldMap = selectDictType(oldMap);

                baseDao.update(NameSpace.DictMapper, "updateDictType", paramMap);
                resultMap.put(MagicValue.LOG, "更新字典类型,更新前:" + formatColumnName(TableName.SYS_DICT_TYPE, oldMap) + ",更新后:" + formatColumnName(TableName.SYS_DICT_TYPE, paramMap));
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
    public Map<String, Object> deleteDictType(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = DELETE_ERROR;
        try {
            if (isEmpty(mapParam.get("ID"))) {
                throw new CustomException(Tips.ID_NULL_ERROR);
            }
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
            String id = toString(mapParam.get("ID"));

            paramMap.put("SDT_ID", id);
            //删除字典类型详细表
            baseDao.delete(NameSpace.DictMapper, "deleteDictInfo", paramMap);
            //删除字典类型表
            paramMap.clear();
            paramMap.put("ID", id);
            Map<String, Object> oldMap = selectDictType(paramMap);
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.SYS_DICT_TYPE);
            baseDao.delete(NameSpace.DictMapper, "deleteDictType", paramMap);

            resultMap.put(MagicValue.LOG, "删除字典类型,信息:" + formatColumnName(TableName.SYS_DICT_TYPE, oldMap));
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
    @Transactional
    public Map<String, Object> insertAndUpdateDictInfo(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(16);
            String id = toString(mapParam.get("ID"));

            //查询是否重复
            paramMap.put("NOT_ID", id);
            paramMap.put("SDT_ID", mapParam.get("SDT_ID"));
            paramMap.put("SDI_CODE", mapParam.get("SDI_CODE"));
            int count = baseDao.selectOne(NameSpace.DictMapper, "selectDictInfoCount", paramMap);
            if (count > 0) {
                throw new CustomException("信息编码重复!");
            }
            paramMap.clear();
            paramMap.put("NOT_ID", id);
            paramMap.put("SDT_ID", mapParam.get("SDT_ID"));
            paramMap.put("SDI_INNERCODE", mapParam.get("SDI_INNERCODE"));
            count = baseDao.selectOne(NameSpace.DictMapper, "selectDictInfoCount", paramMap);
            if (count > 0) {
                throw new CustomException("连接编码重复!");
            }

            paramMap.clear();
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.SYS_DICT_INFO);

            paramMap.put("ID", id);
            paramMap.put("SDT_ID", mapParam.get("SDT_ID"));
            paramMap.put("SDT_CODE", mapParam.get("SDT_CODE"));
            paramMap.put("SDI_NAME", mapParam.get("SDI_NAME"));
            paramMap.put("SDI_CODE", mapParam.get("SDI_CODE"));
            paramMap.put("SDI_INNERCODE", mapParam.get("SDI_INNERCODE"));
            paramMap.put("SDI_PARENTID", isEmpty(mapParam.get("SDI_PARENTID")) ? "0" : mapParam.get("SDI_PARENTID"));
            paramMap.put("SDI_IS_LEAF", mapParam.get("SDI_IS_LEAF"));
            paramMap.put("SDI_REMARK", mapParam.get("SDI_REMARK"));
            paramMap.put("SDI_REQUIRED", mapParam.get("SDI_REQUIRED"));
            paramMap.put("SDI_ORDER", mapParam.get("SDI_ORDER"));
            paramMap.put("IS_STATUS", mapParam.get("IS_STATUS"));

            if (isEmpty(id)) {
                id = getId();
                paramMap.put("ID", id);
                paramMap.put("IS_STATUS", Attribute.STATUS_SUCCESS);

                //查询SDT_CODE
                Map<String, Object> sdtMap = Maps.newHashMapWithExpectedSize(1);
                sdtMap.put("ID", mapParam.get("SDT_ID"));
                Map<String, Object> dictType = selectDictType(sdtMap);

                paramMap.put("SDT_CODE", dictType.get("SDT_CODE"));

                baseDao.insert(NameSpace.DictMapper, "insertDictInfo", paramMap);
                resultMap.put(MagicValue.LOG, "添加字典信息:" + formatColumnName(TableName.SYS_DICT_INFO, paramMap));
            } else {
                Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
                oldMap.put("ID", id);
                oldMap = selectDictInfo(oldMap);

                baseDao.update(NameSpace.DictMapper, "updateDictInfo", paramMap);
                resultMap.put(MagicValue.LOG, "更新字典信息,更新前:" + formatColumnName(TableName.SYS_DICT_INFO, oldMap) + ",更新后:" + formatColumnName(TableName.SYS_DICT_INFO, paramMap));
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
    public Map<String, Object> changeDictInfoStatus(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(2);
            String id = toString(mapParam.get("ID"));

            paramMap.put("ID", id);
            paramMap.put("IS_STATUS", mapParam.get("IS_STATUS"));

            Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
            oldMap.put("ID", id);
            oldMap = selectDictInfo(oldMap);
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.SYS_DICT_INFO);

            baseDao.update(NameSpace.DictMapper, "updateDictInfo", paramMap);
            resultMap.put(MagicValue.LOG, "更新字典类型状态,字典:" + toString(oldMap.get("SDT_NAME")) + ",信息:" + toString(oldMap.get("SDI_NAME")) + ",状态更新为:" + ParamTypeResolve.statusExplain(mapParam.get("IS_STATUS")));

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
    public Map<String, Object> deleteDictInfo(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = DELETE_ERROR;
        try {
            if (isEmpty(mapParam.get("ID"))) {
                throw new CustomException(Tips.ID_NULL_ERROR);
            }
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
            String id = toString(mapParam.get("ID"));

            //删除字典类型表
            paramMap.put("ID", id);
            Map<String, Object> oldMap = selectDictInfo(paramMap);
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.SYS_DICT_INFO);
            baseDao.delete(NameSpace.DictMapper, "deleteDictInfo", paramMap);

            resultMap.put(MagicValue.LOG, "删除字典信息,信息:" + formatColumnName(TableName.SYS_DICT_INFO, oldMap));
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
    public List<Tree> selectDictInfoTree(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(2);
        paramMap.put("SDI_PARENTID", "0");
        paramMap.put("SDT_ID", mapParam.get("SDT_ID"));
        paramMap.put("NOT_ID", mapParam.get("NOT_ID"));
        List<DictInfo> dictInfos = setDictInfoChildrenList(baseDao, baseDao.selectList(NameSpace.DictMapper, "selectDictInfo", paramMap), toString(mapParam.get("NOT_ID")));

        return getDictInfoTree(dictInfos, toString(mapParam.get("SDI_PARENTID")));
    }

    @Override
    public List<Tree> selectDictInfoTreeBox(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(2);
        paramMap.put("SDI_PARENTID", "0");
        paramMap.put("SDT_CODE", mapParam.get("SDT_CODE"));
        paramMap.put("NOT_ID", mapParam.get("NOT_ID"));
        List<DictInfo> dictInfos = setDictInfoChildrenList(baseDao, baseDao.selectList(NameSpace.DictMapper, "selectDictInfo", paramMap), toString(mapParam.get("NOT_ID")));

        return getDictInfoTreeBox(dictInfos, toString(mapParam.get("SDI_CODE")));
    }

    /**
     * 递归查询子菜单
     *
     * @param baseDao
     * @param dictInfo
     * @return
     */
    public DictInfo setDictInfoChildren(BaseDao baseDao, DictInfo dictInfo, String notId) {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(2);
        mapParam.put("SDI_PARENTID", dictInfo.getId());
        mapParam.put("NOT_ID", notId);

        List<DictInfo> childrenList = this.selectDictInfoList(mapParam);
        if (!ValidateUtil.isEmpty(childrenList)) {
            childrenList.stream().forEach(info -> {
                mapParam.clear();
                mapParam.put("SDI_PARENTID", info.getId());
                mapParam.put("NOT_ID", notId);
                //是叶节点才要查询子类
                if (!isEmpty(info.getIsLeaf()) && toInt(info.getIsLeaf()) == STATUS_SUCCESS) {
                    info.setChildren(selectDictInfoList(mapParam));
                }
            });
            dictInfo.setChildren(childrenList);
        }

        return dictInfo;
    }

    /**
     * 递归查询子类
     *
     * @param baseDao
     * @param parentList
     * @return
     */
    private List<DictInfo> setDictInfoChildrenList(BaseDao baseDao, List<Map<String, Object>> parentList, String notId) {
        List<DictInfo> results = Lists.newArrayList();
        if (!isEmpty(parentList)) {
            parentList.stream().forEach(map -> {
                DictInfo dictInfo = new DictInfo();
                dictInfo.setId(toString(map.get("ID")));
                dictInfo.setSdtId(toString(map.get("SDT_ID")));
                dictInfo.setSdtCode(toString(map.get("SDT_CODE")));
                dictInfo.setSdiName(toString(map.get("SDI_NAME")));
                dictInfo.setSdiCode(toString(map.get("SDI_CODE")));
                dictInfo.setSdiInnercode(toString(map.get("SDI_INNERCODE")));
                dictInfo.setSdiOrder(toInt(map.get("SDI_ORDER")));
                dictInfo.setSdiParentid(toString(map.get("SDI_PARENTID")));
                dictInfo.setIsLeaf(toString(map.get("SDI_IS_LEAF")));
                dictInfo.setSdiRemark(toString(map.get("SDI_REMARK")));
                dictInfo.setSdiRequired(toInt(map.get("SDI_REQUIRED")));
                dictInfo.setIsStatus(toInt(map.get("IS_STATUS")));
                if (!isEmpty(dictInfo.getIsLeaf()) && toInt(dictInfo.getIsLeaf()) == STATUS_SUCCESS) {
                    setDictInfoChildren(baseDao, dictInfo, notId);
                }
                results.add(dictInfo);
            });
        }
        return results;
    }

    /**
     * 吧dictinfo转为tree选择已经选中的菜单
     *
     * @param dictInfs
     * @param dictInfoParentId
     * @return
     */
    private List<Tree> getDictInfoTree(List<DictInfo> dictInfs, String dictInfoParentId) {
        List<Tree> dictInfoTrees = Lists.newArrayList();
        dictInfs.forEach(info -> {
            String id = toString(info.getId());

            Tree tree = new Tree();
            tree.setId(id);
            tree.setText(toString(info.getSdiName()));
            tree.setTags(new String[]{"编码:" + toHtmlBColor(info.getSdiCode())});

            TreeState state = new TreeState();
            //是否选中
            if (id.equals(dictInfoParentId)) {
                state.setChecked(true);
                //选中的设置打开
                state.setExpanded(true);
            }

            //设置状态
            tree.setState(state);

            //递归
            if (!isEmpty(info.getChildren())) {
                tree.setNodes(getDictInfoTree(info.getChildren(), dictInfoParentId));
            }

            dictInfoTrees.add(tree);
        });

        return dictInfoTrees;
    }

    /**
     * 获取treebox使用
     *
     * @param dictInfs
     * @param selectId
     * @return
     */
    private List<Tree> getDictInfoTreeBox(List<DictInfo> dictInfs, String selectId) {
        List<Tree> dictInfoTrees = Lists.newArrayList();
        dictInfs.forEach(info -> {
            String id = toString(info.getId());
            String sdiCode = toString(info.getSdiCode());

            Tree tree = new Tree();
            tree.setId(id);
            tree.setSdiCode(sdiCode);
            tree.setText(toString(info.getSdiName()));
            tree.setTags(new String[]{"编码:" + toHtmlBColor(info.getSdiCode())});

            TreeState state = new TreeState();
            //是否选中
            if (sdiCode.equals(selectId)) {
                state.setChecked(true);
                //选中的设置打开
                state.setExpanded(true);
            }
            //是否禁用
            if (info.getIsStatus() == STATUS_ERROR) {
                tree.setSelectable(false);
            }

            //设置状态
            tree.setState(state);

            //递归
            if (!isEmpty(info.getChildren())) {
                tree.setNodes(getDictInfoTreeBox(info.getChildren(), selectId));
            }

            dictInfoTrees.add(tree);
        });

        return dictInfoTrees;
    }
}
