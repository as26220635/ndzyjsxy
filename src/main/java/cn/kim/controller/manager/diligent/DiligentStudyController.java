package cn.kim.controller.manager.diligent;

import cn.kim.common.annotation.SystemControllerLog;
import cn.kim.common.annotation.Token;
import cn.kim.common.annotation.Validate;
import cn.kim.common.eu.UseType;
import cn.kim.controller.manager.BaseController;
import cn.kim.entity.ActiveUser;
import cn.kim.entity.ResultState;
import cn.kim.entity.Tree;
import cn.kim.service.DiligentStudyService;
import cn.kim.service.OperatorService;
import com.google.common.collect.Maps;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.checkerframework.checker.units.qual.A;
import org.jetbrains.annotations.Nullable;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/9/10
 * 勤工助学管理
 */
@Controller
@RequestMapping("/admin/diligent")
public class DiligentStudyController extends BaseController {

    @Autowired
    private DiligentStudyService diligentStudyService;

    @Autowired
    private OperatorService operatorService;

    /******************************     勤工助学    *******************************/

    @GetMapping("/study/add")
    @RequiresPermissions("DILIGENT:STUDY_INSERT")
    @Token(save = true)
    public String addHtml(Model model) throws Exception {
        ActiveUser activeUser = getActiveUser();
        Map<String, Object> study = Maps.newHashMapWithExpectedSize(2);
        study.put("BDS_TABLE_ID", activeUser.getTableId());
        study.put("BDS_TABLE_NAME", activeUser.getType());
        model.addAttribute("study", study);
        return "admin/diligent/study/addAndEdit";
    }


    @PostMapping("/study/add")
    @RequiresPermissions("DILIGENT:STUDY_INSERT")
    @SystemControllerLog(useType = UseType.USE, event = "添加勤工助学")
    @Token(remove = true)
    @Validate("BUS_DILIGENT_STUDY")
    @ResponseBody
    public ResultState add(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = diligentStudyService.insertAndUpdateDiligentStudy(mapParam);

        return resultState(resultMap);
    }


    @GetMapping("/study/update/{ID}")
    @RequiresPermissions("DILIGENT:STUDY_UPDATE")
    public String updateHtml(Model model, @PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        model.addAttribute("study", diligentStudyService.selectDiligentStudy(mapParam));
        return "admin/diligent/study/addAndEdit";
    }

    @PutMapping("/study/update")
    @RequiresPermissions("DILIGENT:STUDY_UPDATE_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改勤工助学")
    @Validate("BUS_DILIGENT_STUDY")
    @ResponseBody
    public ResultState update(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = diligentStudyService.insertAndUpdateDiligentStudy(mapParam);
        return resultState(resultMap);
    }

    @DeleteMapping("/study/delete/{ID}")
    @RequiresPermissions("DILIGENT:STUDY_DELETE")
    @SystemControllerLog(useType = UseType.USE, event = "删除勤工助学")
    @ResponseBody
    public ResultState delete(@PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> resultMap = diligentStudyService.deleteDiligentStudy(mapParam);
        return resultState(resultMap);
    }

    /******************************     勤工助学岗位   *******************************/

    @GetMapping("/post/add")
    @RequiresPermissions("DILIGENT:STUDY_POST_INSERT")
    @Token(save = true)
    public String addHtmlPost(String BDS_ID, Model model) throws Exception {
        model.addAttribute("BDS_ID", BDS_ID);
        return "admin/diligent/post/addAndEdit";
    }


    @PostMapping("/post/add")
    @RequiresPermissions("DILIGENT:STUDY_POST_INSERT")
    @SystemControllerLog(useType = UseType.USE, event = "添加勤工助学岗位")
    @Token(remove = true)
    @Validate("BUS_DILIGENT_STUDY_POST")
    @ResponseBody
    public ResultState addPost(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = diligentStudyService.insertAndUpdateDiligentStudyPost(mapParam);

        return resultState(resultMap);
    }


    @GetMapping("/post/update/{ID}")
    @RequiresPermissions("DILIGENT:STUDY_POST_UPDATE")
    public String updateHtmlPost(Model model, @PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        model.addAttribute("post", diligentStudyService.selectDiligentStudyPost(mapParam));
        return "admin/diligent/post/addAndEdit";
    }

    @PutMapping("/post/update")
    @RequiresPermissions("DILIGENT:STUDY_POST_UPDATE_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改勤工助学岗位")
    @Validate("BUS_DILIGENT_STUDY_POST")
    @ResponseBody
    public ResultState updatePost(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = diligentStudyService.insertAndUpdateDiligentStudyPost(mapParam);
        return resultState(resultMap);
    }

    @DeleteMapping("/post/delete/{ID}")
    @RequiresPermissions("DILIGENT:STUDY_POST_DELETE")
    @SystemControllerLog(useType = UseType.USE, event = "删除勤工助学岗位")
    @ResponseBody
    public ResultState deletePost(@PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> resultMap = diligentStudyService.deleteDiligentStudyPost(mapParam);
        return resultState(resultMap);
    }

    /******************************     勤工助学学生   *******************************/

    @GetMapping("/student/add")
    @RequiresPermissions("DILIGENT:STUDY_STUDENT_INSERT")
    @Token(save = true)
    public String addHtmlStudent(String BDSP_ID, Model model) throws Exception {
        model.addAttribute("BDSP_ID", BDSP_ID);
        return "admin/diligent/student/addAndEdit";
    }


