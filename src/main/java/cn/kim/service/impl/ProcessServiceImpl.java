package cn.kim.service.impl;

import cn.kim.common.attr.*;
import cn.kim.common.eu.NameSpace;
import cn.kim.common.eu.ProcessStatus;
import cn.kim.common.eu.ProcessType;
import cn.kim.entity.ActiveUser;
import cn.kim.entity.ProcessRunBean;
import cn.kim.entity.Tree;
import cn.kim.entity.TreeState;
import cn.kim.exception.CustomException;
import cn.kim.service.ProcessService;
import cn.kim.service.util.ProcessCheck;
import cn.kim.service.util.ProcessExecute;
import cn.kim.util.CacheUtil;
import cn.kim.util.DateUtil;
import cn.kim.util.TextUtil;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 * Created by 余庚鑫 on 2018/5/22
 */
@Service
public class ProcessServiceImpl extends BaseServiceImpl implements ProcessService {

    /**
     * 前进校验
     */
    @Autowired
    private ProcessCheck processCheck;
    /**
     * 前进执行
     */
    @Autowired
    private ProcessExecute processExecute;

    /****   流程    ***/

    /**
     * 查询流程项目名称
     *
     * @param tableId
     * @param busProcess
     * @param busProcess2
     * @return
     */
    @Override
    public String selectProcessTableName(String tableId, String busProcess, String busProcess2) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(3);
        paramMap.put("BUS_PROCESS", busProcess);
        paramMap.put("BUS_PROCESS2", busProcess2);
        Map<String, Object> definition = this.selectProcessDefinition(paramMap);

        paramMap.clear();
        paramMap.put("SPD_TABLE_ID", tableId);
        paramMap.put("SPD_UPDATE_TABLE", definition.get("SPD_UPDATE_TABLE"));
        paramMap.put("SPD_UPDATE_NAME", definition.get("SPD_UPDATE_NAME"));

