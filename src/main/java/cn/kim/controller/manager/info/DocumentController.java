package cn.kim.controller.manager.info;

import cn.kim.common.annotation.SystemControllerLog;
import cn.kim.common.annotation.Token;
import cn.kim.common.annotation.Validate;
import cn.kim.common.eu.UseType;
import cn.kim.controller.manager.BaseController;
import cn.kim.entity.ResultState;
import cn.kim.service.DocumentService;
import cn.kim.util.CommonUtil;
import com.google.common.collect.Maps;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/9/4
 * 文件管理
 */
@Controller
@RequestMapping("/admin/document")
public class DocumentController extends BaseController {

    @Autowired
    private DocumentService documentService;

    @GetMapping("/add")
    @RequiresPermissions("INFO:DOCUMENT_INSERT")
    @Token(save = true)
    public String addHtml(Model model) throws Exception {
        //设置初始化ID
        setInsertId(model);
        return "admin/info/document/addAndEdit";
    }

    @PostMapping("/add")
    @RequiresPermissions("INFO:DOCUMENT_INSERT")
    @SystemControllerLog(useType = UseType.USE, event = "添加文件")
    @Token(remove = true)
    @Validate("BUS_DOCUMENT")
    @ResponseBody
    public ResultState add(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = documentService.insertAndUpdateDocument(mapParam);

        return resultState(resultMap);
    }


    @GetMapping("/update/{ID}")
    @RequiresPermissions("INFO:DOCUMENT_UPDATE")
    public String updateHtml(Model model, @PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        model.addAttribute("document", documentService.selectDocument(mapParam));
        return "admin/info/document/addAndEdit";
    }

    @PutMapping("/update")
    @RequiresPermissions("INFO:DOCUMENT_UPDATE_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改文件")
    @Validate("BUS_DOCUMENT")
    @ResponseBody
    public ResultState update(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = documentService.insertAndUpdateDocument(mapParam);
        return resultState(resultMap);
    }

    @GetMapping("/reply/{ID}")
    @RequiresPermissions("INFO:DOCUMENT_REPLY")
    public String replyHtml(Model model, @PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        model.addAttribute("document", documentService.selectDocument(mapParam));
        return "admin/info/document/reply";
    }

    @PutMapping("/reply")
    @RequiresPermissions("INFO:DOCUMENT_REPLY")
    @SystemControllerLog(useType = UseType.USE, event = "修改文件回复")
    @Validate("BUS_DOCUMENT")
    @ResponseBody
    public ResultState reply(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = documentService.insertAndUpdateDocument(mapParam);
        return resultState(resultMap);
    }

    @DeleteMapping("/delete/{ID}")
    @RequiresPermissions("INFO:DOCUMENT_DELETE")
    @SystemControllerLog(useType = UseType.USE, event = "删除文件")
    @ResponseBody
    public ResultState delete(@PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> resultMap = documentService.deleteDocument(mapParam);
        return resultState(resultMap);
    }

}
