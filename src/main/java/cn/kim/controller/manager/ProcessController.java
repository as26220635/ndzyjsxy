package cn.kim.controller.manager;

import cn.kim.common.annotation.NotEmptyLogin;
import cn.kim.common.annotation.SystemControllerLog;
import cn.kim.common.annotation.Token;
import cn.kim.common.annotation.Validate;
import cn.kim.common.attr.Attribute;
import cn.kim.common.attr.MagicValue;
import cn.kim.common.eu.ProcessStatus;
import cn.kim.common.eu.UseType;
import cn.kim.common.eu.ProcessType;
import cn.kim.entity.CustomParam;
import cn.kim.entity.DataTablesView;
import cn.kim.entity.ResultState;
import cn.kim.entity.Tree;
import cn.kim.exception.CustomException;
import cn.kim.service.MenuService;
import cn.kim.service.OperatorService;
import cn.kim.service.ProcessService;
import cn.kim.service.RoleService;
import cn.kim.tools.ProcessTool;
import cn.kim.util.DictUtil;
import cn.kim.util.FuncUtil;
import cn.kim.util.TextUtil;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.util.stream.Collectors;

/**
 * Created by 余庚鑫 on 2018/5/22
 * 流程管理
 */
@Controller
@RequestMapping("/admin/process")
public class ProcessController extends BaseController {

    @Autowired
    private ProcessService processService;

    @Autowired
    private MenuService menuService;

    @Autowired
    private RoleService roleService;

    @Autowired
    private OperatorService operatorService;

    /********   流程    ********/

    /**
     * 获取当前流程拥有的按钮
     *
     * @param ID
     * @param BUS_PROCESS
     * @param BUS_PROCESS2
     * @return
     * @throws Exception
     */
    @GetMapping("/showDataGridBtn")
    @NotEmptyLogin
    @ResponseBody
    public Map<String, Object> showDataGridBtn(String ID, String BUS_PROCESS, String BUS_PROCESS2) throws Exception {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(1);
        //查询当前角色拥有的按钮
        String btnTypes = processService.showDataGridProcessBtn(ID, BUS_PROCESS, BUS_PROCESS2);
        resultMap.put("html", ProcessTool.getProcessButtonListHtml(btnTypes, false));
        return resultMap;
    }

    /**
     * 获取流程审核状态
     *
     * @param ID
     * @param BUS_PROCESS
     * @param BUS_PROCESS2
     * @return
     * @throws Exception
     */
    @GetMapping("/getProcessAuditStatus")
    @NotEmptyLogin
    @ResponseBody
    public String getProcessAuditStatus(String ID, String BUS_PROCESS, String BUS_PROCESS2) throws Exception {
        return ProcessTool.getProcessAuditStatus(ID, BUS_PROCESS, BUS_PROCESS2);
    }

    /**
     * 当前登录角色是否拥有随时编辑
     *
     * @param BUS_PROCESS
     * @param BUS_PROCESS2
     * @return
     * @throws Exception
     */
    @GetMapping("/showDataGridIsEdit")
    @NotEmptyLogin
    @ResponseBody
    public boolean showDataGridIsEdit(String BUS_PROCESS, String BUS_PROCESS2) throws Exception {
        return ProcessTool.selectNowActiveProcessStepIsEdit(BUS_PROCESS, BUS_PROCESS2);
    }

