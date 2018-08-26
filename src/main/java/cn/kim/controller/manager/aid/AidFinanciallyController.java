package cn.kim.controller.manager.aid;

import cn.kim.common.annotation.SystemControllerLog;
import cn.kim.common.annotation.Token;
import cn.kim.common.annotation.Validate;
import cn.kim.common.eu.AidType;
import cn.kim.common.eu.Process;
import cn.kim.common.eu.UseType;
import cn.kim.controller.manager.BaseController;
import cn.kim.entity.ResultState;
import cn.kim.service.AidFinanciallyService;
import com.google.common.collect.Maps;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/8/12
 * 资助管理
 */
@Controller
@RequestMapping("/admin/aidFinancially")
public class AidFinanciallyController extends BaseController {

    @Autowired
    private AidFinanciallyService aidFinanciallyService;

    /******************     学校奖学金   *****************/

    @GetMapping("/collegeScholarship/add")
    @RequiresPermissions("AID:COLLEGE_SCHOLARSHIP_INSERT")
    @Token(save = true)
    public String addHtmlCollegeScholarship(Model model) throws Exception {
        Map<String, Object> aid = Maps.newHashMapWithExpectedSize(2);
        model.addAttribute("aid", setStudentYearSemester(aid, "BAF_YEAR", "BAF_SEMESTER"));
        return "admin/aid/collegeScholarship/addAndEdit";
    }


    @PostMapping("/collegeScholarship/add")
    @RequiresPermissions("AID:COLLEGE_SCHOLARSHIP_INSERT")
    @SystemControllerLog(useType = UseType.USE, event = "添加学院奖学金")
    @Token(remove = true)
    @Validate("BUS_AID_FINANCIALLY")
    @ResponseBody
    public ResultState addCollegeScholarship(@RequestParam Map<String, Object> mapParam) throws Exception {
        //流程
        mapParam.put("BUS_PROCESS", Process.AID.toString());
        mapParam.put("BUS_PROCESS2", Process.AID_COLLEGE_SCHOLARSHIP.toString());
        //类型
        mapParam.put("BAF_TYPE", AidType.COLLEGE_SCHOLARSHIP.toString());
        Map<String, Object> resultMap = aidFinanciallyService.insertAndUpdateAidFinancially(mapParam);

        return resultState(resultMap);
    }


    @GetMapping("/collegeScholarship/update/{ID}")
    @RequiresPermissions("AID:COLLEGE_SCHOLARSHIP_UPDATE")
    public String updateHtmlCollegeScholarship(Model model, @PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        model.addAttribute("aid", aidFinanciallyService.selectAidFinancially(mapParam));
        return "admin/aid/collegeScholarship/addAndEdit";
    }

    @PutMapping("/collegeScholarship/update")
    @RequiresPermissions("AID:COLLEGE_SCHOLARSHIP_UPDATE_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改学院奖学金")
    @Validate("BUS_AID_FINANCIALLY")
    @ResponseBody
    public ResultState updateCollegeScholarship(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = aidFinanciallyService.insertAndUpdateAidFinancially(mapParam);
        return resultState(resultMap);
    }

    @DeleteMapping("/collegeScholarship/delete/{ID}")
    @RequiresPermissions("AID:COLLEGE_SCHOLARSHIP_DELETE")
    @SystemControllerLog(useType = UseType.USE, event = "删除学院奖学金")
    @ResponseBody
    public ResultState deleteCollegeScholarship(@PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> resultMap = aidFinanciallyService.deleteAidFinancially(mapParam);
        return resultState(resultMap);
    }

    @PostMapping("/collegeScholarship/import")
    @RequiresPermissions("AID:COLLEGE_SCHOLARSHIP_IMPORT")
    @SystemControllerLog(useType = UseType.USE, event = "导入学院奖学金")
    @ResponseBody
    public ResultState importCollegeScholarship(MultipartFile excelFile) throws Exception {
        //最多等待10分钟10分钟后解锁
        return fairLock("importCollegeScholarship", 600, 600, () -> {
            Map<String, Object> resultMap = aidFinanciallyService.importCollegeScholarship(excelFile);
            return resultState(resultMap);
        });
    }

