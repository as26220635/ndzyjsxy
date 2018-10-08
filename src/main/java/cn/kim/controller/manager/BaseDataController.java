package cn.kim.controller.manager;

import cn.kim.common.annotation.NotEmptyLogin;
import cn.kim.common.annotation.SystemControllerLog;
import cn.kim.common.attr.Attribute;
import cn.kim.common.attr.MagicValue;
import cn.kim.common.eu.ButtonType;
import cn.kim.common.eu.ProcessStatus;
import cn.kim.common.eu.UseType;
import cn.kim.common.tag.Button;
import cn.kim.entity.DataTablesView;
import cn.kim.entity.Tree;
import cn.kim.entity.TreeState;
import cn.kim.exception.CustomException;
import cn.kim.service.*;
import cn.kim.tools.ExportExcelTool;
import cn.kim.util.CommonUtil;
import cn.kim.util.FuncUtil;
import cn.kim.util.HttpRequestDeviceUtils;
import cn.kim.util.TextUtil;
import com.google.common.collect.Maps;
import com.google.common.collect.Sets;
import lombok.extern.log4j.Log4j2;
import org.apache.shiro.authz.UnauthorizedException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.util.*;

/**
 * Created by 余庚鑫 on 2018/3/21
 * 基础数据CONTROLLER
 * 通用列表和通用UI
 */
@Controller
@Log4j2
public class BaseDataController extends BaseController {

    @Autowired
    private MenuService menuService;

    @Autowired
    private ConfigureService configureService;

    @Autowired
    private DataGridService dataGridService;

    @Autowired
    private FormatService formatService;

    @Autowired
    private ProcessService processService;

    /**
     * 预览图片
     *
     * @return
     */
    @GetMapping("/previewIcon")
    public String previewIcon() {
        return "admin/component/data/previewIcon";
    }

