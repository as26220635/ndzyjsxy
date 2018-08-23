package cn.kim.controller.manager.info;

import cn.kim.common.annotation.SystemControllerLog;
import cn.kim.common.annotation.Token;
import cn.kim.common.annotation.Validate;
import cn.kim.common.eu.UseType;
import cn.kim.controller.manager.BaseController;
import cn.kim.entity.ResultState;
import cn.kim.entity.Tree;
import cn.kim.service.DepartmentService;
import cn.kim.service.OperatorService;
import com.google.common.collect.Maps;
import org.jetbrains.annotations.Nullable;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/8/6
 * 系部管理
 */
@Controller
@RequestMapping("/admin/department")
public class DepartmentController extends BaseController {

    @Autowired
    private DepartmentService departmentService;

    @Autowired
    private OperatorService operatorService;

    /**
     * 获取系部树
     *
     * @param ID
     * @param NOT_ID 不显示的自身和父类ID
     * @return
     * @throws Exception
     */
    @GetMapping("/tree")
    @RequiresPermissions(value = {"INFO:DEPARTMENT", "INFO:DEPARTMENT_PERSONNEL", "INFO:CLASS", "INFO:STUDENT"}, logical = Logical.OR)
    @ResponseBody
    public List<Tree> treeList(String ID, @Nullable String NOT_ID) throws Exception {
        List<Tree> treeList = departmentService.selectDepartmentTreeList(ID, NOT_ID);
        return treeList;
    }

    @GetMapping("/add")
    @RequiresPermissions("INFO:DEPARTMENT_INSERT")
    @Token(save = true)
    public String addHtml(Model model) throws Exception {
        return "admin/info/department/addAndEdit";
    }


    @PostMapping("/add")
    @RequiresPermissions("INFO:DEPARTMENT_INSERT")
    @SystemControllerLog(useType = UseType.USE, event = "添加系部")
    @Token(remove = true)
    @Validate(value = "BUS_DEPARTMENT", required = true)
    @ResponseBody
    public ResultState add(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = departmentService.insertAndUpdateDepartment(mapParam);

        return resultState(resultMap);
    }


    @GetMapping("/update/{ID}")
    @RequiresPermissions("INFO:DEPARTMENT_UPDATE")
    public String updateHtml(Model model, @PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        model.addAttribute("department", departmentService.selectDepartment(mapParam));
        return "admin/info/department/addAndEdit";
    }

    @PutMapping("/update")
    @RequiresPermissions("INFO:DEPARTMENT_UPDATE_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改系部")
    @Validate(value = "BUS_DEPARTMENT", required = true)
    @ResponseBody
    public ResultState update(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = departmentService.insertAndUpdateDepartment(mapParam);
        return resultState(resultMap);
    }

    @DeleteMapping("/delete/{ID}")
    @RequiresPermissions("INFO:DEPARTMENT_DELETE")
    @SystemControllerLog(useType = UseType.USE, event = "删除系部")
    @ResponseBody
    public ResultState delete(@PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> resultMap = departmentService.deleteDepartment(mapParam);
        return resultState(resultMap);
    }


    /****************   系部人员    ************/
    @GetMapping("/personnel/add")
    @RequiresPermissions("INFO:DEPARTMENT_PERSONNEL_INSERT")
    @Token(save = true)
    public String addHtmlPersonnel(Model model) throws Exception {
        return "admin/info/departmentPersonnel/addAndEdit";
    }


    @PostMapping("/personnel/add")
    @RequiresPermissions("INFO:DEPARTMENT_PERSONNEL_INSERT")
    @SystemControllerLog(useType = UseType.USE, event = "添加系部人员")
    @Token(remove = true)
    @Validate(value = "BUS_DEPARTMENT_PERSONNEL", required = true)
    @ResponseBody
    public ResultState addPersonnel(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = departmentService.insertAndUpdateDepartmentPersonnel(mapParam);

        return resultState(resultMap);
    }


    @GetMapping("/personnel/update/{ID}")
    @RequiresPermissions("INFO:DEPARTMENT_PERSONNEL_UPDATE")
    public String updateHtmlPersonnel(Model model, @PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        model.addAttribute("personnel", departmentService.selectDepartmentPersonnel(mapParam));
        return "admin/info/departmentPersonnel/addAndEdit";
    }

    @PutMapping("/personnel/update")
    @RequiresPermissions("INFO:DEPARTMENT_PERSONNEL_UPDATE_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改系部人员")
    @Validate(value = "BUS_DEPARTMENT_PERSONNEL", required = true)
    @ResponseBody
    public ResultState updatePersonnel(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = departmentService.insertAndUpdateDepartmentPersonnel(mapParam);
        return resultState(resultMap);
    }

    @GetMapping("/personnel/accountInfo/{ID}")
    @RequiresPermissions("INFO:DEPARTMENT_PERSONNEL_ACCOUNT_INFO")
    public String updateHtmlAccountInfoPersonnel(Model model, @PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        model.addAttribute("OPERATOR", operatorService.selectOperator(mapParam));
        return "admin/system/operator/addAndEdit";
    }

    @PutMapping("/personnel/accountInfo")
    @RequiresPermissions("INFO:DEPARTMENT_PERSONNEL_ACCOUNT_INFO")
    @SystemControllerLog(useType = UseType.USE, event = "修改系部账号信息")
    @Validate("SYS_ACCOUNT_INFO")
    @ResponseBody
    public ResultState updateAccountInfoPersonnel(@RequestParam Map<String, Object> mapParam) throws Exception {
        return fairLock("insertAndUpdateOperator", () -> {
            Map<String, Object> resultMap = operatorService.insertAndUpdateOperator(mapParam);
            return resultState(resultMap);
        });
    }

    @PutMapping("/personnel/resetPwd")
    @RequiresPermissions("INFO:DEPARTMENT_PERSONNEL_RESET_PWD")
    @SystemControllerLog(useType = UseType.USE, event = "重置系部人员密码")
    @ResponseBody
    public ResultState resetPwdAccountInfoPersonnel(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = operatorService.resetOperatorPassword(mapParam);

        return resultState(resultMap);
    }

    @DeleteMapping("/personnel/delete/{ID}")
    @RequiresPermissions("INFO:DEPARTMENT_PERSONNEL_DELETE")
    @SystemControllerLog(useType = UseType.USE, event = "删除系部人员")
    @ResponseBody
    public ResultState deletePersonnel(@PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> resultMap = departmentService.deleteDepartmentPersonnel(mapParam);
        return resultState(resultMap);
    }

}
