package cn.kim.common.tag;

import cn.kim.common.annotation.Validate;
import cn.kim.common.sequence.Sequence;
import cn.kim.util.TextUtil;
import cn.kim.util.ValidateUtil;
import lombok.Getter;
import lombok.Setter;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/3/31
 * 时间选择控件
 */
@Setter
@Getter
public class Datebox extends BaseTagSupport {
    private String custom = "";
    private String id = "";
    private String name = "";
    private String value = "";
    private String placeholder = "";
    /**
     * year: '1', month: '4', yearMonth: '2', yearMonthDay: '3', yearMonthDayNone: '5', datetimepicker: '6'
     */
    private int type = 1;
    /**
     * 是否要有清理的选项
     */
    private boolean clear;
    /**
     * 是否必填
     */
    private boolean required;
    /**
     * 是否显示学年
     */
    private boolean studentYear = true;

    @Override
    public int doStartTagInternal() throws Exception {

        if (!ValidateUtil.isEmpty(custom)) {
            Map<String, Object> customMap = customResolve(custom);
            id = toString(customMap.get("id"));
            name = toString(customMap.get("name"));
            required = toBoolean(customMap.get("required"));
        }
        return init(pageContext.getOut());
    }

    /**
     * 清除参数
     *
     * @return
     * @throws JspException
     */
    @Override
    public int doEndTag() throws JspException {
        custom = "";
        id = "";
        name = "";
        value = "";
        placeholder = "";
        type = 1;
        clear = false;
        required = false;
        studentYear = true;
        return super.doEndTag();
    }

    /**
     * 选择图标
     *
     * @param out
     * @return
     */
    public int init(JspWriter out) {
        try {
            StringBuilder builder = new StringBuilder();

            builder.append("<input " + toTagId(custom, id, name) + " type='text' class='form-control form-control-input-search' placeholder='" + placeholder + "' value='" + value + "'>");

            builder.append("<script>datepick.init({obj: $('#" + id + "'),model:" + getFormat(type) + ",clear: " + TextUtil.toString(clear) + "});</script>");
            builder.append("<script>$('#" + id + "').on('hide', function (e) {validator.fieldValidate($('#" + id + "').parents('form:first'), '" + id + "');});</script>");
            if (studentYear) {
                builder.append("<script>$('#" + id + "').on('hide', function (e) {if( " + type + "!= 1||$(this).val() == '' || $(this).val().indexOf('-') != -1){return;}$(this).val($(this).val() + '-' + (Number($(this).val()) + 1))});</script>");
            }

            out.print(builder.toString());
        } catch (Exception e) {
            e.printStackTrace();
            return SKIP_BODY;
        }
        return EVAL_BODY_INCLUDE;
    }

    /**
     * 获取格式化
     *
     * @param type
     * @return
     */
    private String getFormat(int type) {
        //year: '1', month: '4', yearMonth: '2', yearMonthDay: '3', yearMonthDayNone: '5', datetimepicker: '6'
        if (type == 1) {
            return "datepick.model.year";
        } else if (type == 2) {
            return "datepick.model.yearMonth";
        } else if (type == 3) {
            return "datepick.model.yearMonthDay";
        } else if (type == 4) {
            return "datepick.model.month";
        } else if (type == 5) {
            return "datepick.model.yearMonthDayNone";
        } else if (type == 6) {
            return "datepick.model.datetimepicker";
        }
        return "";
    }

}