    /**
     * 查询配置列表
     *
     * @param ID    SM_ID  菜单ID
     * @param model
     * @return
     * @throws Exception
     */
    @GetMapping("/admin/dataGrid/{ID}")
    @SystemControllerLog(useType = UseType.SEE, isDataGrid = true, event = "查看列表")
    public String dataGrid(@PathVariable("ID") String ID, @RequestParam Map<String, Object> extra, Model model, HttpServletRequest request) throws Exception {
        isInvalidKey(extra);
        try {
            Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(2);
            //查询菜单
            Map<String, Object> menu = menuService.queryMenuById(ID);
            //判断权限
            if (!isEmpty(menu.get("SM_CODE")) && !isPermitted(toString(menu.get("SM_CODE")))) {
                throw new UnauthorizedException("权限错误!");
            }
            String configureId = toString(menu.get("SC_ID"));

            if (isEmpty(configureId)) {
                throw new CustomException("配置管理ID为空!");
            }
            //查询配置列表
            Map<String, Object> configureMap = dataGridService.selectConfigureById(configureId);
            //配置列表
            Map<String, Object> configure = (Map<String, Object>) configureMap.get("configure");
            //查询字段
            List<Map<String, Object>> columnList = (List<Map<String, Object>>) configureMap.get("columnList");
            //查询搜索字段
            List<Map<String, Object>> searchList = (List<Map<String, Object>>) configureMap.get("searchList");
            //查询文件
            List<Map<String, Object>> fileList = (List<Map<String, Object>>) configureMap.get("fileList");
            //移除不显示的搜索字段
            if (!isEmpty(searchList)) {
                searchList.removeIf(map -> toInt(map.get("SCC_IS_VISIBLE")) == Attribute.STATUS_ERROR);
            }
            //是否是审核状态过滤
            searchList.forEach(search -> {
                if (toString(search.get("SCS_FIELD")).equals("SPS_AUDIT_STATUS")) {
                    //判断流程是否开启，查询根据流程大小类查询过滤
                    if (!isEmpty(menu.get("BUS_PROCESS"))) {
                        search.put("inValue", ProcessStatus.BACK + SERVICE_SPLIT +
                                ProcessStatus.START + SERVICE_SPLIT +
                                ProcessStatus.COMPLETE + SERVICE_SPLIT +
                                dataGridService.selectProcessStepGroupByStatus(toString(menu.get("BUS_PROCESS")), toString(menu.get("BUS_PROCESS2")))
                        );
                    }
                }
            });
            //导出字段
            List<Tree> exportList = new LinkedList<>();
            columnList.forEach(column -> {
                Object SCC_IS_EXPORT = column.get("SCC_IS_EXPORT");
                //是否导出列
                if (!isEmpty(SCC_IS_EXPORT) && toInt(SCC_IS_EXPORT) == STATUS_SUCCESS) {
                    //不是操作列
                    if (isEmpty(column.get("SCC_IS_OPERATION")) || toInt(column.get("SCC_IS_OPERATION")) == STATUS_ERROR) {
                        Tree tree = new Tree();
                        tree.setId(toString(column.get("ID")));
                        tree.setText(toString(column.get("SCC_NAME")));

                        TreeState state = new TreeState();
                        //是否选中
                        state.setChecked(true);
                        //选中的设置打开
                        state.setExpanded(true);
                        //设置状态
                        tree.setState(state);

                        exportList.add(tree);
                    }
                }
            });
            //加密
            idEncrypt(exportList);

            //查询操作按钮
            mapParam.clear();
            mapParam.put("SM_ID", ID);
            mapParam.put("SO_ID", activeUser().getId());
            List<Map<String, Object>> buttons = menuService.selectOperatorNowMenu(mapParam);
            //分出列表菜单和顶部菜单
            List<Map<String, Object>> topButton = new LinkedList<>();
            List<Map<String, Object>> listButton = new LinkedList<>();
            buttons.forEach(button -> {
                int buttonType = toInt(button.get("SB_TYPE"));
                //额外的class
                String additionalClass = Button.additionalClass(button.get("SB_BUTTONID"), button.get("SB_EXTEND_CLASS"));
                if (!isEmpty(additionalClass)) {
                    button.put("SB_CLASS", button.get("SB_CLASS") + additionalClass);
                }
                if (ButtonType.TOP.getType() == buttonType) {
                    //顶部菜单
                    topButton.add(button);
                } else if (ButtonType.LIST.getType() == buttonType) {
                    //列表菜单
                    listButton.add(button);
                }
            });

            //拿到name字段
            if (!isEmpty(columnList)) {
                for (Map<String, Object> column : columnList) {
                    if (toString(column.get("SCC_FIELD")).toLowerCase().endsWith(MagicValue.NAME)) {
                        model.addAttribute("treeField", column.get("SCC_FIELD"));
                        break;
                    }
                }
            }

            model.addAttribute("MENU", menu);
            model.addAttribute("CONFIGURE", configure);
            model.addAttribute("SEARCH_LIST", searchList);
            model.addAttribute("COLUMN_LIST", columnList);
            model.addAttribute("EXPORT_LIST", TextUtil.toJSONString(exportList));
            model.addAttribute("FILE_LIST", fileList);
            model.addAttribute("TOP_BUTTON", topButton);
            model.addAttribute("LIST_BUTTON", listButton);
            model.addAttribute("BUTTON_SIZE", 1);
            //拿到左右固定列个数
            boolean isFixed = false;
            int leftFixedLength = toInt(configure.get("LEFT_FIXED_LENGTH"));
            int rightFixedLength = toInt(configure.get("RIGHT_FIXED_LENGTH"));
            if (leftFixedLength != 0 || rightFixedLength != 0) {
                //移动设备不开启固定列
                if (!HttpRequestDeviceUtils.isMobileDevice(request)) {
                    if (leftFixedLength > 0) {
                        //序号
                        leftFixedLength += 1;
                        //是否有选择框
                        if (isSuccess(configure.get("SC_IS_SELECT"))) {
                            leftFixedLength += 1;
                        }
                    }
                    isFixed = true;
                    model.addAttribute("LEFT_FIXED_LENGTH", leftFixedLength);
                    model.addAttribute("RIGHT_FIXED_LENGTH", rightFixedLength);

                }
            }
            model.addAttribute("IS_FIXED", isFixed);
            //URL额外参数
            model.addAttribute("EXTRA", extra);

            log.info("菜单:" + menu.get("SM_NAME") + ",视图:" + configure.get("SC_VIEW") + ",配置列表地址:" + configure.get("SC_JSP"));
            return toString(configure.get("SC_JSP"));
        } catch (Exception e) {
            e.printStackTrace();
            //权限错误
            if (e instanceof UnauthorizedException) {
                throw e;
            }
            //404跳转
            return return404(model);
        }
    }

