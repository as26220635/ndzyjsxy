package cn.kim.controller.manager.student;

import cn.kim.common.annotation.SystemControllerLog;
import cn.kim.common.annotation.Token;
import cn.kim.common.annotation.Validate;
import cn.kim.common.eu.UseType;
import cn.kim.controller.manager.BaseController;
import cn.kim.entity.DataTablesView;
import cn.kim.entity.ResultState;
import cn.kim.service.DepartmentService;
import cn.kim.service.MenuService;
import cn.kim.service.OperatorService;
import cn.kim.service.StudentService;
import cn.kim.util.AllocationUtil;
import com.google.common.collect.Maps;
import org.apache.shiro.authz.annotation.Logical;
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

    @Autowired
    private MenuService menuService;

    /**
     * 获取学生列表
     *
     * @param mapParam
     * @return
     */
    @GetMapping("/list")
    @RequiresPermissions(value = {"STUDENT:ATTENDANCE", "STUDENT:PUNISHMENT", "STUDENT:COMPREHENSIVE"}, logical = Logical.OR)
    @ResponseBody
    public DataTablesView<?> list(@RequestParam Map<String, Object> mapParam) {
        DataTablesView<?> view = studentService.selectStudentDataTablesView(mapParam);
        view.setDraw(toInt(mapParam.get("draw")));
        return view;
    }


    @GetMapping("/add")
    @RequiresPermissions("STUDENT:BASE_INSERT")
    @Token(save = true)
    public String addHtml(Model model) throws Exception {
        return "admin/student/student/addAndEdit";
    }


    @PostMapping("/add")
    @RequiresPermissions("STUDENT:BASE_INSERT")
    @SystemControllerLog(useType = UseType.USE, event = "添加学生")
    @Token(remove = true)
    @Validate(value = "BUS_STUDENT", required = true)
    @ResponseBody
    public ResultState add(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = studentService.insertAndUpdateStudent(mapParam);

        return resultState(resultMap);
    }


    @GetMapping("/update/{ID}")
    @RequiresPermissions("STUDENT:BASE_UPDATE")
    public String updateHtml(Model model, @PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        model.addAttribute("student", studentService.selectStudent(mapParam));
        return "admin/student/student/addAndEdit";
    }

    @PutMapping("/update")
    @RequiresPermissions("STUDENT:BASE_UPDATE_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改学生")
    @Validate(value = "BUS_STUDENT", required = true)
    @ResponseBody
    public ResultState update(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = studentService.insertAndUpdateStudent(mapParam);
        return resultState(resultMap);
    }

    @GetMapping("/accountInfo/{ID}")
    @RequiresPermissions("STUDENT:BASE_ACCOUNT_INFO")
    public String updateHtmlAccountInfo(Model model, @PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        model.addAttribute("OPERATOR", operatorService.selectOperator(mapParam));
        return "admin/system/operator/addAndEdit";
    }

    @PutMapping("/accountInfo")
    @RequiresPermissions("STUDENT:BASE_ACCOUNT_INFO")
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
    @RequiresPermissions("STUDENT:BASE_RESET_PWD")
    @SystemControllerLog(useType = UseType.USE, event = "重置学生人员密码")
    @ResponseBody
    public ResultState resetPwdAccountInfo(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = operatorService.resetOperatorPassword(mapParam);

        return resultState(resultMap);
    }

    @DeleteMapping("/delete/{ID}")
    @RequiresPermissions("STUDENT:BASE_DELETE")
    @SystemControllerLog(useType = UseType.USE, event = "删除学生")
    @ResponseBody
    public ResultState delete(@PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> resultMap = studentService.deleteStudent(mapParam);
        return resultState(resultMap);
    }

    /**********     学生考勤    ********/

    @GetMapping("/attendance/add")
    @RequiresPermissions("STUDENT:ATTENDANCE_INSERT")
    @Token(save = true)
    public String addHtmlAttendance(Model model) throws Exception {
        return "admin/student/attendance/addAndEdit";
    }


    @PostMapping("/attendance/add")
    @RequiresPermissions("STUDENT:ATTENDANCE_INSERT")
    @SystemControllerLog(useType = UseType.USE, event = "添加学生考勤")
    @Token(remove = true)
    @Validate(value = "BUS_STUDENT_ATTENDANCE", required = true)
    @ResponseBody
    public ResultState addAttendance(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = studentService.insertAndUpdateStudentAttendance(mapParam);

        return resultState(resultMap);
    }


    @GetMapping("/attendance/update/{ID}")
    @RequiresPermissions("STUDENT:ATTENDANCE_UPDATE")
    public String updateHtmlAttendance(Model model, @PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        model.addAttribute("attendance", studentService.selectStudentAttendance(mapParam));
        return "admin/student/attendance/addAndEdit";
    }

    @PutMapping("/attendance/update")
    @RequiresPermissions("STUDENT:ATTENDANCE_UPDATE_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改学生考勤")
    @Validate(value = "BUS_STUDENT_ATTENDANCE", required = true)
    @ResponseBody
    public ResultState updateAttendance(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = studentService.insertAndUpdateStudentAttendance(mapParam);
        return resultState(resultMap);
    }

    @DeleteMapping("/attendance/delete/{ID}")
    @RequiresPermissions("STUDENT:ATTENDANCE_DELETE")
    @SystemControllerLog(useType = UseType.USE, event = "删除学生考勤")
    @ResponseBody
    public ResultState deleteAttendance(@PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> resultMap = studentService.deleteStudentAttendance(mapParam);
        return resultState(resultMap);
    }

    /**********     学生处分    ********/

    @GetMapping("/punishment/add")
    @RequiresPermissions("STUDENT:PUNISHMENT_INSERT")
    @Token(save = true)
    public String addHtmlPunishment(Model model) throws Exception {
        //设置初始化ID
        setInsertId(model);
        return "admin/student/punishment/addAndEdit";
    }


    @PostMapping("/punishment/add")
    @RequiresPermissions("STUDENT:PUNISHMENT_INSERT")
    @SystemControllerLog(useType = UseType.USE, event = "添加学生处分")
    @Token(remove = true)
    @Validate(value = "BUS_STUDENT_PUNISHMENT", required = true)
    @ResponseBody
    public ResultState addPunishment(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = studentService.insertAndUpdateStudentPunishment(mapParam);

        return resultState(resultMap);
    }


    @GetMapping("/punishment/update/{ID}")
    @RequiresPermissions("STUDENT:PUNISHMENT_UPDATE")
    public String updateHtmlPunishment(Model model, @PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> punishment = studentService.selectStudentPunishment(mapParam);

        model.addAttribute("punishment", punishment);
        return "admin/student/punishment/addAndEdit";
    }

    @PutMapping("/punishment/update")
    @RequiresPermissions("STUDENT:PUNISHMENT_UPDATE_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改学生处分")
    @Validate(value = "BUS_STUDENT_PUNISHMENT", required = true)
    @ResponseBody
    public ResultState updatePunishment(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = studentService.insertAndUpdateStudentPunishment(mapParam);
        return resultState(resultMap);
    }

    @PutMapping("/punishment/revoke/{ID}")
    @RequiresPermissions("STUDENT:PUNISHMENT_REVOKE")
    @SystemControllerLog(useType = UseType.USE, event = "撤销学生处分")
    @ResponseBody
    public ResultState revokePunishment(@PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> resultMap = studentService.revokeStudentPunishment(mapParam);
        return resultState(resultMap);
    }


    @DeleteMapping("/punishment/delete/{ID}")
    @RequiresPermissions("STUDENT:PUNISHMENT_DELETE")
    @SystemControllerLog(useType = UseType.USE, event = "删除学生处分")
    @ResponseBody
    public ResultState deletePunishment(@PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> resultMap = studentService.deleteStudentPunishment(mapParam);
        return resultState(resultMap);
    }

    /**********     学生综合素质测评    ********/

    @GetMapping("/comprehensive/insertAndUpdate")
    @RequiresPermissions("STUDENT:COMPREHENSIVE_INSERT_AND_UPDATE")
    public String insertAndUpdateHtmlComprehensive(Model model, String SM_ID, String ID, String BS_NAME) throws Exception {
        String educationProportion;
        String intellectualProportion;
        String volunteerProportion;

        if (!isEmpty(ID)) {
            Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
            mapParam.put("ID", ID);
            Map<String, Object> comprehensive = studentService.selectStudentComprehensive(mapParam);

            model.addAttribute("BS_NAME", BS_NAME);
            model.addAttribute("comprehensive", comprehensive);

            educationProportion = toString(comprehensive.get("BSC_EDUCATION_PROPORTION"));
            intellectualProportion = toString(comprehensive.get("BSC_INTELLECTUAL_PROPORTION"));
            volunteerProportion = toString(comprehensive.get("BSC_VOLUNTEER_PROPORTION"));
        } else {
            educationProportion = AllocationUtil.get("EDUCATION_PROPORTION", 30);
            intellectualProportion = AllocationUtil.get("INTELLECTUAL_PROPORTION", 60);
            volunteerProportion = AllocationUtil.get("VOLUNTEER_PROPORTION", 10);
        }

        //德育
        model.addAttribute("EDUCATION_PROPORTION", educationProportion);
        //智育
        model.addAttribute("INTELLECTUAL_PROPORTION", intellectualProportion);
        //志愿者
        model.addAttribute("VOLUNTEER_PROPORTION", volunteerProportion);

        model.addAttribute("MENU", menuService.queryMenuById(SM_ID));
        return "admin/student/comprehensive/addAndEdit";
    }

    @PutMapping("/comprehensive/insertAndUpdate")
    @RequiresPermissions("STUDENT:COMPREHENSIVE_INSERT_AND_UPDATE")
    @SystemControllerLog(useType = UseType.USE, event = "添加或编辑学生综合素质测评")
    @Validate(value = "BUS_STUDENT_COMPREHENSIVE", required = true)
    @ResponseBody
    public ResultState insertAndUpdateComprehensive(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = studentService.insertAndUpdateStudentComprehensive(mapParam);
        return resultState(resultMap);
    }

    @DeleteMapping("/comprehensive/delete/{ID}")
    @RequiresPermissions("STUDENT:COMPREHENSIVE_DELETE")
    @SystemControllerLog(useType = UseType.USE, event = "删除学生综合素质测评")
    @ResponseBody
    public ResultState deleteComprehensive(@PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> resultMap = studentService.deleteStudentComprehensive(mapParam);
        return resultState(resultMap);
    }
}