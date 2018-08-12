<%--
  Created by IntelliJ IDEA.
  User: 余庚鑫
  Date: 2018/3/30
  Time: 0:26
  To change this template use File | Settings | File Templates.
--%>
<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<form id="addAndEditForm">
    <input type="hidden" name="${SUBMIT_TOKEN_NAME}" value="${token}">
    <input type="hidden" name="ID" value="${CONFIGURE.ID}">
    <div class="form-group has-feedback">
        <label>配置列表名称:</label>
        <input type="text" class="form-control" ${fns:validField("SYS_CONFIGURE","SC_NAME")}
               value="${CONFIGURE.SC_NAME}">
    </div>
    <div class="form-group has-feedback">
        <label>数据库视图:</label>
        <input type="text" class="form-control" ${fns:validField("SYS_CONFIGURE","SC_VIEW")}
               value="${CONFIGURE.SC_VIEW}">
    </div>
    <div class="form-group has-feedback">
        <label>JSP地址:</label>
        <input type="text" class="form-control" ${fns:validField("SYS_CONFIGURE","SC_JSP")}
               value="${CONFIGURE.SC_JSP}">
    </div>
</form>

<script>
    validator.init({
        //验证表单
        form: $('#addAndEditForm'),
    });
</script>