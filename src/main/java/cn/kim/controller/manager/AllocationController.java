package cn.kim.controller.manager;

import cn.kim.common.annotation.SystemControllerLog;
import cn.kim.common.annotation.Token;
import cn.kim.common.annotation.Validate;
import cn.kim.common.eu.UseType;
import cn.kim.entity.ResultState;
import cn.kim.service.AllocationService;
import cn.kim.util.AllocationUtil;
import cn.kim.util.EmailUtil;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/5/22
 * 系统配置
 */
@Controller
@RequestMapping("/admin/allocation")
public class AllocationController extends BaseController {

    @Autowired
    private AllocationService allocationService;


    /****************************   邮箱管理    *****************************/

    @GetMapping("/email")
    @RequiresPermissions("SYSTEM:ALLOCATION_EMAIL")
    @SystemControllerLog(useType = UseType.USE, event = "查看邮箱配置")
    @Token(save = true)
    public String emailHome(Model model) throws Exception {
        //邮箱登录名
        model.addAttribute("EMAIL_USER", AllocationUtil.get("EMAIL_USER"));
        //邮箱授权码不是登录密码
        model.addAttribute("EMAIL_PASSWORD", AllocationUtil.get("EMAIL_PASSWORD"));
        //邮箱协议
        model.addAttribute("EMAIL_PROTOCOL", AllocationUtil.get("EMAIL_PROTOCOL"));
        //邮箱服务器地址
        model.addAttribute("EMAIL_HOST", AllocationUtil.get("EMAIL_HOST"));
        //邮箱服务器端口
        model.addAttribute("EMAIL_PORT", AllocationUtil.get("EMAIL_PORT"));
        //是否需要是否验证
        model.addAttribute("EMAIL_AUTH", AllocationUtil.get("EMAIL_AUTH"));
        //是否启用
        model.addAttribute("EMAIL_STATUS", AllocationUtil.get("EMAIL_STATUS"));
        //是否开启SSL加密
        model.addAttribute("EMAIL_SSL_ENABLE", AllocationUtil.get("EMAIL_SSL_ENABLE"));

        return "admin/system/allocation/email/home";
    }

    @PutMapping("/email")
    @RequiresPermissions("SYSTEM:ALLOCATION_EMAIL_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改邮箱配置")
    @Token(remove = true)
    @Validate("SYS_ALLOCATION")
    @ResponseBody
    public ResultState emailUpdate(@RequestParam Map<String, Object> mapParam) throws Exception {
        try {
            AllocationUtil.put("EMAIL_USER", mapParam.get("EMAIL_USER"));
            AllocationUtil.put("EMAIL_PASSWORD", mapParam.get("EMAIL_PASSWORD"));
            AllocationUtil.put("EMAIL_PROTOCOL", mapParam.get("EMAIL_PROTOCOL"));
            AllocationUtil.put("EMAIL_HOST", mapParam.get("EMAIL_HOST"));
            AllocationUtil.put("EMAIL_PORT", mapParam.get("EMAIL_PORT"));
            AllocationUtil.put("EMAIL_AUTH", mapParam.get("EMAIL_AUTH"));
            AllocationUtil.put("EMAIL_STATUS", mapParam.get("EMAIL_STATUS"));
            AllocationUtil.put("EMAIL_SSL_ENABLE", mapParam.get("EMAIL_SSL_ENABLE"));
        } catch (Exception e) {
            return resultError(e);
        }
        return resultSuccess("邮箱配置修改成功!", "修改邮箱配置为:" + toString(mapParam));
    }

    @PostMapping("/email/cache")
    @RequiresPermissions("SYSTEM:ALLOCATION_EMAIL_CACHE")
    @SystemControllerLog(useType = UseType.USE, event = "刷新邮箱配置缓存")
    @ResponseBody
    public ResultState emailCache() throws Exception {
        try {
            EmailUtil.init();
            return resultSuccess("刷新缓存成功!");
        } catch (Exception e) {
            return resultError("刷新缓存失败");
        }
    }

    @GetMapping("/fileInputTest")
    public String fileInputTest(Model model) throws Exception {
        model.addAttribute("tableId","fileInputTest");
        return "admin/system/allocation/fileInputTest";
    }

    /****************************   综合素质测评比例管理    *****************************/

    @GetMapping("/comprehensive")
    @RequiresPermissions("SYSTEM:ALLOCATION_COMPREHENSIVE")
    @SystemControllerLog(useType = UseType.USE, event = "查看综合素质测评比例")
    @Token(save = true)
    public String comprehensiveHome(Model model) throws Exception {
        //德育
        model.addAttribute("EDUCATION_PROPORTION", AllocationUtil.get("EDUCATION_PROPORTION", 30));
        //智育
        model.addAttribute("INTELLECTUAL_PROPORTION", AllocationUtil.get("INTELLECTUAL_PROPORTION", 60));
        //志愿者
        model.addAttribute("VOLUNTEER_PROPORTION", AllocationUtil.get("VOLUNTEER_PROPORTION", 10));

        return "admin/system/allocation/comprehensive/home";
    }

    @PutMapping("/comprehensive")
    @RequiresPermissions("SYSTEM:ALLOCATION_COMPREHENSIVE_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改综合素质测评比例")
    @Token(remove = true)
    @Validate("SYS_ALLOCATION")
    @ResponseBody
    public ResultState comprehensiveUpdate(@RequestParam Map<String, Object> mapParam) throws Exception {
        try {
            AllocationUtil.put("EDUCATION_PROPORTION", mapParam.get("EDUCATION_PROPORTION"));
            AllocationUtil.put("INTELLECTUAL_PROPORTION", mapParam.get("INTELLECTUAL_PROPORTION"));
            AllocationUtil.put("VOLUNTEER_PROPORTION", mapParam.get("VOLUNTEER_PROPORTION"));
        } catch (Exception e) {
            return resultError(e);
        }
        return resultSuccess("综合素质测评比例修改成功!", "修改综合素质测评比例为:" + toString(mapParam));
    }

    /****************************   迟到旷课处分配置管理    *****************************/

    @GetMapping("/punishment")
    @RequiresPermissions("SYSTEM:ALLOCATION_PUNISHMENT")
    @SystemControllerLog(useType = UseType.USE, event = "查看迟到旷课处分配置")
    @Token(save = true)
    public String punishmentHome(Model model) throws Exception {
        //迟到几节课算旷课
        model.addAttribute("LATE_PROPORTION", AllocationUtil.get("LATE_PROPORTION", 2));
        //旷课几节课算处分
        model.addAttribute("ABSENTEEISM_PROPORTION", AllocationUtil.get("ABSENTEEISM_PROPORTION", 40));

        return "admin/system/allocation/punishment/home";
    }

    @PutMapping("/punishment")
    @RequiresPermissions("SYSTEM:ALLOCATION_PUNISHMENT_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改迟到旷课处分配置")
    @Token(remove = true)
    @Validate("SYS_ALLOCATION")
    @ResponseBody
    public ResultState punishmentUpdate(@RequestParam Map<String, Object> mapParam) throws Exception {
        try {
            AllocationUtil.put("LATE_PROPORTION", mapParam.get("LATE_PROPORTION"));
            AllocationUtil.put("ABSENTEEISM_PROPORTION", mapParam.get("ABSENTEEISM_PROPORTION"));
        } catch (Exception e) {
            return resultError(e);
        }
        return resultSuccess("迟到旷课处分配置修改成功!", "修改迟到旷课处分配置为:" + toString(mapParam));
    }
}
