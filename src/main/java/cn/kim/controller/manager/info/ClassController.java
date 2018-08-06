package cn.kim.controller.manager.info;

import cn.kim.common.annotation.SystemControllerLog;
import cn.kim.common.annotation.Token;
import cn.kim.common.annotation.Validate;
import cn.kim.common.eu.UseType;
import cn.kim.controller.manager.BaseController;
import cn.kim.entity.ResultState;
import cn.kim.entity.Tree;
import cn.kim.service.ClassService;
import cn.kim.service.OperatorService;
import com.google.common.collect.Maps;
import com.sun.istack.internal.Nullable;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/7/8
 * 班级管理
 */
@Controller
@RequestMapping("/admin/class")
public class ClassController extends BaseController {

    @Autowired
    private ClassService classService;

    @Autowired
    private OperatorService operatorService;

    @GetMapping("/add")
    @RequiresPermissions("INFO:CLASS_INSERT")
    @Token(save = true)
    public String addHtml(Model model) throws Exception {
        return "admin/info/class/addAndEdit";
    }


    @PostMapping("/add")
    @RequiresPermissions("INFO:CLASS_INSERT")
    @SystemControllerLog(useType = UseType.USE, event = "添加班级")
    @Token(remove = true)
    @Validate(value = "BUS_CLASS", required = true)
    @ResponseBody
    public ResultState add(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = classService.insertAndUpdateClass(mapParam);

        return resultState(resultMap);
    }


    @GetMapping("/update/{ID}")
    @RequiresPermissions("INFO:CLASS_UPDATE")
    public String updateHtml(Model model, @PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        model.addAttribute("cls", classService.selectClass(mapParam));
        return "admin/info/class/addAndEdit";
    }

    @PutMapping("/update")
    @RequiresPermissions("INFO:CLASS_UPDATE_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改班级")
    @Validate(value = "BUS_CLASS", required = true)
    @ResponseBody
    public ResultState update(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = classService.insertAndUpdateClass(mapParam);
        return resultState(resultMap);
    }

    @DeleteMapping("/delete/{ID}")
    @RequiresPermissions("INFO:CLASS_DELETE")
    @SystemControllerLog(useType = UseType.USE, event = "删除班级")
    @ResponseBody
    public ResultState delete(@PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> resultMap = classService.deleteClass(mapParam);
        return resultState(resultMap);
    }

}