    /******************     年度表彰   *****************/

    @GetMapping("/commend/add")
    @RequiresPermissions("AID:COMMEND_INSERT")
    @Token(save = true)
    public String addHtmlCommend(Model model) throws Exception {
        Map<String, Object> aid = Maps.newHashMapWithExpectedSize(2);
        model.addAttribute("aid", setStudentYearSemester(aid, "BAF_YEAR", "BAF_SEMESTER"));
        return "admin/aid/commend/addAndEdit";
    }


    @PostMapping("/commend/add")
    @RequiresPermissions("AID:COMMEND_INSERT")
    @SystemControllerLog(useType = UseType.USE, event = "添加年度表彰")
    @Token(remove = true)
    @Validate("BUS_AID_FINANCIALLY")
    @ResponseBody
    public ResultState addCommend(@RequestParam Map<String, Object> mapParam) throws Exception {
        //流程
        mapParam.put("BUS_PROCESS", Process.AID.toString());
        mapParam.put("BUS_PROCESS2", Process.AID_COLLEGE_SCHOLARSHIP.toString());
        //类型
        mapParam.put("BAF_TYPE", AidType.COMMEND.toString());
        Map<String, Object> resultMap = aidFinanciallyService.insertAndUpdateAidFinancially(mapParam);

        return resultState(resultMap);
    }


    @GetMapping("/commend/update/{ID}")
    @RequiresPermissions("AID:COMMEND_UPDATE")
    public String updateHtmlCommend(Model model, @PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        model.addAttribute("aid", aidFinanciallyService.selectAidFinancially(mapParam));
        return "admin/aid/commend/addAndEdit";
    }

    @PutMapping("/commend/update")
    @RequiresPermissions("AID:COMMEND_UPDATE_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改年度表彰")
    @Validate("BUS_AID_FINANCIALLY")
    @ResponseBody
    public ResultState updateCommend(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = aidFinanciallyService.insertAndUpdateAidFinancially(mapParam);
        return resultState(resultMap);
    }

    @DeleteMapping("/commend/delete/{ID}")
    @RequiresPermissions("AID:COMMEND_DELETE")
    @SystemControllerLog(useType = UseType.USE, event = "删除年度表彰")
    @ResponseBody
    public ResultState deleteCommend(@PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> resultMap = aidFinanciallyService.deleteAidFinancially(mapParam);
        return resultState(resultMap);
    }

    @PostMapping("/commend/import")
    @RequiresPermissions("AID:COMMEND_IMPORT")
    @SystemControllerLog(useType = UseType.USE, event = "导入年度表彰")
    @ResponseBody
    public ResultState importCommend(MultipartFile excelFile) throws Exception {
        //最多等待10分钟10分钟后解锁
        return fairLock("importCommend", 600, 600, () -> {
            Map<String, Object> resultMap = aidFinanciallyService.importCommend(excelFile);
            return resultState(resultMap);
        });
    }

    /******************     绿色通道   *****************/

    @GetMapping("/greenChannel/add")
    @RequiresPermissions("AID:GREEN_CHANNEL_INSERT")
    @Token(save = true)
    public String addHtmlGreenChannel(Model model) throws Exception {
        Map<String, Object> aid = Maps.newHashMapWithExpectedSize(2);
        model.addAttribute("aid", setStudentYearSemester(aid, "BAF_YEAR", "BAF_SEMESTER"));
        return "admin/aid/greenChannel/addAndEdit";
    }