    /**
     * 获取流程提交退回界面
     *
     * @param ID
     * @param BUS_PROCESS
     * @param BUS_PROCESS2
     * @param PROCESS_TYPE
     * @param model
     * @return
     * @throws Exception
     */
    @GetMapping("/showDataGridProcess")
    @NotEmptyLogin
    @Token(save = true)
    public String showDataGridProcess(String ID, String SHOW_SO_ID, String BUS_PROCESS, String BUS_PROCESS2, int PROCESS_TYPE, Model model) throws Exception {
        try {
            //取第一个ID拿来查询流程
            String[] tableIds = ID.split(SERVICE_SPLIT);
            String processBtnType = ProcessType.SUBMIT.toString();
            List<Map<String, Object>> transactorList = Lists.newArrayList();

            //判断是否处于同一流程同一状态
            if (!ProcessTool.checkProcessUnified(tableIds)) {
                throw new CustomException("流程或流程状态不统一!");
            }
            //判断当前是否拥有审核权限
            if (!ProcessTool.checkProcess(PROCESS_TYPE, tableIds[0], BUS_PROCESS, BUS_PROCESS2)) {
                throw new CustomException("当前用户没有审核权限!");
            }

            //根据大小类查询流程定义
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(5);
            paramMap.put("BUS_PROCESS", BUS_PROCESS);
            paramMap.put("BUS_PROCESS2", BUS_PROCESS2);
            Map<String, Object> definition = processService.selectProcessDefinition(paramMap);
            String SPD_ID = toString(definition.get("ID"));
            //查询当前流程办理步骤
            paramMap.clear();
            paramMap.put("SPS_TABLE_ID", tableIds[0]);
            paramMap.put("SPD_ID", SPD_ID);
            paramMap.put("SPS_IS_CANCEL", toString(STATUS_ERROR));
            Map<String, Object> schedule = processService.selectProcessSchedule(paramMap);

            //审核状态
            String SPS_AUDIT_STATUS;
            if (!isEmpty(schedule) && !"0".equals(toString(schedule.get("SPS_AUDIT_STATUS")))) {
                SPS_AUDIT_STATUS = toString(schedule.get("SPS_AUDIT_STATUS"));
                if (toInt(SPS_AUDIT_STATUS) == ProcessStatus.BACK.getType()) {
                    SPS_AUDIT_STATUS = toString(schedule.get("SPS_BACK_STATUS_TRANSACTOR"));
                }
            } else {
                //查询角色拥有的最高的申报角色
                Map<String, Object> topStep = processService.processStepStartRoleTop(SPD_ID, activeUser().getRoleIds());
                if (!isEmpty(topStep)) {
                    SPS_AUDIT_STATUS = toString(topStep.get("SPS_PROCESS_STATUS"));
                } else {
                    throw new CustomException("当前用户没有提交审核权限!");
                }
            }

            //拼接提交项目
            List<CustomParam> submitProcessList = Lists.newArrayList();
            for (String tableId : tableIds) {
                CustomParam customParam = new CustomParam(ProcessTool.selectProcessTableName(tableId, BUS_PROCESS, BUS_PROCESS2), tableId);
                customParam.setDefaultParam(true);
                customParam.setEncrypt(true);
                submitProcessList.add(customParam);
            }

            paramMap.clear();
            paramMap.put("SPD_ID", SPD_ID);
            paramMap.put("SPS_PROCESS_STATUS", SPS_AUDIT_STATUS);
            Map<String, Object> step = processService.selectProcessStep(paramMap);

            //默认意见
            String DEFAULT_OPINION = "";

            Map<String, Object> nextStep = null;
            //查询下一步骤
            if (PROCESS_TYPE == ProcessType.SUBMIT.getType()) {
                //流程为提交
                nextStep = processService.processNextStep(SPD_ID, SPS_AUDIT_STATUS);
                if (isEmpty(nextStep)) {
                    throw new CustomException("没有找到下一流程步骤！");
                }
                String SR_ID = toString(nextStep.get("SR_ID"));
                //下一步是否为结束
                if (toInt(nextStep.get("SPS_PROCESS_STATUS")) != ProcessStatus.COMPLETE.getType()) {
                    //查询下一步办理人
                    if (MagicValue.ONE.equals(toString(nextStep.get("SPS_STEP_TYPE")))) {
                        //下一步为角色
                        paramMap.clear();
                        paramMap.put("ID", SR_ID);
                        Map<String, Object> role = roleService.selectRole(paramMap);

                        Map<String, Object> transactor = Maps.newHashMapWithExpectedSize(2);
                        transactor.put("KEY", role.get("ID"));
                        transactor.put("VALUE", role.get("SR_NAME"));
                        transactorList.add(transactor);
                    } else if (MagicValue.TWO.equals(toString(nextStep.get("SPS_STEP_TYPE")))) {
                        //下一步为人员
                        paramMap.clear();
                        paramMap.put("ID", nextStep.get("SR_ID"));
                        List<Map<String, Object>> operatorList = operatorService.selectOperatorByRoleId(SR_ID);
                        operatorList.forEach(map -> {
                            Map<String, Object> transactor = Maps.newHashMapWithExpectedSize(2);
                            transactor.put("KEY", map.get("ID"));
                            transactor.put("VALUE", map.get("SAI_NAME"));
                            transactorList.add(transactor);
                        });
                    }
                } else {
                    //下一步为结束
                    Map<String, Object> transactor = Maps.newHashMapWithExpectedSize(2);
                    transactor.put("KEY", "0");
                    transactor.put("VALUE", "结束");
                    transactorList.add(transactor);
                }

//                DEFAULT_OPINION = "通过";
                processBtnType = ProcessType.SUBMIT.toString();
            } else if (PROCESS_TYPE == ProcessType.BACK.getType()) {
                //查询上一步骤办理人
                nextStep = processService.processPrevStep(SPD_ID, SPS_AUDIT_STATUS);
                if (isEmpty(nextStep)) {
                    throw new CustomException("没有找到下一流程步骤！");
                }
                //是否允许多级退回
                if (toInt(definition.get("IS_MULTISTAGE_BACK")) == STATUS_ERROR) {
                    //查询日志查询流程对应状态办理人
                    paramMap.clear();
                    paramMap.put("SPL_TABLE_ID", ID);
                    paramMap.put("SPS_PROCESS_STATUS", nextStep.get("SPS_PROCESS_STATUS"));
                    Map<String, Object> processLog = processService.selectProcessLog(paramMap);
                    if (isEmpty(processLog)) {
                        throw new CustomException("流程变动，请联系管理员！");
                    }
                    Map<String, Object> transactor = Maps.newHashMapWithExpectedSize(2);
                    transactor.put("KEY", processLog.get("SPL_PROCESS_STATUS") + SERVICE_SPLIT + processLog.get("SPL_SO_ID"));
                    transactor.put("VALUE", processLog.get("SPL_PROCESS_STATUS_NAME") + ":" + processLog.get("SPL_TRANSACTOR"));
                    transactorList.add(transactor);
                } else {
                    //多级退回
                    List<Map<String, Object>> nextSteps = processService.processPrevStepList(SPD_ID, SPS_AUDIT_STATUS);
                    //查询步骤对应日志的办理人,只查询提交的
                    StringBuilder SPS_PROCESS_STATUS_ARRAY = new StringBuilder();
                    nextSteps.forEach(map -> {
                        SPS_PROCESS_STATUS_ARRAY.append(map.get("SPS_PROCESS_STATUS") + ",");
                    });
                    paramMap.clear();
                    paramMap.put("SPS_ID", schedule.get("ID"));
                    paramMap.put("SPL_TABLE_ID", ID);
                    paramMap.put("SPL_PROCESS_STATUS_ARRAY", TextUtil.interceptSymbol(SPS_PROCESS_STATUS_ARRAY.toString(), ","));
                    paramMap.put("NOT_SPL_PROCESS_STATUS", "0," + schedule.get("SPS_BACK_STATUS_TRANSACTOR"));
                    paramMap.put("SPL_TYPE", "0");
                    paramMap.put("IS_GROUP", true);
                    List<Map<String, Object>> processLogList = processService.selectProcessLogList(paramMap);
                    if (isEmpty(processLogList)) {
                        throw new CustomException("流程变动，请联系管理员！");
                    }

                    processLogList.forEach(processLog -> {
                        Map<String, Object> transactor = Maps.newHashMapWithExpectedSize(2);
                        transactor.put("KEY", processLog.get("SPL_PROCESS_STATUS") + SERVICE_SPLIT + processLog.get("SPL_SO_ID"));
                        transactor.put("VALUE", processLog.get("SPL_PROCESS_STATUS_NAME") + ":" + processLog.get("SPL_TRANSACTOR"));
                        transactorList.add(transactor);
                    });
                }
//                DEFAULT_OPINION = "退回";
                processBtnType = ProcessType.BACK.toString();
            }
            //查询流程步骤
            paramMap.clear();
            paramMap.put("SPD_ID", SPD_ID);
            List<Map<String, Object>> stepList = processService.selectProcessStepList(paramMap);
            //设置流程步骤
            String stepId = toString(step.get("ID"));
            String nextStepId = toString(nextStep.get("ID"));
            StringBuilder stepGroupName = new StringBuilder();
            stepGroupName.append("开始" + MagicValue.RIGHT_ARROW);
            FuncUtil.forEach(stepList, (index, map) -> {
                Object SPS_NAME = map.get("SPS_NAME");
                if (toString(map.get("ID")).equals(stepId)) {
                    stepGroupName.append(TextUtil.joinFirstTextSymbol("<span style='color:blue;'>" + SPS_NAME + "(当前步骤)" + MagicValue.RIGHT_ARROW + "</span>", MagicValue.NBSP, 1));
                } else if (toString(map.get("ID")).equals(nextStepId)) {
                    if (index + 1 == stepList.size()) {
                        stepGroupName.append(TextUtil.joinFirstTextSymbol("<span style='color:red;'>" + SPS_NAME + "(下一步骤)" + "</span>", MagicValue.NBSP, 1));
                    } else {
                        stepGroupName.append(TextUtil.joinFirstTextSymbol("<span style='color:red;'>" + SPS_NAME + "(下一步骤)" + MagicValue.RIGHT_ARROW + "</span>", MagicValue.NBSP, 1));
                    }
                } else {
                    stepGroupName.append(TextUtil.joinFirstTextSymbol(SPS_NAME + MagicValue.RIGHT_ARROW, MagicValue.NBSP, 1));
                }
            });

            //流程步骤
            model.addAttribute("SPS_GROUP_NAME", TextUtil.interceptSymbol(stepGroupName.toString(), MagicValue.RIGHT_ARROW));
            //办理表ID
            model.addAttribute("SPS_TABLE_ID", ID);
            //查看人SO_ID
            if (!isEmpty(SHOW_SO_ID)) {
                model.addAttribute("SHOW_SO_ID", SHOW_SO_ID);
            }
            //下一步办理人
            model.addAttribute("TRANSACTOR_LIST", transactorList);
            //流程定义
            model.addAttribute("SPD", definition);
            //当前步骤
            model.addAttribute("STEP", step);
            //下一步步骤
            model.addAttribute("NEXT_STEP", nextStep);
            //流程办理类型
            model.addAttribute("PROCESS_TYPE", PROCESS_TYPE);
            //默认办理意见
            model.addAttribute("DEFAULT_OPINION", DEFAULT_OPINION);
            //提交项目list
            model.addAttribute("submitProcessList", submitProcessList);
            //步骤名称
            model.addAttribute("STEP_NAME", DictUtil.getDictName("SYS_PROCESS_STATUS", SPS_AUDIT_STATUS));
            //下一步步骤
            model.addAttribute("processBtnType", processBtnType);
        } catch (CustomException e) {
            model.addAttribute("message", e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            //错误消息
            model.addAttribute("message", "流程查询出错!");
        }
        return "admin/component/process/processHome";
    }

    /**
     * 提交流程
     *
     * @param mapParam
     * @return
     */
    @PutMapping("/submit")
    @NotEmptyLogin
    @Token(remove = true)
    @Validate(value = {"SYS_PROCESS_LOG", "SYS_PROCESS_SCHEDULE"})
    @ResponseBody
    public ResultState submit(@RequestParam Map<String, Object> mapParam) throws Exception {
        //办理类型
        int PROCESS_TYPE = toInt(mapParam.get("PROCESS_TYPE"));
        //流程办理ID
        String[] tableIds = toString(mapParam.get("SPS_TABLE_ID")).split(SERVICE_SPLIT);
        //拿到大小类
        String BUS_PROCESS = toString(mapParam.get("BUS_PROCESS"));
        String BUS_PROCESS2 = toString(mapParam.get("BUS_PROCESS2"));

        //判断是否处于同一流程同一状态
        if (!ProcessTool.checkProcessUnified(tableIds)) {
            throw new CustomException("流程或流程状态不统一!");
        }

        if (!ProcessTool.checkProcess(PROCESS_TYPE, tableIds[0], BUS_PROCESS, BUS_PROCESS2)) {
            throw new CustomException("当前用户没有审核权限!");
        }

        //错误消息
        StringBuilder errorBuilder = new StringBuilder();
        //循环提交
        for (String tableId : tableIds) {
            mapParam.put("SPS_TABLE_ID", tableId);
            //公平锁
            ResultState state = fairLock(tableId, () -> {
                Map<String, Object> resultMap = ProcessTool.submitProcess(mapParam);

                return resultState(resultMap);
            });
            //只有1个流程直接返回
            if (tableIds.length == 1) {
                return state;
            }
            //判断返回结果
            if (state.getCode() == STATUS_ERROR) {
                String tableName = ProcessTool.selectProcessTableName(tableId, BUS_PROCESS, BUS_PROCESS2);
                errorBuilder.append("流程:" + tableName + ",异常原因:" + state.getMessage() + ",请修改后再次尝试!<br/>");
            }
        }
        if (isEmpty(errorBuilder)) {
            return resultSuccess("流程批量提交成功!", "流程批量提交成功,SPS_TABLE_IDS:" + toString(tableIds));
        } else {
            return resultError("异常流程:<br/>" + errorBuilder.toString(), "流程提交成功!出现问题流程:" + errorBuilder.toString());
        }
    }

    /**
     * 撤回流程
     *
     * @param mapParam
     * @return
     */
    @PutMapping("/withdraw")
    @NotEmptyLogin
    @Validate(value = {"SYS_PROCESS_LOG", "SYS_PROCESS_SCHEDULE"})
    @ResponseBody
    public ResultState withdraw(@RequestParam Map<String, Object> mapParam) throws Exception {
        //流程办理ID
        String SPS_TABLE_ID = toString(mapParam.get("SPS_TABLE_ID"));
        //拿到大小类
        String BUS_PROCESS = toString(mapParam.get("BUS_PROCESS"));
        String BUS_PROCESS2 = toString(mapParam.get("BUS_PROCESS2"));
        if (!ProcessTool.checkProcess(ProcessType.WITHDRAW.getType(), SPS_TABLE_ID, BUS_PROCESS, BUS_PROCESS2)) {
            throw new CustomException("当前用户没有审核权限!");
        }

        //公平锁进行等待
        return fairLock(SPS_TABLE_ID, () -> {
            Map<String, Object> resultMap = ProcessTool.withdrawProcess(mapParam);

            return resultState(resultMap);
        });
    }

    /**
     * 流程日志
     *
     * @param ID
     * @param BUS_PROCESS
     * @param BUS_PROCESS2
     * @param SPS_ID
     * @param model
     * @return
     * @throws Exception
     */
    @GetMapping("/log")
    @NotEmptyLogin
    public String log(String ID, String BUS_PROCESS, String BUS_PROCESS2, String SPS_ID, Model model) throws Exception {
        if (isEmpty(SPS_ID)) {
            Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(3);
            mapParam.put("BUS_PROCESS", BUS_PROCESS);
            mapParam.put("BUS_PROCESS2", BUS_PROCESS2);
            Map<String, Object> definition = processService.selectProcessDefinition(mapParam);
            String SPD_ID = toString(definition.get("ID"));

            mapParam.clear();
            mapParam.put("SPS_TABLE_ID", ID);
            mapParam.put("SPD_ID", SPD_ID);
            mapParam.put("SPS_IS_CANCEL", toString(STATUS_ERROR));
            Map<String, Object> schedule = processService.selectProcessSchedule(mapParam);
            //流程进度ID
            SPS_ID = toString(schedule.get("ID"));
        }
        //流程进度ID
        model.addAttribute("SPS_ID", SPS_ID);

        return "admin/component/process/processLog";
    }

    /**
     * 流程日志数据
     *
     * @param SPS_ID
     * @return
     * @throws Exception
     */
    @GetMapping("/log/list")
    @NotEmptyLogin
    @ResponseBody
    public DataTablesView<?> logList(String SPS_ID) throws Exception {
        DataTablesView<Map<String, Object>> dataTablesView = new DataTablesView<>();
        //查询日志数据
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("SPS_ID", SPS_ID);
        List<Map<String, Object>> logList = processService.selectProcessLogList(mapParam);
        dataTablesView.setData(logList);
        return dataTablesView;
    }
    /********   流程定义    ********/

    /**
     * 获取流程定义列表 转为List<Tree>
     *
     * @param ID 已选角色ID
     * @return
     * @throws Exception
     */
    @GetMapping("/definition/tree")
    @RequiresPermissions(value = {"SYSTEM:MENU"}, logical = Logical.OR)
    @ResponseBody
    public List<Tree> definitionTree(String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        List<Tree> definitionTreeList = processService.selectProcessDefinitionTreeList(mapParam);

        return definitionTreeList;
    }

    @GetMapping("/definition/add")
    @RequiresPermissions("SYSTEM:PROCESS_DEFINITION_INSERT")
    @Token(save = true)
    public String addHtmlDefinition(Model model) throws Exception {
        return "admin/system/process/definition/add";
    }


    @PostMapping("/definition/add")
    @RequiresPermissions("SYSTEM:PROCESS_DEFINITION_INSERT")
    @SystemControllerLog(useType = UseType.USE, event = "添加流程定义")
    @Token(remove = true)
    @Validate("SYS_PROCESS_DEFINITION")
    @ResponseBody
    public ResultState addDefinition(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = processService.insertAndUpdateProcessDefinition(mapParam);

        return resultState(resultMap);
    }


    @GetMapping("/definition/update")
    @RequiresPermissions("SYSTEM:PROCESS_DEFINITION_UPDATE")
    public String updateHtmlDefinition(String SPD_ID, String SM_ID, Model model) throws Exception {
        isNotFound(SPD_ID);
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", SPD_ID);
        model.addAttribute("SPD", processService.selectProcessDefinition(mapParam));
        //查询菜单
        model.addAttribute("MENU", menuService.queryMenuById(SM_ID));
        return "admin/system/process/definition/edit";
    }

    @PutMapping("/definition/update")
    @RequiresPermissions("SYSTEM:PROCESS_DEFINITION_UPDATE_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改流程定义")
    @Validate("SYS_PROCESS_DEFINITION")
    @ResponseBody
    public ResultState updateDefinition(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = processService.insertAndUpdateProcessDefinition(mapParam);
        return resultState(resultMap);
    }

    @PutMapping("/definition/switchStatus")
    @RequiresPermissions("SYSTEM:PROCESS_DEFINITION_UPDATE")
    @SystemControllerLog(useType = UseType.USE, event = "修改流程定义状态")
    @ResponseBody
    public ResultState switchStatusDefinition(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = processService.changeProcessDefinitionStatus(mapParam);

        return resultState(resultMap);
    }

    @GetMapping("/definition/copy/{ID}")
    @RequiresPermissions("SYSTEM:PROCESS_DEFINITION_COPY")
    public String copyHtmlDefinition(@PathVariable("ID") String ID, Model model) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        model.addAttribute("SPD", processService.selectProcessDefinition(mapParam));
        return "admin/system/process/definition/copy";
    }

