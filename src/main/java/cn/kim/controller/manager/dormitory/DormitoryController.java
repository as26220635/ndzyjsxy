package cn.kim.controller.manager.dormitory;

import cn.kim.common.annotation.SystemControllerLog;
import cn.kim.common.annotation.Token;
import cn.kim.common.annotation.Validate;
import cn.kim.common.attr.TableName;
import cn.kim.common.eu.UseType;
import cn.kim.controller.manager.BaseController;
import cn.kim.entity.DataTablesView;
import cn.kim.entity.ResultState;
import cn.kim.service.DormitoryService;
import com.google.common.collect.Maps;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * Created by 余庚鑫 on 2019/6/16
 * 宿舍管理
 */
@Controller
@RequestMapping("/admin/dormitory")
public class DormitoryController extends BaseController {

    @Autowired
    private DormitoryService dormitoryService;

    /*************  楼   ************/

    @GetMapping("/floor/add")
    @RequiresPermissions("DORMITORY:FLOOR_INSERT")
    @Token(save = true)
    public String addHtml(Model model) throws Exception {
        return "admin/dormitory/floor/addAndEdit";
    }

    @PostMapping("/floor/add")
    @RequiresPermissions("DORMITORY:FLOOR_INSERT")
    @SystemControllerLog(useType = UseType.USE, event = "添加楼")
    @Token(remove = true)
    @Validate(value = TableName.BUS_DORMITORY_FLOOR, required = true)
    @ResponseBody
    public ResultState add(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = dormitoryService.insertAndUpdateDormitoryFloor(mapParam);

        return resultState(resultMap);
    }


    @GetMapping("/floor/update/{ID}")
    @RequiresPermissions("DORMITORY:FLOOR_UPDATE")
    public String updateHtml(Model model, @PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        model.addAttribute("floor", dormitoryService.selectDormitoryFloor(mapParam));
        return "admin/dormitory/floor/addAndEdit";
    }

    @PutMapping("/floor/update")
    @RequiresPermissions("DORMITORY:FLOOR_UPDATE_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改楼")
    @Validate(value = TableName.BUS_DORMITORY_FLOOR, required = true)
    @ResponseBody
    public ResultState update(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = dormitoryService.insertAndUpdateDormitoryFloor(mapParam);
        return resultState(resultMap);
    }

    @DeleteMapping("/floor/delete/{ID}")
    @RequiresPermissions("DORMITORY:FLOOR_DELETE")
    @SystemControllerLog(useType = UseType.USE, event = "删除楼")
    @ResponseBody
    public ResultState delete(@PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> resultMap = dormitoryService.deleteDormitoryFloor(mapParam);
        return resultState(resultMap);
    }

    /*************  室   ************/

    @GetMapping("/room/add")
    @RequiresPermissions("DORMITORY:ROOM_INSERT")
    @Token(save = true)
    public String addHtmlRoom(String BDF_ID, Model model) throws Exception {
        model.addAttribute("BDF_ID", BDF_ID);
        return "admin/dormitory/room/addAndEdit";
    }

    @PostMapping("/room/add")
    @RequiresPermissions("DORMITORY:ROOM_INSERT")
    @SystemControllerLog(useType = UseType.USE, event = "添加室")
    @Token(remove = true)
    @Validate(value = TableName.BUS_DORMITORY_ROOM, required = true)
    @ResponseBody
    public ResultState addRoom(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = dormitoryService.insertAndUpdateDormitoryRoom(mapParam);

        return resultState(resultMap);
    }


    @GetMapping("/room/update/{ID}")
    @RequiresPermissions("DORMITORY:ROOM_UPDATE")
    public String updateHtmlRoom(Model model, @PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        model.addAttribute("room", dormitoryService.selectDormitoryRoom(mapParam));
        return "admin/dormitory/room/addAndEdit";
    }

    @PutMapping("/room/update")
    @RequiresPermissions("DORMITORY:ROOM_UPDATE_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改室")
    @Validate(value = TableName.BUS_DORMITORY_ROOM, required = true)
    @ResponseBody
    public ResultState updateRoom(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = dormitoryService.insertAndUpdateDormitoryRoom(mapParam);
        return resultState(resultMap);
    }

    @DeleteMapping("/room/delete/{ID}")
    @RequiresPermissions("DORMITORY:ROOM_DELETE")
    @SystemControllerLog(useType = UseType.USE, event = "删除室")
    @ResponseBody
    public ResultState deleteRoom(@PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> resultMap = dormitoryService.deleteDormitoryRoom(mapParam);
        return resultState(resultMap);
    }