    @PostMapping("/greenChannel/add")
    @RequiresPermissions("AID:GREEN_CHANNEL_INSERT")
    @SystemControllerLog(useType = UseType.USE, event = "添加绿色通道")
    @Token(remove = true)
    @Validate("BUS_AID_FINANCIALLY")
    @ResponseBody
    public ResultState addGreenChannel(@RequestParam Map<String, Object> mapParam) throws Exception {
        //流程
        mapParam.put("BUS_PROCESS", Process.AID.toString());
        mapParam.put("BUS_PROCESS2", Process.AID_GREEN_CHANNEL.toString());
        //类型
        mapParam.put("BAF_TYPE", AidType.GREEN_CHANNEL.toString());
        Map<String, Object> resultMap = aidFinanciallyService.insertAndUpdateAidFinancially(mapParam);

        return resultState(resultMap);
    }


    @GetMapping("/greenChannel/update/{ID}")
    @RequiresPermissions("AID:GREEN_CHANNEL_UPDATE")
    public String updateHtmlGreenChannel(Model model, @PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        model.addAttribute("aid", aidFinanciallyService.selectAidFinancially(mapParam));
        return "admin/aid/greenChannel/addAndEdit";
    }

    @PutMapping("/greenChannel/update")
    @RequiresPermissions("AID:GREEN_CHANNEL_UPDATE_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改绿色通道")
    @Validate("BUS_AID_FINANCIALLY")
    @ResponseBody
    public ResultState updateGreenChannel(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = aidFinanciallyService.insertAndUpdateAidFinancially(mapParam);
        return resultState(resultMap);
    }

    @DeleteMapping("/greenChannel/delete/{ID}")
    @RequiresPermissions("AID:GREEN_CHANNEL_DELETE")
    @SystemControllerLog(useType = UseType.USE, event = "删除绿色通道")
    @ResponseBody
    public ResultState deleteGreenChannel(@PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> resultMap = aidFinanciallyService.deleteAidFinancially(mapParam);
        return resultState(resultMap);
    }

    @PostMapping("/greenChannel/import")
    @RequiresPermissions("AID:GREEN_CHANNEL_IMPORT")
    @SystemControllerLog(useType = UseType.USE, event = "导入绿色通道")
    @ResponseBody
    public ResultState importGreenChannel(MultipartFile excelFile) throws Exception {
        //最多等待10分钟10分钟后解锁
        return fairLock("importGreenChannel", 600, 600, () -> {
            Map<String, Object> resultMap = aidFinanciallyService.importGreenChannel(excelFile);
            return resultState(resultMap);
        });
    }

    /******************     减免学费   *****************/

    @GetMapping("/tuitionWaiver/add")
    @RequiresPermissions("AID:TUITION_WAIVER_INSERT")
    @Token(save = true)
    public String addHtmlTuitionWaiver(Model model) throws Exception {
        Map<String, Object> aid = Maps.newHashMapWithExpectedSize(2);
        model.addAttribute("aid", setStudentYearSemester(aid, "BAF_YEAR", "BAF_SEMESTER"));
        return "admin/aid/tuitionWaiver/addAndEdit";
    }


    @PostMapping("/tuitionWaiver/add")
    @RequiresPermissions("AID:TUITION_WAIVER_INSERT")
    @SystemControllerLog(useType = UseType.USE, event = "添加减免学费")
    @Token(remove = true)
    @Validate("BUS_AID_FINANCIALLY")
    @ResponseBody
    public ResultState addTuitionWaiver(@RequestParam Map<String, Object> mapParam) throws Exception {
        //流程
        mapParam.put("BUS_PROCESS", Process.AID.toString());
        mapParam.put("BUS_PROCESS2", Process.AID_TUITION_WAIVER.toString());
        //类型
        mapParam.put("BAF_TYPE", AidType.TUITION_WAIVER.toString());
        Map<String, Object> resultMap = aidFinanciallyService.insertAndUpdateAidFinancially(mapParam);

        return resultState(resultMap);
    }


