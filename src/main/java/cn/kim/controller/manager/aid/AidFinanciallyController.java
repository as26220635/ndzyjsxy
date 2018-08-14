package cn.kim.controller.manager.aid;

import cn.kim.common.annotation.SystemControllerLog;
import cn.kim.common.annotation.Token;
import cn.kim.common.annotation.Validate;
import cn.kim.common.attr.Attribute;
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

}