        return baseDao.selectOne(NameSpace.ProcessMapper, "selectProcessTableName", paramMap);
    }

    /**
     * -1 无 0 提交按钮 1 退回按钮 2 撤回按钮
     *
     * @param id
     * @param process
     * @param process2
     * @return
     */
    @Override
    public String showDataGridProcessBtn(String id, String process, String process2) throws Exception {
        if (isEmpty(id) || isEmpty(process) || isEmpty(process2)) {
            throw new CustomException("参数错误!");
        }
        ActiveUser activeUser = getActiveUser();
        String operatorId = activeUser.getId();

        String resultBtn = "";
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(5);
        paramMap.put("BUS_PROCESS", process);
        paramMap.put("BUS_PROCESS2", process2);
        Map<String, Object> definition = this.selectProcessDefinition(paramMap);
        //流程停用就没有按钮
        if (isEmpty(definition) || isDiscontinuation(definition)) {
            return resultBtn;
        }
        String definitionId = toString(definition.get("ID"));

        //1:查询是否流程记录表拥有记录
        paramMap.clear();
        paramMap.put("SPS_TABLE_ID", id);
        paramMap.put("SPD_ID", definitionId);
        paramMap.put("SPS_IS_CANCEL", toString(STATUS_ERROR));
        Map<String, Object> schedule = this.selectProcessSchedule(paramMap);
        //2:判断是否进度为空或者状态为启动人员，说明没有启动
        if (!isEmpty(schedule) && toInt(schedule.get("SPS_AUDIT_STATUS")) != ProcessStatus.START.getType()) {
            //3:判断是否已完成
            if (ProcessStatus.COMPLETE.getType() == toInt(schedule.get("SPS_AUDIT_STATUS"))) {
                return ProcessType.NONE.toString();
            }
            //4:判断进度是不是退回状态
            if (toInt(schedule.get("SPS_AUDIT_STATUS")) == ProcessStatus.BACK.getType()) {
                if (toString(schedule.get("SPS_STEP_TRANSACTOR")).equals(operatorId)) {
                    //查询当前流程步骤是否存在
                    paramMap.clear();
                    paramMap.put("SPD_ID", definitionId);
                    paramMap.put("SPS_PROCESS_STATUS", toString(schedule.get("SPS_BACK_STATUS_TRANSACTOR")));
                    Map<String, Object> step = this.selectProcessStep(paramMap);
                    if (!isEmpty(step)) {
                        //查询是否是第一个节点
                        paramMap.clear();
                        paramMap.put("SPD_ID", definitionId);
//                        paramMap.put("SR_ID", step.get("SR_ID"));
                        paramMap.put("SPS_PROCESS_STATUS", schedule.get("SPS_BACK_STATUS_TRANSACTOR"));
                        List<Map<String, Object>> prevStepList = this.processPrevStepList(paramMap);
                        //不是启动步骤
                        if (prevStepList.size() > 0) {
                            resultBtn += ProcessType.SUBMIT.toString() + SERVICE_SPLIT + ProcessType.BACK.toString();
                        } else {
                            resultBtn += ProcessType.SUBMIT.toString();
                        }
                    }
                }
            } else {
                //4:进度不为空查询当前角色或人员是否可以提交当前流程
                if (MagicValue.ONE.equals(toString(schedule.get("SPS_STEP_TYPE")))) {
                    //当前办理为角色
                    if (containsRole(toString(schedule.get("SPS_STEP_TRANSACTOR")))) {
                        //查询流程步骤是否存在
                        paramMap.clear();
                        paramMap.put("SPD_ID", definitionId);
                        paramMap.put("SR_ID", schedule.get("SPS_STEP_TRANSACTOR"));
                        paramMap.put("SPS_PROCESS_STATUS", schedule.get("SPS_AUDIT_STATUS"));
                        Map<String, Object> step = this.selectProcessStep(paramMap);
                        if (!isEmpty(step)) {
                            resultBtn += ProcessType.SUBMIT.toString() + SERVICE_SPLIT + ProcessType.BACK.toString();
                        }
                    }
                } else if (MagicValue.TWO.equals(toString(schedule.get("SPS_STEP_TYPE")))) {
                    //当前办理为人员
                    if (toString(schedule.get("SPS_STEP_TRANSACTOR")).equals(operatorId)) {
                        //查询当前流程步骤是否存在
                        paramMap.clear();
                        paramMap.put("SPD_ID", definitionId);
                        paramMap.put("SPS_PROCESS_STATUS", schedule.get("SPS_AUDIT_STATUS"));
                        Map<String, Object> step = this.selectProcessStep(paramMap);
                        if (!isEmpty(step)) {
                            resultBtn += ProcessType.SUBMIT.toString() + ProcessType.BACK.toString();
                        }
                    }
                }
            }

            //不能是退回状态
            if (toInt(schedule.get("SPS_AUDIT_STATUS")) != -1) {
                //5:上次办理人是自己切 当前步骤之前只有自己出现一次说明是第一次经过
                if (toString(schedule.get("SPS_PREV_STEP_TRANSACTOR")).equals(operatorId)) {
//                    //查询上一步骤办理人
//                    paramMap.clear();
//                    paramMap.put("ID", schedule.get("SPS_PREV_STEP_ID"));
//                    Map<String, Object> prevStep = this.selectProcessStep(paramMap);
//                    //查询当前办理角色是否是第一个
//                    paramMap.clear();
//                    paramMap.put("SPD_ID", definitionId);
//                    paramMap.put("SR_ID", prevStep.get("SR_ID"));
//                    paramMap.put("SPS_PROCESS_STATUS", schedule.get("SPS_AUDIT_STATUS"));
//                    List<Map<String, Object>> stepList = this.processPrevStepList(paramMap);
//                    if (stepList.size() == 1) {
                    resultBtn += ProcessType.WITHDRAW.toString();
//                    }
                }
            }

        } else {
            //3:查询是否是流程启动角色,是的话返回提交按钮
            List<Map<String, Object>> startRoleList = this.selectProcessStartList(paramMap);
            String roleStr = TextUtil.joinValue(startRoleList, "SR_ID", SERVICE_SPLIT);
            if (!isEmpty(roleStr) && containsRole(roleStr)) {
                resultBtn += ProcessType.SUBMIT.toString();
            }
        }

        return resultBtn;
    }

    /**
     * 获取当前项目的下一步步骤
     *
     * @param definitionId        流程定义ID
     * @param scheduleAuditStatus 流程办理状态
     * @return
     */
    @Override
    @Transactional
    public Map<String, Object> processNextStep(String definitionId, String scheduleAuditStatus) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(2);
        //查询关联进度表
        paramMap.put("SPD_ID", definitionId);
        paramMap.put("SPS_PROCESS_STATUS", scheduleAuditStatus);

        return baseDao.selectOne(NameSpace.ProcessFixedMapper, "selectProcessNextStep", paramMap);
    }

    /**
     * 获取当前项目的上一步步骤
     *
     * @param definitionId        流程定义ID
     * @param scheduleAuditStatus 流程办理状态
     * @return
     */
    @Override
    @Transactional
    public Map<String, Object> processPrevStep(String definitionId, String scheduleAuditStatus) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(2);
        //查询关联进度表
        paramMap.put("SPD_ID", definitionId);
        paramMap.put("SPS_PROCESS_STATUS", scheduleAuditStatus);

        return baseDao.selectOne(NameSpace.ProcessFixedMapper, "selectProcessPrevStep", paramMap);
    }

    @Override
    @Transactional
    public List<Map<String, Object>> processPrevStepList(String definitionId, String scheduleAuditStatus) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(2);
        //查询关联进度表
        paramMap.put("SPD_ID", definitionId);
        paramMap.put("SPS_PROCESS_STATUS", scheduleAuditStatus);
        paramMap.put("ALL", true);

        return baseDao.selectList(NameSpace.ProcessFixedMapper, "selectProcessPrevStep", paramMap);
    }

    /**
     * 根据当前角色ids查询流程定义最高的启动角色
     *
     * @param definitionId
     * @param roleIds
     * @return
     */
    @Override
    public Map<String, Object> processStepStartRoleTop(String definitionId, String roleIds) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(2);
        //查询关联进度表
        paramMap.put("SPD_ID", definitionId);
        paramMap.put("SR_IDS", roleIds);

        return baseDao.selectOne(NameSpace.ProcessFixedMapper, "selectProcessStepStartRoleTop", paramMap);
    }

    private List<Map<String, Object>> processPrevStepList(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(4);
        //查询关联进度表
        paramMap.put("SPD_ID", mapParam.get("SPD_ID"));
        paramMap.put("SPS_PROCESS_STATUS", toString(mapParam.get("SPS_PROCESS_STATUS")));
        paramMap.put("SR_ID", mapParam.get("SR_ID"));
        paramMap.put("ALL", true);

        return baseDao.selectList(NameSpace.ProcessFixedMapper, "selectProcessPrevStep", paramMap);
    }

    /**
     * 提交流程
     *
     * @param mapParam
     * @return
     */
    @Override
    @Transactional
    public Map<String, Object> processSubmit(Map<String, Object> mapParam) {
        ActiveUser activeUser = getActiveUser();
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = Tips.PROCESS_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(8);

            //查询流程
            paramMap.put("BUS_PROCESS", mapParam.get("BUS_PROCESS"));
            paramMap.put("BUS_PROCESS2", mapParam.get("BUS_PROCESS2"));
            Map<String, Object> definition = this.selectProcessDefinition(paramMap);
            //流程停用就没有按钮
            if (isDiscontinuation(definition)) {
                throw new CustomException("流程已经停用!");
            }

            //流程办理类型
            String processType = toString(mapParam.get("PROCESS_TYPE"));
            //流程定义ID
            String definitionId = toString(definition.get("ID"));
            //流程办理ID
            String scheduleTableId = toString(mapParam.get("SPS_TABLE_ID"));
            //流程办理表名称
            String scheduleTableName = toString(mapParam.get("SPS_TABLE_NAME"));
            //流程当前步骤办理ID
            String stepId = toString(mapParam.get("SPS_ID"));
            //流程下一步骤办理ID
            String nextStepId = toString(mapParam.get("NEXT_SPS_ID"));
            //下一步骤办理人
            String scheduleStepTransactor = toString(mapParam.get("SPS_STEP_TRANSACTOR"));
            //办理意见
            String logOpinion = toString(mapParam.get("SPL_OPINION"));

            if (isEmpty(scheduleTableId) || isEmpty(definitionId) || isEmpty(processType)) {
                throw new CustomException("参数错误!");
            }

            //错误提示信息
            String error = "";
            Map<String, Object> resultIUMap = null;
            Map<String, Object> executeMap = Maps.newHashMapWithExpectedSize(5);
            //流程当前办理状态
            String scheduleAuditStatus = "0";
            //流程当前办理步骤
            String scheduleStepType = "0";
            //流程退回状态
            String scheduleBackStatus = "0";
            //退回到的审核状态
            String scheduleBackStatusTransactor = "-1";
            //查询当前步骤
            paramMap.clear();
            paramMap.put("ID", stepId);
            Map<String, Object> step = this.selectProcessStep(paramMap);
            if (isEmpty(step)) {
                throw new CustomException("流程办理失败,请联系管理员!");
            }
            //提交流程时查询流程办理是否超时
            if (processType.equals(ProcessType.SUBMIT.toString()) && toInt(step.get("SPS_IS_OVER_TIME")) == STATUS_SUCCESS) {
                //超时时间,没有填写默认24小时 1440分钟
                int stepOverTime = isEmpty(step.get("SPS_OVER_TIME")) ? 1440 : toInt(step.get("SPS_OVER_TIME"));
                String nowDateStr = getSqlDate();
                long nowDateTime = DateUtil.getDateTime(DateUtil.FORMAT, nowDateStr).getTime();
                //获取最后可以办理的时间
                Date lastDate = DateUtil.moveMinuteDate(true, DateUtil.getDateTime(DateUtil.FORMAT, nowDateStr), stepOverTime);
                long lastDateTime = lastDate.getTime();

                if (nowDateTime > lastDateTime) {
                    throw new CustomException("超过办理时间,最后办理时间:" + DateUtil.getDate(DateUtil.FORMAT, lastDate) + "!");
                }
            }

            //流程运行传递参数
            ProcessRunBean processRunBean = new ProcessRunBean();
            processRunBean.setBaseDao(baseDao);
            processRunBean.setDefinitionId(definitionId);
            processRunBean.setBusTableId(scheduleTableId);
            processRunBean.setBusProcess(toString(definition.get("BUS_PROCESS")));
            processRunBean.setBusProcess2(toString(definition.get("BUS_PROCESS2")));
            processRunBean.setExecuteMap(executeMap);

            //是否进行前进后退执行或验证
            if (processType.equals(ProcessType.SUBMIT.toString())) {
                //是否前进校验
                if (toInt(step.get("SPS_IS_ADVANCE_CHECK")) == STATUS_SUCCESS) {
                    error = processCheck.advanceCheck(processRunBean);
                }
                //如果有错误就抛出
                if (!isEmpty(error)) {
                    throw new CustomException(error);
                }

                //查询下一步骤办理状态
                paramMap.clear();
                paramMap.put("ID", nextStepId);
                Map<String, Object> nextStep = this.selectProcessStep(paramMap);

                scheduleAuditStatus = toString(nextStep.get("SPS_PROCESS_STATUS"));
                scheduleStepType = toString(nextStep.get("SPS_STEP_TYPE"));

            } else if (processType.equals(ProcessType.BACK.toString())) {
                //是否退回校验
                if (toInt(step.get("SPS_IS_RETREAT_CHECK")) == STATUS_SUCCESS) {
                    error = processCheck.retreatCheck(processRunBean);
                }
                //如果有错误就抛出
                if (!isEmpty(error)) {
                    throw new CustomException(error);
                }

                //解析退回办理人
                String[] processHandles = scheduleStepTransactor.split(SERVICE_SPLIT);

                //查询流程步骤，拿到对应的节点
                paramMap.clear();
                paramMap.put("SPD_ID", definitionId);
                paramMap.put("SPS_PROCESS_STATUS", processHandles[0]);
                Map<String, Object> backStep = this.selectProcessStep(paramMap);
                if (isEmpty(backStep)) {
                    throw new CustomException("流程退回失败,请联系管理员!");
                }

                //退回审核状态,人员
                scheduleStepType = "2";
                //退回办理人
                scheduleBackStatusTransactor = processHandles[0];
                scheduleStepTransactor = processHandles[1];
                //退回审核状态
                scheduleAuditStatus = ProcessStatus.BACK.toString();
                scheduleBackStatus = ProcessType.BACK.toString();
            }

            //查询流程进度是否存在
            paramMap.clear();
            paramMap.put("SPD_ID", definitionId);
            paramMap.put("SPS_TABLE_ID", scheduleTableId);
            paramMap.put("SPS_IS_CANCEL", toString(STATUS_ERROR));
            Map<String, Object> schedule = this.selectProcessSchedule(paramMap);
            //如果为空就插入
            if (isEmpty(schedule) || ProcessStatus.START.toString().equals(toString(schedule.get("SPS_AUDIT_STATUS")))) {
                if (isEmpty(schedule)) {
                    schedule = Maps.newHashMapWithExpectedSize(16);
                    schedule.put("SPD_ID", definitionId);
                    schedule.put("SPS_TABLE_ID", scheduleTableId);
                    schedule.put("SO_ID", activeUser.getId());
                    schedule.put("SHOW_SO_ID", mapParam.get("SHOW_SO_ID"));
                }
                schedule.put("SPS_PREV_AUDIT_STATUS", ProcessStatus.START.toString());
            } else {
                //判断流程是否重复审核
                if (toInt(schedule.get("SPS_AUDIT_STATUS")) != ProcessStatus.BACK.getType() &&
                        toInt(schedule.get("SPS_PREV_AUDIT_STATUS")) != ProcessStatus.BACK.getType() &&
                        toString(schedule.get("SPS_PREV_AUDIT_STATUS")).equals(scheduleAuditStatus)) {
                    throw new CustomException("流程重复审核!");
                }
                //上一步流程审核状态
                schedule.put("SPS_PREV_AUDIT_STATUS", schedule.get("SPS_AUDIT_STATUS"));
            }
            schedule.put("SPS_ID", nextStepId);
            schedule.put("SPS_TABLE_NAME", scheduleTableName);
            schedule.put("SPS_AUDIT_STATUS", scheduleAuditStatus);
            schedule.put("SPS_BACK_STATUS", scheduleBackStatus);
            schedule.put("SPS_BACK_STATUS_TRANSACTOR", scheduleBackStatusTransactor);
            schedule.put("SPS_STEP_TYPE", scheduleStepType);
            schedule.put("SPS_STEP_TRANSACTOR", scheduleStepTransactor);
            //办理类型
            schedule.put("SPS_PREV_STEP_TYPE", processType);
            schedule.put("SPS_PREV_STEP_TRANSACTOR", activeUser.getId());
            schedule.put("SPS_PREV_STEP_ID", stepId);
            resultIUMap = this.insertAndUpdateProcessSchedule(schedule);


            validateResultMap(resultIUMap);

            //流程进度表ID
            String scheduleId = toString(resultIUMap.get("ID"));

            //插入流程办理日志
            paramMap.clear();
            paramMap.put("SPS_ID", scheduleId);
            paramMap.put("SPL_TABLE_ID", scheduleTableId);
            paramMap.put("SPL_SO_ID", activeUser.getId());
            paramMap.put("SPL_TRANSACTOR", activeUser.getUsername());
            paramMap.put("SPL_OPINION", logOpinion);
            paramMap.put("SPL_ENTRY_TIME", getSqlDate());
            paramMap.put("SPL_TYPE", processType);
            paramMap.put("SPL_PROCESS_STATUS", step.get("SPS_PROCESS_STATUS"));

            resultIUMap = this.insertProcessLog(paramMap);
            validateResultMap(resultIUMap);

            //流程通过额外插入完成日志
            if (processType.equals(ProcessType.SUBMIT.toString()) && "999".equals(scheduleAuditStatus)) {
                paramMap.clear();
                paramMap.put("SPS_ID", scheduleId);
                paramMap.put("SPL_TABLE_ID", scheduleTableId);
                paramMap.put("SPL_SO_ID", activeUser.getId());
                paramMap.put("SPL_TRANSACTOR", activeUser.getUsername());
                paramMap.put("SPL_OPINION", "审核通过(系统)");
                paramMap.put("SPL_ENTRY_TIME", getSqlDate());
                paramMap.put("SPL_TYPE", processType);
                paramMap.put("SPL_PROCESS_STATUS", scheduleAuditStatus);

                resultIUMap = this.insertProcessLog(paramMap);
                validateResultMap(resultIUMap);
            }

            //是否进行前进后退执行或验证
            if (processType.equals(ProcessType.SUBMIT.toString())) {
                //是否前进执行
                if (toInt(step.get("SPS_IS_ADVANCE_EXECUTE")) == STATUS_SUCCESS) {
                    error = processExecute.advanceExecute(processRunBean);
                }
            } else if (processType.equals(ProcessType.BACK.toString())) {
                //是否退回执行
                if (toInt(step.get("SPS_IS_RETREAT_EXECUTE")) == STATUS_SUCCESS) {
                    error = processExecute.retreatExecute(processRunBean);
                }
            }
            //如果有错误就抛出
            if (!isEmpty(error)) {
                throw new CustomException(error);
            }
            status = STATUS_SUCCESS;
            desc = Tips.PROCESS_SUCCESS;

        } catch (Exception e) {
            desc = catchException(e, baseDao, resultMap);
        }
        resultMap.put(MagicValue.STATUS, status);
        resultMap.put(MagicValue.DESC, desc);

        return resultMap;
    }

    /**
     * 撤回流程
     *
     * @param mapParam
     * @return
     */
    @Override
    @Transactional
    public Map<String, Object> processWithdraw(Map<String, Object> mapParam) {
        ActiveUser activeUser = getActiveUser();
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = Tips.PROCESS_ERROR;

        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(3);
            paramMap.put("BUS_PROCESS", mapParam.get("BUS_PROCESS"));
            paramMap.put("BUS_PROCESS2", mapParam.get("BUS_PROCESS2"));
            Map<String, Object> definition = this.selectProcessDefinition(paramMap);

            //流程定义ID
            String definitionId = toString(definition.get("ID"));
            //流程办理ID
            String scheduleTableId = toString(mapParam.get("SPS_TABLE_ID"));

            if (isEmpty(definitionId) || isEmpty(scheduleTableId)) {
                throw new CustomException("参数错误!");
            }

            Map<String, Object> resultIUMap = null;
            //查询流程进度
            paramMap.put("SPD_ID", definitionId);
            paramMap.put("SPS_TABLE_ID", scheduleTableId);
            paramMap.put("SPS_IS_CANCEL", toString(STATUS_ERROR));
            Map<String, Object> schedule = this.selectProcessSchedule(paramMap);
            //判断流程是否可以撤回
            if (toInt(schedule.get("SPS_AUDIT_STATUS")) == ProcessStatus.BACK.getType() ||
                    !toString(schedule.get("SPS_PREV_STEP_TRANSACTOR")).equals(activeUser.getId())) {
                throw new CustomException("流程撤回失败,请检查流程状态!");
            }
            //查询上一步的ID
            paramMap.clear();
            paramMap.put("SPD_ID", definitionId);
            paramMap.put("SPS_PROCESS_STATUS", schedule.get("SPS_AUDIT_STATUS"));
            Map<String, Object> withdrawStep = this.processPrevStepList(paramMap).get(0);
            //上一步流程审核状态
            schedule.put("SPS_PREV_AUDIT_STATUS", schedule.get("SPS_AUDIT_STATUS"));
            schedule.put("SPS_AUDIT_STATUS", ProcessStatus.BACK.getType());
            schedule.put("SPS_BACK_STATUS", ProcessType.WITHDRAW.toString());
            schedule.put("SPS_BACK_STATUS_TRANSACTOR", withdrawStep.get("SPS_PROCESS_STATUS"));
            schedule.put("SPS_STEP_TYPE", 2);
            schedule.put("SPS_STEP_TRANSACTOR", activeUser.getId());
            //办理类型
            schedule.put("SPS_PREV_STEP_TYPE", ProcessType.WITHDRAW.toString());
            schedule.put("SPS_PREV_STEP_TRANSACTOR", activeUser.getId());
            schedule.put("SPS_PREV_STEP_ID", schedule.get("SPS_ID"));
            schedule.put("SPS_ID", withdrawStep.get("ID"));
            resultIUMap = this.insertAndUpdateProcessSchedule(schedule);
            validateResultMap(resultIUMap);

            //流程进度表ID
            String scheduleId = toString(resultIUMap.get("ID"));

            //插入流程办理日志
            paramMap.clear();
            paramMap.put("SPS_ID", scheduleId);
            paramMap.put("SPL_TABLE_ID", scheduleTableId);
            paramMap.put("SPL_SO_ID", activeUser.getId());
            paramMap.put("SPL_TRANSACTOR", activeUser.getUsername());
            paramMap.put("SPL_OPINION", "用户撤回(系统)");
            paramMap.put("SPL_ENTRY_TIME", getSqlDate());
            paramMap.put("SPL_TYPE", ProcessType.WITHDRAW.toString());
            paramMap.put("SPL_PROCESS_STATUS", ProcessStatus.BACK.getType());

            resultIUMap = this.insertProcessLog(paramMap);
            validateResultMap(resultIUMap);

            status = STATUS_SUCCESS;
            desc = Tips.PROCESS_SUCCESS;
        } catch (Exception e) {
            desc = catchException(e, baseDao, resultMap);
        }
        resultMap.put(MagicValue.STATUS, status);
        resultMap.put(MagicValue.DESC, desc);

        return resultMap;
    }


    /****   流程定义    ***/

    @Override
    public Map<String, Object> selectProcessDefinitionById(String ID) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("ID", ID);
        return this.selectProcessDefinition(paramMap);
    }

    @Override
    public Map<String, Object> selectProcessDefinition(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(3);
        paramMap.put("ID", mapParam.get("ID"));
        paramMap.put("BUS_PROCESS", mapParam.get("BUS_PROCESS"));
        paramMap.put("BUS_PROCESS2", mapParam.get("BUS_PROCESS2"));
        return baseDao.selectOne(NameSpace.ProcessFixedMapper, "selectProcessDefinition", paramMap);
    }

    @Override
    public List<Tree> selectProcessDefinitionTreeList(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("IS_STATUS", STATUS_SUCCESS);
        List<Map<String, Object>> definitionList = baseDao.selectList(NameSpace.ProcessFixedMapper, "selectProcessDefinition", paramMap);

        return getDefinitionTree(definitionList, toString(mapParam.get("ID")));
    }


    @Override
    @Transactional
    public Map<String, Object> insertAndUpdateProcessDefinition(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(14);
            String id = toString(mapParam.get("ID"));
            //查询大小类是否重复
            paramMap.put("NOT_ID", id);
            paramMap.put("BUS_PROCESS", mapParam.get("BUS_PROCESS"));
            paramMap.put("BUS_PROCESS2", mapParam.get("BUS_PROCESS2"));
            int count = baseDao.selectOne(NameSpace.ProcessFixedMapper, "selectProcessDefinitionCount", paramMap);
            if (count > 0) {
                throw new CustomException("流程大小类重复!");
            }
            //记录日志
            paramMap.clear();
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.SYS_PROCESS_DEFINITION);

            paramMap.put("ID", id);
            paramMap.put("SO_ID", mapParam.get("SO_ID"));
            paramMap.put("SR_ID", mapParam.get("SR_ID"));
            paramMap.put("BUS_PROCESS", mapParam.get("BUS_PROCESS"));
            paramMap.put("BUS_PROCESS2", mapParam.get("BUS_PROCESS2"));
            paramMap.put("SPD_NAME", mapParam.get("SPD_NAME"));
            paramMap.put("SPD_VERSION", mapParam.get("SPD_VERSION"));
            paramMap.put("SPD_UPDATE_TABLE", mapParam.get("SPD_UPDATE_TABLE"));
            paramMap.put("SPD_UPDATE_NAME", mapParam.get("SPD_UPDATE_NAME"));
            paramMap.put("SPD_COLLEGE_FIELD", mapParam.get("SPD_COLLEGE_FIELD"));
            paramMap.put("SPD_DEPARTMENT_FIELD", mapParam.get("SPD_DEPARTMENT_FIELD"));
            paramMap.put("SPD_CLASS_FIELD", mapParam.get("SPD_CLASS_FIELD"));
            paramMap.put("SPD_DESCRIBE", mapParam.get("SPD_DESCRIBE"));
            paramMap.put("SDP_ENTRY_TIME", mapParam.get("SDP_ENTRY_TIME"));
            paramMap.put("IS_STATUS", mapParam.get("IS_STATUS"));
            paramMap.put("IS_MULTISTAGE_BACK", mapParam.get("IS_MULTISTAGE_BACK"));
            paramMap.put("IS_TIME_CONTROL", mapParam.get("IS_TIME_CONTROL"));

            if (isEmpty(id)) {
                id = getId();
                paramMap.put("ID", id);
                paramMap.put("IS_STATUS", Attribute.STATUS_SUCCESS);
                paramMap.put("SO_ID", getActiveUser().getId());
                paramMap.put("SDP_ENTRY_TIME", getSqlDate());

                baseDao.insert(NameSpace.ProcessFixedMapper, "insertProcessDefinition", paramMap);
                resultMap.put(MagicValue.LOG, "添加流程定义:" + formatColumnName(TableName.SYS_PROCESS_DEFINITION, paramMap));
            } else {
                Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
                oldMap.put("ID", id);
                oldMap = selectProcessDefinition(oldMap);

                baseDao.update(NameSpace.ProcessFixedMapper, "updateProcessDefinition", paramMap);
                resultMap.put(MagicValue.LOG, "更新流程定义,更新前:" + formatColumnName(TableName.SYS_PROCESS_DEFINITION, oldMap) + ",更新后:" + formatColumnName(TableName.SYS_PROCESS_DEFINITION, paramMap));
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
    public Map<String, Object> changeProcessDefinitionStatus(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(3);
            String id = toString(mapParam.get("ID"));
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.SYS_PROCESS_DEFINITION);

            paramMap.put("ID", id);
            paramMap.put("IS_STATUS", mapParam.get("IS_STATUS"));

            Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
            oldMap.put("ID", id);
            oldMap = selectProcessDefinition(oldMap);

            baseDao.update(NameSpace.ProcessFixedMapper, "updateProcessDefinition", paramMap);
            resultMap.put(MagicValue.LOG, "更新流程定义状态,流程定义名:" + toString(oldMap.get("SPD_NAME")) + ",状态更新为:" + ParamTypeResolve.statusExplain(mapParam.get("IS_STATUS")));

            //清除缓存
            CacheUtil.clear(NameSpace.MenuMapper.getValue());

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
    public Map<String, Object> copyProcessDefinition(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(3);
            String id = toString(mapParam.get("ID"));
            //查询大小类是否重复
            paramMap.put("BUS_PROCESS", mapParam.get("BUS_PROCESS"));
            paramMap.put("BUS_PROCESS2", mapParam.get("BUS_PROCESS2"));
            int count = baseDao.selectOne(NameSpace.ProcessFixedMapper, "selectProcessDefinitionCount", paramMap);
            if (count > 0) {
                throw new CustomException("流程大小类重复!");
            }

            paramMap.clear();
            paramMap.put("ID", id);
            Map<String, Object> definition = this.selectProcessDefinition(paramMap);
            String newDefinitionId = getId();
            //拷贝流程定义
            definition.put("ID", newDefinitionId);
            definition.put("SPD_NAME", mapParam.get("SPD_NAME"));
            definition.put("SPD_VERSION", mapParam.get("SPD_VERSION"));
            definition.put("BUS_PROCESS", mapParam.get("BUS_PROCESS"));
            definition.put("BUS_PROCESS2", mapParam.get("BUS_PROCESS2"));
            definition.put("SPD_UPDATE_TABLE", mapParam.get("SPD_UPDATE_TABLE"));
            definition.put("SPD_UPDATE_NAME", mapParam.get("SPD_UPDATE_NAME"));
            definition.put("SDP_ENTRY_TIME", getDate());
            baseDao.insert(NameSpace.ProcessFixedMapper, "insertProcessDefinition", definition);

            //拷贝流程步骤
            paramMap.clear();
            paramMap.put("SPD_ID", id);
            List<Map<String, Object>> stepList = this.selectProcessStepList(paramMap);

            for (Map<String, Object> step : stepList) {
                step.put("ID", getId());
                step.put("SPD_ID", newDefinitionId);
                baseDao.insert(NameSpace.ProcessFixedMapper, "insertProcessStep", step);
            }

            //拷贝流程启动角色
            paramMap.clear();
            paramMap.put("SPD_ID", id);
            List<Map<String, Object>> startList = this.selectProcessStartList(paramMap);

            for (Map<String, Object> start : startList) {
                start.put("ID", getId());
                start.put("SPD_ID", newDefinitionId);
                baseDao.insert(NameSpace.ProcessFixedMapper, "insertProcessStart", start);
            }

            resultMap.put(MagicValue.LOG, "拷贝流程定义:" + formatColumnName(TableName.SYS_PROCESS_DEFINITION, definition));

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

    /****   流程步骤    ***/

    @Override
    public Map<String, Object> selectProcessStep(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(4);
        paramMap.put("ID", mapParam.get("ID"));
        paramMap.put("SR_ID", mapParam.get("SR_ID"));
        paramMap.put("SPD_ID", mapParam.get("SPD_ID"));
        paramMap.put("SPS_PROCESS_STATUS", mapParam.get("SPS_PROCESS_STATUS"));
        return baseDao.selectOne(NameSpace.ProcessFixedMapper, "selectProcessStep", paramMap);
    }

    @Override
    public List<Map<String, Object>> selectProcessStepList(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("SPD_ID", mapParam.get("SPD_ID"));
        return baseDao.selectList(NameSpace.ProcessFixedMapper, "selectProcessStep", paramMap);
    }

    @Override
    public boolean selectProcessStepIsEdit(String roleId, String busProcess, String busProcess2) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(4);
        paramMap.put("SR_ID", roleId);
        paramMap.put("BUS_PROCESS", busProcess);
        paramMap.put("BUS_PROCESS2", busProcess2);
        int count = baseDao.selectOne(NameSpace.ProcessFixedMapper, "selectProcessStepIsEdit", paramMap);

        return count == 0 ? false : true;
    }


    @Override
    @Transactional
    public Map<String, Object> insertAndUpdateProcessStep(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(16);
            String id = toString(mapParam.get("ID"));
            //检测流程状态是否重复
            paramMap.put("NOT_ID", id);
            paramMap.put("SPD_ID", mapParam.get("SPD_ID"));
            paramMap.put("SPS_PROCESS_STATUS", mapParam.get("SPS_PROCESS_STATUS"));
            int count = baseDao.selectOne(NameSpace.ProcessFixedMapper, "selectProcessStepCount", paramMap);
            if (count > 0) {
                throw new CustomException("步骤流程状态重复,请检查!");
            }
            //检测流程排序是否重复
            paramMap.put("NOT_ID", id);
            paramMap.put("SPD_ID", mapParam.get("SPD_ID"));
            paramMap.put("SPS_ORDER", mapParam.get("SPS_ORDER"));
            count = baseDao.selectOne(NameSpace.ProcessFixedMapper, "selectProcessStepCount", paramMap);
            if (count > 0) {
                throw new CustomException("步骤流程状态重复,请检查!");
            }
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.SYS_PROCESS_STEP);

            paramMap.put("ID", mapParam.get("ID"));
            paramMap.put("SPD_ID", mapParam.get("SPD_ID"));
            paramMap.put("SR_ID", mapParam.get("SR_ID"));
            paramMap.put("SPS_NAME", mapParam.get("SPS_NAME"));
            paramMap.put("SPS_ORDER", mapParam.get("SPS_ORDER"));
            paramMap.put("SPS_PROCESS_STATUS", mapParam.get("SPS_PROCESS_STATUS"));
            paramMap.put("SPS_IS_OVER_TIME", mapParam.get("SPS_IS_OVER_TIME"));
            paramMap.put("SPS_OVER_TIME", mapParam.get("SPS_OVER_TIME"));
            paramMap.put("SPS_STEP_TYPE", mapParam.get("SPS_STEP_TYPE"));
            paramMap.put("SPS_IS_EDIT", mapParam.get("SPS_IS_EDIT"));
            paramMap.put("SPS_TAB", mapParam.get("SPS_TAB"));
            paramMap.put("SPS_IS_ADVANCE_CHECK", mapParam.get("SPS_IS_ADVANCE_CHECK"));
            paramMap.put("SPS_IS_RETREAT_CHECK", mapParam.get("SPS_IS_RETREAT_CHECK"));
            paramMap.put("SPS_IS_ADVANCE_EXECUTE", mapParam.get("SPS_IS_ADVANCE_EXECUTE"));
            paramMap.put("SPS_IS_RETREAT_EXECUTE", mapParam.get("SPS_IS_RETREAT_EXECUTE"));

            if (isEmpty(id)) {
                id = getId();
                paramMap.put("ID", id);

                baseDao.insert(NameSpace.ProcessFixedMapper, "insertProcessStep", paramMap);
                resultMap.put(MagicValue.LOG, "添加流程步骤:" + formatColumnName(TableName.SYS_PROCESS_STEP, paramMap));
            } else {
                Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
                oldMap.put("ID", id);
                oldMap = selectProcessStep(oldMap);

                baseDao.update(NameSpace.ProcessFixedMapper, "updateProcessStep", paramMap);
                resultMap.put(MagicValue.LOG, "更新流程步骤,更新前:" + formatColumnName(TableName.SYS_PROCESS_STEP, oldMap) + ",更新后:" + formatColumnName(TableName.SYS_PROCESS_STEP, paramMap));
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
    public Map<String, Object> deleteProcessStep(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = DELETE_ERROR;
        try {
            if (isEmpty(mapParam.get("ID"))) {
                throw new CustomException(Tips.ID_NULL_ERROR);
            }
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
            String id = toString(mapParam.get("ID"));

            //删除流程步骤表
            paramMap.clear();
            paramMap.put("ID", id);
            Map<String, Object> oldMap = selectProcessStep(paramMap);
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.SYS_PROCESS_STEP);

            baseDao.delete(NameSpace.ProcessFixedMapper, "deleteProcessStep", paramMap);

            resultMap.put(MagicValue.LOG, "删除流程步骤,信息:" + formatColumnName(TableName.SYS_PROCESS_STEP, oldMap));
            status = STATUS_SUCCESS;
            desc = DELETE_SUCCESS;
        } catch (Exception e) {
            desc = catchException(e, baseDao, resultMap);
        }
        resultMap.put(MagicValue.STATUS, status);
        resultMap.put(MagicValue.DESC, desc);
        return resultMap;
    }

    /****   流程开始角色    ***/

    @Override
    public Map<String, Object> selectProcessStart(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("ID", mapParam.get("ID"));
        return baseDao.selectOne(NameSpace.ProcessFixedMapper, "selectProcessStart", paramMap);
    }

    @Override
    public List<Map<String, Object>> selectProcessStartList(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(2);
        paramMap.put("ID", mapParam.get("ID"));
        paramMap.put("SPD_ID", mapParam.get("SPD_ID"));
        return baseDao.selectList(NameSpace.ProcessFixedMapper, "selectProcessStart", paramMap);
    }

    @Override
    @Transactional
    public Map<String, Object> insertAndUpdateProcessStart(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(3);
            String id = toString(mapParam.get("ID"));

            paramMap.put("ID", mapParam.get("ID"));
            paramMap.put("SPD_ID", mapParam.get("SPD_ID"));
            paramMap.put("SR_ID", mapParam.get("SR_ID"));

            if (isEmpty(id)) {
                id = getId();
                paramMap.put("ID", id);

                baseDao.insert(NameSpace.ProcessFixedMapper, "insertProcessStart", paramMap);
                resultMap.put(MagicValue.LOG, "添加流程开始角色:" + formatColumnName(TableName.SYS_PROCESS_START, paramMap));
            } else {
                Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
                oldMap.put("ID", id);
                oldMap = selectProcessStart(oldMap);

                baseDao.update(NameSpace.ProcessFixedMapper, "updateProcessStart", paramMap);
                resultMap.put(MagicValue.LOG, "更新流程开始角色,更新前:" + formatColumnName(TableName.SYS_PROCESS_START, oldMap) + ",更新后:" + formatColumnName(TableName.SYS_PROCESS_START, paramMap));
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
    public Map<String, Object> deleteProcessStart(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = DELETE_ERROR;
        try {
            if (isEmpty(mapParam.get("ID"))) {
                throw new CustomException(Tips.ID_NULL_ERROR);
            }
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
            String id = toString(mapParam.get("ID"));

            //删除流程开始角色表
            paramMap.clear();
            paramMap.put("ID", id);
            Map<String, Object> oldMap = selectProcessStart(paramMap);
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.SYS_PROCESS_START);
            baseDao.delete(NameSpace.ProcessFixedMapper, "deleteProcessStart", paramMap);

            resultMap.put(MagicValue.LOG, "删除流程开始角色,信息:" + formatColumnName(TableName.SYS_PROCESS_START, oldMap));
            status = STATUS_SUCCESS;
            desc = DELETE_SUCCESS;
        } catch (Exception e) {
            desc = catchException(e, baseDao, resultMap);
        }
        resultMap.put(MagicValue.STATUS, status);
        resultMap.put(MagicValue.DESC, desc);
        return resultMap;
    }


    /****   流程控制时间    ***/

    @Override
    public Map<String, Object> selectProcessTimeControl(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(3);
        paramMap.put("ID", mapParam.get("ID"));
        paramMap.put("SPD_ID", mapParam.get("SPD_ID"));
        paramMap.put("IS_STATUS", mapParam.get("IS_STATUS"));
        return baseDao.selectOne(NameSpace.ProcessFixedMapper, "selectProcessTimeControl", paramMap);
    }

    @Override
    @Transactional
    public Map<String, Object> insertAndUpdateProcessTimeControl(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(3);
            String id = toString(mapParam.get("ID"));

            paramMap.put("ID", id);
            paramMap.put("SPD_ID", mapParam.get("SPD_ID"));
            paramMap.put("SPTC_START_TIME", mapParam.get("SPTC_START_TIME"));
            paramMap.put("SPTC_END_TIME", mapParam.get("SPTC_END_TIME"));

            if (isEmpty(id)) {
                id = getId();
                paramMap.put("ID", id);
                paramMap.put("IS_STATUS", Attribute.STATUS_ERROR);
                paramMap.put("SPTC_ENTRY_TIME", getDate());

                baseDao.insert(NameSpace.ProcessFixedMapper, "insertProcessTimeControl", paramMap);
                resultMap.put(MagicValue.LOG, "添加流程时间控制:" + formatColumnName(TableName.SYS_PROCESS_TIME_CONTROL, paramMap));
            } else {
                Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
                oldMap.put("ID", id);
                oldMap = selectProcessTimeControl(oldMap);

                baseDao.update(NameSpace.ProcessFixedMapper, "updateProcessTimeControl", paramMap);
                resultMap.put(MagicValue.LOG, "更新流程时间控制,更新前:" + formatColumnName(TableName.SYS_PROCESS_TIME_CONTROL, oldMap) + ",更新后:" + formatColumnName(TableName.SYS_PROCESS_TIME_CONTROL, paramMap));
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
    public Map<String, Object> changeProcessTimeControlStatus(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(3);
            String id = toString(mapParam.get("ID"));
            int IS_STATUS = toInt(mapParam.get("IS_STATUS"));

            paramMap.put("ID", id);
            Map<String, Object> oldMap = selectProcessTimeControl(paramMap);

            if (IS_STATUS == 1) {
                //如果是启用要把正在启用的停止
                paramMap.clear();
                paramMap.put("SDP_ID", oldMap.get("SDP_ID"));
                paramMap.put("IS_STATUS", Attribute.STATUS_SUCCESS);
                Map<String, Object> timeControl = this.selectProcessTimeControl(paramMap);
                if (!isEmpty(timeControl)) {
                    //记录日志
                    paramMap.clear();
                    paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.SYS_PROCESS_TIME_CONTROL);
                    paramMap.put("ID", timeControl.get("ID"));
                    paramMap.put("IS_STATUS", Attribute.STATUS_ERROR);
                    baseDao.update(NameSpace.ProcessFixedMapper, "updateProcessTimeControl", paramMap);
                }
            }

            paramMap.clear();
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.SYS_PROCESS_TIME_CONTROL);

            paramMap.put("ID", id);
            paramMap.put("IS_STATUS", IS_STATUS);

            baseDao.update(NameSpace.ProcessFixedMapper, "updateProcessTimeControl", paramMap);
            resultMap.put(MagicValue.LOG, "更新流程时间控制状态,流程时间控制名:" + toString(oldMap.get("SPD_NAME")) + ",状态更新为:" + ParamTypeResolve.statusExplain(mapParam.get("IS_STATUS")));

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
    public Map<String, Object> deleteProcessTimeControl(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = DELETE_ERROR;
        try {
            if (isEmpty(mapParam.get("ID"))) {
                throw new CustomException(Tips.ID_NULL_ERROR);
            }
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
            String id = toString(mapParam.get("ID"));

            //删除流程时间控制表
            paramMap.clear();
            paramMap.put("ID", id);
            Map<String, Object> oldMap = selectProcessTimeControl(paramMap);
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.SYS_PROCESS_TIME_CONTROL);
            baseDao.delete(NameSpace.ProcessFixedMapper, "deleteProcessTimeControl", paramMap);

            resultMap.put(MagicValue.LOG, "删除流程时间控制,信息:" + formatColumnName(TableName.SYS_PROCESS_TIME_CONTROL, oldMap));
            status = STATUS_SUCCESS;
            desc = DELETE_SUCCESS;
        } catch (Exception e) {
            desc = catchException(e, baseDao, resultMap);
        }
        resultMap.put(MagicValue.STATUS, status);
        resultMap.put(MagicValue.DESC, desc);
        return resultMap;
    }

    /****   流程进度   ***/

    @Override
    public Map<String, Object> selectProcessSchedule(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(4);
        paramMap.put("ID", mapParam.get("ID"));
        paramMap.put("SPS_TABLE_ID", mapParam.get("SPS_TABLE_ID"));
        paramMap.put("SPD_ID", mapParam.get("SPD_ID"));
        paramMap.put("SPS_IS_CANCEL", mapParam.get("SPS_IS_CANCEL"));
        return baseDao.selectOne(NameSpace.ProcessMapper, "selectProcessSchedule", paramMap);
    }


    @Override
    @Transactional
    public Map<String, Object> insertAndUpdateProcessSchedule(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(17);
            String id = toString(mapParam.get("ID"));
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.SYS_PROCESS_SCHEDULE);

            paramMap.put("ID", mapParam.get("ID"));
            paramMap.put("SPD_ID", mapParam.get("SPD_ID"));
            paramMap.put("SPS_TABLE_ID", mapParam.get("SPS_TABLE_ID"));
            paramMap.put("SPS_AUDIT_STATUS", mapParam.get("SPS_AUDIT_STATUS"));
            paramMap.put("SPS_BACK_STATUS", mapParam.get("SPS_BACK_STATUS"));
            paramMap.put("SPS_STEP_TYPE", mapParam.get("SPS_STEP_TYPE"));
            paramMap.put("SPS_STEP_TRANSACTOR", mapParam.get("SPS_STEP_TRANSACTOR"));
            paramMap.put("SPS_PREV_AUDIT_STATUS", mapParam.get("SPS_PREV_AUDIT_STATUS"));
            paramMap.put("SPS_PREV_STEP_TYPE", mapParam.get("SPS_PREV_STEP_TYPE"));
            paramMap.put("SPS_PREV_STEP_TRANSACTOR", mapParam.get("SPS_PREV_STEP_TRANSACTOR"));
            paramMap.put("SPS_BACK_STATUS_TRANSACTOR", mapParam.get("SPS_BACK_STATUS_TRANSACTOR"));
            paramMap.put("SPS_TABLE_NAME", mapParam.get("SPS_TABLE_NAME"));
            paramMap.put("SPS_PREV_STEP_ID", mapParam.get("SPS_PREV_STEP_ID"));
            paramMap.put("SPS_ID", mapParam.get("SPS_ID"));

            if (isEmpty(id)) {
                id = getId();
                paramMap.put("ID", id);
                paramMap.put("SO_ID", mapParam.get("SO_ID"));
                if (!isEmpty(mapParam.get("SHOW_SO_ID"))) {
                    paramMap.put("SHOW_SO_ID", mapParam.get("SHOW_SO_ID"));
                }

                baseDao.insert(NameSpace.ProcessMapper, "insertProcessSchedule", paramMap);
//                resultMap.put(MagicValue.LOG, "添加流程进度:" + toString(paramMap));
            } else {
                Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
                oldMap.put("ID", id);
                oldMap = selectProcessSchedule(oldMap);

                baseDao.update(NameSpace.ProcessMapper, "updateProcessSchedule", paramMap);
//                resultMap.put(MagicValue.LOG, "更新流程进度,更新前:" + toString(oldMap) + ",更新后:" + toString(paramMap));
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
    public Map<String, Object> cancelProcessSchedule(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(5);
            String id = toString(mapParam.get("ID"));
            String scheduleCancelReason = toString(mapParam.get("SPSC_REASON"));

            paramMap.put("ID", id);
            paramMap.put("SPS_IS_CANCEL", STATUS_SUCCESS);

            baseDao.update(NameSpace.ProcessMapper, "updateProcessSchedule", paramMap);
            //插入作废表
            paramMap.clear();
            paramMap.put("ID", getId());
            paramMap.put("SO_ID", getActiveUser().getId());
            paramMap.put("SPS_ID", id);
            paramMap.put("SPSC_REASON", scheduleCancelReason);
            paramMap.put("SPSC_ENTRY_TIME", getSqlDate());
            baseDao.insert(NameSpace.ProcessMapper, "insertProcessScheduleCancel", paramMap);

            resultMap.put(MagicValue.LOG, "作废流程进度,作废原因:" + scheduleCancelReason);

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
    public Map<String, Object> deleteProcessSchedule(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = DELETE_ERROR;
        try {
            if (isEmpty(mapParam.get("ID"))) {
                throw new CustomException(Tips.ID_NULL_ERROR);
            }
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
            String id = toString(mapParam.get("ID"));

            //删除流程进度表
            paramMap.clear();
            paramMap.put("ID", id);
            Map<String, Object> oldMap = selectProcessSchedule(paramMap);

            baseDao.delete(NameSpace.ProcessMapper, "deleteProcessSchedule", paramMap);

//            resultMap.put(MagicValue.LOG, "删除流程进度,信息:" + toString(oldMap));
            status = STATUS_SUCCESS;
            desc = DELETE_SUCCESS;
        } catch (Exception e) {
            desc = catchException(e, baseDao, resultMap);
        }
        resultMap.put(MagicValue.STATUS, status);
        resultMap.put(MagicValue.DESC, desc);
        return resultMap;
    }

    /****   流程日志   ***/

    @Override
    public Map<String, Object> selectProcessLog(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(3);
        paramMap.put("ID", mapParam.get("ID"));
        paramMap.put("SPL_TABLE_ID", mapParam.get("SPL_TABLE_ID"));
        paramMap.put("SPS_PROCESS_STATUS", mapParam.get("SPS_PROCESS_STATUS"));
        return baseDao.selectOne(NameSpace.ProcessMapper, "selectProcessLog", paramMap);
    }

    @Override
    public List<Map<String, Object>> selectProcessLogList(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(5);
        paramMap.put("SPS_ID", mapParam.get("SPS_ID"));
        paramMap.put("SPL_TABLE_ID", mapParam.get("SPL_TABLE_ID"));
        paramMap.put("SPL_PROCESS_STATUS_ARRAY", mapParam.get("SPL_PROCESS_STATUS_ARRAY_ARRAY"));
        paramMap.put("NOT_SPL_PROCESS_STATUS", mapParam.get("NOT_SPL_PROCESS_STATUS"));
        paramMap.put("SPL_TYPE", mapParam.get("SPL_TYPE"));
        paramMap.put("IS_GROUP", mapParam.get("IS_GROUP"));
        return baseDao.selectList(NameSpace.ProcessMapper, "selectProcessLog", paramMap);
    }

    @Override
    @Transactional
    public Map<String, Object> insertProcessLog(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(9);
            String id = toString(mapParam.get("ID"));

            paramMap.put("ID", id);
            paramMap.put("SPS_ID", mapParam.get("SPS_ID"));
            paramMap.put("SPL_TABLE_ID", mapParam.get("SPL_TABLE_ID"));
            paramMap.put("SPL_SO_ID", mapParam.get("SPL_SO_ID"));
            paramMap.put("SPL_TRANSACTOR", mapParam.get("SPL_TRANSACTOR"));
            paramMap.put("SPL_OPINION", mapParam.get("SPL_OPINION"));
            paramMap.put("SPL_ENTRY_TIME", mapParam.get("SPL_ENTRY_TIME"));
            paramMap.put("SPL_TYPE", mapParam.get("SPL_TYPE"));
            paramMap.put("SPL_PROCESS_STATUS", mapParam.get("SPL_PROCESS_STATUS"));

            if (isEmpty(id)) {
                id = getId();
                paramMap.put("ID", id);

                baseDao.insert(NameSpace.ProcessMapper, "insertProcessLog", paramMap);
//                resultMap.put(MagicValue.LOG, "添加流程日志:" + toString(paramMap));
            } else {
                Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
                oldMap.put("ID", id);
                oldMap = selectProcessLog(oldMap);

                baseDao.update(NameSpace.ProcessMapper, "updateProcessLog", paramMap);
//                resultMap.put(MagicValue.LOG, "更新流程日志,更新前:" + toString(oldMap) + ",更新后:" + toString(paramMap));
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
    public Map<String, Object> deleteProcessLog(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = DELETE_ERROR;
        try {
            if (isEmpty(mapParam.get("ID"))) {
                throw new CustomException(Tips.ID_NULL_ERROR);
            }
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
            String id = toString(mapParam.get("ID"));

            //删除流程日志表
            paramMap.clear();
            paramMap.put("ID", id);
            Map<String, Object> oldMap = selectProcessLog(paramMap);

            baseDao.delete(NameSpace.ProcessMapper, "deleteProcessLog", paramMap);

//            resultMap.put(MagicValue.LOG, "删除流程日志,信息:" + toString(oldMap));
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
    public Map<String, Object> selectProcessScheduleCancel(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("ID", mapParam.get("ID"));
        return baseDao.selectOne(NameSpace.ProcessMapper, "selectProcessScheduleCancel", paramMap);
    }

    private List<Tree> getDefinitionTree(List<Map<String, Object>> definitionList, String selectId) {
        List<Tree> definitionTreeList = Lists.newArrayList();
        if (!isEmpty(definitionList)) {
            definitionList.forEach(definition -> {
                String id = toString(definition.get("ID"));

                Tree tree = new Tree();
                tree.setId(id);
                tree.setText(toString(definition.get("SPD_NAME")));
                tree.setTags(new String[]{
                        "更新表名称字段:" + toHtmlBColor(toString(definition.get("SPD_UPDATE_NAME"))),
                        "更新表名:" + toHtmlBColor(toString(definition.get("SPD_UPDATE_TABLE")))
                });

                TreeState state = new TreeState();
                //是否选中
                if (!isEmpty(selectId) && id.equals(selectId)) {
                    state.setChecked(true);
                    //选中的设置打开
                    state.setExpanded(true);
                }

                //设置状态
                tree.setState(state);

                definitionTreeList.add(tree);
            });
        }

        return definitionTreeList;
    }

    /**
     * 流程是否停用
     *
     * @param id
     * @return
     */
    private boolean isProcessDiscontinuation(String id) {
        if (isEmpty(id)) {
            return true;
        }
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("ID", id);
        paramMap = this.selectProcessDefinition(paramMap);
        if (isEmpty(paramMap)) {
            return true;
        }

        return isDiscontinuation(paramMap);
    }
}
