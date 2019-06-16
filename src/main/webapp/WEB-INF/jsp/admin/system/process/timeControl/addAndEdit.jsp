<%--
  Created by IntelliJ IDEA.
  User: 余庚鑫
  Date: 2018/3/27
  Time: 15:40
  To change this template use File | Settings | File Templates.
--%>
<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<form id="addAndEditForm">
    <input type="hidden" name="${SUBMIT_TOKEN_NAME}" value="${token}">
    <input type="hidden" name="ID" value="${SPTC.ID}">
    <input type="hidden" name="SPD_ID" value="${fns:trueOrFalse(SPTC != null ,SPTC.SPD_ID,SPD_ID)}">
    <div class="form-group has-feedback">
        <label>开始时间:</label>
        <s:datebox type="6" custom='${fns:validField(TableName.SYS_PROCESS_TIME_CONTROL, "SPTC_START_TIME")}'
                   value="${SPTC.SPTC_START_TIME}"></s:datebox>
    </div>
    <div class="form-group has-feedback">
        <label>结束时间:</label>
        <s:datebox type="6" custom='${fns:validField(TableName.SYS_PROCESS_TIME_CONTROL, "SPTC_END_TIME")}'
                   value="${SPTC.SPTC_END_TIME}"></s:datebox>
    </div>
</form>

<script>
    validator.init({
        //验证表单
        form: $('#addAndEditForm'),
    });
</script>