    @GetMapping("/tuitionWaiver/update/{ID}")
    @RequiresPermissions("AID:TUITION_WAIVER_UPDATE")
    public String updateHtmlTuitionWaiver(Model model, @PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        model.addAttribute("aid", aidFinanciallyService.selectAidFinancially(mapParam));
        return "admin/aid/tuitionWaiver/addAndEdit";
    }

    @PutMapping("/tuitionWaiver/update")
    @RequiresPermissions("AID:TUITION_WAIVER_UPDATE_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改减免学费")
    @Validate("BUS_AID_FINANCIALLY")
    @ResponseBody
    public ResultState updateTuitionWaiver(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = aidFinanciallyService.insertAndUpdateAidFinancially(mapParam);
        return resultState(resultMap);
    }

    @DeleteMapping("/tuitionWaiver/delete/{ID}")
    @RequiresPermissions("AID:TUITION_WAIVER_DELETE")
    @SystemControllerLog(useType = UseType.USE, event = "删除减免学费")
    @ResponseBody
    public ResultState deleteTuitionWaiver(@PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> resultMap = aidFinanciallyService.deleteAidFinancially(mapParam);
        return resultState(resultMap);
    }

    @PostMapping("/tuitionWaiver/import")
    @RequiresPermissions("AID:TUITION_WAIVER_IMPORT")
    @SystemControllerLog(useType = UseType.USE, event = "导入减免学费")
    @ResponseBody
    public ResultState importTuitionWaiver(MultipartFile excelFile) throws Exception {
        //最多等待10分钟10分钟后解锁
        return fairLock("importTuitionWaiver", 600, 600, () -> {
            Map<String, Object> resultMap = aidFinanciallyService.importTuitionWaiver(excelFile);
            return resultState(resultMap);
        });
    }

    /******************     困难毕业生就业补助   *****************/

    @GetMapping("/jobseekerSupport/add")
    @RequiresPermissions("AID:JOBSEEKER_SUPPORT_INSERT")
    @Token(save = true)
    public String addHtmlJobseekerSupport(Model model) throws Exception {
        Map<String, Object> aid = Maps.newHashMapWithExpectedSize(2);
        model.addAttribute("aid", setStudentYearSemester(aid, "BAF_YEAR", "BAF_SEMESTER"));
        return "admin/aid/jobseekerSupport/addAndEdit";
    }


    @PostMapping("/jobseekerSupport/add")
    @RequiresPermissions("AID:JOBSEEKER_SUPPORT_INSERT")
    @SystemControllerLog(useType = UseType.USE, event = "添加困难毕业生就业补助")
    @Token(remove = true)
    @Validate("BUS_AID_FINANCIALLY")
    @ResponseBody
    public ResultState addJobseekerSupport(@RequestParam Map<String, Object> mapParam) throws Exception {
        //流程
        mapParam.put("BUS_PROCESS", Process.AID.toString());
        mapParam.put("BUS_PROCESS2", Process.AID_JOBSEEKER_SUPPORT.toString());
        //类型
        mapParam.put("BAF_TYPE", AidType.JOBSEEKER_SUPPORT.toString());
        Map<String, Object> resultMap = aidFinanciallyService.insertAndUpdateAidFinancially(mapParam);

        return resultState(resultMap);
    }


    @GetMapping("/jobseekerSupport/update/{ID}")
    @RequiresPermissions("AID:JOBSEEKER_SUPPORT_UPDATE")
    public String updateHtmlJobseekerSupport(Model model, @PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        model.addAttribute("aid", aidFinanciallyService.selectAidFinancially(mapParam));
        return "admin/aid/jobseekerSupport/addAndEdit";
    }

    @PutMapping("/jobseekerSupport/update")
    @RequiresPermissions("AID:JOBSEEKER_SUPPORT_UPDATE_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改困难毕业生就业补助")
    @Validate("BUS_AID_FINANCIALLY")
    @ResponseBody
    public ResultState updateJobseekerSupport(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = aidFinanciallyService.insertAndUpdateAidFinancially(mapParam);
        return resultState(resultMap);
    }

