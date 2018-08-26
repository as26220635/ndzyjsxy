package cn.kim.common.tag;

import cn.kim.common.attr.Constants;
import cn.kim.service.MenuService;
import cn.kim.common.attr.Constants;
import cn.kim.common.sequence.Sequence;
import cn.kim.service.MenuService;
import cn.kim.util.*;
import com.google.common.collect.Maps;
import com.google.common.collect.Sets;
import lombok.Getter;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.tags.RequestContextAwareTag;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;
import javax.xml.soap.Text;
import java.util.*;

/**
 * Created by 余庚鑫 on 2018/3/29
 * 按钮
 */
@Setter
@Getter
public class Button extends BaseTagSupport {
    /**
     * ajax开始的时候不能点击 结束ajax恢复
     */
    public static Set<String> BTN_ID_AJAX_CLOSE = Sets.newHashSet("save", "cache");

    private MenuService menuService;

    private String contextPath;

    /**
     * 菜单ID
     */
    private String smId = "";
    /**
     * 按钮类型 0 顶部按钮 1 列表按钮
     */
    private int type = 0;

    private boolean back = true;

    @Override
    protected int doStartTagInternal() throws Exception {
        this.contextPath = toString(SessionUtil.get(Constants.SESSION_SERVLET_PATH));
        if (ValidateUtil.isEmpty(this.contextPath)) {
            return SKIP_BODY;
        }
        if (this.contextPath.startsWith("/")) {
            this.contextPath = this.contextPath.substring(1, this.contextPath.length());
        }
        //获取bean
        this.menuService = this.getRequestContext().getWebApplicationContext().getBean(MenuService.class);
        //拿到当前访问的连接
        //查询菜单列表
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(3);
        if (!isEmpty(smId)) {
            mapParam.put("ID", CommonUtil.idDecrypt(smId));
        }
        mapParam.put("SM_URL", this.contextPath);
        Map<String, Object> menu = this.menuService.selectMenu(mapParam);
        if (ValidateUtil.isEmpty(menu) || ValidateUtil.isEmpty(menu.get("SM_CODE")) || !AuthcUtil.isPermitted(toString(menu.get("SM_CODE")))) {
            return SKIP_BODY;
        }
        //查询菜单
        //查询顶部操作按钮
        mapParam.clear();
        mapParam.put("SM_ID", menu.get("ID"));
        mapParam.put("SO_ID", AuthcUtil.getCurrentUser().getId());
        mapParam.put("SB_TYPE", type);
        List<Map<String, Object>> buttons = menuService.selectOperatorNowMenu(mapParam);

        if (!ValidateUtil.isEmpty(buttons)) {
            //根据权限过滤按钮 返回不过滤
            buttons.removeIf(map -> !"RETURN".equals(toString(map.get("SB_CODE"))) && !AuthcUtil.isPermitted(toString(menu.get("SM_CODE")) + "_" + toString(map.get("SB_CODE"))));
            buttons.forEach(button -> {
                //有返回了就隐藏放回
                if ("RETURN".equals(toString(button.get("SB_CODE")))) {
                    back = false;
                    return;
                }
            });
        }


        if (type == 0) {
            //顶部按钮
            return top(pageContext.getOut(), buttons);
        } else if (type == 1) {
            //列表按钮
            return list(pageContext.getOut(), buttons);
        }

        return SKIP_BODY;
    }

    /**
     * 清除参数
     *
     * @return
     * @throws JspException
     */
    @Override
    public int doEndTag() throws JspException {
        smId = "";
        type = 0;
        back = true;
        return super.doEndTag();
    }

    /**
     * 顶部按钮
     *
     * @param out
     * @param buttons
     * @return
     */
    public int top(JspWriter out, List<Map<String, Object>> buttons) {
        try {
            StringBuilder builder = new StringBuilder();

            if (isBack()) {
                builder.append("<button type='button' class='btn btn-warning' onclick='backHtml();'><i class='mdi mdi-keyboard-return'></i>返回</button>");
            }

            if (!isEmpty(buttons)) {
                buttons.forEach(button -> {
                    //额外的class
                    String additionalClass = additionalClass(button.get("SB_BUTTONID"), button.get("SB_EXTEND_CLASS"));
                    builder.append("<button id='" + button.get("SB_BUTTONID") + "' type='button' class='" + button.get("SB_CLASS") + additionalClass + "' onclick='" + button.get("SB_FUNC") + "'><i class='" + button.get("SB_ICON") + "'></i>" + button.get("SB_NAME") + "</button>");
                });
            }

            out.print(builder.toString());
        } catch (Exception e) {
            e.printStackTrace();
            return SKIP_BODY;
        }
        return EVAL_BODY_INCLUDE;
    }

    /**
     * 列表按钮
     *
     * @param out
     * @param buttons
     * @return
     */
    public int list(JspWriter out, List<Map<String, Object>> buttons) {
        try {
            StringBuilder builder = new StringBuilder();

            if (!isEmpty(buttons)) {
                buttons.forEach(button -> {
//                builder.append("<button id='" + button.get("SB_BUTTONID") + "' type='button' class='" + button.get("SB_CLASS") + "' onclick='" + button.get("SB_FUNC") + "'><i class='" + button.get("SB_ICON") + "'></i>" + button.get("SB_NAME") + "</button>");
                });
            }

            out.print(builder.toString());
        } catch (Exception e) {
            e.printStackTrace();
            return SKIP_BODY;
        }
        return EVAL_BODY_INCLUDE;
    }

    /**
     * 返回额外的class
     *
     * @param SB_BUTTONID
     * @param SB_EXTEND_CLASS
     * @return
     */
    public static String additionalClass(Object SB_BUTTONID, Object SB_EXTEND_CLASS) {
        String additionalClass = "";
        //在ajax时候禁止点击
        if (Button.BTN_ID_AJAX_CLOSE.contains(TextUtil.toString(SB_BUTTONID))) {
            additionalClass = " model-ok ";
        }
        if (!ValidateUtil.isEmpty(SB_EXTEND_CLASS)) {
            additionalClass += " " + TextUtil.toString(SB_EXTEND_CLASS) + " ";
        }
        return additionalClass;
    }
}

