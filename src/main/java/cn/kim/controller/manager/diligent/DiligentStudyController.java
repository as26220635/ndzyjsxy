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


}