    @DeleteMapping("/jobseekerSupport/delete/{ID}")
    @RequiresPermissions("AID:JOBSEEKER_SUPPORT_DELETE")
    @SystemControllerLog(useType = UseType.USE, event = "删除困难毕业生就业补助")
    @ResponseBody
    public ResultState deleteJobseekerSupport(@PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> resultMap = aidFinanciallyService.deleteAidFinancially(mapParam);
        return resultState(resultMap);
    }

    @PostMapping("/jobseekerSupport/import")
    @RequiresPermissions("AID:JOBSEEKER_SUPPORT_IMPORT")
    @SystemControllerLog(useType = UseType.USE, event = "导入困难毕业生就业补助")
    @ResponseBody
    public ResultState importJobseekerSupport(MultipartFile excelFile) throws Exception {
        //最多等待10分钟10分钟后解锁
        return fairLock("importJobseekerSupport", 600, 600, () -> {
            Map<String, Object> resultMap = aidFinanciallyService.importJobseekerSupport(excelFile);
            return resultState(resultMap);
        });
    }

    /******************     应急求助   *****************/

    @GetMapping("/emergencyHelp/add")
    @RequiresPermissions("AID:EMERGENCY_HELP_INSERT")
    @Token(save = true)
    public String addHtmlEmergencyHelp(Model model) throws Exception {
        Map<String, Object> aid = Maps.newHashMapWithExpectedSize(2);
        model.addAttribute("aid", setStudentYearSemester(aid, "BAF_YEAR", "BAF_SEMESTER"));
        return "admin/aid/emergencyHelp/addAndEdit";
    }


    @PostMapping("/emergencyHelp/add")
    @RequiresPermissions("AID:EMERGENCY_HELP_INSERT")
    @SystemControllerLog(useType = UseType.USE, event = "添加应急求助")
    @Token(remove = true)
    @Validate("BUS_AID_FINANCIALLY")
    @ResponseBody
    public ResultState addEmergencyHelp(@RequestParam Map<String, Object> mapParam) throws Exception {
        //流程
        mapParam.put("BUS_PROCESS", Process.AID.toString());
        mapParam.put("BUS_PROCESS2", Process.AID_EMERGENCY_HELP.toString());
        //类型
        mapParam.put("BAF_TYPE", AidType.EMERGENCY_HELP.toString());
        Map<String, Object> resultMap = aidFinanciallyService.insertAndUpdateAidFinancially(mapParam);

        return resultState(resultMap);
    }


    @GetMapping("/emergencyHelp/update/{ID}")
    @RequiresPermissions("AID:EMERGENCY_HELP_UPDATE")
    public String updateHtmlEmergencyHelp(Model model, @PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        model.addAttribute("aid", aidFinanciallyService.selectAidFinancially(mapParam));
        return "admin/aid/emergencyHelp/addAndEdit";
    }

    @PutMapping("/emergencyHelp/update")
    @RequiresPermissions("AID:EMERGENCY_HELP_UPDATE_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改应急求助")
    @Validate("BUS_AID_FINANCIALLY")
    @ResponseBody
    public ResultState updateEmergencyHelp(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = aidFinanciallyService.insertAndUpdateAidFinancially(mapParam);
        return resultState(resultMap);
    }

    @DeleteMapping("/emergencyHelp/delete/{ID}")
    @RequiresPermissions("AID:EMERGENCY_HELP_DELETE")
    @SystemControllerLog(useType = UseType.USE, event = "删除应急求助")
    @ResponseBody
    public ResultState deleteEmergencyHelp(@PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> resultMap = aidFinanciallyService.deleteAidFinancially(mapParam);
        return resultState(resultMap);
    }

