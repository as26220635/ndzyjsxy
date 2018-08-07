package cn.kim.controller.manager.info;

import cn.kim.common.annotation.SystemControllerLog;
import cn.kim.common.annotation.Token;
import cn.kim.common.annotation.Validate;
import cn.kim.common.eu.UseType;
import cn.kim.controller.manager.BaseController;
import cn.kim.entity.ResultState;
import cn.kim.service.DepartmentService;
import cn.kim.service.OperatorService;
import cn.kim.service.StudentService;
import com.google.common.collect.Maps;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.checkerframework.checker.units.qual.A;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/8/6
 * 学生管理
 */
@Controller
@RequestMapping("/admin/student")
public class StudentController extends BaseController {

    @Autowired
    private StudentService studentService;

    @Autowired
    private OperatorService operatorService;

    @GetMapping("/add")
    @RequiresPermissions("INFO:STUDENT_INSERT")
    @Token(save = true)
    public String addHtml(Model model) throws Exception {
        return "admin/info/student/addAndEdit";
    }


    @PostMapping("/add")
    @RequiresPermissions("INFO:STUDENT_INSERT")
    @SystemControllerLog(useType = UseType.USE, event = "添加学生")
    @Token(remove = true)
    @Validate(value = "BUS_STUDENT", required = true)
    @ResponseBody
    public ResultState add(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = studentService.insertAndUpdateStudent(mapParam);

        return resultState(resultMap);
    }


    @GetMapping("/update/{ID}")
    @RequiresPermissions("INFO:STUDENT_UPDATE")
    public String updateHtml(Model model, @PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        model.addAttribute("student", studentService.selectStudent(mapParam));
        return "admin/info/student/addAndEdit";
    }

    @PutMapping("/update")
    @RequiresPermissions("INFO:STUDENT_UPDATE_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改学生")
    @Validate(value = "BUS_STUDENT", required = true)
    @ResponseBody
    public ResultState update(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = studentService.insertAndUpdateStudent(mapParam);
        return resultState(resultMap);
    }

    @GetMapping("/accountInfo/{ID}")
    @RequiresPermissions("INFO:STUDENT_ACCOUNT_INFO")
    public String updateHtmlAccountInfo(Model model, @PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        model.addAttribute("OPERATOR", operatorService.selectOperator(mapParam));
        return "admin/system/operator/addAndEdit";
    }

    @PutMapping("/accountInfo")
    @RequiresPermissions("INFO:STUDENT_ACCOUNT_INFO")
    @SystemControllerLog(useType = UseType.USE, event = "修改学生账号信息")
    @Validate("SYS_ACCOUNT_INFO")
    @ResponseBody
    public ResultState updateAccountInfo(@RequestParam Map<String, Object> mapParam) throws Exception {
        return fairLock("insertAndUpdateOperator", () -> {
            Map<String, Object> resultMap = operatorService.insertAndUpdateOperator(mapParam);
            return resultState(resultMap);
        });
    }

    @PutMapping("/resetPwd")
    @RequiresPermissions("INFO:STUDENT_RESET_PWD")
    @SystemControllerLog(useType = UseType.USE, event = "重置学生人员密码")
    @ResponseBody
    public ResultState resetPwdAccountInfo(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = operatorService.resetOperatorPassword(mapParam);

        return resultState(resultMap);
    }

    @DeleteMapping("/delete/{ID}")
    @RequiresPermissions("INFO:STUDENT_DELETE")
    @SystemControllerLog(useType = UseType.USE, event = "删除学生")
    @ResponseBody
    public ResultState delete(@PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> resultMap = studentService.deleteStudent(mapParam);
        return resultState(resultMap);
    }

}
