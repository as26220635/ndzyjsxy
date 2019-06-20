package cn.kim.service.impl;

import cn.kim.common.attr.MagicValue;
import cn.kim.common.attr.TableName;
import cn.kim.common.attr.Tips;
import cn.kim.common.eu.NameSpace;
import cn.kim.entity.ActiveUser;
import cn.kim.entity.DataTablesView;
import cn.kim.entity.QuerySet;
import cn.kim.exception.CustomException;
import cn.kim.service.DormitoryService;
import cn.kim.util.CommonUtil;
import cn.kim.util.TextUtil;
import com.google.common.collect.Maps;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/8/6
 * 楼管理
 */
@Service
public class DormitoryServiceImpl extends BaseServiceImpl implements DormitoryService {

    /***********    楼   *********/
    @Override
    public Map<String, Object> selectDormitoryFloor(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("ID", mapParam.get("ID"));
        return baseDao.selectOne(NameSpace.DormitoryMapper, "selectDormitoryFloor", paramMap);
    }

    @Override
    @Transactional
    public Map<String, Object> insertAndUpdateDormitoryFloor(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(10);
            String id = toString(mapParam.get("ID"));
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_DORMITORY_FLOOR);

            paramMap.put("ID", id);
            paramMap.put("BDF_NAME", mapParam.get("BDF_NAME"));
            paramMap.put("BDF_ADDRESS", mapParam.get("BDF_ADDRESS"));
            paramMap.put("BDF_NUMBER", mapParam.get("BDF_NUMBER"));
            paramMap.put("BDF_REMARKS", mapParam.get("BDF_REMARKS"));