    @PostMapping("/student/add")
    @RequiresPermissions("DILIGENT:STUDY_STUDENT_INSERT")
    @SystemControllerLog(useType = UseType.USE, event = "添加勤工助学学生")
    @Token(remove = true)
    @Validate("BUS_DILIGENT_STUDY_STUDENT")
    @ResponseBody
    public ResultState addStudent(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = diligentStudyService.insertAndUpdateDiligentStudyStudent(mapParam);

        return resultState(resultMap);
    }


    @GetMapping("/student/update/{ID}")
    @RequiresPermissions("DILIGENT:STUDY_STUDENT_UPDATE")
    public String updateHtmlStudent(Model model, @PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        model.addAttribute("student", diligentStudyService.selectDiligentStudyStudent(mapParam));
        return "admin/diligent/student/addAndEdit";
    }

    @PutMapping("/student/update")
    @RequiresPermissions("DILIGENT:STUDY_STUDENT_UPDATE_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改勤工助学学生")
    @Validate("BUS_DILIGENT_STUDY_STUDENT")
    @ResponseBody
    public ResultState updateStudent(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = diligentStudyService.insertAndUpdateDiligentStudyStudent(mapParam);
        return resultState(resultMap);
    }

    @DeleteMapping("/student/delete/{ID}")
    @RequiresPermissions("DILIGENT:STUDY_STUDENT_DELETE")
    @SystemControllerLog(useType = UseType.USE, event = "删除勤工助学学生")
    @ResponseBody
    public ResultState deleteStudent(@PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> resultMap = diligentStudyService.deleteDiligentStudyStudent(mapParam);
        return resultState(resultMap);
    }

    @PostMapping("/student/import")
    @RequiresPermissions("DILIGENT:STUDY_STUDENT_IMPORT")
    @SystemControllerLog(useType = UseType.USE, event = "导入勤工助学学生")
    @ResponseBody
    public ResultState importStudent(MultipartFile excelFile) throws Exception {
        //最多等待10分钟10分钟后解锁
        return fairLock("importDiligentStudyStudent", 600, 600, () -> {
            Map<String, Object> resultMap = diligentStudyService.importDiligentStudyStudent(excelFile);
            return resultState(resultMap);
        });
    }

    /******************************     勤工助学月工资   *******************************/

    @GetMapping("/monthWages/add")
    @RequiresPermissions("DILIGENT:STUDY_MONTH_WAGES_INSERT")
    @Token(save = true)
    public String addHtmlMonthWages(String BDSS_ID, Model model) throws Exception {
        Map<String, Object> student = diligentStudyService.selectStudentByDiligentStudyStudentId(BDSS_ID);
        Map<String, Object> wages = Maps.newHashMapWithExpectedSize(2);
        wages.put("BDSS_ID", BDSS_ID);
        wages.put("BS_NAME", student.get("BS_NAME"));

        model.addAttribute("wages", wages);
        return "admin/diligent/monthWages/addAndEdit";
    }


    @PostMapping("/monthWages/add")
    @RequiresPermissions("DILIGENT:STUDY_MONTH_WAGES_INSERT")
    @SystemControllerLog(useType = UseType.USE, event = "添加勤工助学月工资")
    @Token(remove = true)
    @Validate("BUS_DILIGENT_STUDY_MONTH_WAGES")
    @ResponseBody
    public ResultState addMonthWages(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = diligentStudyService.insertAndUpdateDiligentStudyMonthWages(mapParam);

        return resultState(resultMap);
    }


    @GetMapping("/monthWages/update/{ID}")
    @RequiresPermissions("DILIGENT:STUDY_MONTH_WAGES_UPDATE")
    public String updateHtmlMonthWages(Model model, @PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        model.addAttribute("wages", diligentStudyService.selectDiligentStudyMonthWages(mapParam));
        return "admin/diligent/monthWages/addAndEdit";
    }

    @PutMapping("/monthWages/update")
    @RequiresPermissions("DILIGENT:STUDY_MONTH_WAGES_UPDATE_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改勤工助学月工资")
    @Validate("BUS_DILIGENT_STUDY_MONTH_WAGES")
    @ResponseBody
    public ResultState updateMonthWages(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = diligentStudyService.insertAndUpdateDiligentStudyMonthWages(mapParam);
        return resultState(resultMap);
    }

    @DeleteMapping("/monthWages/delete/{ID}")
    @RequiresPermissions("DILIGENT:STUDY_MONTH_WAGES_DELETE")
    @SystemControllerLog(useType = UseType.USE, event = "删除勤工助学月工资")
    @ResponseBody
    public ResultState deleteMonthWages(@PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> resultMap = diligentStudyService.deleteDiligentStudyMonthWages(mapParam);
        return resultState(resultMap);
    }

    @PostMapping("/monthWages/import")
    @RequiresPermissions("DILIGENT:STUDY_MONTH_WAGES_IMPORT")
    @SystemControllerLog(useType = UseType.USE, event = "导入勤工助学月工资")
    @ResponseBody
    public ResultState importMonthWages(MultipartFile excelFile) throws Exception {
        //最多等待10分钟10分钟后解锁
        return fairLock("importDiligentStudyMonthWages", 600, 600, () -> {
            Map<String, Object> resultMap = diligentStudyService.importDiligentStudyMonthWages(excelFile);
            return resultState(resultMap);
        });
    }
}
