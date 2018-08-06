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
    <input type="hidden" name="ID" value="${cls.ID}">
    <div class="form-group has-feedback">
        <label>系部名称:</label>
        <input type="text" class="form-control" ${fns:validField("BUS_CLASS", "BC_NAME")}
               value="${cls.BDM_NAME}">
    </div>
    <div class="form-group has-feedback">
        <label>所属院系:</label>
        <s:combobox sdtCode="BUS_COLLEGE" custom='${fns:validField("BUS_CLASS", "BDM_COLLEGE")}'
                    value="${cls.BDM_COLLEGE}"></s:combobox>
    </div>
</form>

<script>
    validator.init({
        //验证表单
        form: $('#addAndEditForm'),
    });
</script>