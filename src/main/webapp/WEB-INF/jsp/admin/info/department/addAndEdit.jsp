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
    <input type="hidden" name="ID" value="${department.ID}">
    <div class="form-group has-feedback">
        <label>系部名称:</label>
        <input type="text" class="form-control" ${fns:validField("BUS_DEPARTMENT", "BDM_NAME")}
               value="${department.BDM_NAME}">
    </div>
    <div class="form-group has-feedback">
        <label>所属院系:</label>
        <s:combobox sdtCode="BUS_COLLEGE" custom='${fns:validField("BUS_DEPARTMENT", "BDM_COLLEGE")}'
                    value="${department.BDM_COLLEGE}"></s:combobox>
    </div>
    <div class="form-group has-feedback">
        <label>地址:</label>
        <input type="text" class="form-control" ${fns:validField("BUS_DEPARTMENT", "BDM_ADDRESS")}
               value="${department.BDM_ADDRESS}">
    </div>
    <div class="form-group has-feedback">
        <label>描述:</label>
        <textarea ${fns:validField("BUS_DEPARTMENT","BDM_DESCRIBE")}
                class="form-control form-textarea"
                rows="3">${department.BDM_DESCRIBE}</textarea>
    </div>
    <div class="form-group has-feedback ">
        <label>排序:</label>
        <input type="text" class="form-control" ${fns:validField("BUS_DEPARTMENT", "BDM_ORDER")}
               value="${department.BDM_ORDER}">
    </div>
</form>

<script>
    validator.init({
        //验证表单
        form: $('#addAndEditForm'),
    });
</script>