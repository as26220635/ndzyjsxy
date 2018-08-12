<%--
  Created by IntelliJ IDEA.
  User: 余庚鑫
  Date: 2018/5/22
  Time: 23:48
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
                                <form id="addAndEditForm">
                                    <input type="hidden" name="${SUBMIT_TOKEN_NAME}" value="${token}">
                                    <div class="form-group has-feedback">
                                        <label>德育:</label>
                                        <input type="text"
                                               class="form-control" ${fns:validField("SYS_ALLOCATION", "EDUCATION_PROPORTION")}
                                               value="${EDUCATION_PROPORTION}">
                                    </div>
                                    <div class="form-group has-feedback">
                                        <label>智育:</label>
                                        <input type="text"
                                               class="form-control" ${fns:validField("SYS_ALLOCATION", "INTELLECTUAL_PROPORTION")}
                                               value="${INTELLECTUAL_PROPORTION}">
                                    </div>
                                    <div class="form-group has-feedback">
                                        <label>志愿者:</label>
                                        <input type="text"
                                               class="form-control" ${fns:validField("SYS_ALLOCATION", "VOLUNTEER_PROPORTION")}
                                               value="${VOLUNTEER_PROPORTION}">
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
    //保存
    $('#save').click(function () {
        var $form = $('#addAndEditForm');
        //验证
        if (!validator.formValidate($form)) {
            demo.showNotify(ALERT_WARNING, VALIDATE_FAIL);
            return;
        }
        var params = packFormParams($form);
        //比例判断相加必须等于100
        if (Number(params.EDUCATION_PROPORTION) + Number(params.INTELLECTUAL_PROPORTION) + Number(params.VOLUNTEER_PROPORTION) != 100) {
            demo.showNotify(ALERT_WARNING, "比例总和必须等于100%");
            return;
        }

        ajax.put('${COMPREHENSIVE_BASE_URL}', params, function (data) {
            ajaxReturn.data(data, null, null, null);
        })
    });

    validator.init({
        //验证表单
        form: $('#addAndEditForm'),
    });
</script>