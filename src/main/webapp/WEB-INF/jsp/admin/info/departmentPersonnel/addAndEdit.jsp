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
    <input type="hidden" name="ID" value="${personnel.ID}">
    <div class="form-group has-feedback">
        <label>人员名称:</label>
        <input type="text" class="form-control" ${fns:validField("BUS_DEPARTMENT_PERSONNEL", "BDMP_NAME")}
               value="${personnel.BDMP_NAME}">
    </div>
    <div class="form-group has-feedback">
        <label>所属系部:</label>
        <s:treeBox custom='${fns:validField("BUS_DEPARTMENT_PERSONNEL","BDM_ID")}'
                   value="${personnel.BDM_ID}" nameValue="${personnel.BDM_NAME}"
                   url="${DEPARTMENT_TREE_DATA_URL}" title="选择所属系部"></s:treeBox>
    </div>
</form>

<script>
    validator.init({
        //验证表单
        form: $('#addAndEditForm'),
    });
</script>