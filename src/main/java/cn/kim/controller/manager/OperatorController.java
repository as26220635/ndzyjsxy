package cn.kim.controller.manager;

import cn.kim.common.annotation.SystemControllerLog;
import cn.kim.common.annotation.Token;
import cn.kim.common.annotation.Validate;
import cn.kim.common.eu.UseType;
import cn.kim.entity.ResultState;
import cn.kim.entity.Tree;
import cn.kim.service.OperatorService;
import com.google.common.collect.Maps;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/4/3
 * 操作员
 */
@Controller
@RequestMapping("/admin/operator")
public class OperatorController extends BaseController {

    @Autowired
    private OperatorService operatorService;

    @GetMapping("/add")
    @RequiresPermissions("SYSTEM:OPERATOR_INSERT")
    @Token(save = true)
    public String addHtml(Model model) throws Exception {
        return "admin/system/operator/addAndEdit";
    }


    @PostMapping("/add")
    @RequiresPermissions("SYSTEM:OPERATOR_INSERT")
    @SystemControllerLog(useType = UseType.USE, event = "添加操作员")
    @Token(remove = true)
    @Validate("SYS_ACCOUNT_INFO")
    @ResponseBody
    public ResultState add(@RequestParam Map<String, Object> mapParam) throws Exception {
        return fairLock("insertAndUpdateOperator", () -> {
            Map<String, Object> resultMap = operatorService.insertAndUpdateOperator(mapParam);
            return resultState(resultMap);
        });
    }


    @GetMapping("/update/{ID}")
    @RequiresPermissions("SYSTEM:OPERATOR_UPDATE")
    public String updateHtml(Model model, @PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        model.addAttribute("OPERATOR", operatorService.selectOperator(mapParam));
        return "admin/system/operator/addAndEdit";
    }

    @PutMapping("/update")
    @RequiresPermissions("SYSTEM:OPERATOR_UPDATE_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改操作员")
    @Validate("SYS_ACCOUNT_INFO")
    @ResponseBody
    public ResultState update(@RequestParam Map<String, Object> mapParam) throws Exception {
        return fairLock("insertAndUpdateOperator", () -> {
            Map<String, Object> resultMap = operatorService.insertAndUpdateOperator(mapParam);
            return resultState(resultMap);
        });
    }


    @PutMapping("/switchStatus")
    @RequiresPermissions("SYSTEM:OPERATOR_UPDATE_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改操作员状态")
    @ResponseBody
    public ResultState switchStatus(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = operatorService.changeOperatorStatus(mapParam);

        return resultState(resultMap);
    }

    @PutMapping("/resetPwd")
    @RequiresPermissions("SYSTEM:OPERATOR_UPDATE_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "重置操作员密码")
    @ResponseBody
    public ResultState resetPwd(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = operatorService.resetOperatorPassword(mapParam);

        return resultState(resultMap);
    }

    @DeleteMapping("/delete/{ID}")
    @RequiresPermissions("SYSTEM:OPERATOR_DELETE")
    @SystemControllerLog(useType = UseType.USE, event = "删除操作员")
    @ResponseBody
    public ResultState delete(@PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> resultMap = operatorService.deleteOperator(mapParam);
        return resultState(resultMap);
    }


    /***********    sub登录账号信息表  ***********/
    @GetMapping("/sub/add")
    @RequiresPermissions(value = {"SYSTEM:OPERATOR_SUB_INSERT", "INFO:DIVISION_PERSONNEL_SET_SUB", "INFO:DEPARTMENT_PERSONNEL_SET_SUB", "INFO:CLASS_SET_SUB", "INFO:TEACHER_SET_SUB", "INFO:STUDENT_SET_SUB"}, logical = Logical.OR)
    @Token(save = true)
    public String addHtmlSub(String SO_ID, Model model) throws Exception {
        model.addAttribute("SO_ID", SO_ID);
        return "admin/system/operator/sub/addAndEdit";
    }


    @PostMapping("/sub/add")
    @RequiresPermissions(value = {"SYSTEM:OPERATOR_SUB_INSERT", "INFO:DIVISION_PERSONNEL_SET_SUB", "INFO:DEPARTMENT_PERSONNEL_SET_SUB", "INFO:CLASS_SET_SUB", "INFO:TEACHER_SET_SUB", "INFO:STUDENT_SET_SUB"}, logical = Logical.OR)
    @SystemControllerLog(useType = UseType.USE, event = "添加操作员账号")
    @Token(remove = true)
    @Validate("SYS_OPERATOR_SUB")
    @ResponseBody
    public ResultState addSub(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = operatorService.insertAndUpdateOperatorSub(mapParam);

        return resultState(resultMap);
    }


    @GetMapping("/sub/update/{ID}")
    @RequiresPermissions(value = {"SYSTEM:OPERATOR_SUB_UPDATE", "INFO:DIVISION_PERSONNEL_SET_SUB", "INFO:DEPARTMENT_PERSONNEL_SET_SUB", "INFO:CLASS_SET_SUB", "INFO:TEACHER_SET_SUB", "INFO:STUDENT_SET_SUB"}, logical = Logical.OR)
    public String updateHtmlSub(@PathVariable("ID") String ID, Model model) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        model.addAttribute("SUB", operatorService.selectOperatorSub(mapParam));
        return "admin/system/operator/sub/addAndEdit";
    }

