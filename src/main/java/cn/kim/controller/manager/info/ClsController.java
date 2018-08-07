package cn.kim.controller.manager.info;

import cn.kim.common.annotation.SystemControllerLog;
import cn.kim.common.annotation.Token;
import cn.kim.common.annotation.Validate;
import cn.kim.common.eu.UseType;
import cn.kim.controller.manager.BaseController;
import cn.kim.entity.CustomParam;
import cn.kim.entity.ResultState;
import cn.kim.service.ClsService;
import com.google.common.collect.Maps;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/8/6
 * 班级管理
 */
@Controller
@RequestMapping("/admin/cls")
public class ClsController extends BaseController {

    @Autowired
    private ClsService clsService;

    /**
     * 根据系部获取对应的班级
     *
     * @param mode   1 值 2 名称
     * @param BDM_ID
     * @return
     * @throws Exception
     */
    @PostMapping("/department/{mode}")
    @ResponseBody
    public List<CustomParam> add(@PathVariable int mode, String BDM_ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("BDM_ID", "BDM_ID");
        List<Map<String, Object>> classList = clsService.selectClassList(mapParam);

        List<CustomParam> resultList = new ArrayList<>();
        classList.forEach(cls -> {
            CustomParam customParam = new CustomParam();
            customParam.setEncrypt(true);
            if (mode == 1) {
                customParam.setKey(toString(cls.get("BC_NAME")));
                customParam.setValue(toString(cls.get("ID")));
            } else {
                customParam.setKey(toString(cls.get("ID")));
                customParam.setValue(toString(cls.get("BC_NAME")));
            }
        });

        return resultList;
    }

    @GetMapping("/add")
    @RequiresPermissions("INFO:CLASS_INSERT")
    @Token(save = true)
    public String addHtml(Model model) throws Exception {
        return "admin/info/cls/addAndEdit";
    }

    @PostMapping("/add")
    @RequiresPermissions("INFO:CLASS_INSERT")
    @SystemControllerLog(useType = UseType.USE, event = "添加班级")
    @Token(remove = true)
    @Validate(value = "BUS_CLASS", required = true)
    @ResponseBody
    public ResultState add(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = clsService.insertAndUpdateClass(mapParam);

        return resultState(resultMap);
    }


    @GetMapping("/update/{ID}")
    @RequiresPermissions("INFO:CLASS_UPDATE")
    public String updateHtml(Model model, @PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        model.addAttribute("cls", clsService.selectClass(mapParam));
        return "admin/info/cls/addAndEdit";
    }

    @PutMapping("/update")
    @RequiresPermissions("INFO:CLASS_UPDATE_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改班级")
    @Validate(value = "BUS_CLASS", required = true)
    @ResponseBody
    public ResultState update(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = clsService.insertAndUpdateClass(mapParam);
        return resultState(resultMap);
    }

    @DeleteMapping("/delete/{ID}")
    @RequiresPermissions("INFO:CLASS_DELETE")
    @SystemControllerLog(useType = UseType.USE, event = "删除班级")
    @ResponseBody
    public ResultState delete(@PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> resultMap = clsService.deleteClass(mapParam);
        return resultState(resultMap);
    }

}