    @PostMapping("/emergencyHelp/import")
    @RequiresPermissions("AID:EMERGENCY_HELP_IMPORT")
    @SystemControllerLog(useType = UseType.USE, event = "导入应急求助")
    @ResponseBody
    public ResultState importEmergencyHelp(MultipartFile excelFile) throws Exception {
        //最多等待10分钟10分钟后解锁
        return fairLock("importEmergencyHelp", 600, 600, () -> {
            Map<String, Object> resultMap = aidFinanciallyService.importEmergencyHelp(excelFile);
            return resultState(resultMap);
        });
    }

    /******************     国家奖学金   *****************/

    @GetMapping("/nationalScholarship/add")
    @RequiresPermissions("AID:NATIONAL_SCHOLARSHIP_INSERT")
    @Token(save = true)
    public String addHtmlNationalScholarship(Model model) throws Exception {
        Map<String, Object> aid = Maps.newHashMapWithExpectedSize(2);
        model.addAttribute("aid", setStudentYearSemester(aid, "BAF_YEAR", "BAF_SEMESTER"));
        return "admin/aid/nationalScholarship/addAndEdit";
    }


    @PostMapping("/nationalScholarship/add")
    @RequiresPermissions("AID:NATIONAL_SCHOLARSHIP_INSERT")
    @SystemControllerLog(useType = UseType.USE, event = "添加国家奖学金")
    @Token(remove = true)
    @Validate({"BUS_AID_FINANCIALLY", "BUS_AID_NATIONAL_SCHOLARSHIP"})
    @ResponseBody
    public ResultState addNationalScholarship(@RequestParam Map<String, Object> mapParam) throws Exception {
        //流程
        mapParam.put("BUS_PROCESS", Process.AID.toString());
        mapParam.put("BUS_PROCESS2", Process.AID_NATIONAL_SCHOLARSHIP.toString());
        //类型
        mapParam.put("BAF_TYPE", AidType.NATIONAL_SCHOLARSHIP.toString());
        Map<String, Object> resultMap = aidFinanciallyService.insertAndUpdateAidFinancially(mapParam);

        return resultState(resultMap);
    }


    @GetMapping("/nationalScholarship/update/{ID}")
    @RequiresPermissions("AID:NATIONAL_SCHOLARSHIP_UPDATE")
    public String updateHtmlNationalScholarship(Model model, @PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> aid = aidFinanciallyService.selectAidFinancially(mapParam);
        mapParam.clear();
        mapParam.put("BAF_ID", aid.get("ID"));
        Map<String, Object> ns = aidFinanciallyService.selectNationalScholarship(mapParam);

        model.addAttribute("aid", aid);
        model.addAttribute("ns", ns);
        return "admin/aid/nationalScholarship/addAndEdit";
    }

    @PutMapping("/nationalScholarship/update")
    @RequiresPermissions("AID:NATIONAL_SCHOLARSHIP_UPDATE_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改国家奖学金")
    @Validate({"BUS_AID_FINANCIALLY", "BUS_AID_NATIONAL_SCHOLARSHIP"})
    @ResponseBody
    public ResultState updateNationalScholarship(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = aidFinanciallyService.insertAndUpdateAidFinancially(mapParam);
        return resultState(resultMap);
    }

    @DeleteMapping("/nationalScholarship/delete/{ID}")
    @RequiresPermissions("AID:NATIONAL_SCHOLARSHIP_DELETE")
    @SystemControllerLog(useType = UseType.USE, event = "删除国家奖学金")
    @ResponseBody
    public ResultState deleteNationalScholarship(@PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> resultMap = aidFinanciallyService.deleteAidFinancially(mapParam);
        return resultState(resultMap);
    }