    @PutMapping("/definition/copy")
    @RequiresPermissions("SYSTEM:PROCESS_DEFINITION_COPY")
    @SystemControllerLog(useType = UseType.USE, event = "拷贝流程定义")
    @Validate("SYS_PROCESS_DEFINITION")
    @ResponseBody
    public ResultState copyDefinition(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = processService.copyProcessDefinition(mapParam);
        return resultState(resultMap);
    }

    /********   流程步骤    ********/

    @GetMapping("/step/add")
    @RequiresPermissions("SYSTEM:PROCESS_STEP_INSERT")
    @Token(save = true)
    public String addHtmlProcessStep(String SPD_ID, Model model) throws Exception {
        model.addAttribute("SPD_ID", SPD_ID);
        return "admin/system/process/step/addAndEdit";
    }

    @PostMapping("/step/add")
    @RequiresPermissions("SYSTEM:PROCESS_STEP_INSERT")
    @SystemControllerLog(useType = UseType.USE, event = "添加流程步骤")
    @Token(remove = true)
    @Validate("SYS_PROCESS_STEP")
    @ResponseBody
    public ResultState addProcessStep(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = processService.insertAndUpdateProcessStep(mapParam);

        return resultState(resultMap);
    }

    @GetMapping("/step/update/{ID}")
    @RequiresPermissions("SYSTEM:PROCESS_STEP_UPDATE")
    public String updateHtmlProcessStep(Model model, @PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        model.addAttribute("SPS", processService.selectProcessStep(mapParam));
        return "admin/system/process/step/addAndEdit";
    }

