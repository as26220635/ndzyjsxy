<%--
  Created by IntelliJ IDEA.
  User: 余庚鑫
  Date: 2018/3/27
  Time: 15:40
  To change this template use File | Settings | File Templates.
--%>
<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<form id="addAndEditForm" class="row">
    <input type="hidden" name="${SUBMIT_TOKEN_NAME}" value="${token}">
    <input type="hidden" name="ID" value="${aid.ID}">
    <div class="form-group has-feedback">
        <label>学生:</label>
        <input type="hidden" ${fns:validField(TableName.BUS_AID_FINANCIALLY, "BS_ID")} value="${aid.BS_ID}">
        <input type="text" class="form-control" ${fns:validField(TableName.BUS_AID_FINANCIALLY, "BS_NAME")}
               value="${aid.BS_NAME}">
    </div>
    <div class="row">
        <div class="form-group has-feedback form-group-md-6">
            <label>学年:</label>
            <s:datebox
                    custom='${fns:validField(TableName.BUS_AID_FINANCIALLY, "BAF_YEAR")}'
                    value="${aid.BAF_YEAR}"></s:datebox>
        </div>
        <div class="form-group has-feedback form-group-md-6">
            <label>学期:</label>
            <s:combobox sdtCode="BUS_SEMESTER"
                        custom='${fns:validField(TableName.BUS_AID_FINANCIALLY,"BAF_SEMESTER")}'
                        value="${aid.BAF_SEMESTER}"></s:combobox>
        </div>
    </div>
    <div class="row">
        <div class="form-group has-feedback form-group-md-6">
            <label>资助标准:</label>
            <input type="text"
                   class="form-control" ${fns:validField(TableName.BUS_AID_NATIONAL_GRANTS, "BANG_FUNDING_STANDARDS")}
                   value="${ng.BANG_FUNDING_STANDARDS}">
        </div>
        <div class="form-group has-feedback form-group-md-6">
            <label>应发金额:</label>
            <input type="text"
                   class="form-control" ${fns:validField(TableName.BUS_AID_NATIONAL_GRANTS, "BANG_AMOUNT_PAYABLE")}
                   value="${ng.BANG_AMOUNT_PAYABLE}">
        </div>
    </div>
    <div class="row">
        <div class="form-group has-feedback form-group-md-6">
            <label>实发金额:</label>
            <input type="text"
                   class="form-control" ${fns:validField(TableName.BUS_AID_NATIONAL_GRANTS, "BANG_ACTUAL_AMOUNT")}
                   value="${ng.BANG_ACTUAL_AMOUNT}">
        </div>
        <div class="form-group has-feedback form-group-md-6">
            <label>发放日期:</label>
            <s:datebox
                    type="33"
                    custom='${fns:validField(TableName.BUS_AID_NATIONAL_GRANTS, "BANS_ISSUANCE_TIME")}'
                    value="${ng.BANS_ISSUANCE_TIME}"></s:datebox>
        </div>
    </div>
    <div class="form-group has-feedback">
        <label>申请理由:</label>
        <input type="text"
               class="form-control" ${fns:validField(TableName.BUS_AID_NATIONAL_GRANTS, "BANG_APPLY_REASONS")}
               value="${ng.BANG_APPLY_REASONS}">
    </div>
</form>

<script>
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
</script>