package cn.kim.controller.manager.info;

import cn.kim.common.annotation.SystemControllerLog;
import cn.kim.common.annotation.Token;
import cn.kim.common.annotation.Validate;
import cn.kim.common.eu.UseType;
import cn.kim.controller.manager.BaseController;
import cn.kim.entity.ResultState;
import cn.kim.service.OperatorService;
import cn.kim.service.TeacherService;
import com.google.common.collect.Maps;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/8/6
 * 教师管理
 */
@Controller
@RequestMapping("/admin/teacher")
public class TeacherController extends BaseController {

    @Autowired
    private TeacherService teacherService;

    @Autowired
    private OperatorService operatorService;

    @GetMapping("/add")
    @RequiresPermissions("INFO:TEACHER_INSERT")
    @Token(save = true)
    public String addHtml(Model model) throws Exception {
        return "admin/info/teacher/addAndEdit";
    }


    @PostMapping("/add")
    @RequiresPermissions("INFO:TEACHER_INSERT")
    @SystemControllerLog(useType = UseType.USE, event = "添加教师")
    @Token(remove = true)
    @Validate(value = "BUS_TEACHER", required = true)
    @ResponseBody
    public ResultState add(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = teacherService.insertAndUpdateTeacher(mapParam);

        return resultState(resultMap);
    }


    @GetMapping("/update/{ID}")
    @RequiresPermissions("INFO:TEACHER_UPDATE")
    public String updateHtml(Model model, @PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        model.addAttribute("teacher", teacherService.selectTeacher(mapParam));
        return "admin/info/teacher/addAndEdit";
    }

    @PutMapping("/update")
    @RequiresPermissions("INFO:TEACHER_UPDATE_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改教师")
    @Validate(value = "BUS_TEACHER", required = true)
    @ResponseBody
    public ResultState update(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = teacherService.insertAndUpdateTeacher(mapParam);
        return resultState(resultMap);
    }

    @GetMapping("/accountInfo/{ID}")
    @RequiresPermissions("INFO:TEACHER_ACCOUNT_INFO")
    public String updateHtmlAccountInfo(Model model, @PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        model.addAttribute("OPERATOR", operatorService.selectOperator(mapParam));
        return "admin/system/operator/addAndEdit";
    }

    @PutMapping("/accountInfo")
    @RequiresPermissions("INFO:TEACHER_ACCOUNT_INFO")
    @SystemControllerLog(useType = UseType.USE, event = "修改教师账号信息")
    @Validate("SYS_ACCOUNT_INFO")
    @ResponseBody
    public ResultState updateAccountInfo(@RequestParam Map<String, Object> mapParam) throws Exception {
        return fairLock("insertAndUpdateOperator", () -> {
            Map<String, Object> resultMap = operatorService.insertAndUpdateOperator(mapParam);
            return resultState(resultMap);
        });
    }

    @PutMapping("/resetPwd")
    @RequiresPermissions("INFO:TEACHER_RESET_PWD")
    @SystemControllerLog(useType = UseType.USE, event = "重置教师人员密码")
    @ResponseBody
    public ResultState resetPwdAccountInfo(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = operatorService.resetOperatorPassword(mapParam);

        return resultState(resultMap);
    }

    @DeleteMapping("/delete/{ID}")
    @RequiresPermissions("INFO:TEACHER_DELETE")
    @SystemControllerLog(useType = UseType.USE, event = "删除教师")
    @ResponseBody
    public ResultState delete(@PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> resultMap = teacherService.deleteTeacher(mapParam);
        return resultState(resultMap);
    }

}
