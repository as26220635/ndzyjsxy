package cn.kim.common.tag;

import cn.kim.util.HttpUtil;
import cn.kim.util.ValidateUtil;
import lombok.Getter;
import lombok.Setter;
import org.jetbrains.annotations.Nullable;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/3/27
 * 点击弹出树菜单
 */
@Setter
@Getter
public class TreeBox extends BaseTagSupport {
    /**
     * 默认选中的值
     */
    private String custom = "";
    private String id = "";
    private String name = "";
    private String value = "";
    private String nameValue = "";
    private String url = "";
    private String title = "";
    private String sdtId = "";
    private String notId = "";
    /**
     * 字典
     */
    private String sdtCode = "";
    /**
     * 小：modal-sm 大：modal-lg
     */
    private String modelSize = "";
    /**
     * 是否单选
     */
    private boolean single = true;
    /**
     * 是否必填
     */
    private boolean required;

    /**
     * url传递参数
     */
    @Nullable
    private String requestParams;

    @Override
    public int doStartTagInternal() throws Exception {
        if (isEmpty(name)) {
            name = uuid();
        }
        if (!ValidateUtil.isEmpty(custom)) {
            Map<String, Object> customMap = customResolve(custom);
            id = toString(customMap.get("id"));
            required = toBoolean(customMap.get("required"));
        }
        //字典解析
        if (!isEmpty(sdtCode)) {
            url = HttpUtil.getContextPath() + "admin/dict/info/treeBox?SDT_CODE=" + sdtCode;
        }
        if (single) {
            return single(pageContext.getOut());
        } else {
            return SKIP_BODY;
        }
    }

    @Override
    public int doEndTag() throws JspException {
        //清除参数
        custom = "";
        id = "";
        name = "";
        value = "";
        nameValue = "";
        url = "";
        title = "";
        sdtId = "";
        notId = "";
        custom = "";
        sdtCode = "";
        modelSize = "";
        single = true;
        required = false;
        requestParams = null;
        return super.doEndTag();
    }

    /**
     * 单选
     *
     * @param out
     * @return
     */
    public int single(JspWriter out) {
        try {
            StringBuilder builder = new StringBuilder();

            builder.append("<input type='text' class='form-control' id='" + name + "' name='" + name + "' value='" + nameValue + "' readonly " + (required ? "required" : "") + " data-bv-trigger='focus'><input type='hidden' class='form-control' id='" + id + "' name='" + id + "' value='" + value + "'>");

            String func = "<script>$('#" + name + "').selectInput(function () {" +
                    "        treeBox.init({" +
                    "            title: '" + title + "'," +
                    "            selectMode: treeBox.mode.SINGLE," +
                    "            modelSize: '" + modelSize + "'," +
                    "            url: '" + url + "'," +
                    "            searchParams: {" +
                    "                ID: $('#" + id + "').val()," +
                    "                SDI_CODE: $('#" + id + "').val()," +
                    "                SDT_ID: '" + sdtId + "'," +
                    "                NOT_ID: '" + notId + "'," +
                    //请求传递参数
                    toString(requestParams) +
                    "            }," +
                    "            isConfirm: true," +
                    "            confirm: function ($model, nodes) {" +
                    "                if (nodes.length > 0) {" +
                    "                    $('#" + id + "').val(nodes[0].sdiCode != '' ? nodes[0].sdiCode : nodes[0].id);" +
                    "                    $('#" + name + "').val(nodes[0].text);" +
                    "                } else {" +
                    "                    $('#" + id + "').val('');" +
                    "                    $('#" + name + "').val('');" +
                    "                }" +
                    "                $('#" + id + "').change();" +
                    "                $('#" + name + "').focus();" +
                    "                model.hide($model);" +
                    "            }" +
                    "        });" +
                    "    });</script>";

            builder.append(func);
            out.print(builder.toString());
        } catch (Exception e) {
            e.printStackTrace();
            return SKIP_BODY;
        }
        return EVAL_BODY_INCLUDE;
    }

}

