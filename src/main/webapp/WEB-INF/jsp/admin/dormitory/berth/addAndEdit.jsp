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
    <input type="hidden" name="ID" value="${berth.ID}">
    <input type="hidden" name="BDR_ID" value="${fns:trueOrFalse(berth != null ,berth.BDR_ID,BDR_ID)}">
    <div class="form-group has-feedback">
        <label>名称:</label>
        <input type="text" class="form-control" ${fns:validField(TableName.BUS_DORMITORY_BERTH, "BDB_NAME")}
               value="${berth.BDB_NAME}">
    </div>
    <div class="form-group has-feedback">
        <label>备注:</label>
        <textarea ${fns:validField(TableName.BUS_DORMITORY_BERTH,"BDB_REMARKS")}
                class="form-control form-textarea"
                rows="3">${berth.BDB_REMARKS}</textarea>
    </div>
</form>

<script>
    validator.init({
        //验证表单
        form: $('#addAndEditForm'),
    });
</script>