    @PutMapping("/step/update")
    @RequiresPermissions("SYSTEM:PROCESS_STEP_UPDATE")
    @SystemControllerLog(useType = UseType.USE, event = "修改流程步骤")
    @Validate("SYS_PROCESS_STEP")
    @ResponseBody
    public ResultState updateProcessStep(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = processService.insertAndUpdateProcessStep(mapParam);
        return resultState(resultMap);
    }

    @DeleteMapping("/step/delete/{ID}")
    @RequiresPermissions("SYSTEM:PROCESS_STEP_DELETE")
    @SystemControllerLog(useType = UseType.USE, event = "删除流程步骤")
    @ResponseBody
    public ResultState deleteProcessStep(@PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> resultMap = processService.deleteProcessStep(mapParam);
        return resultState(resultMap);
    }

    /********   流程启动角色    ********/

    @GetMapping("/start/add")
    @RequiresPermissions("SYSTEM:PROCESS_STEP_INSERT")
    @Token(save = true)
    public String addHtmlProcessStart(String SPD_ID, Model model) throws Exception {
        model.addAttribute("SPD_ID", SPD_ID);
        return "admin/system/process/start/addAndEdit";
    }

    @PostMapping("/start/add")
    @RequiresPermissions("SYSTEM:PROCESS_STEP_INSERT")
    @SystemControllerLog(useType = UseType.USE, event = "添加流程启动角色")
    @Token(remove = true)
    @Validate("SYS_PROCESS_STEP")
    @ResponseBody
    public ResultState addProcessStart(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = processService.insertAndUpdateProcessStart(mapParam);

        return resultState(resultMap);
    }

