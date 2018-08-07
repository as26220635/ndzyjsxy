<%--
  Created by IntelliJ IDEA.
  User: 余庚鑫
  Date: 2017/3/6
  Time: 19:44
  To change this template use File | Settings | File Templates.
--%>
<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<form id="addAndEditForm">
    <div class="form-group has-feedback">
        <label>姓名:</label>
        <input type="text" class="form-control" ${fns:validField("SYS_ACCOUNT_INFO", "SAI_NAME")}
               value="${accountInfo.SAI_NAME}">
    </div>
    <div class="form-group has-feedback">
        <label>手机:</label>
        <input type="text" class="form-control" ${fns:validField("SYS_ACCOUNT_INFO", "SAI_PHONE")}
               value="${accountInfo.SAI_PHONE}">
    </div>
    <div class="form-group has-feedback">
        <label>邮箱:</label>
        <input type="text" class="form-control" ${fns:validField("SYS_ACCOUNT_INFO", "SAI_EMAIL")}
               value="${accountInfo.SAI_EMAIL}">
    </div>
</form>

<script>
    validator.init({
        //验证表单
        form: $('#addAndEditForm'),
    });
</script>