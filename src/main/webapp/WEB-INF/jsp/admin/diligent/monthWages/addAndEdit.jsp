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
    <input type="hidden" name="ID" value="${wages.ID}">
    <input type="hidden" name="BDSS_ID" value="${fns:trueOrFalse(wages != null ,wages.BDSS_ID,BDSS_ID)}">
    <div class="form-group has-feedback">
        <label>学生:</label>
        <input type="text" class="form-control" ${fns:validField(TableName.BUS_DILIGENT_STUDY_MONTH_WAGES, "BS_NAME")}
               value="${wages.BS_NAME}">
    </div>
    <div class="row">
        <div class="form-group has-feedback form-group-md-6">
            <label>工作时长:</label>
            <input type="text"
                   class="form-control" ${fns:validField(TableName.BUS_DILIGENT_STUDY_MONTH_WAGES, "BDSMW_HOUR")}
                   value="${wages.BDSMW_HOUR}">
        </div>
        <div class="form-group has-feedback form-group-md-6">
            <label>工资总额:</label>
            <input type="text"
                   class="form-control" ${fns:validField(TableName.BUS_DILIGENT_STUDY_MONTH_WAGES, "BDSMW_WAGES")}
                   value="${wages.BDSMW_WAGES}">
        </div>
    </div>
    <div class="form-group has-feedback form-group-md-6">
        <label>月份:</label>
        <s:datebox
                type="4"
                custom='${fns:validField(TableName.BUS_DILIGENT_STUDY_MONTH_WAGES, "BDSMW_MONTH")}'
                value="${wages.BDSMW_MONTH}"></s:datebox>
    </div>
</form>

<script>
    validator.init({
        //验证表单
        form: $('#addAndEditForm'),
    });
</script>