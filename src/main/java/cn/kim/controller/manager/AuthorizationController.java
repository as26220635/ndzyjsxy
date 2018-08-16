package cn.kim.controller.manager;

import cn.kim.common.annotation.SystemControllerLog;
import cn.kim.common.annotation.Token;
import cn.kim.common.annotation.Validate;
import cn.kim.common.eu.UseType;
import cn.kim.entity.ResultState;
import cn.kim.entity.Tree;
import cn.kim.service.AuthorizationService;
import cn.kim.service.RoleService;
import com.google.common.collect.Maps;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/8/14
 * 授权
 */
@Controller
@RequestMapping("/admin/authorization")
public class AuthorizationController extends BaseController {

    @Autowired
    private AuthorizationService authorizationService;

    /**
     * 拿到授权节点数据
     *
     * @param mapParam
     * @return
     * @throws Exception
     */
    @GetMapping("/tree")
    @RequiresPermissions(value = {"INFO:DEPARTMENT_PERSONNEL_AUTHORIZATION","INFO:DIVISION_PERSONNEL_AUTHORIZATION"}, logical = Logical.OR)
    @ResponseBody
    public List<Tree> treeList(@RequestParam Map<String, Object> mapParam) throws Exception {
        List<Tree> treeList = authorizationService.selectAuthorizationTreeList(mapParam);
        return treeList;
    }

    /**
     * 更新菜单权限
     *
     * @param mapParam
     * @return
     * @throws Exception
     */
    @PutMapping("/update")
    @RequiresPermissions(value = {"INFO:DEPARTMENT_PERSONNEL_AUTHORIZATION","INFO:DIVISION_PERSONNEL_AUTHORIZATION"}, logical = Logical.OR)
    @SystemControllerLog(useType = UseType.USE, event = "授权用户查看权限")
    @ResponseBody
    public ResultState update(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = authorizationService.updateAuthorization(mapParam);
        return resultState(resultMap);
    }

}