            if (isEmpty(id)) {
                id = getId();
                paramMap.put("ID", id);
                paramMap.put("BDF_ENTRY_TIME", getDate());

                baseDao.insert(NameSpace.DormitoryMapper, "insertDormitoryFloor", paramMap);
                resultMap.put(MagicValue.LOG, "添加楼:" + toString(paramMap));
            } else {
                Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
                oldMap.put("ID", id);
                oldMap = selectDormitoryFloor(oldMap);

                baseDao.update(NameSpace.DormitoryMapper, "updateDormitoryFloor", paramMap);
                resultMap.put(MagicValue.LOG, "更新楼,更新前:" + formatColumnName(TableName.BUS_DORMITORY_FLOOR, oldMap) + ",更新后:" + formatColumnName(TableName.BUS_DORMITORY_FLOOR, paramMap));
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
    public Map<String, Object> deleteDormitoryFloor(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = DELETE_ERROR;
        try {
            if (isEmpty(mapParam.get("ID"))) {
                throw new CustomException(Tips.ID_NULL_ERROR);
            }
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
            String id = toString(mapParam.get("ID"));

            //删除楼表
            paramMap.clear();
            paramMap.put("ID", id);
            Map<String, Object> oldMap = selectDormitoryFloor(paramMap);
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_DORMITORY_FLOOR);
            baseDao.delete(NameSpace.DormitoryMapper, "deleteDormitoryFloor", paramMap);

            resultMap.put(MagicValue.LOG, "删除楼,信息:" + formatColumnName(TableName.BUS_DORMITORY_FLOOR, oldMap));
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
     * 更新楼室数
     *
     * @param id
     */
    public void updateDormitoryFloorNumber(String id) throws CustomException {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(2);
        paramMap.put("BDF_ID", id);
        int BDF_NUMBER = baseDao.selectOne(NameSpace.DormitoryMapper, "selectDormitoryRoomCount", paramMap);

        paramMap.clear();
        paramMap.put("ID", id);
        paramMap.put("BDF_NUMBER", BDF_NUMBER);
        validateResultMap(this.insertAndUpdateDormitoryFloor(paramMap));
    }

    /************   室   *************/
    @Override
    public Map<String, Object> selectDormitoryRoom(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("ID", mapParam.get("ID"));
        return baseDao.selectOne(NameSpace.DormitoryMapper, "selectDormitoryRoom", paramMap);
    }

    @Override
    @Transactional
    public Map<String, Object> insertAndUpdateDormitoryRoom(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(10);
            String id = toString(mapParam.get("ID"));
            String BDF_ID = toString(mapParam.get("BDF_ID"));
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_DORMITORY_ROOM);

            paramMap.put("ID", id);
            paramMap.put("BDR_NAME", mapParam.get("BDR_NAME"));
            paramMap.put("BDR_NUMBER", mapParam.get("BDR_NUMBER"));
            paramMap.put("BDR_REMARKS", mapParam.get("BDR_REMARKS"));

            if (isEmpty(id)) {
                id = getId();
                paramMap.put("ID", id);
                paramMap.put("BDF_ID", BDF_ID);
                paramMap.put("BDR_ENTRY_TIME", getDate());

                baseDao.insert(NameSpace.DormitoryMapper, "insertDormitoryRoom", paramMap);
                resultMap.put(MagicValue.LOG, "添加室:" + toString(paramMap));
                //更新楼 室数
                this.updateDormitoryFloorNumber(BDF_ID);
            } else {
                Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
                oldMap.put("ID", id);
                oldMap = selectDormitoryRoom(oldMap);

                baseDao.update(NameSpace.DormitoryMapper, "updateDormitoryRoom", paramMap);
                resultMap.put(MagicValue.LOG, "更新室,更新前:" + formatColumnName(TableName.BUS_DORMITORY_ROOM, oldMap) + ",更新后:" + formatColumnName(TableName.BUS_DORMITORY_ROOM, paramMap));
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
    public Map<String, Object> deleteDormitoryRoom(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = DELETE_ERROR;
        try {
            if (isEmpty(mapParam.get("ID"))) {
                throw new CustomException(Tips.ID_NULL_ERROR);
            }
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
            String id = toString(mapParam.get("ID"));

            //删除室表
            paramMap.clear();
            paramMap.put("ID", id);
            Map<String, Object> oldMap = selectDormitoryRoom(paramMap);
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_DORMITORY_ROOM);
            baseDao.delete(NameSpace.DormitoryMapper, "deleteDormitoryRoom", paramMap);

            resultMap.put(MagicValue.LOG, "删除室,信息:" + formatColumnName(TableName.BUS_DORMITORY_ROOM, oldMap));

            //更新楼 室数
            this.updateDormitoryFloorNumber(toString(oldMap.get("BDF_ID")));

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
     * 更新室 铺位数
     *
     * @param id
     */
    public void updateDormitoryRoomNumber(String id) throws CustomException {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(2);
        paramMap.put("BDR_ID", id);
        int BDR_NUMBER = baseDao.selectOne(NameSpace.DormitoryMapper, "selectDormitoryBerthCount", paramMap);

        paramMap.clear();
        paramMap.put("ID", id);
        paramMap.put("BDR_NUMBER", BDR_NUMBER);
        validateResultMap(this.insertAndUpdateDormitoryRoom(paramMap));
    }

    /************   铺位   *************/
    @Override
    public Map<String, Object> selectDormitoryBerth(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("ID", mapParam.get("ID"));
        return baseDao.selectOne(NameSpace.DormitoryMapper, "selectDormitoryBerth", paramMap);
    }

    @Override
    @Transactional
    public Map<String, Object> insertAndUpdateDormitoryBerth(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(10);
            String id = toString(mapParam.get("ID"));
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_DORMITORY_BERTH);

            paramMap.put("ID", id);

            paramMap.put("BDB_NAME", mapParam.get("BDB_NAME"));
            paramMap.put("BDB_REMARKS", mapParam.get("BDB_REMARKS"));

            if (isEmpty(id)) {
                id = getId();
                paramMap.put("ID", id);
                paramMap.put("BDR_ID", mapParam.get("BDR_ID"));
                paramMap.put("BDB_ENTRY_TIME", getDate());

                baseDao.insert(NameSpace.DormitoryMapper, "insertDormitoryBerth", paramMap);
                resultMap.put(MagicValue.LOG, "添加铺位:" + toString(paramMap));
                //更新室 铺位数
                this.updateDormitoryRoomNumber(toString(mapParam.get("BDR_ID")));
            } else {
                Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
                oldMap.put("ID", id);
                oldMap = selectDormitoryBerth(oldMap);

                baseDao.update(NameSpace.DormitoryMapper, "updateDormitoryBerth", paramMap);
                resultMap.put(MagicValue.LOG, "更新铺位,更新前:" + formatColumnName(TableName.BUS_DORMITORY_BERTH, oldMap) + ",更新后:" + formatColumnName(TableName.BUS_DORMITORY_BERTH, paramMap));
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
    public Map<String, Object> deleteDormitoryBerth(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = DELETE_ERROR;
        try {
            if (isEmpty(mapParam.get("ID"))) {
                throw new CustomException(Tips.ID_NULL_ERROR);
            }
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
            String id = toString(mapParam.get("ID"));

            //删除铺位表
            paramMap.clear();
            paramMap.put("ID", id);
            Map<String, Object> oldMap = selectDormitoryBerth(paramMap);
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_DORMITORY_BERTH);
            baseDao.delete(NameSpace.DormitoryMapper, "deleteDormitoryBerth", paramMap);

            resultMap.put(MagicValue.LOG, "删除铺位,信息:" + formatColumnName(TableName.BUS_DORMITORY_BERTH, oldMap));

            //更新室 铺位数
            this.updateDormitoryRoomNumber(toString(oldMap.get("BDR_ID")));

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
    public DataTablesView<?> selectDormitoryBerthList(Map<String, Object> mapParam) {
        DataTablesView<Map<String, Object>> dataTablesView = new DataTablesView<>();
        QuerySet querySet = new QuerySet();

        //连接名称
        if (!isEmpty(mapParam.get("name"))) {
            querySet.set(QuerySet.LIKE, "BDB_JOIN_NAME", mapParam.get("name"));
        }

        int offset = toInt(mapParam.get("start"));
        int limit = toInt(mapParam.get("length"));

        querySet.setOffset(offset);
        querySet.setLimit(limit);

        long count = baseDao.selectOne(NameSpace.DormitoryMapper, "selectDormitoryBerthListCount", querySet.getWhereMap());
        dataTablesView.setRecordsTotal(count);
        dataTablesView.setTotalPages(CommonUtil.getPage(count, limit));

        System.out.println(toString(querySet.getWhereMap()));
        List<Map<String, Object>> dataList = baseDao.selectList(NameSpace.DormitoryMapper, "selectDormitoryBerthList", querySet.getWhereMap());
        dataTablesView.setData(dataList);

        return dataTablesView;
    }

    /************   铺位人员   *************/
    @Override
    public Map<String, Object> selectDormitoryPersonnel(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("ID", mapParam.get("ID"));
        return baseDao.selectOne(NameSpace.DormitoryMapper, "selectDormitoryPersonnel", paramMap);
    }

    @Override
    @Transactional
    public Map<String, Object> insertAndUpdateDormitoryPersonnel(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        StringBuilder tips = new StringBuilder();
        try {
            ActiveUser activeUser = getActiveUser();
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(10);

            String id = toString(mapParam.get("ID"));
            String BDP_OPERATOR_ID = toString(mapParam.get("BDP_OPERATOR_ID"));
            String BDB_ID = toString(mapParam.get("BDB_ID"));

            paramMap.clear();
            paramMap.put("ID", BDB_ID);
            Map<String, Object> berth = baseDao.selectOne(NameSpace.DormitoryMapper, "selectDormitoryBerth", paramMap);

            paramMap.clear();
            paramMap.put("ID", berth.get("BDR_ID"));
            Map<String, Object> room = baseDao.selectOne(NameSpace.DormitoryMapper, "selectDormitoryRoom", paramMap);

            paramMap.clear();
            paramMap.put("ID", room.get("BDF_ID"));
            Map<String, Object> floor = baseDao.selectOne(NameSpace.DormitoryMapper, "selectDormitoryFloor", paramMap);

            //查询铺位 和人员是否已被选择 已被选择 删除铺位记录
            paramMap.clear();
            paramMap.put("NOT_ID", id);
            paramMap.put("BDB_ID", BDB_ID);
            Map<String, Object> oldBerth = baseDao.selectOne(NameSpace.DormitoryMapper, "selectDormitoryPersonnel", paramMap);
            if (!isEmpty(oldBerth)) {
                //删除记录
                paramMap.clear();
                paramMap.put("ID", oldBerth.get("ID"));
                Map<String, Object> validateResult = this.deleteDormitoryPersonnel(paramMap);
                validateResultMap(validateResult);
                tips.append("铺位已被占用,删除占用信息,原铺位(" + oldBerth.get("BDP_JOIN_NAME") + ")人员(" + oldBerth.get("BDP_OPERATOR_NAME") + ")" + "记录已被移除!<br>");
            }
            paramMap.clear();
            paramMap.put("NOT_ID", id);
            paramMap.put("BDP_OPERATOR_ID", BDP_OPERATOR_ID);
            oldBerth = baseDao.selectOne(NameSpace.DormitoryMapper, "selectDormitoryPersonnel", paramMap);
            if (!isEmpty(oldBerth)) {
                //删除记录
                paramMap.clear();
                paramMap.put("ID", oldBerth.get("ID"));
                Map<String, Object> validateResult = this.deleteDormitoryPersonnel(paramMap);
                validateResultMap(validateResult);
                tips.append("人员已经存在铺位,删除占用信息,原铺位(" + oldBerth.get("BDP_JOIN_NAME") + ")人员(" + oldBerth.get("BDP_OPERATOR_NAME") + ")" + "记录已被移除!<br>");
            }


            String BDF_NAME = toString(floor.get("BDF_NAME"));
            String BDR_NAME = toString(room.get("BDR_NAME"));
            String BDB_NAME = toString(berth.get("BDB_NAME"));

            Map<String, Object> accountInfo = selectAccountInfo(BDP_OPERATOR_ID);

            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_DORMITORY_PERSONNEL);

            paramMap.put("ID", id);
            paramMap.put("BDF_NAME", BDF_NAME);
            paramMap.put("BDR_NAME", BDR_NAME);
            paramMap.put("BDB_NAME", BDB_NAME);
            paramMap.put("BDP_JOIN_NAME", TextUtil.joinValue("-", BDF_NAME, BDR_NAME, BDB_NAME));
            paramMap.put("BDP_OPERATOR_ID", accountInfo.get("SO_ID"));
            paramMap.put("BDP_OPERATOR_NAME", accountInfo.get("SAI_NAME"));
            paramMap.put("BDP_OPERATOR_TYPE", accountInfo.get("SAI_TYPE"));

            if (isEmpty(id)) {
                id = getId();
                paramMap.put("ID", id);
                paramMap.put("BDB_ID", BDB_ID);
                paramMap.put("BDP_ENTRY_TIME", getDate());
                paramMap.put("SO_ID", activeUser.getId());

                baseDao.insert(NameSpace.DormitoryMapper, "insertDormitoryPersonnel", paramMap);
                resultMap.put(MagicValue.LOG, "添加铺位人员:" + toString(paramMap));

                //插入日志
                insertDormitoryLog(baseDao, BDB_ID, BDP_OPERATOR_ID, MagicValue.RECODE_TYPE_INSERT);
            } else {
                Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
                oldMap.put("ID", id);
                oldMap = selectDormitoryPersonnel(oldMap);

                baseDao.update(NameSpace.DormitoryMapper, "updateDormitoryPersonnel", paramMap);
                resultMap.put(MagicValue.LOG, "更新铺位人员,更新前:" + formatColumnName(TableName.BUS_DORMITORY_PERSONNEL, oldMap) + ",更新后:" + formatColumnName(TableName.BUS_DORMITORY_PERSONNEL, paramMap));

                //插入日志
                insertDormitoryLog(baseDao, BDB_ID, BDP_OPERATOR_ID, MagicValue.RECODE_TYPE_UPDATE);
            }
            status = STATUS_SUCCESS;
            desc = isEmpty(tips.toString()) ? SAVE_SUCCESS : tips.toString();

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
    public Map<String, Object> deleteDormitoryPersonnel(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = DELETE_ERROR;
        try {
            if (isEmpty(mapParam.get("ID"))) {
                throw new CustomException(Tips.ID_NULL_ERROR);
            }
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);

            String id = toString(mapParam.get("ID"));

            paramMap.put("ID", id);
            Map<String, Object> oldMap = selectDormitoryPersonnel(paramMap);

            //插入日志
            insertDormitoryLog(baseDao, toString(oldMap.get("BDB_ID")), toString(oldMap.get("BDP_OPERATOR_ID")), MagicValue.RECODE_TYPE_DELETE);

            //删除铺位人员表
            paramMap.clear();
            paramMap.put("ID", id);
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_DORMITORY_PERSONNEL);
            baseDao.delete(NameSpace.DormitoryMapper, "deleteDormitoryPersonnel", paramMap);

            resultMap.put(MagicValue.LOG, "删除铺位人员,信息:" + formatColumnName(TableName.BUS_DORMITORY_PERSONNEL, oldMap));
            status = STATUS_SUCCESS;
            desc = DELETE_SUCCESS;
        } catch (Exception e) {
            desc = catchException(e, baseDao, resultMap);
        }
        resultMap.put(MagicValue.STATUS, status);
        resultMap.put(MagicValue.DESC, desc);
        return resultMap;
    }
}
