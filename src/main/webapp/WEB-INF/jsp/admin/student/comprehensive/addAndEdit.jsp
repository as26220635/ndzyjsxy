<%--
  Created by IntelliJ IDEA.
  User: 余庚鑫
  Date: 2018/3/27
  Time: 15:40
  To change this template use File | Settings | File Templates.
--%>
<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="box" id="boxContentDiv">
                <div class="box-header">
                    <div class="col-md-12 btn-group-header">
                        <s:button back="false"></s:button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="col-md-12">
                        <div class="box box-default">
                            <div class="box-body">
                                <form id="addAndEditForm" class="row">
                                    <input type="hidden" name="${SUBMIT_TOKEN_NAME}" value="${token}">
                                    <input type="hidden" name="ID" value="${comprehensive.ID}">
                                    <input type="hidden" name="BSC_EDUCATION_PROPORTION"
                                           value="${EDUCATION_PROPORTION}">
                                    <input type="hidden" name="BSC_INTELLECTUAL_PROPORTION"
                                           value="${INTELLECTUAL_PROPORTION}">
                                    <input type="hidden" name="BSC_VOLUNTEER_PROPORTION"
                                           value="${VOLUNTEER_PROPORTION}">
                                    <div class="form-group has-feedback">
                                        <label>学生:</label>
                                        <input type="hidden" ${fns:validField("BUS_STUDENT_COMPREHENSIVE", "BS_ID")}
                                               value="${comprehensive.BS_ID}">
                                        <input type="text"
                                               class="form-control" ${fns:validField("BUS_STUDENT_COMPREHENSIVE", "BS_NAME")}
                                               value="${comprehensive.BS_NAME}">
                                    </div>
                                    <div class="row">
                                        <div class="form-group has-feedback col-md-6">
                                            <label>学年:</label>
                                            <s:datebox
                                                    custom='${fns:validField("BUS_STUDENT_COMPREHENSIVE", "BSC_YEAR")}'
                                                    value="${comprehensive.BSC_YEAR}"></s:datebox>
                                        </div>
                                        <div class="form-group has-feedback col-md-6">
                                            <label>学期:</label>
                                            <s:combobox sdtCode="BUS_SEMESTER"
                                                        custom='${fns:validField("BUS_STUDENT_COMPREHENSIVE","BSC_SEMESTER")}'
                                                        value="${comprehensive.BSC_SEMESTER}"></s:combobox>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group has-feedback col-md-6">
                                            <label>总分:</label>
                                            <input type="text"
                                                   class="form-control" ${fns:validField("BUS_STUDENT_COMPREHENSIVE", "BSC_TOTAL")}
                                                   value="${comprehensive.BSC_TOTAL}" readonly>
                                        </div>
                                        <div class="form-group has-feedback col-md-6">
                                            <label>排名:</label>
                                            <input type="text"
                                                   class="form-control" ${fns:validField("BUS_STUDENT_COMPREHENSIVE", "BSC_RANK")}
                                                   value="${comprehensive.BSC_RANK}" readonly>
                                        </div>
                                    </div>
                                    <div id="educationDiv">
                                        <div class="box-header with-border"><h3 class="box-title">
                                            <b>德育${EDUCATION_PROPORTION}%</b></h3></div>
                                        <br/>
                                        <div class="row">
                                            <div class="form-group has-feedback col-md-3">
                                                <label>政治态度和表现10分:</label>
                                                <input type="number"
                                                       class="form-control" ${fns:validField("BUS_STUDENT_COMPREHENSIVE", "BSC_POLITICAL_ATTITUDE")}
                                                       value="${comprehensive.BSC_POLITICAL_ATTITUDE}" max="10">
                                            </div>
                                            <div class="form-group has-feedback col-md-3">
                                                <label>劳动态度和表现20分:</label>
                                                <input type="number"
                                                       class="form-control" ${fns:validField("BUS_STUDENT_COMPREHENSIVE", "BSC_LABOR_ATTITUDE")}
                                                       value="${comprehensive.BSC_LABOR_ATTITUDE}" max="20">
                                            </div>
                                            <div class="form-group has-feedback col-md-3">
                                                <label>遵纪守法10分:</label>
                                                <input type="number"
                                                       class="form-control" ${fns:validField("BUS_STUDENT_COMPREHENSIVE", "BSC_COMPLIANCE")}
                                                       value="${comprehensive.BSC_COMPLIANCE}" max="10">
                                            </div>
                                            <div class="form-group has-feedback col-md-3">
                                                <label>集体观念10分:</label>
                                                <input type="number"
                                                       class="form-control" ${fns:validField("BUS_STUDENT_COMPREHENSIVE", "BSC_COLLECTIVE")}
                                                       value="${comprehensive.BSC_COLLECTIVE}" max="10">
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="form-group has-feedback col-md-3">
                                                <label>文明礼貌15分:</label>
                                                <input type="number"
                                                       class="form-control" ${fns:validField("BUS_STUDENT_COMPREHENSIVE", "BSC_DECORUM")}
                                                       value="${comprehensive.BSC_DECORUM}" max="15">
                                            </div>
                                            <div class="form-group has-feedback col-md-3">
                                                <label>爱护公物15分:</label>
                                                <input type="number"
                                                       class="form-control" ${fns:validField("BUS_STUDENT_COMPREHENSIVE", "BSC_CARE")}
                                                       value="${comprehensive.BSC_CARE}" max="15">
                                            </div>
                                            <div class="form-group has-feedback col-md-3">
                                                <label>个人品质10分:</label>
                                                <input type="number"
                                                       class="form-control" ${fns:validField("BUS_STUDENT_COMPREHENSIVE", "BSC_PERSONAL_QUALITY")}
                                                       value="${comprehensive.BSC_PERSONAL_QUALITY}" max="10">
                                            </div>
                                            <div class="form-group has-feedback col-md-3">
                                                <label>服务精神10分:</label>
                                                <input type="number"
                                                       class="form-control" ${fns:validField("BUS_STUDENT_COMPREHENSIVE", "BSC_SERVICE_SPIRIT")}
                                                       value="${comprehensive.BSC_SERVICE_SPIRIT}" max="10">
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="form-group has-feedback col-md-3">
                                                <label>满勤分:</label>
                                                <input type="number"
                                                       class="form-control" ${fns:validField("BUS_STUDENT_COMPREHENSIVE", "BSC_FULL_WORK")}
                                                       value="${comprehensive.BSC_FULL_WORK}">
                                            </div>
                                            <div class="form-group has-feedback col-md-3">
                                                <label>奖励分:</label>
                                                <input type="number"
                                                       class="form-control" ${fns:validField("BUS_STUDENT_COMPREHENSIVE", "BSC_BONUS_POINTS")}
                                                       value="${comprehensive.BSC_BONUS_POINTS}">
                                            </div>
                                            <div class="form-group has-feedback col-md-3">
                                                <label>扣分:</label>
                                                <input type="number"
                                                       class="form-control" ${fns:validField("BUS_STUDENT_COMPREHENSIVE", "BSC_EDUCATION_DEDUCTION")}
                                                       value="${comprehensive.BSC_EDUCATION_DEDUCTION}">
                                            </div>
                                            <div class="form-group has-feedback col-md-3">
                                                <label>总分:</label>
                                                <input type="text"
                                                       class="form-control" ${fns:validField("BUS_STUDENT_COMPREHENSIVE", "BSC_EDUCATION_TOTAL")}
                                                       value="${comprehensive.BSC_EDUCATION_TOTAL}" readonly>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="form-group has-feedback col-md-3">
                                                <label>得分:</label>
                                                <input type="text"
                                                       class="form-control" ${fns:validField("BUS_STUDENT_COMPREHENSIVE", "BSC_EDUCATION_SCORE")}
                                                       value="${comprehensive.BSC_EDUCATION_SCORE}" readonly>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="intellectualDiv">
                                        <div class="box-header with-border"><h3 class="box-title">
                                            <b>智育${INTELLECTUAL_PROPORTION}%</b></h3></div>
                                        <br/>
                                        <div class="row">
                                            <div class="form-group has-feedback col-md-3">
                                                <label>学习成绩:</label>
                                                <input type="number"
                                                       class="form-control" ${fns:validField("BUS_STUDENT_COMPREHENSIVE", "BSC_ACADEMIC_RECORD")}
                                                       value="${comprehensive.BSC_ACADEMIC_RECORD}" max="100">
                                            </div>
                                            <div class="form-group has-feedback col-md-3">
                                                <label>奖励分:</label>
                                                <input type="number"
                                                       class="form-control" ${fns:validField("BUS_STUDENT_COMPREHENSIVE", "BSC_INTELLECTUAL_POINTS")}
                                                       value="${comprehensive.BSC_INTELLECTUAL_POINTS}">
                                            </div>
                                            <div class="form-group has-feedback col-md-3">
                                                <label>得分:</label>
                                                <input type="text"
                                                       class="form-control" ${fns:validField("BUS_STUDENT_COMPREHENSIVE", "BSC_INTELLECTUAL_SCORE")}
                                                       value="${comprehensive.BSC_INTELLECTUAL_SCORE}" readonly>
                                            </div>
                                            <div class="form-group has-feedback col-md-3">
                                                <label>排名:</label>
                                                <input type="text"
                                                       class="form-control" ${fns:validField("BUS_STUDENT_COMPREHENSIVE", "BSC_INTELLECTUAL_RANK")}
                                                       value="${comprehensive.BSC_INTELLECTUAL_RANK}" readonly>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="volunteerDiv">
                                        <div class="box-header with-border"><h3 class="box-title">
                                            <b>志愿者${VOLUNTEER_PROPORTION}%</b></h3></div>
                                        <br/>
                                        <div class="row">
                                            <div class="form-group has-feedback col-md-3">
                                                <label>总分:</label>
                                                <input type="number"
                                                       class="form-control" ${fns:validField("BUS_STUDENT_COMPREHENSIVE", "BSC_VOLUNTEER_TOTAL")}
                                                       value="${comprehensive.BSC_VOLUNTEER_TOTAL}" max="100">
                                            </div>
                                            <div class="form-group has-feedback col-md-3">
                                                <label>得分:</label>
                                                <input type="text"
                                                       class="form-control" ${fns:validField("BUS_STUDENT_COMPREHENSIVE", "BSC_VOLUNTEER_SCORE")}
                                                       value="${comprehensive.BSC_VOLUNTEER_SCORE}" readonly>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<script>
    setTimeout(function () {
        setMenuActive('admin-dataGrid-${MENU.SM_PARENTID}');
        <c:choose>
        <c:when test="${not empty comprehensive}">
        editMenuTitle('编辑-${BS_NAME}-' + getMenuTitle());
        </c:when>
        <c:otherwise>
        editMenuTitle('添加' + getMenuTitle());
        </c:otherwise>
        </c:choose>
    }, 50);

    //保存
    $('#save').click(function () {
        var $form = $('#addAndEditForm');
        //验证
        if (!validator.formValidate($form)) {
            demo.showNotify(ALERT_WARNING, VALIDATE_FAIL);
            return;
        }
        var params = packFormParams($form);

        ajax.put('${STUDENT_COMPREHENSIVE_INSERT_AND_UPDATE_URL}', params, function (data) {
            ajaxReturn.data(data, null, null, null, {
                success: function () {
                    backHtml();
                }
            });
        })
    });

    //计算
    //德育
    $('#educationDiv input').bind("input propertychange", function (event) {
        var val = 0;
        $('#educationDiv input[id!="BSC_EDUCATION_DEDUCTION"][id!="BSC_EDUCATION_TOTAL"][id!="BSC_EDUCATION_SCORE"]').each(function () {
            val += Number($(this).val());
        });
        //扣分
        val -= Number($('#BSC_EDUCATION_DEDUCTION').val());
        $('#BSC_EDUCATION_TOTAL').val(val);
        $('#BSC_EDUCATION_SCORE').val(toFixed(val * ${EDUCATION_PROPORTION/ 100})).change();
    });
    //智育
    $('#intellectualDiv input').bind("input propertychange", function (event) {
        var val = 0;
        $('#intellectualDiv input[id!="BSC_INTELLECTUAL_SCORE"][id!="BSC_INTELLECTUAL_RANK"]').each(function () {
            val += Number($(this).val());
        });
        $('#BSC_INTELLECTUAL_SCORE').val(toFixed(val * ${INTELLECTUAL_PROPORTION/ 100})).change();
    });
    //自愿者
    $('#volunteerDiv input').bind("input propertychange", function (event) {
        var val = 0;
        $('#volunteerDiv input[id!="BSC_VOLUNTEER_SCORE"]').each(function () {
            val += Number($(this).val());
        });
        $('#BSC_VOLUNTEER_SCORE').val(toFixed(val * ${VOLUNTEER_PROPORTION/ 100})).change();
    });
    //总分
    $('#BSC_EDUCATION_SCORE,#BSC_INTELLECTUAL_SCORE,#BSC_VOLUNTEER_SCORE').on('change', function () {
        var val = 0;
        $('#BSC_EDUCATION_SCORE,#BSC_INTELLECTUAL_SCORE,#BSC_VOLUNTEER_SCORE').each(function () {
            val += Number($(this).val());
        });
        $('#BSC_TOTAL').val(toFixed(val));
    });

    validator.init({
        //验证表单
        form: $('#addAndEditForm'),
    });

    //选择学生
    choiceBox.student({
        id: 'BS_ID',
        name: 'BS_NAME',
        url: '${STUDENT_LIST_URL}'
    });

    function toFixed(val) {
        return parseInt(val * 100) / 100;
        //四舍五入
        // return val.toFixed(2);
    }
</script>