    @PostMapping("/nationalScholarship/import")
    @RequiresPermissions("AID:NATIONAL_SCHOLARSHIP_IMPORT")
    @SystemControllerLog(useType = UseType.USE, event = "导入国家奖学金")
    @ResponseBody
    public ResultState importNationalScholarship(MultipartFile excelFile) throws Exception {
        //最多等待10分钟10分钟后解锁
        return fairLock("importNationalScholarship", 600, 600, () -> {
            Map<String, Object> resultMap = aidFinanciallyService.importNationalScholarship(excelFile);
            return resultState(resultMap);
        });
    }

    /******************     国家助学金   *****************/

    @GetMapping("/nationalGrants/add")
    @RequiresPermissions("AID:NATIONAL_GRANTS_INSERT")
    @Token(save = true)
    public String addHtmlNationalGrants(Model model) throws Exception {
        Map<String, Object> aid = Maps.newHashMapWithExpectedSize(2);
        model.addAttribute("aid", setStudentYearSemester(aid, "BAF_YEAR", "BAF_SEMESTER"));
        return "admin/aid/nationalGrants/addAndEdit";
    }


    @PostMapping("/nationalGrants/add")
    @RequiresPermissions("AID:NATIONAL_GRANTS_INSERT")
    @SystemControllerLog(useType = UseType.USE, event = "添加国家助学金")
    @Token(remove = true)
    @Validate({"BUS_AID_FINANCIALLY", "BUS_AID_NATIONAL_GRANTS"})
    @ResponseBody
    public ResultState addNationalGrants(@RequestParam Map<String, Object> mapParam) throws Exception {
        //流程
        mapParam.put("BUS_PROCESS", Process.AID.toString());
        mapParam.put("BUS_PROCESS2", Process.AID_NATIONAL_GRANTS.toString());
        //类型
        mapParam.put("BAF_TYPE", AidType.NATIONAL_GRANTS.toString());
        Map<String, Object> resultMap = aidFinanciallyService.insertAndUpdateAidFinancially(mapParam);

        return resultState(resultMap);
    }


    @GetMapping("/nationalGrants/update/{ID}")
    @RequiresPermissions("AID:NATIONAL_GRANTS_UPDATE")
    public String updateHtmlNationalGrants(Model model, @PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> aid = aidFinanciallyService.selectAidFinancially(mapParam);
        mapParam.clear();
        mapParam.put("BAF_ID", aid.get("ID"));
        Map<String, Object> ng = aidFinanciallyService.selectNationalGrants(mapParam);

        model.addAttribute("aid", aid);
        model.addAttribute("ng", ng);
        return "admin/aid/nationalGrants/addAndEdit";
    }

    @PutMapping("/nationalGrants/update")
    @RequiresPermissions("AID:NATIONAL_GRANTS_UPDATE_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改国家助学金")
    @Validate({"BUS_AID_FINANCIALLY", "BUS_AID_NATIONAL_GRANTS"})
    @ResponseBody
    public ResultState updateNationalGrants(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = aidFinanciallyService.insertAndUpdateAidFinancially(mapParam);
        return resultState(resultMap);
    }

    @DeleteMapping("/nationalGrants/delete/{ID}")
    @RequiresPermissions("AID:NATIONAL_GRANTS_DELETE")
    @SystemControllerLog(useType = UseType.USE, event = "删除国家助学金")
    @ResponseBody
    public ResultState deleteNationalGrants(@PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> resultMap = aidFinanciallyService.deleteAidFinancially(mapParam);
        return resultState(resultMap);
    }

    @PostMapping("/nationalGrants/import")
    @RequiresPermissions("AID:NATIONAL_GRANTS_IMPORT")
    @SystemControllerLog(useType = UseType.USE, event = "导入国家助学金")
    @ResponseBody
    public ResultState importNationalGrants(MultipartFile excelFile) throws Exception {
        //最多等待10分钟10分钟后解锁
        return fairLock("importNationalGrants", 600, 600, () -> {
            Map<String, Object> resultMap = aidFinanciallyService.importNationalGrants(excelFile);
            return resultState(resultMap);
        });
    }
}