    /**
     * 查询菜单列表数据
     *
     * @param ID       SYS_CONFIGURE id
     * @param mapParam
     * @return
     * @throws Exception
     */
    @GetMapping("/admin/dataGrid/data/{ID}")
    @ResponseBody
    public DataTablesView<?> dataGridData(@PathVariable("ID") String ID, @RequestParam Map<String, Object> mapParam) throws Exception {
        isInvalidKey(mapParam);
        mapParam.put("ID", ID);
        mapParam.put("SM_ID", mapParam.get("SM_ID"));
        DataTablesView<Map<String, Object>> dataTablesView = dataGridService.selectByMap(mapParam);
        dataTablesView.setDraw(toInt(mapParam.get("draw")));
        return dataTablesView;
    }

    /**
     * 查询树形菜单列表数据
     *
     * @param ID       SYS_CONFIGURE id
     * @param mapParam
     * @return
     * @throws Exception
     */
    @GetMapping("/admin/treeGrid/data/{ID}")
    @ResponseBody
    public List<Map<String, Object>> treeGridData(@PathVariable("ID") String ID, @RequestParam Map<String, Object> mapParam) throws Exception {
        isInvalidKey(mapParam);
        mapParam.put("ID", ID);
        mapParam.put("start", "0");
        mapParam.put("length", "-1");
        List<Map<String, Object>> trees = dataGridService.selectByMap(mapParam).getData();
        //父类ID设置
        trees.forEach(tree -> {
            Set<String> keys = new HashSet<>(tree.keySet());
            keys.forEach(key -> {
                String lowKey = key.toLowerCase();
                if (lowKey.contains(MagicValue.PARENT) && lowKey.contains(MagicValue.ID)) {
                    Object value = tree.get(key);
                    if (MagicValue.ZERO.equals(toString(value))) {
                        tree.put("parentId", null);
                    } else {
                        tree.put("parentId", value);
                    }
                }
            });
        });
        return trees;
    }

    /**
     * 导出列表菜单数据
     *
     * @param ID         菜单 id
     * @param COLUMN_IDS 需要导出的字段IDS
     * @return
     * @throws Exception
     */
    @GetMapping("/file/export/{ID}/{COLUMN_IDS}")
    @SystemControllerLog(useType = UseType.USE, isExport = true, event = "导出列表excel数据")
    public void export(@PathVariable("ID") String ID, @PathVariable("COLUMN_IDS") String COLUMN_IDS, @RequestParam Map<String, Object> mapParam, HttpServletResponse response) throws Exception {
        isInvalidKey(mapParam);

        //查询菜单
        Map<String, Object> menu = menuService.queryMenuById(ID);
        //判断权限
        if (!isEmpty(menu.get("SM_CODE")) && !isPermitted(toString(menu.get("SM_CODE")) + "_EXPORT")) {
            throw new UnauthorizedException("权限错误!");
        }
        String configureId = toString(menu.get("SC_ID"));

        if (isEmpty(configureId)) {
            throw new CustomException("配置管理ID为空!");
        }
        //查询配置列表
        Map<String, Object> configureMap = dataGridService.selectConfigureById(configureId);
        //查询字段
        List<Map<String, Object>> columnList = (List<Map<String, Object>>) configureMap.get("columnList");

        //拿到需要导出的字段
        Set<String> exportIds = Sets.newHashSet(COLUMN_IDS.split(SERVICE_SPLIT));
        //移除没有导出的字段
        columnList.removeIf(map -> !exportIds.contains(map.get("ID")));
        String[] titleArrays = new String[columnList.size()];
        String[] columnArrays = new String[columnList.size()];
        FuncUtil.forEach(columnList, (i, column) -> {
            titleArrays[i] = toString(column.get("SCC_NAME"));
            columnArrays[i] = toString(column.get("SCC_FIELD"));
        });

        //查询数据
        mapParam.put("ID", configureId);
        mapParam.put("SM_ID", ID);
        mapParam.put("start", "0");
        mapParam.put("length", "-1");
        List<Map<String, Object>> list = dataGridService.selectByMap(mapParam).getData();

        ExportExcelTool<List<Map<String, Object>>> exportExcel = new ExportExcelTool<>();
        //设置导出文件名称
        OutputStream out = getResponseOutputStream(response, getDate() + ":导出" + toString(menu.get("SM_NAME")) + Attribute.EXCEL_XLSX);

        exportExcel.exportExcelByColumn(toString(menu.get("SM_NAME")), titleArrays, columnArrays, list, out, null);

        log.info("导出:" + menu.get("SM_NAME") + ",字段:" + toString(columnArrays));
    }

