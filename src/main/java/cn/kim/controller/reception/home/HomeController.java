package cn.kim.controller.reception.home;

import cn.kim.util.HttpUtil;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.web.util.WebUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by 余庚鑫 on 2017/4/23.
 */
@Controller
@RequestMapping("/my_home")
public class HomeController {

    @GetMapping("/home")
    public String hoem(HttpServletRequest request, HttpServletResponse response) throws IOException {
        WebUtils.issueRedirect(request, response, HttpUtil.getManagerHomeUrl(), null, true);
        return "reception/myhome/home";
    }
}