    @PutMapping("/sub/update")
    @RequiresPermissions(value = {"SYSTEM:OPERATOR_SUB_UPDATE", "INFO:DIVISION_PERSONNEL_SET_SUB", "INFO:DEPARTMENT_PERSONNEL_SET_SUB", "INFO:CLASS_SET_SUB", "INFO:TEACHER_SET_SUB", "INFO:STUDENT_SET_SUB"}, logical = Logical.OR)
    @SystemControllerLog(useType = UseType.USE, event = "修改操作员账号")
    @Validate("SYS_OPERATOR_SUB")
    @ResponseBody
    public ResultState updateSub(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = operatorService.insertAndUpdateOperatorSub(mapParam);
        return resultState(resultMap);
    }


    @PutMapping("/sub/switchStatus")
    @RequiresPermissions(value = {"SYSTEM:OPERATOR_SUB_UPDATE", "INFO:DIVISION_PERSONNEL_SET_SUB", "INFO:DEPARTMENT_PERSONNEL_SET_SUB", "INFO:CLASS_SET_SUB", "INFO:TEACHER_SET_SUB", "INFO:STUDENT_SET_SUB"}, logical = Logical.OR)
    @SystemControllerLog(useType = UseType.USE, event = "修改操作员账号状态")
    @ResponseBody
    public ResultState switchStatusSub(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = operatorService.changeOperatorSubStatus(mapParam);

        return resultState(resultMap);
    }

    @DeleteMapping("/sub/delete/{ID}")
    @RequiresPermissions(value = {"SYSTEM:OPERATOR_SUB_DELETE", "INFO:DIVISION_PERSONNEL_SET_SUB", "INFO:DEPARTMENT_PERSONNEL_SET_SUB", "INFO:CLASS_SET_SUB", "INFO:TEACHER_SET_SUB", "INFO:STUDENT_SET_SUB"}, logical = Logical.OR)
    @SystemControllerLog(useType = UseType.USE, event = "删除操作员账号")
    @ResponseBody
    public ResultState deleteSub(@PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> resultMap = operatorService.deleteOperatorSub(mapParam);
        return resultState(resultMap);
    }

    /***********    设置角色  ***********/

    @GetMapping("/roles")
    @RequiresPermissions(value = {"SYSTEM:OPERATOR_SET_ROLE", "INFO:DIVISION_PERSONNEL_SET_ROLE", "INFO:DEPARTMENT_PERSONNEL_SET_ROLE", "INFO:CLASS_SET_ROLE", "INFO:TEACHER_SET_ROLE", "INFO:STUDENT_SET_ROLE"}, logical = Logical.OR)
    @ResponseBody
    public List<Tree> getRoles(String ID, Integer SR_TYPE) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        mapParam.put("SR_TYPE", SR_TYPE);
        List<Tree> roles = operatorService.selectOperatorRole(mapParam);

        return roles;
    }

    @PutMapping("/updateOperatorRoles")
    @RequiresPermissions(value = {"SYSTEM:OPERATOR_SET_ROLE", "INFO:DIVISION_PERSONNEL_SET_ROLE", "INFO:DEPARTMENT_PERSONNEL_SET_ROLE", "INFO:CLASS_SET_ROLE", "INFO:TEACHER_SET_ROLE", "INFO:STUDENT_SET_ROLE"}, logical = Logical.OR)
    @SystemControllerLog(useType = UseType.USE, event = "设置操作员角色")
    @ResponseBody
    public ResultState updateOperatorRoles(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = operatorService.updateOperatorRole(mapParam);
        return resultState(resultMap);
    }

}
