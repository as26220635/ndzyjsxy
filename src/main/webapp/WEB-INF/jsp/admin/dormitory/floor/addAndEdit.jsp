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
    <input type="hidden" name="ID" value="${floor.ID}">
    <div class="form-group has-feedback">
        <label>名称:</label>
        <input type="text" class="form-control" ${fns:validField(TableName.BUS_DORMITORY_FLOOR, "BDF_NAME")}
               value="${floor.BDF_NAME}">
    </div>
    <div class="form-group has-feedback">
        <label>地址:</label>
        <input type="text" class="form-control" ${fns:validField(TableName.BUS_DORMITORY_FLOOR, "BDF_ADDRESS")}
               value="${floor.BDF_ADDRESS}">
    </div>
    <div class="form-group has-feedback">
        <label>备注:</label>
        <textarea ${fns:validField(TableName.BUS_DORMITORY_FLOOR,"BDF_REMARKS")}
                class="form-control form-textarea"
                rows="3">${floor.BDF_REMARKS}</textarea>
    </div>
</form>

<script>
    validator.init({
        //验证表单
        form: $('#addAndEditForm'),
    });
</script>