    @GetMapping("/start/update/{ID}")
    @RequiresPermissions("SYSTEM:PROCESS_STEP_UPDATE")
    public String updateHtmlProcessStart(Model model, @PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        model.addAttribute("SPS", processService.selectProcessStart(mapParam));
        return "admin/system/process/start/addAndEdit";
    }

    @PutMapping("/start/update")
    @RequiresPermissions("SYSTEM:PROCESS_STEP_UPDATE")
    @SystemControllerLog(useType = UseType.USE, event = "修改流程启动角色")
    @Validate("SYS_PROCESS_STEP")
    @ResponseBody
    public ResultState updateProcessStart(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = processService.insertAndUpdateProcessStart(mapParam);
        return resultState(resultMap);
    }

    @DeleteMapping("/start/delete/{ID}")
    @RequiresPermissions("SYSTEM:PROCESS_STEP_DELETE")
    @SystemControllerLog(useType = UseType.USE, event = "删除流程启动角色")
    @ResponseBody
    public ResultState deleteProcessStart(@PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> resultMap = processService.deleteProcessStart(mapParam);
        return resultState(resultMap);
    }

    /********   流程进度    ********/

    @GetMapping("/schedule/{ID}")
    @RequiresPermissions("SYSTEM:PROCESS_SCHEDULE")
    @Token(save = true)
    public String cancelHtmlProcessSchedule(@PathVariable("ID") String ID, Model model) throws Exception {
        model.addAttribute("ID", ID);
        return "admin/system/process/schedule/addAndEdit";
    }