    /**
     * tabs 标签通用页面
     *
     * @param extra
     * @param model
     * @return
     * @throws Exception
     */
    @GetMapping("/admin/tabs")
    public String tabs(@RequestParam Map<String, Object> extra, Model model) throws Exception {
        isInvalidKey(extra);
        String formatCode = toString(extra.get("SF_CODE"));
        try {
            if (isEmpty(formatCode)) {
                throw new CustomException("SF_CODE不能为空!");
            }
            //最外层的按钮ID,查询完成后移除
            Map<String, Object> menu = menuService.queryMenuById(toString(extra.get("SM_ID")));
            extra.remove("SM_ID");
            extra.remove("_pjax");
            extra.remove("_");

            Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
            //查询格式
            Map<String, Object> format = formatService.selectFormat(formatCode);
            if (isEmpty(format)) {
                throw new CustomException("格式唯一标识错误!");
            }
            //查询格式详细
            mapParam.clear();
            mapParam.put("SF_ID", format.get("ID"));
            List<Map<String, Object>> formatDetailList = formatService.selectFormatDetailList(mapParam);
            //移除没有权限的菜单
            formatDetailList.removeIf(map -> !isPermitted(toString(map.get("SM_CODE"))));
            //格式化URL
            formatDetailList.forEach(detail -> {
                String menuId = toString(detail.get("SM_ID"));
                String menuUrl = toString(detail.get("SM_URL"));
                String menuUrlParams = toString(detail.get("SM_URL_PARAMS"));

                extra.put("SM_ID", menuId);
                String extraParams = CommonUtil.mapToUrlParams(extra);

                //连接URL
                menuUrl = CommonUtil.getMenuUrlJoin(menuId, menuUrl, menuUrlParams);
                //连接自带额外参数
                menuUrl = CommonUtil.getUrlParamsJoin(menuUrl, extraParams);

                detail.put("SM_URL", menuUrl.startsWith("/") ? menuUrl.substring(1, menuUrl.length()) : menuUrl);
            });
            //查询菜单
            model.addAttribute("MENU", menu);
            model.addAttribute("TITLE", extra.get("TITLE"));
            model.addAttribute("SFD_LIST", formatDetailList);
            model.addAttribute("EXTRA", extra);
            return "/admin/component/ui/tabs";
        } catch (Exception e) {
            e.printStackTrace();
            //权限错误
            if (e instanceof UnauthorizedException) {
                throw e;
            }
            //404跳转
            return return404(model);
        }
    }

    /**
     * 文本比对
     *
     * @param oldValue
     * @param newValue
     * @param model
     * @return
     * @throws Exception
     */
    @GetMapping("/admin/diff")
    @NotEmptyLogin
    public String valueRecordLog(String oldValue, String newValue, Model model) throws Exception {
        model.addAttribute("oldValue", oldValue);
        model.addAttribute("newValue", newValue);
        return "admin/component/diff";
    }


}