    /*************  铺位   ************/

    @GetMapping("/berth/add")
    @RequiresPermissions("DORMITORY:BERTH_INSERT")
    @Token(save = true)
    public String addHtmlBerth(String BDR_ID, Model model) throws Exception {
        model.addAttribute("BDR_ID", BDR_ID);
        return "admin/dormitory/berth/addAndEdit";
    }

    @PostMapping("/berth/add")
    @RequiresPermissions("DORMITORY:BERTH_INSERT")
    @SystemControllerLog(useType = UseType.USE, event = "添加铺位")
    @Token(remove = true)
    @Validate(value = TableName.BUS_DORMITORY_BERTH, required = true)
    @ResponseBody
    public ResultState addBerth(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = dormitoryService.insertAndUpdateDormitoryBerth(mapParam);

        return resultState(resultMap);
    }


    @GetMapping("/berth/update/{ID}")
    @RequiresPermissions("DORMITORY:BERTH_UPDATE")
    public String updateHtmlBerth(Model model, @PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        model.addAttribute("berth", dormitoryService.selectDormitoryBerth(mapParam));
        return "admin/dormitory/berth/addAndEdit";
    }

    @PutMapping("/berth/update")
    @RequiresPermissions("DORMITORY:BERTH_UPDATE_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改铺位")
    @Validate(value = TableName.BUS_DORMITORY_BERTH, required = true)
    @ResponseBody
    public ResultState updateBerth(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = dormitoryService.insertAndUpdateDormitoryBerth(mapParam);
        return resultState(resultMap);
    }

    @DeleteMapping("/berth/delete/{ID}")
    @RequiresPermissions("DORMITORY:BERTH_DELETE")
    @SystemControllerLog(useType = UseType.USE, event = "删除铺位")
    @ResponseBody
    public ResultState deleteBerth(@PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> resultMap = dormitoryService.deleteDormitoryBerth(mapParam);
        return resultState(resultMap);
    }

    /**
     * 铺位列表
     * @param mapParam
     * @return
     */
    @GetMapping("/berth/list")
    @RequiresPermissions(value = {"DORMITORY:PERSONNEL"}, logical = Logical.OR)
    @ResponseBody
    public DataTablesView<?> selectDepartmentInstructor(@RequestParam Map<String, Object> mapParam) {
        DataTablesView<?> view = dormitoryService.selectDormitoryBerthList(mapParam);
        view.setDraw(toInt(mapParam.get("draw")));
        return view;
    }

    /*************  铺位人员   ************/

    @GetMapping("/personnel/add")
    @RequiresPermissions("DORMITORY:PERSONNEL_INSERT")
    @Token(save = true)
    public String addHtmlPersonnel(String BDR_ID, Model model) throws Exception {
        model.addAttribute("BDR_ID", BDR_ID);
        return "admin/dormitory/personnel/addAndEdit";
    }

    @PostMapping("/personnel/add")
    @RequiresPermissions("DORMITORY:PERSONNEL_INSERT")
    @SystemControllerLog(useType = UseType.USE, event = "添加铺位人员")
    @Token(remove = true)
    @Validate(value = TableName.BUS_DORMITORY_PERSONNEL, required = true)
    @ResponseBody
    public ResultState addPersonnel(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = dormitoryService.insertAndUpdateDormitoryPersonnel(mapParam);

        return resultState(resultMap);
    }

    @GetMapping("/personnel/update/{ID}")
    @RequiresPermissions("DORMITORY:PERSONNEL_UPDATE")
    public String updateHtmlPersonnel(Model model, @PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        model.addAttribute("personnel", dormitoryService.selectDormitoryPersonnel(mapParam));
        return "admin/dormitory/personnel/addAndEdit";
    }

    @PutMapping("/personnel/update")
    @RequiresPermissions("DORMITORY:PERSONNEL_UPDATE_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改铺位人员")
    @Validate(value = TableName.BUS_DORMITORY_PERSONNEL, required = true)
    @ResponseBody
    public ResultState updatePersonnel(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = dormitoryService.insertAndUpdateDormitoryPersonnel(mapParam);
        return resultState(resultMap);
    }

    @DeleteMapping("/personnel/delete/{ID}")
    @RequiresPermissions("DORMITORY:PERSONNEL_DELETE")
    @SystemControllerLog(useType = UseType.USE, event = "删除铺位人员")
    @ResponseBody
    public ResultState deletePersonnel(@PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> resultMap = dormitoryService.deleteDormitoryPersonnel(mapParam);
        return resultState(resultMap);
    }

}