    @PutMapping("/schedule/cancel")
    @RequiresPermissions("SYSTEM:PROCESS_SCHEDULE_CANCEL")
    @SystemControllerLog(useType = UseType.USE, event = "作废流程进度")
    @Token(remove = true)
    @Validate("SYS_PROCESS_SCHEDULE_CANCEL")
    @ResponseBody
    public ResultState cancelProcessSchedule(@RequestParam Map<String, Object> mapParam) throws Exception {
        String ID = toString(mapParam.get("ID"));

        return fairLock(ID, () -> {
            Map<String, Object> resultMap = ProcessTool.cancelProcess(ID, toString(mapParam.get("SPSC_REASON")));
            return resultState(resultMap);
        });
    }

    /**
     * 流程进度作废信息
     *
     * @param ID
     * @param model
     * @return
     * @throws Exception
     */
    @GetMapping("/schedule/cancel/{ID}")
    @RequiresPermissions("SYSTEM:PROCESS_SCHEDULE_CANCEL_INFO")
    @Token(save = true)
    public String cancelHtmlProcessScheduleInfo(@PathVariable("ID") String ID, Model model) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> cancel = processService.selectProcessScheduleCancel(mapParam);

        model.addAttribute("SPSC", cancel);
        return "admin/system/process/schedule/addAndEdit";
    }


    /********   时间控制    ********/

    @GetMapping("/timeControl/add")
    @RequiresPermissions("SYSTEM:PROCESS_TIME_CONTROL_INSERT")
    @Token(save = true)
    public String addHtmlProcessTimeControl(String SPD_ID, Model model) throws Exception {
        model.addAttribute("SPD_ID", SPD_ID);
        return "admin/system/process/timeControl/addAndEdit";
    }

    @PostMapping("/timeControl/add")
    @RequiresPermissions("SYSTEM:PROCESS_TIME_CONTROL_INSERT")
    @SystemControllerLog(useType = UseType.USE, event = "添加流程时间控制")
    @Token(remove = true)
    @Validate("SYS_PROCESS_TIME_CONTROL")
    @ResponseBody
    public ResultState addProcessTimeControl(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = processService.insertAndUpdateProcessTimeControl(mapParam);

        return resultState(resultMap);
    }

    @GetMapping("/timeControl/update/{ID}")
    @RequiresPermissions("SYSTEM:PROCESS_TIME_CONTROL_UPDATE")
    public String updateHtmlProcessTimeControl(Model model, @PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        model.addAttribute("SPTC", processService.selectProcessTimeControl(mapParam));
        return "admin/system/process/timeControl/addAndEdit";
    }

    @PutMapping("/timeControl/update")
    @RequiresPermissions("SYSTEM:PROCESS_TIME_CONTROL_UPDATE")
    @SystemControllerLog(useType = UseType.USE, event = "修改流程时间控制")
    @Validate("SYS_PROCESS_TIME_CONTROL")
    @ResponseBody
    public ResultState updateProcessTimeControl(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = processService.insertAndUpdateProcessTimeControl(mapParam);
        return resultState(resultMap);
    }

    @PutMapping("/timeControl/switchStatus")
    @RequiresPermissions("SYSTEM:PROCESS_TIME_CONTROL_UPDATE")
    @SystemControllerLog(useType = UseType.USE, event = "修改流程时间控制状态")
    @ResponseBody
    public ResultState switchStatusProcessTimeControl(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = processService.changeProcessTimeControlStatus(mapParam);

        return resultState(resultMap);
    }

    @DeleteMapping("/timeControl/delete/{ID}")
    @RequiresPermissions("SYSTEM:PROCESS_TIME_CONTROL_DELETE")
    @SystemControllerLog(useType = UseType.USE, event = "删除流程时间控制")
    @ResponseBody
    public ResultState deleteProcessTimeControl(@PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> resultMap = processService.deleteProcessTimeControl(mapParam);
        return resultState(resultMap);
    }
}
