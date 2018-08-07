package cn.kim.controller.manager;

import cn.kim.common.annotation.SystemControllerLog;
import cn.kim.common.annotation.Validate;
import cn.kim.common.eu.UseType;
import cn.kim.entity.ResultState;
import cn.kim.service.OperatorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Controller
@RequestMapping("/admin")
public class FirstController extends BaseController {

    @Autowired
    private OperatorService operatorService;

    @GetMapping("/editUser")
    public String queryUser(Model model) throws Exception {
        model.addAttribute("accountInfo", getAccountInfo());
        return "admin/system/first/editActiveUser";
    }


    @PostMapping("/editUser")
    @SystemControllerLog(useType = UseType.USE, event = "修改信息")
    @Validate("SYS_ACCOUNT_INFO")
    @ResponseBody
    public ResultState editUser(@RequestParam Map<String, Object> mapParam) throws Exception {
        String id = activeUser().getId();
        mapParam.put("ID", id);
        return fairLock(id, () -> {
            Map<String, Object> resultMap = operatorService.insertAndUpdateOperator(mapParam);
            return resultState(resultMap);
        });
    }


    /**
     * 后台修改密码
     *
     * @param model
     * @return
     * @throws Exception
     */
    @GetMapping("/editPwd")
    public String editPswdHtml(Model model) throws Exception {
        return "admin/system/first/editPwd";
    }

    /**
     * 前台修改密码
     *
     * @param model
     * @return
     * @throws Exception
     */
    @GetMapping("/editPwdR")
    public String editPswdR(Model model) throws Exception {
        return "admin/system/first/editPwdR";
    }


    @PostMapping("/editPwd")
    @SystemControllerLog(useType = UseType.USE, event = "修改密码")
    @ResponseBody
    public ResultState editPwd(@RequestParam Map<String, Object> mapParam) throws Exception {
        String id = activeUser().getId();
        mapParam.put("ID", id);
        return fairLock(id, () -> {
            Map<String, Object> resultMap = operatorService.updateOperatorPassword(mapParam);
            return resultState(resultMap);
        });
    }

}
