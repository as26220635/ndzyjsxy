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
    <input type="hidden" name="ID" value="${document.ID}">
    <div class="form-group has-feedback">
        <label>回复内容:</label>
        <textarea ${fns:validField(TableName.BUS_DOCUMENT,"BD_REPLY_CONTENT")}
                class="form-control form-textarea"
                rows="5">${document.BD_REPLY_CONTENT}</textarea>
    </div>
</form>

<script>
    validator.init({
        //验证表单
        form: $('#addAndEditForm'),
    });
</script>